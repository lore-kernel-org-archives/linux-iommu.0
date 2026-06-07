Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A24282F00
	for <iommu@lists.linux.dev>; Sun,  7 Jun 2026 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780869044; cv=none; b=om0jAka0YD+LitMlR9/tVAvZ9AVaU8OSOKjE79OlXoIFGwxdfjrGWyRtUehsSNZalOj40ZCgHK6HSE0JDtGl8+U6PL18+ZDCpvdFddOtFicXW8ouk8RUlYxF/ZGXWbZkpgmkY6/c0M6iWA6fr4kMAicQlvRKzAYsOAohZnrtAC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780869044; c=relaxed/simple;
	bh=UomSXRxMTAKvyZiKT+NoMtsFruOw0/rkwBDWsx5ibcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfxOMeDUxqMVfCs3ZJ0f0kdGxa/9woypAsdXl4AXQkqbrO12+WbyUwvOdzbU5LzdiU0Z0QY/Iz+wKTxYG1uL0RJZ/JBaYYv79mvxMvmQqCTakgMXte3pIfqGUnQ6z8WL8tMFAVxXccQKrI6hQ6mbXU2ZTT6yv1ArMpfv9fsjFjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EgPUd+Fc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jBpuhJle; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EgPUd+Fc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jBpuhJle"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657EkQdu441974
	for <iommu@lists.linux.dev>; Sun, 7 Jun 2026 21:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TkLy2ZXcdqLANqAf1PiLH1iG
	ICYsV3dWxbIjnbk1Yz8=; b=EgPUd+FcdAB7PL2qPJ/vI+0nESXL6vFhId9IOAtq
	7jeG2dhxQZw8aHXPbbYw510aUBNhtVlg+NYcODu0m258I3OV4nkYJXWk2VhRlLxg
	WrUGK6o/jvOIg3sM8ZQCsT7U+8j7y0P0Z4GAcaKhYY1HaRu8GiJlJ9DqxvF0XSSH
	AY7wrYWhNwXNcJ+GYSidRcwlzuv1uaCzpjByw5geP6odR/skmt3Dfp08krzlFEfe
	VoyIRRNQIW4fykb0zxC1YhQAZKOZKirvLS72A4FYBe/D9uWVD8ebwkQjhe0WmE6M
	3DA1YlX9GDINfF6Pblz8Q8z6Hu4+x680zlKVoB064wG6rg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs1cqyx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 21:50:42 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-963b4e8cf8cso5757204241.1
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 14:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780869041; x=1781473841; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TkLy2ZXcdqLANqAf1PiLH1iGICYsV3dWxbIjnbk1Yz8=;
        b=jBpuhJleslNcBKhvXQTEyhQlcML31T7YJ8/OTLGG5k/IMvp2KAe6wVtoEqSkupNsOA
         B3GT5QiKUCK95QnFn5YAxGUDC0oPN2OyXFFFrt9UKw6F2QWDm/7BZDk08EA53+vRKA//
         6Wk3x98JxARdpGh0fM1nsOzBadWISnmxkF5K318OyzyHpkq5odwn4zLPt4QU6rTXCN8E
         LyRvCEzzhScJnkedo0O1aGKchlcMDk1jrqUAu1mjHTRyOXAN2HB+nxPZY/eERFc+OK/F
         fEOMJgpTDvvJwnvRZLAehn4E7dv3lya+E9HkVybdqF8wGYHJBetWg8E7fE51WiB9VftN
         /RYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780869041; x=1781473841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkLy2ZXcdqLANqAf1PiLH1iGICYsV3dWxbIjnbk1Yz8=;
        b=l2WLUNyc4Huj2eY3qDINhEjw3dHfKZ4kmINlcJJUPJUKAV8pBy0sM77CbG/JAFltUu
         k9EjrUnSZyAsle525tIzOjYlnFCdVfEMGIxCZR+6H9JxcXKEUq5z3Y1NN+Z0zhMsDim6
         sZ6TSfvRR5lFIYneGzbJTxDVcoYP8Ncp+NlYrXuvIfLZxgCkpLARlzD0ral7XTKj2IDo
         8D54nxSkUyXLH+0xUtmYsNRBqTLpOAoy2eq66N46PhjmVZ9YB2ftcT2Q4AX8BU2QYqBn
         r1nPBZiyOIZhxQmZHKg/jjaxF0WteCqvg03sYcIX2p94YT+Vl/qPh2gVM7AZvP5oL7Ic
         kXnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+gVdJmMtfVhDUM5EbN8oh9ATg2vsIKFIC0EMK+DW9n8yVc41altTK9zB2Rkb1egrzzOns66A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5iBy1U8UNSxkhE0yPiq5ejRBsOxG1yvT5vklZVYvzfU8i4O3c
	qBqjxXe+mx+r6jeMQMtCpDE9TPPmu0SkkHk92LnpXvCc3TEO0p3+FukpY4FoA0wULdZNUFg4a52
	xEDKQ2ymDJYqquWEZlWyFwtlKbIgINcPlx+V3iImkpPGVl4IU0IE0Zm2bwA==
X-Gm-Gg: Acq92OGlOT0eWkKDFC5KKvCcncJ1EisAvGogniZOxRsOjJJCSKZ/hvgE72Q+ehdXhwx
	sQS4IhWaWtXpU7ACO7T5TQeThQCob3LBe17W8o34kjgKmJaHNps0FHro+gzV3tLhfSPsDRCqaof
	o4V6rKFczcGZ9IDCnqTyXqYzk9go7GoKBeeCzQePAr8LeCXAnMBwwSOoKEB3k4RUemjr0dZVO/9
	SMdRMYUWCHWmn9m8Q7cf+P8W1rmSvjHjzHd4GXsGfSJSLfgZqGYy2qOM2nBKuVD3q4CL4YL3qf1
	YM8oW7RpyPYQ7MhvW+MvEB/wpp3SUO8o43PTFhMrYoMAAbHEn8eYDSiqTQRtl1uDHIlNkSq54EZ
	yT/zxvCXV7ZOPTcMOSdDiOfIfJnNTABELaIIEiWub/UYlEdNObNqaJ47SPNsDuN/1rb51EvR+RZ
	VvyA7C3CcVznPp43y+t16MfmAXuPh95vfHz9d46dhtbmzLyg==
X-Received: by 2002:a05:6102:1849:b0:634:d97f:7ee7 with SMTP id ada2fe7eead31-7002d6b6b88mr2938800137.7.1780869041598;
        Sun, 07 Jun 2026 14:50:41 -0700 (PDT)
X-Received: by 2002:a05:6102:1849:b0:634:d97f:7ee7 with SMTP id ada2fe7eead31-7002d6b6b88mr2938794137.7.1780869041184;
        Sun, 07 Jun 2026 14:50:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b985ed4sm3271776e87.55.2026.06.07.14.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 14:50:40 -0700 (PDT)
Date: Mon, 8 Jun 2026 00:50:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 10/12] media: iris: Add platform data for glymur
Message-ID: <7s3vxq5pd4oc66hygmpl7ku4kh4jwztls72dw4hswxyusrzfrk@p7s7645qjxor>
References: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
 <20260603-glymur-v7-10-afaa55d11fe0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-glymur-v7-10-afaa55d11fe0@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIxOSBTYWx0ZWRfX2i6RBt0XsxZ9
 yHx5GZWYN4VJsO0RR6IzRSjX7sCd3YsIJg8M364sm9d7snbWwEV5/bA5QsXst/DA/k9I4RmDt7M
 2RR/CkcB2zKoBzVeouOLp3C05TT7YJrmk/fe1kJjBxHdV/XOiio1+8P6THPpxpMXUB0m6nONbM+
 0Ik4c9NyZ0gjhbDrNoVDG2xwXR+2LfPPCxNXoB3M9PmszJBZjgHVnHZCVgjfYw0pf9cMJfa+iGE
 Xtr4DPbMVcjG/qUetREihg7CLhSePOmsEE15ZD63FA7tj6wJEzmCCfitbsrCZtjVDCljGB2BzoM
 ednaDvTzaLjpCodRvHGaC+HI4Gl/0HkshlAoZZ1HTFJRDRaEGpRK+4q48PUwwOmRlTIQSQOmhRL
 ttb9Svzlwcn1543rTTtHwIucl/sJJpqbfLoMSSyzPWTp7TNgsd/Gy5b62n98tqNMe+6FZ42EHYK
 Izch0KWscM+L0D3oFpA==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a25e7b2 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=CfngaO5SQeOV7zP3I9kA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: Et3ajMY4kX13ETsZltJc10Kp5z3aAH3Z
X-Proofpoint-GUID: Et3ajMY4kX13ETsZltJc10Kp5z3aAH3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606070219

On Wed, Jun 03, 2026 at 07:48:48PM +0530, Vishnu Reddy wrote:
> On glymur platform, the iris core shares most properties with the
> iris core on the SM8550 platform. The major difference is that glymur
> integrates two codec cores (vcodec0 and vcodec1), while SM8550 has only
> one. Add glymur specific platform data, reusing SM8550 definitions
> wherever applicable.
> 
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/Makefile          |   1 +
>  .../platform/qcom/iris/iris_platform_common.h      |   5 +
>  .../platform/qcom/iris/iris_platform_glymur.c      | 106 +++++++++++++++++++++
>  .../platform/qcom/iris/iris_platform_glymur.h      |  17 ++++
>  .../media/platform/qcom/iris/iris_platform_vpu3x.c |  35 +++++++
>  drivers/media/platform/qcom/iris/iris_probe.c      |   4 +
>  drivers/media/platform/qcom/iris/iris_vpu3x.c      |   3 +
>  7 files changed, 171 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
