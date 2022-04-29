Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2316C433FE
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 11:19:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 471B18400F;
	Fri, 29 Apr 2022 11:19:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UNUnaQTNhdLx; Fri, 29 Apr 2022 11:19:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3D58184032;
	Fri, 29 Apr 2022 11:19:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF04DC0032;
	Fri, 29 Apr 2022 11:19:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C704C002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 11:19:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E784560E9E
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 11:19:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rE5eUGOvw4ee for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 11:19:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C7E860E2F
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 11:19:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08D281063;
 Fri, 29 Apr 2022 04:19:17 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA3103F73B;
 Fri, 29 Apr 2022 04:19:13 -0700 (PDT)
Message-ID: <a0331f20-9cf4-708e-a30d-6198dadd1b23@arm.com>
Date: Fri, 29 Apr 2022 12:19:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RFC 15/19] iommu/arm-smmu-v3: Add
 set_dirty_tracking_range() support
Content-Language: en-GB
To: Joao Martins <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-16-joao.m.martins@oracle.com>
 <BN9PR11MB5276AEDA199F2BC7F13035B98CFC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f37924f3-ee44-4579-e4e2-251bb0557bfc@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <f37924f3-ee44-4579-e4e2-251bb0557bfc@oracle.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On 2022-04-29 12:05, Joao Martins wrote:
> On 4/29/22 09:28, Tian, Kevin wrote:
>>> From: Joao Martins <joao.m.martins@oracle.com>
>>> Sent: Friday, April 29, 2022 5:09 AM
>>>
>>> Similar to .read_and_clear_dirty() use the page table
>>> walker helper functions and set DBM|RDONLY bit, thus
>>> switching the IOPTE to writeable-clean.
>>
>> this should not be one-off if the operation needs to be
>> applied to IOPTE. Say a map request comes right after
>> set_dirty_tracking() is called. If it's agreed to remove
>> the range op then smmu driver should record the tracking
>> status internally and then apply the modifier to all the new
>> mappings automatically before dirty tracking is disabled.
>> Otherwise the same logic needs to be kept in iommufd to
>> call set_dirty_tracking_range() explicitly for every new
>> iopt_area created within the tracking window.
> 
> Gah, I totally missed that by mistake. New mappings aren't
> carrying over the "DBM is set". This needs a new io-pgtable
> quirk added post dirty-tracking toggling.
> 
> I can adjust, but I am at odds on including this in a future
> iteration given that I can't really test any of this stuff.
> Might drop the driver until I have hardware/emulation I can
> use (or maybe others can take over this). It was included
> for revising the iommu core ops and whether iommufd was
> affected by it.
> 
> I'll delete the range op, and let smmu v3 driver walk its
> own IO pgtables.

TBH I'd be inclined to just enable DBM unconditionally in 
arm_smmu_domain_finalise() if the SMMU supports it. Trying to toggle it 
dynamically (especially on a live domain) seems more trouble that it's 
worth.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
