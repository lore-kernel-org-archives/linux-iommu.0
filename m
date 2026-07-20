Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962013B14DE
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556725; cv=none; b=LzFSvXjDS7Z4pfCOQXtokGZjgdt3siieUqJ+Aqw9CILpZfKfAocy4vL2EasSxJTPzrtdsyVzYD1kuSs8phAIWTkci7SJUSExmwrNnf1fIY4EROz59pLcKqfIwPek3l90gXv3AwW8xo7qukdjWYlDqnu5OnpOHX0TF//020eEeB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556725; c=relaxed/simple;
	bh=CrusvQrBASBFhooN+pfdEkfPmD79gBrBLgltXL1IqQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ef9nDiRkX/YmKOQHO48hHLZIoh3FZMt0tq1MGhE3yHADUWDDtHHa0tWXDvQIaiGe4PO2jDS2WhS/WYsqrx0aFwSek0FY50qKNQ5VPq8tszo5CKq8JYRsvVATkc6nzOQkECQtNBDRkKuEmYpVfne3EkGnQU/0p9xz5c911WqLs38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MgerdfAG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ae8YqpRi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MgerdfAG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ae8YqpRi"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KDrA3X2501709
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 14:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IFbXZVYlpWFB+86AR3x1jH6JDJM2yKuesn95gcq6Bt8=; b=MgerdfAGT8P4AsIY
	Bb7+lF6ar+WGa3Xv8UPRLAtbfgAI/6Ay7vu4wY8upS/JK5Sa4OIcHGWZO/LmPp0k
	PADPqEm1K7t+R5eprqmKKggHeDeSa53LKG2MLyxAs0/FUqGMOCsuYtxn4FkbrXzI
	zmiICvyIcNsfmP6ZlurHvwAOL4qtRJobKmZRaS1f9yLlpu3CrZpcasDVXaIiCTfK
	6EfQNPZFVKokSQ7lcV9W5Ok46nfJaXR7ADHgw4qM5OmhoYwIx6FuzhrK1raFem3J
	TzKdTl6gu/FyBHhh2CR6PO9dZ+0Rf9UkFaBg3yU2yHJLFjoNkvwdwYnB2VZlm/3Z
	R3ul/Q==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhh5y1666-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 14:12:03 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4a416619e8dso6995122b6e.1
        for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784556723; x=1785161523; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IFbXZVYlpWFB+86AR3x1jH6JDJM2yKuesn95gcq6Bt8=;
        b=Ae8YqpRid+nIq416YoWE/D3XZYFmog94CB0ggT4k9GbaVPqoG+oBZX4EyZradnLk7/
         NQtm0c5+PGF4qr+01JnfNib6PdGjzfoaR8Q2CfIPB4c1Kut4GojSukc9W1weo1ROOBP6
         o2m0Njsju2RYAmygcBkdNkUwozNNpQ6zESMfatETdTwQTuegLm0JLqoegcLv23EcfLn3
         bpQUc9yDDDhp0kBr9NqjDYUOA4EdD1UqOSCr3HUzs4NUeEcby/hC+b4uPigKjy+LMKoP
         c2IbRO3yQ/5nXZG5oLnCVbXOewlllNUXadxMAx1Bt1yUqSpkhu4RqbBpLDeZCvsY/T7J
         W4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784556723; x=1785161523;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IFbXZVYlpWFB+86AR3x1jH6JDJM2yKuesn95gcq6Bt8=;
        b=DQvv4plBpr0o/j7JGZ7MYI4GndErFUWeZqbfbdcIJdCUIT0yz93oCVF8EQBBQNsxJN
         XSQrAQHaYa4RYC6Jy8z4T72Ky+FWpaOsVUAC6nFBPTFsaSz8I7j7X6cHTokQSGG9AxIt
         26RwKBd7HZS7hdem3k2AJlD6E5E6cZz+7izLXPwY8l+HFnK1IiOX3d5M26pFiIhfmT+k
         LJjpEBc/DExg14zNLWFkChi6mDDs1McvccvYoAgxArGGM43/XibSEIkzxhGIaroZRkCJ
         HCNOyuP4aEbM4vmlnoULe0ad+toDXG29/Jx8ujM54buaVY/xMFSYvSoDMY5/z2CcJZtv
         AiuA==
X-Forwarded-Encrypted: i=1; AHgh+RqiOj3BRWabSHwaRqzGOfaRUz6JeDOxABk0oK0RPs96NJcUfEgZMAwCZyVRerDqI9CGzcPDzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5CSeN6XptreaPfmKXn2bT2nTxLPxIMZ53h95mWaHEN2XXAdjk
	VOsCy3lYFNtl6LMJY+fFC7WPD12fc6KkuPB2tmp6IHPlQOgkqTZ7tpD2z4SPDsAUTKNs5JuuS83
	t53U1TsOZmGgT+R1rrcggMmnk/VNqaMqqcVNiJZz4ZT+/eegi6Xumqc9pdA==
X-Gm-Gg: AfdE7cnJsdayI53M2hYEo05Vk5YLm4V29sc1Xoy5wUbh/pgWSPxAa8PQ9kanWIwM4a7
	OvUeXuk2MSYtz0UPkrrYgs6yF3z3nR9A3k9SEWEwc0FOVq4xikcA2dL1FTq7Xgfqh2cXnkyLI50
	NsffV5NDZyDjI8XQdTt9THS+BWtfvPokgihmsP+TLZkpQ82Bt7rTA6+TXH6qN1YWA5sku3p8q5z
	ltzo5GzqWAr6Q46nmvNBSfocg6Lc8VGwbsgNK7307TnUwwvKLyoky9ELLxbF7LSs/7/4bq7devt
	yQdiCxws9ryzugwxcvw6K5GGIgWmgvmWg9Vkxxo+0KesRf8LiJLwF0DyCmptVxygiycWjhEJ/Od
	1dpaPpTrz7LwSiTW9wemu5ae+iA8I
X-Received: by 2002:a05:6808:c3cb:b0:495:fa67:7496 with SMTP id 5614622812f47-4a4cf26bb93mr7248855b6e.14.1784556722670;
        Mon, 20 Jul 2026 07:12:02 -0700 (PDT)
X-Received: by 2002:a05:6808:c3cb:b0:495:fa67:7496 with SMTP id 5614622812f47-4a4cf26bb93mr7248832b6e.14.1784556722182;
        Mon, 20 Jul 2026 07:12:02 -0700 (PDT)
Received: from [10.218.33.224] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a4d3d36340sm7497247b6e.16.2026.07.20.07.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 07:12:01 -0700 (PDT)
Message-ID: <9f31bf3d-3c7d-45ba-bc25-e6349f689b70@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 19:41:35 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: iommu: arm,smmu: Document
 interconnects property
To: Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
 <20260706-smmu_interconnect_addition-v3-1-afdca0125a65@oss.qualcomm.com>
 <nrht4irqtvt2vk3lrqvljonarc4kanht2nrwjt7pppsfhozffv@o4xei47l6gcj>
 <e8b247d9-d60d-497f-a831-a9772d27481a@oss.qualcomm.com>
 <phlk6zsxr7szdadsvgoecf7ewcqjkuaj5aeqmfqa4uvvvvnsmj@57u2pofxewuh>
 <4e266d45-ee88-42f8-91da-6253927686ae@oss.qualcomm.com>
 <ak5pC_meP8KRc3wJ@baldur>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <ak5pC_meP8KRc3wJ@baldur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE1OCBTYWx0ZWRfX7gB/TkdFhzhx
 y6IgaIx8UWEVCcORPzE2cDP4XwiWb6/11k+0jzm9Z2CRuwQGPBVmdiDQucKmC0RTc1GCV79VPlt
 W/VpL/4epLRZrM2bT6OyV91SpIiFPak=
X-Proofpoint-GUID: tsopuIkJkfww5XxX-1Fym9vjI98x-nsC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE1OCBTYWx0ZWRfXyP0Na5JsThm7
 V2SaEjg73wcBACoIIj2RuTChTIBB0oWo+HSUA2W45ieWEdi+BidirPAS4cBKRucIZVXbADXrhLd
 /Fqmjov0a7oA+W5W8iJKJDRt38sxA7lkekXSGIKo+u33SfDyoptGtz1snQa1FMz98Zz6fq2nxPn
 dJk+JQFBDwj8pKkd/XzT4Nrjkj++8nln48lMBIF9aIOkFW3GX0u0qgXvOPGiL4xP1x5ixUCsPnm
 5A1kmSJ2SutA16cO3Ts+mSF6h54iaIxv+puyTGoKllaQkHeHKjhLm+lqCd8Cf6XX1UIhwRzboRs
 SJKyY+cFBVEPx2ULwvXIBuLJk0W83tQs37Sl/6lh8n+UuTf6H5xPekCoxM9Fasyl/bH+GYiwOmQ
 RnKIQMeCKBZI4JtAQY8GRQeRodKS1RzAj4CFTz/dcESI5MS71Z3d+9HJZcPSruqj+qC7YF56Grh
 COuvN2B1RA8P5D7Y3eA==
X-Proofpoint-ORIG-GUID: tsopuIkJkfww5XxX-1Fym9vjI98x-nsC
X-Authority-Analysis: v=2.4 cv=f/x4wuyM c=1 sm=1 tr=0 ts=6a5e2cb3 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=fPhLyPd3YuFPpQYp6doA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200158



On 7/8/2026 8:48 PM, Bjorn Andersson wrote:
> On Wed, Jul 08, 2026 at 08:22:00PM +0530, Bibek Kumar Patro wrote:
>>
>>
>> On 7/7/2026 10:12 PM, Dmitry Baryshkov wrote:
>>> On Tue, Jul 07, 2026 at 06:06:59PM +0530, Bibek Kumar Patro wrote:
>>>>
>>>>
>>>> On 7/6/2026 11:09 PM, Dmitry Baryshkov wrote:
>>>>> On Mon, Jul 06, 2026 at 10:26:34PM +0530, Bibek Kumar Patro wrote:
>>>>>> Some SoC implementations require a bandwidth vote on an interconnect
>>>>>> path before the SMMU register space is accessible. Add the optional
>>>>>
>>>>> Why is it limited only to those SoCs? Is it also applicable to other
>>>>> Qualcomm SoCs?
>>>>>
>>>>
>>>> I was hoping to keep this series focused on the core infrastructure
>>>> changes: the bindings, base ICC bandwidth-voting support, and DT
>>>> interconnect properties for the platforms currently supported on
>>>> Qualcomm Linux and have been validated so far.
>>>>
>>>> The additional targets have not been tested yet, so I'd prefer
>>>> to add their support in a separate follow-up series once validation
>>>> is complete, rather than growing this series further. WDYT?
>>>
>>> Then it should be a part of the commit message. All SoCs since SDM12345
>>> need to vote on the interconnect (and then, in the cover letter mention
>>> that you convert only a few of the SoCs). We possibly can help with
>>> testing on other platforms.
>>>
>>
>> Ack, sounds reasonable.
>> I'll add the first platform onwards which interconnect voting is required in
>> commit description.
> 
> But to what degree is this related to a specific set of platforms? If we
> look ahead, aren't we expecting the list to grow to include all
> platforms in the end - resulting in a lot of noise and churn.
> 

We have seen this issue consistently on SM8750 and later platforms, 
along with at least one customer-reported instance on SM8550. As a 
result, downstream Android implementations already vote for the required 
interconnect bandwidth explicitly on these platforms.

On Qualcomm Linux targets, we have observed similar issues on Kodiak, 
with a few occurrences on Talos as well.

My understanding is that the interconnects property remains optional, 
but in practice it is needed for Adreno SMMU operation on these platforms.

> Can you give an example of a platform where there is no interconnect
> path to vote for here or where it would be harmful to do so?
> 

I do not anticipate any functional issues or side effects from
explicitly voting for the interconnect on Qualcomm platforms where the 
path exists.


>> And update the cover letter to clarify that this series adds
>> support for the Qualcomm Linux-supported targets available today, and
>> the list will be expanded in follow-up series as additional platforms
>> are enabled.
>>
> 
> The binding should not reflect what has been implemented and verified in
> Linux, it defines the contract between DeviceTree and the OS.
> 

Since the property is optional, would it be necessary to add in AllOf
the list of compatible for which the property hasn't been added yet, or 
for the compatibles where it is added?

Thanks & regards,
Bibek

> Regards,
> Bjorn
> 
>> Thanks & regards,
>> Bibek
>>
>>>>>> 'interconnects' property to the binding to allow platform DT nodes
>>>>>> to describe this path.
>>>>>>
>>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>>>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>>>> ---
>>>>>>     .../devicetree/bindings/iommu/arm,smmu.yaml        | 27 ++++++++++++++++++++++
>>>>>>     1 file changed, 27 insertions(+)
>>>>>>
>>>
>>

