Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59178C433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 15:45:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 061BF61351;
	Thu, 21 Apr 2022 15:45:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sDOSyJjjciKS; Thu, 21 Apr 2022 15:45:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CE9A56135C;
	Thu, 21 Apr 2022 15:45:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E2DFC0033;
	Thu, 21 Apr 2022 15:45:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E25E9C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 15:45:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF5106135C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 15:45:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CCSRr3c6hRby for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 15:45:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id E0BE861351
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 15:45:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D754B1516;
 Thu, 21 Apr 2022 08:45:42 -0700 (PDT)
Received: from [10.57.41.251] (unknown [10.57.41.251])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A455D3F73B;
 Thu, 21 Apr 2022 08:45:39 -0700 (PDT)
Message-ID: <4c3cce25-cd40-092f-5316-e5c5d3adbcc6@arm.com>
Date: Thu, 21 Apr 2022 16:45:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 0/9] ACPI/IORT: Support for IORT RMR node
Content-Language: en-GB
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Steven Price <steven.price@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
 <b75dd20c-24b9-7944-bfb7-9f102623e725@arm.com>
 <78cd48d112b144b69bcc498748c584e3@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <78cd48d112b144b69bcc498748c584e3@huawei.com>
Cc: "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "hch@infradead.org" <hch@infradead.org>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "will@kernel.org" <will@kernel.org>, wanghuiqiang <wanghuiqiang@huawei.com>
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

On 2022-04-21 15:43, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Steven Price [mailto:steven.price@arm.com]
>> Sent: 21 April 2022 13:59
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
>> joro@8bytes.org; robin.murphy@arm.com; will@kernel.org; wanghuiqiang
>> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
>> <guohanjun@huawei.com>; Sami.Mujawar@arm.com; jon@solid-run.com;
>> eric.auger@redhat.com; laurentiu.tudor@nxp.com; hch@infradead.org
>> Subject: Re: [PATCH v10 0/9] ACPI/IORT: Support for IORT RMR node
>>
>> On 20/04/2022 17:48, Shameer Kolothum wrote:
>>> Hi
>>>
>>> v9 --> v10
>>>   - Dropped patch #1 ("Add temporary RMR node flag definitions") since
>>>     the ACPICA header updates patch is now in the mailing list[1]
>>>   - Based on the suggestion from Christoph, introduced a
>>>     resv_region_free_fw_data() callback in struct iommu_resv_region and
>>>     used that to free RMR specific memory allocations.
>>>
>>> Though there is a small change from v9 with respect to how we free up
>>> the FW specific data, I have taken the liberty to pick up the R-by and
>>> T-by tags from Lorenzo, Steve and Laurentiu. But please do take a look
>>> again and let me know.
>>
>> I've given this a go and it works fine on my Juno setup. So do keep my
>> T-by tag.
> 
> Many thanks for that.
> 
>> Sami has been kind enough to give me an updated firmware which also
>> fixes the RMR node in the IORT. Although as mentioned before the details
>> of the RMR node are currently being ignored so this doesn't change the
>> functionality but silences the warning.

Strictly they're not ignored, you just won't be getting past the point 
where they're not entirely not ignored. It'll appear to work because 
arm_smmu_rmr_install_bypass_smr() just bypasses the whole stream until 
the actual device turns up to join up to the StreamID and the "real" 
processing of RMRs happens via iommu_create_device_direct_mappings() - 
if there's no actual HDLCD device described in the DSDT, that will never 
happen, and even if there is, chances are that things will currently 
happen in the wrong order such we'd end up waiting to replay 
iommu_probe_device() from acpi_iommu_configure_id() once a driver binds, 
and *that* definitely can't happen without teaching the HDLCD driver 
about ACPI.

>> My concern is that with the RMR region effectively ignored we may see
>> more broken firmware, and while a length of zero produces a warning, an
>> otherwise incorrect length will currently "silently work" but mean that
>> any future tightening would cause problems. For example if the SMMU
>> driver were to recreate the mappings to only cover the region specified
>> in the RMR it may not be large enough if the RMR base/length are not
>> correct.
> 
> Not sure how we can further validate the RMR if the firmware provides an
> incorrect one. I see your point of future tightening causing problems
> with broken firmware. But then it is indeed a "broken firmware"...
> 
>   It's up to the maintainers as to whether they see this as a
>> problem or not.
> 
> Hi Robin,
> 
> Any thoughts on this?

In general we can't second-guess firmware. Even a zero-length RMR should 
have ample opportunity to blow up outside this one corner case where 
Linux never gets to associate the StreamID with a corresponding device.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
