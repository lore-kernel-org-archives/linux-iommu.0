Return-Path: <SRS0=lDAf=5C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A57C18E5B
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 15:27:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B6020714
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 15:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="l254W5RQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B6020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7EC8F23235;
	Tue, 17 Mar 2020 15:27:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cFXHwDgadXqb; Tue, 17 Mar 2020 15:27:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 590C52314A;
	Tue, 17 Mar 2020 15:27:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E944C18DA;
	Tue, 17 Mar 2020 15:27:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82A2FC013E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 15:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 71E2E866A9
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 15:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z8vUKmUZqzmh for <iommu@lists.linux-foundation.org>;
 Tue, 17 Mar 2020 15:27:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 16B308651A
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 15:27:51 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id t13so17701875qtn.13
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 08:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HqOBm7bQCludye1SGv0KdSFELKwpbPDMXnv2Sugq1V4=;
 b=l254W5RQNfFLpxh3XTCQBj64u0gip2PXizITExpY6lAOsWn1MUvIebu1an3ADb11ac
 liTXMm06RwsmMDI7Qxiw9AwtmT5Pq9dzz7YOo1yY/xONZZxMl1/9GUt/YT/Do+pTSGdB
 LbzJPXVYWH5ymK7O98yRz+R6EsdJ99oOZtKTikglOEznI557wq65BJDifgceaq5MjBtM
 MD2ztt6vDgt+RFxsqrUaKeQAXdaibVSfiqFDy2rYCj+/W/jcbmIRuSoa7Bwg0O0V5Q0Q
 gUkz99+eQIieLq631DL+LXAbdAOqEbiyoIYUQDsB+lgYPHYbAecWPCKStQ6zNYLvYJeX
 UiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HqOBm7bQCludye1SGv0KdSFELKwpbPDMXnv2Sugq1V4=;
 b=ata1MABPXQNo7bTZQcqx25qDNGozMJtVHWPfodfiJixy41djZBIIH0q1+ckyAvEUmP
 gTpoyBwYSr0wJVlMjxnHXPRJTbyL3PSD+Py/kfCX8edRhWtgcjyrks9ppDoDDQ9ows/w
 V7F7oQEHJh2Er9wi7kA4VNc/ixqH2G9HCej9uNpHCAiAyGVQ+swZFezWJg3KBuFU8Vz9
 er8rBkeHYrVzgqEd7/iy3eSSSVRhD9N8f98UrIw8ZySExa3UP2EldiurNLdJUoJxHAAL
 X+tnSFSWHN7ugOg7bibwSCppwe4In0pbvmz7vKcfI0urbVGD9ZZRH7B7QoPha/0c7eL5
 Csrg==
X-Gm-Message-State: ANhLgQ1cVjki0e9xxjBGtVYY2NbN+6KOlKjOIDk+IvIb4z31AqfAJ4vz
 pwhetLps9QHW68RXK1KwoA0CCLDXBt89JQ==
X-Google-Smtp-Source: ADFU+vt5wqdAcnNu9Z6Fsgi+m9R2A9sC6GlSijeQ7cGL3zxioALaVGP0oa2V6N9J1JQpQHnNsM1vEQ==
X-Received: by 2002:a37:5b82:: with SMTP id p124mr5447016qkb.130.1584457415620; 
 Tue, 17 Mar 2020 08:03:35 -0700 (PDT)
Received: from ovpn-66-200.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id n74sm2037090qke.125.2020.03.17.08.03.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Mar 2020 08:03:34 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de
Subject: [PATCH] iommu/vt-d: silence a RCU-list debugging warning
Date: Tue, 17 Mar 2020 11:03:26 -0400
Message-Id: <20200317150326.1659-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

dmar_find_atsr() calls list_for_each_entry_rcu() outside of an RCU read
side critical section but with dmar_global_lock held. Silence this
false positive.

 drivers/iommu/intel-iommu.c:4504 RCU-list traversed in non-reader section!!
 1 lock held by swapper/0/1:
 #0: ffffffff9755bee8 (dmar_global_lock){+.+.}, at: intel_iommu_init+0x1a6/0xe19

 Call Trace:
  dump_stack+0xa4/0xfe
  lockdep_rcu_suspicious+0xeb/0xf5
  dmar_find_atsr+0x1ab/0x1c0
  dmar_parse_one_atsr+0x64/0x220
  dmar_walk_remapping_entries+0x130/0x380
  dmar_table_init+0x166/0x243
  intel_iommu_init+0x1ab/0xe19
  pci_iommu_init+0x1a/0x44
  do_one_initcall+0xae/0x4d0
  kernel_init_freeable+0x412/0x4c5
  kernel_init+0x19/0x193

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4be549478691..ef0a5246700e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4501,7 +4501,8 @@ static struct dmar_atsr_unit *dmar_find_atsr(struct acpi_dmar_atsr *atsr)
 	struct dmar_atsr_unit *atsru;
 	struct acpi_dmar_atsr *tmp;
 
-	list_for_each_entry_rcu(atsru, &dmar_atsr_units, list) {
+	list_for_each_entry_rcu(atsru, &dmar_atsr_units, list,
+				dmar_rcu_check()) {
 		tmp = (struct acpi_dmar_atsr *)atsru->hdr;
 		if (atsr->segment != tmp->segment)
 			continue;
-- 
2.21.0 (Apple Git-122.2)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
