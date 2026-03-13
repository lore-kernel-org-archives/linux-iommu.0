Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9223396EE
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416298; cv=none; b=IKl0SIueT1m9SfdXHKG52kfVgrocPqtKkxjRv2lfezDstY66bWdVCEWWlpNGnCzNhsjEoG1CiexH5NJGfRjicXD3W/Tdhm49tCyeraePqoUaBdiYzrwJOERuuP3UlciMsEoz4S2oPBBOf+Sx0zZ9PDoZcRl09P7Ssfg8Y+aBGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416298; c=relaxed/simple;
	bh=DzV86dVTBkJFl+81gRHZySlu5Hs7Tg3y7UcFrJIGUqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Icnw7/Li24IHKqud+561rXwGtaM8MwdLUU21Gu+WxGZXUEClcELD8hjizYwnIXFfsWl4g6zOsePmMMm3lQoTjE8nW+MbUbTUt57mQjLUk/wuFG7tDclF8j2uBg9Nvy4mxbafu0xLW4a/3woL8Krc6vkQ0d9JSt2T018N4zm6Mwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WKoaJeyJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CzxLi+sY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WKoaJeyJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CzxLi+sY"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DEMUm9237560
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HfoqBgtFBPOG18HFwuX3p4vU
	62ysi71nghWsY8TsAl8=; b=WKoaJeyJOc1oLoSS9CiFqw5SciMt9ESBcfV6DMfK
	32DM1n/hxoga7Zl95jydi75qyeNNcrPxb8y3Wb6ZSc4ZnOdHmPaGfk9PQvMcWRAQ
	jlbvSFNl+ffSy3Mba3tNbOB4LVktOuQ915luix6M9Lr/io2+u/VEcZ0TeZwPR68f
	eB639YikvY67ztSG1FVpx6OUoKvRg9XgAvgwo2c+eV2LXzUUDFo0QQR+nqvHyiLg
	w/v4URjzR4keJ6O8YyjzAjQlkImBrIkAjrJSC2Ilb0bLMTYnW/Ha7HQ2kEViNfAF
	qipje3K9Qan20VVki8AoxuBWhbJ34dUbXeXP9NI97MMZaQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cve3d9r5h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:38:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd80bea54dso1318131085a.3
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773416295; x=1774021095; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HfoqBgtFBPOG18HFwuX3p4vU62ysi71nghWsY8TsAl8=;
        b=CzxLi+sYzxFWyyNBYtr/QX5qtpYT55wuv61rm/rHW4q12Ki9JU8blyIEqUZYRiEnrP
         DmeON2ujHfGQR3MeV7BxLFlt9+KohHa+LuW8xcDj61tPC07xpaIKBsJ0cNUrGhUqI7VZ
         IBIRC7WlMfiIKd+xfl+46gGEFXvr26rYGbaXXGPR+kBIMOmdW3X2xaIDgyK3XS8K1W7x
         aVAlIjWg8hF7u6PldVHiOdD3pbk+8qx6ZKQKOd1/xYd5elqS3VlnczW9vWmpa7ROjOcU
         5zb6Kl40nuLkIE4T+rlYWe4SftjzusLpcwaJ/IkMHW6oMlsIeXHPA6pTUt9vsC5GrgGc
         GS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773416295; x=1774021095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfoqBgtFBPOG18HFwuX3p4vU62ysi71nghWsY8TsAl8=;
        b=Nl5C9rA0WH56bpv4y2hi/JsP+JyozMr+PkEc7pXiD7c4a3vU0yp1rI0ozty5nHOuAC
         RM3kdfOPFK3hRCeDUWuUwRjaccgvCJYzIUi4Vm4nrw2XgSezKnc0ZPuXXHsLAlPCi0qm
         rZFolNI0azq/nyrBhx11z54AV52VBIPR5lowOyLiiT+HsNPEuCV7x/Rhl/ksFV53uCaL
         TbnzfDmvmwhR2DxR3sha2gl3FWw6RuKj1ww8tk4cQvMvQxV8H4PxRva1dVsza6p0a33W
         qO6Tb80ZnwWwXsN1Plmk1qTEBKzR5baKqhk5TKSK4mNuZQ/mlohAGth3uw6Si04x/HPK
         dGlA==
X-Forwarded-Encrypted: i=1; AJvYcCV5PCx5vaMFB1FvtLAm80hmzMl3bVJ/GoGTbTyQ2WG0N9WIwH+0QzjwGjxtPDbOmNm5G6ImxA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxo3eFGzePPnlYwp5XnJn85j1dFJx6pSO7XmweZT8uJg/OxgmuV
	Iv4Kv4XblClzkx7qROfRVy/n93RR0SEhNxEYqiegcWBjGJWy+uSv80TCzNzhhJjuuGLmkmqilEV
	Xs2TTUUYKK2vipNzrKYDGKxhAlA910Vx0WTbZR2M3KKKA+scW+GFvuXeSpw==
X-Gm-Gg: ATEYQzx+foXOkbfwFWoZqejYAx5b2jcwZ8tpV5uKMqANtD8r5Oxza+FzOk3s3/QSxap
	A4SrzRNXgXtu7PVHrS0grMZpW3YkEZbu6fa6c/WCOeqShAcYD0VZTQDUXh1yGovdgcqz0w8IcMQ
	YJMlo+5EUHOUi6SLQTCz1BGvuRtE4XKh7Gf17S3ZW1AhbiNJXAua4ZhkcagCIJdJkONk6LBbgfU
	td8/2vRh8jvsQhvJU2SoDN/5Ba2EYiC9JYmrrgoB0BDD6wKoGjJ07tVqSE4MiuWT5PeyShx4DiH
	R1TBzjDjWE2YNnXklR3zkbiMG5dSsL0LGpUmtkOWJYcyCKxiZzZpPvznIM17i8BseIZW5cl5dlE
	VP1xVc+XYW3ZI1XTF1pKN33qKByR0I/XFlzGlPsTmc3NjIroaHisuFjy7nYQ9coOoeHpJH/Je2o
	WKTb/2PMUvL4xoPsnZyrQhIOO5PNueDPAvwNI=
X-Received: by 2002:a05:620a:44c3:b0:8a2:234a:17be with SMTP id af79cd13be357-8cdb5a1c13amr525243085a.7.1773416295408;
        Fri, 13 Mar 2026 08:38:15 -0700 (PDT)
X-Received: by 2002:a05:620a:44c3:b0:8a2:234a:17be with SMTP id af79cd13be357-8cdb5a1c13amr525238085a.7.1773416294908;
        Fri, 13 Mar 2026 08:38:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156162b08sm1560840e87.53.2026.03.13.08.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 08:38:13 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:38:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v3 2/7] media: iris: switch to hardware mode after
 firmware boot
Message-ID: <6hz4rxfxhllulc5o47rwltcjdif3ocqvubfvsh2qnygmnacpyk@hirsszuwi3so>
References: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
 <20260313-kaanapali-iris-v3-2-9c0d1a67af4b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-kaanapali-iris-v3-2-9c0d1a67af4b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: vKcqJjECm5_5alZUoQLfCwUpMSUhBHtl
X-Authority-Analysis: v=2.4 cv=FLwWBuos c=1 sm=1 tr=0 ts=69b42f68 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=dE1MpONsbtOZy1RxgbwA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEyNSBTYWx0ZWRfX4jYxhNUGXDyE
 i6j+Y7yvVFZOWGzYmtyA9FWiThSSv8z79KB6TylFZa2F0IelkZYjr+0o/9ZAbmvRFj8fkwtAHLW
 ePyaF267Zcl18TQPbjUpnAUGdpHRqllLkoMpF23U87TgdWmRqZjbQCC9SZbpn4HvBxne2NAZNa6
 wtIPLQ7wJpNbao5c9L75dDuQgdJ+zow+zp+8ltnwLCC3u8/p5oGwJy9vJTaMwr2ZBx7pWH1Ldb+
 zBdrgx9RvKKsokHNZpCreGETL8iF5/8C6d1+LLINuw93ifxag9lL5zhZ2FMr81NbcgHC+btjJpb
 VOkzBezoZnCVCUAqmvPLrqlCjww7kNdPnr83pFw1jGjj0Qhgj+2Qco7QhGWvj5HhvHiCnQapDAS
 iOnhgrIAvtF9EYeYuw+coFO/GzZ9T+vY0TgzN1dlO214CxmQR74mSSRvJXvXP3ABznJQoy33TZz
 px/D+qOy4jB/FxiJ3zQ==
X-Proofpoint-GUID: vKcqJjECm5_5alZUoQLfCwUpMSUhBHtl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130125

On Fri, Mar 13, 2026 at 06:49:36PM +0530, Vikash Garodia wrote:
> Currently the driver switches the vcodec GDSC to hardware (HW) mode
> before firmware load and boot sequence. GDSC can be powered off, keeping
> in hw mode, thereby the vcodec registers programmed in TrustZone (TZ)
> carry default (reset) values.
> Move the transition to HW mode after firmware load and boot sequence.
> 
> The bug was exposed with driver configuring different stream ids to
> different devices via iommu-map. With registers carrying reset values,
> VPU would not generate desired stream-id, thereby leading to SMMU fault.
> 
> For vpu4, when GDSC is switched to HW mode, there is a need to perform
> the reset operation. Without reset, there are occassional issues of
> register corruption observed. Hence the vpu GDSC switch also involves
> the reset.
> 
> Fixes: dde659d37036 ("media: iris: Introduce vpu ops for vpu4 with necessary hooks")
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_core.c       |  4 ++++
>  drivers/media/platform/qcom/iris/iris_hfi_common.c |  4 ++++
>  drivers/media/platform/qcom/iris/iris_vpu2.c       |  1 +
>  drivers/media/platform/qcom/iris/iris_vpu3x.c      |  9 +++-----
>  drivers/media/platform/qcom/iris/iris_vpu4x.c      | 24 ++++++++++++----------
>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 16 +++++++++------
>  drivers/media/platform/qcom/iris/iris_vpu_common.h |  3 +++
>  7 files changed, 38 insertions(+), 23 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
