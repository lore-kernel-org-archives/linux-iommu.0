Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41044BCAA
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330404; cv=none; b=Xsva4Vzyh0gux6rQobA8orGlIlk8vV9jxEe7xYH81fCgOfFoF2BBAOHAns5F9aM/ypynAkS22OlSS/iETzaGUIyXG3aYcw/58xnZBnF3Tm/qlhIh2XUZjVwshsoHMHi4zOGFnVS9Mu2mYMyUA4xb6CkyIksPIst/WkDcnhIGNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330404; c=relaxed/simple;
	bh=rS/tT4UyEIl+85LBso67PqHLP7F6BOYzmZCdyUtb3x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZzWYCVXHss5E7hA5hXW3qXfmMwRY688q7hb+iAlvsoEVm9IgzNa3Bkfwpf5x1G040ZkvqzGJJlMkLmYBYOIjjv+vHAx4eOCQbfdhrNR9glZxtur9duXn4yFLaNfgpbgqiI12yenxTn7WdOSAuAfooY8c5HFx8XHxrq+q7Hp2g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oV4pdxOF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ex6z5cyD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oV4pdxOF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ex6z5cyD"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6669QVJt184952
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 09:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CqI3glLxpjkIaZ4hS8KAt+z85sv8/xneAfqqjsT0BtM=; b=oV4pdxOFkkgiwhy3
	KqQkRC/eNXZnrAUtWwLiMjuiM9z75nTKAlsexWfvJ06t8B6RMx1uhJ3n+CvmsGvq
	ijj3ukeTsKiOA9rME3WLIRqParkCUvFsqEPrM7NAllVPF69cpNKHrm7/RWwAT6kM
	vMg+2abWKTLmYA+EcGRmtq16AxOY8VT0/lyNrcjvYE8Iu/KXBPmqxB0UsElSBR3Z
	/QKljMdrTPLdXnr2gHXPBVEsuD31Zvk0qxhQQ62aXHKcLHuRx5e3q4ykx1HopZd1
	leEUczyCwW6zfkO30AlDmc8rEN5RBb+JoFUOWU3w7EBRRWhjz0nS5NRLA6eAMcwo
	cVsUTg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpg0wc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 09:33:19 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ef4a54f86fso7563786d6.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 02:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783330399; x=1783935199; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CqI3glLxpjkIaZ4hS8KAt+z85sv8/xneAfqqjsT0BtM=;
        b=ex6z5cyDMVYUq++vfkBjA5Xboqo0veskOoq/Hza58TOivm0ZmWhOsJvQjcxiRxAPjy
         S8Etxnd9EISpXxv3dz9QeUTwEpk3/l8T3nE4u2Y85vrGjT+Q4j9jp8ynC/oKp98uD64y
         mwwOV2bQpYt/b7a38ZjB7P1XWdfkPYhLuRjXqxWQcima+2xzT5L7GXTtn4mNrkKE6W48
         +5Vo7phhEl8r0gLL+TtDl0AmcSja2RpIN5QBLnYZSGgGAwOVPR2ivsXssOVZ7gTU+qP2
         bEp4JnyZEf6k1zNDT6K+g2E/bw9GTogJvxY6nftzSgnz9JX1CzC0iSVw/eF8AiQbLoRg
         DcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330399; x=1783935199;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CqI3glLxpjkIaZ4hS8KAt+z85sv8/xneAfqqjsT0BtM=;
        b=ZTz1fyG49+UjBv1k6yD8FkvFU9aSiePMMcoI+Fpz0/oVGimQd4Y3qgWA18igyppZsv
         5e9QtMa1BBfXshXOUA+B69FApmpu3ivlBgQ+80JUpmRg3O22kGpnfZdHtWa8QEBgCZ4t
         PH04PbsJ0IDliXzEwh1KDaWfamGJpHqlRQ1MkVg8iji6swVR772D+qKUTBQ2MSrKzwV7
         0lrh1SZKp8u9OETmjfywwO3msQ6MhTnC45w3X6O6D6Hq52++B4vwfSlw+3fXpkpFKBzM
         csf0dVGgIG09DfzKqRmZDn23LU8LJ3J6UP0pYkR/4jlp3Lx9V59PA6t4Mx+sj5LkirhG
         7hMg==
X-Forwarded-Encrypted: i=1; AHgh+Rrx4Wrmknq5gVWb35bMhmRXyjwxqxUApl79mHAW/LSiuWXPRzDc22QsgoPjILBM1erfOnoIjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyom6yx3hxkJ6WaCnWBk6tu/xJXS4Si32aM6wlzCWySPftYXdRX
	ffrnAMNOCHSeBkDE/r0xGw6hhOeQtGIehQ2/681wndtrTZ+nABYw+KJK16K15R9KbesIPrqv1p9
	cJyD62YYZ7zZMJffjzb4Gx0o1Vow/8oDVCDnz2Fd0XwmxvYtMGFW3VBkxYg==
X-Gm-Gg: AfdE7cky8+AZMb6eevuzFEL86WKqI9FsGB4LbF6e/1img+4wQK2wlEz3ChLn0MO3jNj
	RZ0e1KMTw4xuPbeZBRx29bJ/j2LwXrqxIZTHFVg7gbqn5Jp81bg7x0KgzyOA4bppO2tY7zXUofR
	5fN4kD+Tgc/NKlb0daSfgGTC4QIKcwpKaEl8p+60POznJv3oHnPOxhRU8NTFHG+ilEn7zrGLmSA
	CHX457JH++qAlzNVULMYYuK9VRUxplTmzoJP72pjzJBQdxnV4P/ladDbDsrSKbe3W7CEcvhaHsz
	/5QeZ6OLZrLoYGfIXA5hmCddt8zUVhNKsgT0xW/zfzAxMzwm7dpvq8liyrG7XaO7rS0FqpUhZr3
	h74aSaU3vUKbAN0RgkTfWKdoMifyXnV2Pee8=
X-Received: by 2002:a05:6214:2503:b0:8e9:f5de:d5fd with SMTP id 6a1803df08f44-8f74caaf417mr106701796d6.10.1783330399119;
        Mon, 06 Jul 2026 02:33:19 -0700 (PDT)
X-Received: by 2002:a05:6214:2503:b0:8e9:f5de:d5fd with SMTP id 6a1803df08f44-8f74caaf417mr106701416d6.10.1783330398707;
        Mon, 06 Jul 2026 02:33:18 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19d9e701sm3807545a12.21.2026.07.06.02.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 02:33:17 -0700 (PDT)
Message-ID: <14c366e5-f030-401e-b51b-62d833f9dde9@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 11:33:14 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] arm64: dts: qcom: kaanapali: add the GPU SMMU node
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
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-3-6ac53de56314@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-3-6ac53de56314@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4b765f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=54KNg95dvv-uSQ5X8vIA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ouYmqVbu1JLyisSEy8R-1LGKT7Agyrhl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NiBTYWx0ZWRfX4oRYEb8k0tK3
 QjAs+ecHh2jwQekQweAlI4SfEi3bf/XNl3sa0Gc6yEtYsFtUPRTrOUuNmWjleY44TSb5mhOOuVX
 wpQDFxP5VDnhNlOHe2KKrpDwlm5V8Ac0cZYANyOnu86Mm1VM0ReSTtD1YXnFZuSRXu66koS+Yr7
 W7CAeCDDcybjPQm1TulapZojwpuldRWel84sr5WRJxLpseyFnV0iVvW6F2jCGCOZiH6v7w1viR9
 Ni0rnttxW9IoCASYq84553bPD+xhhpxhKoU+JRoxtqoN62gw0SECcLgRKKTleav9DELozI1QB7K
 ABy6x4SymBp3+dlWN9E5KDT6dEh7viTS4GBxU3FPPO9a4H44u8987oG1t/TZDihmLP9LMKfw6CM
 Z98zcs0TcTevHp/C/h4J1FfU31jMtgWiwg1EKIh9aL+HK/rC5YdHm2uZiXYlG8prq/9O4Vpzq8+
 ukr2L8hCZWybhgrFxLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NiBTYWx0ZWRfX766lGAPjvosD
 7X7fhplgZ4fObJiqv364vG7aWYUTEoHMjH7EsEXHWl8VleDDOAyNSTOp9WpJGgxs6ILPLLxtzC9
 Q1riDbeoJjimwdgpsM3cmuVUqEtBC1I=
X-Proofpoint-GUID: ouYmqVbu1JLyisSEy8R-1LGKT7Agyrhl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060096

On 7/5/26 10:00 AM, Akhil P Oommen wrote:
> From: Qingqing Zhou <quic_qqzhou@quicinc.com>
> 
> Add the Adreno GPU SMMU node for kaanapali platform.
> 
> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 43 +++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> index 7aa9653bd456..19eceecc2a19 100644
> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> @@ -2601,6 +2601,49 @@ gpucc: clock-controller@3d90000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		adreno_smmu: iommu@3da0000 {
> +			compatible = "qcom,kaanapali-smmu-500",
> +				     "qcom,adreno-smmu",
> +				     "qcom,smmu-500",
> +				     "arm,mmu-500";
> +			reg = <0x0 0x03da0000 0x0 0x40000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <1>;
> +			dma-coherent;
> +
> +			power-domains = <&gpucc GPU_CC_CX_GDSC>;
> +
> +			clocks = <&gpucc GPU_CC_GPU_SMMU_VOTE_CLK>;
> +			clock-names = "hlos";

Let's match the property order of glymur.dtsi

for the contents

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
