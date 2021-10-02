Return-Path: <SRS0=MlyH=OW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABB1C433F5
	for <iommu@archiver.kernel.org>; Sat,  2 Oct 2021 12:40:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B80161A50
	for <iommu@archiver.kernel.org>; Sat,  2 Oct 2021 12:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B80161A50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2762F425F7;
	Sat,  2 Oct 2021 12:40:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id THgjy79YtUmU; Sat,  2 Oct 2021 12:40:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0F087425EF;
	Sat,  2 Oct 2021 12:40:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9C8CC000F;
	Sat,  2 Oct 2021 12:40:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 692D5C000D
 for <iommu@lists.linux-foundation.org>; Sat,  2 Oct 2021 12:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51AE9425F3
 for <iommu@lists.linux-foundation.org>; Sat,  2 Oct 2021 12:40:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id abp5gnmN3qi7 for <iommu@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 12:40:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C14A8425EF
 for <iommu@lists.linux-foundation.org>; Sat,  2 Oct 2021 12:40:48 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id j4so6588225plx.4
 for <iommu@lists.linux-foundation.org>; Sat, 02 Oct 2021 05:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=boC5DH+e5eDznk4gCfSQd5KzFhA9YXPE0HN8TOlXHRM=;
 b=DrDz4tlLiEuf9X/s3JrTFdv/dbjHHnVXgOJq08OXY9rxryZjAOa0aPLnCA4wrU6kjj
 SGu850FsqNzOzqE8FWNCFQlXlYALzgd9KgSmoAh1dsEfR4zx/5K1bQffnwtwVCxVhy2Z
 16zYnq0qg4NaZGENFiv1m2GJvWw8EgfShf3c2pfRnructRQoWqdlzgLVKuXgL/OhI0Vg
 PFCijxWyRHg0Zbf9Heh5gy5kL8/CodI08EpJfJuugeeukMFy8lMj9/Z46i2xTrxyi4rM
 pEgl1MiIP41gZSoqVz+sD9d5E7b/oFCLvdJyYKEVyX/rZmw9CFA7wdwZ5Zkez11LZ9Nd
 Rdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=boC5DH+e5eDznk4gCfSQd5KzFhA9YXPE0HN8TOlXHRM=;
 b=FDB7b3j2WHij1rviitGJ3y8TGNuaIORZBY/e5PmJjD/R2StfMya/ZsdPlCAgAWx0oT
 V6m3CN73z8EitCW60iEZHpAnOb34MVQRYptBMx1ePINmar8onLDmQ3TTMqK46ezk+SxT
 cFpQ0bMEAzcCFXiNZi+RswhmL814Gj4m1sRllZwE3Tvb6dqU261r9xFTdveFZ84TsJvI
 9tzJVBQo+HKMuAH/wIvSR3bH1Yh/x7/Fn6Z0lPYMvgU+rY0N/kx4tshzfpdRvI1dZXfy
 QEGQoR1RXSWtTxMUdEkV/AcSIjKftGLuM23JQRnhdNIpayMEV7rsmH8YjvsyXcuSwWrf
 RQig==
X-Gm-Message-State: AOAM533z2hKJCFTFpVjvHSwqKk/peb06M7A0gw8UOByBhT43lFwl2evU
 rhyR6giButdxTNXM63jR+HFXvNAThfI=
X-Google-Smtp-Source: ABdhPJzDtA/vEzbxkSvzWKRyYY4VFSJIYY3QysxOrL0OPQ4NHudtiWZQ9dn0Lac2J0jbvWPA8DEMJQ==
X-Received: by 2002:a17:902:b909:b0:13a:2d8e:12bc with SMTP id
 bf9-20020a170902b90900b0013a2d8e12bcmr14245355plb.6.1633178448124; 
 Sat, 02 Oct 2021 05:40:48 -0700 (PDT)
Received: from ajay-Latitude-E6320.. ([122.161.244.167])
 by smtp.gmail.com with ESMTPSA id c9sm8760694pgq.58.2021.10.02.05.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Oct 2021 05:40:47 -0700 (PDT)
From: Ajay Garg <ajaygargnsit@gmail.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 kvm@vger.kernel.org
Subject: [PATCH] iommu: intel: remove flooding of non-error logs,
 when new-DMA-PTE is the same as old-DMA-PTE.
Date: Sat,  2 Oct 2021 18:10:12 +0530
Message-Id: <20211002124012.18186-1-ajaygargnsit@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
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

Taking a SD-MMC controller (over PCI) as an example, following is an
example sequencing, where the log-flooding happened :

0.
We have a host and a guest, both running latest x86_64 kernels.

1.
Host-machine is booted up (with intel_iommu=on), and the DMA-PTEs
are setup for the controller (on the host), for the first time.

2.
The SD-controller device is added to a (L1) guest on a KVM-VM
(via virt-manager).

3.
The KVM-VM is booted up.

4.
Above triggers a re-setup of DMA-PTEs on the host, for a
second time.

It is observed that the new PTEs formed (on the host) are same
as the original PTEs, and thus following logs, accompanied by
stacktraces, overwhelm the logs :

......
 DMAR: ERROR: DMA PTE for vPFN 0x428ec already set (to 3f6ec003 not 3f6ec003)
 DMAR: ERROR: DMA PTE for vPFN 0x428ed already set (to 3f6ed003 not 3f6ed003)
 DMAR: ERROR: DMA PTE for vPFN 0x428ee already set (to 3f6ee003 not 3f6ee003)
 DMAR: ERROR: DMA PTE for vPFN 0x428ef already set (to 3f6ef003 not 3f6ef003)
 DMAR: ERROR: DMA PTE for vPFN 0x428f0 already set (to 3f6f0003 not 3f6f0003)
......

As the PTEs are same, so there is no cause of concern, and we can easily
avoid the logs-flood for this non-error case.

Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d75f59ae28e6..8bea8b4e3ff9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2370,7 +2370,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		 * touches the iova range
 		 */
 		tmp = cmpxchg64_local(&pte->val, 0ULL, pteval);
-		if (tmp) {
+		if (tmp && (tmp != pteval)) {
 			static int dumps = 5;
 			pr_crit("ERROR: DMA PTE for vPFN 0x%lx already set (to %llx not %llx)\n",
 				iov_pfn, tmp, (unsigned long long)pteval);
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
