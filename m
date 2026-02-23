Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4AF37BE60
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886512; cv=none; b=nCiJLKi1jFbq5xkjfLZtGwAuL5CoiByiwfXK+RXwYBSmm9zC15GMCEurCEfYaTMNMHY5ae1cjNAQNM1PCjVhEqcGzkoRnOVEPNdS8pnicRCWFAXbNpvpJsDdt1YbWOCSHJSVvI03SNZoAj+6bdSTR+TjCq8hIrKF9ZRSSdAKseE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886512; c=relaxed/simple;
	bh=PDnJPTRLUiPMHSkXqn9tuBvAQ1ylJXUzFUE4GbH7Hqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWzE8t34WEQsuWgxzJn5j6awlVvp1h1C3a+XEQOnmPk0Bs5uxeE98XDPLGaRTwJy3NBbdBubk6lVzFCGQk1n9xPyQ5w51tftpFQTcPyuvlgdgWkDZslvsaZWs2iJJ+KkvDh424A9ZVy/o4wsBIeN4FM4PTFq1Tt8K7WEskGSA8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UqxJBeZr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j3dhHmUP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UqxJBeZr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j3dhHmUP"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NDsXuc185758
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AyHH7QcVrx7/d/Pc5HmpEFyc
	TB7iy4eLl8RPthi6BKQ=; b=UqxJBeZrdU/+HWoz57Jsz5OGQVVAWwhBjkkReBnM
	znYBmNaTaRZGpuZhz7FyFz+WMKoWazbntOR+ec/5k/EJVTBMqgTMcgo7rFv0h8Iw
	XdOhutI9faQnvYCkm6mP+1Kd6PUqlMPkM8s8XwwBmRVS4g5u5yQUOdKMmQtYMgzi
	ZFyxbQT2h5UlRY/O5RUWPPxnMKT7wj4bAzCzT5ovcR01y2uay4wfuENWyM56LLaB
	HewbVsGgnFFTIQHaCasjtePqb0Ad+WJthHI8w3QeISWAww3VujFiKji1G4ot6uw0
	1yteuL+sy6paHYOY5NXaN6D4btbz4lVrj3tv6Ix0oKOFsA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgr69hhk1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:41:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb42f56c4aso4803336485a.3
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 14:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771886509; x=1772491309; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AyHH7QcVrx7/d/Pc5HmpEFycTB7iy4eLl8RPthi6BKQ=;
        b=j3dhHmUPrlKcveSkX3bxxMDvYISQ3ncC/ocCDBRFuVFQTn5MFsniLSTIwTjab1vFE+
         qhM6lWaS0OMBdH/U01WS8Po3w1PaMkUFM/KaNtIldYVrqcBP+OZTqxsBQCcO0Qsji57/
         5uAYom4EkuPDQPVcZotYthuGBXK1apmACXr6fjs8So1KZUMZD/W+yCKMztGH2M615NK6
         AksjsTKN+1AjB7qAExk2VgH3Pd36FkWLdJpggTX4bUIpJjXasBPsbmZmAfkq0+pDq6Nw
         quoidmPQutvnQp0PWT/xVsmge9Qfa4GBu4qTT3/PVQA0OrP0uyE0bFPQEhGxSc03fLCr
         MrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886509; x=1772491309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyHH7QcVrx7/d/Pc5HmpEFycTB7iy4eLl8RPthi6BKQ=;
        b=LcMIdQ0HsJFQidVLVZoLHn91y0DzBPxhvq6CDoXgKJeVRJVc2yUDUBDyxNxLfwzeqm
         QGmclj33nHjO+N7mQyLLCRkM7YubjZ4smR+xMhY+oLXIDQJWNPoAJOQs+S6xFC4IBOw/
         jGUxix+56a4GENW8JW01XFPTnMtGEU8H6Atq2ug1x6LVmQNYlg2ldSZ07QI6GQyxLEyF
         CLMwsxhKCIRWQmSp1ILodpSPWm8w4LWncNlDwPupRaJjy4gdBuOqnMgeNogf2VnME92w
         Ck9VhmTACNZBOgtdnyoXy48WR9pWpUAWDwW5FpPkvw/xNFmVSnFEvifat1MRPUCcXz03
         6zHA==
X-Forwarded-Encrypted: i=1; AJvYcCXtcZRoYMtlaUPChfIn7RfaZYHS+H/cDIRq/zUynBUvhhaJla7LL4v3PcLy7z2CcuVXqDthIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIKeTQp/8lhh/LNaoJvG7zprTl5p095ZVE5Lv7TaKStIYpjNby
	+Lq+pboMNcmYjs6iILfvk0xkExYMnZ92TkcjqjDjGuDMgrS5hm63IWydMcxn5grkcwbsmZctib2
	SYQk7/rUJe2WLViwJb9jVBXbJIQiIa0yulz+fwnfubMfd+dbsLUskRbGjrA==
X-Gm-Gg: AZuq6aJNSRUFetUUL6SwT2QyP1hQUyOd95/ys6pofSh5YC8xGaTJpXvOcOQ671P/maF
	00gyGV8ZavmReGW4KCzdpHwfJwv19Ku1MrMfk0QS5jmXYrRbhpF48x+Bo5OFYdmHeD/TghwSEuG
	vCTms5ao3eg0fYKUCusjN/ICHBiWOISzTDLDKI+XawNiGs5ouPL7s/47RKxlHbDhASFytYRYhN+
	GUBP2QcFafhAustGxigbmQgFNYWGJRaQLgaDwU3oOfDsobEVbKym9cyJ02NI841Ia8KZOlvEeb+
	kg+bcsRBUQK2M63g5JG5GeAWpgdby+6lAUck4+bMfH1kJZz06ElckVdq6dkn+AydhoeavltWBEe
	kDYsnPWlqe2Ub+qxrME/8KrUFzyYrfbNh7LriBPQ4Iw8SzJIFV+6/fBnYD4G89Gc8uSXMyXa+7f
	6ZsDOPUZbRUckhLGq4JKRxiy2Zq8UgPRuFelE=
X-Received: by 2002:a05:620a:440f:b0:8b2:d72d:e41c with SMTP id af79cd13be357-8cb8c9d2d25mr1211394785a.5.1771886508760;
        Mon, 23 Feb 2026 14:41:48 -0800 (PST)
X-Received: by 2002:a05:620a:440f:b0:8b2:d72d:e41c with SMTP id af79cd13be357-8cb8c9d2d25mr1211390585a.5.1771886508209;
        Mon, 23 Feb 2026 14:41:48 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb4cbf5sm1818985e87.91.2026.02.23.14.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:41:47 -0800 (PST)
Date: Tue, 24 Feb 2026 00:41:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
Subject: Re: [PATCH RFC 03/18] accel/qda: Add RPMsg transport for Qualcomm
 DSP accelerator
Message-ID: <x3ebegi74hx3a2okxnjipgsrgkbncmtwnusxtv7mc66nfih2qu@jdxc4ry2n2gb>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-3-fe46a9c1a046@oss.qualcomm.com>
 <tqsdbijgjomrn7fq3sdz7v2axwxqvbccpjh4fmvod4kbrq7pod@af3igw5dx66p>
 <lyco6vkfjlerri55ldyn6fbhihbkhnuolifddcnscevybsztq7@ljhjln2ynmid>
 <r7eko65ua2ofyejqf6ipnh6jm4s76f4mqy6a4msgmlraz4xuec@uymfzc65dbng>
 <oe4ho45dxtwjjjsqj6nd4op3gh7dz2pqwsuuhgqpdbf5hym645@smg3g4evqmge>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oe4ho45dxtwjjjsqj6nd4op3gh7dz2pqwsuuhgqpdbf5hym645@smg3g4evqmge>
X-Authority-Analysis: v=2.4 cv=O6A0fR9W c=1 sm=1 tr=0 ts=699cd7ad cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=-Sm6rUxn0lnaPTpFYlgA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: QABSI8n8XsKSjAHosGg88RZMV7iw3K67
X-Proofpoint-GUID: QABSI8n8XsKSjAHosGg88RZMV7iw3K67
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE5NyBTYWx0ZWRfX6sF0QtVlpKK7
 mZMoVwq7DiQENuo0W4Y2Wf8vQvoXopWW/2Z6qjnDRadnjTybmzcVash4S8nFCL9aS26DtmASz7j
 mrcjKBZRW7KiwsIZA236rK+htmlvZNLeIRuAdXRuQiv985cegHIXmaWbYtZxNLHh+NKQRp7EwSM
 oWHAmycf6+Mz8Orzcoq/X86TzFkWHkQkw9Jc7AShTQR/Myz8OazM639dPvW/A8NxKHojzTP4wca
 HYH0trVzh4nGRDnDni205HnYJOtWlg9b/oJjiJ5Vem+7iHVlqveXgJ+OddGdbDdzl15AwUgPqP0
 er2H8wQM23EBVxEV+65K1FkK26cuq5X0LAKduVPKXPHG1uavH9ku6NMkBnJ4P0QqkAVwl99s/eA
 ulTNtOyFaXOYwKveEMbg5r99R8lGZkQ/AmugEfnX05yDXZRBYLRQtKBnWuVBpxRGkFabjIEwBwX
 piNLAXO4UxrEZ8vI+Hg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230197

On Mon, Feb 23, 2026 at 04:25:08PM -0600, Bjorn Andersson wrote:
> On Tue, Feb 24, 2026 at 12:12:32AM +0200, Dmitry Baryshkov wrote:
> > On Mon, Feb 23, 2026 at 03:50:32PM -0600, Bjorn Andersson wrote:
> > > On Mon, Feb 23, 2026 at 11:23:13PM +0200, Dmitry Baryshkov wrote:
> > > > On Tue, Feb 24, 2026 at 12:38:57AM +0530, Ekansh Gupta wrote:
> > > [..]
> > > > > diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
> > > [..]
> > > > > +/* Error logging - always logs and tracks errors */
> > > > > +#define qda_err(qdev, fmt, ...) do { \
> > > > > +	struct device *__dev = qda_get_log_device(qdev); \
> > > > > +	if (__dev) \
> > > > > +		dev_err(__dev, "[%s] " fmt, __func__, ##__VA_ARGS__); \
> > > > > +	else \
> > > > > +		pr_err(DRIVER_NAME ": [%s] " fmt, __func__, ##__VA_ARGS__); \
> > > > 
> > > > What /why? You are under drm, so you can use drm_* helpers instead.
> > > > 
> > > 
> > > In particular, rather than rolling our own wrappers around standard
> > > functions, just use dev_err() whenever you have a struct device. And for
> > > something like fastrpc - life starts at some probe() and ends at some
> > > remove() so that should be always.
> > 
> > I'd say differently. For the DRM devices the life cycle is centered
> > around the DRM device (which can outlive platform device for multiple
> > reasons). So, please start by registering the DRM accel device and using
> > it for all the logging (and btw for private data management too).
> > 
> 
> There are no platform_devices here, but tomato tomato... What defines
> the life cycle of the DRM device then? Might it linger because clients
> are holding open handles to it?

Yes.

> 
> Note that the fastrpc service is coming and going, as the remoteproc
> starts and stops.

Even one more reason to use drm_device for life cycle management
instead of manually inventing the wheel.

> 
> Regards,
> Bjorn
> 
> > > 
> > > Regards,
> > > Bjorn
> > 
> > -- 
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry
