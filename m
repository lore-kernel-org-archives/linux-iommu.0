Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C7D28C2A1
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 05:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780463969; cv=none; b=qBsVJmGHGkdlTVYvWd+DowM6DBUVPepPfV9Oqz4ozbpvTl8By+08eEzeOiz/rt2uA6q1mNBPYYMuCa4e7ZaGMjRR3f9oNNPjWUBa5lCJ7N1S0JNKOqrlH3lwYiXSC7tUneYx/Wyt+9YzwDIv82Bl3XjYyoSH2AXvOHE7qrocXz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780463969; c=relaxed/simple;
	bh=ernpbc8mYW3pnQ6ReVEaUvPZ/tMCJlEDj12Fyv3+pSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFfAU5zOMVranq3QPZDgw8cyA5ejN73PQawb2UePKMiNnr72Ux5ULihBV/FtJHViWan8OH10FpnSNCTnXx/NmyVQU36TcgkmqB+mm3TkOn/cQIVCYqvDFMfjan7y145614U3/7+86AztCUMu0Wb/6HVV1eAVdVgf+6rEkuhCmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tz4k9u8e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DpmaSpb2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tz4k9u8e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DpmaSpb2"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65318Pua1260400
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 05:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jOezco5+6BfmrPgKfWENo0B2DWVFkDWfjF+LxPufsWM=; b=Tz4k9u8ewVkJrO5B
	99GB3NoAxaV/ZgnBI5djpO9t9CiuxBOwWbgiYZ15Dou2NkfUl8fwbVqvcH43VPdv
	CbvtGdm5wm1S3ktWSq+pyilEiuMMVToFEPobSTan3F5560/XS80pGmmVW5AVHTka
	O/8ly7e9RsUFprK66xn7pC6IE/4WSSuiMoOzXQeNBZA9BdpGzL0Ruv7bIJaWERnR
	odTUeR0vun/2F2aJVwrX5Lj/iykCVQFntqTduXCHhVjh1peZZaYQhw4J+Ygb5VP+
	qxFlqBpRupSQbHc59MIYsSyr4/NOmG4Txf3R0iRg1a5Tb03mfXePTk1nxr3pyR1o
	J6EcXQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejabggs1h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 05:19:27 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36bc02d28b6so4143036a91.3
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 22:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780463966; x=1781068766; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOezco5+6BfmrPgKfWENo0B2DWVFkDWfjF+LxPufsWM=;
        b=DpmaSpb2HQX4k1eT1LzvN8wGv+SuIXQj26Y3zzdP+S4NHy3F2JIyS48MsR0CJrt8fq
         t8L6COaNY9LbLGMvlVuJ8V402tijtDSngziEwfXrc56jvpnmFKffIW9lD0frZ/zw3haG
         tT1/c8U2pCJZWcgSZXFIXzyQFFS4cnMUKWUOkVp77OXAKdO5aKVwX2S9YMzGXlT1G25x
         +xw2tFQVbjQD6m6X/x3mqIeMpr44ZPJFKlohY2mjHEiZJOD8pH/synEbPBQ94c4/7EsD
         +RRTb7F+oZr7T3KqcpZLHHCMa0Z2OHn1LIo8WfU+dWNiO9+AUYyEoFk8raGrhu9pQgo3
         jQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780463966; x=1781068766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOezco5+6BfmrPgKfWENo0B2DWVFkDWfjF+LxPufsWM=;
        b=SSV6shQ37H7Veo0A88D7UFo6P4Y+hk7IkYu9N6u9pzBkKnVNVGLfCXQ8gFTut50qIU
         iy5hG8XMSnOCOBWVy5n1EzkCJVbDnnz3vZjNNVN/3BWXtCnR22InyXOFGpYkhFmAY7vm
         XkrWDd/ndyr55jsoaDJcX9MiIeYL9Zgi0snHhuP2d+b2+spc/rKip3vPfnZOuyO4uSrV
         dPPu64cFNUmuJUnKAY1Cv/q/AtZIfrbIbwXOTP16l8nNe3paXEmIwUoBpqmkN6E4z2zB
         cMPkRDcqlIXMdEpbwkRk1vdWOoF1UkWbxGy5cGVZ53qfUka+viAhBbKZQfYLG/hC1e41
         NiAA==
X-Forwarded-Encrypted: i=1; AFNElJ+btM0ceFvVB74rsVVvPHwI3jWCOhPoYcFJZgqQC7CB2aqeGLYFLIAu0f+v7aU3Zcm4EgObQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnKZ4YGk+NZyRdUnRg8xJw6EdB8nNSr0OyFCzjlSPnhOZYke2h
	PXPcu82TXy2XbHQJyxoYQxQlMZA+FStbG6TDPEnrdR6fAWn6/neuV2nsdBgCZaT2QcFRHY8LUhO
	p6wTSsjfvfPKLqm4n198F3PJEa72Kz2I0WLMMvJGlpKIKMlvjAjr9gi2ujA==
X-Gm-Gg: Acq92OGcd3kbacNhw5o12YuTjNbdpqn3kisjvXjs/mD5l2x/uRVtF5ByzNL2Rtt87yz
	JPeW/bz+uIcu+r9CdeexvjA3PQ4YY1oMn/UzMjkr5WIlXJB6wA8HrGKAiWVYsUFFfmaXfaQB//x
	9YruFIAtuL7ZV4TnpTiCVUJoqQTtaiZi+G1x2qVK6NRhdIwcSX1xyqQqJ7zzIOqVu0Jt7J79MqN
	ZJ29nhtsiIi5okoqq/R7NKPLitNAqUEFuKIjpe6ceNlalNskr3IBpY9O7S+UBqgqO+JQr6i96/z
	qYqvvW8t0ysqqLegG2cMhPQ+1Bua9pVJIO+/YbI/Unus84OIPWWJwbc4Uh+zs9e9XlbyuCajSCy
	VBeuu7JhCmM2O87axOj8j1woU1aVTYH8tzKuRk+wqDv89C1CLvY6gTNL1pWcY
X-Received: by 2002:a17:90b:540c:b0:368:5367:d679 with SMTP id 98e67ed59e1d1-36e2f3c32demr2076750a91.9.1780463966262;
        Tue, 02 Jun 2026 22:19:26 -0700 (PDT)
X-Received: by 2002:a17:90b:540c:b0:368:5367:d679 with SMTP id 98e67ed59e1d1-36e2f3c32demr2076710a91.9.1780463965719;
        Tue, 02 Jun 2026 22:19:25 -0700 (PDT)
Received: from [10.204.78.54] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a14485esm1695509a91.3.2026.06.02.22.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 22:19:25 -0700 (PDT)
Message-ID: <77511905-1dac-4605-8195-68ec770740d2@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 10:49:15 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] accel/qda: Add QDA driver documentation
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <paiohsil5pmvm7cf6jxrhaj2225bgvlt3scrag4x6gbkyosow5@l4tbakbnxcvo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R6sz39RX c=1 sm=1 tr=0 ts=6a1fb95f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=yE1-P__lAf5keu_9ItMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 4HwfO5bf1egYaqhv5DgUkzk1yZFHXe-_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA0NyBTYWx0ZWRfX48N8NWeR6RJe
 YYfCjVgII91/FLmOMb2BN9wkPV0UolfwhavBifqSw1mqje3cunSEdr5AJOk/RBqniD5DFVx4slR
 hoL/1NDnN+QUuA/bYsy/AG3e2SpTvXT4d5LSl8D2ceTKHyWMyF6A6IUrJrqu0kSe+OpeaAJZQ0q
 r7oNMo6NYjW+8hyUO4BSr3RT48x8nSbQwlGEftnysieB7aNLIb7XFQjnOwv3nVbkHEp95m7FKh6
 qef4b/Cdnwlkby57PwjhV/eS0TUGHEpQXSXg0GsxZvb1dJquB+EafBY9FwXkGUTOiohJlI3PRLS
 rrz5U1HtfMDcJY6ANvGJydTta2oEIsxDDuyDeM7jHhkIFb5uOf3Py6QjfnqD/bZ4bnMeOf7lSJ8
 gBQUZH7GtlFi7RtJnP5iroMWBXtU2iC2HCyYS8zsYyWKzegBmnVGWWwuc/5hb9WwHtv+1RZBeO1
 sJnIaMJ/BN6IJB+eNdg==
X-Proofpoint-ORIG-GUID: 4HwfO5bf1egYaqhv5DgUkzk1yZFHXe-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030047

On 20-05-2026 19:42, Dmitry Baryshkov wrote:
> On Tue, May 19, 2026 at 11:45:52AM +0530, Ekansh Gupta via B4 Relay wrote:
>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>
>> Add documentation for the Qualcomm DSP Accelerator (QDA) driver under
>> Documentation/accel/qda/. The documentation covers the driver
>> architecture, GEM-based buffer management, IOMMU context bank
>> isolation, and the RPMsg transport layer.
>>
>> The user-space API section describes the DRM IOCTLs for session
>> management, GEM buffer allocation, and remote procedure invocation via
>> the FastRPC protocol, along with a typical application lifecycle
>> example. Sections for dynamic debug and basic testing are also
>> included.
>>
>> Wire the new documentation into the Compute Accelerators index at
>> Documentation/accel/index.rst.
>>
>> Assisted-by: Claude:claude-4-6-sonnet
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  Documentation/accel/index.rst     |   1 +
>>  Documentation/accel/qda/index.rst |  13 ++++
>>  Documentation/accel/qda/qda.rst   | 146 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 160 insertions(+)
>>
>> diff --git a/Documentation/accel/index.rst b/Documentation/accel/index.rst
>> index cbc7d4c3876a..5901ea7f784c 100644
>> --- a/Documentation/accel/index.rst
>> +++ b/Documentation/accel/index.rst
>> @@ -10,4 +10,5 @@ Compute Accelerators
>>     introduction
>>     amdxdna/index
>>     qaic/index
>> +   qda/index
>>     rocket/index
>> diff --git a/Documentation/accel/qda/index.rst b/Documentation/accel/qda/index.rst
>> new file mode 100644
>> index 000000000000..013400cf9c25
>> --- /dev/null
>> +++ b/Documentation/accel/qda/index.rst
>> @@ -0,0 +1,13 @@
>> +.. SPDX-License-Identifier: GPL-2.0-only
>> +
>> +==================================
>> +accel/qda Qualcomm DSP Accelerator
>> +==================================
>> +
>> +The QDA driver provides a DRM accel based interface for Qualcomm DSP offload.
>> +It uses the FastRPC protocol and integrates with DRM and GEM infrastructure
>> +for device and buffer management.
>> +
>> +.. toctree::
>> +
>> +   qda
>> diff --git a/Documentation/accel/qda/qda.rst b/Documentation/accel/qda/qda.rst
>> new file mode 100644
>> index 000000000000..9f49af6e6acc
>> --- /dev/null
>> +++ b/Documentation/accel/qda/qda.rst
>> @@ -0,0 +1,146 @@
>> +.. SPDX-License-Identifier: GPL-2.0-only
>> +
>> +=====================================
>> +Qualcomm DSP Accelerator (QDA) Driver
>> +=====================================
>> +
>> +Introduction
>> +============
>> +
>> +The QDA driver is a DRM accel driver for Qualcomm's DSPs. It provides a
>> +DRM accel based interface for Qualcomm DSP offload, supporting workloads
>> +such as AI inference, computer vision, audio processing, and sensor offload
>> +on Qualcomm SoCs. It uses the FastRPC protocol and integrates with DRM and
>> +GEM infrastructure for device and buffer management.
>> +
>> +Key Features
>> +============
>> +
>> +*   **DRM accel Interface**: Exposes a standard character device node
>> +    (e.g., ``/dev/accel/accel0``) via the DRM accel subsystem.
>> +*   **FastRPC Protocol**: Implements the FastRPC protocol for communication
>> +    between the application processor and the DSP.
>> +*   **GEM Buffer Management**: Uses the DRM GEM interface for buffer
>> +    allocation, lifecycle management, and DMA-BUF import/export.
>> +*   **IOMMU Isolation**: Uses IOMMU context banks to enforce memory isolation
>> +    between different DSP user sessions.
>> +*   **Modular Design**: Clean separation between the core DRM logic, the
>> +    memory manager, and the RPMsg-based transport layer.
>> +
>> +Architecture
>> +============
>> +
>> +The QDA driver consists of several functional blocks:
>> +
>> +1.  **Core Driver (``qda_drv``)**: Manages device registration, file operations,
>> +    and DRM accel integration.
>> +2.  **Memory Manager (``qda_memory_manager``)**: A flexible memory management
>> +    layer that handles IOMMU context banks. It supports pluggable backends
>> +    (such as DMA-coherent) to adapt to different SoC memory architectures.
>> +3.  **GEM Subsystem**: Implements the DRM GEM interface for buffer management:
>> +
>> +    * **``qda_gem``**: Core GEM object management, including allocation, mmap
>> +      operations, and buffer lifecycle management.
>> +    * **``qda_prime``**: PRIME import functionality for DMA-BUF interoperability
>> +      with other kernel subsystems.
>> +
>> +4.  **Transport Layer (``qda_rpmsg``)**: Abstraction over the RPMsg framework
>> +    to handle low-level message passing with the DSP firmware.
>> +5.  **Compute Bus (``qda_compute_bus``)**: A custom virtual bus used to
>> +    enumerate and manage the specific compute context banks defined in the
>> +    device tree. The bus was introduced because IOMMU context banks (CBs) are
>> +    synthetic constructs — not real platform devices — making a platform driver
>> +    an incorrect abstraction for them. The earlier platform-driver approach also
>> +    had a race condition: device nodes were created before the RPMsg channel
>> +    resources were fully initialized, and because ``probe`` runs asynchronously,
>> +    applications could open a CB device and attempt to start a session before
>> +    the underlying transport was ready. The compute bus makes CB lifetime
>> +    explicitly subordinate to the parent QDA device, closing that window.
>> +6.  **FastRPC Core (``qda_fastrpc``)**: Implements the protocol logic for
>> +    marshalling arguments and handling remote invocations.
>> +
>> +User-Space API
>> +==============
>> +
>> +The driver exposes a set of DRM-compliant IOCTLs:
>> +
>> +*   ``DRM_IOCTL_QDA_QUERY``: Query DSP type (e.g., "cdsp", "adsp")
>> +    and capabilities.
>> +*   ``DRM_IOCTL_QDA_REMOTE_SESSION_CREATE``: Initialize a new process context
>> +    on the DSP.
>> +*   ``DRM_IOCTL_QDA_REMOTE_INVOKE``: Submit a remote method invocation (the
>> +    primary execution unit).
>> +*   ``DRM_IOCTL_QDA_GEM_CREATE``: Allocate a GEM buffer object for DSP usage.
>> +*   ``DRM_IOCTL_QDA_GEM_MMAP_OFFSET``: Retrieve mmap offsets for memory mapping.
>> +*   ``DRM_IOCTL_QDA_REMOTE_MAP`` / ``DRM_IOCTL_QDA_REMOTE_MUNMAP``: Map or unmap
>> +    buffers into the DSP's virtual address space. Each accepts a ``request``
>> +    field selecting between a legacy operation (``QDA_MAP_REQUEST_LEGACY`` /
>> +    ``QDA_MUNMAP_REQUEST_LEGACY``) and an attribute-based operation
>> +    (``QDA_MAP_REQUEST_ATTR`` / ``QDA_MUNMAP_REQUEST_ATTR``).
> 
> Explain, what happens in the users don't map the buffers into the DSP
> space. Will DRM_IOCTL_QDA_REMOTE_INVOKE handle the mapping or not? What
> is the difference between those two modes?
I'll add more details for this, this is specifically required when
persistent type of DSP mappings are required.>
> Would the driver benefit from using GPUVM?
I'm not exactly sure how this will fit in here, I'll check this and get
back.>
>> +
>> +Usage Example
>> +=============
>> +
>> +A typical lifecycle for a user-space application:
>> +
>> +1.  **Discovery**: Open ``/dev/accel/accel*`` and use
>> +    ``DRM_IOCTL_QDA_QUERY`` to identify the DSP domain served by that
>> +    device node.
>> +2.  **Initialization**: Call ``DRM_IOCTL_QDA_REMOTE_SESSION_CREATE`` to
>> +    establish a session and create a process context on the DSP.
>> +3.  **Memory**: Allocate buffers via ``DRM_IOCTL_QDA_GEM_CREATE`` or import
>> +    DMA-BUFs (PRIME fd) from other drivers using ``DRM_IOCTL_PRIME_FD_TO_HANDLE``.
>> +4.  **Execution**: Use ``DRM_IOCTL_QDA_REMOTE_INVOKE`` to pass arguments and
>> +    execute functions on the DSP.
>> +5.  **Cleanup**: Close file descriptors to automatically release resources and
>> +    detach the session.
> 
> I'd have expected the description of the actual example. I.e. clone the
> app from https://the.addr, prepare clang >= NN.MM, QAIC (https://foo),
> run make, run the app, check the results. I'd remind that DRM Accel has
> a very specific requirement of having the working toolhain in the
> open-source.
ack>
>> +
>> +Internal Implementation
>> +=======================
>> +
>> +Memory Management
>> +-----------------
>> +The driver's memory manager creates virtual "IOMMU devices" that map to
>> +hardware context banks. This allows the driver to manage multiple isolated
>> +address spaces. The implementation uses a DMA-coherent backend to ensure data consistency
>> +between the CPU and DSP without manual cache maintenance in most cases.
> 
> GEM usage?
I'll add the details here.>
>> +
>> +Debugging
>> +=========
>> +The driver includes extensive dynamic debug support. Enable it via the
>> +kernel's dynamic debug control:
>> +
>> +.. code-block:: bash
>> +
>> +    echo "file drivers/accel/qda/* +p" > /sys/kernel/debug/dynamic_debug/control
>> +
>> +Testing
>> +=======
>> +The QDA driver can be exercised using the ``fastrpc_test`` utility from the
>> +FastRPC userspace library. Run the test application:
> 
> pointer
ack.>
>> +
>> +.. code-block:: bash
>> +
>> +    fastrpc_test -d 3 -U 1 -t linux -a v68
>> +
>> +**Options**
>> +
>> +``-d domain``
>> +    Select the DSP domain to run on:
>> +
>> +    * ``0`` — ADSP
>> +    * ``1`` — MDSP
>> +    * ``2`` — SDSP
>> +    * ``3`` — CDSP *(default on targets with CDSP)*
>> +
>> +``-U unsigned_PD``
>> +    Select signed or unsigned protection domain:
>> +
>> +    * ``0`` — signed PD
>> +    * ``1`` — unsigned PD *(default)*
>> +
>> +``-t target``
>> +    Target platform: ``android`` or ``linux`` *(default: linux)*
>> +
>> +``-a arch_version``
>> +    DSP architecture version, e.g. ``v68``, ``v75`` *(default: v68)*
>>
>> -- 
>> 2.34.1
>>
>>
> 

