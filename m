Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0A3E715C
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180027; cv=none; b=Qbncfs6GOPkyi2SVaLpqUcmjE4sCH1DKAAPAG8gfnjrHQFj7OkblA4Z+SGAHJ7v42cBLCEnSrdwogIkkAoFdvNZOSHxXHUhWNdLSJVQc/fbhNWbuOyvOYQMNH9zJYJrXivZKJ3Wi/EWFnncXLrIL8GxwQItoQeG0xQcycEg5w40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180027; c=relaxed/simple;
	bh=ZVhgbifAln2OzcbNbG8e+t48xa3IPnq3A4MkqBC2ucc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRWOzpXKRmY5F8ZCeIHrki7i72b5sb4DMuMb35LoDfLo2gQPFOV7YkV84HflufqyG8eMGy/xtAqjU1XxjGA2KTMXRVbN6KdJSNKqRF2FpIG7CzykDtJ+hP9d4dC+UAcQbdrWdx1WNbcXWOcTR3ZFE7xYalRKcbmo/2v8OnmcdSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GXyQm6dq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dhr34AfD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GXyQm6dq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dhr34AfD"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EA4DtQ030219
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 15:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eRyLpOe3BxkDfC/79y4mRDy2
	zo6Mqv/lVSOI/jQ5RBo=; b=GXyQm6dqs3c2KrXG0JeQqKuLblcaKvc25vRLgpdB
	p/hDom/XzWvcBuES8/K4MQjLNzj55AUP15ebX7HSketu3jDDHJIotKgl/BH1UeKW
	IQFDj0Hn1xo04LEqA9ZbEHtSCOiq9JOFTfH/kKLj7zcyBf3hHiZWEanwLIxB8GG3
	I+5kY46iJPqpYoX8PYicVau1UDbgvRWEg2R01CDOjkrp3IZhAkcbCkqyD7nPDJpc
	ZTZmm/ZD2LQVbND8jAlkpcwHqHLSY2k3SQznb2YAtXS7OK/i5Km0OmlgTJ+59Mz/
	pURjQBAanOS+FhWWG9dhijMCSmCxzjOE6/LiKekIYcw7CA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhkgmh3ag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 15:20:23 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5fb6622ca5dso2607972137.0
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776180023; x=1776784823; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eRyLpOe3BxkDfC/79y4mRDy2zo6Mqv/lVSOI/jQ5RBo=;
        b=dhr34AfDKdFguPp+oFwxH3gT7p5UWjn2C+ZAbdzZfHUyN1neXCNgNaBBzT+dm4A/XR
         aQUN5t1DuRVxtUsoxvdKiE7ZeyDzdp2/dgcnRNFwSqn3q3kStmBP9q3rse23ceEeJ1Zz
         E4i4pou9ZEW6wkfOCznFT4uVP6+ZKU/cPIp9jc7b2Ypdpst1Pb53m937m9ncobttR3TW
         G1kpVEOg1K2MzOPY8gMJJsGR2QUtefszeUb6rnZNUSLsv4OjgKL6RFNE0PCCXGCvV8Sm
         StYmLrWzc3mVNxb52OjXaYUq4aM0CC9VMWVHmErd9QxDlYEVrmATpY+HQODEHpr4+rS8
         Pang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776180023; x=1776784823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRyLpOe3BxkDfC/79y4mRDy2zo6Mqv/lVSOI/jQ5RBo=;
        b=GMg6clMd6R5nvNZz+mTrRLGb7VAsDUVuPvs2eCBGEdtH5of9sX1hIq5r9WH7xZoox0
         jjEwxyQMA7308GUWvrt9ATeh1naBl4xk06MnZBujeHFiml3I8iwH9sjMdcDmW1fuu0yu
         DY1K++cwYgkiBG2uIpJENflhOG7IxUtzxEwENtW42fJAmTalPaMNZHE+qeZYC2sukUNv
         pDjHk9iDaFLFUql3aHT/PaMl/gOugJ9z47oCcy+y3/9XH9MYWwZyiiu4VHkHdRkr7bGO
         t/hp53Q9n6M61iR48ff2KufZNx0fXNIMtIMtMSZpmT12Dtwh8r6qOQkNwR3YOJoR555q
         o5Rg==
X-Forwarded-Encrypted: i=1; AFNElJ+WnuQCuYA5wPZ37wDRag2gpa6auJDMbbSRyPg6L8ibLib2c0dq3mrzZFFjGNqKbCOB+lPY8g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzbipts9G4UQFb8r60etBfq87nK/zo16bHflo8jm2j4sTr5mgVU
	oAvSFWjn89pE2otDoZWDdV5dLAxnDAU/7tEO/ph1RrvtDfdD6gl23hAHATFRBVaPOWf8iUQippd
	8JbNBpG2URkjFquHzaRbF/sPjcCIxvcXh8qqv3D26JSZxL/H5OjJEz6z0Zw==
X-Gm-Gg: AeBDiesWdsgncsWRRISpbwCdW+cmitCHfbUfhEiO4HOSBgUydXvPW7hdCETs/CXyv/p
	tiuOemEbTSoVJbO1MmXiitE7dZoqPDcW7WvXtKiWmp/FeVu9dTmFICJ4UPlhdyZZh9Q4QffEMVL
	1akgw2MLlmmPr/qRL/HBxCUUKS2yhKmVjJzYKVCOIVsZX6vV/TPwF4MjUi9UQVlnzweNdRcpX3W
	uIqfVaMmobwLOJHaWOLGG9B+zE0RSQQBGGlVgRHenQVDtEuBjFqepPwn1EzWjpkpEThYd5a3HqE
	9Ei62bGBvj9OInJvhzwR1cs7O1ciG7ktuw/gT+awEvUgP9zOkwfkA4P2dXg21ItxLaNTtsUkZ3U
	ct8w2dMWVo0TKw3SRf6qCs0Ng9UbtdsZj9ufd6fcymWtaUOM+pW3ggKjDko0Fh9574u46uyrgXE
	hsYXAEN29nJpacWAUF9trnYtKqmuQSlUXGnwSRw44QD2yybA==
X-Received: by 2002:a05:6102:5e8b:b0:608:759a:53bc with SMTP id ada2fe7eead31-609fb5713bdmr6999529137.0.1776180023205;
        Tue, 14 Apr 2026 08:20:23 -0700 (PDT)
X-Received: by 2002:a05:6102:5e8b:b0:608:759a:53bc with SMTP id ada2fe7eead31-609fb5713bdmr6999473137.0.1776180022703;
        Tue, 14 Apr 2026 08:20:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eee8657esm3314870e87.12.2026.04.14.08.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:20:21 -0700 (PDT)
Date: Tue, 14 Apr 2026 18:20:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        stable@vger.kernel.org
Subject: Re: [PATCH 06/11] media: iris: Fix VM count passed to firmware
Message-ID: <otikvdonnfakykra57z4fingdyfm7xebw2h3lmykzk6sbk7emq@xptiwpx5lvjl>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-6-7d3d1cf57b16@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-glymur-v1-6-7d3d1cf57b16@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE0NCBTYWx0ZWRfX7K3zyWJyuvIS
 BVDFZ2PQTvrLiXqgaTTVcQQARD7krZQbmsEb5jOmI65w+/EUUx4km7ds+Ui4pjF1O50JpbhTrLI
 prNVc8mFkxkMtE3WvokZCQ/n16+O8UQfG4Oax+iwMpCVCLf65J3a91NQirm6vLsbi9C2Wk8gRkc
 aGV06UCyCwxlu5riarAu/fdc5NLeOe2cK3GZ+Geyn8UQLUtVCYlGkeU7olx0OZwqxkxADQQqbTn
 BPpA4OUk8pe9n+YdynnPSZ4k/LQf1S4fBkOIjomMDhDWJm/BXVj1HvypAzJL2tvi1sAfwgf0r/A
 Mw6zKwlmDc048t8HKqH+yq3UT0qP3YdjO7HXv2qS/MdydreRfjMY6Z6aL6/D5YlYqu6PbRcL5by
 UuhyHXHoZFA2A/Rz26ZZZ03GHheUgdtjv/NCrb1YJwG0mQZ9C79Hbo2relf9iX1Ow9EvvN4Vnz5
 4BZZca+dMk1q+CK6JjA==
X-Proofpoint-ORIG-GUID: 7oGUlNlLcabKMS-2FYC5YLXEzgdAH6s5
X-Proofpoint-GUID: 7oGUlNlLcabKMS-2FYC5YLXEzgdAH6s5
X-Authority-Analysis: v=2.4 cv=HJLz0Itv c=1 sm=1 tr=0 ts=69de5b37 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=oTq01oph0ifE-MoszjAA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140144

On Tue, Apr 14, 2026 at 10:30:02AM +0530, Vishnu Reddy wrote:
> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
> the number of virtual machines (VMs) and internally adds 1 to it. Writing

Does this apply to Glymur only or to other platforms too?

> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
> remove this write to leave the register at its reset value of 0. This does
> not affect other platforms as only Glymur firmware uses this register,
> earlier platform firmwares ignore it.
> 
> Fixes: abf5bac63f68a ("media: iris: implement the boot sequence of the firmware")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> index 548e5f1727fd..bfd1e762c38e 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> @@ -78,7 +78,6 @@ int iris_vpu_boot_firmware(struct iris_core *core)
>  	iris_vpu_setup_ucregion_memory_map(core);
>  
>  	writel(ctrl_init, core->reg_base + CTRL_INIT);
> -	writel(0x1, core->reg_base + CPU_CS_SCIACMDARG3);
>  
>  	while (!ctrl_status && count < max_tries) {
>  		ctrl_status = readl(core->reg_base + CTRL_STATUS);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
