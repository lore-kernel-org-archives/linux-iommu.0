Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DE5259CA9
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215783; cv=none; b=Uloigu/pYhY/4BBc3fvcnWcKEVKo1cVPZmMNnMzoEEhrVJG8cdUggwoUl2Bq5+zf3JCFNa3DmPiJXyuBfLcZP25Om8XnPUVWbH98bU+YxHq9KjF7UnBDaMVsj+zf4kJlhOJgFVF2liDIF3bazQBV+QmcQ9l/BsOYBmz8dkH8NT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215783; c=relaxed/simple;
	bh=F1FiYxViKywIbSE573kHTnjfzX7LXToBGFkMvAHPD3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVOdZk7T3xw6A0+UJbb1EUgaseWapKZHruMeHfKwaq43Llaiy4BLVcsPVGEh276DkXlIP2hqAGpaRtzKO4UxSgQB9/CcYHcsnSAIfP80iqwXFwsiO8FL+ZaIz+B7+AcOxEel+bJONvadev7/mgA7vKmPNPifur7NcPe70b2V0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OOut8Vw5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OOut8Vw5"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4I7x9028066
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZILBarotSZWQdM56LLJz3+w/
	7JscPhGYyLjRbrYgdnY=; b=OOut8Vw5yYRY4OGq48yBkocOurdwvVdz2F1lCt6o
	k2gP3wjxwc5Aysiuye2xQK2pZM1ndn2A08UC2m1ielc6IQUggOShqqOGyiZXadlm
	vhpKm7dbSBDU+VPSb/YE0XhgUHTUEqZLq+3yacne2pSC//8fyBfWbXLFqhlG7/p+
	3BuJ7W3TU6nEUBTYIdkpFLp77cyYQwCxCvZnvHAQTNtd97eHYTD9YylFAH8sBFA8
	lje4KKku7gcJcPdVJwW/6MMd9qL14cPT+Q0IGW5rpts3lhEI4sz1qEwVj0bYYlKV
	RKee9WgC1CRvh3/JcmNlaoeiMIOrdP0vRyclmTH5YulaFg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fyrf1jee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:03:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e1015c48c8so37273281cf.1
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 00:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759215779; x=1759820579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZILBarotSZWQdM56LLJz3+w/7JscPhGYyLjRbrYgdnY=;
        b=rJavjt1cREMjG044OeSJRqotzuYfNeGDu+DRFOnhRzHxMwHRRKCj7h5tpTIerPSoLo
         tovnIclSzeiKCCEnBxbRpC13kOca6uR4VcIYlEhBgx84lEhWHO6BQlRtyDXVvbvxUkud
         0J0clgyeROBA4QRmIDmCn6b8cB1OwCrNexnsNjYi+fTj/St35Vec8O8tc6t9ZyoGOgz1
         jxcvmw2N7TOzDoY6ko/fmc7yH6h+MLxFjpgnZi9/9ChGbimRcyHW8TxUN638LwJypQy1
         KR/xYxWFaHsNoVf9ScsJ7pyNahH47hRxm3f5uOYd73qyBgVwQAiYI9fwmjqcznCkrRdo
         y28g==
X-Forwarded-Encrypted: i=1; AJvYcCVIfmcR8rMtQ9mdh90t6iCuNb6f0K6VwvFJg1Zjx6WCSw2nAr6UCWACVBMFnjS72cPn1kiJuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2GSML8Kfp4Ufzvt3ZZddl2NMLFeEMBk+kzoNXcMmoI39yIeDE
	6dbL+1594ymxoPiQDhZ8gRDUKSkk8SjZEq0ICCMlrnRffIAId/5Cv+rOg3aGqT8G3LbJ/FTmts/
	oFLSxpvli3e9KJMnmxFBA91Mg2tUFpYNz1sUMWdgsxFknZZH7SICp+v6Ytw==
X-Gm-Gg: ASbGnctSEUlXhnqEKYwf2L8YgxEkuxFqjdYpQF8huoRubuWd+43tWdVYDuDPwjCh/6y
	SSrSJIULSN6esfRy1hLgR7tMkQtwz+NJ/IhUs/fGczYo7zYNW4LzZNhPJ0uAeDkIUu3EhbCN8x6
	rDsRDBuH4s6d45sp84ROCft24EHIKSXd6jyZgXMt+YGCqFKHAtzcpbuMRP453S+5EMq27yY3Mrv
	bdlYe2hzhlvEa8Fpbc+K2BUx/2NA2wLh/07XORNsiSVU9/PUyFcg7HA3nVCQqb6PIbuNTnZ4ven
	69GoBjvfqneiDidThBoFcAg5kUJ1EDNs5//CVANfj9Vmmt7le2VCWssOF64Ths41Gw+SY+5BJmP
	u7xFcj0pM9hW8ApmwyBNp08PymdzkRdRXdKHPM1RzY0T0M2LHoSN2KUn8Ww==
X-Received: by 2002:a05:622a:255:b0:4ab:6e3d:49b4 with SMTP id d75a77b69052e-4e27d7c1b65mr43578971cf.7.1759215779605;
        Tue, 30 Sep 2025 00:02:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA6lGjRTL6r8mC989qOKGIofS9wz03iYOMq+60qPx/pT9WrIKYNjXkEHiEux+C3IniYKpKBg==
X-Received: by 2002:a05:622a:255:b0:4ab:6e3d:49b4 with SMTP id d75a77b69052e-4e27d7c1b65mr43577931cf.7.1759215778195;
        Tue, 30 Sep 2025 00:02:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5839329881dsm4325236e87.87.2025.09.30.00.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:02:57 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:02:55 +0300
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
Subject: Re: [PATCH 01/17] soc: qcom: ubwc: Add config for Kaanapali
Message-ID: <yhcqj3beliary34msn6zbaig7j4krn32st37g4n3ey7oipswea@ckio3yjuwswo>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-1-73530b0700ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-kaana-gpu-support-v1-1-73530b0700ed@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: M4enFEM2EV32fEZhK6JiKjEtXAV7ghyj
X-Proofpoint-GUID: M4enFEM2EV32fEZhK6JiKjEtXAV7ghyj
X-Authority-Analysis: v=2.4 cv=etzSD4pX c=1 sm=1 tr=0 ts=68db80a4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_QbXVIGTKPyQLETMuiAA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE3NSBTYWx0ZWRfXyguO0WOVozCO
 NqqYFMSNWs/BFz486Nmclz/WnFkp4qAtQ4q05RgMV3U9ysxl5gR5z8NQ86Uf7HLmcofHbGq/aVS
 Bilpru+DY3EDOlf1KC69+v1/RpqH467kesr5mkEfZiq9EwvuUa0KiZ7x1QrWN9Mn1zmrlPjjcnb
 kllcuLFzKIUYe70yUnnT1UerF26n+52zKwUGX89SPGvxUjh0nwd3TSC5KzHxTbO+Mbsjoj+7UAq
 4Po9c37By9EhCdiQREBreBJQiCVi+rHVYcqwBcUVLWaR4YqC1y1davrQEiThp7CrGvyOvz/EWx2
 zdyqCz/ZIySSvV2rE9Vvw5C5TjuCdtEbBePQB5EnIZGC4t3rU+/+5d0C+bTOf6KcPB039hynzrx
 YoQ4cUO1yVG4q7DS+nrN9o83XG3usw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290175

On Tue, Sep 30, 2025 at 11:18:06AM +0530, Akhil P Oommen wrote:
> Add the ubwc configuration for Kaanapali chipset. This chipset brings
> support for UBWC v6 version. The rest of the configurations remains
> as usual.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/ubwc_config.c | 11 +++++++++++
>  include/linux/soc/qcom/ubwc.h  |  1 +
>  2 files changed, 12 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
