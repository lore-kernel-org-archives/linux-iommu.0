Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EE43C5849
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779038702; cv=none; b=bQMlyxjrh83J/XJIdhc4a4kWJxvVfmcXxOhaoPlsUBMpUxicWc5AJHHVwngyL1gJMN+jkYt2Z4XKzx1vvaDLJC/anp+8oajI9OZp4ZXi0UdegNmHfa6bImZz8/rFQ78vrwj+gGbX9NdiEr9iKGwxjUdqFAMYyb4IR5Zv7fePbwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779038702; c=relaxed/simple;
	bh=wolJ4ThGe8dC9+nkGWmJ3EDbmW5mWWkDH7iALQvuVsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN2Bk+1juH/XN3mO/419fiweGHxbjPZQNu/QOEO75B7mY+XxDJeGhWkVylOEabgFcsq5u2pi4NV1TRd6ctfMlTXCb6hRPZ2aq+bmWGD8m/cKSYw//op/J4s+GvF2JStUr6XxLooWt4d9GkPIi9zIJf0blbMZF0r50wd+u4rQx2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=meKhTaR0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UQA/cj58; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="meKhTaR0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UQA/cj58"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H5tuhF1683834
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=62y0GV+EuCwNt4/8lErab1ei
	sydCTnrzt3JbW4c45hQ=; b=meKhTaR0O2rYD2EE1otQpoGUaBG3tt2BzmrbUqFS
	JbAn64r/SirYpK/2EXzHaeLMDZss2LqyV0+/K6lZKUywebHVvJ6dwQC/Y9OxP4bX
	nYFxCxJss2OEbUS7YPc3ymekaZvkBmOxZXS8EAscEgngwL0JQIy5wWzNuK+4T3bs
	vPqvRMKmfDOCgXvSlPpsDn8DtzskgTmTQF/Ldhwbt6PDGJ0z94k8fsko66Z/iSP6
	QdWAnf1S8AI5oXv78SmeA97VofYrhu9yZl+3F//BHO5fbEqzaAU2QOI/MNTfyqPy
	9yK5C0S8dy9pdUoSv5YuHEe6DQwtE2aKHmcl1Kr9InpyLw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6hv7u696-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:24:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5156c85538cso49674581cf.3
        for <iommu@lists.linux.dev>; Sun, 17 May 2026 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779038698; x=1779643498; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=62y0GV+EuCwNt4/8lErab1eisydCTnrzt3JbW4c45hQ=;
        b=UQA/cj58xNn35EKlHyelDKMmekmEPBP/NBu1fFyoKi21pEHeD6EZLGeL470so3pYN4
         B85qrO2ZMkGQ0GUglbVFCsI1KvwTxOO3O7xxQ0ruYSjMjcTfzQbAefHiCtHlyTkS06ME
         jVOV6o/+paYi3mLy/BaOjBqdkObttmPmEHRw4fn6C/12X/0FmBmvPbq4B3JbBPBnRy+5
         NICRYh86zZmrPdjqsSm3gDqbT8rAkjidex5wTSc3Cb10zTH4WXdHWqadlZHazBf5pb24
         SvKqfH8l8rD5pFgT8D4nbjautBuoF9Ff+pm6CNHkmBOBSNoBL8I14oAWd2pb3mz7MjFn
         QwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779038698; x=1779643498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62y0GV+EuCwNt4/8lErab1eisydCTnrzt3JbW4c45hQ=;
        b=eAhUkpCDwb1ggd3EfM+JWzHOELJqk2FwO7q523NoIoZ2SG300RO10v7Ml/n34CKAIz
         agLo8nnwgOQ0Jocay0j2lkERtnXGinvoNotNlIglNIx8p8Bsg0IMfS61y93eFM/V4qOk
         jS0iuGzADpBPVhfFyK3nS2EGiUB826wH0L4HI2xGP0LUI86Q1XWvXDg7d6HM/tbB+rvj
         mpqmHYvKoWcBg60C67y35mVvKj0qjjnEsDJKz7yFRaXHyG42k4kWNhIO/S5HUlUMoiIa
         Cur3g0sjhdgmVm1hhguqVA1SzZ0Pc1HVP3PuTrx4IJ3YY+TG9If9vfxqoi+84zDJ12pe
         r3jQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ppdO7s2thQBJs/thtrjuFYVs2Js5/KoZhG2p+xRoMs+F3SwI7yf8o+mblhOtLFvNifOOB8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtbcuO/aef7bT+3LBgCa3+aA4a7F+aVTFO1mnmMBfEUWe5BiSC
	r3NhuxKvjD5NsW0C9/r/TPA/Mn97jTSwpK5JEdWtcOWzslpH092irfnVmm0uqVl+fUYO8cyX35T
	HYDIAUrUvWgntfw+D/8Mi3xlzD3KInZTktk9dvEitv/k19ZhZUfXWsqj4uQ==
X-Gm-Gg: Acq92OF3aEs0KYwA35Sl4TOlPVzDo6eD58UdqNHO5J9D+aahgcAXQ/9BddU425g7RTS
	0wm94muex4HbsfrQdDKdoubX70jEnC1SsMG8v/LXZJs6Yx3MrwtFx9resyP9ld2dLM9b5VXIs2A
	CeePPcECjJP8fxdkQHrXd3y7LOw73vZaqe4XtyKeBB/FR9Xr4cAvYc8xVPfqyUN//wuYSaAb0pr
	V0p+p5fT8YGelTjpRzTpf05jgX0544Rt8v24C++OZzSP9U1GWaptgtMfpL/hA9NX1sfMtflnFsn
	uDY6Ninb27jc1H+Tc+9ygHHl4ezGLahLiZbmF52km+BZXj2uLT7D3xAMZrjzQF18qbnhQDm9t0m
	mm72BQ/9jmjv6JfivDD0MqA6dJImbOhyLm9aoB95SQ5GVApkAhuDCiiyu+EEqDJaLEysIH7ZxQ/
	bP4IQnoEPDizKb4egi+SMARoIWyrgSv721aSeJ4O3uRCNW2w==
X-Received: by 2002:a05:622a:1dcc:b0:50e:5b04:810b with SMTP id d75a77b69052e-5165a0a4091mr177101691cf.32.1779038698557;
        Sun, 17 May 2026 10:24:58 -0700 (PDT)
X-Received: by 2002:a05:622a:1dcc:b0:50e:5b04:810b with SMTP id d75a77b69052e-5165a0a4091mr177101371cf.32.1779038698161;
        Sun, 17 May 2026 10:24:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958874ff29sm6451821fa.22.2026.05.17.10.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:24:57 -0700 (PDT)
Date: Sun, 17 May 2026 20:24:53 +0300
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
Subject: Re: [PATCH v6 01/14] media: iris: Add iris vpu bus support
Message-ID: <5l4pecxynb7mip5tmzspxrjnzy6jkjxr6fru6lgfy4lt4vo2r6@cm3w5t3bfksg>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
 <20260515-glymur-v6-1-f6a99cb43a24@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-glymur-v6-1-f6a99cb43a24@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE4NiBTYWx0ZWRfX9SCXP7JCy8bp
 /YBRSz1LavKxPXRA+r/76wHDGF4nT0h15YZd4R1j9KLQVOngKiclIZBs4mnf92vanhSRsiiOQON
 VOoWtw/NClM5MAwD09L1YcowzxlrJXsOI/6Aak7w7Bh+xUhHTciBm2O+1zdEK+XUdLH1M2XQ8ct
 g3te2hLCqU3d7tcFE5M8S++9ffF15vI41lAqfjPS1/0pQIH5NsFKU1cw/qyY/WzkNIsDC9F1i3M
 V4/6ENsO3URqeWoj2rpJaBmsRZy4BQ9WJPvLxQEWdjHeglOIiSsepXo3bSGN/xGxNRDShMHFnqs
 UCGBoNdv9HQy6Pw3/AglYWVL7pcrOFscFPHE1IQ3EM5wjcciYoJ16xnppAY8pAHeGVhxo2uH6Sp
 BilxaVjniJFnE+LtyOVBiBhUy7sLbCn12qhhgMxKWfak6OUADhxUrqdjpA5t9VCZ2ezNazUjO1T
 RlYGfP4rk+zHaucJ6Yw==
X-Authority-Analysis: v=2.4 cv=a8oAM0SF c=1 sm=1 tr=0 ts=6a09f9eb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=iwIdmoSuwSNZiPAV1xIA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: qMgpzeXXWXprSKDFE21NmNA4PfynG9U5
X-Proofpoint-GUID: qMgpzeXXWXprSKDFE21NmNA4PfynG9U5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170186

On Fri, May 15, 2026 at 04:51:16PM +0530, Vishnu Reddy wrote:
> From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> 
> On glymur platform, firmware loading needs a separate IOMMU mapping with
> its own stream ID. This stream ID is defined in the device tree with the
> associated firmware function ID in the iommu-map property. To create this
> mapping, a separate child device is needed so the firmware memory can be
> isolated in its own IOMMU context.
> 
> Introduced a new bus called iris-vpu-bus. This creates a dynamic device,
> and its dma_configure() callback calls of_dma_configure_id() with the
> function ID provided by the client to map the corresponding stream ID.
> This sets up a dedicated IOMMU context for the child device.
> 
> Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  MAINTAINERS                                     |  1 +
>  drivers/media/platform/qcom/iris/Kconfig        |  4 ++
>  drivers/media/platform/qcom/iris/Makefile       |  1 +
>  drivers/media/platform/qcom/iris/iris_vpu_bus.c | 61 +++++++++++++++++++++++++
>  include/linux/iris_vpu_bus.h                    | 25 ++++++++++
>  5 files changed, 92 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
