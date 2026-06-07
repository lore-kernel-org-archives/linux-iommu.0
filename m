Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5AE283FE5
	for <iommu@lists.linux.dev>; Sun,  7 Jun 2026 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780867022; cv=none; b=JBnwPMsnO1oAWh3o4KA+GJ4/gRl1ihZ8HBwdmWkWYBO3nMX+j5eQwHcK2PR4Ynv2E3hhYmtPuAY0mJ3o5IVIrAlwi+cgWKmHog8lbY6BnLwZmksg4Pk0hNJKrWzzpa5WkkyC4GWVELMf6tndVsqQPmIF1bn3rMOJ9jFKXooVp3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780867022; c=relaxed/simple;
	bh=K05rDR/kI8f6Lkx/1x5sjLiZhZshxFfSfklW9pxpF8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcxbsBeotGhYDtfY2ifH7OXudDWdZS3pAFYoLAMkr28Xs7caLQnm/KpdGsfo5kd4FrOwjg4ieItlEMrtaNN8dAr4KjxgH4d/sIllLkCD0WPbfnHVsfGK3adEMUQ88OSjngXB2vmKjVE8xx8MrQ33XE+o7inmM5uw/pt9KowHvj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=But72Gez; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VeLJiQNV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="But72Gez";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VeLJiQNV"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657J7cL71409639
	for <iommu@lists.linux.dev>; Sun, 7 Jun 2026 21:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=b7j6fWH2ZTuBoYf3DikwUXDF
	crJUfkjfuq65I6UYILE=; b=But72Gezh3J8O2kC7pcCgCeUO5B83TzWPdicivQA
	g19bqR3eLMsg6WosHQ36cxQOtkV5o6n+puHlydTYJg9M+usFF2y/WDRnVMD/m5tC
	LI4wPKcHTMp5c+znAZb4hadOrDuF1f60I6rywu0fRAkeKosyfnwZd9Uxr9HHTDfW
	KwRXI8Xq1Xnr7nDD0TVtDmCQLFeb04rNMSgc4ZAwJ8OoalbIu330DN5gPgPmsbZa
	RSKO85OmfXjzkldAeL90tkekubBWeWcWRwQv6CEt6YLnpTotwTGNzIuU+MUT/vYP
	8eyF/eliV3HLq6qYlVZMJ2ptEHT30V8N/QOm0w4exF9mDw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4w3x2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 21:17:00 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-59ec77e0184so3147669e0c.2
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780867020; x=1781471820; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7j6fWH2ZTuBoYf3DikwUXDFcrJUfkjfuq65I6UYILE=;
        b=VeLJiQNVybRod9vy3H+QBX9hl7SPP+VvPy55OmcslkemjsuT8QuNJnYQBv58Df3SNK
         5ApCJrRsdT3P5xHdz0mON4aosy8qPvQawKFW8DGltLvaGbZTBV3YZZUzdqadYaGw/ifN
         ZomAD+Iklw6UGFkhT8Y/9PRcKCA/l4NVlQK9/XndF1ve13iqIQIEc1ZChgsHjJjR9P6F
         UP71QJiBINgOSem+5ktZxhJNifiLOvgnZrEL1aLaek8afJY5zUJQwbrLZBcpEalrKhx6
         hy+kL3qj6w1WN0lyIIx+8mh5qdI9iDKYMUD5J5X0mkiE5PD0LMaSCWsSQQcqkP+KWzHg
         G2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780867020; x=1781471820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7j6fWH2ZTuBoYf3DikwUXDFcrJUfkjfuq65I6UYILE=;
        b=J/D+QAXFp1jXMPf2MTNQrYLzIq24lln/qZIQP9ZAzkJOcdIgUo2aZrJcPA/gRsNUVU
         1D8b4ng+3Dyb7w116NBNbWe0aNaooUNr+9qUcP0QZFuA91cA1W6CTJ+5GM5AVMFkiI1Y
         5SXCPKSGjDObC6B+gv4PIeyQztxu6/4+e2DIU07gSQLJ31icktHzyARUTmovKXHn+q/1
         Jvq0Hmk7dYc+lwI8fDjzctSSInzbZiDk2Ka8YOnPGbC2z8a4/zZI8sljYslbruwjbpaZ
         EmMjIXY6tk03Ihdv5NvE7cVjZQdFcrSccalW0XBoamhKxdh1c1hX+RkpJcNPrplRbP7P
         XpKA==
X-Forwarded-Encrypted: i=1; AFNElJ806MpjPNIpCs3M26C8CNl5GrfOTefqHS2/3tPLZBxdCA5Gu8+clAmjtx5MhOJmEf833ujIJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLemV+w3cAo2gukzle/Gn6K/stFY+aKY8ZY/pib1LtMAZ8ushq
	3MnEx7iBlexCPXCGvl6QJLyRFrhKoakkRTplmvud13r0UABRxHomf63/wEAVaGLF6rAz7MYkEhu
	QFGNr2RgZsxShXfCq/eFDeXwCCnO8+/RPuwigsYmmld85iWK26BPlTxmtFA==
X-Gm-Gg: Acq92OE3YK8FWwlZwKPo+pmc77imArejYiFmvBBmIHTbqT83+GJChlpFvfSwygw6RB6
	0hZVd4l7xCqHdXTXK3SbLZBBSeY6FsaCQy0XDi4ZmghH2iUe+tFTgZo1QpZGPJdQZ9beXUeD26z
	It9RxcAVYUvDswuI2lEc5/1ATkhIgGYKQzstS7AuU+BepR0WFPT9tjIgQ1QSJnZ4h/QFAjK2sUF
	uoeMcTkNUrZm6xTkSr68TRG1Wg7NzPSR54ZvfBEifSE+QIQlqN5/vPYJYd9apeGB/FxaNeCR0lc
	xjngKGWPqso/Du93nT8Hb8/XXgdH9IAp16qC4sNdIZsC9HpnJDxfohiMpwZvLhIRjnenrUgG+dY
	IbrBGO1pngUoMfX/V3dxzOBX2888bZqkBdEfGXZJX10Jo7EXb+V/+rD3OBbl6FeAaI+FIdAmoA4
	TRAO9Tx/nM6skLllDkgTg39tjMlL4a5HvQ+VC4KFACUpQo/g==
X-Received: by 2002:a05:6102:4191:b0:634:a573:c097 with SMTP id ada2fe7eead31-6fef36392d5mr4964756137.13.1780867020071;
        Sun, 07 Jun 2026 14:17:00 -0700 (PDT)
X-Received: by 2002:a05:6102:4191:b0:634:a573:c097 with SMTP id ada2fe7eead31-6fef36392d5mr4964739137.13.1780867019635;
        Sun, 07 Jun 2026 14:16:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b9040fesm3273761e87.31.2026.06.07.14.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 14:16:58 -0700 (PDT)
Date: Mon, 8 Jun 2026 00:16:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 13/15] accel/qda: Add DSP process creation and release
Message-ID: <5gz4m3mfsnlwmyfiqtl34rgt7krgo546l6kslux2ibyinep3td@zs7xjxrk557o>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-13-b2d984c297f8@oss.qualcomm.com>
 <w44qzw2ryg7bpbte3hegopmtkfjd2gby532rdjarm4i3tylpv2@2rmruincfdgc>
 <568987b0-6f54-4b51-b1c0-416435e3f564@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568987b0-6f54-4b51-b1c0-416435e3f564@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: kGPVxh5fHTBA-JNh5vqtLIaiFVOcv5PX
X-Proofpoint-GUID: kGPVxh5fHTBA-JNh5vqtLIaiFVOcv5PX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIxNCBTYWx0ZWRfX34XHMDvJakuX
 h0OxR3bAjCQEZ+BIRQBSItYVIhVoxlKqLY6/g2AzLnTj9wupGsqouTB5dK8CL/K5ThRbUPnOkpf
 Py0TLr0sEXJ4SdYanxJH1dFsnPiNPX4GP95ozfrkN6UNLDpIjrkob6Qj5dGWo7Khouhuf4PhHhm
 csHZP4GiteYjeAv59QnEhyuEzG+Cs1xo4t5i1IrpLZN+oVXFacW29VGXKrOniOtPmuI9Q0rtmsL
 Ov/cT9Ak3y/rB3zeCuhg9pHM2sL/vYaDwSJ9UWk2UdHE9BIR2kwyPBhWd28uYsm0Q3tuWWNZ8Kw
 VLcNlKDyt4AmFjltkrPnCN3KTeEEUqxYUElRkzWmpOlb0tJTKIr1uZF9kRcnhngw2iGiyHxPK8p
 3adjXWv5vuRjVKuQvUZvEILUZAZkXlmjQuQgfs1s1BPsdrCPdytPvNZEMIb+gTJLg5arqoOOboh
 S0M/8dELN1RizEAmGGg==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a25dfcc cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=DtFIhfJECZ_mmoY6xYkA:9
 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070214

On Thu, Jun 04, 2026 at 10:47:13AM +0530, Ekansh Gupta wrote:
> On 20-05-2026 19:30, Dmitry Baryshkov wrote:
> > On Tue, May 19, 2026 at 11:46:03AM +0530, Ekansh Gupta via B4 Relay wrote:
> >>  
> >> +/**
> >> + * qda_ioctl_init_create() - Create a DSP process
> >> + * @dev: DRM device structure
> >> + * @data: User-space data (struct drm_qda_init_create)
> >> + * @file_priv: DRM file private data
> >> + *
> >> + * Return: 0 on success, negative error code on failure
> >> + */
> >> +int qda_ioctl_init_create(struct drm_device *dev, void *data, struct drm_file *file_priv)
> >> +{
> >> +	return fastrpc_invoke(FASTRPC_RMID_INIT_CREATE, dev, data, file_priv);
> > 
> > Where is INIT_CREATE_ATTR, which you described earlier?
> INIT_CREATE_ATTR is used while `sc` creation so the DSP considers the
> request is coming with some attributes, the ioctl functions are going to
> be the same in both the cases, so keeping it unchanged and the decision
> is taken while `sc` is getting created.>

Ack, I missed it earlier.


-- 
With best wishes
Dmitry
