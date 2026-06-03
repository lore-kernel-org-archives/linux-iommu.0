Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC9F346ADC
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492773; cv=none; b=Mw6/v27KpU86UTrKt1YsPCHQGGF8ylJoIYEmX48fB8aTs86rjCtHhN09LuGXsVdrgRmDXiOuiMJe4kBdtVb17WeqwnxHNWo7Y/apotg+eRsGcRoul5LYunm4TJk4WlhmxxJOw2NqVwH3Qx0rlNAiNdesc393uhWkq3zNFvtmUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492773; c=relaxed/simple;
	bh=1nBMSmHkUb3Jkq9JMXc+5j0fs9PgAQlDAMdQSLgzC2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRMhdkOMujoKAeWJkQ5WKM8LwkuXHzNDjzimYCK3dbieaUuEWgCdyWpe60cCU0SnGdCzLQ5D/gd+5YJM9knDHOxxEg/qniSCw/kDfXmlyC2oUTVnbWncvBSAzSEW7/Phly+AdP6DOPYUwO1UruvFkyyjC5pG1MFRqhU3+W2aBYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aIG5ks45; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fz3+kmsp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aIG5ks45";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fz3+kmsp"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65395oSX780679
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 13:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZQM1x4Esz4yRdbII/P6eIDfx
	ohTjz68+7v0muOP15vI=; b=aIG5ks45N2mu/zbkGH1OWKWZrUSRPGfglAxBph1O
	N8eAVRUeYqEK4rzaIELDKoX++7MJL8iXsmufopxacx2HgBBiklHaXsapgrlEsaWn
	G9z1nEZh1zbAvUVE/4n/oxBNA+5H5AhrOGjQz5g9u24yzBFv5NDeqyBFqM/MkrrM
	N9WAs/DAP7xWnzGRAQGg/pCIWO5TaPEnOO7HQ+VmtS0EKmnGV35iXkiz3nb1Wxrk
	jDMgo2aRx9PqYV5oV2UabtP1laYDh4gbWLV1n+QsXrmj/01TNEJdeRpSu+W65C2s
	lv6jnttT/K4Q0XfFeWkfSRKVoROFz7c3rNxaKoDRnFIwzg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejhbb0xyw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 13:19:31 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-963d7e5ac77so1052542241.2
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 06:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780492771; x=1781097571; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQM1x4Esz4yRdbII/P6eIDfxohTjz68+7v0muOP15vI=;
        b=Fz3+kmspdGIsdjzenygP+FiDns1FFvUweicNTb3XeeK+bpEtYujRmO83nCojjh/9Bj
         Cdc6SYaU51mIWKFyP1+KiGSbcHbCemn9lJqZSJ4x1ghk49RSCrJLXsQF1HBfYxyRO/UM
         JJjUj13k8pRRCJpSUmxxP8dAbmzunRmxhQHBm2Xy5mHvTSuisO2OwrpHpL4lUUszs1Ur
         4Hrif3JjUI+mfnUICsEAxAguK5wfy27GlG32CrCMh9M/dwShIR4jEp3lQwiL5VT2iaFx
         7AEyq4v9Pc8JWsNK58p13p++Z3QpVeAI3i3B61tRRrXA6GymQjJNCH9/OGYFGTFEh4L6
         eZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780492771; x=1781097571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQM1x4Esz4yRdbII/P6eIDfxohTjz68+7v0muOP15vI=;
        b=O08Sfg/D0vDB8difOieIKRDqSnkZrOPhTP/Z5mfsTgJn0+7uS4fOou6XuHEom2JuUc
         erE9dV0nJVI4WnRfNFgGr3HNm604Hs1nAFvT+eqtxCns/HNkmSLo4NrwoXeoxZYc7Ij/
         8hSS3t12dQiQ7pOUAMSLC0K+iP4C5nio9nI+8gsB6M/0oajBleFnuYqCYwkKqIPu4Dqx
         hTnOcXEyaY4l0YGTeZu188csVrkoAaiPmN9/JbpGolH7QcQolc2JVklQw5t5XSdRGwle
         oSzsuqBzBIKoaGEmGuHAgKbwYz3jYhH800LfIii/o92eOv16MrEeJc1PX/Cv2cEPiZoS
         AeFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bieG5b+7u090yjAzqOViClhrMTpceWlQivkK89fMUrmsB2mZjt02CdHwWpmUue0aBngFNzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YygJdP94ZIjBamBCyMz9D7IAztuHeqyGhQaLOiHizeGwaQtwuvL
	6Qs0LbXavE/zFb0uoeRvhoErWu7NPxTKUD7qsryLQOHodUe2vUV/scSFPqHepyOWP8P4vZ9AF8Z
	xNI5YvvTXCt3Q6WXqvf+hXpNWyiWFYMCsLeI/LOuLnxoMbI/OA87XgPmEpw==
X-Gm-Gg: Acq92OH1nD1jlN6i5LdGYNW/3wD1DOgGv6MhBafhW6XAUSlvNmfuEaJyA4RZCo8FC/3
	JJBqPfU/LBB050W/7UlWZXhGUaZwPlI8mnbF4sumKH0AM3tT1Lj1WxIFJw21lcX93IqblmT5xz+
	lj6RgUeF9M7BDfVemiyca3hbl3VkUCmLtHNi7TVj9HY3uXv36xmJzNgIZp3L7ZF4HyZc8/XO8z6
	+C1vemLIqNe3lQDzzeZXo1D1fXbRe/YJukM9Ygd55rIP99QNmOq7/Bxv0GRMfJzFtgLUs6C2JJI
	YqbT7EgzwM34HBsflXaeEbzbz9QXCJWNDDi1EZlQyQWq/KC56cUiwZzIx44RnNU9/ShjAxJ78zv
	h56VUC903UQIWzefoVrxv4C0AssMio50cMNQg0EdkmelUPZ6nHeCeI6Qz25Go3Gbm9k7v22JdDA
	t9gGzakE5MquePW6LYTRU8zkPQXo2HyP71yCKnfACJso8pZA==
X-Received: by 2002:a05:6102:9d3:b0:631:2f82:c3ce with SMTP id ada2fe7eead31-6ec2b92f476mr1386563137.10.1780492770610;
        Wed, 03 Jun 2026 06:19:30 -0700 (PDT)
X-Received: by 2002:a05:6102:9d3:b0:631:2f82:c3ce with SMTP id ada2fe7eead31-6ec2b92f476mr1386534137.10.1780492770149;
        Wed, 03 Jun 2026 06:19:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396abf678d7sm9164781fa.7.2026.06.03.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:19:29 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:19:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: MINETTE Alexandre <contact@alex-min.fr>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Linus Walleij <linusw@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux.dev, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] ARM: dts: qcom: pm8921: Add USB ID extcon
Message-ID: <xklnqbeuf4gblh3l57cfpd2xchfy3rug7b37f4redumfsl4g52@dh57ssbrhaz3>
References: <20260427-mainline-send-v1-sending-v2-0-dcaa9178007b@alex-min.fr>
 <20260427-mainline-send-v1-sending-v2-7-dcaa9178007b@alex-min.fr>
 <20260428-jumping-discerning-oarfish-d2caf1@quoll>
 <50c433df-d737-45da-93dc-76d365052a6c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c433df-d737-45da-93dc-76d365052a6c@app.fastmail.com>
X-Proofpoint-GUID: Rh7obSzZtcZWFIigUofOPuVyhD17t30i
X-Authority-Analysis: v=2.4 cv=R74z39RX c=1 sm=1 tr=0 ts=6a2029e3 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=AvYuMi_7Bs4finmeaUUA:9
 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: Rh7obSzZtcZWFIigUofOPuVyhD17t30i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEyNyBTYWx0ZWRfX3vEfAuIEeQLb
 5m4hpeqd426RMaZynedC9/AQiU4QIkkmbqQzJLGBQfWqbWHtIV7QgEudR/DcXcaxL4yMFh42a8o
 hsaxkqYWCEer6aj9HDaRqoiZgKt3zWMnALnbIPgE5MvfyKiDNS8cCWh7VKeHqym+p8yC2KpFIv5
 /zyRjCCLfOY25sCKrhIWq32qg0OqNGLuJoDVogq2bHFVAKpKbaqKqMr/+ba8v3U7Y5DxFoBv9Mm
 9fj3/iXs7Z1JlVdunq29974bANcrY3lAiz/ArgFIUTYnAqUuLJmyapW9z1T7NV7nQhb8UL+HqM0
 YsWge2+8qpUMuvNRslUpGOTBUWGWY0pDqjXmk/wagwoH9faGC8XNwG26u/W4qadrpoQi80TtFww
 eZXTP5fqoDj385t2sSadEUeuOfp+PzytxmWEVXPVnShq8JDZjcBjSFjvt5gjLufvQtwargG09ix
 d93GqKbusGipqjmFQ5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030127

On Wed, Jun 03, 2026 at 10:39:24AM +0200, MINETTE Alexandre wrote:
> Thanks for the feedback, Krzysztof.
> 
> Do you mean that the PM8921 USB ID handling should be exposed by the
> PM8921 parent node itself, so USB consumers would reference the PMIC
> directly, e.g.:

Please stop top-posting. Post your replies under the phrase you are
responding to.

> 

-- 
With best wishes
Dmitry
