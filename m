Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A413DC87A
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787215969; cv=none; b=H0FekNdmisxEosXtFbitBSyaOrA06vqnLcYy9VNNMSb47cCG03+J5GD4jEkgBzoaB8zs2VD6rPMMNrsmwxVD5PgFxyA1I7xS6+YfM9bYRO2Vd4vX55kDAABwf1lpbAzyK+T3ohbSJ1gEOF1jvIFUIjKifJNv//+mxDxpUAk5Kps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787215969; c=relaxed/simple;
	bh=KdclxYicdgGKKKzq6eHwxzoyn3BI9i4HM24fxOvF8As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exuXuX4qR8TBcW1LNVjrM8b8lBzM3jZjNrzwLVdGyFH4bdwqUPRHvUrUxl3RerpwIlvO0yVRYuU50YBVwLfSgJDeGDgy3Cp+oqy09IRctwZe5CuVauPigI6uI49nAGmVGwVHmXoGM5UmnGwv0qtBb3DjI5BnNTN4RwtE2YSXdWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lMXsYwoh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FX5PYNPM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lMXsYwoh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FX5PYNPM"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K6iVbX491350
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 08:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7pRjGAagJWUGoFGnU1ugBrwj
	EF+1RslNAkeOCCC3woY=; b=lMXsYwohJXoOFUUz5vHVF+7qKIlqg27ZPHNA/k6q
	25rddxQ4uXOwlg/AFrE+U3y4wmB+zuEgcpDb3jQow30Tbez0TR7xGVRWiJiBx87A
	rxUTyAbmtBuKY7tYJSVCGJvXEVE15QXhCVmBftVGYpEPMWc9zoy9F2MZ9/8tlbJB
	VmPcYZ6pjL87JylMozbeEEginNKkKRq0k2yRzFp6SvnJ2GNTflAadUfYwUW3Lhf+
	3niYZhSKi+1AgExLjabS7z5hyEsqz01HyhqByCcWdEa+Y8OpcGBQMv/uyUktnObA
	kt0Z1u6ppLwN7VTkcLh9epL9ev2MTq8KJdibui/Io5Kyhg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5ervm2kk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 08:52:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5e38fbc5so251093685a.2
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 01:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787215965; x=1787820765; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7pRjGAagJWUGoFGnU1ugBrwjEF+1RslNAkeOCCC3woY=;
        b=FX5PYNPMsiA4O5cBEgK1Gb9xCh7PAadfGICiKiDN+ab8Qg1mQ1lTfZi1x1xxaRcTr5
         wfQNIiqYi1LWz8VkMtXHTmuxZ4jCcZ7gtG4XVn7COKuCRu8vaeO5rO+VTcXhdnRmng4r
         YfOGuEN2wJL/2T1nDjRK0EcDNhezvBLd8PDsBzJtaTlpbpxwksHecs0OePcvz8WA8kdi
         13OYtA1WgVhHSeySMggpi57LtDNuAtZ3I7IRACvBX0h3F19ycgGCa3pBEInjxCH+UPtC
         uVGd0Xc35W7XBxIggUHg6iMa5B8Oved6gbWf+B8U5Q4mqWrx1MOxQhHAh0zRmqn+ferX
         +MrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787215965; x=1787820765;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7pRjGAagJWUGoFGnU1ugBrwjEF+1RslNAkeOCCC3woY=;
        b=nhrl8brzzkAJPMvzu6Sn0uHDN2c71uiOpKWFIRNX6PUSuMYvI2F56CBqCF6TTnvgND
         UzBsvixWkUJ4Lov02gFZR0ZqfIcclPaEBKAw7k8UyPZ2FCS5lJ5qfAXNgppmptG7Uy/O
         gtAeUgnNH3nO9tAmB9u2Qi3H8OGnT/Te5YtFBGKTw+KR69wb3UoKpsHBlVG4NRSwaZ4h
         zFC01abi0cSt3wcd3YTbWuPLBfwbpJ58gZaNHOnDgK9098Q7hqtOCor07g4PWJFObIjW
         ZcesTHhEtxsiWBjyj0dcHWFVXso5ZOXe8Xf9okA86Qy+laRzmDX50wL8Hvy8nYOPmlne
         +pgg==
X-Forwarded-Encrypted: i=1; AHgh+RqxO8BL4gLOFkwvZ7oZtqsnzoANsTK1TuSdVA82OEj9ktLaLPnJnZUn4mILJzrmi4+QFHEqQg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywb8FIroaJTKAg/lXwuFYc91MP1zTJPRbk6r5sBKp9ILEHg1gqx
	E9k8lXIVFOAuM9wzvV06J7TwKiZ/QqAc6g3RwX1OT3NjOz/5bZ1XtUcRcfxBVyvZ/1wmHKiEdSN
	T4Zqv6URxN63GU+uJiPMPVsom6bIh7g3LIQczUai8/pGhPqsAwHXbvBl7aw==
X-Gm-Gg: AR+sD11VpjhfmEZBCkQXeuAVe3jyuUAWKEeiSM1fdpmRQVThCpjFXRY+UNf4E/GIDxA
	QHCbxc1vFOfW/x7uDisd8ZyDMRUBS+T5Ws8ZpBpigARw7iiqHS/8Jz6QBjoQG680ylxUBfP/KNE
	5ipCp3kM0mh0gQGLl+h27LAoIXlxLNWaioxjrRgg+xaFSZyO4PGLL92wHETVSl7MAU1eANcP17h
	TV2EyrlZmXIbO5IBrcYJEPvhy0yMkQoSdOF4XQi63zU9JuQORXSiJq2jtlNEkrzadcu3MM6IYWV
	5W2dF0V1yi4Dc7CzQaLaYDN+YlKBGbtQwwN1uA+Ul0o7Dz1BKXJxUYGOlrUFG34/C1tq8fqOfl9
	/NuNG8jTtIw1P/EBbCJTj65WWuDs6+djjKHzV4b+vXfrhYFIiNqe7KprrVkVBgtLImf9yUyVbwU
	pOiBFFDwZj667Z
X-Received: by 2002:a05:620a:4505:b0:936:883d:89c6 with SMTP id af79cd13be357-9371e2ff241mr1009579385a.28.1787215965458;
        Thu, 20 Aug 2026 01:52:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4505:b0:936:883d:89c6 with SMTP id af79cd13be357-9371e2ff241mr1009575385a.28.1787215964943;
        Thu, 20 Aug 2026 01:52:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4788d9223sm1121021e87.46.2026.08.20.01.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:52:43 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:52:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 03/15] accel/qda: Add initial QDA DRM accelerator
 driver
Message-ID: <g5orcvzjbwww27vwcsxl3ehrek6lvznxptd7jutifoiuicjnm6@iqq2pus6omsl>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-3-69a02e9090d4@oss.qualcomm.com>
 <81708487-89ce-4cd5-b39a-2989bdce6088@kernel.org>
 <3476b5c3-7983-4994-a901-3d7d8bd75255@oss.qualcomm.com>
 <4ef74e14-8433-4619-ac97-62868c8799d1@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ef74e14-8433-4619-ac97-62868c8799d1@kernel.org>
X-Proofpoint-GUID: VFxeyLFHdrdgjQkFZfaASXG16u1y4Uw7
X-Authority-Analysis: v=2.4 cv=VZ3H+lp9 c=1 sm=1 tr=0 ts=6a86c05e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=D19gQVrFAAAA:8
 a=EUspDBNiAAAA:8 a=qpzGY3gMejqFJFcM8zUA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA2NCBTYWx0ZWRfX7RGiL5PvLf0/
 OpgfhSvRNdJhhoKnfKnFh/IhV0yhrORMSJm64FXR7aTeVxUR0Ak5CGSjauQDFdVQwgkJu8G50jg
 haEhWATvgAlfWEeDkUuUCMy4Fzy6SE/1nRG1w+NspkSKjKxGpiczZAuJL9+BEumj2tR/RqGs6dW
 2jY1p4CWFZahN4cxxNC39cT7Ht3GC8im1Vt3L4j3zg0USdDsQMec8wb3vHFxdHhGdQLwJLu1cGP
 wvZlnnu94f9gjAA8v+3bklFaLUSdW04ui9RLxhh1HkiyUuZuuoPDuP7vo1k/Ct73+Mmu08zs+UT
 pD82X6JRk18xcQySvZoe+2W6iAc6g1n7HB6cbfGLL5/8MhVUz+MDClQuhh/FEmRh8+eYDP0tNlx
 IAGsria/3uSwSMtWZVnZnMRrkist0N6GcsBYPjm0D9TdL8eLaSXnx8+u+iDaFTycJ7vMFPF0dHj
 dxluxUyNjJbBJz2sdCQ==
X-Proofpoint-ORIG-GUID: VFxeyLFHdrdgjQkFZfaASXG16u1y4Uw7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA2NCBTYWx0ZWRfX7AdMW1r4tgI9
 H0Vp7a3/LTvhO2F2IyLP4Z66K1gN0aDMHq0z8w0roSrYgBeI8z9oQ77b9kaMKulf8sK8jcvG9JM
 IHbMq9IHg9D01dFVbIYZmb6uZj0K0P0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200064

On Wed, Aug 19, 2026 at 04:18:51PM +0200, Krzysztof Kozlowski wrote:
> On 19/08/2026 15:17, Ekansh Gupta wrote:
> > On 19-08-2026 00:40, Krzysztof Kozlowski wrote:
> >> On 17/08/2026 06:47, Ekansh Gupta wrote:
> >>> Add the skeleton of the Qualcomm DSP Accelerator (QDA) driver, a DRM
> >>> accel driver for the Hexagon DSPs found on Qualcomm SoCs.
> >>>
> >>> This patch registers a DRM accel device, exposing a /dev/accel/accelN
> >>> character device node, and binds it to the RPMsg channel used to reach
> >>> the DSP. Buffer management, IOMMU context banks and the FastRPC
> >>> protocol are added by later patches in this series.
> >>>
> >>> qda_drv.c / qda_drv.h define the drm_driver ops table, the per-file
> >>> private state (qda_file_priv) and the main device structure (qda_dev),
> >>> which embeds drm_device so that it can be recovered with container_of().
> >>>
> >>> qda_rpmsg.c binds to the "qcom,fastrpc" compatible via
> >>> module_rpmsg_driver(), reads the DSP domain name from the "label"
> >>> device-tree property, and registers the DRM device.
> >>>
> >>> Assisted-by: Claude:claude-sonnet-5
> >>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >>> ---
> >>> Changes in v2:
> >>> - Use module_rpmsg_driver() and drop the qda_rpmsg_register()/
> >>>   _unregister() wrappers, module_init()/module_exit() and
> >>>   qda_rpmsg.h entirely (Dmitry Baryshkov)
> >>> - Read the "label" property directly into qdev->dsp_name (Dmitry Baryshkov)
> >>> - Drop the probe/remove/init log messages (Dmitry Baryshkov)
> >>> - Return the result of qda_register_device() directly (Dmitry Baryshkov)
> >>> - Clarify the Kconfig help text (Dmitry Baryshkov)
> >>> ---
> >>>  drivers/accel/Kconfig         |  1 +
> >>>  drivers/accel/Makefile        |  1 +
> >>>  drivers/accel/qda/Kconfig     | 30 ++++++++++++++++
> >>>  drivers/accel/qda/Makefile    | 10 ++++++
> >>>  drivers/accel/qda/qda_drv.c   | 71 ++++++++++++++++++++++++++++++++++++++
> >>>  drivers/accel/qda/qda_drv.h   | 61 +++++++++++++++++++++++++++++++++
> >>>  drivers/accel/qda/qda_rpmsg.c | 79 +++++++++++++++++++++++++++++++++++++++++++
> >>>  7 files changed, 253 insertions(+)
> >>>
> >>> diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
> >>> index bdf48ccafcf2..74ac0f71bc9d 100644
> >>> --- a/drivers/accel/Kconfig
> >>> +++ b/drivers/accel/Kconfig
> >>> @@ -29,6 +29,7 @@ source "drivers/accel/ethosu/Kconfig"
> >>>  source "drivers/accel/habanalabs/Kconfig"
> >>>  source "drivers/accel/ivpu/Kconfig"
> >>>  source "drivers/accel/qaic/Kconfig"
> >>> +source "drivers/accel/qda/Kconfig"
> >>>  source "drivers/accel/rocket/Kconfig"
> >>>  
> >>>  endif
> >>> diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
> >>> index 1d3a7251b950..58c08dd5f389 100644
> >>> --- a/drivers/accel/Makefile
> >>> +++ b/drivers/accel/Makefile
> >>> @@ -5,4 +5,5 @@ obj-$(CONFIG_DRM_ACCEL_ARM_ETHOSU)	+= ethosu/
> >>>  obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
> >>>  obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
> >>>  obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
> >>> +obj-$(CONFIG_DRM_ACCEL_QDA)		+= qda/
> >>>  obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
> >>> \ No newline at end of file
> >>
> >> You have trivial patch errors.
> > newline problem was already there, wasn't introduced as part of this
> > patch series, so I wasn't sure to fix it here. I can fix this in v3.>
> >> ...
> >>
> >>> +}
> >>> +
> >>> +static const struct of_device_id qda_rpmsg_id_table[] = {
> >>> +	{ .compatible = "qcom,fastrpc" },
> >>> +	{},
> >>
> >> Device node with this compatible is already populated, so this looks
> >> simply wrong or you are adding a duplicated driver.
> >>
> >> That's a no-go, you are supposed to work with existing drivers and grow
> >> them.
> > I'll bring the discussion again here, there was a discussion to move the
> > driver to accel subsystem if we want to support new features/uAPI
> > changes. Please read [1],[2] threads. The intention is to replace
> > fastrpc driver with QDA eventually.
> 
> None of them address the problem. You want to grow fastrpc into user of
> dmabuf? So you move it from misc to here.

It's not as easy and nice, so I think in this case it's better to repeat
what we did for the venus/iris migration or what happened already
several times in the kernel history (for example the AIC7xxx SCSI host
drivers were migrated by introducing the second driver and then removing
the first one after the grace period). The backwards compatibility is a
separate topic, but it will be addressed before the driver can be
merged.

> 
> Again: you have one driver.
> 
> > 
> > Do you suggest adding a different compatible, say "qcom,qda" for this
> > driver?
> 
> How would that even work? How much (or many?) hardware do you have in
> your SoC?

No, it's the same compat. In the end, changing the driver doesn't change
the hardware.

> 
> > 
> > Let me know if you have a better suggestion to proceed here.
> > 
> > [1] https://lkml.org/lkml/2024/6/24/479
> > [2] https://lkml.org/lkml/2024/6/21/1252>
> 
> 
> Please do not ever reference lkml.org, it's long time deprecated and
> barely working. Use lore.

-- 
With best wishes
Dmitry
