Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807963B994A
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 23:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908458; cv=none; b=YrY34NlCPgMu9nfxzeQ5wU3kcMX3qUXEwTm/gb6te/NNaLgLgG966pyUDEBQeLEjoPtxmFVnY1NW/vAAZf4U7vTQLQ6Bp9s+Q1l9iSy1pWZ/uQZBf/tAVoep3dOsxdx7Aflj8M1/pos8F7pjhjUCZnPkB0zRk7vKmojiDjzgeVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908458; c=relaxed/simple;
	bh=fptwP/Jn4YXbmICetcoRZcNAlXOMSlSzrap5v02zqEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saRhX9Yf6pSLb4qm7A5YM8D6vCBcPOawnX/EpIAurcK1FOERhf0lGMG2t3eU7Pnj0Yhj4dk3SEH1BilkoU1hKUvjtGurxGt8ac6mkga4GKfDf0XoojGyWR40pxFUh/HCK7vu+JsirSSyzmI3LE+UOEWn2UBbqUSM+XL5QeEwxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZsD2llIY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kSOh/oPj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZsD2llIY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kSOh/oPj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688MgJ7A045553
	for <iommu@lists.linux.dev>; Tue, 8 Sep 2026 23:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ihPYqdrPGXWVbmFBzBhN4BZ9
	OU7yUZppyNtH0Hlwg+k=; b=ZsD2llIYuQgi0sjhlL9VY5XcKD05Cms4T5S7p32D
	FuZh1o86KtTVKXDXy29YuSCtOVg0XQsdeqjUwl3YZHk4UMDPzCMcpWvef5UXgQgx
	dXjRk+QsQ1nBTKve3ACVZmUnOcdjZVSfdH6j0S1/EwF6ZTjj404E27H/9vvG43LE
	f8FN4kFyozAONXPxHSpm3CDpypkUp9G3QV8VdiFYAP968Y5m2uUNAFPSJ4oi6PbF
	SRDP/uXQEdFmFRIpfHKG4hbLplTqPsThnhw1njeIGCiwKPGdyzsjdWjiatKKadND
	guHN7bu/fd1w2rPO2rZyD+U6kW5VQMOJM6fYSFXJPrK8EQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqewh3sy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 23:00:55 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-738627c7908so1097046137.2
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 16:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788908454; x=1789513254; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ihPYqdrPGXWVbmFBzBhN4BZ9OU7yUZppyNtH0Hlwg+k=;
        b=kSOh/oPj6QDCA10kqPRcGnQHfCvsHyj9B82iAzgnL/Wd07Dwa9yiB7fk8IbKTGUEAB
         a1ojGDjNURtUztk8SXxBDtSQo//CwJ7DYvMKHWQBpqqO6l2A9acObIehR/FDUoGO15qi
         60Cx8a0fD1I8d6lXhGP1KST9+7SIeh6PVNWIcuP2Sq4eBiMu3DWUZxlYAy3BdrqjIRve
         PJTQXgygHPqzgmY0egmqNkHopvFg1IaW8VqIdl2HhttJ1ktT/GD0ow8j1RGbKDKjyGnx
         WloYIcX3Pi4CeHmAswXTDf71hdU0f4DZlzsLivD3ZrarIqngeAw1oOIAJGRgmUsvx8iq
         0Heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788908454; x=1789513254;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihPYqdrPGXWVbmFBzBhN4BZ9OU7yUZppyNtH0Hlwg+k=;
        b=TT0Tcs5cjXLDLRxswv7J31YUyRT2RTnz3gOyyMfYnXyfC8W0Pqa+gVBxTZ+LGqpJCE
         yc19W+aA/anDI5APDO654uKK8R81HaLC7yOVTaCfkRvcocTuvk9TJnWO6cjkHNPyw1Tk
         C47mhfmTluU/gdyd0YeMrAgKwXasbL3FWOALUtJfGYjyWpl4EaVETjsgt/V85938g79N
         rH9JY1oA3FzBI9D1K5KqAG089zw/HiI6o6YUTA91xrJbOZGjw3Wk4Ub3B1Ht/9ksEsTh
         DXydsonEXMLssxRO7RCUdhxRPBB0/q7euQrB2HQfCNCKEQ0mw5vqC3Am10RXEoeiLmIH
         X82Q==
X-Forwarded-Encrypted: i=1; AKwUvByzL4MIzoVG0QiVX29vLa6GHS+uo/g8wGMQB2eDKd+o9/yNIEgGOjJ60MRV8AMkAZa26Le5Jw==@lists.linux.dev
X-Gm-Message-State: AFuF++mV7yAGYU1H5kES9mzyqjK3edjnlMOnwAWy2vD00z3QXmv4w+PK
	fwWwrO86qSADsH2lD6eGf77TSxDtSPVU9lxGLqP2UxO5d3xZu3O8NYjo7Y9in1vhjCi/OGBO7DN
	oA/paWZ+QEm90b/mEvDjoMgDUq2uUwZJENTi5GxsRKeJkM7k0UHed+k5HUA==
X-Gm-Gg: AYBFou3ESw9nmPE5Wkx3PiYVzubgddT1t1Lqdphhv1DachWdkqy4oWHhNDCzcG4eWs6
	8Emi2t2Q5ICPR9b47Zo1lE37zf1cMo0lP0VNO6q0x2UXPVAI+GcnU6IfyrMpffOQiCFk+3Cq2uT
	nko57j0s0UXvgSEjg5gxt+BGepoTOtpA3Xw336eAAmZk2qWQtKXCc4lLAS3z9uKVGe4L3VdWv8n
	LWj977baqLblj9KapN97iZemAcvclbNXSAJLANVShMZRiqtqMvBmlmsfa3TBR1wXWZ3D/MevQHz
	GCHfrSt9UtfFvwc1B7Q54/Etwx9NIdyYoGhuMoCpWtph1YtVIIVIUl4e2dXti2Oohgmt+k5hyvz
	6G2Ff7MODRmJSIWdwOlx17SSCBcAkPOOCrbp1Mar6DV0QnIGaLcCd9JMryXZzDVxTJ6PPTu2QQ2
	356vQQfngQjcv8
X-Received: by 2002:a05:6102:5e90:b0:780:d949:663f with SMTP id ada2fe7eead31-78f73e27b69mr1092805137.4.1788908454338;
        Tue, 08 Sep 2026 16:00:54 -0700 (PDT)
X-Received: by 2002:a05:6102:5e90:b0:780:d949:663f with SMTP id ada2fe7eead31-78f73e27b69mr1092766137.4.1788908453845;
        Tue, 08 Sep 2026 16:00:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6166fbe6fsm3317542e87.41.2026.09.08.16.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 16:00:52 -0700 (PDT)
Date: Wed, 9 Sep 2026 02:00:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: rob.clark@oss.qualcomm.com,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 09/15] accel/qda: Add DMA-backed GEM objects and
 memory manager integration
Message-ID: <iviywddjpdvfx6qcsj7ki2ketbljkzqvkcmwfeop3ur5z2x3dl@fqicfxi5shh7>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
 <7030a8f8-f320-4b09-b2de-2c8e897409f8@amd.com>
 <CACSVV00MubttbkVJgMommPMorf67yqn7D1kfwpxVUZ0t-6au8Q@mail.gmail.com>
 <2febead3-0f0c-4e0d-b11a-8c61ec027f44@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2febead3-0f0c-4e0d-b11a-8c61ec027f44@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=cpirVV4i c=1 sm=1 tr=0 ts=6aa093a7 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=sLzL-2GVjjNmCx-rav0A:9
 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: 5Lnb6hW8a5hoN6UuG80r--fjaWdAzdNo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDI1MCBTYWx0ZWRfX+M3fjWp9lRyz
 0mDabHlqWSY13GdEsdvrCkilHqlOJbl094+t+qkc0UqtK4ZzzQo1i9XGROF2yGXPloPqbWZEXwV
 6V1lQs0v1Ny/rDyc1UAQ2XzCkntpb9dXriHE0/0uj984nuEm/UwV4diaCK35s9nT140t+btYzo+
 2gT03tY6LW9SMUml1rCvYoczgQA9mZ8AE2eK23/m+0iDQao5G2CvvVrRJiBeNfVThoJkmp7zqsz
 jTwDqDCE8z/lWY5yr7ZdJKzEleqRBoTc4ZJP/+DKIgMT86AH55Gttnm1hX6MKga+HULzoMYPvGN
 Pf1wWjFiO1Yc/qBCqBTDt/BHvZmuRAD43u95BZrbRmgrW+/VBRnQ5vildSl7am+YDLhoCWM2WJx
 BSe1884XbZaaJTvQOjIawBB3YmTcgqnzL6MJop0nV6nd0FsTMYS/V0JB/TXAVKX7miMwn3Kwdwz
 g7/TOA3EQznwF5nsLPQ==
X-Proofpoint-ORIG-GUID: 5Lnb6hW8a5hoN6UuG80r--fjaWdAzdNo
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDI1MCBTYWx0ZWRfX8UtSGpoXvkpN
 60wpeqJATxu052xkMQJB0xFDbDyaeHTfHgnuuAe0yByZ31ql8jhV0vC5h+LSrWQaYuuR14qHF6m
 66dlhu7NltR+xEt7pfdVN3Yh42cJFco=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080250

On Wed, Aug 26, 2026 at 07:15:07PM +0530, Ekansh Gupta wrote:
> On 24-08-2026 20:37, Rob Clark wrote:
> >>> qda_memory_dma.c / qda_memory_dma.h
> >>>   DMA coherent allocation backend. qda_dma_alloc() calls
> >>>   dma_alloc_coherent() on the CB device and encodes the stream ID
> >>>   (SID) in the upper 32 bits of the returned DMA address, following
> >>>   the Qualcomm FastRPC convention for IOMMU address space tagging.
> >>>   qda_dma_free() strips the SID prefix before calling
> >>>   dma_free_coherent().
> >>>
> >>> qda_memory_manager.c
> >>>   Adds process-to-device assignment: each DRM file (process) is
> >>>   assigned one IOMMU context bank device for the lifetime of the
> >>>   session. qda_memory_manager_assign_device() first checks whether
> >>>   the process already has a device (reusing it with a refcount
> >>>   increment), then falls back to claiming an unassigned device.
> >>>   qda_memory_manager_alloc() and qda_memory_manager_free() delegate
> >>>   to the DMA backend after resolving the correct CB device for the
> >>>   calling process.
> >> Oh, stuff like that is usually a pretty big NO-GO now.
> >>
> >> AMD has made the same mistake with KFD and it resulted in a massive chaos.
> >>
> >> The DRM file is the driver context your process uses and even if there are multiple DRM files for the same PID you should absolute *NOT* share anything between them.
> >>
> >> The general rule of thumb is to not attach anything to the process using the DRM file descriptor.
> > A couple other things to keep in mind:
> > 
> > 1. drm device fd can be passed across processes
> > 2. virtgpu/virglrenderer drm native ctx is a single process that opens
> > the drm device file N times on behalf of N guest userspace processes.
> > 
> > All that to say, Christian is right here.. drm_file is your context,
> > pgtables should be attached to the drm_file (potentially via
> > drm_gpuvm.. which you perhaps want to use).
> > 
> > BR,
> > -R
> > 
> >> Regards,
> >> Christian.
> >>
> 
> Hi Christian, Rob,
> 
> Thank you for highlighting this.
> 
> I'll rework the CB assignment to be per-drm_file. Each open() will get a
> CB assigned from the available pool (find-first-available, not
> find-by-PID). The assigned_pid field and PID-matching logic will be
> removed entirely.
> 
> The hardware has a limited number of context banks that serve many
> sessions (on fastrpc, via the DT "qcom,nsessions" property), so multiple
> drm_files may end up sharing the same underlying CB due to hardware
> constraints, but while implementing that also, I'll ensure that the
> association goes through drm_file->driver_priv, never through a PID scan.

I'd strongly suggest to implement a simple case and not to implement CB
sharing for now.

> I'll also look into drm_gpuvm for the longer-term address space
> management as Rob suggested.

Nice. I think I've beeng trying point it out, but maybe not very
explicit.

-- 
With best wishes
Dmitry
