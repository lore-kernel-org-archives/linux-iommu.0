Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8486C433F5
	for <iommu@archiver.kernel.org>; Thu,  6 Jan 2022 02:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 654EA40017;
	Thu,  6 Jan 2022 02:22:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q2pC9U7LXohm; Thu,  6 Jan 2022 02:22:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1AD5C40441;
	Thu,  6 Jan 2022 02:22:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E74A4C002F;
	Thu,  6 Jan 2022 02:22:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6532CC001E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:22:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4159C40424
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:22:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wB4Y4kXQwKFf for <iommu@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 02:22:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4CAE840017
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641435769; x=1672971769;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rJCHc+7rEGzzzZ26n+LFYyMzqMy4eMF/FP0CIBhFlrQ=;
 b=QNIX4kw0AjpNz8YvzqvCjXMpPJaaKQXq3ZyKpztEhr3ILg9bHDZFuBXa
 eP+DJwko95AXKuY+Ri8xt9UQIpoxD/2RGXnx1FP3qLnMJaF8WdyLrxmKv
 rdqAiLv/+z/slo/ASR8sIHE1IQdyhfwydXxP1PpZymFqmpEkHDFb7ei4j
 X7iM0nOv+jZcOKU6OG/XuSUJD++QCQyEOuPoK0AuPsJU/HWTg9jVXtO0p
 pPC8TXhjtAn5IEliiCLAJeMoqToEI/7H6XWSv1rsVURh6Oq8DGeH8367f
 KWwH21q8E+5jU2Xe2KDxxpU4g3PfaqWSLzRbpDc3sNQoJ/4REJQAFqvH+ Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="223259106"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="223259106"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2022 18:22:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="526794519"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 18:22:31 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v1 7/8] media: staging: media: tegra-vde: Use
 iommu_attach/detach_device()
Date: Thu,  6 Jan 2022 10:20:52 +0800
Message-Id: <20220106022053.2406748-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
References: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

Ordinary drivers should use iommu_attach/detach_device() for domain
attaching and detaching.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/staging/media/tegra-vde/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/tegra-vde/iommu.c b/drivers/staging/media/tegra-vde/iommu.c
index adf8dc7ee25c..a6e6eb28f1e3 100644
--- a/drivers/staging/media/tegra-vde/iommu.c
+++ b/drivers/staging/media/tegra-vde/iommu.c
@@ -91,7 +91,7 @@ int tegra_vde_iommu_init(struct tegra_vde *vde)
 	order = __ffs(vde->domain->pgsize_bitmap);
 	init_iova_domain(&vde->iova, 1UL << order, 0);
 
-	err = iommu_attach_group(vde->domain, vde->group);
+	err = iommu_attach_device(vde->domain, dev);
 	if (err)
 		goto put_iova;
 
@@ -129,7 +129,7 @@ int tegra_vde_iommu_init(struct tegra_vde *vde)
 unreserve_iova:
 	__free_iova(&vde->iova, vde->iova_resv_static_addresses);
 detach_group:
-	iommu_detach_group(vde->domain, vde->group);
+	iommu_detach_device(vde->domain, dev);
 put_iova:
 	put_iova_domain(&vde->iova);
 	iova_cache_put();
@@ -146,7 +146,7 @@ void tegra_vde_iommu_deinit(struct tegra_vde *vde)
 	if (vde->domain) {
 		__free_iova(&vde->iova, vde->iova_resv_last_page);
 		__free_iova(&vde->iova, vde->iova_resv_static_addresses);
-		iommu_detach_group(vde->domain, vde->group);
+		iommu_detach_device(vde->domain, vde->miscdev.parent);
 		put_iova_domain(&vde->iova);
 		iova_cache_put();
 		iommu_domain_free(vde->domain);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
