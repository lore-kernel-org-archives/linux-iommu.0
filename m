Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793656528;
	b=JEfUAGb7sMqazhIW8YhwaRoHft/WCs01c7N57TnyGCTNAIrIBxYEwR7VbZ9yk84PIZKA
	 393LwYonhNUIGIrSdA0g0Mafc+Cu+VjAOCYQhEnZ3nFpdeNTtmIqylCaN7GSs8a8JrDZR
	 3ZZb49Kxp3vRnH+YvsF4MKH35mvUSGfjeUVsh/kbvp/vFr4MyXTQLIedkoY6QXDs687AB
	 waobkpouITmnayCsX4rNNYLzOQhnbLwvKUumxsSOWhmmZ/857OxWRqdLPkYKzYPeZ1y1u
	 AvNVGynXynfDZCIZZMIDSwu0P68C6YhqCzPs9vOxWdj0aCb8CgQdnDuTy36PVtwHlbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656528;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:Reply-To:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5Kons/VVJeecTE95p6b5aHbvgxf5kG9AxNXwlr03l3E=;
	b=l2U0o06CBkud6e33m1ulptZZ5N9PPClDw8JVqHvnCeUihezRTtiIpXi4WzJDGJZg68Kh
	 k1FBmDfZ52PePFHQfl9K0m5XImYXcvhx6c6wzvTY0PbMA3QBj0qNuhecZbNeO3Qqqoh1u
	 WbW+VVP0Bp9QOdPNVGpP/m5o5PROiZVTFoXVeh1P4b0BnBDOexkwKEai7YH13BViwKlg0
	 phdk7cjD+qRr8Yk+IyvEsc+o7qIjeLjw3KMJwHD5mw67gGNNwniSn6S7vEwpdjOT/CWxo
	 pko+xMVemwXGn872vwNkv/9qUP1IW6A/231PwNuXbEqtDS9YXeYAeMvt30LoANGRRjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="iFG/gbXs";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PCigAaay;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33072606A326
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 21:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33072606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iFG/gbXs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PCigAaay
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2LHstE878718
	for <iommu@lists.linux.dev>; Mon, 2 Nov 2026 21:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=5Kons/VVJeecTE95p6b5aHbvgxf5kG9AxNXwlr03l3E=; b=iF
	G/gbXs4vywdlb2op5UKUfoQVuQsH8yMcM9nEoSU6ycicr6Tah6+SmKgoKWHlbd5c
	oTe3KdUw4yG0ztUBVCgrAngbcIGFF6dazGHGsIcZLU2Ur/6b2wydddoe3UU6DPnt
	nse1dREVyXhQNTDl5/f347gV472rkITi5/j5XHCFKsQgnRb/4vQmBxmaxxgAc7rH
	9EOE4ryF2jMbmKYvd4RlT9xN1HlwEv3aYWTUUnaFe5B0ow+dL+P/+TasTU8y5ZHM
	O9pC6IsO4/ehOz90Mx9k3mdCbu4GLgZg+xHD7RqLlWfL4Yrezi677hHnTjqI2F30
	UjmuutvQTnPWekcwOxJA==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq2acg3mt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 21:55:21 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-45a07949855so4253075fac.2
        for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 13:55:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793656521; cv=none;
        d=google.com; s=arc-20260327;
        b=f7vJAEe2Y+JzvocbNMotEQqtZtTEme1MuJqjgEGetbZxyMLMTlBaIjncC2qlX5qG14
         6s+texmG+HELe0P+owyoXHnqhiQ+nKIPrvqDPYkhgVUeyliarX/vTGYgb2ZLG7jMGZdu
         P+B6AAzhsm3BZj0cluy/WlLtDc+cRRlWGeVLDqmXNDkSORUr7FLKbzJeNhi1NniqjNmh
         Qa6KrLpIklCub1luctCUwOcIhd+JnQ43sFql9uCHTQGxBhdAxQb5qw3DixhWPeeDKV+O
         DOL5jh22TkjkzhgeUYEMI49yIDrVC6ZL8tr8Cgl5RzHaq+Pum0AslrjRlwEW2qglTWN7
         4Wjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=5Kons/VVJeecTE95p6b5aHbvgxf5kG9AxNXwlr03l3E=;
        fh=zl7JoqO2tQie71SFBqnabYANuvioTYE0YLrrCPpUbVA=;
        b=IJeGPSX33FAzRS/31D6eDKwQZagLCRGSAdVJ8IfdUNF6WVV/ddfEfp9K+dxVkSueHa
         89mDkcWOnPjF2/Vea2/6edVMqErVKT+TfqLwQNa8lZx+Xbff7nwLYFBBSJMu17Sh4Whd
         GdiWQeS2Me5QVO6o3ZKwHCL45dB8k2JG3hpPKaS+pSRVh/CI5DGsOLRXcDRTuTckBjCJ
         A/2+Kegr46uMM026TAWbQFSxZEjLah8u0R8c22tToINA0Fw0UKbLZxIjWgL6caVyrruu
         g31yJF6QAeJZ2sc34Q7phiKSnG0s6b2s0mB6RF9TnJ0/HXbR1qUFeqzU2NQU7qrPF7WU
         7xnw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793656521; x=1794261321; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5Kons/VVJeecTE95p6b5aHbvgxf5kG9AxNXwlr03l3E=;
        b=PCigAaayocBJZ7M7fN7SDIUcR+DL2h2YNETFC7leV301PXdthllPik3azs1CpowC4d
         Pfei3niNWLDKu70rY2MNm3+01DlBnLypCtAMuea7UU0BiTOR+AIXKIaN3mRkU3gwbV3m
         MF9fpfGz9OBzmnbG8FT4yITxcdoOxS1as8tu3cSN65TFveW640cn4EnoTuFnzIXN0bPK
         xHcuuVWhcEL/NhooBZjcGEH9kAby4bJVj2FsHigQuq7jp+3HIt2veyMX2fiuPnDmyq99
         IKEJSEyw/Sl9qRLga2Ll3vdG7XXbaVmYuf+Ah1Fhf2e5A9xH8FBWItBUubDdGCwpqg8G
         8+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793656521; x=1794261321;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Kons/VVJeecTE95p6b5aHbvgxf5kG9AxNXwlr03l3E=;
        b=bQf3Tta2+WlE8j0+BYU4K8to1gcsrq3C6TEKTab6posKMGwQQXz6Wk7JVhn43Hwaer
         vrg/n6acmJB50mTc8Wd7Hh72KyoExHbr17wIbGwKCETNGyUdj9f1jpRthw5ndUM2oaWw
         HeoXW63XUXbFlzzn641tXZ1g2oAaKXQzZ48DJSPrJoFU4mdYgbzaXGaW9qhZc608HZc1
         3GMBqtkzkt9v8iQ/ij69A6kDPTGfjGZfIh+9pa4kZ1vqlCoJIrp+TWrHYeEjZ/+yAv2K
         jZln4n6CoIXJLE0yHFxRDgRtlqteCJNLtP5p7FUOxHINMrjfVmkZkxW4rCn/ze6w3J0Q
         041A==
X-Forwarded-Encrypted: i=1; AKwUvByhnxui+R2CVKfj07VQaaDzhcQIvhQxkfPf3LRNW5m0KSElF5XO9RbYJih+AK6cRXW/27HwPw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8PEMX9WfF9/9/r9F/R50Y7gUVaNa0bFjc0krrLr0VAqvrsRaQs
	1y9oyOB1L2OKxPMUoVue90VNDdQpj7a9IGuQe1DSeBKqpBiOGSIHJCGQRyWRbIBp7AHa6SfmhjY
	fl4dM6cMF9eJgsm4U4L0xcV+Ws8Hq1NCwUsjsNj9uzvZfNDs6CXAkXwPWiQoPt86qTNSukTwZsK
	8pMWOQ67x2eS2MhJe3EQtbokPPmu8iZCckRoRXPTmo
X-Gm-Gg: AYBFou0Cb6MYQRVtHtSLDKsU8c6gUVA74C3bDwMK+JhBwqYr+/sh8VRyZgg6aUtvaEK
	l/cSlPsZN9YGYxcasL1w74k+szxCXBCDqBcY9IisTlekpsrIXJ1KkYRcrwm1GafbRQapkwWd8gk
	WGvCdSJ0Y2kulGg7w8ce2XAbVcWJL7H0aRBKR8c7tizQyqg/BIYQrDJRuPwg==
X-Received: by 2002:a05:6871:3285:b0:48f:e107:317b with SMTP id 586e51a60fabf-4a9077d5bbfmr7236431fac.46.1793656521116;
        Mon, 02 Nov 2026 13:55:21 -0800 (PST)
X-Received: by 2002:a05:6871:3285:b0:48f:e107:317b with SMTP id
 586e51a60fabf-4a9077d5bbfmr7236414fac.46.1793656520482; Mon, 02 Nov 2026
 13:55:20 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com>
 <CACSVV02xa+emUMd7Dp1rDSwa0e3wpyQBcPeZg-bXPL4U3kzQvg@mail.gmail.com> <vfpvxwe54n66qmdy5f6hopfo5szlwrl4gcu667mplv2eplu3br@aqpupbzslcgi>
In-Reply-To: <vfpvxwe54n66qmdy5f6hopfo5szlwrl4gcu667mplv2eplu3br@aqpupbzslcgi>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 13:55:07 -0800
X-Gm-Features: AclHuK8vUilw2z840EWu19Aj2IsPjbqVTCvonIaFNq6IovHlRAiOrSo_eV_NVk4
Message-ID: <CACSVV03=CiMQX4sPp8EkL-p0+nyU6JGc8G0HXhyMK29Cw99CXA@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu: qcom: Fix the MSM GPU and display with
 DMA-address based mappings
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=T4gZ3PKQ c=1 sm=1 tr=0 ts=6ae906c9 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=HdZ-pd3ExLc5KhsI-vcA:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX2l2q1rxKcoSU
 7qDnG9xFJUeuaMTxyklvg6JKQbpzEZ3IY54LrBO/tjme+tb+Z1FNeBUHmn9m0oP7D7Ba3DhXeS3
 y8PkNi+86E5HDdxcmkmj5n1/pbUs/P94TuGMK9sRHkux197Dn4DTK0UVnP59DMG9vKy8NDJ4fsW
 5oy86HsjGLxSaxHQZ9KJhCm4v0f1eDWqKyRwgsBkRjNTOTWcPGggShCUC6bQtmNzX+yb+BteB9y
 HhCAOJG7RnE99rRn3YVLYnpxe+MCUXY5qPzw0ybyAOj/jh4xgMB7HNQMlJWiCqip9AeXl/nQvj6
 plrfH9bGKAXM6FjyCCpKWOas2c+/RxLY1bDrWh46ZTaYTMdjnkipTLc+4vWv7MVK04KdDw24wu7
 Klg/Ynxl5+wP+3u/QDZaQCM4LPr0xGJLRlOeI7PwUI82tKFoPnQnKZoAIlo9z25yXIesVihF8YD
 LYe8WxWxRlMxqc4V7Bg==
X-Proofpoint-GUID: lzOK-ViR5H_9n6fFzhQP4MWMT4m5lzBR
X-Proofpoint-ORIG-GUID: lzOK-ViR5H_9n6fFzhQP4MWMT4m5lzBR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfXzBPOo8h1YrKJ
 EsHR9vuchO4pYLHFraMrgMIzVMc7MSjo0LPMlqXXjMBvL9JyJqmsgEpv3abtLGWhJK/PM7vuqBE
 KYMSYikspxqCu8Fbx4sizYn6swWfH+0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020087

On Mon, Nov 2, 2026 at 1:58=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Sat, Oct 31, 2026 at 08:33:06AM -0700, Rob Clark wrote:
> > On Fri, Oct 30, 2026 at 3:05=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > Rob's drm/msm series [1] writes the addresses dma_map_sgtable() retur=
ns
> > > for the DRM device into the GPU and display page tables, so they have=
 to
> > > be physical addresses, i.e. the device must not use iommu-dma. On DPU
> > > platforms that holds, the DRM device has no iommus of its own. On MDP=
5
> > > platforms it is the MDP5 device, which ends up with iommu-dma: the GP=
U
> > > then fails to start on db410c and sda660 and resets db820c. The last
> > > two patches give it an identity default domain in qcom_iommu and
> > > arm-smmu-qcom.
> > >
> > > The first patch fixes qcom_iommu's flush_iotlb_all, which never
> > > invalidated the TLB. Nothing relies on it today, but the series above
> > > does, hence no Fixes tag.
> > >
> > > The patches are independent of [1] and a no-op for the current drm/ms=
m,
> > > but have to land before it. Tested on top of [1] on db410c, db820c an=
d
> > > IFC6560 with and without these patches, and on Open-Q 835 (DPU) as a
> > > control.
> >
> > Thanks, this should mostly supersede my untested series[1], but I
> > think msm_iommu.c still needs the same treatment?  Hopefully just the
> > def_domain_type() part?
>
> The msm_iommu.c needed more fixes. I will refresh my old series and
> include fixes necessary for the dmabuf debug to work.

I guess if iommu/msm needs other fixes in the first place, that
shouldn't hold up the dmabuf-debug series

BR,
-R
