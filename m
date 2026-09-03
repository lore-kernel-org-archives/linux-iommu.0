Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953294A840D
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444057; cv=none; b=rY/99uJn3TcCGF+AIKJ778UudVNeaXrNXz+O1xi72wXnf1quo+8ndiSg8Rzlz3qtrtwTSQUoN3IuuZywdooYgt4FjRtCOAHOqoNskNjAiIpeNCfEUyaaz55HhpM5pZJNtiV9SiIN5L19+TB4Br5sCAHPUbAvJDXPvhFszIWrTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444057; c=relaxed/simple;
	bh=jY9nHpNgEvlW8JyWvz3Jehy7FPbVDgI1Ta6inmZFL4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pIgRaAtzdauFjVcjS7xVdM2o8sI75pttDB8GMmpV1C6oQBQe6yymwUweaSEdktc2TEsodhjsYry7wTCiA3J7I6U6I+kIA2GE04HzbDw397uIULgTlB4AQys5Fx+0rF4WkepKBsE8QLQ7+U07oLVvH8i88K+SFN/VOnP5AEUGbwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cpx103/W; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cpx103/W"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788444035; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EeH6bdDAEIQqh3qtw9ytOgfSyurKW+ipErCrXEGxYck=;
	b=cpx103/Wm0Y1mFRFhn7w7+Naq5aAOctYx9jvfBv3FpRuMLEdLJ1GexXdmYrJJy8YA/aLl5U8RpDE8mGCFUVzV59cL0KU9BjIAdrqA6TrElt12jq+KJgKVsbBk/absg1iPgDF9Gj8MVsl6uZsM+QqnGOgBw6vmy2oczx1V7UUzMk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0XAG8g3p_1788444033;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XAG8g3p_1788444033 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 03 Sep 2026 22:00:34 +0800
From: fangyu.yu@linux.alibaba.com
To: sunilvl@oss.qualcomm.com,
	rafael@kernel.org,
	lenb@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2] ACPI: RIMT: Enable PCI ACS for root complexes mapped to an IOMMU
Date: Thu,  3 Sep 2026 22:00:31 +0800
Message-Id: <20260903140031.3684-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Mirror the ACPI IORT solution used on arm64 (see iort_enable_acs())
by scanning the RIMT table for PCIe root complex nodes during
riscv_acpi_rimt_init(), which runs before ACPI PCI enumeration. If a
root complex node's ID mapping points at an IOMMU node, call
pci_request_acs() immediately, so pci_acs_enable is already set by
the time any PCI device is scanned and pci_enable_acs() runs.

Only one call to pci_request_acs() is needed regardless of how many
root complexes are found, so track that with a static acs_enabled
flag, same as iort_enable_acs() does.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>

---
Changes in v2 (Suggested by Sunil):
    - Check the RIMT node type in riscv_acpi_rimt_init() and invoke
      rimt_enable_acs() only for PCIe root-complex nodes.
---
 drivers/acpi/riscv/rimt.c | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
index e4538fa6c2c8..edbd04a9e03b 100644
--- a/drivers/acpi/riscv/rimt.c
+++ b/drivers/acpi/riscv/rimt.c
@@ -179,6 +179,42 @@ static struct acpi_rimt_node *rimt_scan_node(enum acpi_rimt_node_type type,
 	return NULL;
 }
 
+#ifdef CONFIG_PCI
+static void __init rimt_enable_acs(struct acpi_rimt_node *rimt_node)
+{
+	static bool acs_enabled __initdata;
+	struct acpi_rimt_pcie_rc *pci_rc;
+	struct acpi_rimt_id_mapping *map;
+	struct acpi_rimt_node *parent;
+	int i;
+
+	if (acs_enabled)
+		return;
+
+	pci_rc = (struct acpi_rimt_pcie_rc *)rimt_node->node_data;
+	if (!pci_rc->id_mapping_offset || !pci_rc->num_id_mappings)
+		return;
+
+	map = ACPI_ADD_PTR(struct acpi_rimt_id_mapping, rimt_node,
+			   pci_rc->id_mapping_offset);
+
+	for (i = 0; i < pci_rc->num_id_mappings; i++, map++) {
+		if (!map->dest_offset)
+			continue;
+
+		parent = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table,
+				      map->dest_offset);
+		if (parent->type == ACPI_RIMT_NODE_TYPE_IOMMU) {
+			pci_request_acs();
+			acs_enabled = true;
+			return;
+		}
+	}
+}
+#else
+static inline void rimt_enable_acs(struct acpi_rimt_node *rimt_node) { }
+#endif
+
 /*
  * RISC-V supports IOMMU as a PCI device or a platform device.
  * When it is a platform device, there should be a namespace device as
@@ -509,7 +545,10 @@ int rimt_iommu_configure_id(struct device *dev, const u32 *id_in)
 
 void __init riscv_acpi_rimt_init(void)
 {
+	struct acpi_rimt_node *rimt_node, *rimt_end;
+	struct acpi_table_rimt *rimt;
 	acpi_status status;
+	int i;
 
 	/* rimt_table will be used at runtime after the rimt init,
 	 * so we don't need to call acpi_put_table() to release
@@ -525,4 +564,23 @@ void __init riscv_acpi_rimt_init(void)
 
 		return;
 	}
+
+	rimt = (struct acpi_table_rimt *)rimt_table;
+	rimt_node = ACPI_ADD_PTR(struct acpi_rimt_node, rimt,
+				 rimt->node_offset);
+	rimt_end = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table,
+				rimt_table->length);
+
+	for (i = 0; i < rimt->num_nodes; i++) {
+		if (rimt_node >= rimt_end) {
+			pr_err("RIMT node pointer overflows, bad table\n");
+			return;
+		}
+
+		if (rimt_node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX)
+			rimt_enable_acs(rimt_node);
+
+		rimt_node = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_node,
+					 rimt_node->length);
+	}
 }
-- 
2.50.1

