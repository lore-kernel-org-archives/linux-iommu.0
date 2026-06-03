Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A1374183
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 05:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780464162; cv=none; b=BvTmYyzIf1opvEX1AJFQF6fBindfTLtHFV0XVzbQ4ojzVRghBOUE0yBytNlaONNUKOpy5vjQ90q2X3+ZGMZIRsIpWHzaz7w6E+b9fYolKTe2Pz42fskWxh+O+24qomxQIWsLQJxWWkFZXDhgHirkykjM+dJRC1n1teHQJT78NxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780464162; c=relaxed/simple;
	bh=IHlNOx2u9RjdKNB0FvSrv1ifBrP1Oexh3O2W41Os9SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJPcyKVAKWXQIw9XIA41r0Uku3TTTEKnyQjb4ux0kP3+2Te55sqITDdT/5DRo88675U1jRc60mkxNcOLOpDFUC6GG54nZUXxTV/JHFjJ3dlDeBbvZI6b+XJnw2s8aihGnVyVxmwHHv7RdTrJLUTNytAWEF6GMBIFdH0EspZyLgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bz4g0mOG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C+FIraub; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bz4g0mOG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C+FIraub"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65318Evu2388904
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 05:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4apj65DJiSqJHn1+surZiEdopCJDEvIR6E6yf1J3f8k=; b=Bz4g0mOG1L5kTl0F
	v/yspg6vTGPVLHC5Rn6kp+l1tQldIBBwPt4uOLiZoDrumw7DmxQOFFtP3YMzkPGr
	hRB6uHLewPOlLVJir+yV+XZeAKDkOniIN2yw3xHV+6NVtVaN6IfgtfMIo58j9V+m
	o+khF1upABbERcMQbyIEDPHAhV7X0k3UCHF0eOkm0A22nM6NXd9sWZma4N3qvblc
	fUUVWDLzWHnkJnhBwn6Y/KEUxHtB1201x719i/66+aJu14mHRGPf8BBxFtjIQe2t
	H/DmtAwIPMe1MFg9B/CJwYXqRZPSUazR3iVeeQzb37GJ6WlJP4AhzFtfi2dBnxDj
	+5xI+g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejabbrrxe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 05:22:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0c20f7581so37163995ad.0
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 22:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780464160; x=1781068960; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4apj65DJiSqJHn1+surZiEdopCJDEvIR6E6yf1J3f8k=;
        b=C+FIraub1WP3Wn3nNn+6I2MOVyyZEsofdoffh/tDN9AsJUq368vo56aoWk7E62bK5c
         TMdOl4FSYL2ZDvf9k7Yy7N3PluN8T14sC7+AuAbb0VdHdGrPeOA3diH3vQSt973NQjDa
         jK6wYSjM9Qq9AxO7SSzuuA+EqJLr91XLp6eUG6oAnduxgeNeWw9Wc+ChgcKOmLIaRZ6B
         WC3A4TF7epnWYwFo1upIJR0vpZ9oGqIQPcnDSQROeVo3u2ubj/QmEn3obsx1XUxj6bz3
         JRvr/2KuD6ypgOfQ6S3aANkeKzKncm9XnxVOcYAW6v0EKLue27ZTiibb5bNh9Pm2Pv4v
         tcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780464160; x=1781068960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4apj65DJiSqJHn1+surZiEdopCJDEvIR6E6yf1J3f8k=;
        b=KuKIp9/X25r80A541E8B3FWdBebKoUHe06PAPqJxENJyrK6IPI0m19LqESg5+eAVMn
         Tpt4b+Zfo2a1JL+KdDSy9mON3byqBeJb+IrnrZPV9AIqZeUVLy6mu/SqyqSqOK/JoiIw
         /NfSUuJYpFEGQyx7rKmW6OY1GAB3aSpHiURztuG/GN9px+VTkijjRGL8G8zPUneGgv0L
         +RekxqThmVtVLCATIPmi+f1dNwD5bjoTckU9HCkZmSjITgq7O7nSWugu5cTfL+CYD4x7
         JNdqeQ8256CKzMRUFz5ZdwwWLdEibJI8PQ4crk0fwFZqb3aNRnZWJapKGO9Co4d0ASU2
         E/eg==
X-Forwarded-Encrypted: i=1; AFNElJ/7rDkXLQKw54sPxXzVi5haxv5PX/mUfgUdXaXKa4ZW3cKWEPOnGeQSmy/moiLLAyqz/Znh4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhikxX4H1E1ba+2X5dbMg7gmVUyNXzip5Zjk/536VjWG2apRUL
	BiodVqEPcBizgfmdBiTBqdrmiFMajBJydF4+ysHOcyUiXv5p2E6DHvk778inJt45VCTWqe2gdrV
	uESU8hjfoHqwG3uLX8oAF9YRQSA+Ty+BBNErw6KLwDB6bQKDkZSVl1sGTzQ==
X-Gm-Gg: Acq92OEJfGC7nNEvu45knaz1/0my4wxpQckefdPeTkI08cgH7ZqkMH1xRtfZHtFi9Zy
	+R5wASv60LNCKNdbXOLR0ojs0K2cVNBMPYLGAJn8GjaW4Dkjvdzy/5bn7Haufp06qlyUhlnD3pV
	6hYL0BB3lNLN77hLO36Ci0e1Wr4IMuHuTmYxd1ognRMqMhiNbMYp0iGdiHsWFXqRPo6VCQzOMhw
	BoMdoBb440c475YyTPfx/7k8BmMqEOKZ/LKEigMLsvnto7zHazyMPgAtALF3Z0iEC7TgjxpfmTn
	j1TWFh4y0SsU75G8o6FXaqEgXXNCYazimFfIqA3F8+mLkD1iH1Vaxfork9DQUWZfABFS3Z2hkQL
	jZqFrb47g3znK8PsjKdiH6KTO0euAh2e+goaof2n6isr8hwbWK/Of0b2NECos
X-Received: by 2002:a17:903:384d:b0:2c0:ca99:3d8b with SMTP id d9443c01a7336-2c1646ee9ffmr20964115ad.40.1780464159579;
        Tue, 02 Jun 2026 22:22:39 -0700 (PDT)
X-Received: by 2002:a17:903:384d:b0:2c0:ca99:3d8b with SMTP id d9443c01a7336-2c1646ee9ffmr20963525ad.40.1780464158991;
        Tue, 02 Jun 2026 22:22:38 -0700 (PDT)
Received: from [10.204.78.54] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d211sm10928475ad.3.2026.06.02.22.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 22:22:38 -0700 (PDT)
Message-ID: <9879f670-8a23-407b-ab45-673904ad4a86@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 10:52:29 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] accel/qda: Add QDA driver documentation
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-2-b2d984c297f8@oss.qualcomm.com>
 <paiohsil5pmvm7cf6jxrhaj2225bgvlt3scrag4x6gbkyosow5@l4tbakbnxcvo>
 <CAPsqS2Tt0JbHhJLHBsbJ2YfZW913WNfoSXpSa+8TD1T9CV8V3g@mail.gmail.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <CAPsqS2Tt0JbHhJLHBsbJ2YfZW913WNfoSXpSa+8TD1T9CV8V3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA0OCBTYWx0ZWRfX6j9xwp20oca5
 7fkYNB2+FNQ0q4pzgXYJpHNcUkY8LMHMjv30faboh46tWRKMvqoK8L1Gfae/DrBpD0mdWhzkGGE
 zH3mmPn1le30ppBE67LYmTcRw6mU4Og8UxtJqEuU0lwA+lygnAXSVlpoS1TfsVvnimtcycPdZDs
 PLOIvUR0kFRPtT7D0Lz60P8xzckhJUd9OsuSjLwN1fkwM+A+O+LmR1NZn2P+Y5UA321F3w0lBHC
 Ji28wUMgpqUu1zRo0++FILvBK6MTUXgF8hl0qZ2fkf7qnzIV/xpyKcWTBGXIY7QGTfmW3ayWlGK
 WoJufZLlw9zfkKwfhcJy4Und4BCyJyuMtSw53+QCYQNgWCdMTvxnKmxPi2ALfvTneu6Wb25OXUp
 izitxzgYrXQAYbN5CY6fmYZAk0wh6Tyc4gfnwvK1ZZXlup3DPE+HklbUbBhAYwQtGQiodH8G7AZ
 EyoOwv8SnPl5aPkp3TQ==
X-Authority-Analysis: v=2.4 cv=UqZT8ewB c=1 sm=1 tr=0 ts=6a1fba20 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=DISFzqtZAAAA:8 a=EUspDBNiAAAA:8 a=jjORMhuGWfTR70FdTIQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=aug85vrO5LANNmmtkfAW:22
X-Proofpoint-ORIG-GUID: v167TacR9jVOg5ZA4wnTUTFnNVjgdeV0
X-Proofpoint-GUID: v167TacR9jVOg5ZA4wnTUTFnNVjgdeV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030048

On 20-05-2026 21:17, Tomeu Vizoso wrote:
> On Wed, May 20, 2026 at 4:12 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>
>> On Tue, May 19, 2026 at 11:45:52AM +0530, Ekansh Gupta via B4 Relay wrote:
>>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>>
>>> Add documentation for the Qualcomm DSP Accelerator (QDA) driver under
>>> Documentation/accel/qda/. The documentation covers the driver
>>> architecture, GEM-based buffer management, IOMMU context bank
>>> isolation, and the RPMsg transport layer.
>>>
>>> The user-space API section describes the DRM IOCTLs for session
>>> management, GEM buffer allocation, and remote procedure invocation via
>>> the FastRPC protocol, along with a typical application lifecycle
>>> example. Sections for dynamic debug and basic testing are also
>>> included.
>>>
>>> Wire the new documentation into the Compute Accelerators index at
>>> Documentation/accel/index.rst.
>>>
>>> Assisted-by: Claude:claude-4-6-sonnet
>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>> ---
>>>  Documentation/accel/index.rst     |   1 +
>>>  Documentation/accel/qda/index.rst |  13 ++++
>>>  Documentation/accel/qda/qda.rst   | 146 ++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 160 insertions(+)
>>>
>>> diff --git a/Documentation/accel/index.rst b/Documentation/accel/index.rst
>>> index cbc7d4c3876a..5901ea7f784c 100644
>>> --- a/Documentation/accel/index.rst
>>> +++ b/Documentation/accel/index.rst
>>> @@ -10,4 +10,5 @@ Compute Accelerators
>>>     introduction
>>>     amdxdna/index
>>>     qaic/index
>>> +   qda/index
>>>     rocket/index
>>> diff --git a/Documentation/accel/qda/index.rst b/Documentation/accel/qda/index.rst
>>> new file mode 100644
>>> index 000000000000..013400cf9c25
>>> --- /dev/null
>>> +++ b/Documentation/accel/qda/index.rst
>>> @@ -0,0 +1,13 @@
>>> +.. SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +==================================
>>> +accel/qda Qualcomm DSP Accelerator
>>> +==================================
>>> +
>>> +The QDA driver provides a DRM accel based interface for Qualcomm DSP offload.
>>> +It uses the FastRPC protocol and integrates with DRM and GEM infrastructure
>>> +for device and buffer management.
>>> +
>>> +.. toctree::
>>> +
>>> +   qda
>>> diff --git a/Documentation/accel/qda/qda.rst b/Documentation/accel/qda/qda.rst
>>> new file mode 100644
>>> index 000000000000..9f49af6e6acc
>>> --- /dev/null
>>> +++ b/Documentation/accel/qda/qda.rst
>>> @@ -0,0 +1,146 @@
>>> +.. SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +=====================================
>>> +Qualcomm DSP Accelerator (QDA) Driver
>>> +=====================================
>>> +
>>> +Introduction
>>> +============
>>> +
>>> +The QDA driver is a DRM accel driver for Qualcomm's DSPs. It provides a
>>> +DRM accel based interface for Qualcomm DSP offload, supporting workloads
>>> +such as AI inference, computer vision, audio processing, and sensor offload
>>> +on Qualcomm SoCs. It uses the FastRPC protocol and integrates with DRM and
>>> +GEM infrastructure for device and buffer management.
>>> +
>>> +Key Features
>>> +============
>>> +
>>> +*   **DRM accel Interface**: Exposes a standard character device node
>>> +    (e.g., ``/dev/accel/accel0``) via the DRM accel subsystem.
>>> +*   **FastRPC Protocol**: Implements the FastRPC protocol for communication
>>> +    between the application processor and the DSP.
>>> +*   **GEM Buffer Management**: Uses the DRM GEM interface for buffer
>>> +    allocation, lifecycle management, and DMA-BUF import/export.
>>> +*   **IOMMU Isolation**: Uses IOMMU context banks to enforce memory isolation
>>> +    between different DSP user sessions.
>>> +*   **Modular Design**: Clean separation between the core DRM logic, the
>>> +    memory manager, and the RPMsg-based transport layer.
>>> +
>>> +Architecture
>>> +============
>>> +
>>> +The QDA driver consists of several functional blocks:
>>> +
>>> +1.  **Core Driver (``qda_drv``)**: Manages device registration, file operations,
>>> +    and DRM accel integration.
>>> +2.  **Memory Manager (``qda_memory_manager``)**: A flexible memory management
>>> +    layer that handles IOMMU context banks. It supports pluggable backends
>>> +    (such as DMA-coherent) to adapt to different SoC memory architectures.
>>> +3.  **GEM Subsystem**: Implements the DRM GEM interface for buffer management:
>>> +
>>> +    * **``qda_gem``**: Core GEM object management, including allocation, mmap
>>> +      operations, and buffer lifecycle management.
>>> +    * **``qda_prime``**: PRIME import functionality for DMA-BUF interoperability
>>> +      with other kernel subsystems.
>>> +
>>> +4.  **Transport Layer (``qda_rpmsg``)**: Abstraction over the RPMsg framework
>>> +    to handle low-level message passing with the DSP firmware.
>>> +5.  **Compute Bus (``qda_compute_bus``)**: A custom virtual bus used to
>>> +    enumerate and manage the specific compute context banks defined in the
>>> +    device tree. The bus was introduced because IOMMU context banks (CBs) are
>>> +    synthetic constructs — not real platform devices — making a platform driver
>>> +    an incorrect abstraction for them. The earlier platform-driver approach also
>>> +    had a race condition: device nodes were created before the RPMsg channel
>>> +    resources were fully initialized, and because ``probe`` runs asynchronously,
>>> +    applications could open a CB device and attempt to start a session before
>>> +    the underlying transport was ready. The compute bus makes CB lifetime
>>> +    explicitly subordinate to the parent QDA device, closing that window.
>>> +6.  **FastRPC Core (``qda_fastrpc``)**: Implements the protocol logic for
>>> +    marshalling arguments and handling remote invocations.
>>> +
>>> +User-Space API
>>> +==============
>>> +
>>> +The driver exposes a set of DRM-compliant IOCTLs:
>>> +
>>> +*   ``DRM_IOCTL_QDA_QUERY``: Query DSP type (e.g., "cdsp", "adsp")
>>> +    and capabilities.
>>> +*   ``DRM_IOCTL_QDA_REMOTE_SESSION_CREATE``: Initialize a new process context
>>> +    on the DSP.
>>> +*   ``DRM_IOCTL_QDA_REMOTE_INVOKE``: Submit a remote method invocation (the
>>> +    primary execution unit).
>>> +*   ``DRM_IOCTL_QDA_GEM_CREATE``: Allocate a GEM buffer object for DSP usage.
>>> +*   ``DRM_IOCTL_QDA_GEM_MMAP_OFFSET``: Retrieve mmap offsets for memory mapping.
>>> +*   ``DRM_IOCTL_QDA_REMOTE_MAP`` / ``DRM_IOCTL_QDA_REMOTE_MUNMAP``: Map or unmap
>>> +    buffers into the DSP's virtual address space. Each accepts a ``request``
>>> +    field selecting between a legacy operation (``QDA_MAP_REQUEST_LEGACY`` /
>>> +    ``QDA_MUNMAP_REQUEST_LEGACY``) and an attribute-based operation
>>> +    (``QDA_MAP_REQUEST_ATTR`` / ``QDA_MUNMAP_REQUEST_ATTR``).
>>
>> Explain, what happens in the users don't map the buffers into the DSP
>> space. Will DRM_IOCTL_QDA_REMOTE_INVOKE handle the mapping or not? What
>> is the difference between those two modes?
>>
>> Would the driver benefit from using GPUVM?
>>
>>> +
>>> +Usage Example
>>> +=============
>>> +
>>> +A typical lifecycle for a user-space application:
>>> +
>>> +1.  **Discovery**: Open ``/dev/accel/accel*`` and use
>>> +    ``DRM_IOCTL_QDA_QUERY`` to identify the DSP domain served by that
>>> +    device node.
>>> +2.  **Initialization**: Call ``DRM_IOCTL_QDA_REMOTE_SESSION_CREATE`` to
>>> +    establish a session and create a process context on the DSP.
>>> +3.  **Memory**: Allocate buffers via ``DRM_IOCTL_QDA_GEM_CREATE`` or import
>>> +    DMA-BUFs (PRIME fd) from other drivers using ``DRM_IOCTL_PRIME_FD_TO_HANDLE``.
>>> +4.  **Execution**: Use ``DRM_IOCTL_QDA_REMOTE_INVOKE`` to pass arguments and
>>> +    execute functions on the DSP.
>>> +5.  **Cleanup**: Close file descriptors to automatically release resources and
>>> +    detach the session.
>>
>> I'd have expected the description of the actual example. I.e. clone the
>> app from https://the.addr, prepare clang >= NN.MM, QAIC (https://foo),
>> run make, run the app, check the results. I'd remind that DRM Accel has
>> a very specific requirement of having the working toolhain in the
>> open-source.
> 
> We have been getting submissions lately that don't fulfill that
> requirement so I will point to the precise part of the documentation
> that explains it:
> 
> https://www.kernel.org/doc/html/latest/gpu/drm-uapi.html#open-source-userspace-requirements
> 
> For an example of a submissions that complies, see:
> 
> https://lore.kernel.org/dri-devel/20260114-thames-v2-0-e94a6636e050@tomeuvizoso.net/
> 
> Most importantly, notice how the proposed Thames Mesa driver generates
> machine code for all the hardware units, and doesn't use any blob for
> that.
> 
I believe QDA checks all boxes for accel, as there is available
opensource userspace, opensource QAIC compiler for IDL compilation and
LLVM supports hexagon arch.

I'll try adding these details as well.

Thanks!> Regards,
> 
> Tomeu
> 
>>> +
>>> +Internal Implementation
>>> +=======================
>>> +
>>> +Memory Management
>>> +-----------------
>>> +The driver's memory manager creates virtual "IOMMU devices" that map to
>>> +hardware context banks. This allows the driver to manage multiple isolated
>>> +address spaces. The implementation uses a DMA-coherent backend to ensure data consistency
>>> +between the CPU and DSP without manual cache maintenance in most cases.
>>
>> GEM usage?
>>
>>> +
>>> +Debugging
>>> +=========
>>> +The driver includes extensive dynamic debug support. Enable it via the
>>> +kernel's dynamic debug control:
>>> +
>>> +.. code-block:: bash
>>> +
>>> +    echo "file drivers/accel/qda/* +p" > /sys/kernel/debug/dynamic_debug/control
>>> +
>>> +Testing
>>> +=======
>>> +The QDA driver can be exercised using the ``fastrpc_test`` utility from the
>>> +FastRPC userspace library. Run the test application:
>>
>> pointer
>>
>>> +
>>> +.. code-block:: bash
>>> +
>>> +    fastrpc_test -d 3 -U 1 -t linux -a v68
>>> +
>>> +**Options**
>>> +
>>> +``-d domain``
>>> +    Select the DSP domain to run on:
>>> +
>>> +    * ``0`` — ADSP
>>> +    * ``1`` — MDSP
>>> +    * ``2`` — SDSP
>>> +    * ``3`` — CDSP *(default on targets with CDSP)*
>>> +
>>> +``-U unsigned_PD``
>>> +    Select signed or unsigned protection domain:
>>> +
>>> +    * ``0`` — signed PD
>>> +    * ``1`` — unsigned PD *(default)*
>>> +
>>> +``-t target``
>>> +    Target platform: ``android`` or ``linux`` *(default: linux)*
>>> +
>>> +``-a arch_version``
>>> +    DSP architecture version, e.g. ``v68``, ``v75`` *(default: v68)*
>>>
>>> --
>>> 2.34.1
>>>
>>>
>>
>> --
>> With best wishes
>> Dmitry

