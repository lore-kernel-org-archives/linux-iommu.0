Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08BF36D50D
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268039; cv=none; b=rGAE7H2VA//D9lgN8wSbRhKzwCG+SYtUD+5Blf/tsCwxW4sEBA5j1ScHJlwjAUuKpR/Dh4ufEBHyoqGW3FfdjEhOGwf1U2G8WKWbsJayLX8U9uW6zCdTLKCLMaNrIeI/b8u3r0NmdkbR9HoewMAyMbMTsKTNrH48IywGhvq9wkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268039; c=relaxed/simple;
	bh=UAMVwWLPOlb06OiGlUHEI7yxWTDO23kLGEMFXjCn5vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdxo6osVpIlq48P5zqbLbXm7Xrl3jlQKuXQCn6PkACQGpn82P/aRrEnd8+l/foT6b2xZ4nyiczOjZsfiX9087km/YvUEAaTElZihPPX5u1eU6VSd9Kf9Iu/tzn4UtSmv30ktUa8XJ6dzP6Ocg3m7F5V6RTCFnn1KnXJeeX4ZmI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O5gglEjc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vnji6ug5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O5gglEjc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vnji6ug5"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648DDQMZ1173959
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 19:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cMtQJYJVO2Gf9M/V1tEx2sOU
	Xhro7LsTOX7c9UtcKe8=; b=O5gglEjcEVXSpfd3j/yiolJPtp6hq8KO2hTF7sPR
	9sVRMaKQ/bwlBqlnnT/apkrzBTQyvNU3wi37SxAjGQkxTBmR4ExF9b/prHiqNSqc
	a4MoSrVjbM7SyH8yMaxttzTwQKTxHqsD99d/E+luciQOcF/UUE1migTltYPmcrUm
	k6na5Qhw0Kbyo+fsnVKiIZ/bUwlWpKDVQcbCSQc2VtqN2iV9CXxGepX+TlnLyHM8
	wQaDvw1AqNCHm5bY0JYdH5o2LjbKeqKWli0VALnSVwOAbULO1YsEe6oINke4ZyU8
	rPAz1YEI0Yef5r57W4Zjfg1IvBtrM5lZhMPPaEWZ+xTWcA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e132hceug-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 19:20:36 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6314a4009f2so251521137.0
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778268036; x=1778872836; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cMtQJYJVO2Gf9M/V1tEx2sOUXhro7LsTOX7c9UtcKe8=;
        b=Vnji6ug5K1L9+tJaRfby8jDKWMPhMivPJRj8+TMcHPOQiVbDN6jP97jZd7WCzmlRoe
         KbvwpHYmU1VMp2a1mxQ6x0Xy/iBMhRqvu02EgZEfg2wS1lICLcGuCpU7jtAgLk9DPLBP
         MCfClpEUDF5JVpAU2rEWp0fgGEgu6Iu6X65bj7AwzXyhTazUvHS1FXZv8HNQd/0PEns4
         yHkumLDtjec2eYDdt35FWW6SnLYDND+JkHvRWHxytunA0NKvCxxmA04CgVZLcbZcXydY
         +OslZPuwJFwVi+P3r0bMPfZGMPF3p2b5nPZLh5BdEjpJ2bQpGEh3Puu8+Wpwr3lRrP82
         TX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778268036; x=1778872836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMtQJYJVO2Gf9M/V1tEx2sOUXhro7LsTOX7c9UtcKe8=;
        b=HAHhUqYRLqOP1vkJLgnhMOGHtENQ/7pLXLSs5Pww0Qt2hF4nAdhmbU3zEAAOtmo3uk
         lNBxM9nVEZAkLmPyD3I9zk+G6f968x6AFhZdeu2VLZzTRcGf8uWsOTER5QSoUh0te/7Y
         S1TDDwwKbM0PG3tk95hsdrtJQgxd0fTqalFdRUnzM/wKhW3N4CNZeNUxCCxAQXhmVFXN
         oN7IoYPN2OI3ZMRYR2GasjgHPDzuR1KlaJSj1rPXFQ+XIkKkLHUV5b4gLCgzXs0Xj2h7
         GxwgM2bkpNB/h18Sv0hKFzfmR0yrqimzv7XbEPYKtLKEM/h500apdEwdjtagPYpaZMX7
         s/DA==
X-Forwarded-Encrypted: i=1; AFNElJ8aM1IB5V/zzHu4aA2AIcyfCXRp8cd/Rfp3NAbmZwyXUhuIRi3Nzcn/1HeVbSQlFvE2U8Z9bQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqTR+jfiSjhRT7ZXy0c24ZwOMwA9X8RUR2lBAa4khwYz3Cb+uG
	wMr2aghckqDPRhbpUet4+rkpqKE1R8ZzQcVWgren2UgWWv3RFGlm+rkSOh+Iy687swsdplKu/vD
	Ng7OOx4WBaM5JrFlCFl1gdyaTBvm0piA0HZVW+w3/QVaWbmbKqoOTZ2q6aw==
X-Gm-Gg: Acq92OGDVIH+5EcwAJMtUuop4mNuQ0WmfpcZyBFj/rdVOQgbOLzZX65JGMPm9DHlUw7
	guk7xhscEpdVtYPPjlphLlYluyHqOfVHGm2v0JldsIGqVU7p2PjAkiiItHrSsdWI1lUnrs8DfKZ
	EMsgqMUtBlmn/vI0V0T/vjZ1kQ2a0Hn/ScdntebW7QDicFLmLcR6gPKeqCT4XfNuCgIqTN36Ad1
	ZiED2SNdSlimjTk7DARZvT5lAd9uGD11VGR8VSpHtZdTpmyckxpl3GNYoblGTtDFNtvgcZoRLn0
	fHq11w+Z6o2ju9UYPOpwXhDQym/7nbm85NqZHbn5kJhp+uxPjO/Xy6xJXn1Ut5EzjHRI+rKWITN
	NSGQUq+tJNBwsvQTUhqkX8plF+9d3cuz0bP/ZarnKokwQNoUI22XGPp0JaJ8hMP07WMWIcAsKxA
	UYycUkSMymdU49KhSML3E2Aag04J7hCfcmktc=
X-Received: by 2002:a05:6102:26ce:b0:60f:928f:bf98 with SMTP id ada2fe7eead31-630f8ff11cbmr7365910137.17.1778268036294;
        Fri, 08 May 2026 12:20:36 -0700 (PDT)
X-Received: by 2002:a05:6102:26ce:b0:60f:928f:bf98 with SMTP id ada2fe7eead31-630f8ff11cbmr7365894137.17.1778268035868;
        Fri, 08 May 2026 12:20:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a951520csm747036e87.15.2026.05.08.12.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:20:34 -0700 (PDT)
Date: Fri, 8 May 2026 22:20:31 +0300
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
        devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 03/14] media: iris: Fix VM count passed to firmware
Message-ID: <zfh3hb4gowxejxeip3l24jub2z3xh26pzl5xmjhjos634c6e3u@y26yubeb7v33>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-3-7fbb340c5dbd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509-glymur-v5-3-7fbb340c5dbd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MyBTYWx0ZWRfX2Uoy40FDaZMk
 NLjFsXEj36xsMsFUSfw2gHABmJW1ihh/ZUr5N6bRXVVndx1BosEC2/fusKKZFg6rAi+KIo77zlB
 BgkG5Y6YQVPkwP5HAOQi78hejiEOZdWh5fig2rpAY5d1UstnHlNy7E1/9D5OhTJl6udbNqLxHNO
 MkiB3In1H9QtGEsEoi4OSmdcP0yBrnhFPKEaTkwD7+6NJeSHgcwhhj7vvWRbhrO33vIvCDUaxeT
 EonOx8rIw5RxCVb3ubAgdzf3zQCFP8WRGzgLh+S1UIaicQ1OsRHTCEXWE77Ury4NKmNdb7pA9pV
 R1PUrWs2R07pIW7bIHMIGly+un9Uu1PAUT1eUg1kWqs95yDHLalzfhusI77TBEQYoacGzpWV8pL
 xuwKD7YWQkJIIT1J72SJrL0lMl6Eq19gKn+tvtP7EDs9iR6r91KcnOkhifQH6hIFa399NRud3fx
 s7reJZcgL9vIlYH+76g==
X-Proofpoint-ORIG-GUID: KWMLyoKhGSeToO2Bm2FFjyBBca5984hq
X-Proofpoint-GUID: KWMLyoKhGSeToO2Bm2FFjyBBca5984hq
X-Authority-Analysis: v=2.4 cv=McxcfZ/f c=1 sm=1 tr=0 ts=69fe3785 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lCV4VpG5okPm4yurM3MA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080193

On Sat, May 09, 2026 at 12:29:52AM +0530, Vishnu Reddy wrote:
> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
> the number of virtual machines (VMs) and internally adds 1 to it. Writing
> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
> remove this write to leave the register at its reset value of 0. This does
> not affect other platforms as only Glymur firmware uses this register,
> earlier platform firmwares ignore it.

The explanation is pretty suspicious. I can see this write in venus
sources too and it was added in the initial submission, dating 2017. The
driver targeted two platforms, MSM8916 and MSM8996, so this write
predates Glymur pretty much.

> 
> Fixes: abf5bac63f68 ("media: iris: implement the boot sequence of the firmware")
> Cc: stable@vger.kernel.org
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
>  1 file changed, 1 deletion(-)
> 

-- 
With best wishes
Dmitry
