Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2F73515F6
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153436; cv=pass; b=MYyM4kQx0UsR9T2MfEiPcj5V31nsUvw/nK6zCCepyErEzTvgDVXh0SZCMjmn5H+g5TOj8JkezgFvKqxatY6mRVLCd67nBbwR22T2eY3LLCz4K1XMjEqIo1UHYRalO6x7F6QYJxTG0haVJJUpV7q7X++p2JK3cOX98FrKvbs0SyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153436; c=relaxed/simple;
	bh=zgrW+FnTM1DV6L5kMs4FP8rCOUdtYt8xe+26qvHuZGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBOsU9aXmfab+47kAmAg/WjB0oHmvRzkIvZIy/d+cUieHweALXIcdF4sXZNSTj3eFGXXx08kLjhrex2uAWavkL8/nWRUM6qpa/pVeFChHoxBQ8/g4+kTdDz8FqfFlU8TpDWJhylRlNAIphOGX8QNJ/UJBYq+uzxmj5Jau6fVvg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eqtYERns; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NdFevLit; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eqtYERns";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NdFevLit"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF1ipF212239
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 15:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=KBH/fUIgWYWW3/6b3lc46QqFXFbnfFKPLKLVEnp7Rdo=; b=eq
	tYERnsZTS3kFgGZ+V6OYIfQSuwal+Wyf6alsTQxpOdLChbPicqOUuXLXL9yBVLVI
	DpPL8hQD+TSwk0o8IG05G4gjVuVAj19T/RyMlhPzZbqqBkVYB8y5x0mvZZim1dON
	idZbReCveIfOKPoQSCJrzVNApr4H2re1dYjZjPK6cXbayggYeOpiBcniVOe8aStj
	ldhZb7RZiklrnboO0MquBUxcpdDAnR3aFOnL/HzIXssMdY8hn9AkeH6xDVR4tofX
	rYW5hyrLveNflJWVikkwx62Dd90MdJmAlFQG53w/5Rw6/T5k++Ln0+TyhdZxnNsM
	JzA/VA+0/v6s5OPvt43w==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es4g52y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 15:30:33 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-97bf9109675so757842241.2
        for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 08:30:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787153433; cv=none;
        d=google.com; s=arc-20260327;
        b=aemoVT3kB0r0ie1An+lRuswYHtfO3RaXDZ3XBBtxZEmchEOBBihC67TDQzYzQ23SGp
         iPeIhjuhsnngGtCexuAzjptZSa7G5C6sgaL8rp2w6oz8VdD6Dr28iSxZkyKwK++LsV+C
         kn19EyYFbG9jqH6+2ve6GIGyuiEXp2ypwVwMxFiJBHLT5XpEgNpVxUCALNladHo1bAaI
         TGjZTZbJEYLMzjd65S4q5txL3xXK+OTYPozSrkXaYI6+J0DLrzSEq2cHFGwpa7SxkFRJ
         8/ELukuH7upMv8a/fWCacqC6tepndWsnlInsB8AXC/AtoHvpJ51T2vDeza2doWjVFEOr
         PpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=KBH/fUIgWYWW3/6b3lc46QqFXFbnfFKPLKLVEnp7Rdo=;
        fh=kLCqep2OwO/Ox+ieR06tixNjGH329iVu7Vw2n/x0dak=;
        b=qdqXjDd9EZ3q0Zy3BClPhJFWt7d5IfE1F4sdhPXh7Cldpvs/35FLAYtEDH1aMitlUD
         g52YGii2KRw6Wwl/3vUeumxk9kmpSqQZuB15aVktOE0MlIBxcr1PbXOlBIh5hNdfb7of
         AeUaUu642Bm4EhRu6+a+C1aJGir+ya+eJ1Aerckh/mVA7WafCiObtWKC6XvmpC91g2Rv
         pORNmqa5XG6Wymlq5Wem0sZql3l8FvVehswrM6jwE8yKK9Sl/TdhijWcuM2SpYvWLJYW
         egPemb8ZhLm2krxI0S94/8lZyfL5wWlj/gCa2IjgFOkRlUpW5GD1bFYXQpaxrBC4YvcG
         V06w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787153433; x=1787758233; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KBH/fUIgWYWW3/6b3lc46QqFXFbnfFKPLKLVEnp7Rdo=;
        b=NdFevLitfWIe1u68IQbMLAkKgcuSGFhjK+a/1ISqSeua6yPzORik+C3xLKpklakDgi
         aRL4xnqKXoQbVoQP2gSoGfl/5Vt0fZ9pTYq6oc+MoNy4AaFl5TCqHdDNJpCJgXAyYycC
         PaZPlm5qLdGBFiyJGIJOHl122ODM5eWq7klGJNFkPRXPA00IcnrJvW/WjJzGVc5FpC47
         1OHoU2EiOXbjlPKyishhjFvHYRH9okr3M+duPh18CQHNbasrdXIhKygBInmd2TCAu+HD
         B5IpALA5+OEDt2oNSZhUYR9uf29V6Zs4GmbT2UBdyNF6IeJC+Sv9aQdRsc/CGXViPyN2
         L0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153433; x=1787758233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KBH/fUIgWYWW3/6b3lc46QqFXFbnfFKPLKLVEnp7Rdo=;
        b=aD2ZnsRo8KKOBs/bs/iUyKi7xQkTW+73W+DAbwkU9LcpksPCwtMwRKBBmUOKUmD0PJ
         DvskDa9KZSwgSXeFCC04MfivTuPpjO4kY9d8FDAbaclDDK9IH7PMj9IvQ/3vEAkS8KWG
         IxJWXroTztlMSBm0AiLHK7/uj8uaReSvjQCrAVQk6GD91rU+waUoRvlIqm+QpfZktstV
         hh78q0/aEP0GQQ1aeSKVzIkKYEY1YXlh2h0r7osf3N4/caZO5EN11ZUh+ZSlbGB+QsSs
         JPfnEe1pfHnFNBJiK2l88Vw1lHjcHiyfh7VhhcwoWyaCCRxCpMclsnDS6nFZnIJOMKTV
         Icbw==
X-Forwarded-Encrypted: i=1; AHgh+Rqzb8alUlrlL6J9JB5EJBy/3leI6XihMHGGIuYQoiSW1USTInK/VLoHliPnN8DLPdHfIkEQGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJ2GhXcuRDPNP32lNwPj286TaX/4phebU7oQPetgc8hc235IcP
	d2fmdLzfWQG/fl4C7hyKEfrolMST4f6dL0OEo17H0JedfnH5xnpYYS9C7TUK/PuwWnafwQ+H0O7
	VmLhEWZfzqdxO5YLZOHdUa4UOcSTJRVisAB0963ay9hLLt5aF5GK10r5ibxVvXU72mmCCvX9zmB
	C1JqFOiEpguJnrfUhN8ol0uIuS+kBg0RFPOdmt1RE3
X-Gm-Gg: AR+sD13giN9OPkZqT+55BWDNq1VvP+Wz+IUpDKdqC0rmOTJpyGRfkPQpM1JKNwrevQy
	mFBi+SBjSGQL3nwx8ywPMt3dbx/siFXEhGyZrCJdaGIXVHWTigh641elAgXr4hk0wuRriGe7oBG
	2ov6KmZN/CCDsEI0w6VPO82F2o3BE9m4fYUCzoYKt4fWyejwyZ9vOSgnWu
X-Received: by 2002:a05:6102:148a:b0:778:5e9b:1668 with SMTP id ada2fe7eead31-7785e9b170cmr1538054137.12.1787153432519;
        Wed, 19 Aug 2026 08:30:32 -0700 (PDT)
X-Received: by 2002:a05:6808:1997:b0:495:eb86:6e8f with SMTP id
 5614622812f47-4b2bcaa116cmr4635236b6e.14.1787152998435; Wed, 19 Aug 2026
 08:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <3322b42b-3755-45ec-ad55-345125f0d488@kernel.org> <10349e29-b583-403f-a89a-9a00c73666bc@oss.qualcomm.com>
 <87dca76c-851e-4cc3-ab91-68949d283b79@kernel.org> <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
 <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org> <CACSVV01T=ytVJKM7NRoBTAJm7vH+JPJNT9Tftu5X9YskGXerwg@mail.gmail.com>
 <e7b4eceb-cb3a-49ea-bed9-728c958594b0@kernel.org>
In-Reply-To: <e7b4eceb-cb3a-49ea-bed9-728c958594b0@kernel.org>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 08:23:07 -0700
X-Gm-Features: AcwNN1WxA9fiQ0CGl4J8t7bFhD1MTRVpPgPEs_G6pBof5jMpK8zFCbjUKPrGqB0
Message-ID: <CACSVV03ypjBYkhRpt=TyDwOKhejKKke3x=Fi_TvxXN-5U_rCsw@mail.gmail.com>
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
X-Proofpoint-GUID: A_nTlP5B0A3JxclSHevwf58-Hz6ZbxT2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEyMCBTYWx0ZWRfX9KZHBmJSZbch
 Rcd6Yaz7lln4L/nsoejNf9bYtj+bfGjQq5to9J5UGRPIumJEGxXEbwVrYU5asgJNRLB1ZCo8UFR
 mq/dBb9sIKu+2Efv5kxghUFfL4BYOTgYsIBWqjGbNzrXNNFMn9T9F6bfA9Mi4t2FDXiLXqbtqNw
 uoBHdZi3lLZ2aCRaKscgJRVJ2kyLtNnhazjX5JVAiN4/YNbMjiuO58ETwR3d6YZrZQ8oXQO9xXd
 SJ6a2PxSO843+Mzz94bwSdkxb8daKaxlIpGJm2aWL5Epn6xeE//90ohpGvQLW8ZIgv9tFQfkbyY
 uu4LaHzlsFlyhHoORlXoFGJBWGb6G75g5YskMstZowwvq5faEa0hy0kn715vW6HRv18kJOOMCyd
 KFL6itM7wwZckfL9O/giYFzN+EPF0Y/srLWCnbyU04NyDQzLsdlPeMzTiDfBnVbGxblRwUPgQ/S
 oMLm5qi4p1ciKaYtt1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEyMCBTYWx0ZWRfX1O6B2nA5TF2T
 rEII4haOMTGZ0RmlIGlT0UQnp5uOu9E+2UW6Sdrrp8OGls0/u8MlbTO3HrcSuwpog7XDIX7lYxr
 GbBSZEFsw5mOLMZ8eucplVVPRDtcxkY=
X-Authority-Analysis: v=2.4 cv=CN8amxrD c=1 sm=1 tr=0 ts=6a85cc19 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=2opUpfO7wUc-A3Q1rUYA:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: A_nTlP5B0A3JxclSHevwf58-Hz6ZbxT2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190120

On Wed, Aug 19, 2026 at 7:53=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 19/08/2026 16:49, Rob Clark wrote:
> > On Wed, Aug 19, 2026 at 7:43=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 19/08/2026 16:38, Rob Clark wrote:
> >>> On Wed, Aug 19, 2026 at 7:21=E2=80=AFAM Krzysztof Kozlowski <krzk@ker=
nel.org> wrote:
> >>>>
> >>>> On 19/08/2026 15:26, Ekansh Gupta wrote:
> >>>>> On 19-08-2026 00:43, Krzysztof Kozlowski wrote:
> >>>>>> On 17/08/2026 06:47, Ekansh Gupta wrote:
> >>>>>>> This patch series introduces the Qualcomm DSP Accelerator (QDA) d=
river,
> >>>>>>> a DRM-based accelerator driver for Qualcomm DSPs. The driver prov=
ides a
> >>>>>>> standardized interface for offloading computational tasks to DSPs=
 found
> >>>>>>> on Qualcomm SoCs, supporting all DSP domains.
> >>>>>>>
> >>>>>>> The QDA driver implements the FastRPC protocol over the DRM accel
> >>>>>>> subsystem. It uses the same device-tree node structure as the exi=
sting
> >>>>>>> fastrpc driver in drivers/misc/. The approach for binding the QDA=
 driver
> >>>>>>> to device-tree nodes while coexisting with the fastrpc driver is =
an open
> >>>>>>> item described below.
> >>>>>>
> >>>>>> No. Grow/replace/improve existing driver instead of coming with a =
duplicate.
> >>>>>>
> >>>>>> That's a standard upstream requirement, basically given on every
> >>>>>> upstreaming guide.
> >>>>>>
> >>>>>> Please watch old talk from Greg - "I Don=E2=80=99t Want Your Code!=
".
> >>>>> Posted discussion threads here[1]. Would seek comments from Dmitry,
> >>>>> Srini as well.
> >>>>>
> >>>>> [1]
> >>>>> https://lore.kernel.org/all/3476b5c3-7983-4994-a901-3d7d8bd75255@os=
s.qualcomm.com/
> >>>>
> >>>> The rest of the comments is still valid even if you did not acknowle=
dge
> >>>> them.
> >>>>
> >>>> Anyway, regarding above - again, watch the talk from Greg.
> >>>>
> >>>> You have ONE driver. Not two.
> >>>
> >>> Long term, moving to the common driver framework (which did not exist
> >>> when fastrpc was first created) seems like a good thing.  But does
> >>> that not allow for some transition period?  How can we get from here
> >>> to there without otherwise breaking userspace?  Is there some other
> >>> precedent elsewhere in other driver subsystems?
> >>
> >> Yes, Iris and Venus where we agreed for an exception (two drivers) as
> >> long as new driver supports old hardware / features.
> >>
> >> This is not the case here, right?
> >>
> >>>
> >>> I suppose drm exposing legacy fbdev on top of drm drivers is _sort of=
_
> >>> a precedent if you squint a bit?  I'm not really familiar enough to
> >>> say if that would be reasonable/possible in this case.
> >>
> >> Growing old driver does not look complicated itself. The only a bit
> >> tricky thing is to present somehow exclusive interface to user-space,
> >> like usage of one disables the second etc. Depending on actual
> >> differences in that interface.
> >>
> >> But having a duplicated driver is a clear no go and it is well known
> >> upstream requirement. Nothing new here.
> >
> > Would it be acceptable as a first step to, by default (ie. when no
> > cmdline override/etc) for the new driver to bind to new compatibles
>
> You have one compatible.
>
> > and the existing driver to old?  Ie. have both drivers but only one
> > binds on a given platform?
>
> I don't see how is it possible to write such DTS, because - repeating my
> question - how many hardware blocks is there? I believe only one per
> given DSP, so how could you have two device nodes?

Maybe I'm misunderstanding something here.. I don't see any new
bindings with this series so my assumption is that the bindings are
the same.  What I meant was something more like "qcom,glymur-fastrpc"
would bind to new driver but "qcom,fastrpc" (which seems to be what is
used on older platforms) would bind to the old driver.

So single dts node, but different compatible strings picking which
driver is used.

BR,
-R
