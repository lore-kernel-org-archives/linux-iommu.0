Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B6B3644BE
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 22:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782687038; cv=none; b=flpBEqWb3Na8tBWNSf4TeaaKkSRN+9ZaTVGxTO4iXWQWWYP8d5ygX6xjLwtO7s5f/KQ+rzcMqzwWbbhsc4kIHys2YGhgUQkex/N70NAjtfv7FAC51k3GdOIX7dpcdoQYnva5SGG9VNMesYSL2GlyX6IrTNbimCyS6HlVPUSBcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782687038; c=relaxed/simple;
	bh=Jur/ubW0ogvxkz0KX+X5lU+2n2LljLpFE8n2inLrwdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJzJEqxQSsjUAgkpRbprhGbflySBBct9EkQ7R1wVZBtaM/MrVn9pVa73foxknNpazwWf+UMCP7Z7K9q5W9MqgZ/n+gfsiFBhFXMvlWY0Qjz17E+vOBgQVQOX6CppDjoqaIcGdmuqZMTTlNBOXMSuiPLGE2fMnvMMNE/JVOOn368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AfyvBxRy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=apxPlszK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AfyvBxRy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="apxPlszK"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SM9OQS956396
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 22:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=j+vRFFpc+G0V53boa1pioH5l
	DzLNJAkcW+8BSOZcbSo=; b=AfyvBxRyo223qh0kt1HewpkBVIixQE6iJJrQUJza
	vsmwNGZOG5cYLbBgLndEco7RgaWs0/yUywvC5ebhj6yxuVqK/vIze/f0WziDgmyj
	Uexv0Ml2PkT35spCildFcWgRVwnp8m2PlwPMeJ3X7E7SnVPDduJMqvGJPX4lmy5Y
	8nexKvYyJXWUK22nvWwwt+NJcmHxL0CsdZ2SlWlj/NPro+lH3ogUSH01IWDj9B4i
	PDjSjeFltWdBN8jG2+xCIiNusLf1frOEgM5tLGKsXZoZCb+mMs1byPLLZr3fpyEJ
	fuPmbfafA0PyipaSZ4vDSOfjFoiEI3H6JoGnMP3sQ1FD7A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f2734bspa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 22:50:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92b380149c4so192089885a.3
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 15:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782687035; x=1783291835; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j+vRFFpc+G0V53boa1pioH5lDzLNJAkcW+8BSOZcbSo=;
        b=apxPlszKVGVJmbls1o+lruG96AawmJgIatJeNc4CffI/KBbfNa60avXnz82G4on/g5
         SyfFRmx4oJ7ubjK+6dOfVzDf4uek25oi3WnDWgXdogPF+7Rp2fVleL9sSk0JyQcTRw1W
         txQTKNO/muoQwKsjAA0VGn1mesF/2M8dg7tHFDDp+OLhbPc9rvkUv7IPLuz+r3vyJvEs
         DdOJ8pm3p0IDkw6ic5nWidfmW+NVPUSOok37Rh8Mu9qcb+WRQzDlTsvue04KqNRTGnag
         0cdlYtmLa9XgzgW1iNNZnK7Xpo5tx6HVYprHgMx5QvwnXs268l4DTqEWju+pZdAAelJV
         aEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782687035; x=1783291835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+vRFFpc+G0V53boa1pioH5lDzLNJAkcW+8BSOZcbSo=;
        b=D1habKU89MxXNofBhDFuUOEyEbU2Gv3AEhY1PJywtMqAEhK/r8qbyLMScEzPJFb8gS
         DEWTu20wDVYHxvD6fVjSlfgUCYKvtwSoa6kBxFmTTSRYrlU/+FILkPfHInPQdNfig2Pz
         77EastvQOK/WZuls6O5WTb4iwZWQvrgBLo4sgKpmuXrS0PQgjaJQHRnTIgEfURQ8SdQM
         83ff42x0icSyx3I3/EnqOiQae/hT3sNAz8Ks0TSwQD/yHyI6WscloRo68UZWSUkmxTyl
         Kzvdu67IHbE2R3biCGvtdn8HEMpp3UA2/XR5P7m/lCJtgVTWlUcFKe6BJu7dOw6uKuxn
         1TpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+LinsWac1Nk8d0iF4SpxtauBxmmwlQ7UBPkDvS30dD3suXaHNOFDrZMIdTvV1/m88hU8fpOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyH+c+RwUJBJ6Uc9vCezGNxs37KDoxGg+vLsrZUmT/RvCZSsmKT
	MGqI8yDKvsdQW/o9JowGykSE+4Sy34Q9aeLYvrzkx/qKYEwESzr53SSxCDH+b2dtklG0YxIU3bt
	IZYVA8G/8BBLvRwKj7bcICCEBnkXxmbUPivk4zckK03KgcbTpESi5m0k0Aw==
X-Gm-Gg: AfdE7cli0Tn2sQxvhPc+hvfYCie87wevcN/7HfGSH+KgSOOU6m4YZoOIYG4kMPoKcRG
	v805N02i6C1+91bg/B7GQrHszHC8Qy3eaY1GhRf87e2k7Sq2dqdB0l5f10pX11qKcIyp0/FPMMB
	pqQntkOLJhZz+5XTI+c/gxAEB3XRa4ZI7sQ7rhL7v53uR3DavCz7XRccwL6jt6ZLSwy+LRlBBCJ
	veDtRFQ+z5Q77Tat7Ao7R7gdiktlwhd9VrW6Zsz1nexKZ9fAIu3Msp/MvJWRpLPFAGGS2AESnPW
	ReLNL/zcojmgM568CTDMBLXM9/DG7+C3QMDpMiozgV3eL4PmZ0NR8FvmzPMLNJEKAgaAymFIKPo
	D1j0q1BCOzPFoCZDHz+Vqe7DT0X849C3DMy+42iKwwO8i9w8Lzl138JEpGvljdDC/gCnKCQqfIe
	vh51tqBeOUbwzRqC/XP4ixV45y
X-Received: by 2002:a05:620a:4153:b0:90c:be8b:3676 with SMTP id af79cd13be357-92b3ee65133mr1273573385a.56.1782687035227;
        Sun, 28 Jun 2026 15:50:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4153:b0:90c:be8b:3676 with SMTP id af79cd13be357-92b3ee65133mr1273569285a.56.1782687034719;
        Sun, 28 Jun 2026 15:50:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6957a8b6sm5337343e87.39.2026.06.28.15.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 15:50:32 -0700 (PDT)
Date: Mon, 29 Jun 2026 01:50:30 +0300
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
Subject: Re: [PATCH v3 5/8] arm64: dts: qcom: shikra: Add A704 GPU support
Message-ID: <n3ttyffbsve56cba4x4texugczjkogkv534rjvw643sbqjgcee@iktjvgiqzffy>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
 <20260628-shikra-gpu-v3-5-9b28a3b167e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628-shikra-gpu-v3-5-9b28a3b167e1@oss.qualcomm.com>
X-Proofpoint-GUID: fP83dipT1VsLXSMXMHcVn4eOGkDqMyXf
X-Proofpoint-ORIG-GUID: fP83dipT1VsLXSMXMHcVn4eOGkDqMyXf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDIwNiBTYWx0ZWRfX3y9uxW1VxFyl
 J4TtPtD/pLdfMw2zNAYoR+V533mADakWRfQqJvoUdPFNCm6tOs9v9C8en+gWb9QqE0M/KyTy5AK
 7NuzXKnl3jUo4dnbhVdI/aBaBPLaJOg=
X-Authority-Analysis: v=2.4 cv=HYokiCE8 c=1 sm=1 tr=0 ts=6a41a53c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=UQAiW8fk4jwks4S4FoYA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDIwNiBTYWx0ZWRfXwVqzbDvfjtsO
 2pUX8tZwWLf4W8Yl/pZGiulzV7qPfme/YNCION0q6+/oUPacXubShmu0UcrBogRiRjzV5EflTTx
 QNw0jL6HH25veOE2UJYP4yiZaO9vKtj2vI1fv3XyHZF4zB0r9r/vhByMEDqdG0Z/okRlQAI+RUt
 ZUG8igS5RarTmccyO/S7ZU339s7PL0pDSq6gmR/A127FYG6dwuPeoEK1bqUii4AW2Oc/lB7nAQi
 qj/eQT782g2VLXzaJqpXNIZ0emQIhg4uMK/L8KJiBv+bStXwa1FqzwzHjkBqoeZTRtw48+k9r7q
 3ygddi8hEx07m+fDOYQZg9ICtvEBB8npPX/E411cjPHVOt29sHoGcCiI/fUAJ3LPn/EszvdpIz7
 KRY1Y6Mb+U5LIszJ1E1hjZ6wrqWyUKxIzvWRwb74XHbe/Kvzr7ltZAjbMyy1dHE5fHntwnTCqdR
 tdewxqyC4hqTrncGJvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606280206

On Sun, Jun 28, 2026 at 11:53:58PM +0530, Akhil P Oommen wrote:
> From: Aditya Sherawat <asherawa@qti.qualcomm.com>
> 
> Add the A704 GPU and GMU wrapper nodes with register maps, clocks,
> interconnects, IOMMU, OPP table and the zap-shader region.
> 
> Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 98 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
