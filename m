Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447E29D29C
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489049; cv=none; b=L1EXnvluqyIXpNdQtK7Jr1XlUHwPU4BeW2bRQzUxW3buB1Ez0P+RlYf/qh4p2o7rkrsNlIQuVjDl7HaKTmR5TZZTejgSn1GYCR+udcP9N7v69+UU5LjeBcvZipBMaajwIiEfgIPxhwkbs5jwiBl3FsiLTyqv16raP6gOOnQFQUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489049; c=relaxed/simple;
	bh=S/reGcZiyMR29etlw+1fv5JzzcK4XVwPMIMb3fwLIeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoevZKF3+SGVUsvPLgF2aOSycL1xOIFuOMOYZ95hMpXXgwMnhBCOoIxyBY1SbG/E2GnOPjrmvXiE8oFHws0vos2NWnsk7fIQuB5YZn4w+fM71j/JQ8F/LOz/XK0EDnMAVFLfyvyrrFuYzrPv6tgCezieStc/xmf+8bCxtd9wMR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PQGtY1Wb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U10kpyoe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PQGtY1Wb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U10kpyoe"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AIHA5TA2664784
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 18:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DOgMsJh7yHgEVaismwLoID83
	bitySPIblPH+7pbri8A=; b=PQGtY1Wb+P0FVaPxyXoIobV9WdsgAYmPyiyCL949
	wKchojF5wjuTRnUHDFYRD/X7k7nMykgF9KCpRIUHnIPuIbl3TWPnBdp1Ca3imSpE
	W5wswq7ZoppUT1xmLB2KxhnPbIMFwn0gr/9PwjEroGIll8CtZmkaVUigyYiPmVbx
	kPt5tsAUP9hoGGtu/hlpmEUTMZGHlBLpYNWEnSXpG9oFS5NAUI2mML6MjT4Obusc
	wUqEW5q+l90190OUOR88j0Yb0/3XkzbJOuW5ejwVfioyoHoRRL+ADkJhuPRLah0o
	suBK6FqErepWiKCStCi56D4iF0LnV3gRtFZM0QggLjJLPw==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agpjk9dve-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 18:04:04 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-63de18a36f1so8194373d50.2
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 10:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763489044; x=1764093844; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DOgMsJh7yHgEVaismwLoID83bitySPIblPH+7pbri8A=;
        b=U10kpyoeirM7FGQvY1vvWZUzu3gvd7aMt3caVJNRiuXP0QJGN666nvuWy3cBT8ZFk3
         WhO6BuVBDx4bOV/EHUAQpGOwrZzn0Gfe61OWusz5ZQcUWJjJ21parU0BoA1SZq7QCOEU
         x3vG0RVx5+hj1LbjGJ5CRG4TOEGMszJ6MFVeQYVJC6ti9sVyK/7EUsqmQw17A+/Iq5Ob
         AS3/NTw6q5v3LkpO3av8gNA1j4SQQPWjOvpWLARAphzn7OiQUwobRGqPvAqJd8KeuzpO
         +/REIHwR1Fi074uManqc/EmguK6a4U+zQpX9XqyK6KCscIkeJhuNj8GkTDP18CMaqL5v
         EeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489044; x=1764093844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOgMsJh7yHgEVaismwLoID83bitySPIblPH+7pbri8A=;
        b=Qutmf7R5xPGAgDD7dM6zMQm86I+iIlNXepVB0dXsf4mzA0TYuYo9kRfm77Bky5J6do
         oC3ge7WfkEFLLN05yt+v55yXBcynMniEDQG6pitPt00EeCfabOZhzUs1dQ6INYMNZSGS
         cMo475g9eHpUIYSZiR/v4BEUIwEqOtQ0RYDuLOrNX7DHBvL5iD4jMTJVgzKOCda/G42G
         t92kbyNHY/7JAGJ0+y2KYQv0CuP51Mb/9cffy7PovKTVzVWamTAkYIT0HBBjVLJHgFk0
         OEPwaU+SN8vBcH33lio2+85oWzlWvlYUkAXr9YSgUEMUTYAReOdtvrlJjl4/oZSU5CBa
         L7vA==
X-Forwarded-Encrypted: i=1; AJvYcCUh6Jqq6AjO64rwkPlhLHmVq50wq/xmdS85vDV6nwpyG4+92GwSoxPQKfv6ONCbtPkLea7pOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvUhivfuRIEECkUyiJgAzqRFv/APxlc1oThSedqrR5JBG4UC5s
	dq8eBTGqlktuXtIkDWP3N8b5maUH9trTsJwgrbBpMwoCFeFXYVDAMZCWFE7+85A/QcuIDOnaBUs
	G6eUeLQ0euh+MVKdVDs8XIjrA1onirBo3XImNrtTq2+p/zbpRX0dwGCCfAw==
X-Gm-Gg: ASbGncsRXSmKaXmS3eItNh5gs7I7x4rrmH4aRfkZ8ppg2wNznWrKkQ10DE2jlhk1vzB
	TkdANqCeBpqhEdI9NdiusJrT1vYZMYPFUGDmlKzidPoFPsy70KHGCG4TVj5ObYDRmPB+7T3GSCq
	RGGftWlnX1K6+tu2QUutRi7sbGmA3bg8cVl7YlDZbkKkJl76el9uSjfov1XhsCfs01Zs+vGR81y
	cZwhR9aEDnGCLqQvx8QqGh0O4b2dJBRI6Ue5ncd6z2BMOrn9/8mr20QPgL7wBYah8cwiDi53R2j
	pDsBQZPrit2rAiowas83xfNskUt2jhlWS+yNDwOo/HAgbed2n6i0a2bCAwyR4IOFFlP5thD9Nbg
	6b01KXmMOvvfYjPCIa+TcfTrEXM/2F0haL0gpBYyXiiyHd2If1SHF7BYKdtuDtHfH1XQYaiCUQO
	zwCenlg3fvQIHnzGHPGxO4iv0=
X-Received: by 2002:a05:690e:d8a:b0:629:acb6:d8a with SMTP id 956f58d0204a3-641e7562fd0mr13908334d50.26.1763489044223;
        Tue, 18 Nov 2025 10:04:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJDCFxdIFQSE4sT2yUN8Na+Q7D5n9DbKi4ZwR4v2kZ0CHmdW00x3h9MQOY0N0AD3dsBBTO5Q==
X-Received: by 2002:a05:690e:d8a:b0:629:acb6:d8a with SMTP id 956f58d0204a3-641e7562fd0mr13908289d50.26.1763489043667;
        Tue, 18 Nov 2025 10:04:03 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5959d9c52e0sm62169e87.11.2025.11.18.10.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:04:01 -0800 (PST)
Date: Tue, 18 Nov 2025 20:03:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, robin.clark@oss.qualcomm.com,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] iommu/arm-smmu: add actlr settings for mdss on
 sa8775p platform
Message-ID: <himyof7napywkc44vre5ncqsatkkaxqnqbhjht6hjt53lakper@4wlwsvxkkamc>
References: <20251118171822.3539062-1-charan.kalla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118171822.3539062-1-charan.kalla@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: P4HsoPMQB0IBSiw4hMZdVRDzL1KxB5xc
X-Proofpoint-GUID: P4HsoPMQB0IBSiw4hMZdVRDzL1KxB5xc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDE0NSBTYWx0ZWRfX9P2Ad8jm7sA3
 /Tq7v4aGbuFQplvZt1PZgxnRXskoTCpgMUba4fGso9/zDiHuaU5Z8BgRAUxKEvvVKd9r/5JZfas
 0dIowEk2hp7DDaIyMgXSh0SqUZYwmqhoqEd7h+nR4yeyacQ62peHCU4eZRmTPjW/oaRrEl8wOan
 N+4YF6yb4tYS4+DJiN+3zxh+bGhfrFqMz4h1qZF3qucctIDTbHPzd4VfvGRkCt9VsyECq0UDmfw
 eG1KaRSgwuseEFau3pBKk3Gbaa7bJQ36X5U6uA57Xm+AoglHGztormO/s5MFrcLuIE1yef148j8
 GQMEcAdXucdGIiVbAnXeOaSpvHA/t6LYSc+iEbA2MVYuSy5aN/SpYIZoZxA+RtkJvBZvNanmAmH
 1mm6QGnF2h6ie1uXAo2EF2jKehyDTA==
X-Authority-Analysis: v=2.4 cv=N/Yk1m9B c=1 sm=1 tr=0 ts=691cb514 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=mjdW_OwqRCTym2VxSEUA:9 a=CjuIK1q_8ugA:10
 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180145

On Tue, Nov 18, 2025 at 10:48:22PM +0530, Charan Teja Kalla wrote:
> Add ACTLR settings for the mdss device on Qualcomm SA8775P platform.
> This is achieved by adding compatibility string for mdss in the actlr
> client of match table.
> 
> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> ---
> 
> Changed from V1:
>   1) Added actlr setting only for MDSS and dropped for fastrpc. -- konrad
>   2) ACTLR table is updated per alphanumeric order -- konrad 
>   https://lore.kernel.org/all/20251105075307.1658329-1-charan.kalla@oss.qualcomm.com/
> 
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 62874b18f645..0b400e22cb00 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -41,6 +41,8 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
>  			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>  	{ .compatible = "qcom,fastrpc",
>  			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sa8775p-mdss",
> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },

What's the difference from SC7280? Why don't we need to set CPRE?

>  	{ .compatible = "qcom,sc7280-mdss",
>  			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>  	{ .compatible = "qcom,sc7280-venus",
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
