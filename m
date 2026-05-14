Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED493C0A15
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762647; cv=none; b=EqltGPouuLBRYfwiqfkKH4lBbqECzVQ5I881r/mcj9cCQCx86Q3HLe8Jfj6iE3xuOeLu3ivAcdLzOTKvT12DL0rtJxwgab53Xga5yJ/s2ZiBWOYjhyQyFBaB+GGIg4V5Idg2yIVbaF8fNVC7917CAF+QYGrcIkNVqGk4CapGbC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762647; c=relaxed/simple;
	bh=DcIPXR/xIFPytsBGJRYa6g9YSH+zqLKVAKufUlxLhYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/4g3P8E03fcdWbG3IhA6E2C3C/BWT/GtDndpN/6bD8ykgpioYfW0hNikdo6mS259Mri+phtxYk/F5j/EmUcbOzxJ4FC1lMTZ7D4XF200j3SJ8QksC4DuNmZa+kMSwAPM4HigCPn9QOWqwzOManQswNrbj+QZ8AGYYvR69DpxQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P9O0Crni; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J9H14hq6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P9O0Crni";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J9H14hq6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBeU3J2241699
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 12:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rAvsMuwZV4ckNzcq8kycV+c90RKc2YlbhdiothPSIhI=; b=P9O0CrniShmq3Pj3
	iA3WD2SZI1Hycq79Apgxw1n9nuht/0Fgw+utcmQggHJkn2eiqsVoJY1qSiV5zEgb
	LLF1lBFVB2vtjBwsIpDrIvlCv5tL+5Vsw3HWBAn/9v3pMn+NiOKf6m31VUtp2qDb
	XR6oSmqq5fhg+QpNWHXbrEB9LlYmmpVEi4pvP9NfiBRCjyuGC/pzUXOYPklNnAj9
	p5Bwce3oS79TsLxZnX5MZUjSVz3AuXSpKb0eg70Z1a85XSHCMDNWJ7TzVR0al0DY
	PvkY099ekYKVzFO+8YtJPwF2lfxAAVa/TVTMD91m9C90j/40wPOiABA6llH9PS7l
	QUB8Tw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e513gan5f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 12:44:05 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6313443ffa2so545959137.2
        for <iommu@lists.linux.dev>; Thu, 14 May 2026 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778762644; x=1779367444; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rAvsMuwZV4ckNzcq8kycV+c90RKc2YlbhdiothPSIhI=;
        b=J9H14hq6Guza5JZANOnw7+xfn9dMLfK4S70KPyTCC7vIvnvVdH3acF3O2LF67oYzyk
         kZIjRp6fTZ6L3yEuvhYp3oREprXhpY6V8+1HyHG8x8FZ6poHQMjqKUQ6fVnSjdPDEf+7
         j3hwvllhzRKjzYV0Dmp6INXolThLOxp0o8QmoUZU0v61egN4Az7VkYU+IbilGr+D3iBn
         aTBxvLU3HuEDWnh1MKoKedKdoHjmzMLZa5oZzFL3Vln7fagEM1j3Qh5dG7AfftURmMCR
         Nu6pADpBg28ULWGUd0pUJo8XNHGm6+Z5BS2NWCPXabnQ1fQztWTHWsd0mC6VN59S19a5
         eWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778762644; x=1779367444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAvsMuwZV4ckNzcq8kycV+c90RKc2YlbhdiothPSIhI=;
        b=jTRaWCbC5Epz4XPuhjxGcFpENh7596e9qjlzJegbVVRS6/b7gzBb1rNH6XGOJszMHc
         QofkDrHKIh2TqdcOX5sSMX/6YsHwmA0noLWDn/wa1NY2ykRICR9j0s7WtuvTegXvsvL0
         YLtGddZBWqPugISGlfbB7pGRoQFkaGLCH9Jqp7aKb3vE2aesFs0YzUYLVmf05ATJ902y
         b1a5m6Eg8OgJ6E3f387QoF1eqOxa6UtUSSpqdPTc4iczvkbgEJXpafiUYUX5cEddhNmx
         GHRGuh35QklqsgUGB6JZHOJc7Hlv6ga/cDjbsDeu+OYmfIm8ymWul62C+WmORYQP2gbr
         2YnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Y3Ib/t9DSJNN9HYFRY5lTOrm8Vf742xMQO8wM1mStgHi+VDcXM+yF96F2a+g+Rm7dmO2/pA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLRdGnPiUF27ziyQmJOaZ+Lc1YzAgeXUNzR4qKzXe2nXlODpQP
	lwDVj7xB4FJjvC+cpgdWD3blyIQ+Dfrv4VnNc/cH99IO6fj6DQOZGF1JQSOu8t07JW2btSjhBiQ
	AuLVfsbIG7XGZ1cdS+/Azt3OcqX72ejJv9opbb7RLF4vrZw/o0jRQRxSuQA==
X-Gm-Gg: Acq92OHMWwaa6XuxX7xs4CL2Djm7D9nH1WWYJUT+qFevjkYl9RPcVfnxE3Fho0AJG5H
	G/sBCbIJiLPUbYhVt43QjHDtCMgEFFlu+no/QUShO+WGgOB/m4tGL9+irUN+HqD2jDy2zI43SQV
	W251rezId5qPmtU5s8YmPmuJaSmA39wNjbuMl/btnhKBgUxE8n0qylIiMTKitGLR2YRQLXxq9F1
	H4+LGCq1/DpQ6J3PV/p3i6Zo1lLoPyiWoYgfMV7q10lBbNu14RbyQcPEHLBh0+nkJ/ilh35oF4t
	blgtH7/I9rGhlWoNLvwi6IzX/6D6j32IOpv/2A4p7qXPYrNgxrEUlVE/TyHLS3WguZBWjUEcDLE
	L6V5FUmubPnGnvb+OtTqszylzALunxW7OC3JOsmOuDuqWa00VcyYF/dsVVWAjDQ/SwmsDeQmgtF
	1djDpt1JTwQpeqdQ==
X-Received: by 2002:a05:6102:308e:b0:631:3ccc:42df with SMTP id ada2fe7eead31-637750e0095mr1201554137.3.1778762644578;
        Thu, 14 May 2026 05:44:04 -0700 (PDT)
X-Received: by 2002:a05:6102:308e:b0:631:3ccc:42df with SMTP id ada2fe7eead31-637750e0095mr1201528137.3.1778762644167;
        Thu, 14 May 2026 05:44:04 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c24178sm87039266b.15.2026.05.14.05.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 05:44:03 -0700 (PDT)
Message-ID: <f0cd7431-acc3-4468-a2ce-7e44a915472f@oss.qualcomm.com>
Date: Thu, 14 May 2026 14:44:00 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] arm64: dts: qcom: kaanapali: Add qfprom node
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-4-13e1c07c2050@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-4-13e1c07c2050@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEyNyBTYWx0ZWRfX9VYvMf1nVe1w
 483cN+sb6zDfdYCcnwonFf0lS2YNhc48vgnwl5B5r/9f+w3ZXgmRIZcbTGSxm5VsiHlCME7SKC2
 6/Hji7Ph4QdkRBRBopk4rrl3BTGw6/ngXkpcEAv5Y2/AXTZGTxrNMWR32RAIv0G+UlBlME1iE+H
 EUXT8iNdNBdHjRP1/Ab1Mep7AVYPrHE4Zh9DigYLBAhh6RXwijPQAyni38ECekwoWb0UUjSAqcO
 hes7EO7AdeIN5kJL1wnviK2Lu7zCMvpe/yk0+zptEx958aonlF7cq50XiGiBb0jZyG8Vado4qjY
 OAu6WxkpkKnrHNRMM0vgh5xJZGRUOm7D79hmE8Ahm6UaC+R0Lk8v1/pf5zjUUVxLbMJDQ7SoFCP
 IZRldQ6vr1gNm641zD3mqpcaHVetY0rFRxLx2TyINr9hO09in/W7gX9z+OTSZKwxT1Fp3RNE7Xk
 ILeY/k1WYvGi2VgIFHw==
X-Proofpoint-ORIG-GUID: 8pdVRr6_PoodMR7FGN0MyQBIYEsnH-17
X-Authority-Analysis: v=2.4 cv=Iba3n2qa c=1 sm=1 tr=0 ts=6a05c395 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=_Tv7ClR51sp9MY50WFAA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: 8pdVRr6_PoodMR7FGN0MyQBIYEsnH-17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140127

On 5/12/26 12:23 AM, Akhil P Oommen wrote:
> From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> 
> Add the qfprom node and gpu related subnodes on Kaanapali SoC.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
