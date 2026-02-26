Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444FE2E2850
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772102790; cv=none; b=TmQ+msI7FHGviosamOdkiHLrT85ZuhKDGrvrMC+VIGEFeIoXiqxcXST2/0tyL+GbPTmo1VNGAHDE8U5vy4XmZzJmaWds0ebbqtsztUwEUbQYAn6pEvLI4WMno+zpQQHlzhMUSi/O8yvKsP6HLqqiH0UxeGlIePAEwj7uTm9FXyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772102790; c=relaxed/simple;
	bh=x5QsUgHTLILuKL85clF/hSpHD9ULs8iSoklDCm1XTEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQRle98PjULCqQhqjSYxV2M7nNlbVPkbiY1EBwPvIfrtcYSxz4BLIM2mGVa8eFCDcNY8yULIHiIpsUQwZtuHyF/kciRMCPm0WsHoRCc8kTtJDvALCDdqXjWb7cWhj1AaDRLx+jYMlLrCk2HSj48ggBKXoJ5KEwtLT/rI/usZwaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C1liJdau; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FQ8IbuXk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C1liJdau";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FQ8IbuXk"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QAhvjf1161263
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 10:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zwCZAKTqPxoAPp//XCVoK8Lk
	kN9XjJo3gF5cOknkSTU=; b=C1liJdauVkvXUPdz9x3HsYm8gc/a5RB/NKVhsVYK
	SykF8PnuqWMn/B6ChdB94munsY3p5MRzDGHWRf1gr/FtBV+TCNu1GRMZaIkWu1SR
	aWlke4e7iWwkqQ+Tb2dI89FBFpR9bGHyr6PKk+t73OIh9DATfiKmi0gd5eCUvrJ5
	05ZLuogLemIBdseCQdKoOfZF/NYjBpcNC/t3HunV03G7Z8jITBNYt/afGHdcrowM
	K1YB5UbJTdwwW6fRI6kLaylwsB1pFToENxXJy0/XnOcOedpUioyM5anP9CQEvPxW
	WsVmxUvoKrTeZssoLuYaJQq4PMdgbfprUmepih4wFY9gVg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjmp6007u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 10:46:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70cff1da5so432356885a.2
        for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 02:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772102786; x=1772707586; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwCZAKTqPxoAPp//XCVoK8LkkN9XjJo3gF5cOknkSTU=;
        b=FQ8IbuXktRco+ElWNW/WL82+LLdvdjJLMc3Fa61+bSTgCk/B8TGm+obzhSDQ3Sb7iQ
         2mkZnD+lqfyz1mb815LyCruVUI6mLfJXKDv9cqW42nJ4TbVDTWpnzIQ+om7qMszgPvwE
         4ic4v93e3ESoCfl7wEP7zD4RH98xZfXxcbWpNh7fC4wJ5463hCnrRKqo/L07bP2Ya7vK
         IFf2fqZVF96PsAyKjOcTmTvrXWyQ7w5+p27EeCeSzw2L7HN9a1sbfP5Aa91BSofIFOQd
         qZDJltfmtVhRM6yDY+axirkChm+7OI0vkzIChgiorRXy6HodgKm3oOh6EosWpUIGh6yg
         y0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772102786; x=1772707586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwCZAKTqPxoAPp//XCVoK8LkkN9XjJo3gF5cOknkSTU=;
        b=moBOjjxt3qYMX2KO1l4PIu3PPoVMtIJd7YywKQfbP8o6mU0iy54fMzA6o2uX0PhXGY
         6DARpjcEmxVwQAxyGknOf4XydhxoWfvAB6o6foeEBOdnR+nVoPgJrv9Wv1EJELzAYn4s
         jNchx/7hFIuiwArK//FNwGAV57BypShshZm7eP/f66TCgMx630XqsFK5fNEgMhwnUiSr
         WclydFWSdaVA+nBWRKPmkUo9QKeuxnjhdogHlY06wNWOJqaM91A+sWI3V0Ll6qFsvj9P
         MXx76xVBTX7gVYAHnXrcyeVfPDj0MLU+DFxtvf0ZVHBJvI+T6Ue+DNOzz+k9XE4CpwQM
         DeAw==
X-Forwarded-Encrypted: i=1; AJvYcCVsgW7W0TxpaMd0SJGm2GxIj+h9w6iPorJin0kZqlTPFOprBlQbRhMOnwsqStxtwYIwkU403A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJ894g/ILwP6tt46dn133ywpVDvwqBPNiWUL+AbygG/4W9Z2Of
	jNQauOu7g/Ob/K+j8AkLVFi+aiu+0ho84HTzXzPVAW8rDY1wMLwlCN3Nzg+57S8I4Hb6JpvPmW9
	eAurtoZT2Wonw3Fnf76pYYBb+27FxYU5xc4RdseroX5gJFghzefBtNMTJIw==
X-Gm-Gg: ATEYQzwbn7hck4UVZCfimUyXkC1+lFixel0m4oVAJ7Z36SgsykEXxOgNLITaCoAL9Jl
	i74iLFIhJ+ReycQHFr6NQjHpzrs90crFSws9em3I/IIF7NJ7O1LDT1bWYu2VTVr9HNLVU/XquFr
	5FLMjo2riG3VUcJi0RPR+klMaBUCQx1RNvHsXAcHevOuzqO6oL5HqyMWsWtKKvCch5Uz937HH8U
	VaAHYJlRcmviUZChyi7aELlZ8u+7dhEwx1GIukPZCr9DIeghJRLCamt+SdSrGew1K/EKkXru6aa
	3tCTFtxFra/hXMu1PXSXH5aoDoxNBxuDBWAK02QjXU0dEWnO/ggrtWX5IMfWl3XiYhLXRonuv7R
	CXzWSkFTIQMavlpP0Z4eJ2hP0eZiyQbED3MOtGYjczJzQSQeOnXyLu8Pl2CAkyX9/n35z4awU3y
	Zextq4FztZ9+KcOd9dAICTJHhIuouTJrv2iIs=
X-Received: by 2002:a05:620a:4587:b0:8c7:106c:cbd4 with SMTP id af79cd13be357-8cb8c9cdef9mr2566361785a.12.1772102786505;
        Thu, 26 Feb 2026 02:46:26 -0800 (PST)
X-Received: by 2002:a05:620a:4587:b0:8c7:106c:cbd4 with SMTP id af79cd13be357-8cb8c9cdef9mr2566355985a.12.1772102785838;
        Thu, 26 Feb 2026 02:46:25 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a109df8dc4sm685189e87.59.2026.02.26.02.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 02:46:25 -0800 (PST)
Date: Thu, 26 Feb 2026 12:46:23 +0200
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
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
Subject: Re: [PATCH RFC 05/18] accel/qda: Create compute CB devices on QDA
 compute bus
Message-ID: <3y6rn5ujkdbc6cd2ooq7gobjvokwwrey2xoj4d3h2pavi7r5k6@rrc6bbmutz73>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-5-fe46a9c1a046@oss.qualcomm.com>
 <x3s26yr7oy2dokp4plsp67yndr7o4ps6nuj7i4zjze77ifljux@ap537se6npfg>
 <57937a68-7f22-4ca1-8980-0be12cf06c66@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57937a68-7f22-4ca1-8980-0be12cf06c66@oss.qualcomm.com>
X-Proofpoint-GUID: ud5J9ylhreij70DOq2O2IJRm23e9OvLw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA5NiBTYWx0ZWRfX8YuolO2GglPI
 w0kyVhGtrt+YsawRiPGgdqzzgPSOojkwzYJF2mA+JGem2JKvAuzMyhou78Y2klSosXvuE3RzV83
 xmMGk+eJGXpSHrCaff5eC/0ta9I2F/qRIDS0pYZGJQXaix9sY4RNryT6bwQJ/Cej7N/MAn7sy93
 5wOvkA1IE4LApHV9/NSUvc8ZEQ4SpN+4svnPoGhiGuiiHykxc9zEDP2BzDh1iJXJ9IZkw1DaO9o
 IVCqZWfaBqJIwVpeL+A4ZHmJ6PRYMIFtT/vTs/kA1bSi+nZeV+o4hgTliQj72cfv5VhLj6lSQFU
 M824j3vxdr/R7WlLsVZXbuiFKaaI8TsFWUsp057kyB130ofMEkoOE/0rndxy8M1cpNla/olmjAj
 H+RpSAFgwunv3CZesOs6EHaRn9GO+DgjEtTh7AXlms6YPGklty2qmJE9pTPwejwnqQt9+oi5ZhC
 8GyQaAmO0GiXWN+5HPQ==
X-Authority-Analysis: v=2.4 cv=daaNHHXe c=1 sm=1 tr=0 ts=69a02483 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=kIP-TH2kwnt34PtL7doA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: ud5J9ylhreij70DOq2O2IJRm23e9OvLw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260096

On Thu, Feb 26, 2026 at 02:08:57PM +0530, Ekansh Gupta wrote:
> 
> 
> On 2/24/2026 4:19 AM, Dmitry Baryshkov wrote:
> > On Tue, Feb 24, 2026 at 12:38:59AM +0530, Ekansh Gupta wrote:
> >> Add support for creating compute context-bank (CB) devices under
> >> the QDA compute bus based on child nodes of the FastRPC RPMsg
> >> device tree node. Each DT child with compatible
> >> "qcom,fastrpc-compute-cb" is turned into a QDA-owned struct
> >> device on qda_cb_bus_type.
> >>
> >> A new qda_cb_dev structure and cb_devs list in qda_dev track these
> >> CB devices. qda_populate_child_devices() walks the DT children
> >> during QDA RPMsg probe, creates CB devices, configures their DMA
> >> and IOMMU settings using of_dma_configure(), and associates a SID
> >> from the "reg" property when present.
> >>
> >> On RPMsg remove, qda_unpopulate_child_devices() tears down all CB
> >> devices, removing them from their IOMMU groups if present and
> >> unregistering the devices. This prepares the ground for using CB
> >> devices as IOMMU endpoints for DSP compute workloads in later
> >> patches.
> > Are we loosing the nsessions support?
> Yes, it's not part of this series. I'll try bringing that as well.
> >
> >> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >> ---
> >>  drivers/accel/qda/Makefile    |   1 +
> >>  drivers/accel/qda/qda_cb.c    | 150 ++++++++++++++++++++++++++++++++++++++++++
> >>  drivers/accel/qda/qda_cb.h    |  26 ++++++++
> >>  drivers/accel/qda/qda_drv.h   |   3 +
> >>  drivers/accel/qda/qda_rpmsg.c |  40 +++++++++++
> >>  5 files changed, 220 insertions(+)
> >>
> >> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
> >> index 242684ef1af7..4aded20b6bc2 100644
> >> --- a/drivers/accel/qda/Makefile
> >> +++ b/drivers/accel/qda/Makefile
> >> @@ -8,5 +8,6 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
> >>  qda-y := \
> >>  	qda_drv.o \
> >>  	qda_rpmsg.o \
> >> +	qda_cb.o \
> >>  
> >>  obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
> >> diff --git a/drivers/accel/qda/qda_cb.c b/drivers/accel/qda/qda_cb.c
> >> new file mode 100644
> >> index 000000000000..77a2d8cae076
> >> --- /dev/null
> >> +++ b/drivers/accel/qda/qda_cb.c
> >> @@ -0,0 +1,150 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> >> +#include <linux/dma-mapping.h>
> >> +#include <linux/device.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/iommu.h>
> >> +#include <linux/slab.h>
> >> +#include "qda_drv.h"
> >> +#include "qda_cb.h"
> >> +
> >> +static void qda_cb_dev_release(struct device *dev)
> >> +{
> >> +	kfree(dev);
> > Do you need to put the reference on the OF node?
> Reference put is happening as part of qda_destroy_cb_device.

This way: you have a (small) window where of_node is already put (and
might be gone), but the pointer is not NULL. The of_node should be put
only when device is no longer accessible from the rest of the system, in
release function.


-- 
With best wishes
Dmitry
