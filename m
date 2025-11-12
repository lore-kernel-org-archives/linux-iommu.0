Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115592D839E
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762985381; cv=none; b=D1vId1jLK29yd6LStTlLKdMC1od0WjtFvV1/uctufF9B+0BT/9cC5fr6nKxURCFS5ks5SAOysJbi0i7dkHMepqfF9vAVHlouvQRIbPfo4uHmi1OSaPuWnecp8uNUz8YCr83pmv1OD4w86G2+0JEicbED5t3uEnFw8jJpC+fst0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762985381; c=relaxed/simple;
	bh=uu/OVGsmPgjiqEif9CsqNjLeyI55qyMfIViXNJbj+t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6lSYp5xMhsMguAQXiZLO2KwNBGKPPQ4uz2Q3OZ8jnbfQ/EJVnISRhwkal0t2QfC3pkmmC5fhmUulO+T4Xr3v/TZQiFJQPZEQ+n2y5buEg85V030oje1lRCDScrjl3YDieSN2yN1I+e7hS0gfuvytBOmaLlhh8aXZcuz141+k8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YaOQ2gMv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UPopXsO5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YaOQ2gMv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UPopXsO5"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACEJFno1382419
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 22:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PKqNXD1DollfLI5h1J2Xseqpi/6Yas+Ng79HmXPNvu8=; b=YaOQ2gMvd3/T2S8/
	MFfA/GNKngL5oDoYFpGPtoDfaZtgNEd3XKI7mFuEDVr3AoHNMLQ1RveVof/P4K1C
	MBTr1vFrsSX3rd8CT/nDm0Cx7/HQSUMMxBkD2xD/pggoeQbc4UdQ0At17NM7gWW9
	5m2RJOwq74SAEruoLtIqCJDADeMt6FI2XMOwC3eITawkofhDN8nltztqtxQRHftW
	foR+RMjQpLY4n/Nag8BcHwprobmGjkMqulU/Feeqm5lHY85HMukVa2nwk57pu4Nv
	QPdO5BzUJ37cd+3xC7xlgxq0B5paVicxwtHp1lLFddI5EtFgX5NYPRo3fQUlSEkf
	j0E5tQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acuw49ex7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 22:09:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-298389232c4so1458885ad.2
        for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 14:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762985377; x=1763590177; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PKqNXD1DollfLI5h1J2Xseqpi/6Yas+Ng79HmXPNvu8=;
        b=UPopXsO51Z/AVnwDwHsQaIwcCvw4xL4msbJars4yUqU1XU/kV3N6MMsa0gfkyXukMH
         TvztkgOFWRzecM2TFI0KPu5lm9jgFLN4Ea6QTO+FhqaSGkV7WAv86sFmkWMdGrAZjxD3
         skI3ykOgzG2t/kbNmZXxa0kNeTiXW/dAOdN/n0L1biVoSwkBwrs0w6T+a0WgBjw2xc9x
         K1njV9h+7GVoFuWIfczTJSQBLTKAPKLGci+f846I8gcbwJwhN/AW0mLkL2njdgQrDvbw
         ggFbcpcmptKH+jLlAQX619WsTv0KpED7SY4ZIAgNuHRpcDeRj4Se7jXwWTEMMKddIDib
         TQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762985377; x=1763590177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKqNXD1DollfLI5h1J2Xseqpi/6Yas+Ng79HmXPNvu8=;
        b=j52PEBN+bIFC343m46l5ZRSWgXDVkzs0b3DuOT2oob11B6F7YR4kgHVrcOGk2QzvoQ
         cmjVrsZwfsDRotRJOqPoUNSXjCLAAb2Z75n1+Kj0LlmjTFyGWjYjmZtOlcVkisqrOvTV
         Vrj4Tf+3JbhMTLUkUOhS8thppczxS8H+gSSs5THlSH9UxoLVIj6NPcjME8b2wzGIlzYZ
         RQHTPmwnqOVFmfqRmmnusltjvIxweoJ6xEy3EjPiZGIeSKpetpC8k0zrcfGNqja/zZtm
         87BaYHKcZfP+2ak5MRupKcHpnv0meolftSLR3mlWKEEKSwS+UZ5BtqzgQoMC8s6Ydj3f
         fUVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXefYrtVv7r5DYb4S2qvl74+DUC6ZwAty03G7w0H7a0rQEu4kV/xd4h9Hpkgvs38It4jBuAqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVcJDf7TCCtXwsXWOOZtX+ghB0+TnYTdeUSnq690vxGXzgxbRT
	PcU1NWYaO1LGVU0QJs5V6nXFaxmPOtUv1zjoNbbGNbBfghq0bNKDOTbyJrOs4K4tFTA05cpYrnY
	/03AgSYTo2PLL3p3c/Y5UOqcTPfieRcqjd9J8xn2iNKDDs8D/TJtWQy1+Bw==
X-Gm-Gg: ASbGncuplAs13rA+tKZ28wfGJI+Zo7X7oEOXApvL8nkeEzY+QhQmtMwBxfBDSFc/GQl
	ZfIkfAuijOpZIwi9A2E3bXbx0a+s/UbMLY0UMOPE7wUUy/If0P/Ij/shL9FK6OOY/p5VbGsEMzb
	DpUsVdL8Eb9fbsdjg7iuRqdRbsSaPXLQKFVlI5j+rtpxuXLv+nOFJfggg5i9AkTFXGS4g43b905
	UkaKZPjivbjV9vnFKpCe1BiDp9jb9A05NYhJsGpwbeRNxZl3qzZUkO5tW+nvN+q5dcsW/b2F1Eb
	KVbUpqSyx9bbhnKcOLwRTcf4XZcTLYod9fA1iK2UK2MjuL+PqptqO1vufKdTY+rUN2DMddp5O/N
	gHF4njbe5OV/jLIAdIAYsFA==
X-Received: by 2002:a17:903:1b6b:b0:295:4d97:84dd with SMTP id d9443c01a7336-2984edd59fdmr58284475ad.51.1762985377574;
        Wed, 12 Nov 2025 14:09:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbDPQwjbxvdgWkQp34t9iHfLbIFLfFbNnosXkOr7CJTuwb5+1HxivTIaNHyQXba3NQUZhkaQ==
X-Received: by 2002:a17:903:1b6b:b0:295:4d97:84dd with SMTP id d9443c01a7336-2984edd59fdmr58284135ad.51.1762985377049;
        Wed, 12 Nov 2025 14:09:37 -0800 (PST)
Received: from [192.168.1.5] ([106.222.234.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0c9dsm1704455ad.67.2025.11.12.14.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 14:09:36 -0800 (PST)
Message-ID: <d4753c6b-b3cc-423b-912e-61f8b7bc3c1a@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 03:39:27 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/21] drm/msm/a6xx: Fix the gemnoc workaround
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
 <20251110-kaana-gpu-support-v2-2-bef18acd5e94@oss.qualcomm.com>
 <a1273bdf-d926-48b4-877e-48d5ff45e7d9@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <a1273bdf-d926-48b4-877e-48d5ff45e7d9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: A7lV623ZEqrYJnVhj4Eu0M4Ach0-0lxp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE3OSBTYWx0ZWRfXxgJtJMy1GkM+
 Db7p5eJAZZvwhL2l16NGosZDEShRv8NGOSeSY88YO9yeVUETUm8An2C/c5H895i8laU9SLNWvHP
 r15r+N7yfrFYIOxmUfCkHfAIOQ6mjqEPWfSXaN3QdUY18tmZI29tC5ywMUikw36VDOQj36AhJsp
 rE3ekT3MebUSea79OLw2Nn76b4ASCcgeNA7Cy2flPw6UZqnhmq61Rdv3SI9kAZjVZoFaGgdgTxc
 eZ6zeIBY6vE9/Y9yLNj9MWBEbYQwMhC5hWxWqlCpqGiYpH9j601qEyjy3PPuGt+CtwbK+2qD9JL
 +PuPl97BhndVcHmI39CqK4J6yU97BMIC6vm7WtpTh0x/x5hcEWbO0QXNZ/sWtwgGY3V6ToKaiXA
 3IPI85WFdw4SSSyDdKm8TrLd3eNj1g==
X-Authority-Analysis: v=2.4 cv=F+Bat6hN c=1 sm=1 tr=0 ts=691505a2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=2IP1oaZ8+KUWsYovLW0HHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=vAHTylR2Z3b6qOykXHEA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: A7lV623ZEqrYJnVhj4Eu0M4Ach0-0lxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120179

On 11/12/2025 3:48 PM, Konrad Dybcio wrote:
> On 11/10/25 5:37 PM, Akhil P Oommen wrote:
>> Correct the register offset and enable this workaround for all A7x
>> and newer GPUs to match the recommendation. Also, downstream does this
>> w/a after moving the fence to allow mode. So do the same.
> 
> It does so for _notify_slumber(), but not for _pwrctl_suspend() in kgsl,
> but in my understanding, making sure the bus arbiter doesn't gate access
> first makes more sense

Yes. I didn't change the order in a6xx_gmu_force_off() (equivalent of
kgsl_pwrctl_suspend)

-Akhil

> 
>>
>> Fixes: dbfbb376b50c ("drm/msm/a6xx: Add A621 support")
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> index 4e6dc16e4a4c..605bb55de8d5 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> @@ -485,8 +485,9 @@ static void a6xx_gemnoc_workaround(struct a6xx_gmu *gmu)
>>  	 * in the power down sequence not being fully executed. That in turn can
>>  	 * prevent CX_GDSC from collapsing. Assert Qactive to avoid this.
>>  	 */
>> -	if (adreno_is_a621(adreno_gpu) || adreno_is_7c3(adreno_gpu))
>> -		gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, BIT(0));
>> +	if (adreno_is_a7xx(adreno_gpu) || (adreno_is_a621(adreno_gpu) ||
>> +				adreno_is_7c3(adreno_gpu)))
>> +		gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FALNEXT_INTF, BIT(0));
> 
> Arghhh copypasta, thanks for catching this!
> 
> Konrad

