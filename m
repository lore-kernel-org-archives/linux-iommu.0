Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3911C862D;
	Wed,  3 Sep 2025 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910563; cv=none; b=TfKx9WEyxiJGaQ8/YT7X3CfzOjRpiNdnjm3lEOvMSbbnBVkFvsWvz5YBjO1fVw3T8uJ7y0FcEoGgw4v8PSHxMVAw50mljFCGgJ7uq02gem/Qncyi0a+MEy9v9QhbWleZh4oqj53oin/2+x71MZcW31TWITDqsS+BakDo5NPihtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910563; c=relaxed/simple;
	bh=nKe5S8ycLOzlLVAPStN7aGZhiVpT24J1UIRxuEv2Yw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YqX6CQJuEWfA7B9AvYwvxggb/vkEvS3O6G7kQJKb6DTO/W6obNrYG8DJy1+3/2Kc8uFgsJQdJFoHt2eCXqmYGTLE1ykgi5Hyqin0+3bYrhaPp7XhletsrRqFYgS45w0OwKGfU3YYiJ+pJYLhOVPgxEu6LiVMihWKuE3dHu8JwZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Isyln6Yf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Isyln6Yf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B4DC4CEE7;
	Wed,  3 Sep 2025 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756910563;
	bh=nKe5S8ycLOzlLVAPStN7aGZhiVpT24J1UIRxuEv2Yw8=;
	h=From:To:Cc:Subject:Date:From;
	b=Isyln6YfCyS8lm/je/aRbzCGEX8RBC3azcY6te/H1QmmZAwAdGXWCTYnHlTC1eHq9
	 C1XVkfEcGL9Rr4eHPtMzTxvUDtfRWDjRVB6+K4mTcOnjO44uzThp9//DsH/2G6r038
	 kdRYOPACCuVc8SDT5Bt8nF+3wsUxQ+zEcN9t4dH0E00hU7hXsAa0qZ4c4aEbXC6qkT
	 l2KH8vKj+amv2MqoXJJqRpuFi8beSwLULEbV6E+vJxaS1DG2DIduUlx2pY3Qw22yZg
	 4/HHOZHGfBfwprvr+7DJisicJ1e5i5DMdUuqGah88a7BMldfHemnL7b0q0b4SbydkN
	 szirxuc1qpmQw==
From: guoren@kernel.org
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: guoren@kernel.org,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	palmer@dabbelt.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/riscv: Use two individual 4-byte accesses for 8-byte register
Date: Wed,  3 Sep 2025 10:42:17 -0400
Message-Id: <20250903144217.837448-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

The RISC-V IOMMU memory-mapped register interface define:

The 8-byte IOMMU registers are defined in such a way that
software can perform two individual 4-byte accesses.

Therefore, use two individual 4-byte accesses for an 8-byte
register to make the driver compatible with a 32-bit-wide
interconnect.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 drivers/iommu/riscv/iommu.c |  7 +++++--
 drivers/iommu/riscv/iommu.h | 27 ++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 0eae2f4bdc5e..9a80464ed7be 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -662,9 +662,12 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu)
 
 #define riscv_iommu_read_ddtp(iommu) ({ \
 	u64 ddtp; \
-	riscv_iommu_readq_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp, \
-				  !(ddtp & RISCV_IOMMU_DDTP_BUSY), 10, \
+	u32 ddtp_lo, ddtp_hi; \
+	riscv_iommu_readl_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp_lo, \
+				  !(ddtp_lo & RISCV_IOMMU_DDTP_BUSY), 10, \
 				  RISCV_IOMMU_DDTP_TIMEOUT); \
+	ddtp_hi = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_DDTP + 4); \
+	ddtp = ((u64)ddtp_hi << 32) | ddtp_lo; \
 	ddtp; })
 
 static int riscv_iommu_iodir_alloc(struct riscv_iommu_device *iommu)
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 46df79dd5495..698acffff298 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -69,18 +69,31 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu);
 #define riscv_iommu_readl(iommu, addr) \
 	readl_relaxed((iommu)->reg + (addr))
 
-#define riscv_iommu_readq(iommu, addr) \
-	readq_relaxed((iommu)->reg + (addr))
+static inline u64 riscv_iommu_readq(struct riscv_iommu_device *iommu,
+				      u16 addr)
+{
+	u32 val_lo, val_hi;
+
+	val_lo = readl_relaxed((iommu)->reg + (addr));
+	val_hi = readl_relaxed((iommu)->reg + (addr) + 4);
+
+	return (u64) val_lo | ((u64) val_hi << 32);
+}
 
 #define riscv_iommu_writel(iommu, addr, val) \
 	writel_relaxed((val), (iommu)->reg + (addr))
 
-#define riscv_iommu_writeq(iommu, addr, val) \
-	writeq_relaxed((val), (iommu)->reg + (addr))
+static inline void riscv_iommu_writeq(struct riscv_iommu_device *iommu,
+				      u16 addr, u64 val)
+{
+	u32 val_lo, val_hi;
 
-#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
-	readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, cond, \
-			   delay_us, timeout_us)
+	val_hi = (u32) (val >> 32);
+	val_lo = (u32) val;
+
+	writel_relaxed((val_hi), (iommu)->reg + (addr) + 4);
+	writel_relaxed((val_lo), (iommu)->reg + (addr));
+}
 
 #define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
 	readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
-- 
2.40.1

