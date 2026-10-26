Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009877;
	b=imMLg/41armXBplkmYyEDbBdxhZNg8b+ghKE4dORQYYQ8pG0NxTAX7Wsazv//KQxOokn
	 nArlLXQxSjEQSiJZen/w2ivOz/jRVVeyZH7H5ijnzDEWylePrB806xSQHie7j5cy7CU2S
	 CmqvcjvsLUnPoFr4ceuBZHXHyw23ZSEZy6Q1mXARzF1xRAkpjfnvJOniL+xzGInBsaBGQ
	 RcBQ1wh9P2LD1VrA8+XbxKnIht0Dn6clCfhAXLYVzEyIJthQcu+MvoKqserRMRidQqPnf
	 ReUgPAm/byEqJ+2Gv5xZIsP41bmvH1qwvbIF22H9m5/K001xQ+HGFzG/X1zhfGjW3ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009877;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=78XFvnCPVHn0LabnIkSaSmfw7iCeIi7jK9513VDUmZ0=;
	b=quKT9+BA6J7FYaBjYqHOPU8KVXlto1sHCPOIdeldQ1tiKG9XDnc5eFQNjqCAxaq2C1eq
	 1zwi56j8TlI0q8Mgtry7yiPLOh5S/FcLF9mcAOoguoBl7g6OOZTJ3OhSGZ6hrg7Z1F637
	 5sW6TBNEw/u2MzLqqhzs7h0mzdEQVG1ZYQNOWGYX4de0HPPGiTMu3+abda2fTSiAqmFw6
	 P4E4ggJNuD5wsuLTnCScsB9HnAZJSrnzMDHhRe/XFzbRoiWOB9WvR9tFeX5nvYIiSL/yR
	 /mueJic12hJqS/TVs91gwAAd+5Oj/bjsmB72VfyufYVyPnoDLG4d9D43OBYuYJpQ4dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dSx13RSA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ufg396pk;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7F606A322
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 10:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EE7F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dSx13RSA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ufg396pk
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b1EF2206172
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 10:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=78XFvnCPVHn0LabnIkSaSmfw
	7iCeIi7jK9513VDUmZ0=; b=dSx13RSAlAAD4EUSzR9AAOMLfIHAGtEyMLOfHTRS
	pN1Vr8xV5aPEqcZmnOE3vw7Xw9+63iVXiEiPsBrFbnxmiJwqMyMPdo/DqFUzAqr8
	RFjb/wlh3sKurhr2fnnUukWrR3BZhHqQ6XmUmStb8r82aNvCS/EiKDAI0q/nGBuc
	ZpksdOnmhTL6RGYy2D8KTRlt85jKkJcXOjJlVwUsZmrGJK03ka8ft6g80aQJRAlM
	H0Uquj7iyHtk8J6zPfdK47S6h2LwhINz8FAes8aYQWRTbDKcJDFZcoXeqZIbKY+c
	nhWGRw78uQYZcMREksvGT+NUr0ZnHfX7P86zYTo0o7/STA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmrunw4w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 10:17:55 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5eab0467c89so3775542e0c.2
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 03:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793009875; x=1793614675; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=78XFvnCPVHn0LabnIkSaSmfw7iCeIi7jK9513VDUmZ0=;
        b=Ufg396pk/BbTnoT2VRiR15yFItlVyzeZQS3cTrTL7Wzfl3Xs5QucMsowX1RA6Zj3AS
         cnu5suE5KDOAVB25RsVCDabic1Uo14IPuv9mZIGdhR3DSOxJVp1alA4nYwSseermWJ9M
         +2ALAYpdi9VSBA8I7+qjuyzq+w7JeF8TlUxDHMpzN83I0lrSP8/Ew5OFVwuyEHOR2+77
         MB68hyF9MOsRySkJ/EnTi9L0zfysqBqYeh5TO3BF2eXHmHGHaWpxbUCrYG0GEd71/gDL
         gAzDcafQTy/2j7z5RCUxDlgMNXGiR5WGd0y5TOAlUTBuX0vHjOEoFPijGoBrv1T/u/cA
         JK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793009875; x=1793614675;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=78XFvnCPVHn0LabnIkSaSmfw7iCeIi7jK9513VDUmZ0=;
        b=iDWmkgvFGwj+WKCIeE8l874uFKArrYe7nq2yrKHnaNaE6/IUA8dIpZpWAcLqt5gr5o
         Lv8riE260I6VObS0liy2UEbQ1cOHuaOCsLv6pOft5kyxsjCnecE2tLROeATDEbRqrp1i
         otMFrbXTDk7VwCaxADxUTi5YMynI56R/3cSrqYgOnTFFSn4nif3u6gJTea98oEk70cwd
         gQ0NYvZn+E+a1stKMtqK1UeDAyu7T85RgcdbxBGF5ju3xnQ0baDRkkOOSoR1ZN9/I8X8
         m85siyyq+wUg0MPmD7SY8PMmS4iuSq4zPZhEOdKzvIqPODY04QBJ0zi8322OHra66kSh
         a1OQ==
X-Forwarded-Encrypted: i=1; AKwUvByGvBNSUibwEQWvMgRsYswnA8G1KxWpPOnBEP7niT/5FFaW2hEOIbz3a7k2JWGDAbhBuW4q6g==@lists.linux.dev
X-Gm-Message-State: AFq9FYLUiAn7D+kBh1fMtv+tgclGnWBaOGnIyoMJXlYOI9uBpUyXoIar
	dY+aVekSCj5OhTHfryZCc/Cnd81VsiXUkpmrgyRTt526KSjB87gbyUFC5+0QMDVZw3wtayijmkw
	M3XQ0fZ5s71UHOm/ntko+kVbBe9/ZN4pYgFzVE0DJeNubmj31kknPUhxUvQ==
X-Gm-Gg: AYBFou0CSu9yBgeFQYRLD+RJD7yFYihJY5hHkvXwFVQDzdDFV71LhqlR5zcLG9VyaoR
	A6N/Xl1xw2POqQWva4qN3DeVPQSxGCS5P8cRfMhj4syXe9YW6dC/c744Dwh8ZsU75yxjiRC8KB/
	d6mkz5Hm/dl4HJw/s9dIb0EyDSQSMQva8VVENVMUsTSy8K0zm1PRgjGf2wBSphTa4GelbuZ+lzw
	Zw/cImpxXWWqq3dUfBzXABD7MDnzWWrjB7zBqxfKy/MVsjnFT5oCmuM7JFo3HDDiRnBfh3VJOk+
	OTqhaqqjfs55nRk/6EQZvOmvwxqYsBimJEuIvH6/ym/b6WvcmJfyF3QCoVwLYtK0n0MKZUE58pf
	/DzMH0zZjoWx8yYfcxyvX9wxj7bx+QMk5Kd5z/J/b/O3HI/d38A6eCdQGILDIZfnVnGey3pFG6H
	A9w7gBQMcfFjvi
X-Received: by 2002:a05:6122:130e:b0:5ec:20e8:45ff with SMTP id 71dfb90a1353d-5ec23319c0amr2162210e0c.21.1793009874643;
        Mon, 26 Oct 2026 03:17:54 -0700 (PDT)
X-Received: by 2002:a05:6122:130e:b0:5ec:20e8:45ff with SMTP id 71dfb90a1353d-5ec23319c0amr2162205e0c.21.1793009874219;
        Mon, 26 Oct 2026 03:17:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac709d0606sm17076351fa.14.2026.10.26.03.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:17:53 -0700 (PDT)
Date: Mon, 26 Oct 2026 12:17:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 06/13] drm/msm/dcp: Add planes, CRTCs, and HFI event
 routing
Message-ID: <rdaviyavkytkblgqjqp334mtluji4t6ybron73wm3uv5hdbvjf@5uxq5hb4fclw>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-6-48aad0fe4f72@oss.qualcomm.com>
 <x2ppnksfdan6yehawencv53qttcxznr367iuaw3ltwttkoffkx@ccrzx7alvdpm>
 <7ea3f000-086c-49d2-8409-04d5aa6e9ded@oss.qualcomm.com>
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
In-Reply-To: <7ea3f000-086c-49d2-8409-04d5aa6e9ded@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfX1FfNG3wzyREn
 2MjjQATOwYnBImcUdAE+HndimkC/N8J3lv4kp0uQ8Wzoj4WXl0tFMZ/SGzHj3LzWgTb3DMS/FxA
 bc8NTDiPOpHz+4UtcUFbjVbN7Pq9acx1TFcr/AAwgYHbLRT2UnjoXHEGovhrntrE5AB2MaaugQz
 3yLl7u6J4to2QAT4HQXK7H0g4Gw1+D9tq5ExPtn+Zv+2tD0nh5U5fGHU2371rLeXQurbBBYs+XD
 fjlRGMBz6ddbWkiUUptRuJEnOg8f8P3itexGnik7H2rsLGVNOMrAjhXNu2TfSH+SK3vqeVLe//1
 uMEzCmw3n8l2qR5bNcapyfUCOpR6QECiAxRpxgKprDNevdp8KGsvLF8TG532/Bavw5vMuSFicYz
 igqYNpk4YYTCG3DLXKAsPEjgT8Gg0b6i4x6Pj/h0JTX+rd81vJmCx+w489fopDlIuMn/z++Bljp
 LyPN7wfEnmHmfzssV5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfX1LWWAcenrjmF
 CXOT1LYMnmFp44+ZWxwntW4NBAJjpM2t0PKoNg8dmoiyG6qII8HrIG3FKenemMr/k7EMlpDyX7C
 IcBePAgh/JxxSgD1gM+C57S8JxtZGRw=
X-Proofpoint-ORIG-GUID: 52tMauiCdZZHSfdGUcQmTEyxVh_Oj6g5
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6adf28d3 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=_9fECkkFWEdeBB18FusA:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: 52tMauiCdZZHSfdGUcQmTEyxVh_Oj6g5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260040

On Fri, Oct 23, 2026 at 12:41:15PM +0530, Jayant Shekhar wrote:
> 
> On 15-10-2026 18:48, Dmitry Baryshkov wrote:
> > On Thu, Oct 15, 2026 at 01:08:26PM +0530, Jayant Shekhar wrote:
> > > The firmware-owned DCP pipeline still needs normal DRM atomic objects and
> > > event handling so it can participate in the MSM DRM device.
> > > 
> > > Add DCP plane and CRTC objects, validate framebuffer and plane state,
> > > allocate firmware display pipes, calculate bandwidth and clock votes, and
> > > translate visible planes and CRTC state into HFI commands. Route VSYNC and
> > > frame-scan completion events back to DRM and retain CRTC-local display
> > > session state.
> > > 
> > > Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> > > Assisted-by: LLM
> > > ---
> > >   drivers/gpu/drm/msm/Makefile           |    3 +
> > >   drivers/gpu/drm/msm/dcp/dcp_crtc.c     |  733 ++++++++++++++++++++++
> > >   drivers/gpu/drm/msm/dcp/dcp_crtc.h     |  104 ++++
> > >   drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c  |   27 +
> > >   drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h  |   49 ++
> > >   drivers/gpu/drm/msm/dcp/dcp_hfi.h      |    2 +
> > >   drivers/gpu/drm/msm/dcp/dcp_hfi_core.c |   21 +
> > >   drivers/gpu/drm/msm/dcp/dcp_plane.c    | 1073 ++++++++++++++++++++++++++++++++
> > >   drivers/gpu/drm/msm/dcp/dcp_plane.h    |   60 ++
> > >   9 files changed, 2072 insertions(+)
> > > 

> > > *p++ = lid;
> > > +	for (i = 0; i < HFI_MAX_PLANES; i++)
> > > +		*p++ = lower_32_bits(iova[i]);
> > > +	for (i = 0; i < HFI_MAX_PLANES; i++)
> > > +		*p++ = upper_32_bits(iova[i]);
> > Who has invented this? Splitting addresses into two distinct arrays.
> > 
> 
> The field order is defined by the firmware HFI ABI, not chosen by the
> driver. struct hfi_plane_buff defines the wire layout as:
> 
> u32 addr_l[HFI_MAX_PLANES];
> u32 addr_h[HFI_MAX_PLANES];
> ..

can it be fixed before it is landed? If somebody made a strange decision
it doesn't mean that it can't be changed.


-- 
With best wishes
Dmitry
