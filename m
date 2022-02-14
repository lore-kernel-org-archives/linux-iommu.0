Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63390C433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 14:10:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F27A0400A4;
	Mon, 14 Feb 2022 14:10:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xchSy-YbOZIO; Mon, 14 Feb 2022 14:10:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 95A22400B8;
	Mon, 14 Feb 2022 14:10:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39A01C001A;
	Mon, 14 Feb 2022 14:10:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D904C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 14:10:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4949560ECE
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 14:10:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9hXDYh368UGx for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 14:10:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29E2060AFE
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 14:10:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FC2F1042;
 Mon, 14 Feb 2022 06:10:29 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E40A3F66F;
 Mon, 14 Feb 2022 06:10:24 -0800 (PST)
Message-ID: <1347f0ef-e046-1332-32f0-07347cc2079c@arm.com>
Date: Mon, 14 Feb 2022 14:10:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v1 1/8] iommu: Add iommu_group_replace_domain()
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
 <20220106022053.2406748-2-baolu.lu@linux.intel.com>
 <43f2fc07-19ea-53a4-af86-a9192a950c96@arm.com>
 <20220214124518.GU4160@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220214124518.GU4160@nvidia.com>
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Stuart Yoder <stuyoder@gmail.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
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

On 2022-02-14 12:45, Jason Gunthorpe wrote:
> On Mon, Feb 14, 2022 at 12:09:36PM +0000, Robin Murphy wrote:
>> On 2022-01-06 02:20, Lu Baolu wrote:
>>> Expose an interface to replace the domain of an iommu group for frameworks
>>> like vfio which claims the ownership of the whole iommu group.
>>
>> But if the underlying point is the new expectation that
>> iommu_{attach,detach}_device() operate on the device's whole group where
>> relevant, why should we invent some special mechanism for VFIO to be
>> needlessly inconsistent?
>>
>> I said before that it's trivial for VFIO to resolve a suitable device if it
>> needs to; by now I've actually written the patch ;)
>>
>> https://gitlab.arm.com/linux-arm/linux-rm/-/commit/9f37d8c17c9b606abc96e1f1001c0b97c8b93ed5
> 
> Er, how does locking work there? What keeps busdev from being
> concurrently unplugged?

Same thing that prevents the bus pointer from suddenly becoming invalid 
in the current code, I guess :)

But yes, holding a group reference alone can't prevent the group itself 
from changing, and the finer points of locking still need working out - 
there's a reason you got a link to a WIP branch in my tree rather than a 
proper patch in your inbox (TBH at the moment that one represents about 
a 5:1 ratio of time spent on the reasoning behind the commit message vs. 
the implementation itself).

> How can iommu_group_get() be safely called on
> this pointer?

VFIO hardly needs to retrieve the iommu_group from a device which it 
derived from the iommu_group it holds in the first place. What matters 
is being able to call *other* device-based IOMMU API interfaces in the 
long term. And once a robust solution for that is in place, it should 
inevitably work for a device-based attach interface too.

> All of the above only works normally inside a probe/remove context
> where the driver core is blocking concurrent unplug and descruction.
> 
> I think I said this last time you brought it up that lifetime was the
> challenge with this idea.

Indeed, but it's a challenge that needs tackling, because the bus-based 
interfaces need to go away. So either we figure it out now and let this 
attach interface rework benefit immediately, or I spend three times as 
long solving it on my own and end up deleting 
iommu_group_replace_domain() in about 6 months' time anyway.

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
