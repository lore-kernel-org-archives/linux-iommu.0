Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3AF3A7852
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707825; cv=none; b=j3Vg/y4bD8fDEPpnugxZyKJsk7UgYXsDn9J7IKtRFq/h7MhUkgSmnLpKIuI6KBxBCi5HnSTvR+ZBc4c7kkyt+4aIiLn5/tGfYoDWU/zwIrHfz0yFDimqx4WlID2WNPe8W68vraw4cGETgb20XFh5lTXR20JvSEup9ls0t4rxZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707825; c=relaxed/simple;
	bh=mA0cosl1Y/UKnS5y10aDzdtF+S+d+4NJ48Fw+uJpY+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooEManX11j3TjOEwrPE5pFBC593qCSuLk8DtYLQ8Fnz9t4sqqfb+gufMth0LIZDmhfAUjkLmijOAlrzt/ebW792BO+C+PuCIxYWJi5tBYzRnLV2p0YvuYBQl18gxCAk27Fckrt2pdowBuYTd799ZdQBnYFxbPfqPqziyoTd380Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h5fOjvZM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BfVkLLzp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h5fOjvZM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BfVkLLzp"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KFbhda785485
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 17:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lJedt12Ka/Xa0EGY392YLMx6
	0quQ8TyR8f08LkpHbbs=; b=h5fOjvZM2RiFhmgAgBdxV0HPKW05h/nqXsfQJLUh
	H+EBZDUz4lye5WDJy1bgmO5hZQRuVXOz/BRyIK7cSL7D1qta8SuaBTmtfNn0AZ5e
	6CzIpb8gxAusOI+IU3x1G4VIiZwLw+genz9RODklxmraGfdgkXzKwXcAEXb4wOJ/
	++ChKTkj4USBwG3mOTRj1NlWJ46s5LRQiTyxG1UYRkHlOtQmsc1wAADKTb+B6LPk
	H9hjMNygJ2p1jt1YKBls+krmh4IEnr8dpkc3P3kjRYfe0mVTCjsGbGVVzAG5JVXC
	1OotTtAuTkNHHBiUDDgj0gAkopVrDgy69Il3p0EZC9xf7A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnhdhhvtw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 17:57:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b4b81c632so74010771cf.1
        for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 10:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776707822; x=1777312622; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJedt12Ka/Xa0EGY392YLMx60quQ8TyR8f08LkpHbbs=;
        b=BfVkLLzpfmTRgnuB0A4Mean6IXTTOUMBaO+iF3TGmtKnVR962zsEm3cNHV2WcVakTk
         bZ+ogCZQ3EzA9wlh9dvQzV0Ug83zSjTBGmzCCo+Z1k5cAai1k3erU/KUU+zqN6hlfBOy
         1AbhT9p5XDjQI2ZAapJVtQBDeCNFeKT76MuOmpcSqczkrLQqsqJs7Ldq9syIirULV5hg
         Js0Cf44r1a0WetrOjLBvc1cJs9+ZGl2dCyFxFVLa8ZWffNjc8mychiHrbp8v0PMrVqd7
         n3McwhnO9/0aWkM40dAPRDDsOO2KSfkULjms69Rh+KJGYS+v1brytgw5YL4qe1B6UZaD
         jMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776707822; x=1777312622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJedt12Ka/Xa0EGY392YLMx60quQ8TyR8f08LkpHbbs=;
        b=Aq8j+xjYz5nEdcL0H8S7oH+o0y+PbnQeAVMKTG7uMQRpDLD3TJpPD5sUv3MPOi89lV
         FlA5QZXFZWJp+yfepUWBwHXtWQMgeaFJt8YGMbsGSNtJ9HLwiVYyjgPevzYyp8Rny3u0
         J1VpTILzLT0bbkoe8ukYfDuiCIiDXlsO6M3q1o57OYYein/6TKqL3wKxpVOzSHNkuNt7
         ZaDBhS/hqMI9zGIBlUTwkmBZlfI3kIjtnXoAQyiC16DA3b2iueaJzehFLbG3vCgrpmuw
         ntfzdoS9TV83s4jG2hnvXC+ZZvtVGUn/1FjhRX+nXoIEEWLfcONNljGMsz04C4RHpEFd
         pwGg==
X-Forwarded-Encrypted: i=1; AFNElJ9O6C+qVmM85bh29M1e1DRKaKfukpxmo+DvLB3VONglz5Bqa/7KKDENSvXETsJfgr31ge8/0g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9Qp+Y3jWZG5v8xE+I/ywgaWbe4/pd+d4lCSH0X1VRw5Jwtnxf
	K0J5vqjEboMznT3iCZns1eH3FHra9DUF2dDSAQaAHyJ7oFZSoMlMOZu3mA7btKEJ1B8s6+7vE+s
	UYOP/2O4SbxLfsVPsFVWIcwEcaedoGzmUS7AijYGlBym68xUna/hndrBYFQ==
X-Gm-Gg: AeBDiesbHDWSpcqmeD6+HQnStx6l7xqE7VlWslhOIO9f8vznLba9ym90fr1vRJZoHF5
	jo3ryZC5FftF7aI568htLwM77nw/c1DFd6R4vNVTvZP7ynoZQ84kGoF/O1zXEy6ms7ZOMGzTLDJ
	BuKVsBs8LDVNQL0PJMtT5D7bbcERicZYm+csgOMAHRXU5XR4aGY+L65oSU/8o6V6ASRvAcy8MOf
	7wAwN4dOLsDET+BHXBecXYjIso7uoEL99jLFiIhkdjHnveNZs5fgUaHGTf9RmspMdrDCota+04X
	hPhmIJx/ZvOHx9o6GU4umHSOTqS84Lx8sB1xV3Z5ZFDt8qjeoiYG2g9P4Fs4a08fezy//6rPMAy
	tEjxbe5gX8qgo/r095LbCwi1/SrByNzXwJTB/qtHcgJA57MH2hXpvbKRpEo9um3nf8Q2S0gBz58
	SrDJuT4t3di7RaizpaUP4jhKma0kBEDan9DeLLOuGzxtoauQ==
X-Received: by 2002:a05:622a:a64c:b0:50e:5fe2:83aa with SMTP id d75a77b69052e-50e5fe290c0mr48699811cf.12.1776707822379;
        Mon, 20 Apr 2026 10:57:02 -0700 (PDT)
X-Received: by 2002:a05:622a:a64c:b0:50e:5fe2:83aa with SMTP id d75a77b69052e-50e5fe290c0mr48699181cf.12.1776707821844;
        Mon, 20 Apr 2026 10:57:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187eb5f1sm3049040e87.72.2026.04.20.10.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 10:57:00 -0700 (PDT)
Date: Mon, 20 Apr 2026 20:56:58 +0300
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
Message-ID: <cucl4m3h2wkosvzuyxdwyjec3v5n6vpa5g3osvo5y4farpewtn@jw6kzf3f3eyj>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-4-7d3d1cf57b16@oss.qualcomm.com>
 <ie6dad3xewm25gdrqqne2fsroopu3jwgrqmu54sfzjliis6mo5@6qsgagvyynwx>
 <b0ba2172-3f66-c912-29e9-0a48b4480987@oss.qualcomm.com>
 <sqg2db63gsjg3cxfdfbmndhxibzlprgviarbcl4l6isza36nc3@ljgg23nkuooi>
 <bab7f899-dc05-7c9d-aed5-fed1910aa32b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bab7f899-dc05-7c9d-aed5-fed1910aa32b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 37V4xpGj7nP_16Zu0yjchTAZGl7RW6eZ
X-Authority-Analysis: v=2.4 cv=IMgyzAvG c=1 sm=1 tr=0 ts=69e668ef cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=XurYlQOUMRzH-DkKxKYA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 37V4xpGj7nP_16Zu0yjchTAZGl7RW6eZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE3NCBTYWx0ZWRfX2oUedFViX/Jf
 vNsyDcwuqXpdaN+8gYUPMPZy+Imdo3+j4UwFsn5so1R18Q+eeELLOYQNsY9Ospytp5usvK81bOK
 loFoq2LDvKVVtrwofK0ekPuEy6UaAta3afx+MS3WUoICASVy72iKNtBwXEdAVNtfZ/gozhHq14u
 QNB30hJ2mmvvoSe2DYui5TiKAw02N/L/XDC0M4t01wNVFJ2XQGhWuJ5hy7j0s/ryilqNG4Jqa++
 /HOlhM2vogQl1OkqsxLIXl1k9G7bxAtLhlxjAjYhlJtAsFyXijdvJd4IRYJxICNfi3Vmhg4A9gq
 V5Sk09KPvwibWSQENifQluuyGkTuKgKRy75B5KEii/JO4vNrb0kyFg8vw4yQWy8sh8Z9D3NCHsE
 F3YAVppzmLHwFpc1rxybvtdcCInZgDqCM/x27OFwJyEVnQmKgGOBAKr38Ne7dTUA9FGxLKglLEw
 wFCmbSOadWs3a/6QePA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200174

On Mon, Apr 20, 2026 at 07:33:01PM +0530, Vishnu Reddy wrote:
> 
> On 4/17/2026 11:53 PM, Dmitry Baryshkov wrote:
> > On Fri, Apr 17, 2026 at 08:49:44PM +0530, Vishnu Reddy wrote:
> >> On 4/14/2026 8:48 PM, Dmitry Baryshkov wrote:
> >>> On Tue, Apr 14, 2026 at 10:30:00AM +0530, Vishnu Reddy wrote:
> >>>> From: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
> >>>>
> >>>> Add a helper function to allocate and register context bank (CB) device
> >>>> on the iris vpu bus. The function ID associated with the CB is specified
> >>>> from the platform data, allowing the bus dma_configure callback to apply
> >>>> correct stream ID mapping when device is registered.
> >>>>
> >>>> Signed-off-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
> >>>> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> >>>> ---
> >>>>   drivers/media/platform/qcom/iris/iris_resources.c | 33 +++++++++++++++++++++++
> >>>>   drivers/media/platform/qcom/iris/iris_resources.h |  1 +
> >>>>   2 files changed, 34 insertions(+)
> >>>>
> >>>> diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
> >>>> index 773f6548370a..a25e0f2e9d26 100644
> >>>> --- a/drivers/media/platform/qcom/iris/iris_resources.c
> >>>> +++ b/drivers/media/platform/qcom/iris/iris_resources.c
> >>>> @@ -6,6 +6,7 @@
> >>>>   #include <linux/clk.h>
> >>>>   #include <linux/devfreq.h>
> >>>>   #include <linux/interconnect.h>
> >>>> +#include <linux/iris_vpu_bus.h>
> >>>>   #include <linux/pm_domain.h>
> >>>>   #include <linux/pm_opp.h>
> >>>>   #include <linux/pm_runtime.h>
> >>>> @@ -141,3 +142,35 @@ int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type
> >>>>   	return 0;
> >>>>   }
> >>>> +
> >>>> +static void iris_release_cb_dev(struct device *dev)
> >>>> +{
> >>>> +	kfree(dev);
> >>>> +}
> >>>> +
> >>>> +struct device *iris_create_cb_dev(struct iris_core *core, const char *name, const u32 *f_id)
> >>> Please move into the bus code and make it generic enough.
> >> Do you suggest to add a wrapper to pass the varying inputs to the generic
> >> bus, something like this
> >> struct device* create_and_register_device(dma_mask, parent_dev, *release,
> >> dev_name,...)
> > Definitely not the release function. The devname is also not that
> > important. The rest, yes, you are correct.
> >
> >>>> +{
> >>>> +	struct device *dev;
> >>>> +	int ret;
> >>>> +
> >>>> +	dev = kzalloc_obj(*dev);
> >>>> +	if (!dev)
> >>>> +		return ERR_PTR(-ENOMEM);
> >>>> +
> >>>> +	dev->release = iris_release_cb_dev;
> >>>> +	dev->bus = &iris_vpu_bus_type;
> >>>> +	dev->parent = core->dev;
> >>>> +	dev->coherent_dma_mask = core->iris_platform_data->dma_mask;
> >>>> +	dev->dma_mask = &dev->coherent_dma_mask;
> >>> Would you also need to set the of_node? See
> >>> device_set_of_node_from_dev()
> >> It might be needed for FastRPC as they are following sub node approach, Iris
> >> does not need.
> > Wouldn't it save you from passing it to of_dma_configure_id()?
> Iris will pass parent device of_node, setting parent device is enough.

Set the of node and pass NULL to of_dma_configure_id.

> >>>> +
> >>>> +	dev_set_name(dev, "%s", name);
> >>>> +	dev_set_drvdata(dev, (void *)f_id);
> >>>> +
> >>>> +	ret = device_register(dev);
> >>>> +	if (ret) {
> >>>> +		put_device(dev);
> >>>> +		return ERR_PTR(ret);
> >>>> +	}
> >>>> +
> >>>> +	return dev;
> >>>> +}
> >>>> diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
> >>>> index 6bfbd2dc6db0..4a494627ff23 100644
> >>>> --- a/drivers/media/platform/qcom/iris/iris_resources.h
> >>>> +++ b/drivers/media/platform/qcom/iris/iris_resources.h
> >>>> @@ -15,5 +15,6 @@ int iris_unset_icc_bw(struct iris_core *core);
> >>>>   int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
> >>>>   int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type clk_type);
> >>>>   int iris_prepare_enable_clock(struct iris_core *core, enum platform_clk_type clk_type);
> >>>> +struct device *iris_create_cb_dev(struct iris_core *core, const char *name, const u32 *f_id);
> >>>>   #endif
> >>>>
> >>>> -- 
> >>>> 2.34.1
> >>>>

-- 
With best wishes
Dmitry
