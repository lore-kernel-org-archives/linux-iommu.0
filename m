Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1C7C43217
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 14:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFE0660FC6;
	Tue, 15 Feb 2022 14:29:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RaESWm1ipEoY; Tue, 15 Feb 2022 14:29:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BACE860FBD;
	Tue, 15 Feb 2022 14:29:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B82AC001A;
	Tue, 15 Feb 2022 14:29:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEB88C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 14:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ACDE2415F8
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 14:29:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jc4VrpWtnO_C for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 14:29:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9BCC6415F6
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 14:29:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78DC11396;
 Tue, 15 Feb 2022 06:29:36 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 327793F718;
 Tue, 15 Feb 2022 06:29:32 -0800 (PST)
Message-ID: <161e5005-ea12-fde4-0e31-ec871d2fe591@arm.com>
Date: Tue, 15 Feb 2022 14:29:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 8/8] iommu/arm-smmu-v3: Make default domain type of
 HiSilicon PTT device to identity
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-9-yangyicong@hisilicon.com>
 <e58888c1-5448-77c7-7f6c-f5db999a888f@huawei.com>
 <20220215130044.GA7154@willie-the-truck>
 <9018a1d9-4d42-3a99-dbc6-c55139abcb1e@arm.com>
 <20220215134232.GA7592@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220215134232.GA7592@willie-the-truck>
Cc: mark.rutland@arm.com, prime.zeng@huawei.com,
 alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
 linuxarm@huawei.com, Yicong Yang <yangyicong@hisilicon.com>,
 daniel.thompson@linaro.org, peterz@infradead.org, mingo@redhat.com,
 helgaas@kernel.org, liuqi115@huawei.com, mike.leach@linaro.org,
 suzuki.poulose@arm.com, coresight@lists.linaro.org, acme@kernel.org,
 zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 mathieu.poirier@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 iommu@lists.linux-foundation.org, leo.yan@linaro.org,
 Yicong Yang <yangyicong@huawei.com>
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

On 2022-02-15 13:42, Will Deacon wrote:
> On Tue, Feb 15, 2022 at 01:30:26PM +0000, Robin Murphy wrote:
>> On 2022-02-15 13:00, Will Deacon wrote:
>>> On Mon, Feb 14, 2022 at 08:55:20PM +0800, Yicong Yang wrote:
>>>> On 2022/1/24 21:11, Yicong Yang wrote:
>>>>> The DMA of HiSilicon PTT device can only work with identical
>>>>> mapping. So add a quirk for the device to force the domain
>>>>> passthrough.
>>>>>
>>>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>>>> ---
>>>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++++
>>>>>    1 file changed, 16 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> index 6dc6d8b6b368..6f67a2b1dd27 100644
>>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> @@ -2838,6 +2838,21 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
>>>>>    	}
>>>>>    }
>>>>> +#define IS_HISI_PTT_DEVICE(pdev)	((pdev)->vendor == PCI_VENDOR_ID_HUAWEI && \
>>>>> +					 (pdev)->device == 0xa12e)
>>>>> +
>>>>> +static int arm_smmu_def_domain_type(struct device *dev)
>>>>> +{
>>>>> +	if (dev_is_pci(dev)) {
>>>>> +		struct pci_dev *pdev = to_pci_dev(dev);
>>>>> +
>>>>> +		if (IS_HISI_PTT_DEVICE(pdev))
>>>>> +			return IOMMU_DOMAIN_IDENTITY;
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>>    static struct iommu_ops arm_smmu_ops = {
>>>>>    	.capable		= arm_smmu_capable,
>>>>>    	.domain_alloc		= arm_smmu_domain_alloc,
>>>>> @@ -2863,6 +2878,7 @@ static struct iommu_ops arm_smmu_ops = {
>>>>>    	.sva_unbind		= arm_smmu_sva_unbind,
>>>>>    	.sva_get_pasid		= arm_smmu_sva_get_pasid,
>>>>>    	.page_response		= arm_smmu_page_response,
>>>>> +	.def_domain_type	= arm_smmu_def_domain_type,
>>>>>    	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>>>>>    	.owner			= THIS_MODULE,
>>>>>    };
>>>>>
>>>>
>>>> Is this quirk ok with the SMMU v3 driver? Just want to confirm that I'm on the
>>>> right way to dealing with the issue of our device.
>>>
>>> I don't think the quirk should be in the SMMUv3 driver. Assumedly, you would
>>> have the exact same problem if you stuck the PTT device behind a different
>>> type of IOMMU, and so the quirk should be handled by a higher level of the
>>> stack.
>>
>> Conceptually, yes, but I'm inclined to be pragmatic here. Default domain
>> quirks could only move out as far as the other end of the call from
>> iommu_get_def_domain_type() - it's not like we could rely on some flag in a
>> driver which may not even be loaded yet, let alone matched to the device.
>> And even then there's an equal and opposite argument for why the core code
>> should have to maintain a list of platform-specific quirks rather than code
>> specific to the relevant platforms. The fact is that a HiSilicon RCiEP is
>> not going to end up behind anything other than a HiSilicon IOMMU, and if
>> those ever stop being SMMUv3 *and* such a quirk still exists we can worry
>> about it then.
> 
> Perhaps, but you know that by adding this hook it's only a matter of time
> before we get random compatible string matches in there, so I'd rather keep
> the flood gates closed as long as we can.
> 
> Given that this is a PCI device, why can't we have a PCI quirk for devices
> which require an identity mapping and then handle that in the IOMMU core?

Oh, don't think I *like* having quirks in the driver, it just seems like 
the least-worst choice from a bad bunch. All of the default domain 
quirks so far (including this one) exist for integrated devices and/or 
dodgy firmware setups such that they are platform-specific, so there is 
no technical reason for trying to split *some* of them off into a 
generic mechanism when the driver-based platform-specific mechanism 
still needs to exist anyway (some of them do depend on driver state as 
well).

Feel free to test the waters with a patch punting 
qcom_smmu_def_domain_type() to core code, but I think you'll struggle to 
find a reason to give in the commit message other than "I don't like it".

>> Ugly as it is, this is the status quo. I don't recall anyone ever arguing
>> that the equivalent quirks for Intel integrated graphics should be made
>> generic ;)
> 
> I don't know anything about Intel integrated graphics. Have they solved this
> problem in a better way, or could they equally make use of a generic quirk?

See intel-iommu's device_def_domain_type() implementation. The shape of 
it may seem quite familiar...

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
