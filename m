Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E6F1EABAF
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731085087; cv=none; b=kEtsMRGX0v8BwV/WzrvJN33ddpclSHzR+gO7zkA31Dci2vWTFHFfwcMFxhsz+Yd7b/v1xZ7lhdp+Jjfkf1DNOfRcfMYlgMHfhEF8iAQZ49NUZdUJuQ0UtvPc98HGRxwNRqXDXjWBhC9NRC00CKIF01ar7CjCbHCO8xCGCAUa0RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731085087; c=relaxed/simple;
	bh=rR6oxh4TsPeJEFTyjlpe/mmrrtWMwgdViIyTgLo9Ezs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShmqcsomBxI8kAYF6XT6NVTmJ7Td6ljvOAWrdwjRz3h5tGluZ+UqqLqEGEvPenTgIJ4OmkhiACF8uWiqyWIhw9qw6wZa8tR2ltHbgVKGoYh1Z3AVv1vXBqB7HxS+tSOkyxoDTlX3sAtkQE2bixBymGEGxys1AACiFyzpXU0kXcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bMKljHRs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bMKljHRs"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8FCtxh002160
	for <iommu@lists.linux.dev>; Fri, 8 Nov 2024 16:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HWI14o00dzdsEyLD1xZkH5uhQvD1CWU2kS6AnH4E94s=; b=bMKljHRsJuTHnWCe
	/bvKdX1jaZ07Q5YIJUalHojqML7Bb6NmjDMkjBUtGFrre2svtF+xCVlPYxRaA/Bc
	p+IMbbgQuU4fCJMUmb7Ae3L15fzuZdzqwjxdpegfJUYgQf+3VJUy0b0wk7Gpzww2
	3sAGb29W5aipYDq4yLHQPuK9Pk4uNye4hKfiVUZmzhKowrnNfzVEhIrOC5NHbXUG
	625z+7D2ygNWTnHlaugTQqjKz8IMnOvztAxf8R6wtlqquEwtSTLEorqZM3GvlrVZ
	9YVajFEv4emHvvakQ3KRoNPK8IEscmrssetDw20OoIOA7zQeJANwaYHb8VPnhlLU
	Jx9RHQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42s6gka5ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 Nov 2024 16:58:05 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-84fe094f03fso85635241.1
        for <iommu@lists.linux.dev>; Fri, 08 Nov 2024 08:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731085084; x=1731689884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWI14o00dzdsEyLD1xZkH5uhQvD1CWU2kS6AnH4E94s=;
        b=Wb+pJjzHud4RADJQw0Mk8Syao6sZcfYx+TeBD0jx7AgwSOTroDtRw0YO+1hOscqXVt
         5YgdW+pKmzxxWSKr7PnlqgnhJzvoseM5iqmYzs3VCi0ehDH3priEMDIR8jNvOORrMFen
         HsIGmHK+IFYwQTtVG4SCuBO7yuB+RISEb/B1sn0wUTVhnT8mkspGwf85eYU+tCtDA3T2
         em4Svh7mW1A67TRH79YUfqGJMuRDRvGaECpJh5uAAwcr0qo6En7avGTyGcVxoSOKfZ+x
         1yES1YwAoKEtuq1iobaVobJJPaDGEZAwcxvlxzEMHJX5tGmV0Ca2cCwwUVO2tDqK5QWf
         MTQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgOgklOZndE9Vnw8OU7EHlU5TZ3bEy1SRtqH/tIXPg7ee0bGnX7owal6MiWGBbS6IttjNeYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRMvnqmS6FeLXIJ60CdcmIt43rpYU0Rg+KhzLqZqzfnIQzZWUS
	CNX9FeEfV4UNulEyDG+GoscpWWdjwi/2A5zbfX/t6ws79nesHFeNS90XslzHuFS01x8pEv3RJKD
	o4Ue+/goa16yMVTApfWXcQG6SAkqikUPIezzuOD60NqSk03EgoYNEcw==
X-Received: by 2002:a05:6102:3311:b0:4a4:8268:9a65 with SMTP id ada2fe7eead31-4aae138b9cbmr1471557137.3.1731085083641;
        Fri, 08 Nov 2024 08:58:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFY/osSz3UlDBbQ0ox84O5Rchw1d3JTWrCxq8eAaHipugtEjyXcxITf9weaSejsQ7bLHn/nnw==
X-Received: by 2002:a05:6102:3311:b0:4a4:8268:9a65 with SMTP id ada2fe7eead31-4aae138b9cbmr1471530137.3.1731085083296;
        Fri, 08 Nov 2024 08:58:03 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a184dasm254433666b.30.2024.11.08.08.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 08:58:02 -0800 (PST)
Message-ID: <3bc06d82-7443-4c89-947b-8931cabd787f@oss.qualcomm.com>
Date: Fri, 8 Nov 2024 17:57:58 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] thermal/drivers/qcom/tsens-v1: Add support for
 MSM8937 tsens
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, iommu@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
 <20241107-msm8917-v3-9-6ddc5acd978b@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241107-msm8917-v3-9-6ddc5acd978b@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: X1srkftaTvL8BljW0ICi6KLCieG5L1pz
X-Proofpoint-ORIG-GUID: X1srkftaTvL8BljW0ICi6KLCieG5L1pz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080140

On 7.11.2024 6:02 PM, Barnabás Czémán wrote:
> Add support for tsens v1.4 block what can be found in
> MSM8937 and MSM8917.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  drivers/thermal/qcom/tsens-v1.c | 13 +++++++++++++
>  drivers/thermal/qcom/tsens.c    |  3 +++
>  drivers/thermal/qcom/tsens.h    |  2 +-
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index dc1c4ae2d8b01b42a0edbb7f12a5780b25d0c8ac..50787cf68bfae48da6061d8e75956308f41053be 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -162,6 +162,19 @@ struct tsens_plat_data data_tsens_v1 = {
>  	.fields	= tsens_v1_regfields,
>  };
>  
> +static const struct tsens_ops ops_8937 = {
> +	.init		= init_common,
> +	.calibrate	= tsens_calibrate_common,
> +	.get_temp	= get_temp_tsens_valid,
> +};

Rename ops_8976 to ops_common and reuse it

Konrad

