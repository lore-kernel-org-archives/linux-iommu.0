Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683982;
	b=w7foxMlaSmjQhWnVCEgSnm/9T+/bgpfJw7xVPl0VSWRbDTvM44dl6xADMRan0RtXzepX
	 eh2pZEGxIRmqtGOcET5s7Jmu2p++QL9BA9J0NJrHJw7OA5cjBXZGYVhIbOCn5ohJK6NRY
	 dm8u5HPy79rNQaYs7okmwsFKKKLxP5jIU26KnN36+lWrQLa5F8LWsPeTaL1zu5wwtKK+V
	 BdxE/7BXlfA0yC4JiXB1ibJEYPoePNrMnG2fU1R9x6amQ2Zqri3e7kWEcCIzZ6psC6DOT
	 GGwFQYsl81uVzfMFcMVnuVaBYX+8tSE9cHwkE+eaNO4K+7rCD/GBIplosARaVVJkLsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683982;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a5zbmPbouV8SEmXjWtmuRgaGja46q1uw1FeBKlf0wpY=;
	b=iua5valkxtab7SoQFOOz4EdqV/c2mf/T3ObHHAjkOKnhoId+ttR0KbhxTcNuLca8yFVb
	 svsB6rgbvDstorxs9bjGU0kz9WLi3s5vPjbR7KyzgvyJSeOML7SRl708Eis4W1qGEZYJ8
	 AgD1h3HWl8m16Y8dSd98CAWkYxcehxm91j/0AEFeG4Zn7uRf3uJYULisn+lJVYSjg3mtN
	 twchuD800mmPvzOGLdug/UKzwwpBOnEYnboZABJ18VE2LM40nD86KfDyCFNlvNdG5TUzt
	 XzH4TejoU4W8WQ5ag/36UZI2VpZF4ru+z4ZaVzct13xAGTayPaMt9hQBBPx6rkdErPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nEILtDJc;
	arc=none smtp.remote-ip=91.218.175.96
Received: from mta0.migadu.com (out-96.mta0.migadu.com [91.218.175.96])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59429606A331
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 15:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59429606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nEILtDJc
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=JMdDrJYGHoatl+CVcAcsdrIs5ssl7riEmzRfx4ikLh0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792683979; v=1; x=1793288779;
 b=nEILtDJcz+736p/Eemboi36CcrizEp4oc+YAgxGbIm9a+CHFnbE+3YvPIN7m0xCNxjfgHl3p
 HAGSv0sfRG8LPlcw20+X4GWtQ3HVXNooGpFaMZrcf+LvlHksxw/XFMgMpNYfR9rkKTJvYx/kRMV
 PCF/F3YHQOj5zemaivk+BZ9Q=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 96cd205962e0f05a;
	Thu, 22 Oct 2026 15:46:19 +0000
X-Mizu-Trace-ID: 96cd205962e0f05a
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
Subject: [PATCH v7 3/5] irqchip/riscv-imsic: Add MSI address list
Date: Thu, 22 Oct 2026 17:46:01 +0200
Message-ID: <20261022154603.1374754-4-andrew.jones@linux.dev>
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

From: Andrew Jones <andrew.jones@oss.qualcomm.com>

Upcoming RISC-V IOMMU interrupt remapping needs to map every possible
host IMSIC target into one contiguous MSI IOVA range. MSI message
composition then uses the target CPU's position within that range.

Build an IMSIC physical address array indexed by logical CPU.
Require every possible CPU to have an initialized IMSIC page before
publishing the array. This preserves physical address zero as a valid
target and guarantees the array has num_possible_cpus() entries.

The array size and each target's index can therefore be derived
directly, without storing duplicate count or per-CPU index metadata.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Acked-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Anup Patel <anup@brainfault.org>
---
 drivers/irqchip/irq-riscv-imsic-state.c | 32 +++++++++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index b8d1bbbf42f7..eb525c324982 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -687,6 +687,31 @@ static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode,
 	return of_address_to_resource(to_of_node(fwnode), index, res);
 }
 
+static int __init imsic_init_msi_pa_list(void)
+{
+	struct imsic_global_config *global = &imsic->global;
+	phys_addr_t *msi_pa_list;
+	unsigned int cpu;
+
+	msi_pa_list = kcalloc(num_possible_cpus(), sizeof(*msi_pa_list), GFP_KERNEL);
+	if (!msi_pa_list)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		struct imsic_local_config *local = per_cpu_ptr(global->local, cpu);
+
+		if (!local->msi_va) {
+			kfree(msi_pa_list);
+			return -ENODEV;
+		}
+
+		msi_pa_list[cpu] = local->msi_pa;
+	}
+
+	imsic->msi_pa_list = msi_pa_list;
+	return 0;
+}
+
 static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
 				     struct imsic_global_config *global,
 				     u32 *nr_parent_irqs,
@@ -937,6 +962,12 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
 		goto out_local_cleanup;
 	}
 
+	rc = imsic_init_msi_pa_list();
+	if (rc) {
+		pr_err("%pfwP: failed to initialize MSI address list\n", fwnode);
+		goto out_local_cleanup;
+	}
+
 	/* Initialize matrix allocator */
 	rc = imsic_matrix_init();
 	if (rc) {
@@ -962,6 +993,7 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
 out_free_local:
 	free_percpu(imsic->global.local);
 out_free_priv:
+	kfree(imsic->msi_pa_list);
 	kfree(imsic);
 	imsic = NULL;
 	return rc;
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index c42ee180b305..e51c61dcced3 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -50,6 +50,9 @@ struct imsic_priv {
 	/* Global configuration common for all HARTs */
 	struct imsic_global_config		global;
 
+	/* MSI target physical addresses indexed by logical CPU for IOMMU mapping */
+	phys_addr_t				*msi_pa_list;
+
 	/* Per-CPU state */
 	struct imsic_local_priv __percpu	*lpriv;
 
-- 
2.56.0

