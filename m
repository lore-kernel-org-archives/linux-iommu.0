Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668B361657
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769532596; cv=none; b=XoqQXd5QeiYQvyXt3nzj1ATaCkXmh3NOntVlFDnICWaEaHCdL1bVPNk7dQAGUYmNuDybATAYu9h97jueWgg3IJSLmrd4cmIRIgIU45CUPY2V3wPhXkPjyilwQp5wtUzLhm8hzWsN+g751b7rycpD5hdmNrs7JqVYyj1Ahzny2rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769532596; c=relaxed/simple;
	bh=uI2HXAW17zYtOEMTXnjlUKn9NrrZpUIxt/eqbaiU+Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2fcRHuh+ZrSASUByBDeGpyCVwjKttildJ31Q3f5kGokETXBD+huBmTempBE2vhbPv6EXHEstfpbheQXMAxhbYTmLvgDUaOsvF/fo86bLkThyJs8jhHmnz5xOfXS+p332YkaTau14m8SzRLldHlUdSY7F5UfWUdGVaTnBQRmm8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PFmZWdbd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HsIdk3eZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PFmZWdbd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HsIdk3eZ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60REZwak1066277
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 16:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yQo6VrZHfmG9VNHQSAg9y8t7
	eLlTHj5DLIPChUOy9a4=; b=PFmZWdbdxzcBW9ca31lVQLc+xXMI3DzoFV0gl3zk
	7qw2Be+dAUUZiAMTyOM56y71ppPWLB53fgboIv6wgpgKDDMvUn2cmSk9qMZRgkiJ
	nx5yyrMVBZyXP+oMkBH5h/LQpNOCRF9mznreE1Uf8gr3JnenyWJr1x+69cuHmB3e
	NTFR+yNAazM+KDyLpd1srghzyUW0XogeDHz/X3RrX5NPQ8B6zkaUAfHP/4r3hUCd
	XN1vX0/AVVn/6PVDAhVfW7H7tAO9qcHOtI4t/MMA6jRYo7xH2B5NUNZpk+eic6Ct
	ndfhV5Ta/DYmn5C6gRf1IOQsPwAuRn7XOKlP2xtswWzwfw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxy8x0h3m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 16:49:53 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-93f65d0a94eso7884609241.2
        for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 08:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769532593; x=1770137393; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQo6VrZHfmG9VNHQSAg9y8t7eLlTHj5DLIPChUOy9a4=;
        b=HsIdk3eZiTPyg8H/Rske6ZbFL6W6235ctHGXlWIzxTCLR0OfyZbJvxe7b7b8DP5b++
         90J8jiYb5JIxKHDayobdAXrFqVi1jhbuS82za1u6mrql2bU09bvO/HiVHiDLzHLtanQj
         Y3omBULjDwm/2/vz+4yIBXl7xQzTObus2gJNw3DgoYqQOcyLGCeZijelHE4Z8oeKWmaV
         t18aAo8Y2GCruwT5ApmV6FJy9RFCu2GBNyZNTJzO+ssEi/2Bojvvm1BSG2wFpfDpfxt4
         ELB6fD4VVCW4zF6uCKosxkNxwmvnYpQgzQgja1z4ZOnkLt9O9jSFeYkWECWuz18L8LBA
         FWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769532593; x=1770137393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQo6VrZHfmG9VNHQSAg9y8t7eLlTHj5DLIPChUOy9a4=;
        b=uR5zvF6GmQ+dsO6KMz3Bv1xFdQu3IGh7eDDKPAcXkRgyb2Ae26VmTGWT8aE6ydSJ5k
         SZWwmupu7NTAWxNgPXM8rcoLeBnqsjxoiYLDKpBCAglWYjYbvl2t50SbPRNb7MxSvlnq
         r50sLQOYNrBBgX3rNzhKECELtnPbXRg+Vp7+roYE9NKbeeQuKsGYNTs4t0ybvtXPr1m8
         HjQRq06UhvYBYczeuC0KpnPb2cF1IaMnCDDQyVKEl0D0M5NC8buk0jH2/S6/MNGUYTfX
         Ax7ArvXucne9J/lhoNmx/Bb/p715JhWYjesyo7t4H1jhcPQSYK/olUx8WXbvt1Ri3Nhq
         3YVg==
X-Forwarded-Encrypted: i=1; AJvYcCU9m9k/tWKnt9IOD/vg2v+Da2/n/KGypjdqYEXNcg0CmdebdCoEMotQNiBUbhpILuBb/4SUng==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxj6A933gDblhxVfvfy+hA1EhWtkLRtPItmlfOlsIAK5DEH/Vh5
	jOSvJdUkJVyXYBxNrFuBGvtyYGpy/CgxCeNBwwz3wj5AUOLdNBOKOgCW7JHRtmRa5j+Wxs73BSK
	twDSy4P9OpnwHh4agiNgARUIyHrteqN0IHv/3H8ogcoziJ5RyRO3VyDLceQ==
X-Gm-Gg: AZuq6aJfIdfV+6yChKnM30ECcLhFft42bZ5D7U6DS7TRUWMF+zAU7dQCPboJNLDC44a
	k2B8VHIRtWmOB2q8p3GGD02kj6c+7DCR1k6mBo85vpeZpHzIC+vQODAVwJJuQstJAJ0VGzUBIHY
	ByhdJB7soyCixo5hVa5iARWodicx9zYKWt4Eibk/x81PUQHYbu3mp/fk5p7sLlyakHvHPh8wBK9
	nzaa1hSCUukRM4Qr/ckk136v0jCQHYYsuVxCu+AShgQFf/AO0vcL1GKgizEDtOA0dSVZ1nzMOgh
	2URcRhlyqwqBchf39wAwTYMtKau/dV38SWRUpvJICODyY0G6H9c7Krnej5wyBDwQVaQgBpvshuo
	NS7T4TpqEIpgn7rWw+s6QPd8OIJdE0AsdlxvTGu0yI2brmHZcQIBdCy586mNfH2ufJ7VEPDWtaI
	oL0DSnH/Sbh+VhTO91dxM/cN4=
X-Received: by 2002:a05:6102:41a6:b0:5ee:a1e5:6504 with SMTP id ada2fe7eead31-5f7238206afmr850588137.36.1769532592734;
        Tue, 27 Jan 2026 08:49:52 -0800 (PST)
X-Received: by 2002:a05:6102:41a6:b0:5ee:a1e5:6504 with SMTP id ada2fe7eead31-5f7238206afmr850558137.36.1769532592052;
        Tue, 27 Jan 2026 08:49:52 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074887desm46265e87.27.2026.01.27.08.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 08:49:51 -0800 (PST)
Date: Tue, 27 Jan 2026 18:49:49 +0200
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
Message-ID: <svmbjepmhjub2coqismesfjd7wgaenauawszjophmozntjohw3@566w2rnnycou>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <lpgw6eodclsvfwgvtljfiorvjkpd5vd27yhxs7i3ijfibaqzuk@bak2lwbyh77f>
 <2d4632b2-916a-4eda-ad08-44af68461dc8@oss.qualcomm.com>
 <vv4stkmrrwdqmbnpv7pg5nd4immtqo5iplwbcia3oykycfmg2m@dsithotfy5ls>
 <eef542b8-2a1c-4941-8895-453a108634dd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eef542b8-2a1c-4941-8895-453a108634dd@oss.qualcomm.com>
X-Proofpoint-GUID: Boe15Qjyx-cPRdem1zhiZAHQaOhY22-z
X-Authority-Analysis: v=2.4 cv=OcWVzxTY c=1 sm=1 tr=0 ts=6978ecb1 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=e5mUnYsNAAAA:8 a=dHVBxyF5DYbF2fpzP9wA:9
 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: Boe15Qjyx-cPRdem1zhiZAHQaOhY22-z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzNyBTYWx0ZWRfX6u3SRAi2VpuP
 HAImnLXtiM67CX5HpC1dEpkjtc4Jpj1CtR1/xNkWs54mz0bCBcSylkXKLPP2QYqmIL2zk2VJMNm
 fZBbh8DjqbpA+FQ4pAnthw1QU7oAJ5wgxVc5z4H2h81UgTn/WymCWjb8HVwZGHknIo6ZqY8kUwv
 2sU6bWRuRXG0dLztQxpFfX23TQSj++ZJdj60+vJ8wnTxFS0HiYQ/vv83SmHTvhVh2+mpSw1h0o1
 oAphLXdYz0/VMf+3QyxPIXQT3re6G1C4GYkCB0N7PyK3IFslDBCBRBKD+JqkbHnE08NQ1ek17F+
 /T5nLcK8MKDSqFjEGGFXLMIrgW10ehcC29ikATEq727X6ES9V/YEYgb2fmw7eUtXES/NDczSaQR
 tF4fapvPpOV/pfrhUvAI+JdQsegks68XPYB9juw+z4sZuFL2qp2uudBAuA3LZIwf5eh+EUW9wzW
 WxVCWmSnfXpXfFKblUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1011 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270137

On Tue, Jan 27, 2026 at 09:41:01PM +0530, Vikash Garodia wrote:
> 
> On 1/27/2026 5:22 PM, Dmitry Baryshkov wrote:
> > On Tue, Jan 27, 2026 at 04:56:34PM +0530, Vikash Garodia wrote:
> > > 
> > > On 1/26/2026 7:08 PM, Dmitry Baryshkov wrote:
> > > > On Mon, Jan 26, 2026 at 05:55:43PM +0530, Vikash Garodia wrote:
> > > > > Qualcomm kaanapali platform have a newer generation of video IP iris4.
> > > > > The hardware have evolved mostly with respect to higher number of power
> > > > > domains as well as multiple clock sources.
> > > > > 
> > > > > The series extends support for multiple iommu-map entries for the same
> > > > > input id. Considering iris as a client driver, it adds the handling for
> > > > > multiple stream ids from VPU via iommu-map.
> > > > > 
> > > > > This series is depend on the below series:
> > > > > Link: https://lore.kernel.org/all/20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com/
> > > > > 
> > > > > Following are the compliance and functional validation reports.
> > > > 
> > > > Please validate with fluster too. Having a "knowingly good" command line
> > > > is not a validation. It can't be reproduced by anybody else.
> > > > 
> > > 
> > > Below is the fluster result on kaanapali (will add in cover letter in next
> > > revision)
> > 
> > Nice, thanks!
> > 
> > > 
> > > H264:
> > > 77/135 while testing JVT-AVC_V1 with GStreamer-H.264-V4L2-Gst1.0.JVT-AVC_V1.
> > 
> > What about the extension testsuites? Even if they are not supported,
> > they should not crash or cause the timeouts.
> > 
> > > - 52 test vectors failed due to interlaced clips - not supported
> > 
> > Yet or completely? Does "failed" mean "returned an error" or something
> > else?
> 
> completely. Driver returns error on firmware detecting the content as
> interlace.

Ok. I was more worried about timeouts or other kinds of failures.

> 
> > 
> > > - 3 test vectors failed due to unsupported bitstream.
> > > - 2 test vectors failed because SP_SLICE type - not supported by the
> > >    hardware.
> > > - 1 test vector failed due to unsupported profile
> > > 
> > > H265:
> > >   129/147 testcases passed while testing JCT-VC-HEVC_V1 with
> > >   GStreamer-H.265-V4L2-Gst1.0.
> > >   The failing test case:
> > >   - 10 testcases failed due to unsupported 10 bit format.
> > 
> > MAIN10? I was actually surprised, Venus driver supported them for the
> > Iris2 hardware. Is it somethething to be fixed in future?
> 
> 10bit would be added in iris. We are catching up with all the codecs, 10bit
> should be next from decoder side.

Thanks!

> > > > > gst-launch-1.0 multifilesrc location=<input_file.hevc> stop-index=0 !
> > > > > parsebin ! v4l2h265dec ! video/x-raw ! videoconvert dither=none !
> > > > > video/x-raw,format=I420 ! filesink location=<output_file.yuv>
> > > > > 
> > > > > gst-launch-1.0 filesrc location=<input_file.webm> stop-index=0 !
> > > > > parsebin ! vp9dec ! video/x-raw ! videoconvert dither=none !
> > > > > video/x-raw,format=I420 ! filesink location=<output_file.yuv>
> > > > > 
> > > > > Encoders validated with below commands:
> > > > > gst-launch-1.0 -v filesrc location=<input_file.yuv> ! rawvideoparse
> > > > > format=nv12 width=<width> height=<height> framerate=30/1 ! v4l2h264enc
> > > > > capture-io-mode=4 output-io-mode=4 ! filesink sync=true
> > > > > location=<output_file.h264>
> > > > 
> > > > At least these should use test sinks in order to be reproducible.
> > > 
> > > it is using filesink in the pipeline to generate the encoded bitstream
> > 
> > I should have been more explicit: test sinks to generate the image.
> > 
> 
> If you could suggest a gst pipeline for it, i can give it a try.

gst-launch-1.0 -v videotestsrc pattern=smpte '!' video/x-raw,width=1280,height=720 '!' xvimagesink

There are other patterns supported too:
https://gstreamer.freedesktop.org/documentation/videotestsrc/index.html?gi-language=c#GstVideoTestSrcMotionType

-- 
With best wishes
Dmitry
