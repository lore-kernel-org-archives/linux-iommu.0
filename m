Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8175F371CF9
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 22:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782687189; cv=none; b=N5QKI42UDpk6lWtb2EOPD7PMInHJFmMW/rvz/rq9bRMHzHizbtTBv5L7uQYkGj+Bb0EvSeTuzYah1lXDYgv/uW+FziG0nZ6v5E9HJqQ5iACV2w7FVruwm+BwqLCutarFwVAZxn0ladDpDGiRIoUnK3Vj+3YWusK8e/AwBwT/R6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782687189; c=relaxed/simple;
	bh=HNBGEhE75qHKo9m4HubnNX79t3k9BMJ4QWwlRdp5z7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoLTOu3fTjtFgbr81tT3Uu6+LsCNNDpFG3uVBVXLrHsHb5e22aowcLTAw1fwU5DU1+peQ1gFQ+HNyARU+hHLrUNzPbN1QVTEVrrXgkNnBXsH3mu8mtlRT6lVxiX/hJM+o0S0xm6y6FErw+4dxYdH2AiMmgmMAvLmtjTmVCMGZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pvl7WW3d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cdl3qM4P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pvl7WW3d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cdl3qM4P"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SM8qDk936915
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 22:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=08I0qAKNeZ3YtOQJRXgtfOdK
	vyOV10uVclmPREP6adU=; b=Pvl7WW3dnynCredS2uHbctPhs2ZIcn/foX1a5uxN
	zcZHYX+eSKnoreYOzg6p2aFMO0S//CDSm32s8rFWce47yEUHLRJlb+hAsq9D93Kf
	+iNcyG+eJSdIkCnoINhR4J17Es4oWxM8grbCLY9tfO552TGnref0Zd2lUub7vdYP
	/8GQAH3IMA0TKPyW7Ks700CYqm5t9Dz0haO6q8w1eNm1W+vZMCV5PdU9h/UR5NKZ
	ukWrE9kBz4x9OoEDpulG2AjHkNm6NLwPi3xYMphAvhBW56U6PyDj2EXAb+9lfZrY
	0LFQDrk7FlUHB1sMDphSHYUg3lP/0DveF6UR97jSvzug7Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27pf3kt9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 22:53:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92158791d14so337962085a.2
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 15:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782687187; x=1783291987; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=08I0qAKNeZ3YtOQJRXgtfOdKvyOV10uVclmPREP6adU=;
        b=Cdl3qM4PaP4x+E/4tWU+ORD3fK6+w/UiYkB9dilW6O9r65wX6mE4sWMpp6fmFejvWF
         YC+7kHwhWWg0tfnmdABstn4EPGJBmMJb7CQ1WzVQw7PaX9aJhB3IV2L/T+4GNOuBOctK
         3ymhpvMNsPI7pOczsdYwIi5NnFrHD7BwVLL3VGL7hhLINt+rMyWvvrlJwn+wCcg358HQ
         x5qRouteaIKtbop1Fc3Mf4ULbICoWKxqRTXlu7/QhaPxjbKEAXLuPC5KUZNdEGk8xYei
         4rXr/2HUoNz7sb0jOvSdV6nj+twjxr9wnCy56xZkNUJj5jk56K/bjv3clZZljJt5J7rY
         o9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782687187; x=1783291987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08I0qAKNeZ3YtOQJRXgtfOdKvyOV10uVclmPREP6adU=;
        b=XNtqq7V+5/caJF8EUQSV0uTISieAQtmEx3lHlx2aus0cU39+3lepwDm/PwmDfaQRjI
         d7ogi65x76Iti9Ltw8/lNaa7UPybASRAEACwgrO78oDNi8ob6x0dy1+VVvpqVjG0F9MI
         0X89SeO8XK7tK24h1mnfO5rZ3E3UGFsKYQYfdTVw9pSoe+7g8Ve4Wxq/7IAKb1ah8gUV
         FOU1CuXQFfXf4jRDioJCdqAmwVaK8+q040m8E+NFCND6KDSojfXIdxPtK1YeT8Veqd64
         NloESQ58LFzUte7LFdu8D420HllWlv+oYkteG38U7UxNVfNjsNl+Q04qm4x0CjSiHPtm
         rIAg==
X-Forwarded-Encrypted: i=1; AFNElJ/+blo6yVwxXrYxsUO04mIGO72N4fxcY7Ea0McFI3wi7TRVz7gGUu6wIRx5oyWOXQrf8vkVMA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5KJ67Kg6PvptxiOoNkU6aZVLsTknNt4LRIfM+Dhb7YLNU8Hcl
	CrcOlKiUokX/mc8ud+iJkPAxONd1vtqOAXt1nQOaAZ1QAYGklv93bKuxyDOvT9kmDYCLfCrQliH
	fDug1BTz09T0HZgjSdzq1Xl0TSLEZ2iu4BTL2mn4l+PFBP26yK44iSgKYBQ==
X-Gm-Gg: AfdE7cmvOSY8jN8xHXzclfA6GQgKgdCuN1DapmdtqI18/iv8dfgNenPS0y/Kr2On38f
	978NEtZfBuFwuKbYziDZcDUzxpQo6J54TrMvcPriKeyNv0eWdy/k7Pp7sMyBei2DHCz/2ZQtpeW
	Ym2Ol+GNqC9Vm+LLSjMFCsBG6DajIRvzRtTpBHYGA2FjvfsNbmszhUkDv9JHX4PhWAhR631JI8Z
	P0XuxJ8TigEXW4Eumh2TT728DSLuF5KzRq32F9SiJqhaZDF06uN37NL+Rc+m5zU/dOMtFGPBAi1
	be1lTsLIz1HMS0KF/srwVyg6huo3voRgbLKZtASEh6P9oT+HT6Gx1YPlCrkrTnFDxXfhsWfcyEd
	83VaQj2twIR0RYbZMfbmsPqk3QfqKoXL3E1ZWU5L8nBoUfHcAKGvDKOtyUhOegsqO7+GKO//W+J
	snw2o5a1tL/+rZtb3wMdQ1OC83
X-Received: by 2002:a05:620a:8399:b0:926:e8e6:36b2 with SMTP id af79cd13be357-9293d5b1deamr2010754485a.32.1782687186690;
        Sun, 28 Jun 2026 15:53:06 -0700 (PDT)
X-Received: by 2002:a05:620a:8399:b0:926:e8e6:36b2 with SMTP id af79cd13be357-9293d5b1deamr2010751585a.32.1782687186041;
        Sun, 28 Jun 2026 15:53:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999b18370fsm68823601fa.36.2026.06.28.15.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 15:53:03 -0700 (PDT)
Date: Mon, 29 Jun 2026 01:53:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Aditya Sherawat <asherawa@qti.qualcomm.com>
Subject: Re: [PATCH v3 6/8] arm64: dts: qcom: shikra-cqm-evk: Enable A704 GPU
Message-ID: <ga2yyuoob5jcseb5xeeumbnlvsxdhmnrioymbd2bgskpuy5min@miczr3mmgyay>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
 <20260628-shikra-gpu-v3-6-9b28a3b167e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628-shikra-gpu-v3-6-9b28a3b167e1@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDIwNyBTYWx0ZWRfXyQBPL+UhkU1U
 p9MYa6Km55s902PE3hF0WxtHs6MoE9vwP8YutrHHeOuHlbdKkgpPfbKsTZsPuRAEJls0CKrHGtO
 JqBcbXe+O3fFlj2spgkNurBDlM5rlJc=
X-Proofpoint-GUID: 2X9zVFPK1EV2cwkhgkMe8iHKlgnBux4R
X-Proofpoint-ORIG-GUID: 2X9zVFPK1EV2cwkhgkMe8iHKlgnBux4R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDIwNyBTYWx0ZWRfX37z5Py4JHZLO
 spdxEkMXt+k+6xykr+4pgZrtLXbjKkD+mYBfYX/Y/C4FVByUoSbf5vXZO8TW2cYFd4emO2ymzE0
 n2fpA38xmCzEprl8Mg/pHhvgQ2fPVuFipj6oNlpqdUppiugWB8Iva9x8n5MmlZVsWccjtW3J8fJ
 qwr3d0TWrKrLY4BsQtzIF7Y2FV1e9w8T9mGTG6pAJ6QP7m0TIPeIVNmjxUJoU3Hwoi4j9qJSJsR
 3vgcTH0phh84mZiVFOL1LSzO7CTfasoZq13btInMOKk0Km3xklqIresrGZgtYBtqZOl63no/TEj
 9PVet3rFicEyPiA6B41Z/82voMIJHhljYm231WZlizsq/LBxAam93BYfDI2YLUJsG1Ix9avdA6y
 ckN8g7s5wRjIS1g9t9WLrdi91mrJU+593qQhl4Rh1qIKrJ1qGr0VUfXScVDGDx6b2UCi5qds7Bm
 OBrILem7XFiXReE/EFQ==
X-Authority-Analysis: v=2.4 cv=R7Mz39RX c=1 sm=1 tr=0 ts=6a41a5d3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=UQAiW8fk4jwks4S4FoYA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280207

On Sun, Jun 28, 2026 at 11:53:59PM +0530, Akhil P Oommen wrote:
> From: Aditya Sherawat <asherawa@qti.qualcomm.com>
> 
> Enable the A704 GPU and configure its zap-shader firmware on the
> Shikra CQM EVK board.
> 
> Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
