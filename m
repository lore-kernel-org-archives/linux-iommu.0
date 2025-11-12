Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C472F9984
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942071; cv=none; b=sAlGQqWjvPo5qG0OCSkVZdYcqdtQV4PDl3WIOo/UgX1bpLAHY8YwwKJ9c9K+qtYDoEnZyNzXegJl/aEt+hiZPUSNbgxeJi/UTtomtxGAHoCoO86PEVkgK/xE+RJ1Jht0yQ8fIsT97YKrj16WC1Oc5222Z2+FBD6ssDNNJ7eRc2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942071; c=relaxed/simple;
	bh=TVAcGPnABcNOszTgcAJl5hDoV/qMbNyV12hdTLLHVSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5/mxoYNw7y/rRPyOvdPvChylymsIG2O3G3oe3ai787NzOnGsGLbIeHmVM7dsiRY71aGcJ+zxyTRR43H7Hy/8Zuru51eDoirHQzPB2tA80jlxX8fTIPgikM1GercH/vR3B/3yeoLruhZPRchr1GT/lfNpYoKbKUYsVp1YmEsng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kAGdreiM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mi63Y2vm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kAGdreiM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mi63Y2vm"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9gLC1960179
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 10:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5tMUAPHj3MTUC9Ymia6xtrQkXoeMohe0oVZfqEDumFs=; b=kAGdreiMYqZZcG2C
	a0uUG51Xyaex5zm8dEzDifgrYM5roPuhPx6kulk58BS+3W4TQOgTjoDq/LETD+5v
	toGP7tnj8cm8v2VOP+Lz/IpXCakCM90iM38mvClvDOeFEsYdpaWGBXd1aHjxLjpp
	AG2iXmEwEz9WwP5KH0yLT47UkP4ZycamLGgCsOVpOXREEsSXGEPofqjIuh1/A6cl
	8LeM5ogKJJzUCQJLJcS3TvjBK/3S3BtpOkBOzEhYPUkaFk6OcMno02VIYZ06WDsx
	ptIuEYHOCgcE0bzK3p9fTf3uJs5R1wFxbW1ukttPz3Fs2uSqO/F6CPSlVCgrZfQs
	ttvkZA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acquer3v7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 10:07:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edb714b16aso1658491cf.0
        for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 02:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762942068; x=1763546868; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5tMUAPHj3MTUC9Ymia6xtrQkXoeMohe0oVZfqEDumFs=;
        b=Mi63Y2vm/Mr6mliClQpyxUnU+xrRu/RfTeROCcuUeBG2kU4lkjVqrDUzdqBAYoNNhE
         /NfrWG8cHEo7ATNEfAZ7PVh2CSu/fjBNWTicraFR/Ajj0m4Hvui2wEFaHSC/rRhgY6dj
         60TbSpOFHMBM4pJavh6i14+morEzYYGPtWN/jJ7VtaH2jDYdgqJTZkb3oTG4tmkCA3nI
         K1awvwJPsMoM56JUPQ9tkBnVGVOwiDdpzGDUXhKv9vjg9Ig4tv45slC8rsZ9erwAPdg8
         Xcsre8T7DvBk3P2mX8p6WRWdPgFFeadzL9NVFAWYEvqWHE9a07MvwKgjVhL/J1cMsTTN
         DIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762942068; x=1763546868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tMUAPHj3MTUC9Ymia6xtrQkXoeMohe0oVZfqEDumFs=;
        b=HCDDDaOadDQyfga8T1gcJn7y+IdZzrlm4iiC5CUUGyI7oV2Ts/Jz1VA2U9z0kHJnYH
         dL5bepHeTNb56LEgRNIZSHmzXTuz1zfcgetAg36Nggf4+iJkpUpy2Ig5J5BAIzyLJTHl
         sDvDvkhHXIO5dQHQpcjKv484eALdPUBzVj692ckqPp30X5MxWAy1xJQ1WSSsnkxue5gU
         /syDR19TrFJDFDTSb3/gF/GlCqScH2QDYLLjR1VbCfSWzNuRhdafmWiktefLl5p7tkFV
         tXxgR9uwcxN91UtOD8B7iUvKHmTxejLcUxWL5WIyFNhIXox+YX1ivU2K8zhzfkc8EgX4
         5aVw==
X-Forwarded-Encrypted: i=1; AJvYcCWj2lb7TAjIvr1cE4HlHkudkxKa8RDThbn5v+LLXsbMkMWYr0b1oVTEvdTOBLDdcciQF0/4hg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8KzFiIM7XpES9JfrveS9V91jTUEJ0NOtLVbZIykw/4bW2G84W
	C782bF4SYzw69ucA7ht4HxImwMSDhEK4HUmwZ4JQl9zbkTOcovXRw2NxmAOLc957QDreGIpXzkz
	bDtbEI8etb0PwlZG0uAPkFF/yqkMGqtUgJKLxc0v1xNql0Aia1w/amS9kZw==
X-Gm-Gg: ASbGncu/wwDOQw7dXwsBQqgH34XWyslESeg1AzAHG715VAxVINkiGxQNIAJMjwiNzcx
	5nZKEsyMm1tj0e6w20OxGEppLjwTpPstbiz5W7zrCOVXLlamTbYKWORX7VQ7sFsiB2Wan2t1rhu
	17e6CfhrdyDDnb+86JfiIuYj5k3DSlTxm9l1If09bOPpyribgalT7gzSms8Jf1nXs08qLOlwFmh
	Z+xZIGAeugUq8aw+cLV9yFXwu5u0EI7Rw5FIb25tPEEI/mLkQqAf6pqBlA+dwZNYb13V2/Tr+aW
	bc9noKAzv44eMxS9P+B6SQdIANn0ieuHd/SM4WfHFNIfVOZf4w0ka3QkxK2B9qqPKgQx4yozK8U
	S9Xojdlb8ElvUYXmksZFSs/NXq7hgKUtQ2kc1Ic+fu1Om+gBQA14umVRb
X-Received: by 2002:a05:622a:18a2:b0:4e8:90f4:c3aa with SMTP id d75a77b69052e-4eddbdad648mr18859691cf.8.1762942068448;
        Wed, 12 Nov 2025 02:07:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd6taWWH3kgb8r8uxKAXxyDkXj9rB9AL10HGL6oyqqdNWof71H5ltc/gx7kawJfP1MWxxJCw==
X-Received: by 2002:a05:622a:18a2:b0:4e8:90f4:c3aa with SMTP id d75a77b69052e-4eddbdad648mr18859471cf.8.1762942067993;
        Wed, 12 Nov 2025 02:07:47 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72d3baf872sm1427413366b.27.2025.11.12.02.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 02:07:47 -0800 (PST)
Message-ID: <da9e9d31-7745-4eb6-ac24-50905dc2a133@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 11:07:43 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/21] drm/msm/a6xx: Flush LRZ cache before PT switch
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
 <20251110-kaana-gpu-support-v2-1-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-1-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4MSBTYWx0ZWRfX6Y0Dz74VGhu5
 Lp79A9bnEE2HDxPxQMBMMVviY2dyMS9ZYbEEz76WlANpV19Vl6weNMfcyRkgJN/0g5sbWq6xebV
 wHW5AwW83mrF7Suh1WONRU0zfO6mYjPHGkl1aTgTHy06CuMgguGbXXaQKNVJfoiJHaug9yw8Mwn
 W9u5OIIT4y71LznrDI+ANLluSYCBKygbGwvXvyoL8SN1J7+fGkDtvARYyjKnadD6gcMgngGwI1G
 tzHFE5cntEgO7GoEizbyNjdj7jfH3pzwyX1hEsuosRXvloKlkjCy4QhNhW6wrLPOlqXNroO26cv
 sJabKWjOBYyw21gn6rUcyp/eTtoN1l+AFeCB7BD/pHjVKv3CNue0CqeLr+gaDzRGEjRg/rbziID
 YDnvmSkm/5mf+8uuV0dM/JUCh3LfZw==
X-Proofpoint-ORIG-GUID: gAuiGVdXGpW-D548huIVo-7qbXUznfej
X-Authority-Analysis: v=2.4 cv=cPztc1eN c=1 sm=1 tr=0 ts=69145c75 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=FVkm2KtGXHSZZ5XTrLgA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: gAuiGVdXGpW-D548huIVo-7qbXUznfej
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120081

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> As per the recommendation, A7x and newer GPUs should flush the LRZ cache
> before switching the pagetable. Update a6xx_set_pagetable() to do this.
> While we are at it, sync both BV and BR before issuing  a
> CP_RESET_CONTEXT_STATE command, to match the downstream sequence.
> 
> Fixes: af66706accdf ("drm/msm/a6xx: Add skeleton A7xx support")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index b8f8ae940b55..6f7ed07670b1 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -224,7 +224,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
>  		OUT_RING(ring, submit->seqno - 1);
>  
>  		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
> -		OUT_RING(ring, CP_SET_THREAD_BOTH);
> +		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
>  
>  		/* Reset state used to synchronize BR and BV */
>  		OUT_PKT7(ring, CP_RESET_CONTEXT_STATE, 1);
> @@ -235,7 +235,13 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
>  			 CP_RESET_CONTEXT_STATE_0_RESET_GLOBAL_LOCAL_TS);
>  
>  		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
> -		OUT_RING(ring, CP_SET_THREAD_BR);
> +		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);

IIUC downstream doesn't sync here since there's a sync after the LRZ
flush, but I don't think that's a meaningful difference.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
