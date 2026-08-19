Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045C835DA6D
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150979; cv=pass; b=kTyahAywz9XrWcK98qr7NAyybTi1ZfJXioD/XQc+2VxKmBxFdSkK1W9Ujnf+YB6vuyY18dWfe0meols1GUD//VM+HhQA5R/MOacK3NaslpkpL+Cqm2c3T85HesakGAF6Q+csOs2Y2mCbzIc+WgT3LoEfIt/WZj3qJn0pFU/xqf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150979; c=relaxed/simple;
	bh=9wVhSx3PVShqBVKKwgYE6zUrTe2YMfHR4S+tqrdXOCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlQKxrRvhV58FIQ+Xj+suBvDV7c3qEa1wigUbre1itVlSqWBKxzjbAe/TH/LSRGkMOLYuR8cRI78sKrtAAGncr6FbdEroCyv86GHaxnH4r44UVCuqu4eLnYBH3lI61sZq7VqXFgEUAM+H3WFkj7vX7L/km1711oA4jQNIgjzfxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eLme8JwQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MA3U+ox+; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eLme8JwQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MA3U+ox+"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JEbaov158025
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 14:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=4rNpIpy4LtbyQ9Xtow0eilFdW8OjcFy/oDCBHiNow/s=; b=eL
	me8JwQK0gnd4E0UZMMlGf35BN58ld0D1S5FR4/hiSNXSXIxD29uqf2vrpsBHXPjx
	d9PATSuywKmGTK0IssoLyQ3nYDj52e+ZKi4vMX5YCORIKrn1TBdkjENHaxy4I9Tf
	EhQRPwdOujFdQJfuOIq9ktzzprkpUeWv5BnWKOtOp0qFSIsIi/9Y0PmGTqk4JrpO
	nhu6BwMo5nJPbzvlRvoNnPEOjerlIY8yXhVvvN3gEqVRxGpSCl6vToiotnzH9P32
	FnOi/m8QA5a7QSwo+jCuLakY1PKPY0T4EjhdsQksMMIpPQysdOh6nsgGFr9hEiYy
	9QCjJF2anT+fFc8qCrEg==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yffkq4v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 14:49:36 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6b12e3edc28so600637eaf.3
        for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 07:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787150976; cv=none;
        d=google.com; s=arc-20260327;
        b=jwu0uyIlGG2rgIU2SwU4D0ErKj5U06JYkPD1AGD8WxJAOY9oAoHRdhlEK0guRzzOC6
         RMlv8Sik9N5Id3lk306adL7/NapZwnMF8RkupT7fEHmQ3dkvibtg+wQLhILgtnIYQrLa
         lbY6JJp3vGak/1ABAryheyMH5eP4b5s7+KDxS0S9PzdBVMozGrr5U/keyvMF28qSVI9P
         mDd6nOZ0airNgTHtV0IgcfBYW9N1+GYUEp5bnh7BIBNlfs3yBbgWLG7FbycNgXSQ9yMz
         54/s8k+P6ZaXzZ59UBG8CYf25M/lhxOpfTCOzMEMrmWhCwsIPvHicVZ88pRkwMdQ3szD
         X4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=4rNpIpy4LtbyQ9Xtow0eilFdW8OjcFy/oDCBHiNow/s=;
        fh=+QvJPSjxo79mPjrm52ZAByCR3gK22sKdmQQkGEEhPMc=;
        b=MBicUQcPRZlN/d8Xhh5Lb5LOutD4C3HKuqwzkPdqXzln+qQ54UigHmYoQpWDjMOYvP
         cDBq47MTlUJjevUQh3lrQ4Qeq1IEmru4qpIJlrFO5x/5M0O8QRaITnUdOQHS1LUHfj9O
         W33oK9cZ9Kg4PB2N7DmF2cO1IYiWhqZIv80sRXeVQKhWtQTqc2PmuApogSGDsUPoPU+n
         Wy9TVnGqveznb3iK2iKwQoFcv3ILPCwCZvFS6tl9Gdwgn+6saiDy6DfTKGHHRN8BHUwh
         0y0nF0zZcL65xatzDCJIhr24sIbADFJb0yU6FeftS89NOmxtL5epgzURNz7G9u1etw1w
         kAOg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787150976; x=1787755776; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4rNpIpy4LtbyQ9Xtow0eilFdW8OjcFy/oDCBHiNow/s=;
        b=MA3U+ox+645nS0jlnNzWcmf2o1W0OBnRmqW2jn1BeZhFWZvs3HympKcgfV/KimQoCE
         jSzzCSqyYfdlcN+Q+OXIt02jUX2/vn4+55Qt/IbRL3BqPZjsc3mMnzyajaDlGsqd/7LU
         p6RLaTV0B0S9G2zA8pA/EJGYNJrx9Pv+V1O526T6dhYSM8sQvr3x+n9NT5tpidnklrpe
         JTHV5qG33sBFi5/tbXz+3XMXt3CHNo28RqiMiWLnCAiLtBsNefoaG5wCprZR7iHi8png
         uoHX284JT9IjYnOG+OreFNsrDPi4io/qf2BZlS5PEv8BV/4EK2lcy7xzwYYocrNDpfa0
         P5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787150976; x=1787755776;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4rNpIpy4LtbyQ9Xtow0eilFdW8OjcFy/oDCBHiNow/s=;
        b=VQRO0UE8+Vged/34wVWaN6FNSoVLopXP+D7InDuKEOxHKHkgSnfoITzSLlb3OvyC/k
         6xtVKgYu97I0XZ8S+U1HiHpADj7AjXl1j4Kegi55CvRuzj1DysO7eNaeOhoBhtDvkjxH
         ezhvtfqyp+8uv1I3hs/86CjUhxtJFBW6pSnss+xDKJC2tQ4NliJx6gTlRBEvdaOhJLMZ
         c4+KuI9X2IqmS9PPNL3In4pXRhBV2ORPULSw0wSdy242SK63KSSPL0vpa+LJFnXj4tgA
         4WLyX/vut/CSFqo7mMjtUOjhkM/yuxkLiXXg4JaNaI4DUiKudS+mRRdOClAHPXr9pPYr
         Na5Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro+ULTTI5zysWomLDC+OFmdhstkyzDUuUiZhgHw42wdXBVrq2K8o7L70T0Mp2esOSydBu9piA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVpGOtIHYMNmF43BJ6EHnTnsGw3EN9V7OXOj4o/gpukCT5m6X9
	GV/+J4CPY3rmFBX6828bWLWGtQzfkjxT2IWIPUq09mdAyFOiXW2JWkyX0xrZ8P6XAG6mpO5GctU
	Lr64jqWm3uExCYpRweedEj07kMMoc/mLGmnDmZwecJRLQbqjYMyBWa8cugk95yFeyAV6eRGA6xS
	eF7Lfj1N+p4IJJfkpeGD7+9KaO+H435KgD
X-Gm-Gg: AR+sD130m3AsFncPbYd+pwm9Wz7wUAsij0KFdSClBwGALZwAEXau9lLR/47nlJh5vr7
	y0OgcmAypEf/u4tqEEblU7uD+HBtZB/pQMmLVg0Vza9JtVYAGJmeLBvj2/JPdpk9gkjMo7h3/oT
	Qsfc9ylqRRgDPASKrdXxqx3KghAH+N0pY836sv2FrEE8SXRrsACI2eJ44r
X-Received: by 2002:a4a:e917:0:b0:6a1:8c8c:abd7 with SMTP id 006d021491bc7-6b13c3a41cfmr4766405eaf.16.1787150976073;
        Wed, 19 Aug 2026 07:49:36 -0700 (PDT)
X-Received: by 2002:a4a:e917:0:b0:6a1:8c8c:abd7 with SMTP id
 006d021491bc7-6b13c3a41cfmr4766332eaf.16.1787150975455; Wed, 19 Aug 2026
 07:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <3322b42b-3755-45ec-ad55-345125f0d488@kernel.org> <10349e29-b583-403f-a89a-9a00c73666bc@oss.qualcomm.com>
 <87dca76c-851e-4cc3-ab91-68949d283b79@kernel.org> <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
 <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org>
In-Reply-To: <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 07:49:24 -0700
X-Gm-Features: AcwNN1V5bfW_enn3TfGcE4UwPNlg1kyolZJsLpJh8D-Byx5y30oNV1d5dKRlS_Q
Message-ID: <CACSVV01T=ytVJKM7NRoBTAJm7vH+JPJNT9Tftu5X9YskGXerwg@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNSBTYWx0ZWRfX0qlmspMHsneC
 UJoZzMeGlpIM02x43gCdhmwocBo9TSHp9zOk0hsYfrsi14UG1+S9XMkVPYp86Tf1FUdIqFdlwH/
 VqUVtrHuj9bDKVlYENuuGFUY2IGWoc0=
X-Authority-Analysis: v=2.4 cv=H5PrBeYi c=1 sm=1 tr=0 ts=6a85c280 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=MVsHzMdaoZhIBd0MKPEA:9 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-ORIG-GUID: ZkoSltC1sdCZFHFMUKn_gekOLU9IAFso
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNSBTYWx0ZWRfX2uj47c/7L5r0
 ga8ZMZ0bHiCf1X2Jr0C0gxfNfRyL6de+7eZowcYT8EAxxfzsWzQgTG+zhVQ97LkLOiWOhB81B3I
 XQ5bqttT1lZu49dBH5UmTk2qlj0fLO4WYiM/79Mq/QTYwtg8QxwaF9EsiA5LNH7PrjHu41me6u/
 mZ2zNRgOKksWYI7neeep3JUQQcA3qvjlbYyOJYbz2vh4vAktqYodtidUv2UY0D4kUzhJANH2ZBl
 WN7+q0v0yUPsRVHkWVR/oYWC8n5d6EUyppr/x5Ir2xjgWVcJRtlE7SOg1jlTFJYz+RE5ur+ywGl
 A3su2dVLJXPvVA9TTafsGuOe6KXKyRzRUd6lUu0GI6nW3yardc7fA/oDK6ojKYt92Ri1q7pew6E
 GFJEtu3jvVRme48TJDo9AI63yQ1B4TKAkBlLEkZT1e6jj8gXTQZwufJ9RaPumYI0DMnp1B3OPaP
 BhmIP98DMngCp0cvZFw==
X-Proofpoint-GUID: ZkoSltC1sdCZFHFMUKn_gekOLU9IAFso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190115

On Wed, Aug 19, 2026 at 7:43=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 19/08/2026 16:38, Rob Clark wrote:
> > On Wed, Aug 19, 2026 at 7:21=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 19/08/2026 15:26, Ekansh Gupta wrote:
> >>> On 19-08-2026 00:43, Krzysztof Kozlowski wrote:
> >>>> On 17/08/2026 06:47, Ekansh Gupta wrote:
> >>>>> This patch series introduces the Qualcomm DSP Accelerator (QDA) dri=
ver,
> >>>>> a DRM-based accelerator driver for Qualcomm DSPs. The driver provid=
es a
> >>>>> standardized interface for offloading computational tasks to DSPs f=
ound
> >>>>> on Qualcomm SoCs, supporting all DSP domains.
> >>>>>
> >>>>> The QDA driver implements the FastRPC protocol over the DRM accel
> >>>>> subsystem. It uses the same device-tree node structure as the exist=
ing
> >>>>> fastrpc driver in drivers/misc/. The approach for binding the QDA d=
river
> >>>>> to device-tree nodes while coexisting with the fastrpc driver is an=
 open
> >>>>> item described below.
> >>>>
> >>>> No. Grow/replace/improve existing driver instead of coming with a du=
plicate.
> >>>>
> >>>> That's a standard upstream requirement, basically given on every
> >>>> upstreaming guide.
> >>>>
> >>>> Please watch old talk from Greg - "I Don=E2=80=99t Want Your Code!".
> >>> Posted discussion threads here[1]. Would seek comments from Dmitry,
> >>> Srini as well.
> >>>
> >>> [1]
> >>> https://lore.kernel.org/all/3476b5c3-7983-4994-a901-3d7d8bd75255@oss.=
qualcomm.com/
> >>
> >> The rest of the comments is still valid even if you did not acknowledg=
e
> >> them.
> >>
> >> Anyway, regarding above - again, watch the talk from Greg.
> >>
> >> You have ONE driver. Not two.
> >
> > Long term, moving to the common driver framework (which did not exist
> > when fastrpc was first created) seems like a good thing.  But does
> > that not allow for some transition period?  How can we get from here
> > to there without otherwise breaking userspace?  Is there some other
> > precedent elsewhere in other driver subsystems?
>
> Yes, Iris and Venus where we agreed for an exception (two drivers) as
> long as new driver supports old hardware / features.
>
> This is not the case here, right?
>
> >
> > I suppose drm exposing legacy fbdev on top of drm drivers is _sort of_
> > a precedent if you squint a bit?  I'm not really familiar enough to
> > say if that would be reasonable/possible in this case.
>
> Growing old driver does not look complicated itself. The only a bit
> tricky thing is to present somehow exclusive interface to user-space,
> like usage of one disables the second etc. Depending on actual
> differences in that interface.
>
> But having a duplicated driver is a clear no go and it is well known
> upstream requirement. Nothing new here.

Would it be acceptable as a first step to, by default (ie. when no
cmdline override/etc) for the new driver to bind to new compatibles
and the existing driver to old?  Ie. have both drivers but only one
binds on a given platform?

BR,
-R
