Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406392;
	b=0Afxib7X6uBqZLpcg71u673QxRG4iJ2Bo0hgq5g0N3xpZaZCabkedVi1Dp+y6eeo/R05
	 SufEPkxB1uEvhHxW7A+5omp5OFCkSUdNDD2yNDiKEn5/49U1T/PBbiDQGc8irAq7mIMQy
	 Ltnpjcv7RSKrlzYBZyJ38Axu/MT5vRzdNCy1BqbQnl7i4tNYMvactZTgINLpAfvAbMnMw
	 gRV2fQGUJvXVSg6UdlDdgNMGzaqQpbKwGej9Qo+PAlWaxIK1RqZvtcNjawCWTfUuIwF/l
	 bwRcO1FjTB2G8ggRph7fX5cv7jhMdttfjGK4X/QJyuLz9kKhSqMDhKQKrqavhNrxqlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406392;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=llfh8etuwqMEBoatS7BG9atTA4vpv1pJNPCbkPuzpyI=;
	b=gai09/YIwxt6qcAI5y+SoT7733RvN6A3YGHVWUe7WmOWSwanv4vaOhmly6W1pHo4YkX1
	 U5lGbZEbNByO3BE0NlXJDzNZSABaiWLQrx/2fpb7QfPsI5KJ6kgnUk7p7/a2z7RMx4nE+
	 9/dTp1S+/1tMMcI3Y2zfE48XCaR1S/PKHvsJhTGq3+OzJqev5WHb0Mgr9J9RtHNKX1f5w
	 JGKaNjtNPWh8apUUqPBWejhJPHAijBfh2MvThODpuelMu90dkTSW8J3uwlMxaYPO0mH+C
	 AhJf5zpfO09rJlngs3FIU6BQCr53yMCLVfazh3vzO+MiJP99FS17JXrVCVwn6O3fitA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="ZCbj/bq/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P37pJT02;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DE1606A336
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 14:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8DE1606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZCbj/bq/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P37pJT02
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCYwi2300500
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 14:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=llfh8etuwqMEBoatS7BG9atT
	A4vpv1pJNPCbkPuzpyI=; b=ZCbj/bq/7etR5mduMsXYp0jpAwQ/AZdMzdYdASci
	VmMJONZ+iJEIUbANBiDjtZphcWabwse7wGo9h645cixX6XcXKZ/uGGfPLJ4JCERB
	e8I7/d5uvjtX6Fw9P/v8ncTMUJg6MECCmrpbVV9qB8RiuOe8CAEq5tV0DSgzvrXS
	ey5Gg1BPNsa8KT+NcxPxPlnh+AJcYxc7TyWgZXzrM+P5SfYUHqybWuG1ftpAHVZW
	5w25MerOy+XYX+KP/GioZbvtfeBkosizv8g9POZL/G7BWgPNt+jueA+IlNyGQM38
	I9qm7lpjucG7INeL2Za54FsOjajj4386I+7u307pJIeOXw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvpjjrvar-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 14:13:09 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9907de400a6so517381241.0
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 06:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794406389; x=1795011189; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=llfh8etuwqMEBoatS7BG9atTA4vpv1pJNPCbkPuzpyI=;
        b=P37pJT02fll5VAqvLNE8taolV3X1t50GxToR4R3nJyS29yupT4P84L/l1KADc4+Ajd
         sy66H3El6ZB+KT3htPzpVHyHnL26SZFGTUmeQDXbWU7oAaPvCQSbgh6fx5n7TUqsfimt
         ikvX1w2UriHp/xBUK+AhrMMcW6DyK3kA/9xnTqUIQQzQLp0DjpGolqEiFppPrA41w5Vp
         Hmsf2Mst0eMN86hhyJ6JuTpMHehuPInlbcFySI/QULEzrm9dL9GOfVVQick5pujL+2EU
         0vYBgTCW5LIHPfjXIaefnqlE16Vq7i/k+om7tTpw6Wj+uRucQs6Anm5yXqqFQBhf9WyN
         AH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794406389; x=1795011189;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=llfh8etuwqMEBoatS7BG9atTA4vpv1pJNPCbkPuzpyI=;
        b=b44qRok0isJ7ctMyYeTDmsfSl3Kk/WlvENEdPW2pM8C9iJqwJVw74fCpxrzuAFbE4I
         etkRx6izXzwfqWVGkyd/mMxtscj11s2BAnji+Wn5h6qxoKn0Udi0h2uynjaigPF9712Q
         EOV4FrxRYiTpodpd/De7UyqSiBWNozbUmiGWF/QEdqfKiFCs4FgfHDmMOspRdnm80p/y
         8k5aYnxbCwCaLNcc9Xmcw2knVh0weNjclrxdEWEHL7XrIQZc0YrZsgoPc+Q9Tvpb2wh/
         teqgCMBQUQZ0wL7Q7l2B0pyNjbrHiEuxSI9R6AaJE8grgTBmycVrSPU1tlBLbTfPUtbZ
         HO7g==
X-Forwarded-Encrypted: i=1; AL+hErFsQfYOe//WsqQV12KPxfCoSbsFxaVzagJhQvZuai21SHh9ZWNnppbTTGnblGB30vEGoD9oog==@lists.linux.dev
X-Gm-Message-State: APuU4Z8gvo6r8H45i87mPySlOCy/wL1yS0BIjnf+K3XlpO6IZVB665Oy
	o5Oq92kigoSw/Eeofwk3LzgltumZv0Z8Zz/hp+yF7KeZYZpcXtV/3gEyAQ+b7VEWC+rgugVvZgm
	5yzRUBvLY9pt8xY3MgHHX38eDK1pWApz1Kg1dRejpf1gke9Tp9kdn7DymcA==
X-Gm-Gg: AYBFou1rhmuxMQW4xFb59vg9prBmvysuqiHBpv+OYNoPPbEz1jTiYoiGkbVpdbBfl3x
	e24jLXESXu3PRaCXCvpVSYT34TeBQXHeWZQI+hyRek4EkMXc10FsTxkdvuTI0axkkXHqU3To7x2
	BHdnN93sHUPc2UDTh0dhQ2zP6a8CsfjjSCaW/uvs2PQphOBd2RWh4tGiV+7Wj3mDNYn03QFiCKx
	ynoVymI62XfRGcCX4eWHvB7cFCgjNa42qUmg5n4XmknLH09DjmUFM0yqgHVOtS/6RTLHsxrfX9f
	cpGIssAyB16X1rNmCQJsQnRZUdEllLH1AEXXavoWQ9dFmxgBxaJEeCuNgSJb4YD06VXctWU59IP
	MU/1BHy4BI/5ejVSDpwRKAw3Y7298K1pdHLS8+uEGVisDRB+ook2ZPapPmEHcYGcPe0pgyfua0v
	9GM92y9ip6UQs9zdP+3jQnjEGEUGQTdtlwdN82rVRg337KsoLnkmgnTtFnNBNA1Q==
X-Received: by 2002:a05:6122:1b09:b0:5ea:94cd:c5d7 with SMTP id 71dfb90a1353d-5ee1c462ffdmr791565e0c.16.1794406388803;
        Wed, 11 Nov 2026 06:13:08 -0800 (PST)
X-Received: by 2002:a05:6122:1b09:b0:5ea:94cd:c5d7 with SMTP id 71dfb90a1353d-5ee1c462ffdmr791529e0c.16.1794406388144;
        Wed, 11 Nov 2026 06:13:08 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157bb7839sm956114e87.74.2026.11.11.06.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:13:07 -0800 (PST)
Date: Wed, 11 Nov 2026 16:13:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 01/23] dt-bindings: display: msm: Add Qualcomm DCP
Message-ID: <34hgm3yw4z4kbulvgpg7c2iunyui5ljn2l6fqq47prc7s6hycn@c2rnwvhcn5x6>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
 <fzchmbho74ii6d2zhzni4qy4g74hiwv4fwf5xudrqdrstt6klm@7wdoo4acr6fm>
 <0bf2075b-e507-4b81-a563-f7b4e7e2cbc1@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bf2075b-e507-4b81-a563-f7b4e7e2cbc1@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX5qP9ulvblktK
 zM4FBQGdf4MQ7MARiwFowIjpmmBqHwmDxlSCaJBtOlzGVWgOQDde9Bep98LWKcvJ7MjvGOUYWwU
 k4mr1MmHgXo2VXOlnxeucn80tEXOt3nyz8W5NLBDUKTmI78wpuP6SLAxXCl2W6nk2G5xrvdc6C6
 0jZHD2RxMtMjFY//IrAvikCp67d6mO4QlgNdWG9c2MKvIqt83C0X2G+hMPMx8V8TYkmb2VWZUF3
 pkTxewck2C6LvvV5W65l+MigxOLFJ5Lt2Oo50r9OiX3Cwu8HkrKg6OuVLKWADTZwpjaFe1vyCWP
 XJ7gVbrDQqdjI1TVTwX9LnoyRaFg7SuhcF2actxxYrHYD9vhhLPFhwEMvgVyEloT4xxuVwpZvIQ
 dlh3XXJjwfWCgxD2OpyYuFscFvBlBq04FDfclvC1iwW8qdxSkA3RbGv7ENVGAi0dHujMmqNmu5Z
 h3KqcivsOPs40GnLk4g==
X-Proofpoint-ORIG-GUID: 098M1rNO3RapinOGIOgymYAMQaPpSCsR
X-Authority-Analysis: v=2.4 cv=FeuiV5+6 c=1 sm=1 tr=0 ts=6af477f5 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=XCsYekLr3cgse1I9aysA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: 098M1rNO3RapinOGIOgymYAMQaPpSCsR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX5JuYnV5F2EC1
 itijQQUnu7vvyKtXqPetnAO7EUVLNNpQ6pjGlL4uuZbDVgAMX/ewwz4dlgthZrmR6kBePAYARQw
 7jPRsYGTHeNBvRD4CInyOSHNLkdOV0k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110056

On Wed, Nov 11, 2026 at 12:38:54PM +0530, Jayant Shekhar wrote:
> 
> On 26-10-2026 15:27, Dmitry Baryshkov wrote:
> > On Mon, Oct 26, 2026 at 11:51:11AM +0530, Jayant Shekhar wrote:
> > > DCP platforms place the display pipeline under firmware control, so Linux
> > > cannot discover display resources through direct register access. The DRM
> > > driver therefore needs device-tree descriptions of the Qualcomm transport
> > > wrapper, display topology, IOMMU contexts, and panel connections.
> > > 
> > > Add bindings for the Qualcomm DCP transport wrapper and VirtIO display
> > > subsystem. Document the IPCC power-notify resources, transport and
> > > framebuffer IOMMU contexts, firmware-visible IOVA range, INTF graph, and
> > > DSI panel connections. The wrapper creates a standard VirtIO-MMIO child
> > > after the IPCC power-notify sequence has completed.
> > > 
> > > Assisted-by: LLM
> > > Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> > > ---
> > >   .../bindings/display/msm/qcom,dcp-dsi.yaml         |  79 ++++++++++++
> > >   .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 123 +++++++++++++++++++
> > >   .../bindings/virtio/qcom,dcp-virtio.yaml           | 132 +++++++++++++++++++++
> > >   3 files changed, 334 insertions(+)
> > > 



> > > +
> > > +patternProperties:
> > > +  "^dsi@[0-9a-f]+$":
> > > +    $ref: qcom,dcp-dsi.yaml#
> > When adding DP support, would you add more devices at the same level? If
> > so, we risk getting a warning about multiple devices using the same
> > address.
> > 
> 
> Is it good to model each firmware INTF as a single interface@N node carrying
> the INTF reg, with the protocol-specific DSI or DP description nested
> beneath it?
> The driver can then obtain the INTF index from the common parent, avoiding
> duplicate addresses across protocol types.

Yes, it might be good, but it's not what is happening here. You are
adding dsi@0, although, I guess, INTF is 1.

> > > 

-- 
With best wishes
Dmitry
