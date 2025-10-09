Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C662E11AB
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015986; cv=none; b=VmfpokuWA6fKwGME2i8G+frAzeTOn7KUkiFzzhwezDGXPzfaThmYaID7FR88je8aNXN7BAUbI9s0Lq/o3jVL2DB0aYFBGCEBZ/PZ+p4DoUC09kajuSMrv9a0Ojgxxn4z/wS1f6Ayp0g/70sBk7gfvTUQ9uSQBcWaPvuSAi/CZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015986; c=relaxed/simple;
	bh=6od1fV6rVbTTlriYWkrdTnoQlj1t0m28wf/FQK3dZoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXShJt+3Xie/C2HDY+dhIpII1Sa2h7xasb0qJu3ol1D2wR9PBmMdvCowZuz6bokXqbveMrWgRDR01unwGbA8wMSGQZJL70Xh2Rlfuxd3mYuv+ji5OCxBjGHZLhNfL9g7rNtTGAEZfu1Z1vtj90iGrOZ4v6FOhrZzxghTrLZyBsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bB8emnIR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bB8emnIR"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EKV6019192
	for <iommu@lists.linux.dev>; Thu, 9 Oct 2025 13:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vv0TlFWg4LZf6pn5FCrrZNgZ
	oi+P6lXJOgo5f8lPaQA=; b=bB8emnIRbj4PeCz4vFHAoC1oZZqt5GqAhiLEGsJF
	WUgvM9gutwLAjNNJpOvjqJchc1LxccVolCUZUL22/o1HoTvci7mmeBVhNlinykpU
	HUViStE4h/18kA3mh1RanAReXIuIcqmVhIzaKikUomluW1KiB1O/OWnPNQfJadQ+
	6AMaBp9zfplitt+sVpUiiDVkMoKGQJByF+kH6tyC1Q5PleCpkdFSpWIpKicrOyXL
	AWaa23RyB1tpVrjD5s5twwiUQnqc4MCRyPzX2O9YcWhINp+A2T+taVOWcYgEJhQO
	+I1+asJcDpE85a11AO+oZugLbVl47sL4FAepX5ctkS1pBw==
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4ntvsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 09 Oct 2025 13:19:43 +0000 (GMT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42594b7f324so28228875ab.1
        for <iommu@lists.linux.dev>; Thu, 09 Oct 2025 06:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760015982; x=1760620782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vv0TlFWg4LZf6pn5FCrrZNgZoi+P6lXJOgo5f8lPaQA=;
        b=bLMd8hmBdV3geU6bhkGz8iGDrNdXsYnscyZ4LXoSb+XBXW2k0IHk8u68xfHLN+B9KJ
         olfC6DW9/5a6dA2Op7bgQEPKwH2H0Uz8IkbTws4sZha3yrJTdB9fy6KiXLZ1/tFGqyOQ
         NaYCFKYmfYWpARj3vKNCECyQqYT+w0W/VO38FShP/rISqDWOpsxHfF+YnOfnntDBzHMu
         i8inFAfo3UiG2NPtPW8msyPmTb0L404+lSRCa0kmij1lNt48WRBxo2wXjFJP7McoAvWX
         rjRUipCIFCOOzjZyD5U50kh7/9se/Bd4sdWqqlhV9exl+0Y0QgMf5+XENJb3j5rb1EH0
         ExIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQGvy1ZOa9JcDy6g+xpIBxsg/ReGMp2iqFAp5xHUlc0CTP9FQ4uKTcq1gmJdU/w+MpE8kHgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuP/1NoOUkh5izcWQlQvhh7SWx3dhXIub9+3h/KaqhxKHILthz
	BjN2QEejbHB/vHKZhVD/89Kfw5+REwbJSSm3KvJOURTtQx/cBZPyAe23U4KpfD07LiEOhTGPXVq
	dV/zwVvFPgO4EkYYUMP0RUTMR8OTKyHY7mK6E+Kh5v4wN+ir3OOKWqxwWpg==
X-Gm-Gg: ASbGncvViE1hVVtu12wAY0WS6aVtMP2nW2vyCDudqXUOeQ8/hS+okOOvor7D5NSDPC+
	nVNu1TTvpnK1NaJh7Yh9AqTHhCEChctt9b5cIA9gPu/4d9/fK1ZaoISFLnzTdumzLgqP+938HV6
	zwRwbK5evhbiVL7tFi0H8v9CZTR/a7+GidqwUPGZ4a+PqVFfwFeRqKYSffmbsroebtB7HeqPeDs
	brUUV9jQhBzNTAs194+67oeEHfb2AP0oj0PhlGFCYIByazFOar8rmJHiQYKWKYwWvYfr0yaLk/A
	Y6Sh2sHHUBm1JfCFDG7Nd7+WWTpNTldrn+KXExd49z743CF4ah1C18dPuknQRApSg5zAOr4hV9v
	hcDTMJYZa+bq5xyMbNqG1SC5OSc7fYLmVJKI2J6j/ZFWZKG/sd6uxKq0ttw==
X-Received: by 2002:a05:6e02:2489:b0:42f:9649:56b4 with SMTP id e9e14a558f8ab-42f96495934mr6334505ab.13.1760015982049;
        Thu, 09 Oct 2025 06:19:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuLd6doij9uX9eFOZ4a0b3LPpTi2x2bpfbnZ3V6dXKn1WmTOSuYPaxXIOlXui8pryaHKbNrQ==
X-Received: by 2002:a05:6e02:2489:b0:42f:9649:56b4 with SMTP id e9e14a558f8ab-42f96495934mr6334115ab.13.1760015981514;
        Thu, 09 Oct 2025 06:19:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907adb1268sm1038524e87.90.2025.10.09.06.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:19:40 -0700 (PDT)
Date: Thu, 9 Oct 2025 16:19:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>, joro@8bytes.org,
        will@kernel.org, saravanak@google.com, conor+dt@kernel.org,
        robh@kernel.org, mchehab@kernel.org, bod@kernel.org,
        krzk+dt@kernel.org, abhinav.kumar@linux.dev,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        bjorn.andersson@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] Introduce iommu-map-masked for platform devices
Message-ID: <nzqte4glwtpjs5bhkxz43yhdufelxvqvzmg5tepudxwetimir3@bvlw5csjizsh>
References: <20250928171718.436440-1-charan.kalla@oss.qualcomm.com>
 <aec0f40a-8346-4194-8b18-1022fe3366bb@arm.com>
 <0d0560cc-9757-4c7b-8de4-170148d99481@oss.qualcomm.com>
 <ead7cf8b-fbc4-4242-a9da-b313dded1abc@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ead7cf8b-fbc4-4242-a9da-b313dded1abc@arm.com>
X-Proofpoint-ORIG-GUID: XIisFVHYZrBuQcPkztl3ZvLu39fNdYuu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX+2qfGX3i6/0e
 hMZSW62G/fyYLaw15QsI5hfE5B2+Hrf1ei89D7yD5vBZIQ6vJ8r63MEg4S5oKfg0rXKBCfDHHYG
 JtcS0yRWawBdhGvtK1OqI8xK8hxNQJEurY17WLsE4P4uNbZ3TqDFWee5Osgk5mVqxYOlvOfdg5Y
 KAkCnJj7KEsQeBP94FY0ze065PN7AhFzIvpv61QUZZp4Irin1m/ibNND08g2b6kKSXJ4tb24g6P
 ANzgK7VC71R+PpQE1MuBGh9/oWR3LvXd655dcmQddVCmu3LxpiBMj1L40Uep5VzNoQemEGbMXlH
 9hcL1VFJMD67u0x38n6hwFHTNyoRR3NIZ6fY+nvGoniyP1/yS2dPGkeXh7Zs34Qa797NcUonMy5
 +c+zJKU34gEco+FYH/Ybn8LUUE5OQg==
X-Proofpoint-GUID: XIisFVHYZrBuQcPkztl3ZvLu39fNdYuu
X-Authority-Analysis: v=2.4 cv=b6a/I9Gx c=1 sm=1 tr=0 ts=68e7b66f cx=c_pps
 a=vy3nvQW9C2dqy/lMnN3IYg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=K8VDcWk0KpU4SPYsRVAA:9 a=CjuIK1q_8ugA:10
 a=mHQ74H5e8mo-RpSg_uaF:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 11:46:55AM +0100, Robin Murphy wrote:
> On 2025-10-08 8:10 pm, Charan Teja Kalla wrote:
> > 
> > On 9/29/2025 3:50 PM, Robin Murphy wrote:
> > > > USECASE [1]:
> > > > -----------
> > > > Video IP, 32bit, have 2 hardware sub blocks(or can be called as
> > > > functions) called as pixel and nonpixel blocks, that does decode and
> > > > encode of the video stream. These sub blocks are __configured__ to
> > > > generate different stream IDs.
> > > 
> > > So please clarify why you can't:
> > > 
> > > a) Describe the sub-blocks as individual child nodes each with their own
> > > distinct "iommus" property
> > > 
> > 
> > Thanks Robin for your time. Sorry for late reply as I really didn't have
> > concrete answer for this question.
> > 
> > First let me clarify the word "sub blocks" -- This is just the logical
> > separation with no separate address space to really able to define them
> > as sub devices. Think of it like a single video IP with 2 dma
> > engines(used for pixel and non-pixel purpose).
> > 
> > I should agree that the child-nodes in the device tree is the easy one
> > and infact, it is how being used in downstream.
> > 
> > For upstream -- Since there is no real address space to interact with
> > these sub-blocks(or logical blocks), does it really qualify to define as
> > child nodes in the device tree? I see there is some push back[1].
> 
> Who says you need an address space? Child nodes without "reg" properties,
> referenced by name, compatible or phandle, exist all over the place for all
> manner of reasons. If there are distinct logical functions with their own
> distinct hardware properties, then I would say having child nodes to
> describe and associate those properties with their respective functions is
> entirely natural and appropriate. The first example that comes to mind of
> where this is a well-established practice is PMICs - to pick one at random:
> Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml

Logical function, that's correct. And also note, for PMICs that practice
has bitten us back. For PM8008 we switched back to a non-subdevice
representation.

> For bonus irony, you can't take the other approaches without inherently
> *introducing* a notional address space in the form of your logical function
> IDs anyway.
> 
> >    > or:
> > > 
> > > b) Use standard "iommu-map" which already supports mapping a masked
> > > input ID to an arbitrary IOMMU specifier
> > > 
> > 
> > I think clients is also required to program non-zero smr mask, where as
> > iommu-map just maps the id to an IOMMU specifier(sid). Please LMK if I
> > am unable to catch your thought here.
> An IOMMU specifier is whatever the target IOMMU node's #iommu-cells says it
> is. The fact that Linux's parsing code only works properly for #iommu-cells
> = 1 is not really a DT binding problem (other than it stemming from a loose
> assumption stated in the PCI binding's use of the property).

I really don't like the idea of extending the #iommu-cells. The ARM SMMU
has only one cell, which is correct even for our platforms. The fact
that we need to identify different IOMMU SIDs (and handle them in a
differnt ways) is internal to the video device (and several other
devices). There is nothing to be handled on the ARM SMMU side.

> 
> However, I still lean toward the first approach, as this definitely seems
> like it wants to be one overall device with a level of internal hierarchy,
> rather than a full-blown bus abstraction.

-- 
With best wishes
Dmitry
