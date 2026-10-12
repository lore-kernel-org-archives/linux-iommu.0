Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA65546F4BB
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795994; cv=none; b=qoXnt/0CFbEBEdqwBDui/mW5nk3nmVbVGoSZA3ix7SvBYctatBxf+tKP+ad9AlPeD3nGo1hi/8BSxt++6ZfW0GB3yGyELdAs24cKDLjsszesDjJiGP8zWrdcNcs9g1Jc7SBvHBdf3jJRxx2ex3bh5GPz3PY4PuxBbmgax9pPT0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795994; c=relaxed/simple;
	bh=R2YeaMNbURFkEIoSogMRREx3bQhA9PtIl5X75VogD8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMYq5mzcYSxHDXGmPkMeIUG0kZlfksJUSEFLQG4K3oNh+G0K+Y1l1X91zaHN5HHFs971GPTfIZGRjrVLWnXwENRa0919/TiLe1qGP4QorCkn4qXQUQDvOWirw3Ow1e1YxW6K/YAn/AG2qvUW3FGbfXkgxt18JL2iDLcfFEZNxMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lpAQoSLY; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lpAQoSLY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+k
	EkSyvwh6GSZa8ZjQ7pknaCKLLkHC0Sa4c2m2fLYTc=; b=lpAQoSLY+WBTi186WL
	JHjjH/YkzBj630NiQsaz9Yb7gQ60a9nNq7EbXKhyb05ELAbRBYNg41cYowZNmjWi
	Lir4RH1AV419QcW52kcbPwCfEIM97dt9UFhSkbyOnqcPmgH4NErQTZ9/9r2+a2MB
	kCMJ0A9VR/hVdHgxg7G8h7ekk=
Received: from WIN-TOG0NDEIICD.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBXH74Ao8xq2x4yDw--.48221S2;
	Mon, 12 Oct 2026 17:06:09 +0800 (CST)
From: Shirong Zhao <shxzhaosr@163.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: amd: Validate the IVMD length before walking by it
Date: Mon, 12 Oct 2026 17:06:06 +0800
Message-ID: <20261012090607.18-1-shxzhaosr@163.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBXH74Ao8xq2x4yDw--.48221S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4ftF1DKFW8AF4fuFW7Jwb_yoW8Xw15pF
	s3GF1qgrs0qF48t3Z7Ja1Fvay5Jw4rKF9Fkry5C390gw45Ww4I9FyrKFy2gFykGFWrKFWa
	vF42vrWDuFn5J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzD73UUUUU=
X-CM-SenderInfo: hvk06xhdrv2qqrwthudrp/xtbC7gG29GrMowEXOAAA3G

init_memory_definitions() steps through the IVMD entries at the end of the
IVRS table by m->length, a u16 read straight out of the table, and nothing
constrains it.

A zero length leaves p where it is and the loop never ends.  A length
shorter than the IVMD header steps through table payload one byte at a
time and reinterprets it as IVMD entries, and each one that carries
IVMD_FLAG_UNITY_MAP or IVMD_FLAG_EXCL_RANGE is handed to
init_unity_map_range(), which is what sets up the IOMMU unity mapping.

Require the length to cover the header, which is what IVRS already
specifies for an IVMD entry, and use FW_BUG as the rest of this file does
for malformed IVRS content.

Checked against torvalds/linux at HEAD; the file is unmodified there.

Found by EFSM.R17, which reports a loop whose cursor advances by a step
memory can supply as zero while the exit condition depends on that cursor.
Signed-off-by: Shirong Zhao <shxzhaosr@163.com>

---
 drivers/iommu/amd/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8a410d4..d446abc 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2702,6 +2702,10 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 
 	while (p < end) {
 		m = (struct ivmd_header *)p;
+		if (m->length < sizeof(*m)) {
+			pr_warn(FW_BUG "Invalid IVMD length %u\n", m->length);
+			break;
+		}
 		if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
 			init_unity_map_range(m, table);
 

