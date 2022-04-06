Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F5EC433F5
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 14:03:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C90C783337;
	Wed,  6 Apr 2022 14:03:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RR_j_sLvkPd6; Wed,  6 Apr 2022 14:03:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8FACD831F8;
	Wed,  6 Apr 2022 14:03:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E743C001D;
	Wed,  6 Apr 2022 14:03:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D19D7C0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 08:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B07F44019F
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 08:42:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QrR6Aoo4AVvg for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 08:42:45 +0000 (UTC)
X-Greylist: delayed 00:05:37 by SQLgrey-1.8.0
Received: from mail.codelabs.ch (mail.codelabs.ch [109.202.192.35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE27040025
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 08:42:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.codelabs.ch (Postfix) with ESMTP id E956B220003;
 Wed,  6 Apr 2022 10:37:05 +0200 (CEST)
Received: from mail.codelabs.ch ([127.0.0.1])
 by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id USzK58Cg8Xho; Wed,  6 Apr 2022 10:37:04 +0200 (CEST)
Received: from skyhawk.codelabs.local (unknown
 [IPv6:2a02:169:803:0:f7fb:8040:b3e4:bffe])
 by mail.codelabs.ch (Postfix) with ESMTPSA id ACB1A220001;
 Wed,  6 Apr 2022 10:37:04 +0200 (CEST)
From: Reto Buerki <reet@codelabs.ch>
To: dwmw2@infradead.org
Subject: [PATCH] x86/msi: Fix msi message data shadow struct
Date: Wed,  6 Apr 2022 10:36:24 +0200
Message-Id: <20220406083624.38739-2-reet@codelabs.ch>
In-Reply-To: <20220406083624.38739-1-reet@codelabs.ch>
References: <20201024213535.443185-13-dwmw2@infradead.org>
 <20220406083624.38739-1-reet@codelabs.ch>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 06 Apr 2022 14:03:25 +0000
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
 decui@microsoft.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, maz@misterjones.org, pbonzini@redhat.com,
 tglx@linutronix.de
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The x86 MSI message data is 32 bits in total and is either in
compatibility or remappable format, see Intel Virtualization Technology
for Directed I/O, section 5.1.2.

Fixes: 6285aa50736 ("x86/msi: Provide msi message shadow structs")
Signed-off-by: Reto Buerki <reet@codelabs.ch>
Signed-off-by: Adrian-Ken Rueegsegger <ken@codelabs.ch>
---
 arch/x86/include/asm/msi.h | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/msi.h b/arch/x86/include/asm/msi.h
index b85147d75626..d71c7e8b738d 100644
--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -12,14 +12,17 @@ int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 /* Structs and defines for the X86 specific MSI message format */
 
 typedef struct x86_msi_data {
-	u32	vector			:  8,
-		delivery_mode		:  3,
-		dest_mode_logical	:  1,
-		reserved		:  2,
-		active_low		:  1,
-		is_level		:  1;
-
-	u32	dmar_subhandle;
+	union {
+		struct {
+			u32	vector			:  8,
+				delivery_mode		:  3,
+				dest_mode_logical	:  1,
+				reserved		:  2,
+				active_low		:  1,
+				is_level		:  1;
+		};
+		u32	dmar_subhandle;
+	};
 } __attribute__ ((packed)) arch_msi_msg_data_t;
 #define arch_msi_msg_data	x86_msi_data
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
