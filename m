Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC443358C2
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460662; cv=none; b=CIZ+1wCufB8ZVQU4D/zaWOV/Xq36bbzJlKINcaY8YIYgO7z97rI6Zqclv3DdUO70aKeHLwftCh9SeqJIn065wD5JzVhKWBZQ16CGGjHDJFNqfG/T/DP/GrZ/2LLdEtvENRNRTZCRYsVYXW/yvtxIL3kd9nBYOuBL0uALnRzAGDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460662; c=relaxed/simple;
	bh=164cUtNwQ/6MAlPBIz8BZE8izUZJcebmqVBJfuQrG0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uY48ArLLGbuwPHttgYnQ7k7OCw0fuPcNS6XaIp67IeFfGr9pJSl5AM3lZQ5Ru2wmg3EtfAiHLqMiUQpTtekTEK2kZhRXQPtUxU0qUVv+63p1maTFdTRkc1ilvYz8ya3WDEvkV2L6lnCL1/cjNIw9FDg0XBnqpLKo9PGA/auGbTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LSqQmsbI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NCdEPJeS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LSqQmsbI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NCdEPJeS"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI6fOiW2272031
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 10:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U02eh9bqJE1p9hqnUKH0dgcb2ZclOzx3BYb9xwfCu5g=; b=LSqQmsbILJ6n/45d
	G0PmH/9BOI69YrXMtodKs6YirqaoZ8Gg0l3TzZVzCW7VyWa9cwY9blv3gIih+Tpd
	daIM8z7QH2SlY9PJCt1Kl8GFtG5O5pLqGeAUiVAPLzYtKCW3v8kzgWsnIqc2bIED
	NYzMp/HVm1/uekJyJkPS1pNYPLG776nJpT+r1VUy5RzKUvV9/yuf9JrRqYtq6Fse
	5LhZmd1l6aox+BCReTwv5pDOKpRNiWl5kmfQQm07HbY9W81nWZ1ry1rAorUlGAsL
	BIN3oXSErPUb5nMlS6gLTiESr/eMSv1o6RoGFrd3wo8Gww25hRjum2wbT5VLslk2
	p8xjVA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agkrmgmh7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 10:10:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed6a906c52so13871631cf.2
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 02:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763460658; x=1764065458; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U02eh9bqJE1p9hqnUKH0dgcb2ZclOzx3BYb9xwfCu5g=;
        b=NCdEPJeSuj7+befQqRMOQNfH5lRCrVUpzsPngBOV3ZCuQjB8tasA5fnYkydaKK7KNm
         7N+8LETBl8gR/F2m5nrBJoTVfjdXDAWDBixTNqnqcNg03GHUGtAlGPwjckM75MLaXNUF
         HAvb4Ve8o++Ajg+ElbOZ0md7SQcurp1oGN3I6vSMPmjxT+MVv2TYGAfq6XWqQPsw/M6n
         cuGAY/gz48KHIAyjQuEqb0OJWJe3UYzLZpMrCl5Y4isbw6kewCxcSvNNsHQq29/QE2BE
         SlYFVb8sA95vkiDZpkjkTpUzNHLwf39lCTedOdvEfw6JogtO5h9Q8sowaFHfiLnXDHQK
         rjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763460658; x=1764065458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U02eh9bqJE1p9hqnUKH0dgcb2ZclOzx3BYb9xwfCu5g=;
        b=itZ/7iGsrLQmJdDQbz1wFTfxL2Y5pbcG3wFzrafflZOaHLOOX9iLxNzbg0HsOcIKay
         AEcEgb8kK5FVR5pX3gnC8dKlOfjHqU2YR3uqF/zOEdfGeH0VbDYnj4ibOdyiGILIpFpF
         314qaMKin2iHDFLcw8aNYn3dAJiM/PJ8UAY8T2s3S/SNAEhi/1LKHZLasBXMX+F7FyJx
         lGRyzSDNeKYeHxLE+Gmg2pdzjsOZyUGD7SOmkJWngxddgD/bMfd9Vy12uCKUvu8Q2JCx
         nkE6CN6qiBdj8yQ6/uwKU/xIXGd44teBJ2vGVFhWhX/7JYOSGuSFhSK4qK2RifT5NWtp
         GZiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuoCo2pMxl093ruHPKPIRCjS/XUBVlknX0Jy+JrZUxGQbMjxRSr17UnWlh0gNiKdEGngZKvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1WVrMy8NWFJTpsU3zVHqj3BNMiviYeciIbQz1zeaS87PCjQWN
	f6BPWe0sviSmXa3XwxuVPwdwRc4dKVtuaHpgP2DGpaxLLOM3C+OlWa1Rku1umelbQAoPNAMbREy
	SOoampFfNa7fKtf7ZrBOe6RuGncwpSOWgMoK8IlAK4Pc2we9S0s9AEnkPvQ==
X-Gm-Gg: ASbGncsPmzMLAvkhWYNaNj6sDlxKhEZ86lweDROaiDq1SbwzdphOQZyxEw3wyAKNm+W
	5I7n6w9xe5waTVwNraEMrSMqFLKIUZiQhP9PUhndCHQNJOa07QshGo1nRJwk0v87BrOvyO3Pkax
	DShnt4PaE0/c+KONZzhjXzjkVluS5GagjqUsgKiISjrnNNPVa8GGpyI9wFDsoVHcyPf3H6aQrD2
	U5lSkJOvCQx4ZPzaFdfkysw9VxYDXl0lfR2JYZ1mBjaydAKdli0xwDvk4sckFcMSJ/1L5UzP+9r
	CJWMPSCBV+XXfpyMq2ylQNwVjXitLFUk1SKZfHuwCa9Mvo1RnjN/GYgH0EmsleO9lEV76awJysj
	kkA5wsXM6XDnK9ZC59y9egVYuTwiLM8GgD56Ar5ooe3XRBxDNpGBnYdy881RE4oyAX7M=
X-Received: by 2002:a05:622a:20c:b0:4ed:b409:ca27 with SMTP id d75a77b69052e-4ee3182237fmr20160261cf.10.1763460658051;
        Tue, 18 Nov 2025 02:10:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHz4Ftkem+yYtF3nOBOFFpkdhV6ZE7GbZunxdHTdiyocnrRN9QBCgvxmaVDrzMTewaoOz9MgQ==
X-Received: by 2002:a05:622a:20c:b0:4ed:b409:ca27 with SMTP id d75a77b69052e-4ee3182237fmr20159971cf.10.1763460657671;
        Tue, 18 Nov 2025 02:10:57 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-644f13ff4d4sm2997956a12.12.2025.11.18.02.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 02:10:57 -0800 (PST)
Message-ID: <1c438a94-fc9d-4322-918c-b6ec1a4cc5a0@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 11:10:53 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/22] drm/msm/adreno: Support AQE engine
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
References: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com>
 <20251118-kaana-gpu-support-v4-15-86eeb8e93fb6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251118-kaana-gpu-support-v4-15-86eeb8e93fb6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA4MSBTYWx0ZWRfX4xKSfJAPA3vK
 HNx5aga6U4N/bpDeip8LVzC+qW2V7Rl2zAlJk0fh52F6VYH1lM1GtNSSAfs6WVSvBhNHHyduRc9
 hPoVq4WMlcduL3ZP/VKQmwCKG3F7XDWicfK9cFLKcm3agBSxQwquZIh0CN6H61kYBZcF1GsASEG
 U+bxaOijbSV1s2IRiBnn0j/Ih+DJEniwo7av0vGsSxTv/41icRwl/dwpJNLT9ZqbXt09Cp9Yb+f
 xg248cM2AvulIcPLjsr2cRlGPQeG34yeRmV2139UtkikjEwwbcdHHIMKj64M/iis/EPK7qOf0XL
 R0TEDsBXduuxKTK3pUb2jRWPk/T4+DxkuNANJQL62rcmvDL31hFOr+d88RNtRxTTFN46bAp2gKy
 z1ZmG4MunzJ4EoYBUFieE8/CNmZx8Q==
X-Proofpoint-ORIG-GUID: bkzrLOpenyV0IUh1-YekP_S-hwpUOzOw
X-Proofpoint-GUID: bkzrLOpenyV0IUh1-YekP_S-hwpUOzOw
X-Authority-Analysis: v=2.4 cv=JfWxbEKV c=1 sm=1 tr=0 ts=691c4632 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=GtNZTxoBlHEkV55hDasA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180081

On 11/18/25 9:50 AM, Akhil P Oommen wrote:
> AQE (Applicaton Qrisc Engine) is a dedicated core inside CP which aides
> in Raytracing related workloads. Add support for loading the AQE firmware
> and initialize the necessary registers.
> 
> Since AQE engine has dependency on preemption context records, expose
> Raytracing support to userspace only when preemption is enabled.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
