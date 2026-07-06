Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0941B414A35
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373498; cv=none; b=S1gvmfXxSdDypgWBQBTgUMM9qOwB4tXclOlfzFM637AMnlKNrVfHZfkmtwWg6EqcWVxHPFoda9B5Gv6IKloRW3yYg776RyBeF5aBOdJdF27+0n0/dIBBTfCvcsQwqXfwWZtli9Ned6kulBeYSDd4eV88djy367JUzMHQiseoMUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373498; c=relaxed/simple;
	bh=+yJVUqDXTIZuke7dSFRZiIYi0J/L6lEfd/W1u6sYik0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjwxHKoypBTxAJCFDM66ERV4Xm6bXscmA7eR3Fie97xFEUdyNOBlABde/mdA5uKorfU4qhSCsb3tISttnjZVqb5bPXgfC6CTGFxy0fuTQvRAq06I23XBq2lRGMhBnxzjXShgSEqpL9ofdQzZB3PEyOvzDWu04FrKLYT+tvYqv8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g9xRteVh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HVrDbU3Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g9xRteVh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HVrDbU3Y"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KEFDY1639584
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fzDGxXLJjspm8ID6JkaqhKtT
	kAtG0hD6KCQrkPkv4FQ=; b=g9xRteVhP5gefYbx3ff3+GVHkD5/NtiD8aFuBMmo
	LEvcsBjk7gLxGiEeBkNwuOxiiOUkedrQgK/jNGCTT8Qx/jKdOvE7Xb3acU3YafMq
	bJWF4WqKDd9ZtgDi9VlLEp/JtlO0xxZskJUD61UsCA/LzCawqqyrJbadehamQfhO
	ACULbQGHjRHrqnuIUhZjcPAn6C3bZZwwXQCINsSe7FIGkS92zjGhusCelovk8Yxm
	fGKCjq7+om8sGd39x9soMcEnV8RwKpjCysdN/UAlBLVv99omvKFvpQ6DkdoW8d43
	+nMvnk6KMg++WBqdAd0X+NpH4jWzhYoHiEJoJEmv/z0B4w==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r2x34-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:31:36 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9693cc255cfso3423382241.3
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783373495; x=1783978295; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzDGxXLJjspm8ID6JkaqhKtTkAtG0hD6KCQrkPkv4FQ=;
        b=HVrDbU3YWtCr8TpxxyesqE/eXOf39tCUKxW09+rUGABS5GOTl7MypBD4Y8Ss3s0WQA
         W5S0NfgipBf4pZ9ioOqoT27Uw8UrS6YsrASnZaesCp8gI7dS3COYSfwgx4N2QdHY/CYB
         8rViIfhJUvBP18HzjQnkkHBMH6Jc9Aoqt5AgDYcRgCYq+Wr+eHSWAWCsxhwGaagKJFuY
         4uwgM9/vER7QYmYTVBWyUlcRNe2seoOmeuR9xX2/CNuo+1uvisC1oQ59JvCHXnbOhNt4
         bZ16nQHBgRhUPLkmbK1kCapd29kAYAlW5jOccrX4NVkRzoIyFPyYzZrR3oNFrdtZWbv1
         4zXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783373495; x=1783978295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzDGxXLJjspm8ID6JkaqhKtTkAtG0hD6KCQrkPkv4FQ=;
        b=RgRs9+f7xzhKNLFqyiV/SGuRfnpY+2vMQ1asNw6Ny3KtA9aEp8C2+TJwJz7DKbMpAv
         f3JYRZFAUSJXTBztfW5fd9zHUZTZVl1+797hExloJDMxYZxtnCGqCRorUEN8mSuovEo7
         WIPXAib5wBbQZVGJmbhGngR3g+ToUhS8Y5EU4QjD/VzuByLwZ0X4s3Wf4et0I058iiAW
         JqTUYNoXRk0KqJpXI1BFPCJ9PXezFM5MzkDBUbVbKojZUgcrcI542DAb5E2vEpnTH56U
         KptTd8kt6BMhLEj/rvh6jAWUE7GVfeYBcPkm4rphBrU6WczTBJgkLXCNyT6Jv29XkMES
         q7FQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQykORBjms5/Btx6hINVBmBnBbYtn2j7HCWDipDYKCMa2vFnMnEAC+N2lpFVFgLOQSv8yooA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyewmn76e8++N4/fk4ovD0s5OuUQORWb+fwlAArEaXAxOYt1o0t
	9QmRgpkBzKrNnf6My6tqqQQ96XPdAL3zWpevbhVESu/3XukY2FVdy3tehqW8RUrKos0eNx9CG1V
	QFt1v8zqpMrsILwIDrItV/ItVlzl1I6K+hTZrxTLPI2seDtTLOC0+LwXWeg==
X-Gm-Gg: AfdE7clRhTmy3kxQiRJc4lNjd7rQiJZsBU+VYOQ176Vfk1fvgPW2q5M8w3srwEP0pUB
	LsN/5LKND+tFd7lqQrUZzKq/6zB91qegIpfQbIasgUe+M6UzulEzXtLSA9H5FrSTSq9pUeyWM8D
	bePe2cUk8FzSAPYUaiaRUlUnH2Z9+Bl+AyIlQV+eGljBxsbGyuG8OkUmh1VRbura4VNo3Gx6Fse
	WYLoitWIQXZdntqz7c2sGH+ZHlJgpRKl1gEq5iZSA11VFqTUQcQzjEGwU5cgv3x8HL5/H1lj1DQ
	C79nEOMB6JSKjiDsuhxaaud1PjkXvgV5BBg2Su6lEQJHbLcD7Ay3147YT7axH7Ei/0dH9NsgCjm
	ussgeckjcgZOt8bYvcEmMd+ZpgpDc7yzAkidhvtjUsQeRA/MQ/c3pt9/exepSeb9M09/D5z3dMO
	6P2HY4TnEe4eMdARQ/jfMfZ1aL
X-Received: by 2002:a05:6102:598c:b0:744:a3fd:410a with SMTP id ada2fe7eead31-744b7d6e301mr1166750137.14.1783373495240;
        Mon, 06 Jul 2026 14:31:35 -0700 (PDT)
X-Received: by 2002:a05:6102:598c:b0:744:a3fd:410a with SMTP id ada2fe7eead31-744b7d6e301mr1166733137.14.1783373494851;
        Mon, 06 Jul 2026 14:31:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bb868sm3149884e87.47.2026.07.06.14.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:31:32 -0700 (PDT)
Date: Tue, 7 Jul 2026 00:31:29 +0300
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
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: Re: [PATCH v2 4/8] arm64: dts: qcom: kaanapali: Add QFPROM node
Message-ID: <w3cid5vezrofchq7nagu5pzasicagrzj432j3l4rt3ebc3slqw@gvtvxbkkplet>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-4-6ac53de56314@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-kaana-gpu-dt-v2-4-6ac53de56314@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxNyBTYWx0ZWRfX6EThFY25+9O+
 ZhYfhWArJp6R4/jTwRllbDDlJIIIIxSDnKX2IuDubJ+gI6ravYzTHnPLoXhex0tKhnfE8JjvAxW
 FM8Z30qJivsP7aYkUvFHfN7iMtu3XlagPRsbnMoBp03IDmVJopIRme0xI2YBTDk8pSy9Sy1ioSc
 0wM0rnALCP4VMm5dr8eBMiEsggN4czw+h6HzHVl6cuFv3URAz+Orr4qwEuS+9cR5Nu0fkwOr5+L
 jeYhUzLSWlmQ6/8aA3f0CKV56I11kIb6kX/K/kBgIphCMHMUTvWsRsyvNvcE8AHdqS+vgezALBQ
 /xmz530bpB6xUMr5+PgB0zi4jz50D7Lsu+Jk94ZVHTHtNiLLyfroAAVCRW2xEZedtaLp3TaEhGK
 QY3+hD18NoNeuTCJ9fjJ041HcqsNw5dpnR5hf+k+90Y71wUd2KwUfLiXrAIi5l6inWHaUhcWoE4
 yGtFntZHhv5w03dF17Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxNyBTYWx0ZWRfX8RMSrPiIFAxN
 1ggTSFlVlrFYVZtBMzdn7NRfrO0qiznxYaOFMJlB4RVtA2BjFoeu6YnFOBWG+JR+VFvU4MexO5Z
 /sHGSYCiN41vUQD7+A1EqQ6JTLWsCkI=
X-Proofpoint-GUID: _xD0bta5_tpE8kVOWM78kyIfIJRpN7vb
X-Proofpoint-ORIG-GUID: _xD0bta5_tpE8kVOWM78kyIfIJRpN7vb
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c1eb8 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=UQAiW8fk4jwks4S4FoYA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060217

On Sun, Jul 05, 2026 at 01:30:08PM +0530, Akhil P Oommen wrote:
> From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> 
> Add the QFPROM node and GPU related subnodes on Kaanapali SoC.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
