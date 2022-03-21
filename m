Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4ADC433EF
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 11:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91D7181882;
	Mon, 21 Mar 2022 11:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id usrvednwqAF8; Mon, 21 Mar 2022 11:11:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 70715826E7;
	Mon, 21 Mar 2022 11:11:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A054C001A;
	Mon, 21 Mar 2022 11:11:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C17A5C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A226B409F5
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:11:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EtCc3ANWwTQ0 for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 11:11:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id AECBF409F4
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:11:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF93C1042;
 Mon, 21 Mar 2022 04:11:48 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA0783F766;
 Mon, 21 Mar 2022 04:11:46 -0700 (PDT)
Message-ID: <fd86c2cf-3068-1bea-2a6f-46cabb019062@arm.com>
Date: Mon, 21 Mar 2022 11:11:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] thunderbolt: Make iommu_dma_protection more
 accurate
Content-Language: en-GB
To: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
References: <cover.1647624084.git.robin.murphy@arm.com>
 <0dd14883930c9f55ace22162e23765a37d91a057.1647624084.git.robin.murphy@arm.com>
 <DM4PR12MB51683722CF9A553563D0C721E2139@DM4PR12MB5168.namprd12.prod.outlook.com>
 <YjhaViFzmEjBgmmu@lahna>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YjhaViFzmEjBgmmu@lahna>
Cc: "michael.jamet@intel.com" <michael.jamet@intel.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
 "hch@lst.de" <hch@lst.de>
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

On 2022-03-21 10:58, mika.westerberg@linux.intel.com wrote:
> Hi Mario,
> 
> On Fri, Mar 18, 2022 at 10:29:59PM +0000, Limonciello, Mario wrote:
>> [Public]
>>
>>> Between me trying to get rid of iommu_present() and Mario wanting to
>>> support the AMD equivalent of DMAR_PLATFORM_OPT_IN, scrutiny has
>>> shown
>>> that the iommu_dma_protection attribute is being far too optimistic.
>>> Even if an IOMMU might be present for some PCI segment in the system,
>>> that doesn't necessarily mean it provides translation for the device(s)
>>> we care about. Furthermore, all that DMAR_PLATFORM_OPT_IN really does
>>> is tell us that memory was protected before the kernel was loaded, and
>>> prevent the user from disabling the intel-iommu driver entirely. While
>>> that lets us assume kernel integrity, what matters for actual runtime
>>> DMA protection is whether we trust individual devices, based on the
>>> "external facing" property that we expect firmware to describe for
>>> Thunderbolt ports.
>>>
>>> It's proven challenging to determine the appropriate ports accurately
>>> given the variety of possible topologies, so while still not getting a
>>> perfect answer, by putting enough faith in firmware we can at least get
>>> a good bit closer. If we can see that any device near a Thunderbolt NHI
>>> has all the requisites for Kernel DMA Protection, chances are that it
>>> *is* a relevant port, but moreover that implies that firmware is playing
>>> the game overall, so we'll use that to assume that all Thunderbolt ports
>>> should be correctly marked and thus will end up fully protected.
>>>
>>
>> This approach looks generally good to me.  I do worry a little bit about older
>> systems that didn't set ExternalFacingPort in the FW but were previously setting
>> iommu_dma_protection, but I think that those could be treated on a quirk
>> basis to set PCI IDs for those root ports as external facing if/when they come
>> up.
> 
> There are no such systems out there AFAICT.

And even if there are, as above they've never actually been fully 
protected and still won't be, so it's arguably a good thing for them to 
stop thinking so.

>> I'll send up a follow up patch that adds the AMD ACPI table check.
>> If it looks good can roll it into your series for v3, or if this series goes
>> as is for v2 it can come on its own.
>>
>>> CC: Mario Limonciello <mario.limonciello@amd.com>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>
>>> v2: Give up trying to look for specific devices, just look for evidence
>>>      that firmware cares at all.
>>
>> I still do think you could know exactly which devices to use if you're in
>> SW CM mode, but I guess the consensus is to not bifurcate the way this
>> can be checked.
> 
> Indeed.
> 
> The patch looks good to me now. I will give it a try on a couple of
> systems later today or tomorrow and let you guys know how it went. I
> don't expect any problems but let's see.
> 
> Thanks a lot Robin for working on this :)

Heh, let's just hope the other half-dozen or so subsystems I need to 
touch for this IOMMU cleanup aren't all quite as involved as this turned 
out to be :)

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
