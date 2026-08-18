Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273993093C1
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 04:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028331; cv=none; b=inEEQ+uyzBD4wgwzdSaV2d+OoKbrXcd3SvP91kWTdHYyeGTZueFcbwG1E1zDUHp3BZImOLLyyuobdU/DOdCXxA/WZAfDGAkYahQCJJzeavv2ba2ZYdIbFM7QRACjE/equvFR8wD5yvQla4U2wj5AA+fyUGv6Eq+xxvmFDUXMwME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028331; c=relaxed/simple;
	bh=4aUJK7VUOQ/uCRWZ29j9yj0ZivF1P99o5NOl3kBlKyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHqfgrZz9KMmZtnNS4munvo5NTKGZGuXZ9sCmoTZijCfoTvv+RgBQWPtBDlORtb2Qexq4Xc2bz/8cJymSVwfk9WRLmmIHBEUN+dHPuAHrQ5+E+JbTD/JmgCPa1uomtLA9wLyuy7FebpqBn703Bn/Ou2Po1VDyNLVJEfIB0/gpmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AZLXrhLK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=heCDIcaX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AZLXrhLK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="heCDIcaX"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I45m0C4187023
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 04:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+GMonc/RpYRTRb39qbdjpzhy
	wf/yWb6wWhYjSvEgMFI=; b=AZLXrhLKeOIaJbOQhN1f/mV6AmzKXDGGHr8sd/FP
	7A+yZhwyDyc8rsYV7paaj8MfyyGlu2+8FEHFBxB3FDNNe575kDViwsLOaRFA/Hkn
	aTx+Dd/oz1uZtz9s7Bs0vPRDMM0ykNJ8OrjZnOB7SVbgL8vi67NCBkpxcrXdsMCw
	lI6kJW9ReRAeujuzScXbbRs6M7hMEhzHGVpVVHLiqIjLfQ1dJAW3Dt0v7ZRziutA
	AP3P4MxLAFodKbVBWk+25KmxZ62v9kYY+6gFRk5Y8nZAtNJZCVALufyWOBMsKMY4
	vafCsyO1RxVJJrxpQ/VrLht+HPB9lc+PSnApQn6WOBAMAw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4g2p0584-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 04:45:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936d067836eso439864085a.0
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 21:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787028328; x=1787633128; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+GMonc/RpYRTRb39qbdjpzhywf/yWb6wWhYjSvEgMFI=;
        b=heCDIcaXyYrm48Bqs73oI5iMK6DG2Y3+XZxUiIqPg9gO2IreBTOKgWR1/MLFiJ0Dxc
         sX8MwwGroF9iaWsMh6OkyhGZ1WZVm1v+Z3Hd6zYuLlu7htjnM/L15vyXavctkai5wNFL
         UqyvVnTKb40BpE6I2tXn+erbshGDpI/4JBF3SrMQHotv6tGDeuH5j0lcR5zp0z8eDXjy
         SbZBKQu2NgG2xlsB5AKZNFL51Zjkdxvnvwh23a8yqBC/5TQWWyKsk7UgGDNFXotVIOVh
         82e/I9f7UooG3C+or3U1B1cjZ8Q571/2gzGdkUC+9XBVV2x58ABvVpf66rrXf4SkBlfc
         q+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787028328; x=1787633128;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+GMonc/RpYRTRb39qbdjpzhywf/yWb6wWhYjSvEgMFI=;
        b=h+rYxs5NfnKQ616y3AS3ujDh13sU3dUk5OJCe1aQonjfr54scRKc2SwnCHJq/waNkD
         0vD9LC/xzV1j3s1XrOSf2bJRVQCJfQccBr/tmTP6UCfXek0IsdVz1FElWpo/Eqx8lapk
         PTugW8J5ppjS+YvmsGU1Z9VVEjCHXU6/54wJv8/m+vs8h3WmS4aGUj4rHHjiD/WC9eLh
         1ddzl3Z7eXIleB3Chjj6nWBeAjBTACutZc1fnwud2S3z6ZdRYGxSFsJiq/Fk8FkovCcm
         qnbCqMdMijdoDkrg/22wzn2RZUFxXBNycSrKzlLVUl8t7YuGH9onVZ2xOL/y3idA5q03
         1ktA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9ED8z9fNJkjz6lfCH/1rKpo69YU0uPp8M8Jn1aZ49hjCxbt3rCap7wneKxWLrgGLgEh+sZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYAdBiDH/wVYfE1XGc+X+9VWoZ9B32Wwllg6gOA2cdOprAfWrs
	BnroVlc+ELehojZFRKS+6XUKSq1i0SOwLdMilFAsE45At71CxduIQSY23wk7HNVoNR7Jgp3RvJN
	knuAoO/8VszdZijyLV3lnQcD4h7y3qMQlx7Q3zcy4Ac+jmC76uF1RUrAf9w==
X-Gm-Gg: AR+sD13CGiSFC+jlUw1obNnmq3bTJ7sJSLtGX40361yLLEjgr6Gs5DMPebGiOTV2i7r
	vqLeR2Dfn3mkSWL9axhLcZbPDYyCQF90VhgX2KqB8nfyZUHpygqBXGeE9OHnYZCeI5FeXD5o8FN
	LOuI8Iz4p3HERrqrimmqKWl2a+dvQGI95HkDO9FjgQ1yCwMXbv8FXqpq0TYZ+x+k+q1H4p11a+4
	TPXcYUeWvdiktn0RTjDYeGVUsRDYZ5PMXpUdsD3GOccV9SE4wa/NSIpKqMFXxmIVGWvKojYjkNg
	HZm3eWzKPFrK+Cr+GBGl1kbA7mwU+f9sQtqp0oQpWbPBQpaH1SE0xp9u+DGOMSsjbPLvuMTp4Hr
	66uapBcL5qylCvVSmyS3vIJZJ6s4LOsZZRuqTwL/RF62KTPHfanK6uvYo7O6LBA7lZwiCeu/G16
	8OaLiDn5PScaZO
X-Received: by 2002:a05:620a:a217:b0:936:cf64:97cf with SMTP id af79cd13be357-936d239212dmr3033325085a.41.1787028328461;
        Mon, 17 Aug 2026 21:45:28 -0700 (PDT)
X-Received: by 2002:a05:620a:a217:b0:936:cf64:97cf with SMTP id af79cd13be357-936d239212dmr3033322485a.41.1787028328017;
        Mon, 17 Aug 2026 21:45:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46cf960b6sm911796e87.13.2026.08.17.21.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 21:45:26 -0700 (PDT)
Date: Tue, 18 Aug 2026 07:45:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 08/15] accel/qda: Add QUERY IOCTL and QDA UAPI header
Message-ID: <bi3zx3rvebd4ywnyzhsu2ft2sqz3rnoblcgt3jpmyik3n4dxar@nnddlv2susx4>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-8-69a02e9090d4@oss.qualcomm.com>
 <r7bx25akbxomzhxxyqd644efy2vc65etwcnhlyha7wm7xrt7ea@p4v5sesn5rzw>
 <c54f5212-809e-4517-beda-f86b375c086f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c54f5212-809e-4517-beda-f86b375c086f@oss.qualcomm.com>
X-Proofpoint-GUID: GieXnw5JtizoOLrxPsiqnPK_xgBH0mfj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzMiBTYWx0ZWRfX5kjQlL2sVxVT
 iol9S/Lgod0PYGobdh8aPGaIpgF7nq8bsCEYq2pDP4LoLRbV1Jp7Z3/3iXiWuF1he6s01uYtcOs
 34tuStCIg1Dujxqw7Z0nSN2YRPF/TD4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzMiBTYWx0ZWRfX8PNNZVWnrLCf
 n8TMkI4UZpQEkZ/WSKvOD0w2kcxS1W7CdjSDzoStA23QrWFPlxakqVf05te9eXh3lcPerjgVDaP
 j6JjcmhIAM2Jw/KGvQCNRLoWfxH8FYe3dCYed6xmubxCilckIY0RnP0pkbPqUIKYk8FvXiRbTrP
 Im+TgdCDA9WDcTIEx7fkawcQHeT931gt5Wp1tV5PEJrpv9C8ROr9ZFp+2Mc1bScOT9fCF0cEWij
 OWEexcLojR/gdxhhjndjhp3JO2KEt05fz1uteZc2IqwRellHPsFO/G0xMTeoO534yBi8nYt4BW0
 Yo8BqTEnEikZQ+lxBPbjo6ASoIC7inVjZZSXLYYOjcyTmmcOTwsMNRCfyWgsjyALoqa1LEuDbq0
 9opwmea6k1MCxkBcUXACooJEiMEHWGBCnpnWFnVeod+KLtPsNFBOPSTU7MAw0YrzQcTD+mUpuVR
 fpDbH2cXiQO55ibwT4w==
X-Proofpoint-ORIG-GUID: GieXnw5JtizoOLrxPsiqnPK_xgBH0mfj
X-Authority-Analysis: v=2.4 cv=bfRbluPB c=1 sm=1 tr=0 ts=6a83e369 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=SJmWK-JnP90tPv7FAzsA:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180032

On Tue, Aug 18, 2026 at 10:10:16AM +0530, Ekansh Gupta wrote:
> On 17-08-2026 12:28, Dmitry Baryshkov wrote:
> > On Mon, Aug 17, 2026 at 10:17:43AM +0530, Ekansh Gupta wrote:
> >> Introduce DRM_IOCTL_QDA_QUERY, a query IOCTL that lets user-space
> >> retrieve information about the DSP a given /dev/accel/accel* node
> >> represents.
> >>
> >> The IOCTL takes a query_type selector as input, so it can be extended
> >> to return additional parameters (capabilities, attributes) in the
> >> future without adding new IOCTLs: drm_ioctl() zero-extends the argument
> >> structure, so new fields can be appended to struct drm_qda_query as
> >> long as they go at the end. The first supported query,
> >> QDA_QUERY_DSP_NAME, returns the DSP domain name (e.g. "cdsp", "adsp").
> >>
> >> The UAPI header include/uapi/drm/qda_accel.h defines the command number,
> >> the DRM_IOWR IOCTL definition, the query_type values, and struct
> >> drm_qda_query. It follows the standard DRM UAPI conventions: fixed-width
> >> types, a C++ extern "C" guard, and GPL-2.0-only WITH Linux-syscall-note
> >> licensing.
> >>
> >> qda_ioctl_query() validates the reserved pad field, dispatches on
> >> query_type, and copies the DSP name from qda_dev.dsp_name into the
> >> user-supplied buffer with strscpy(). Unknown query types are rejected
> >> with -EINVAL.
> >>
> >> qda_drv.c registers the qda_ioctls[] table with the drm_driver so the
> >> DRM core dispatches DRM_IOCTL_QDA_QUERY to qda_ioctl_query().
> > 


> >> + */
> >> +#define DRM_IOCTL_QDA_QUERY		DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
> >> +					 struct drm_qda_query)
> >> +
> >> +/* Query type definitions for drm_qda_query */
> >> +#define QDA_QUERY_DSP_NAME	1
> > 
> > Why is it necessary for the userspace?
> Currently the requirement is that on systems with multiple DSP domains,
> each is exposed as a separate /dev/accel/accelN node, the library must
> query the domain name to select the correct DSP to offload to and use
> other dependencies like shell etc.

Commit message.


-- 
With best wishes
Dmitry
