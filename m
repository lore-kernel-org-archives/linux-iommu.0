Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6C08F40
	for <iommu@lists.linux.dev>; Sun, 29 Oct 2023 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="SAJiupU5";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="RfercLSu"
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id DD1AE60182;
	Sun, 29 Oct 2023 12:13:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1698578013; bh=NtW5AA3iztqWChPJltkY4/MG+Vbb89cp9gCAty5mC2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SAJiupU5Lqr+a+cpvtLP1Ehji5uY8ahX5H0FXi86cRA8Z1urPmKYJbzGEuB/r9lAe
	 Zq746u6NYHBfc2UlfY0QF73zJQncLb6Z8LZYJqpFj9ofD9sCJtTyI8MKrMamlbuKia
	 SDEJFMk2moW9ksTsC2OQYRryloS5DZkqAYuM4UEcPCBE5/P3pZFRBiBrrZ7aD7g7bM
	 yoSs5aS3f8eV/E4EPAAt0PjIjyNuAtOnG4S5big1qUHCgAmtrgUpiO2SkYz2Psz3AH
	 pl5sEEfmIOvds17Q8LSE9UndM7leaKmcYDnmjLBZLqRniiGyUqO40tk3CMcVeNrmO6
	 VEOUnpa537J1Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MUAMGmq2omC4; Sun, 29 Oct 2023 12:13:31 +0100 (CET)
Received: from defiant.home (78-3-40-247.adsl.net.t-com.hr [78.3.40.247])
	by domac.alu.hr (Postfix) with ESMTPSA id 3799A60173;
	Sun, 29 Oct 2023 12:13:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1698578011; bh=NtW5AA3iztqWChPJltkY4/MG+Vbb89cp9gCAty5mC2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RfercLSu6F5ap+xDowIYoRw/jAzK6gD2ex1MxlxO/NKq6NYR+lj8XgELdp/SPEUzT
	 V7Fdchlm6Ee3xKpUqwh74InU6qzjdRdWIGMUIuUCTXGMy9suAf2u3BYOuSUyOft0PG
	 u/q+tubop6TOZv7qROvXDrAHH5rBenUKvIjg7TzAzGTCSy7CN/2/3+WWsTPK+cQ/te
	 39XKmlDmAC6koOLY4HZMQy93O46x/4xySgs+0EOAvXwTCW0kmMizOtPDGdjDGWHCSy
	 iy0PCXKZ1bLlKad5Nv7cJcu1Y5WJaVTpg3QbxnodUht9ScvoBwlmLzjQTodhN/CaKE
	 qys2jFnHWuFJg==
From: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <jroedel@suse.de>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Marco Elver <elver@google.com>
Subject: [PATCH v4 4/5] r8169: Coalesce mac ocp commands for 8125 and 8125B start to reduce spinlock contention
Date: Sun, 29 Oct 2023 12:04:45 +0100
Message-Id: <20231029110442.347448-4-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029110442.347448-1-mirsad.todorovac@alu.unizg.hr>
References: <20231029110442.347448-1-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Repeated calls to r8168_mac_ocp_write() and r8168_mac_ocp_modify() in
the startup of 8125 and 8125B involve implicit spin_lock_irqsave() and
spin_unlock_irqrestore() on each invocation.

Coalesced with the corresponding helpers r8168_mac_ocp_write_seq() and
r8168_mac_ocp_modify_seq() into sequential write or modidy with a sinqle lock/unlock,
these calls reduce overall lock contention.

Fixes: f1bce4ad2f1ce ("r8169: add support for RTL8125")
Fixes: 0439297be9511 ("r8169: add support for RTL8125B")
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Marco Elver <elver@google.com>
Cc: nic_swsd@realtek.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/lkml/20231028005153.2180411-1-mirsad.todorovac@alu.unizg.hr/
Link: https://lore.kernel.org/lkml/20231028110459.2644926-1-mirsad.todorovac@alu.unizg.hr/
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
v4:
 fixed complaints as advised by Heiner and checkpatch.pl.
 split the patch into five sections to be more easily manipulated and reviewed
 introduced r8168_mac_ocp_write_seq()
 applied coalescing of mac ocp writes/modifies for 8168H, 8125 and 8125B

v3:
 removed register/mask pair array sentinels, so using ARRAY_SIZE().
 avoided duplication of RTL_W32() call code as advised by Heiner.

 drivers/net/ethernet/realtek/r8169_main.c | 38 ++++++++++++++---------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index cbaac4675bd2..dd65e0384ab3 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3539,6 +3539,27 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
 
 static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 {
+
+	static const struct e_info_regmaskset e_info_8125_common_1[] = {
+		{ 0xd3e2, 0x0fff, 0x03a9 },
+		{ 0xd3e4, 0x00ff, 0x0000 },
+		{ 0xe860, 0x0000, 0x0080 },
+	};
+
+	static const struct e_info_regmaskset e_info_8125_common_2[] = {
+		{ 0xc0b4, 0x0000, 0x000c },
+		{ 0xeb6a, 0x00ff, 0x0033 },
+		{ 0xeb50, 0x03e0, 0x0040 },
+		{ 0xe056, 0x00f0, 0x0030 },
+		{ 0xe040, 0x1000, 0x0000 },
+		{ 0xea1c, 0x0003, 0x0001 },
+		{ 0xe0c0, 0x4f0f, 0x4403 },
+		{ 0xe052, 0x0080, 0x0068 },
+		{ 0xd430, 0x0fff, 0x047f },
+		{ 0xea1c, 0x0004, 0x0000 },
+		{ 0xeb54, 0x0000, 0x0001 },
+	};
+
 	rtl_pcie_state_l2l3_disable(tp);
 
 	RTL_W16(tp, 0x382, 0x221b);
@@ -3553,9 +3574,7 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	r8168_mac_ocp_write(tp, 0xc140, 0xffff);
 	r8168_mac_ocp_write(tp, 0xc142, 0xffff);
 
-	r8168_mac_ocp_modify(tp, 0xd3e2, 0x0fff, 0x03a9);
-	r8168_mac_ocp_modify(tp, 0xd3e4, 0x00ff, 0x0000);
-	r8168_mac_ocp_modify(tp, 0xe860, 0x0000, 0x0080);
+	r8168_mac_ocp_modify_seq(tp, e_info_8125_common_1);
 
 	/* disable new tx descriptor format */
 	r8168_mac_ocp_modify(tp, 0xeb58, 0x0001, 0x0000);
@@ -3570,18 +3589,7 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	else
 		r8168_mac_ocp_modify(tp, 0xe63e, 0x0c30, 0x0020);
 
-	r8168_mac_ocp_modify(tp, 0xc0b4, 0x0000, 0x000c);
-	r8168_mac_ocp_modify(tp, 0xeb6a, 0x00ff, 0x0033);
-	r8168_mac_ocp_modify(tp, 0xeb50, 0x03e0, 0x0040);
-	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0030);
-	r8168_mac_ocp_modify(tp, 0xe040, 0x1000, 0x0000);
-	r8168_mac_ocp_modify(tp, 0xea1c, 0x0003, 0x0001);
-	r8168_mac_ocp_modify(tp, 0xe0c0, 0x4f0f, 0x4403);
-	r8168_mac_ocp_modify(tp, 0xe052, 0x0080, 0x0068);
-	r8168_mac_ocp_modify(tp, 0xd430, 0x0fff, 0x047f);
-
-	r8168_mac_ocp_modify(tp, 0xea1c, 0x0004, 0x0000);
-	r8168_mac_ocp_modify(tp, 0xeb54, 0x0000, 0x0001);
+	r8168_mac_ocp_modify_seq(tp, e_info_8125_common_2);
 	udelay(1);
 	r8168_mac_ocp_modify(tp, 0xeb54, 0x0001, 0x0000);
 	RTL_W16(tp, 0x1880, RTL_R16(tp, 0x1880) & ~0x0030);
-- 
2.34.1

