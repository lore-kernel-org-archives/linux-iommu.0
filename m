Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4808AC433F5
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 12:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4199610C2;
	Wed,  6 Apr 2022 12:32:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jQJoAUZIXGid; Wed,  6 Apr 2022 12:32:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 88307610AB;
	Wed,  6 Apr 2022 12:32:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F576C002C;
	Wed,  6 Apr 2022 12:32:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AD35C0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 12:32:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4912440608
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 12:32:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uTEzJTVkb3gY for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 12:32:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65235403C4
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 12:32:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 832F81516;
 Wed,  6 Apr 2022 05:32:14 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97DBD3F718;
 Wed,  6 Apr 2022 05:32:12 -0700 (PDT)
Message-ID: <d0f6caea-0cd9-d839-c9fb-0fe49c2bad16@arm.com>
Date: Wed, 6 Apr 2022 13:32:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Content-Language: en-GB
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-4-baolu.lu@linux.intel.com>
 <20220330190201.GB2120790@nvidia.com>
 <BN9PR11MB5276A39F481E2E31B0FCFEAE8CE39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220402233210.GM2120790@nvidia.com>
 <BN9PR11MB527660D99D154F922B0A628B8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220406012334.GZ2120790@nvidia.com>
 <BN9PR11MB52764E3DE16E19D1F1515D008CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <BN9PR11MB52764E3DE16E19D1F1515D008CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On 2022-04-06 06:58, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Wednesday, April 6, 2022 9:24 AM
>>
>> On Wed, Apr 06, 2022 at 01:00:13AM +0000, Tian, Kevin wrote:
>>
>>>> Because domains wrap more than just the IOPTE format, they have
>>>> additional data related to the IOMMU HW block itself. Imagine a SOC
>>>> with two IOMMU HW blocks that can both process the CPU IOPTE format,
>>>> but have different configuration.
>>>
>>> Curious. Is it hypothesis or real? If real can you help give a concrete
>>> example?
>>
>> Look at arm_smmu_attach_dev() - the domain has exactly one smmu
>> pointer which contains the base address for the SMMU IP block. If the
>> domain doesn't match the smmu pointer from the struct device it won't
>> allow attaching.
>>
>> I know of ARM SOCs with many copies of the SMMU IP block.
>>
>> So at least with current drivers ARM seems to have this limitation.
>>
> 
> I saw that code, but before this series it is used only for stage-2 instead
> of SVA. and I didn't see similar check in the old sva related paths (though
> it doesn't use domain):
> 
> arm_smmu_master_sva_enable_iopf()
> arm_smmu_master_enable_sva{}
> __arm_smmu_sva_bind()
> 
> If I didn't overlook some trick hiding in the call chain of those functions,
> is there a bug in the existing SMMU sva logic or is it conceptually correct
> to not have such check for SVA?

The current SVA APIs are all device-based, so implicitly reflect 
whichever SMMU instance serves the given device. Once domains come into 
the picture, callers are going to have to be more aware that a domain 
may be specific to a particular IOMMU instance, and potentially allocate 
separate domains for separate devices to represent the same address 
space, much like vfio_iommu_type1_attach_group() does.

It's not really worth IOMMU drivers trying to support a domain spanning 
potentially-heterogeneous instances internally, since they can't 
reasonably know what matters in any particular situation. That's 
primarily why we've never tried to do it in the SMMU drivers. It's a lot 
easier for relevant callers to look at what they get and figure out 
whether any mismatch in capabilities is tolerable or not.

Robin.

> If the former then yes we have to take SMMU IP block into consideration
> thus could have multiple domains per CPU page table. If the latter then
> this is not a valid example for that configuration.
> 
> Which one is correct?
> 
> Thanks
> Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
