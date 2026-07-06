Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7523DD87A
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324898; cv=none; b=e/qHAQkIbL7/khmY4sBbrw7SO34wSvGvcZMiPKjAtMFFrhxY2PWmOSaQgUZl5L5D0pTEzMzXZt7bb0c7HOQi8pbpT+ggHdu+X3zj4/nnGZU5LYv4LhadSblBs4ywTTa4s7ITYrYCLQyRpkFv1E21sNZ4sL0Q4qxvlFqA0o1pqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324898; c=relaxed/simple;
	bh=xbTYkIXpXUee3gvvOBxk0kUVHW03TTov1eo5uXnvD3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdctANFMl9kblVMGB66EPtmfel0Gxd5t8+iPyu04TpWmWEDwJH+4j0nzi9v9J7uTr/b2V/+xEK27DInTFkOETDjq3d5GIAbgoj1yM0HtJ0DpsO1mliYqVh1+pyIrZg2qdADDaLg+R6llV+MS8OAotBYei+DeoeGcChTBe9DAMdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PNJc616W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LZdDGAR5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PNJc616W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LZdDGAR5"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641jTi3459261
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 08:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LEvwY9lVsl4c0KkWFbM31zunGMAv/eiBIVSW86anSwM=; b=PNJc616WMWAi/P5h
	KzviJ2QOcmxmWXrNJrOBf186e8ISZSGtk198bVxyTL1x8Ul2sznEyosF6vSU+S4o
	1Iidcvx0nJoQ0rt1im8IZc8p2GU6PoaLmX0Cu6oBI1wjZIHDlvbj9GeTL4QEWcSo
	UdL8TInLCrszGVqnQRAA7vKM0/0QKz0fAIrUjxHcJ5Vk5gRH8FU38XhDAEwh8pUb
	efJLf0/aAi3C8d3e2nd/6vvEk3QoG02CApQOj/ngfc8Oqpwg31zqE+SnHkk2kpCj
	/A7aZ80v+JQV3/90uYV2iFw9EGC9LN2hFw6xV1ivi5vuW5RVfoYOs9owJxpaojO6
	lDdtAA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6uf8512c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 08:01:28 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-73966c839bfso93883137.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 01:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783324887; x=1783929687; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LEvwY9lVsl4c0KkWFbM31zunGMAv/eiBIVSW86anSwM=;
        b=LZdDGAR5A84eq5jRg5tN3nRvc1IcgbDCAxC7bMR/SBwjotTsO4Mrd+eOWneRLmgTh7
         LLtM1TpKuVrpU/r6oq5eQfGrNAt6DXoZOFFa2n4feOOCgYV8JpI+0iUhtz7sCc4POGtW
         afedvJrFddf/9nbRPbIiVeT71weGKgG1ZDtIxAW6bf4FTxtYs14tconxf4flUyxot5+u
         gqfmvXqVpxxB662jMpYqRkw43wjDYL9+gooe8ZLpRGZ07iSvtafy8dMWWik3GlYOrbhf
         8teqXBKwjaFuFX3Gf861fb47LjALlzS78AcnvWvFTm3xgSBB4k5heGQkXY5/CsV3tpCi
         Cu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783324887; x=1783929687;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LEvwY9lVsl4c0KkWFbM31zunGMAv/eiBIVSW86anSwM=;
        b=P3oj6EtsxeLSiOJSxQEYfVapA8kXiPn9ORxX2P8DzDMhZ19hdbF+kuCttjVVhNLACI
         LY92ARVIq/AuuDtfc7kdhl7Dqy4FCdmCm1om5AtkBKYpTS83BIZS9IDIRphmxxCXIsU9
         9C3+GeCRxOH1ih/LDpaPvr5e0MsBk0keWz27c12mvBtS+nsq1Pj0Aab0yF2x5JWhcA/O
         forZw41Y8YozeZUHRzoL/gqVYmvLyXgKs1OP+RdM6xHfCHtaLn/3+joZGq25kDcLrfwA
         QpO7j6X9eFVnk+jqxd3F9vbBw49Cafb+O8hIfXJbEIqNNXRdi6HrcGXQD3bODkHTitAg
         sfmQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro7+1FieI6D1eKkd+T72ljawpmL9BKcEB0O8qzqLD0KRxBQlXgKsklau7qorNBYWGey6Ld8rQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5P+5QBVKo+iWd94uSlbNHZ//bpgBSjERb5dUsYTjS1Jcgfuie
	zFavUkLb7KNv4w2Cuo8/JxTnKfqksvH1bvKOa4bnD89RpsgnVOkNvWqqyKbRGrcXgEWQdFTSaII
	qDegxOEFfzhnmUieM7Bl08uJf4aK6qja7ZPdtMfQDr7Z6ZuhlcHnX8Nzwdg==
X-Gm-Gg: AfdE7cm2pIqYq+48t9LDPsFZubn9M6nRW4A3whnzkr2r8551uBM7uamPTny+kDqAiC5
	FSCe3oqn7mouyuDbbzd6FXoM2gEh9Lu0zP/g26X/mygYxUv7BcWXrAhvSam4CQNsDCVxO4Q92fN
	tE57RfH17p7sybIcG6m++PC0gDqxnn4ywdI2nfBR+3jv9oN4gDDzm4rSmF1ZC+4ub7O70urmaG9
	CmRAM6BpZ9+XtgVHCR9D3VuJrGebAyZ5SxL4404qOS9pN0zeis7X2Yo8/orevnCwis4M3maR+WT
	puY5VzMbTEs6Je0kKcxCyTll9bR88ixmrBS8S/2f/idybfY1RmpzCuGKpmN7U+sncVuRpTFD2EM
	XEc3uouV2/i/lk4G+/+JFDnzaCsr/cnVGIbY=
X-Received: by 2002:a05:6102:5f02:b0:633:3bf6:977c with SMTP id ada2fe7eead31-741f6b12922mr1165575137.1.1783324887384;
        Mon, 06 Jul 2026 01:01:27 -0700 (PDT)
X-Received: by 2002:a05:6102:5f02:b0:633:3bf6:977c with SMTP id ada2fe7eead31-741f6b12922mr1165550137.1.1783324886847;
        Mon, 06 Jul 2026 01:01:26 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19d786e7sm3638842a12.16.2026.07.06.01.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 01:01:25 -0700 (PDT)
Message-ID: <f55c20ab-681e-423f-8d51-9c1def0f13ea@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:01:21 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] arm64: dts: qcom: shikra-cqm-evk: Enable A704 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Aditya Sherawat <asherawa@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
 <20260704-shikra-gpu-v4-7-90cf1a52e539@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260704-shikra-gpu-v4-7-90cf1a52e539@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6Yls5EFgAYJf9cPTmJL8bHkVG_TAtLwG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA3OSBTYWx0ZWRfX3O+IiPSofymM
 jszfKEeMDQh+Enyb5shCTa+4xHyeo8bR4qohjn5aYS+Krq5w6aBKqVn4XdbIw1paCyZZ0NX8dIl
 szSLEOEMSNzvFkcBH2Ec+8D4YCc4Uf4=
X-Authority-Analysis: v=2.4 cv=Z4Tc2nRA c=1 sm=1 tr=0 ts=6a4b60d8 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=dZuxl-eQfz5dsBr31XEA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: 6Yls5EFgAYJf9cPTmJL8bHkVG_TAtLwG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA3OSBTYWx0ZWRfX83+fmFOlYzIu
 uydr2mflBis5TOFrDlZ43Yn1a4gGTZdQV3y5AGSNlcoViHg/6YTAbr5bfAxTX/aQHLHdKZsWsce
 EOVCK9bkyHnXRR6BGWnwbicwPaDOx5T3/pTuI8Ipi1jVXOi66ULXpE+vnQO5en5b8rTrZCzpfIC
 9/CQwf69Us0Wl4At++flJshzIgvMh6wSbhOEf51IiJjlQnimmeFNs6V0oc+VfeIg+KFTboR7v9z
 l0eAig19/Qo1owKdWCouBVTRikUzEEjSDPxZ/B1broqmxM8dJ1+FN1PWHoorPmzh09UZxQpnR8Y
 TY4qzpcBKsYgjkh1dDmMY1vIYcIW55HnYRhXKtVp15wEhEE/ZfEoXtW7mq+T/1I3nePrlyiuBLg
 CyMC19AxD4Kc3SKSpKquKpIIa+ZyrLffdBqRFb7lUjcHzuzrITTGzRNAdO3sIGoKkoOh64Qk5RP
 WqXXAe9cHl+ltLLRn4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060079

On 7/3/26 10:34 PM, Akhil P Oommen wrote:
> From: Aditya Sherawat <asherawa@qti.qualcomm.com>
> 
> Enable the A704 GPU and configure its zap-shader firmware on the
> Shikra CQM EVK board.
> 
> Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> index 269e11bd44f6..8206dddcfc75 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> @@ -50,6 +50,14 @@ &remoteproc_mpss {
>  	status = "okay";
>  };
>  
> +&gpu {
> +	status = "okay";
> +};
> +
> +&gpu_zap_shader {
> +	firmware-name = "qcom/shikra/a704_zap.mbn";
> +};

Move this to evk.dtsi

Konrad
