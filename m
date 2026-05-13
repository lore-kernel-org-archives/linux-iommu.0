Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E7D44B692
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691106; cv=none; b=BJjwZv93vKc22WWZFXdEWTrfHk/uRtvNy/BKqzEq0YyYv3wB2xfuiLk+/BmsNZyJ0CqkM6l9S0Vg0JVW+/eFbLM5RR7kon4pVHfIc8il2vix+nkdh2nEgNGAnzVbVOuL9qtQA03wGs1z+Tt0d9NvxJI24vdgq7oGU7G02530mBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691106; c=relaxed/simple;
	bh=uquoSwa7ZwAvpTOAIW92nV9OPtPJezsv1BSkxTCjGQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVFyzVtqVtWuYWTDu/cA/YJpnOnvqrdXdDBKpkDj5Xcz4a71tuCNfsP2gZbBYl1MeNZ34YVtNdZgXxeGgrHuC3BQ/WddGDu00L9WVncYgeLJRkG/VpOCC4BJmIBi3NasNURIQC8WO4j9CGPCB15PM49Q9Xzqi3+Sgwm5ygFhAog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OKhBglmb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DVHaifRm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OKhBglmb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DVHaifRm"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGAPBs2321233
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 16:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kvW9MFUmG8rvh5PNkmsY1wyy
	sIDeA/uWWz+EQKpqk6g=; b=OKhBglmbyQEX6oq9vBhZaGVssws+8Oa4lvLJQKfB
	4FEJkO4YRuPf1HRAdUShy1fygbwX1pfjz83GjEUwa93LLuDPghfBuLMvFuTG2SLD
	+65p0KgExqbkudiKV2L3KmrxwRmWK6rQVhZrlmOeYqa2bWAX+GcJA5dtB8wV3MiC
	GnZ3NhJtQRhAf+nKH6KnRWLrfB406qwwwvtg0i/brx3tQ7mz47ZA+FOIjO7TZx4I
	4kb1qi66BpS1Ytc8S25d0HiTqTyte/pKRc0O9kDA6FXxAa/VYyTTRoUVFDq585jX
	2c4sPuGmX84QWsN5ESl9w2jikrBUf0wOO+0tNGV5gplOaQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hgub1vy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 16:51:43 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-634ce585b41so2068736137.0
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778691102; x=1779295902; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kvW9MFUmG8rvh5PNkmsY1wyysIDeA/uWWz+EQKpqk6g=;
        b=DVHaifRmuP5Ki46PG+Rrx6iTl0/J8ycY6+yrQIZ3NzGNs8jjpqP/h+Hy/DSVkTl60g
         qhEjAJuwaTi1guDjv69H3UHRV34+F6TYsRVg7uPqi+wbQFU95WhhogimW/R+UHzlC8sR
         b7qPdf2MIkFwf83zXR4fawf2tr63DfRIaVLHjIJN446Lku7tEGXtNxL4fwoeWGiarJC5
         yia6Zcx5WePDROdloVDf7W4BetPrQpuNQfBIFMokyqAAGU7fUvhbwSSzl8ZnUiJf9WqG
         m8+KNlqn0zvNY4NHWfbkJTE1mRhttjel/XT8CdRYwVAdQbRfgAZjW04DhsJEQiCoz9kz
         V5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778691102; x=1779295902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvW9MFUmG8rvh5PNkmsY1wyysIDeA/uWWz+EQKpqk6g=;
        b=V3Z/lXhA16MRSSaGN9qWQYlsaKWbmNFTcPHxddKrwxF5ypAezk8GgQ1ofn/aOszJKu
         NRMXvHCmm5GqJJ/sMMtF3DMIWFgqIEF6pxUSoRjMQWRbxuAP7MMwbdBSw5J3Gb9h4sor
         rNo0JBmvJ4kYNsL4Mmw7CyAY7PCi5Mx0lz5/F//iFO3/WFw8KgLLUHygywWzoD/295q9
         M8es18IDFhFqWSVtLUUj7sKbCdeCefAbr6Z7bri4Gq5feeOuuloziw1hwkH/h6Mz0pof
         /E8Lmir1ZxQ+0/l1gNypRgVBr4C7E/dp8S1YVOoIFdAn5bFXNHzQnT3F4sAZ+Ww1jdRC
         oGxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9gK00Ai/UcZSWmd02ANb+O7U8ND3hte1EGSRPRbXw6DG/2DfLBs1WRckFtxXjMa93xkKQD6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzy21nvCT7Otoq94VuQNRoppklkWKMUwPQenTmxyDSqk5uUgdIp
	VMqrW7VaLBls06wLut/47X2l2dsTFyLKz/8a/ec/mGdce0OE9D1IeW4JfepNdB+F/qIhh67IZ2R
	8R3gkf2loj6PZabOLrDHq9xCDtkNhaFY3i++fuU44gmAI0YfQ+PoKV8mMtg==
X-Gm-Gg: Acq92OFOXRRptkagMH9Ph1IUeIGnv7weAMGNnVrxNxUUlY8jXguo1Z34ND7YcMgaXwG
	qDDUw02iJ+XCf071tTGYb1w9/UoZTKhzMCLubgXljgplSqXbmLLx//PVslbVQltpaPjySxZYY0c
	Iq4Sq3fv0frFh0ksoynJnkiymJgITBEoJ5P2gkbOrArFIKqwIAsrlg2X4QFW+NuISd+eLH6y1Mh
	6xyKlOg7NafcwcP0WwVm0/4AFuc+4gzPtyuE8T7RdqAhnUNh6q6jqb5VzEhGKBNt6FXgq9/qIdL
	9cfVZZALtJid+TlIgHVVFvN2YFy8kT8EiTwd6NuQlqZw+vgJA+JJnHvlsaqF7zWGIrCRf36X+c1
	PdAEBIAQlw3f9OEjM1Q4Lxf3XPddeO2Rkr2NprQJNwevFE44thVghWTpnguxbm3bf6kspJGbOYq
	t7dcxhP6xzGrZKD5rU9l2PHMDrn/KVDSdcxEE=
X-Received: by 2002:a05:6102:358e:b0:631:7781:fe89 with SMTP id ada2fe7eead31-637728ca842mr2437839137.7.1778691102259;
        Wed, 13 May 2026 09:51:42 -0700 (PDT)
X-Received: by 2002:a05:6102:358e:b0:631:7781:fe89 with SMTP id ada2fe7eead31-637728ca842mr2437801137.7.1778691101711;
        Wed, 13 May 2026 09:51:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a955dfbfsm4156067e87.46.2026.05.13.09.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:51:40 -0700 (PDT)
Date: Wed, 13 May 2026 19:51:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Qingqing Zhou <quic_qqzhou@quicinc.com>
Subject: Re: [PATCH 3/8] arm64: dts: qcom: kaanapali: add the GPU SMMU node
Message-ID: <ergnufuk7qx7b3xsccdifdhlwfoxka5k4y6s72zpqvcfmv4uxm@brakkpiqkqhy>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-3-13e1c07c2050@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-kaana-gpu-dt-v1-3-13e1c07c2050@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a04ac1f cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=54KNg95dvv-uSQ5X8vIA:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 2iPNqbkshCUBXSKAV4O5v4Bw3-1i4SXZ
X-Proofpoint-ORIG-GUID: 2iPNqbkshCUBXSKAV4O5v4Bw3-1i4SXZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3MCBTYWx0ZWRfX/LxQ5vt3HD0n
 3GMwzqRNI8AxitklTLk2zTU+3NVaQEx5pYGGMbOCzzcd2hYhuEpQJNrSgDfQuL/7Pn9ocYjxhzW
 zKs2w3hj+DMtLXlY+RIECGctogtiscmnuWPG03M2okStTMH4aKW51eyGDCWwKSgCAhUwgn9c/os
 CRYARjKfZpr0Voa1sCUbJSZA1DB2KagbaZNuzaXfnwB7IcpiEECo6eLMp1niNTVuuuCZlOSaHOj
 PZc3cEfJb30DEL69OAx63abaguNzkmFvKOF/wg9n91hafvdUVUik4VIDVy7YbCrxNjlHFhqknRP
 hZv5KkyOLUwblCTBlXLDCalFjGZRfrVR+rvyU2DpXzt2NvSrf5S1L6KNUYlra9BqM8Uo8mhICaA
 kNrhUav+e5n/0i7CWnRgsi/zmhz31DZYaTjOjWj3awXsFuH1Vozjqt6L4loJyjdmAjj/hQV4+Cu
 8HllGMqTsUOi/phX4Hg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130170

On Tue, May 12, 2026 at 03:53:17AM +0530, Akhil P Oommen wrote:
> From: Qingqing Zhou <quic_qqzhou@quicinc.com>
> 
> Add the Adreno GPU SMMU node for kaanapali platform.
> 
> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 41 +++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> index bab654bbd6d0..26a4de9c8d45 100644
> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> @@ -2597,6 +2597,47 @@ gpucc: clock-controller@3d90000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		adreno_smmu: iommu@3da0000 {
> +			compatible = "qcom,kaanapali-smmu-500", "qcom,adreno-smmu",
> +					"qcom,smmu-500", "arm,mmu-500";
> +			reg = <0x0 0x3da0000 0x0 0x40000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <1>;
> +			dma-coherent;
> +
> +			power-domains = <&gpucc GPU_CC_CX_GDSC>;
> +
> +			clocks = <&gpucc GPU_CC_GPU_SMMU_VOTE_CLK>;
> +			clock-names = "hlos";
> +
> +			interrupts = <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,

Please align on '<' symbol

> +				<GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,

-- 
With best wishes
Dmitry
