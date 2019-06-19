Return-Path: <SRS0=+KpI=US=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BB4C31E49
	for <iommu@archiver.kernel.org>; Wed, 19 Jun 2019 11:54:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FE620665
	for <iommu@archiver.kernel.org>; Wed, 19 Jun 2019 11:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FE620665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D908B11FB;
	Wed, 19 Jun 2019 11:54:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7AD8411F3
	for <iommu@lists.linux-foundation.org>;
	Wed, 19 Jun 2019 11:54:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 251467C
	for <iommu@lists.linux-foundation.org>;
	Wed, 19 Jun 2019 11:54:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89DB6360;
	Wed, 19 Jun 2019 04:54:16 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71F893F738;
	Wed, 19 Jun 2019 04:56:01 -0700 (PDT)
Subject: Re: [PATCH 3/8] iommu/arm-smmu-v3: Support platform SSID
To: Will Deacon <will.deacon@arm.com>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
	<20190610184714.6786-4-jean-philippe.brucker@arm.com>
	<20190618180851.GK4270@fuggles.cambridge.arm.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <73cfb797-5ae7-b9d9-01ea-fe98a1bed5c3@arm.com>
Date: Wed, 19 Jun 2019 12:53:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618180851.GK4270@fuggles.cambridge.arm.com>
Content-Language: en-US
Cc: Mark Rutland <Mark.Rutland@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Robin Murphy <Robin.Murphy@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 18/06/2019 19:08, Will Deacon wrote:
>> +	/*
>> +	 * If the SMMU doesn't support 2-stage CD, limit the linear
>> +	 * tables to a reasonable number of contexts, let's say
>> +	 * 64kB / sizeof(ctx_desc) = 1024 = 2^10
>> +	 */
>> +	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
>> +		master->ssid_bits = min(master->ssid_bits, 10U);
> 
> Please introduce a #define for the 10, so that it is computed in the way
> you describe in the comment (a bit like we do for things like queue sizes).

Ok

>> +
>>  	group = iommu_group_get_for_dev(dev);
>>  	if (!IS_ERR(group)) {
>>  		iommu_group_put(group);
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index f04a6df65eb8..04f4f6b95d82 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -206,8 +206,12 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>>  			if (err)
>>  				break;
>>  		}
>> -	}
>>  
>> +		fwspec = dev_iommu_fwspec_get(dev);
>> +		if (!err && fwspec)
>> +			of_property_read_u32(master_np, "pasid-num-bits",
>> +					     &fwspec->num_pasid_bits);
>> +	}
> 
> Hmm. Do you know if there's anything in ACPI for this?

Yes, IORT version D introduced a "substream width" field for the Named
component node (platform device). I don't think it existed last time I
checked, so I'll see about supporting it.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
