Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2214264612
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 03:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779852698; cv=none; b=SA6jgoplFUuxSiQVGgBePI7i/VWW7AIt7lr7ZkLnhX5HJFHM5Skxp3iTXEdTveouUZpBp/hsWccx4hXBsuMWGYt8gtbAoPIBkl3FmeDYaGvJhW4HcBYytxOLQC+yyxXi99cqeE/cM3bvtjwawhcHRu/M240uLYLw3c8v1S+Ts2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779852698; c=relaxed/simple;
	bh=uLOeasSEYWAvpT8ERSE9h3DlJwiheu4obyaLXpGYn9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScOD5/iVhuQjpSo7a9EnPawNN1hkKARyp7vgN0BPNoTUchMl/vgRXLuyRMQ+WkKJQmLUckdo/qZN2mGs/PXh+fqRTQm8uLOL9n0bMdI6jdZ/GxgT+qxJ1nR64TW8ZinB2zsM6N5qI+jIH1GSxStKecL5w4M6KNqQX8PF7TgKVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVoHcR6f; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVoHcR6f"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-836ebdeb969so5041494b3a.3
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 20:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852696; x=1780457496; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcszoUDc7316A03Dx3QXGOd8FcU7DWvjuNUEWPnVcI4=;
        b=kVoHcR6ftpxL39fREQ/Kwxn4ZtRvbOs9BtCyEfo8qe1nN5Q/BC4gaPwbFDthJb/ps2
         +d8Xbt2Qk+Dl4utCbcf65fY/cFa9NQuRdBGLwH9wTVB4emD5mkdgP44eoZ/EWiHnq5YT
         1ZBlA3eniwD5n4tCvqFnFIN4DTqUffOtdFxWojV16oiNp/bojfY3MSHFqnVdfWiFVvbe
         7ahXxh/+57GrciANcJdMWm1yYJKGC6Jq3tLMAG9cTAtX5AHwnRAQf1h7h2TKDz6rAmwf
         zati2VFWblQM/Pjtd24L05lwgiD8xvNXRji1CuRT3uFbdq5CMwS0wOAp7nw61PSMoHLB
         8cKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852696; x=1780457496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HcszoUDc7316A03Dx3QXGOd8FcU7DWvjuNUEWPnVcI4=;
        b=APR7Tod7dd96o34caPSRv4P76Q3CPIx+x6NAP8ynvYxId0i6+xZugsjWgvZlX+qOjs
         yuuhxVRnx6p/clLZhO1cyl9e3Jaq/mY8TzkD/pyctM1NRguyQwHjrebypCvMSQNH6WBN
         e7FilsisjWIXAJkzVj3MNCmxrMgSuannvKR1ZBqpUqgM1yrQ1N60O9vLl08bFA2e4iH4
         JiUSYcBp/CgpFei5Z+vlM6XYZJ+ZoQTC+bTLk9vUOQvqvPPE2TyP0CYpbOulfCSmbtMA
         JUIi9jAXBqpDzR/ajJGrm35XovUs0e2K2HPEVrPiKtbcA9aHRrOSq+F/jaqKzBpw38+p
         dl/A==
X-Forwarded-Encrypted: i=1; AFNElJ+WXw8RXOf7zLEb7O3mFMaaIj+9fmoy1v3kOGFdHnwpCNPPl7OeZYOA3sDFCll1aCWaDgblXw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1bAHcXddHhi3LsEwWvezeFfuhUTbSHgguWf0ntX1g1/GW1cWf
	IFVjyQl1+4THytub29np7jF0kGlt8S9CFJyD3Cg5Zpv0iRsEFTOQwEQt
X-Gm-Gg: Acq92OFrdfIjzzwYf8P6F5c/c3MDtNHaKdvlHYwX7W+aWobmh3XqNWk2FrZr46rVIZk
	Aun4e2okaBtgxW3chKK3R9q5adtOHt5LnSfxgSxkQ6n7yWBdXO4osfBtGhDOAZh35jkP9sJrKnK
	nXKtZHkXnh+8P6Em1PEwz4zYbv8fvF9QEvgiWYxFiJKQgFi/34MVGQqbtKw2nlEYS6+REqaSBIp
	UbVMpSPX4UUWra+oYlrUUQFC3j/VDEJ+P6zx/18bzSoxXt7EfFPEbvKMEQhXu+9YhV9lthZfsLR
	OzWVlomzBs3r9QBC3YuCS8vnV2G1SnLjqYiogs6QbQTyZNDmk4UAdfgMFoCeMn3QPlE8QyFkv8R
	q5sOjaOn6uKpZogD0WXfCOSMbZg/2OX1OUDrUucFiXB2u7LbRHNu/uwpbEqYDNMmkP5DLutFZzX
	QZ9m3d6K0aEuhsSKj1/aYqkVjsYKYGflzD5eHKe/cnGiT/uHmOgPQszjqt1w==
X-Received: by 2002:a05:6a00:3a0d:b0:837:8c8f:8f51 with SMTP id d2e1a72fcca58-8415f3bdb92mr20798104b3a.47.1779852696430;
        Tue, 26 May 2026 20:31:36 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:31:35 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	quic_obabatun@quicinc.com
Subject: [PATCH v3 11/11] loongarch: kdump: exclude non-dumpable reserved memory regions from vmcore
Date: Wed, 27 May 2026 11:29:17 +0800
Message-ID: <20260527032917.3385849-12-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Apply the same non-dumpable reserved memory filtering to LoongArch
kdump as was done for arm64. Use of_reserved_mem_kdump_exclude() to
drop flagged regions from the elfcorehdr PT_LOAD segments, and
of_reserved_mem_kdump_nr_ranges() to pre-size the crash_mem array.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 arch/loongarch/kernel/machine_kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index 5584b798ba46..4b918c3d4a28 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/memblock.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -67,6 +68,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	nr_ranges = 2; /* for exclusion of crashkernel region */
 	for_each_mem_range(i, &start, &end)
 		nr_ranges++;
+	nr_ranges += of_reserved_mem_kdump_nr_ranges();
 
 	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
 	if (!cmem)
@@ -91,6 +93,10 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 			goto out;
 	}
 
+	ret = of_reserved_mem_kdump_exclude(cmem);
+	if (ret)
+		goto out;
+
 	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
 out:
-- 
2.43.0

