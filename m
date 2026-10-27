Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102331;
	b=c4K5XpzNvm/Hm3kOdzIWMBUOJcVIrkAQ9s9CgubKv5POT7dmfP8BWoN1QYspWcyq9QKT
	 664PkzqPdEzeyNm8/hj8GgTOLoVRIo3SYrpMoYgp6Ci0Q65axIJN2+HkNYRbD+7MlWdwu
	 g80aAna1sv88JMd1IhIw7on0bcH/CXoz8yy6KQRmVv7pvySB8tLQPB+XHPS1NLADMJQfC
	 VO+nP6X7w0f9msljVtp3M+NYKnlNVSFC6ffkeSkUdhulkXdR1xcQfMFegfZob/hX+oVgu
	 DMJ++Z2RzQX3yug5k193CLkw1ii9rGKyzfZMGpQNXaXI9g1ceBaI8h0/Vg+ArtHVcYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102331;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8WFUrHNWaio59C4MJug1pehFmtY/vUi9V1RMigc1CXo=;
	b=ZHMUzCMDytprQf38JLtETHPlIohbXb3cKCLX6GcSOyzo/0Mr50J9/TPpWhqWjGrBC4/r
	 ZIOzy5QM7FpFca76Uly8GmT4y8z7txBj5fJYR/AnIM6TxEiX1OiR+O3qb0ZJ7vc3au729
	 IXx3HyyhPbPUPu+taARODyj8wrRGL82zt3lvKB2VGuEiFYMnptdtyhAVKvj/cVq5w9KWw
	 we6yYx8/KhAfn7nZRUWWGWxj1bizR7HSwvmXg2b2+KeZq06HKcDhx6aDkXOmc6z+929Gr
	 b+BEHNNlyP6/KojbygPbs36t+Tl3gp9UPqT2d1AbOfDSU2HuOSM4+Orc/MlM8ql8kAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kBfSKDWU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N0KpnqVH;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6632B606A31F
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 11:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6632B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kBfSKDWU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N0KpnqVH
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAeCiJ3012104
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 11:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8WFUrHNWaio59C4MJug1pehFmtY/vUi9V1RMigc1CXo=; b=kBfSKDWUMiXE2MWx
	UfYT9MTCvVbTk9XVkED0JWhz24h90TOvx3quBRZyIGkuBmeOcLVAASYHkSPc5jd9
	20OL1qOFckWZdVF22xCb4DHsImDKQJ+HY0gE9Puoq8vfCxMql1dRBYs6BmAlVWkH
	RckL2BFQH4slxrpmXRzhtbMnE3opd90cHsq4rPjmX5givw+9B3vXRWeJObmuRz6N
	eIczvP7UgFt+gMQysBziSYzWN+aCk2AJj+H9AcxTNT5TBbx8jcMrNpGfkkboZj58
	MM8fBhuJ041bi8ILWgKK1X+7Svs5sFcPpxWAhjOsO50G+lKkwvnJnlDOD4CQpqOn
	EscHRw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hje3davcj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 11:58:50 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7bf5c02f7a3so632415137.2
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793102329; x=1793707129; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8WFUrHNWaio59C4MJug1pehFmtY/vUi9V1RMigc1CXo=;
        b=N0KpnqVHHMktm375/9fLv1qzb6VRb81Tg1itXnIrRX6ln7DosRbfv7/qsb3udBCRPb
         1wDT+CXy+5eCRSr6phgEYlIBBEUVKU9kUqRlQ0ddKw1sQZudWy98iYH25NzrPsbPQRLP
         79nlPaEHP9z8QtcqbAJi0sz3FQGoG5HY50QfNAVsTI7Vx8IXH3QnJwT1mG1FHhAA5WjE
         YkkI01kSbjlBOzlHMpkhMxTz68PqbYK9g9oWLaV45Z7WkUzZyKEL5HeHMA0QF8W0SKMf
         bSyDbzZ9ie6s2emLmNSbcwMD7TVuiawXxyOdY3ZEZrNfrGvCO36omjBkJT592E50D/kH
         K5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793102329; x=1793707129;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8WFUrHNWaio59C4MJug1pehFmtY/vUi9V1RMigc1CXo=;
        b=KCefEYSsPKJkRi15S1ohWOEAR5yYxc1eDEPJUjx61uBTL5gJfrNz6X/STJAfpUUlzK
         JY1vtmmzcal9JFsiS6SR668vRNKfN/b1TZF8tYcUFp1uWC+8RKhxAUv4OF0PIdX5Gjuz
         g7ekUL/JTrvm+EXqVD6dJkKlMg8C/LZD4ajcu1WinEIwF1a3C5v03R4h7VWcXoUjy4PY
         H4IL4sinP0a4tEjaRzwFLos4PJqIOAhO4rfTRh3VcvDJC8PGFZydLjh8pwSKpt4ISnZR
         fq36YplNCMSmhDymk95yjYm16oFI8kxpgUiyt9y2yHELGM6u0cjLqcpWPO9oLU1NJAIM
         D4ww==
X-Forwarded-Encrypted: i=1; AKwUvBxpQPSzcxqSIkCCV9f9Fjkk5UDcmNHH8BFML/5NxDlZ6WwUWhR1uuWU5qlzfNwcTOeLn2DhTg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJLttJne1stFO7oaSnrPNkJlpk9y8vc4QsIDou4wkVt/QA/D0KG
	bmV8VcLaF/asVFVQCxUgk/o1edABjC4wO9eQ/z+XvGf/eeH/pRgXXLVWuXEGZRlX5McCoYsNNUH
	f9EB5j7ygz/IS4H+T5BCzR3wtcIV3UtGP7GowXtrJWwTMSgq+xjXKdR7c+A==
X-Gm-Gg: AYBFou0b6DG2anQJhYgnXKlIxZg78ljEsjoAJN7sZQzhME9gLt8+LPr5lD7om7USyTl
	9/y3qo1sruqayCeQACW0nuTWPDMwHSXGEHk7cSejJXn6HwifzyZYib8gi2qii13lCLWWmsHWEPN
	TEnnI7o8x7oep+joQ6Y6rsiTQhi83nX2wIhb47Rwth8T2a4mqPKmvHXlROrAy73Pluyx7UQJluR
	mNC6umui12CHCBpOqGXNwMnPseEyh1qSUmrkaSDKX9THKKeueUiz1g84H2f+ed8M9It1Ig4wlLi
	YVsgD6VpQkHy4mTCzLMJUwX1Oma7cANRY32jBL3/kH5Hk6dKNjXreHCMM6dXn2owhuSkpk+ZXtJ
	92wpy9i7Hy5KL+Lp1NyJctXtzHSAlPUZoBSq8EFIvj2ks8vHa8bD09eh2pKfCZGCZ7dO+nyugOZ
	bDzI9bjuXu7Dgc
X-Received: by 2002:a05:6102:2ad2:b0:7c3:875e:593b with SMTP id ada2fe7eead31-7ce5ce246dfmr3089882137.32.1793102329213;
        Tue, 27 Oct 2026 04:58:49 -0700 (PDT)
X-Received: by 2002:a05:6102:2ad2:b0:7c3:875e:593b with SMTP id ada2fe7eead31-7ce5ce246dfmr3089855137.32.1793102328285;
        Tue, 27 Oct 2026 04:58:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7a6aca4sm2092776e87.15.2026.10.27.04.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:58:46 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:58:45 +0200
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
Subject: Re: [PATCH v2 00/23] drm/msm/dcp: Add Qualcomm DCP display support
Message-ID: <55uzx3sa4jor5p7i5erhyuangyfvc3ssp5rgelagk4ysply2ip@3x46t7swwj56>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfX8+0Dy1Wulqd9
 4Qpr10u9lgjxyLh7fwjC8QRZQiLoZQUitqaRK8rrXL80XGCLAsfdlfhnE60KmHhIQ4n6Dh1BmIu
 4IhiJ1TGoX21BnT0x92u20FVrOKvWto=
X-Proofpoint-GUID: JDYvC0ewBsfB491m9xgNqACIMaQplr7g
X-Proofpoint-ORIG-GUID: JDYvC0ewBsfB491m9xgNqACIMaQplr7g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfX3v+rM/211t4i
 RnfYyPRHZToDZseiKNIYcwHyyVzearLyzV3a5Kf/rhxRga4y9gF1oUILfwqGaaNhEbz7h4fQbaH
 XPpScnPQd2PEJzmvyGuw6lBBeVGuWITleTdQfWbohxIJ7fkiCcuQWel7fhxi9SjYj9c9oWaSies
 8DSSlphJFhRL5ga9IgIA9AAAweSCdHhcYhC2x34MV8GbXLynC6b7jYmJDPwOdsnV0gYAg7rR7OT
 OGk4an/iwXot+rsYhd4vj1RfWNLasFDl0jOLARMd5B75u/3lcjeeB084sFxEb1tbzvWxXOma99v
 t9OUGNIR0jLvLRCqDcuJUlPe3uF/M0IWvAntsRrJhQoAFGe8z6Jxp0JFloboWhThu0VGwnyt55f
 wn0J5A1a3iGC/989nM/kESEGrR5PKEz79MUzY6zQSIFxZDBexi7CkLSwdBSUYivnOAYv2yHQHsf
 LDtOxdvPeoXklkppv/Q==
X-Authority-Analysis: v=2.4 cv=SN/Xx+vH c=1 sm=1 tr=0 ts=6ae091fa cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=sWvDS1lmqIG2hvCGZjwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270047

On Mon, Oct 26, 2026 at 11:51:10AM +0530, Jayant Shekhar wrote:
> On Qualcomm platforms using the Display Co-Processor (DCP), the display
> hardware is owned and programmed by firmware. Linux does not access the
> display controller, DSI controller, DSI PHY, display clocks, or other
> display pipeline registers.
> 
> The display pipeline must nevertheless be exposed through the DRM/KMS
> interfaces so userspace can perform modesetting, framebuffer updates,
> panel control, and page flips.
> 
> This series adds a DCP KMS backend to MSM DRM. It represents the
> firmware-owned display pipeline and translates DRM operations into HFI
> commands.
> 
> DCP communicates with Linux over VirtIO and uses the HFI protocol for
> command and response handling, capability discovery, and display events.
> 
> This series adds:
> 
> - Device-tree bindings for the Qualcomm DCP VirtIO transport wrapper,
>   firmware-visible IOVA ranges, separate transport and framebuffer IOMMU
>   contexts, IPCC power notification, interrupts, and the external DSI
>   display graph.
> 
> - HFI protocol definitions and packet helpers for capability discovery,
>   modesetting, plane and CRTC configuration, DSI, and panel control.
> 
> - A Qualcomm DCP transport wrapper which initializes the IPCC channel,
>   sends the required power notification, and registers the DCP VirtIO
>   device directly. The wrapper also implements the MMIO transport and
>   keeps VirtIO queue activity ordered with DCP power transitions.
> 
> - VirtIO command and response queues. HFI command, response, and
>   capability buffers are allocated through the DMA API in the address
>   space visible to DCP firmware.
> 
> - Synchronous command tracking, asynchronous response dispatch, timeout
>   handling, and queue teardown synchronization for safe device removal.
> 
> - Capability discovery for displays, CRTCs, mixers, VIG and DMA pipes,
>   DSI interfaces, and panel resources.
> 
> - DRM planes and CRTCs using the standard atomic-state model. DRM state is
>   translated into HFI properties for layer configuration, mixer limits,
>   bandwidth and clock properties, frame sequencing, and triggering.
> 
> - An MSM KMS backend, DCP encoder, and DSI bridge. The backend reuses the
>   existing MSM DRM device, GEM and framebuffer handling, atomic commit
>   infrastructure, encoder, bridge, and connector support.
> 
> - Asynchronous VSYNC, frame-scan completion, and error events propagated to
>   DRM for vblank and page-flip completion.
> 
> - IPCC power notifications to wake DCP firmware and coordinate HFI queue
>   activity across firmware power transitions.
> 
> DCP is integrated as an MSM KMS backend rather than a separate DRM device.
> This preserves the userspace-visible MSM DRM device and allows Linux to
> retain normal DRM/KMS semantics while display hardware remains owned by
> firmware.
> 
> The initial implementation supports the DSI output described below and
> uses resources reported by firmware. Split-pipe, multirect, cursor-pipe,
> partial-update, DisplayPort, and writeback support are deferred.
> 
> Tested on the Qualcomm Hawi MTP with an NT37801 DSC command-mode panel:
> 
> - Display console at 1440x3200.
> - Panel initialization and DCS transfers complete successfully.
> 
> Device Tree Topology
> ====================
> 
>   qcom,dcp-virtio
>   ├── transport IOMMU context
>   ├── firmware-visible iommu-ranges
>   ├── VirtIO and power-notify interrupts
>   ├── dcp-power-tx mailbox
>   └── dcp-subsystem
>       ├── compatible = "virtio,device34"
>       ├── framebuffer IOMMU context
>       ├── port@0
>       │   └── endpoint ─────────────── panel endpoint
>       └── dsi@0
>           └── panel@0
> 
> The DCP INTF endpoint connects directly to the panel endpoint. Firmware
> internal paths, including the INTF-to-DSI connection, are not described in
> the device tree.
> 
> Runtime Architecture
> ====================
> 
>   Linux DRM/KMS
>   └── DCP MSM KMS backend
>       ├── planes, CRTCs, encoder, connector, and DSI bridge
>       └── DRM atomic state and commit handling
>                   │
>                   ▼
>       DCP VirtIO function driver
>                   │
>                   ▼
>               VirtIO core
>                   │
>                   ▼
>       qcom,dcp-virtio transport wrapper
>       ├── IPCC initialization and power notification
>       ├── MMIO register access
>       ├── VirtIO queue setup and interrupt handling
>       ├── VirtIO device registration
>       └── suspend/resume power sequencing
>                   │
>                   ▼
>               DCP firmware
>               ├── HFI command and response handling
>               ├── display pipeline and VIG/DMA pipes
>               ├── DSI PHY and controller
>               └── display clocks and resource handling

Going through the series, I have come with the quite generic comment.
Please split the series into two independent parts:
- Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml
  drivers/virtio/virtio_dcp_*.[ch]

  Driver for the DCP + IPCC VirtIO host. The driver should not know
  anything about the display interface.

- Documentation/devicetree/bindings/display/msm
  drivers/gpu/drm/msm/dcp

  The actual driver for the DCP display engines. It must not know or
  care at all about the particular VirtIO host (or SoC FWIW). It should
  not use IPCC. If we pass it through to the VM via virtio-mmio or
  virtio-pci it must work as is.

Possibly submit those as two separate series.


-- 
With best wishes
Dmitry
