Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4977EC433E0
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 02:06:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FDC422509
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 02:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDC422509
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3BBA585A4B;
	Wed, 20 Jan 2021 02:06:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VvgQK9BuS42D; Wed, 20 Jan 2021 02:06:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2B9FB85815;
	Wed, 20 Jan 2021 02:06:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 078DFC088B;
	Wed, 20 Jan 2021 02:06:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 681FCC013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 02:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4DDA186FAA
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 02:06:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Iva-pCmSc5n for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 02:06:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 642B586258
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 02:06:01 +0000 (UTC)
IronPort-SDR: DibvoDDsmxiulp/UInQ+o8Di4tMFTIUA6Seafq1W7ZqiqJJcy6366HQJf/hitIBlpVlYe6iYLS
 yBCllx6kmGBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="175526276"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; d="scan'208";a="175526276"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2021 18:06:00 -0800
IronPort-SDR: W6eM+jIfTZwk0PBH1IIFJWnO3U5jYa/3pifRN/NWz3Ibe/PpfkfPsHjwZ4SUqihavlEC755cX7
 eI+tl5wEn0GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; d="scan'208";a="466917375"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2021 18:05:54 -0800
Subject: Re: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Tian, Kevin" <kevin.tian@intel.com>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-4-jean-philippe@linaro.org>
 <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
 <X/1o72DTmzdCMhDz@myrica>
 <c88e5d74-098d-7f1d-a7bb-a89e40fb8fa4@linux.intel.com>
 <MWHPR11MB18868F53E5A9E0CF9975042B8CA90@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YAB0SHyUZbxprkL3@larix.localdomain>
 <636814a9-7dea-06f6-03ec-6a98dd30b7e3@linux.intel.com>
 <MWHPR11MB188653AF6EFA0E55DE17815F8CA40@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YAaxjmJW+ZMvrhac@myrica>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5e563a0b-e853-bb72-2cec-13c94ab4d554@linux.intel.com>
Date: Wed, 20 Jan 2021 09:57:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YAaxjmJW+ZMvrhac@myrica>
Content-Language: en-US
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "guohanjun@huawei.com" <guohanjun@huawei.com>,
 "will@kernel.org" <will@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "lenb@kernel.org" <lenb@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 David Woodhouse <dwmw2@infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-accelerators@lists.ozlabs.org" <linux-accelerators@lists.ozlabs.org>
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

Hi Jean,

On 1/19/21 6:16 PM, Jean-Philippe Brucker wrote:
> On Mon, Jan 18, 2021 at 06:54:28AM +0000, Tian, Kevin wrote:
>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>> Sent: Saturday, January 16, 2021 11:54 AM
>>>
>>> Hi Jean,
>>>
>>> On 2021/1/15 0:41, Jean-Philippe Brucker wrote:
>>>> I guess detailing what's needed for nested IOPF can help the discussion,
>>>> although I haven't seen any concrete plan about implementing it, and it
>>>> still seems a couple of years away. There are two important steps with
>>>> nested IOPF:
>>>>
>>>> (1) Figuring out whether a fault comes from L1 or L2. A SMMU stall event
>>>>       comes with this information, but a PRI page request doesn't. The
>>> IOMMU
>>>>       driver has to first translate the IOVA to a GPA, injecting the fault
>>>>       into the guest if this translation fails by using the usual
>>>>       iommu_report_device_fault().
>>
>> The IOMMU driver can walk the page tables to find out the level information.
>> If the walk terminates at the 1st level, inject to the guest. Otherwise fix the
>> mm fault at 2nd level. It's not efficient compared to hardware-provided info,
>> but it's doable and actual overhead needs to be measured (optimization exists
>> e.g. having fault client to hint no 2nd level fault expected when registering fault
>> handler in pinned case).
>>
>>>>
>>>> (2) Translating the faulting GPA to a HVA that can be fed to
>>>>       handle_mm_fault(). That requires help from KVM, so another interface -
>>>>       either KVM registering GPA->HVA translation tables or IOMMU driver
>>>>       querying each translation. Either way it should be reusable by device
>>>>       drivers that implement IOPF themselves.
>>
>> Or just leave to the fault client (say VFIO here) to figure it out. VFIO has the
>> information about GPA->HPA and can then call handle_mm_fault to fix the
>> received fault. The IOMMU driver just exports an interface for the device drivers
>> which implement IOPF themselves to report a fault which is then handled by
>> the IOMMU core by reusing the same faulting path.
>>
>>>>
>>>> (1) could be enabled with iommu_dev_enable_feature(). (2) requires a
>>> more
>>>> complex interface. (2) alone might also be desirable - demand-paging for
>>>> level 2 only, no SVA for level 1.
>>
>> Yes, this is what we want to point out. A general FEAT_IOPF implies more than
>> what this patch intended to address.
>>
>>>>
>>>> Anyway, back to this patch. What I'm trying to convey is "can the IOMMU
>>>> receive incoming I/O page faults for this device and, when SVA is enabled,
>>>> feed them to the mm subsystem?  Enable that or return an error." I'm stuck
>>>> on the name. IOPF alone is too vague. Not IOPF_L1 as Kevin noted, since L1
>>>> is also used in virtualization. IOPF_BIND and IOPF_SVA could also mean (2)
>>>> above. IOMMU_DEV_FEAT_IOPF_FLAT?
>>>>
>>>> That leaves space for the nested extensions. (1) above could be
>>>> IOMMU_FEAT_IOPF_NESTED, and (2) requires some new interfacing with
>>> KVM (or
>>>> just an external fault handler) and could be used with either IOPF_FLAT or
>>>> IOPF_NESTED. We can figure out the details later. What do you think?
>>>
>>> I agree that we can define IOPF_ for current usage and leave space for
>>> future extensions.
>>>
>>> IOPF_FLAT represents IOPF on first-level translation, currently first
>>> level translation could be used in below cases.
>>>
>>> 1) FL w/ internal Page Table: Kernel IOVA;
>>> 2) FL w/ external Page Table: VFIO passthrough;
>>> 3) FL w/ shared CPU page table: SVA
>>>
>>> We don't need to support IOPF for case 1). Let's put it aside.
>>>
>>> IOPF handling of 2) and 3) are different. Do we need to define different
>>> names to distinguish these two cases?
>>>
>>
>> Defining feature names according to various use cases does not sound a
>> clean way. In an ideal way we should have just a general FEAT_IOPF since
>> the hardware (at least VT-d) does support fault in either 1st-level, 2nd-
>> level or nested configurations. We are entering this trouble just because
>> there is difficulty for the software evolving to enable full hardware cap
>> in one batch. My last proposal was sort of keeping FEAT_IOPF as a general
>> capability for whether delivering fault through the IOMMU or the ad-hoc
>> device, and then having a separate interface for whether IOPF reporting
>> is available under a specific configuration. The former is about the path
>> between the IOMMU and the device, while the latter is about the interface
>> between the IOMMU driver and its faulting client.
>>
>> The reporting capability can be checked when the fault client is registering
>> its fault handler, and at this time the IOMMU driver knows how the related
>> mapping is configured (1st, 2nd, or nested) and whether fault reporting is
>> supported in such configuration. We may introduce IOPF_REPORT_FLAT and
>> IOPF_REPORT_NESTED respectively. while IOPF_REPORT_FLAT detection is
>> straightforward (2 and 3 can be differentiated internally based on configured
>> level), IOPF_REPORT_NESTED needs additional info to indicate which level is
>> concerned since the vendor driver may not support fault reporting in both
>> levels or the fault client may be interested in only one level (e.g. with 2nd
>> level pinned).
> 
> I agree with this plan (provided I understood it correctly this time):
> have IOMMU_DEV_FEAT_IOPF describing the IOPF interface between device and
> IOMMU. Enabling it on its own doesn't do anything visible to the driver,
> it just probes for capabilities and enables PRI if necessary. For host
> SVA, since there is no additional communication between IOMMU and device
> driver, enabling IOMMU_DEV_FEAT_SVA in addition to IOPF is sufficient.
> Then when implementing nested we'll extend iommu_register_fault_handler()
> with flags and parameters. That will also enable advanced dispatching (1).
> 
> Will it be necessary to enable FEAT_IOPF when doing VFIO passthrough
> (injecting to the guest or handling it with external page tables)?
> I think that would be better. Currently a device driver registering a
> fault handler doesn't know if it will get recoverable page faults or only
> unrecoverable ones.
> 
> So I don't think this patch needs any change. Baolu, are you ok with
> keeping this and patch 4?

It sounds good to me. Keep FEAT_IOPF as the IOMMU capability of
generating I/O page fault and differentiate different I/O page faults by
extending the fault handler register interface.

> 
> Thanks,
> Jean
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
