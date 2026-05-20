Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8803E95BD
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286348; cv=none; b=poJQaiGTOGsY0R7rauRCuCIkdolaEURnCMByzIjY9P80YFFIwygP823kUS5UI13t8MN0z5BeqsX5+1VBGF4Kc0vE1EjWuI6Zc1aiW+w3XqQ+AkRvgg5J8Uh/WQpolB28ENy++aJ5XC1VLjMUNGwkg8YmmXunl0JmAQuNhI/fbcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286348; c=relaxed/simple;
	bh=phSB63IMl2A6TqoNdQoL+sK0co7BbyjOBYGwKZxoYCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6sDhJDyIYdlVfWJ+DsdjJ769bc9Jv91OGhQMIqZ3rw+PcEQ6ZRaXoacDDpCVUeXt08Vxr6XSfShLzQfqDbuKagGFlzCZM0bG+x1xDzvM3dgsD1+W843fm5Iio4ew+MWKE2klmpYsZwLsBmOahmWhBHXhsU8Y8GXf6LRfGHbaaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cSDgISG+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jf+PNpzm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cSDgISG+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jf+PNpzm"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDXhRZ1798400
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fjc/US0eOmCaq8NJVQ5/t7CluwSHuURJ7uN+zaRxrGg=; b=cSDgISG+AOhCmG7R
	DKix72vBfFMmRS7S5JLtuxJgxQ5rA/o91om6pqfXovLaO82aNU3pJLEx7Gv0w3Ug
	qklISnqIKD1ip2d4rvBvU+6XC7jC9BWp+gRYSFso1oPY6GoHyKUX47jeqU9hr37g
	8pWE99iqikCzwkoGHLhOJd11rwpLAsHX9X/w7Lek/kn7r5oD+xRa0sJXoOVy/WnM
	NV+qkDCcoAS8bHvgs08mfpJZKKDCqHndlwYjJWsFwgx1my1puF+DciEmUIXIs2rN
	km8/aItafF6gKi9C0DxV81h2ZXVjN04qiOwEdHsHyj4VN2y+BPsuO4z755cJEnAz
	b6Bgdg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9dxu04f6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:12:25 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-56f69a1a9f5so15411482e0c.1
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779286344; x=1779891144; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fjc/US0eOmCaq8NJVQ5/t7CluwSHuURJ7uN+zaRxrGg=;
        b=Jf+PNpzmgydBqujJf2WiOpLyrZFMj8u5P4avhuLO9HFA8AF7JpVJhxplJ6MZ5fnv81
         P136QYy8j98LhQ0NpcWXAW8QHdpwj/oSNtkD2XCAtC+hfidAqzjB94wy5HDhdcV92B/K
         I9OB8UVuAnLvXRRcA9MG7Cw5cJbddy/gws8c6bDWEd9W4B5vnjpKD3XF7lNG8fvWK3uS
         x4yXt9ntI4FaLHdxMYozCUY1NAICYwznMjH6DLawaqzLbohNbvXPeiL8+9W9dDf4uYZV
         YeIL9QQbOwXIroZLG7XXzJ6bfEqZID2bBCB9UNfqxOG1M5ExVamgsyZ/1Nz+7gWv3oEu
         jVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286344; x=1779891144;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fjc/US0eOmCaq8NJVQ5/t7CluwSHuURJ7uN+zaRxrGg=;
        b=iLDBtWbVY3TFQ/zeWAskH3NKnK1krWg0mK8WcO7NnjEDVT+6RamIh9EKlU8HlkegTd
         irPK5Tle+Z06mlmvbgnz3h4rjh25PKlyFV8amGB0RtYj6d8Iu88Uwy0a5oped0xFZ+aW
         ID1RWyMoNDaCuGM9SBCIkzu0mom7+VpnbOwo/aG7bo0PD9VyTqdmcHqGyeqo3e+oJJpN
         BHJMx48v5Rxw7xnM5fQoNAhbVcR5et+/gavoiIFJGv2c3Sk9qLJasVD+AzH0eWUx4e7r
         kvTZDo2mH9S1IvSmUGSBRD3ISTOGi7aQ8witNcaBFcslpMi1PHWb0wrRDO6AcvNpNoRe
         ZHNQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dyZWiLfZiFh26Ful2Mb2i/yfRTE8ZXPRPpXNYZtfmtT4YVQLZ2xre52YeEJ9skohKG+Z/yw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJo2/6CVmKrWCwXkhKGxTesPDBc7nlZ0a72j0EeFBfAKo0ar40
	cv1FFHFngNAzu8JKjFKbQmOMdjMHc42J2behDSGWDp51f2gpWTLn6da9ZEJb/5+mAF/io26u8Lw
	+92qb1gJzci8Ww6+0iy0Ro7K1fbuO1g6/UxO52YP+Od2ClUdm6NB4tjAw7A==
X-Gm-Gg: Acq92OF3ScIS3NfuhEtNdZqtPALIHjEJlLk1QycrKuXGLR5UNU+iZ/tpcXaUwgGVcE1
	IQ+FALKS6WtHBohNOAm6tKuGF4nEXlQAwMDl8yPEwMDYsPmTlf6eHRDmG1068h69PLbv5Ez80yM
	wGtAvIHlKXiSryilJWzOj6H1Vo+KHZBEP2SEAz/RLZRH1pTv33gX2wXgMz1XAb84ajXCj1Amh3O
	OWXo9kfRzwjY4wwqwOuMYuqpUm3cXSWWRMVP2+7mXFDps0a0whaa11ovPbQP4U9CnjgwezU+Bh/
	bJ+a1I7Jx/Kr5iBcvyYyBfP9l5xQY3QyRyL2vU5oKUSEy2pTlIgrdLTG3wJvGPsMLa/zTGt6UFa
	X1/sNLF3oqPDF6PdxDwAaBUUE48T5QzHcQG5aMp/82mCF8orw9DuV6NExJl+WP9TNcSt04HKASB
	7AXHVVb73AoAT2nmzd5BDpodvhkYx7s/k8ZeE=
X-Received: by 2002:a05:6122:2676:b0:57d:6d56:11ff with SMTP id 71dfb90a1353d-57d6d56133cmr2372269e0c.9.1779286343937;
        Wed, 20 May 2026 07:12:23 -0700 (PDT)
X-Received: by 2002:a05:6122:2676:b0:57d:6d56:11ff with SMTP id 71dfb90a1353d-57d6d56133cmr2372208e0c.9.1779286343311;
        Wed, 20 May 2026 07:12:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164cec52sm4960154e87.72.2026.05.20.07.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:12:22 -0700 (PDT)
Date: Wed, 20 May 2026 17:12:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: ekansh.gupta@oss.qualcomm.com
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 02/15] accel/qda: Add QDA driver documentation
Message-ID: <paiohsil5pmvm7cf6jxrhaj2225bgvlt3scrag4x6gbkyosow5@l4tbakbnxcvo>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-2-b2d984c297f8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519-qda-series-v1-2-b2d984c297f8@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzOCBTYWx0ZWRfX7LDbQoT3R5im
 TY58HJ3TEHQtFnjLwNFMrdveBhlL5L8zqfQXlyVcLWCTYO3E7D3eW+45r5T6SwUwc8yHBNHu+rg
 ntt/WJ5CqIqn96NVnC0EDoQc2eM87FCQlNGnSpt+P+eRIU5EcFuuvjfrZZRq+J7c7I8jPJ79yfI
 dH06RXtSq27cYx5t+Qp3mc8xoOXNfwL7XBYy++06rfEtVLih6fIRrhYywqfoZieD1bKAP6NMFtv
 Hlg3mb+0KzBJ0eedx/wj+2O7Wh7PckANZtS1YI6HA/ECi9A4Fo5yhypoVu5EIdk/nX00v/JgLZ2
 QCPgmiyEZdYSFXj1UtXptEJeJMb2U/dGDzcVU5YeZoobbcKtSqPBSX7ECV9pMZ+iPVuFg4jvZHd
 xFw2cMeVycZkPJzBXcjeqidq8Ux5WhDooWXIs55w5TAmY0G6o8Wou/Cwfn0NKGnxfVTgtXxvMDD
 qrYwOJR13fT3knK+Pxw==
X-Authority-Analysis: v=2.4 cv=Zckt8MVA c=1 sm=1 tr=0 ts=6a0dc149 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=x97SpM1XRKmEcGPL2ZkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: OK_z_WLxRwhNugwLfOnlLRBOYkwYaT0Z
X-Proofpoint-ORIG-GUID: OK_z_WLxRwhNugwLfOnlLRBOYkwYaT0Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200138

On Tue, May 19, 2026 at 11:45:52AM +0530, Ekansh Gupta via B4 Relay wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Add documentation for the Qualcomm DSP Accelerator (QDA) driver under
> Documentation/accel/qda/. The documentation covers the driver
> architecture, GEM-based buffer management, IOMMU context bank
> isolation, and the RPMsg transport layer.
> 
> The user-space API section describes the DRM IOCTLs for session
> management, GEM buffer allocation, and remote procedure invocation via
> the FastRPC protocol, along with a typical application lifecycle
> example. Sections for dynamic debug and basic testing are also
> included.
> 
> Wire the new documentation into the Compute Accelerators index at
> Documentation/accel/index.rst.
> 
> Assisted-by: Claude:claude-4-6-sonnet
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  Documentation/accel/index.rst     |   1 +
>  Documentation/accel/qda/index.rst |  13 ++++
>  Documentation/accel/qda/qda.rst   | 146 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 160 insertions(+)
> 
> diff --git a/Documentation/accel/index.rst b/Documentation/accel/index.rst
> index cbc7d4c3876a..5901ea7f784c 100644
> --- a/Documentation/accel/index.rst
> +++ b/Documentation/accel/index.rst
> @@ -10,4 +10,5 @@ Compute Accelerators
>     introduction
>     amdxdna/index
>     qaic/index
> +   qda/index
>     rocket/index
> diff --git a/Documentation/accel/qda/index.rst b/Documentation/accel/qda/index.rst
> new file mode 100644
> index 000000000000..013400cf9c25
> --- /dev/null
> +++ b/Documentation/accel/qda/index.rst
> @@ -0,0 +1,13 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +==================================
> +accel/qda Qualcomm DSP Accelerator
> +==================================
> +
> +The QDA driver provides a DRM accel based interface for Qualcomm DSP offload.
> +It uses the FastRPC protocol and integrates with DRM and GEM infrastructure
> +for device and buffer management.
> +
> +.. toctree::
> +
> +   qda
> diff --git a/Documentation/accel/qda/qda.rst b/Documentation/accel/qda/qda.rst
> new file mode 100644
> index 000000000000..9f49af6e6acc
> --- /dev/null
> +++ b/Documentation/accel/qda/qda.rst
> @@ -0,0 +1,146 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=====================================
> +Qualcomm DSP Accelerator (QDA) Driver
> +=====================================
> +
> +Introduction
> +============
> +
> +The QDA driver is a DRM accel driver for Qualcomm's DSPs. It provides a
> +DRM accel based interface for Qualcomm DSP offload, supporting workloads
> +such as AI inference, computer vision, audio processing, and sensor offload
> +on Qualcomm SoCs. It uses the FastRPC protocol and integrates with DRM and
> +GEM infrastructure for device and buffer management.
> +
> +Key Features
> +============
> +
> +*   **DRM accel Interface**: Exposes a standard character device node
> +    (e.g., ``/dev/accel/accel0``) via the DRM accel subsystem.
> +*   **FastRPC Protocol**: Implements the FastRPC protocol for communication
> +    between the application processor and the DSP.
> +*   **GEM Buffer Management**: Uses the DRM GEM interface for buffer
> +    allocation, lifecycle management, and DMA-BUF import/export.
> +*   **IOMMU Isolation**: Uses IOMMU context banks to enforce memory isolation
> +    between different DSP user sessions.
> +*   **Modular Design**: Clean separation between the core DRM logic, the
> +    memory manager, and the RPMsg-based transport layer.
> +
> +Architecture
> +============
> +
> +The QDA driver consists of several functional blocks:
> +
> +1.  **Core Driver (``qda_drv``)**: Manages device registration, file operations,
> +    and DRM accel integration.
> +2.  **Memory Manager (``qda_memory_manager``)**: A flexible memory management
> +    layer that handles IOMMU context banks. It supports pluggable backends
> +    (such as DMA-coherent) to adapt to different SoC memory architectures.
> +3.  **GEM Subsystem**: Implements the DRM GEM interface for buffer management:
> +
> +    * **``qda_gem``**: Core GEM object management, including allocation, mmap
> +      operations, and buffer lifecycle management.
> +    * **``qda_prime``**: PRIME import functionality for DMA-BUF interoperability
> +      with other kernel subsystems.
> +
> +4.  **Transport Layer (``qda_rpmsg``)**: Abstraction over the RPMsg framework
> +    to handle low-level message passing with the DSP firmware.
> +5.  **Compute Bus (``qda_compute_bus``)**: A custom virtual bus used to
> +    enumerate and manage the specific compute context banks defined in the
> +    device tree. The bus was introduced because IOMMU context banks (CBs) are
> +    synthetic constructs — not real platform devices — making a platform driver
> +    an incorrect abstraction for them. The earlier platform-driver approach also
> +    had a race condition: device nodes were created before the RPMsg channel
> +    resources were fully initialized, and because ``probe`` runs asynchronously,
> +    applications could open a CB device and attempt to start a session before
> +    the underlying transport was ready. The compute bus makes CB lifetime
> +    explicitly subordinate to the parent QDA device, closing that window.
> +6.  **FastRPC Core (``qda_fastrpc``)**: Implements the protocol logic for
> +    marshalling arguments and handling remote invocations.
> +
> +User-Space API
> +==============
> +
> +The driver exposes a set of DRM-compliant IOCTLs:
> +
> +*   ``DRM_IOCTL_QDA_QUERY``: Query DSP type (e.g., "cdsp", "adsp")
> +    and capabilities.
> +*   ``DRM_IOCTL_QDA_REMOTE_SESSION_CREATE``: Initialize a new process context
> +    on the DSP.
> +*   ``DRM_IOCTL_QDA_REMOTE_INVOKE``: Submit a remote method invocation (the
> +    primary execution unit).
> +*   ``DRM_IOCTL_QDA_GEM_CREATE``: Allocate a GEM buffer object for DSP usage.
> +*   ``DRM_IOCTL_QDA_GEM_MMAP_OFFSET``: Retrieve mmap offsets for memory mapping.
> +*   ``DRM_IOCTL_QDA_REMOTE_MAP`` / ``DRM_IOCTL_QDA_REMOTE_MUNMAP``: Map or unmap
> +    buffers into the DSP's virtual address space. Each accepts a ``request``
> +    field selecting between a legacy operation (``QDA_MAP_REQUEST_LEGACY`` /
> +    ``QDA_MUNMAP_REQUEST_LEGACY``) and an attribute-based operation
> +    (``QDA_MAP_REQUEST_ATTR`` / ``QDA_MUNMAP_REQUEST_ATTR``).

Explain, what happens in the users don't map the buffers into the DSP
space. Will DRM_IOCTL_QDA_REMOTE_INVOKE handle the mapping or not? What
is the difference between those two modes?

Would the driver benefit from using GPUVM?

> +
> +Usage Example
> +=============
> +
> +A typical lifecycle for a user-space application:
> +
> +1.  **Discovery**: Open ``/dev/accel/accel*`` and use
> +    ``DRM_IOCTL_QDA_QUERY`` to identify the DSP domain served by that
> +    device node.
> +2.  **Initialization**: Call ``DRM_IOCTL_QDA_REMOTE_SESSION_CREATE`` to
> +    establish a session and create a process context on the DSP.
> +3.  **Memory**: Allocate buffers via ``DRM_IOCTL_QDA_GEM_CREATE`` or import
> +    DMA-BUFs (PRIME fd) from other drivers using ``DRM_IOCTL_PRIME_FD_TO_HANDLE``.
> +4.  **Execution**: Use ``DRM_IOCTL_QDA_REMOTE_INVOKE`` to pass arguments and
> +    execute functions on the DSP.
> +5.  **Cleanup**: Close file descriptors to automatically release resources and
> +    detach the session.

I'd have expected the description of the actual example. I.e. clone the
app from https://the.addr, prepare clang >= NN.MM, QAIC (https://foo),
run make, run the app, check the results. I'd remind that DRM Accel has
a very specific requirement of having the working toolhain in the
open-source.

> +
> +Internal Implementation
> +=======================
> +
> +Memory Management
> +-----------------
> +The driver's memory manager creates virtual "IOMMU devices" that map to
> +hardware context banks. This allows the driver to manage multiple isolated
> +address spaces. The implementation uses a DMA-coherent backend to ensure data consistency
> +between the CPU and DSP without manual cache maintenance in most cases.

GEM usage?

> +
> +Debugging
> +=========
> +The driver includes extensive dynamic debug support. Enable it via the
> +kernel's dynamic debug control:
> +
> +.. code-block:: bash
> +
> +    echo "file drivers/accel/qda/* +p" > /sys/kernel/debug/dynamic_debug/control
> +
> +Testing
> +=======
> +The QDA driver can be exercised using the ``fastrpc_test`` utility from the
> +FastRPC userspace library. Run the test application:

pointer

> +
> +.. code-block:: bash
> +
> +    fastrpc_test -d 3 -U 1 -t linux -a v68
> +
> +**Options**
> +
> +``-d domain``
> +    Select the DSP domain to run on:
> +
> +    * ``0`` — ADSP
> +    * ``1`` — MDSP
> +    * ``2`` — SDSP
> +    * ``3`` — CDSP *(default on targets with CDSP)*
> +
> +``-U unsigned_PD``
> +    Select signed or unsigned protection domain:
> +
> +    * ``0`` — signed PD
> +    * ``1`` — unsigned PD *(default)*
> +
> +``-t target``
> +    Target platform: ``android`` or ``linux`` *(default: linux)*
> +
> +``-a arch_version``
> +    DSP architecture version, e.g. ``v68``, ``v75`` *(default: v68)*
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry
