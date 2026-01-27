Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5940345743
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769514766; cv=none; b=kPAEJ98DW0W9OdMDlYf2V1aedNsoEK8Q4loCHnNSUU1Nkh+iwtm9+GTaFZRu5oECQHVm3gKONRQGkairSWlQxtXBznGUOFotUU8U0DrgzO0j0mmMigVZUbj00D3RBSpmtZMa7iuQogov3SFR2Nv18BgMcONMqm36uONczJTEQn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769514766; c=relaxed/simple;
	bh=6JAzVZsU4KubP9IgDxyR6AZcv2GMmZ6+OF1QDY+5G9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrF/u/D/cpuXwIpCNdPTF8HoZGB6HzKsP6/Kp+6VAEzyy0NoBs8qV0CA8CFM7CE9peVevF/ddHt9B9GtHntSf5DRYSSjmFzeBHgLyEHKq4TnpT2rTxESQjpWcipQwraMamyk6/K42GAkCUl2xFB3ybtwd/pzA10Nnx3ehs3RO58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TPJ/IBsB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FkX5lJKT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TPJ/IBsB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FkX5lJKT"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R7QJgD658517
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 11:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IdKihRKTuK8o6lDlHKbGDjAG
	XAhwUnc+3Y9rbly4WSo=; b=TPJ/IBsBxG1S9yuDyy5ey4JJRo5GkUrvhw52MFOD
	qXejSeLKkEKKcqLpbSTETpqBscszsuhhzSjxd8PV1Wl6txIIlFOW90x7X+Eeq3Jw
	WpaHCsNojN3UKCFFQfHphWUtG2sFt1bWwk6mCER7SQITFF9EPmW9F/C28i2PSdnl
	utlkyjOHYZVQMLCxtNKRhuN9OTvaLp1rwLZcKSwH0NNvyjkugVuErE8XVZmEe4Ye
	/Yx6NopRAnuNwJ/eknWaQCDZZuF2uzwbrZrpKtAGAJ8rZoZ7DcAEOhS/EzcTfgY0
	rCehaEJgsq7nyagfXblCj0b0ZJ0MdxtCMn+aIylXAjMUbQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxryn8wsn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 11:52:44 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5f53b7f1341so5195903137.0
        for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 03:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769514763; x=1770119563; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IdKihRKTuK8o6lDlHKbGDjAGXAhwUnc+3Y9rbly4WSo=;
        b=FkX5lJKTOkjGn+QDEN1Eeig8wZ+m6XGdoswJH9Sh7yLV75wDNfDDfjAal0DMFfaNX4
         u0BxSFVjJbbLtLF3oV6esLy761+aCO5KnKnjYZuoxCstW6G3+SyHnsCNYWzkRyidMq4m
         RCIRWkR2+aIUxTk2QiBPGZpE2v9PnjQhbzFqcWUmVZ0exwhKHVMOyvvnCHi3ITx/1kLj
         l61RvPcFAMMfPK9EcrN1FvWba3lEyfUDQzbhEI+s7CqXRBsiD+QhTPMtzxaVe6/fDWxi
         Owj3G0ZEv3qQWLpF8tvW6fN7JQe3XSQrkhvHnapN9iUo1TwKVk1xykqk53PxICoQwVzG
         eTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769514763; x=1770119563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdKihRKTuK8o6lDlHKbGDjAGXAhwUnc+3Y9rbly4WSo=;
        b=fFMTsvxEzNDBZ6POM4nXc4knKffo/pBhcixHckYJW95LkfZyEblbCPVjkmUtlOYQLH
         0aAaDvQFk0aljzAgI2U6Y8smY01jlGDzV1UjueY4H6SkKPZ+0Bm7jieKlV1A43AEFzrM
         6/J+6Ki7q5QHGnVJMEXJIngkJdD1/aY3QCbaFA7FI7JQQ2Vjr7NCEEVFdQ04gQgXOPxg
         zG89pxWUHLcMcpvPD/2Is5hiRacfTWD59ECXr8N5epgrSAhDGqFmbGne1N743Qcr9nnM
         H3VsVe+P7mNsEsqqmbvhtmzTuLFuIl1QiQSeRNL75R3lYGtvrarm/k+AugHzLPDTQYJK
         YaIA==
X-Forwarded-Encrypted: i=1; AJvYcCXK6sR2S7do5yWnnkm2Wy3sYkMmOqc/uU60ceF29jfkq9lK6DaVWtlg5gJ0qzhQi69nfK7kRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyuEzxWSECLmfmkTtN/0alAbYtj9dnDSzzUgc7tQoVnIj6K8LdZ
	pd8GXZ0iphbupuyhv3d3D5ABMNNE4rzppUSNrbwjp7V+X8oORQ1BGCHiiPVA26DwnENqR3EfFWX
	GD43XcguO8q+vgbtReRC8iGzdc7XpMzuucKfLmjIHGrZBSkEVTc6upXRfpw==
X-Gm-Gg: AZuq6aKyyEv/4+FZe8L8vdMKJFc52e8PvBnMS8U49B81dDML8zWECoSXJiBhPyvXNnN
	xI2+/xfC9bzcORh0BrybaN560ntFoJcHQMuwVseWvIUm436stckHwG7h4Ni4mvERyofDw1TFWca
	bkI7slUmQ24C6FnzaEYvAGA4wxXMUdQ55cKOWDHGA1+bhV6ZOw+yZHDag1pItT05cQB5alKVwZY
	z5T2aznuK3YR13nBw5ATbCC9jjFI9OVkcSU7aMGu50P3U3d1Juho0CJYz2BmGQp8qnl1WApxs5+
	JC+/D5Qxb8sfUi4fd0PhOYTFWbZy0Nhg3SXlZozBg0sPvn7ZiYBdc/r0sLWTiQlYf11VagsYPUi
	zTeMDfmYhOf4HSWwU/DvuA59BTOMhXi28aIQCxbbecPDEAVMjjvD7W7VFZpFg1Qb3Lhr08phz3y
	euBpt08If10QOa/DiT+8VQdjE=
X-Received: by 2002:a05:6102:3ed6:b0:5dd:84f1:b51a with SMTP id ada2fe7eead31-5f723841222mr634357137.43.1769514762539;
        Tue, 27 Jan 2026 03:52:42 -0800 (PST)
X-Received: by 2002:a05:6102:3ed6:b0:5dd:84f1:b51a with SMTP id ada2fe7eead31-5f723841222mr634345137.43.1769514761958;
        Tue, 27 Jan 2026 03:52:41 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de4918a16sm3564116e87.59.2026.01.27.03.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 03:52:41 -0800 (PST)
Date: Tue, 27 Jan 2026 13:52:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: Re: [PATCH 0/7] media: iris: add support for kaanapali platform
Message-ID: <vv4stkmrrwdqmbnpv7pg5nd4immtqo5iplwbcia3oykycfmg2m@dsithotfy5ls>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <lpgw6eodclsvfwgvtljfiorvjkpd5vd27yhxs7i3ijfibaqzuk@bak2lwbyh77f>
 <2d4632b2-916a-4eda-ad08-44af68461dc8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d4632b2-916a-4eda-ad08-44af68461dc8@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: n4qP3SkPfUwYSRvjaB5E9HDp7L160Mzu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA5NiBTYWx0ZWRfX4v1Q5kZMQsHI
 ROeBosbEWwDrGdkrHcIlLTLMP8BwFqOeEeGLT/hmThuGa4kO+GuJCKDhesr7GCj7LMmIpch/yhQ
 76bVm+HNdTx6cJ4qxEIgb3Kkhj3mMkQK0ycloIGeq9o2dmBOwdT6zEGt+SuEGUauf5IVliCHRtc
 wYTyDV81Rtr5bK7xJlkUwrWbXYSaiX9vmbjaMYZFFJtIusX+JbgCdZZX6xDNFFw4XNn+670Ov7c
 KUlb6pQWOpi5tZAq5LwPYmHq9EWIPorDShVHsqTzVZL4llVOG9uFJGoLVPzamIR+h9g0LRkPFU3
 3bxaPdKBA6oB7bi8JtWKrj0IyqgcbqifAMmRBpttD2O15qiiypvV/RwKYIhOBn/eTZbTcMJh0U9
 X117W8inKDzYH74PM/yMrMuV9DiHB5Si4/ms064ij+53cm7aZW3yHq4ecSnJQqTbQR2a7e7E2p7
 O+uH+g5Qv0KFoFYcjpw==
X-Proofpoint-GUID: n4qP3SkPfUwYSRvjaB5E9HDp7L160Mzu
X-Authority-Analysis: v=2.4 cv=FsEIPmrq c=1 sm=1 tr=0 ts=6978a70c cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wY_k35-0G0TR-rtl6zUA:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270096

On Tue, Jan 27, 2026 at 04:56:34PM +0530, Vikash Garodia wrote:
> 
> On 1/26/2026 7:08 PM, Dmitry Baryshkov wrote:
> > On Mon, Jan 26, 2026 at 05:55:43PM +0530, Vikash Garodia wrote:
> > > Qualcomm kaanapali platform have a newer generation of video IP iris4.
> > > The hardware have evolved mostly with respect to higher number of power
> > > domains as well as multiple clock sources.
> > > 
> > > The series extends support for multiple iommu-map entries for the same
> > > input id. Considering iris as a client driver, it adds the handling for
> > > multiple stream ids from VPU via iommu-map.
> > > 
> > > This series is depend on the below series:
> > > Link: https://lore.kernel.org/all/20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com/
> > > 
> > > Following are the compliance and functional validation reports.
> > 
> > Please validate with fluster too. Having a "knowingly good" command line
> > is not a validation. It can't be reproduced by anybody else.
> > 
> 
> Below is the fluster result on kaanapali (will add in cover letter in next
> revision)

Nice, thanks!

> 
> H264:
> 77/135 while testing JVT-AVC_V1 with GStreamer-H.264-V4L2-Gst1.0.JVT-AVC_V1.

What about the extension testsuites? Even if they are not supported,
they should not crash or cause the timeouts.

> - 52 test vectors failed due to interlaced clips - not supported

Yet or completely? Does "failed" mean "returned an error" or something
else?

> - 3 test vectors failed due to unsupported bitstream.
> - 2 test vectors failed because SP_SLICE type - not supported by the
>   hardware.
> - 1 test vector failed due to unsupported profile
> 
> H265:
>  129/147 testcases passed while testing JCT-VC-HEVC_V1 with
>  GStreamer-H.265-V4L2-Gst1.0.
>  The failing test case:
>  - 10 testcases failed due to unsupported 10 bit format.

MAIN10? I was actually surprised, Venus driver supported them for the
Iris2 hardware. Is it somethething to be fixed in future?

>  - 4 testcase failed due to unsupported resolution

Can it be fixed?

>  - 2 testcase failed due to CRC mismatch

Which means an error in the testsuite or somewhere on our side?

>  - 2 test fails due to session error (under debug)
>    - PICSIZE_C_Bossen_1
>    - WPP_E_ericsson_MAIN_2
> 
> VP9:
> 235/305 testcases passed while testing VP9-TEST-VECTORS with
>  GStreamer-VP9-V4L2-Gst1.0.
>  The failing test case:
>  - 64 testcases failed due to unsupported resolution

Can it be fixed?

>  - 2 testcases failed due to unsupported format

Hmm?

>  - 1 testcase failed with CRC mismatch (fails with ref decoder as well)

Could you please raise an issue against fluster?

>  - 2 testcase failed due to unsupported resolution after sequence change

Can it be fixed?

>  - 1 testcase failed due to unsupported stream

?

> 
> > > gstreamer test:
> > > Decoders validated with below commands, codec specific:
> > > gst-launch-1.0 multifilesrc location=<input_file.h264> stop-index=0 !
> > > parsebin ! v4l2h264dec ! video/x-raw ! videoconvert dither=none !
> > > video/x-raw,format=I420 ! filesink location=<output_file.yuv>
> > 
> > Neither of these commands specify, what exactly was validated. They
> > specify that you've validated _some_ videos. It's impossible to even
> > reproduce your results, because you don't specify which files you've
> > used.
> > 
> 
> commands are shared indicating the pipeline used for validation for
> different codec plugins. These are some basic encode and decode commands,
> and shared for reference for anyone to pick input test files of their own.

Thanks, but it would also be helpful if you stated, which filesets were
used for validation. There are enough public filesets for testing video
decoders.

> 
> > > 
> > > gst-launch-1.0 multifilesrc location=<input_file.hevc> stop-index=0 !
> > > parsebin ! v4l2h265dec ! video/x-raw ! videoconvert dither=none !
> > > video/x-raw,format=I420 ! filesink location=<output_file.yuv>
> > > 
> > > gst-launch-1.0 filesrc location=<input_file.webm> stop-index=0 !
> > > parsebin ! vp9dec ! video/x-raw ! videoconvert dither=none !
> > > video/x-raw,format=I420 ! filesink location=<output_file.yuv>
> > > 
> > > Encoders validated with below commands:
> > > gst-launch-1.0 -v filesrc location=<input_file.yuv> ! rawvideoparse
> > > format=nv12 width=<width> height=<height> framerate=30/1 ! v4l2h264enc
> > > capture-io-mode=4 output-io-mode=4 ! filesink sync=true
> > > location=<output_file.h264>
> > 
> > At least these should use test sinks in order to be reproducible.
> 
> it is using filesink in the pipeline to generate the encoded bitstream

I should have been more explicit: test sinks to generate the image.

-- 
With best wishes
Dmitry
