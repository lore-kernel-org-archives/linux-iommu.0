Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D1E1EEA31
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 01:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776822577; cv=none; b=SrG8LOfIQDqdcxOgjSYX0Jz5Luy+mEfYFOeBS6h4cWZh7CmVony8BPUQI8LNQ5S9Aj8wptnc0TgGOUUdtjB+lt82xEcbC2biehofvK3h3jem2Mw15nZHQS0NOv/Oe1/fbUNQ+2HzIKRivNJUHh5WdQoyWvTGLVLti2oOVa4SbCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776822577; c=relaxed/simple;
	bh=+Wtn7wvNYHZYHKoX5jpV9Jp81OC6dD9Jr4VMinq3PGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NU9PaX/0WRY/Z1G52e6mnZk22Ir/kMgC+VWL560Mu/+P6LMOeONZZGJuyv/iRvNj24IeFBf95IL+qfBiXv9Ier33dRYuAFLq21hECu1165K/TxIMq+6Stlt77Kq67dU+2wAZDJHZ+s9lKPLvwoAqdC7EEE8l60yzolfa4jwvyFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ms8Cy+ly; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S0TnOsW8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ms8Cy+ly";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S0TnOsW8"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIZkdl3377480
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 01:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hurFr09vNtmPRCEJnucpGA3f
	RhEigXPf8InOBEhGYnk=; b=Ms8Cy+lyTo8U8uLX2ZfLEM+kvoRgLHCEf6ouCKac
	vPQQn6FqXzvayAm96xM5z7MTjnYIsJojkmCvgUaj7XwVWc+zIU2SvYPKUk/TrJjj
	ZBYC6KG0jINAGs3Z2t95R45sQhGyEKUEslf4yHLcGDVrpO0l9IB0pOQTmN4o1RzS
	D+amClEcSUbvkr6OPQ6mQ50k11VcxIsCCjLwKUaiU7vDX5GIChkJ7R9EP6go6nFL
	AdtlLeIs55ybvZQs2pmfVK9m7DPcy39wvcwE3jhWs2DC9eM0vqOOfQ8xbv/Zzqtf
	vtU2Q8ISf17YTcQfKAKyQBvWSV0H3lQ3yJVWYqdL43onSQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpeng16g5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 01:49:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50faf575af4so52275541cf.0
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 18:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776822574; x=1777427374; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hurFr09vNtmPRCEJnucpGA3fRhEigXPf8InOBEhGYnk=;
        b=S0TnOsW82VGRsdreMxdTNHxic7KBgBwVS024xnTRiaCj3EmFxFgDDEoklFtRJQvniA
         cjPmvjbrGNod09knwngiwZr6wnnxuRqpXTr1wmHdZREnM+58281OIZbkysC6DP9p5F3C
         8n3zKdmS1GvM+Q/omihCaQyOsofm2nDJ95RT90weKNZwUQCjT6yo7vsINXSvUp/vpVOQ
         zzMAO00mkvUrxpBQ/E3HAjjGrRN+bfnTvvSuXNqRbSVwUEN/YeUcARNNz1TVpcNp5v8e
         E1S6UbM2HM/OMf1wukud+2YVgE01XLNxANY3sfPurYnwQsQggPG3PWptddNl3LyNok8S
         FX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776822574; x=1777427374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hurFr09vNtmPRCEJnucpGA3fRhEigXPf8InOBEhGYnk=;
        b=rrAiv1wjnoqQPBTXSGkBHfh33boxYWzciizgRKrg4wHoZsn49YrD78k6S3jcuclRxj
         JS3u0YeO+qW9H5xmuxZ53LJgpzHsib7PAn9tokjE//TchQrSBGJm97PSyT9b//aHxRsq
         AiEHnu7bDTLvr7o5Spnzx+5kevzQ8eySEsHqnmXZgmkXi6p6Iek2zS+UKt/w5Iq3n+eQ
         cnqT9rXCL5xCkNJEEWqtf8kD8oJHt6xHN2UHjFuHxCXp6EFnfdsmedOi+tw4KqTQf+AL
         Cym/oecO00kT4l4c9qo2yUnbI5IDjUREqbgMFGQcpT7EH+V+/t6yW266iusqSbApM5Qw
         9gTA==
X-Forwarded-Encrypted: i=1; AFNElJ+YVyketyHRN8AEG5tUwhjIX3++yZmTwEstUyH03qwT8c7UxKdaYmhnEXP7GjWCaLHz1AADZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyi46OHJiZ0VbcTV2cIvsZ/xGCYM3YGYPCBfgS7uTLqTHBBJYJY
	z9dinmEgqk8PdYGtauaFsb7BbUjv7TnTIZw/JIh/HJX8Tfnnza6Ea4GPwCkdXeVFlOE3SptLhRo
	FTGjZEVacxfhELqnr69iJ49u7YmtxNlr/SwgCVkEliT/dwJ5mqEo+FKrU7w==
X-Gm-Gg: AeBDies/Wp91rPvNFe0hxnxKr0JqnpmmUkKrLT2mvkDFPB4/Y91Ia2NhwMhUXP6DAQR
	+OqyGAedj5BWKhyEKpIyWDf6aWOOYubRqvVDyzz6gdRra7tN39wHQBNEjDNEfxJJ1hxD9mMWrOL
	qqzQO3TfhQwI14XJthNCM14cFo/Fknbpb7l368ob2fOgrUVQYd9BwnF/cQJlhrYOxfAYdJMHH/o
	h1TP2J0igle6bvfqm1L5kE8XDzvRUR3pihdjT4MGYE4S8M6d3S5H2d/A03EZoqwhaOpf95E1SF0
	4gTJHLxptnpURaJBCYe7z0CmmYN6V4Qat02bz1v7smeEd712VQ59KaaRgxAUZNB+3NBa4mBdMbI
	1CjGUpNHUck4LO+/x/hE6ZIRlzNvUHw9d7BqA8rnPdXsoCrllw7Ded0e/YPEvrxm0rHt/aV3tb+
	NFEDBFCyUwHwzSIib8B4v5Ewc9XI6HwJGRf4D5ERST3e9rlg==
X-Received: by 2002:a05:622a:11d5:b0:50f:b732:202c with SMTP id d75a77b69052e-50fb73225a9mr67301271cf.19.1776822574127;
        Tue, 21 Apr 2026 18:49:34 -0700 (PDT)
X-Received: by 2002:a05:622a:11d5:b0:50f:b732:202c with SMTP id d75a77b69052e-50fb73225a9mr67301061cf.19.1776822573662;
        Tue, 21 Apr 2026 18:49:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc25csm4072345e87.26.2026.04.21.18.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 18:49:32 -0700 (PDT)
Date: Wed, 22 Apr 2026 04:49:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: contact@alex-min.fr
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Linus Walleij <linusw@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 7/8] ARM: dts: qcom: pm8921: Add USB ID extcon
Message-ID: <7cbmtdsq7iz54fkxckyfqgpkcz3yweg4rrfvo53vyxmraqj4kl@yrioxjdcxu6i>
References: <20260421-mainline-send-v1-sending-v1-0-bcb0857724de@alex-min.fr>
 <20260421-mainline-send-v1-sending-v1-7-bcb0857724de@alex-min.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-mainline-send-v1-sending-v1-7-bcb0857724de@alex-min.fr>
X-Authority-Analysis: v=2.4 cv=CNUamxrD c=1 sm=1 tr=0 ts=69e8292e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=0w_FVvD09BqdKzzQVHwA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 9-S6sqTVaWza0G4xdFKw1QYIvfMUx2jP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAxNSBTYWx0ZWRfX4qqNczD3DI2O
 G+x5ZB9HSSf+NSd1TaDo3t82NXgmYVUtpQJW+T8HtxrLdQO5vs3L/LunxnK5S4GldOLydyrmVkz
 w9MKwU44z2EM/kjNqjgBm+nBhLC0D2yXQ0pYuGEVRf8uLrmtv4af8Wta4GMPvKu8NhnGN7K48uj
 xCyNBHXn5+36EQyFjWmJ9KOayVS5Bogbs25kylVvQhcNsl3W77G6TYyDmAS9JyQzIJOl5hjjU30
 i0VrrLxkNlIW2PHjDFZ8htMflbkQ2jl6Hf2nTONgwdjmgPN8Eet3Ft/+CS1+9hSNXkTGjObr7/H
 +MXZWHDhK71Szk3O7KsVqC6CSak1uoBKv8Lo3u51XnMVzySKGuvZObvDx6/Tepu5JxNi8KyEkOg
 5cXdfba/I2uxnERljbN7FDCKron1IdKAGts+OjmOKQW6/t9id+q/OAPR5DwJlJv4gFjPrs8w8Hk
 MZeULkBikWADOGBbmrg==
X-Proofpoint-ORIG-GUID: 9-S6sqTVaWza0G4xdFKw1QYIvfMUx2jP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220015

On Tue, Apr 21, 2026 at 11:45:13AM +0200, Alexandre MINETTE via B4 Relay wrote:
> From: Alexandre MINETTE <contact@alex-min.fr>
> 
> Add the PM8921 USB ID interrupt as a disabled extcon provider. Boards
> can enable it when their USB controller consumes the PMIC USB ID state
> for OTG role detection.
> 
> The interrupt corresponds to PM8921 USB_ID_IN, block 6 bit 1.
> 
> Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
> ---
>  arch/arm/boot/dts/qcom/pm8921.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/pm8921.dtsi b/arch/arm/boot/dts/qcom/pm8921.dtsi
> index 535cb6a2543f..935383d6a594 100644
> --- a/arch/arm/boot/dts/qcom/pm8921.dtsi
> +++ b/arch/arm/boot/dts/qcom/pm8921.dtsi
> @@ -41,6 +41,13 @@ rtc@11d {
>  			allow-set-time;
>  		};
>  
> +		usb_id: usb-detect {

Let's see if we can find register info... Anyway, if there is no reg, it
should be placed either before or after all the other nodes (to keep the
sort order).

> +			compatible = "qcom,pm8921-misc";
> +			interrupt-names = "usb_id";
> +			interrupts-extended = <&pm8921 49 IRQ_TYPE_EDGE_BOTH>;
> +			status = "disabled";
> +		};
> +
>  		pm8921_keypad: keypad@148 {
>  			compatible = "qcom,pm8921-keypad";
>  			reg = <0x148>;
> 
> -- 
> 2.43.0
> 
> 

-- 
With best wishes
Dmitry
