Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E18FC433EF
	for <iommu@archiver.kernel.org>; Fri, 25 Feb 2022 22:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E36B840AD6;
	Fri, 25 Feb 2022 22:06:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MhUQ-tw64L3i; Fri, 25 Feb 2022 22:06:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8FEAD40385;
	Fri, 25 Feb 2022 22:06:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7092DC0033;
	Fri, 25 Feb 2022 22:06:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B6B1C001A
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 22:06:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 480AE612F1
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 22:06:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LC--_RhtzlPm for <iommu@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 22:06:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4CE8612EF
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 22:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645826793; x=1677362793;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=U0LnNa5rgaykiuNGMZGPVXAMkCcNVFd2QMGGkX2fDMc=;
 b=G9pKTIWAWq+0vtQkgGxzqG2jwAWNdfg7GTEsmHgPs3hm9Kgc9w15r1sR
 my0CvcghIAbsl0vmYPxZM+To3RQCHysimaw87LkdBOFSvLo+uVF96T6z2
 iOv1bj+rwMl9CHp+Fa3t/N/4t3S82Ko5ztGgz/zR1TRORrew/1SHEvKLZ
 Xdrml3f5Gstq/Wa0S850Jh9kHD2q2vK7/wBskvBx9FbsOOm42EGY9/nUP
 u2m6I2IsHFShXiMi4k5VKQdVwM0uwEnBmXNW+IDMtQSZGzJc0kk6ui+bY
 oA9D38Q80VCLySDAv6KBB7OlXMTZy1Zr7oLYgrUiWh5r0zy8HzdCa9EN6 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="239992853"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; d="scan'208";a="239992853"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2022 14:06:32 -0800
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; d="scan'208";a="684776647"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2022 14:06:32 -0800
Date: Fri, 25 Feb 2022 14:09:37 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 09/10] iommu/vt-d: Refactor dmar_insert_one_dev_info()
Message-ID: <20220225140617.63a95344@jacob-builder>
In-Reply-To: <20220207064142.1092846-10-baolu.lu@linux.intel.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220207064142.1092846-10-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

Hi BaoLu,

On Mon,  7 Feb 2022 14:41:41 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

>  
> -	if (dev && domain_context_mapping(domain, dev)) {
> -		dev_err(dev, "Domain context map failed\n");
> -		dmar_remove_one_dev_info(dev);
> -		return NULL;
> -	}
> +	/* Setup the context entry for device: */
> +	ret = domain_context_mapping(domain, dev);
> +	if (ret)
> +		goto setup_context_err;
>  
> -	return domain;
> +	info->domain = domain;
> +	list_add_rcu(&info->link, &domain->devices);
> +
There seems to be an ordering problem. We need to do list_add_rcu()
*before*  domain_context_mapping(). Otherwise, while doing context mapping
the search for dev IOTLB support in iommu_support_dev_iotlb() will fail.
Then ATS capable device context will not have DTE bit set. The result is
DMAR unrecoverable fault while doing DMA.


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
