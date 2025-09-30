Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8633E23E229
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218592; cv=none; b=k4KtqFDCCgD3W/qkQTgoglZbyuibtaASE3Sw4FZKCn+28Wov7OMawIrUCSBFCjsdUbu7VCcAUu1On6Q1OH8HfexLBfIF/cDYfOW27wzStJtGmyuB1VweRsHdy4P+RTUgtUUiOIicJjEzbchN7GFKv4Vyiy8N3/Jmr3P7E1qAyFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218592; c=relaxed/simple;
	bh=vPPstQsecnnkIWa6DxFaHD9gRnqYStgZOVelTzbVHqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcbQ89a89ZMtabS7olglT3WINogdAda//hrX9ipk6x/k5TvvZKt29hbZ7A4tlHFpVXviQCPzOclSA4avqQmFPZS72kOvHdoc/JBkzp2Ee4i5z+VcyQW/C2WWJu8jQ7vzXJV1VU/P6gV8pz4xDgJ2pvVvYMXzcEGc8yEfGQ6eO4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mbPXCIfs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mbPXCIfs"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HPmC009323
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tcDYvvx/kWESRIwdIUfePzUj
	wXfd5DkiWsQQ0UqQcPs=; b=mbPXCIfsnKiNtisq0erGetEyK+l37muV+7YinheB
	bYj644FZBNuf1NgkhSgSbqRlm+TYG5UJuTdvExajM+vrUhtwvopVf/wSpTJ/WkqC
	hu2tYYX0OahWkjx/XHHgJ165uF0Hdl0hZ0NmfphU42nznbmNIJHNgJcE+NtGueab
	od5nvAuCN+cVzlntj3IJiIy7FHLagNgVuDVgefB2uDbvVHjVWmKsT3TunRetSyK/
	SXZxXbuQKgsXBy8egQfp4FHYNPv0FfnA5OKfkxqjjmN2DiFC/r0Lp+ZgdSNra7UX
	qUjV2tDvYdey7K8eKSeHm1dSYSwas7M8x+dBmnqjSl5Xfg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e977qvdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:49:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e0e7caf22eso54677991cf.3
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 00:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218589; x=1759823389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcDYvvx/kWESRIwdIUfePzUjwXfd5DkiWsQQ0UqQcPs=;
        b=haGJSWD1bsY1GDPdp5SeIR1J91fe1cUtie5JFZcDRFptgZW8ukjfIate1KcIFoGzDC
         9O9RjC7RqBvjRUqqUcOTkR0c/b2RZKujKCI+nTZpzTm+wOcxuW2GHV182JISLJVY02ua
         6deShXrHaGjtAhhQlkGC+0KwULPZSzLWF3x+fTzme7lNpfOgKKcFvCnvXJoLbzJ8uzJu
         W6gfWegcHTZ2maDm8sEvR8cNzgM/wtVeR9BfvKFfmugxSVINkLoJgnqhVfLLMp5fm5jo
         6h22k9BVXZK4PsgZ8ur9D3nexv/BxApz33dcu/L85pJnTuJl63jA8pQTUo3bX++IH7xu
         yWRg==
X-Forwarded-Encrypted: i=1; AJvYcCVr9un2t5bI5LEMAZOV0mMPHFJ2ujEQ4BCEN81kB8bJN5I44r9bCDxTEwejqx/hwpIP+Pb1DA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4kuTBlr52y48tHirQ5U+LBwLP84BNrrCTDbW8qNk7fC6ggOl8
	aR73p8TKkxyUvzdwks/jGqQi/Qf/MnYL0uXSvINubmVY6UFGTZqLW8wYhZWe+vsfDF3vkLxj24K
	dMJbfqd6MW6Bj7sWcVLEiUkTVqaW/bvBrtA7+BxUR9lvYzV5IlWDZ8MjZAg==
X-Gm-Gg: ASbGncurHC1S1AuCz9gBNkK+yxh3M/VWDmO6+4Fsfhne4DHpc97TFExnmrQzP2ueB2E
	xYFt8zO0BIEOLn5G9uLaWS86nI1QqePpxmWFpJVS+utZgFtT7I1u/6ZvTSTNtCMKKhozGpujaMg
	k9BVhyZOsCpLUzgBabR27BP0emyUp74PibStGyxJcMgRIv+7m59zmEDO4th2iI7W/7FyIqc0hLk
	+17DYvv95HP3Vlciju1RoL5BsvncNL5yVM8CrMU6Df0T1exNXg/kmRi+xbCMX/Q+6tBC9/DhiSF
	YUvUSDGuPxp6/PqwIl1OOplpeIulnZuQqGtGeshQ5wlxSETZ0te7Uv9+tqeoHcL4zdvhFTlLqef
	FYx4Up6x+8US+P41+Xd5EbcbT3CvO+AleRm3jO+rj1WhidLFLyzz4fiTeTg==
X-Received: by 2002:a05:622a:17c3:b0:4e3:25d7:57d4 with SMTP id d75a77b69052e-4e325d772ffmr15078661cf.80.1759218589259;
        Tue, 30 Sep 2025 00:49:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1NOqQxAPdQp+Dh3rh+AoIDtXwXlBUdceAQk5B9YJWaQLrY/hOzC1FHHQS6Zz8p9Hkpk4YgQ==
X-Received: by 2002:a05:622a:17c3:b0:4e3:25d7:57d4 with SMTP id d75a77b69052e-4e325d772ffmr15078221cf.80.1759218588705;
        Tue, 30 Sep 2025 00:49:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58567242ef3sm2908507e87.19.2025.09.30.00.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:49:47 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:49:45 +0300
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
Subject: Re: [PATCH 15/17] drm/msm/adreno: Do CX GBIF config before GMU start
Message-ID: <ae2ooybajk6mcjggeztumubht6auw5qlhmsdrblikc5ruoxtmm@oj5kvpxithva>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-15-73530b0700ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-kaana-gpu-support-v1-15-73530b0700ed@oss.qualcomm.com>
X-Proofpoint-GUID: BgVfq7hGLCZKFnXg8fd6sg8FAU2xSZMW
X-Proofpoint-ORIG-GUID: BgVfq7hGLCZKFnXg8fd6sg8FAU2xSZMW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfX+6GKMPWsc0+u
 AT5PEP9urdPxFf+NbXJmOvrST5Fivkn0h8KpOoolRYpbIJc1cGXaR3ljbUDpQwLjOKrZ/9CuiJ6
 dZxb7VFyH+cki9a1lZa8Z1mV8yOw3+MUW1uc4ZiYlOLbtkv6ejNYtzv85Q16iZk+oJUVnookIT7
 dLYKT4W8WUys1hQBoeiBRgv+C+4iAHr7RVOPgVMru+pQMBqrdqmAJ9tRl6uxUZYgR7zF8BX6R/+
 WMJSWOk9V7K/5VCRUy0dylqEEILJS/6686CjXczjPOZw7yVx0DNLkx6aPo0MJT8DS/jSdUq5UeE
 j4o2oXScG+3z3Rh377uDF0C0FxpVQ9i6u6duIy2IJ1AJps2AHzh3jThBp1rnj4cPjqVaE4mBGT+
 Fjfsg1/K/e969XIvniCouLl6WycoXg==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68db8b9e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=219S4Ll1wpRkBpzXM0IA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043

On Tue, Sep 30, 2025 at 11:18:20AM +0530, Akhil P Oommen wrote:
> GMU lies on the CX domain and accesses CX GBIF. So do CX GBIF
> configurations before GMU wakes up. Also, move these registers to
> the catalog.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Fixes tag?

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 23 +++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c     | 12 ++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 17 ++++++++++-------
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c     | 10 +++-------
>  5 files changed, 49 insertions(+), 14 deletions(-)
> 

-- 
With best wishes
Dmitry
