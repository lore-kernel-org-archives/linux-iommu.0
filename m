Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798614;
	b=ai5uMTR1Hho/KuUkPxAW2N+nlaAdISPbeql/QVJSrotQhLOnJriXzWaI0Oxn56WF/zFl
	 noe8CTv3YH5BjYdpoDxlAQb3pGzrWm7QaeSTGz3SSK/uRb0Oy5LlS2jyCr8CtASgPrxMR
	 +Ed+qieVdiv/tWaHkYKCk+jKsKLwVqDmiGOuJlrrXSsVsr1NXZ/32SCB0f/onxN8wVW84
	 ymQ79GIhyQcHJ6l2fTGymsxjHwL5E8hOq/4anTJq/7ZJjr1LJF5r6lWVsnSCh39dwGy90
	 pwTNM0IigcfqT/hnx3EWit5FdG+dCNYKY/y/iodwm8NabDX+sYd6vdgt83krFcMwpGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798614;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Mgo2dnohmbku8+6gd0EG9FENz+puwwm3rQ80la31iuE=;
	b=IDacQNvmzS64NJsv7nm1wescwtWTG8IrwtGOXCzdcDSr4roaH3yEQjFxV7A/40sxjbcH
	 DQ+Ixes77AH0vuK+WKxp5YQOtd600LnH6km1ZLAdkJ9O2fpmBgk+MCAUkH3EEmUU/bm7k
	 9P9CON99STTBAExUEyfBDFGbBIqXnym+BkzD8ms8OJCsgsKmxhnR4olTQrXC6161Lryn6
	 tpujbjTOjZUY2Gl8hiEC2TYRUVzkEzhmEz14rEWWFuwLhEb7nirM8BwgyTgAqBBIDdLys
	 aZpGIUwv4ed+9JjCNMJHmGciUp/2ixMAIWOj058Wh/9mXwDWj1hnYbsCQLq1Siq/8lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=moYOHMFI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eiLEwO4w;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C9606A31F
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 23:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F6C9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=moYOHMFI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eiLEwO4w
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLvcUd3471173
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 23:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mgo2dnohmbku8+6gd0EG9FENz+puwwm3rQ80la31iuE=; b=moYOHMFI/3MRcJDz
	ZA8WnN7yEfSkWsyYp8v9+QFucDkTCQC8SKcTMqg6RzdAtSjs3QzyZzQWJj0B/Ck0
	RUVQ95Vua/zwF3kcxhebMt86PgFMZy42QbaGG1wXhzJI9u5QVSOEYPxzcdwRGL5g
	v8e/Cwpg5r/HTWQirguGNfljG9bsB9eUsY068Ty7mtfFWZ0WCbFD0USBCprfm2Cv
	tP4D5MY2tkdIdOtYAMZUXZa5Di76LOUTGCgvyc8GSjD9Fx7Ln0TieTpXRURC96qg
	+UKV4UvxmqsF+PWNhqI2HT9ElC6Wn/6oWhECs9FABEYmXr70LNHco9j/K0M4FKGi
	fs/lwA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcrugvuj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 23:36:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93ecdc701a2so192775685a.3
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792798612; x=1793403412; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mgo2dnohmbku8+6gd0EG9FENz+puwwm3rQ80la31iuE=;
        b=eiLEwO4w4a8T+O3TLWWYr5DvMTjYtJ9yxQRnofyKy/tJISE1K1gzhReGFcT60Y86Y5
         LiWyAsMcsq+IdrMcJwLc9tXThabdG1ziJ+VqAXk9pPoEZnPwPt1+RSGLUutQsuZteD6V
         YHbhDaKPSI9Q6z8xK36x9y3DS1U3SZyXBp4fV6V4xLgVde0AoZ/Qem3FlnT+LQc8lsmD
         Uzyv28J3Vn5+8wBbYCZweVUiSVppD3DQlwQgCtiOpEElEJ/38e3GJEBS1qp2sna8sS4K
         lRt0zPauAA/q0uiKpRiVp+jrFEJbhkEwBhFRxXTWdDCyfA2KD89aX17uJ3L9DG9q2p7z
         DsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792798612; x=1793403412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Mgo2dnohmbku8+6gd0EG9FENz+puwwm3rQ80la31iuE=;
        b=WtDWIe/EV7Go8sxvyqu6w10bzHhH53RKDFVCnAGNy9sD6fhf96ECXzx5QgxShDXU5U
         s/EHIMx1oF6VjOhoC9BzWvMaZx8qxWW1kWu6KykELWLrvVRRww2XxBSHf1CulKegMKHB
         8B1LDMsd4Myoj7usEVCuarFzxk4lBxm8OfS6hRlum+bgsg0S7pP8KoD4uE3hddXBw2yC
         A6opkwadPtdNws44UGnH1NZ41kHzkOOESKEzOlQrl8cUlhex+Q3aWhgCh8y7NgE0xGIz
         GoCS9R7cOd+v+5GVnGv2BAGYxvwOuZ0ywhBoGO5pohk8zIdb5gGty6htyOK8MO7qTxAT
         /HYA==
X-Forwarded-Encrypted: i=1; AKwUvBwfPMNVa3KVbTlWMrxGdqpyhE1IV7jUhrqBK4yYcbTejZXDiJOL7IXG7kefGmj0FT6SK0artg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIfQ9JQb0heJC8NPuUISLrsK5lLDm5TO3xZLE5NToimk6sgxl/u
	dpeRx/sHqDpKpNyWgM2hFm0SiXCKeB/CezT1/9kb/CZGGmf78Bivg+AO+p+KDDTfCQCfUAoGdte
	qI+1riAPZ41TxeCBmvzar8wf96ZZspSwnhaM1IUviww+FPiJSyO9uZw/5hw==
X-Gm-Gg: AYBFou3mMmcdSFdJBk3ci2BHSa1foa21w4TyO2HYmBvyc4h6pEhCe1uJV1ETDDq7wXa
	lXZXozhHTdK+rK49TE0bj5TLfRoq2KPJ8iR4vQTvLnoqdY/YPDNe1zANsNG7S0HtRKEokusbQcM
	J79aKYi03Mc+zqLP26FtUzGloY5TCZDwnE1+Y67nLsJtA5k0G6o3b7WK+ZZi3WtZQt8cbZ1zFEy
	ot5gnFljAU0EvO51E0nJgwtLmXsweST8GBRphpoVkUyBxDQmgh3yES6CpKo99nFknjQWL3JoPPX
	JlLZb0EcX7auHsC63zJXpbMXT6Dd1zI2dUBXR7Kzm2yQ46kVZe1N/WorEUBwxJ9LyFsKikd6PjF
	9+VQGaJOb5rgGR4pixooMn78EKMZtYnwXBemOtpJXIikUW6zHgqEdR8aoFl8srGJGjIBILSN6Rp
	SmQs/jHqQJgjD/
X-Received: by 2002:a05:620a:370b:b0:93b:eb9a:ca47 with SMTP id af79cd13be357-940ef938f5fmr84044585a.31.1792798611959;
        Fri, 23 Oct 2026 16:36:51 -0700 (PDT)
X-Received: by 2002:a05:620a:370b:b0:93b:eb9a:ca47 with SMTP id af79cd13be357-940ef938f5fmr84041285a.31.1792798611386;
        Fri, 23 Oct 2026 16:36:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7a6b051sm67463e87.14.2026.10.23.16.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 16:36:49 -0700 (PDT)
Date: Sat, 24 Oct 2026 02:36:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
Message-ID: <o2zmplbtmoueumw3iqejfsdmucp5f66woa5hmw3vodbe66reab@syn2ashugzyg>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
 <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
 <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
 <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
 <t5gu6ciwmxdb2jghc44gtixdsbedkgy4yzke5sgawjrr2h362u@ahvhh3yfe6lx>
 <wtun2cfukyzxlsfiz2izsejd33k4jpapwqa3uqih5drcsrkff5@e6llkke5dayw>
 <1f6db59c-b7a9-41a1-8022-6713365fa09e@gmail.com>
 <fcb86c33-1893-47bb-80eb-20acd65f3805@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcb86c33-1893-47bb-80eb-20acd65f3805@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MyBTYWx0ZWRfX6f2cgQUSpqvM
 fIUP43VLdH25n9owHShM8W4HTWE4oQWcE1EdFSo6uHpmx4yDdwp1c1G/dXJGFiCn0aKXBq6sM/k
 pOicOI3EvdkFoF0+b6Z2ZYmKQZhBZ6Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MyBTYWx0ZWRfX6KSzPZX15HYp
 NPk+OHvbazGJqUW09KhsoHg0MaXt+EdSgiL4r+hlccUbgtIZCOS9MfxUQfkOUvhwEYXn7RyPaRg
 CvR2gJs514nBz82ABnxbJu9ZYWA5jeIpdskm8PfDLLI2oAeCHGp10YTT+8cjPC5CK8InmI3JAQV
 xdsE7yMbzjB5F0QQIZ2FFxiN0S4cGRV3/sZNdZDMOf1pTN6MCiLUk79kBnfYsjO72/1Lw3AfQ5+
 Z6duXcOgLaZ0k2VHldBgaji7dcEL/WmoCjBSKHKoN9prG9/LmsBQ2cd35BZjo2HSiH44clRB0uN
 fZJYAZcm9LxmO732OcIHVh82wg9qH7lXsHU4gWgKlMCkRl8q+utIwC0wWgpF0mL9nqVAFEjXWxh
 Wm93ZDcxd+6ALZOSlhb1LEyFE0M6Cy8P7/nspwSZ2Yq1aoumX/6VNv7jEPDpUfj5IGuFzGE2hdS
 VD+jdYTJwd6CSCyGPpw==
X-Authority-Analysis: v=2.4 cv=Ju5kP84C c=1 sm=1 tr=0 ts=6adbef95 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=9jRdOu3wAAAA:8 a=s7fkfekX88plzggl2-cA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-GUID: eYFc0-RjD5sbwdZI-rMaORNlePXj0gTA
X-Proofpoint-ORIG-GUID: eYFc0-RjD5sbwdZI-rMaORNlePXj0gTA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230093

On Fri, Oct 23, 2026 at 03:16:27AM +0530, Akhil P Oommen wrote:
> 
> 
> On 10/22/2026 6:24 PM, Anna Maniscalco wrote:
> > On 7/9/26 9:39 PM, Dmitry Baryshkov wrote:
> >> On Thu, Jul 09, 2026 at 05:54:23PM +0300, Dmitry Baryshkov wrote:
> >>> On Thu, Jul 09, 2026 at 07:12:39PM +0530, Akhil P Oommen wrote:
> >>>> On 7/7/2026 10:09 PM, Dmitry Baryshkov wrote:
> >>>>> On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
> >>>>>> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
> >>>>>>> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
> >>>>>>>> In order to associate the SID used by LPAC to it's own domain and
> >>>>>>>> context bank we need a separate node on the DTS.
> >>>>>>> Can we use iommu-map instead of adding a new device using the same
> >>>>>>> addresses? You provide zero explanations, but it seems like you are
> >>>>>>> trying to separate a part of the GPU into a separate device, but it's
> >>>>>>> unnecessary.
> >>>>>> What I was trying to say is that we need to map sid0 and sid1 to different
> >>>>>> context banks.
> >>>>>>
> >>>>>>  From what I recall, so long as we use the same dt node, the iommu drivert
> >>>>>> provides no way of doing this.
> >>>>>>
> >>>>>> What kgsl does is having a node for the iommu and then subnodes for gfx lpac
> >>>>>> and secure.
> >>>>>>
> >>>>>> The address on the lpac device doesn't really matter. I have very limted
> >>>>>> knowledge of DTSs but I think we could just leave it out altogether?
> >>>>> I think, you were poined to the Glymur Iris patches. Another option is
> >>>>> the QDA driver being submitted too. Both ot them use iommu-map to
> >>>>> describe the same usecase - a set of SIDs which are used by the device
> >>>>> but which should not be a part of the defaut set. With it in place you
> >>>>> don't need to have separate qcom,lpac devices, no additional properties,
> >>>>> etc.
> >>>>>
> >>>>> I'd recommend following the same approach.
> >>>> iiuc, the conclusion in this recent thread is to use child nodes for a
> >>>> similar case:
> >>>> https://lore.kernel.org/all/20260618151745.GD231643@ziepe.ca/
> >>> Let me check internally.
> >> After a brief discussion: it can be either, depending on what suites
> >> better (and if you can persuade DMA / IOMMU maintainers to let one extra
> >> bus or not).
> >>
> > One thing sashiko is pointing out is that new dt should work with hold kernel so, in general moving sid1 from there would break it since old kernels don't know how to handle them separately.

The rule is the opposite: new kernels must continue to work with the old
DTs. If the new DT breaks with the older kernel, just specify it in the
cover letter so that Bjorn doesn't merge DT changes before the driver
changes find the way into his tree.

> > 
> 
> + Bjorn/Konrad
> 
> Not sure how strict is the requirement for compatibility with older kernel version. An
> option in your case could be just do an override in the board dts file of the
> Steam Frame.

Anyway, would it be a problem? Does GPU normally use SID 1? Or is it
only used by the LPAC?

> 
> -Akhil.
> 
> > Not sure how to address this.
> > 
> > Best regards,
> 

-- 
With best wishes
Dmitry
