Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D81FDA61
	for <iommu@lists.linux.dev>; Sat,  4 Jul 2026 01:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783127772; cv=none; b=GY7WPPfpIXflkrFK6bfEji9QWJyqyGaHnL7EoPGv1HTrcpLU/bzJc5fkycLl5Gx1G1XTAHlVxHU5DQoaJxltb0QOSZ9GMUSGWJRuesuOJMjZMeU86aQ+IckAPGMcympMAAm1ltmWCBlYDpb3f+948yR2KZOgGY4G6OjT9JFL8+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783127772; c=relaxed/simple;
	bh=QIq0i1uRb4CD36VVnafIJ+x7ndn6LE7SYR47Ra66rrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iFLRohrtGTaJa+TYxN023JYNlN/zTwASJkNNA1SKSDpdRTKLcFvk2FxL1GsJU+Bcoo0TvQjSOVaz9/mALGX2wmqnpttclI+uvDyVz5waDHxuR+6AcUyYojmvRm0F+bdlzWFP8lpTximDglHUcxkpmI1YkA+4wzjtX7UzdWgtfcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowABX7RDTXkhqRsPEFg--.56832S2;
	Sat, 04 Jul 2026 09:16:03 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] iommu/amd: bound early ACPI HID map entries
Date: Sat,  4 Jul 2026 09:16:01 +0800
Message-ID: <20260704011601.62087-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABX7RDTXkhqRsPEFg--.56832S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZryxJFyfCF4fCrW7Ww4fAFb_yoWfJwc_CF
	n5A3s7Jrs3uF4UCF1Iqw13Z34fKa9ruanrur97tw17Jw13ZF4kW348Grn5Xw4UG3W5GF1k
	CrZ8urW0qrnrXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnG
	QDUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

parse_ivrs_acpihid() appends command-line ACPI HID mappings to the
fixed early_acpihid_map[] array, but unlike the neighbouring IOAPIC
and HPET parsers it does not check early_acpihid_map_size before
incrementing it and writing the next entry.

Reject additional ivrs_acpihid= entries once the fixed early map is
full.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/iommu/amd/init.c | 5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3888,6 +3888,11 @@
 		return 1;
 	}
 
+	if (early_acpihid_map_size == EARLY_MAP_SIZE) {
+		pr_err("Invalid command line: too many ivrs_acpihid entries\n");
+		return 1;
+	}
+
 	i = early_acpihid_map_size++;
 	memcpy(early_acpihid_map[i].hid, hid, strlen(hid));
 	memcpy(early_acpihid_map[i].uid, uid, strlen(uid));

