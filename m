Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C515F439326
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418987; cv=none; b=cPc7m8qWQa64cf9DWusesVecKCBrqcONDQggbLZoy1hIZ89HPi8SGfw+J3IMYvRSPXRiIeTtqShJUIJCiiBT1m6iPHG99U0olYspZ/L8wjLGWjQ3lqJcSwDkVh980U4BXmkQjRTzM5WJ7PatYKf7XUDe6TJJ9EEPUkzo1EfgHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418987; c=relaxed/simple;
	bh=yzhUy4o0mOiRrgJ+9DOMPc8IwPfnEtJ/dCNB3RDvKao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYVgC6okv2SUgZbEXQ1iU+M+h173zf1u5ed6uRpJ+bALtI8tnKqbROATb1bi0oEN8geF2l/fXN8oRo/a4CF30DYwbqJgAxjKBe/m6qB6KIAR45S3u1pmRA3BatXIJpBPHyCEhfjQWIaSCwhWpyt7Mk/eFMBVjQYY8cukz/9NvwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WuBkjEPE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KzyLCIZv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WuBkjEPE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KzyLCIZv"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDeddd1229005
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LIHC0dGoCfL4jo/TTDqxxd8bs6eGi4j6fVBGNZoeJSw=; b=WuBkjEPEQ6+jaMAP
	mb7/eJ2DfGQPN8Y84dNiQ6j+CFSIFrqWAsxwUjY42fZuux0vSgKE4CwYUBxJX4y8
	YW4Lhs5BtJG87JVyfjtLs88SO1AZ9VVRACBDSd1dLjCwmFixdKS+k5Jq8L/SkslP
	dy7pA3v31WKP9bof+R+XetAssoV7ZE4Lakkcg1MI8X0lJ3jGB5a8srg9e6F3+byW
	ZbuW12hYQtj5jkMBvX09jKqK0u8ngTBgksd9BOf1ZQrpL6/nfooMFvXsBvRTHLkC
	ktGGj8VTarBbnRPHMG+yr8jQnddWlMP8CDG+t94qhxht+gDofuOu8d9l73N7yi/E
	UvDZVw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr7q3g0d6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:43:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c27616421so3820111cf.2
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 06:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785418984; x=1786023784; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LIHC0dGoCfL4jo/TTDqxxd8bs6eGi4j6fVBGNZoeJSw=;
        b=KzyLCIZvWjGH8YwvPvDwxtWUO3h1vyRCzTd4yXTHiE8eQm28p2X3m/iSh0akQE/ELP
         g4Kp2SR2q+8W9mXZJDbjkHtjqYfq13Ixh+6Str1Yew1uwhmfg15q5QqE/AFdOldoGNcI
         cHdt2I/cr12Vs9WuF2/aBSzbdpf2GaBOdG76B+piCHioLpw3WzZHXM+qYteQyGs77SHt
         JAU+BGtSioVI95R7KIhvOsWMHU3SW1oDNXJMlNJTEQ034iLYhvElh3TmkX0gOFV+IkZ9
         QN3c+SGfVSKm/Ryd65+5GSOVIbP0qSXuaZgnYaxEXiTQf9dGZ6DRxPu85M47gcvh39u8
         UHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785418984; x=1786023784;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LIHC0dGoCfL4jo/TTDqxxd8bs6eGi4j6fVBGNZoeJSw=;
        b=JPibnrz+ZCyzvPPd4yzzHLMeCrNp0ptG8mZyEMwDA8JuZRpHjhpwru3woOFzt8jQQt
         47fjxdaOxXiGP4DDo0tH15W88J4UprlEJ2wLFKH9yH1q/YYHC+9yFUyNinbOJxxOYkXl
         RyxUJCehNqLriIQb/A6y257dBESCMBrg3Br+Iw3kOEpG2Tps9Cb+XsO5ncQToCkU9II5
         eC7l/jVmcbDV0o6tGP3iUAd6MbtwkG+NZDrhR77N4FoiGJ2PvdcLquIf6ZEGoDVHkpeg
         gyCEryDmR7T7LlZxKJwjDld3ISnVStNFMjSR9WUTOHqW0h8v4yMgXFixhR3FB07gZSZQ
         TmlA==
X-Forwarded-Encrypted: i=1; AHgh+Rq53fmPmXPmdFcqLJqj+okONg5B34p/mMpZ7KarA26r6yvh5askL70C/rR83IlrEYjXy/BARQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTLSAq+eJjnRPxEWDYDFzkz7pHD9uDYw3rXnZwiw+V0NHjMXL8
	X0htdPoTsfIqJVipcreVoeSDe42tBZT0sVtTCoQ7CB3mSuYymVMThob//54ZNWT9PuO6aaIs5fC
	ZNe3GQKVoCYb+lSqD5P81vbAk/Dk1ryBayiEQDhGbxHRdWFN0Vj3yfEB8ag==
X-Gm-Gg: AR+sD13mBDPqf+3ofpMB70B1D3NlezDs8dj8jiJ5Cimui9Q/zRi4dt/DZVJigvVr1Q7
	dAOuBr9dQBO7t5zH88CLVoRhJIhXlSepO7sxKygECol/QvJYGPENTq6d9V7oEKENLtGoTSTPlvx
	bd+qNMi2zEG9dng4nJT4HfBqTfeAFY5REyKQx+kVB8uyfipxBjCZJZ3K2hSFebSGtW9NVKKOHvC
	xg59jPBqoPIelYsm8TWhlz/x9AbLctTjLnNX4sh7AJkHeJkKNbJPH9AnVZRyBwnXPwWzC6PFu9I
	1+KRrFQv27J+mc1v5VliLjtk7KCA+DOC3Bp0baFT6nC5xn7KwDrpELOUNZHnk+sn5cFwzHjuaKs
	lNnyEyZQTN5x2niUAWM4gY4DE
X-Received: by 2002:a05:622a:a98b:20b0:51b:f9e0:87b0 with SMTP id d75a77b69052e-52b42b7f23dmr3221691cf.2.1785418983822;
        Thu, 30 Jul 2026 06:43:03 -0700 (PDT)
X-Received: by 2002:a05:622a:a98b:20b0:51b:f9e0:87b0 with SMTP id d75a77b69052e-52b42b7f23dmr3221211cf.2.1785418983387;
        Thu, 30 Jul 2026 06:43:03 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8b6dbdesm66080166b.36.2026.07.30.06.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 06:43:02 -0700 (PDT)
Message-ID: <8e55ef12-6c4a-42b4-923b-238b3739ea51@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 15:42:58 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/msm: detach the ARM DMA mapping before attaching
 our own domain
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Joerg Roedel <jroedel@suse.de>, Russell King <linux@armlinux.org.uk>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org
References: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
 <20260730-fix-qcom-smmu-v1-3-b12fa067804e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260730-fix-qcom-smmu-v1-3-b12fa067804e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwMyBTYWx0ZWRfXzkKGEf4fFTkm
 mrGQCrJG18g76qctpjfFI5odqqXK3MeEp3brfMKIA7O5hxGAwqkr5uOew5ZcgIfMWbCmEjsufT3
 Zsd1rKYIScjb5yALKK/K3R7Ar2800024Hvn4UXl+WpRTUC6DorbrGbcpDC5OZH7OZgAYsSNFL1b
 8DohnTAPwl9q3NKvvDSitoTYpM2Jw/+wdVNVmcKWbczlIfx9sxQ+PPoO5vrd4ShMQmLwOIXtVRd
 D/EaT+VYC17DPZqiSboxkRMbImsPh3s9skHXGGPdyjQ4RmHH0e27LPzYAzRtv15MH84r2XdDUdD
 LCM18b9PWHg4WvkyaDR+TTblyvV0Yt89fu/KcdLZSHsOOWfMNtpUzinu4vxWWBBlgPAomfvnx1f
 urnm0PbWd1FD6Voy0bQ9TmzR+TJ8tJQrVxyEH8IlEU7XqHxlp109punO07abQtrjP0DRISMJpuV
 je8rFa4KUrCCiXsf0mA==
X-Proofpoint-GUID: SxaRon244rNZfCoi2qbeFbu4VduD14Q_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwMyBTYWx0ZWRfXxbAmZGvBTNhv
 AP/U23BF+L+z0bbm+xJ3Y0KAy64066uilRU/YHzhkzuqUmZdQCbAi5llF8WP35Gwy0P6xPXgkXo
 adfXSLKLfFJxk4dc6qVBqhhQj+7VsCY=
X-Proofpoint-ORIG-GUID: SxaRon244rNZfCoi2qbeFbu4VduD14Q_
X-Authority-Analysis: v=2.4 cv=WuQb99fv c=1 sm=1 tr=0 ts=6a6b54e8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=mSMHI8jCXtBZcuwA1AYA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300103

On 7/30/26 3:29 PM, Dmitry Baryshkov wrote:
> On ARM32 with CONFIG_ARM_DMA_USE_IOMMU, arch_setup_dma_ops() creates a
> dma_iommu_mapping for every IOMMU-backed device and attaches its domain
> to the device's IOMMU group. That domain is neither the group's default
> nor its blocking domain, so when msm_iommu_new() later attaches the
> domain the driver manages itself, __iommu_attach_group() refuses it:

[...]

> +#if defined(CONFIG_ARM_DMA_USE_IOMMU)
> +#include <asm/dma-iommu.h>
> +#else
> +#define arm_iommu_detach_device(...)	({ })
> +#define arm_iommu_release_mapping(...)	({ })
> +#define to_dma_iommu_mapping(dev)	NULL
> +#endif

I see this is prior art, but should we support this config being off?

Konrad
