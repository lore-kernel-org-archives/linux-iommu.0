Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CDA3BED6D
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563853; cv=none; b=cOu2b08DKmK1orDpIGlXe91q4g6xEngyL0AKrpVeUgeVCgDsyqdzMsdCepHsYxDgzg0g4do+o3pjrMBRP4MhsamUzVOjP7w8gAaL90UUgQUu9ajwUpfBu8oj7Pjs/LlFgBb5Od3BXEGrHxx/Pm4OtBMa547k78eB0KNZcozyAlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563853; c=relaxed/simple;
	bh=p7D3XDbzE4LmwJD1gYeONBjA4tJgseuls8e8XyVdW/o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qW5jNcquWaIKWrgKS30gqaRS4CfbozLS/hczeqq87G9WZYS/i2t+aYo1iZwL3ZWzJ5vyKN/7hqDxLz4sehprQA2oY9o00YTZNERZjdsaf/XTR2gw9PoqqOAOX0CVo7udXeb8GGhCdwWISlm41OPMAviiSpxfhtEIdxfHi8P9Uxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c2Hee6A/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HCLvUu+V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c2Hee6A/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HCLvUu+V"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623H11jj3559919
	for <iommu@lists.linux.dev>; Tue, 3 Mar 2026 18:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	25shQvLHwOqK8bP7PBHIpLPvewVyW9weQjfHgjfIRuc=; b=c2Hee6A/xIkezOG6
	p76Zk3LEZrO88pJWKEKNEyub1+Wgmp+cq65jzjvAqZk1WdowamH6fQEIP7DEIPtc
	2lT2EDDV3BsEcjTGcfYM3ecuhynRNSPZ0k4n9IscvIAsvBrZfdKRbdjDmzLQ0bhx
	DGqyU65Hv1YQCJwawj20GxJGZHAC6dhWrg5ET+A/TL09uvIq1ANubG2OkHFVhXco
	ZjqdvCetiJ56bciEwM+FAyIwHjBww4HQ6RAOsjeKH23f05W1tzdmwUStTgRmg+Ve
	1E+Hl+HYdkWXd9q31vl9D1oboVT2SOwuzoXKEkGZj46iujEgkz0LX3lejqQTG3Ez
	NoC6Eg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnhx5c2h4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 18:50:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-358e95e81aeso28149976a91.0
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 10:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772563848; x=1773168648; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=25shQvLHwOqK8bP7PBHIpLPvewVyW9weQjfHgjfIRuc=;
        b=HCLvUu+V8h+SADttjbBId8FlJGVHxsALo1N1E/S7xrO+/28ikHbmOsoZT2K+zqzoV2
         UhnEqVHtvVY5tY6ObwJVt+cXrPP6WLw87sXYwXImZeqg6wKZZ7w3WVudAjabHmUKVspZ
         p6lbuPPpi7ZK2l/D1oh07K9euCiZCT5tiu0O9Ihu4KMoUcHhwR4P/6kiGCOWFeSaKvMG
         VqAJrrEUR6HQqhlC6nOmRiPfZlTx1RaJoXWAPkSEDN7VRX6D5et2/oMwiCwf2PvuohuN
         0UDvd1yho86NW6NUPBeWgtdDPHNB2pJWy7wNWgwqgxU01vLCxD9F9zJMBkM+KuZoBnuU
         weEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772563848; x=1773168648;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25shQvLHwOqK8bP7PBHIpLPvewVyW9weQjfHgjfIRuc=;
        b=w7c/rPNZKBdh1PnUfk4atx4Vw/+Am+NEZZxSP8lT+rGUHeG+Pej3Ko8eElcACvFwWw
         6a0fpHuv2Kzh1KMDVmb6eWs/DxR1OGKIUN9IhLqSq1K96Lfkoi+E57RQQ3sJ8XnJnrzb
         HKTkQpoq3TTvrr4NNB/9afe+rBB+IY+0TjA+XosWX0f17cmHtXgJ8vs1wKQAWMzZo9Hw
         NQ83ldEb8uFmitFV39gYi/9v6jZee3wgrC8o/GMadinm1CN4WI09W8JxHBOsH3B1EO6Q
         v4yn2IA9mRH5gWHCR4yI239aHLL6OQkRKwGTWpbibZsiMW70dY4vQwv0A0lB63RvGAba
         Ex2w==
X-Forwarded-Encrypted: i=1; AJvYcCW/3d87GWqdJT9g+1YC4hAv3wnJNbjTcECLX558/CLBVaTrC+ZRxklQlVpFy++px78aj3RJVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1IaGmIPJ4LTd0/x/5JxNvkyCUXQZRGq0QzSYsqXmHgNunl2Q8
	XsctYh88ufqpeMVbApxqicFB1BMS9BdV7u1jac4cJVUkIDpelvhhiUt9RP51Bamzs6PWpuLlnWG
	S3epo4sCwSnr4y+77IZBMN96J3qHRtRT3fS0xsqCkBaprDiNf29Ev9TmWKA==
X-Gm-Gg: ATEYQzzOF+Gxj005Lu7hKmXw7XJs84csB4GB8XrWJ+795lq9+D0F7mJl9+S9gh2UjNx
	dquPyp/o/wzweOGT508/qgVIuLbGHZXENa5LzeGZNyfb20En9YCn6DpXxWNG+NEXuWFFeIhfOby
	j6VGfQGL8a5Ww9bFF5akzTWP2Hyn5+RhqRAcDRzKT5wEhEGOIu+lpbH2x2Mqq9z23CJj4/sn28i
	5hcHayLAvq0aGDO/1owGDTYCQ8N0kVsyQtfPbMgU601PdOvf4W3irKhXUm6w84bO708vxCRGJZc
	hB8azI1/A6hb6CzfJMESLd2bZNktWqQDoPL12ZsjjozeU1t1z0Df3wgNlryo607RSXRjJvh114W
	eo5beqhw4qYuV5oIYNBDC2ZxGjtfd3q73wReUFXaeDyz44Dv0NV79HOs=
X-Received: by 2002:a17:90b:524b:b0:354:a284:3fff with SMTP id 98e67ed59e1d1-35965ceb27dmr14994961a91.25.1772563848387;
        Tue, 03 Mar 2026 10:50:48 -0800 (PST)
X-Received: by 2002:a17:90b:524b:b0:354:a284:3fff with SMTP id 98e67ed59e1d1-35965ceb27dmr14994936a91.25.1772563847950;
        Tue, 03 Mar 2026 10:50:47 -0800 (PST)
Received: from [192.168.0.172] ([49.205.248.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5e4aafsm15501836a12.4.2026.03.03.10.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 10:50:47 -0800 (PST)
Message-ID: <21fda4d2-72e1-4e5b-aee0-a799886f53b7@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 00:20:38 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] of/iommu: add multi-map support
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
To: Robin Murphy <robin.murphy@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <20260126-kaanapali-iris-v1-3-e2646246bfc1@oss.qualcomm.com>
 <hunwsdkmeo6efpv3yt3izkgmarelnubd74dywj3scryxrreq6p@njijwtoyjh46>
 <78ffd1ce-5408-4bf5-a782-0c4ca14017b1@arm.com>
 <1c3c36b9-7367-462f-8280-16477d3ad20d@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1c3c36b9-7367-462f-8280-16477d3ad20d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE1MiBTYWx0ZWRfX9Ps4prq4t6BQ
 VHaUgDmZGS0zQ0f7zUp2wiUEK+CIrXn8m0WUooN8d0942Erpvt6dtp+66DsnLiJ7mCzz6CfruMj
 YKeVMad3NAzXJxCw53ZIfnHRrXn9UWfbeQzEHt5r8qA01gjX8Y2ZSqegVX0Cv0FES86hjU1AgHB
 cJM+PHfECVYv9uwEnaqY0yVehJQMf1OZTaAMU1YfVj6IoEp77Yp0W3rgnERmUNWkaka064an2IW
 RpsU338uHPoeO1oKE+R19rzktry3f/OjtyRgR3MXECIgUHI26+Fgv9AEav1/ypsBr/EkCtjZlX6
 WyUV1u/B1U08qEw6wdE22kpFi5CMgJzIEXpuiCBZsfU+27RDvc7HVPyukg0lg7JQw6D+y8L42fB
 ProXS5yA7WyRQ63AJnDyB7Zg+6tM6MlWuzdYonJrPXx8oygSasjdJYtPbJtwUbKgp+Wfa8hUtUf
 yqWft4slC3kqlzyv5Gg==
X-Authority-Analysis: v=2.4 cv=T9CBjvKQ c=1 sm=1 tr=0 ts=69a72d89 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=KPiuay1jFzAquJblYynD6w==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=r3fjQwxrIzP3dXeSYucA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: gbzhmqAR-JWJBF6IkLdPaCd4ArlTdveZ
X-Proofpoint-ORIG-GUID: gbzhmqAR-JWJBF6IkLdPaCd4ArlTdveZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030152


On 2/17/2026 6:38 PM, Vikash Garodia wrote:
> 
> On 1/27/2026 7:50 PM, Robin Murphy wrote:
>> On 2026-01-27 11:45 am, Dmitry Baryshkov wrote:
>>> On Mon, Jan 26, 2026 at 05:55:46PM +0530, Vikash Garodia wrote:
>>>> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>>>
>>>> When multiple mappings are present for an input id, linux matches just
>>>> the first one. There is a usecase[1] where all the mappings are to be
>>>> maintained in parallel for an iommu-map entry of a same input id.
>>>
>>> This contradicts the IOMMU idealogy (at least as far as I understood it
>>> fom the maintainers): the device (driver) doesn't control which IOMMUs
>>> are getting used. Instead _all_ defined entries should get used. For
>>> iommu-map it means that if the map defines several entries for a single
>>> function, then all entries should always get mapped.
>>
>> Indeed there is no concept of "multi-map" - if a single input ID 
>> represents more than one thing then that notion of "input ID" is 
>> fundamentally wrong. A single *device* may have multiple IDs, as in 
>> the case of PCI bridge aliasing, but in that case there are multiple 
>> things to map.
> 
> Let me take examples of kaanapali and sm8550 and describe the vpu stream 
> id generation part,
> 
> kaanapali:
> iommu-map = <0x100 &apps_smmu 0x1940 0x0 0x1>,
>              <0x100 &apps_smmu 0x1a20 0x0 0x1>,
>              ....
> 
> sm8550:
> iommus = <&apps_smmu 0x1940 0>,
>       <&apps_smmu 0x1947 0>;
> 
> In kaanapali, 0x1940 and 0x1a20 are the *resultant* stream-IDs. The 
> resultant stream-id is generated based on
> c-SID --> generated by vpu hardware, controlled by video firmware 
> programming.
> Topo ID --> port id, port at which vpu is connected to NOC, decided by 
> vpu hardware.
> TBU - smmu translation buffer unit, decided at soc design time.
> 
> Now if we take 0x1940 and 0x1a20, c-SID is same i.e 0. Within VPU, we 
> have video engine (vcodec) and processor, both have different TOPO ID in 
> kaanapali, whereas in sm8550, both have same TOPO ID. So vcodec and 
> processor may (sm8550) or may not (kaanapali) have same stream-id.
> 
> There are some buffers, like internal buffers, are accessed by both, 
> which then need both the stream-ids to be mapped into single context bank.
> 
> If you see sm8550, the requirement for both those hardware to access 
> internal buffer is still there, since they have same c-SID, same topo id 
> and tbu id, they have same stream id (0x1940)

Robin,

do you have any further comments on this ?

> 
> Regards,
> Vikash
>>
>> Thanks,
>> Robin.
> 

