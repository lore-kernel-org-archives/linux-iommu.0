Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A675381EB9
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 03:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787024909; cv=none; b=azf8ooDjxPQTMxhsJv9yJXrGibSR8Q4/szB5aIcowYj0u05YvvatOs/PZIaXo5xyF1s5iaCFHM9DGjAVZKO7LVXxETvCztWoAZnA1UgVvNosehwERpMmJIm3w2zLJL1aZvO/B0o/TY7Se2DYl4JPXDJhLDXhTPktRIr3wQvtG/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787024909; c=relaxed/simple;
	bh=274ubsZNFLQDldOL5Eiz3Zl72Xl4ZQjrmRgtjTkbP/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv7NbRljESUEqYFsJwACCYmf4zkzTK+N0mczSpgW6Iq5l9FszehhfdWZGeGmpE3Yrz/eI7t3O2ZFbx5eN88CxaCZy3Oy5uKfEE8CV9DedFdFPEuV8CtAWaVNEVH+C14sENBCKmpS+zolRpHMrUWtJayKkYZdmIqU/CJz8Ej2nC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jrJR1hkk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WwPxcF77; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jrJR1hkk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WwPxcF77"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLkTaD3464511
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 03:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bXRS5rh9jAJP3tYbTw91AwAt
	64eiYAnV5pL1NFBS+kw=; b=jrJR1hkkjxicDvKwYQNE2jU5RTmV0lIIVKelab3P
	UfYbP+Y4otWMjtQPr2NntdzTvuK8Z0twLgKCUklVQZiblZ87nW7yLziXFSAyg1Mc
	SB7i/7uF9kKZC9CeCbbGn50T+BC8BqHuNHiQzEpnFvI/TFbdhP5S84SutqyeQKrq
	qOtTeOZF2GsTpUVy5MH15pluhblIgj2phoVDZypSKrgUgq3FOXSznXWMTgeD/uhR
	T8+JqIt31HrqiPF47XL99in9izUGbiJhINLMAdWJ2X18ysQof9b9HHqpMnsKFdBm
	kmdIBexMbo64W9BhFfWxjX93EwR0BNWYKcOWbN2hjF9kHw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4611afk5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 03:48:26 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-91931144870so534035185a.1
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 20:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787024906; x=1787629706; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bXRS5rh9jAJP3tYbTw91AwAt64eiYAnV5pL1NFBS+kw=;
        b=WwPxcF77APssxygVvvfNWoNcfQojOURedqW93g7miyi6z0SQx1a+HMPmLa03NO8vb8
         eFa2BoFCRIQ4uiFZ+0y6NkAaTPWPb5CPxQyXKi6iX/3BFlPZxmoOMK02W1KTsJ4zCRzY
         FUBr+l96wzjtw7D080FvpvPORNEIVhCF+BP0hw+mG2cZeZYzcr+yAfFGwnhDmXZ+5ll3
         5FOdvYFU9kCKCfJ1mA1tILtHBfEUzvW2K3Yp4qXvhs8o3FZ34Pdg7SExZ6azIZ9OFqD7
         gD0CUMpjOKp2gHXjtj8jQxh+drCkOtzYHiGxhH3+HiRzlLxlV710Yu85Sa14+J1zqGUH
         WUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787024906; x=1787629706;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bXRS5rh9jAJP3tYbTw91AwAt64eiYAnV5pL1NFBS+kw=;
        b=I0a7ietjVRskKDMD35q6gPwtGgEOsApdPdU0llezdJRb19Q2m5alMbLGOYvs2z+0j5
         +q5NA//WI51IFHKLYDa2f/BX+I+yg1fx0UZe+7Ad7Qyv/n1I7i3mSmUJh8YcUfIBtrFe
         qz74ReqVc/9EaFY4K78vNt5FqZbsfdrpJRnjBCkCaE12ePxJK8s9cWawwipk6eEa7K0p
         XUckEWgF36yWwxdTdPP8ixn409VaxAy1Ot9z+9dCFoLTZI6Fm1PvlJ/r49sEO1yVWVPi
         e3UexOA4PSY0y9zmShpJ7Xpd3X7SFN6DqU2l0G8gtqXh3l4sXLC+uwDigEwUKaRjT4TO
         s1mw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6cXuXg/LmX/lLb3oXbntTli5Jd2W9vJD0abcET02ClzepzMHc1Kjw4tPro+mtThvPV9MH6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzthriZ1LwbiFsLDakWxtntQRTwvLrF13eAJ7va9i0hCZy/oQvW
	4git0JRhGMkFU8vaBU5pwatdcatmLn1VBoYbUIJllwV+rJTuixXejjQmMb9Y/gG4V0WJUzvK6cL
	K6ZL7Dkdl6Iv55ry3bxxraNF6FMNiVSXv9H7oMEAzmcGpAM1YBdmXjNLT3A==
X-Gm-Gg: AR+sD11a2/e3AtP6MwfvF87kmVKsaHX8FkspHjj1tRB8H9S3he8jh/5ykYcssXsWNgL
	oig1gC2j5UoUqrwCyfr0AghKPZIeKnpctHgKogpqnrayNaHUrkSChimRzjLN00+EBKLt6WBR+vg
	vNMT4rW0HJS5AOfKHbTsSObOyJ5cX7SVNXh8fMxlkmKun38y+T7Mk+iL7jf5VKwUrYSD8KFasjS
	47rFIux7WzsKK1C8o5ByCJUoAthTYe/SXB/TUBapDuR6lB98sCFavTH/oEK6X/94vys+2Dc6zM4
	Cly697ChACpwHwXJpC4Sfb8K+daNolX8JKLy7CYRapgDmWuY6fXFVU0QmmbHywOdRYZalUyJHc4
	TrsXjAjZXe7NmtVNw6xfBtwDDg087iSNFV0orBGYB6AXeNVk5xR5RsVAZnii0oIs5/U9jtYBAt4
	FIuzI3tF+9wjZ2
X-Received: by 2002:a05:620a:4153:b0:930:fad2:fd with SMTP id af79cd13be357-93704b523fbmr526537785a.17.1787024906261;
        Mon, 17 Aug 2026 20:48:26 -0700 (PDT)
X-Received: by 2002:a05:620a:4153:b0:930:fad2:fd with SMTP id af79cd13be357-93704b523fbmr526535185a.17.1787024905805;
        Mon, 17 Aug 2026 20:48:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46cfa0e5esm861092e87.25.2026.08.17.20.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 20:48:23 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:48:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 09/15] accel/qda: Add DMA-backed GEM objects and
 memory manager integration
Message-ID: <pm5yr7fovkav4cuat5zqn3ngf2fxzrqutsgyaobwp5djv4xkuv@in7n4o3x3x6y>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
X-Proofpoint-GUID: TY89GCBd7q5fpRdMuiecGaLS7ExoKSR4
X-Proofpoint-ORIG-GUID: TY89GCBd7q5fpRdMuiecGaLS7ExoKSR4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyNSBTYWx0ZWRfX8GBCwRtr63TF
 cVHDQds5TiUcJZQOVi4eeF02TUdrTUYK2690xEHlRaBXoTWRHWH2xS+plpToFyfBukcI3Gld4+q
 OZdLAYUe7FK8cjKAMjaHjWhTIU8hWJA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyNSBTYWx0ZWRfXy4SrBi6r4AGH
 I01YYptbWBv5yxt6S2ZCdM7CSERxXjAVzIY4GRQQOIuFzHzzjB/lq4nTvRJaNYVZoaxbPPjA3EV
 XjdLKjfKn9zcSTKxnFPb6QQz+KqzQTDyxDCkUF95MpBXdJOneqr1GTBVtq4TrKKxAklZu0uqDIc
 7TJxvP0sT9Xa4jnfZtUlDAo/fdenJgwolOK7LR0M7E0hGT3/Q2r0TDcABM3ugnubBs8rX+McVXN
 uHglvgC3JV2GqgkIE+KI8wf3hxFug9G7+I4JNThemSIKF9tJ2bRJpB17XLO3ANlA3uc6YB0TsmQ
 rwx1dnkDevgimKAmt13vwFHaCu4umLvK4oYP01AnveYl+2Dkuk8Tjj12WkOieU5op2nEvIUfH1J
 lAgV+qyh/uHZN9DYgKliPaDYZTLop2VvjU6PEM+kPWdG1hUxw+3hxP/6BCgzoN4TIwcRCoMsRuR
 2kKg0qfhe7LRBQINjHg==
X-Authority-Analysis: v=2.4 cv=UslT8ewB c=1 sm=1 tr=0 ts=6a83d60a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=biWI9kQzUyu7Ho-RK_UA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180025

On Mon, Aug 17, 2026 at 10:17:44AM +0530, Ekansh Gupta wrote:
> Introduce DMA-coherent buffer management for the QDA driver, wiring
> together the GEM subsystem, the IOMMU memory manager, and a DMA
> allocation backend.
> 
> +
> +/*
> + * The DSP identifies the IOMMU context bank from the upper bits of the address,
> + * so the stream ID is folded into every address handed to it. The DMA API only
> + * ever sees the plain 32-bit address, which is why the context bank devices are
> + * created with a 32-bit DMA mask.
> + */
> +static dma_addr_t get_actual_dma_addr(struct qda_gem_obj *gem_obj)

Let me propose a very simple rule for you. Unless you know what you are
doing, all function, struct and macro names should start with qda_. The
to_qda_foo(), I think, is the only example up to now where you don't need
to have the prefix.

> +{
> +	return gem_obj->dma_addr - ((u64)gem_obj->iommu_dev->sid << 32);
> +}
> +
> +static void setup_gem_object(struct qda_gem_obj *gem_obj, void *virt,
> +			     dma_addr_t dma_addr, struct qda_iommu_device *iommu_dev)
> +{
> +	gem_obj->virt = virt;
> +	gem_obj->dma_addr = dma_addr;
> +	gem_obj->iommu_dev = iommu_dev;
> +}
> +
> +static void cleanup_gem_object_fields(struct qda_gem_obj *gem_obj)
> +{
> +	gem_obj->virt = NULL;
> +	gem_obj->dma_addr = 0;
> +	gem_obj->iommu_dev = NULL;
> +}

These functions are called only once. Inline them.

> +

-- 
With best wishes
Dmitry
