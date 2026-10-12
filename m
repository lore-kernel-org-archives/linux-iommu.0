Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1703C09F8
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794510; cv=none; b=XCaaoJGglemHXCQkqLvOYWg3ycF7Ynf61NGIewYv2bMfzx0QUjr8s0QsvizPpvnTUQRGhil/+oXrXt7yqEw52t7ubK2i6oLWYp4nbsN7rkD6ChUssrCZX+NwaffDb+Lhs/g/+OCt24rOR1BoXmeVkm0MOZryzWwcytFVGtO7uDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794510; c=relaxed/simple;
	bh=Qanp8XpTcR8oBU9NgCmlUZCKBu56qLf1fhHTnhwauVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ams8IO8gTzCo3BcuNohUzdIkY0Ss3WaxDdBOogVWsQ/JSCekWOt+FiH2zAx6EnEfjgh/kGyXXNggch/BfGdYFlmtZmqlWKiIrpSaw4yToJIHpnDaZEHix9G3Pm6nRi3H8GsZ02Mr7c1dapFe7iwgT+Fe+1OrEXWym57DT4KTyUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ISA+Fx0H; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ISA+Fx0H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=xi
	B/mc8XaApxaPDniNNCfUu6SOnvJQaPDWT8rHnuIrc=; b=ISA+Fx0HcsaEn6AJxt
	Xv6MAskDAExXqkuderFxpnFYN+zuaVu0jYYwRMF3ZhLKCAhQvijPXFgRBS5/vBKs
	RVUS6qh9Y4HDyGrZ2FX8p7wdFvpOyat7U6pq7MvnMxTZRz9I/Ppd9V04SqwJqV7b
	9QUUbtkGBFzQ2XVeG8WM+ILLU=
Received: from WIN-TOG0NDEIICD.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3P7Efncxqike8Dw--.13686S2;
	Mon, 12 Oct 2026 16:41:04 +0800 (CST)
From: Shirong Zhao <shxzhaosr@163.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: intel: Apply the device scope length check to every device scope walk
Date: Mon, 12 Oct 2026 16:41:02 +0800
Message-ID: <20261012084102.18-1-shxzhaosr@163.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P7Efncxqike8Dw--.13686S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFy5KryDXr43Kryftw17trb_yoWrXw1rpF
	W8KrZ0yrW5trs7Gw13AayfZry5tws3A3y3CF45W3909a129Fy5WFyDGFySgr1rKFWDtF1f
	ZayjvrWUCw15JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jVUDJUUUUU=
X-CM-SenderInfo: hvk06xhdrv2qqrwthudrp/xtbC7gA9e2rMnSB-EQAA3d

dmar_walk_remapping_entries() already refuses to step by a zero length:

	next = (void *)iter + iter->length;
	if (iter->length == 0) {
		/* Avoid looping forever on bad ACPI tables */
		pr_debug(FW_BUG "Invalid 0-length structure\n");
		break;
	}

Five walks over the same DMAR structures do not:

  dmar_alloc_dev_scope()        - counts namespace/endpoint/bridge scopes
  dmar_insert_dev_scope()       - attaches a scope to a PCI path
  dmar_acpi_insert_dev_scope()  - same, by ANDD enumeration id
  dmar_acpi_dev_scope_init()    - the ANDD entries at the end of the table
  ir_parse_ioapic_hpet_scope()  - IOAPIC and HPET scopes

Each advances its cursor by a length read out of the DMAR table, and
nothing constrains it.  A zero length leaves the cursor where it is and
the walk never ends; a short one steps through table payload a byte at a
time, reinterpreting it as scopes.  dmar_alloc_dev_scope() and
dmar_acpi_dev_scope_init() run on every boot with the IOMMU enabled, and a
short length in the latter hands andd->device_name to acpi_get_handle().

Use the check dmar_walk_remapping_entries() already uses.

Checked against torvalds/linux at HEAD; both files are unmodified there.

Found by EFSM.R17, which reports a loop whose cursor advances by a step
memory can supply as zero while the exit condition depends on that cursor.
Signed-off-by: Shirong Zhao <shxzhaosr@163.com>

---
 drivers/iommu/intel/dmar.c          | 16 ++++++++++++++++
 drivers/iommu/intel/irq_remapping.c |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ba675b0..1615ef6 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -94,6 +94,10 @@ void *dmar_alloc_dev_scope(void *start, void *end, int *cnt)
 			scope->entry_type != ACPI_DMAR_SCOPE_TYPE_HPET) {
 			pr_warn("Unsupported device scope\n");
 		}
+		if (!scope->length) {
+			pr_warn(FW_BUG "Invalid 0-length device scope\n");
+			break;
+		}
 		start += scope->length;
 	}
 	if (*cnt == 0)
@@ -227,6 +231,10 @@ int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
 
 	for (; start < end; start += scope->length) {
 		scope = start;
+		if (!scope->length) {
+			pr_warn(FW_BUG "Invalid 0-length device scope\n");
+			break;
+		}
 		if (scope->entry_type != ACPI_DMAR_SCOPE_TYPE_ENDPOINT &&
 		    scope->entry_type != ACPI_DMAR_SCOPE_TYPE_BRIDGE)
 			continue;
@@ -743,6 +751,10 @@ static void __init dmar_acpi_insert_dev_scope(u8 device_number,
 		for (scope = (void *)(drhd + 1);
 		     (unsigned long)scope < ((unsigned long)drhd) + drhd->header.length;
 		     scope = ((void *)scope) + scope->length) {
+			if (!scope->length) {
+				pr_warn(FW_BUG "Invalid 0-length device scope\n");
+				break;
+			}
 			if (scope->entry_type != ACPI_DMAR_SCOPE_TYPE_NAMESPACE)
 				continue;
 			if (scope->enumeration_id != device_number)
@@ -778,6 +790,10 @@ static int __init dmar_acpi_dev_scope_init(void)
 	for (andd = (void *)dmar_tbl + sizeof(struct acpi_table_dmar);
 	     ((unsigned long)andd) < ((unsigned long)dmar_tbl) + dmar_tbl->length;
 	     andd = ((void *)andd) + andd->header.length) {
+		if (!andd->header.length) {
+			pr_warn(FW_BUG "Invalid 0-length namespace entry\n");
+			break;
+		}
 		if (andd->header.type == ACPI_DMAR_TYPE_NAMESPACE) {
 			acpi_handle h;
 			struct acpi_device *adev;
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 25c26f7..884347c 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -933,6 +933,11 @@ static int ir_parse_ioapic_hpet_scope(struct acpi_dmar_header *header,
 			ret = ir_parse_one_ioapic_scope(scope, iommu, drhd);
 		else if (scope->entry_type == ACPI_DMAR_SCOPE_TYPE_HPET)
 			ret = ir_parse_one_hpet_scope(scope, iommu, drhd);
+		if (!scope->length) {
+			pr_warn(FW_BUG "Invalid 0-length device scope\n");
+			ret = -EINVAL;
+			break;
+		}
 		start += scope->length;
 	}
 

