Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9887AC4332F
	for <iommu@archiver.kernel.org>; Thu,  6 Jan 2022 03:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4644060E29;
	Thu,  6 Jan 2022 03:19:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gzcs5GDWf2Te; Thu,  6 Jan 2022 03:19:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 38A9160DFD;
	Thu,  6 Jan 2022 03:19:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EDFDC0030;
	Thu,  6 Jan 2022 03:19:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B073AC001E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 03:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C8D140577
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 03:19:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TOVrs-U_hDvW for <iommu@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 03:19:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5E5740165
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 03:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641439150; x=1672975150;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=jVs1PWNNKTf5pqsikfeVCGpxxqUkOICSdcJS6faPCaM=;
 b=MvKbXQ4wF3qU6a/wkmKEKpY4wVAGI4VQxJd/Uq5Xd8/1lzq7Oj/AEV9Z
 nV9SuiAg82yUL7ydIrGI5RTLaIoyZDmwbVn6NLlPbR2KotqP8bjtrVAmV
 wOi/gMS2VthEJ5zkhZuGoHp/BpQDIpFuMGBarm0LmeaP/eptUdncXLGyJ
 gt9q47sHXtaUBlCOl5qe8b7zannkUBooRZb1kzVzuPWNj9OKaTLAQYocp
 UgLJKYms7ihvmcgARoT1IYVU9WJb6HalnKlj67qXqNYIR1kxeZThZNSPt
 lEpZ3VscZudu+Dqwu+fnbwW0zc/cE7P3GIaE0HJGoqGCMbPJKzhGEHKVG w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="266866629"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="266866629"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2022 19:19:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="526808939"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 19:19:03 -0800
Subject: Re: [PATCH v5 01/14] iommu: Add dma ownership management interfaces
To: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <YdQcgFhIMYvUwABV@infradead.org>
 <20220104164100.GA101735@bhelgaas> <20220104192348.GK2328285@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <370335ad-0a2f-3668-9229-c65896f12828@linux.intel.com>
Date: Thu, 6 Jan 2022 11:18:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104192348.GK2328285@nvidia.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On 1/5/22 3:23 AM, Jason Gunthorpe wrote:
>>>> The vfio oriented interfaces are,
>>>>
>>>> 	int iommu_group_set_dma_owner(struct iommu_group *group,
>>>> 				      void *owner);
>>>> 	void iommu_group_release_dma_owner(struct iommu_group *group);
>>>> 	bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>>>>
>>>> The device userspace assignment must be disallowed if the set dma owner
>>>> interface returns failure.
>> Can you connect this back to the "never a mixture" from the beginning?
>> If all you cared about was prevent an IOMMU group from containing
>> devices with a mixture of kernel drivers and userspace drivers, I
>> assume you could do that without iommu_device_use_dma_api().  So is
>> this a way to*allow*  a mixture under certain restricted conditions?
> It is not about user/kernel, it is about arbitrating the shared
> group->domain against multiple different requests to set it to
> something else.
> 
> Lu, Given that the word 'user' was deleted from the API entirely it
> makes sense to reword these commit messages to focus less on user vs
> kernel and more on ownership of the domain pointer.

Sure. Will do it.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
