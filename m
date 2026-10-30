Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365810;
	b=czCMzW+Z86gSOE3AmQkxsgPR97YHF8NA6xVylE0UvJzuG/i2stQjXclBQtKPlx9DdzR6
	 vOoXDZwEb5ON1zVPmWjQwz3Faa3OkEGcD91Z/HJ1YT5b7S9ME+smAaU3ph9E2ElQwAQUe
	 U8oVakgZ98JC9gUXU1FVKGQpNoPMhRRpYH1PVbCKZGflaa5e3xXx061vhE/AElqnsJ82j
	 7r75rdjSCsO6+wZFRc3THGeq+zPrwA8sTEVgFoRF1FdlY4YqvYJvbOQI8HHVTo/AIZfJF
	 F1wOFIWgt9ZevbMfvibASURcb9Vhfp7SrWYtXu76GAOhKLY5l9GQ+yRKQQSKFWQkjtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365810;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ywCvlXy/LXKFqaxptvjDdPHYZDdYq6KYRB/vMQRsu30=;
	b=AOFQUTrna3oG3Hq6XjGpEjyLKg+p74I3Ssm7fySAz7+urIbl4Gb8QiNkaMLzUFKm4ugO
	 gENXXJc8P+JKcxSe6LLHAS6Gc65tB4fa1hIxDLkVmSWtoQBwP1HYMKSK13cpMLkk2DBnk
	 LEghcfMvMitPzptgEABq9oFno5P/JyN89Dyo/EzFqZ/ZOyglG73fPY2tl1bjd9rEVpX2d
	 nj9wxBeb9JQeu8s/xgRMCdG6lSZvnl82NJMj5ticCy3W6ap9rPGwHtzmxEo79xByiNFDm
	 bF2ft5BFpbnk8mb3+lCGiQvwMM0GrggnJLn/TsdyeFNzeDv/dx2UiUJ/AyYKO7KObkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tjw7LyIU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jP5wIF1s;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF9606A326
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 13:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDCF9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tjw7LyIU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jP5wIF1s
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBGKYp3130276
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 13:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ywCvlXy/LXKFqaxptvjDdPHYZDdYq6KYRB/vMQRsu30=; b=Tjw7LyIUXUz7kTQZ
	nHbzHNDytvKwXF7h6fO5R0T7IGPnebTHUPziPf71DnEPsGCP2xg9JiDcZ1BPoF90
	ZFknm9PD/jcRLyWOM9Bn7r2tH5j/hZ7yciCwnxuOnWzEWRVCQiWBIuqkuDN6liSm
	XcRVQZHfLXOydwZa0+rGTK4AalyAr4Ru73e7YYqk4ui4CsnextGljDS09InSXzEF
	frM17HOq+y6Fnki1ziT8eLNBb3LcOZaEafigxUN9sUEI7OZYOqkgwm4XsGDdspzz
	2Qh7ecy6OODRietSmf6tl9TMvx8gHcAinVyJJJox+NZEiitxIZTC7HWS9oQ9qPOE
	msN7aA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qk3w6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 13:10:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f3960dca5so5413185a.0
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 06:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793365808; x=1793970608; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ywCvlXy/LXKFqaxptvjDdPHYZDdYq6KYRB/vMQRsu30=;
        b=jP5wIF1sJTi81WLGwv+qcqBj127lpNWqI4eseyGe8FfLuV+1sqdg3DBLvl6rR9IWLc
         /yd8KTc6JS3WqmrNokiOEd722HOyVQ+QfKycBeEgwBoPL1yjNSPYYHnsKGcZfd7p4k1S
         1YabW9sJOJ2AsubixxFpHY85YanmNnjhKX9BCDX7HbEPXwSa+FZyocHX0Gltuy9lG3VA
         QZFPVJ+baUMCVWZiW52nwPE+taE3dc+U/PhRILSk8E1g17qh3ApO7C8FMl8s6vzkk2iC
         IWQ3AEZno+ivV+EKWobsp8EYlupptLrOC3kkRw/Rffz/cVe86rS7v6sq7R2YprozJtXr
         3BMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793365808; x=1793970608;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ywCvlXy/LXKFqaxptvjDdPHYZDdYq6KYRB/vMQRsu30=;
        b=GS+4qRZmYIN3zILVH2giWlmN8W/IBLvgUEsjNiHkFTYpBF6SsqtxgBj5JjssqZl4mi
         2Oicse1Q2vE/exbs/ZU3O3pfrqLtUcbjDq7z8vyYNzOnUxEF8ukTeX8l+GmzlMtrKp+E
         GLe4J3q/D96qrnNX3LaRecJRHq/sI05l4kGzQkZnitxFA98dddBb2nCRmNeFBwNMGr2i
         bUERbOn71wxmpvaO7Kxt1p4vNNjXf45WezAq/PEnH6rxtR9jeW3ByQUa/IjWExBqjXiO
         uAMCxM6CFnoatrHaVoKiZCdeQpvXdimLnsg1Gx1rOp+GIeA3sT7VXYuSQ8ruwdNPA/Pq
         lfAQ==
X-Gm-Message-State: AFq9FYIfUmP+BS9C1xguMMS5MRHnGhGt26hA3wh33tiYy8X9snm+y+Q8
	xRnryhTXmt7Op+dGcM0fenMeJUWNrKurZxrBu8g00fNO7bPI7h3ogUU/quAcnsTBlhYMaT0gapV
	t8gX+zPGrW+NdPX4SP18ka4JAXCF0yq8mfYg/XPfsO2kdKZC0BQTtoTV+Yw==
X-Gm-Gg: AYBFou1tGEcWyG846EDKevlpWBpLfTublAIG4gE/IUKPdmSLgUPMXbP/q+2Wp7LCIox
	s9tMrJmKE42BMoQEvQ66NYVxbZS8wDHHxfJgCFqnmougoMalgyLVWYAnfEe3/Gx5jxJMxlqAkI+
	9tGHlseUY8mKUmiZ9Wwhm4peHArFmg8yFsD6tz3ykXmXVIpipQMegdt3GYUIhmwVosyap/nSxXM
	esP96J7XMyyHJ65C6cckluRSTa+77AX3BM9Yzxmtr1M0EIhCqBUxYQIPjXPmDNhoudyTmt0BrMM
	BQo0oStsIfs+lxMoUroqIjMOoBGwm47hxU5+h85nrxZKpb5zN0YoT6oEEfX7bWVxwIyvxSmthj3
	mduDJYMENkrUKn+zbm3K1Df2EJFpbbyjBAlD1XekBo0b0Krp8grqEkbo8ptvrebgMiFxoa5A=
X-Received: by 2002:a05:620a:870e:10b0:940:f21a:eb64 with SMTP id af79cd13be357-944216f3e4amr392367085a.5.1793365807953;
        Fri, 30 Oct 2026 06:10:07 -0700 (PDT)
X-Received: by 2002:a05:620a:870e:10b0:940:f21a:eb64 with SMTP id af79cd13be357-944216f3e4amr392359485a.5.1793365807359;
        Fri, 30 Oct 2026 06:10:07 -0700 (PDT)
Received: from [10.169.205.110] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabc174d0sm65887066b.4.2026.10.30.06.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 06:10:05 -0700 (PDT)
Message-ID: <4f6e1534-5105-4a4a-83e6-4b2b846b67f9@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 14:10:01 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 04/14] arm64: dts: qcom: sm8650: move smmu sid 1 to
 new lpac device
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
 <20261029-descriptive-name-lpac-upstream-v2-4-a21a5c850961@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-4-a21a5c850961@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: D0iHNXn69Yru0ShUmqdDA5Jb_XVOWZ6b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MiBTYWx0ZWRfX9vAv2hPvIRQE
 z7rb5fnKtgml2z8agBxaO0mKdYzVKvDIa4FGEHg35sQuveVbGMg4kr51VucDZulB2KyR5O+GcRB
 SqKhyvJiLpfsgog5n3aMBYtpqr0FV/E=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae49730 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=7uVtGDAPqmP0Npu4MUQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: D0iHNXn69Yru0ShUmqdDA5Jb_XVOWZ6b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MiBTYWx0ZWRfX6sW8IGn+Ei6Q
 GRoMsBU9Mi4uaECZNwEibKmDPIy9qUopskVnwVaNXgMf3AJ/qIlxPqFSPzUGmAi1L2qKYnB+W34
 j6wBLDm7zTu5h9JZLM7unKSYLnRMAY5zkpGv7Zslnif2Lc8kj5tUjrZA2H/z828y6C0FUcJ1Q6k
 mfdXEq0cMszpIcXnWEInushPNUdCOeXMthnnpMG8vlCZxWDzqvNGM+uZ9Be8TqdAZh9TNjUOL0H
 mPIqiRlPc1+UYds8JCdLdT++0Y3A3WDNmUN8wMJcNIgA0fI4Cza70MtM7eivkmx7jKaaNmYwXZ2
 Ar1g64/IVXJ0nXZnRLikd5gu3iN0dwtKb8QZGSqxTJ1gMXrgi8+0LJ0PqD1N0p90rz8a3g5Ikm2
 vnplZk1eoS82buCZTo18ZrZ/3oWOnVtNd0KeNLxR/LKWKquaWE+WlHzKs+mkPANFsEp6KOXxOxs
 uYb16bXoFGkKesY0BRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300052

On 10/29/26 2:52 PM, Anna Maniscalco wrote:
> Previously both SID 0 and 1 where associated with the same domain.
> 
> When LPAC is not used this is needed so firmware can acces memory when
> initializing using the same page table as GFX.
> 
> To use LPAC however we need to move SID 1 to a different device.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 1604bc8cff37..f47d1dbd06da 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -4144,8 +4144,7 @@ gpu: gpu@3d00000 {
>  
>  			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH 0>;
>  
> -			iommus = <&adreno_smmu 0 0x0>,
> -				 <&adreno_smmu 1 0x0>;
> +			iommus = <&adreno_smmu 0 0x0>;
>  
>  			operating-points-v2 = <&gpu_opp_table>;
>  
> @@ -4158,6 +4157,12 @@ gpu: gpu@3d00000 {
>  
>  			status = "disabled";
>  
> +			lpac: lpac {
> +				compatible = "qcom,lpac";

I'm debating what to do with the compatible here.. On one hand they
shouldn't be generic (should be soc hw specific instead, but that
feels a little overkill here) and it may be that we even don't need
one, but the iommu driver needs to know what we need a 1:1 mapping
hmm..

Konrad

> +
> +				iommus = <&adreno_smmu 1 0x0>;
> +			};
> +
>  			gpu_zap_shader: zap-shader {
>  				memory-region = <&gpu_micro_code_mem>;
>  			};
> 
