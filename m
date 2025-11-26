Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6856D1A5B84
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 01:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764121899; cv=none; b=mGNBmbEi7Lcx6/tv3x9ibiGb3WpL5IKuLxw8ePxz26IMFAFFPWjz1fX0ONMAGVBkUDCxAaeBoF0Rzlm1T0tG8i6VsdGOTJ4ZYbN80ha1cBOjum2g7aVLFCDEI0r8yVKq48q8BmsRKmNg8QPjv2XPk0/IgOyxjkMGdbsGYXilA3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764121899; c=relaxed/simple;
	bh=Ta7zSAMa/dl8EzhPD1HdouMqho+ZR4XotmIXTbraDcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Km8KV3LQz8z3YivC8CEZU063zYB81Dsp8vl+8HR5arKi4daFZtws4vUd6NuoWrTDFNnQlr/C15zYJFo0BoeYv2ZR4RTInsMAQJ2j9Rnx3ODrpdmCPx43e/X4TaY643Z403C+1+x0nisYz3UDot7wxS/iHM6SWp1Lbvqk1T50M/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OuZvMsBa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NjFjSr4F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OuZvMsBa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NjFjSr4F"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APE0XJZ3706625
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 01:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=L7i31meeSU9nTcwAbcrWqzAM
	NAAO5fXiHJNoyvPBSbA=; b=OuZvMsBaXcg8GaDj4MjoNPKg/4JJ5BnOEvHO+ufk
	iOO3zbjC2pQZv6HZYj1RCMgBWYWZM3viHu503S/M3afT+SSG3RK6U3xLXQTb8cbg
	Rq/A077E5YUZqWbg7NcLBXy3Y4pk4cmvjjlMhV66s1UdHcVvoOuJwFDdGOO/md6S
	J8GSr51/PPy/KXO3CdrRUiFheARE0cmXN3YJaWnXavc372gL3yDDwFy3QZD9d2bI
	lz7ZdWPJEALYbO5XVAmRMD+uke8T19HDaQRWBCbrWDBCndNKzKFbY3uECeENyI0g
	FaHwynFe0tFAHQ0Gtb6GmbNsFj1SLYYCFqcaJ2aBOknFsw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4andufsr8w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 01:51:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2194e266aso1400589485a.3
        for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 17:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764121895; x=1764726695; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7i31meeSU9nTcwAbcrWqzAMNAAO5fXiHJNoyvPBSbA=;
        b=NjFjSr4FB5P/djBv3GYfEkOIyjsKHx23LecDBIDL0rU8Awsq97AjTEuEx5okeRxAo4
         wWW0RdCYlBqexsWHZKS4vYq1I7DXcI9TAAR1AxN9yT+Y5BAHSIiF9lBPJuYmiB+l44mZ
         4VQiyFBm9LJ3GURL8ppcj9SlWQsI699avehh6WlWfdDQY5Jx94zg1Q5uROgqdCNmog36
         fAKczvx+A1f9Y3C2uhKNq3hw4X1GfKrvy2ULQX5IAE9lG73SqVjvMwjZ8oVEfXVPLcCb
         rS/me9XVQCt+r+O9mvqdDJA2EfnoLar9TsHcC/jQJaE5kYqje7yAX4xSOAPL7zPmX3Hr
         0m5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764121895; x=1764726695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7i31meeSU9nTcwAbcrWqzAMNAAO5fXiHJNoyvPBSbA=;
        b=EQWCxtgSLWuvGUZ+UqkKhkQgNszTeMBMEfsJF3MrtkSofNSZyU79eQwtl6WI/Hnh5U
         hNBamld/2WoJX2bIA2yEHnxo0nvymVtIATM7B+RnYHyVLsB8Wpw4YqpUWVFSm+RXIq2p
         8UedJdohLDR+oIjgw5mDXkI21iXFnJB+slcHXHcEMm9wLGIoNNINfz7g7UA7z+juwglQ
         u3k7MB3CZLBt6QCYFyVZtwy1O2LzrV18sUewwgqNmgcQyxI6nGUx0aMCz2L+nhBECe8l
         N2TK9KvuHNx+0flfHvCZMKa5vzm7t1uxPZxG5VCFPXEdES1tLafNMYybGIsX1iHIVwN+
         tTDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrO6vPBf2/fEWw293vNmPEnETaZdFCPqrtak1Qiot5cEYWozoGfsh+1H354xwXQCEUff0fkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvscYr8Gac0kNNDlVu40iuULkwpnUGk5BM7ie4m6B6OiKrAqaD
	L77BnSIcqDJeFWnO/qQJKSsd7w+5QSoWhAKLXduSDSwCGCF/oLhFhxjlxeqQvUcxv1qFAXsmwhZ
	d9QB3jxAXTamtsOYmPCr3fV/lB1/lL8gh7EnryHVE9TKTlqmV+3aQRQemew==
X-Gm-Gg: ASbGnctmoguPNX8M9k882SH+TDlqNxOHxfUlfvUWF83mNzmObQ6Oj/K0jUn0ZFAyXZi
	+TR3fmkuOS936YczNl6Z/VL/wGeV1IfylS7EoUg6uzRFDxAEnDlmFVrflsbW/5r6A+BC54Dj5i/
	6eOQMW62cDJ6EwRYRzTifMzZSSQRjWrljTnJMCqZ5cSni1rfffcMb/Ww8/9iYgko+sIz6X3Y/X6
	pSmX45/c1TLEnjSx0W9u3XoDKtlPN+ryXPA/x3Q7fKlN/yWgtNb3gv4vyf9DelIR6Le2EPUukzF
	mW+RbAbAcizWDwHe37B96z9VEuKxcNFkmId5NL+/CWGla92AcXnUfc/SKmG200Zjp0Bk/7Wzg9d
	0/pvoYIIZX/X2dqAZEidAr2eRh6U0cDeJkshNI+uot/aRMCg2qpHwy5vqlmnBemHecFA6C6MvWK
	OiE/NYoaqOEOcJhB78sWpNXOg=
X-Received: by 2002:a05:620a:4415:b0:8b2:ddeb:99c with SMTP id af79cd13be357-8b33d469d4fmr2401589385a.63.1764121895572;
        Tue, 25 Nov 2025 17:51:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBiysWZ2d8lUT2YSXb0WOudkrGcNWv5wfEnUYYkztgCXli6WXKinB964WNQbdbINNXXNoV0A==
X-Received: by 2002:a05:620a:4415:b0:8b2:ddeb:99c with SMTP id af79cd13be357-8b33d469d4fmr2401587185a.63.1764121895056;
        Tue, 25 Nov 2025 17:51:35 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969db747bcsm5609868e87.11.2025.11.25.17.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 17:51:34 -0800 (PST)
Date: Wed, 26 Nov 2025 03:51:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, robin.clark@oss.qualcomm.com,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] iommu/arm-smmu: add actlr settings for mdss on
 Qualcomm platforms
Message-ID: <6zyysrrq6mt447s6rg5sk5vy5w7ulzub4u5m24xw3xo7edguwu@73vtynhdp7nx>
References: <20251124171030.323989-1-charan.kalla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124171030.323989-1-charan.kalla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=C53kCAP+ c=1 sm=1 tr=0 ts=69265d28 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1k3nfMqBUa8zcchP1JgA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDAxMyBTYWx0ZWRfX/P/lp8SG2vRX
 sH8ZrzPQSkRrT7ccVuncYdfLaupV0BvG74PN1E/UvtQhX6GEXR4Fdn249uCyr2Q5QUgI6RBQiSM
 wUSQZuoo2GV5oUle2l3+2VdsH2qDbfT30ia0C6zyQgbWgPNF6UCeV4W0Bcc3ipbeLx9UVwWm3PS
 WG58D9TmvQPng6PBi5MKI3bnM4zzmSC/ukmHE9yo7bNqJ433DFIpNc7fFyc7DHLZheA8E8Oqp/9
 6lJQMH8MHO/+ePHpq80NoxwWENHkZ7/X5I4KxQHavVbw8Nlm24rGIEWKyv9FOFWXQfkd95HupJf
 7QPtfAA9Qzxh7Ru3offsttz0Ix1s1fiGHL/J+OzwpTTPmFMQEepfVVxy/+L4HZ+7cDFzLEG0YN6
 wgfyNdoADIdedIpmlxEAFFaZlxQ+ew==
X-Proofpoint-ORIG-GUID: g4LN5kMEVE9cT1Vg0W-5WnrAcc-bv573
X-Proofpoint-GUID: g4LN5kMEVE9cT1Vg0W-5WnrAcc-bv573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511260013

On Mon, Nov 24, 2025 at 10:40:30PM +0530, Charan Teja Kalla wrote:
> Add ACTLR settings for missing MDSS devices on Qualcomm platforms.
> 
> These are QoS settings and are specific to per SoC thus different
> settings, eg: some have shallow prefetch while others have no
> prefetch.
> 
> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> ---
> Changes from V2:
>  1) Add actlr settings for all the mdss devices on Qualcomm platforms.
>  2) Improved the commit message that explain why different ACTLR
>     settings
> https://lore.kernel.org/lkml/20251118171822.3539062-1-charan.kalla@oss.qualcomm.com/#t
> 
> Changes from V1:
>   1) Added actlr setting only for MDSS and dropped for fastrpc. --
> konrad
>   2) ACTLR table is updated per alphanumeric order -- konrad 
>   https://lore.kernel.org/all/20251105075307.1658329-1-charan.kalla@oss.qualcomm.com/
> 
> 
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index c21a401c71eb..ead1a59d40ae 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -41,12 +41,34 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
>  			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>  	{ .compatible = "qcom,fastrpc",
>  			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> +	{ .compatible = "qcom,qcm2290-mdss",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>  	{ .compatible = "qcom,sc7280-mdss",
>  			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>  	{ .compatible = "qcom,sc7280-venus",
>  			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sc8180x-mdss",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },

sc8280xp? sm6115?  sdm845? sdm660, msm8998?

> +	{ .compatible = "qcom,sm6125-mdss",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sm6350-mdss",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sm8150-mdss",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sm8250-mdss",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sm8350-mdss",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sm8450-mdss",
> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
>  	{ .compatible = "qcom,sm8550-mdss",
>  			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
> +	{ .compatible = "qcom,sm8650-mdss",
> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
> +	{ .compatible = "qcom,sm8750-mdss",
> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
> +	{ .compatible = "qcom,x1e80100-mdss",
> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
>  	{ }
>  };
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
