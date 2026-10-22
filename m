Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683991;
	b=JxpXnAgd7ut5Fw0mc6jeTfskB7x878rdY/rLwLToJDHHxAL5BAPcgz/8uaWcvGHOmQRA
	 ceCDPqvj9Q4BAv7a22VR/NHSQ7Gn5coRAEny1uwC2RMcVfMAjicoivdHjYpYmhGsXaVTi
	 qjWxeyR2a5u312I9HCJ6OCQrfnhqO/TVQE+/xQgi+UcwBgzaE9D/TEZiopCNPcx7w/G3/
	 xhL0Q8jdIFjwr5bFtpGx0MDcBIz5CtD9gdbNQR8zzHrgAilG6Y7LpxtvW6LfSu0BYqSvE
	 UY+U3ga1C91zap28ZPpw3XHBJ10jN5q8MECILld9v3TQL2C6GKYDlb6XMxkdl9QsYFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683991;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+Z0HjrMiSQrKDafUeNk5fpJdwsbHzeh3DJwl/lPuiB4=;
	b=vJ7nUvHDUgPX273YihF1Nm4jnO59ifbZJq0In7RhFnB0hPOpVP6mbISSIgRU9DvnHCL5
	 a4MpKGaxilwhDL51wD7MPunOY0s3DFdRfZAxYA5so4rdJPXFrie95+kPBA4DhkmfePhoi
	 c320EVQjXbLqj5/cPjriBugA6q9cr85rua7u3PcEVRGbx/nzluntZ99fzZWEudbelJGoF
	 XhJeb+D5S4K4CJRzXjkEAunkmRkdCJuM1z67j7wxBYt7ZwJDm9MjjySnXGSn2iFESmz38
	 sOW9jIQOfGdTWXfKzpGQpPc09mFDD6pPy7bWKCiQqfRdc3+LikoSEGLXdqDRmgJQCEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lNZrMPw3;
	arc=none smtp.remote-ip=95.215.58.37
Received: from mta1.migadu.com (out-37.mta1.migadu.com [95.215.58.37])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA45606A31E
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 15:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDA45606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lNZrMPw3
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=xVnbD5NPCwNUtek5rbJ7N7bjfuJvseF0zqNU40fRwo4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792683988; v=1; x=1793288788;
 b=lNZrMPw3e/oDx3JW7udezPOdBU4x7PWj9OxtSKRfgRnltSvOZkpkZrj4A/piFzU616noKuHi
 hppLeN8vCQ/zrBcXhOdWcMVSwZDnXKcwnOTqExnd565OvfZBjvxJrKbn3QS9njKJ9Gb/SOtskPf
 P3gzJXGuSsRDoVKR2SVKDQRo=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id fad8cbd66f56fb82;
	Thu, 22 Oct 2026 15:46:28 +0000
X-Mizu-Trace-ID: fad8cbd66f56fb82
X-Migadu-Flow: FLOW_OUT
From: Andrew Jones <andrew.jones@linux.dev>
To: linux-riscv@lists.infradead.org,
	iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tomasz.jeznach@linux.dev,
	jgg@ziepe.ca,
	jgg@nvidia.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	anup@brainfault.org,
	tglx@kernel.org,
	kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com,
	nutty.liu@hotmail.com
Subject: [PATCH v7 5/5] iommu/dma: Enable IOMMU_DMA for 64-bit RISC-V
Date: Thu, 22 Oct 2026 17:46:03 +0200
Message-ID: <20261022154603.1374754-6-andrew.jones@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154603.1374754-1-andrew.jones@linux.dev>
References: <20261022154603.1374754-1-andrew.jones@linux.dev>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomasz Jeznach <tomasz.jeznach@linux.dev>

Enable IOMMU_DMA for 64-bit RISC-V now that the RISC-V
IOMMU driver supports MSI remapping.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 85a8d7fdfa30..96b282ed38f9 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -151,7 +151,7 @@ config OF_IOMMU
 
 # IOMMU-agnostic DMA-mapping layer
 config IOMMU_DMA
-	def_bool ARM64 || X86 || S390
+	def_bool ARM64 || X86 || S390 || (RISCV && 64BIT)
 	select DMA_OPS_HELPERS
 	select IOMMU_API
 	select IOMMU_IOVA
-- 
2.56.0

