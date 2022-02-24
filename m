Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9AFC4332F
	for <iommu@archiver.kernel.org>; Thu, 24 Feb 2022 08:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B91681313;
	Thu, 24 Feb 2022 08:58:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PH1_v-3_H-L2; Thu, 24 Feb 2022 08:58:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D33D38131F;
	Thu, 24 Feb 2022 08:58:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 871A6C001A;
	Thu, 24 Feb 2022 08:58:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52CE4C0011
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 08:58:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2CD848131F
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 08:58:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xWVmx_o9uQqJ for <iommu@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:58:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 020EC81313
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 08:58:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21F78D6E;
 Thu, 24 Feb 2022 00:58:46 -0800 (PST)
Received: from [10.57.40.147] (unknown [10.57.40.147])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73E543F70D;
 Thu, 24 Feb 2022 00:58:40 -0800 (PST)
Message-ID: <31dc9d19-362d-4c1a-1483-cc7f525c6dd3@arm.com>
Date: Thu, 24 Feb 2022 08:58:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 01/11] iommu: Add dma ownership management interfaces
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
 <20220218005521.172832-2-baolu.lu@linux.intel.com>
 <f830c268-daca-8e8f-a429-0c80496a7273@arm.com>
 <20220223180244.GA390403@nvidia.com>
 <dd944ab4-cf25-fa41-0170-875e5c5fd0e8@linux.intel.com>
 <c591f91a-392c-21a2-e9bd-10c64073e9e8@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <c591f91a-392c-21a2-e9bd-10c64073e9e8@linux.intel.com>
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

On 2022-02-24 05:29, Lu Baolu wrote:
> On 2/24/22 1:16 PM, Lu Baolu wrote:
>> Hi Robin and Jason,
>>
>> On 2/24/22 2:02 AM, Jason Gunthorpe wrote:
>>> On Wed, Feb 23, 2022 at 06:00:06PM +0000, Robin Murphy wrote:
>>>
>>>> ...and equivalently just set owner_cnt directly to 0 here. I don't 
>>>> see a
>>>> realistic use-case for any driver to claim the same group more than 
>>>> once,
>>>> and allowing it in the API just feels like opening up various potential
>>>> corners for things to get out of sync.
>>> I am Ok if we toss it out to get this merged, as there is no in-kernel
>>> user right now.
>>
>> So we don't need the owner pointer in the API anymore, right?
> 
> Oh, NO.
> 
> The owner token represents that the group has been claimed for user
> space access. And the default domain auto-attach policy will be changed
> accordingly.
> 
> So we still need this. Sorry for the noise.

Exactly. In fact we could almost go the other way, and rename owner_cnt 
to dma_api_users and make it mutually exclusive with owner being set, 
but that's really just cosmetic. It's understandable enough as-is that 
owner_cnt > 0 with owner == NULL represents implicit DMA API ownership.

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
