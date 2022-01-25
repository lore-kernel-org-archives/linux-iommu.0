Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4146C433EF
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 14:48:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C72082CD4;
	Tue, 25 Jan 2022 14:48:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HyMOEkxEGkF8; Tue, 25 Jan 2022 14:48:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3632682CE4;
	Tue, 25 Jan 2022 14:48:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AD33C0031;
	Tue, 25 Jan 2022 14:48:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46002C002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 14:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 33B2760BDF
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 14:48:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uAnajBCnFfxV for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 14:48:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67A3560B5B
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 14:48:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7528D6E;
 Tue, 25 Jan 2022 06:48:09 -0800 (PST)
Received: from [10.57.68.26] (unknown [10.57.68.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95B2B3F793;
 Tue, 25 Jan 2022 06:48:06 -0800 (PST)
Message-ID: <7febcba4-f5bf-6bf6-6180-895b18d1b806@arm.com>
Date: Tue, 25 Jan 2022 14:48:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/7] iommu cleanup and refactoring
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52767F46CC13601306001B9E8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220124174404.GG966497@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220124174404.GG966497@nvidia.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Will Deacon <will@kernel.org>
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

On 2022-01-24 17:44, Jason Gunthorpe wrote:
> On Mon, Jan 24, 2022 at 09:46:26AM +0000, Tian, Kevin wrote:
>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>> Sent: Monday, January 24, 2022 3:11 PM
>>>
>>> Hi,
>>>
>>> The guest pasid and aux-domain related code are dead code in current
>>> iommu subtree. As we have reached a consensus that all these features
>>> should be based on the new iommufd framework (which is under active
>>> development), the first part of this series removes and cleanups all
>>> the dead code.
>>>
>>> The second part of this series refactors the iommu_domain by moving all
>>> domain-specific ops from iommu_ops to a new domain_ops. This makes an
>>> iommu_domain self-contained and represent the abstraction of an I/O
>>> translation table in the IOMMU subsystem. With different type of
>>> iommu_domain providing different set of ops, it's easier to support more
>>> types of I/O translation tables.
>>
>> You may want to give more background on this end goal. In general there
>> are four IOPT types in iommufd discussions:
>>
>> 1) The one currently tracked by iommu_domain, with a map/unmap semantics
>> 2) The one managed by mm and shared to iommu via sva_bind/unbind ops
>> 3) The one managed by userspace and bound to iommu via iommufd (require nesting)
>> 4) The one managed by KVM (e.g. EPT) and shared to iommu via a TBD interface
> 
> Yes, at least from an iommufd perspective I'd like to see one struct
> for all of these types, mainly so we can have a uniform alloc, attach
> and detatch flow for all io page table types.

Agreed, certainly an IOMMU_DOMAIN_SVA type that can both encapsulate the 
mm and effectively replace iommu_sva seems like a logical and fairly 
small next step. We already have the paradigm of different domain types 
supporting different ops, so initially an SVA domain would simply allow 
bind/unbind rather than attach/detach/map/unmap.

It might then further be possible to hide SVA bind/unbind behind the 
attach/detach interface, but AFAICS we'd still need distinct flows for 
attaching/binding the whole device vs. attaching/binding to a PASID, 
since they are fundamentally different things in their own right, and 
the ideal API should give us the orthogonality to also bind a device to 
an SVA domain without PASID (e.g. for KVM stage 2, or userspace 
assignment of simpler fault/stall-tolerant devices), or attach PASIDs to 
regular iommu_domains.

That distinction could of course be consolidated by flipping to the 
other approach of explicitly allocating the PASID first, then wrapping 
it in a struct device that could then be passed through the same 
attach/detach interfaces and distinguished internally, but although I 
still have a fondness for that approach I know I'm about the only one :)

Cheers,
Robin.

> If we want to use the iommu_domain, or make iommu_domain a sub-class
> of a new struct, can be determined as we go along.
> 
> Regardless, I think this cleanup stands on its own. Moving the ops and
> purging the dead code is clearly the right thing to do.
> 
> Thanks,
> Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
