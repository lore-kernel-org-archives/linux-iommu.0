Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6263AFCF2
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787032329; cv=none; b=EIvt5hlKJyHWzeST4Wrp/gNDqe0apT8GfQPrvv0nm/BxGQqyYcaAbHYTKyymwZmtnuqcIWK1aV0/de8ch7KluSEccvLFw5WCKIg76bE0Y7raBGHtYfslv+PdVNQr66I6qSRelQG7mYDcTdHDohwmj8SSlgKq6QIkceaOV37IQZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787032329; c=relaxed/simple;
	bh=t7zqK2kfTIdM7DeJsFj7PjMFIgkgpjQMOw5BoqQOa/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxV3bbr340l6XGO6D7CvSgLlQIacZbUFrzXLkI2TspWkW1chKDQRLd0C3ZbZan8Nzztr9BRcZS4/KKB3KV/RN52S8hfw+ECywq4mBN45Twu2KdM7qdoyIXFKbCQ8p1vxJPcrFhiclqCiEOVRy+/mT5GKfFgDcnViAwLYjIkU/V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DMcr0RWQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ffDPu5nc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DMcr0RWQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ffDPu5nc"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I12LQI297691
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 05:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9MGPW6/DK7pn6fKMqjuLg89wJJuJK8oCiXQggTwY6zk=; b=DMcr0RWQv+aJkxOq
	gUbCjFe3NzYI3OjesOMkpzJTRXBjrRxwtH6VVpZBWH95TK5T4AdoohWTSaY/Pe+J
	7tE2qg49EPqjakmV9X+lzItNlEm7Ty55bS8kqEOEnwYgmz+Q+l/A0UzCX8B3sPM9
	sDLkI41D8h8nuCTY9rYTbpOgu6mrJUSjA2Qvflpzd0evQ7B++9d1DY/3qUvCF6bu
	zrx997uDw6q4U81ym76aIR6FRJo8UnMBeBbxrACpSQDKGrchomzeg+g28RME5jk8
	9ksRJuowsPPRozywktrveZAJuq887VPVTCAA2SLmyqcwqlWkg94kKRxXskHAGgDH
	aayzoQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4dcn12tr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 05:52:06 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8487ed7f7beso4311949b3a.0
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 22:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787032326; x=1787637126; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9MGPW6/DK7pn6fKMqjuLg89wJJuJK8oCiXQggTwY6zk=;
        b=ffDPu5nc7CgndaIz1QcuvdN5+VOOA4MGtOGRuucHflcR7Hk3maD/BhbZyd1/5L42kQ
         NzA2ks77FhbKvEphI4PesLgDHonYJxBKuutbmLFNApYavH3o6LXyGSizPuRRbYvHiSTy
         I5liFJqXU6GI/i+V0DD0rcBJ1kt+T7t5G+6/oCv6d37M9p/LRGYUj34aZQthc16uAnEY
         NFdiO34ncCQ7/PtJMNhInUhpa0WP+8xKL/ifBaYzQT8t2c4zcBo+YcZqhjf7adcOatV5
         sH6UK7Ysi2YLWwP5jrbf/nWnbdhPzcPCc8X6HfsVONXWhrifbEdIjnw+o9ntOqDJaYME
         ORQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787032326; x=1787637126;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9MGPW6/DK7pn6fKMqjuLg89wJJuJK8oCiXQggTwY6zk=;
        b=iuZMJ6C7l0y7So4NAkhsGJueIubmd+16wjmmLpA3n5iEGFAxzlsbGkD14b1wy361+g
         lA6fqysIRgCZh+9e/L/42DlSF5+KyNe5LBFD7cM28em2UUE1KSnBWw/0SkhXen4IgdAd
         Kfc4SphL1TMaO3ifAETNgPq25F9ri+aQMiy9MySiuLNaSvtq77mHvJEg8UxzWjQ69SDs
         yKjum4AK9O+QZz2E8rZaRXi5zSXsyjL+0+zWZ/sRyhUUo+Jusb5voJidm8sXnFMKdtKj
         /zTws5S9TAkwVttBjNgnGZ20gz22dNRDZ5yLzirCeMopbXReA99L0MloCDkwRJphBVEB
         9Oxw==
X-Forwarded-Encrypted: i=1; AHgh+RrDauzIEaABzaGZ3micjbmKQlMXgu1UBnuusOqNQtgtmOpSITf2I8aP4VTahd63Dfg9lOL1fw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4MMqCoWveZ2SWMnGdH59IWU7LOfg3uEYYE7jfW6tsMSkGCeny
	T2sR0/EeLUjE1ysUramtqFDXfgRRbBRhSUHuT5iHxX0AZb+yKNLvUzR85mev12w7HnzpKsMNqx1
	ZOIsn3sHWYBS9+9M2P0zMy+wkjOBJVFWN+0OLjeqHd0j4hdT9ADg+L8KImw==
X-Gm-Gg: AR+sD122c31kHnbe1HPzYaH8YgqFk5udqb+eRqRn0P/eL4LKuHfm5cPHe1Xg2mRimuE
	/vXKUiqA2O4aYhLN44cH7JmtaFIQfNx3ZQ/+kF1i7He1ljKn1+XSvYaLyT941pK1Fniul9bD83R
	ljT730vBgWVJqE9BVqMKd8US1ByisFSZzFHoJw/EuJb8TQynRCAlTPHjcTvyWQMwwEbUHDXTDif
	vKEcqfYw3wMyeVqu/FGuqLnxFnGV1D9a43Qads7cVfgK70pelmfkUeT+MXQmowUx32CO1aLFYAA
	Apv7uHI9zLBkOr6cgqMzdXs6CDOuQtZ+NscJ+IOHQyBbQJps5Miri1Zu5P4K3IvNPCn2/0lvzuB
	84OaUbNWtmZ1QAHfIiYZ7x+MiZhZrng==
X-Received: by 2002:a05:6a00:4395:b0:845:31a6:d84d with SMTP id d2e1a72fcca58-84fde14ffecmr33705031b3a.7.1787032325957;
        Mon, 17 Aug 2026 22:52:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:4395:b0:845:31a6:d84d with SMTP id d2e1a72fcca58-84fde14ffecmr33704931b3a.7.1787032325493;
        Mon, 17 Aug 2026 22:52:05 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b4072c39sm1284034b3a.26.2026.08.17.22.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 22:52:04 -0700 (PDT)
Message-ID: <2d092339-a691-4539-8419-c9606ea35f68@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 11:21:55 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] accel/qda: Add DMA-backed GEM objects and memory
 manager integration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap
 <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling
 <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
 <g3dkltejtlzrrelv77kjteqbkny6vhedyuet7d6b2p7yfix3ys@sop7vjvpdvzb>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <g3dkltejtlzrrelv77kjteqbkny6vhedyuet7d6b2p7yfix3ys@sop7vjvpdvzb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: v4o6CEx8_slfK1tgQwv6bbyDhP4tltEZ
X-Authority-Analysis: v=2.4 cv=Gs5yPE1C c=1 sm=1 tr=0 ts=6a83f306 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=U_ymhupkC0DnaqHl0NQA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: v4o6CEx8_slfK1tgQwv6bbyDhP4tltEZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0MiBTYWx0ZWRfXyehkXd87SNY1
 I/EjSa8Jy9Ywz7d3M3seGKZIS60IOPnbdRyOX1CjLibVy1rCbkb5+uZtZTeNhZBb5ITrw1LNzkg
 HSvp5UT1j2n5ZaFt9ukD93crCeXMX7RZTrWjs9qsnnTtVqaf4FsS0Pd3atYIRdYZtyC4iEuIrC8
 Kgufge5ylq3BLgPgH1PxqTU4NcHX5xlxErjn12AOL2qRJcif9HXH+6nxDwaPTduVE8aTIEgV11r
 Us1bsmGm6ezfZymoHshiPO4S1/bio0EXboHaJKQSdQdGOHg7/Pv15fmw1WGpLdZJyaEX6Kee7Nn
 fi2lPskRCepx3iGI8Gezt6SUM3EKSIbE159myFrUbY8Qso5a0SAvmmt6u9QncRmLTHIRoEadJhj
 aO5a8nNsh9mJYNYJ7/yMsYfK9Kw0+kb5pTG7fQGu+BTYgp0B3dK8T3nO0NUgpmiMuLuS/PQrIU9
 qIN6MuJHtZMfUsge3sw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0MiBTYWx0ZWRfXzJ3+aAuWGdFt
 9hgCAKXVEatp/ksWrJgvyLbnp1plSZwED2wXHNxEgjdF6mPCFEqkLMYVByv1zfviSmjZKJxZHDC
 JXfYUvMyRcGMgyztjTe+bxIM8c77/PE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180042

On 18-08-2026 09:12, Dmitry Baryshkov wrote:
> On Mon, Aug 17, 2026 at 10:17:44AM +0530, Ekansh Gupta wrote:
>> Introduce DMA-coherent buffer management for the QDA driver, wiring
>> together the GEM subsystem, the IOMMU memory manager, and a DMA
>> allocation backend.
>>
>> qda_gem.c / qda_gem.h
>>   Implements the GEM object lifecycle for QDA buffers. Each buffer is
>>   represented by a qda_gem_obj which embeds a drm_gem_object and
>>   carries the kernel virtual address, DMA address, and a pointer to
>>   the IOMMU device that performed the allocation. The .free callback
>>   delegates to the memory manager, and the .mmap callback uses
>>   dma_mmap_coherent() via the DMA backend.
>>
>> qda_memory_dma.c / qda_memory_dma.h
>>   DMA coherent allocation backend. qda_dma_alloc() calls
>>   dma_alloc_coherent() on the CB device and encodes the stream ID
>>   (SID) in the upper 32 bits of the returned DMA address, following
>>   the Qualcomm FastRPC convention for IOMMU address space tagging.
>>   qda_dma_free() strips the SID prefix before calling
>>   dma_free_coherent().
>>
>> qda_memory_manager.c
>>   Adds process-to-device assignment: each DRM file (process) is
>>   assigned one IOMMU context bank device for the lifetime of the
>>   session. qda_memory_manager_assign_device() first checks whether
>>   the process already has a device (reusing it with a refcount
>>   increment), then falls back to claiming an unassigned device.
>>   qda_memory_manager_alloc() and qda_memory_manager_free() delegate
>>   to the DMA backend after resolving the correct CB device for the
>>   calling process.
>>
>> qda_drv.c / qda_drv.h
>>   qda_file_priv gains an assigned_iommu_dev pointer and a pid field.
>>   The .postclose callback decrements the IOMMU device refcount and
>>   clears the process assignment when the last reference is dropped.
> 
> This provides a nice summary of the patch, which is pretty useless.
I'll fix this for all patches.> Please teach your AI instead to describe
the reasons and the design
> decisions instead of just assessing what the code does. Why do you need
> memory manager? Why can't you use existing GEM helpers?
I'll add more details for this in commit message:
The DSP requires each buffer's DMA address to carry the stream ID of the
context bank that owns it (SID << 32 | IOVA). The memory manager tracks
which CB is assigned to which process and ensures all allocations for a
process go through that device.

`drm_gem_dma_create()` and friends allocate from `dev`, the DRM device
itself. QDA needs to allocate from one of N child CB devices (each with
its own IOMMU domain), selected per-process. There's no existing GEM
helper that takes a per-allocation device argument.

//Ekansh
> 
>>
>> Assisted-by: Claude:claude-sonnet-5
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Adapt to the dynamically-sized device array introduced in patch 07
>>   (kcalloc'd from DT node count, replaces fixed QDA_IOMMU_DEVICES_MAX)
>> - Protect register/unregister with the process_assignment_lock mutex so
>>   the device-assignment and device-registration paths are serialised
>> - No functional changes requested by reviewers on this patch
>> ---
>>  drivers/accel/qda/Makefile             |   2 +
>>  drivers/accel/qda/qda_drv.c            |   4 +
>>  drivers/accel/qda/qda_drv.h            |   4 +
>>  drivers/accel/qda/qda_gem.c            | 134 ++++++++++++++++++
>>  drivers/accel/qda/qda_gem.h            |  52 +++++++
>>  drivers/accel/qda/qda_memory_dma.c     |  82 +++++++++++
>>  drivers/accel/qda/qda_memory_dma.h     |  17 +++
>>  drivers/accel/qda/qda_memory_manager.c | 239 ++++++++++++++++++++++++++++++++-
>>  drivers/accel/qda/qda_memory_manager.h |  30 +++++
>>  9 files changed, 559 insertions(+), 5 deletions(-)
>>
> 

