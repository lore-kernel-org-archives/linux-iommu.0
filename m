Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D34C433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 19:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE80560B54;
	Fri, 29 Apr 2022 19:20:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nzcLqeP7p2i7; Fri, 29 Apr 2022 19:20:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 90D4E60B35;
	Fri, 29 Apr 2022 19:20:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75157C0032;
	Fri, 29 Apr 2022 19:20:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FCDEC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 19:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6CF0E41D79
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 19:20:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2jSn6CH1K2iN for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 19:20:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FD1841D6F
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 19:20:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00F7B1063;
 Fri, 29 Apr 2022 12:20:54 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 226FC3F73B;
 Fri, 29 Apr 2022 12:20:50 -0700 (PDT)
Message-ID: <cab0cf66-5e9c-346e-6eb5-ea1f996fbab3@arm.com>
Date: Fri, 29 Apr 2022 20:20:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RFC 15/19] iommu/arm-smmu-v3: Add
 set_dirty_tracking_range() support
Content-Language: en-GB
To: Joao Martins <joao.m.martins@oracle.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-16-joao.m.martins@oracle.com>
 <BN9PR11MB5276AEDA199F2BC7F13035B98CFC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f37924f3-ee44-4579-e4e2-251bb0557bfc@oracle.com>
 <a0331f20-9cf4-708e-a30d-6198dadd1b23@arm.com>
 <e1c92dad-c672-51c6-5acc-1a50218347ff@oracle.com>
 <20220429122352.GU8364@nvidia.com>
 <bed35e91-3b47-f312-4555-428bb8a7bd89@oracle.com>
 <20220429161134.GB8364@nvidia.com>
 <e238dd28-2449-ec1e-ee32-08446c4383a9@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <e238dd28-2449-ec1e-ee32-08446c4383a9@oracle.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
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

On 2022-04-29 17:40, Joao Martins wrote:
> On 4/29/22 17:11, Jason Gunthorpe wrote:
>> On Fri, Apr 29, 2022 at 03:45:23PM +0100, Joao Martins wrote:
>>> On 4/29/22 13:23, Jason Gunthorpe wrote:
>>>> On Fri, Apr 29, 2022 at 01:06:06PM +0100, Joao Martins wrote:
>>>>
>>>>>> TBH I'd be inclined to just enable DBM unconditionally in
>>>>>> arm_smmu_domain_finalise() if the SMMU supports it. Trying to toggle it
>>>>>> dynamically (especially on a live domain) seems more trouble that it's
>>>>>> worth.
>>>>>
>>>>> Hmmm, but then it would strip userland/VMM from any sort of control (contrary
>>>>> to what we can do on the CPU/KVM side). e.g. the first time you do
>>>>> GET_DIRTY_IOVA it would return all dirtied IOVAs since the beginning
>>>>> of guest time, as opposed to those only after you enabled dirty-tracking.
>>>>
>>>> It just means that on SMMU the start tracking op clears all the dirty
>>>> bits.
>>>>
>>> Hmm, OK. But aren't really picking a poison here? On ARM it's the difference
>>> from switching the setting the DBM bit and put the IOPTE as writeable-clean (which
>>> is clearing another bit) versus read-and-clear-when-dirty-track-start which means
>>> we need to re-walk the pagetables to clear one bit.
>>
>> Yes, I don't think a iopte walk is avoidable?
>>
> Correct -- exactly why I am still more learning towards enable DBM bit only at start
> versus enabling DBM at domain-creation while clearing dirty at start.

I'd say it's largely down to whether you want the bother of 
communicating a dynamic behaviour change into io-pgtable. The big 
advantage of having it just use DBM all the time is that you don't have 
to do that, and the "start tracking" operation is then nothing more than 
a normal "read and clear" operation but ignoring the read result.

At this point I'd much rather opt for simplicity, and leave the fancier 
stuff to revisit later if and when somebody does demonstrate a 
significant overhead from using DBM when not strictly needed.

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
