Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4BB36A034
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873765; cv=none; b=U+OrILFxHdTkUVWn9+2Sv20cCAYio3Xx+8Az4rfTu3XxV0twHyq4MM5MBNl5eWqGl/HipHJUuFOKAuvL1aygPMocms7QX+c1IpMWkZCKeL9n0ObMBWVwXeyLrOBpXSAjQMVLa0hc+Cdk53EkvT2nlnEilDBK4BF1lh85j8gNcSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873765; c=relaxed/simple;
	bh=D//kaqpwCmT40rsG5cKJ+7z0DZfDBbgSAfyZIlvB0A8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TKExhcejKgZQLw5/EEZsLebMP3K1+U86CCQJ3Z3S1uMnepqwNTD1wr3mqFewEguXcAIsT4twMrvvBNR4lML8+T+6fybK+ABi7utZ+WKo/MAr5N59tmJJqwK+SVQBIGFx6vbqFGUKLV1UUy/KFDh6KT+4APDkZrtZgMvAy5zOZog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dTjldB41; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F86nCH9j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dTjldB41";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F86nCH9j"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NH4coZ910666
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TvF6VK4oxjuFL6LNyQstH1
	ImQ9tkF3SQZlGOX1aTU3Q=; b=dTjldB41+wHzfWAlQA1sSmChKx7Z6JXOK9ClZr
	MrgQqIXj1j6lir0zy7lSoUkYUpJUMi9yjF+TJE/SLH6tIPYaQOpanPSgK6ZjCCgH
	a/YRhM5dD2P719nVmCoa8Pe6t+VS+HrG9cUXE7NT6aJ31nQU2XxcFKQ/knp27vp1
	zdOJpsZ9PkIC8ESBeChiu1WLUsmAjayIf1vX1xPYTQbt6jQ7U9nVBVe8IU88dZl8
	XrOl8LIHdMvk+WxwkSo5kXpgVyVLaOc4fZihBADw421K5XYTXQYb/lt39GPJYarS
	NmC1btIDV3tCFBfmj2Kc+cU1Fgggx/+Mn3qa+3X/P9fCl2rQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgtyj8d28-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:09:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aaf2f3bef6so48575845ad.0
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 11:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771873762; x=1772478562; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TvF6VK4oxjuFL6LNyQstH1ImQ9tkF3SQZlGOX1aTU3Q=;
        b=F86nCH9jnCiDKxGaw3ezGUgVwmtyFF1yW/uxhppvCBluf+CWI0s18ogNp1z/o3A6k8
         gy3jycIkW6ITiGmLPlgoJwjqrKEyPiu7XrrJDViQ2pq7UgN7rX7cI+wXURJf29MD+azh
         CRsFuFZ3F2aOQ/UTH1ZdFl8WNzwQdmfjqEeLPSJnRwfT2kHf992Fc7xDZY2t0X5FNyK7
         w1BlEf/eugYIPU3SH6aVgY2PwDnun6vALisUp6ABUs0RHexDxL1PWph3NT4ubVDTvCDK
         UWiZZRD3DFmKdw6COcjvtqdACCD1AMsTT0PJc2YRDVxW8raSbzEk95+PEm5tq4euCyXv
         WDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873762; x=1772478562;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvF6VK4oxjuFL6LNyQstH1ImQ9tkF3SQZlGOX1aTU3Q=;
        b=sUAz5TCSAtnykUBCX87TYgFQAbOyyIzmpWmWpd/Gxn1Qst8bqDPcBiAXE0v4Z2ZaKE
         zeKHkooB1S7ywvfTxSPk3YLwPlyHFvG6y1S7lfFKvlqBCI1ZeEVcDpc7Lu0K9Uk/gqZY
         tXOkCT+iHr57mGTretrT8AbBQvJDx9MsB0LiLRXR2Y2p6p5T9VlHnimY5yqpx7ii3RzB
         ad5DiHsPK+KIekQy08C4OPeefc3n9M0XvXvXZDboHv5Ck5HXNutmHYhZ6/YfRyq/2JhZ
         xiFl1ZW6kZMTXeM1icFywQB4vNzr57ehKOTwKled/NjawUxb3FVQHWnz3v4XeKCef222
         4b/A==
X-Forwarded-Encrypted: i=1; AJvYcCXrl5+pTXcfp6s3sVX6oLjmuBS/WtnmpvhKiJWhbISFufZue2ectWvc1JskQQRmxACYKO6+5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAiRjq28DUNCOu6GJabgD4pxoIKVD6wWbni8kAsOMKjkrRLQDI
	CZVKraV+7y56VR7KAHXtO7EZh1uTVsQ/Jaw99nWMPfihJZgRNw0hTvYUxTXwTjHA29DUDyVZUoY
	hTRzCf2PBIZTY+Sdkh2kpimLMOsNYKXzrYPkYxFjQ/ekjeYx/w1MJMP49dw==
X-Gm-Gg: ATEYQzzmW8orJy4zeYsyNytXtl5Dyu1wQhzi3Vzw367RTmUMgQyPmVQJiku7rpdqmeQ
	1GALHSP8QGdlgdybwyMZJAJHRf4xCvtHgi4eyWJ4zRiyaU7Wb7PlLJwnT1m0FU1G2TPWKTfv2fi
	ZxD8YEPxBqnpaGNvYmELCuTuTHMxLCS3ZCdFYPT5eo6tyG3XIKfXwIO/mo8sVXgg+6QdSTYW9pC
	BI+YfKBpyxkEv3WmlIy0s5jpR/ZvGqASeOmgQIbR0+CBElGDiiTb63uxtACXQvkr6FTUiH6WeDa
	zhO5XPjG0dVWDELPsTwFAK8kR3BQQIJ1ygRm6cpE3tLg870LLzNKkiEjraCF17FSusK931HwEpP
	otix0TmEAnXvBK7wBhwc5bgcCvCwadH9pYNSOBmqlmMypdhlRL/FCyQ==
X-Received: by 2002:a17:903:2bcb:b0:2a9:5e25:46f6 with SMTP id d9443c01a7336-2ad7449f6bbmr87070005ad.17.1771873761671;
        Mon, 23 Feb 2026 11:09:21 -0800 (PST)
X-Received: by 2002:a17:903:2bcb:b0:2a9:5e25:46f6 with SMTP id d9443c01a7336-2ad7449f6bbmr87069625ad.17.1771873761120;
        Mon, 23 Feb 2026 11:09:21 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34e18sm83501505ad.10.2026.02.23.11.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:09:20 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Subject: [PATCH RFC 00/18] accel/qda: Introduce Qualcomm DSP Accelerator
 driver
Date: Tue, 24 Feb 2026 00:38:54 +0530
Message-Id: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMalnGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyNj3cKURN20zKLikoL84hJdk8QkA1MjE8tUo+RkJaCegqLUtMwKsHn
 RSkFuzkqxtbUAHlWAZWQAAAA=
X-Change-ID: 20260223-qda-firstpost-4ab05249e2cc
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771873753; l=11158;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=D//kaqpwCmT40rsG5cKJ+7z0DZfDBbgSAfyZIlvB0A8=;
 b=lK/DmO5cl5PDlIdldx+QTx4Kw45T1SHEvRcIXseha9NM9kCesb2auejxvWSkASz7wrYw4z7T9
 NQyYDgWSO04Cp1D+dZISVB/jL7DdT+TnyQwVOWw5tRXVYJKW8G/UIIg
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Authority-Analysis: v=2.4 cv=Jq/8bc4C c=1 sm=1 tr=0 ts=699ca5e2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=D19gQVrFAAAA:8
 a=B-WXDzf3NZ75i5Zg2PoA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-ORIG-GUID: tRtOh4V4ZjF0Fpr9fKAeeb3dOpIeYEJ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE2NiBTYWx0ZWRfX3Xz6fHtzKvui
 KvIEQO/Y0YJ2gEwwUkT4carGCqjuUO8U3jPxUp89rY+sJkfmNxCO6RgJ1mCq9JSZOjUQv8gCaPP
 jcv4d2g4rbXes0Nrx0eOVXm2bxx/n68nMwSsep1+wtrlNafDHZE4pzYVrRCR1G/osyR/vrz66oh
 BReW5L9yytwGCXP02NkMwan2RBnIQUR/PrC3AyG0rgIuUjJplRMgSQ6tbP+XiRJNmtviSE3qdH3
 30vU5nLiiUwip5LuNu4V5c2+F7AriEBfFTLdI75JqZlhVrpFtwdzmCn+ynSa4ewwOqgHhVL3v3N
 sMbRB2c/RIe22WM8wkWlLqYWBSbCCtQ4zPVyhRptWzvWEeYGlVxMAQGOMWgqK7W9Vaqb5YKAdJt
 yh4EA/BMTnasdIIhJhjWnOFmGMgEhSp0WUqVDg02J0+G5/des7nJMNQcI8Kgw+4voZbTlyl0pYL
 9SRdkCiLqjJ8iE3hudg==
X-Proofpoint-GUID: tRtOh4V4ZjF0Fpr9fKAeeb3dOpIeYEJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230166

This patch series introduces the Qualcomm DSP Accelerator (QDA) driver,
a modern DRM-based accelerator implementation for Qualcomm Hexagon DSPs.
The driver provides a standardized interface for offloading computational
tasks to DSPs found on Qualcomm SoCs, supporting all DSP domains (ADSP,
CDSP, SDSP, GDSP).

The QDA driver is designed as an alternative for the FastRPC driver
in drivers/misc/, offering improved resource management, better integration
with standard kernel subsystems, and alignment with the Linux kernel's
Compute Accelerators framework.

User-space staging branch
============
https://github.com/qualcomm/fastrpc/tree/accel/staging

Key Features
============

* Standard DRM accelerator interface via /dev/accel/accelN
* GEM-based buffer management with DMA-BUF import/export support
* IOMMU-based memory isolation using per-process context banks
* FastRPC protocol implementation for DSP communication
* RPMsg transport layer for reliable message passing
* Support for all DSP domains (ADSP, CDSP, SDSP, GDSP)
* Comprehensive IOCTL interface for DSP operations

High-Level Architecture Differences with Existing FastRPC Driver
=================================================================

The QDA driver represents a significant architectural departure from the
existing FastRPC driver (drivers/misc/fastrpc.c), addressing several key
limitations while maintaining protocol compatibility:

1. DRM Accelerator Framework Integration
  - FastRPC: Custom character device (/dev/fastrpc-*)
  - QDA: Standard DRM accel device (/dev/accel/accelN)
  - Benefit: Leverages established DRM infrastructure for device
    management.

2. Memory Management
  - FastRPC: Custom memory allocator with ION/DMA-BUF integration
  - QDA: Native GEM objects with full PRIME support
  - Benefit: Seamless buffer sharing using standard DRM mechanisms

3. IOMMU Context Bank Management
  - FastRPC: Direct IOMMU domain manipulation, limited isolation
  - QDA: Custom compute bus (qda_cb_bus_type) with proper device model
  - Benefit: Each CB device is a proper struct device with IOMMU group
    support, enabling better isolation and resource tracking.
  - https://lore.kernel.org/all/245d602f-3037-4ae3-9af9-d98f37258aae@oss.qualcomm.com/

4. Memory Manager Architecture
  - FastRPC: Monolithic allocator
  - QDA: Pluggable memory manager with backend abstraction
  - Benefit: Currently uses DMA-coherent backend, easily extensible for
    future memory types (e.g., carveout, CMA)

5. Transport Layer
  - FastRPC: Direct RPMsg integration in core driver
  - QDA: Abstracted transport layer (qda_rpmsg.c)
  - Benefit: Clean separation of concerns, easier to add alternative
    transports if needed

8. Code Organization
  - FastRPC: ~3000 lines in single file
  - QDA: Modular design across multiple files (~4600 lines total)
    * qda_drv.c: Core driver and DRM integration
    * qda_gem.c: GEM object management
    * qda_memory_manager.c: Memory and IOMMU management
    * qda_fastrpc.c: FastRPC protocol implementation
    * qda_rpmsg.c: Transport layer
    * qda_cb.c: Context bank device management
  - Benefit: Better maintainability, clearer separation of concerns

9. UAPI Design
  - FastRPC: Custom IOCTL interface
  - QDA: DRM-style IOCTLs with proper versioning support
  - Benefit: Follows DRM conventions, easier userspace integration

10. Documentation
  - FastRPC: Minimal in-tree documentation
  - QDA: Comprehensive documentation in Documentation/accel/qda/
  - Benefit: Better developer experience, clearer API contracts

11. Buffer Reference Mechanism
  - FastRPC: Uses buffer file descriptors (FDs) for all book-keeping
    in both kernel and DSP
  - QDA: Uses GEM handles for kernel-side management, providing better
    integration with DRM subsystem
  - Benefit: Leverages DRM GEM infrastructure for reference counting,
    lifetime management, and integration with other DRM components

Key Technical Improvements
===========================

* Proper device model: CB devices are real struct device instances on a
  custom bus, enabling proper IOMMU group management and power management
  integration

* Reference-counted IOMMU devices: Multiple file descriptors from the same
  process share a single IOMMU device, reducing overhead

* GEM-based buffer lifecycle: Automatic cleanup via DRM GEM reference
  counting, eliminating many resource leak scenarios

* Modular memory backends: The memory manager supports pluggable backends,
  currently implementing DMA-coherent allocations with SID-prefixed
  addresses for DSP firmware

* Context-based invocation tracking: XArray-based context management with
  proper synchronization and cleanup

Patch Series Organization
==========================

Patches 1-2:   Driver skeleton and documentation
Patches 3-6:   RPMsg transport and IOMMU/CB infrastructure
Patches 7-9:   DRM device registration and basic IOCTL
Patches 10-12: GEM buffer management and PRIME support
Patches 13-17: FastRPC protocol implementation (attach, invoke, create,
               map/unmap)
Patch 18:      MAINTAINERS entry

Open Items
===========

The following items are identified as open items:

1. Privilege Level Management
  - Currently, daemon processes and user processes have the same access
    level as both use the same accel device node. This needs to be
    addressed as daemons attach to privileged DSP PDs and require
    higher privilege levels for system-level operations
  - Seeking guidance on the best approach: separate device nodes,
    capability-based checks, or DRM master/authentication mechanisms

2. UAPI Compatibility Layer
  - Add UAPI compat layer to facilitate migration of client applications
    from existing FastRPC UAPI to the new QDA accel driver UAPI,
    ensuring smooth transition for existing userspace code
  - Seeking guidance on implementation approach: in-kernel translation
    layer, userspace wrapper library, or hybrid solution

3. Documentation Improvements
  - Add detailed IOCTL usage examples
  - Document DSP firmware interface requirements
  - Create migration guide from existing FastRPC

4. Per-Domain Memory Allocation
  - Develop new userspace API to support memory allocation on a per
    domain basis, enabling domain-specific memory management and
    optimization

5. Audio and Sensors PD Support
  - The current patch series does not handle Audio PD and Sensors PD
    functionalities. These specialized protection domains require
    additional support for real-time constraints and power management

Interface Compatibility
========================

The QDA driver maintains compatibility with existing FastRPC infrastructure:

* Device Tree Bindings: The driver uses the same device tree bindings as
  the existing FastRPC driver, ensuring no changes are required to device
  tree sources. The "qcom,fastrpc" compatible string and child node
  structure remain unchanged.

* Userspace Interface: While the driver provides a new DRM-based UAPI,
  the underlying FastRPC protocol and DSP firmware interface remain
  compatible. This ensures that DSP firmware and libraries continue to
  work without modification.

* Migration Path: The modular design allows for gradual migration, where
  both drivers can coexist during the transition period. Applications can
  be migrated incrementally to the new UAPI with the help of the planned
  compatibility layer.

References
==========

Previous discussions on this migration:
- https://lkml.org/lkml/2024/6/24/479
- https://lkml.org/lkml/2024/6/21/1252

Testing
=======

The driver has been tested on Qualcomm platforms with:
- Basic FastRPC attach/release operations
- DSP process creation and initialization
- Memory mapping/unmapping operations
- Dynamic invocation with various buffer types
- GEM buffer allocation and mmap
- PRIME buffer import from other subsystems

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
Ekansh Gupta (18):
      accel/qda: Add Qualcomm QDA DSP accelerator driver docs
      accel/qda: Add Qualcomm DSP accelerator driver skeleton
      accel/qda: Add RPMsg transport for Qualcomm DSP accelerator
      accel/qda: Add built-in compute CB bus for QDA and integrate with IOMMU
      accel/qda: Create compute CB devices on QDA compute bus
      accel/qda: Add memory manager for CB devices
      accel/qda: Add DRM accel device registration for QDA driver
      accel/qda: Add per-file DRM context and open/close handling
      accel/qda: Add QUERY IOCTL and basic QDA UAPI header
      accel/qda: Add DMA-backed GEM objects and memory manager integration
      accel/qda: Add GEM_CREATE and GEM_MMAP_OFFSET IOCTLs
      accel/qda: Add PRIME dma-buf import support
      accel/qda: Add initial FastRPC attach and release support
      accel/qda: Add FastRPC dynamic invocation support
      accel/qda: Add FastRPC DSP process creation support
      accel/qda: Add FastRPC-based DSP memory mapping support
      accel/qda: Add FastRPC-based DSP memory unmapping support
      MAINTAINERS: Add MAINTAINERS entry for QDA driver

 Documentation/accel/index.rst          |    1 +
 Documentation/accel/qda/index.rst      |   14 +
 Documentation/accel/qda/qda.rst        |  129 ++++
 MAINTAINERS                            |    9 +
 arch/arm64/configs/defconfig           |    2 +
 drivers/accel/Kconfig                  |    1 +
 drivers/accel/Makefile                 |    2 +
 drivers/accel/qda/Kconfig              |   35 ++
 drivers/accel/qda/Makefile             |   19 +
 drivers/accel/qda/qda_cb.c             |  182 ++++++
 drivers/accel/qda/qda_cb.h             |   26 +
 drivers/accel/qda/qda_compute_bus.c    |   23 +
 drivers/accel/qda/qda_drv.c            |  375 ++++++++++++
 drivers/accel/qda/qda_drv.h            |  171 ++++++
 drivers/accel/qda/qda_fastrpc.c        | 1002 ++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_fastrpc.h        |  433 ++++++++++++++
 drivers/accel/qda/qda_gem.c            |  211 +++++++
 drivers/accel/qda/qda_gem.h            |  103 ++++
 drivers/accel/qda/qda_ioctl.c          |  271 +++++++++
 drivers/accel/qda/qda_ioctl.h          |  118 ++++
 drivers/accel/qda/qda_memory_dma.c     |   91 +++
 drivers/accel/qda/qda_memory_dma.h     |   46 ++
 drivers/accel/qda/qda_memory_manager.c |  382 ++++++++++++
 drivers/accel/qda/qda_memory_manager.h |  148 +++++
 drivers/accel/qda/qda_prime.c          |  194 +++++++
 drivers/accel/qda/qda_prime.h          |   43 ++
 drivers/accel/qda/qda_rpmsg.c          |  327 +++++++++++
 drivers/accel/qda/qda_rpmsg.h          |   57 ++
 drivers/iommu/iommu.c                  |    4 +
 include/linux/qda_compute_bus.h        |   22 +
 include/uapi/drm/qda_accel.h           |  224 +++++++
 31 files changed, 4665 insertions(+)
---
base-commit: d4906ae14a5f136ceb671bb14cedbf13fa560da6
change-id: 20260223-qda-firstpost-4ab05249e2cc

Best regards,
-- 
Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

