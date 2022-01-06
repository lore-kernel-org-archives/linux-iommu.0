Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19835C433EF
	for <iommu@archiver.kernel.org>; Thu,  6 Jan 2022 02:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBBE8428B1;
	Thu,  6 Jan 2022 02:22:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NUT3Ym_k6jkn; Thu,  6 Jan 2022 02:22:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D6142428A5;
	Thu,  6 Jan 2022 02:22:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF012C002F;
	Thu,  6 Jan 2022 02:22:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDF93C002F
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:22:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABFE960D72
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:22:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hhq8MvMI7mnG for <iommu@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 02:22:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 257EE60B33
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641435755; x=1672971755;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GDCUJufXvlu7Z20AypZ4GsZd9L9C8y8eFXL56cSyTrE=;
 b=DWPH9272X9BFNjgHIs1lexF61dTSRcjOUBMsdxUPzWfBfp+CDUgqZXlu
 eFtPyhpLHc0oFJS+hAdzbxuiXHmrPr8YtMbPSrRfwKnde2W3FAcYtSPE7
 mUach//L+k4vL5SoOqyWBaAvQTPtPmHTQ1NG3OGxi687nrUWSLD+oNM34
 srr45r26GAC6G9CrbpT0CLRj+b/c/d8gYiC5fL8RkBx6CkqmSKhah2dhC
 Ld124+pIT0RFLSuvYjx7OamnyYrrCZ6y0k2gfb6mD/Y7zpDknKnDilKDB
 xMw0CKwdT9dp1PZAiiTd5977eAoafXxHGkUhg+jOMqKL5eb6fs9oOmV31 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242531679"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="242531679"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2022 18:22:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="526794466"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 18:22:24 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v1 6/8] gpu/host1x: Use iommu_attach/detach_device()
Date: Thu,  6 Jan 2022 10:20:51 +0800
Message-Id: <20220106022053.2406748-7-baolu.lu@linux.intel.com>
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
 drivers/gpu/host1x/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index fbb6447b8659..6e08cb6202cc 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -265,7 +265,7 @@ static struct iommu_domain *host1x_iommu_attach(struct host1x *host)
 			goto put_cache;
 		}
 
-		err = iommu_attach_group(host->domain, host->group);
+		err = iommu_attach_device(host->domain, host->dev);
 		if (err) {
 			if (err == -ENODEV)
 				err = 0;
@@ -335,7 +335,7 @@ static void host1x_iommu_exit(struct host1x *host)
 {
 	if (host->domain) {
 		put_iova_domain(&host->iova);
-		iommu_detach_group(host->domain, host->group);
+		iommu_detach_device(host->domain, host->dev);
 
 		iommu_domain_free(host->domain);
 		host->domain = NULL;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
