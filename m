Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D74C433EF
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 14:11:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C19BD40286;
	Tue, 31 May 2022 14:11:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nNBDepFNC_Hm; Tue, 31 May 2022 14:11:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A93D4403B7;
	Tue, 31 May 2022 14:11:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76A94C0032;
	Tue, 31 May 2022 14:11:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5ABE4C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 14:11:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2363D8088A
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 14:11:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jp1bq7D4BKyV for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 14:11:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 42EEB83FFD
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654006286; x=1685542286;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=jlWqAS9a8O9NkMkuZlVFXTKLAixuk0JanbpsgrmgyZM=;
 b=aWo02sXYqlNtRkbZWCnLp7BrREXQmztLO0CJbffZbpRizuXLMZEO+Y0B
 6qUyMvSzf8WOMWVwGbJtbHK9SJXNC9WznYT3phJlofFU3AoWil56nYs5G
 3ukGSEbpLh/Ku4mp4WmWBRjuWudCXOOMhPfS30eYv5gCbPUdNo+DEp6L8
 dcWoxkG/OIdWxFYSO+EgyLlu2W9U22zh81YY6+6/GXLxNnLo56dvS+l5d
 kMcRODLhzxPyXbtyjP4a/DbQBwTLjJ4fo7dnftlE3lH4gQbwSR/nWrb49
 OJpi8LBrcn9O+mqd6WO7QcL0utNyIjlF67a2CgKb+yRi8STX2NKpoPlSx Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="300611414"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; d="scan'208";a="300611414"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2022 07:11:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; d="scan'208";a="605689795"
Received: from peakwan.ccr.corp.intel.com (HELO [10.249.168.229])
 ([10.249.168.229])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2022 07:11:20 -0700
Message-ID: <60318d83-e22f-f922-436f-6c31bce24d59@linux.intel.com>
Date: Tue, 31 May 2022 22:11:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <20220531131052.GD1343366@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220531131052.GD1343366@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Will Deacon <will@kernel.org>
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

On 2022/5/31 21:10, Jason Gunthorpe wrote:
> On Tue, May 31, 2022 at 11:02:06AM +0800, Baolu Lu wrote:
> 
>> For case 2, it is a bit weird. I tried to add a rwsem lock to make the
>> iommu_unmap() and dumping tables in debugfs exclusive. This does not
>> work because debugfs may depend on the DMA of the devices to work. It
>> seems that what we can do is to allow this race, but when we traverse
>> the page table in debugfs, we will check the validity of the physical
>> address retrieved from the page table entry. Then, the worst case is to
>> print some useless information.
> 
> Sounds horrible, don't you have locking around the IOPTEs of some
> kind? How does updating them work reliably?

There's no locking around updating the IOPTEs. The basic assumption is
that at any time, there's only a single thread manipulating the mappings
of the range specified in iommu_map/unmap() APIs. Therefore, the race
only exists when multiple ranges share some high-level IOPTEs. The IOMMU
driver updates those IOPTEs using the compare-and-exchange atomic
operation.

> 
> It is just debugfs, so maybe it is not the end of the world, but
> still..

Fair enough. I think this is somewhat similar to that IOMMU hardware can
traverse the page table at any time without considering when the CPUs
update it. The IOMMU hardware will generate faults when it encounters
failure during the traverse of page table. Similarly, perhaps debugfs
could dump all-ones for an invalid IOPTE?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
