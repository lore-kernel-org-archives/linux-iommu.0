Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08A335CB9F
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526552; cv=none; b=KZPDS8jzMRLcmvmXcMPA7GaxbBWIllD+zjYFHZPfBue0kRcbqRB7NmXyovjyERr8zk5nyqnHIQMOq67vSl3NvOiLvvWCe+tuBz7DnTzsCq07qMRJMLqdNIOX2cso6uQJekQsq+N6huEkhmasYFdf3IHtwG6VrAT+LnLrMmlwYYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526552; c=relaxed/simple;
	bh=oz92nNe/0jQO/YoUvvjkb1eXuR88e+7C5+ksv9MjMGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzBu39XM0jBnwxOR1zABPj/YpY8aeA74shlEEXl78CJia9Gw6rdgT02Wnv3+FSPlb7oMyVEgU3ND1FCNic4FQ9j3HLiT1tQmmYS/Avg+YLcXdHP1I9W23fLOr0Lj9RGu5RtZkNt06YOvFRfXPv1g8A2AN0j4wpuovyQMejhkAug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iKpDgcHI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bqOD8rBW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iKpDgcHI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bqOD8rBW"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RAOJqE3714671
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 15:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=27wgVHbQ9lzPrRPmK3tFXLzr
	eFllIGFd+b8eFXO3QbI=; b=iKpDgcHIzfAAIohNIXVpVuF7Xbu3dTHnjf5l5tQJ
	6oECx4fEBkbq5fZFTlzY7Myq3GFCp3bTBqZ4YBthzca5TDZ/5DcrKDS1HcVtgZXv
	98HzOpqRWJN6phict5+G6CG2Z+LPoRhLFZGu36AUspGJbr5BWoVw7qsgdhvRWqUa
	JRLkm5FkqTp8zGKj/Q4yw5Q3bwctk9yszcpka+XylflmQSy6vNeaGwckkElHbwph
	C9nj169bgsa+js7trEIoHWuDTD0xTU3td0d22x7KGTIu8Kp2RS278oCjcBcF3Imv
	KAtr0RaAKMEdlpDzZtuGBlZ5mqOcwO1WmdBPtElta7V4Zg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxdv0bed1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 15:09:09 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5f5409de680so6877880137.1
        for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 07:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769526549; x=1770131349; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27wgVHbQ9lzPrRPmK3tFXLzreFllIGFd+b8eFXO3QbI=;
        b=bqOD8rBWteIoUjTrkSRI9jsgPzCp+o0HYX2rfnSl3Z9dmql8aPSGMazXROqCLCF4Ds
         uLIlAull7USSo6b/1Xi+eTUaeMToFGyl0/XrVMR7dPVxPNxvwz6Uaxvb7ctPV2jd2qQc
         2LMKX7EYaupJKl9zRKQr5qZkuqHkffyLDZwJypSQry/WKy6CCvoCz7Nlkymo/VTGOLxO
         9CUevWnZed8Y8SIawFXK3QQEPR9n7JvhYj1cIHEqsLr2NUVbL+cHoIX4q456HSeY5AGi
         ZuYi0kZFlD7RT8+nijzT+Z2L3VvVTJH8KP459+I6cwCJhQ0Ar+lYgOW8Qt3ENsl6sunT
         BsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769526549; x=1770131349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27wgVHbQ9lzPrRPmK3tFXLzreFllIGFd+b8eFXO3QbI=;
        b=lL9xXbNvP6hsJfKHHWvZLjI0mDcfgzRzfyIs/A5MR2Aywb9w0GxCYH8BenF+9lQIfi
         h/34hOzkEhqHYYHYDVI8slIWmGJIAgRbxFIUme8IlHvgCUks4q2YwTG7L22acQGCuIHw
         TbA7mr570iLqw/ZsxD7JomcUpLlqGC0IgoYE5smrH5MwvdPnmfh9sdeKZqRrpVHDfb8L
         qGORC9e7l0O4qpX7BxPTEzUAlqH8tSiC9V3DOvgiauiofNNNlluiKRBm4Mi5VdpT2F/U
         yrzZ4H8v1hfsNR9NUpi0ldtw86+J2S4hof+DbTID78gDaYYVWShTh9MVvTiJiRG7JUef
         9VHg==
X-Forwarded-Encrypted: i=1; AJvYcCXmxRTTNONVozQfufqMmPHz4R6kjOCZUxAMi2or4y2UsV/tllGFuM85WZSw16fdROolOfp0xA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNZwKVwVd0McxYT17lnSR0+VkF5/D8pq+T1Wg/Vwuf/7KE5e0D
	NHLvo8EEFcfW5a2bRu3Sc9RP7oHirKdySyG2ng4pYBaE2C2YTGmYGAHedR4c9l2SaS/B2LG4tAb
	fRNycOLX8a9K5wd7Fpp/Kkgrcj48E/ClyZORQrU/0ywMgyGBzc2pQnPnnaQ==
X-Gm-Gg: AZuq6aLfzuSByeye4p4dfOFLqj33cfazI2MzmCcQ3p4mXCtCBX610B0z3OZadbdaNa0
	NdXUAnhVr+ioKeqooABT7vvxQMBhIyNmrmGVIQrrFf1vhVD4k7yTnEdNX8xCBH2Q2VmT8SM+f6Y
	IjjpfWdZbOObPAdCaLUNL11Axnq+e5PCJ8NU40F0Jnc+6MNWZg4ED8/+/0MCKcqFQqDB6FDqz19
	v4nl9qtlp8dkHnZqbz3CSBAVxRYAwEkxDMHXGOhFNhMRCGGYrf0mI9BCtBmMwaivYWjmLDwiKbY
	OweU4dUqRdYGv5z4aJZ5V5MTmqAnpZlt++52M1lgnklWg5Wfz+uLVLgwmi+vZnc4uRJMxnqNkHy
	YwWoefkN4U23tHkU9gh6rA+RaJc4lTF3uCfHBfJ4ejNbC7yNX5+M8HIoD/OdvsKG0ZgW0pcPnWP
	65KmXiiwa/diM0jCtwJ4eCbjI=
X-Received: by 2002:a05:6102:390a:b0:5ee:a2a8:2e73 with SMTP id ada2fe7eead31-5f72378e4b4mr772181137.26.1769526548901;
        Tue, 27 Jan 2026 07:09:08 -0800 (PST)
X-Received: by 2002:a05:6102:390a:b0:5ee:a2a8:2e73 with SMTP id ada2fe7eead31-5f72378e4b4mr772143137.26.1769526547175;
        Tue, 27 Jan 2026 07:09:07 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-385da1daf40sm33193441fa.46.2026.01.27.07.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:09:06 -0800 (PST)
Date: Tue, 27 Jan 2026 17:09:04 +0200
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
Subject: Re: [PATCH 1/7] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
Message-ID: <r642meaclfme7thmb6spkna6xiuhbjuqw6x32jndjqhwqjtbbr@qkcziz3cyxb6>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <20260126-kaanapali-iris-v1-1-e2646246bfc1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-kaanapali-iris-v1-1-e2646246bfc1@oss.qualcomm.com>
X-Proofpoint-GUID: OW1UQw2dIx8MdqpI5edoRcvJEm4g_xmu
X-Authority-Analysis: v=2.4 cv=SvedKfO0 c=1 sm=1 tr=0 ts=6978d515 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Gjm7CCj-TAD5GDm5kmYA:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: OW1UQw2dIx8MdqpI5edoRcvJEm4g_xmu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNCBTYWx0ZWRfX6yqxzxxkHBfs
 0jQpbpxpe9NMWg+8U0bXsqmqw4NlM8QNa9e97T7k1qt1jGFWoCBA86Pix492oV4WY1sCVqL2VSK
 xQNeEIKUgnSG17ehIzhCq79MEoytuMPRkMKuFbyynXihXYs4Q9faj+51/DMh6ehZ1GALWl6JRap
 SC4rfpOOa5DEepVhgt3vY/jB12WWVpnA7vdhleqNRGn5o8763vI1AF7LTJei/wUV3Y9hRem9nZN
 lEelGxHUECrPg3m27i6MEVertgqa1cUwPhRf79qpuBzrfIRp4S5wZts+L1A5RPD5hRAQSte/rSS
 HFhuSBAAmk4AvH38lNc3LVX5rOn5dDuvyrS/q3uMfZC0jQXsEI1L8YXTVAmTatoN15G6mLsrBue
 r2q8vwgU6Oacd5ksnvCnyXtVRfrFJGbIobmIspiu2clNDwnhZSZQJ9m7XRs7ut09U1qrI9wdROf
 CL+CJUzk5DUV6zBVtDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270124

On Mon, Jan 26, 2026 at 05:55:44PM +0530, Vikash Garodia wrote:
> Kaanapali SOC brings in the new generation of video IP i.e iris4. When
> compared to previous generation, iris3x, it has,
> - separate power domains for stream and pixel processing hardware blocks
>   (bse and vpp).
> - additional power domain for apv codec.
> - power domains for individual pipes (VPPx).
> - different clocks and reset lines.
> 
> iommu-map include all the different stream-ids which can be possibly
> generated by vpu4 hardware.

It's not how it can be defined.

> 
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  .../bindings/media/qcom,kaanapali-iris.yaml        | 234 +++++++++++++++++++++
>  1 file changed, 234 insertions(+)
> 
> +
> +  iommu-map: true

This is totally underspecifified.

> +
> +  memory-region:
> +    maxItems: 1
> +

> +
> +        iommu-map = <0x100 &apps_smmu 0x1940 0x0 0x1>,
> +                    <0x100 &apps_smmu 0x1a20 0x0 0x1>,
> +                    <0x100 &apps_smmu 0x1944 0x0 0x1>,
> +                    <0x101 &apps_smmu 0x1943 0x0 0x1>,
> +                    <0x200 &apps_smmu 0x1941 0x0 0x1>,
> +                    <0x200 &apps_smmu 0x1a21 0x0 0x1>,
> +                    <0x201 &apps_smmu 0x1945 0x0 0x1>,
> +                    <0x202 &apps_smmu 0x1946 0x0 0x1>,
> +                    <0x300 &apps_smmu 0x1a22 0x0 0x1>;

#define the functions in the ABI, provide them in the bindings.

> +

-- 
With best wishes
Dmitry
