Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D8E36682C
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773043650; cv=none; b=Qhq3fzSW8K8hyK4n0Eju6IP8Lf9nPIYYD591/BqC3kwQyI3Frxnpc8b/c0KML0XVcAARuJGVfSyNjqgYHh+r5PA0cTXhN8ObQCSbk2SVXw6KV16a6PzqpTelhAQzejKvnb2w+ekGRt8fXedenwLcAr/hymd8C6uOyGJ0E4ogIzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773043650; c=relaxed/simple;
	bh=kntNWSGlN2lfw8IJnX2yG7u1Fal1fKrnwQobK1CyP4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdUTI/rWFGldmFd32dvNBCL6C7p/bZ8MdYmlj2fg54OkctalXSp2IDvdY5AJHbw1t9c5bcUXiPuR7LjKqBK80Z8/3/WjmOCqw1jHmBaxRZPfYlBhXF2AZUQx7j8T8ZQcf7gnB1fw2TeHEyqaM/CjeFb64w1GKivRSTsXMqmZi5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cuAMJwsD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bCe9juNH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cuAMJwsD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bCe9juNH"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6294nLUn1968932
	for <iommu@lists.linux.dev>; Mon, 9 Mar 2026 08:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+eohagC17wyTUw9Qrm49C+RUGjm3ynIkPUJ2iQskYLo=; b=cuAMJwsDq3of/1MR
	Xrhe2whXDqiq8iwzw5TYlQexS2I7eDEfJfkx3+XqQkiAkhyNEOhj2yEizDVG2Jpd
	Z/5/mYA2Lanw2Mur89hq055gW8i+dsi51l/rJ3fK9Jlt+EJ+jZA06L0b85VjRm9w
	lEi9TefGDQ1PxwpTLTa9wLYA+5ktH/xT29a2cgXVqnjCuobHhK5H8vwZ8IvW4tC5
	KafZKIjzRN5g7QNhRXGuKXkG1rrxv4/N/KJTkK8bfAW1UXxRiawFO4f79RKD4jA8
	lSvRMhYa8az1Gq4q6XQ04SbC/3F40G62j4Wbm6O4Y39fGyZHkcHpKTue9xTisPv3
	/AwN1Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crayrmm0y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 08:07:28 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso11115695a91.0
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 01:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773043648; x=1773648448; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+eohagC17wyTUw9Qrm49C+RUGjm3ynIkPUJ2iQskYLo=;
        b=bCe9juNHutXMbZfsnmvvolxQdIA+BWX3YPyWVeanBesdki20YG4VXADW5letB+RaKJ
         w4Bi/sPooBZQhO/UOfaBUQQghP9XX84nHZB3N+0BQnjcMWPdMrspTBQKxSAJHwdBemZt
         owV9NrLIo6y2dr2MYIdM86jo+Lq6H4uTRnxzWWbuiYZ9DhLCs6JPBjWKd5O2PtKt4SDO
         Zoe1RQ8wscA1p5NzrHaHzpbcGJnrPvEm1PSeLBQAMVM5RCdIV931Q4hwBk1pZ2kHBigh
         698gk+l4cjz7PfAKzoTARxQcC2Cw9qcnwqq2f1xIUgIaQ09OSoI0G5vsfa8hOD6ffCcw
         a63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773043648; x=1773648448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+eohagC17wyTUw9Qrm49C+RUGjm3ynIkPUJ2iQskYLo=;
        b=uCZXgVWWXETXCp+YmqpOK3b7rU+pgOSwr/AmMangVN34ohtF8U8xMSNlngAGoViAJ0
         IPIKPhgANa0ZuXIut2Lnt/cICuZfnOyZYwvbzl0JwGg1oAf8A1b4DphQ9EmQ9wHYqTrv
         QUfGqMeGTYlxAYTm/NjsNo+stmoUSodkhGX2TyJdSdzmLgu6xmCcMycceftKQvCQbux9
         2x/4uPKU+00fW+d9ZnF1GjQVlA6ScXFDe9MNgzadWL5RJ4X1oIFA3RU2pTvoWPa5TilW
         h6vNH8zUS8fYKRRkwbhNSppVypPdugdiA+OVKBsusfBWCjZTcmDDFFdJnZGdTJpTFiJe
         Ia5A==
X-Forwarded-Encrypted: i=1; AJvYcCVrdKy/ZhBFOk624eJBkpaykmD4J34VIMzxH097o74O2VhqgZFtPEkxsHWDo0Bwe9YvLH1mlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZsiWzYHV9nHqKr45lZG/atpuEmj/1FHDUVWvIWhThEyzLpw05
	i0hQFp1lnostsM2pLFvO6FHH/qOAZw0MtZp5fuIka5Rid7OtkXgqDqAyuao2mZTz4tepqoTUWHE
	CT8Td76zxMkyL6WgCtfwOVYuBbvgr2pAy9Uofq0IGABN1yzz+5poRyfM4dg==
X-Gm-Gg: ATEYQzz1WtCxMFWjCM/4jmHb3gWsmCXTqWRMvLIy75xJOvelUxWHCBj36gcbOgar68t
	nYutlx7wkKImq/60aCJI92WfTSnndX5gL+LCi3dQCM9TpaKbefQ/Q1gDL4G9ZJs1xROFTkGFNNp
	nfRihgVunt4v84ZXHg+75eT2njzCcTRC5l0oI4xcbov59D969jaC5N3Ue4RsPfstd1JwwK6IXal
	GGYA93bxf655b2cLWoaGlGNl3VBtoy69n78uOix/zpF1zEwD7uwJEIVEKln+qU2AaLv0ff1zfry
	PAG18SUKoshbj8C6wAS4no/Eq79SHGikcJMLaij0m1rMuIT+WHS3qZljqfP6WeHH0LPa8SBQkmO
	ToGDcvi7r9+7iSatYhYeHyX9nUsSf0a0LZq2+u9pIE1eoiJ+k7A==
X-Received: by 2002:a17:90b:498b:b0:359:8dfd:64c8 with SMTP id 98e67ed59e1d1-359be34f6a3mr9759158a91.24.1773043647516;
        Mon, 09 Mar 2026 01:07:27 -0700 (PDT)
X-Received: by 2002:a17:90b:498b:b0:359:8dfd:64c8 with SMTP id 98e67ed59e1d1-359be34f6a3mr9759131a91.24.1773043646911;
        Mon, 09 Mar 2026 01:07:26 -0700 (PDT)
Received: from [10.206.99.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f74e4fsm108035235ad.58.2026.03.09.01.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 01:07:26 -0700 (PDT)
Message-ID: <f7b789c9-052f-4b5d-89e8-59dceda6b847@oss.qualcomm.com>
Date: Mon, 9 Mar 2026 13:37:18 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/18] accel/qda: Introduce Qualcomm DSP Accelerator
 driver
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=U5qfzOru c=1 sm=1 tr=0 ts=69ae7fc0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=D19gQVrFAAAA:8
 a=9DV_eOp41SfxLb3a3r4A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-ORIG-GUID: D_gZyxqKmPVriio6A7jDEt63Ce0qMYbM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA3MyBTYWx0ZWRfXzfPhSOMEW17p
 XaayC6plZFFggvZNYo9km+WTGRhTpggfDJK6T7vEVxRnEjjliRKvhDWuEQnt1wQuPTtsXsbZvMe
 luoCflIhvGnRrDXUudnlQAOD4Y3vhq2M28mvboRw8ZupDI09VWYMuqJMbjJn5DcujMco4b9QhX2
 PPH9HCVKUKHupA9/lXU2uTVi8StL2qSbfSQbg9v8MhaS4u+BFwgvSyLb8ygW3UXPodN4nD8Ra/d
 089cuNR6GmLy4woE0fHL8ho0xsdrXhLsgT9tAAKvyrD2wfCa8PmFQWXmGxRzKQ+0llhaGs/GKWo
 GHtL+2EYZiFzwwyXBBzxvI15QEi3Y40r21X8qtDJs/uk7fxeDHT3eEWP2SIKhxud2ZRYgTPsnUL
 YIDhdsDLU01d3eVXXUqXlsqSUDd1SeaoJhgVtoPMo/TZfcYczxAUxgrUsi+cZ2Wv6UgZvxmWd85
 V1Kq5ANZp7lmm/QsaMg==
X-Proofpoint-GUID: D_gZyxqKmPVriio6A7jDEt63Ce0qMYbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090073



On 2/24/2026 12:38 AM, Ekansh Gupta wrote:
> This patch series introduces the Qualcomm DSP Accelerator (QDA) driver,
> a modern DRM-based accelerator implementation for Qualcomm Hexagon DSPs.
> The driver provides a standardized interface for offloading computational
> tasks to DSPs found on Qualcomm SoCs, supporting all DSP domains (ADSP,
> CDSP, SDSP, GDSP).
>
> The QDA driver is designed as an alternative for the FastRPC driver
> in drivers/misc/, offering improved resource management, better integration
> with standard kernel subsystems, and alignment with the Linux kernel's
> Compute Accelerators framework.
>
> User-space staging branch
> ============
> https://github.com/qualcomm/fastrpc/tree/accel/staging
>
> Key Features
> ============
>
> * Standard DRM accelerator interface via /dev/accel/accelN
> * GEM-based buffer management with DMA-BUF import/export support
> * IOMMU-based memory isolation using per-process context banks
> * FastRPC protocol implementation for DSP communication
> * RPMsg transport layer for reliable message passing
> * Support for all DSP domains (ADSP, CDSP, SDSP, GDSP)
> * Comprehensive IOCTL interface for DSP operations
>
> High-Level Architecture Differences with Existing FastRPC Driver
> =================================================================
>
> The QDA driver represents a significant architectural departure from the
> existing FastRPC driver (drivers/misc/fastrpc.c), addressing several key
> limitations while maintaining protocol compatibility:
>
> 1. DRM Accelerator Framework Integration
>   - FastRPC: Custom character device (/dev/fastrpc-*)
>   - QDA: Standard DRM accel device (/dev/accel/accelN)
>   - Benefit: Leverages established DRM infrastructure for device
>     management.
>
> 2. Memory Management
>   - FastRPC: Custom memory allocator with ION/DMA-BUF integration
>   - QDA: Native GEM objects with full PRIME support
>   - Benefit: Seamless buffer sharing using standard DRM mechanisms
>
> 3. IOMMU Context Bank Management
>   - FastRPC: Direct IOMMU domain manipulation, limited isolation
>   - QDA: Custom compute bus (qda_cb_bus_type) with proper device model
>   - Benefit: Each CB device is a proper struct device with IOMMU group
>     support, enabling better isolation and resource tracking.
>   - https://lore.kernel.org/all/245d602f-3037-4ae3-9af9-d98f37258aae@oss.qualcomm.com/
>
> 4. Memory Manager Architecture
>   - FastRPC: Monolithic allocator
>   - QDA: Pluggable memory manager with backend abstraction
>   - Benefit: Currently uses DMA-coherent backend, easily extensible for
>     future memory types (e.g., carveout, CMA)
>
> 5. Transport Layer
>   - FastRPC: Direct RPMsg integration in core driver
>   - QDA: Abstracted transport layer (qda_rpmsg.c)
>   - Benefit: Clean separation of concerns, easier to add alternative
>     transports if needed
>
> 8. Code Organization
>   - FastRPC: ~3000 lines in single file
>   - QDA: Modular design across multiple files (~4600 lines total)
>     * qda_drv.c: Core driver and DRM integration
>     * qda_gem.c: GEM object management
>     * qda_memory_manager.c: Memory and IOMMU management
>     * qda_fastrpc.c: FastRPC protocol implementation
>     * qda_rpmsg.c: Transport layer
>     * qda_cb.c: Context bank device management
>   - Benefit: Better maintainability, clearer separation of concerns
>
> 9. UAPI Design
>   - FastRPC: Custom IOCTL interface
>   - QDA: DRM-style IOCTLs with proper versioning support
>   - Benefit: Follows DRM conventions, easier userspace integration
>
> 10. Documentation
>   - FastRPC: Minimal in-tree documentation
>   - QDA: Comprehensive documentation in Documentation/accel/qda/
>   - Benefit: Better developer experience, clearer API contracts
>
> 11. Buffer Reference Mechanism
>   - FastRPC: Uses buffer file descriptors (FDs) for all book-keeping
>     in both kernel and DSP
>   - QDA: Uses GEM handles for kernel-side management, providing better
>     integration with DRM subsystem
>   - Benefit: Leverages DRM GEM infrastructure for reference counting,
>     lifetime management, and integration with other DRM components
>
> Key Technical Improvements
> ===========================
>
> * Proper device model: CB devices are real struct device instances on a
>   custom bus, enabling proper IOMMU group management and power management
>   integration
>
> * Reference-counted IOMMU devices: Multiple file descriptors from the same
>   process share a single IOMMU device, reducing overhead
>
> * GEM-based buffer lifecycle: Automatic cleanup via DRM GEM reference
>   counting, eliminating many resource leak scenarios
>
> * Modular memory backends: The memory manager supports pluggable backends,
>   currently implementing DMA-coherent allocations with SID-prefixed
>   addresses for DSP firmware
>
> * Context-based invocation tracking: XArray-based context management with
>   proper synchronization and cleanup
>
> Patch Series Organization
> ==========================
>
> Patches 1-2:   Driver skeleton and documentation
> Patches 3-6:   RPMsg transport and IOMMU/CB infrastructure
> Patches 7-9:   DRM device registration and basic IOCTL
> Patches 10-12: GEM buffer management and PRIME support
> Patches 13-17: FastRPC protocol implementation (attach, invoke, create,
>                map/unmap)
> Patch 18:      MAINTAINERS entry
>
> Open Items
> ===========
>
> The following items are identified as open items:
>
> 1. Privilege Level Management
>   - Currently, daemon processes and user processes have the same access
>     level as both use the same accel device node. This needs to be
>     addressed as daemons attach to privileged DSP PDs and require
>     higher privilege levels for system-level operations
>   - Seeking guidance on the best approach: separate device nodes,
>     capability-based checks, or DRM master/authentication mechanisms
Hi all, I'm seeking guidance for this open item. I wanted some conclusion on this before
I send out the next version. This requirement is because any malicious application should
not attach to privileged DSP PDs and it's might impact the functionality of the PD by not
providing proper file-operation framework.
>
> 2. UAPI Compatibility Layer
>   - Add UAPI compat layer to facilitate migration of client applications
>     from existing FastRPC UAPI to the new QDA accel driver UAPI,
>     ensuring smooth transition for existing userspace code
>   - Seeking guidance on implementation approach: in-kernel translation
>     layer, userspace wrapper library, or hybrid solution
>
> 3. Documentation Improvements
>   - Add detailed IOCTL usage examples
>   - Document DSP firmware interface requirements
>   - Create migration guide from existing FastRPC
>
> 4. Per-Domain Memory Allocation
>   - Develop new userspace API to support memory allocation on a per
>     domain basis, enabling domain-specific memory management and
>     optimization
>
> 5. Audio and Sensors PD Support
>   - The current patch series does not handle Audio PD and Sensors PD
>     functionalities. These specialized protection domains require
>     additional support for real-time constraints and power management
>
> Interface Compatibility
> ========================
>
> The QDA driver maintains compatibility with existing FastRPC infrastructure:
>
> * Device Tree Bindings: The driver uses the same device tree bindings as
>   the existing FastRPC driver, ensuring no changes are required to device
>   tree sources. The "qcom,fastrpc" compatible string and child node
>   structure remain unchanged.
>
> * Userspace Interface: While the driver provides a new DRM-based UAPI,
>   the underlying FastRPC protocol and DSP firmware interface remain
>   compatible. This ensures that DSP firmware and libraries continue to
>   work without modification.
>
> * Migration Path: The modular design allows for gradual migration, where
>   both drivers can coexist during the transition period. Applications can
>   be migrated incrementally to the new UAPI with the help of the planned
>   compatibility layer.
>
> References
> ==========
>
> Previous discussions on this migration:
> - https://lkml.org/lkml/2024/6/24/479
> - https://lkml.org/lkml/2024/6/21/1252
>
> Testing
> =======
>
> The driver has been tested on Qualcomm platforms with:
> - Basic FastRPC attach/release operations
> - DSP process creation and initialization
> - Memory mapping/unmapping operations
> - Dynamic invocation with various buffer types
> - GEM buffer allocation and mmap
> - PRIME buffer import from other subsystems
>
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
> Ekansh Gupta (18):
>       accel/qda: Add Qualcomm QDA DSP accelerator driver docs
>       accel/qda: Add Qualcomm DSP accelerator driver skeleton
>       accel/qda: Add RPMsg transport for Qualcomm DSP accelerator
>       accel/qda: Add built-in compute CB bus for QDA and integrate with IOMMU
>       accel/qda: Create compute CB devices on QDA compute bus
>       accel/qda: Add memory manager for CB devices
>       accel/qda: Add DRM accel device registration for QDA driver
>       accel/qda: Add per-file DRM context and open/close handling
>       accel/qda: Add QUERY IOCTL and basic QDA UAPI header
>       accel/qda: Add DMA-backed GEM objects and memory manager integration
>       accel/qda: Add GEM_CREATE and GEM_MMAP_OFFSET IOCTLs
>       accel/qda: Add PRIME dma-buf import support
>       accel/qda: Add initial FastRPC attach and release support
>       accel/qda: Add FastRPC dynamic invocation support
>       accel/qda: Add FastRPC DSP process creation support
>       accel/qda: Add FastRPC-based DSP memory mapping support
>       accel/qda: Add FastRPC-based DSP memory unmapping support
>       MAINTAINERS: Add MAINTAINERS entry for QDA driver
>
>  Documentation/accel/index.rst          |    1 +
>  Documentation/accel/qda/index.rst      |   14 +
>  Documentation/accel/qda/qda.rst        |  129 ++++
>  MAINTAINERS                            |    9 +
>  arch/arm64/configs/defconfig           |    2 +
>  drivers/accel/Kconfig                  |    1 +
>  drivers/accel/Makefile                 |    2 +
>  drivers/accel/qda/Kconfig              |   35 ++
>  drivers/accel/qda/Makefile             |   19 +
>  drivers/accel/qda/qda_cb.c             |  182 ++++++
>  drivers/accel/qda/qda_cb.h             |   26 +
>  drivers/accel/qda/qda_compute_bus.c    |   23 +
>  drivers/accel/qda/qda_drv.c            |  375 ++++++++++++
>  drivers/accel/qda/qda_drv.h            |  171 ++++++
>  drivers/accel/qda/qda_fastrpc.c        | 1002 ++++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_fastrpc.h        |  433 ++++++++++++++
>  drivers/accel/qda/qda_gem.c            |  211 +++++++
>  drivers/accel/qda/qda_gem.h            |  103 ++++
>  drivers/accel/qda/qda_ioctl.c          |  271 +++++++++
>  drivers/accel/qda/qda_ioctl.h          |  118 ++++
>  drivers/accel/qda/qda_memory_dma.c     |   91 +++
>  drivers/accel/qda/qda_memory_dma.h     |   46 ++
>  drivers/accel/qda/qda_memory_manager.c |  382 ++++++++++++
>  drivers/accel/qda/qda_memory_manager.h |  148 +++++
>  drivers/accel/qda/qda_prime.c          |  194 +++++++
>  drivers/accel/qda/qda_prime.h          |   43 ++
>  drivers/accel/qda/qda_rpmsg.c          |  327 +++++++++++
>  drivers/accel/qda/qda_rpmsg.h          |   57 ++
>  drivers/iommu/iommu.c                  |    4 +
>  include/linux/qda_compute_bus.h        |   22 +
>  include/uapi/drm/qda_accel.h           |  224 +++++++
>  31 files changed, 4665 insertions(+)
> ---
> base-commit: d4906ae14a5f136ceb671bb14cedbf13fa560da6
> change-id: 20260223-qda-firstpost-4ab05249e2cc
>
> Best regards,

