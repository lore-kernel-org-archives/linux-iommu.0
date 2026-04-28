Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFDF2E88BD
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372001; cv=none; b=u4kPNcAVhHBMz/zG8I15egquHiFTdtNHUZrqOulffxkVtZaBVv2FrzixbH0pJVfLxjXM/UEOSQyFJ5cQme4UpfStSW+sOAn2pTzSbHsWXbB0vBz4CL3hFlfiU61YUsEFJo9Cp3ic/UNoiZWXzxuKRiQv3Gm/pqVN3KRkovM72t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372001; c=relaxed/simple;
	bh=27VOQfbN1vMIhcKK+0PlFGn9GDTl1QArKYdMvHgjUqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iB3G0ZxNgZQhEP05nVDp6V6Ma7JPmcOdCl6CyWszK3q2Feel1s9pWZrTXXUOMu2IKpiQaw96ohxjAMkpKbgtvpzDbMmRX3Sfs/XGvrBolvFgXaLjuBuNzC1UxXjQuaSp9FY8D0Eldy7s8ww3cbH+iAXfKwhnge9g5gfRxmZOKmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YMMegQ66; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gwj5fDWP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YMMegQ66";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gwj5fDWP"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S7urHH3968052
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 10:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8AKTk28XPgJmHgqTSTU5AnTp
	0W1XYNRTdTpAHvwrNYg=; b=YMMegQ668LEBrBOIEPSpxiHMdZHKjnAZZ01kAiDK
	gxa2BK0fXSjtCdulMe4phiAww/17ADVuCjN9ZR5zUdwsg19tcMCL2Lalj3fWPhWG
	QB5nnQm640JyEYHlouiXUncixpvPgufeoDa52cWw1mRKjcnV1qaCHN6C2OFm/vyW
	glS1dTWoHRFSlktcG0s2GQYFQtbkQyX2ppSqtGoYRZxzGR5OfLud0k4YFaBxiE6T
	0XvWktlI4l6EbRRJuzQC6kVAeeyOnB3bMzhcgwjKgZL3Uft188IrFbIaNGzqtp54
	BsSpt6FnDiIEtgK38rPaFoPTFXh2mr5eauicSAlGB/HOOQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtry0gk6f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 10:26:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50df4c130dbso194422441cf.1
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777371998; x=1777976798; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8AKTk28XPgJmHgqTSTU5AnTp0W1XYNRTdTpAHvwrNYg=;
        b=Gwj5fDWPnOz57MBEN+X5Grfw/qKCMYd1NlQkEglbOcF9mpg4Wr2pX2IMqXRNVbOsws
         IzytLYpggpbzcN8wbjQFXUADqTjM49+Jy4+iw6WTVqmGwT0o22vtwdMdpBzPkym73a6X
         aLICHN5EuKO9VnVQalDX1qJPHtZR49aApqxlbUGhbFW7F8A895QPU+Kz/oMwhctKZjg3
         0ce1Ns3zSutNwgRXEBXjRvsW4LQ6e+o9NyDBH2gJscvOsTQ+QN7V+nr0LdLHdUw+G9xS
         c6FrfJqD3RTm3zbHqW/r0uGHTQnRBNOU5pYTaR0H++v8/2Y/06WEankk+GFz3rqkMUu4
         0dzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777371998; x=1777976798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AKTk28XPgJmHgqTSTU5AnTp0W1XYNRTdTpAHvwrNYg=;
        b=qaVFCK/aPd+1H4FI7Ymx7oQO8S45TmwMv1zJc1EQ9+iER3l8qVehlamxre4z+II9yR
         pYQK2ZWo5MiIZXjg8WQ6jAdQ6rlhgWd2YVahHJkG5WRB9gRC/S3aG5i6crs8I/kxN2yC
         EaXoWnZLKikW5vzrwCszw4QGBP3ZitRvZatWhWw4tTiJm9pnSZAzIvogOJ3903twdcCB
         ryTV63R+ana9XfHGhXiCtaw9aQRgZa3SJRob4H/scWg+BFKl2Bgq+3K73QyQXO8keSSL
         feq96rHyV1arEdSrsLto1HzAYR8AWPXwEWGlwK1WLp9AcAxKcC5ELKiP3nK0XzIPyYaP
         PgWA==
X-Forwarded-Encrypted: i=1; AFNElJ8gHfOFfg+picpPlmzLhigZcCGfSWiy+oYs3DOoJMB7+II5qoITcJe6ooNZLoZPw2bOemoX5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMfIPMefpJAqANWrbsqxuKXlzMRIVZs4Xk9yMdxKRt/bzbJGNU
	sc6GbI0x50k5zjYRDeFdq0MRS2iohW/a/T+p1lld/iwHmfdqZ1b5Q7U5ZEwQtix8bfI1PYFfOFa
	OaVwVI/MWvFDI263fhH5KllIBMs2+WFnmG11rcc9H6prrVm+WHARTEGUP9Q==
X-Gm-Gg: AeBDiesKs+ug+YhUmJgY73Wn6l/tg8/kj0m63gxW7Mk87NTOOpl3uEhvpy+h9MWk79k
	BkmuBT1KMgape44eNr4UtpnisnbMmw2eZ1odSXjS5BKs7QI4txVgEk8eeLso1An9vdALLDvF+0F
	B8okgXbIznBivQhMxsM8djs2u3ZEkx22W0REAYyG9F4XmPo/Ww9BONA3gcW1M4bBX8Ckd18nb7c
	ODnx3LLMSJA4lidO3sUVn2byo6u80Dwpft4njL/IWDbvYtt6KG0zcoFAr/LflXaIcSHJ68aXKXA
	SCVqP8RJ89QUJEhgRpgujQ99X0ypFgnof/AgMRxolYP95FG3c43V2mlJKfjoRT5/kbDtSvA+/Cs
	P0oVVc0VOouKJl6kmIX8shEFe7PDGzslFJmfiEwpxzqYZTDHJyQzdN4lOESsePE3zti5xjGNSJG
	Joz7fr7GD5yzT9JpaorwI6zb4Kt6aKfCJ0u3+wpBBpUziksA==
X-Received: by 2002:a05:622a:d06:b0:50b:8b8c:f68b with SMTP id d75a77b69052e-5100da87a60mr25743821cf.39.1777371998217;
        Tue, 28 Apr 2026 03:26:38 -0700 (PDT)
X-Received: by 2002:a05:622a:d06:b0:50b:8b8c:f68b with SMTP id d75a77b69052e-5100da87a60mr25743581cf.39.1777371997776;
        Tue, 28 Apr 2026 03:26:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a7463f5e38sm510022e87.52.2026.04.28.03.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 03:26:36 -0700 (PDT)
Date: Tue, 28 Apr 2026 13:26:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Lokanadha M R <lokanadha.r@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Add glymur MDSS to ACTLR client
 table
Message-ID: <rlm5shkccrpbijkuhrkp6evmfwxfsvlifhpmw4utnjryqtgm7s@tv6wyksenaji>
References: <20260428-add_glymur_mdss_compatible-v1-1-8416df5a26f4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-add_glymur_mdss_compatible-v1-1-8416df5a26f4@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KuJ9H2WN c=1 sm=1 tr=0 ts=69f08b5e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=WvJH3o8hvjs2AAOsRaEA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: yzE6FwgW9a7R9KOXQQl8IyrQSBV1akPf
X-Proofpoint-ORIG-GUID: yzE6FwgW9a7R9KOXQQl8IyrQSBV1akPf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA5MyBTYWx0ZWRfX/fWk9ca3AKgQ
 /cu+Y4/Y1tjM5amWTtlOsG2yMiOvI7wMURe9zXOz134IPDNZdX/210gfHZb3eoEhEvX0oMdYOTd
 xC8Ogiy4OtJrtw9LMN4rnPetBLGgVdyWhKhDzVQdz1Sh+xnb7FD8U5p417V9jk0gpzM+VaL8Gt8
 2Hy8u9Aohbl88/XCfNRWQgWdE/gPIp9LIHEPJwxpPu6HoQKx0kos4DSHSbtemUC3kWM85SKool5
 FRhZqwSALU0ZbN+NErcz9SUX9puIFyhdKrKyt+qzxsIWDsedf/V4/iGtdPV409bqrGWGGGdsbd4
 BvjZtET4bGIrpSubaE9u90JGzFClOmdu/mzJa2hw3wXlBQzjo/SYDXvd7Ne16jEcirrWbQnA/IC
 6aWmJg4xSifZUuxMVSdUfmc/GCu7sHxww0U1H6klqQbh49H5t0QrVh/ixca4Ctl9isIIYbxgeAB
 gdHqX+LDcMuqmNeYUDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280093

On Tue, Apr 28, 2026 at 03:13:50PM +0530, Lokanadha M R wrote:
> Add qcom,glymur-mdss to the qcom_smmu_actlr_client_of_match[]
> table to configure the SMMU-500 context bank for the display
> subsystem (MDSS) on the Glymur platform.
> 
> The settings disable the next-page prefetcher while keeping
> macro TLB caching enabled. Without this entry,
> qcom_smmu_set_actlr_dev() finds no match for the glymur MDSS
> device and leaves the context bank ACTLR at its reset value.
> 
> Signed-off-by: Lokanadha M R <lokanadha.r@oss.qualcomm.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
