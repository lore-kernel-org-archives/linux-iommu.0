Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE41A08A4
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745415537; cv=none; b=oXuhWxPvRDNlZD5QgDHutrYUugkpl8NHjZHnhX+0sjYKY/7H2NE8oWMGJEYeD5YjYtBTadWny4s1sCUV/4EoEqZKvGBwvVVhAgR6BB8IiGhfNGb5cDIti+/agCdl4V6D4cLSKfe4el00iOLhvgBTeZIc8vQLm6IJiIHCxXjIEJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745415537; c=relaxed/simple;
	bh=lPJJwHKGCbJcWTOy/W2KqY1hoahEC6Ch3aeOkRUot7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SP55h9/AqSfY3U20nJZiNkrwP5o+D1wa2FLZQ8c/o8QrRoYhrYoWj+uvAnZohhEXqJ8wPHippCZmfEHxzqUn0OtKfLdwgucaun+jGRYPX584m1VR5lenE9AJhllWgH72FFaHZ1jNgxaLxYNqOmfaZsOvW0QBYTqj7eOyJIahgVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lln9v1Oc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lln9v1Oc"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NA9mal014551
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 13:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wj+FtiAGAkQ5P/5zChODPkrm
	ZAMKKPl/2U1Ld2vwF7E=; b=lln9v1Oc1wNdBAOcxgSa0NUOSO3GeARiFX0pWfBT
	TB72Ue87DJnryx3NjX+fkfljwpPeSHEttfHNXIMW0hMXfAWmCQz30Qfnr39qHxoj
	Lsz8T5pDCCM45mCE0VL7jq/tReu41HvWK7/F0k9p7WykLE8P6KYjRbdAbVTBQo7A
	RPpPQOoEZPn1+toa5OKpsOVAoTp02EWXjAQ2jnwOR+1nGzmnsNxXz5/jRHpWaMO6
	ZKUigtfJs+ZRGywq+p3Sl08dmcM8y4u+3rlYlzQjQ99zakY39vFtej73yslL+a4i
	J87Hg6K/1RRqiO4kV189DUnc/+QfgYfnPwl/yelkdOc3Ow==
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh0j911-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 13:38:53 +0000 (GMT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b5878a66cso2053589139f.2
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 06:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745415532; x=1746020332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj+FtiAGAkQ5P/5zChODPkrmZAMKKPl/2U1Ld2vwF7E=;
        b=ZJR84LgpC0FIHNNG+AwG+5ZB1aMCvEBS/1RDhjlq+/U2pF4nxVMECEqzJz9xv0HU91
         Bth8iQsW95SrFmR3c6Qr2BqQr6J1xVbRbu6z2nv51QLWs97/51YDvcJcIcEd30DlmfGy
         oF61xoYRtq5qstxwyRkrQwwfdeOWGkT8xU9T6lIq/BRGb4D1HMG1TR2iyDMtkiMLzMeq
         0IvHrz+h9fBqjDWgtph7unptJGqYcKzmP2i0MxZAKXjVgoKbcTE8VuS7S6XBT2cRWyzp
         rTvykEWUhQU9lP/wPDLYeDwA2pldwom23/A+FN9Bo1Fmu5I3jvDN/G5MlmgI+ZqHTtfk
         zZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxZTL1li6eADtxZ/50eaoLngInEoITU1EazHH15sCEpGPI6+uiTVW9FOS+LNvChdMUrZM7dw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWLJpr+L+OWHSHAac+uJQHRQyF28AlpOYD3wsDNIFpiL2jjNQ/
	BtBaFCcoqYJVdeyCijPNpIV+skmQ/PdhzTBnbgw+/yCGexnYTwyNgcocFd4ZnpTK9NeiYWW9Njd
	FQlmz7Ny3i2l9uoz6vV5JqW7RTe+2CssEUFgR3s0w6k+3+FVSQrYMlQ==
X-Gm-Gg: ASbGncvQ6gf60q1rqk9Vbslt8qsDkGUnPlrGofp8POpDMyJidGKWBhDprYxtQ9LnLnl
	1UpCrszVNXtTs/99tZJsPwxLrwk0/M0eSJG8sIssvWFOQVNJiHsu1Fob9en1vsL15O3AAsWoUoN
	pWP1qTKQCmL0x85OvWme5WXAcxo4M1dsGRB2rWBJa74/FR1ejuWNLPuBKzbBgjhPfaFpJP5+aD3
	lRqWAqMwjin30qHJE14EouRXr2hjQ04YDsZBVaqm1eb4W00VSo1vMYb4F/MTDY9dEw80TXqizg0
	YO3X4oNGPRq2HdaFVCAM8GZwE9wUnKGXePk7eMwskiNBT9G5D9isV4wAEUplca++4xlhYeFmzKc
	=
X-Received: by 2002:a05:6808:6a84:b0:400:fa6b:5dfb with SMTP id 5614622812f47-401c0ca677amr12197807b6e.36.1745415056325;
        Wed, 23 Apr 2025 06:30:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDEi3rdB2ep6R+cK4PHyu/fZwFAeRdF3OHYastR6zA3OEKUX6hMlxowo/Y01S4Kl8W7OZkVg==
X-Received: by 2002:a05:6808:6a84:b0:400:fa6b:5dfb with SMTP id 5614622812f47-401c0ca677amr12197723b6e.36.1745415055890;
        Wed, 23 Apr 2025 06:30:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3109084e434sm18283881fa.104.2025.04.23.06.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 06:30:54 -0700 (PDT)
Date: Wed, 23 Apr 2025 16:30:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Lee Jones <lee@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        David Wronek <david@mainlining.org>,
        Jens Reidel <adrian@mainlining.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-scsi@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-remoteproc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-hardening@vger.kernel.org,
        linux@mainlining.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 28/33] cpufreq: Add SM7150 to cpufreq-dt-platdev blocklist
Message-ID: <pywgehih5yrxbnzyjtufkh52xiuonsjv7wougvbauiw2yd3mpy@imcguzi5f7fm>
References: <20250422213137.80366-1-danila@jiaxyga.com>
 <20250422213137.80366-12-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422213137.80366-12-danila@jiaxyga.com>
X-Proofpoint-ORIG-GUID: X9p5GnXp64zoK1UFnhPpYYE-e_TmdsKc
X-Authority-Analysis: v=2.4 cv=ftfcZE4f c=1 sm=1 tr=0 ts=6808ed6d cx=c_pps a=x6q9Wowz3da5qcMoR2tSzg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=7ibcVnAUAAAA:8 a=EUspDBNiAAAA:8 a=KMkCwTOw-m2sBZ1LepcA:9 a=CjuIK1q_8ugA:10
 a=TsFzuV67ciA61D7d30EA:22 a=HywIFdX19-EX8Ph82vJO:22
X-Proofpoint-GUID: X9p5GnXp64zoK1UFnhPpYYE-e_TmdsKc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA5NSBTYWx0ZWRfXz5OO8LWxyI9t G/oFej6Z/RsUanBzHyNfGDI7iQATP7uLTO/V6nqLoskoPGR2iX+VTgZNYfr5RQW2LnFGADN223M kJyfmnNyo8tDa7vkfoaHB8z4sgLnBCnv6KrdTQY+lJdapJZaYXvfv9Wm8cdDEJbBAQ8u6zrZyMd
 RHn6HUNwkMHfjUscmdetNxjcFU19pEb3eXFgiRSaHHFTQYfPaASsmGXR1RbAruqTWqogP8phWYu i4uZpzM7j8lDOx/hR+bjS3JxzSzlcvbRWyE/O/QzrsBw1jmBzkcETrKXgfmQnm1nhlvwB+Kq9z+ hCRptcyv721pHpjomxx8bbRotX4krzFKo0ah3DNwEUfQ7NTBB6x4WMBR5L/qFYlnwRAbix2Xv4a
 /d/AB5ZxfzIjPsZXRguUcGtY5M0vhFgwHCOjaTnE1Lx6OopZR7Lf1gMNtne45Bh3/qXG2QYa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=665 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230095

On Wed, Apr 23, 2025 at 12:31:32AM +0300, Danila Tikhonov wrote:
> The Qualcomm SM7150 platform uses the qcom-cpufreq-hw driver, so add
> it to the cpufreq-dt-platdev driver's blocklist.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
-- 
With best wishes
Dmitry
