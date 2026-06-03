Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572802BE051
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493204; cv=none; b=GFOPGpQ5hFIiQXbSr/LBdB2Kawh0BQAPTWVSHeCD8+Rnx4vXBdauJuXl/ZUwMxoqb7Jk7HFzskVAj6KVVRHt4/hs2kKMumifESUUZeBqG03lZvUeUsDFstUuswCnd08jkFXQWA0UyAC0ghNCiUzFLGJub+kq16ZtbDR+KXHP9dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493204; c=relaxed/simple;
	bh=T/tEolCSMDWiK1ElWJnUQfM0lMP/lYha3xE84ovma+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udBipMhfrqQ8dXrSIP4obdJPUsBz2DAVUEfuB/Kn+qvN72TSsVnogVNKjMq1KJ5HTNZJaw15rt024ZM2WLuk8SsyJO3QMH72Kyf1G+tKtj4nv9OyLwid5YcOGrzTDZkdTQ1+KGACt0N1iFIcSLkHkJQojYV9FbMiMEgGG+Gamx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gwfdrQC8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z/RCEnBx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gwfdrQC8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z/RCEnBx"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653CTZGC1200016
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 13:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FBhsg7FwzuMrC2Y5faSGRrZu
	R8DY6M4ytXCJ9V4SUKo=; b=gwfdrQC8QGxcPEM1JdkngF2f7SVaf4tWQ4Ar3/Z2
	6Ayhs4s0EPnkY365ytZbRhJr5pZ2Ia0SCCTCAjv8Dbl8NTmB4HeesLWg5ze+/sWx
	TbJcRPE3fn3biZkvNM1w3nSUGg1ZJKlJVM1FYegh6rsP/G/2hwrATp873oFuKgfj
	RvZupct1n2aWYUOfGIbS+nTL/f9ub4gaaiJm67n2bX/LW77XFx5QZNmy1ZIFRr71
	uH5X6GoBc3xC/fiJxNk3Hi9qxlRKkJtAjnpLvT/a0udBzmyrHG9DmQLaQSP/yiJF
	3et4YpPyFT+THy+MgCOz4wiuWpJyvsI6UXbRlDQhUCOuDQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejckw26r5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 13:26:42 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-59bd734ecbcso2501388e0c.3
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780493202; x=1781098002; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FBhsg7FwzuMrC2Y5faSGRrZuR8DY6M4ytXCJ9V4SUKo=;
        b=Z/RCEnBxTlEPRhyYrNdEGEiyNABRB/5NqMmhh93iHLGIaZ90gOV6DPMx+30H00jT8Y
         pE7GRwTZ+cFj/tK1Cz960NBHlgeAuj6Rv14yyjPxO56/cKntVgOV0K0H5NE2L2/gzx84
         k3DKxvox47voa+UFgrhDIesPZIEF6CxU7HPJFIm9dVh5JcoeNxW2FLHqqFri56NWKvRD
         AYxk0zOjyTyMFPwNRTzff95vExJL1FgqvqpvKeElg4TSgai/dYSmsJt80enhaOZPbkC/
         4H1xnqz65nxJG3l37yyFqBgEWuVHpTs4n06oMZKMzNGKoadgJFxcql9Y1s4TqnnXx4Nm
         LVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780493202; x=1781098002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBhsg7FwzuMrC2Y5faSGRrZuR8DY6M4ytXCJ9V4SUKo=;
        b=Ri5HgXuwBxHMvq8kf/p60tXy0MB2kxWa6HjiXzAhpVLFtO7wF9InqxyFv7yaqROM3J
         76w6r0mp0AfN9+QkyBWXAYosoxgEVAYGWfhtEX9ssMiQEp6TARtRz+/LSYnmF4/V6IFB
         MNDzaBkgWAwLudjtwnwIn9OeINBi8y+e9xdaTvEV+FPoVtVIO7fazzQeWemTyojmxbWt
         P1xjzRI9mOxvXlvjbuTgslbGaLzLdEJlCV+6jqmp50+UES1As4q68PppACqrkU48cxG6
         M9CJIlFVq94VVP5QReGa4uxJTI4GQft1UuIIK5u8Y6T77LHSH5lQ0Hx9lcO0TG0wTYbv
         Zksw==
X-Forwarded-Encrypted: i=1; AFNElJ8vC5dkKQNIZvsSh6rJQpHGD0rxZuwEBZtluwh7Wl5eVh5z+UJFFl6FcrPhnAe2DvoZ3LjZZw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxw1efeA9PAw6oakkI/eI86AhzHLtlJdSX8JFNXlQEdBx2kVtpe
	AmiE69AuilPFwmLp7EUmV1vLQUADPjR00pc4pA6Q64sT0O/e3Gzyo8VTaHopAbz0QIffcayZF6N
	w+7VI05PCvFTt7F5yHBRFBSKuFjvq7BR3s2T3RpQxPRvPgBpORnuk16TXNA==
X-Gm-Gg: Acq92OF4+5FojtEUUJ9FheXfVLFvUeW7UMg1rbDMnBiSwdbXGGCDuRjaJkX5hsUDz94
	b4bCtlqMNwtD41KiERa7/Jc48iQ9kCsEPo/rP32WQ92pnOTu18L79mBliWzDoaZmgSx07GT2iS7
	VXv/SFi5mC7x1CwIWS5zV2S4kfUIn8D/wSK7NisWC8qDd4EmZDeMqyHJenv89efNvHKYHYkXmbZ
	5+OaU5qH0Xx4WD1w2Mv++eN532BUzWXXsSzsXG4/eUxewmbXdvtEj45sH4YO2zMif3YdJO4YJ42
	mHjj/m/XictMalzad8apWRl65MTpcdlrzv678z/kKgR5qxz6YB4TH2oExJVqzRnNwx15KurksSk
	K3YZwA7jWGtU1ez764Z4Mzp2IcdH93rMbUBrR1Vk73v8N+p7PzRh+OTNjzABwjga844yoi6I5fA
	YZJLj0n16vm0175uqzTkR//E3lN4N9qQNE2d7cJ9Q7Tg32FA==
X-Received: by 2002:a05:6122:1da9:b0:5a4:ac74:f5ba with SMTP id 71dfb90a1353d-5a6e86256ecmr1670757e0c.11.1780493201642;
        Wed, 03 Jun 2026 06:26:41 -0700 (PDT)
X-Received: by 2002:a05:6122:1da9:b0:5a4:ac74:f5ba with SMTP id 71dfb90a1353d-5a6e86256ecmr1670719e0c.11.1780493201199;
        Wed, 03 Jun 2026 06:26:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97b04esm665779e87.40.2026.06.03.06.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:26:39 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:26:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 06/15] accel/qda: Create compute context bank devices on
 QDA compute bus
Message-ID: <4ok65ttxij2yn4qyvbizgobfxsfikqmsaynz5c6lfbp2d3o2kt@iuqdma64k4w5>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-6-b2d984c297f8@oss.qualcomm.com>
 <f527lflctqyqjrotd2qerlx4oikg6st6u2seqsjw6u5krkqrab@uhw33gnkp5c7>
 <37ae68ba-6639-4bd2-9483-5aa0156fd772@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37ae68ba-6639-4bd2-9483-5aa0156fd772@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: XZaIdwU9QT68A35MmGyiuQZfaS_ulqhj
X-Authority-Analysis: v=2.4 cv=edUNubEH c=1 sm=1 tr=0 ts=6a202b92 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=niLhY7D_osK6bJDgftoA:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEyOSBTYWx0ZWRfX5JcU2oiyQUse
 Yphkt7ixbvZyESEVC/WOwUwZTXY0LUWST3bVx/9I5ojJXJvKh3/uhyfQP8O7Y9fBodAu6WhuydV
 nAEM4y4eR2RYVhMOI7eoxlRLvp1OwW/yHQQ1YEHiZpjaeEKQ1Qg0TyowTHp+s2OMzLTU3Ol9kgv
 M+05JwmglfyAwknudiR5E3S5us3IgBCZoqmYj2lwpaUm8tVt/qWp1YkRs5tkZTNKZZ+9uB3xnXn
 kCZzwlA3lcI2L5YD8H4o1OPliKlEIbCYNzgUdjVNKpyMx/KHb+oQryZp+7iOVXjVPWeDTEnD9Sr
 tA/sTA443gLqQVkCf1uo5emMQ45CGpAwPViUme6NHxi8pXJxQD4lDxRGfXju7Ayh2YAPqDI7JB9
 +8ZPjvQ9tOJEYdCFMKleR+5Tb2Bqlyg95gqjMy0HLDm0nF8MN0Eqlg8jbvLkuHknDEDgGnaBpzQ
 SgmqbX0FKLwY/ZrS4PQ==
X-Proofpoint-GUID: XZaIdwU9QT68A35MmGyiuQZfaS_ulqhj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030129

On Wed, Jun 03, 2026 at 11:09:31AM +0530, Ekansh Gupta wrote:
> On 20-05-2026 19:53, Dmitry Baryshkov wrote:
> > On Tue, May 19, 2026 at 11:45:56AM +0530, Ekansh Gupta via B4 Relay wrote:
> >> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >>
> >> Introduce the CB (compute context bank) device management layer for the
> >> QDA driver. Each DSP domain node in the device tree may contain child
> >> nodes with compatible "qcom,fastrpc-compute-cb", each representing one
> >> IOMMU context bank. The driver enumerates those child nodes during
> >> RPMsg probe and creates a corresponding device on the qda-compute-cb
> >> bus for each one.
> >>
> >> The CB devices are created via create_qda_cb_device(), which registers
> >> them on the qda-compute-cb bus so that the IOMMU subsystem assigns each
> >> device its own IOMMU domain, enabling per-session address space
> >> isolation for DSP buffer mapping.
> >>
> >> The new qda_cb.c file provides two functions:
> >>
> >>   qda_create_cb_device()
> >>     Reads the "reg" property from the DT child node to obtain the
> >>     stream ID, constructs a unique device name of the form
> >>     "qda-cb-<dsp>-<sid>", and registers the device on the compute bus.
> >>     A qda_cb_dev entry is allocated and appended to qdev->cb_devs so
> >>     that the list can be walked during teardown.
> >>
> >>   qda_destroy_cb_device()
> >>     Removes the device from its IOMMU group before calling
> >>     device_unregister(), ensuring the IOMMU domain is released cleanly.
> >>
> >> CB devices are populated before the DRM device is registered and
> >> destroyed before it is unplugged, so no DRM operation can race with
> >> CB teardown. On probe failure after population, qda_cb_unpopulate()
> >> is called to clean up any CBs that were successfully created before
> >> the error.
> >>
> >> Assisted-by: Claude:claude-4-6-sonnet
> >> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >> ---
> >>  drivers/accel/qda/Makefile    |  1 +
> >>  drivers/accel/qda/qda_cb.c    | 99 +++++++++++++++++++++++++++++++++++++++++++
> >>  drivers/accel/qda/qda_cb.h    | 32 ++++++++++++++
> >>  drivers/accel/qda/qda_drv.c   |  1 +
> >>  drivers/accel/qda/qda_drv.h   |  3 ++
> >>  drivers/accel/qda/qda_rpmsg.c | 12 +++++-
> >>  6 files changed, 147 insertions(+), 1 deletion(-)
> >> @@ -59,9 +61,17 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
> >>  	}
> >>  	qdev->dsp_name = label;
> >>  
> >> +	ret = qda_cb_populate(qdev, rpdev->dev.of_node);
> >> +	if (ret) {
> >> +		dev_err(qdev->dev, "Failed to populate child devices: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >>  	ret = qda_register_device(qdev);
> >> -	if (ret)
> >> +	if (ret) {
> >> +		qda_cb_unpopulate(qdev);
> >>  		return ret;
> > 
> > Unwinding registration?
> did I miss something here? The intention to free up the CB devices in
> case the device registration fails.>

Don't you need to unwind anything else?

> >> +	}
> >>  
> >>  	drm_info(&qdev->drm_dev, "QDA RPMsg probe complete for %s\n", qdev->dsp_name);
> >>  	return 0;
> >>
> >> -- 
> >> 2.34.1
> >>
> >>
> > 
> 

-- 
With best wishes
Dmitry
