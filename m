Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009998;
	b=Pj41uuMIUdJQ4294bZLME7uZv2/TzRdDp+sEBCAoO2kmXpQQRn7pOmHwgcU+9/2lHhSr
	 cCkOPqGpPCRQ2ShBmg7n8nC8T+uoqG68ulIw+0k1/I5hyKPtBMJH3tBC/5RK2UP3Q39tC
	 +cg/wxfi1tN9Q9Shu356RpZSiN1I1GDIAAflBbspfCaNzXCtbhQNt70zfaAMNGhbd01ut
	 FO/e+y1Q/EPtiuNKl2pCGDLbSfkGkATDEm9v5XWtYrlHLSgkv6DM39aZi7f8tARlDdUtt
	 4hspxrJH8EHkNNfR0YWnmYf0lfbzD1HWjfPcD759nMZlCERzzrWT15i0iWSHgDhEAiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009998;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0d1AZOuu17x2UJYa5tXiu0AYveVDNIUyu2EW7x7PGi0=;
	b=0mjlmlh3Qw33sQb4e1JXQ5rBEhhegeBVj9cQ0hNTCe+lydZtkSUImiFb+WMy5rnAUjKs
	 Fu/OoMovsX8EP+IGo4loHce9LhwKD8GDHfMH26QWqN75C8txLPFcrap0/XVEqxmutRt+k
	 Eb6L2RgSOLX0V3LTZ+SszRFn/4tvr0u6fm1BpWsiP92PZEmMU/Plqyhn0AXlmBUI835zl
	 uWq3uuZ5QA7ADXbLoxU0ltoJFrQ48n/luG1GiRZKXwBN/MZwR3RpvnUhdPFWSJlMUBhgr
	 V2rZU/v2OX7jlfqPfbxzzvpyfJErsBTkdHttk+bup6gMELCz+2Nu+HWcFn4bN5TtB5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iG7uEmRH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RYs8+THM;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22936606A31B
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 10:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22936606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iG7uEmRH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RYs8+THM
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q9aZjR2560675
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 10:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0d1AZOuu17x2UJYa5tXiu0AYveVDNIUyu2EW7x7PGi0=; b=iG7uEmRHrz2nY6ZQ
	qdfXjpFDxtIuoB54amFfslMLk2lyWrApABuyXNM/prMFFhb0eZQTdvQQmSwZSmeR
	P2Itb0Vd3aOACtLYDfNclmQki/Xm5b7/Y/fogMLOSR6c8vuf2nNwnfmnHQ1kxVTo
	8/g4NRErnM8FfV5y9oECOeIGwrLqPaPNkRUOBgxRPR9twWXYqwbMG5Oxh+dnn2NZ
	MHzvISixMZ1cYA4ooKwj247NCQDEYHN94FAzl5ZNSeqqRY1zq/JjyaqqTxHeLITP
	KvojHGmvFYS/Ztl4x+BIdJNMTEK8LQyl2XRwbepebw/VVaXUzGh+TynZsanz9x4H
	yOtGLQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4cp85gt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 10:19:55 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7c15deb3794so542612137.1
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 03:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793009995; x=1793614795; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0d1AZOuu17x2UJYa5tXiu0AYveVDNIUyu2EW7x7PGi0=;
        b=RYs8+THMj3lA5Mw54oLXlHEAfVY1lCXpfLnOZ0g91IVm34rGmsIXDD5u3z1UjE5wD2
         yCf7rieHDI8MXRqq4+TCjNtDFzi65euSvkaVzvvkiYftTh2KAMcv5huQ9+pB01P9XRsX
         RpfVVVMvVIueA0tM22VuZn26fg6ck14zY5+uInWjIkwUBpZb/yyJf4kY911y4055my/a
         +5C+Ll3G8eD2npKXMJ9b28wzzpulhwhvhGfgTBb9zFMDA5BUfUkTIf7cGziJlydT+l0T
         kFtiuzsnIti0OEjr4+PrCQOLPPg6moQZQywuMbtkP/vDP3+3AoJIBY7MOrcqMMHE3w9/
         QWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793009995; x=1793614795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0d1AZOuu17x2UJYa5tXiu0AYveVDNIUyu2EW7x7PGi0=;
        b=RmZ7L+lK5xdJBb0bth9QxCcrbv+ACSpIKjTWk8Ft0l4Xt0r/w1t9sD3ufi3h1sB1J0
         wOFgx/Z5siTMHR9fV7k50nRfxNBNjfjzuXoLi7Q/Qv7SBGuFglZohf3v7/Az6UWiWUGv
         X6YiutZo1fDXk+bGHa5GUJYLpUZV776iT578G0NJCxsOZHcLLTbHyvfqd2kyizNqWYsx
         lDeFbk1h6XvxLDlZ4OxVVucMi6Gw18lwjD4Rw/Ebu39teaJgUnOWr7UmASxPyN5A+bd1
         y8HyWdX0mDe50tX7Rmu/yQiPjENSk/2rQwhU1+YG+4z+baPU6pkSTvodDvaWTdqKG4i3
         TSHg==
X-Forwarded-Encrypted: i=1; AKwUvBwt3NTdoNwfxV59xZRJVz+KDk8Gnpw46Tv86xWFjbzjpLA1az3Klm6OcIf0BhI9MYVTDeulPw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIYbN7wwP//un4eyY0Bz+vemya4nm00KjFq6NJoNMoH6eEof4WX
	DlQQVZeoxot0Skx+6/92X5Q52TpO8MKhDvFtOeJoFL1R9o3T/LMD0mOZhvdwg0NFNptRUelDKtm
	D4PVbNywKE79qjGKBNbbueTvRiYzv/h2IAWwEvtL5qScyACl5iNmnUMdx2w==
X-Gm-Gg: AYBFou0fiW2gxrj3x+qFCgDY7QQMlWMJvqQf/rEPWP7YIQUaprMdm2APXKPn88r1lWa
	J/ljqK9WSGUMt74enVxuo3fbENxvKs3FWJbJatCdEaVKoOS6srygW2gQSNAKPvlK3tCwRsfvLiN
	a4oiUO0PLhErYeu6DlO+2OyFjg1asKGyY3N2KyWJPsByWxp8Y06F68O4ggsg8NEeFgqKzWk8yOn
	ELBDSo0UiFXpfkIq2oa3bP2fAyROJbbcFdH5N3QjzkvUCUTmfSjtzda2oFu4brb4X9o4tdMf/ki
	QuuYjW5DIJxTiyhsGZ8GtlpFVyWRdI3kZ2XduyTeJgFPcyFzlXIAZjf+waGI5QsC8Pmc82JZir0
	s7WSpD1om5q9KhI9f0zkCNWlOyMzqySajEDzAsFELdJn4CQQmu9+Ld9ClGsib8J442T84ecwT69
	2YuVyzrgAgCnfL
X-Received: by 2002:a05:6102:508e:b0:7cc:1a41:20e7 with SMTP id ada2fe7eead31-7ce5cc8d17bmr1599790137.7.1793009995218;
        Mon, 26 Oct 2026 03:19:55 -0700 (PDT)
X-Received: by 2002:a05:6102:508e:b0:7cc:1a41:20e7 with SMTP id ada2fe7eead31-7ce5cc8d17bmr1599773137.7.1793009994712;
        Mon, 26 Oct 2026 03:19:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac709f3a4csm18119321fa.25.2026.10.26.03.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:19:53 -0700 (PDT)
Date: Mon, 26 Oct 2026 12:19:51 +0200
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
Subject: Re: [PATCH 08/13] drm/msm/dcp: Add DSI bridge
Message-ID: <ztyi4f5u7h6bmm6755j3xzf25gvguqswiwwpfm5vj5ye4sfl5d@t7vwsro3kewu>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-8-48aad0fe4f72@oss.qualcomm.com>
 <hftbao746gtvza4vkmeo4jvvgrgzoyrifdpsu4w7vcy4w5qskv@4afg7wpdw6gm>
 <a27903fd-c122-4ba1-ab84-fd3fb282fc77@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a27903fd-c122-4ba1-ab84-fd3fb282fc77@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfX21pDmjk02JCi
 SUvdNjTBNzBvPQVwoow2EYCx3DvaC+4yM+0xJT0qkBUXm4T3NKkwP3BY/sVHwIfag7kURkPUTCi
 4DpgfUrfdsuDusKbO2PY8C3fVoM/VaeF0S9cQmdyGzQreEUHFjMiKWjgImWssEicH5yV4Yd7hX2
 K3Ek4o9NGsSQmGUSPJ0mTteH/pvkR4nBU19Lzbd9A37ErQWtHVVBlpdc9eOjD4r2wiIKB6dS6kV
 0jsSvZTF2QO3+pL2/U6NDsmIR0+bP9+8L/z5g8Z7u90hYpDnlfafPqIpY927zwwzj3fLdd7DmtC
 49eBbmWXRfisQbpN0GlozzOxGBbSx6ls4SRMmLJfvfopBBZW4qAAdajS1FN4ke6LlCByQs2aG5Y
 5qUhvEvDYCU6uaywIpGBbnnzx17Z64B+mEbcPuWlwyjqND9zLQx30MWPu6ljXy6ZyXx0+P65FWB
 BcTsgKaM5VXUgp+frmA==
X-Proofpoint-GUID: dp8--csoYR5RROE81HCuM6UuWApZQ5KR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfX6JIZ0Xzqojg/
 t2EIrcieFqujGA0NtsaTmSr4eLF9z7LHi4hQEs66rVwiNi0+uOgLFOZeq4qq4vn0q9W0yjmPfcY
 DHT4HZnjBjFC72VQnitKDqAg04NoPVQ=
X-Proofpoint-ORIG-GUID: dp8--csoYR5RROE81HCuM6UuWApZQ5KR
X-Authority-Analysis: v=2.4 cv=TboDJhQh c=1 sm=1 tr=0 ts=6adf294b cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=B2W7agYZx9Fm13VZOvYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260040

On Fri, Oct 23, 2026 at 12:47:10PM +0530, Jayant Shekhar wrote:
> 
> On 15-10-2026 18:26, Dmitry Baryshkov wrote:
> > On Thu, Oct 15, 2026 at 01:08:28PM +0530, Jayant Shekhar wrote:
> > > The firmware owns the DSI controller and display session, so the DRM bridge
> > > must translate panel and connector operations into DCP HFI commands.
> > > 
> > > Add the DCP DRM bridge for the MIPI DSI pipeline. Translate panel, mode,
> > > power, DCS, and display-session operations into HFI commands, together with
> > > the KMS session preparation and CRTC integration required by the bridge.
> > > 
> > > Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> > > Assisted-by: LLM
> > > ---
> > >   drivers/gpu/drm/msm/Makefile             |    1 +
> > >   drivers/gpu/drm/msm/dcp/dcp_crtc.c       |   14 +
> > >   drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c    |   45 ++
> > >   drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h    |    4 +-
> > >   drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c | 1140 ++++++++++++++++++++++++++++++
> > >   drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.h |   69 ++
> > >   drivers/gpu/drm/msm/dcp/dcp_plane.c      |    8 +-
> > >   drivers/gpu/drm/msm/dcp/dcp_plane.h      |    1 +
> > >   8 files changed, 1279 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> > > index e7d24be72113..9910bd4f306d 100644
> > > --- a/drivers/gpu/drm/msm/Makefile
> > > +++ b/drivers/gpu/drm/msm/Makefile
> > > @@ -72,6 +72,7 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
> > >   msm-display-$(CONFIG_DRM_MSM_DCP) += \
> > >   	dcp/dcp_crtc.o \
> > >   	dcp/dcp_dpu_kms.o \
> > > +	dcp/dcp_dsi_bridge.o \
> > >   	dcp/dcp_hfi_core.o \
> > >   	dcp/dcp_hfi_crtc.o \
> > >   	dcp/dcp_hfi_dsi.o \
> > > diff --git a/drivers/gpu/drm/msm/dcp/dcp_crtc.c b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
> > > index ede81881d495..fb8920d44f8a 100644
> > > --- a/drivers/gpu/drm/msm/dcp/dcp_crtc.c
> > > +++ b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
> > > @@ -147,6 +147,12 @@ static void dcp_crtc_atomic_begin(struct drm_crtc *crtc,
> > >   		return;
> > >   	}
> > > +	ret = dcp_dpu_kms_prepare_crtc_session(dcp_kms, crtc);
> > Do you have the session mechanism described somewhere?
> > 
> 
> The session is an HFI display session created with HFI_CMD_DISPLAY_ENABLE.
> DCP requires a valid session ID before accepting destination-ROI,
> plane-property, and frame-trigger commands.
> dcp_dpu_kms_prepare_crtc_session() finds the DSI bridge associated with the
> CRTC and calls dcp_dsi_bridge_prepare_session(). That function opens the HFI
> display session once, stores the firmware-assigned session ID, and publishes
> it to the CRTC.
> The session is then used by the remaining operations in atomic_begin() and
> atomic_flush(). The bridge’s atomic_pre_enable() verifies that the session
> was prepared, while atomic_post_disable() sends DISPLAY_CLOSE and clears it.

I didn't ask to describe it as a comment. I really hope to see some docs
in the driver.

> > 
> > > +			dcp_dsi_bridge_get_mixer_count(dsi_bridge,
> > > +						       &state->hfi_panel_config, mode);
> > > +		state->hfi_panel_config.topology_enc_count =
> > > +			state->hfi_panel_config.topology_mixer_count;
> > > +		state->hfi_panel_config.topology_intf_count = 1;
> > No 2:2:2 support? Can we just drop DSC support for now and add it later?
> > 
> 
> The current series supports a single DSI output with one encoder and one
> interface. It does not support split-pipe or 2:2:2 topologies, will be added
> separately.
> DSC support cannot be removed from this series because the Hawi MTP test
> panel requires DSC. DSC is part of the panel/DSI configuration and is

That's a hardware problem. Use a different panel for the initial
validation, then add the DSC support on top.

> independent of split-pipe or 2:2:2 resource allocation.
> This series establishes the basic topology and HFI/DRM plumbing needed to
> validate the DCP KMS backend. A follow-up will add dynamic mixer, encoder,
> and interface allocation, including 2:2:2 and other split-display
> topologies.
> 

-- 
With best wishes
Dmitry
