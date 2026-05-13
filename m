Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8224DD6CD
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694854; cv=none; b=aLP6gh87Rwrqc6HoEGcmCF6ghaO1lxkiZ6P6LhBuPPrKvB9k+COEbCuOB8q14nMqRWDuJKig0xiVYa2SsKqlk8qk6cRtNDcFyKGjB3JuW8KMz6XpPESF+oXpzRHDNqylvTH5q9tcVJhzFIopnHIgHElXD1BA2u6wjqecCd+78FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694854; c=relaxed/simple;
	bh=5OCnIDxaKzXtIMFl7vgca1Wdf+x4Gq6w9DliutD+wa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjSYZ8n+cDqVKeerpZDwcrbRYphCrB3CBATl0HyY5g+/Dc8EAXaP4H+YCHjGz+3TQKyOyupck01WGh6egnUZbqha2INwvTaLMHf0CzSj1sFLSsGsboRuu38o5uC7oaQqn5r3GsokB4myRKdeiQ6c0FD8tjO6lTnDxoX4E5/m/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RnrEFmAG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pz9fnxcY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RnrEFmAG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pz9fnxcY"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DHo9I11393027
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rPuHL/f5LzXJ7O7qOo274Obs
	+ipAHrmu1VPjHVQ/kck=; b=RnrEFmAGoLK6MSSxH/hyxpSV94i49m/hTXnpMIbi
	D7cl9PdO2cHptax5x49zf/eDaswen8dPC1Z9MKvwXnNfg0Se79gL6OSFmSE/31HB
	SFGfiYRWoYg/1GpBol6ieYd0ontVTPIMbEeIsikKfwZQ8ZH+1zPScFZ+0gh87H8d
	xfjxPH2dZIc7qXrQ4WxqmmxtwF5W0ZfctuaohLAw5NA1oLPbyFiQj13uctdBVqwn
	aUSahxZQbQPR8ONqSWRf5yLcqLQ57B9RcaRdZRp4K4FeG9SfEy8KVbtMrueuuaAr
	FGQHPyeAyThzLhvmkv2qOZfFtvOz4Gn7p8RBqSV3MvvzEA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4k262xvx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:54:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50fb6d713ddso39663001cf.1
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 10:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778694851; x=1779299651; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rPuHL/f5LzXJ7O7qOo274Obs+ipAHrmu1VPjHVQ/kck=;
        b=Pz9fnxcYjvPuES/oArVoztlhE16Nac46WFV+NqBxpspfnxUY4Bq5cEPXvRskjF2Hko
         a78f7k7b7TqVhUVZQCqWNRXQXHbvXSsg2WsnYFrDFs8YN50EHvOorjcZ43OieX2rtGHZ
         IGZenypCIHi/X8qpriYKiaavGSIk7Ak3oFdT0EgZ9u+vjtbzlsacDSBEblo2J8/ApZjv
         sFs0zMtxQnPOKXPHk54lYkeBfcmNd2qF2ElKCvatgWnRsUeG1eIEUHHUZHjnd6DEdnsi
         fIs/XWZbJbxTCaDMWiJrADwY9nUqfOfy3B0187/U6cwIfzTbPBUPAhzeh1MwbGrEX/kC
         pjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694851; x=1779299651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPuHL/f5LzXJ7O7qOo274Obs+ipAHrmu1VPjHVQ/kck=;
        b=OGtafpTYjBoGOAefc9Go2duHRLUtZTzTLYzxapFUVaOOuop7WpGkQd1JwfWBq6DtZO
         WNFLwqoOVH+6IbTmLa42UPeJDY8KWtaeP8U87uk/9/Ksrso7q8p2cTIgp8N1k52yooJf
         5Gujy2TviGQGy7bhl/56b6N0Z2dUGZ+U4h+mQ2mzeGkuJyyipU7UBZbXubIlxBwMsv8X
         HTmq9dwxeJ/5e7XHIAkkoZLKoFlneMA9zoWpBbpeTUIRyuOoO7poDK2OB+9qDfbYKfwo
         X3dojRvgTg/q4Cp8iLg0lUEihLfqK2BOW4pIB0I7a2d7+l3qIIsl+UHU/MguV3v83rxe
         B6yQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ZFrglam11b1/RhoLCJuzT/hiw71wSwAIhce5CKEpktg98rPmFh22hKiRAH9bt2zvJqu6RLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdzEvPhykzS7JSH3ateJcpNgP12yBAvI8Pz63mL6ZUS8itjyZk
	qd4E8tV80YJHI2d2rTg5MywLzIcy5Ft5/5z3bSrXPW8DMHPHIsMoe6v+lwriOrhl9f9ohbt/1is
	bjn2V3tDJ9LOuw0B9NeQ3d240Bfs+4A7/M72jLN/ewQ+ZLUE85mMaSTXfdg==
X-Gm-Gg: Acq92OGo3pAgRvH0jSku2Nwsky0OvcQdQWTNFOPfAzYKKbj88uCEGpM6GOz0/MHJ6Ws
	dYBiBocNWeOl+Uh67bWHX/jGWNfn0f//jgmXFi1NybjGRz9WHjcLu9l8XUsSAytLD1RZ5SkK6ss
	v0usmpR4Y2FM9V78AqiX6fvxgVF7Gd4/+KON0DSzGJ9DFHFqCa0GO9XYpPyswzXDzA2TaydmHvL
	4Z/b0Go3PkcYvJjjgNyczqFztM0ttyqsVmNqAOGQUJUufMjiv2g00UPO6dIYo+p45Ea2gt789pG
	moGjB4FZD81TxYKNDimNMFRbi7kqETVc2J9RrhYO2cn4L3uuOzrNzEaFm8pazu6tyAkjtV/d1WQ
	g4dG1fhYBEj7cmPzuiITYkEL5EuWLpQVgwXgFgTk4Gx+f86B9l+YIwb4q1sus+Fqblbko/NYutl
	qWELhItyjg+MUknQy/wzo3qzTwXCb2FZ1o7nI=
X-Received: by 2002:a05:622a:98b:b0:50d:a3a3:e612 with SMTP id d75a77b69052e-5162f4a88fcmr58563801cf.18.1778694851472;
        Wed, 13 May 2026 10:54:11 -0700 (PDT)
X-Received: by 2002:a05:622a:98b:b0:50d:a3a3:e612 with SMTP id d75a77b69052e-5162f4a88fcmr58558691cf.18.1778694846256;
        Wed, 13 May 2026 10:54:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a956606fsm4199375e87.60.2026.05.13.10.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:54:05 -0700 (PDT)
Date: Wed, 13 May 2026 20:54:03 +0300
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
Subject: Re: [PATCH 7/8] arm64: dts: qcom: kaanapali-mtp: Enable GPU
Message-ID: <c3qa7bctzt4v7lblcnagdkxl7q2ku6iutwz3c7yplh7zvrrxb7@iyhn3wd43mrj>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-7-13e1c07c2050@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-kaana-gpu-dt-v1-7-13e1c07c2050@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=M/l97Sws c=1 sm=1 tr=0 ts=6a04bac4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=z9YPW0OalzF3dbzmYPEA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3OSBTYWx0ZWRfX5Xt1fhSSkjRZ
 5gYyWNRaVvEr26BksSSkyzS4kXGoeease/gH0JQKZ+gWb7FN7wiNQGBhZxny8Ab2lJXqfSy2rPF
 bYy4sdyUiMhioeXvwj9FTY4OB0LPZWyARQ68fydrzfgjY6WJbBIDexFCybqXIaNtt/zJFptMtUi
 xKArpvOdToeN5fRdysMIjSHkjNcFEiGXk6+fRi4wRyrPkXXWJV+s3GKmQb2POvAFZtQcq9AE4Bo
 sxAtNSd7MxmXmN639EicV9Q3c1AMyhYDedCIzbYF6NYgJjZyeOWCUuLSJOB2iRejQ1W7diJ+DqG
 B02fIMcLizWh4kUbaLfojEV7IT6qiiSI1dNhvGxyvZUFL2b3o7keTASWZHQj4TecZbmwxwHARce
 w8NtSOqz0amVTGIEZHCfWXKXnQHdjZGQQ2cwkXl6sDrmYhQagYDMArdoKmWRG2hvv8A5GDRn/JM
 K7WXnvZazpS6W7R3/Eg==
X-Proofpoint-ORIG-GUID: 6EhuXR0GZ-5Z8uUW_Jli65BYZGcrNE_i
X-Proofpoint-GUID: 6EhuXR0GZ-5Z8uUW_Jli65BYZGcrNE_i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130179

On Tue, May 12, 2026 at 03:53:21AM +0530, Akhil P Oommen wrote:
> Add the secure firmware name property and enable GPU support on
> Kaanapali MTP device.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
