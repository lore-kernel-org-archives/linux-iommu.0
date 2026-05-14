Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6455371CEA
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762181; cv=none; b=eMdfsw8fhJfN3ClW6zzqZG9LN+OAi8Vbdn2gS4+3o3C7o9XyrIi/C9XUUf/SiQX2rEDtzEKUHG85/eSrzD7XjjFfPUlJSAuzblJHfC2Cx8QQSYiT7mkDdqtWfLVo0RbTflG3MmQcd/IrJM44YRbhSBtDDJLMe2ManptkdqhGbvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762181; c=relaxed/simple;
	bh=xQD6ynP2HswCTksRdrkuex7u22mk5r5rKc6Ptzhavws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsNgChlbDkv+x8V2+jFKZ4eWLrwACrcdVysjL43w7zLNNL62UcWHPTTvDmUImv3n1132Qa5PHOEjAyoYVZ7k/jr0UJPc8TjqjEfmMLkqC2YqUANRICTbkfvYLBFpT07zf7WMmam/c8j4eDudLz/UjZnPHzTCG4f+escZSyx88JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YdZfUXij; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HtjqOQQp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YdZfUXij";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HtjqOQQp"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBegk33062163
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 12:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L3E4RMWJDlN4oTIAm3vwmxetHRc24rPFl0tCcoD9zto=; b=YdZfUXijc1B63K4O
	JdArn+cNh/r/AmZB/J0SRCcZ28FQsxxgqDgzALCmvHrC6TZ4czcJ5FSfjCVxIdLo
	m5wiUrTeTxnJ/Geh+XNmLOqRuJJHLJ+E7RGvS2ygDQ7P67Gp/VE6+L2Ue5sBctVH
	BcvvCPsVXEJYwbtK1F6ULFfEP4vh+3tMCFzVpzQz6u6wbT0/KOEcco6smNCe2tx+
	2WikL6CpTdyaCDtwnYRf16RPCqNwjI9OCSoJm6P77yHVgLxbj4DTGXUUg7br8UT2
	RUMKUMe3kAUtmfFg5059U3y59k9H17t2qLjKS7i9zCV7MU/ScqOv4z/mAbF4AjxN
	AXdELQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e554a9yag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 12:36:19 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5751eff95d6so462971e0c.3
        for <iommu@lists.linux.dev>; Thu, 14 May 2026 05:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778762178; x=1779366978; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L3E4RMWJDlN4oTIAm3vwmxetHRc24rPFl0tCcoD9zto=;
        b=HtjqOQQpDop2K6HDJlyxUL1S2/JihdoHoQJ2Sh8UJbNyeSqOfk0zWO0VN1nrChleZY
         8a5103udnenwGfA1iNC8M4mgIFwXFUR6JDNdg/+Mtac5bu148XKYv50zRAyro5cRzUZo
         h2KWOc/yAWJ5AfthY5rHpgIk4/DDyVb1rM1uK0tDWZ4cEct4/tbwK+zO7kohe318uAMy
         /DWOcWFofcJs2IO6dBcDaKjiIPVBGDVSLpIDIIi/jOcDMq2IoKV4hb4Gds01kc27poyy
         15pLQCbJrydYhHjVFQWCctmGL8vV8dI59nI080jax/taMsonxZSFmLinIwwMic/NzlPC
         KpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778762178; x=1779366978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3E4RMWJDlN4oTIAm3vwmxetHRc24rPFl0tCcoD9zto=;
        b=ohxu4D2bZOqKaBaVBb14FbLXnv0VP91KAspGV4tsGPv0r/BSSEgXRZfr80JM+Wj1dV
         covNtv++iFA40n7VSvSd72mX2CxA0mF9/BJO0CDAtXSK+jjoh5LBzJd+dgSOwiXeLZyV
         7SWYys+2E+Hj/zYsXzTXPZzCY0/d+yjEsBk0ioU30QBLSbX9CY0amNLkdODPR0PjYx1C
         bFX4sZmfzsoxYIl1pEMtotZ8muwccfbr8b2dKMeJ+llP3hr1fxatMAbRgYQphyq7C+TS
         CeyZU5bJ9NnUiDAg087siBM1iTzz4h1GXhp6ojlVprSqqdVO+FbltUb/fJ7MatSSw8a+
         JtLw==
X-Forwarded-Encrypted: i=1; AFNElJ8dRessucReofJl3Ce3HZz6FOMZsbR4VlxoKWTQMxE53xuGT4HaYUrTkvPEVCnkB/8KiJSL5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEd/HGanU6NpOuDGHxuRDmt7ei1mVqZI6XdDiw1apVIA/JcqSF
	w2BMV3fEEy8U53YCPGq22uJnPh6fS7e+eo01tdMfCmEWxn4JeiSiBRUrwOH+4fsh6AQ9pq4vMBc
	u7HvckUqkM1iEe5bdxPM9pHs79IUmMbniPvfHE7oFe/tzc49Qb8gDwBUQyw==
X-Gm-Gg: Acq92OH71GiFvBG3gA8Nzh6reTUtoAky89tIzP6rz7tCPSjDm6qXuwH0qdKS1uESli/
	VJzy3U2wwpLvXYk1QFAtoRVqyDk/c1ZdtbJY3e6CQBn15bWrTbwUEEVgzSgOgdIgO6sqmzoSeXz
	8/5hmx1+xoNYJfHK/dic36XknDHXQu4oeX4qFWsJ7t48Z9Ry7RYwUa6MDlLFlbQUDQb9FJKg+iF
	gCWiEBH4H3dDqWt859SCC6oELWM2LW0gPWvssPe53Ed3H6R6nILIEgyBmNCjmeV0h47OxX2MzTP
	JQOWJ0aNWhqz8V/fJlzDQFwdzWyeG4ZYZ4ud3yhqLanGl9LZqmVn/VWQqxXut7TKQDemSirOoNa
	NTTq+Jfw6bocU638S+KARWSipJ8yVpvs/komCe1QmNQiIueAwmzVzaGncQZ5GhP9jQUKqI3snnN
	stOfzjA5UX29l/CQ==
X-Received: by 2002:ac5:c7d4:0:b0:575:2300:9f54 with SMTP id 71dfb90a1353d-575e6f5a3b9mr1298030e0c.1.1778762177951;
        Thu, 14 May 2026 05:36:17 -0700 (PDT)
X-Received: by 2002:ac5:c7d4:0:b0:575:2300:9f54 with SMTP id 71dfb90a1353d-575e6f5a3b9mr1298009e0c.1.1778762177520;
        Thu, 14 May 2026 05:36:17 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bcf7f3sm85198466b.2.2026.05.14.05.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 05:36:16 -0700 (PDT)
Message-ID: <83958f30-59c5-4b15-a62a-92da02187c08@oss.qualcomm.com>
Date: Thu, 14 May 2026 14:36:12 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] arm64: dts: qcom: kaanapali: add the GPU SMMU node
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
        Qingqing Zhou <quic_qqzhou@quicinc.com>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-3-13e1c07c2050@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-3-13e1c07c2050@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zBn9yIEqzyIcqc5fYtISMKly1xEkfM3k
X-Authority-Analysis: v=2.4 cv=Wag8rUhX c=1 sm=1 tr=0 ts=6a05c1c3 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=54KNg95dvv-uSQ5X8vIA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: zBn9yIEqzyIcqc5fYtISMKly1xEkfM3k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEyNiBTYWx0ZWRfX8gqKqWgqZllf
 BkLZ/L/WKvfi585rlhIp9Ak6cFVGMDNGAe8z3kxhvr1EtfNoWOzutWNSWF760h8+5ODHX/867QI
 uflgtgsFOa8xHjCRvi1W1vbmH8uBOUS5RTk0i7cWViV1B9dr0Nq6eXKHasFa9S/riRiC1dgB1eE
 xwWtCuxOep6clVZdNsFMg4bOercz/scLWi+MN8LPFpu7xZ0nGfx//9VNBBdYtoCft1GwF9nP2TE
 KQAl9SjIiPQ/Vpj2XU5gwKnzEKYIJ8ld4B+LpS4acvr3H1qDWo++yYcafTdESUlYTKK1uaoa3T0
 sfuwrL2fOMDiS2c6ZaU9lsZ3IPnesoxdzAggZdiWMDcXGOrhRyPWDi1D/EXmDSf9I6JBbC8EU0m
 5tnPJhbj+URglv76uGXqiGVS1E7p7KRxIt4E0u5ZsDv+tOixSYgSyoURvzoAxJSno6zkhnZpsN3
 CeALYejNMUyDRKuKIKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140126

On 5/12/26 12:23 AM, Akhil P Oommen wrote:
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

The lines are misaligned, but please reshuffle this to be 1 a line

> +			reg = <0x0 0x3da0000 0x0 0x40000>;

Please keep the 8-hex-digit padding for addr


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

likewise, please align the '<'s and align the property order in this node
with Glymur

Konrad
