Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA6E3A758E
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707793; cv=none; b=Rb5Sgyw1NwHBf7hYX/bXGVuwVKht3zmo1Bi3I/Wg0k94q2MrIF55Byj5PgA9UfksugB1OtglZbLEuWKx+Gk7Q4N0LAOs5DfLh/PsOQABsiQqAJ2vXvsMSE1GItQxgVv+mdw41wXZZ78uNUmScds4LByBvhxGjDlrP8y2u35vAlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707793; c=relaxed/simple;
	bh=XXXUz3CS56m7m4/m9kSl9rGSBa3muR6RPy0opFLSn2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlor+3o7iWE2KcNbEC8RTjVzphfKGYcJqbBk9+ETB5FS2oOcbKN+BRQFiPhlYt4+RCV7aRp2Lu3sAkW9YU4HQnKce3quMJbdtXz81T+lvND1kNOJ3WfWlhRTE0eb1E97Wpc6czHwiQFMJXSrZ663jhzadTgdviRJt1VD58M7Bp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cQw0VTh+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eMmUBkPK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cQw0VTh+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eMmUBkPK"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KFeUJH785655
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 17:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vU+va+DrVJGvGnK1Re3NUtvK
	u7bOBZBRLYYb8Lhqnvw=; b=cQw0VTh+8n9dnGSqzrqkP9dt2DoeByY5ET9gux20
	mKtVyRXG1V7WjUaQ2JyYmY3b4RSPStjsJAtgvf1DNPBBcAMgoLHU+yvD1lhNWj3v
	w/G732V7uGsyeNuUIxMwmsmgbx1zU7DvM2sKMBvx+6CeWbyInBJvHCwgdlpoCN/n
	JzA4yL/BMoS4DGkHvEA44EzB29iph09mH0YLO69QqxuZvNLk6005zu/ZBUb6+rJT
	Ww4sV7L3Y9VKIm2Ev0R8nu+qu83ijnHN8BXZZ7L2poVNKm7H2FYmO/HRFKd3JSAN
	VDXSoviDP5Yxq6Ftz1te6AhLBio+aT7FoxuIydcnuB5UFw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnhdhhvrg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 17:56:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d8ed08aa4so111901711cf.3
        for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776707790; x=1777312590; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vU+va+DrVJGvGnK1Re3NUtvKu7bOBZBRLYYb8Lhqnvw=;
        b=eMmUBkPK4aQD5LQyvTP8LOrD9lVzvWS6vv1cEqu3BhejiHoBaW0iH16q46hQpKNG+D
         ZEeW+DLO9L5P4S9w1unZygMv0hWYbUM3/S9OS8criKdumSADYXlZgP0J0fgRaKM0wcmv
         cY4BgkdOt2o5v8HPaYvF8tUjd63eG0v1vj7xh6s/ixMWSi2iieztoW3dxgJpm20QlUyS
         LnarhHk3Dm6MR1UAvXTZLEbWuIlD+82oUcHseVUvEbQz07yydyk6VhzuH/39GP/iTWv6
         Nk8xjpLlAD/kIX8PmTZJcLB6EzngTp3c7n5PdgxPhH12znI8mZKI1Js18yT15+HxhlG0
         6BVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776707790; x=1777312590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vU+va+DrVJGvGnK1Re3NUtvKu7bOBZBRLYYb8Lhqnvw=;
        b=kxhiMRLIArfkCJk5BKfpGTvVPVOCCrTpmrk711HUnZwO90iRQEJfhO1wQlQpCe9JI+
         SJ4sn+cwfNm2uPpXsF+RslaihUoExuJSs7HcA4YEMVkexdv0d9ewlwsyPe5+tL8+T2dS
         OSDSH/OTnEUat+2h1xZ4iHkACaxmJwHYkAzPQGl0p+Y3klMHnsn/2QyCXVxoM162CLaN
         P4Zd5htkN0yVd8vjUXCTsmZCx9kA7sY9XWRciz99UjKYjYCvcUE/zZ6kvnqNsqOx27T9
         5DlKrolsDYlO1hcI9185xViorH3GkZcByNqte1Ksgr2QIiWMA+aMc2leHhgdLpTcFH0q
         9S3w==
X-Forwarded-Encrypted: i=1; AFNElJ8Y6qtAkYs4uye7FmlV71OyFhY/KWrNaLcw0doJ2+EGlPEdTejIss+bwqQ4OBaMy5wUH8yOow==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSP1bmD5JIMkpo4MQuhtCUsjahqR8nz0wF41MqQwgUniVyXizJ
	HAj2H4agFSLyJdGBqz7TobeSrzMxSRfLVNPC/o/3j8JvN0nPKkZHhc6407vTQuikcBmyRBEtbgJ
	lj8xp0IqWCNJW6LydlUljDltIuUiVH8zjgj/kwQa40SEKhnfer544B6I7Uw==
X-Gm-Gg: AeBDiesqZ6S/RKgLLoP/2AFPik5jWt+oZ+WGpcUa5/BabwAopUeoNFu7HZKMeIIpv3D
	Et+WwiEl2V3ZNqd+BZ5AmHwzTMCgKMQGq35rAJortYINwU7vH4tPbgbBOihonvceTA4BDi7Je8f
	zbDIPVeABzrWOopfNBaW65D6iKkE9qExjCdDxUZhB57YrLJMApn4lbUKVvkCYcABrMCyB1pgFHb
	Q/LeWMR0xplTBLFM9QvMrqL7W3uLndSGOCGXHaxWRz3sn3Cbb9D3xG6tn4iJw4IKPl1SSlwKvuy
	TFFm0VSDHqQBNjMbwLe2m9df1OCzsflLiqHGzxI50x1RP7d3A7SGl9wVqSwZ6M3AybZJIpnKHg1
	eKbI6adTV0djyNqwPOsiY/z/EHSwZrUvLBurhUGNxFWu74DXW29G1GN/qfwcE9R6QsndJoNAFT7
	DhUQgLrvhcLtMt36n6AWEp3zv5pPKNgilrnDUfd6jazj2XCQ==
X-Received: by 2002:a05:622a:1dcb:b0:50d:9b2e:7ee3 with SMTP id d75a77b69052e-50e36c18fe5mr221246891cf.38.1776707789930;
        Mon, 20 Apr 2026 10:56:29 -0700 (PDT)
X-Received: by 2002:a05:622a:1dcb:b0:50d:9b2e:7ee3 with SMTP id d75a77b69052e-50e36c18fe5mr221246181cf.38.1776707789354;
        Mon, 20 Apr 2026 10:56:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a5241f6583sm775615e87.39.2026.04.20.10.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 10:56:28 -0700 (PDT)
Date: Mon, 20 Apr 2026 20:56:26 +0300
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
Message-ID: <blkye2p4ojm6y2674pq5pmpxhufrqw3tdyqf7yugfc5jxi4hyu@hyehk75fnefc>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-2-7d3d1cf57b16@oss.qualcomm.com>
 <eqxeib5ci42ox4o7l45yjwgsjwjyhekojiigpxj6s5npjw5cwq@ggbtohqh3pip>
 <5dee6da0-9170-d9e0-5ff7-f8436331c6a9@oss.qualcomm.com>
 <26b71f52-3355-d4e9-f640-007123e3aba2@oss.qualcomm.com>
 <7bnl34zyexz4z54fmz6ymax7izfey6nyp7lenhvfp3hkfmhdia@lssovgsnas72>
 <1f73fad2-1d53-dd35-2668-750eaf3fe00e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f73fad2-1d53-dd35-2668-750eaf3fe00e@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 746eB0wbqOSR_pG0WT3cP975UIptrgIp
X-Authority-Analysis: v=2.4 cv=IMgyzAvG c=1 sm=1 tr=0 ts=69e668ce cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=wO3C73Ume8EFaJWdbmMA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 746eB0wbqOSR_pG0WT3cP975UIptrgIp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE3NCBTYWx0ZWRfXxOlZH3IiHit3
 YPaOT2Y+dX6ScI/s5VlvjbJY7LwQauPGZ61oPIE+DhUrWtiSFIcURANqZol7YoLLg6dAuupkQ/G
 KdlNysG4MrDu9FlO+aIj6iZ0HBWRCgo0mt69fQE0UjEzwBWmlitwR2A75zCi/DohyYk+pC3ZnIU
 M6wkAWf/Ukinvy95JoqG//SwJ3JmPN/dACWpc5x+DcTSRJIunDHI6WzJeV6JBeo8VfQJwkl9c4A
 PKBQsTcHLIsg31XoBsfav9Irb8+gmCKT3FKUl6TxLPe+bnjGB8R/9BQ/aZa1kKayjRWhkFt2HQ8
 7FlQ89yx6TDCK7LSCehikDv7xrfnrWqhxTQGjxnszNxBJE3ZEkcJWqzlgWdIVixBX23gPLQfynx
 SmbYxXtdlgHH6jIc/+oJ1UHTcKKkAKRynhpNjHeA9ePd1vhI8dUV3hcLP/M7VmUMIDFwv0zXbRI
 0k1/caRUPHh8GBewfRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200174

On Mon, Apr 20, 2026 at 07:32:23PM +0530, Vishnu Reddy wrote:
> 
> On 4/17/2026 11:49 PM, Dmitry Baryshkov wrote:
> > On Fri, Apr 17, 2026 at 08:29:21PM +0530, Vishnu Reddy wrote:
> >> apologies for re-sending (earlier responses was rejected due to HTML format)
> > Ugh.
> >
> >> On 4/17/2026 8:22 PM, Vishnu Reddy wrote:
> >>> On 4/14/2026 8:44 PM, Dmitry Baryshkov wrote:
> >>>> On Tue, Apr 14, 2026 at 10:29:58AM +0530, Vishnu Reddy wrote:
> >>>>> From: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
> >>>>>
> >>>>> Add a dedicated iris VPU bus type and register it into the iommu_buses
> >>>>> list. Iris devices require their own bus so that each device can run its
> >>>>> own dma_configure() logic.
> >>>> This really tells nothing, unless one has full context about the Iris
> >>>> needs. Start by describing the issue (that the device needs to have
> >>>> multiple devices talking to describe IOMMUs / VAs for several hardware
> >>>> functions), then continue by describing what is needed from the IOMMU
> >>>> subsys.
> >>> This series handles firmware device which do not require multiple
> >>> devices part.
> >>> given this device need for specific IOMMU configuration, I'll update the
> >>> description
> >>> accordingly.
> >>>
> >>>>> Signed-off-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
> >>>>> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> >>>>> ---
> >>>>>   drivers/iommu/iommu.c                           |  4 ++++
> >>>>>   drivers/media/platform/qcom/iris/Makefile       |  4 ++++
> >>>>>   drivers/media/platform/qcom/iris/iris_vpu_bus.c | 32 +++++++++++++++++++++++++
> >>>>>   include/linux/iris_vpu_bus.h                    | 13 ++++++++++
> >>>> How are you supposed to merge this? Through IOMMU tree? Through venus
> >>>> tree? Can we add one single bus to the IOMMU code and use it for Iris,
> >>>> Venus, FastRPC, host1x and all other device drivers which require
> >>>> per-device DMA configuration?
> >>> Separating out the bus definition and the Iris driver handling would
> >>> provide a
> >>> cleaner merge path.
> > Then why wasn't it done from the ground up?
> >
> >>>> Your colleagues from the FastRPC team posted a very similar code few
> >>>> weeks ago and got exactly the same feedback. Is there a reason why your
> >>>> teams don't sync on the IOMMU parts at all?
> >>> I would admit that I missed to review that, thank you for bringing that
> >>> discussion.
> >>> FastRPC patches generalizes the handling for host1x, FastRPC and the
> >>> same can be
> >>> extended for Iris. I have left few comments there.
> >>>
> >>>>>   4 files changed, 53 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >>>>> index 61c12ba78206..d8ed6ef70ecd 100644
> >>>>> --- a/drivers/iommu/iommu.c
> >>>>> +++ b/drivers/iommu/iommu.c
> >>>>> @@ -13,6 +13,7 @@
> >>>>>   #include <linux/bug.h>
> >>>>>   #include <linux/types.h>
> >>>>>   #include <linux/init.h>
> >>>>> +#include <linux/iris_vpu_bus.h>
> >>>>>   #include <linux/export.h>
> >>>>>   #include <linux/slab.h>
> >>>>>   #include <linux/errno.h>
> >>>>> @@ -179,6 +180,9 @@ static const struct bus_type * const iommu_buses[] = {
> >>>>>   #ifdef CONFIG_CDX_BUS
> >>>>>   	&cdx_bus_type,
> >>>>>   #endif
> >>>>> +#if IS_ENABLED(CONFIG_VIDEO_QCOM_IRIS)
> >>>>> +	&iris_vpu_bus_type,
> >>>>> +#endif
> >>>>>   };
> >>>>>   /*
> >>>>> diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
> >>>>> index 2abbd3aeb4af..6f4052b98491 100644
> >>>>> --- a/drivers/media/platform/qcom/iris/Makefile
> >>>>> +++ b/drivers/media/platform/qcom/iris/Makefile
> >>>>> @@ -31,3 +31,7 @@ qcom-iris-objs += iris_platform_gen1.o
> >>>>>   endif
> >>>>>   obj-$(CONFIG_VIDEO_QCOM_IRIS) += qcom-iris.o
> >>>>> +
> >>>>> +ifdef CONFIG_VIDEO_QCOM_IRIS
> >>>>> +obj-y += iris_vpu_bus.o
> >>>>> +endif
> >>>>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_bus.c b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
> >>>>> new file mode 100644
> >>>>> index 000000000000..b51bb4b82b0e
> >>>>> --- /dev/null
> >>>>> +++ b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
> >>>>> @@ -0,0 +1,32 @@
> >>>>> +// SPDX-License-Identifier: GPL-2.0-only
> >>>>> +/*
> >>>>> + * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
> >>>>> + */
> >>>>> +
> >>>>> +#include <linux/device.h>
> >>>>> +#include <linux/of_device.h>
> >>>>> +
> >>>>> +#include "iris_platform_common.h"
> >>>>> +
> >>>>> +static int iris_vpu_bus_dma_configure(struct device *dev)
> >>>>> +{
> >>>>> +	const u32 *f_id = dev_get_drvdata(dev);
> >>>>> +
> >>>>> +	if (!f_id)
> >>>>> +		return -ENODEV;
> >>>>> +
> >>>>> +	return of_dma_configure_id(dev, dev->parent->of_node, true, f_id);
> >>>> I think it was discussed that this is not enough. Some of devices need
> >>>> multiple function IDs.
> >>> In this glymur series we are following the legacy way of handling IOMMUs
> >>> and does not
> >>> require multi map.
> > Why can't we land the version that has multiple entries? It's as if the
> > teams are totally not in sync. The corresponding version is in works, it
> > has been implemented, etc.
> The main idea is to introduce firmware stream ID with iommu-map, while keeping the
> other stream IDs described in legacy iommus way.
> or, are you suggesting that, going forward, we should have VPU stream IDs described
> _only_ with iommu-map for any new dts/bindings?

I thought it was the plan, to keep only one (or zero?) IOMMU stream in
iommus and move the rest to iommu-map.

> 
> Thanks,
> Vishnu Reddy.
> 

-- 
With best wishes
Dmitry
