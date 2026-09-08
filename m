Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570CC492E21
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908728; cv=none; b=YleRR9OWlQU0FQFNQVqR6FL5LlsHRQl/a/5gcrObzzA7u/Hu4mnRAUOCz9BYNSOKqLIyIsIKA2nYCK6XG6+QZBiwMqY+rm9Y/TomolPeLo5GopeF4d77CLLBNb5kHfvWDttcJPNn+mIyC9OO14XkFkyeplu7g/DdzI7Tq1vAMpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908728; c=relaxed/simple;
	bh=Uy/e3pYwP42TDDIvFNQ90B89CTw2CPnfTxb4AAbQsCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ky9+WqsiLY7o8LlFo9uSEnQE8JMcF1JBy2A4aaXG3V+/JeacnDR1cNXCLmjxqeG17Yf1X4TZTxM/K9LXyrm+g1RpBLGmlonEAQm2DoE48oh+hgoQdU5YDEHj2pjdq3uJIyt1wrPMb8DL8sP+r1NDHRQtb78RtZe7UAnfFISkIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hmzqmxQ4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KS9h4Mcl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hmzqmxQ4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KS9h4Mcl"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688MgEHt045456
	for <iommu@lists.linux.dev>; Tue, 8 Sep 2026 23:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/GhhHa8OWdtOiPSMUGlb1pW6jJlr+86zcpdLSW1zB4c=; b=hmzqmxQ42BEaEeVT
	IvNKp7PG5jp6hEdrg0XvJzRNv5f6ND/AmKEpWuGd/N5xmhEiJASv/TWngbjQAqzh
	7gCMVK4IQCk3Z8PBOM9Xh6ZkGqqHV+2j+WW8hmFsyWuexQbLjafy+z73SG47xBcX
	vAuyJtWjOgbFifUvlCB9tSXi3R81jy9c33TvL6BpYJg1M5iS8RVvdpjCRTLvPoGl
	UTPT/0dCwtgWp67I0l7aZZViLCVvM+LgN6AZrRF27MyKSN3vxxEiJYL0VbzAGnSO
	R/yKHeK5QEM8WyHi7a0gvAdRlAo/n68JhMLAeMoDRwTKEdMroGjl9mbWdW5fYszH
	KQoBtQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqewh48j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 23:05:25 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97e9c9e23d8so3852587241.1
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 16:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788908725; x=1789513525; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/GhhHa8OWdtOiPSMUGlb1pW6jJlr+86zcpdLSW1zB4c=;
        b=KS9h4MclmPJxorhkYwPo3jPVGjaUZ0gWmQkgiNmMAVIHzm6ONt4ED7bNDVxxd5kBcg
         bJM+1pWtUMsiMI227t+uWwAkKDEhAubgvJrIrMaJH+IbTcN9t6rxKZYePRhJ5FkNuSTd
         eVY+FBj4vH2eRi5zOo8fPE3VPPtrmid0DOsd7Fs1GejZvrK41X/2S6Py2rEacXbBurKp
         PdmA2hKyo0DjUAovBeLPifHTnAwzoqplWA/z8stLPHJmv5SfKIAYoT315wdTUeq9bPNZ
         +2D5WhLn+ZTe0oHzHhrJsSwxoJNmx6fl+o3soIBChU6fnmlEq1rMWkhMf+eCqWn4G4lZ
         +8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788908725; x=1789513525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/GhhHa8OWdtOiPSMUGlb1pW6jJlr+86zcpdLSW1zB4c=;
        b=GIIhDGf/26oagsBUvPs1tYvi/rKMTJ9ANENOVOsqf3BV0rWS6Q08EkjG5lyoOWIZyj
         +81fNuJprOc+96OMpXWxizw0ipGKs1H4+ZOCRWjnqkA/DOYYij4Wp50iju7EHVzYpaGi
         tGj/pqqlunEyNLvGILD4hbz+EucMiFwqBbyHukUyRs2CQFZnXszPeBDS9NwSVuH5s7wd
         2SNBetjYUmdOGh4Zui5MTg4QCrmeeCaVYSS05QD0Xo8DkZB/bChtrS01XuY+l3Et2O6r
         7iJLtdHjsWUEsSnckCwf2lFZnlObG/1JLiCt3t0VkTiD5He4ZwjZnL7evABxiQD8JP9p
         TPcg==
X-Forwarded-Encrypted: i=1; AKwUvBxX8xKMEuiEkwltUf9OUE9irfunse/xmBPKuqJ7kayw4rijA/U5/RhWNP+Oppw/0F9W9jdtkw==@lists.linux.dev
X-Gm-Message-State: AFuF++kqhUV3xIbZk6bR5wb/4SthczUcnqAdjhstNIIJxh6HUCk5dZqU
	jU8zO6zO4REtxC2FKiar5Co+eCCjbM0++4Sd8eYb5/0xj0qJ1Eoxlq5XOHzMYun2fXdH1in0tiy
	yQz9BTqwW6IcxQBT+aSUlL6AoqccVCE9XjKjgvjh7VBahFvbyv2MQVpVy4Q==
X-Gm-Gg: AYBFou3W41MQaS3pEQTdzF7Wt8A6HB0/b3XfXgeyI2Dtjd8HHEMXiQpPGvzARgJ3Egc
	4S44dfxm5QpubJlw6l5YLpxDhdfPcuq988I6rU8zmu/MBwfd7X14rFuwtRuc/AaaQLD192w52cZ
	rf7WW5zNv7RiXbrT9m6cwgT9SZW7iJPkq4yLflqxje7qS/vuuH60H/54dwY8cT89PcCnK+mj5bk
	RGQJzOuD2e0AX+9c+H+qsquXQLFUL2PZH9A6CbiHxAq4jwUPaKdhFPkm7UzR80Ve9RrfMJazfz7
	gd1PPtT47f5CI9+bj6cUBB3OJXrrwB6Qd+slv56UZoW6pTb7J7+eSax8VpuisVtYbGih2+1w0hD
	cS8xYyPkScSuwH3k4UiPsu6HAIPO1jNHb8iR/L8YXalWbM929u3Q5ZzBI0C8lX1eAZ7Yn5Q3TlI
	ghW4MTyadYzn7g
X-Received: by 2002:a05:6102:e0d:b0:778:5bbb:b2d2 with SMTP id ada2fe7eead31-78a4a97bda0mr14097735137.11.1788908720226;
        Tue, 08 Sep 2026 16:05:20 -0700 (PDT)
X-Received: by 2002:a05:6102:e0d:b0:778:5bbb:b2d2 with SMTP id ada2fe7eead31-78a4a97bda0mr14097683137.11.1788908719796;
        Tue, 08 Sep 2026 16:05:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a37058669fsm36735161fa.17.2026.09.08.16.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 16:05:18 -0700 (PDT)
Date: Wed, 9 Sep 2026 02:05:16 +0300
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
Subject: Re: [PATCH v2 11/15] accel/qda: Add PRIME DMA-BUF import support
Message-ID: <d4ykcbhd2bqisv47s6hutrpdtlox2aid3j6pkgif6tptivaqkn@tko3tts7hzcn>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-11-69a02e9090d4@oss.qualcomm.com>
 <l7gt2mr3rrnzmkc46ntqw5e5sirdimavv5do4wmdf6jktryp7g@772ovv3qlgcv>
 <c1da4243-36d1-4b65-a5da-f660ab8c63b3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1da4243-36d1-4b65-a5da-f660ab8c63b3@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=cpirVV4i c=1 sm=1 tr=0 ts=6aa094b5 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pwSLSVGh1Xxsrx2JAEcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: RIgOJol6qg7oD3drjZEnlg8WysOkvfv1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDI1MiBTYWx0ZWRfXwHqY49yi/rn9
 XVgLUzCuIz0Qe7rZwIuKxK8rW1C2CRlqfXTvV3arIQtcXKep6kdSrjfm4jGHdtR7b2gRPOFKKM+
 mB0Qi9r9GnSBnbRkufRUCPZpt0U2MuSd1U2VEGoNCyIhkyN1xJsW8Xdz7o0zySXTkxTvwBlnkGW
 q6rtFkIDX0iR66afYq9SOuSTD3scthvQJebmsjlYI6H/q27qDwvCYobEUAlxo1sxvBBtnNTLmcK
 5c8uXSa7xOMHCMGjBSzDVp/Bx1STyBYXkikQX4v3x443x/RiDpLHbbtkEMrTyhIAxY31Pt/aGUd
 sEAAYfN6Swwent/yAW2rUCEXsXWJ2vSSxyCALCwQchJfsRDArjH9hyMR4eo/wwdNb+NVnQ6Hhhr
 H7T+oHlq3m9WDadqzkgZ0sgGJyBzzY9B72hZwQVC4SB+NY9CAjo3KoVobMt4ahjoPGQvNMtXD6o
 l33AS1KkB9egdhvooNg==
X-Proofpoint-ORIG-GUID: RIgOJol6qg7oD3drjZEnlg8WysOkvfv1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDI1MiBTYWx0ZWRfXwFhxYwxlfXIk
 juQL1i3CRyUOYG/1sqjzG0XsmepXyYsbTUL2GqlcgZaP1Y8KinrVncoyLAKzgzuuAdnjxeiNffR
 UIReJZFeE/iNcuHrH4qXOqhXGwpqkZU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080252

On Tue, Aug 18, 2026 at 11:55:50AM +0530, Ekansh Gupta wrote:
> On 18-08-2026 09:25, Dmitry Baryshkov wrote:
> > On Mon, Aug 17, 2026 at 10:17:46AM +0530, Ekansh Gupta wrote:
> >> Allow user-space to import DMA-BUF file descriptors from other
> >> subsystems (GPU, camera, video) into the QDA driver via the standard
> >> DRM PRIME interface.
> >>
> >> qda_prime.c
> >>   Implements qda_gem_prime_import(), which is set as the driver's
> >>   .gem_prime_import callback. On import it:
> >>   1. Short-circuits self-import: if the dma_buf was exported by this
> >>      device and is not itself an import, the existing GEM object is
> >>      returned with an incremented reference count.
> >>   2. Attaches to the dma_buf and maps it with DMA_BIDIRECTIONAL via
> >>      dma_buf_map_attachment_unlocked(), obtaining an sg_table whose
> >>      DMA addresses are IOMMU virtual addresses in the CB device's
> >>      address space.
> >>   3. Calls qda_memory_manager_alloc() to record the mapping and encode
> >>      the SID in the upper bits of the DMA address, matching the
> >>      convention used for natively allocated buffers.
> >>
> >>   qda_prime_fd_to_handle() wraps drm_gem_prime_fd_to_handle() under
> >>   qdev->import_lock, storing the calling file_priv in
> > 
> > Why do you need a separate lock?
> Will add details in commit message,
> The lock serialises the `fd_to_handle → gem_prime_import` call so that
> `current_import_file_priv` is valid for the duration of the import.
> Without it, two concurrent imports could race and each see the other's
> `file_priv`.

What is different from other DRM drivers which can use
drm_gem_prime_fd_to_handle() directly?

> > 
> >>   qdev->current_import_file_priv so that qda_gem_prime_import() can
> >>   retrieve it (the .gem_prime_import callback does not receive
> >>   file_priv directly, but the context bank to attach to is per-process).
> >>
> >> qda_gem.c
> >>   qda_gem_free_object() is extended to handle the imported-buffer
> >>   teardown path: unmap the sg_table, detach from the dma_buf, and
> >>   release the dma_buf reference.
> >>   qda_gem_mmap_obj() rejects mmap requests on imported objects, which
> >>   must be mapped through the exporter instead.
> >>
> >> qda_memory_manager.c
> >>   The DSP is given a single base address per buffer, so only buffers
> >>   that are mapped as one contiguous range can be described to it.
> > 
> > Is there no IOMMU in front of the DSP? Can we remap the buffer to a
> > linear are inside the DSP map?
> The DSP firmware's buffer descriptor format carries a single
> {base_address, size} pair per buffer and it does not support
> scatter-gather or multi-entry page tables on its side. This is a
> firmware interface constraint that we cannot change from the kernel. So
> imported buffers must present as one contiguous IOVA range, and
> non-contiguous ones are rejected.

I think the main part of the question ended up being ignored. Can we use
_IOMMU_ in front of the DSP to make buffer scattered through the
multiple pages to look linear? Or maybe I'm misunderstanding what you
wrote. If I have a buffer spanning three non-contiguous pages PA, PB and
PC, can we still use that buffer with the DSP?

> 
> Will add this information in commit message and during the check.>

-- 
With best wishes
Dmitry
