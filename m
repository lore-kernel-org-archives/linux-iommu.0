Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE7481AA2
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522332; cv=none; b=hfnnw9ieK1UdfiNkV0mXj02R1/TNByjw/go3ZJmZZWreo1hP29dmLweer6gWLm+ipsSMd9fRxj4tU81mM0E5Fny4GmisFcT71Y7SI7B68z2+XAVn0gVngzrbdFupM8KSh8aEcVsGqe632qOXAWLhcrEetePGjL8UxNfIcSYXgWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522332; c=relaxed/simple;
	bh=RoFMDCUUj62w2tWbiccAzqrlHIyKF0aRDZB8FP8cyts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuWjRVncZ6ObleuRyHyS1CQtJaO/+PyCuSL/FvpekaOlMmDnlQIBQx+sXn4zDgDga0Ol/OZY5do53EktdWFJjt2tJ33HDa/Mc6wsVWUHGtef3IBMXQVE1/lAgGEsNgxOJUAn6t8r2iro78V2IrLZ4c7PQH1qjSL9iqNs5tczSO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I/6K8tSV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PYX55SPE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I/6K8tSV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PYX55SPE"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3TSU2617315
	for <iommu@lists.linux.dev>; Wed, 8 Jul 2026 14:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hO6xcDIc0zi6w0QwroXm/ugLcJogfcgAT7RlRKexx38=; b=I/6K8tSV8Tog1rSx
	QxTgfuz3V4KJuTrPPMd8xzxm2aaI6LUUSzIanf1NQbBAEsalbCXUwg382Rnv3p/a
	jlD5XnZYGzgz8Uq63XhVbDtel8TCA0glGeJp7uDS2/7jzS24G+OzLfripjdAvyUs
	FLlAFqO7Fr/02nlVXF7J7d7Yc//8R67dC1D06wli2yKvt05bnScaZi+H8ZaqYGwp
	W4BNxGV2GnQmaAUIBS9iFVnWhFsGQKOGoAs7QJFDxEy3zArlMLhqu81mxr2WIh49
	rrlcQ5TANwq1woAas9TIzX7YWOK0hKx1eMAwxXKKzh/eZDTNfg6thRCZ+7owT9yy
	0rAePg==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9gqwa3uw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 14:52:10 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6a17dafd042so910085eaf.2
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 07:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783522329; x=1784127129; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hO6xcDIc0zi6w0QwroXm/ugLcJogfcgAT7RlRKexx38=;
        b=PYX55SPEtmgJmYijW3I1pgPl81As17yCkmqZf2OhY8zNGAWfne+AmENWuTbMvfcZJH
         +jBGcMkz+hV70cPYrhsriuOKu/CGmM/OCEU0tFGbP1QOSrUZ4Qs9bdkkN9SADh1iqFFR
         +hddkVnm/S7iE3eVRMQfULdEcOMAXW8rTEMfyhB+2xNkvlx9pdlZPvTsathO9ZFmjdcP
         aDKKoHaHWtrIXs+/qxUwR16AtimtvSuz2HuObvhN5p0tp1txe3vgofeVwjXY8BiJHX6H
         ub8M4Jgr0lI1XfKtTy5ZLg8w3mnZMk7PIOU/+gRMS/9SKJK7YOPdT/W42YVDW5PqNMSt
         kIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783522329; x=1784127129;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hO6xcDIc0zi6w0QwroXm/ugLcJogfcgAT7RlRKexx38=;
        b=YYY/5nRND961jk6h3imCTJ1mE84KWKyXF2rjzNzcivumRyOiKV8qZHsHBI0x87fmez
         JLzHnsnrTf7LwLx3/xUZSPLdCuw8j7H3haDoNb/0mZEH+vrEn9x6B3H2iivssGsjYUlO
         jA+zMjq+ZiGASVQVQDyKIPJ0Wzq9nKXi9omSOiwNMpZNrJ9D87fQHtflbKEldD6O5N3m
         h+qu05Xr7AYE/+Rqe9MqK1+h56oisF6YUkhWqJ76B7QX9F+J8Viwj3WRqO6GTyitA56V
         mC0gwszac6T5BKmMhF8NxQ/lQFxy/FBB75+PrM5nQ6KzRjwRB0o0wwwlhwXkJuLwWWU0
         uiUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/mLgK9HxkMqhfmEQoQrd9joipwjGgfyFfc0/qOuGhLdI6WVewNDB14UkugCskdLhyzGY5jAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRLPDv9O47l+tcxCwA4EVBwop9WFGzUv+HSaI+hUmwvjvNUKkQ
	Plf89H5i2eOUIWWHEStgJBBNrI1sDb11KNj5SqRJcz6SH/lHlxRDQifDOdt8dy3k5Vw+Yy1U0mA
	XsienQOdCYHhy57r+GLNHp1SZpVCQlLhe7asZyLiizfb3BwakiPQNwfjQXQa1eD7EQA==
X-Gm-Gg: AfdE7ckkayolXGY8S5OWH0nmHZE+MhrsSpQWQIZwp6Yj8vwYOFXA+2HvtfrDjnnDCR2
	0WYL4vEAP9XcLxsB6/wenvTeQ+dJzu9m3OcawvZFNlk04JLfF3k+pG4dXkQmU7pyzudMUz9XCdf
	EeXTsxSZssWGJdJAOIZkj3V63hFomHTONwercbwJykjXQLYQVqxvpqB0xEWlUFwHGuAi58Ml3eZ
	jVFEbgMTMghBXqb6Jjdltclzo0vUM6afygNfFP52+tvPFHG0ZvIp8tbaJxxVHYkqYcyPVXZoUqH
	3lBnyynF6agXKyfQDJ1khrQg1JPLxiTHnpdpXJQeYECG9ank/aj8FgKQdJrPidwZhe3Yv7mH29R
	3KeNXHR4PcuHVER9n/XFsgZLNSSM09c6C/1+qJ6Q=
X-Received: by 2002:a05:6820:20e:b0:6a3:21bb:17b with SMTP id 006d021491bc7-6a36da17682mr1672817eaf.58.1783522329613;
        Wed, 08 Jul 2026 07:52:09 -0700 (PDT)
X-Received: by 2002:a05:6820:20e:b0:6a3:21bb:17b with SMTP id 006d021491bc7-6a36da17682mr1672782eaf.58.1783522328951;
        Wed, 08 Jul 2026 07:52:08 -0700 (PDT)
Received: from [10.219.56.198] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb13d624sm16831050fac.1.2026.07.08.07.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 07:52:08 -0700 (PDT)
Message-ID: <4e266d45-ee88-42f8-91da-6253927686ae@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 20:22:00 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: iommu: arm,smmu: Document
 interconnects property
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <phlk6zsxr7szdadsvgoecf7ewcqjkuaj5aeqmfqa4uvvvvnsmj@57u2pofxewuh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0NiBTYWx0ZWRfX9xrebNQ51oIu
 JqkyS+wATdRzhTcwcg8Ol63LAjwb4IIr143IMQ0SyhxpcUQ6CMP3sGhvST6wgltQ6QQOaj2u80P
 DPDfsE02yGuZ8D2pD7ncIK3br0Hae4snzlikwIESCsC7Hu0CCr2s6srtMuPJr+2khcxeD3yRfcM
 FMnCfTv+D46dSnBv+MLApFpaDg9PzdTVRAdYdKe/ehi9ynT8LBrv7W8GmfF6bFDgXVuJXStMnma
 0kasIjT/N9pynw8r3EVtFgPAK66MTIeu5z+SOy8QwAHofp5kSoWzYe58z4dciC6ioKJKqunr1O6
 gxA2SCDVjPieIflgRLXvgsGANQvHt3JOa0WYXfjvk8o1VAoUYKyqcYvrvdp5LYRKrLuEsxvicpz
 uNBVQElMW2tUVeomIX5BGQwoLF0M95UGNvptNJVXlwVOx7T3Khv7i4jIvvXiMQka/58QDOFiNDT
 RYaohl9DIlwlmGuXi1A==
X-Proofpoint-GUID: irsZThAaea2s9H14kax15DXoW6UpPRqd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0NiBTYWx0ZWRfX341J/JZ5/+Ne
 80Pm9N1+bj7F4Up8HbpB02HQqj3Kh7duXDs1whqeq2l29L3xv6FNPUa3+Ek79Pl4HF5js8CS1ok
 fP87D9EUcamCjIURnuhL+sa30M3lHDE=
X-Proofpoint-ORIG-GUID: irsZThAaea2s9H14kax15DXoW6UpPRqd
X-Authority-Analysis: v=2.4 cv=Wf88rUhX c=1 sm=1 tr=0 ts=6a4e641a cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=6nhsP2hVHzjk3Kom7RcA:9 a=QEXdDO2ut3YA:10
 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080146



On 7/7/2026 10:12 PM, Dmitry Baryshkov wrote:
> On Tue, Jul 07, 2026 at 06:06:59PM +0530, Bibek Kumar Patro wrote:
>>
>>
>> On 7/6/2026 11:09 PM, Dmitry Baryshkov wrote:
>>> On Mon, Jul 06, 2026 at 10:26:34PM +0530, Bibek Kumar Patro wrote:
>>>> Some SoC implementations require a bandwidth vote on an interconnect
>>>> path before the SMMU register space is accessible. Add the optional
>>>
>>> Why is it limited only to those SoCs? Is it also applicable to other
>>> Qualcomm SoCs?
>>>
>>
>> I was hoping to keep this series focused on the core infrastructure
>> changes: the bindings, base ICC bandwidth-voting support, and DT
>> interconnect properties for the platforms currently supported on
>> Qualcomm Linux and have been validated so far.
>>
>> The additional targets have not been tested yet, so I'd prefer
>> to add their support in a separate follow-up series once validation
>> is complete, rather than growing this series further. WDYT?
> 
> Then it should be a part of the commit message. All SoCs since SDM12345
> need to vote on the interconnect (and then, in the cover letter mention
> that you convert only a few of the SoCs). We possibly can help with
> testing on other platforms.
> 

Ack, sounds reasonable.
I'll add the first platform onwards which interconnect voting is 
required in commit description.
And update the cover letter to clarify that this series adds
support for the Qualcomm Linux-supported targets available today, and
the list will be expanded in follow-up series as additional platforms
are enabled.

Thanks & regards,
Bibek

>>>> 'interconnects' property to the binding to allow platform DT nodes
>>>> to describe this path.
>>>>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>> ---
>>>>    .../devicetree/bindings/iommu/arm,smmu.yaml        | 27 ++++++++++++++++++++++
>>>>    1 file changed, 27 insertions(+)
>>>>
> 

