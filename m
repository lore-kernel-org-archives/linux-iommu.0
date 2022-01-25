Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDEAC433EF
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 03:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 786CD84C03;
	Tue, 25 Jan 2022 03:00:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xtrLN4C6LQnG; Tue, 25 Jan 2022 03:00:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5770A84BFC;
	Tue, 25 Jan 2022 03:00:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B14AC0039;
	Tue, 25 Jan 2022 03:00:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 451C7C002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 03:00:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2AF114159C
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 03:00:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e0-u7c8CVVsi for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 03:00:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48B8E4159B
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 03:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643079639; x=1674615639;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=hcjXanRyyzUabhBOjDATgrq+wFYZUEv0LZVR5v+RCiM=;
 b=jBNyvcxFFN3txwnn9KTvXiieBKBhi0c/Mv2fhbLY9C9kE0pdMAwJ/ACQ
 qeluOnK1qFq/1bzigbKD6BXI1hxG3fNR+pWas4E74B+FOznCm6/y9lzb6
 XIdtvbpI285n3+r5RbtmwQm0/BRgCkxGEN20FtGF/rP/ns+/v3dvLKW6B
 4itRKfi5NeY2Y88b5SxkiUMaSSgw4XaNCMGvqlMmw4EdKW66otC+1yl8S
 D0fjfaSVyFKoPzjUSECzln7EKed6a76ODzgMerkMJkGPuTHoeQybHqf/4
 3mhONa9wNG5NI+B/ji3xMpo/seZRzxycaOOlXuN3vxPe0luR/xRQh/BLH Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226875068"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; d="scan'208";a="226875068"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 19:00:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; d="scan'208";a="534530804"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 19:00:34 -0800
Subject: Re: [PATCH 5/7] drm/nouveau/device: Get right pgsize_bitmap of
 iommu_domain
To: Christoph Hellwig <hch@infradead.org>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-6-baolu.lu@linux.intel.com>
 <Ye5xlSbwAw5JJ8k2@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5977c231-fbd3-ac26-ff13-94ed7a08f347@linux.intel.com>
Date: Tue, 25 Jan 2022 10:59:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ye5xlSbwAw5JJ8k2@infradead.org>
Content-Language: en-US
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
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

On 1/24/22 5:29 PM, Christoph Hellwig wrote:
> On Mon, Jan 24, 2022 at 03:11:00PM +0800, Lu Baolu wrote:
>> The supported page sizes of an iommu_domain are saved in the pgsize_bitmap
>> field. Retrieve the value from the right place.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>> Link: https://lore.kernel.org/r/20211218074546.1772553-1-baolu.lu@linux.intel.com
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Wouldn't it mke sense to remove the pgsize_bitmap in struct iommu_ops
> and initialize the domain field in the domain_alloc methods?  Or am I
> missing something?
> 

It looks reasonable to me. The pgsize_bitmap is an attribute of a domain
that provides the map/unmap interfaces. It could be moved out of the
iommu_ops structure.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
