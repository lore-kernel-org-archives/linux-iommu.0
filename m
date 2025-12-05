Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C92581
	for <iommu@lists.linux.dev>; Fri,  5 Dec 2025 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764968084; cv=none; b=Q55SkHCQWt9Go7DIT6PT8KRR+NEKTfTjZpH8/frUPcDqpzBK9j71RUQPybW9RR7+l/TA5wE12oJbi63YE3E7VGp2D9dufPaURr5I1vjw5OPE3GuPuPRZRKbRi0yQDJWd9XG5Ead70KvVTMLOpGtfguzUUXcVPp0+BWADYJ8XtYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764968084; c=relaxed/simple;
	bh=vWrcmrGHN2InD/GxtwtNYZOhDP2iNAhu3gWZK6OFzmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbM/0QH1qi3qboQRRnwtnzrvE97apO1gpWJ/XhotnTND0f2tVwJNgpog4LlUQNaSJUkNX3Tx9Ndrt0ScrlC0ejw1wFkB9G+9vk/rz1kFSFXorfiljeah6hjNz2Ryb4KUG797NMyzKqgc9NzdLExfKaTQEqTM/NWPx3LioJzhwuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HyrcEeh2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dP5CSZjG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HyrcEeh2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dP5CSZjG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5FBL81673058
	for <iommu@lists.linux.dev>; Fri, 5 Dec 2025 20:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GtFPosF2LgiE2WjxvqOOGkRy
	YJUYOXnYWCtT9Q8AA0k=; b=HyrcEeh2fn/ST9g1pNlY/hYo11L1eO++CR0/+5ZB
	otctzrL8Zxp+lAZMsT60n9fuKoqO5Sl+T5w5wVKda7svL+TgaJyDwx+/bKYK0IW6
	EeuxZI0yohjTQ/c9s9L6s8owJaAd+FUW/ZuNt0rxD8/QxFvV8d7TBJRt5tuq2ob/
	x2g20EKV7EtWw7+QP2G8vNQqIR7StMjbPK2zXq6RQWVMNigI9NSW8HmaK2mGq+Uz
	5L/cMOF5ShxctyxukcbA+mJzN2gx5RWCUw3n7kNWtxiAB3XU8wwwYsuoJJmofCdg
	sdp+trN2r0VV6RRhsurq39Potdu/fDQJK5XM9TYjy/ziTw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4auwm4hnqx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 05 Dec 2025 20:54:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b24383b680so808382385a.0
        for <iommu@lists.linux.dev>; Fri, 05 Dec 2025 12:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764968082; x=1765572882; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GtFPosF2LgiE2WjxvqOOGkRyYJUYOXnYWCtT9Q8AA0k=;
        b=dP5CSZjGjRd+JJ5+6MZi7USnJNnCo5wSUmVOP0jsuVe63x8w5551rsK5qWepu3qcYG
         mX2WVB/QfLJ7NzCk92LwTdwSrjoc9p+VrnGOc+2f2JcStNL8im1FX199LXfxnFrUp2Y8
         woLI8TQWp/PbNIq6Vr1Uf95rrWzTGsd7kq9NZRsFtughhjvKYZeDqIQYI3zr1GjiUF75
         GMxZjG6OSHGHSqpEYZFtNFdBKCWVgcanNeG7AudbOOz29FYzR8j+g9VvgEa+/bUg+nNJ
         FdKCfAhSRnvbRpW/de4GxyZ5EWoD3+mTbL+iyh7ZBx/YhVyHUUvX8HYWnLFG+ZPmi80M
         4L/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764968082; x=1765572882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtFPosF2LgiE2WjxvqOOGkRyYJUYOXnYWCtT9Q8AA0k=;
        b=xQGsNwXuUyPKSmjiqR+4vElLFlS87BrFGjkIhFDhCc1l9U97Tq0zkD4qufVXQJlavy
         Ql0T3xXLnWCBvmvaM12c1FHxQU95ddL52CSQv11KP+V/0lu3toQJvnPilNt4jQN415uG
         FmIbxWvFGQchosuUGkS1XcZ5ZatwTGGDi8/QfbCNsLwmS83/AoPVFXTw1Gw/c+IZDzGJ
         uProAtwuDaT3OTz/nX1HHLbr6dw+CgbhIVigdZNCkTMsnU9/zuPcUOAGhsx8uPAwp9CK
         bsGcqrtcHZsWuHQu0hzyH4xTjqtw4b2+1O9jESn2xoX904M4DH26xFqsAXUK1D07ZV4+
         TMIw==
X-Forwarded-Encrypted: i=1; AJvYcCULqsXbpcyphFBLpM5UWu5Ab9jE+i+4Rnq9EFDewViHBwUMP/6eafJ/DP62qTRS+Ie7bPCm7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoYBLLBpISmQqG6MKxurI+SDRnLO62OJtdQH6E1D8TWPmxer7I
	PnT3OXxe1EZV3ndKCNJ1Lz1tUVAIRhdjeZoZYOAmVnKpOZ6q3VNZYb3IyuD5yzxHFstVkw5+hL0
	DJDb3Y14m5tXOLiOqHXgFTUVrW5ldGuhRUJm/JXTt9eK1aiXIzOQnmCQdhw==
X-Gm-Gg: ASbGncu6+rV4jW7YYXHSNPnfFHNbgTKpwU/sxydp1/kff689FAwH3IkfOrTIBVIYIPV
	isS/+VFT5Ejg1bJ3NKyJqnrlAW1Bp89sK5ekpsqiABj1F9tFyW9aoSvLiSmBgDjipVNBMsXwfn6
	VxyG/f5yq1/VGIojmhmXf/wGhpqcRf9fBlfAvOzeJzWC+iMV1ctmemxPkoViYvObY00WBAcfxj2
	vMSFadOafmIAzp4Rcyn9NswE9ID5V4tlBGWsxVHIFqGV0vPxiQpD8iuM2vFcjeV2Aiy68C9tn19
	+XULzRCWElZD1ZHXgdw4AQRPyR/IR4OfgEx3FTgpq8s/9/BF28ZYVTD5UauwO2RVf3RtX8k7jXc
	tmIVcWRCo57NwxOtlMQZE8DgDjpzQ/iI2cnig9J069vndhI1foOZiIJJdnap2PXOLwd1SoqEgQQ
	IQ4qAgDForpI5OuWM2tSdez1M=
X-Received: by 2002:a05:620a:294d:b0:8b1:426d:2b87 with SMTP id af79cd13be357-8b6a2503493mr64542985a.21.1764968082067;
        Fri, 05 Dec 2025 12:54:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAybpfmIdKabPoU0b3dhUbqBBQq3XsZxjf+SdNpObrlWklaDL5pyA+vTb0we9EyoSRApMq/w==
X-Received: by 2002:a05:620a:294d:b0:8b1:426d:2b87 with SMTP id af79cd13be357-8b6a2503493mr64540185a.21.1764968081599;
        Fri, 05 Dec 2025 12:54:41 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7c1e2c2sm1826782e87.63.2025.12.05.12.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 12:54:40 -0800 (PST)
Date: Fri, 5 Dec 2025 22:54:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, robin.clark@oss.qualcomm.com,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] iommu/arm-smmu: add actlr settings for mdss on
 Qualcomm platforms
Message-ID: <ombtqnvej7vxot7fzhtbgt7doqky4b4wwtockyvorpfi2hl4zz@wslecjpuhmmj>
References: <20251202125447.2102658-1-charan.kalla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202125447.2102658-1-charan.kalla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=T92BjvKQ c=1 sm=1 tr=0 ts=69334693 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=8Kug02PE9PhwNHeq3GEA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: nHFQDu0cKKoJAjtUFQK_-EGBGwomt_d1
X-Proofpoint-ORIG-GUID: nHFQDu0cKKoJAjtUFQK_-EGBGwomt_d1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDE1NiBTYWx0ZWRfX2sa8DrH7KI7v
 /c1FR9P1IPClJO9dMFLz8Tn1HizWrB0U+fxpZXVZjVOCl2df4EXtG2eHyIZ0KXt59mkazp7NGd3
 aQmXY31oNvjKSevZLUO5v6pkQd7uVE+XWew+xZWIruv5tOlrRYX5KUKJ3uiVJGzYnkM8NzcqLC4
 I0ChLrSjHYG9D70ouh69FTyKJ4PZF8T5X+guwB3qZNCTI15jLs1/gxrgTRh11Egy0fXLFHC8Zaj
 3Cy/142nkcEI4oBxisoz4FJQaIJlPhIMeNp1+FajGimn+kJGXr9fmY+PR0sPYt/K4dtaQhPe489
 DYwsW8fPXFtfFYJKLPYtn6wfFhXpYg0p5Bb9gqmXDzYp7wVmS5yFZqDvzQ6uOwhzVugFOovcoSW
 Nk/cyqMT5cOt1/8kkPBJ4Ph/DUgG/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_07,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050156

On Tue, Dec 02, 2025 at 06:24:47PM +0530, Charan Teja Kalla wrote:
> Add ACTLR settings for missing MDSS devices on Qualcomm platforms.
> 
> These are QoS settings and are specific to per SoC thus different
> settings, eg: some have shallow prefetch while others have no
> prefetch.
> 
> Aswell, this prefetch feature is not implemented for all the
> platforms, capturing to those are implemented to the best of my
> knowledge.
> 
> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> ---
> Changes from V3:
>  1) Add actlr setting for missing sc8180x & sm6115.

Thanks!


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> 

-- 
With best wishes
Dmitry
