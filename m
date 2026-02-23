Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFD236AB49
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873774; cv=none; b=fHGwxtVlKqjYNnKxAzp2YDlx1ns8OzPjaRIvFRLJSR6PDP4BVUV7C7ZY7SuGBbbE6f561crq1ufB6IhsTgOXF+fCdFOcP7dxaiQzNvslCBq+pjffbvvJ8k41Y0cQ9mOrPUOxJ80tB1NBV0gmBGXt6CyONBXurv84wnFIb1/ccKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873774; c=relaxed/simple;
	bh=Zq6CFw1VSCQehea9a6rhVdMON7B8W0MmxMsOW3uKtjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gbOCHDi/2QZAuk6QruY6Dnp76LhbijJ6cutg2KNDRpFGghr5Ezcjd9OEv0bbzVq1LbZ0MtkQozhyhAudJtMqDr8DLcXPLtQpUjMnlvvvN+ZVD+YUr3RxpjdIghzXFWHqwJ+E9h+q0MUkJkjG5W+7qEQI94n9zoQKGMrOOXXsI+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pY7bv8Ly; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YUcQJjps; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pY7bv8Ly";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YUcQJjps"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NHZtFk322482
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Clm+7k+qHiGBFSKNSFyBJAE1bBx37+hOGzIhiR9y8j8=; b=pY7bv8LyTytdTBwx
	FdDz8F8YAh21njbNhRKTOgB6ASxCA5j+1P+5Hd7dROPVgXLegJv7Y4OZ4Y75jTbb
	691M3GLS52UkNTPuNK+tUSt/OKn6RK5YhR5tttqrXS7/2YX2/ALYN1GNDIX14Gtp
	8y7wyRBGxNHBt6kh3siFZC7okCWsmbAwfQperSk6+9HOwOinOewBnSjq0AWzPHTk
	B2nbzYjoGlicQRzCFR309S838vxt/jYNyIMa799i1USDELzpQ0+wjR4gw5K6IR11
	8yB4K12mYKvRwhlmp1eM0wE939875N4A4S9fjicTdaReX86Oix7iJbCfjgBqAIpx
	/ASXPQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8y1m3c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:09:30 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aae0d40a47so416113525ad.2
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 11:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771873770; x=1772478570; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Clm+7k+qHiGBFSKNSFyBJAE1bBx37+hOGzIhiR9y8j8=;
        b=YUcQJjpsh/vEVF5cGGps17ocisM6/eA9Q4LGx993oQn/foF9MoPwWZwLnHDxSshSiT
         DON1HZf+yJIF0fEqxUBM9QOVp0nPfwSgQwHFd1kzTBzM4NzAlAtJYavCQDUNgBYwXkmo
         a+RE+ABDih9gMQBN3QRONbs+fzzKdGq+3WmxH+oR7Jgyspjk4FEZRPQ4PT/MAknlTQB2
         WWArd/9eHWrmn0JbfgTeW22/RoKL8tb0FyEg0xXKdb8gByqN7mjMix54JcPfooWYgIDK
         01N8Rga0SKuLTGSweeXgtD8cqN2N+fWoNpMOWhqUVMeYeHV6Ti4Vs2guuZzt7bgMeU0D
         jKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873770; x=1772478570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Clm+7k+qHiGBFSKNSFyBJAE1bBx37+hOGzIhiR9y8j8=;
        b=aHXotI1OWhWROYP62vo0AtCjMMCa5kidFlU23ORm/X4AmJvOZgc46aHhjI9kwCU7Jo
         us8bq6MNAWyHfOvDM0Oo/hxLx7aJF/e7U8SQncN0WUXEdGE8LHzLN6M7ZRIjg1d9tqgO
         y6lwHOVkOcwASdMepYp/54Hxtg6HK1Bc6v2QIo/gVz46osUgGYMMwcw0NOAOhfdxTYna
         hVG7cSQ7w4FakoMmEn92eAis4vyBsSjQRM5odtx2R3Uqly3YRb8VCADuWVMgKnVsbySM
         LPbO+ulkD77qTNtykbTfZMmCFxwKTEgMl68BZFqn/iWJFHQyNLcIUTpteEqaU4WbI0ad
         yXhw==
X-Forwarded-Encrypted: i=1; AJvYcCX4Hq0OlVArQA42xO6PgO8jD8OeFSfiGx54CzgFVPLYTCU7rYIlYQIl+0YMHYdvK6zGIUSTaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPcu+01zRW31WwrpnwAHzDXEl6Qm/oz+yyvNgKeTrcaxv29I4S
	7p8LlNCQ1XYY6kSQfqS+ybBGzD4VjnUOTFhLj/utSNKy+lx/hinWxerF5Zvyxw5Z4StDcOBPgwu
	NYcDXnJIdCson68Z8p1IGTXqOBWf9pOkXu/KgHtTNfi+qMirgmswG1WtMSA==
X-Gm-Gg: ATEYQzyeE/m7NAJCJgfDeQtlI6G6YCWku9Fj1r75REC0kXkFxZixEJDm7kNMa/dBPyR
	x7gpIv0gyle5hNoY4hNUHL4JKXrVZu0IT6TfrwL8bctEm2uLnLnkFsihph8aOFlWUnDmXu5J35q
	2rGS1fRODkvt9VP1CcNUbJk/gpXtom1G11BOxbRqpJhJAhdtEqqQg87b0CUlNGkT92EU0M7q666
	Ec3fivmhkiR+WXixKxRMjk2uPo0VvpRagY1jG/KvycF90S7HIYoTXebEgCIBOKIQArbtTCQ2er+
	1X/uL7o3X9Cna8o+k28EMW6lQSKAMRRahLZzI7BG19czxJ2GqWV6WL5y+c+rgt2bS4qy8A7pTOY
	eGmZaOMSCrO+EEPStgsq0qGqRB98Y3UKm4yla8Lh2+nrzlWsY94AvRw==
X-Received: by 2002:a17:902:ef48:b0:2a9:4c2:e47 with SMTP id d9443c01a7336-2ad7458617fmr91702905ad.56.1771873769450;
        Mon, 23 Feb 2026 11:09:29 -0800 (PST)
X-Received: by 2002:a17:902:ef48:b0:2a9:4c2:e47 with SMTP id d9443c01a7336-2ad7458617fmr91702545ad.56.1771873768877;
        Mon, 23 Feb 2026 11:09:28 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34e18sm83501505ad.10.2026.02.23.11.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:09:28 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 00:38:55 +0530
Subject: [PATCH RFC 01/18] accel/qda: Add Qualcomm QDA DSP accelerator
 driver docs
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-qda-firstpost-v1-1-fe46a9c1a046@oss.qualcomm.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
In-Reply-To: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771873753; l=8196;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=Zq6CFw1VSCQehea9a6rhVdMON7B8W0MmxMsOW3uKtjQ=;
 b=rXPbVMVVUoLnQhK6G4B08gOscy7gxC3JRP2zb2W8d74yPv902ZtG45ZW6lWshlXckS4YvBWtR
 LzYqLzgQ+iIAwp100NKsDuMgQ4wgN58wj+seVZlEx1YacUgesqDzglm
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE2NiBTYWx0ZWRfX3f7785SRJrhl
 FUBEFzQpcnKuloEwIyrPCaPi1eBqeUWbU70TvOkwk8xRIylE56FBr/CSwI7WZ3rOMNKZoRXfjl5
 nXd1KZcIH/igPRq/lKAwlAYB/9bQnY7sPaMAWSo+0UsxmbvdjTmE8G1Gi8cIYklCBfwOQCeB0eG
 +mo75X/o6CEb969T6COcjTIj70eafLoYpZw8VYoo6N6q4cOnoj/zdUi63N7lCl0vdhaGikNs8vD
 iipAAf7E4YTTT1oOYiyuSNy9Z63j+6N1zaTXXf3TdDjQm2vX8bYH/3R54khT9fYr6HdRoxRMljd
 lSBACdDsH7b93x2hWTIYAHMVRovkQiDYVqQ2IK17rgg+RIC9EPSY3IeGlgFeOQCGOzE+phz7FoC
 dEMF0PYuQIKS8lTjPnBPu/7G6xe6CZwmnv1eTuGVwqJyNCguxdBLAegUa+HdnJil++h3Byt/iFq
 lBhi21A8emFRmb5/L0Q==
X-Authority-Analysis: v=2.4 cv=edYwvrEH c=1 sm=1 tr=0 ts=699ca5ea cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=WUJy9f6djnNETMKr9A4A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: DFSR1TTA3AGNobG47DE-X-PYIL4e1Y8N
X-Proofpoint-ORIG-GUID: DFSR1TTA3AGNobG47DE-X-PYIL4e1Y8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230166

Add initial documentation for the Qualcomm DSP Accelerator (QDA) driver
integrated in the DRM accel subsystem.

The new docs introduce QDA as a DRM/accel-based implementation of
Hexagon DSP offload that is intended as a modern alternative to the
legacy FastRPC driver in drivers/misc. The text describes the driver
motivation, high-level architecture and interaction with IOMMU context
banks, GEM-based buffer management and the RPMsg transport.

The user-space facing section documents the main QDA IOCTLs used to
establish DSP sessions, manage GEM buffer objects and invoke remote
procedures using the FastRPC protocol, along with a typical lifecycle
example for applications.

Finally, the driver is wired into the Compute Accelerators
documentation index under Documentation/accel, and a brief debugging
section shows how to enable dynamic debug for the QDA implementation.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 Documentation/accel/index.rst     |   1 +
 Documentation/accel/qda/index.rst |  14 +++++
 Documentation/accel/qda/qda.rst   | 129 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)

diff --git a/Documentation/accel/index.rst b/Documentation/accel/index.rst
index cbc7d4c3876a..5901ea7f784c 100644
--- a/Documentation/accel/index.rst
+++ b/Documentation/accel/index.rst
@@ -10,4 +10,5 @@ Compute Accelerators
    introduction
    amdxdna/index
    qaic/index
+   qda/index
    rocket/index
diff --git a/Documentation/accel/qda/index.rst b/Documentation/accel/qda/index.rst
new file mode 100644
index 000000000000..bce188f21117
--- /dev/null
+++ b/Documentation/accel/qda/index.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+==============================
+ accel/qda Qualcomm DSP Driver
+==============================
+
+The **accel/qda** driver provides support for Qualcomm Hexagon DSPs (Digital
+Signal Processors) within the DRM accelerator framework. It serves as a modern
+replacement for the legacy FastRPC driver, offering improved resource management
+and standard subsystem integration.
+
+.. toctree::
+
+   qda
diff --git a/Documentation/accel/qda/qda.rst b/Documentation/accel/qda/qda.rst
new file mode 100644
index 000000000000..742159841b95
--- /dev/null
+++ b/Documentation/accel/qda/qda.rst
@@ -0,0 +1,129 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+==================================
+Qualcomm Hexagon DSP (QDA) Driver
+==================================
+
+Introduction
+============
+
+The **QDA** (Qualcomm DSP Accelerator) driver is a new DRM-based
+accelerator driver for Qualcomm's Hexagon DSPs. It provides a standardized
+interface for user-space applications to offload computational tasks ranging
+from audio processing and sensor offload to computer vision and AI
+inference to the Hexagon DSPs found on Qualcomm SoCs.
+
+This driver is designed to align with the Linux kernel's modern **Compute
+Accelerators** subsystem (`drivers/accel/`), providing a robust and modular
+alternative to the legacy FastRPC driver in `drivers/misc/`, offering
+improved resource management and better integration with standard kernel
+subsystems.
+
+Motivation
+==========
+
+The existing FastRPC implementation in the kernel utilizes a custom character
+device and lacks integration with modern kernel memory management frameworks.
+The QDA driver addresses these limitations by:
+
+1.  **Adopting the DRM accel Framework**: Leveraging standard uAPIs for device
+    management, job submission, and synchronization.
+2.  **Utilizing GEM for Memory**: Providing proper buffer object management,
+    including DMA-BUF import/export capabilities.
+3.  **Improving Isolation**: Using IOMMU context banks to enforce memory
+    isolation between different DSP user sessions.
+
+Key Features
+============
+
+*   **Standard Accelerator Interface**: Exposes a standard character device
+    node (e.g., `/dev/accel/accel0`) via the DRM subsystem.
+*   **Unified Offload Support**: Supports all DSP domains (ADSP, CDSP, SDSP,
+    GDSP) via a single driver architecture.
+*   **FastRPC Protocol**: Implements the reliable Remote Procedure Call
+    (FastRPC) protocol for communication between the application processor
+    and DSP.
+*   **DMA-BUF Interop**: Seamless sharing of memory buffers between the DSP
+    and other multimedia subsystems (GPU, Camera, Video) via standard DMA-BUFs.
+*   **Modular Design**: Clean separation between the core DRM logic, the memory
+    manager, and the RPMsg-based transport layer.
+
+Architecture
+============
+
+The QDA driver is composed of several modular components:
+
+1.  **Core Driver (`qda_drv`)**: Manages device registration, file operations,
+    and bridges the driver with the DRM accelerator subsystem.
+2.  **Memory Manager (`qda_memory_manager`)**: A flexible memory management
+    layer that handles IOMMU context banks. It supports pluggable backends
+    (such as DMA-coherent) to adapt to different SoC memory architectures.
+3.  **GEM Subsystem**: Implements the DRM GEM interface for buffer management:
+
+    * **`qda_gem`**: Core GEM object management, including allocation, mmap
+      operations, and buffer lifecycle management.
+    * **`qda_prime`**: PRIME import functionality for DMA-BUF interoperability,
+      enabling seamless buffer sharing with other kernel subsystems.
+
+4.  **Transport Layer (`qda_rpmsg`)**: Abstraction over the RPMsg framework
+    to handle low-level message passing with the DSP firmware.
+5.  **Compute Bus (`qda_compute_bus`)**: A custom virtual bus used to
+    enumerate and manage the specific compute context banks defined in the
+    device tree.
+6.  **FastRPC Core (`qda_fastrpc`)**: Implements the protocol logic for
+    marshalling arguments and handling remote invocations.
+
+User-Space API
+==============
+
+The driver exposes a set of DRM-compliant IOCTLs. Note that these are designed
+to be familiar to existing FastRPC users while adhering to DRM standards.
+
+*   `DRM_IOCTL_QDA_QUERY`: Query DSP type (e.g., "cdsp", "adsp")
+    and capabilities.
+*   `DRM_IOCTL_QDA_INIT_ATTACH`: Attach a user session to the DSP's protection
+    domain.
+*   `DRM_IOCTL_QDA_INIT_CREATE`: Initialize a new process context on the DSP.
+*   `DRM_IOCTL_QDA_INVOKE`: Submit a remote method invocation (the primary
+    execution unit).
+*   `DRM_IOCTL_QDA_GEM_CREATE`: Allocate a GEM buffer object for DSP usage.
+*   `DRM_IOCTL_QDA_GEM_MMAP_OFFSET`: Retrieve mmap offsets for memory mapping.
+*   `DRM_IOCTL_QDA_MAP` / `DRM_IOCTL_QDA_MUNMAP`: Map or unmap buffers into the
+    DSP's virtual address space.
+
+Usage Example
+=============
+
+A typical lifecycle for a user-space application:
+
+1.  **Discovery**: Open `/dev/accel/accel*` and check
+    `DRM_IOCTL_QDA_QUERY` to find the desired DSP (e.g., CDSP for
+    compute workloads).
+2.  **Initialization**: Call `DRM_IOCTL_QDA_INIT_ATTACH` and
+    `DRM_IOCTL_QDA_INIT_CREATE` to establish a session.
+3.  **Memory**: Allocate buffers via `DRM_IOCTL_QDA_GEM_CREATE` or import
+    DMA-BUFs (PRIME fd) from other drivers using `DRM_IOCTL_PRIME_FD_TO_HANDLE`.
+4.  **Execution**: Use `DRM_IOCTL_QDA_INVOKE` to pass arguments and execute
+    functions on the DSP.
+5.  **Cleanup**: Close file descriptors to automatically release resources and
+    detach the session.
+
+Internal Implementation
+=======================
+
+Memory Management
+-----------------
+The driver's memory manager creates virtual "IOMMU devices" that map to
+hardware context banks. This allows the driver to manage multiple isolated
+address spaces. The implementation currently uses a **DMA-coherent backend**
+to ensure data consistency between the CPU and DSP without manual cache
+maintenance in most cases.
+
+Debugging
+=========
+The driver includes extensive dynamic debug support. Enable it via the
+kernel's dynamic debug control:
+
+.. code-block:: bash
+
+    echo "file drivers/accel/qda/* +p" > /sys/kernel/debug/dynamic_debug/control

-- 
2.34.1

