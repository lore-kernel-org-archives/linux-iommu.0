Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434BDC433FE
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 03:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EEB0240106;
	Mon, 14 Feb 2022 03:01:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 90M6Ye-OXYgR; Mon, 14 Feb 2022 03:01:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AC25B4012A;
	Mon, 14 Feb 2022 03:01:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 809B7C001A;
	Mon, 14 Feb 2022 03:01:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68D48C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 03:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47BC14012A
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 03:01:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wvq8guyFSCzU for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 03:01:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4790D40106
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 03:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644807669; x=1676343669;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=p2vQ+UAviLd5lnbMwBPi9FpeI0f022As0OZJg61G+20=;
 b=mlld7C2Alwcl0Nza4s5grp5jiU+RRGl0IroVEZgE/uy9gz+7w2WRpmJa
 6efkPBYUrq+nesUHymKk8ARkWxndtddwRppvFewGwiekAk4/vv8WrnbAn
 qz2CX2iQsXgPv85YrncR/CDTrxTLcQzEEkYZ5Mkffyac393+cWLHS6Fuo
 X4YumpAWAV5CKn2nnxSf0nlPb95zxvr5qMt52JCwbFz49svKEg5HOVPd0
 b4bkOt8W/z0XL/kLWN9gwzlQUyWAETsBR0ujOJbGtEKVwOW9VBounKzDz
 t85foS2cS8qdIL5x2gib8849a843jr+wuAI/72rQqtFDjERhS+Mh38hg1 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="310736576"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="310736576"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2022 19:01:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="680167100"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2022 19:01:03 -0800
Message-ID: <9d123ace-8e76-2d4d-0802-4ba5f21acfe9@linux.intel.com>
Date: Mon, 14 Feb 2022 10:59:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 00/10] iommu/vt-d: Some Intel IOMMU cleanups
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2/7/22 2:41 PM, Lu Baolu wrote:
> Hi folks,
> 
> After a long time of evolution, the drivers/iommu/intel/iommu.c becomes
> fat and a bit messy. This series tries to cleanup and refactor the
> driver to make it more concise. Your comments are very appreciated.
> 
> Best regards,
> baolu
> 
> Lu Baolu (10):
>    iommu/vt-d: Move DMAR specific helpers into dmar.c
>    iommu/vt-d: Remove intel_iommu::domains
>    iommu/vt-d: Remove finding domain in dmar_insert_one_dev_info()
>    iommu/vt-d: Remove iova_cache_get/put()
>    iommu/vt-d: Remove domain and devinfo mempool
>    iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
>    iommu/vt-d: Use an xarray for global device_domain_info
>    iommu/vt-d: Use rculist for dmar_domain::devices
>    iommu/vt-d: Refactor dmar_insert_one_dev_info()
>    iommu/vt-d: Some cleanups in iommu.c
> 
>   include/linux/dmar.h          |   43 +-
>   include/linux/intel-iommu.h   |  220 ++++++-
>   drivers/iommu/intel/debugfs.c |    3 -
>   drivers/iommu/intel/dmar.c    |  216 ++++++-
>   drivers/iommu/intel/iommu.c   | 1109 ++++++---------------------------
>   5 files changed, 650 insertions(+), 941 deletions(-)
> 

Thanks for your review comments. A new version of this series has been
posted.

https://lore.kernel.org/linux-iommu/20220214025704.3184654-1-baolu.lu@linux.intel.com/

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
