Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A31D3A05F2
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146002; cv=none; b=axJeDGqAmbMHDNTM4NdVp7fdLPOAzkQ3Rvybgsx26F7pV1ZwL+qfzWT9T5Gf6XW7F3Yt6aVqYOGnjLcGQ+9JK/WXCoIg/KG4I/yXdSnEv92e9Q3FswgVbz/yyQOUx55fzkLSr7wN26Z646iw57wrDxTD7PxXeE5WGv6JLzte9Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146002; c=relaxed/simple;
	bh=6HzawwOxkusOjOPeE6/oX/1EaAdxQaxMxK9EQzXaZDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iza9bxcaWDz5kkm245uQYtRI2OjLiJnPmSNWSN0QJ3lAXgJONSk/wnoT4w1BtEyJu4W40vcntv525+KyVfNBpY57r5yxSkaEFlRnfOcUHnlnDXiMGge3OO93BA3tXiroDrtKj6DazrhEhPiBClJijvDg5/eA8al92qxj5OCzUP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G4hE9RKH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nrnv5cMb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G4hE9RKH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nrnv5cMb"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JD089V4045467
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 13:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RC/u9yMGeHLFDrjdoHnolPqZvFBp4AVSt0SyCBdL7ug=; b=G4hE9RKHpv1cHu7k
	VrLrbNQo/EAdJunCWDrxmKNhWRYHX2pb2l26AEVKrsFVirbZVNgywCKQhmReIlaG
	JhEDxoUIoo89ZnoSKAq4GdcwQ0kJLGSe7yfC+5g+ZKuOkYYdzq8cfsILYgag2x50
	DuWJ2+DbC4syzjVucQdBGDM42esXb10fNgDNTg004ivwBBVonqBA+X5zJFOg8rcS
	rxIrqhtGuvXPFGbFJ7o3gDrbkjCCjr7lqQlLzJlKOg0G1yukAv5uAHA6uT2YE+Qj
	rFF8ld744Q3PkrsOQUDb49WfVYuhG7ukFW1Z6wj/SIOIE3Hk03B8EwsbQLgOsOvH
	szXX5A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfkkets-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 13:26:35 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84c4cd31b51so2523724b3a.0
        for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 06:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787145994; x=1787750794; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RC/u9yMGeHLFDrjdoHnolPqZvFBp4AVSt0SyCBdL7ug=;
        b=Nrnv5cMb2kyLKG5kY3PAva6Hg7s8BRprLFmZzZ1O8dNAz74UZOxKUbf7FXAau/G33t
         JI4mzpRcbDHzb3YEFAIiEBmuDH1wxqo6sSjt/ukT7Ri1+u1OgM5PbdIZoGS75ZdIFcjf
         W6pWOK/RAlKtlXSLrYHd7OimQ4EMpTwv4KNRydov82CryD3j+0lvG9/pMnFA73vtFyhI
         DFuUhHK4YNfGurLEr+Hi6LaY5LbPZrORDP4uiyErqd8Iv/4AUShcSsnDOaSk4yScTbb+
         9VkVLa+mWAoo3N5C/k/pr7/C81OgsoSfT+5PuQr7Kk1BDExbsS3VfIIEqyn22L37DaQi
         MsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787145994; x=1787750794;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RC/u9yMGeHLFDrjdoHnolPqZvFBp4AVSt0SyCBdL7ug=;
        b=i6GY4B9gpwP2ZitYexCSIRAtwLzBqdz75tSdXFdkFdwNQ7Uw7geOw+qUnXorLL3L2E
         tnU+uTiiZgL7id9JYpxmvg5t5tb2C34s4Try5fy078DDgoeTGYPEmnwQ6JKHNAs0EqDs
         e3LgonUEIVjQG9E1zw2A+B1Oqpmrf437/oSGl8dopG3aHnXA6vr3xNBgWuymnAIsEow6
         pdEjW3+fSAicMQbXiIT1MU055aFVCDkscDg5SEe9+UQFd96oiZqJkB6BtGy4vfWnBy/t
         ZjFLBpReeB2xlErdfdIxZ35Idd5yWHDzl7cmPHBUruRgb1n2s2yCoSQlRXs9QC+C4iZ9
         DmMw==
X-Forwarded-Encrypted: i=1; AHgh+RrJtQDS7q8RRMnNADo0thCU0ic4OKeoIX3Ad2VQ9KGO9X+n0imoi17gqbHVcp9GXc0wh384sA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzz7sn7NvnnBhU1a18k22WjyU5vJALOT26AYHopfDkven2jg6Hg
	CG5hrdiLhZa58I143NJXkn/jWr73ht7Zr3xGsCKWbOCrqNSaxM2ubHQKJkmT1HncfpaHlOGcNOo
	7Vc+P0eOjGBC4YtY7YHQF73P718eg6Efzdk4g4h4oBbQ7QahsxbnLdnE6Iw==
X-Gm-Gg: AR+sD10H725AV7c8MHHqnogKv2zpgo5Uj5fj2AXGelqzcaNB9ipSWFTjhOeaz6LGr+4
	3WUzI8hxZxwUtLb8OCz3MasGxI83tWLNK3KT9/FT7bASMD9scU3eHFWojkKoE2YQ87uIWFQkUXU
	6FJWdy9WsLn0EwCqgEtD/AD5PABypRouekvdqSK2gbnXFA8BzQeOD6NhcUNLL5OJS46e3MKX57y
	xZXnmNFFNKZFw3RcjSBGqSn7LoM7FRvsEqmvbB+8lO5d+Ly+AxLSsHJfqAQZJ2BawDQI4mXK9jp
	el2Aea2G5RLeDsgvkCdVnMo2GODb3CXySKbaDNfwG2aS7pOftuZKVXJw42MUyYLuEzqw7oXs4yn
	CT83VigczGAjK3u5nQ8SWn28ey5eWVw==
X-Received: by 2002:a05:6a21:110:b0:3b4:661d:8405 with SMTP id adf61e73a8af0-3cd00c6d745mr6160103637.4.1787145994367;
        Wed, 19 Aug 2026 06:26:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:110:b0:3b4:661d:8405 with SMTP id adf61e73a8af0-3cd00c6d745mr6159988637.4.1787145993729;
        Wed, 19 Aug 2026 06:26:33 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc155689110sm598347a12.22.2026.08.19.06.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 06:26:33 -0700 (PDT)
Message-ID: <10349e29-b583-403f-a89a-9a00c73666bc@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 18:56:23 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
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
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <3322b42b-3755-45ec-ad55-345125f0d488@kernel.org>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <3322b42b-3755-45ec-ad55-345125f0d488@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NoPhtcdJ c=1 sm=1 tr=0 ts=6a85af0b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=1aprj6cQADeN8GqOYRYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 7cbzir_GJNg267lBUKDbEKLcz7wWD-8e
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNCBTYWx0ZWRfXwvGnGKLZKuJj
 UznwO0KGbW022HORWBPAsdwjl980uY051gV2kJcspi+2n/7glvczMCYUUIQXJSPgtLMAEOmH254
 FAhxmGt3tHB8L1IOjsTdrxBavEEOz0o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNCBTYWx0ZWRfX4fvjOG2n3pJo
 aF6m0eaSnisHdMKyYvg/7JwU3W+kK3/q9U/pr2pzJZDrykjjRUitT5adVR8qLuT+k8XwW4LMlQB
 sQIY1DzTPx6ZRRFnRSecoBLbfAAz74Gh97JWfiwFnagwiMcIzzJceHnyEnWsRb2r5uASge2Znlm
 ovqj3UerPbhjbxFpdZ0PHMRzvnTuJ4PoqgMQM2+t2l9b+CAIZ1jOgfDSBFUMvDARSuwlPshsgBU
 n1/FG78iPSu35+HpceRaWWkm7Ha+7FM0nLK7F1kBhTjaRdoalTo/9p1ZgNnAQwCg3KarfVWAkdA
 QLpwCZrHdpWFgUE4akYMFPm+6syH906djCwjmYnqmt3E9uXBw63nnkWDrdE4zz+bsrKQU5NyLis
 HiOFgM3tilGcqyTjeWwAY+wQU0isLHFBWIMGYSETUvOUEqNG3IH49uLbqNpIuBNGlNEdgYi627H
 HH4VqK4PF3tftFgveEQ==
X-Proofpoint-GUID: 7cbzir_GJNg267lBUKDbEKLcz7wWD-8e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190104

On 19-08-2026 00:43, Krzysztof Kozlowski wrote:
> On 17/08/2026 06:47, Ekansh Gupta wrote:
>> This patch series introduces the Qualcomm DSP Accelerator (QDA) driver,
>> a DRM-based accelerator driver for Qualcomm DSPs. The driver provides a
>> standardized interface for offloading computational tasks to DSPs found
>> on Qualcomm SoCs, supporting all DSP domains.
>>
>> The QDA driver implements the FastRPC protocol over the DRM accel
>> subsystem. It uses the same device-tree node structure as the existing
>> fastrpc driver in drivers/misc/. The approach for binding the QDA driver
>> to device-tree nodes while coexisting with the fastrpc driver is an open
>> item described below.
> 
> No. Grow/replace/improve existing driver instead of coming with a duplicate.
> 
> That's a standard upstream requirement, basically given on every
> upstreaming guide.
> 
> Please watch old talk from Greg - "I Don’t Want Your Code!".
Posted discussion threads here[1]. Would seek comments from Dmitry,
Srini as well.

[1]
https://lore.kernel.org/all/3476b5c3-7983-4994-a901-3d7d8bd75255@oss.qualcomm.com/

> 
>>
>> v1: https://lore.kernel.org/all/20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com/
>> RFC: https://lore.kernel.org/dri-devel/20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com/T/
>>
>> Changes since v1
>> ================
>>
>> The v1 review raised two architectural objections and one correctness
>> issue; all three are resolved in v2:
>>
>> * Christian König (dma-buf maintainer) pointed out that the imported-
>>   buffer path silently assumed the IOMMU maps every buffer as a single
>>   contiguous range, which is not guaranteed. v2 walks the scatterlist
>>   and cleanly rejects non-contiguous imports; contiguous imports (e.g.
>>   CMA DMA-buf heap) are accepted. (patch 11)
>>
>> * Dmitry Baryshkov objected to three different buffer-passing formats
>>   in the invoke IOCTL (DMA-BUF fd, direct/inline, DMA handle). v2
>>   passes only GEM handles; userspace imports any fd to a GEM handle
>>   with DRM_IOCTL_PRIME_FD_TO_HANDLE before invoking. Packing and
>>   overlap handling are left to userspace. (patch 12)
>>
>> * The memory manager (patch 07) used a fixed 16-entry array without
>>   justification and leaked the device descriptor on teardown. v2
>>   allocates the array from the DT context-bank count (as Dmitry
>>   suggested) and frees it correctly.
>>
>> User-space staging branch
>> =========================
>> https://github.com/qualcomm/fastrpc/tree/accel/staging
>>
>> Key Features
>> ============
>>
>> * Standard DRM accelerator interface via /dev/accel/accelN
>> * GEM-based buffer management with DMA-BUF import (PRIME)
>> * IOMMU-based memory isolation using per-process context banks
>> * FastRPC protocol implementation for DSP communication
>> * RPMsg transport layer for reliable message passing
>> * Support for all DSP domains (ADSP, CDSP, SDSP, GDSP)
>> * DRM IOCTL interface for DSP session management, buffer allocation,
>>   and remote procedure invocation
>>
>> Architecture
>> ============
>>
>> 1. DRM Accelerator Framework Integration
>>    The driver registers as a DRM accel device, exposing a standard
>>    /dev/accel/accelN character device node. This provides established
>>    DRM infrastructure for device management, file operations, and
>>    IOCTL dispatch.
>>
>> 2. Memory Management
>>    Buffers are managed as GEM objects with PRIME support for DMA-BUF
>>    import. This enables buffer sharing with other DRM drivers (GPU,
>>    camera, video) using standard kernel mechanisms. Only contiguous
>>    imports are accepted; the driver verifies contiguity at import time
>>    rather than assuming it.
>>
>> 3. IOMMU Context Bank Management
>>    IOMMU context banks (CBs) are represented as proper struct device
>>    instances on a custom virtual bus (qda-compute-cb). Each CB device
>>    is registered with the IOMMU subsystem and receives its own IOMMU
>>    domain, enabling per-session address space isolation. The custom
>>    bus was introduced because IOMMU context banks are synthetic
>>    constructs — not real platform devices — and to ensure CB device
>>    lifetime is strictly subordinate to the parent QDA device.
>>    See also: https://lore.kernel.org/all/245d602f-3037-4ae3-9af9-d98f37258aae@oss.qualcomm.com/
>>
>> 4. Memory Manager Architecture
>>    The memory manager maintains a registry of IOMMU devices in an
>>    array sized to the number of context banks described in the device
>>    tree, and coordinates per-process device assignment with reference-
>>    counted lifetime management. The DMA-coherent backend allocates
>>    buffers with SID-prefixed DMA addresses for DSP firmware
>>    compatibility.
>>
>> 5. Transport Layer
>>    RPMsg communication is handled in a dedicated transport layer
>>    (qda_rpmsg.c), separate from the core DRM driver logic.
>>
>> 6. Code Organization
>>    The driver is organized across multiple files (~4800 lines total):
>>    * qda_drv.c:            Core driver and DRM integration
>>    * qda_rpmsg.c:          RPMsg transport layer
>>    * qda_cb.c:             Context bank device management
>>    * qda_compute_bus.c:    Custom virtual bus for CB devices
>>    * qda_gem.c:            GEM object management
>>    * qda_prime.c:          DMA-BUF import (PRIME)
>>    * qda_memory_manager.c: IOMMU device registry and allocation
>>    * qda_memory_dma.c:     DMA-coherent allocation backend
>>    * qda_fastrpc.c:        FastRPC protocol implementation
>>    * qda_ioctl.c:          IOCTL dispatch
>>
>> 7. UAPI Design
>>    The driver exposes DRM-style IOCTLs defined in
>>    include/uapi/drm/qda_accel.h, following DRM UAPI conventions
>>    (__u32/__u64 types, C++ guard, GPL-2.0-only WITH Linux-syscall-note).
>>    Buffer arguments are identified by GEM handles; the driver never
>>    accepts DMA-BUF fds directly in any IOCTL.
>>
>> Patch Series Organization
>> ==========================
>>
>> Patch 01:      MAINTAINERS entry
>> Patch 02:      Driver documentation (Documentation/accel/qda/)
>> Patches 03-04: Core driver skeleton and compute bus
>> Patch 05:      iommu: Register qda-compute-cb bus with IOMMU subsystem
>> Patches 06-07: CB device enumeration and memory manager
>> Patch 08:      QUERY IOCTL and UAPI header
>> Patches 09-11: GEM buffer management and PRIME import
>> Patches 12-15: FastRPC protocol (invoke, session create/release,
>>                map/unmap)
>>
>> Open Items
>> ===========
>>
>> 1. Device-Tree Compatible String
>>    The QDA driver uses the same device-tree node structure and
>>    properties as the existing fastrpc driver in drivers/misc/. A
>>    mechanism is needed to allow the QDA driver to bind to its device
>>    node independently of the fastrpc driver.
>>
>>    The intended coexistence model is: platforms that require the
>>    complete fastrpc feature set continue to use "qcom,fastrpc"; new
>>    platforms where QDA's feature set is sufficient use a QDA-specific
>>    compatible string. New feature development is directed toward QDA.
>>
>>    The options under consideration are:
>>
>>    a) Add a new "qcom,qda" compatible string to the existing
>>       qcom,fastrpc.yaml binding, since the DT node structure and
>>       properties are identical.
> No
> 
>>
>>    b) Introduce a separate qcom,qda.yaml binding that references or
>>       inherits the fastrpc binding properties.
> 
> No
> 
>>
>>    Seeking guidance from DT binding maintainers on the preferred
>>    approach.
> 
> Grow existing driver. You do not get new driver, you do not get new
> bindings.
> 
> 
> Best regards,
> Krzysztof

