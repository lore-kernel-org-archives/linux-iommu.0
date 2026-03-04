Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E283336495D
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 04:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772598135; cv=none; b=lXyb7/IC9Fd20oBdCYMwUNrhNgb6ESykrp2Ig7vm5FxwtGD/tX71IA8vgOG4JadQDeENMReO7atuq2yHGVGPi7vI5zbii8V9mGjS9IXFMq89I9fXu2IFzaGVpkBIfCrEfV3UArtQOUF/37/eTPa4eTNRZWHtqmOii8nDT8m0FeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772598135; c=relaxed/simple;
	bh=vfZ4Fm1illYeYZxI8bJ8e1HWahncA/1F2Qj57ZqkvyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMjPqYC39dO28I9XtdwO/kptnDiFFeODZJZ6PLGsi/BOzCSeHhhGQH9rxjxJ5XMfNA7V7YctURv1Z3TXTzJ8KDh9bi9sPxibvWmhZeTAGr3Hn9lyg1XoVq//KVIvTLz0Rsxls0lyDM08UhpW+pIEzXOluatkuWZ+eTvbNBZF+I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c/Z5n66U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BWp9LRMZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c/Z5n66U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BWp9LRMZ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6244HxbD2124584
	for <iommu@lists.linux.dev>; Wed, 4 Mar 2026 04:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tlbeDGjUP0JSGoux2wklhzIf
	NMznEwVoyK8emBv6LqI=; b=c/Z5n66UUeyIGhW6V3AS80qPffCne7OeN24B8uqj
	dnBn9Vc/Kq1CVFKJFUDn9HSKvsrJUA+EOnZV179NYpUMjZECKSE8wvJzsJKVB7XH
	K4EPD3iBaCNSxGR9t/QtdYgR7U/L9GtcpsonFi0FGsWk9PYuirNMLIQXIM5Y2gv4
	PKJjYeF58AYRdVqSOSu5nbb2syGAGqCyLhceytWPICAby7BPXIN4ujlNNd994q4k
	4Iai0zouxtO767KHYoRxXctKM1sAoOyoKg8n7filX7iHVT3tKkCRTGFX72Eva6ka
	m5n++swUkhl0cSLxAYG6RIDoiNNZmkJ2PYJvof08wJHT9w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpc4mr9ht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 04:22:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb4d191ef1so809827285a.0
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 20:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772598132; x=1773202932; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tlbeDGjUP0JSGoux2wklhzIfNMznEwVoyK8emBv6LqI=;
        b=BWp9LRMZ4ifz6GS/zY8gZ/tbwQMLLKyJaI1wOcpFq9B0aqhUvR+ODsV5XdROi7JJ8h
         Fc2SdF+oKtx2FJPPj/HZ/6VmGYcmEKa9rQvhf7xNKXVz4MOkwHVgrEGDV5nL4EvcPkLQ
         Rw9VTWydvizR44PYjAi+yRmmlX+i/hXYZrZLfuZjd+NMp+w4FhLSOuvmsze05pOFFr3m
         2jSqQpLm2hsFvYvf4CqjRJsw1p8NU8smXqvwQiQh4sm1QNBt+QPfkZ0SnOVFSC7e9BH8
         qh3O5Ub/ZCxjGs7BwHENYQESIh1X59VgvYmsWr03aQVlVD7AbRDtHaqc37FxeS/cPwt6
         GA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772598132; x=1773202932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlbeDGjUP0JSGoux2wklhzIfNMznEwVoyK8emBv6LqI=;
        b=xVneyq45UHqMusm1hbGaUv5rtLWPeMnpxOWMoO6RN9adlKETnAQgnP6r3+e2G7q4Zw
         3T3N00udZF+2iKfIeZuJ7kzIj4NjKXjU88vjJjtN9c0agCyUKeoOO+iTm2QAbhZ/FDAj
         T3ZfQOsnzXtjWO9YmR7ntT7WOkHqhtwdjtw42iz+/X5Fr6GruDtr4/uRCYe+aUi5kksI
         7v5i+75UKyQDXC+2pQ9fMWXGNNaJxfy5hyT6xH+kIsNXcRPlAkWlZ/KUmSH/ewU46Z/K
         UPh8LVXe/DntxOa1rzBrTJkWbP60jN+hUKfKR0l5X2sBrP+wJ/Y5HSr3u1poE3v9Wvbl
         3rgA==
X-Forwarded-Encrypted: i=1; AJvYcCWIN73TNSxhBd9W1lv8ZDSoe/L+6fWxLO8e7WyfOOpCJWHfmedroa55thx4DKap5y7jEOpyFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyArhu2AX/aR/2F9s8UigdhQg+6XQ3g4A4/VIKbrclqBcJhxX7i
	MPsyQv+oRaRDVTqljowEqD6lF9kFqpm7LG3fPUpFm0ct45REFnP1rMoqDSSzi9jtX87GoBAnxdW
	C/lodMi32LS9HBTp3/9xf3yzXAd5JxlmctlpuHZT408Ny4Bo4ecOlk6TUsQ==
X-Gm-Gg: ATEYQzy6zV71W5xBVl6UtQLg9Y27jRMJNWcDtM4gGXu6xpK/y4h+lawqxU5GqPJaxQk
	SDlGDOp1Yhb9zNT9kGfKMWdYc/j4zjNx5Ctx+mWckeC57c8DinYqBOle6pkB/GEbTNxzsdlPkYF
	T1WvFCORGKQR9p89fp2XNdT1qtpJ6Mx89D2dKO2ehC43oriO0/RGzlLawY0Qep/kKqUkxZVD5mY
	1MjXVqC0ybyO34grJLepZREA8vIhDvWu+1z/DRZz0Y1RCRTYtcj56KwEn0PSUyqNcChq9TPAnSP
	7obfBs87YIssKKWvg6onPzRrnWSxQmFSBnWEJ59/QEVcpsok+pSIVkz+Q8Th5r6Zwa1MqaFxNeo
	oE8YyG1py7AgR6hQ3SvrQo9GYI/qpVeI3A/1EanSAM2iSinGBnf7RuAnkSJea87zGKFRq3r3sbn
	f1Z40OVMFnYW0X/MI4NLd7k8rrq6SRCCUFZQA=
X-Received: by 2002:a05:620a:4609:b0:8c9:fc46:235c with SMTP id af79cd13be357-8cd5afc1082mr91776185a.71.1772598132178;
        Tue, 03 Mar 2026 20:22:12 -0800 (PST)
X-Received: by 2002:a05:620a:4609:b0:8c9:fc46:235c with SMTP id af79cd13be357-8cd5afc1082mr91772185a.71.1772598131614;
        Tue, 03 Mar 2026 20:22:11 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a12a6e4c0csm227636e87.2.2026.03.03.20.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 20:22:10 -0800 (PST)
Date: Wed, 4 Mar 2026 06:22:08 +0200
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
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
Subject: Re: [PATCH RFC 06/18] accel/qda: Add memory manager for CB devices
Message-ID: <wubjsfz2ijtqvwwqc6y2bawinpdwvvke6vh4owytcxjdmbfjji@ybmz23zic5dn>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-6-fe46a9c1a046@oss.qualcomm.com>
 <d7s4e7xzfqfbcf5o3grc6xqm74dzwpck6ge7hyrwewmyacpuez@lcd6nhzyjr55>
 <5448e807-2435-42f4-b98e-2beb6b66a6f4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5448e807-2435-42f4-b98e-2beb6b66a6f4@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: eH33LESs-mcrVLgSKSWqOk065ELozN_D
X-Proofpoint-GUID: eH33LESs-mcrVLgSKSWqOk065ELozN_D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAzMyBTYWx0ZWRfX8hM4C5+RVRsM
 TZ7KYS8E8UYDJBL6zyCf0ifcL8F0DbpnXgkIqgb6Jw8DdTUhOhKvdLhamcst+/HPBuBE4RUD1qF
 vqmxGrcV38ieI9BUVxDl+iWxztB589RmS5uOQsn05EER89CeZFd/0Joa25wgg5eMTwEC6MNVasT
 ZzgFNmuJsUsjikxZwh2e9JMFigTu0tbWMdHdvUx4FZhwr5QRqFu0gLKXmuY4nyYdm5EwBAXkyge
 A1L+R1lAE6ZLZiCWVOI1ex+RurEUEIDHcp9iq7B3BZupPywtEgXQEIkvQ5SY6R5O8YkfkMAnUQc
 b8RzSnQ6srmcXbVuELXq+XXAJseLU7k/lv+CFVd6TtJ7xIEbWBZuED0WomG3s8fgGiEdyO6Dx56
 hasIuqTG7xs0A/O/tfN1zG+OR4Bopnz9rMtuh4SzmAr/WWEs+dPEhYwlbWkOpxqoUhdvmD0amyQ
 fApGniep4f7vWU+BKfQ==
X-Authority-Analysis: v=2.4 cv=C67kCAP+ c=1 sm=1 tr=0 ts=69a7b374 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=LbhuFg2odiTRP-zraWgA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040033

On Mon, Mar 02, 2026 at 01:45:09PM +0530, Ekansh Gupta wrote:
> 
> 
> On 2/24/2026 4:20 AM, Dmitry Baryshkov wrote:
> > On Tue, Feb 24, 2026 at 12:39:00AM +0530, Ekansh Gupta wrote:
> >> Introduce a per-device memory manager for the QDA driver that tracks
> >> IOMMU-capable compute context-bank (CB) devices. Each CB device is
> >> represented by a qda_iommu_device and registered with a central
> >> qda_memory_manager instance owned by qda_dev.
> >>
> >> The memory manager maintains an xarray of devices and assigns a
> >> unique ID to each CB. It also provides basic lifetime management
> > Sounds like IDR.
> I was planning to stick with xarray accross QDA as IDR gives checkpatch warnings.

Ack.

> >
> >> and a workqueue for deferred device removal. qda_cb_setup_device()
> > What is deferred device removal? Why do you need it?
> This is not needed, I was trying some experiment in my initial design(CB aggregation),
> but it's not needed now, I'll remove this.

Ack

> >
> >> now allocates a qda_iommu_device for each CB and registers it with
> >> the memory manager after DMA configuration succeeds.
> >>
> >> qda_init_device() is extended to allocate and initialize the memory
> >> manager, while qda_deinit_device() will tear it down in later
> >> patches. This prepares the QDA driver for fine-grained memory and
> >> IOMMU domain management tied to individual CB devices.
> >>
> >> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >> ---
> >>  drivers/accel/qda/Makefile             |   1 +
> >>  drivers/accel/qda/qda_cb.c             |  32 +++++++
> >>  drivers/accel/qda/qda_drv.c            |  46 ++++++++++
> >>  drivers/accel/qda/qda_drv.h            |   3 +
> >>  drivers/accel/qda/qda_memory_manager.c | 152 +++++++++++++++++++++++++++++++++
> >>  drivers/accel/qda/qda_memory_manager.h | 101 ++++++++++++++++++++++
> >>  6 files changed, 335 insertions(+)
> >>
> 

-- 
With best wishes
Dmitry
