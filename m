Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC70395DBB
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046600; cv=none; b=gjZ7SVsHDuf6yMyynC2/P50PixeP1KQZ+l2ILqYjZAbfo+Ao/pq325awbhXhKJ0vX6YtgoZgAUsWwL01FKK+mEfgBIdsxdK/PozHcbCuxkra2xiKAAs5ZJTZ/akI6djbllY6CvaTs/8I4xdi7PkwpZX04r7/vJ+PVpAUTyICJ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046600; c=relaxed/simple;
	bh=CzfU35N3pjq6xy3wil9kM7JXhYOUU0JGjdRVEwu0+gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWBoBQKmIYjponkTy06niw4j/KvtDIsxUnWvNI9g/O2aHkQU+3kHYTl55OZIauBchAu4DTCzlSV0arI9W3NMcbYyeBWCBqoleHqPw3LrCFL4eNt07lmUs/TnMA1we4LqSderCz6NRj/UisfhxQD/JBXkGm52deI2clAn3tW9/Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=deEDZpuC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WLuufyuK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="deEDZpuC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WLuufyuK"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PI0JqB806689
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 19:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pZEpDcrfMrqqrHue5nZhulZF
	qXVRR9YBcn3GTIB6GfE=; b=deEDZpuCFaGh0XyjzUZOyK0hDDEqcK6/Q8xviVo8
	f4DzXIpDz6jIg0dOrqEWjiyZRnsRXjZahXaUHgSjcY4hE+0TuOxFb3cIpjlhiWXO
	EMqG//Dmp5K8OiZY04WhLhOxkBHvE5subNv+ebJkQ1fm1PFylogeaaJpjQ/IUbwg
	bmDwBPPzBsfJPH+EXvISMBJQv+U2mQTGNNREV6xK5QiIvITBGx5ahrnC2lj4Ggvf
	kAUHDy6kIjJGD4ae1n9TSz7sNZ16SM27+PDkJmbSnmvPa49Gfc/WVHke683i7+A9
	ULivLKJqK5NlQTiFt9Gbj2lWTyCDeteu1eDJedoBVLLxFA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chr5pawfj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 19:09:57 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb3a129cd2so554366885a.0
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 11:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772046597; x=1772651397; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZEpDcrfMrqqrHue5nZhulZFqXVRR9YBcn3GTIB6GfE=;
        b=WLuufyuKE7YWYdGl7y/JT0JdFuz97BPRQuVPednbZNMonLykMEBFsm9EGTQ1u000ZA
         NpdiMjo0C89/cLufqpvSoHq8pgaWhVyMq2D3mNVYldttWh4ykjWxomFAT/kc/hjA0Zya
         aPi5Zs6Ga9vcfaaDixidgxyxDvoEFudnzIJG4OHPxwCl11tNyYlyGEZc2XHPn6ioxNWA
         UHfZ3qyDqnO9MWzBm90tu9Xw40qHtmdeXAUbftXY4rbBtJfK0xutQkVqt+0xMIOZC/gl
         FiHQcZm/1Ns9eRdxttu6ET4yBAi3bgIguc79JPp1JgXc9mZyW2AxVseeNmBwEM0NqfTv
         mZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772046597; x=1772651397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZEpDcrfMrqqrHue5nZhulZFqXVRR9YBcn3GTIB6GfE=;
        b=egIcwNwV9Ky9kRTv41N1ffen3hCgyTqJlPgP4NrZLIqrnJjABHEpEzbaTeCZPAwtj8
         FqsCeRJvbp36q8MYHEcFLSMz0UiALEiiYBnNzvFFWjOyZKordLHERIwAUljomgypDVl0
         /MgDSWgOpSQ3uAukBVGd7Ceqb4cjUF7ZEHZ6pe8jBuhY61No+5peqaqi3LzHCZbUX7DT
         wt2oPgFut1uKdcslJLEKg95nKiAIlR5Rp61vqpskCq5OwDUXhS4Oq/57/Nud+fvPzoqe
         Nv8Ap+yGEycaM6PHMLwV3dZaRZehup43upMYkukUF11Dc6nT//qwtKbJvkWxhpb2vZoC
         Julw==
X-Forwarded-Encrypted: i=1; AJvYcCU3RhPZXNf4pGhOR/13mi6X+bx6jthuMaPT6or+FFjTmq7t8kG7nFWJOsRPwj0Hgf/zWTso0A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyj0IobygeZG3tzy6Pl6dj7Xfwccdfjqzjjp6z79f8cG/1LF1W3
	Kfq8NVNcEqh7GPxy3gFMxLpD7fdjh877cxUvQoDNBMOr/5vpeaRrL59kbbL9Ugz0tj9xBi+p9YN
	WyxzbxcOKCiJHuAPXBmI+frJrb4k1954urHxpAZfxO+j4D0MZVUPBVnO1/g==
X-Gm-Gg: ATEYQzxeeAdCTzs4HBVH+E7dnNrh8fzgik0R23xxhgpqCzNL0g/yRnXHpR6htotDcuu
	vVin6vjJB+H9XkACyrgCxDAtpDNwBE3ncgasV0QoS6vFMk/WjKvgeYYOtiOI+FldUcAlfiMXns/
	/aMN2kAsWh0VesGXDXp4TmvwgmnO8cu3ONPCthBBi80HXOI9NE/rJ4eVEGk+6w3h6k+BNsWCsv8
	kaRspbjVTTDSy37TaygSSz5B6uqhK3Nm31yYgpdVmKk3/42rrH2Q+cH7HhBzuXjdVfFoQZAVXi1
	1gi3e8KzrWy6UVeolTg/FJhrFvaEGhzpoIAjV/yOdEXGNxwiwvt9bOdFx3i3PF57edPuR8NIY6r
	0vErgOiiPlO2jAcenVse05Yc4ra/Yx9iPJnkBIs/dxCmihmUbpoAEzuoOfZjDr09DHP+8cTMI0E
	eI/xmFHTc40VvtPzb5Vf7p4eaDjZTBxs/RS+c=
X-Received: by 2002:a05:620a:4451:b0:8cb:4d46:7a6e with SMTP id af79cd13be357-8cbbf3658dfmr20931085a.10.1772046597005;
        Wed, 25 Feb 2026 11:09:57 -0800 (PST)
X-Received: by 2002:a05:620a:4451:b0:8cb:4d46:7a6e with SMTP id af79cd13be357-8cbbf3658dfmr20924285a.10.1772046596434;
        Wed, 25 Feb 2026 11:09:56 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a7a1fcb1sm30525601fa.27.2026.02.25.11.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 11:09:55 -0800 (PST)
Date: Wed, 25 Feb 2026 21:09:53 +0200
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
Subject: Re: [PATCH RFC 04/18] accel/qda: Add built-in compute CB bus for QDA
 and integrate with IOMMU
Message-ID: <x6zseuf7g3ngtdlszf3vxj3nqexlkbtrp5kifo4tg4muzdef4n@5rngfg4gu47m>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-4-fe46a9c1a046@oss.qualcomm.com>
 <ox7jnqkjo3frhbgpp63sse7ram72obihe4qlbbn4z22wbw4szr@7pzoeecdvsyg>
 <e82443ff-f6c1-4b8e-b573-f4620dd0f17c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e82443ff-f6c1-4b8e-b573-f4620dd0f17c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE4MCBTYWx0ZWRfX2fZ21J+A2QtF
 KGejSTkp1LTFkojq/Bg44pPs0gRA5E0ZybhI+oBAci3Nzvgd7JPH26a5IYkOJ3i2YRI4QDvx3jE
 2RxEEvhlJwOlH6aRkDPUFTysezcTG25s5oFGZUc/3MsXn9rfeoV/Jm2VUmcLfZaBmmyjI51yotk
 yQ3XTPaJD4WU4R4ZgcttYjPGakp14C0SRiduHsy5SdUD8hbf57TB+nIvefhEHEpVEBcOmADqz/e
 RamKmfZB7r0USBXDUiobmAn+5RjzYxPrJ587yCVaRLj+IPU/20SFKK1vv7RKRDxqIOWi1C1hUqs
 sVW8Bthbl9AqXhLwReGuJLb/Jhb0DNHADgDEZpR9i2yj1xhM2MyD8RPo+4C1YH3A+DHv6z3d5yf
 w6RSfFpvlmaV7TJmjMV5VJMZYAqwDoF33CZHOrXpQzir8/nrW46cT7cmI71u4NzGqvy/Auu/x+a
 zshHFgiWgNPA9IzraDA==
X-Authority-Analysis: v=2.4 cv=GstPO01C c=1 sm=1 tr=0 ts=699f4905 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=yBEyVpS31OZj4jLVKcoA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: L2X0L9ypPSgIJfv8-5BWbP0A7iLLW6GL
X-Proofpoint-ORIG-GUID: L2X0L9ypPSgIJfv8-5BWbP0A7iLLW6GL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250180

On Wed, Feb 25, 2026 at 11:26:52PM +0530, Ekansh Gupta wrote:
> 
> 
> On 2/24/2026 4:14 AM, Dmitry Baryshkov wrote:
> > On Tue, Feb 24, 2026 at 12:38:58AM +0530, Ekansh Gupta wrote:
> >> Introduce a built-in compute context-bank (CB) bus used by the Qualcomm
> >> DSP accelerator (QDA) driver to represent DSP CB devices that require
> >> IOMMU configuration. This separates the CB bus from the QDA driver and
> >> allows QDA to remain a loadable module while the bus is always built-in.
> > Why? What is the actual problem that you are trying to solve?
> Bus needs to be built-in as it is being used by iommu driver. I'll add more details here.

It's an implementation detail. Start your commit message with the
description of the issue or a problem that you are solving.

> >
> >> A new bool Kconfig symbol DRM_ACCEL_QDA_COMPUTE_BUS is added and is
> > Don't describe the patch contents. Please.
> Ack.
> >
> >> selected by the main DRM_ACCEL_QDA driver. The parent accel Makefile is
> >> updated to descend into the QDA directory for both built-in and module
> >> builds so that the CB bus is compiled into vmlinux while the driver
> >> remains modular.
> >>
> >> The CB bus is registered at postcore_initcall() time and is exposed to
> >> the IOMMU core through iommu_buses[] in the same way as the Tegra
> >> host1x context-bus. This enables later patches to create CB devices on
> >> this bus and obtain IOMMU domains for them.
> > Note, there is nothing QDA-specific in this patch. Please explain, why
> > the bus is QDA-specific? Can we generalize it?
> I needed a custom bus here to use for the compute cb devices for iommu
> configurations, I don't see any reason to keep it QDA-specific. The only requirement
> is that this should be enabled built in whenever QDA is enabled.

Why? FastRPC uses platform_bus. You need to explain, why it's not
correct.

> 
> But if I keep it generic, where should this be placed? Should it be accel(or drm?) specific?

drivers/base? Or drivers/iommu? That would totally depend on the issue
description. E.g. can we use the same code for host1x?


-- 
With best wishes
Dmitry
