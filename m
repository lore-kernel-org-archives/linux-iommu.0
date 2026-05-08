Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3994E33D511
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267804; cv=none; b=ONdGiCdyMxiO0mE+pocqGbxeZ8sWPxMF0OCs8RkVtHcEvydBfPa77sSDbEIlZtepf9dXzWhmcaWT/cDho6GF4PMQT9T3wnxlwOPtrzXL/phVsqDSfcP7rYx0OByD6KTPYP+VidOvCY4Gb/tW1TPZXKyo0pWrVv9+1vNipJZ/wb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267804; c=relaxed/simple;
	bh=GqrSSFG+g75ZfR09SPDvsyRCtlFsE5haXopDyurtwfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGrOpwCN2lkrT+nle8ztRc7SGtQp9G/Q9cp3QhXMKI6xZc9G92yOIPu7lP3WGVIKEP68rTs81YW7KpmCdifdRcAycPUoR6fgPLheqlvVRogLYLdc/lgaV6NSMVyHvG0oxkCieMgkivTwoGX5naaTZMPzlbIrD9jaa1nLhSbu21s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FiWGhKT3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c714pV27; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FiWGhKT3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c714pV27"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648CdWao1173957
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 19:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0S/MaBMiXgPLIl8xMXZreOhp
	tTdxir8IQpeWuhySA38=; b=FiWGhKT316va8LDXkb4dzlF+N1sHDUFf2/kUE5pu
	ORAY3pIpzA9b/swU83iCS8Tn47OwEGnuz4J3PiM5VEJgn/PsqR537zjWMiWtAN3Q
	PAW+IvJ6H9IRAmMPxm0hzPddoHC6wHteJDnKesYGOIc2/nxs2Uw9lMchBNr28HDJ
	7NCxHDgIndXeTW5KYX1++n/jOtxdAilkH2qK747cq/Fms5FmRM+ZtFm4CMJsJF3n
	D028s57sh5cDECU3NoWOHP01b4nSnHvE7eHD4EXcMIDob/7chcrZEax3/oUjKJg9
	FXPii95Z/XKIayq6AU0ozH8cFd8h5IjxcErddyqEPkeJMw==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e132hceh2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 19:16:42 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-42394108a90so4176934fac.0
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 12:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778267801; x=1778872601; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0S/MaBMiXgPLIl8xMXZreOhptTdxir8IQpeWuhySA38=;
        b=c714pV27HHMzMoZtqGH1KUXw7ge3in/uU1nEiNRp716+EULUXt6XV0YfIRgjOdiWR+
         7YEEff8fh2xdtIyboQoz6Jr7oEVLL/ZeNt1xvZNthKcFzaaQyOO8CDjm884YFiWDG91e
         XF3tQ7smk0Dw630xxjgB+ZzYEsoSkn/59vagZ1M3AgkRRqrUaePe3jUztDewNEufBcLJ
         ZIXNglrCh+GNszv941o5oniasnRmzNC7uAv/Ft+Fg+sJhWPys/N7UCyCZFAGUPCGjW/r
         /Dpi5xhenQyyqhzNzAdvaoqHuuw6B9Xz8N1Be87wDg3qUn8FQEZoK7s29GNtuFpnOxj1
         FZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778267801; x=1778872601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0S/MaBMiXgPLIl8xMXZreOhptTdxir8IQpeWuhySA38=;
        b=HZQ5/Klg84NHeMYRXgR8ro0q9DOyYZvFN2dGMvybtxPORwTe0ZMaK1F8jT2nY6xy1i
         Qc2KQFPxKOgaTEt/Remv5DT9XUzmVv52lT2pCGRMW7zZxn3tiP4PrKu5MIvgXLrL8gGc
         ugqKBRg5uCHwtpYVg7kkTgpd5BMqm5xQCVQIajr3rduiIGLQ/UOUfMLwG7be1VDtRV/K
         eGBBk3f76Oy7A9amwW5Ylk0lZ2Os5zKl52aXQofZLPkjs1aDuyk2giYBQ91fUnsP2FMf
         7hwC2N3FwT2tvpw2aH0HfSjhSE+ZZ+KwFsS5vtTLV6b0g7iGYSJ9IX4JPVxfSUOH8Xgh
         s7Jg==
X-Forwarded-Encrypted: i=1; AFNElJ9ZCqX1Ptd3iiicyRAwme3VnwvwD6b9LPUVtkhFjkujQNIDtJYktvUpUO73ouGqCIvFN5VIBA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5Ue35CyeCQrNsjvtcoMvIZt9NuRXejU3a5DjwEIdidMEp+TuP
	+mpScDASYOROfYF6kIiZ1x7TCKAlNjL+lFjavRbPVny/wlb71G7y8TjxanTBSpWY4Ogx+ugOHsP
	kmeNp0iSUmOeQ/wXX3I4RACEjafEL3yMYhIuQlIxNZ7xbC/Y+bQsFvlL9/A==
X-Gm-Gg: AeBDiev1tjfLu4GuFYtMb92l+RdEhNu0SqcPCr848WLp6Wc5K6n4NCkLlsUdplCO4g5
	WAX/gqGV5orHqXEL8UZHMc7cv4A9Tu6ytNH57oftbJMVtiJEf0VBFykiYE62wDeOd1gU5nT7tCQ
	wiRXWMGMqu9W/RTsYAMTjz21JncBUvH/NvxoQRKuY59k2rXEbd/Q2n3GCKY1X7gCh23VXKVdu/a
	AqesUuTWcgfD8omw9QS1CPx52SsRROOLaZwciCh9LZVM/8YSPrMIpkk5bz7sPNBm0/wosWzBCo+
	HbTMwVvOzVZL8L+3TxiWYTEZ77HGcgxFYj5jivgfwRPncNrPehoU6n4lzwXID/OKJj61P6EuRqT
	x947hQAqg5hkT8X9HoKFaJj0I5iDWrEtp8CMx1EJO32kGoqiXHJzCWtCYngB8CAMqeC+5xQqE6H
	FBJmZ529xOz81FnckPp75kdUfJXv5JDiYZWUQ=
X-Received: by 2002:a4a:e914:0:b0:696:1291:fb29 with SMTP id 006d021491bc7-69998cbe145mr7809094eaf.24.1778267801566;
        Fri, 08 May 2026 12:16:41 -0700 (PDT)
X-Received: by 2002:a4a:e914:0:b0:696:1291:fb29 with SMTP id 006d021491bc7-69998cbe145mr7809069eaf.24.1778267801163;
        Fri, 08 May 2026 12:16:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a951552dsm727066e87.6.2026.05.08.12.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:16:39 -0700 (PDT)
Date: Fri, 8 May 2026 22:16:38 +0300
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
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 02/14] iommu: Add iris-vpu-bus to iommu_buses
Message-ID: <ewu4nbig32tl67xwghulsnyotlxezkkbx4uystuky4xe74rpud@xblm7twcvhxf>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-2-7fbb340c5dbd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509-glymur-v5-2-7fbb340c5dbd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MiBTYWx0ZWRfX1uHbH0jB0mE4
 7haKbNBoCzBzYafap1W5fxJN+IgOZR9WKITjq2CHAbzsULCyx1ohUoTFVWIvH75fZkmY3Q5V4Ff
 EfHogPghjt+zG59RZfLTDrKXr9D3a6NAfYimA9orP4S40jVGvs1jmXDDFoyAFZkrxnxhqVJ5QVg
 tZwIFeM/Q6xULIecXXBBM6HjoiwxuOAjPbpMkEO3xQlIa+A3srFczTWEJdRj4alw+O4zOjfjsu3
 k8cCmUtcLxLySbSI2XYxqtV3bZo0Hyxk3GY+ay7SRmWmXACDG668YjzREunGkSDgWeoMkqSNT3H
 ufTdsDR0rKtNW+nHmMAmaLxaekVik0M4KQ20//oa+4q3u0yEpWgzIsTLV8lF4xUJDz1FB+0gAes
 KF/6GPS0Lt+fk+jaQBH3JwrKkAIX/pclRnke9On7HHWFMSkTJfDgCMD3YI29IUqn/qkCNWf/FbX
 F+2JXzgNyczFP22TJdQ==
X-Proofpoint-ORIG-GUID: eqPHmtFj9AdDoGTP4P55T2T_eMCH09NJ
X-Proofpoint-GUID: eqPHmtFj9AdDoGTP4P55T2T_eMCH09NJ
X-Authority-Analysis: v=2.4 cv=McxcfZ/f c=1 sm=1 tr=0 ts=69fe369a cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=0ofZ2ib08pOWvdXbZkUA:9 a=CjuIK1q_8ugA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080192

On Sat, May 09, 2026 at 12:29:51AM +0530, Vishnu Reddy wrote:
> From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> 
> Add iris-vpu-bus to iommu_buses[] to register the bus notifier callbacks
> for device add and removal events. This ensures that when a device is
> registered on iris-vpu-bus, the notifier triggers dma_configure(),
> which sets up the IOMMU context for that device.
> 
> Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/iommu/iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
