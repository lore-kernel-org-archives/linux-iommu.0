Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16371C433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 20:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6827360AD2;
	Mon, 21 Feb 2022 20:43:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S_PxjwTncCec; Mon, 21 Feb 2022 20:43:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8DA1460595;
	Mon, 21 Feb 2022 20:43:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F610C0021;
	Mon, 21 Feb 2022 20:43:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 060EBC0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 20:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E3BA2605E9
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 20:43:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BmK_I4DvD33Y for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 20:43:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B7E560595
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 20:43:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47AEA1063;
 Mon, 21 Feb 2022 12:43:41 -0800 (PST)
Received: from [10.57.40.147] (unknown [10.57.40.147])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51ACA3F66F;
 Mon, 21 Feb 2022 12:43:37 -0800 (PST)
Message-ID: <1d8004d3-1887-4fc7-08d2-0e2ee6b5fdcb@arm.com>
Date: Mon, 21 Feb 2022 20:43:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 02/11] driver core: Add dma_cleanup callback in bus_type
Content-Language: en-GB
To: Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
 <20220218005521.172832-3-baolu.lu@linux.intel.com>
 <YhCdEmC2lYStmUSL@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YhCdEmC2lYStmUSL@infradead.org>
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Stuart Yoder <stuyoder@gmail.com>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-02-19 07:32, Christoph Hellwig wrote:
> So we are back to the callback madness instead of the nice and simple
> flag?  Sigh.

TBH, I *think* this part could be a fair bit simpler. It looks like this 
whole callback mess is effectively just to decrement group->owner_cnt, 
but since we should only care about ownership at probe, hotplug, and 
other places well outside critical fast-paths, I'm not sure we really 
need to keep track of that anyway - it can always be recalculated by 
walking the group->devices list, and some of the relevant places have to 
do that anyway. It should be pretty straightforward for 
iommu_bus_notifier to clear group->owner automatically upon an unbind of 
the matching driver when it's no longer bound to any other devices in 
the group either. And if we still want to entertain the notion of VFIO 
being able to release ownership without unbinding (I'm not entirely 
convinced that's a realistically necessary use-case) then it should be 
up to VFIO to decide when it's finally finished with the whole group, 
rather than pretending we can keep track of nested ownership claims from 
inside the API.

Furthermore, If Greg was willing to compromise just far enough to let us 
put driver_managed_dma in the 3-byte hole in the generic struct 
device_driver, we wouldn't have to have quite so much boilerplate 
repeated across the various bus implementations (I'm not suggesting to 
move any actual calls back into the driver core, just the storage of 
flag itself). FWIW I have some ideas for re-converging .dma_configure in 
future which I think should probably be able to subsume this into a 
completely generic common path, given a common flag.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
