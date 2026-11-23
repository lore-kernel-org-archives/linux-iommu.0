Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462935;
	b=tpPSMhOvb+ZKRG5VnH1X6M/Ci1wW1W1zOc5VbPpr4gei6hTSKLIa3xHPoxsUN1X1kEYr
	 bXG1EY1TpEiuPq4FI+Mybyq3HoARFNA0Eiue+EKqJ6dZP8n8OUu99sf9CImChf8sj9Tbb
	 AwKeqfBdu0A21wk4UYqsjP8Mq6TypS6bNkQhDdBp3exbIxFmMh7u6N35D4jsed3EsTKaB
	 0qfAZMjeKhMMosDdfnxv/QP4CNbU/oQ2JeVZ9eddiBGbfxQmnkVvETXiftcjEXuycRg2A
	 q71yCjsUK68ewoGoY8AWIyYexjWtT9R/oG837dgg2gAJ8mpWX+O6VAkUSM4sjjxXeMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462935;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=TiJHHZoWYTxxWc307M21mACD+manX7RHfmlFNEd6ixw=;
	b=EXFsAwYGOJesD8ij1U/EYwvmlsJudRnM7VUR34++FliIUTexO1LGe6iBU/xUyosvQAMf
	 +mwrLS7ftD+I2T1h4HMdIMd24VUD8a13ihg1XF/hi/ZeGYzQ9RZVUiPtAsIxb5pZ6BiB9
	 43uSLY3w3xny9cjNSdbNjtYkB55fZ1svU+pX6hpQl5pdJaHq1SKkSckUM0jJ1MsgYRtKg
	 POI03vJfET3vffxTKQzgEaZdZaMLn9YNK7UY/1p4Y7ZsNpr31j5/Ql1J4/44WAfYAvuLe
	 EPUiThDesCmGa7afeUQp4nG7DmiT3gT84fSp7X1/UtDjPmSbD5gj2RIUGI8WDozIHEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ln3J9Mbz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jlkCPnXb;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10B2606A31A
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B10B2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ln3J9Mbz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jlkCPnXb
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGH96m3475364
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TiJHHZoWYTxxWc307M21mACD
	+manX7RHfmlFNEd6ixw=; b=ln3J9Mbz/Ri2MWC4Bqf9PAdfIdkWPONzyUcCiZt4
	FFQbUFaYfbFupBqSQIKQelR+CcKaFRG3ls9jggcGnPr9kLsDb61FoUsEJhChY/Lt
	8A8u/9DA8IM/QYMAu/12GJbsT2s6ojTMmD8HVcVJ1oG6tQioFqYqEO5K4I/cXo3b
	sQMtVbGe/Otl6Fh+4Bd+lS5BsFxnk2AOQzz2Y0KWGLbHOfeZQT4RyzK+mLd3qYRL
	soTv4XwtplyZKWaTyJD6PF/hkYRn9Jz/5m7PQ7sOKMyUEsvo+Drr++uofaBhid4r
	df8Ly4zgMFDsz0ibhPfx/ObtuJAraO7Vs+nJqS9HO+SoWw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4hn7tts3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:42:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-55d2c49c3d9so49644611cf.3
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795462933; x=1796067733; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TiJHHZoWYTxxWc307M21mACD+manX7RHfmlFNEd6ixw=;
        b=jlkCPnXbQXio9hYhc0511tiMwkHdQVldQgnYBKhqo6tH4d3rABBVjlmoBQg7dNUAtg
         hRrSGI2IqgKW3y8n7tI0JL7ZpzTal9NSlZV1KA5mNqV0cfpY+rVTSKU58bwloJLmpaey
         W0MXkZYiwddp/L6OcP/45AU40JofJjZn1EDOu3k0h/ev3Ae6q3ieKjjXMPxuHXC3AakA
         0SGNVIoJ4OU3el07w4uk4eYAC+SN4weDY7XNKv29gIh3vjnnfCyE04nwD9uy3QUlvWJx
         3Ljac+UFlsDAGyXI1BaxRRgea4NutmOpJJFO6hJQRN0aV056Y22IWH/+f2PCQn3daW6h
         WfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462933; x=1796067733;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TiJHHZoWYTxxWc307M21mACD+manX7RHfmlFNEd6ixw=;
        b=ksP/98eSTivxhN1P1ag/7hz9jngb6xqa+WjYJ2NRzqsthicP5umR2Y99jM/v1sZpys
         55qQ3BewwxNLAit2cWBvbzG04jahHsNHSNJpAh9WVn8lkbhbidayvoN768d71zdAA26Z
         GZXSovP52L3pMdehMcqCHE/R6IYmpHUMfY0X47LX0PFOAz0rg4/AeILcmtZ1TEIMlMHb
         cMNv5yRLDnQg9iNGT/T4De2U6quJ+0z8JynnK0JrXwIkJFjhgoZSq5nJ463u6UoFvPBS
         g4PDdYNXpwbsnXf8DkJXMgVWzBhqdoel9hE87SfraBWn5PphmCxN0NYU9eZy9F/zG6sJ
         Kbvw==
X-Forwarded-Encrypted: i=1; AL+hErHZSTdDVTyQlW+RP4RFHyVCUslE0qvjzhoIuK1qJa2XBdLXJj/mZb8XY2EBJWQJkU8Gw4T7aQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8SnA9bsBfnmMASc/2szZMZQcKBRZeM329h0TXNznBDJopFnFdz
	DwbSin5rYio+FZ9lDiHSlagmVHlMtMn/zRxT+Ij8iQB3Fmjx2a/ZZDtgRQCHVqTGLIjL9X9SMF/
	fLfhmJJrhvDnZq4NhfU4yQlQVpuKIxIwfE7oBbWk4W2KwNgSzUa/v0IguXw==
X-Gm-Gg: AZFdTZdkSBZk8KPYgfKOASd9eWVAOw2PXN8/rT6Gw9lzFXvm769KFp9HZrDoeWrgvMp
	IYIII+KGZYunTdD2BQngSgtEatfp0zptgKrdCWyIw6MUhhTub0CCLBzdN1eAAOfXk4QxjrtoSCC
	tXc6Le02z6WE5k7ImutogkpV4G/iW0SBf7Ni7CgjrfoDiB/JNDnhBDSR54xnc7jDOPggmr9zKj2
	lSXVxjIekvhWgHtieSQ+01t9B3XtfUY0AgTCQxYWiBD2QsHODfJYAPSKRyJsGwwikqgCNblNcFH
	YsIvCzLc5bNBGtD3tYlai/fJwympI3sw65k+eI3WOiNrAw/z8f70Sa1G82CzH2aolDzgNR5B4q2
	RuRAl9aVntQ/DrtkY6FsG6uU2Wqb2pcjBsd/TYJWJSUorQcHhl0IDBOej0flyOwNH
X-Received: by 2002:a05:622a:4d8a:b0:55d:2e72:1a03 with SMTP id d75a77b69052e-55d769b96c7mr239449561cf.27.1795462933028;
        Mon, 23 Nov 2026 11:42:13 -0800 (PST)
X-Received: by 2002:a05:622a:4d8a:b0:55d:2e72:1a03 with SMTP id d75a77b69052e-55d769b96c7mr239449201cf.27.1795462932439;
        Mon, 23 Nov 2026 11:42:12 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf62f7sm25764593f8f.13.2026.11.23.11.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:42:11 -0800 (PST)
Date: Mon, 23 Nov 2026 21:42:10 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RESEND v4 17/20] arm64: dts: qcom: glymur: Add HSC_NOC
 interconnect for adreno SMMU
Message-ID: <6obybmhvyuxsp3jarjv4z57ojjfprwss3mer4vq5x56yhhl7kk@fk4ysedbakif>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-17-be30526391d9@oss.qualcomm.com>
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
In-Reply-To: <20261120-smmu_interconnect_addition-v4-17-be30526391d9@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Ls0HWXdc c=1 sm=1 tr=0 ts=6b049715 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=P-COMtFXNwbjGjwEE7UA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfXwmvEC9sgk5oh
 TER4AbaSQe+f5Seb2NXxCSpn8FQ24VdGuRqGjH8TxgtadyQCXMYKFx3GTK4H0qgci6AcGlhZ5hi
 uUsLbT2S7KaT6y3u4BRAUedV1liIkpvJrCkV0pvuK64DiXuNUhS/mLAnf2Riypqk1n9Q1XuOTr8
 HOJXu0us9Q/3F4gdbCrimj58RH+YuBkEXllQ6XgpXG50jCx5lDHCIc611svPPPdgOLFu2/nztLv
 Qza+m+dFUih3Lm6LvVOKxwzQKI+wzvp/Twrgjp8hsK19h8jK8pfMbppoFmIuFl1bIxr5QWRlSr8
 fu99YOwO5A2CDmSEiZ7Wf5hpwDrkd4U2IOcn8WjljL1p1tW9r02EtRGC6ihhpLXMVr0zSL/6706
 ZYORfhoIj1VliPZaga5VdQ0//yVRQk4j1uQbpHdRMWZZgkXIAdgY4Vjkoipx7CJxpVa+wZ50skZ
 PK9ufRZPq469RkqGjHw==
X-Proofpoint-GUID: e2E1g0BPP8vrkHpjC85nyAIS0wWbskEo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX80f11/RojrkH
 jCRgLSwGyh/JdxM4JiDEWhNuuBnoRKjjj3hzeMqA/tTYnGHpP6AxaD1bC4ILKmKpQ6YSIA4hoIN
 p6Zm+34GNhcfJUSMUPhmezbQT7yVynA=
X-Proofpoint-ORIG-GUID: e2E1g0BPP8vrkHpjC85nyAIS0wWbskEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230078

On 26-11-20 19:11:48, Bibek Kumar Patro wrote:
> On Glymur the Adreno SMMU GPU TCU is a separate hardware block with a
> dedicated alm_gpu_tcu master port on HSC_NOC. Without an explicit
> interconnect bandwidth vote, the HSC_NOC path to DDR can be left
> unvoted during sleep/wakeup transitions, causing intermittent SMMU
> register access failures.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
