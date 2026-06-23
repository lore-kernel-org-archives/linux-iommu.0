Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517962580F2
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204720; cv=none; b=DndUKjqv42rdJrrPBohswMTQK4MAWHcGxSTkr2XurOeS4Ue7FoKS4yGG+4VgeGA3R1Kezlw7oXO4wgqqNp90gy+tEn1HYF8k+13+Wd9Bu+NynzSzWzufdineL1XInLYYV9GXEsD3a5ewYsi86ur3O24kpCMiiEY3E5kq77tmPPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204720; c=relaxed/simple;
	bh=BFBG8+SC5Uj5ZB2Ay5lTKTJQltli+zwEim5VFBFstPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRPNrJ1tDUWOSC42JktFASDSO68Qzxw8W5zOYKbTcxQJcmSbMuc6vb/zOYGMshpyFeEuV8xwIz1SQ5X84u1x2Za/buyt30k27lobxWn3Bx2B3HgVjX1Gx9ipQmk7dwrk/e+TsKNj9zKAu3dglV/YxdWTSTCtYqT3Ewh8G410Cp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=asT6Mglx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L0uko283; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="asT6Mglx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L0uko283"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6cklc3564059
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 08:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zfMUMzU1RF+WDR1ZaUyRVDL9
	zp3SnqsjfGf7c+h7ADg=; b=asT6MglxIIq0cO6EQ0OLdb0VTdZMJllLKn72jxy5
	5p4wE5k3xs0FcNi3TtlH3UMCV+zEaEK0/0wN4TMbz7+96y1xiYQ0ceokAWMc2efx
	ovbH5y4LvnBoHYQmwud/X2vSRPHWmAv0xFmNJN4hmifnJ2j3OMZxnGAsNcjCcfpB
	NgI1EsIoXkSi+qFN3nikBxo+NYSQ12fkGVL5Wf3F1OLtLxYj5EtO2xOo7N8rCa7V
	sFuSPrGPCySm/ciYUCPX67GdLEwszssOJEgir8HM0awGaNub6hlkGW23ixJ3krGR
	/7JohAZgsj6semAAKGYjyJbQioZ+xeI12SyIqoXRqv+GVg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n43uhf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 08:51:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d8719bae6so4411836a91.3
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 01:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782204717; x=1782809517; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zfMUMzU1RF+WDR1ZaUyRVDL9zp3SnqsjfGf7c+h7ADg=;
        b=L0uko283N2LCClA4IgrVCJb+GR0o9vE2XGctZLkDSzdwloRHrQwkyqf3sZR2YbJUmm
         Xn/hHJ4J8mv/yqYlt9XVjge2kv0+I0sxtuN8eo3O2ry/w4g9cnvkpP5lUgFB/TZCRq6d
         TjRF8V6EmbTvnYnqYCyR8AffU50q4EGm6Mn8I0QVfW08W+5QpCl3QHCEbKeO5dKnmVPU
         NoGcK6S5yRC+qJhV4g8oUI+jdPdOasEojw28Vg982piJvV4/scH8AgfsQHT2M83isgho
         KNbIeAkSmHTLCUawzBL53lrmUlFYk7UiM2B4h6t+s5ZIRcdfiy61cXAt/DXiZC3Ljpfj
         yVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782204717; x=1782809517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfMUMzU1RF+WDR1ZaUyRVDL9zp3SnqsjfGf7c+h7ADg=;
        b=eMHBaWRJZdWUl1EQSzmxhjas8mcgEpZeGREeeng35DlwHaWEyNZKVBfVsMzrYp/gq3
         o84/1FQzIQ77q3Ak1JPEhSM1RYR4w+ToWl8VUFJWNUQH2/ML2SGqs+SWpcwvC3x77VrU
         nlx0JjYYWrMUWmDHyvqPulnzH3j773d6Vqi04sa04y/wmREh+oBVJgNXb/RRtRXu3ys/
         KG4sefnBE5eTF//kW0FVNQTw7v5PXnWCDBsdn9OzKR+U40Rv+1shIyLGMy3cKsx5V3gz
         JCAeeVepU19cl+PK+tRJmHhq7KSVRcWMqATUiGgtBy3j4aDdJ4Paxdx5mKWhSvZm7VXq
         ma6g==
X-Forwarded-Encrypted: i=1; AHgh+RrjeVttRzwhhYUW3CzRA4s79cltLV7oprEbjrYmj0KThA/Si930yFcT8ywYYEqJz8INON56FQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YydtA0t6yzE/nl7rzFvd18dBb6NDfVK4O7YQed1UKO+flCYGp9X
	LkL5Fqso8hOSLLVea1w5ZsdnGJB+YUeWrbqXBkg4pqlh26BpowhxF/aarW/w6/wcy6v3H28FcSr
	PhjxQI827rHKL6KLvXpRyt8Gpxv49rcUYC+LLeBJRZj+rqg23e7Bovz9Q/Q==
X-Gm-Gg: AfdE7clyA/noAvKYMaEqY8pxaUkc6sDoGDHQZdQjdf7pdD5uJX6v/R93TdaLmjTUS5s
	WPiSCuL1QCuKIDvL5EFnyFbjZfwpf1lt7oI59+4pNMzB/30weXPeeDBKr7tioS/N2guGcayX0Wd
	SgwcmgUlYN58HM/xvpx2knu7caO2ZjJyZYk3jwKl+aTlx5xg8iFTbTQfUpJlp/WsUpOtOa1zsyI
	eCVoVyLv3A4dXLU5haXrrsHRhabmCHMpnR95srIVyCFaQ2jzufnS9K9sIn6Fq8fEVsXaDgrb39X
	8BZrmwHHLkoVCcAEhgb3Im12mCUG5w0jjNNg55+aWmpgbjLJ9PC97kFVRbauZFJarrWDtMD7lgL
	Uh1AqkC/P7ScgBCXMlTw+LbA+B6BXmW/W0/OPvw==
X-Received: by 2002:a17:90b:3d43:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-37dd16b5af1mr1870946a91.2.1782204717222;
        Tue, 23 Jun 2026 01:51:57 -0700 (PDT)
X-Received: by 2002:a17:90b:3d43:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-37dd16b5af1mr1870920a91.2.1782204716687;
        Tue, 23 Jun 2026 01:51:56 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d15f92d5bsm3246843a91.0.2026.06.23.01.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 01:51:56 -0700 (PDT)
Date: Tue, 23 Jun 2026 14:21:50 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: robin.clark@oss.qualcomm.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, jroedel@suse.de, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/qcom: Remove sysfs device on probe failure path
Message-ID: <20260623085150.nr45mbu4225lpaom@hu-mojha-hyd.qualcomm.com>
References: <20260623071245.1985938-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623071245.1985938-1-haoxiang_li2024@163.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MCBTYWx0ZWRfX8mEcrae9ssgj
 oVeHB5eDz4DjhUEDGSW/1F0UP2aqiRswJT6VlJggBHTsdNNyp2mLRG/B4152Ci7vQZshziIRFO6
 WfmBYIJcMLv/UmNQa6SsBD3+sXQHORI=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a3a492e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=pQidVZ3N1npoo1zWM9kA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 4blbtkNsiZu11r0CfujQAdiO3lUlaOHZ
X-Proofpoint-GUID: 4blbtkNsiZu11r0CfujQAdiO3lUlaOHZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MCBTYWx0ZWRfX1dpEgfoO7xEv
 FgGKX3S0sG4TNHSDit0bdGYhWXWMsJ5gpH+1dYFrLDTXIOpK/5jTHQQ6KNIPfyCNjSM2JiQOnWu
 epN4+VkjhumhleykG6waNXboaPzuwHH3UpbyAkWJmrN+XkRjZCCgQcPwAoDI6Oukv3pvLqEs8zs
 n+xVDHHYLJHDc8W86mPJjvSdJslnS+bres+QOwbZ/vwYWxB4MMgk3TSGYvZ2+omnZsR3xQawpmi
 XvBr8v3dYsTBI1eSiSzuSHiQEjYElGiMnC/bC/bqzzE4zM4cBT4xCwigWIsfvLMrhKXDn0sFkC+
 nlNJ9AkWCxtquV9MsRLZ3pQ5nmevZjdR0QAhIZANyHOgHlFUDedjb+SDfkL/LcIYZpYfDrMLClP
 DN5AMMFe9Y1DKHGbo/WQ5kNzouITTHQlcXPcdWV2zJ1QNFFOdbxAM9yiNanM/v/cmz1OEUq7E5i
 21lY7Y4echa1ElL26Dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230070

On Tue, Jun 23, 2026 at 03:12:45PM +0800, Haoxiang Li wrote:
> In qcom_iommu_device_probe(), if iommu_device_register()

You can take space till col 65..

> fails, the sysfs device created by iommu_device_sysfs_add()
> is not released. Add a goto label to do the cleanup.
> 
> Fixes: 0ae349a0f33f ("iommu/qcom: Add qcom_iommu")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Not related to this change,  but there are some more issue in this
driver..

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index a1e8cf29f594..32efef69e72d 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -855,7 +855,7 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
>  	ret = iommu_device_register(&qcom_iommu->iommu, &qcom_iommu_ops, dev);
>  	if (ret) {
>  		dev_err(dev, "Failed to register iommu\n");
> -		goto err_pm_disable;
> +		goto err_sysfs_remove;
>  	}
>  
>  	if (qcom_iommu->local_base) {
> @@ -866,6 +866,8 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +err_sysfs_remove:
> +	iommu_device_sysfs_remove(&qcom_iommu->iommu);
>  err_pm_disable:
>  	pm_runtime_disable(dev);
>  	return ret;
> -- 
> 2.25.1
> 

-- 
-Mukesh Ojha
