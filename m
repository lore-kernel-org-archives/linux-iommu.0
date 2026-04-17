Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C234753F
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776449988; cv=none; b=FY0p99zx6PqYdM9Nr+rzK1Yf5ySR8JLUiVotFWHsZOxY3xgndaWGmHCK1K+Cv+QSOLhzmZrk1BoDs5B4H3B89Fr3Dc0aLNEJ92OImq/CJGjM54SStCeR+3Kdb3Bcm5Li3F3be1Dh5HBX5S660HQJ+onJylgdJGfr5+/gudCKRyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776449988; c=relaxed/simple;
	bh=+Y/1hph+Mu+w5hL+nWV2EJbB/kkq2DaGW9MdbCp16lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXWZytS7hwkRD+TdS+CGU2EobD7XG3TuAlUlOuO5vWIqf+F0PRA/Wq9SX4CvaNbyV3a5KAJ6eSqZmzvcjIwGL6XNowecnAsPlf7wJXazNuDZngs7IuTHEDeeZv6NLQ5BYxImuoD2X7PlkamfdLFHl4Mgas1glvG4S4Ks+tMZVf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IAjtQCRo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NqDjRHh4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IAjtQCRo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NqDjRHh4"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HG4g7b2669866
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 18:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=isDf/vy7kpIME0B9xxwzgDcl
	RWf8VcVDgop6pAMzdtI=; b=IAjtQCRok6+EkiwQdB1Ykf3Y6DCeROmW6eWodZYT
	KlbzZDatJfVyh7V1jyKYKq6w4IICTAfcuSvwz7Boq4ibNGNJF9zXBALHB0LAN5Y4
	gxRtJ9NGR1d++/d/ndqcmdowm1MdOMQSN6QDCMlR5+afMyf9H0LZEJSfDvJvyAgY
	m5V7jCoMaaEbuOOzFnlXoKIxsncaRJ4kS/OZNWSpZMcGqYYrco6/Atvt/8mS7yL+
	oJdeObrE8FYTan/BdFtw2vyGxhjMEO72YO7HBOCAoG2k2X2tc7AUbp0CnwGCixyw
	wdxzZVUZpeUn3O662cXBHdo5wtukc3XIViAsg0Gnj1ivTA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkaxcucbw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 18:19:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d63962d83so22896961cf.2
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776449979; x=1777054779; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=isDf/vy7kpIME0B9xxwzgDclRWf8VcVDgop6pAMzdtI=;
        b=NqDjRHh4iSO5jb7Ar2nc1GRPLz9GiMZy/dpTS/eSnDngDcL+tPckLeeOBDcTnr6mI9
         cGCMHiaYRWKOGZRVW5EJ8yB1PhZ4b26Sc92mlHytOJAoQl5xxXLdq7/7lsWhw8WRHhH5
         uCK0Pdxg51nZ/Z4REG94VdBN43Atd7LHm3ugQzkoIVkZnDPQ2TV0MC1hFRuObvFj6NB9
         JuKxYHXiVy4+EndHTeFrnogClB23Ijms74UXdTwMfqE171sbr336ZIfzqgtmJjXCZysx
         FjrLXCrFSnCtxAq4/giCHegx4RTPyaUilHO5fU+q6RteJQAo8XWQxqi5u4+ng+kki2KB
         /3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776449979; x=1777054779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isDf/vy7kpIME0B9xxwzgDclRWf8VcVDgop6pAMzdtI=;
        b=L63bRYZEDMOdHpB11Gd1qgKHvMBIh+hvS/7tlChyFjqWrIyYdEGSCH0OKOCRhKUgcr
         w/pAZqOqAf0unhDUSYH+fepFP3Id9Z+vmsMKVgni1UDSwiANDbNNVUdugZBjU5AZdwqD
         yDYp1zBg69N9K5ix4Rk9/DauUtXH0+tCzRgdrtCtNRSj8Y6M6nyrNWOTQB5cJFZsNBCL
         p5TjDnP4ZVeZkvT01pBw+/Y7YSNSGM1nVGlUXSqPZvrCyiey49wLURS9zKh0H7kcL+Jb
         AeyUBGYd4ja9tUZ84kBO6F6A3aZyp2Iwe5vXkE+1DN+GbqCw3rel3plZJH6X80C7PsRE
         GChw==
X-Forwarded-Encrypted: i=1; AFNElJ+CaGHlhZzHWFOhVV3Iq85DLdjI/aUE+bjXxrzNEimJnOdUqOiK/NYi2XMVr/I5+R/e/FMMdQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwV6Mxk5adbG8OG/oa8wxQDoPZ0PU55yHUdBmmdXkGvp4BhUmPG
	4Nh8CNcQOKz6GEf95eLSXvfRnQQZSzD6yz84aOL6U8NBSgIgBPuNkN7wEiUXl50x3m42d8GGW99
	a/QFayJVjOEW4qihVbjc15y4qnTDVLvJhlDp9UH5pYZuGMflciGh/nwajYQ==
X-Gm-Gg: AeBDietH7ACXX2ZKg99KVb++eQsDm4A6z1+d73Btb9yjr5fZ0nlXLgMTJ8YDCDWW4dL
	hTyKI3ERi4ibhNSnJpqlzxX6x0RhQEWv06YIcX/oZCkScg/xL3NORSmzig79DYP+VDAMgQEhXJC
	c9MiAB0z0Qbyftdr0Q5Dg09Z2CYbRm88kyLl8vmj5MsAs9D2c2hPkK9W8tELQMBwxajYEYIitu5
	YFisRh2q39SOHj+kdj627IfAnkm8/q4rBe+IXvmzD30yzIdMaVMlVUh1Z+HoxcNGmAqKzHfyZMu
	KGvK+63nJYD6yJE56e0X0Xf3pPlEz4+XGEvfyw7lhg6ckOg55WFQ+ifw+2aZyn/LKarqVavS/Ps
	MSlefpZiHHEVFmV7qDAdNEEcV+CUXfenAg+FduOtdiHISJxp9kgjSlw3VvIO0kBXTHf6DVDjg0n
	x67RIiDRwUiOlbS7slZ3J+uQUJ6hB2Ycsa4mhtVwOllhNq5Q==
X-Received: by 2002:ac8:5988:0:b0:50b:51a0:f744 with SMTP id d75a77b69052e-50e36be3545mr58901791cf.17.1776449979520;
        Fri, 17 Apr 2026 11:19:39 -0700 (PDT)
X-Received: by 2002:ac8:5988:0:b0:50b:51a0:f744 with SMTP id d75a77b69052e-50e36be3545mr58901131cf.17.1776449978987;
        Fri, 17 Apr 2026 11:19:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e7a62sm596839e87.56.2026.04.17.11.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 11:19:37 -0700 (PDT)
Date: Fri, 17 Apr 2026 21:19:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 02/11] media: iris: Add iris vpu bus support and register
 it with iommu_buses
Message-ID: <7bnl34zyexz4z54fmz6ymax7izfey6nyp7lenhvfp3hkfmhdia@lssovgsnas72>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-2-7d3d1cf57b16@oss.qualcomm.com>
 <eqxeib5ci42ox4o7l45yjwgsjwjyhekojiigpxj6s5npjw5cwq@ggbtohqh3pip>
 <5dee6da0-9170-d9e0-5ff7-f8436331c6a9@oss.qualcomm.com>
 <26b71f52-3355-d4e9-f640-007123e3aba2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26b71f52-3355-d4e9-f640-007123e3aba2@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=JcqMa0KV c=1 sm=1 tr=0 ts=69e279bc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=TwgMmoAUbSKMSTU6PL0A:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE4NCBTYWx0ZWRfXyWiudbv8z3ck
 Yz6B2/FpLtPIg33YV6QAQnujUElQDfX4Yh5j3il8+0DuVihjkzQzeIMi1mss7EWXWj/x8MJVOMb
 ktBNxe4pxaUlYEUZ4YF/KHiTZO6VBhVU3LzMmquTs9RfkzAVaZE3aTWk2nfw01+MUTi6/zA/1xd
 J9+2PFqdpf/DWoi3yKdG6BV08jgOjrn0EPHGqeaatm3oeeaxNHW0g3qyU4pk+D7URUkpLgRoRce
 JiFZCVyXQNxiZUKUrQ3uce7vap1wUrkmvbYfpdfganzAVFRaRvHAQ4ntxOpMg1RaQBoJ+3Si2tC
 SpJUw15jEtIP4PsE7/LcJyMRCBa3qoj/gnjfpQeXlxrsP9vv7jQfHQtm78oxIa4MXxSQL1mukNj
 tRzZ2jljWdR48+7PZt41PXevQyN7Llaku3Dht7CUoRjWKYySm47S0LLTffRa11gwgcXT3hBMifv
 jQBb/NI4jSy/aeDmMWA==
X-Proofpoint-GUID: hqQdaGSO9AtAPSaQb-4UU8Nh2rq5l5Vh
X-Proofpoint-ORIG-GUID: hqQdaGSO9AtAPSaQb-4UU8Nh2rq5l5Vh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170184

On Fri, Apr 17, 2026 at 08:29:21PM +0530, Vishnu Reddy wrote:
> apologies for re-sending (earlier responses was rejected due to HTML format)

Ugh.

> 
> On 4/17/2026 8:22 PM, Vishnu Reddy wrote:
> > On 4/14/2026 8:44 PM, Dmitry Baryshkov wrote:
> > > On Tue, Apr 14, 2026 at 10:29:58AM +0530, Vishnu Reddy wrote:
> > > > From: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
> > > > 
> > > > Add a dedicated iris VPU bus type and register it into the iommu_buses
> > > > list. Iris devices require their own bus so that each device can run its
> > > > own dma_configure() logic.
> > > This really tells nothing, unless one has full context about the Iris
> > > needs. Start by describing the issue (that the device needs to have
> > > multiple devices talking to describe IOMMUs / VAs for several hardware
> > > functions), then continue by describing what is needed from the IOMMU
> > > subsys.
> > 
> > This series handles firmware device which do not require multiple
> > devices part.
> > given this device need for specific IOMMU configuration, I'll update the
> > description
> > accordingly.
> > 
> > > > Signed-off-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
> > > > Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> > > > ---
> > > >   drivers/iommu/iommu.c                           |  4 ++++
> > > >   drivers/media/platform/qcom/iris/Makefile       |  4 ++++
> > > >   drivers/media/platform/qcom/iris/iris_vpu_bus.c | 32 +++++++++++++++++++++++++
> > > >   include/linux/iris_vpu_bus.h                    | 13 ++++++++++
> > > How are you supposed to merge this? Through IOMMU tree? Through venus
> > > tree? Can we add one single bus to the IOMMU code and use it for Iris,
> > > Venus, FastRPC, host1x and all other device drivers which require
> > > per-device DMA configuration?
> > 
> > Separating out the bus definition and the Iris driver handling would
> > provide a
> > cleaner merge path.

Then why wasn't it done from the ground up?

> > 
> > > Your colleagues from the FastRPC team posted a very similar code few
> > > weeks ago and got exactly the same feedback. Is there a reason why your
> > > teams don't sync on the IOMMU parts at all?
> > 
> > I would admit that I missed to review that, thank you for bringing that
> > discussion.
> > FastRPC patches generalizes the handling for host1x, FastRPC and the
> > same can be
> > extended for Iris. I have left few comments there.
> > 
> > > >   4 files changed, 53 insertions(+)
> > > > 
> > > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > > index 61c12ba78206..d8ed6ef70ecd 100644
> > > > --- a/drivers/iommu/iommu.c
> > > > +++ b/drivers/iommu/iommu.c
> > > > @@ -13,6 +13,7 @@
> > > >   #include <linux/bug.h>
> > > >   #include <linux/types.h>
> > > >   #include <linux/init.h>
> > > > +#include <linux/iris_vpu_bus.h>
> > > >   #include <linux/export.h>
> > > >   #include <linux/slab.h>
> > > >   #include <linux/errno.h>
> > > > @@ -179,6 +180,9 @@ static const struct bus_type * const iommu_buses[] = {
> > > >   #ifdef CONFIG_CDX_BUS
> > > >   	&cdx_bus_type,
> > > >   #endif
> > > > +#if IS_ENABLED(CONFIG_VIDEO_QCOM_IRIS)
> > > > +	&iris_vpu_bus_type,
> > > > +#endif
> > > >   };
> > > >   /*
> > > > diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
> > > > index 2abbd3aeb4af..6f4052b98491 100644
> > > > --- a/drivers/media/platform/qcom/iris/Makefile
> > > > +++ b/drivers/media/platform/qcom/iris/Makefile
> > > > @@ -31,3 +31,7 @@ qcom-iris-objs += iris_platform_gen1.o
> > > >   endif
> > > >   obj-$(CONFIG_VIDEO_QCOM_IRIS) += qcom-iris.o
> > > > +
> > > > +ifdef CONFIG_VIDEO_QCOM_IRIS
> > > > +obj-y += iris_vpu_bus.o
> > > > +endif
> > > > diff --git a/drivers/media/platform/qcom/iris/iris_vpu_bus.c b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
> > > > new file mode 100644
> > > > index 000000000000..b51bb4b82b0e
> > > > --- /dev/null
> > > > +++ b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
> > > > @@ -0,0 +1,32 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
> > > > + */
> > > > +
> > > > +#include <linux/device.h>
> > > > +#include <linux/of_device.h>
> > > > +
> > > > +#include "iris_platform_common.h"
> > > > +
> > > > +static int iris_vpu_bus_dma_configure(struct device *dev)
> > > > +{
> > > > +	const u32 *f_id = dev_get_drvdata(dev);
> > > > +
> > > > +	if (!f_id)
> > > > +		return -ENODEV;
> > > > +
> > > > +	return of_dma_configure_id(dev, dev->parent->of_node, true, f_id);
> > > I think it was discussed that this is not enough. Some of devices need
> > > multiple function IDs.
> > 
> > In this glymur series we are following the legacy way of handling IOMMUs
> > and does not
> > require multi map.

Why can't we land the version that has multiple entries? It's as if the
teams are totally not in sync. The corresponding version is in works, it
has been implemented, etc.

-- 
With best wishes
Dmitry
