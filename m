Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785712BD00C
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493156; cv=none; b=b7IbZAfgF1qTXASMQEHo3Wv5s1QVOTtdOYibUoddXzpz66RNs0A7SDD7O2IUzo5/4BsWd9mCg0XK/mDVpmXM6lp1Ki2hJB/BVsAIslFKAAB+D+rxysvkVz8JS4Re7lla4q9/Yx/OdFswsSl+qmO7rDqAri/z5c7QVxjK4sOmfL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493156; c=relaxed/simple;
	bh=qKuP1aYXbsLJv6x6e4VAWHfEB3D/VfGQIgMjqDkaRw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9W8S+IBrrd08ovCwpXVaant6SIxJYd7IO37oPG2RWgkzJ/36ddn55D+ImUSZzNnlvPm0z7CegqK+690T1Kmx1Jad84oyIVZOqDA6qCrT1G8QXUhOCA5+I2iGbMGCxPasidGrffft0fScMgI1yKDMxUqztVVe83TNER8WT/2P3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ODNZo4nN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fV3254qb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ODNZo4nN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fV3254qb"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65395qkV780719
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 13:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UhFwddlTFY09oF6cy7oYeNVke04XX3DNuQUC89hSDWQ=; b=ODNZo4nNljDaEEsi
	1dIvaUauNqUhkE5Fr31T394FGhgER/rCJQmyJBP1E+y1HnlSMLtKzu4uVtE+5e0A
	GTGjk5Z3FWKAq11NdlAKHmno2R+/mnw0barEmTPEZ/d4dKsWpSz2iBND3GpY/8q1
	+W/x/yk7omU/OqmyDBntXvKs4JPTMJcN6AVR/o08V4KgVkKl49lO5ce0uauypmdi
	aNiimcbLZTdoJBZAlKgUtz4Rp4CX6PtW00AFT/5gRhHhRobXcLfGEDIU1ZFdKfpI
	lXu8ClEOdxoMM0Jr+LoK89idmcGNfciwX+l9ud9ovRuYF4ZptNkozDdSMIi2tYLm
	0lTb5g==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejhbb0ym2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 13:25:54 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-59ebf600cf4so7148120e0c.3
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 06:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780493154; x=1781097954; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UhFwddlTFY09oF6cy7oYeNVke04XX3DNuQUC89hSDWQ=;
        b=fV3254qbOBDranna5RF2huQsXguL9v5BQrFOcQcZ9fW8KJf8DvID3sA/iiLWGvj24M
         0qTkmyo56Y3R280zdynPWLt+2AVLZF7+/aeYu7TTcGurhprJfkB3cF9Ms5NiMoafxvNe
         aJcW0WPU7ujlJjcCxodjU7CgXfWLK/DMddOLCfFwBeo7UKg3S5ABt5lf0Yui28FSJJGE
         yN9IEsoFMUHjfG4VWdNwONsevlQXxHPtYj8cncTLtPFcF/eB7Wl7tvvHXGGkFqN3uHnB
         nOhgQQHtHlT0UnxSuuF7LeRySsfO0CTy70nAqIQ5kajlU20yOB1LBPaHPBNoEYkdat+1
         EEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780493154; x=1781097954;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhFwddlTFY09oF6cy7oYeNVke04XX3DNuQUC89hSDWQ=;
        b=H9fwCNsIZcOOkOs6PW1+rGHnOJxEYjtb+jeOPu4HxKpE9qZPPTgzS6W791OWOpxLO+
         0XOj8dT9koTLFTBmpXa6TgdxSg7sk6xGNadiSpEMLn5bVUf/uy0nJ7dhRdAnxF4QWanf
         e+dkao2R8QFkCh/DB7Ehf4DzZO7PrSavfllEk6mF8W4AJG9DGM37lTv8Uq0XkiX/7rC7
         auDBg2/Mrx23hMz+3ATDuJCD6CpMmUUtzve4uZKM/PmFGb+1DhlmT9rrDduEFCM1URrJ
         +droTOdUjsOo2a6VtgtAB9K/b/gO69fEF/dAStBxMHqNiWzwJlO96J7WGZSbxExGey0x
         W5Gg==
X-Forwarded-Encrypted: i=1; AFNElJ/PoHeKhWEzoI8NOX3xRYlEUePcG0Km48An6GERDjEALSYJyMMkBZxUoG/O3pGZC3NsLaWXpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRirVJoX4cpB/SqBiGU9bNvAZYZodNK92fxoW9JXyDUIRUIj+g
	lbILRyMqa6NXK/MUtARzIntToFeFgNvXQRPlPHz0hqbrPwoNCmfCoh7h4+RORJJOk0omptl1kn2
	DfI3cyh3MYCG0ru2AVPSoLsQBJ5PeaOne4G5aWeAnZoMKkZr5IQH5wCO6KQ==
X-Gm-Gg: Acq92OFsw5EqUUo5M15zesKoH/3iABo8Mqo0gaQEnDaRGeFepFvJoxs4ak1EC5ECnmX
	k1acn1DARFtPbIXfAa+TkmnPl3CkBslNxG4qsyNSfTciReJ585ThouEf414KppY4MW+rSqjZaZH
	NQqimevLO2/kehNLhor+8lomk0L3v4P5DHgxerNtQY0l9OAsOmv7RkZPGQRjw3HOyeUZs9OH9NV
	Ohq0jLxxXpkwZNNE2f/w/wKr3ZNV8jW6unzw5eI1hIX8qSSDJiCdn61qZrKoPTBk5vFs0aqkoXm
	GJrkNF0FfDlZxn5KuhBsJX7NDY0iiKXU8f4s5LHlaQPc3aNBy3rieTzz+WHC0nXbw3JVPiEY7sv
	rkRj3LEVRZXrSBrY4wr5vndTTBs97hnajSAD4CwZ1YTlGvpXimpXe36M0T4EBpjvXGoFtSAx0Mx
	fo0VMWbgi7XQbhMUsOa+7WKEdHPxu9xF2ttEJZOlh0DbW07g==
X-Received: by 2002:a05:6122:46a2:b0:59b:7fbd:39f8 with SMTP id 71dfb90a1353d-5a6e852c12bmr1998170e0c.10.1780493153899;
        Wed, 03 Jun 2026 06:25:53 -0700 (PDT)
X-Received: by 2002:a05:6122:46a2:b0:59b:7fbd:39f8 with SMTP id 71dfb90a1353d-5a6e852c12bmr1998093e0c.10.1780493153309;
        Wed, 03 Jun 2026 06:25:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b990d37sm653480e87.70.2026.06.03.06.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:25:52 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:25:50 +0300
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
Subject: Re: [PATCH 04/15] accel/qda: Add compute bus for QDA context banks
Message-ID: <t4dcxboazzy6mxtbcjntcccxl6gc5oxjaituzyoijy2i6wfq3n@hxcrglx7bftk>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-4-b2d984c297f8@oss.qualcomm.com>
 <gnlpw4ijwtjv43nhcv5iirhjnuc7dntx5vucdrhnxeyznyxa5x@t65o5owldu5s>
 <587b450c-c527-4c6a-b48b-8a7a266bd673@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <587b450c-c527-4c6a-b48b-8a7a266bd673@oss.qualcomm.com>
X-Proofpoint-GUID: bg_qN22y6U2WOKUe-yHRPjuOfU4uRnG8
X-Authority-Analysis: v=2.4 cv=R74z39RX c=1 sm=1 tr=0 ts=6a202b62 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=w4rcs2q4Tst63B3XjnYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: bg_qN22y6U2WOKUe-yHRPjuOfU4uRnG8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEyNyBTYWx0ZWRfXysE8FSC08sNv
 82R4dLKTpzhhV9wNbQrYk84xIEhOp/PEaiYg28IXpvSr1/567OFj4gtRgT5U7pfFWYq74Oo5QMK
 7Ay9wZYpkOlkNfNGdKs+ClQvtgURTsjdlUjqdlazisWsHpp2RTYsyg3cVykUwkRy1KASe1iotX1
 YGpTjG6oVp1r6BnGdwU6vnSqi7iu81FXVkyURDn+tt5MKJvwQ42mDduEhSzzwFrlZa63L2SxDxq
 KBlmKAUBIiKDmcS+yY/aB6fuPz7SdjS/UhCTdQItPWu9FLWX3atClI0Dl8I0gWqzn/qSYMnqeY4
 TIiPWSCy9ktq9CYopF6dLZo4mPfWQb6xlnYTNy7vqxl18f0BJoOHBs2oekT9LfKTplic49UjgDe
 Y99JsVf/Bl4R1Q34tarHnzy/sHdo1AVc4pHWgeurpu47XO1dw/Qyza8l7Yw1Nmgk2mo2SR1pnFj
 LY9KLhjvQsiOTmThzlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030127

On Wed, Jun 03, 2026 at 10:58:09AM +0530, Ekansh Gupta wrote:
> On 20-05-2026 19:49, Dmitry Baryshkov wrote:
> > On Tue, May 19, 2026 at 11:45:54AM +0530, Ekansh Gupta via B4 Relay wrote:
> >> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >>
> >> Introduce a custom virtual bus (qda-compute-cb) for managing IOMMU
> >> context bank (CB) devices used by the QDA driver.
> >>
> >> IOMMU context banks are synthetic constructs — they are not real
> >> platform devices and do not appear as children of a platform bus node
> >> in the device tree. Using a platform driver to represent them was
> >> therefore incorrect and introduced a probe-ordering race: device nodes
> >> were created before the RPMsg channel resources were fully initialized,
> >> and because probe runs asynchronously, user-space could open a CB
> >> device and attempt to start a session before the underlying transport
> >> was ready.
> >>
> >> The qda-compute-cb bus solves this by allowing the main QDA driver to
> >> create CB devices explicitly and under its own control, making their
> >> lifetime strictly subordinate to the parent qda_dev. The bus provides
> >> a dma_configure callback that calls of_dma_configure() so that each CB
> >> device gets its own IOMMU domain derived from its device-tree node,
> >> enabling per-session memory isolation.
> >>
> >> The bus type and the CB device constructor (create_qda_cb_device) are
> >> exported for use by the QDA memory manager.
> >>
> >> A hidden Kconfig symbol (DRM_ACCEL_QDA_COMPUTE_BUS) is introduced and
> >> automatically selected by DRM_ACCEL_QDA so that the bus initialisation
> >> runs via postcore_initcall before any QDA device probes.
> >>
> >> Assisted-by: Claude:claude-4-6-sonnet
> >> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >> ---
> >>  drivers/accel/Makefile              |  1 +
> >>  drivers/accel/qda/Kconfig           |  4 +++
> >>  drivers/accel/qda/Makefile          |  2 ++
> >>  drivers/accel/qda/qda_compute_bus.c | 68 +++++++++++++++++++++++++++++++++++++
> >>  include/linux/qda_compute_bus.h     | 32 +++++++++++++++++
> >>  5 files changed, 107 insertions(+)
> >>
> >> diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
> >> index 58c08dd5f389..9ed843cd293f 100644
> >> --- a/drivers/accel/Makefile
> >> +++ b/drivers/accel/Makefile
> >> @@ -6,4 +6,5 @@ obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
> >>  obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
> >>  obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
> >>  obj-$(CONFIG_DRM_ACCEL_QDA)		+= qda/
> >> +obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda/
> > 
> > Ugh. The previous line should be enough (but don't trust me).
> I was seeing build failures if I don't add this. Took it as a reference
> from host1x driver and recent iris patch.>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
