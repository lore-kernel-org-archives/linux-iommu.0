Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598283B895D
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561635; cv=none; b=AUdIYv68GYvxTiJPi/K4Qcom4i/0tPpKvIS7dFkQngLDsS8v69xzMo8XeEk4r+qzEFYQ4CXi4a0AaPJRa5WMePdRpMDUlMtSnwtK3ev7oqcvS7E0eeEIwihgwUYqYj85NMeEgXPICIItmTgtaRAuFn5ANmA4TUVTQNbE8DxuyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561635; c=relaxed/simple;
	bh=RcXwqXfS7Q5UFVrsfUc/MKGMCy848BRRPAW+m1ka48E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHe860OZOqcPHwzlei3/MHc2pTCj35yOS9hCpPyVI59yXuZJfqmW6VRkF7oZsy8kEXGUn6HS+ygiTcCN6CJvogZtSBk464TWxSNTYqGqtaymD/ehXFAccXoN00RdQQ1qu7dVCc6krL9ddFaYQDIjaddF6KV22bSSxKeRK/vQRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=owZThwJh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L4okzysn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="owZThwJh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L4okzysn"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623H0MkI3238365
	for <iommu@lists.linux.dev>; Tue, 3 Mar 2026 18:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u3Uqm7HnmfbRYpPRyjqAGfV/78GMbwg16ye8LCZyPMk=; b=owZThwJh90AMnzRV
	paDO7cq59E1QOE3ULFAyQheUv2KstgXkYWoyfoFOaENT6WsPcGmwVGp1I1S8jWeK
	hkPkWWycWG1XDk8vQtLqDG+JrpBhi9k2oaN03YTIvNwbsdUnal8jrVTIuO0sPdCI
	PRz7TiFTFluTlq2oJXHa0R0LR8JiG5kRvO6/tScNlnJi81ae+yNmc8k7I7ZNscXi
	2QL6F1rG/oN+KTDgjWMtz3YKNdkXYkjhWesZEQUoXJy0Ar/HPXWepg78FMEcC2JT
	xnVWkgGiHB/mygYn9Bm/cFWupgTiCJDqJOksBBmOCUyFbajJh7dkXEGsinjRy46p
	t+W3fQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnvtu9q62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 18:13:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35980affbf3so2124166a91.0
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 10:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772561630; x=1773166430; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u3Uqm7HnmfbRYpPRyjqAGfV/78GMbwg16ye8LCZyPMk=;
        b=L4okzysnD2eXhL0loFc5fZUSJs54C53XYQvz3YiE09ibB11mr3l5u36ClYN9UQcyTt
         F9JHWr3IS2HNfBW0BCP0NfZ42EDtBaDiQsoRAj/Il6DgYd04CiKeeKDLjFtM37cuKkHg
         8pUNgAfGiUvkAS9ZR0i1oSRo7iOnxPwHey+KUvSEpQi/NMdzmDT7EcB5GVl5BnRhuZVg
         d8YxziBwwsW2mgqrymafW+sA3uT65epP2ADVAq7GYLyvPGHWMK44emsGRWSRqaJ1SENN
         iDKdfxAfvylM4Lfp5V9uJeU6onqfE7JogrF/a0d8NzSZ9Ok2xTBFT1LK6NCkIHbhE6wU
         V6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772561630; x=1773166430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3Uqm7HnmfbRYpPRyjqAGfV/78GMbwg16ye8LCZyPMk=;
        b=UYvkkruAK1wBTfi4W9CdwRM2GGExFx1V4ot55jsr16JDBBUDCcYvnfcF/8olTYNLeV
         cD1eHt7XPu6MiHFv7dt/mz52j0gnfd40RY6FJ0IeLn0xNili16ovP20ktd3P6rQoCSoA
         ym4dTyfRVoDGrf+kFQnhmiNc6H6w4iORYrXyH1Mj+L/4HHvwOxFsUdqoypOivR9ATp1E
         NHZjv8KMUeIgL9Uu0cVwLpv/84Dzgc2p6jnq2H3bj+plnUa3fwytz6/rbw3Bqtu9ZqbO
         /dZDo163ZPqnm/6GI70EABU84qoANbh8diDALL8ygELyFTszPNDJa5zkk8XXb+ynWId1
         0eXA==
X-Forwarded-Encrypted: i=1; AJvYcCU0e0VS/N6xpXq+/RasyNG8emLSrlGsPR77HxFsVJccWQ1z9DM+AaVLoN4ed+tM6jWpy0zjUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjbPq/vncjjXh6nLRIJrHGOdUvELjHq1MqMl6W2uRtS5xpuL10
	PZ5ddrsdubIkmoaSAcvUpRhOjE684jLUm2ertBd3HIqaEji5y/KlCDKUvBrxtCncPcFCRZgrISi
	XbxFmAP7SrukgUl3m+EKKbCj7hXby0IBNTyM+uI5GEwZdyOoJmWc22kp8vQ==
X-Gm-Gg: ATEYQzzeJwWy96SYNZFFL0/AkVvCJNKfNgC7oFEfQu5FYy9SBNkeSUnL3slcBi3OZXB
	Bz62eEqbE63h3eyUqF79/RKXWQ8wI1I0G4+QogdlIexj8baK48Ohu/O6XB2LjBxpFO+MqqmbqhN
	vw7ngHA1pVfTi6TU5X5nSfFRUOAb9azdVzrVytpQnMhekGHQhptITzDBDpyNYD+OFfTTesI/6cQ
	WhWsFWREcsgItOSTOEFBo6Mfj64KYFlgmfF8QO4WPLjts+nzN7okp/4yd6Y72OLRr6hu2K/IGMY
	il8/U21+FnjBTcz00vEh9FHLslOsOZSJs2ei8Vjszhkjf8PrqM4qVp1gMfpxtfy1W6g+lXAahD9
	ZJC2Wjs5p7wcBETK8IceVKVZ9IyfbqhQ6rFxiknD47awan2J4xwXj94k=
X-Received: by 2002:a17:90b:1f8c:b0:359:7c55:c160 with SMTP id 98e67ed59e1d1-3597c55c28emr10322558a91.13.1772561630177;
        Tue, 03 Mar 2026 10:13:50 -0800 (PST)
X-Received: by 2002:a17:90b:1f8c:b0:359:7c55:c160 with SMTP id 98e67ed59e1d1-3597c55c28emr10322519a91.13.1772561629667;
        Tue, 03 Mar 2026 10:13:49 -0800 (PST)
Received: from [192.168.0.172] ([49.205.248.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599ca38be9sm2030588a91.4.2026.03.03.10.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 10:13:49 -0800 (PST)
Message-ID: <635cc998-d530-42eb-95cf-99b0d5baab68@oss.qualcomm.com>
Date: Tue, 3 Mar 2026 23:43:40 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-1-850043ac3933@oss.qualcomm.com>
 <nen35eqhwbikt7jlpxn22hvur33chxibrbmzd6awo425i3mujf@f2cbncxpcatc>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <nen35eqhwbikt7jlpxn22hvur33chxibrbmzd6awo425i3mujf@f2cbncxpcatc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tKKT5f26VVKd98ljW2f334QOjeN-mXz4
X-Proofpoint-ORIG-GUID: tKKT5f26VVKd98ljW2f334QOjeN-mXz4
X-Authority-Analysis: v=2.4 cv=A75h/qWG c=1 sm=1 tr=0 ts=69a724df cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=KPiuay1jFzAquJblYynD6w==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=yfRxjFk6VvuiwaCZe6sA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0NiBTYWx0ZWRfXw6EB8PUbnQS0
 MN/xrYG6pmClwNrUz53I00uGMlHHME7W3/rOZXV9XTgWg7j95ZXnAm029G/zmSe9Flqn8cG6FAz
 LTwGwSmztIm4kVMHmPlZ2ZbcSHFSi6dlGsLdK8I4JqLPtXpIQ9Y/rooAaU1/SOIm70MgHuXy9JW
 7CIt4TpP4cZGoQDA/Ks3DY1EtmxgLtQL2pvtacRxuDUDRX43PNYa65mKPacrqOO76B2HsBmhXrB
 AIYUAxtbk7+cHdUUsZTwfIL5vXg3WOBPmD01pMmnO/ZAaxdkxaGbYMkHdxytgwJwoNBiY9+lFu/
 WUJaJSWyan79qXbR/PFa6YoH0W7tYuBEWsfLoTUgNGpP7kB2AvmJUT2RAZO2BI2u/va8rmPw55A
 6dRlz5OWR9Z4nQ6r7hA+229lNt8jcjeHaGF1jQCNtacrvZxMLqeLU2Fhye825pxJtjoJCtAA55t
 2ohukn+WE2tcfAKP5wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030146



On 2/28/2026 1:22 AM, Dmitry Baryshkov wrote:
> On Fri, Feb 27, 2026 at 07:41:17PM +0530, Vikash Garodia wrote:
>> Kaanapali SOC brings in the new generation of video IP i.e iris4. When
>> compared to previous generation, iris3x, it has,
>> - separate power domains for stream and pixel processing hardware blocks
>>    (bse and vpp).
>> - additional power domain for apv codec.
>> - power domains for individual pipes (VPPx).
>> - different clocks and reset lines.
>>
>> iommu-map include all the different stream-ids which can be possibly
>> generated by vpu4 hardware as below,
>> bitstream stream from vcodec
>> non-pixel stream from vcodec
>> non-pixel stream from tensilica
>> pixel stream from vcodec
>> secure bitstream stream from vcodec
>> secure non-pixel stream from vcodec
>> secure non-pixel stream from tensilica
>> secure pixel stream from vcodec
>> firmware stream from tensilica (might be handled by the TZ / hyp)
>>
>> This patch is depend on the below dt-schema patch.
>> Link: https://github.com/devicetree-org/dt-schema/pull/184/changes/d341298d62805bc972dfba691da6b3b62aa3ff15
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   .../bindings/media/qcom,kaanapali-iris.yaml        | 261 +++++++++++++++++++++
>>   include/dt-bindings/media/qcom,iris.h              |  18 ++
>>   2 files changed, 279 insertions(+)
>>
>> +
>> +  iommu-map:
>> +    description: |
>> +        - bitstream stream from vcodec
>> +        - non-pixel stream from vcodec
>> +        - non-pixel stream from tensilica
>> +        - pixel stream from vcodec
>> +        - secure bitstream stream from vcodec
>> +        - secure non-pixel stream from vcodec
>> +        - secure non-pixel stream from tensilica
>> +        - secure pixel stream from vcodec
>> +        # firmware might be handled by the TZ / hyp
>> +        - firmware stream from tensilica
> 
> Why are you providing description as a list rather than describing each
> item separately? Then you wouldn't need maxItems.
> 

rewrote them as below and dropped maxItems. Please review.

iommu-map:
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
     items:
       - description: bitstream stream from vcodec
         items:
           - description: Function ID
           - description: Phandle to IOMMU
           - description: IOMMU stream ID base
           - description: IOMMU stream ID mask
           - description: Number of stream IDs
       - description: non-pixel stream from vcodec
       - description: non-pixel stream from tensilica
       - description: pixel stream from vcodec
       - description: secure bitstream stream from vcodec
       - description: secure non-pixel stream from vcodec
       - description: secure non-pixel stream from tensilica
       - description: secure pixel stream from vcodec
       # firmware might be handled by the TZ / hyp
       - description: firmware stream from tensilica
     minItems: 8

>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +    items:
>> +      $ref: '#/definitions/iommu-types'
>> +      minItems: 5
>> +    minItems: 8
>> +    maxItems: 9
>> +
> 

Regards,
Vikash
