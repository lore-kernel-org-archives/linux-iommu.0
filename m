Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101909;
	b=tDUbHeTMBZlPEr9pt8pytI4zkvGKZ+mxU4F4mHP0WYIaePO3j0D1/pke152I7UTDXqt7
	 R92WQz98oRH5k/F1WODhbm2XQYEnvRqsgjRAvGWvd7Fqx2BE3k4Ag9UZ1FSFUE2eAlxza
	 zD+qq9yz+qcbEUnZuhrarPBs9ajwFKtOQ7aQGitPB4CBD0qMXzYdnZ/VMUCnr+CaA17at
	 PzXvt0bEF2XivtGiOlYQ5sVWeqqzM+aKf4HW7OCuVOwOzvSE4YvxYBmoY/UYZ35nrgToG
	 yzFMsRexyFWjZsAwGpEZuLsg9W+7+K7hDHDGVv5y82TUli7JUMadBUG5Okxxh6HZVKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101909;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4W3OqlKiBwfz5eOJMTRV/rIcRtmzZqXVHzyrSvnxP1E=;
	b=nvIKAAAj2MnbE95DB/6iiK1KCzsbY8+jjCCXBEhsRQjVqLR6gbAhOEvyXLYWxzIFhl/P
	 qrKr65Omb60SRvqM89yU+5PXGdoU4G7QjAoA2so5SI4qKc1QGQKylaS9PD/Au24ewK8Xj
	 0toFBRjav0ADYm+2OON9FJ2tnFW81yh545VmEthCfZcxT/D6/N6bFEj20YATfTe99TpAh
	 KxtRAgCNCf/lWWA4tN5p3xrUd+NVwhwT6/u2ajKKNdsTpsazVNiTokJF5PWVmm9PXRHeC
	 tKZ4fdw85S0Q6lIM2o931L0U/MRwbo4r7KgnfmWusHsgyv8sKaYy6DAqaKqWz6k/X4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D1mfuL7S;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jUR8OrNp;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346E3606A31F
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 11:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 346E3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D1mfuL7S;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jUR8OrNp
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAeMNg1427681
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 11:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4W3OqlKiBwfz5eOJMTRV/rIc
	RtmzZqXVHzyrSvnxP1E=; b=D1mfuL7SsPPdywV1ReO5FFA7LhAPLjwRRqGIXf5P
	zHtT9DGm5cK7aTPGPks/P9Tp3ff5LKQNkHUi1YVw4uQZDKdHMtxyca9OI4ORMxWA
	M0qHs20gmke7Jm1Ro6H3/CpWT8JkzH30zVEyPPuQ0OswNev4I7RQ381fWXOClVRR
	kQX9ZFhdwY6v6uMd2DyCDn12HCMkp8yv0W+efd9Ulldrq7jkk9bxcvNyyaiHrIm1
	yOCyBIWEwV9qfwg1kOiGI/p/GoLgs/KhI2n87VNnAom40WMY+IqIvknE8yLyux3S
	7OOPInAJcEHMHv+WquBkag64NvySmob2o+UL6KSZatGoeQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmbdxy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 11:51:48 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5eabb3a1bd8so4739849e0c.0
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 04:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793101907; x=1793706707; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4W3OqlKiBwfz5eOJMTRV/rIcRtmzZqXVHzyrSvnxP1E=;
        b=jUR8OrNp66faX5QQknz4Jo81ScaclWG3EazZTfmUXA+Rl+8U/y4Nvn2kFS6Z2OvC7j
         nzFDCnfim+65UDh9Ry/j3LS+SlAju9kIgaUl0kvShwNulgsBHD51GJWIy2FAoQbBi2Dn
         okuIFGJr3l/0SOg1OSPoHJ7Naygsci517lfYIFzxAILwI32WcZbu9ciYXHp2pFO80dvk
         Yg2qu1vx7eKRRNLYcHUQHRjvbufdJpeOJwpFnA1WE7XuVchRVBHciD45ilV97hn083Yo
         uL/vUmNuESNTr3LPzqYb8PjXPnUIOFe9WWhyQgwG7Tz27h5Ul2gMCMmqjSuzuYC0iByb
         CUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793101907; x=1793706707;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4W3OqlKiBwfz5eOJMTRV/rIcRtmzZqXVHzyrSvnxP1E=;
        b=sEnA/H1ZAPKNxC3Bz2bhiDOh+sTWNDcOz8yvxaPLr852z/KhnhfxX/LVrBZlnr32xe
         PN9Y9FKbn0tTtcOTDIAgBdrQbQ+XCv8u9efEWN+j30RhhnqoQWLuzHw1F4vS177ZPWqi
         /kXCRtXVzP6uGg1KHSEnrzOGItyS/2Cbb0w1syV9xK4pWVyK2BvMl7xb88sZ6Hg+K/gc
         hJNsKBruv7/Ol9CUyreOtfQdsVEwNCn8ZQMsgtqXxz715IpD/zZP6y+jvcPJP+tiSBXb
         JGQtuI8ULDFl7sP+59/KCjI3ESgFXQgafCaGaeanZqf4IT8HgWI6GqUSs3feJk9uAD+w
         fdRg==
X-Forwarded-Encrypted: i=1; AKwUvBzvCrG545KJ3OEwl/lttfYUh1heY+ECSAWnpvnjROSqxzQ2fRXDmbUIibM3HWYejWkCHhRNqA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLJ6ArZ2dLMxIIrTM+c8tf9TaxdMgYHTO5XUVuJRF6hae7TOBS9
	POdh6/Z0UxGhi6/DgDWKIFiKWxATcYo2meUX33NKhVr+4wmgBcWpNMlcp42OlFa7hc/N6bQOTfC
	jD3sNTKup3+1CudUG93xAXo0A0FJTNiqMKonyWOxi8jFi8/JzKbKUZpAmpA==
X-Gm-Gg: AYBFou0HvbPMYlbgqBWh6E8Z3Csw4b9bPpAlDLfGVbSCNkcIXT+AtB4pqHgJSuvKonc
	WV1TdouRvld1/VVO8XxDK8CFqR0wAjpu8ZGjtH5JKbAf5uciKkPMpeCRLg+N2eqHtly9tIHnhrz
	vVxsPwJCXERgtXpj0EjVsgglYJm7UXlIoklpKi4u1qJeyRgZrogoqCszcxB9SYOFPXf5nG8LNFj
	ixu7nPGk7y4vUeUTpRDQ8AKL1HLV/8AIVTakHl+tD2twVsYXhj/dKoe/0cCnDjn/FxBXFYgp9CI
	0ULh4FbytWctza+lHmMLZfpf8pGMTvCidP4vfNnd3YQHzdefq5zTuaG6eIXfG6GS/Vjep8rk+cj
	7WY1vYrEBKfAO1+OJOvQxHV4Wivh/oHXXd+O0gi7G05R6YatjUKR58+dKLr1BrfVdFkP2C2Rp8j
	XQ0tELkpiKN2jd
X-Received: by 2002:a05:6122:6990:b0:5ea:e324:7c15 with SMTP id 71dfb90a1353d-5ec232ae080mr3936890e0c.15.1793101907180;
        Tue, 27 Oct 2026 04:51:47 -0700 (PDT)
X-Received: by 2002:a05:6122:6990:b0:5ea:e324:7c15 with SMTP id 71dfb90a1353d-5ec232ae080mr3936868e0c.15.1793101906693;
        Tue, 27 Oct 2026 04:51:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac70993e89sm24077941fa.9.2026.10.27.04.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:51:45 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:51:43 +0200
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
Subject: Re: [PATCH 04/13] drm/msm/dcp: Add IPCC power notification
Message-ID: <t3vxg46g7jac5th3hrrs3zchss6lzmgm2ga5qkro4cepr3qmnb@ddosuavblhuy>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-4-48aad0fe4f72@oss.qualcomm.com>
 <u7pcn75yh435vuuwqezml37bqfzdztvrywggbmkydkilwe5yzp@myijo4wd2bob>
 <db88a83c-29e6-4fb9-a874-15c0f186e14d@oss.qualcomm.com>
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
In-Reply-To: <db88a83c-29e6-4fb9-a874-15c0f186e14d@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfX9oBVfosw57t8
 +B/qHQE8JNVIDO7M8O88ZgnyEl4+U+5GcxYaLpt6u8KP8yGv1zFL4hrhPbE5Ib1x0cCLD1RKq9i
 9zuC9CNaPY/XclI/pK0lFAPOabiJ/WM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfX88aRGNRTYl6l
 1m4XcaKiz/2C1oEnjQyEA+wznqCDZ1g+Juj7myW07O3ZAOKEuWa+7TlYalk4RQIo6VNRDpmiYjr
 HVGsHEH6lMx6JXScXbB4Pauxr59ZY3niKND/RD93vVyO3c/QLCNutE2g0Z0EAd7rBvYJUBWjXi5
 ai+Ar8JagrmgOMXY2tUfpkTYRNLsuYpdOd7XXoTHb+Zllw2zMcIfghwqd2isQdoLlnAbMtBTExF
 apG4eIi+xRqlRYTZ9fHlQ8A8qiZeumiws5pobyP99t7iwx665j1aqtZBoTpvn4naTd+TLcYf98T
 F0ij6OYpBEpP8YS/9H4MWTWfkfe2qgDKNgKyYjB9wiZjlKZVHT+wiA1wdxazyRlrmXznUcRgIZb
 i4tEtRsLDSUMgvIHtqzlLUqmdVYcbVWSr7AQyACh945QKKeB5++E+UI2Vo1K6C8PPE70PbXAHI8
 kOncJ3POL2s5eBDQ/kA==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae09054 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=75pfyCq1Idx6z_e0LXYA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: VOLrc1XSQ7-NZzp5JTxi5PWhGmgVzkbs
X-Proofpoint-GUID: VOLrc1XSQ7-NZzp5JTxi5PWhGmgVzkbs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270047

On Fri, Oct 23, 2026 at 12:37:30PM +0530, Jayant Shekhar wrote:
> 
> On 15-10-2026 18:12, Dmitry Baryshkov wrote:
> > On Thu, Oct 15, 2026 at 01:08:24PM +0530, Jayant Shekhar wrote:
> > > DCP may be power-collapsed while the VirtIO transport remains available.
> > > The host therefore needs the platform IPCC channel to wake the firmware and
> > > to receive notification that it can service HFI queues.
> > Is it allowed per the VirtIO spec?
> > 
> 
> As we discussed, its not compatible, will address in v2.
> 
> 
> > > Add the IPCC mailbox client and power-notify interrupt handling. Wake DCP
> > > before VirtIO queue activity, wait for the firmware acknowledgment, and
> > > notify the response queue when the IPCC receive path completes.
> > Don't describe patch contents. Describe your design decisions. The
> > reasons for the flags, init/deinit functions, etc.
> > 
> > > Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> > > Assisted-by: LLM
> > > ---
> > >   drivers/gpu/drm/msm/Makefile       |   1 +
> > >   drivers/gpu/drm/msm/dcp/dcp_drv.h  |   1 +
> > >   drivers/gpu/drm/msm/dcp/dcp_ipcc.c | 212 +++++++++++++++++++++++++++++++++++++
> > >   drivers/gpu/drm/msm/dcp/dcp_ipcc.h |  56 ++++++++++
> > >   4 files changed, 270 insertions(+)
> > > 
> > > +
> > > +/**
> > > + * struct dcp_ipcc - DCP IPCC power-notification state
> > > + * @client: Mailbox client used for APSS-to-DCP notifications.
> > > + * @power_chan: Mailbox channel carrying power notifications.
> > > + * @resp_vq: VirtIO response queue notified by the IPCC receive path.
> > > + * @power_notify_done: Completion for the firmware acknowledgment.
> > > + * @power_notify_lock: Serializes power notifications and teardown.
> > > + * @power_notify_pending: Indicates an outstanding acknowledgment.
> > > + * @state_lock: Protects shutdown state and response queue access.
> > > + * @shutting_down: Prevents callbacks from accessing teardown state.
> > What is going to access it during teardown? Can we shutdown in a logical
> > way, so that there are no accessors after starting the teardown?
> > 
> 
> The access can come from dcp_ipcc_handle_rx(), which is invoked by either
> the power-notify IRQ handler or the mailbox RX callback. An RX callback may
> already be running when teardown begins. Without protection, it could
> complete power_notify_done or notify resp_vq after the queue has been
> detached.

THat's what I called correct sequencing. Make sure that events are
properly ordered. That is, disable / mask hardware event reporting, make
sure that the events are processed and completed, then teardown. See how
IRQs are being freed.

> 
> 
> > > + * @power_notify_irq_wake: Whether IRQ wake was enabled.
> > > + * @power_notify_irq: Power-notify acknowledgment IRQ number.
> > > + */
> > > +struct dcp_ipcc {
> > > +	struct mbox_client client;
> > > +	struct mbox_chan *power_chan;
> > > +	struct virtqueue *resp_vq;
> > > +	struct completion power_notify_done;
> > > +	/* Serializes power notifications and teardown. */
> > > +	struct mutex power_notify_lock;
> > > +	atomic_t power_notify_pending;
> > > +	/* Protects shutdown state and response queue access. */
> > > +	spinlock_t state_lock;
> > > +	bool shutting_down;
> > > +	bool power_notify_irq_wake;
> > > +	int power_notify_irq;
> > > +};
> > > +
> > > +int dcp_ipcc_init(struct dcp_ipcc *ipcc, struct device *dev);
> > > +void dcp_ipcc_set_resp_vq(struct dcp_ipcc *ipcc, struct virtqueue *resp_vq);
> > > +void dcp_ipcc_deinit(struct dcp_ipcc *ipcc);
> > > +int dcp_ipcc_send_power_notify(struct dcp_ipcc *ipcc);
> > > +
> > > +#endif /* __DCP_IPCC_H__ */
> > > 
> > > -- 
> > > 2.43.0
> > > 

-- 
With best wishes
Dmitry
