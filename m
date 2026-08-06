Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9A0439F60
	for <iommu@lists.linux.dev>; Thu,  6 Aug 2026 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008975; cv=none; b=i5agMATTM88Bww8JTWVq249+3d7dfQWb60VEwFad9VrYDpolGyjtsXXGhQYQTL5JRC2v2oeR5WvqN3FO+T41AcjC/zvO9SwgfWY62ZPM/XWBZVOENUlHJx6hKh/quEOXiTGAfiHuAGxbUcUgLruYlCvpilrWuosV/7apN6blZ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008975; c=relaxed/simple;
	bh=/woMQBlsW3X8qxXLH9mBLMDq8jOPUBo5XVC406TKw0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KB7OfQFSjP/O8O58FqtsyzWVb/la0lwkdoILfpCF16/yWpfn38QsAMwLEd5MU6sEZuOBFtaEVunusxHU/HmvJAGofWM1l1X2Feo7WgoQYaNGx0d2JfOjOtZHCag6TdGCnlmY4+3R2ydHgjD8fEzPZe06Jpl+94SHddtSZPWgBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QedUrxPB; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QedUrxPB"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-cbb818e57c9so1074147a12.0
        for <iommu@lists.linux.dev>; Thu, 06 Aug 2026 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786008972; x=1786613772; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rxssx1F9jirIGuLt/jYdKLTnwp1BKr8qLnqrQJiF24Q=;
        b=QedUrxPBxZK5v5B2yS+8g8vpRa6E+7tB8Aq4RKbSxJCk+EM932cGDvMSyEXc0ZKe/A
         6z3v3yuBo6q8EENZANViHpu5WGJ4IaqBblkqfvkoA3v/A9bKfn9BogZOhtchWXbu+43b
         OV9ywKUl9P0pVazj//ifH4bOdgGt7NOzgOm3cZP2IdlfMTL8RWSFrE+B86fZxR52yicI
         Wv0H4cpKYcYP4ueB6pghNAONB3YT6hjVgZK04rjdhddPtUiizbefoKsxmcxa1jrBtsKS
         /yFWVGEK9hyvmE21fb65rmMgbQQz1cgyYXgA/riJ7Cxs3OxyaESqFMklT4gpbDrEX1vD
         mQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786008972; x=1786613772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rxssx1F9jirIGuLt/jYdKLTnwp1BKr8qLnqrQJiF24Q=;
        b=avSeQO0sE/gK5oP4Ph5uOozXPf9hxTDe3YwI1TNs7D7iMu4w/KLPR8KTG8PU4BX1KI
         n0oqMoSmK/+IZDhmOc2yNGrfDTGdw5suCl8L6+xhCYlgww+Uyo3bOhgNYF9js2ry3uM+
         n+XisbbyldhspEtoxODgk3p9eXHDHCUQIx12cMEFTc1PgvDOU3nqhxyAKgSkKXDSfV+O
         DYUzdVSyQ8a0OP9FEelygYPGIBoie2GJerKy7My5rFQgfSIOgyh/0mQcOkdbgx5vX8aD
         aI/CMwPiPRLZXOjoFLI1nx4c+YfDcXMbvHxDuP5n/dKp7vp7uP7QL8jZzmOdjTVHQN30
         IZrQ==
X-Forwarded-Encrypted: i=1; AHgh+RoeY2ST9VwzHHxA1nDywydR95wM1RBlLXlOAB9ZnaC2cSsPytbcad0BVqqU5zTljKoRWyYSWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZ+Pb3BBkeJu4E1m+d1YdUaPg0YRx6daE6qc8NCXe/zPE412+p
	tBt7I6gtyUzyIz0xiq/Jmf212/GUxWr6T1mtOTWvt+MIcBjRRz2w5QO3
X-Gm-Gg: AR+sD13JPbrKYLeb+dFSAr5fo6MW3nY7Cr/QROfx6s1MOyKQhrFUqGpkiShkrWbXjvY
	DQ19DLUqh94Hnj7+oGysyLsvn1U43VN3EKkDEP1OtPagm+P2KCmxjBYQFcwcpuLS5gydR4TX5wW
	e4r4ksrgC8Qfz4onAw97/CfkcibO1cVSubDjNHb1eOqc1y7k0o7u2Uz3P8AIZi5AbyO7vF6hGSA
	S1iuQuuMO4VHSgMytlpmPufcu65KE/Z4SK4Q36fXlleu2VddMikq85///wZo7N5FUFPGD/oFUEg
	EXbpAp6ueVroA6y83ZjqbDWBapjW+k03z3ZpGwh5oul2zPqILem3Fct/OjtJjD87ob9H7RbtEG4
	gTCUYN5+X6xFdmTjNwPXZkHMW9FLvIwbVglwvpU69Tle7ey4x/7AJNRIgXBpXzwr+3skPfzVKJ3
	6yGDVXCE+v7SjFX1S5r0KV9zkxND6DrhzEWjPKZjuKsXcVhE6Z7nu2koYRM5ssWUl5jvadFPX2k
	Q==
X-Received: by 2002:a05:6a00:80e:b0:847:e791:d5c5 with SMTP id d2e1a72fcca58-84f2e0dc989mr14792962b3a.35.1786008972602;
        Thu, 06 Aug 2026 02:36:12 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b0aeasm1043878b3a.13.2026.08.06.02.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:36:11 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	rppt@kernel.org,
	baoquan.he@linux.dev,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	m.szyprowski@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev
Cc: kernel@xen0n.name,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com
Subject: [PATCH v5 3/8] of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
Date: Thu,  6 Aug 2026 17:35:14 +0800
Message-ID: <20260806093519.2907771-4-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806093519.2907771-1-chenwandun1@gmail.com>
References: <20260806093519.2907771-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Mark non-dumpable reserved-memory regions with MEMBLOCK_NODUMP so
kdump can omit them from the vmcore.

The marking is guarded by CONFIG_CRASH_DUMP so non-kdump kernels do not
pay the cost of splitting memblock.memory entries at NODUMP boundaries.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 drivers/of/of_reserved_mem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 7b1616b9c6c2..f38d11df6f15 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -674,6 +674,9 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
 			rmem->name ? rmem->name : "unknown");
 	}
 
+	if (IS_ENABLED(CONFIG_CRASH_DUMP) && !rmem->dumpable)
+		memblock_mark_nodump(rmem->base, rmem->size);
+
 	reserved_mem_count++;
 }
 
-- 
2.43.0

