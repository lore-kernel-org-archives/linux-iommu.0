Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EEFC433F5
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 06:39:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14DB841C25;
	Sat, 23 Apr 2022 06:39:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 75j2FVqAVLOj; Sat, 23 Apr 2022 06:39:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B3E1341BF1;
	Sat, 23 Apr 2022 06:39:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D143C0032;
	Sat, 23 Apr 2022 06:39:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4766FC002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 06:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2DA3D60E46
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 06:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eMftEB_xCKvZ for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 06:39:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6903A60E2B
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 06:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650695966; x=1682231966;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=gVRIdH50VRkkOoW7Ed2DisHM8rizLUoP6GWfszv/o78=;
 b=PgcVntVvJHI+KdGT4X7vbxP6au7TToOO9c8rcpszA2zCDrzEdpNKpVeY
 lWf+OX28lYQtx1LG36ZjqXT0LRu1z16eym1L4xpyxDT5E02ukKR4CPOUS
 25dM1qWzWpdSW0IPUJZHRiWdnXY3CUfvGH40M2gBY92GQzzZMb92aZPZn
 88BMgZ0rGukxyI4vdfXR5s9KXa9k0Z7F2G5Mz/hNh6CAJg+/OqlpR/i5O
 iYW2yzY7ZiPv6ApoeMqAr8OVhcrhyxZsOJVnYVkZG0tdlHSNVmI7mSQrc
 dVfGw2tfngrxyevimzwtmOrRcwboPxpoi3Id9HoKLXAmcgKbmmfbwoqoU A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264351333"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; d="scan'208";a="264351333"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2022 23:39:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; d="scan'208";a="578293638"
Received: from yjsun1-mobl.ccr.corp.intel.com (HELO [10.255.31.217])
 ([10.255.31.217])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2022 23:39:17 -0700
Message-ID: <675db27a-94d4-f933-1fa1-0960d64f3ff2@linux.intel.com>
Date: Sat, 23 Apr 2022 14:39:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v11 1/9] iommu: Introduce a callback to struct
 iommu_resv_region
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20220422162907.1276-1-shameerali.kolothum.thodi@huawei.com>
 <20220422162907.1276-2-shameerali.kolothum.thodi@huawei.com>
 <03e94ba9-f558-954f-e84b-cd8a9e693aea@linux.intel.com>
 <YmOLGsaMa7hCjMzx@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YmOLGsaMa7hCjMzx@infradead.org>
Cc: will@kernel.org, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, wanghuiqiang@huawei.com,
 guohanjun@huawei.com, Sami.Mujawar@arm.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On 2022/4/23 13:14, Christoph Hellwig wrote:
> On Sat, Apr 23, 2022 at 10:04:39AM +0800, Lu Baolu wrote:
>> The generic_iommu_put_resv_regions() itself is a callback. Why bothering
>> adding another callback from the same iommu driver in it? Or, you are
>> going to remove the put_resv_regions from the iommu ops?
> 
> It is a driver method, but these reserved entries are not actually
> allocated by the driver.  And I do have a patch pending removing this
> driver method that should never have been a driver method, check
> the iomm list archives for
> 
>      iommu: remove the put_resv_regions method
> 

Yeah! That's a good idea.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
