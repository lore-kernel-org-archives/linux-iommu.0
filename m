Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D023C456F
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 04:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028269; cv=none; b=X8/juycM9NK8mEAVWXOTFzCI220e9yZDQ8vcrnN5ZinmdUuvqilT5C88/ESbya1dBsH5gJk/C0ZMaGsVmJL2MqQAE2o7ZnulHU384y8bvntbhVTM+CYrtD+8TRcQTZ/fPoQAkKRxAIfxfxlSOCVdX7v69RD30S7QOjqcpGF387c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028269; c=relaxed/simple;
	bh=tnGp3Kb5DzPKO0lPgp+14Gr0e21tr30Rqzq+JOih/a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqfROHaOjqB6ICC9X8ThXepxfmt8NDU/0F3V5VMPyFseU43jrgxpkKV6CfrDo8Qlf0VaLgpGdannwIha6h9WRzpcvczrujiZm+3/0KDpWwT96KIIJ3j1UNvDIyHkg6KSVtnK1q+XGRabBvMxigCEuKuAjDcAIRFB50DI4XcZdFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d4g3Sp8T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TGGZRsHj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d4g3Sp8T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TGGZRsHj"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I2530I3602932
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 04:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+VhAlrPJjjcR4cgApAcBunef
	pIwGteIoKexT12Xm+PQ=; b=d4g3Sp8TrzXwJwOmUupLetOfSkAkAbo3IrH/0X7V
	r3RDpHZbFTvySya4aXBJnQUmP+pBb2cvATh7XjTLYAcWMLpwH9utxAIHDXTmSX41
	oRqtN7i6d+8Ct+J5ZW4/2BtU1Vdh85Q4dvQu741YawaaKupuGuwMY46MC4/I7fMK
	yYqgnIkTuQ5G4+s5I8NIOYtyeRrHm9VhVPkLX+m2C4MPRCYfeUbbJ7umMSrcfxso
	rFX6Yewbr5nyQeNd579dtQ5ECqTmjPflnYD/Odh9PoiNxQLlhmKJKHUVs6UqZgVs
	ZcvkGP4SDFalGkSrYKy3lFXwEGbXpSMVuHtvq6WEAo8nWQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4ea2gk3r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 04:44:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52cd0374265so86194951cf.1
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 21:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787028265; x=1787633065; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+VhAlrPJjjcR4cgApAcBunefpIwGteIoKexT12Xm+PQ=;
        b=TGGZRsHj5oD97D/8XhMOz6QVCtMIf/E1sZ3sds+FH4BylceHWYHqdPek64RVgbSKmt
         ujtJQ38OKXdHsfBjehcFLWcpNkD+o9bw+cxTest0QY8YKF6O4+/4A4TykD8H63mc1RfI
         wmg0T07Xba6Eoz8gSaeU2MPuqkNMINLV4wuBxTPPzo9nWnqECpnEnSMNSBOjqaxpUtg0
         AQFsunBFZ4TV2BgairkGoMSeh+HjxriZioiQADJ+FEP1s+YJ2GxvZaZMTSQzT/ctd5/5
         e/z4inuPCakh863Q685Yklq84OkFIX77HTRxwC50xQSYhNQhs0b2F9hIj4GP8C5kHEc5
         /ApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787028265; x=1787633065;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+VhAlrPJjjcR4cgApAcBunefpIwGteIoKexT12Xm+PQ=;
        b=eURmW3Byql8R+9yQ5QbtyRkbaOHfNfHIusC/2UkYwoKjCGbBlgrVP6knf4js6opqDs
         GcW4RyYY7DEe0u+4Y8wCn4jDLOnfUuVan2kbX4VKdNf0PXGbRrcpT67A8mCT747rDzT6
         2JaLk9TpejAfqGX1uwdp9nXujX4/c7Tw1hPdFL+zvkiFhM/UBNAVzHzZrhjtsteijiBV
         DKgIlrLqi7BACHUjqCKh+bTpVV3p5BtjvR8VLPGqm3clVYzLUHcdX71wIH+iusbFSjTc
         FdVAyMXxu51mVnXvS+zLqarXmKltlmmXJdzogoqiPz7WbDq+HDDzGa31JPM32qmdMIev
         oYgQ==
X-Forwarded-Encrypted: i=1; AHgh+RqX67+sHdMSJJvFzFE1zypYlaDBf4gfCMxlT63tLwuJQhppozQA4oni/Vq2d1hVaDQ1fia4Rw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnbR3drh6k6y8CyagOpRGBf1/17XvblqaYgcEXYdezvgctfiQP
	To5PSJCvdCth9pA2dH6Xp4jdknyvE4ky7Wl60khAtT3Az5LhN3MjvEy4JWdAWEOJyAaFKpJ1Mfm
	60S8qttlKLf4MzuzLmGPGVRKXINQUnhvqP7FHVHLaKMqTKttV/Q0guafuFg==
X-Gm-Gg: AR+sD12opQLW8gh2LadQc1tDx+hVG9RIJeEjtWAQ5XKubQJ1143lGOhG+F8VC09mSwJ
	cPAbgDY5hLYIho8mT+dbHhrAX3ASWVkC2eR8bfGj8oINeQvhXUxNsKtCZQCdfoZlnO0g64ua+QF
	fQ153RPoOKy6tCuPVB12T/eVfOAfjuak6X4h7W6eTFTrq7mpqARta4Se9D+KQxZ2jXNJ0x91dNz
	4/optX50jEiUdqXw6lMRJefJhH8PxXA9lUyP918MAGZ/5odDo0Sp2GHHPYUgwNFWnrDMmaDmLNf
	oi6+CjG8YOzz/wUDOSRdOCQc8FK1cheb/6l97FSRDvR7EcZlZCGw/6wFCOuG9NS0vV/Wqvbi5+v
	Ll/qD4w286xsvesNGlRB5keTWFRrChwcvuKD273sciCxpW1JM5H2ihEOnSK6KjvdCNXkMtm0w29
	FflNNAvxzhJE+b
X-Received: by 2002:ac8:58c5:0:b0:52d:771a:23f1 with SMTP id d75a77b69052e-52d853cb033mr315816271cf.14.1787028265561;
        Mon, 17 Aug 2026 21:44:25 -0700 (PDT)
X-Received: by 2002:ac8:58c5:0:b0:52d:771a:23f1 with SMTP id d75a77b69052e-52d853cb033mr315815811cf.14.1787028264997;
        Mon, 17 Aug 2026 21:44:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46d01a74dsm880330e87.73.2026.08.17.21.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 21:44:23 -0700 (PDT)
Date: Tue, 18 Aug 2026 07:44:20 +0300
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
Subject: Re: [PATCH v2 07/15] accel/qda: Add memory manager for CB devices
Message-ID: <phiwowaf74wgykqrvkvu2s3ya6eln72jolngpstadjb4vbbdrb@p7j7j2kc33su>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-7-69a02e9090d4@oss.qualcomm.com>
 <wt2pdo3m3nlhvyofuvbsqnvggywx75ucs65vjt3dzrxkrpgztz@xwwlhq2iuiun>
 <c4820424-eff0-4c28-ba77-5b595ed09a4e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4820424-eff0-4c28-ba77-5b595ed09a4e@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzMiBTYWx0ZWRfXyn48cMJcCram
 2bzk9i+TLYEJzn4TRZaZzHQpmw5sPm7WE+vSBtlupxJbnJoOvT5nI9Yp5Dy+Kxb2THXL8nbtX7T
 kJpihC+q0ZerjkHOVsLLrm2KyetMQKab4hsJk5OUFsJUvMs+CvMybeExc/IK1+zRniEzuMolziM
 3BTx0R2/orMDF+hceyfXjph4+l7ijHyVY/RdcI2cTU3Y7haRx46tNtth6uGT7Xv59npfBPno1oO
 MHU2N8wK37J2Ui6LUrQofoNeQZ0+eJOUixn93Y/lmqWMdVTAnfUz1Lh8iv4mNd030/xUku+YM/K
 L7guyBOmAdw/WKJxUCHbNNg+ZN6WTRnuavMlKsl73rTzvy6/fZgbO/2VRQ7gCFC8szX7vCI4RVX
 6y9WG/xw8uofP+vXTX1nycSCehXrCs47mQ0PTS4bBznAx8B2UB9hYtuK7Whg959TSFCII6hR0nv
 p7nSQ39eK6iN+Fn67Ng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzMiBTYWx0ZWRfX2KyTVQcoByFF
 +4dzwmVOI9y1Fxo4uSpKcqDDvy6iFVpbaAmAgytns7FhlNLp7VHf5gIeyfz1ja14uCvTfItkT6o
 jHRl5Kqya1GJQ+31xwrBoO0BU/oQwRM=
X-Authority-Analysis: v=2.4 cv=XtfK/1F9 c=1 sm=1 tr=0 ts=6a83e32a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=kDtCMvKoDeDWkizO3CQA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 6zedEr2cGbA8FbZxur7V5HPwAFo8JW3R
X-Proofpoint-GUID: 6zedEr2cGbA8FbZxur7V5HPwAFo8JW3R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180032

On Tue, Aug 18, 2026 at 10:03:56AM +0530, Ekansh Gupta wrote:
> On 17-08-2026 12:22, Dmitry Baryshkov wrote:
> > On Mon, Aug 17, 2026 at 10:17:42AM +0530, Ekansh Gupta wrote:
> >> Introduce the QDA memory manager (qda_memory_manager) to track the
> >> IOMMU devices that back each compute context bank (CB).
> >>
> >> Each CB device registered on the qda-compute-cb bus is wrapped in a
> >> qda_iommu_device descriptor recording the device pointer and its stream
> >> ID, and stored in the memory manager's registry. Later patches use this
> >> registry to resolve the IOMMU device a session should allocate from.
> >>
> >> The registry is a plain array sized to the number of
> >> "qcom,fastrpc-compute-cb" nodes present in the device tree: the RPMsg
> >> probe counts those nodes and passes the count to qda_init_device(),
> >> which allocates the array in qda_memory_manager_init(). The memory
> >> manager is created before CB devices are populated and destroyed after
> >> they are torn down, so no dangling descriptors remain.
> >>
> >> qda_cb_setup_device() is called immediately after a CB device is
> >> registered on the bus: it allocates the descriptor, registers it with
> >> the memory manager, and stores it as the CB device's driver data so
> >> that qda_destroy_cb_device() can unregister and free it during teardown.
> >>
> >> Assisted-by: Claude:claude-sonnet-5
> >> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >> ---
> >> Changes in v2:
> >> - Replace the XArray with a plain array sized to the device tree's CB
> >>   node count instead of a fixed 16-entry table (Dmitry Baryshkov)
> >> - Fold the init_memory_manager()/cleanup_memory_manager() wrappers into
> >>   qda_init_device()/qda_deinit_device() (Dmitry Baryshkov)
> >> - Drop the pr_debug() calls (Dmitry Baryshkov)
> >> - Use goto labels to unwind probe failures instead of open-coding the
> >>   cleanup at each error site (Dmitry Baryshkov)
> >> ---
> >>  drivers/accel/qda/Makefile             |  1 +
> >>  drivers/accel/qda/qda_cb.c             | 39 ++++++++++++++
> >>  drivers/accel/qda/qda_drv.c            | 26 +++++++++
> >>  drivers/accel/qda/qda_drv.h            |  5 ++
> >>  drivers/accel/qda/qda_memory_manager.c | 98 ++++++++++++++++++++++++++++++++++
> >>  drivers/accel/qda/qda_memory_manager.h | 55 +++++++++++++++++++
> >>  drivers/accel/qda/qda_rpmsg.c          | 23 +++++++-
> >>  7 files changed, 246 insertions(+), 1 deletion(-)
> >>
> >> +
> >> +/**
> >> + * struct qda_memory_manager - Central memory management coordinator
> >> + *
> >> + * Coordinates memory management across multiple IOMMU devices. Maintains
> >> + * a registry of devices in an array sized to the number of context banks
> >> + * described in the device tree.
> >> + */
> >> +struct qda_memory_manager {
> >> +	/** @devices: Array storing registered IOMMU devices */
> >> +	struct qda_iommu_device **devices;
> >> +	/** @num_devices: Number of registered IOMMU devices */
> >> +	int num_devices;
> > 
> > What for? Is devices array to be looped up to num_devices or
> > max_devices?
> num_devices is to trace device registry with manager, it grows on
> register operation. I'll improve the comment.

If it's a loop counter during device registration, make it a loop
counter. Don't store useless data.


-- 
With best wishes
Dmitry
