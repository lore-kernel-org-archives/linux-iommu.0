Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2216B3D16E4
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 03:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787024548; cv=none; b=opSc/GHlfe3UfzyntmcV4OHo3G6BjFahhnszsybI4vFZCnp/jfvx3vYVedglRXm6ktVc7/iIKC5rqOeNMlZMzv4YR1Bbu09CFJfLLWzHUAOQi8cqf3T9ypIFCpZdXj94NvlbkMMfMgLPNTQiNLuvMiLxH9/FdTO9dFaU1JyZfwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787024548; c=relaxed/simple;
	bh=og0nH85CYCCGni0xB/xCMYW1Oun84u73xVvU8oPwK0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi3sAr8C7EPyQnfX2Fqh/14VoglW32c6qkXO8T7LlGyMdArE8T2Stb/vZfmYqjT1Ex/DdclbxWTxMayGsza24L0MGIBd4MH9J/H4CQ4AqkLUyBLbRE6oI0dYVpuo3PHOqIQhsT8wi2t/DWaZiRCzNPN6OgIn/PB+Q8+/fJ7B0IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R1GwYAHq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JVb+VFwf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R1GwYAHq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JVb+VFwf"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I252123602875
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 03:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MaABp0/faTANtVcerTDacDQd
	lb7pXZWcETU4q2gt11c=; b=R1GwYAHqL8EDVwyhfRXBq4LeLrPDpen8Be1zsRaX
	XWcXJhOYiY3/auiFO2HbPN7yF4/QJ1KCGEOCw2iLndJ8FVKA+nADhGeo6qst9tCw
	P3bFDv8C6VafbPcV0gPjV9IFpHGN3JqVvHk9x+IhhVNlqKzMiJIBVw+35KXmZDnc
	/Wx9GiURAGiOU2T/DDfWSEXxjbRe/D0ZLTE7nOlkauAXfJpsBi0ykiRwhQ94ayEF
	2sh/eLmcHZLqo1qTPNCjzDlHIoNoiHOgAFOVi/ywV0oMHnIaeQnoNg1nOZr/gTEb
	NLwXlJSaHoGkw7VVmcznRBUBZ1IazoywpwY9OO42hEllTg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4ea2gc34-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 03:42:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52827090cc5so7446181cf.0
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 20:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787024543; x=1787629343; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MaABp0/faTANtVcerTDacDQdlb7pXZWcETU4q2gt11c=;
        b=JVb+VFwfCZHAAYIUZWI322QYY8AUTNQWdwdpvl5eYRHvDYx+ui2Iw2H+8A4r26uiqC
         8qlZBKsdi0iWiw5pieLXq5kql7XzzUDYgPPC0Jp6l0Idv6TlZwF8qyBn4MCMdywE0dA5
         sapGAC0a+oAr6Zrk06P/Ce5Tdiqhi46tG1EoAkLrVQoELbFmD8uj8TUCsxSoLHpezj88
         G8+8N7Yf2PkbDMWSkrU1A+xUcRQNt1r9Wa51h0J9HL17nw5W0h2B/5BGZP17ELFj3b7j
         XIaB5oXBwUTvc/sktTVWrhIh8TAbA4tBoS2+HykhrogNVCwp16YQiADp+MxlyEdiwzSt
         cd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787024543; x=1787629343;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MaABp0/faTANtVcerTDacDQdlb7pXZWcETU4q2gt11c=;
        b=luC9xQX7xd45uZFQ3DkAHM6sLnN6vG1IjtZswCEqEvSVaOF66ODSgdiq6HKA6+PV88
         fq25GfVbFdu7Wy4Zrbbw0kYL0mFnXXZf9PXxo0dL4pfrukOaVKcYYo2f6FZN3k3Gp5lt
         bdqPxiRvIDkVSjXXtlxwTnPesHCiQNQtcJ+oN69eonIArGjJQ3wNbkxnJi38hx3SUhZt
         5gGcL9WIbMsSokQzNTsziPw2WpZViZaGwvUISpi58bizBdUP1J6N4FntFC04059C3bgo
         hzazPFlnhZhOVESg87cRZhwWg3R+iMfMt1z+amasoF49G2YwLzvgcjS25ruyPVVc+Oni
         tU1w==
X-Forwarded-Encrypted: i=1; AHgh+Rpz83zQJK6QOJGDRBob/Zr4FS7+vKbuSBLpm8d2H4qS3qkl6hsDAj9jsT4eqHTZzlz2vIy1mA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDFTJZcAyuSJjblkMMJr0U5wtcyxfsQdV0u+tQxV4WzXByRfXT
	rpF7LkI83k9y7FybSivxYbP7FcML5SSt/le9CL1IqYt0pWNE3Ca6ZfkCAPHRz5/SPVeF0VOQutk
	TVPTIAnxtgQlBwaKGzY/Ob20eQbskjrKXPCyYmIQ9KrvPAPHYmdkr5cSsyg==
X-Gm-Gg: AR+sD12F2tiBpzzGaqNACUTkPEKrC6o8ZL4K89dgM4kI4k55ZaR2Eff8HfikmXpRCZk
	n/jVwFgM61JwPQyBoucztiLdUqXomh2MUE4inrnl007gdf/ouHa5ELLWA7zuiO1P5j+iEcfJNN6
	Hk7tHqhsar+ImGpV/uTDOmaX3E8SA2jN+gNMD/+G0BLR381tXKVdERkoqtpAJ1Gf/nOoY9zZPAF
	2HAl9AnaT/bX04/gWsSyl+6zumFUVK8L87XBHWCDukK2cr6jJxExP35kTM2v7gSinyuN/g9Xr9p
	gqiQ+4k489fHu+wOhJyEjyx/Hz4de/IKd1TKW0A64E11IRPX416Svgn/Hd21+ydXgoXQCmhlqnf
	48PEPOK9mzy38LFai6ZMNlxFfbulMQyicdCspv48WNlfCzG+0P49r5P2PgIu9dTkCcW/onaz4ZF
	Fyggidf5TFbUhz
X-Received: by 2002:a05:622a:5592:b0:528:ce0:e9f8 with SMTP id d75a77b69052e-52dbecc2fbcmr42318851cf.3.1787024543129;
        Mon, 17 Aug 2026 20:42:23 -0700 (PDT)
X-Received: by 2002:a05:622a:5592:b0:528:ce0:e9f8 with SMTP id d75a77b69052e-52dbecc2fbcmr42318371cf.3.1787024542626;
        Mon, 17 Aug 2026 20:42:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46cfa1811sm866041e87.30.2026.08.17.20.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 20:42:21 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:42:19 +0300
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
Message-ID: <g3dkltejtlzrrelv77kjteqbkny6vhedyuet7d6b2p7yfix3ys@sop7vjvpdvzb>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfX2j7qDpg7lgdV
 6eGuoXKhHZsD/1s8DQTsWX+4EjPFqtUPBFKptrt5kiBBwt0KYK7BeJ2ip8mUFxQYZ88aUGmWooI
 G8HGxn+l/erixjfn67cCsfncw62qohqGNMQch2MQ6bg3KX7yp/ELKcSgNsKBcniAwa97UxGdHr4
 yPQvQAlLlND7tDOuOR7ZW5krs3707VWPlXunPutMVywKupZjxrLJMipkwj65KQAWK0J9gFQZIxe
 HQkU0vrQzczzRB7hwxpZ+dqq3wWjJ4nt72Jbt9lXM2rS1tHYovHAXK3Nhyp3/IJWhYRkyKJTFgt
 k/3qtACXTT80+GDmrOagNlxUqcQ+mh5GD3CYoCYgEgbqzqWuG6+m7e+NtDh0qImNa+kaNQpS687
 /XELCaEsE1Y09tvYKQWC1d2PHkyzApFL7fCyXOyn57JEaVoyOcgcy6zyraAiyV1Uf4OfNAdm2NV
 MIVKfS/V7eMEspfxk/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfX7uB9UbYTDwY/
 46VcR2NLABo4h4xKpYwwyhi9yWaKaAA8g1n3rl1B0CKSTNY6cdJ30UpJW+KzuZ7ic6nX3XzPwgT
 LEgm3Uk9fQfZc+1oxI7CQ4dIouuwsFs=
X-Authority-Analysis: v=2.4 cv=XtfK/1F9 c=1 sm=1 tr=0 ts=6a83d4a0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=BBVwHIhhcn0rA1_HgMAA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: u0PctGMyU5ZNcTYWEffaUJom9aXLMWnI
X-Proofpoint-GUID: u0PctGMyU5ZNcTYWEffaUJom9aXLMWnI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180024

On Mon, Aug 17, 2026 at 10:17:44AM +0530, Ekansh Gupta wrote:
> Introduce DMA-coherent buffer management for the QDA driver, wiring
> together the GEM subsystem, the IOMMU memory manager, and a DMA
> allocation backend.
> 
> qda_gem.c / qda_gem.h
>   Implements the GEM object lifecycle for QDA buffers. Each buffer is
>   represented by a qda_gem_obj which embeds a drm_gem_object and
>   carries the kernel virtual address, DMA address, and a pointer to
>   the IOMMU device that performed the allocation. The .free callback
>   delegates to the memory manager, and the .mmap callback uses
>   dma_mmap_coherent() via the DMA backend.
> 
> qda_memory_dma.c / qda_memory_dma.h
>   DMA coherent allocation backend. qda_dma_alloc() calls
>   dma_alloc_coherent() on the CB device and encodes the stream ID
>   (SID) in the upper 32 bits of the returned DMA address, following
>   the Qualcomm FastRPC convention for IOMMU address space tagging.
>   qda_dma_free() strips the SID prefix before calling
>   dma_free_coherent().
> 
> qda_memory_manager.c
>   Adds process-to-device assignment: each DRM file (process) is
>   assigned one IOMMU context bank device for the lifetime of the
>   session. qda_memory_manager_assign_device() first checks whether
>   the process already has a device (reusing it with a refcount
>   increment), then falls back to claiming an unassigned device.
>   qda_memory_manager_alloc() and qda_memory_manager_free() delegate
>   to the DMA backend after resolving the correct CB device for the
>   calling process.
> 
> qda_drv.c / qda_drv.h
>   qda_file_priv gains an assigned_iommu_dev pointer and a pid field.
>   The .postclose callback decrements the IOMMU device refcount and
>   clears the process assignment when the last reference is dropped.

This provides a nice summary of the patch, which is pretty useless.
Please teach your AI instead to describe the reasons and the design
decisions instead of just assessing what the code does. Why do you need
memory manager? Why can't you use existing GEM helpers?

> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
> Changes in v2:
> - Adapt to the dynamically-sized device array introduced in patch 07
>   (kcalloc'd from DT node count, replaces fixed QDA_IOMMU_DEVICES_MAX)
> - Protect register/unregister with the process_assignment_lock mutex so
>   the device-assignment and device-registration paths are serialised
> - No functional changes requested by reviewers on this patch
> ---
>  drivers/accel/qda/Makefile             |   2 +
>  drivers/accel/qda/qda_drv.c            |   4 +
>  drivers/accel/qda/qda_drv.h            |   4 +
>  drivers/accel/qda/qda_gem.c            | 134 ++++++++++++++++++
>  drivers/accel/qda/qda_gem.h            |  52 +++++++
>  drivers/accel/qda/qda_memory_dma.c     |  82 +++++++++++
>  drivers/accel/qda/qda_memory_dma.h     |  17 +++
>  drivers/accel/qda/qda_memory_manager.c | 239 ++++++++++++++++++++++++++++++++-
>  drivers/accel/qda/qda_memory_manager.h |  30 +++++
>  9 files changed, 559 insertions(+), 5 deletions(-)
> 

-- 
With best wishes
Dmitry
