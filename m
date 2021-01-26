Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDADC433DB
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 20:43:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9600206D4
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 20:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9600206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 50B8A20481;
	Tue, 26 Jan 2021 20:43:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id udRNsPuCW1n7; Tue, 26 Jan 2021 20:43:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 25E9720467;
	Tue, 26 Jan 2021 20:43:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 076BDC0FA7;
	Tue, 26 Jan 2021 20:43:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7468C013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 20:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9E6E786519
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 20:43:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jLJxNKu-NfmM for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 20:43:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D69B38650E
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 20:43:25 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id u4so2962630pjn.4
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 12:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XA+jyv1loiGPphrOL8kn5H8su7PXADpnQ1gR33eeAE4=;
 b=PP38fahaKMJC62EY7XKecdBtPSaTl4VhZR05btl5dnOp7IdtmNqJYWmkAhL8DzS6Kj
 wNuNRosuSulIeXoWHgl4qFS5cvRnrSy2zHxZjbKpDvWqSakX7mZoVVaGSva5+1pZ+za9
 g5zGlasJdNCqAfmZGTXAzc4rLglraGQzOFRGK3aIKc5EFhsk2ABAzDZpU39JHQFPm2wi
 SmY7preEDlxU25nnXV7L9FGA4mQBFCtOamNsARduywSQ/sN6HKcy5BcopP7xZPdL5iUz
 lByVPaErGJmC/kDGLnesjhkIjQ3IaqNvqlv9I2sqJ1je5Uuu+w0s+ORZRF+kBsMfb3m8
 vtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XA+jyv1loiGPphrOL8kn5H8su7PXADpnQ1gR33eeAE4=;
 b=aVLWVY3DG0L9YZSQ/ZCOZc09YQYmhlw+kTE2CCww3KOooObWgdrPL5/ynGE1h6VBZl
 27IATT2fTCF6BGFO16ytvNm2FfESGwm437nLKWmli+PgJXeOFQ1Sefe0UeipBiILwdz9
 n1s/gQKX30G1mnDuICgmygFgsU8OeHLvu3IzgS76SzO2wNhElOLV5rmmAMlCduFVh6ey
 L2xn4iL+zyJjigJYA90YTXtkdtd8vO5vhXKJg3B92/fjDVtkMbtgB/Qqz4ywhiHu3n3+
 ZOwvwPE68eEhzsVrRbnr/O5Ne0ytAztCGLQaGHqEUmi2icaxWUuVvwu94vyh0MDbsX71
 nDUw==
X-Gm-Message-State: AOAM530QFiUFwWfYaV11Hnwjavr3yD7cGHSjdOaFGVoTzb+nCjNIqDUM
 1lchqSv94L4qAJ8V43xbt50rPIrZ05gJVA==
X-Google-Smtp-Source: ABdhPJwwmT30kogCuc3lhP7aqEqdxyYVgkl88E1BimVSr1avbycjpHPuhpnAYWxZo8EeOpApKsljAQ==
X-Received: by 2002:a17:90a:d58c:: with SMTP id
 v12mr1684421pju.37.1611693804887; 
 Tue, 26 Jan 2021 12:43:24 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id hs21sm2990530pjb.6.2021.01.26.12.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jan 2021 12:43:24 -0800 (PST)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/vt-d: do not use flush-queue when caching-mode is on
Date: Tue, 26 Jan 2021 12:38:56 -0800
Message-Id: <20210126203856.1544088-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Nadav Amit <namit@vmware.com>,
 David Woodhouse <dwmw2@infradead.org>
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

From: Nadav Amit <namit@vmware.com>

When an Intel IOMMU is virtualized, and a physical device is
passed-through to the VM, changes of the virtual IOMMU need to be
propagated to the physical IOMMU. The hypervisor therefore needs to
monitor PTE mappings in the IOMMU page-tables. Intel specifications
provide "caching-mode" capability that a virtual IOMMU uses to report
that the IOMMU is virtualized and a TLB flush is needed after mapping to
allow the hypervisor to propagate virtual IOMMU mappings to the physical
IOMMU. To the best of my knowledge no real physical IOMMU reports
"caching-mode" as turned on.

Synchronizing the virtual and the physical TLBs is expensive if the
hypervisor is unaware which PTEs have changed, as the hypervisor is
required to walk all the virtualized tables and look for changes.
Consequently, domain flushes are much more expensive than page-specific
flushes on virtualized IOMMUs with passthrough devices. The kernel
therefore exploited the "caching-mode" indication to avoid domain
flushing and use page-specific flushing in virtualized environments. See
commit 78d5f0f500e6 ("intel-iommu: Avoid global flushes with caching
mode.")

This behavior changed after commit 13cf01744608 ("iommu/vt-d: Make use
of iova deferred flushing"). Now, when batched TLB flushing is used (the
default), full TLB domain flushes are performed frequently, requiring
the hypervisor to perform expensive synchronization between the virtual
TLB and the physical one.

Getting batched TLB flushes to use in such circumstances page-specific
invalidations again is not easy, since the TLB invalidation scheme
assumes that "full" domain TLB flushes are performed for scalability.

Disable batched TLB flushes when caching-mode is on, as the performance
benefit from using batched TLB invalidations is likely to be much
smaller than the overhead of the virtual-to-physical IOMMU page-tables
synchronization.

Fixes: 78d5f0f500e6 ("intel-iommu: Avoid global flushes with caching mode.")
Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/iommu/intel/iommu.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 788119c5b021..4e08f5e17175 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5373,6 +5373,30 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
 	return ret;
 }
 
+static int
+intel_iommu_domain_get_attr_use_flush_queue(struct iommu_domain *domain)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = domain_get_iommu(dmar_domain);
+
+	if (intel_iommu_strict)
+		return 0;
+
+	/*
+	 * The flush queue implementation does not perform page-selective
+	 * invalidations that are required for efficient TLB flushes in virtual
+	 * environments. The benefit of batching is likely to be much lower than
+	 * the overhead of synchronizing the virtual and physical IOMMU
+	 * page-tables.
+	 */
+	if (iommu && cap_caching_mode(iommu->cap)) {
+		pr_warn_once("IOMMU batching is partially disabled due to virtualization");
+		return 0;
+	}
+
+	return 1;
+}
+
 static int
 intel_iommu_domain_get_attr(struct iommu_domain *domain,
 			    enum iommu_attr attr, void *data)
@@ -5383,7 +5407,7 @@ intel_iommu_domain_get_attr(struct iommu_domain *domain,
 	case IOMMU_DOMAIN_DMA:
 		switch (attr) {
 		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
-			*(int *)data = !intel_iommu_strict;
+			*(int *)data = !intel_iommu_domain_get_attr_use_flush_queue(domain);
 			return 0;
 		default:
 			return -ENODEV;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
