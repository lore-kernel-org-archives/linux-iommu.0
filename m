Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BA03F4DD6
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327264; cv=none; b=m5HdN5R97C72UPOHB58AnyKpnSFMuN68NdYdols5AHx4FbQtwj45gCzgCxsXj1E2GzIZWur3P/5xdkBjXb5agKIxWDsE6GF3daMV7DG6gRQMXIwGis/curvLyoZQT12XLO0J/LgaQhfQJLha79hJGYxg7zvl3+y7+Yr0c+1tH1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327264; c=relaxed/simple;
	bh=7HIufWt9gVRK5+mC+4O9yuMIN8y+dLQ4wRKFYCYSneM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c593uKNhLEtPt+KiIitOAIF2Fc/7MsUpY1ZJqfLn+xnCDutEITLCWQbkydJxClN6Da8eG40UHpUaeu12rLU3ap/PIFgJ+qsMBJY5MudoImNb/r73H8WbZ2ImYOGVZKLJRzTKHrrWH8M3VhLmsbipsOKRMn+nAGKxsZQcoQKZNyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bq1jokot; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DxX0Cka1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bq1jokot";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DxX0Cka1"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641fup3470549
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 08:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fzwaTdZYc5k39HsbyB8BJpnbkvc/a1QYt9rl+x/9154=; b=Bq1jokotQ2I1ybSW
	pG8Vbjp5cmexg06ZgOo7HnUcdoz++VQPK9jPrlOoDYzoLaJSiP00gdk3RZV0dGdl
	HcnOpMe8UkqIBbOu3ID5mXiOSHkWrGbn/o4RaCjxI7TUE3YgSMVyeOJwObJIZWFS
	L6e5Dw8FpN9uUp9oYfh03/1X7e1Pt8FYvReYZBaqUJaha7/g0J1nEXVeTp/lerEH
	7XARdYrlxEjVDcYf3Fy6sF1V4rU6mnKUJk05/6VmOOVk7oPy1wh80CgeekGFEm9o
	MGKW5oA9Usfw+0K616ZdPkKF8aVVNyBILDw3nWtqR7P0oqKYiMrsCQD7d8G0vY2b
	yeRsBg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txen76b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 08:40:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c27616421so10803831cf.2
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 01:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783327250; x=1783932050; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fzwaTdZYc5k39HsbyB8BJpnbkvc/a1QYt9rl+x/9154=;
        b=DxX0Cka18zLSnnZNRTuqLwEIj5BSfJkbP81CLHWPNjILcIQ9S1OUtNGGtP9NSl+8Jc
         vUjrjQOihocC8M9gaBlQG0YfEob+JEeVn8/fvux+f3NizML4hVfraaZaor3ZIy7RgEAD
         +VG2L/iGF/dTTxnmVn3EC6VBUgPfLBXa/qXmbuzpfgAJsiM0by05arL1Oph8zms6mnaq
         uKwiM8FYGhiOVkU8LV21DasB6LPb+34OkRxQq3tC0xtkfeWSER1OLnN+MRDhhRkR0YOZ
         +nfTVUBBgGvlVh9oUmaRCtwZUW0mtKcnX3eH5L9TS52C+gEWvVi2GogF3xgbN8X0D4OU
         skkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783327250; x=1783932050;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fzwaTdZYc5k39HsbyB8BJpnbkvc/a1QYt9rl+x/9154=;
        b=OrLql963RcMZ8asXN6BUeHdIch69PijUVkDKjw79hkdkXWn5Vuevk1qtrtsgdH0dE2
         5na4koJd17LAwjkySpBqVxYBFW6WX1ZemcqaB0NHL4j+Cme8Ds1mzzDYplWi1gwFs1ei
         hWVm3p+q9QPBLFi2U5oRYT1BThFr46RyNve50y9+mw9SZ23u+EjEey1YiqT47/ZT+OaH
         SKwl7w78lpl9xMkg3GkXTMexLvR6DIYI91atyTS5Sk3yJLGYVUfztuBBqJ/BBzZZPQAy
         1DvYLnw7QcjYYX8Tebsu1ZFJJKeoXlR23gFJyeWbdEdcSMYYYTd8IHEb3Z8vzoaRn0+x
         Ao9g==
X-Gm-Message-State: AOJu0Yz8DJe35Rt49xbyHWHR22xLhjLcfP7dzoeT6IB/zF8RRSWx4rZA
	fVMOJdA1bmzF/JVUJ7itrk7ro2LP75vw2b0yoj1d+Myp4ZGK6bJu2mlmr4nHs5h1P0+2Q59REBR
	pa4YJNSO4U9KnCcTUpFJB+uyGTfF9VlUM9qFis2vjKrjVuuWDKcZzI3EUTg==
X-Gm-Gg: AfdE7cl0FN+G67XWa+B1n5K3N0/mtdkeEzYtVTHeXhfKFMypbBPviG4X2piGvWamtNC
	VIjIuSWfaWMZ8/VNhYqPeVgavbE2YObag/w5RQ0rRO8T8Mdi+LJhfloC0eq7VFVXC36KRXlCpGW
	5Dqh+vDfFeF+bfHMZvW7iCJaDy7T9M8JhotKlLXwW3Kr0cwltJEIWGJ5oFKBqy4qLAIPghp97Gc
	LlHTvrhmU9xsMe5t4lStOwEz/lmcyyVp8oK8KAUUpOdb3syEJsfhUDpKB+rhbAd54WOHdNKDb+T
	9mruArLzTCKUIdeytAMAn1hkvlU54fQ8Sv+rWWfjXlz/xDL+IA/1sM4BEdbD5lNzUNvyW5KY5/s
	A6Tp+aWzOBTm8KuHYz7WXAhhYY7lQE3UikI8=
X-Received: by 2002:ac8:5910:0:b0:51a:8c9c:7f58 with SMTP id d75a77b69052e-51c4bf4718fmr84324821cf.11.1783327249522;
        Mon, 06 Jul 2026 01:40:49 -0700 (PDT)
X-Received: by 2002:ac8:5910:0:b0:51a:8c9c:7f58 with SMTP id d75a77b69052e-51c4bf4718fmr84324361cf.11.1783327248523;
        Mon, 06 Jul 2026 01:40:48 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62c4b52sm690724266b.47.2026.07.06.01.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 01:40:47 -0700 (PDT)
Message-ID: <0ae3a788-2061-4bee-835f-d08ecb2a1d39@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:40:43 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 04/13] arm64: dts: qcom: sm8650: move smmu sid 1 to
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
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-4-01d50c3e0c99@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-4-01d50c3e0c99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4NiBTYWx0ZWRfX0+way+5eVx1a
 RdJQHqbIGe37r05NiV9VEGEuUwQulQUVQjNJZJ9gZikMHN0dxDXJvK3k2+jnVWr6hSVAn/AJ+5V
 2KfpierVV0RPHrrsaq3ErpllV6Ie24A=
X-Proofpoint-GUID: 7THa1CWYkyofh180sCNxIdGK6I0uT77f
X-Proofpoint-ORIG-GUID: 7THa1CWYkyofh180sCNxIdGK6I0uT77f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4NiBTYWx0ZWRfX0f3Xkz2oGgsK
 hcXn4rMfsRuRAG/5WfFcSjvgMZReVSsNteKugfCTSGeUpeDFvHQGrK1CJfgl5H1x6a49kcIwIy2
 6ViLnHF+LZm22wMRk0cnqzD3PhX52vpzcG1xoPHEiEdPiDpxZkXb4KcS6U82dUmysfTzMdh49C1
 V8OpFukuSN58WFnnwvORCSZ8hZNPnxkbGPYb5VgaV1u7/zEJFJh1VEvNSzzc6TxGZG4iRO7EoTM
 U4K/eUk2gfToz0lw9Gq1aUA7UZsWDPOAvtEuspBUthxJNpOY1oNqa1xEYCvXmc5a0BLF2O35FX4
 cIiG8fZJIcsYi1e139a/6TSjzr5O1j/dFQ5kvnYK7WhO8FRDIYCEGsd4e6CoGmz0EVNOjjWqd+0
 2AXFnayYjsNcGIL88WzG85uIQv38vuO2IsCuFoGKHP/zp6lUZgnjH8wQIig9eLUDLzNZLS4hSRh
 s3zYx61ow68LU+IEhLg==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4b6a12 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=cDqsbA2g2SHu6s1Cd_QA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060086

On 7/5/26 9:13 PM, Anna Maniscalco wrote:
> Previously both SID 0 and 1 where associated with the same domain.
> 
> When LPAC is not used this is needed so firmware can acces memory when
> initializing using the same page table as GFX.
> 
> To use LPAC however we need to move SID 1 to a different device.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 1604bc8cff37..44e5f9d4b335 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -4133,6 +4133,13 @@ tcsr: clock-controller@1fc0000 {
>  			#reset-cells = <1>;
>  		};
>  
> +		lpac: lpac@3d00000 {
> +			compatible = "qcom,lpac";
> +			reg = <0x0 0x03d00000 0x0 0x61000>;
> +
> +			iommus = <&adreno_smmu 1 0x0>;
> +		};

I think this could work better as a subnode of the GPU (or perhaps
if there's no "actual" separate address space, maybe just iommu-maps?

for something also making use of the latter, see patches 1-5 of:

https://lore.kernel.org/all/20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com/

Konrad
