Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020F2ED84A
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783385442; cv=none; b=qS0yMKkapQsZn3MXpzvw6qIf39WYZmb7vruKlZ/r08DFAD5RETC6D4yNoAzrHmLDAB8hmRs8MmmvsVdel81QIfWfUERiRiipLfg0QJEx3+v0ABu4CQjiwOawiGp9UjMjYlOkcN9qg0MiDJFfbkWGGEJI/ziHPdhEAMvW6Ut5Ifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783385442; c=relaxed/simple;
	bh=WHXqkGv1+op9/RSasjwk83MuEuNNutgpJOBEdXbkio8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuOaM/uVVgF9+iD3HwyJB1OqSsIVkdUO5IZqNOazp52uCeQQjFCe7V8vsf6WuFtGlLp1I3q1RHNoZ4BhvPJdS9xrZvUlWBc1I40VQXiZ5hRNRVnfik2yFwmLTJ7kdm/w24+k+O8djTNPWG01gdASiyROY6Fx8j3HtC49ouW+DuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eJTRIo88; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T20PLaFp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eJTRIo88";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T20PLaFp"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KEALm1504917
	for <iommu@lists.linux.dev>; Tue, 7 Jul 2026 00:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kbaBHhic6gIIK0cxoTZmQQiR
	L9kgLJaSC+bKDRff9ZM=; b=eJTRIo88ZURLWQ5Lyl9WzJI/vCIsL6m0r6me8kbU
	E6GGdQxMA9C2sXJtRQxlLfHdSaxhVMho6axkjBVn/D/ok6EG1VXKL2iuAtAk5hdT
	8rVUBU7dMOL7PMyJCqzDhdveUpN3UDz1Jx6fVCpQo4AK77kQy1vhNGPuUkhS6oxR
	c1ijkLM58/VN0muS1ZQhuxyqEXvwudTJ6PJB0y+xIRGzR9YzCVwyNlQcntYYXr0X
	An0I1a372TVuEtU/Gw87JbHDk/YN6Xx4iW+amI+o3Lzox1waLgHqJYMvF2P0ZTyQ
	wOQ+jJQdcf0xOVOA1PJBnEbT6MepevICsboXtqDd0oLIdw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98kc32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 00:50:40 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-738105fa48fso157575137.1
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 17:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783385439; x=1783990239; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbaBHhic6gIIK0cxoTZmQQiRL9kgLJaSC+bKDRff9ZM=;
        b=T20PLaFpplx76ZLhiGovudzfHDLBmyl7uD9Ak2mO9SZJWtFk4nH+hnA45lM+SN3lDM
         g+c4bc2Bi6LryNhMicPm7/3r3j5eIYQX5vm+Bso5wAtc3I9fRECfe25HAjU63bdKtIWR
         TnrjudJFXpxev2irKv+5v3vu6KhHrZfYQZvx8kV4sA/tUUNnaJOpj4FJMwJAFolhfCLX
         oooxiZw8H+lYEWRGrhO7hbtgjSJclzlI6bB/gP+Ma9PQj6mF7OJvZ4X21sYDoBacd8A4
         qeSKm6G5MGQWwCo0l2SHrJcQh1jC9NMIkPUjmP59RYSPJhnC3PJwCDV/91k3OFkLLrmn
         D4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783385439; x=1783990239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbaBHhic6gIIK0cxoTZmQQiRL9kgLJaSC+bKDRff9ZM=;
        b=MW6JAwk9BFs6Oxh+X+NXNOo5RFDH2rfQXW/Xh+pAwIgin5eoUGWQMj/b7sT8SUgO4k
         RURzXGSGcxSRfGb+BPApIUXURcusFw/xSoNt8UOcecbCAck59/L4tZCH4P4n/BmxdU1q
         G386TOONQsU0J0zxHK0WZZZHBoPorVd23unDuueoswOnBRZ2a9laqNb+ZP4Js38Zds8j
         cp5pO1HwFnXKfYeWwwQBMyniL0NWOYpS5PORzYoTYpyl50LdIYCJdnEI0Jtl0BCVAaRf
         ZXbZu/UokGnax0d4ffU+chvHj7NFJBvXOwVrdRSt7PL5f0vOEZifXHcfwmqpkjTyn+Xr
         JlGQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNZBfF/YzE8T0GQx+UH5PJbkzY9iuQ2NAaYHfEeuPywGNnqqCX0J9Y56tC7cT3CeJdBRV0KA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzXh2p2Zs7MESk69vcXLvvlp/JaFc8nT/MQMfnOCx99Rqbuq74
	7Cys57iPT13k73ZLynJxNSSFV3WWn1hJMzsEfi8mPG4cAo7JvhPp/9GUR3I7viKDT20DpdXd9Yu
	mhKLnOU4id2aOuTS5qPbp61SBsp3T5OvVlSIO0mhfdjxcL/7kvVx7BTn4cA==
X-Gm-Gg: AfdE7clwPw1BrMDnqF42qjYYeSTHvBREi/EuBxUGj3MZLn1BZtaVK9Zm+UVTGQmkc+f
	OpczxPA61Xl99KExEmmAUwFAwhMYOLKYmThKrUoEagShOQ3POdODbs+2iVPOBuMO+0ONe6suztQ
	Vmn2MEqlyBjbIiZNqlCjZaSxhMYiOZJ/H46iYhASx9uYEhP1EaCqrD1Cb3i/YNish6A1+Ad87T4
	d/t56D5amSmGYC/GNTVemRf0U49mXQLXPAv2CnM7ydhq+0HiFZEvWtmdDs0QYcLg0Joao3Nt882
	I+3tb+gCeG6K4wgiryAmeEAKeqimTe2sNO4zk8X01gMPCSUlRZ2Cqkjgxh1ZIJ2q5ErmRkSFcII
	lj8tQw3927Jl2qn5Bh72Ie+GL2VxspEKn0e3lBq2sytN/4jQtvyQS+xhEq8S5viJaI/QM9kHr/p
	rw6kglQ7gWraIYtY0P5pmFK7Ue
X-Received: by 2002:a05:6102:3244:20b0:738:9c72:58ce with SMTP id ada2fe7eead31-744c238cfb9mr307046137.12.1783385439564;
        Mon, 06 Jul 2026 17:50:39 -0700 (PDT)
X-Received: by 2002:a05:6102:3244:20b0:738:9c72:58ce with SMTP id ada2fe7eead31-744c238cfb9mr307026137.12.1783385439176;
        Mon, 06 Jul 2026 17:50:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13770a1sm3261848e87.20.2026.07.06.17.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 17:50:36 -0700 (PDT)
Date: Tue, 7 Jul 2026 03:50:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: esteuwu@proton.me
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 6/8] phy: qcom: qmp-combo: Drop qmp_v4_calibrate_dp_phy
Message-ID: <jnfko7lrdlda6qqc3453c4kjmmh62e5vd5pcj2icbnvu737wi5@qttiawd4vjrc>
References: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me>
 <20260622-sm8450-qol-v1-6-37e2ee8df9da@proton.me>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-sm8450-qol-v1-6-37e2ee8df9da@proton.me>
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c4d60 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=0gM5omY_zckdEeGsnHYA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDAwNSBTYWx0ZWRfX41M4jpMPhnSP
 L3l1JC3R5KmtnqjYnRj35ZL2INWCfpka1vNPZNDhn6+DO/59KjlJDMUk+XV3wQ//c5a64pBe4l+
 plEcT8BLUv1S7V14us4+oudGJmm10p1VMMCYn5EO87xf7seTba0f4Gf5UznWCAedBQaGt6SvuDN
 tSTO5KawWCsu7kSNK7cowXIBOjY9yO73Zun2i0crSxBv/QNEtwdVKWV7Rd22sUbl91wOf4dCihP
 227U3OP6nthJqbRNBYQt6BB7Dk19LN5Pxhegtjfp+2KWjoe6Lotq20Bx09SkvgHH2mJXCJvSBvO
 NkPbZ95PHhIm7cpe4lCTdnbPo9XMS79vWBI0zkhFJpStAx+c4RsHUBFV6qmdj92lh31x/FUKvV7
 J/CIuDIbBIjxVinLVpSO+X5mgGZXMvjIXgw9ZoEH5hnrZllj3611W7qlPd3brt4PuzMeB3ve9j5
 3uhyDgf+YnKaA9rKKog==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDAwNSBTYWx0ZWRfXxbQ3GnJCNdUz
 L9KC0PybcCF3j5IctJV68So4BxmddxDKILNNRMCV4rEFDIBbWAs2pu6uY+yJlBfWxmXYpsQNvuj
 T3Yvcjyf7uLlLanW0DS1bT0xD0WlDSY=
X-Proofpoint-GUID: VwxmcOf-osRk5TWB8M_gS8NeZO8z4DYv
X-Proofpoint-ORIG-GUID: VwxmcOf-osRk5TWB8M_gS8NeZO8z4DYv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070005

On Mon, Jun 22, 2026 at 08:54:27PM -0400, Esteban Urrutia via B4 Relay wrote:
> From: Esteban Urrutia <esteuwu@proton.me>
> 
> There are no downstream device trees that specify five values in the
> qcom,aux-cfg1-settings array.
> Plus, after cross referencing both downstream device trees and entries
> which refer this function, only 0x13 is specified.
> Since 0x13 is written at initialization time, drop this function as a
> whole, and remove now unused variable assignations.
> 
> Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 31 -------------------------------
>  1 file changed, 31 deletions(-)
> 

Indeed, 10nm and 14nm PHYs used several AUX CFG1 values for calibration.
PHYs starting from 7nm don't use this calibration.

Fixes: aff188feb5e1 ("phy: qcom-qmp: add support for sm8250-usb3-dp phy")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
