Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66A4071F5
	for <iommu@lists.linux.dev>; Sun,  7 Jun 2026 21:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780868919; cv=none; b=OooeZRZuCOw0Sv2hW2AXABr6wah7tDNfRzIUd7jBdLjEUry8Tpw7cjQveTpOrnMT7dr/M06yeH0y4S+q5s/MfMqH89hc43jOMSOX7neD5CmpsQTECszw24xjSkYrldE9Qftm69BHEQpRqgx1Wpen5g8FmbFSidh7cTOvHdTxotQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780868919; c=relaxed/simple;
	bh=ILGDiyBEsByOArbZlYQlWsMFoQKUuCbBihFkErQKjAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq6rZoMmGO6rDaiatutLY3cTFvQ08XL07/W8++nUqsm4AfC3J7+wpEv4EwSO52vhJrMjbdxTXuPUh0qsGMhpSZQp+CjsP9BOsXSojlPFo3qnKJxL0Rxb+2hBoa5A1lOfIF/Z1zdiI+Aeh/OjGcVjNYfR9tFY/tBgI0+Afbu0fTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o31dCwrl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ghQpvOs4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o31dCwrl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ghQpvOs4"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657EknZH337467
	for <iommu@lists.linux.dev>; Sun, 7 Jun 2026 21:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=o1R7z3tNM5aYb/NUqCfxowaT
	LqYwFCZn/Sdm9gTMZJw=; b=o31dCwrllcRSjxrYsp9xT7mw5iSnDJd1/XUwA/qb
	pjD0ZCyizmJXpvr54oR55PxQ48xH9I3GL77WHFMZOl6Bk0hbr/3w+K6IAN9klip5
	BJuzV9wx0CGLgkocLCtIhiV698S+dFCzu/qLhuIGiw33of+5hb5AnJGXn5mTiPeD
	3ZL4j8xbhLUUKuxEYkJI8diiOesTv7fIYzXkjjrJF2Y9yyN9KeHyp2E/ls9w02pN
	CnHfmibEFRba4sGZrqxsHMVbeIgx2Tn+UyPhZc+u+6CIFFMXm0INcjry4jT4ynK+
	L8C8Nn4MpaZzoVHSQpWGn+lsxwDH4yBvxNgut6GzRh5D/w==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgvjd0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 21:48:37 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6cfd2a26ab0so1543441137.2
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780868916; x=1781473716; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o1R7z3tNM5aYb/NUqCfxowaTLqYwFCZn/Sdm9gTMZJw=;
        b=ghQpvOs4aQf7+b4iGTTYMCdy//UvEg+H51oaR7sOXATdkvgonj4C/6TB8l8xlsqvAb
         uFnWw4sNw45OKIxPITasQTx4JrvHah8pRlJHuo0hgzBr/DxOxnN/5qxqSGwWWSWpfcUM
         E1vLUtvISmBQrZXvQYQbLJJC3ARiOrzm80oKcd1IlD08hjNVTOw4ppBrJWOi4PQUrkzm
         c0QkKc9OXo9CfhRh49nTdHg804wFs1rvpKZUZpeXaetMkwZ/RTePecjqPzN+8nrNch03
         aw2bSSHTFVAUZbu9n3fxiVQ02/YHBfiXh8tn/JO6EUjqlsEwDxW3pW/VslwN3D0UU3O5
         1NAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780868916; x=1781473716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1R7z3tNM5aYb/NUqCfxowaTLqYwFCZn/Sdm9gTMZJw=;
        b=SXLo0mX8CxdJa6nsTKejy5nh8vqDxrHRJb03hu8APaNe3PHabd8a8I+XfmHy2XILxF
         IdZENiic+odiMBYac2fLLjyWmfDsE6PwtSzB57VxbdZUpVEzSdlICpvouln1GZu/8Mzq
         OIEtw+Kg+n/7sKhU5EfJr81NwCihgbxRbqQl6v+5epQWZIPi8CgkxVmlBwR0YM8lt9wl
         D1UpD2syWJBDHpE6YWWz3+mWsrCEEwwpV2+WRPM7t3f/hS49jzHX44XkbGYYtOwc3PAu
         qeQ4i0pKjhfBjDlm8R0R0ADCbMjXIZN31pgY31wg0MoWhgkmnwViRVVNM+8j5sx+jLOl
         ydfg==
X-Forwarded-Encrypted: i=1; AFNElJ/k9ulYxcuNZNd1+nNqIQ1N5RTyyjaKRpAbsOm5Y02XDwReYE4YFa0uiWXzZVH/lrEXANoP6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDEWfRecaIeJwbpRYQl/iZyVT35IiIVnyGoipLM4jg22gatNAS
	Aaao/5Ts0FlqAFVpa4Gs8Be/CzM9irgDHwxIFreUO1xM4LoA7MF0VXqi/qk3r7t+EK/pmLIv1rY
	olUlpXRZ+ztbmFnVnWRZntE9VEABh2nYNxlEnpHXvjlAAVDnp8no8opx0Xw==
X-Gm-Gg: Acq92OEULmKLEfHevxKVgHRNITyA7fDaXb2VowSjP25xeqsdmkZEdlRxrIjinAismMV
	6n9AkcBLVTdn8eoraKUx3q47clvSXWI1BlRtI7FFDl+Oe7H0z+b/HbJamvewqdvOaIM1EYZ4lJP
	3I9MuK1fLyDrsBMxuj6bVEphaFt16vIj8/mQZRfCJH+fo85hTTZ5A9Wr0SeUAvqh8uZOzA5wrg5
	En9kuJPmjzC7YZCRTwLhaNdFjUEX6dPXmPU/OfkOa40tdMua5te75Qe0QBta05krzNwVXY9NC36
	kCtnRpsBC5OwRyvYJsinY1jlyrN5UK4uQnTHlQe14dWK4hlTYzj902IE3tWd1cfReHN8dnqF2po
	+xzC8mtBw5CL2TMVHus1JvUk1mpBnaLbG0hcGRKYnTbb5ucpjW38UIiyYmKh3bTzdi7MtezXDI5
	7JnBSsRiOmRYbeQGfEZ2P9mLXLxA7/aBrr/U1UI2yJV90vGA==
X-Received: by 2002:a05:6102:5094:b0:608:9a34:c8ea with SMTP id ada2fe7eead31-6fef9971468mr5613934137.10.1780868916286;
        Sun, 07 Jun 2026 14:48:36 -0700 (PDT)
X-Received: by 2002:a05:6102:5094:b0:608:9a34:c8ea with SMTP id ada2fe7eead31-6fef9971468mr5613927137.10.1780868915837;
        Sun, 07 Jun 2026 14:48:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fbcc7sm3322124e87.23.2026.06.07.14.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 14:48:34 -0700 (PDT)
Date: Mon, 8 Jun 2026 00:48:32 +0300
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
Subject: Re: [PATCH v7 08/12] media: iris: Handle CPU_CS_SCIACMDARG3 register
 write via program bootup registers hook
Message-ID: <u2mabnpmsql2mfnonw7263b4eb6wpzfdkdmn6q5gghutz2ir2g@ekr3bdwxa6nv>
References: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
 <20260603-glymur-v7-8-afaa55d11fe0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-glymur-v7-8-afaa55d11fe0@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a25e735 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=bJ2oX7-cLgL2xx1Iw9EA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: iqG_6sycYHKgOiaZ4m2W5BSXtFKT17YM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIxOSBTYWx0ZWRfX684VSGbObc46
 WxhUpuhcFtxjVHTYqh/rhpkpRtDAKlHwQkRYlq0OonqkshGTdBGi6A+btdppAINNr79t76RXLuP
 33QIeXNxwLvkg+fk07zf7ffdRFNMa+gw650Oe6glU9kjdU42NhKRYuPDZmJNToc/u8P1bXzr1IV
 So7xRY4ViIUyEYXckw9nGp/mVNPKG9o3jJeZlHWsBsx8a2YOadj3gsnCJ0i3Z+xHNLUWiawh7Kd
 RdxVTgAM1gPXlZG88D39CNryw14QXA4zezCRMKFs3NpUnOebSAWbT2G6P5EHWhZds2j4eJnjSCX
 AOgTuRD8eW2QHhpux0Tk1ij/b66DNXuu1ddkE4Ds/yEc7QTIzRwGOmpVNJOG2NCETzNAI56Mt+8
 A8IuhqzDzh4t+mkfwgD8F8if+tu9kRIC5bv6CNGpporOChqrjCZ09XudrIYZmWU3CeMNwsv56x9
 J0ptBj9Eq/nHCEXXM7g==
X-Proofpoint-ORIG-GUID: iqG_6sycYHKgOiaZ4m2W5BSXtFKT17YM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070219

On Wed, Jun 03, 2026 at 07:48:46PM +0530, Vishnu Reddy wrote:
> On the Glymur platform, the firmware reads CPU_CS_SCIACMDARG3 during boot
> to determine the VM count and increments it by 1. Writing the default 0x1
> causes the firmware to treat the VM count as 2. To avoid that write 0x0 to
> CPU_CS_SCIACMDARG3 as a Glymur platform specific.
> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_vpu3x.c                | 6 ++++++
>  drivers/media/platform/qcom/iris/iris_vpu_common.c           | 4 ++--
>  drivers/media/platform/qcom/iris/iris_vpu_register_defines.h | 1 +
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
