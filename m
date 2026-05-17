Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C4D3BADB3
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041527; cv=none; b=GmjtBlUOOXSkAV+dthCuly9o+ULJ5HPv8cLnHsDKbvxCnXqgHpT8ZJTiKjMAmRyW0xvhR9pEUY1ozgSF4m1+c12mlii30dd7Z3U7FFF9e62qPoa6q3U17Z0q/D+1awUvGthme4OSTblfaokR5phaCO9o6rYTQYB+YfpgRaNmFsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041527; c=relaxed/simple;
	bh=xGnD7yBHQ+nLtVK6MSzRD0aOKM1eCs1UBQP5IPYsJcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dk0X86R8AAlPKWo/MQ1FrsRSkSyM4wAG+fryKil5IRd2Mz5U2MYzTnv3GXfy+6vfv71yFJA5ahUKgOCc/AeEFSGzAJFrdQxJEchaGQ52NsspdQwej5kvQRmwMtD7SRaPnbfGe6sfh83KsRpb8mQFDPo1aPAp7JmnU2MpzK4MiDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GVcA2+Ub; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CbYVyzcH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GVcA2+Ub";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CbYVyzcH"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H0jV4m3270546
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 18:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lF3/2RUQuRYMFEAVIwRWtW73
	IO4hVQVV7I19wPH93XE=; b=GVcA2+Ub5pG5pXpJrE8DbKK6ExSfW7+aZ+zIInGk
	ow6t3kNJ+7lu2BA542LYfO0ixTjYbaZG8ExG7fS8jeZPBTtlLxHAinETuh9WIwCE
	Kux6xv9FjTGjm3OR3IKmqeG7saaofT0rLw0ORGaOzcIhtF1LXDxU2Sn2BND4R132
	tGy72AAitoVJWOlNsRlLqqQ0Lw56G0hEQW+N7vgeU6kOyAWJqDGlZuKqTM+F2jYJ
	slOPpqpoRjBaPXaYB8cwxgaq76FIkENRZNQZfXSGu/ejUMDBdK3tsrhlxTrg4oal
	/FJNAgZdQHFG/r6RmtxURkThGD5iViWoNKVlgrns5McnMA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6hbcb9ea-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 18:12:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50faf575af4so47636331cf.0
        for <iommu@lists.linux.dev>; Sun, 17 May 2026 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779041523; x=1779646323; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lF3/2RUQuRYMFEAVIwRWtW73IO4hVQVV7I19wPH93XE=;
        b=CbYVyzcHowmtiNl+UHSs9c9ef671Hp0/eS+PFG5BhMDmLBFT1Rz1V+DM61u2VbZ98u
         wYwhM2/CVEufmsI/12RtTRDfHdWxEmyeF1umIZ2dD2QMKnv032qqTIsoKfa5gezBeVsu
         i2e2+dj5xZSfSWdrEg+16FsyD/+Ld+hG4FoPPp8nPsOtg74MZt+c8DWj8nTCEx+xl0L0
         zwkfHV4PPBjgn1WzJdxr+BQWESkh80YxJKMdslG+ZhX/2hN03OQGbVn17v9fIP0egv2G
         Vv6hrfe/ccsmPId++4LbZ3vm4UVSPH+p+fCLTIft+JBTWcyQXGvD5bF1nauary7iDBDO
         b5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041523; x=1779646323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lF3/2RUQuRYMFEAVIwRWtW73IO4hVQVV7I19wPH93XE=;
        b=T9GjmR/lsNoL8cFPkqnHI8zvD1AC/jMfzjr42/gF56O28MhDC8t01Pidi5R+IrF7qj
         jAXVe95Zk51oRuy+JtiVliNGLE8+KC+dDu3ob2BZTpcJRfzEPPnvqbkiaxuJhAIAIj9Y
         80jOKrzCTmGZSCsuhNSNoMzZW3Py07AvAU0x9750/h73xz812Y3qqjjqUoDJTV82qfHY
         JdpH/aAJ7KDgS69UijFlaETYWEdV5t4BpO+vVKYJdFMCsGRCJqYmcEiDyFcNvctPLQHA
         6yh1Xv1FLp3oLAbl3+7gajOe7M9goMxbzs1ctVn18s9P1JkHKjC73CrCjqiPGSNvpWMx
         WZQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Jzs20v0lcMGtLtvd+5cma5AoK6xHxK6Gr7ukI+JBdO3fiIdu45K/XvRufo0YFkXVbKEOW8w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0+m2auBMZ0p6Sp6e/qkndzCsU1ibOXIVv5Zylwz3s2PlPwJ0Z
	764hsTmG65Ucm/crjaiciL22pJD1H2fiIkTT5/f9IdURllGz67/Cf7GdUGukl3B+H2MahqW6gOE
	pNw7kpOd/WaniI9fFX/p1LCXdzX+7jdhjUZgvd7TSQxdBY7Azc9MQ6+4eRg==
X-Gm-Gg: Acq92OHcpJ+RyWoqYYOtVMvTs8q3MsT0V4/IPtGlTleIcWEmz0B03o8/dzPJ9iTlLIy
	fTb+PsHAiCWkbdwYm/8h0310cCl352P5k/VyGswgAZkbV44CYeGShHRK/stx8Q/g9aom+N33D7H
	Jc6JK9MP0ZBgqjqHtLFD31VplMBqEKyE/nufhlFwCk3Fws9jx51X2zFlsfU6B3/mUDmqMM3ulPm
	MHDvKVsXocQ04HfgZj8/9elursV4hEqCfpsaK4RlxSkoiiNrOHKOs+9he60DpSbJFooIcLySl8b
	nznHyAcL/JRWxFsqJHFtvsFp09hkTPv722nnpKqYZWZRqYaXuuKAYUbItMGSeKQkeT8+v7pciHb
	B8RYEn3cXNNLHmw8mHn9OVP/X/lmn1V+cDsXEiZcd6lGvE6hbGaMrj+ZPewYLkB2pTEsFRyYhCH
	RsIyxs/Ib5413q4P2ytt1ouT5a+QYorMtiB8U=
X-Received: by 2002:a05:622a:8cf:b0:50f:be4f:465e with SMTP id d75a77b69052e-5165a25ce43mr184112001cf.53.1779041523237;
        Sun, 17 May 2026 11:12:03 -0700 (PDT)
X-Received: by 2002:a05:622a:8cf:b0:50f:be4f:465e with SMTP id d75a77b69052e-5165a25ce43mr184111521cf.53.1779041522805;
        Sun, 17 May 2026 11:12:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395887b6cb8sm6721051fa.37.2026.05.17.11.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:12:00 -0700 (PDT)
Date: Sun, 17 May 2026 21:11:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 13/14] arm64: dts: qcom: glymur: Add iris video node
Message-ID: <fc2wiqf6vxob2lzp4fypekcdeuf7mcmn7znszzm5drmlkrdndh@ph5mgjaezdzo>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
 <20260515-glymur-v6-13-f6a99cb43a24@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-glymur-v6-13-f6a99cb43a24@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=cuSrVV4i c=1 sm=1 tr=0 ts=6a0a04f4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=0_QClZtVb7ToMYl6Za4A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5NyBTYWx0ZWRfXwRWMPms5NA+n
 7VtmiOw2bscTfz3mTiL8rEmaUVNKbdTh8UsM4VYYtUOWU+jQkEGYNgsUw5jBp8y47hvQIjYNTrQ
 2Nq7JnoMvl4Pe9ltK0ZHBPN6WtT3r1m4PDSY+rH7rd8bpk1OAYSKB3Q2/GTFEQ2M2ZOkBbSr/b0
 kzeITXHPDKqSFDYJOzEeTlxvxDI9UqPaM8g4SiQ8ZBFY14rv0FUepBfGFM5oR1OnC36fYB2h/IQ
 PhfYArb8bCzbIKARpTtvGrNH/utv+6m4FV4rUjvLx9pAoBfEpQm+ZB6/RZn2iBKTHbxUI9pvnaC
 dL2ZswAAY7SV0i5pCFI6fnKTlQpH1grqun8Dei0NYNObrIYM2uXeYepymvTsreLDQlviKgYWqfz
 2qGyMICBEJt1D9xm0ri1WpETHlIAyP/YD2J9XI61Mb6llBKlLnVxglTC+sBTB9nr4hZvzDSMeaE
 vJy8hzKUCnpyoGLtcVA==
X-Proofpoint-GUID: Q1_DtVSH8TvrCxuGoofxGRYdCIhVbg_x
X-Proofpoint-ORIG-GUID: Q1_DtVSH8TvrCxuGoofxGRYdCIhVbg_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170197

On Fri, May 15, 2026 at 04:51:28PM +0530, Vishnu Reddy wrote:
> Add iris video codec to glymur SoC, which comes with significantly
> different powering up sequence than previous platforms, thus different
> clocks and resets.
> 
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur.dtsi | 118 +++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> index f23cf81ddb77..c47443174f97 100644
> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/interconnect/qcom,glymur-rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/mailbox/qcom-ipcc.h>
> +#include <dt-bindings/media/qcom,glymur-iris.h>
>  #include <dt-bindings/phy/phy-qcom-qmp.h>
>  #include <dt-bindings/power/qcom,rpmhpd.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
> @@ -4163,6 +4164,123 @@ usb_mp: usb@a400000 {
>  			status = "disabled";
>  		};
>  
> +		iris: video-codec@aa00000 {
> +			compatible = "qcom,glymur-iris";
> +			reg = <0x0 0xaa00000 0x0 0xf0000>;
> +
> +			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
> +				 <&videocc VIDEO_CC_MVS0C_CLK>,
> +				 <&videocc VIDEO_CC_MVS0_CLK>,
> +				 <&gcc GCC_VIDEO_AXI0C_CLK>,
> +				 <&videocc VIDEO_CC_MVS0C_FREERUN_CLK>,
> +				 <&videocc VIDEO_CC_MVS0_FREERUN_CLK>,
> +				 <&gcc GCC_VIDEO_AXI1_CLK>,
> +				 <&videocc VIDEO_CC_MVS1_CLK>,
> +				 <&videocc VIDEO_CC_MVS1_FREERUN_CLK>;
> +			clock-names = "iface",
> +				      "core",
> +				      "vcodec0_core",
> +				      "iface1",
> +				      "core_freerun",
> +				      "vcodec0_core_freerun",
> +				      "iface2",

I can only assume that it is "vcode0_iface", "core_iface" and
"vcodec1_iface".

> +				      "vcodec1_core",
> +				      "vcodec1_core_freerun";
> +
> +			dma-coherent;
> +
-- 
With best wishes
Dmitry
