Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9A922EE6
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 14:02:29 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 8D28F6607187;
	Tue,  1 Aug 2023 15:02:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1690898545;
	bh=O+sOqle7nRll28/FmxMTrTj8mlyOiIx2mIEKBCwzSGA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eoHmMrCkU2nYDXoxwl6GPyQUilti2nJ82i/ts2XxDBgQyKb4hPNwDuIUyLUSiSc8z
	 R0A5XpQtIjU1Qxnm7npVqJ0L60HTMNovgl/DNSe7hLGBeKMbt4gi1Wn78S2rTaMFk2
	 /IycX6R5OfRR2F3ujH3Oi8fKrwtmvWTwbRD9P9BpbauTpIooMAXxcAlSujIK86w57X
	 Ev/wQhrEPZYpwj1ohQlPVqzYHuQzmdef1CXDJGBnI4Q7U2OQA8eR53u3v5eHV7jR+P
	 /fGTEAhrG1+RgBECZ+Zd7hAloPlBzsoPuxwRXoE8ouT1h7DXIAmVjW0ox3q3Yuvi4j
	 oVssdzhph1nKQ==
Message-ID: <9ae6616c-7799-8b0c-eff5-1a30d467fbda@collabora.com>
Date: Tue, 1 Aug 2023 16:02:21 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 2/6] iommu/qcom: Use the asid read from device-tree if
 specified
Content-Language: en-US
To: Will Deacon <will@kernel.org>
Cc: agross@kernel.org, andersson@kernel.org, luca@z3ntu.xyz,
 konrad.dybcio@linaro.org, dmitry.baryshkov@linaro.org, joro@8bytes.org,
 robin.murphy@arm.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, robdclark@gmail.com, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, Marijn Suijten <marijn.suijten@somainline.org>
References: <20230622092742.74819-1-angelogioacchino.delregno@collabora.com>
 <20230622092742.74819-3-angelogioacchino.delregno@collabora.com>
 <20230801134953.GA26253@willie-the-truck>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230801134953.GA26253@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/08/23 15:49, Will Deacon ha scritto:
> On Thu, Jun 22, 2023 at 11:27:38AM +0200, AngeloGioacchino Del Regno wrote:
>> As specified in this driver, the context banks are 0x1000 apart but
>> on some SoCs the context number does not necessarily match this
>> logic, hence we end up using the wrong ASID: keeping in mind that
>> this IOMMU implementation relies heavily on SCM (TZ) calls, it is
>> mandatory that we communicate the right context number.
>>
>> Since this is all about how context banks are mapped in firmware,
>> which may be board dependent (as a different firmware version may
>> eventually change the expected context bank numbers), introduce a
>> new property "qcom,ctx-asid": when found, the ASID will be forced
>> as read from the devicetree.
>>
>> When "qcom,ctx-asid" is not found, this driver retains the previous
>> behavior as to avoid breaking older devicetrees or systems that do
>> not require forcing ASID numbers.
>>
>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>> [Marijn: Rebased over next-20221111]
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 18 +++++++++++++++---
>>   1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> index a503ed758ec3..8face57c4180 100644
>> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> @@ -531,7 +531,8 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>>   	 * index into qcom_iommu->ctxs:
>>   	 */
>>   	if (WARN_ON(asid < 1) ||
>> -	    WARN_ON(asid > qcom_iommu->num_ctxs)) {
>> +	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
>> +	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL)) {
>>   		put_device(&iommu_pdev->dev);
>>   		return -EINVAL;
>>   	}
>> @@ -617,7 +618,8 @@ static int qcom_iommu_sec_ptbl_init(struct device *dev)
>>   
>>   static int get_asid(const struct device_node *np)
>>   {
>> -	u32 reg;
>> +	u32 reg, val;
>> +	int asid;
>>   
>>   	/* read the "reg" property directly to get the relative address
>>   	 * of the context bank, and calculate the asid from that:
>> @@ -625,7 +627,17 @@ static int get_asid(const struct device_node *np)
>>   	if (of_property_read_u32_index(np, "reg", 0, &reg))
>>   		return -ENODEV;
>>   
>> -	return reg / 0x1000;      /* context banks are 0x1000 apart */
>> +	/*
>> +	 * Context banks are 0x1000 apart but, in some cases, the ASID
>> +	 * number doesn't match to this logic and needs to be passed
>> +	 * from the DT configuration explicitly.
>> +	 */
>> +	if (!of_property_read_u32(np, "qcom,ctx-asid", &val))
>> +		asid = val;
>> +	else
>> +		asid = reg / 0x1000;
>> +
>> +	return asid;
> 
> Shouldn't we at least have some error checking here? For example, ensuring
> that the ASIDs are within range, aren't duplicates etc?
> 

The only check that we can perform here for ASID-in-range is

if ((asid * 0x1000 > (mmio_start + mmio_size - 0x1000))
	return -EINVAL;

...as for duplicates, a check can *probably* (surely) be done... but I'm not
sure I have any more time to feed more code to this series from years ago...

> Also, can you elaborate a little more on what sort of ASID-to-Context
> mappings you actually see in practice?
> 

I'm sorry, but not really. The first version of this (including the whole research
that I had to perform to write those patches) is from year 2019, so 4 years ago...

...I don't really remember the full details anymore - if not that all of this was
done because context banks are fixed (and setup by TZ), tz takes an asid number
when trying to perform any operation on the context bank, and there's no way to
reset mappings because everything is protected by the hypervisor (which will fault
and reboot the AP instantly if you try).

Cheers,
Angelo


