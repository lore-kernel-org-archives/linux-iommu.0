Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64441C433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 10:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0361481763;
	Mon,  6 Dec 2021 10:49:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dd6dgOBqcpAE; Mon,  6 Dec 2021 10:49:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C6EBF81769;
	Mon,  6 Dec 2021 10:49:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C9C5C001E;
	Mon,  6 Dec 2021 10:49:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55849C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 10:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 483DB40224
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 10:49:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pM-x3zFfn8P5 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 10:49:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1067D400A4
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 10:49:04 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id BB60137E; Mon,  6 Dec 2021 11:48:57 +0100 (CET)
Date: Mon, 6 Dec 2021 11:48:23 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [RFC v16 1/9] iommu: Introduce attach/detach_pasid_table API
Message-ID: <Ya3qd6mT/DpceSm8@8bytes.org>
References: <20211027104428.1059740-1-eric.auger@redhat.com>
 <20211027104428.1059740-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211027104428.1059740-2-eric.auger@redhat.com>
Cc: peter.maydell@linaro.org, kvm@vger.kernel.org, vivek.gautam@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com,
 jean-philippe@linaro.org, ashok.raj@intel.com, maz@kernel.org,
 vsethi@nvidia.com, zhangfei.gao@linaro.org, kevin.tian@intel.com,
 will@kernel.org, alex.williamson@redhat.com, wangxingang5@huawei.com,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

On Wed, Oct 27, 2021 at 12:44:20PM +0200, Eric Auger wrote:
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

This Signed-of-by chain looks dubious, you are the author but the last
one in the chain?

> +int iommu_uapi_attach_pasid_table(struct iommu_domain *domain,
> +				  void __user *uinfo)
> +{

[...]

> +	if (pasid_table_data.format == IOMMU_PASID_FORMAT_SMMUV3 &&
> +	    pasid_table_data.argsz <
> +		offsetofend(struct iommu_pasid_table_config, vendor_data.smmuv3))
> +		return -EINVAL;

This check looks like it belongs in driver specific code.

Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
