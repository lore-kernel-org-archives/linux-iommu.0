Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7832246348
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215844; cv=none; b=p+9bFXjMbleGPYfsTNS4Byr1tfXuyamvOWRnPB5YQ316grH3ZR9dfj5KZtwJsX1RuxQw5/9nLhQW0bL+TnirnsU7KytaZc5bpd5Adhv6jb+bM91tGRTY7x/uUY5ipTqlYDlphUxmvssdJE/VJHDsAkL6zCA96jCov5Wch8Ag568=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215844; c=relaxed/simple;
	bh=U7r5lXTdsw9Eas2iK8J9LazmFVQXR2IcunJ0KlLWvAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evW+6h6S/mMjQF5ZYZzCi1EbBBqKpxrkck1f8SIQeEX8KhrvgbL441AoKwajDdfevG10zooKc7ckHpjsvMn/FE53wjaIsZcqiLgS7ekcV7k5+YNQMFMx5XmXMNfHSir06j+JAPK5x1n9qi8NSE8jNUIZxCxQCZIp3V4XLw4fs1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pazFXeSC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pazFXeSC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HO7k030548
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tnz5TqBen53zV+5c0hfw9xo0
	Ki5Ws5bufZFZJ5eyQqk=; b=pazFXeSCg6o5laK+b1VdfeBi/n+XWo/NDACcUXTe
	UThRpLJb+Di/Os6lyIJ2n2gB5DCHAf9Y9P4MKFydgDKh6p9L1lChuHqP7i6IKcZy
	ffNiiibIpJwhES1cDQkWs27bxgAwDm64aK/C87iSuqxqkx1hrN1glNoHKpIx+1pT
	12MUrxNMPV7xJf3dntnWub2mC1b65RUpB7Che2v89b96bVzQ0wTJd4L3yI0NkPbz
	1rt+1z5xtboyQ05MHbJ7hDBUds1Tfe5NjHwoS2//qqZ3+C9CySiLf3PNw7+9e5Yp
	jgJqQCm+uRBwMET1BkMmb7wAzbWV92jcVZotc1l0Gif/jA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdfrwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:04:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4dfc05dec2fso89494321cf.3
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 00:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759215841; x=1759820641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnz5TqBen53zV+5c0hfw9xo0Ki5Ws5bufZFZJ5eyQqk=;
        b=qn2cPZzdNeOX1KO0eSk5jvVs4AlksmZa3LU8EqJama80SldFuKq4VzOPhyer+LqToD
         lTjAABqVoWxOKaLdD4w9WnFGjd6NSFPKL6mxmgj1jxEd8f8X6oz+QQmnRaQex/as16SI
         G7M4sB9tlOUh4qINArnJ9Fqr+KaxXa6fbhpBHM5ypfdE7E2ffyD+qqutOL/v7MaKwNx1
         I9as33jEIoJElM/18TLuDSO4qDa3M9Zi+v6fBhwc+hxrPCko/OzstOp6l+zETMsLe0OZ
         TeKhnfW8EzedsuccXob6a+LhIbWB+Ncm4WlE3Y8H4p/xLMOUejarMJcclpdSvpeP9QK3
         m5Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWCHeO1ZMONdZuwDQM0adHj8e2rM0vpYOAocxFVni32mM5fuak/ezxki1JMTnytDLZiuUmgfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfvM/iebf52gnWWCfLoSdsdYeulhpxpBQTu3mCA4wbKVOLGbaH
	c2bWb+/RNKTNW8b7CqebviiDwr1QgHbnQRwsJG93nerVrfiXV5dILBfBNA7CdyeRPnw20ORR3xP
	wpAb17n15rhzzOCGdonTDbOx4W4B0qwR+ZwCZUUREh5npWGYfpE+VFler1w==
X-Gm-Gg: ASbGncs3b5Sk5lDnluqb1p0mtX83nD2uWhm0/w/V6CBkOD8baQ9hPO41XXK/bQ8+yih
	2mpL3q37A7gCWlEU4iDRmUXA/BwG3ADyHtoLWZE5k06jAwSNM/o+c3AfjqvQNhJunkynMKmHV9Y
	2jKJBoTff5g8AOr8vDRt6GQyZ6HQ9gTGKcZ+t/yHGOteHVDyUZfu+ziGqu6jd4/U+BaV5kuqgu4
	4e9+WErFxDki33+nfuAQADii6AL35/w7B2pXrIGCCNLok9jlJFzpY8HaplfCdofOTWFPmIEbup5
	SdJaTskDOsmtkhClpdgagXJ/cUlJaXJBV3+bv50ErLBPsnZtobxK8ZXGgMckrjBi2MEzXffsvwY
	QKbOpK7S6mUTbOhLbG62EGPmcqP43hPOFHpYqMjLpRT2q12VA+mqPP7WwEg==
X-Received: by 2002:a05:622a:560c:b0:4db:b5f1:84a5 with SMTP id d75a77b69052e-4dbb5f18dbfmr197540191cf.57.1759215840552;
        Tue, 30 Sep 2025 00:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB+47pVViAKJXbEvOe8O+nb1gHysifWQJ8Ow1s0HmR2oz9c6rHltLPTDn+bK5bbHz5yEbEhg==
X-Received: by 2002:a05:622a:560c:b0:4db:b5f1:84a5 with SMTP id d75a77b69052e-4dbb5f18dbfmr197539681cf.57.1759215840076;
        Tue, 30 Sep 2025 00:04:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583139f990asm4623729e87.38.2025.09.30.00.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:03:59 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:03:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 02/17] drm/msm/a6xx: Fix the gemnoc workaround
Message-ID: <7gjolux5eowgpbptxdnuys2fgzkz3we6hznldrmfwrkpym2gwl@e4e2tpiinyb4>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-2-73530b0700ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-kaana-gpu-support-v1-2-73530b0700ed@oss.qualcomm.com>
X-Proofpoint-GUID: 6KXE15q444sUyRnVB2w47A8k8O8BOsaA
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68db80e2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=EdiAtJSrrEaB_zXPBFQA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 6KXE15q444sUyRnVB2w47A8k8O8BOsaA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfX87Af7ljShsUe
 WRo9PwmJHmKLios3Ljp3cQFaFXjLw2eZiaIhoFNdi+wh3Sq5JE8VpQgJJylxyezb+thJdbestK1
 wpQbbIfFIZZH/FB0twpDNN+Xt9aa6vibfC8fnODKM20FgTyt0U24yvTUtqdVMwfp/iP7f/G/t54
 Xphc3bh37RiL9f3Fv8A141hH8yBnhC+lco+bkIRukDWGYujd082WODOCfY9H++Ti77lRAJfiWEz
 BuNQa9vcPTKjRFdU7CUO5ZkxUM2wYUNYxm2bLrTHDcBSfjGCh/AEGK2WJU3IgOiMRodGX6dvcf5
 8RAVRNt3DMNHg7dcW1AzcUk45UkTTda1ou2J12KIwcAvxhsfuqFbngw0SNhlpG9li77sKgtm3oP
 TebUWYR1EQW6cyOYh49mZoqKj8oYYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036

On Tue, Sep 30, 2025 at 11:18:07AM +0530, Akhil P Oommen wrote:
> Correct the register offset and enable this workaround for all A7x
> and newer GPUs to match downstream. Also, downstream does this w/a after
> moving the fence to allow mode. So do the same.

Please adopt the 'why' style of commit messages. Describe the issue,
then describe what needs to be done.

> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index fc62fef2fed87f065cb8fa4e997abefe4ff11cd5..e22106cafc394ef85f060e4f70596e55c3ec39a4 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -485,8 +485,9 @@ static void a6xx_gemnoc_workaround(struct a6xx_gmu *gmu)
>  	 * in the power down sequence not being fully executed. That in turn can
>  	 * prevent CX_GDSC from collapsing. Assert Qactive to avoid this.
>  	 */
> -	if (adreno_is_a621(adreno_gpu) || adreno_is_7c3(adreno_gpu))
> -		gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, BIT(0));
> +	if (adreno_is_a7xx(adreno_gpu) || (adreno_is_a621(adreno_gpu) ||
> +				adreno_is_7c3(adreno_gpu)))
> +		gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FALNEXT_INTF, BIT(0));
>  }
>  
>  /* Let the GMU know that we are about to go into slumber */
> @@ -522,10 +523,9 @@ static int a6xx_gmu_notify_slumber(struct a6xx_gmu *gmu)
>  	}
>  
>  out:
> -	a6xx_gemnoc_workaround(gmu);
> -
>  	/* Put fence into allow mode */
>  	gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, 0);
> +	a6xx_gemnoc_workaround(gmu);
>  	return ret;
>  }
>  
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry
