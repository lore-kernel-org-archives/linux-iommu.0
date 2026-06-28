Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC76B371CF1
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782687002; cv=none; b=J2+Rj4aIArVLG7v9ZouHrygNLCzf4iDHptjC79+NKLeFa50N2BAQNAww5N5EYaUXMDYg0ZgzLA9csGaaYJ/pLXuEiTLQIUVKcQwhWQgF3i1G/de2dqXeA6QvSp+dwg31F5GCmiCQDdJL4L3fYqeAmaBNGl/b5jth+FTNJXm7pf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782687002; c=relaxed/simple;
	bh=GZxYSfE4fIDtRxdjBvmjABfjxCxc7sJWSoAYjE6KcOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LC/y++Wzk4Hb9I9nFDbipn5ZEnL0kO+myXmYNWDRcaz32KwYtv/dqvtHyrFBVkboCRXKciJc/91pJUrWuKCgwFAh9lQzSL5RynS0GzlJcMiJbAqnxte1IcIZkTd74YQeVaMOEUs+yhi04G2gF2A2VNeS3wUQFoFHOwbh0sIFMZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TNgb6CGJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WmVByT5p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TNgb6CGJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WmVByT5p"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SM97OW997859
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 22:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JYOeB9wXREvb/kPXlH/uSBNj
	P/9Wet3bk3Yudk2xHjY=; b=TNgb6CGJ1Q0zM/RkqqlO050O65PgXwERKDt8KdQH
	HG2zEfeMv9xdcLl4NAknubrRRPHSLUzNmEP9U6pqJ95hCaHPyjibqiXsSKOo5sbL
	cGdaN+Z4bq+WYnT/zT3immPtN4qTYkqW/luUFJJQ3kBb3rSfgGL9X8uEtX7UaNJF
	zAzt4+8XMg/2tFwVnZaqyq6WgnbNRvf928hV1p0g45fP/Xaf9+nty0xC0UdVtEQP
	xi2MX8a+zibiz7K82RGUnvX/LoVPSeQFvhzoQExiVTCFc5uI1Yq8c9luG6lcyqFa
	QbmXJCb8wV+D400Pli12Cku4keg5bts2SAbjDXLjqJFQZA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tuurwx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 22:49:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92af3d5e85aso564257985a.0
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 15:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782686999; x=1783291799; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYOeB9wXREvb/kPXlH/uSBNjP/9Wet3bk3Yudk2xHjY=;
        b=WmVByT5pEYHveEqXLyjuSLoMMh0ls2CeoOojOy+7K+9mQrsK8+4sSHUd77IMuBEtE0
         b14Skk5nNufgzfoMr6XDQgdduuz8FBi+K2Cw+KGAl1H6frOs/32OSJxrDqYlNV2fd5tQ
         DZmDNGSfvRkgg6euwlTzfMX95Zcbrf8z9bb8ExuM+6pzzep4phfBfQ8Hr+xbXKh8JMRu
         wS0Ld47t1J4U67KhzJ7P96MrT6AObk91uebw4k+W5FFhZNk3vRRDjVBlP0oU2sXb1Va4
         gCqS3bnLy7mPsgddIXjA4If9BVwRxZD97DvZL1IjYGLi5uMoGwpeyHmPIYU2Nx+MPQr7
         o4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782686999; x=1783291799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYOeB9wXREvb/kPXlH/uSBNjP/9Wet3bk3Yudk2xHjY=;
        b=Nua9TsUhyYYQ9sqFX2jU8ZLh/i4QZZg3zwcGeeCvBTfG5mKKEfXEC8n8xyH5O5K4fG
         Itc3c9atvYJZBTW0eIq5v64Tn4d6X0lNWh8YrvJfVUhSYVAHZg4jDYpJjBg/uD3Elirg
         DDOHKJozPYDvZ7wCzL8YCshGg8BDVD9VR2I2jBcUyK/oO+4ote95YDVLyqq4FxsewGWI
         ZAsY18GQate37ht+EtqwhKqAq2IcVgnNapv6oaxp2nRLlyzUpWgYNp7kH4C/v3REZR+P
         iJ2wqk5VeAkQ8sAsmVHDDe+aRbJ5BoeQCn8wMhJ5MkSpig0RQI/4tS2lfXe5Gu1DzPW7
         8o7g==
X-Forwarded-Encrypted: i=1; AFNElJ+2okzEhfpiugycCirMs83hu/ExFvEIS2Esuo6cioAsHV16DtwDKvnXG2yBC5KT8rIuWzGzZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgRKSD8BF8jUDmzY1BL1eiiA5tLxCH6ajoYX4HySCgXAbgXR6h
	lCZNkfg2PP/3xZE5TL0YRKlp7VFwCYOQG6Go/vEusP9nNsLpm5n38q+C374IXJy+sjtww6KAeza
	1DzkyquNUY4GcIsKvAK43pkFZsdBjTVKTw19x/KhoEsD182RcNWLH9gYltQ==
X-Gm-Gg: AfdE7cm0v/QUXb93g3iyDjD2Amk7P2wdgXAnmatKqsRp449ia4pkGaJZSo30Q3XQeN3
	WA7BGkBYo4db3uunNF7VGhMEBooOtZisByJAxD4SuuZLR8WPIax/qkKr1MjYYJvMSOqD1szsVZ4
	QJ7vGo7btI0IfaqRHbzU2RiQ26lP6wDmG32nXZhiX+/aX5MIDREhTqeMQrebMIMbNBUoKxVSo7E
	I8k329cwPDag1dc8s52xSRj5Mj8V6lJ6bpQVlV1EXxJQkbMckInLp5Z3Zu01EhfNgu1vAZI81i0
	FFtYj3sFeNa+Cf4OrwHoWnLSr1PJ9mOgUoyH3FDo1XksKHPX5GGQLDA0C/Vb9sNWYvs6ZkQQ+Nt
	fLfHAHqt1bfgwTJ/R/ESg6g/hOVtzQyUYsNpcVh+MORDGN7XNyCtD/d6K/RZMYONgzzycHrY2oH
	WeTvBvu8wuI790JDgVtvcg+Ka7
X-Received: by 2002:a05:620a:19a8:b0:92b:641f:ea64 with SMTP id af79cd13be357-92b641ff8f9mr1205793285a.35.1782686999071;
        Sun, 28 Jun 2026 15:49:59 -0700 (PDT)
X-Received: by 2002:a05:620a:19a8:b0:92b:641f:ea64 with SMTP id af79cd13be357-92b641ff8f9mr1205791185a.35.1782686998633;
        Sun, 28 Jun 2026 15:49:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999afc749csm74899421fa.12.2026.06.28.15.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 15:49:56 -0700 (PDT)
Date: Mon, 29 Jun 2026 01:49:52 +0300
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
        iommu@lists.linux.dev, Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: Re: [PATCH v3 4/8] arm64: dts: qcom: shikra: Add Adreno SMMU node
Message-ID: <ilwsmzpebxsobixd6xwgkr2dajsza3dr2ghcxfig2m6vhcamj4@but7o2rxmmrr>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
 <20260628-shikra-gpu-v3-4-9b28a3b167e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628-shikra-gpu-v3-4-9b28a3b167e1@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDIwNiBTYWx0ZWRfXyT7LqmRvhODr
 t0mzgZMSXiPdH7gOqvhNGtyaDTB56Sa66VBSfb4KsCz3D//nkWsA9Z/yUSy+HQdSpdPGfz506Rz
 y336917+3Pm9kg6UefdoHFIWtlyZvXc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDIwNiBTYWx0ZWRfX1Q09V+ltkNmR
 /Bam4mlBIllnIdugz+qMpPWo1jnkPL2WsfHAC4uMn+Wtry0GHXAkAe2Jj0kjOYjbq8YqG8t7K7c
 wJrMLtVi6gxkhHizhC6+c1BDkCUeYD7yqcSXRRXICgRxV+7yO5wAudCHKHd+PQX/H/DUYFcm8ib
 JgPdFsUkpyiw0Z9fu+uMO7yisvmdFyPDJ3EERCjjhrCV00wlUxj0+Ovj7xtLMXhGoEKsxCRp+A+
 LZCHycREWA3qUb7rl8jQBcSng6/H7Mwl2vjUHcESl52vrUt+jg6nuydUycqFN0v+3R4fiLKS0pT
 ZrZtTx0sSI1F3agbLU4JoMJfVOTtNG1s2t8ezJbvMIoa2pET+YfGi0qinTxp883Digckf1Nx9G7
 KTxoisl4oQ5CdV41lslsZavhig981aDbt1EReULtiW+0aUgJo4SNwrcEcaLtBb/BWbaLbBZBScz
 QD8IpdP/1cI+mtVcYpA==
X-Proofpoint-GUID: 08rCP4cSwUpvQH_nbvZLE_4wJqlSdc7j
X-Proofpoint-ORIG-GUID: 08rCP4cSwUpvQH_nbvZLE_4wJqlSdc7j
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a41a517 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=CtAqrJV6yErwifH23rQA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280206

On Sun, Jun 28, 2026 at 11:53:57PM +0530, Akhil P Oommen wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> Add the Adreno GPU IOMMU (adreno_smmu) node for the Shikra SoC.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
