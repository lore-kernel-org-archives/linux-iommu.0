Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58D4014A1
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547989; cv=none; b=owyjK/7p+H7OxdQz+irkrufmjtSc3Zd7AX4tcbTryFmJmyXzHACQisHrXKpKmC0jZwDRJfyuIAmK04H+E+ZGhr53T+u5pj723S8/TFecbV0ujT/NNrtpBV+Oi9LrOGfxeYrYP7yqAkuSl0kU+eGnZ9IpCoUc4pjC0KLctUWHS/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547989; c=relaxed/simple;
	bh=6YuLdYYA9D6BnpuXS9x3E3B13sbag1xENXAyfYSuLWo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VEYul7I6Gmkub+1aY39StcJTcohZm6ZhLPVIlyxb2ICi0e19YGEBqj7OFmMN3TxlGcqoHsQRf+76bz5OdT10C8TYk7sPRhrcHpVtbGraPJOjI1qZYcln+zdrRBfn4pX0WJTuSBqCZvB3ktVRr2xT/miDLRdlV5zMoy9HA/Q73s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowADHND+FCl5qZpqIAA--.52370S2;
	Mon, 20 Jul 2026 19:46:13 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Ankit Soni <Ankit.Soni@amd.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2] iommu/amd: bound the early ACPI HID map
Date: Mon, 20 Jul 2026 19:46:13 +0800
Message-ID: <20260720114613.92391-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHND+FCl5qZpqIAA--.52370S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKFyDJF43ZF48Wr15urWxWFg_yoW8JrW7pF
	4jgr12krnYgFWxGFsxAa4UZa45GanxAFWIyFZ0kwn5Zr1UZFy8GrZ5ua40qr1kJrsrKF4a
	yr10qay5Ca45Ga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU13ku3UUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The ivrs_acpihid command-line parser appends entries to a fixed
four-element early_acpihid_map array. Unlike the sibling IOAPIC and HPET
parsers, it does not reject a fifth entry before incrementing the map size.

Check the capacity at the common found label before parsing the HID and
UID or writing the entry.

Fixes: ca3bf5d47cec ("iommu/amd: Introduces ivrs_acpihid kernel parameter")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260704011601.62087-1-pengpeng@iscas.ac.cn/
- move the capacity check to the start of the found path
- describe the condition as a full map rather than an invalid option
- rebase onto v7.2-rc4

 drivers/iommu/amd/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index e93bcb5eef70..e7d7b4cb9337 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3864,6 +3864,12 @@ static int __init parse_ivrs_acpihid(char *str)
 	return 1;
 
 found:
+	if (early_acpihid_map_size == EARLY_MAP_SIZE) {
+		pr_err("Early ACPI HID map overflow - ignoring ivrs_acpihid%s\n",
+		       str);
+		return 1;
+	}
+
 	p = acpiid;
 	hid = strsep(&p, ":");
 	uid = p;

