Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D021F3C4B8A
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039317; cv=none; b=cUZ2sL2+eJHMJ9bQ2JpChHwOvdgi+68DiRgDn7ZvaeFx4YbdfYQ9i8KQ0juhWaKr3208CXBpT8cNHG1q/cKrqmq+gEe07s/yLaFnjz0M+rJm51DgvayIHhVCZde9xfVTEX+5ScvplkgBDEunlIu2KXiHDUIy5jgd1g8RlRGmxJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039317; c=relaxed/simple;
	bh=JJVvs8EUaddgUJ9aXVzqVHjbQkgsNK68CrmK7RkmTJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKsPK70gCF/Fwr7vYNhVRt2YeMSTXXQZ2nvSxPzFwWq/hR1tjTFsMSUSB097ClCm8jfviN/JR/lzegSYu371QVG3kjBPKnx1UoHonOxlt01E7NllZ34svCA56NTADGClPS9vHhGOZ8Or07+B8+GRwvl0aqOLSfYoXHnHui3x400=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QYoMJOgo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Eu2fLrY5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QYoMJOgo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eu2fLrY5"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H3vkkq2748445
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ge/u/FoxPMtAYYqSHirTxFEl
	gHYs0GUb9O+1nJcyRys=; b=QYoMJOgoYozrIjeSBncJR/hfIYTkMgRtZKu5qLJs
	+XC5RQx2VqcM30rG84WKVK8vlBWLZbAvkR+XL5zZy/5nHpXagKt9AF4Vo60BLQBR
	8w2jzdIahHL5IKCvKMBlfT1h4HRxDALhIacbBcSZyUShSDW0WH8aBDECtjldAs9t
	HsQplNamxhnJrS8rviHXZZkaAC0gim7CIigQt4Who4/9dW51S0GoXT/pi3HIWjiI
	KZ2Ngvh6otsR5hvIepXk8OmQQHjlDnmnZfTtbQtI/SFVKCnZJSIxqLXHpJb/lb9u
	+8/dq12yT6B2RoVJt5YspVT7TGetIotsjxUQKhylgty0SA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6h01ka09-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:35:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50faf575af4so47242321cf.0
        for <iommu@lists.linux.dev>; Sun, 17 May 2026 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779039314; x=1779644114; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge/u/FoxPMtAYYqSHirTxFElgHYs0GUb9O+1nJcyRys=;
        b=Eu2fLrY5JNLoJ9fvDgHqTTpyZ+xnVQh/QOrHtsDkmWXxOgae3l9f5rI3q0i3G3KxPt
         k3lPmIMHed3VC0ov/1bmwfX54RTIf+Ay98fKY6ae6lBm5sWrPrJlFAI/COnvT79gpVQy
         VXGzl72K62Fn0+k3d7cRlIM9GSarrI1hH7278Xl6nLA4HpB09sVT+VbuGOpkEp082qjp
         KFhQZYIELcE/4QhT31znzFdvf2MfdymF70YtQT/HpDQz58SlU1tsFZBtfQdM9Qf2jclP
         SwSt+nknHhVuxgvHOrwdQNrE75zbxYx8y1ObDnPLeMQB3u/XwmH6FCXHDNauVuAZhFzz
         dtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779039314; x=1779644114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ge/u/FoxPMtAYYqSHirTxFElgHYs0GUb9O+1nJcyRys=;
        b=flYSewKPUrPx0HSZqROZ/SXdmEX9VuzKxY+bpZ88fln9en/+RQYFVZ0iuqlnsB5bcO
         Hu0DYk4pEhdbXPMUj00+Jr4paQ0+ZbODIG0TUsU6s8GiXkOFk63OwJRucbdDkpKtiPd5
         SRDMFGmtV/FVghg8qPAasOZyFl6ogQZbMWXbCNhHcW3+iegbJfqmIUlnZ8y/0ZWiacCT
         ttwF9u3MycC64CpUnYxuL5DT8gnYGEUHeAfuOOgDwRJGn4TZzoyeQlMI88EU6i4V6TIt
         2sfY9p4x5zPE6mNUHsgVPZWsFyQ4kWnOJ+Y6v6nP0Z12wXx9ut21Y86QwEH9SRC8X3oD
         bnXA==
X-Forwarded-Encrypted: i=1; AFNElJ8VqON7XXD2OwyYKyGdqYt7LTI+nqBlYclDseYVkiG481ReFa8HV3sfg9192NLzcjM3nnYdqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YysS5qFRYE+ogz86o2DRtxJQroJEYeqlJeP5L3eXTgZ9GvJbXaQ
	BYVNKgpyPZRYqPAoeIPljlmBuFi3JFq0X4yXlHdwnOLcuNCM7K1JDzNXgWTdtZ3gL0q1sgURE+B
	f9/IobdZp2cVp8+Aw6+++OPThsSUuBbOuZJQf/3gOcRXt8ykhAM5t4Co95A==
X-Gm-Gg: Acq92OGE/vNMF6lT4TXwdxwE8RGsfmy/Ra6zfbH4maBT6+h0Vst6JAXXAnMnbTNg73l
	WmtFA4KLzUL5+yRGEfj5dW48X6Z+k3ZvPGkCdaXjfqh7cGmkzzwdARSpEEB6orCXo2o5zce3UZo
	dWJMDjIOfgbHagto9WG3xhLTu6q3VJ0ZhrKEJ5ba0L7Bb1w1WVslsPrWzSdSbphrlDWDSKAsBiB
	KxlHaonhZmc0kFeej3kmHUJL2uMuKatq1fl0Okk6k1tlc+Wsx4B/4J4DtJlO4jl1d+6SLrHKSOP
	WVbX8fXq7pJc7wAfJwH+MA0IrvlpgVnfjaz0ks6eD0tKtshuEVBLPJukOe2GlvJJ6zRmSTiagsy
	pHlvb7mjkP9RFdp9xfJT7eNMm6m13lBmNwQjTyR6UEdC79rx2si2uqZjUQVwj/G2XIJnADmb2gL
	vl7VspxEF5jD+siFf9GJH5lqi/D3mk9aukW9o=
X-Received: by 2002:a05:622a:28c:b0:512:e813:7ce8 with SMTP id d75a77b69052e-5165a2674admr179787121cf.54.1779039314169;
        Sun, 17 May 2026 10:35:14 -0700 (PDT)
X-Received: by 2002:a05:622a:28c:b0:512:e813:7ce8 with SMTP id d75a77b69052e-5165a2674admr179786551cf.54.1779039313601;
        Sun, 17 May 2026 10:35:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a91e2b6d78sm2783884e87.82.2026.05.17.10.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:35:12 -0700 (PDT)
Date: Sun, 17 May 2026 20:35:09 +0300
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
Subject: Re: [PATCH v6 06/14] media: iris: Add context bank hooks for
 platform specific initialization
Message-ID: <sqjbcmcy3wohzdiftb36i7ztfyt2k7mnxkrzxk5yuocpe7kfy6@ev2ouxxnf6cc>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
 <20260515-glymur-v6-6-f6a99cb43a24@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-glymur-v6-6-f6a99cb43a24@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: yJPfuJutHmYnAEeezbTboaxCnEjCKBCp
X-Authority-Analysis: v=2.4 cv=XbG5Co55 c=1 sm=1 tr=0 ts=6a09fc52 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=KYVELAUBrDEXRFeio5oA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: yJPfuJutHmYnAEeezbTboaxCnEjCKBCp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE4OSBTYWx0ZWRfX2fq3muvHjwU7
 /ri0JzeKsiRXoGEGLio3DhDJOnndE8BZKwDDAsmayIZM9EJVrNOXRgxEReVDCpTDEUkoOTU6/dm
 uHbqqjzq4XDnxnpC1zLKoKYvNol4HgbH0bKsnlWTGuOxmV5MTn8kWK6pFz2GYnK1LhmGR0Ksg5u
 nCgj6nh9GLdTW97FiHMDV4edaNRG4W/8Zr8Pp6fL3AaQe8JpRWy6may7ODidOqs2IHBtO56qaPS
 AouhAcCwwDcbZTr0l+S7bphHnmYnXND+nmLPeHkAftDVc9/wTcgZmH4Gat56s7qW+ZGRoEukswE
 Bk7ygmyG6uiV8OSokMUHctIfmuSppdgV87E6bria0es8WbU7XWWKDOk73LGAd2FLW1nsMsRhsG5
 0HgFUhbwbbv687TxSiXDltD8Nf+lPb0gdSvTeW6svEy9vBQODu3Xfswvb9xYPVvgBMjL0oidkmr
 waAJ2vj8RBSWt8ElTmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170189

On Fri, May 15, 2026 at 04:51:21PM +0530, Vishnu Reddy wrote:
> The Glymur platform requires a dedicated firmware context bank device
> which is mapped to the firmware stream ID to load the firmware.

Why is it required on Glymur? Is it _only_ on Glymur?

> Add init and deinit hooks in the platform data for context bank setup.
> These hooks allow platform specific code to initialize and tear down
> context banks.
> 
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  .../platform/qcom/iris/iris_platform_common.h      |  2 ++
>  drivers/media/platform/qcom/iris/iris_probe.c      | 23 +++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index 6a108173be35..84fc68128c70 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -263,6 +263,8 @@ struct iris_platform_data {
>  	 */
>  	const struct iris_firmware_desc *firmware_desc;
>  
> +	int (*init_cb_devs)(struct iris_core *core);
> +	void (*deinit_cb_devs)(struct iris_core *core);

Why are they being added directly to iris_platform_data? Why not the
vpu_ops?

>  	const struct vpu_ops *vpu_ops;
>  	const struct icc_info *icc_tbl;
>  	unsigned int icc_tbl_size;

-- 
With best wishes
Dmitry
