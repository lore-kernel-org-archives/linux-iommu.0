Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A32D8378
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026156; cv=none; b=rZjIhzQAPkWShNXtfmWbP2oT2XJhq+NalHYXJ9jJSagl+y05zY5kXXvSRE4fmeSPm7wJTpb08d5HvMQV88MSSrm0OTsBpYEjVKREecuubfajCMcT4ioZ4GHSWjKKoAZW/ZRqvhnwX3T22G/08UccTMLwMPEGJ68rLY1fqIncQl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026156; c=relaxed/simple;
	bh=8MJNIVzao8j2hrbn+0QUZMXmV+Ny6jHql9vsW3ffK/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fj5pBXUsHXZxJjQAvHr1DmfpjHacbWiaOAYprtYYtxpPFT9ioarH6hh/4nJQEYYhAvAEURt7mmoeuCm5dvlj0hzm49YG0Gi7Q7WITMZEKs1d+wKX8I+qUXiIgCejK4aTUqgaXIObJoZN6SX/fFAfMDKOW9yuqzDVjyQOyptpTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pTwEa0O0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ACju5ySa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pTwEa0O0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ACju5ySa"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD65jU33563371
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 09:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dk2V+f97R7FIH+RWhnR8qR74s5z0Cna6ABS6uSkhx9Y=; b=pTwEa0O01ggQkmZ+
	aheH+/m17sgjioEGYcDKKAHqaOCVf9Ch/1rOlFiqgbN8wMlMEssOojpkhNjULEA3
	bmifele/wxUqi/ey7vdSZTQ+OWlIFhL32vvnyzt0SVXs2F63ljSbPcaEJ85OG5Zz
	vNnUQa0Pyj3BkfD4FoQx3nnB9Dih/8AGkiZIHqlitAfWYroWhJvMagRXnaVglk64
	QaA1Ywc8LWOb2r7zDljj5Yxq2VdZyMJWSeVNZTNDIjNKqv3bmDD5++hxbp7H69+g
	CCcJjvk/IIqNDt94IWpVbfYjDlcoZuIONdBk1PG5k9ihEPhCbcBkFK2wAQ+eU+Ue
	Y5HoGw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad9rvgm6b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 09:29:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed861df509so2280371cf.1
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 01:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763026153; x=1763630953; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dk2V+f97R7FIH+RWhnR8qR74s5z0Cna6ABS6uSkhx9Y=;
        b=ACju5ySajOmWySHiX6PukzFUhKCCfXy2mIUrGTcQPPwRL9aLlAG8ntSWyUWSb8kng2
         SC/CcR4NHJay1nXPxuEB53VIrRMDCkmUbofJ7Gf8Ojsivw+AT6NHyoTlVCgjvcwPsF7s
         KZDujKHYAZxBgUowFkbuvc5I8aNk4HxWh5HZfpB+32f/K3PLSNFVHhhoecVi4xDg4OMl
         EtT1Y7/7qzn5fibx0SIW6tIVDNQEA/yeyeQM4vNQsMXn0EqvBjNd+uwhWL/GsZUffOHG
         D3vtPqs2Rrgoep4Ef8fGLpOJb1Eej2vfji/qsuOlnALllCeWrqbCA0cxMSCBdPzSkm1Y
         Uf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026153; x=1763630953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dk2V+f97R7FIH+RWhnR8qR74s5z0Cna6ABS6uSkhx9Y=;
        b=Ab1Z56miMz4ad6cAS2qiS1qbY4+N4C5X+7Rpto91hSBJaahEVZYtJxqQF6spnmbE35
         +iOjmy/QS4o2WtFDIUyGozlB8Ri3uqU7aHQyAiiBpKjPZM8tySqQxYnUZsARAreAoR0f
         gKSYqhbQfRRRwa9N8RuSOlz5q1dmUxXIS5R+YzSZKCVwu3g1yQ9r0C6Zz3+q6zaH/bZD
         VjdKQ+IvwVVYJ2PSnkKvvPWQdu9W0VtaxNwcjTFyo5V/EsyZBrgra5lnp4h83/FnDiPg
         ZesbfSSDCbvh0XgGazlFkYscA1ZGHFMdwVOx9+06Fn8OjCH3rE53IguxCtEu1h4WOIOR
         OTGg==
X-Forwarded-Encrypted: i=1; AJvYcCWdrVO/kUMblscdTZBWt1swqkjZ1nnZeIR9qwCnk3P0z4wVA8BF/tZToivOWjnDdccSE+L5zg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0szg7MX2XZyGWhp1Jtzpv7SdJ1H0RHdgQmyVVexSdxVjicIlY
	uFzxqUtvQafzGmwU5WB5Dr6XANCKhq/ugpM26IAqRWKtoM3QnaYWguWFX9uARs0rCJXVvAN8aq5
	ri2bEeykTgENHLx8hLK8yHUMSnSMQZSoQcx3GbTYhPemHZzXEd0JN2UdbMQ==
X-Gm-Gg: ASbGncvFtWURSklgWuhuT0Ug5zhPxEhxu+T7aIZGAa8pQACUHAtd1XVqMNsQ1dX8Vpv
	y18gjN78O28+pRdWyB127xZyP3NQdKt7AftObPD/TLUBGyLS3kK70aFGK+7BhZQN6/jTMbQZ4ul
	b5rKaWHsc3ZTsWaIuMY5ufUg6biowj23lP5n8GStpO+GXmC6lFl5L+/f/uAxDV+dM7Rc6F63agp
	Ca2F4B3z9Ob1UWTyjt5zyRN0T4Xcdmll5oKG1jeULFZiYCq4Aro20UcCvrfYdC51DMvUpn7oRcF
	ZFzjmmkJkQoah1n/n0+rzgS8tt26qasDOI1LVY55W4Ru5luKEbTrqTUmXMM04ZE50cY6mcmt/LE
	twynNl4lFJFKvADIPwkhFWVa6F10NgoRgW5LD+S43I7w97OlcPLv3gCwg
X-Received: by 2002:a05:622a:16:b0:4ed:6e12:f576 with SMTP id d75a77b69052e-4eddbd65318mr52613361cf.8.1763026152888;
        Thu, 13 Nov 2025 01:29:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBKglDPCuRYE0ZGVzuJPGPVwQT3YRBKzTtOU5WmAoz7l8pjecUcIWj985OWak6SKf5r+bgQw==
X-Received: by 2002:a05:622a:16:b0:4ed:6e12:f576 with SMTP id d75a77b69052e-4eddbd65318mr52613171cf.8.1763026152358;
        Thu, 13 Nov 2025 01:29:12 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a2d746bsm1057796a12.0.2025.11.13.01.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 01:29:11 -0800 (PST)
Message-ID: <f76b51e0-43de-40c6-8be9-cad2bd2613ce@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 10:29:08 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/21] drm/msm/adreno: Support AQE engine
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-14-bef18acd5e94@oss.qualcomm.com>
 <1202b66c-6d4f-4909-a010-7e5e3ec7f0c7@oss.qualcomm.com>
 <cc4ff1c7-3158-402d-b746-5aa57b4a855f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <cc4ff1c7-3158-402d-b746-5aa57b4a855f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XrX3+FF9 c=1 sm=1 tr=0 ts=6915a4e9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=CPo_bn1fJaELX20lIFIA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 80cfyeK0vJ8_ykh31kokzqhKwvnY_N1r
X-Proofpoint-GUID: 80cfyeK0vJ8_ykh31kokzqhKwvnY_N1r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA2OCBTYWx0ZWRfXwVesC8415fR2
 FKxkw4gACRvhyBCmLtKSU967964MaWEbR3ida3b5VytDDt+cybfo0JiyjpVlqlwGRUL69KzsgXL
 43yti5XRZMT4M/Wg58loGxbxdazRHMChkSrUHTcF/mDrqGTv+e3uuOHlmjf8qoCO2UTrD7fcR9A
 EkuovA5nCBwqx3g5YDUb4vOWyQKGmhzMtBMOzGx418ZIc/fdySE4qAf4mom4EizetjEKMJMbkm7
 HQ8lL+rykA/ZtTcBbmMT9GIErJFsh0xTMxqkJN1OZf2ugoONNiP6erXDnT+7I0dEkNdUi7eN79h
 FrekCKUqfRLHzfJJonKYQ72boP/YdpfziTeKe7/82SvJNllwjtj1+RUIfq+1+rngwxFOm9LKpzu
 ewGfnAPOZ83aXMyTVovZsBpkJCT/uQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130068

On 11/12/25 10:16 PM, Akhil P Oommen wrote:
> On 11/12/2025 4:37 PM, Konrad Dybcio wrote:
>> On 11/10/25 5:37 PM, Akhil P Oommen wrote:
>>> AQE (Applicaton Qrisc Engine) is a dedicated core inside CP which aides
>>> in Raytracing related workloads. Add support for loading the AQE firmware
>>> and initialize the necessary registers.
>>>
>>> Since AQE engine has dependency on preemption context records, expose
>>> Raytracing support to userspace only when preemption is enabled.
>>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---

[...]

>>> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>>> @@ -616,6 +616,9 @@ static int hw_init(struct msm_gpu *gpu)
>>>  		goto out;
>>>  
>>>  	gpu_write64(gpu, REG_A8XX_CP_SQE_INSTR_BASE, a6xx_gpu->sqe_iova);
>>> +	if (a6xx_gpu->aqe_iova)
>>> +		gpu_write64(gpu, REG_A8XX_CP_AQE_INSTR_BASE_0, a6xx_gpu->aqe_iova);
>>
>> I believe you should also set CP_AQE_APRIV_CNTL per-pipe
> 
> We already configure CP_APRIV_CNTL_PIPE for this.

Aaaah right the register I mentioned is separate on gen7

>> Should we also enable AQE1 while at it, to reduce potential backwards
>> compatibility issues? Would that require solving the iommu woes?
> Yeah, AQE1 is strictly for LPAC workloads. So lets wait for LPAC support
> first.

Sounds good, thanks

Konrad
