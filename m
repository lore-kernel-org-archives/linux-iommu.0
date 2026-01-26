Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD0733A707
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769434728; cv=none; b=jfQTDcCpkbhF3o2SgeExTPhOlf9c+eCVIxDgNBMZFXdEVuV/McMI3TOVDcSLhmPwjvX+a219N+TQ49zba+4OUwyMkz7bmSwlP+CAe34igOCcr8Cvx73TlV5J5o2W6vZxWCay6m62f38i7gV2PFxbJGj0XXYQv+sSDkklYSCWYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769434728; c=relaxed/simple;
	bh=pwjK4+pdWgeLe/K3hHRuwqqM/os1WVoxjKEALfiTNTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RidxFjQTihYAshJ75c1wZxcund2XltO22PZkwCUBN2bQdU3Ps5UJJj2wzABh5stREKmhiVuhJNoG9aU2FxcjHa1ulx8vc07gKBobW2h+1CQM2e6jk2+9Sy5DxRjnZ3iHew349tlgTOMqX1+UkRsgBRGmQPsoqTO7F5iidc96pc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BTGbgHR2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LiGSSqn0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BTGbgHR2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LiGSSqn0"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q5UFpd1018997
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 13:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YskG73YSaDPdLYLxN7gxrpSE
	dUjoPZzx6h1RXNJhXkg=; b=BTGbgHR2c7gbWeI6uKP/KPuMP13PAUsT5cpdAu27
	aTiZUVZVX8dxkgYQCXk8W0rd22yRb+SgIj2x0lIOeSLC91k7+eIg53FH011wJ8PW
	FT75ffvo4WLGUn7RYv7TcbAGESVC563nUgkDr0pjbfy1Mm9OnBnRMkRE3fOtm89E
	FZHZzOnh34tAX5lFyADUtVJ5YsNx17lLpiE7wO8Tso+wAbwA3M3HN1OyxNVjHkep
	Ig0eNKk0ZDh7UkmubwY2/nBXM3yWecBE96K1fksSfByDQZJztn+AsLM49VuHJjYR
	P+x3YxEY/XWnvHhqbpwakA3uZJmLEFxmkA2uYaE9t1BZnA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bx268155v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 13:38:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c1cffa1f2dso1456398885a.1
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 05:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769434725; x=1770039525; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YskG73YSaDPdLYLxN7gxrpSEdUjoPZzx6h1RXNJhXkg=;
        b=LiGSSqn0BQowcuIcviL5DKGIUduObqFryH7Sz6NEi+VU/ILYhuSNBezD9SShlhCxpH
         6jlHlZ4zQYwdWiz4SFmmLnZ92hrpefgh9GHKwRC+9ggQWbYfGo1GzOzakNumsLfeCdoK
         kATm5gJT/VsjvCzutx6+HXDe+O/mQUz25lNkhcjoh3+14TPh4x3lZS7kDsAGaVPjGcEE
         YvgaQx9BsoDKOr5sB7BqYEx2G/Y+vfzZ56aV2p6IquSuaLZxDMMZREDsuAPmrWW4bvfg
         oeV/i6nQEsKbMdCzkdH6G5US+rMR0bYIdYRUKZpGMmuo9YMTawjD/IQnO1NrMZKoVe/V
         mhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769434725; x=1770039525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YskG73YSaDPdLYLxN7gxrpSEdUjoPZzx6h1RXNJhXkg=;
        b=Bf0oBeDBQvPDKcYAWIxKhEXiuE416u+j3T2MORbz29ncZsplRnkUBBvUGIyHUhERWN
         XzUvZq8F4VkAafF/qAQOaxQWLMo7iW/oT/tO/57hJTRE6ubIR8YjktHc+OOB9ICQh/35
         k5q/btY6GCg72qyDj2ueCEFjQ7IBaMdiref5c+057Ndjt4cFPObULnaXkwgW+HGqHMkN
         I/RUZxHikOCTZ6Zj9YAVQiQHM9F0bJ4yihXAtOEAFAzPqfWPcWVkeNUcgNdghDnTol65
         z+stgzntsL7RBjksyVnFEFldIU+89B/buClv19KLZoO2u98GGaVR0OUs4687u9UT0v+O
         WVzw==
X-Forwarded-Encrypted: i=1; AJvYcCVsI58H+f3BXsut86PQca4SI4MgjNBEZZPn8nWJBmucgeXKabA/5wdmjDzcH5VqUFsWAZZe/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhdVu5MdSxL5DsJR61xx5GxtY3FSXvBhDOEUFJVVu1WCczl1Rd
	Li4dOVKJCCgOI+sqBLov42qPlhkqFctO7+lhqOWzpsNYI18Fm09bK9DLp7KPEh7FdfnPOU3sfoB
	Bz/M7Q6Jx+CnB8Z8zESyvz9pMX4N3VREF3nonYqotCH//zHGoAF5CWGgv2A==
X-Gm-Gg: AZuq6aK93jTwf5zFa1JfJLA3Ar3/dTWNdX8ew+aAfhstdcqWXQ5EHwF4HoWo+evF48r
	HdiCJ3comXocxUJHcrw0BRNNjMn4Xj+UAiy/yjKFtEtCY/osx3bB2cyTMbEJ0kZbQKsjckQPcus
	pqxzI/jGKGIhx7lnCcRNIm14eaSwKXGK3QpE9XYJQ81u5lS9+19Oy3ee9lX7ZyOJVgKnmuvq61v
	D/Yx3qxq7lTx4m6yUdZXYMCWmH2AXasoSYD1PpLapq0P2jUaWRgW5IjE1aIxuf6n9wxErianUex
	fE0igcuJoqD1SxHSx5JbQE0YzpMPwoSlfpRoozKCKCr0cotv3GzegXVbCU9MRjRNkIhL/R7RyIF
	0c41t7Gw/ZBfR+5WiQsMN3dD5Ja8iK0ToK5XobsMt0Aj9qu/ceDMrwwlVO/2DZevy2AZ/0CHfeX
	ILWAO7wq1TOJAuW2XxKcz1Z1I=
X-Received: by 2002:a05:620a:1aa2:b0:8b2:63ae:6343 with SMTP id af79cd13be357-8c6f987646amr480076485a.28.1769434724706;
        Mon, 26 Jan 2026 05:38:44 -0800 (PST)
X-Received: by 2002:a05:620a:1aa2:b0:8b2:63ae:6343 with SMTP id af79cd13be357-8c6f987646amr480073185a.28.1769434724156;
        Mon, 26 Jan 2026 05:38:44 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-385da017b5esm27709771fa.19.2026.01.26.05.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 05:38:41 -0800 (PST)
Date: Mon, 26 Jan 2026 15:38:39 +0200
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
Message-ID: <lpgw6eodclsvfwgvtljfiorvjkpd5vd27yhxs7i3ijfibaqzuk@bak2lwbyh77f>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=bIEb4f+Z c=1 sm=1 tr=0 ts=69776e65 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=WVDdUWqqhAlxm7gINyEA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDExNiBTYWx0ZWRfXxO2CE33BF07y
 d/UsFfoIfNtO8zmDHDKG6L53XbZsCHffhVVdvJZfSZpX5vVL9GiWarv+QopEyExPTPxhgewh4QW
 C9sEEF265R62RvMIZ9Q+4BDrSbMiN4xgyLywdqzlCAdj4MDSbtvwPSZjU/IRQgxrv/4zyPtHaY7
 N3S+rxRjhhHf2YQRbvgMYOXGXGkQz3lQDIWF2OURi1Ja9LreVrHYauemMY3rAh66M1leXVPKxqK
 u8GlkWEtzMTJ9PFjmw/kBJD/L4daj8GLTm1kwM4WiNT8CH+VCrVHakhtF0gzjlTQY3+4dGJF04M
 salbPKbfyP7Xltr2uvPpermKbwKhc1qKhXRG0DUcSlVsJH5Iz1B/xqakTy+6odw9/UHrcZzoZDK
 MDQL5mHqvGlPMkJBa/0j1W8DDYBI4HfeQ6ZdY7SLoQSuvUY6VNOKqQEPpOFqMnmhsPVMTDjvztI
 XVBjsbCDfNDHMmO5Z0w==
X-Proofpoint-ORIG-GUID: ziCzBjvLey4IgvKzLoisCQFpOVxbCpcj
X-Proofpoint-GUID: ziCzBjvLey4IgvKzLoisCQFpOVxbCpcj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601260116

On Mon, Jan 26, 2026 at 05:55:43PM +0530, Vikash Garodia wrote:
> Qualcomm kaanapali platform have a newer generation of video IP iris4. 
> The hardware have evolved mostly with respect to higher number of power 
> domains as well as multiple clock sources.
> 
> The series extends support for multiple iommu-map entries for the same 
> input id. Considering iris as a client driver, it adds the handling for 
> multiple stream ids from VPU via iommu-map.
> 
> This series is depend on the below series:
> Link: https://lore.kernel.org/all/20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com/
> 
> Following are the compliance and functional validation reports.

Please validate with fluster too. Having a "knowingly good" command line
is not a validation. It can't be reproduced by anybody else.

> gstreamer test:
> Decoders validated with below commands, codec specific:
> gst-launch-1.0 multifilesrc location=<input_file.h264> stop-index=0 !
> parsebin ! v4l2h264dec ! video/x-raw ! videoconvert dither=none !
> video/x-raw,format=I420 ! filesink location=<output_file.yuv>

Neither of these commands specify, what exactly was validated. They
specify that you've validated _some_ videos. It's impossible to even
reproduce your results, because you don't specify which files you've
used.

> 
> gst-launch-1.0 multifilesrc location=<input_file.hevc> stop-index=0 !
> parsebin ! v4l2h265dec ! video/x-raw ! videoconvert dither=none !
> video/x-raw,format=I420 ! filesink location=<output_file.yuv>
> 
> gst-launch-1.0 filesrc location=<input_file.webm> stop-index=0 !
> parsebin ! vp9dec ! video/x-raw ! videoconvert dither=none !
> video/x-raw,format=I420 ! filesink location=<output_file.yuv>
> 
> Encoders validated with below commands:
> gst-launch-1.0 -v filesrc location=<input_file.yuv> ! rawvideoparse
> format=nv12 width=<width> height=<height> framerate=30/1 ! v4l2h264enc
> capture-io-mode=4 output-io-mode=4 ! filesink sync=true
> location=<output_file.h264>

At least these should use test sinks in order to be reproducible.

> 
> gst-launch-1.0 -v filesrc location=<input_file.yuv> ! rawvideoparse
> format=nv12 width=<width> height=<height> framerate=30/1 ! v4l2h265enc
> capture-io-mode=4 output-io-mode=4 ! filesink sync=true
> location=<output_file.hevc>
> 
> ffmpeg test:
> Decoders validated with below commands:
> ffmpeg -vcodec h264_v4l2m2m -i <input_file.h264> -pix_fmt nv12 -vsync 0
> output_file.yuv -y
> ffmpeg -vcodec hevc_v4l2m2m -i <input_file.hevc> -pix_fmt nv12 -vsync 0
> output_file.yuv -y
> ffmpeg -vcodec vp9_v4l2m2m -i <input_file.webm> -pix_fmt nv12 -vsync 0
> output_file.yuv -y
> 
> v4l2-ctl test
> Decoders validated with below commands:
> v4l2-ctl --verbose --set-fmt-video-out=pixelformat=H264
> --set-fmt-video=pixelformat=NV12 --stream-mmap --stream-out-mmap
> --stream-from=<input_file.h264> --stream-to=<output_file.yuv>
> 
> v4l2-ctl --verbose --set-fmt-video-out=pixelformat=HEVC
> --set-fmt-video=pixelformat=NV12 --stream-mmap --stream-out-mmap
> --stream-from=input_file.bit --stream-to=<output_file.yuv>
> 
> v4l2-ctl --verbose --set-fmt-video-out=pixelformat=VP90
> --set-fmt-video=pixelformat=NV12 --stream-mmap --stream-out-mmap
> --stream-from-hdr=input_file.hdr  --stream-mmap
> --stream-to=<output_file.yuv>
> 
> Encoders validated with below commands:
> v4l2-ctl --verbose
> --set-fmt-video-out=width=<width>,height=<height>,pixelformat=NV12
> --set-selection-output
> target=crop,top=0,left=0,width=<width>,height=<height>
> --set-fmt-video=pixelformat=H264 --stream-mmap --stream-out-mmap
> --stream-from=<input_file.yuv> --stream-to=<output_file.h264> -d
> /dev/video1
> v4l2-ctl --verbose
> --set-fmt-video-out=width=<width>,height=<height>,pixelformat=NV12
> --set-selection-output
> target=crop,top=0,left=0,width=<width>,height=<height>
> --set-fmt-video=pixelformat=HEVC --stream-mmap --stream-out-mmap
> --stream-from=<input_file.yuv> --stream-to=<output_file.hevc> -d
> /dev/video1

-- 
With best wishes
Dmitry
