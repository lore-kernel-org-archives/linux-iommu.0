Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0642D8372
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026039; cv=none; b=FS75upoyPu5o+QnH59I3sodPWtUpJ5ZJks88x9zVj2KzbD2Ne4V1OdxVlVTZCQ2JbTznBGUpoLvRfxBFsp3Pea2qoi89Arz0wC/vUJqksqZmYu76GO8oFoKbd8+zHKWQyq2vrJAB/Jh9T8eI0S5SrzpAyfu8aZ6fDeGIsiN8GLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026039; c=relaxed/simple;
	bh=/iePmsUVjvQOSeWCJzhMKiUEulix7/M1KSmizMWl2jE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPgfMcgOSO0MMvPGjcCs2OvK09MMUtg43yvEhmNR/m2EXKb2qe2Wd43W1a42iXWmxbeLVyu15FIII4YSyfrH2aBlF8WOzCzoRGJ3Igzna1Wlm2boSjl2ZBU3gJXMrk5UehhpyOnyZ/DrlmdlS3K1Za13B4rnE3UwxVs0jZjc7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DZ2znY/d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Op0j4K7T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DZ2znY/d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Op0j4K7T"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD8bI5I2962376
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 09:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hBQHZTyCsz2E3OEb1ZqiRZ3GGm1s7VIXPos3wQ/Oo+o=; b=DZ2znY/dexHHqMHq
	9UkWyfkyA6sxniXfSVzQ3mjIGhqO9rwCQKTW75wPB3nlkpUsS0OtYu8UxJQXenRk
	pcC/7jHqrzkDz1W3+4SVTQy5RvEhR1a1BLews3b1dTMnuu5k0dQ020YVVJy2DVN5
	sZMi3oF9NrfocKv5ItoZdY74rweVMQxLL2DnVYQHV/b9nofgv98w5BqsQjFYHz4L
	iDylQbuQi84kF6BdGMY6P+BalSzQ5+T0zJ6ubsI91moQLfbQiSMla/AmjbyqcdGf
	5NG/PtPFaRkLM+oxZm3TV4c2B5cWISuXHS5uwwv0W++sQfpde37Bk9ymdiBQgomD
	05IFsQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acwbpu04n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 09:27:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed6317be8cso1870511cf.0
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 01:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763026035; x=1763630835; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBQHZTyCsz2E3OEb1ZqiRZ3GGm1s7VIXPos3wQ/Oo+o=;
        b=Op0j4K7TF2JDOlkbpcuU0RVRzelnsUcQZU8hjch3M7vhALBBT1fGQi5V1EhXS49A0S
         r9dfTX1U6ISrxu/7NKRStVPaRlhL0vTbs4dwv7k8nV6cnMN0rGa+i8HteIdCNtwgC3W6
         AevJcI4r5ngQzsvSpqkBKOGk0G+Wopase4d/iYNMHnl4CLIlFolzQ0SO74zjzq12EMKg
         lmSdh/y/lWe7aI6rWdEHXq93oAOQo1yOT+4zh2DU4HGpyMbeu5p3YlVI1tBixVwsrCAP
         uslBTHwGj6IPsFdL4F0hK1ewCKaEkJ0Jr5Z/DN0CrbDdLx3xWLOtGrDS4pr76picZhUA
         uR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026035; x=1763630835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBQHZTyCsz2E3OEb1ZqiRZ3GGm1s7VIXPos3wQ/Oo+o=;
        b=oB0lkmUHPupjRtzFVzPu9DnJMB7NgrgvYZnmki2To0rgN7YGyPWXJIN+Br8Z3XEW4B
         J+e01pK8Ay2Fs1vwJF2kYLV3apisynFeO++nGXicLgDdhiOT4pe1BvWUavrnY5S9Uszp
         oHpukf5W6ru9D936Wu99riwLBPzMa/BQeR+LJ52qyxY6o/haW4QkrDmXQ1TEdcuNAHBt
         1diMm5sXw9QtBcmcdniqCP8x+E6Zy2WMwzyaxt5Fp69RdJXrCK3AcXNMDzq3n3c83NtV
         nDs0uSCsQmLZ/8fpGEul03MvA/tkodZyDhjAlKnGmQ3qISQvDB3G40a+e6e5l0uSQQL2
         hOkw==
X-Forwarded-Encrypted: i=1; AJvYcCVsiVTQ2QPaqzRhQhYq+X38CLNkxH+FYhkZ/WSRxH9ssIw4ARts/ZYlUYW9eeGCEhSYh8Fqag==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWCPoLIDBwwhCOdBS4pbJJbQNLbAtZ2zYk4I4yVdGf+Jbm7FGi
	FZi4dMPIWAA65e/3rniJC6W/+graNl/AzSfNhfLvI2oDKgenxTIu1PTGPdgbC4ykC7FDEAj0pSS
	jDPpeJ3IfIvEzDoba1YWUG2n9KaWqJtBISWz7rzgtBFXQN1yPgdJv5I2D5Q==
X-Gm-Gg: ASbGncuj1MxoxdtlFQs6uG8G6Dm5Ab104WsJKujGsVEYWgZUN4J99q2KAyhjl90mTsP
	qbhETg+UVr07k8WWi6f7tZcIIESKE2U/5CWMzgGxHMQsI3M5fyVGQNc5uFjayVaOTQJf1ZaDCdL
	4JTBp0EJcD9+47s3P+ESmLCEziTIouPiHp8qG+EyBWj3PxKsDwqgiITQ2JvEFbRYAKeg60R3Jjy
	OmZh+IBcRNOOlLN2aFhltz98hhOQ3rN3eQWXk4SsnXU+9soB04+M2qjYpBimr49agi2Xhe3Sl9z
	80jjeu4RjatkEkNLVpt1ysJVE8B+AF2FfjF3qJAIGDb6GqVvpdx8oheHgaBVDjgU8pwdzuskGnX
	OhULNm7JTYcShnqaM1Ha/DKZbgL+VxTZ0FsO5PZylQ72aVa+kdx7RC16v
X-Received: by 2002:ac8:57d6:0:b0:4ec:f9c2:c200 with SMTP id d75a77b69052e-4eddbd957bemr55093231cf.11.1763026034626;
        Thu, 13 Nov 2025 01:27:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoZxoEy/JmKlmxIOPZpqL8nflJ1JnawU4oD4ovv9bKA6hPgIGxSwD69qSzkbCaaUf89Ywfyg==
X-Received: by 2002:ac8:57d6:0:b0:4ec:f9c2:c200 with SMTP id d75a77b69052e-4eddbd957bemr55092921cf.11.1763026034164;
        Thu, 13 Nov 2025 01:27:14 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4ce83dsm1028106a12.34.2025.11.13.01.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 01:27:13 -0800 (PST)
Message-ID: <d87bea02-1a89-4854-b760-617c3655b287@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 10:27:09 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/21] drm/msm/adreno: Move adreno_gpu_func to
 catalogue
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
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
        Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-5-bef18acd5e94@oss.qualcomm.com>
 <28d62905-c191-4c3a-995e-a4146ffce619@oss.qualcomm.com>
 <12e6f588-e422-4803-ae14-56e5297e564d@oss.qualcomm.com>
 <os7rpbynyoeolwvbrocx3yrrxzhextx3srywal2i54jj6dw3mw@n6fbt3pzjvj6>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <os7rpbynyoeolwvbrocx3yrrxzhextx3srywal2i54jj6dw3mw@n6fbt3pzjvj6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NvjcssdJ c=1 sm=1 tr=0 ts=6915a473 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pBDOg7y053Z06RvWvLkA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 264Jbg3LxDUMkIN2SzCScw7ItQdzCHh8
X-Proofpoint-ORIG-GUID: 264Jbg3LxDUMkIN2SzCScw7ItQdzCHh8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA2OCBTYWx0ZWRfX91jrVTSj8Zk1
 mNHRJeZXSXxhLCcQtBnsq4mTMci3J9SWhLnoyJ4kpRY72ndFh0V3ILjfUkHo6BMfTeJSE0IY08d
 PDbrd4p2yK4X0Qd1S6rM6GvXThFUNVKUKUB0W/MYhdvX9F9/fK5bzw/KiNqdvx6OILCP76HQ1x/
 0BXEM5c3u1as1NACHQkXjdGVRD2sWoj9gveVfFAStwcyuCtaFEYwInv5RSY87hE6LiGb4Vceu3Y
 FnFvNgi1XJJhz9bLbjMwRXYTZUZC7KUHVFBr0K+rxis/oIDj4mvxFtDSPYtd2erxFwA14i9Uh+e
 cGIWzHOf7910uhx091LORRKr2yKdj0JJAdt+vA2rlRaE45uS4IpI0XHuxkn2IvGsMObeDdcfe63
 1bGx8sh4lwmuLSgFWVFUR1xo7svtiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130068

On 11/13/25 4:38 AM, Dmitry Baryshkov wrote:
> On Thu, Nov 13, 2025 at 03:32:51AM +0530, Akhil P Oommen wrote:
>> On 11/12/2025 3:52 PM, Konrad Dybcio wrote:
>>> On 11/10/25 5:37 PM, Akhil P Oommen wrote:
>>>> In A6x family (which is a pretty big one), there are separate
>>>> adreno_func definitions for each sub-generations. To streamline the
>>>> identification of the correct struct for a gpu, move it to the
>>>> catalogue and move the gpu_init routine to struct adreno_gpu_funcs.
>>>>
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> ---
>>>
>>> [...]
>>>
>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>> index 44df6410bce1..9007a0e82a59 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>> @@ -683,7 +683,7 @@ static const struct adreno_info a6xx_gpus[] = {
>>>
>>> Somewhere among this diff, a619_holi needs to have gmu_wrapper funcs
>>
>> Could you point me to the holi's devicetree? Currently I see only a610
>> (sm6115) and a702 (qcm2290) uses gmu_wrapper.
> 
> I don't think upstream was ported to SM4350. SM6375 should need the same
> hook, but I don't know why Konrad didn't enable GPU on that platform.

I'll try to fire up -next and confirm it hasn't bitrotten.

Konrad
