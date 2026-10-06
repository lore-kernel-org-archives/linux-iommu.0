Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB534582EB
	for <iommu@lists.linux.dev>; Tue,  6 Oct 2026 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791292751; cv=none; b=jXnx/QPK8XHB0REpJyoP71fLf17xzljUn3dgfrTD7lYyi2P1/FjrcsgvD2r6mZE11W71Wm4DHffoydCbGGpvl775VsMcArcM0Gygl79yEApbwoQ9AKQB2AJqhyN0mgi0+ACKISsNyAKf4rm02x/xwNlHaAE7Ma28auGzNwrF3b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791292751; c=relaxed/simple;
	bh=eszSZMOJpj74kh0VdtVM25yFcD4ep3fqH84k7hrgH0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzS7kr48vSPaO7WgjMiqAQRD2H1fdgj+meKlUojfPRtEvHzctThL8VpUtnYtRnHbzZJgI1mhrjC4iMv/g63dp1Xaty2VfYJGgz81WpSLE6G3wlyzosPQsuzFpgUWY3DRSr1JCSB+7+21IAfuWEkyFzfpkCH7WGzYNeiXiHn2pUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=djpO39YQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U/a+qkf/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="djpO39YQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U/a+qkf/"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BPNKI535559
	for <iommu@lists.linux.dev>; Tue, 6 Oct 2026 13:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3977fqgFQopqrOyetisycUnU
	JNoVrBq+V4kqibqFyZQ=; b=djpO39YQ55MRcLvTrU8FokAtAmc25B8PO6rhSyDs
	RJU4RGI6ZtKkLJ8bTvW2KxxuFZFTSiujmfX1/X85RxYrkbuMuL1CgeaZnPL9i4qF
	54XN73PDYKUfTJzZ1A3S386RM5q3T2Sh5TRNp1ckEIAV07+4eJaoO/nPw/BG83Fi
	Hq3N/Fcw6MgPuaQSCfzrNrI8fBoqq5IpYeht+/An7rgZhb+bGiAgShgYGyFrIdpk
	s+cxaQhxcHjn0+TsjzuOfzlXjRy53E4l9GFJ8lea3j5Vdc77CMbIMIuVau5+QeXb
	siQygViHTHY1l1TttPP8fjQWhuqepsqUcAca25vW3utrNg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr0bqmy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 06 Oct 2026 13:19:08 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5cbd8e78a66so2675226e0c.0
        for <iommu@lists.linux.dev>; Tue, 06 Oct 2026 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791292748; x=1791897548; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3977fqgFQopqrOyetisycUnUJNoVrBq+V4kqibqFyZQ=;
        b=U/a+qkf/uo+ZHcp87DYXDZuQuVsWFGQuCOM6NBZ9SB6O1YTZdniL9jaltFfju++Xkn
         RZ5yuAuWxc4pp0yD74iPL48FsQWWIjmXG3IS18T45OfsYCnWJnqDeTMHIU8dRz+HoX0u
         tbpi1DJhU7JkPvFd6rpC2woLElXar2drC2cx7FK1HX1OoPBqybQsgJ1kNGrCCao19XjG
         tchu6K+3D4gTZovLTEIftAnXpuDD+GNI2LPJ7orH8TEeeh7FaC9+XdMnM/ecedTo5UHh
         cxKEaE1IjlNkewRWbbBxWqlCxT4XM+8/msDe2euIm75QB/31l1XheDbMzu1LOlTJJCpm
         BPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791292748; x=1791897548;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3977fqgFQopqrOyetisycUnUJNoVrBq+V4kqibqFyZQ=;
        b=IsQDEMhWfjgV1rmV4JhgXyKBl1iKYOpGQ5wV/AEflRNIuxVwqClaN1XXQt8LhmzHZB
         mQeQQb1rn6N2i+ydt6QKcwJ7f5EQuLAl8VAqMETalPuIlpGQkfjZ7F807fQI83BMAwtQ
         Yi+SPHp8rzcHCMEq0THcxdqeYTlRk7SUGnvEwK8Vue/iU7GBeu9SK0U+reez/oRAYi/t
         Jsgi6H5kFc0qf825UoFfo9jPdeFBbEI5qLgovfkXVC3IR5Twmjis0phridUW9e1dGgnV
         iJ6EsOGXi5QDeetvEJQFTmUAHvNTxKmDE2tpOBAUPOKMEfW5YgsHDIKqOkYgdhWQ73hv
         v8xg==
X-Forwarded-Encrypted: i=1; AKwUvByRcu28V8HgV5Fj3c4xAr083HYEUiSf3xbfWPJ5LE4hYtIVCA4YKLIAyAhR5y4CGY6o82HCjw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKPBJiaHJ0k7MePGcHMJ76uW1Uf6i/ksJfWOZGh9o5vgMTH/a6S
	Q8xtHoFzOBkzMc4ID/nVOhamOHZRFnsrVJZU1RhYkCuYoQmfgtWLoViRa83qsiIhPea3RolvHB+
	7nWxu0XoHT3856aOl16KZeo9ICfdCQr/XHvNyNY6pC3GY9xw29q8/4PwAFQ==
X-Gm-Gg: AYBFou3Na1Jg+bgXPslMUlEwLpvlIy/F/diFdaDdMp+Xmv2K+ZTNwPPpftUxDWwTdeW
	6tbHevvOd1bTtojEjAjefBlMjjnzarKHHAXjEiMMv6bKh4f/8fKqvD0riTeW+ALDk1/Vh2Q5QHO
	FRSJbw0R0jjBj212juHlJcLqiYnjhUyAI3nCIuVPh10ba+xjSPGYYvxC45TdQamG5wLkCUHYv9i
	5KjLWIgE3X35sTmLIqCLq8lksudHAHuca8fLuwQn5dX5n5lFZD4LBPUtzvueq4bgaLXFpV0hCIA
	hb/nh5GDkLaCR7CNvOkcf4DlP326zjFL4SupD0fLDdvipBCld53WxVibD6xWi3BmP3k7xyvuUT2
	N22lANSi7uLPB8fiIByIO+jVkNM4SBIvK4w2WX/IR6YYvqPb5UVHwhks5Y8LCOTmygWL5lfzdpn
	gb/NUgM07okWeK
X-Received: by 2002:a05:6102:b15:b0:7a7:198a:c2bd with SMTP id ada2fe7eead31-7c87c9235c2mr384662137.37.1791292748020;
        Tue, 06 Oct 2026 06:19:08 -0700 (PDT)
X-Received: by 2002:a05:6102:b15:b0:7a7:198a:c2bd with SMTP id ada2fe7eead31-7c87c9235c2mr384647137.37.1791292747447;
        Tue, 06 Oct 2026 06:19:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a99ea94684sm885231fa.26.2026.10.06.06.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 06:19:06 -0700 (PDT)
Date: Tue, 6 Oct 2026 16:19:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: muzafferkadir@mainlining.org
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v4 4/7] thermal: qcom: tsens: Add support for MSM8952
 tsens
Message-ID: <suzsbvsdlfrfsnvaerphqdycaaaiu5inh5uw5wups4jmfozkbt@n4lsb5pfdhbw>
References: <20261006-msm8952-initial-support-v4-0-ecdcc1ac620c@mainlining.org>
 <20261006-msm8952-initial-support-v4-4-ecdcc1ac620c@mainlining.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-msm8952-initial-support-v4-4-ecdcc1ac620c@mainlining.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfX8uww6t24Ad9o
 AJWbJVjDvBHt/hffzkuyGFnj5SW1mBWdIKFR2xGnpQWbtyCHO+V/yeUl8IFuAPjdSHMSwpiyBTS
 7MWy5J9sXlc5FjNCtqmdC9Au2xSGPFCaOZ3lDt36mQ/bSD/erzGgHOhJbvw0L6Pm0cTptPa1xO1
 domACTVi8Yt/BSjs0XX8Wn3LC989WXriROnfxIiDx66keleFd133a3iGQYk3XqbnAyExqf0emQW
 zVrLoIHZWMkmI1uX9S4yfH4+/LCA3xhMPqLd3oJyyK9tjJFiFGHot2k3MCMVtUh4YD01izoGHkU
 YDBKOmt7epSP9kwCr1SYJueB4jbmgf7xxQP5EjkUY1frwYFLnO08GCqlfSElyFshV9LtgcglR5Z
 vtx6O5yWOR1IkNMf++E3vtNnQujELB/KT4o91afHH98WM1aeWwSnxxvP5iBhKk7l8l+EXEwETfW
 MPcfiVrdVN8dx0DoMng==
X-Proofpoint-GUID: hYHQRGTA6zbsfJRxWIxDosbg3TTr-u83
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfXzPAo7M1Vqhse
 wt+OSW/o7XtXbOSssS7o28BExXalJYfSOpFAXO5cSZ3aO/y8B2ZXfL4ybHjc9mQn8o9zUR4DRYQ
 Amlpf+5+b5DDG3XZD3NsqFoZgAz3mwg=
X-Proofpoint-ORIG-GUID: hYHQRGTA6zbsfJRxWIxDosbg3TTr-u83
X-Authority-Analysis: v=2.4 cv=BrQIUoX5 c=1 sm=1 tr=0 ts=6ac4f54c cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=Oh2cFVv5AAAA:8
 a=OuZLqq7tAAAA:8 a=Nmgb9aOmcCZNRWd-E-8A:9 a=CjuIK1q_8ugA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=7KeoIwV6GZqOttXkcoxL:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060052

On Tue, Oct 06, 2026 at 03:15:11PM +0300, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add support for tsens v1 block that exists on MSM8952
> with 11 tsens sensors. Sensor Offsets and slope values
> are taken from downstream.
> 
> Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  drivers/thermal/qcom/tsens-v1.c | 44 +++++++++++++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.c    |  3 +++
>  drivers/thermal/qcom/tsens.h    |  2 +-
>  3 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index faa5d00788ca..f4201748ea29 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -145,6 +145,37 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>  };
>  
> +static int __init init_8952(struct tsens_priv *priv)
> +{
> +	for (int i = 0; i < priv->num_sensors; ++i)
> +		priv->sensor[i].slope = 3200;

Where are these values coming from? The driver that you pointed out
reads them from the QFPROM (like other tsens platforms do).

> +
> +	priv->sensor[0].p1_calib_offset = 2;
> +	priv->sensor[0].p2_calib_offset = -1;

-- 
With best wishes
Dmitry
