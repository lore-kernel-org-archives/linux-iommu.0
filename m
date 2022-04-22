Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F8CC433EF
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 19:02:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DD9F41C87;
	Fri, 22 Apr 2022 19:02:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id foD4Qn1qteQy; Fri, 22 Apr 2022 19:02:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1BF4241C69;
	Fri, 22 Apr 2022 19:02:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C67ECC0039;
	Fri, 22 Apr 2022 19:02:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99D43C002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 19:02:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F04041C69
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 19:02:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xznV8xJvKVFJ for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 19:02:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4706941BC5
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 19:02:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D2B21FB;
 Fri, 22 Apr 2022 12:02:21 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CDF43F73B;
 Fri, 22 Apr 2022 12:02:18 -0700 (PDT)
Message-ID: <9da468bc-e6fd-1d7c-a6ce-69be87a7472a@arm.com>
Date: Fri, 22 Apr 2022 20:02:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
Content-Language: en-GB
To: Krishna Reddy <vdumpa@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "will@kernel.org" <will@kernel.org>
References: <cover.1649935679.git.robin.murphy@arm.com>
 <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
 <PH0PR12MB56475FAF4A2E7DB0AE1C1217B3F79@PH0PR12MB5647.namprd12.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <PH0PR12MB56475FAF4A2E7DB0AE1C1217B3F79@PH0PR12MB5647.namprd12.prod.outlook.com>
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>
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

On 2022-04-22 19:37, Krishna Reddy wrote:
> Good effort to isolate bus config from smmu drivers.
> Reviewed-By: Krishna Reddy <vdumpa@nvidia.com>

Thanks!

> I have an orthogonal question here.
> Can the following code handle the case, where different buses have different type of SMMU instances(like one bus has SMMUv2 and another bus has SMMUv3)?
> If it need to handle the above case, can the smmu device bus be matched with specific bus here and ops set only for that bus?

Not yet, but that is one of the end goals that this is all working 
towards. I think the stuff that I've added to the dev branch[1] today 
should have reached the point where that becomes viable, but I'll need 
to rig up a system to test it next week.

Intermediate solutions aren't worth it because in practice you 
inevitably end up needing both IOMMU drivers to share the platform "bus" 
anyway.

Cheers,
Robin.

[1] https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/bus

> 
> 
>> +       for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
>> +               struct bus_type *bus = iommu_buses[i];
>> +               const struct iommu_ops *bus_ops = bus->iommu_ops;
>> +               int err;
>> +
>> +               WARN_ON(bus_ops && bus_ops != ops);
>> +               bus->iommu_ops = ops;
>> +               err = bus_iommu_probe(bus);
>> +               if (err) {
>> +                       bus_for_each_dev(bus, NULL, iommu,
>> remove_iommu_group);
>> +                       bus->iommu_ops = bus_ops;
>> +                       return err;
>> +               }
>> +       }
> 
> 
> -KR
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
