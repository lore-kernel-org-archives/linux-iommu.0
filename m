Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84BD4DC55F
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694835; cv=none; b=Uj/xBMXRkrxGIK3WsfddKOl33DGiVBJogqMcGPUn702C+QL5Vm2JIJ51b2+3NpZjjfadVnX4vAIYxQptVmB0tVHPUP070fWclUuxhxQQKSYkHhx1rtlpbeN1mWNuGEUYm4b7s+cbS5IDRA9TiatXe9Hx6kSP3omuhw13LewnP5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694835; c=relaxed/simple;
	bh=Jx9uvFmPRh4k6c6pHREQspkKkEE2qitXAOzyNLdTR9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVDaJg8DJAz2JkFFWFo099AonIygNrQdMcCh0DY5/APbaB+3f5KyXTPTPL6ywYIY5+SByk/JRpg0XzSgdgcQgXqBJyCe8GdcteHF9VlQ8MlQBcnrfCI0OF61Ia2F0fgRKqyxhdOiYWSzv56n9tlj1JgYguK0fUU4aeIWssKTA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IBlM2wlM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dR/DNiLz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IBlM2wlM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dR/DNiLz"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DF9EKv4159821
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	amWzFW2AhltZZiBpdafVGSL8sTRgUnuUyXbxrb/TJ1c=; b=IBlM2wlMmqeFHzE2
	wOWomBDbwP7QrhCvlVkGxcI9aMBJLS5dDoXUAUC00axbhIBBeU6oOEyHJWA/kVY0
	FrZHO2ySgFs6qJBcYOLLd/+oKkcBb6oiMEAa7MsmhE7tE5XsFsg0rvujVPuK4zmB
	riOzJp+hD4PbmO4Kx4+wl00kLYv4tsdzH8VGmTzGWE/fgRrmvunji+kr6o7uc9d4
	K72iuduBvH+MCTPK5MeQhitzF42fS3xuqLWIwt8OFzt2S4kKpwYM7IJ3dd5pNljR
	rWJmEll7upmriXcTaPhJymm0GzIEi6yrNGXEY9nCiM4MX79mf4Uta1hTzFOkfbma
	xtKEJA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p91t4k1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:53:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51494d74d4bso116980791cf.1
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 10:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778694831; x=1779299631; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=amWzFW2AhltZZiBpdafVGSL8sTRgUnuUyXbxrb/TJ1c=;
        b=dR/DNiLzivveBiYsf67AlR/aNa4Hc20iJ3o5pdvXTR39dHcl35dJh0diHvg7HuuX9J
         9jpqvxXjULgWVn69TE31n9Dg9JZ6U9gHRsnMgqiNY3AocyBV6lQNbTyB4iI1l5uebKEG
         bAlZ3CpCx65a4jEz3kMBARcV9snnpNupGWszfq8L7L4I96/DlehMIa9UPXXmpVw/qrM+
         QnAgK9699rWBaehrOA5eFHUnTv4VULgE2cUdqQa7RCXtvRDAkZLhu5WyFnFm+F8HB1zB
         f8zqNAEOD+tGBsun8izZfpGGVwzLMBmqcQHLO4lgTNW8m57oMs32WDFFAwsiUauvnbF0
         uPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694831; x=1779299631;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amWzFW2AhltZZiBpdafVGSL8sTRgUnuUyXbxrb/TJ1c=;
        b=p1pFp/0zM5Ep2/P2+7smjx7ANye4acGKo638FCFmt08Dzn7yhYhXj7ac7rDIzwqX9Y
         V9RB7QNOw0R6RLcrloJfBJjcCo1UsZuOWP5Fi0HukbPWZKlZ3OqaymrPbUSdQvoh6I0M
         rlyQj4a5LP8cqZqpVylk8I3Y060HbSh0/IFZ8NaN8ctXrR+j4z+rhK8zSoY0hGYFRLcF
         LPTAZAPDlDrKIjlsbFOLSXWDu2DzCl6kKFDxWIbU85WfmsTwGM3YUmF9WzcbtgKLIBzl
         PInXrH2kO6kym36eE+VvZucUluqnSFszAAKK1dnK5dDM0SDUcleVCrYOsZsDrPFmcPM3
         G4Dw==
X-Forwarded-Encrypted: i=1; AFNElJ/FYphf2EkDJpHYtbf7R6i4lpRmX1/Iqhz5SaQotDdJg8DnoBrm+uk985S3PSEC/P+PdGJE6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YySZc6yDztj+S78k9W7iwUwwpo4Xz18rpid8zPgGgWqcN7rApNf
	zJzmYZEeTrXlf1PLzsht5VzSXYE9yHrDz1vRb7Z0d6beUWlsgkfnXLS1ZPcXQd3Btns3/iLKMu8
	hSzRXuHZV3R1N2Jr3gWLh5ecjyTjPyySJJfA7sr5gBvx54p4KQNkDWSmu4A==
X-Gm-Gg: Acq92OFdsnGYhPEQpsFanNSNh3FIlc6JFLKYNZNz9lW9TTFArOucsfxLG6V8sud9pWB
	9YShMX4bAOBATdZjereX6xpSBNFwJmFnWEkAzk5/ovARhcQrL83T5E7O/kRxjBvqGrXPhZ0wJ6A
	RcbdbTXMSpSraVSZufGfpTqi57BBZJlT+bVOipRj3ntlDsAvGpPBDw8eCRR2VC7txrqB2bsc7jC
	4qZ+yORfFG69t5+LqxpvwkPqUbPBhttO92r/UpdCoPU0bMgKXPsBXbEvFRo6zKc9vUVL953zjSR
	8Yje9bBlHhjeNoE5DvyU64SbeHVdc8D4IC8SKdrCDSRgT8TJJOf18Qi8owTz0qkFDhHDIfJW3/d
	1GrPORk+nEYGY7FF91iLTUThpF7Ys51LqHtua4jDHJmlQOKQG8Q1f141seV+3eoSg0WEcFXIxWO
	LNxHs5M3OXW9qf92sdeKXkG8bB5x4zoPjq5EVIEvkwJ/EvzA==
X-Received: by 2002:a05:622a:215:b0:516:35fe:5524 with SMTP id d75a77b69052e-5164155bc78mr7504811cf.5.1778694830903;
        Wed, 13 May 2026 10:53:50 -0700 (PDT)
X-Received: by 2002:a05:622a:215:b0:516:35fe:5524 with SMTP id d75a77b69052e-5164155bc78mr7504061cf.5.1778694830374;
        Wed, 13 May 2026 10:53:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3945cae06b4sm109561fa.28.2026.05.13.10.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:53:49 -0700 (PDT)
Date: Wed, 13 May 2026 20:53:47 +0300
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
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: Re: [PATCH 6/8] arm64: dts: qcom: kaanapali: Add GPU cooling
Message-ID: <iun4ziuei3tzvr75qbbqgxytto6vptvtd7j5mr5ol5aqviaafz@5m4yxgnqjavc>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-6-13e1c07c2050@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512-kaana-gpu-dt-v1-6-13e1c07c2050@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: faL7xyPIV0tv0B5m126m4Cg76ctSfpUS
X-Proofpoint-GUID: faL7xyPIV0tv0B5m126m4Cg76ctSfpUS
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=6a04baaf cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=U2egry7Pn7Pb3urGTtEA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3OSBTYWx0ZWRfX11iedbWQfSUm
 YAcnx9IxPA6F7SO1rzM4m+UoiN8wo9lOkO91ZrN9Y9KKTfTwhqnMG+h9Hp4qsOVZjurCQM6Rce2
 ATHdeFrSzQnffy6eEVesOgUrNmiZrtWsmLSWpQchc7ED1KRTq5XHURujXQBQPfMsRBWS0/b99h1
 96jBfbbKwT7yReXKE+Nc2Bx1o6dP3Grhg1dNrWEkT+z5H0+PO9h7124DvTtWkzAz777A3hG6h4h
 /HbnPLE0q+222pxED36DNS72CHLvvzVLlnYpG0pSLK1K1r1WX8l/JL/fcFaJ4YCzre+jolbjmJU
 UYxxIqvBS2au6APrvh3cWlOlt272qDLX3zhz6rL0aHnzCM5jd/EdzkjKS9iK3PKZLLyMM/t+IYx
 BFxvt7gofSc6iMDBpWVlqF9BEH/4u9Y32Com0VhsbCWms7xH3WYp8XISg9b/NC4fg3YI/+XWjnw
 KZ+UmARvg48sNSablOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130179

On Tue, May 12, 2026 at 03:53:20AM +0530, Akhil P Oommen wrote:
> From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically when it
> reaches high temperatures.
> 
> Set up GPU cooling by throttling the GPU speed
> when reaching 105°C.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 165 ++++++++++++++++++++++++++------
>  1 file changed, 135 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> index c57aea44218e..5089416ec32c 100644
> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> @@ -26,6 +26,7 @@
>  #include <dt-bindings/soc/qcom,gpr.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  #include "kaanapali-ipcc.h"
>  
> @@ -7045,13 +7046,15 @@ nsphmx-3-critical {
>  		};
>  
>  		gpuss-0-thermal {
> +			polling-delay-passive = <200>;

Other DT files use 10 for GPU thermal zones polling interval.

> +
>  			thermal-sensors = <&tsens5 0>;
>  
>  			trips {
> -				gpuss-0-hot {
> -					temperature = <120000>;
> +				gpuss_0_alert0: gpuss-0-alert0 {
> +					temperature = <105000>;
>  					hysteresis = <5000>;
> -					type = "hot";
> +					type = "passive";
>  				};

Why don't we keep both passive and hot trip points?

>  
>  				gpuss-0-critical {
> 

-- 
With best wishes
Dmitry
