Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38FB2E4247
	for <iommu@lists.linux.dev>; Sun, 19 Oct 2025 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760876006; cv=none; b=qd8llFzRWszugD/vt4269EB6YFS1NgSxVvnJWg2UE5bZqKqAQiNpcb4/iDt7b3B9EEI5f7HAqLeB9OPAEAa7uTTTmkTCSAVm/5c3shjXp01pEi27KFzYjmbd9OVXPsJcegzo5zufwvcyoyF35e1jviEXiteUYLxeDGTc7tm9NvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760876006; c=relaxed/simple;
	bh=HSQA+Pd76pKK16Rnlbrdl2QZ+5IMbABb8mM/skpID+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctVa8LRp8MdsXYhd940Zku4IsZq6PHzg/uIvFGGi/0Qdo97v2OUO3TcWgncnlmLehgYVACSnLUZZbNA9QN6R2PMYvy4qo5m/0b2L4dFhHAGmRpyXTvw6/+vk/zIPEzX8wtB7fBUfDr3XEc6aXQu2tMVF3/ALcc5WI+aOXIdsoxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U4IhH/Qx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U4IhH/Qx"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JAVNVk015854
	for <iommu@lists.linux.dev>; Sun, 19 Oct 2025 12:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sLjMakJS7ssq/syc/5Yvc6UyrE0zE/sWbLAaJ/RVke4=; b=U4IhH/QxRsqwWpIR
	8Y7+FuRQRBqAX19fHyn8fkE93Mji5Wsc6hQ5zd0GnE/TBn9PqtB0IHFejlwbMgMX
	UsfPEIFO2m/CZEvfMTeUOj9FhtkEnaqQZfffhSQrKmf5IhyEZC0kQ8/DBK3SLl1o
	pOH2B5ZUqOBA7xKl2cYnrKYiF0dKMYex8jIGL2WbmMBLeFj1Eg324W9Ksv48B6nI
	TaIpFEyr49Ow4xpM9pzk6gefkEbsBvLrm+vDlh5Blm4wwZW7AwwCBpF5vvSM0wwt
	3zRTVks4lCdOMcrto4/m4QrEUgV7XTLqbdglELQ7ASNv9oOz8pGQZBimaBglsKvI
	tgtjMg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27htdjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 19 Oct 2025 12:13:23 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-86b8db0e70dso155583766d6.0
        for <iommu@lists.linux.dev>; Sun, 19 Oct 2025 05:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760876003; x=1761480803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLjMakJS7ssq/syc/5Yvc6UyrE0zE/sWbLAaJ/RVke4=;
        b=SrtYKhyAJ1UfFmv2jSXsfHt92b4B9GIRb9TR5zT/D2VkXbWncs+K7BQHT8NugQXArf
         lYOjfhpw1DCNjuBtST0TQaIim74qEJHE7gbOKaKE8FGNXb38spvyGaz+gMN57T2yjz+I
         hfaVpXNE7AwhySPctfUTzBVobXX9oClNV4D1PrNKPDfWwuHCLRI+cQDkUC0dRgcJKc/h
         5UBxAWL7cpXK7vXFHRwwlvanLtCgs+deaKvgokg5a0Io4XnNDsnTDavGhHR5Di6Afe6s
         DOz4rLOin1CeefFnDoHCi7QT+iJrk961cAipAszNv1MP5Jr6WxTc7rzM2t3E86afccsZ
         Syug==
X-Forwarded-Encrypted: i=1; AJvYcCUehJK7enhgBrS1wdH9ZXwL3A4QvGHwL0MVsksnf/NDM1zs4wrfbn/NN/PuIheDM2W9p13LtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxBh7Okc9hrP3rHaJaUhFqnlxqBJtxKWN7A2MbrkYCex4Vv3xG
	MPadU/lEtKjmYFmMmfARYbGOREgLcbmZKawuHjTsIzJoLXOIg6KQpkYe8fnBnBKJkfvCTmyxgqR
	gsQ0UDTsXpDbbWickD/ZfICGIr6OKN1OI+i378qxSOkVJm5lVqP6Oy9khhA==
X-Gm-Gg: ASbGncsWhn+3utfPHMCcn7NUhKsayxTskUGu+zTDJWfAjIlusTmI/iR5XGw5TmUzdNx
	wjmq175O8g0zCNFvEi98WguxT+W3Rx06Pn3652b/qVOHSd0xK6DoLhEn1vGieV6ILiWZ/InQ2ka
	qrMRPbcEogJPEyUqwF3I4zdMwnFhhSu3lmdiDZz7AXAkFH2akuP7cQAs0nK+eUCxnbTEJTiG+Ey
	lwX5oJ/LyP8ZIF8TDiGwwbkCZo1Z5pOPM9SW/8+V4UZaA6ej7/cVwMln4pw1XADKmCYZN5EnP+u
	xXJh2PiUBQYWDZU9anbI8zNoMiyYSGcBG+ANWKcR9jTh23SukUSccwpBOVuem79mQ3E3h8JRCv9
	uyxXoYgaqSXFWjaVA4Z6dwJDrvUd3JJJD84KSjYkCKgFKsW8rLxFxod5zLJ8T/he19E1oSFOhv1
	pg2jZv175+xcA=
X-Received: by 2002:a05:622a:2c2:b0:4e8:a696:386 with SMTP id d75a77b69052e-4e8a6960b70mr83928771cf.12.1760876002505;
        Sun, 19 Oct 2025 05:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIxrvYE1Mmu01UNr8hJKcsKXWXAX8Kw6fsxCn/jB3654Qx/Q1k+3HFFgrbRnEygIt/TWeH6Q==
X-Received: by 2002:a05:622a:2c2:b0:4e8:a696:386 with SMTP id d75a77b69052e-4e8a6960b70mr83928261cf.12.1760876001928;
        Sun, 19 Oct 2025 05:13:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def26992sm1517277e87.103.2025.10.19.05.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:13:19 -0700 (PDT)
Date: Sun, 19 Oct 2025 15:13:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
        saravanak@google.com, conor+dt@kernel.org, robh@kernel.org,
        mchehab@kernel.org, bod@kernel.org, krzk+dt@kernel.org,
        abhinav.kumar@linux.dev, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        bjorn.andersson@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] Introduce iommu-map-masked for platform devices
Message-ID: <k76davhj2ojqrccfdzx5csvyfm2cwz2xgnxxzwcuiy44k7zwyh@bsnw3ny6uydz>
References: <aec0f40a-8346-4194-8b18-1022fe3366bb@arm.com>
 <0d0560cc-9757-4c7b-8de4-170148d99481@oss.qualcomm.com>
 <ead7cf8b-fbc4-4242-a9da-b313dded1abc@arm.com>
 <nzqte4glwtpjs5bhkxz43yhdufelxvqvzmg5tepudxwetimir3@bvlw5csjizsh>
 <9d3eeb9f-b8ea-48e5-a1d9-0865f63ef991@arm.com>
 <fhb4woejzh3r6v5dxvdiopnsbuwstucfuuzbiymxg4wrxrjc7t@dt3z3utq6lwd>
 <8d88cd9d-16e8-43f9-8eb3-89862da1d0c1@arm.com>
 <zcgn4xw2xghyna2eysavujbzbiydyki7p7upzzv7one5mdyjy6@sj7f75kc4vwu>
 <58790287-4787-4763-a979-69df60de9263@arm.com>
 <3394e094-ffb5-4503-adde-7c382e3f2f6e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3394e094-ffb5-4503-adde-7c382e3f2f6e@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX/1Pvwl7gsmIi
 8NTaGobs0xQlimaGMtqMyLoMNfF+OSCRNftpqLoWEIOn7dofnofe3Bt1kg4vMKT4QZkhhEHA4As
 HYEDGib2F8NT7bwJ2StF+tROwSGfhxcWR7ftk1x3AbhPzxPw1THKee9+rvKhoiXaT7VC0NeerWX
 wf/ILAVmpNr7EXJ65C5D2A+jTtkQl7y9eSFVPIbAr9h+0r+kHB/gc3l/J+4fCnNQDScQizO5U4M
 aITuIyM9vjQLqEkEFfxpySOPAlob4OOsJxMXvY80Hss5WEZ/vH/lrjEMl3g2S81WZQELgZ4nGkq
 DYpFvCJ/wsAugAHss6zthm0cn7eOLy0AOkYd7GK9onSJibL3W+88YwTwjvZa7xFg6RV2RNy/oZl
 33mmWVJ7cvi1d1ospSfS6I+QUVgKjQ==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f4d5e3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=tL-A2WhEFdlIpSB3ntkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ndYeQZR1jWZk63W6ldpmVQYS1hp6TQ5a
X-Proofpoint-ORIG-GUID: ndYeQZR1jWZk63W6ldpmVQYS1hp6TQ5a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On Wed, Oct 15, 2025 at 02:02:10PM +0530, Charan Teja Kalla wrote:
> 
> 
> On 10/14/2025 7:37 PM, Robin Murphy wrote:
> > On 2025-10-13 1:31 pm, Dmitry Baryshkov wrote:
> >> On Mon, Oct 13, 2025 at 12:20:54PM +0100, Robin Murphy wrote:
> >>> On 2025-10-09 7:25 pm, Dmitry Baryshkov wrote:
> >>>> On Thu, Oct 09, 2025 at 06:03:29PM +0100, Robin Murphy wrote:
> >>>>> On 2025-10-09 2:19 pm, Dmitry Baryshkov wrote:
> >>>>>> On Thu, Oct 09, 2025 at 11:46:55AM +0100, Robin Murphy wrote:
> >>>>>>> On 2025-10-08 8:10 pm, Charan Teja Kalla wrote:
> >>>>>>>>
> >>>>>>>> On 9/29/2025 3:50 PM, Robin Murphy wrote:
> >>>>>>>>>> USECASE [1]:
> >>>>>>>>>> -----------
> >>>>>>>>>> Video IP, 32bit, have 2 hardware sub blocks(or can be called as
> >>>>>>>>>> functions) called as pixel and nonpixel blocks, that does
> >>>>>>>>>> decode and
> >>>>>>>>>> encode of the video stream. These sub blocks are
> >>>>>>>>>> __configured__ to
> >>>>>>>>>> generate different stream IDs.
> >>>>>>>>>
> >>>>>>>>> So please clarify why you can't:
> >>>>>>>>>
> >>>>>>>>> a) Describe the sub-blocks as individual child nodes each with
> >>>>>>>>> their own
> >>>>>>>>> distinct "iommus" property
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Thanks Robin for your time. Sorry for late reply as I really
> >>>>>>>> didn't have
> >>>>>>>> concrete answer for this question.
> >>>>>>>>
> >>>>>>>> First let me clarify the word "sub blocks" -- This is just the
> >>>>>>>> logical
> >>>>>>>> separation with no separate address space to really able to
> >>>>>>>> define them
> >>>>>>>> as sub devices. Think of it like a single video IP with 2 dma
> >>>>>>>> engines(used for pixel and non-pixel purpose).
> >>>>>>>>
> >>>>>>>> I should agree that the child-nodes in the device tree is the
> >>>>>>>> easy one
> >>>>>>>> and infact, it is how being used in downstream.
> >>>>>>>>
> >>>>>>>> For upstream -- Since there is no real address space to interact
> >>>>>>>> with
> >>>>>>>> these sub-blocks(or logical blocks), does it really qualify to
> >>>>>>>> define as
> >>>>>>>> child nodes in the device tree? I see there is some push back[1].
> >>>>>>>
> >>>>>>> Who says you need an address space? Child nodes without "reg"
> >>>>>>> properties,
> >>>>>>> referenced by name, compatible or phandle, exist all over the
> >>>>>>> place for all
> >>>>>>> manner of reasons. If there are distinct logical functions with
> >>>>>>> their own
> >>>>>>> distinct hardware properties, then I would say having child nodes to
> >>>>>>> describe and associate those properties with their respective
> >>>>>>> functions is
> >>>>>>> entirely natural and appropriate. The first example that comes to
> >>>>>>> mind of
> >>>>>>> where this is a well-established practice is PMICs - to pick one
> >>>>>>> at random:
> >>>>>>> Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> >>>>>>
> >>>>>> Logical function, that's correct. And also note, for PMICs that
> >>>>>> practice
> >>>>>> has bitten us back. For PM8008 we switched back to a non-subdevice
> >>>>>> representation.
> >>>>>>
> >>>>>>> For bonus irony, you can't take the other approaches without
> >>>>>>> inherently
> >>>>>>> *introducing* a notional address space in the form of your
> >>>>>>> logical function
> >>>>>>> IDs anyway.
> >>>>>>>
> >>>>>>>>       > or:
> >>>>>>>>>
> >>>>>>>>> b) Use standard "iommu-map" which already supports mapping a
> >>>>>>>>> masked
> >>>>>>>>> input ID to an arbitrary IOMMU specifier
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> I think clients is also required to program non-zero smr mask,
> >>>>>>>> where as
> >>>>>>>> iommu-map just maps the id to an IOMMU specifier(sid). Please
> >>>>>>>> LMK if I
> >>>>>>>> am unable to catch your thought here.
> >>>>>>> An IOMMU specifier is whatever the target IOMMU node's #iommu-
> >>>>>>> cells says it
> >>>>>>> is. The fact that Linux's parsing code only works properly for
> >>>>>>> #iommu-cells
> >>>>>>> = 1 is not really a DT binding problem (other than it stemming
> >>>>>>> from a loose
> >>>>>>> assumption stated in the PCI binding's use of the property).
> >>>>>>
> >>>>>> I really don't like the idea of extending the #iommu-cells. The
> >>>>>> ARM SMMU
> >>>>>> has only one cell, which is correct even for our platforms. The fact
> >>>>>> that we need to identify different IOMMU SIDs (and handle them in a
> >>>>>> differnt ways) is internal to the video device (and several other
> >>>>>> devices). There is nothing to be handled on the ARM SMMU side.
> >>>>>
> >>>>> Huh? So if you prefer not to change anything, are you suggesting
> >>>>> this series
> >>>>> doesn't need to exist at all? Now I'm thoroughly confused...
> >>>>
> >>>> Hmm. We need changes, but I don't feel like adding the FUNCTION_ID to
> >>>> #iommu-cells is the best idea.
> >>>
> >>> What? No, any function ID would be an *input* to a map, not part of the
> >>> output specifier; indeed it should never go anywhere near the IOMMU,
> >>> I don't
> >>> think anyone suggested that.
> >>
> >> It was Bryan, https://lore.kernel.org/linux-arm-
> >> msm/9bae595a-597e-46e6-8eb2-44424fe21db6@linaro.org
> > 
> > Ah, I wasn't on that thread. But indeed, as I hopefully explained
> > before, that whole idea is a non-starter anyway due to who the consumers
> > of "iommus" actually are.
> > 
> >>>>> If you want to use SMR masks, then you absolutely need #iommu-cells
> >>>>> = 2,
> >>>>> because that is the SMMU binding for using SMR masks. It would
> >>>>> definitely
> >>>>
> >>>> I'm sorry. Yes, we have #iommu-cells = <2>.
> >>>>
> >>>>> not be OK to have some magic property trying to smuggle
> >>>>> IOMMU-driver-specific data contrary to what the IOMMU node itself
> >>>>> says. As
> >>>>> for iommu-map, I don't see what would be objectionable about
> >>>>> improving the
> >>>>> parsing to respect a real #iommu-cells value rather than hard-
> >>>>> coding an
> >>>>> assumption. Yes, we'd probably need to forbid entries with length > 1
> >>>>> targeting IOMMUs with #iommu-cells > 1, since the notion of a linear
> >>>>
> >>>> This will break e.g. PCIe on Qualcomm platforms:
> >>>>
> >>>>                           iommu-map = <0x0   &apps_smmu 0x1400 0x1>,
> >>>>                                       <0x100 &apps_smmu 0x1401 0x1>;
> >>>>
> >>>>
> >>>> But this seems unlogical anyway wrt. apps_smmu having #iommu-cells =
> >>>> <2>. It depends on ARM SMMU ignoring the second cell when it's not
> >>>> present.
> >>>
> >>> Urgh, yes, that's just broken already 🙁
> >>>
> >>> At least they all seem to be a sufficiently consistent pattern that a
> >>> targeted workaround to detect old DTBs looks feasible (I'm thinking, if
> >>> iommu-map size % 4 == 0 and cells n*4 + 3 are all 1 and cells n*4 + 1
> >>> are
> >>> all the same phandle to an IOMMU with #iommu-cells == 2, then parse
> >>> as if
> >>> #iommu-cells == 1)
> >>
> >> How do we handle the case of #iommu-cells = <2>? I.e. what should be the
> >> "fixed" representation of the map above? Should we have usual cells and
> >> one extra "length" just for the sake of it?
> > 
> > It's not really "for the sake of it", it is the defined format of the
> > "iommu-map" binding - IMO it would be far more horrible if each entry
> > did or didn't include a length cell depending on the size of the
> > preceding IOMMU specifier. It's also far from infeasible to have *some*
> > well-defined relationship between a non-singular input ID range and a
> > multi-cell base IOMMU specifier, it just needs more IOMMU-specific
> > interpretation in the consumer than Linux cares to bother with. Thus it
> > is appropriate for the binding to be able to describe that even though
> > Linux as a consumer continues to refuse to support it. The binding does
> > not describe Linux, or the property would be named "linux,iommu-map".
> > 
> >>                 iommu-map = <0x0   &apps_smmu 0x1400 0x0 0x1>,
> >>                             <0x100 &apps_smmu 0x1401 0x0 0x1>;
> >>
> Dmitry,  Wanted to understand if you did consider to include additional
> #iommu-map-cells in the above representation? or it is just based on the
> #iommu-cells?

Just #iommu-cells, as suggested by Robin.

> 
> And this is the same representation for PCI devices as well or it is
> still parsed as if #iommu-cells = 1 just for old dtbs based on the
> workaround by Robin above?
> 
> so, it will be like:
> iommu-map = <rid/func-id phandler sid_base <mask> len>;  and if mask is
> not defined, treat this as if #iommu-cell = 1.

Yes.


-- 
With best wishes
Dmitry
