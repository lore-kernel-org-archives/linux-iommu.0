Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664F24DD6D1
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694860; cv=none; b=a48p0YgQHO3sqqDNWRuXAN0rcFWloWYYWted9RR9Ye9PL8rwU/+edTeOHSHKM3tHy7cENedHSB1qE++uo8s8bdlFp0teufPbsInuE21oZ2vjJ4LK/ooVUFvILtm228U8yGv8al0dcHmETA1VBFINFY6UBFbmNWGxVyDgiUabucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694860; c=relaxed/simple;
	bh=Ud6HHue5cUw0cb/NqF5AekrfW5/jUOz36GsfhRRCz/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYx9qI135n+XFrI5w+7wyUSCBWkt6FbdpCjZ9hjOIbqhqIAxp8kBO50JQyHEdSmGUvOSghFwbr5LgMsv/WCla/d11XWWiN6xlYVoQyJ35vZeXr2JSXxIBKsJDaEuQwrmTPad9bag2iCTCtYCqXq92OJdfUH54+aTt5LeA6uFzOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oax177p8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RfADxVv/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oax177p8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RfADxVv/"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGucH33996018
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=C04fNeLquaS7uemBA4+Am0E2
	khDbaAX+WsMNaX9Ovo8=; b=Oax177p8aI3km8LgiNOtkYjekiQ0Imsft1DerYtc
	jvtmBnrShmz7Nqzh6axl3hpXAgZxpyJBdlscrW7C8S8C22bKZYoE9ubyd/8mRFeQ
	lMVdLBKtUiLcrGcDJDEf18j0zGPgpTG0B+X/vMEv8epb/uJlcOCdX+oQtDr9xReP
	Z1IbFZODpZ6Lfk3aeaEROGwTglWx/gB4DEmgMteBfhQKrXDPuyyUb0TJxLVE3mhj
	eWjlze8sNV97zvqIGCwB5sZLKB2EjuzmKPZnpmxIgezOXo7I7c2Qmeh5N9B2ImHk
	0t6CuNQGNWf4w9c5ER0+puVu7hwxiVs3diiBTy9IE+PvBg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4w8ur7dh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:54:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50fb6d713ddso39665181cf.1
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 10:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778694857; x=1779299657; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C04fNeLquaS7uemBA4+Am0E2khDbaAX+WsMNaX9Ovo8=;
        b=RfADxVv/fX0JDT6D2AAG/zPJxPWanHq0wUziKUeJS0iDnZj0UWbVms9C1EIZXkVAI3
         ibR+DIG1cKJ7JFZILTg5SwXP/5jTOXzPeG3RusO+cOMHfvrDZg9jKKp3QQDCY6SEouDX
         OcVMt0KR0ML0z8S7tvexv6qMhwI1UNPKiWrR51V7QfIYo+F8BpwIC9ITeMu713ETTr4c
         AlEyJA2ZUUtnA3e8yqzo1jhb0w/hxGKXq2KK12zYKC4Jtm0iOUbGRTg5E3HbycLN8xAG
         Cb/M050rtPKniPJ4MQFyGpJbT36x+Ww3dyPS/9WkH9PKWVANVTneVkUKCdfOS5ltOJUq
         7HUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694857; x=1779299657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C04fNeLquaS7uemBA4+Am0E2khDbaAX+WsMNaX9Ovo8=;
        b=l7I6RsX7eX65yLvTopfN1LeCQ543PJej9YJgfPZXE5GLoaaUFtuqY55aHG4ylkfjNy
         lDpNfNDjVApPNAkDwu6rgxQEvZyKyLOHlhPZP/0hmu+r/+a8lWC2e5wsjiYU/ZWdO1zm
         PsP2HXfCjvH8ccFkcD3F6RWJZhP++exH6YBjl/610aPkWvONjPwrUft0OCRWwhvgfG76
         a0Yx9KMqT7UeefWERG0g2Vvx6MzBith7PsuIU5Ypw0VhFdGWg6/e9Rs7lGooOz1jWh4I
         pRsHZqAwpp8Bgv+YUje5OI2DWopW6uHtE/jn8oTEjhMttf3h0DSoccJEm5AFehOFJJFK
         8SVw==
X-Forwarded-Encrypted: i=1; AFNElJ+g/nS/Wmgs3xcUaoSHoc/yi99yU6AZRQTYTk/Q0amLioa8OJM23ERJscsaKjzrdyHKP2Iqsw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8+HdhTNNs5RgT0IFZ3+7S9Q1lV4x5CpHQyzDHBB/XDtYvBfcV
	8Eh4wJ8/5DOg/S6ggNmmr+lisWVXTopPofK6jbcsoFAluI8MqNgQ4r10bYIyDI5g2FFEgwiEjKv
	HYMTIePWu8+idU8PgkBrBUkvbJDy5XgIqlGpcTZvflf/4HDVC8zWD6ebR0A==
X-Gm-Gg: Acq92OF9tw/bNP/yeyiGh3Iau6CPv4ykFrAqcIcHwifYYF6HKL2I1BDgwMpwfXKEsfa
	svTWjz3sa19ow3NI346BPipQe8aP1GL1ihMj9GcH0bcP7im5UadB3vqkcFdjAVhxDiffc4Ap8nm
	X0yODjun/WkDS5HR7OtdRSXad/7VT97EK5FBTLAYqH4/J/QR7KXY/4QRJMIKcDdLcXe2tzGbImV
	oNMwdwuuknW64bykxbl6FCIX8eVzw3ynN86yUmwXJ0h8KIfOisaOk6NfKF0SmhuzTIwQWA4F4QY
	cateVAOTQEvj2aGQH4LT5lF3OPuF4Ij/arRrcYZad/inIIlbPft+tZ7ifGAcj7lbYxT2XAsrs4r
	biGCpxBLURO1uIdJBrf4ymyi4Zz/PaEl9zp6EfxiYqIqg/T+Q6jimCob/pca7Y5G8PWOnKZmjMY
	2CBEz9hT4nfUj30y+tUczfmuRhAJEXS4+OZZU=
X-Received: by 2002:a05:622a:1a97:b0:510:138e:b83c with SMTP id d75a77b69052e-5162f58ae21mr59841171cf.33.1778694857610;
        Wed, 13 May 2026 10:54:17 -0700 (PDT)
X-Received: by 2002:a05:622a:1a97:b0:510:138e:b83c with SMTP id d75a77b69052e-5162f58ae21mr59839211cf.33.1778694855776;
        Wed, 13 May 2026 10:54:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3945c8de83bsm187021fa.15.2026.05.13.10.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:54:14 -0700 (PDT)
Date: Wed, 13 May 2026 20:54:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 8/8] arm64: dts: qcom: kaanapali-qrd: Enable GPU
Message-ID: <t5kgyoudahhrii4x3i5eufl5rqdzrcaid2n4yfx5kixm2xrzqo@3sfbgdenehnu>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-8-13e1c07c2050@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-kaana-gpu-dt-v1-8-13e1c07c2050@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=WP1PmHsR c=1 sm=1 tr=0 ts=6a04baca cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=zfO1FHEroGhDxMXjEocA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Q6kToURX1zHQIbE8dnR_Ps_CiprpR9AM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3OSBTYWx0ZWRfXwAKoCItlYUu9
 g/B4HTkLdgrgKDVwHuUJw+gr0oU1cj2AVNNtSre/BU8GuAtXJf83UB+Y5jfT0T/OGj5tT9k6gBG
 /IxdOn/zn7J+a+PUhq/H0499OprpHfKIWoSxeX1M8SbHpldzCn5+b4yukf1Bj6JZv/NQC6mo4gz
 lU6u+DZ11kH82wgKiNcl0YWQ1Y2LaCkrAk8OsJ4wNoUskbPe82HF3JPlUGpTigyT3u3uLX4kli9
 9nPJGyK0EoMrMLwrlVH/6/BYX7PrTgLdRPuKruli2hQUfUpr+Bs5GHhX3BXVSajeaAYOWSb3ioO
 k98J0TFCoIWlowaHyVor67FYDP5gC8iqywmx4CHDJPI0P3l/Ctuc5pW203c2ltopdXZJi1a29sq
 /MRbULE942MPOvlZRUD0lgedMhWsiJse5V6a0SYquhJLl5uHylNhPBu+cxF6EMo4MzXoLDvxygo
 WqW4xixE44SVol+WIdA==
X-Proofpoint-ORIG-GUID: Q6kToURX1zHQIbE8dnR_Ps_CiprpR9AM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130179

On Tue, May 12, 2026 at 03:53:22AM +0530, Akhil P Oommen wrote:
> Add the secure firmware name property and enable GPU support on
> Kaanapali QRD device.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali-qrd.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
