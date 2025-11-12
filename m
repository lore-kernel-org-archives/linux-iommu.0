Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C951207A20
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942692; cv=none; b=DRfAfeOBum1HEFcfWHpwKOos+Y2UxiCUDsDA1dp+Ow5womGXXukRlKDYA1m1yAdZcQ945HH3/L5aqOMU47a0jBOzEiTcsQArZMJgfBYw+mxYDUMlbtKe0+8LB9W7QTQmOtoP1PXShbqnMCiv6rjD97bmgKmdBJyokvAxIivwaoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942692; c=relaxed/simple;
	bh=6ExUaprOrb7bYmHFnlrq+UtunG+UsbsFRXBeLvcjM0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Et/yOGNvzlC1Zs4IaRYx0CVYJVaUnwJDjdmTCzmGKBTq9E2f9xs5sYXlCe5Z/ED8XSu4HC943+osRgJ9Yh5UQJsF5VAiF+GCkciivDQ0ecN4Ag1pFYrwuMQO7d+wP12bdVnOpTg+KVrHMo1myuYnZSMRnX3asakLip/vAYTbJCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XHG/U/xg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S0Hs8VKP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XHG/U/xg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S0Hs8VKP"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9gLJW960183
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 10:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s/lopT9opyCf90Ve+odq78rypOpIc2a0jmLTtA1UVZ8=; b=XHG/U/xgXOWnwci/
	cbr10cJY9Vt1KgKxrd5wTZGGN7zmOyK3bgcF4K16kGw2s+flbPOVsa5yuY+U9C71
	GUdBTbMP0/9VrCf6+FqRxann05mQXG1D6YLuLAQXMEIFZSf0AUa5FG+JoX3RiyAB
	RR2hEBqBi1jo18d4cxDgheO984q1tR9tsiBCi6yksRqG1uO2QaOVtW+GxTpRASn+
	Rwl5DE0SBlnvtnEfMDP1pKUdc8H4naeKgABrfuOEZOvelQhB6UKWgk69l3UKWmIF
	/z5QGbCOmHcBTIBO7rx0gkghX2PaWhX3rGTitX/HYNfaSywUOHYw6jsPsXOxVZwS
	PykLqQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acquer504-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 10:18:09 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88088964786so1973406d6.3
        for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 02:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762942689; x=1763547489; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s/lopT9opyCf90Ve+odq78rypOpIc2a0jmLTtA1UVZ8=;
        b=S0Hs8VKPW6GJVOG7yOEhKfbp+INp3l8xvGI0/ETdqLEDakIsAgnrvUEHAnLU0x05w8
         ITrC8Nbsu79VCYhkxNbfoqpitTykRFMujCgp5GeWe/2pG32BozjS/3L7qYeLdc+94B2D
         S6slCHb8gbUvc1VrtBpLjzPbMp2OYNkM0bTYKpGisYeIHO1TWluAHRADWKUXYosMCBHT
         AJGOYorCPmGJ/Z4xCs0alwFExWCeuUOQRyfQhZQ79vr8g44/jiIeF8NnygjV/vbCXNNy
         PZFN5QsnKFzkiXoIRd7o9Bn7w23CLdn1fn0qo44eAXdJaecV+RzvwLhf4c14kaYw2fFS
         OW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762942689; x=1763547489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/lopT9opyCf90Ve+odq78rypOpIc2a0jmLTtA1UVZ8=;
        b=rIgKwLIiHzzueChQbSEXcLstPNMoqR14BtJUfRb3WQ/TLpCrogvHFI+lzJ5TfTIV4+
         dBKm2f78AtP5JAd4k/fwpzcxy47bVKuV5kvDEe0pz1CyEvh0NCMrlIOmDORh524FuYqi
         LXyu09ixURKAVOr9RpO426QnlAkpNlXep8Oj/fViYh6mCsB1Ma3JXwnVh/ezodwz6juB
         X3zyqc8a7aBFh9896th6Ebm5oDK+o15Dk51/oBbY6CoxeF6MV4CE1oEKlzZqYs2w39It
         GUdZb4w+o04wb1xP7pETLhFEL21mJxKVJFCwH1M9m9WjhW4Ri6GGJvFSJqxY0n4BKJ3f
         84eg==
X-Forwarded-Encrypted: i=1; AJvYcCVI1kObf7VTxTOtbLhyqN/g51dYNTpjlU/GGKp9lV9pShCicj9FdJEDzbKJ6HrNgKkKN2iCTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuOR5Gf9L1a2KiA88Bi7xhyyIHaPWZqv5jx37s8yiNXL6cfPhJ
	x6GSMgvZnVYDLs19S474sFaodzkvnlvfYJw6S75Lrjxvy2kobjnk2vOMRMpP29MzXyixoXKxDU5
	BR/Pm948Ao60FmxIOOKRIHQbzGDkrqpefEmfkavw31DXoL13K+fjI6KfGuw==
X-Gm-Gg: ASbGnctzUZoepMWX/XeAmJOg9IzsXhL9w0Dtf/LCTIz13TNY5b60vdAMzK122JiFENO
	7fpevRNSpbdQORr2rqM4u1+ooYns/Q9PKKR2LQQwmOjqZU2pNkSt5Idr5NSJ7FBD6/dwtqnaX+z
	ixsvF9QQL6tdlnOqcyq4t12+PUk3DU8HmsLpPJFvpaKMteyswSC77qIdI//KiiQOjucrKWvQZaZ
	jX3n8PKCN/RspibqTPWhTVOUmWofHtTf3nlLNf4A1KdDtmzST6QbsW5q6jivFY0wToSJ4mgtBzj
	bGYs7V24nmMOMe/Swt21cvJI7+S63tGB7Y9xCsHCK6eXQcd0+tWIAjx42mfux+ws4Hf85nlaIox
	U3QWR+LOlA0GFJIO9io4wuZoIq9R7aTzNp/sWs66X8dSVcEdw6aT86xsp
X-Received: by 2002:a05:622a:2cd:b0:4ed:70bd:d9e2 with SMTP id d75a77b69052e-4ede41f17b2mr892371cf.0.1762942689295;
        Wed, 12 Nov 2025 02:18:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYtQ29X5tXvxSDaU/JA+AKkzXH/dnj2dUKb+nxLC9dFOdNM6v1tgVxXnY84nYUEM2+bTg7cQ==
X-Received: by 2002:a05:622a:2cd:b0:4ed:70bd:d9e2 with SMTP id d75a77b69052e-4ede41f17b2mr892001cf.0.1762942688856;
        Wed, 12 Nov 2025 02:18:08 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eb6sm15397422a12.14.2025.11.12.02.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 02:18:08 -0800 (PST)
Message-ID: <a1273bdf-d926-48b4-877e-48d5ff45e7d9@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 11:18:04 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/21] drm/msm/a6xx: Fix the gemnoc workaround
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
 <20251110-kaana-gpu-support-v2-2-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-2-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4MiBTYWx0ZWRfX0R9EfE3wBiBr
 fy7B4mQccQkS5c0j5VMIVXHOJayPPjTrA0XWRb6N1MA0kFAmFuZdzZT0/L7JEMei4kgK+UyAIo4
 sF8BBHCpZilwBsa1BnNAZVnP9D4ShGnbD/kcZIgYXgIIKFUAX+/jx9w7kMCazNhB3hf+B6WHLLI
 7ry9nzt7hsMjSXm7rh6TdEQ5mvPTAd/namvv3EQLfSuRmveenhwEd6AjrAA3XOGRjdZC5wa44/D
 fvZjDG6N1724RPyVCG0wCQWCAoGgsIhEwr67Yxn+gt3oYGbzlfQ8VtuYzm+CyrsN27lY2vi1gfT
 nkWb2caBy7D6i9gBxO+VCKluvyUwIgm4sZiPLWL39jasYZbgFbf5kxMUg/xBwd5HoMZthnW381S
 8XnGVEjfEwUkqV52UI5AbxUZOG8wrg==
X-Proofpoint-ORIG-GUID: 5sFcBAE0rMxGkwUly9CJ2Gho7d7YBepZ
X-Authority-Analysis: v=2.4 cv=cPztc1eN c=1 sm=1 tr=0 ts=69145ee1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=B6ldIsYNqgrP1okBzpgA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 5sFcBAE0rMxGkwUly9CJ2Gho7d7YBepZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120082

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> Correct the register offset and enable this workaround for all A7x
> and newer GPUs to match the recommendation. Also, downstream does this
> w/a after moving the fence to allow mode. So do the same.

It does so for _notify_slumber(), but not for _pwrctl_suspend() in kgsl,
but in my understanding, making sure the bus arbiter doesn't gate access
first makes more sense

> 
> Fixes: dbfbb376b50c ("drm/msm/a6xx: Add A621 support")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 4e6dc16e4a4c..605bb55de8d5 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -485,8 +485,9 @@ static void a6xx_gemnoc_workaround(struct a6xx_gmu *gmu)
>  	 * in the power down sequence not being fully executed. That in turn can
>  	 * prevent CX_GDSC from collapsing. Assert Qactive to avoid this.
>  	 */
> -	if (adreno_is_a621(adreno_gpu) || adreno_is_7c3(adreno_gpu))
> -		gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, BIT(0));
> +	if (adreno_is_a7xx(adreno_gpu) || (adreno_is_a621(adreno_gpu) ||
> +				adreno_is_7c3(adreno_gpu)))
> +		gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FALNEXT_INTF, BIT(0));

Arghhh copypasta, thanks for catching this!

Konrad
