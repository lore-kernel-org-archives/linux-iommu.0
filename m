Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F523BAD81
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150298; cv=pass; b=Tj2k1kljfcA6T2/4PUunsfIwgKJWHnVZV6FIm9Kx8NurRRClL5LumOiVpl2vWJSHTU3f8swCU+96rgeIXjVs0sPT4PyIrdkydgm92lnCC1Twls8iTblxekv8howOYJKQ8zN+vh0A2jtlQQNDgDFg8sTNkT1/h0CY8IJetsDP/+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150298; c=relaxed/simple;
	bh=JOHfuMDahWJpprTXbJI3zSINoNZd4BLeLIcmol+bfrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eS8hTUxbhIG1OcRAYaJTnIXegas4ElRPDY26snFmP4Cu65QXpuwxJVaAd27GhYwWBvNExPvmKTXGKMfO5My3YwNjVQ3G+tqz+3VWZA62oduO4HHgWOobImGV7hmeZexULbnIIxmBMnk9vagVfa01nRQG3d0grIC4aEoGsas9Uzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GPeudUYz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q9Z2D8Cq; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GPeudUYz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q9Z2D8Cq"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JEbndj068018
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 14:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=OV4Etzi0F84EHavFR+Cnl8cEpGoAZCQzZFi7p8gpeMI=; b=GP
	eudUYzAmwpt46XExjtHoL24a2I/8JX5JZHI9Hy6CbC7dO1tazpRAgFP+VcfrugoN
	qQqsW9ubazohF9DaVxrl3s/LKRe5kznPmCK3LoVzh6vJ+iebuKHns765pvdU8/jk
	Lx7WZ4bv8UVCBWYHz3m6v5/GnJT2VNZ0ww0LUj8Ylet1jPbTbGqxlh474I7MyGKO
	RI1PPcRlaETWg5xn/0/ig7ssX0OVcLJI/cDW3vOkQPZjH9SybyNVUYXczHdUhTB5
	BQOZ3N3z7a1vzgCS4xi5BbzZii7NWgVe1Zsvy1mFlVQsrVsTo6F9HCwWhsQoGkSA
	JLDz4rujLqSxMRs9pEMA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5e5d02k5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 14:38:13 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4a7de733fa9so1362863b6e.3
        for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 07:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787150292; cv=none;
        d=google.com; s=arc-20260327;
        b=GHkmosBX7Iw0fOBdnl7NhmtSjUCqTUFmr0TGQBiw8znDXaDyjh+NM5NcG/7J/h8lCy
         4PEHuITsQwVmNaXzpss+3jGDW23UQK3lrK5fmuvYVeHoEQlqes6NoECT8GaTF3QdYMv/
         vTAEKdWUhlUkcx5Pvpx3ly/kpqFkw157TXv5tbeJgkgajtUkiBrgqUS2rgVCYIUTeRvy
         odmG4oRxnuH/qWDPjKf5ha9hrkCTMqc/mw28U0Cfm2tfoQoUJ0w6+U4yIL1NcWmnZZij
         4qgvVwv199Gqh7kWuwv/XLVlabamMI8yVmDnuj1SQf1g6Lb3ggev7wdo6INFxeAZeo+c
         bTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=OV4Etzi0F84EHavFR+Cnl8cEpGoAZCQzZFi7p8gpeMI=;
        fh=Rw2rzaPSPx0a3yNXKqO5lUquHUMXoKX77/lGtyJVMdk=;
        b=bQwq2WEiXScm/dixAG51R/YI1d1WLjfcO6Ea8jxU7GekpMIm2mQU0eaa8dnNCOPVJo
         w7E0gHXwyCo/zSMwURdhs3qcfJlUusCH4s2Hlid6T8iTOkbor6u/Z8vGdGVkI/3kdHyH
         PlSx09AB4+dQZ+Qde3jpzaUgxDcX9Sx1Y1vABdzqag1wA1OhOoV9F5KSGoBMGmcqUfdq
         OFU6sq5IvRX1qUVwDOhE3Fg8tCLkHDtR+syt87bncvd3secp/HJKDPCbYBdulUobMZRo
         uuc3BpTuzxUQQ9563QaulvvBcDzI0vR74cQEdaQTAvw/o/mQfZkx0OT3r8nTG3CW/4mZ
         toPw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787150292; x=1787755092; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OV4Etzi0F84EHavFR+Cnl8cEpGoAZCQzZFi7p8gpeMI=;
        b=Q9Z2D8Cq7DOKAI6AMnCnxUHsuTlipq453Fcxj8hGHq7oCm2b4Wjvp6suuvYbKieGz/
         dvQaFs8kXXVECsnDU55WjLPcOvo5TT6L+DiUZZ5dzkfJN9jHmCxSvbT0AhHfbGkkL1wK
         uIbV0snOavO1Xz3xiqqgNAhqmsoC7Gq+FJrBE6exwgnXUgl1FjPsxCd/rvwyRu9JBa2J
         USOLeqcfEAlc9vRFqoCZSQuvMhcXiq67bpQDZhkwdQ1xdEzOfycykiAjRfx3khgHJNJS
         M+eSKjUDsnYkltj9tsVttDoBHvUQxI/6TQ1Fdqe0Svm4hfE+mQqKkpjnGHLgpPVEjy29
         fIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787150292; x=1787755092;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OV4Etzi0F84EHavFR+Cnl8cEpGoAZCQzZFi7p8gpeMI=;
        b=pGjxT6YxN47TwtT6+ctd5VC9GjoGK5iDQ428qzBIseufedCQc9KO/r0C9C6GkWnou1
         LdfExBYXCDO7ygkWbBZMbj12rpFZG7OLSArPjFxxs9jJQZe18ufOAP15F/adf1FKE4Xj
         YmnxHydxRZRt1ryuOK+bYnQ9g90voFclL3IP3lGEfCgKXTkKKpHWwGhhAIk259ryoWOs
         JQne/YrkqI1pTVn4oLAGTyvkcpvaBUKsUWljdOtACdAuthuei3Kbg5MiZIFn6f0sAQpb
         esTRQ5FED8/63lfQEGOAV6Qldi2B7yXfqq9yEGOpIs4QFZ6xfKhDwbdbn4+dsWIAqPXj
         EJsQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro81TDb+lB64/r9C8A9WWfq2gljEf29ZCN20jyyEa3YwDCl4GM2m68WYGI0teJ+t9VNf+MVzA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzzad4irDULp2XdOx8x8FXGT3BFxlff6671HQXrC3UgyqghWVVj
	VHmKiqgeNcqaxer3p1RKPhz1/7Q7QwrtzqeXvHe1oQXPlu3Yjs53IUG1c6lyzAM1FlMFGhH8RbE
	0F5vmyH2dAL2r/4vLKIgg6ilmKgSI74783Ek2psf3Cv5g9nlxme9XdGASLst6OUloQ6X2GN+PE/
	xr9aqPfCz8U95FXP2NtawD1FxflKyXeLkV
X-Gm-Gg: AR+sD103fZpC7nSPRi+vydK++VGlnB9mI7FJofzgFYQ0o43E/oIL8AE2MN4HFMcUFhq
	/K7uJUACpVvNFTNGxgwnnIfF5SpxE8gi7GH7liO9KIUZ2n/UnR4FA9h41ytjdYWRXaKUHd1bPfU
	sSmt3u99th5xQLvzu5zR47NO3tCJqADFBUDn5o97tC0UcIpLAVRueWNmtL
X-Received: by 2002:a05:6820:1ca2:b0:6ac:b1ae:6ce3 with SMTP id 006d021491bc7-6b13c69056emr3835939eaf.32.1787150292237;
        Wed, 19 Aug 2026 07:38:12 -0700 (PDT)
X-Received: by 2002:a05:6820:1ca2:b0:6ac:b1ae:6ce3 with SMTP id
 006d021491bc7-6b13c69056emr3835876eaf.32.1787150291802; Wed, 19 Aug 2026
 07:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <3322b42b-3755-45ec-ad55-345125f0d488@kernel.org> <10349e29-b583-403f-a89a-9a00c73666bc@oss.qualcomm.com>
 <87dca76c-851e-4cc3-ab91-68949d283b79@kernel.org>
In-Reply-To: <87dca76c-851e-4cc3-ab91-68949d283b79@kernel.org>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 07:38:01 -0700
X-Gm-Features: AcwNN1UJH0MueaAt4fuAnOTplgnMr9BZwDd-FRtcH8UIxmOIWCFCFvjMK1YdptU
Message-ID: <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNCBTYWx0ZWRfX9G0QJ+rBPzfF
 8WhUopAoF+S65Xx0+4/8E7vuq5pb1nJv5TTXYeVQgNZXLklOPHfxMBP5deTzewqfmLyDGiWKZmg
 fBxBIiEpPbFNqA5ttUF/BvAVPdqahQ9t3iWOnERMK0m0Q2Co3N5iyzbvYjWB38SUfozZT2YS+KF
 nBQyhVYHAWnFVP8KZ8mDeli4/MZieM8uRmAxaUgKd457Gr4tl4yyYOL9s5Kc+hYcDJEqKZ3Mdjh
 jilDv3RfP8iIydWV7fY/ec4gG/8o/6AM5GAJTTPrHCZBCO+vLMSthPCJKFg+6Q7THdvNpJnUOsf
 no7XFFggITBwkc5t7VTafQLQRomoBwnlA1w4fkFVSFI24+P6G+iOFBgC9XfGJc/MYBMl8zt8ba9
 d30bKP+kPDFfkwJ0TeUUWszdNRxKoM6uns74khgcb1UEJESWurI9KqPDDKR2ACIEaEPbBGVhhQe
 OF7FTHYnWCzd0i9OKCw==
X-Authority-Analysis: v=2.4 cv=cuOrVV4i c=1 sm=1 tr=0 ts=6a85bfd5 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=OXa2z63zbhD_Ho30eBkA:9 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-ORIG-GUID: QNKFmym7B64YtxEN49BiTKREWbVnxFVz
X-Proofpoint-GUID: QNKFmym7B64YtxEN49BiTKREWbVnxFVz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNCBTYWx0ZWRfXx1Z7eGrQ8neQ
 C24hSG5lUXMMqhTispSgpCEaHU916usqScTPegLR+pVpyCzENITGsKaAAK6sqB813g+rMdAM8D9
 TRfYlWvRaIG9rDkgnpNHKpp/YYLSVA8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190114

On Wed, Aug 19, 2026 at 7:21=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 19/08/2026 15:26, Ekansh Gupta wrote:
> > On 19-08-2026 00:43, Krzysztof Kozlowski wrote:
> >> On 17/08/2026 06:47, Ekansh Gupta wrote:
> >>> This patch series introduces the Qualcomm DSP Accelerator (QDA) drive=
r,
> >>> a DRM-based accelerator driver for Qualcomm DSPs. The driver provides=
 a
> >>> standardized interface for offloading computational tasks to DSPs fou=
nd
> >>> on Qualcomm SoCs, supporting all DSP domains.
> >>>
> >>> The QDA driver implements the FastRPC protocol over the DRM accel
> >>> subsystem. It uses the same device-tree node structure as the existin=
g
> >>> fastrpc driver in drivers/misc/. The approach for binding the QDA dri=
ver
> >>> to device-tree nodes while coexisting with the fastrpc driver is an o=
pen
> >>> item described below.
> >>
> >> No. Grow/replace/improve existing driver instead of coming with a dupl=
icate.
> >>
> >> That's a standard upstream requirement, basically given on every
> >> upstreaming guide.
> >>
> >> Please watch old talk from Greg - "I Don=E2=80=99t Want Your Code!".
> > Posted discussion threads here[1]. Would seek comments from Dmitry,
> > Srini as well.
> >
> > [1]
> > https://lore.kernel.org/all/3476b5c3-7983-4994-a901-3d7d8bd75255@oss.qu=
alcomm.com/
>
> The rest of the comments is still valid even if you did not acknowledge
> them.
>
> Anyway, regarding above - again, watch the talk from Greg.
>
> You have ONE driver. Not two.

Long term, moving to the common driver framework (which did not exist
when fastrpc was first created) seems like a good thing.  But does
that not allow for some transition period?  How can we get from here
to there without otherwise breaking userspace?  Is there some other
precedent elsewhere in other driver subsystems?

I suppose drm exposing legacy fbdev on top of drm drivers is _sort of_
a precedent if you squint a bit?  I'm not really familiar enough to
say if that would be reasonable/possible in this case.

BR,
-R

> Best regards,
> Krzysztof
