Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567F323E320
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776450197; cv=none; b=Nf28sKHdWioZgI8fvrQ73U1qBS5XAGiPgdhQ9XZ0hE7z3VoO8MCkZTqFsINdnpZ/u6wCjAbeXQGymwxdb500R2yiIXPakMsZilQbR753W+EqqLB/Ot7024nMcoYEO9z69Fo9cTTLEVAooMSd4e/EGS1oaphZo7LEZs7hIlhDBg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776450197; c=relaxed/simple;
	bh=FOVV8ytkXqNmDOPHJRES0xYYASo8VFa6Q/ljQtjPeWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMGXrE7O2MOqzxMacaRA/y0SFsygqwhEUm0i1zAiZZz6SUgSGrWYYdUF2Q8xdkRNJLNxRIecU148bmOMFNVyBt63gwQ97mhdKNPgBFz64oLaBoyFS5M0aNJokg5+ksO1qqKOt4h1bM3s+Hk8i9nTzzButdTY/8xZlC+oQT/aHSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N8xeBqhb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iN4xoIMl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N8xeBqhb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iN4xoIMl"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HG4l992125319
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 18:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=c/Vo33zTig6JD1FHHp+ufQHh
	3tG0Ic/BRrAC/lMpdIY=; b=N8xeBqhbKm7+PectbSVf9VmQT8daYMkUTkQinlTc
	yiYnts6LdEzn7KFk1//jEFKrFjXIfySj6IlbbewU0TYuSRXecRrooi5hpI1VQ2qU
	dvlM8iPQpf8BvQURfDvS22w9LoYh7AbtLWU1cHUX+ejPuuzNERCAlhlBRFUMdbQJ
	HJ/6DTkfCx2MTQ6JOYW6d1MiajiDX0PqSSfLuM3+xJ5pfNYhy4zix4hY4toCnXv7
	DPkgALxkL+J62K0JJbdVVcpHnHg9a752f5XT7Y66B1kejBYbM3V1g6/2b0GR2WH4
	obL7+UbJwdEb2OcYJgCzoBzWzYLlgMSmOjLG0mjIWsgKig==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk3af4vnr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 18:23:11 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5fb6622ca5dso419154137.0
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776450190; x=1777054990; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c/Vo33zTig6JD1FHHp+ufQHh3tG0Ic/BRrAC/lMpdIY=;
        b=iN4xoIMlEvFM/YcpS3kBg/qoActf1VkX4yd/xEkwLZFNBPWnO82cmQZbn2ppYz0keh
         1hg1PmIPP0y7jg5VX5wAkT0Hzb8XfGPvSUmuupvEfR1lcJIpM90voOK7tCdLCtTE2wXG
         dqHSRvZT1KUvuopGHLn5fHt5M1TYD1+UtkhkXrPBUzGcgnehOFc4XiriJG3N/jcuuOjb
         31yE5dZpvh+rIMj2PAotwlJaxK6l/k8gG5vcFO3wrARKodjmTUfyplmtkHX0Sm1onPQb
         1gNOg4bKQcE1HigxjLOS7P6gFN25QR3nA7YfoU4Pn16N+qq8urLUQFYLJzEWq0hdJGdN
         L+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776450190; x=1777054990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/Vo33zTig6JD1FHHp+ufQHh3tG0Ic/BRrAC/lMpdIY=;
        b=fM4KVsCrBGjnpvjU0NI19cz1VgY7UZAHFvgrbz47o8On0IpcW4S2kFNCkLah+t7509
         d2ifQCrc3TK6KWUdHbWtN1tgRZVOIfChjjzW03+vD4Vle/4j87uwAZ4VkWFiOP7WURWp
         3i3W4iCgwsSQrZlcAfV802B53Fdu5cCxckM36FUDay+qRfDoUr0Gj4OUDwi7RqPRMKQ9
         9HVj27xqiZqK7GLhMlNgRrKId4aMtsKjnLraQxlLmdf55TdAq4UJaUX5/PLYPE/O12TQ
         XbxGkupP0LR5RuijkiulBm74Fcvzz0ZikRc2Z8uHrTjwVlz94AjINHkrZUsXHoEWOm2C
         s4iw==
X-Forwarded-Encrypted: i=1; AFNElJ/Cez4Ove9JMkH1lIrpNQ/fWR63K6gs9fFDAR2Y5h21yCpQk1rV60DQjEiYmsrFlRqicPkRKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzByPCSq7ki8P02sUcCNgu0B8lJBNaFm96RW9dhtUpFdeHbXxCx
	e1Kq9AEIOAJR8VCWOQwiE6OzoOERNTvDvJ0/VImkDQE586qXDVWsKwA8nOYGeBURZDBv9wZzQ4L
	cvaJKMxrKD5B7mzv870qD6iTy+glqQlvbOc2NNK8+GQbVJg9huIevKG00mA==
X-Gm-Gg: AeBDievEVtYiWnMehoYshFOmbNi5XKpkjCT/3tMVlInDDmZQ9qvxorpGJgqTuMzA4nv
	AHcvnac9DH1T50Mq2XdI+MTqvuf0wvJYGlCdQRYKsb3DY0dnftAqq5xxrKpdGGOIsUevk9Y8xff
	EQU6yU7bVMDYn1jpcLvNOqDZn8b2PYl1faRg2KAM2tJznsHMvnI+KQt/8Ua/5FOzYGcqx2j+Uma
	bnKNCaJzLK8luZdCaf0YXXz5kZcpljbH4P+zAMgals3bBSK8fe5AqMxIv6aivI/1yHdV/ib+FWa
	45MikjmwWOLOlSqEq8pJ6/kqgcqvwP9A0uYh4lTZPzI0/dUXSVG5rHzh75oeMf4A/RiAHqBMadK
	E3wQJxhZ9jFQKv5/cCj8oN0Wz2ReI+jWu157+UQjUjydnUkRYs+z0WxG0/2vpeAa/Gss6I5bKt8
	7mgkMLqMVM52Yg4frjXj9RBLBgFlzqmsvb0i70i1bLyiZxlg==
X-Received: by 2002:a05:6102:38c9:b0:613:86e6:b2d with SMTP id ada2fe7eead31-616f7c5f0camr1810560137.21.1776450190343;
        Fri, 17 Apr 2026 11:23:10 -0700 (PDT)
X-Received: by 2002:a05:6102:38c9:b0:613:86e6:b2d with SMTP id ada2fe7eead31-616f7c5f0camr1810489137.21.1776450189831;
        Fri, 17 Apr 2026 11:23:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb763653sm5616471fa.42.2026.04.17.11.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 11:23:08 -0700 (PDT)
Date: Fri, 17 Apr 2026 21:23:07 +0300
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
Subject: Re: [PATCH 04/11] media: iris: Add helper to create a context bank
 device on iris vpu bus
Message-ID: <sqg2db63gsjg3cxfdfbmndhxibzlprgviarbcl4l6isza36nc3@ljgg23nkuooi>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-4-7d3d1cf57b16@oss.qualcomm.com>
 <ie6dad3xewm25gdrqqne2fsroopu3jwgrqmu54sfzjliis6mo5@6qsgagvyynwx>
 <b0ba2172-3f66-c912-29e9-0a48b4480987@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ba2172-3f66-c912-29e9-0a48b4480987@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE4NCBTYWx0ZWRfX1RMIl66VLOQJ
 iiGWLte7N0+oYSGvVVHOWo5Mcu5Rs0owZxU58rzde5TdAAITeQpng0IDvScwNs9SoXe0WD8Dtn2
 ze7fccwBtg8V84fjbiavZzJOO5hnLiikTAM2P8oL2gn6RX6535GUyiKeqERRx4GQLrRVsn1jaRK
 qsOetyD1B4k5onmH3pY5pYB3LfDlLYo2+Nu1OivshHTS4wm4iDh5jvhSMg/WBHB0JufXts1Y6tc
 vhPhu/77tx64l9aWUTYaLCHmghOX9qazyNWuRGfrHn2jHzGKl+bF/Ldtz8i2L2T6aACOUsETkxP
 CgsMOGhruMwmd0X70IbWSCUl5WZ+E1b5PZyA+bPS3ZRcyrosokEE+kl68nvg5D2i6PjaTlVdQ0P
 QRAQoeQDF5c4cvfhRpeLy5ESXkJKRIKAX5fejr82abKZoi/gnrIJiuOm2OcYIaqHWRI9XMcWW9A
 RpIxX07z2U82DReu1kw==
X-Proofpoint-ORIG-GUID: eqDn1qgk5W3WdDG9km92-84pjoHHbsM-
X-Proofpoint-GUID: eqDn1qgk5W3WdDG9km92-84pjoHHbsM-
X-Authority-Analysis: v=2.4 cv=DfInbPtW c=1 sm=1 tr=0 ts=69e27a8f cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=qp5--WL1MiOyaZoWmgIA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170184

On Fri, Apr 17, 2026 at 08:49:44PM +0530, Vishnu Reddy wrote:
> 
> On 4/14/2026 8:48 PM, Dmitry Baryshkov wrote:
> > On Tue, Apr 14, 2026 at 10:30:00AM +0530, Vishnu Reddy wrote:
> > > From: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
> > > 
> > > Add a helper function to allocate and register context bank (CB) device
> > > on the iris vpu bus. The function ID associated with the CB is specified
> > > from the platform data, allowing the bus dma_configure callback to apply
> > > correct stream ID mapping when device is registered.
> > > 
> > > Signed-off-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
> > > Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> > > ---
> > >   drivers/media/platform/qcom/iris/iris_resources.c | 33 +++++++++++++++++++++++
> > >   drivers/media/platform/qcom/iris/iris_resources.h |  1 +
> > >   2 files changed, 34 insertions(+)
> > > 
> > > diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
> > > index 773f6548370a..a25e0f2e9d26 100644
> > > --- a/drivers/media/platform/qcom/iris/iris_resources.c
> > > +++ b/drivers/media/platform/qcom/iris/iris_resources.c
> > > @@ -6,6 +6,7 @@
> > >   #include <linux/clk.h>
> > >   #include <linux/devfreq.h>
> > >   #include <linux/interconnect.h>
> > > +#include <linux/iris_vpu_bus.h>
> > >   #include <linux/pm_domain.h>
> > >   #include <linux/pm_opp.h>
> > >   #include <linux/pm_runtime.h>
> > > @@ -141,3 +142,35 @@ int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type
> > >   	return 0;
> > >   }
> > > +
> > > +static void iris_release_cb_dev(struct device *dev)
> > > +{
> > > +	kfree(dev);
> > > +}
> > > +
> > > +struct device *iris_create_cb_dev(struct iris_core *core, const char *name, const u32 *f_id)
> > Please move into the bus code and make it generic enough.
> Do you suggest to add a wrapper to pass the varying inputs to the generic
> bus, something like this
> struct device* create_and_register_device(dma_mask, parent_dev, *release,
> dev_name,...)

Definitely not the release function. The devname is also not that
important. The rest, yes, you are correct.

> > > +{
> > > +	struct device *dev;
> > > +	int ret;
> > > +
> > > +	dev = kzalloc_obj(*dev);
> > > +	if (!dev)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	dev->release = iris_release_cb_dev;
> > > +	dev->bus = &iris_vpu_bus_type;
> > > +	dev->parent = core->dev;
> > > +	dev->coherent_dma_mask = core->iris_platform_data->dma_mask;
> > > +	dev->dma_mask = &dev->coherent_dma_mask;
> > Would you also need to set the of_node? See
> > device_set_of_node_from_dev()
> 
> It might be needed for FastRPC as they are following sub node approach, Iris
> does not need.

Wouldn't it save you from passing it to of_dma_configure_id()?

> > > +
> > > +	dev_set_name(dev, "%s", name);
> > > +	dev_set_drvdata(dev, (void *)f_id);
> > > +
> > > +	ret = device_register(dev);
> > > +	if (ret) {
> > > +		put_device(dev);
> > > +		return ERR_PTR(ret);
> > > +	}
> > > +
> > > +	return dev;
> > > +}
> > > diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
> > > index 6bfbd2dc6db0..4a494627ff23 100644
> > > --- a/drivers/media/platform/qcom/iris/iris_resources.h
> > > +++ b/drivers/media/platform/qcom/iris/iris_resources.h
> > > @@ -15,5 +15,6 @@ int iris_unset_icc_bw(struct iris_core *core);
> > >   int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
> > >   int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type clk_type);
> > >   int iris_prepare_enable_clock(struct iris_core *core, enum platform_clk_type clk_type);
> > > +struct device *iris_create_cb_dev(struct iris_core *core, const char *name, const u32 *f_id);
> > >   #endif
> > > 
> > > -- 
> > > 2.34.1
> > > 

-- 
With best wishes
Dmitry
