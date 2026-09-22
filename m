Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F09042B30D
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066710; cv=none; b=F9RALlPUBzWf+5ZUNUXb5uBYUeMwMWYKYXPnffajwIw1FwlFR94/Fn8ttFTqsMKmLZ2dTv0tMtdGuWX9BNoo7rcWkmWe1e7nTgywBpvbEB8VI2Yj3hiibvCa+OB1f3E1lurw4z4oqhFkb/tTkYvM3cUeKdTrRAwuFjT9VRK4VkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066710; c=relaxed/simple;
	bh=HSqynHYwWyM3/AIAzPlw2zR5ssM3zxj+P+TMMRPO3o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnFJ3ArM55zBXdEAe6q4x/3B1Nx88j0MgWc/qlHMnZKdsDn/uBDEBoJciYvr6z2OHhTRhKDZBxaT3VoF5CXaqzDTLZEloVxSBz0YgwK9CpZEPzrfv8Zz0YgnjYiDL/Pc6bRUJh4I7Ca3E+bDrR50NIjdq4P2Cijro/7th+Qq4kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cozxXqin; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cozxXqin"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-398e10200a6so2419051a91.1
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 01:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066708; x=1790671508; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xFj2nCVpKiIz+n9fFlODHsR1pKxI11t8bWPyNgAqBFI=;
        b=cozxXqinOFZ0k99g2Qsg/hufjCZLMEvlqlWzlntSipUpXB7uzuQBG8ZBJyn4PClkSW
         k64nm48BZSRkOnawOlXTlAE3z2ntpHYpNxim8EudeMFb9HaHhha5e7alN8WsAoNq8WVl
         pIQYaJljgNYyL8QFtjSBq7pCirnj7mL+cEZUu29c7bzgMhvPx7/QZNxz7A60k+z0m7F4
         CHfgM2S0J005IgF/9GLG1dJvPFeBn+Au+L4Z1lkVBsicmHJCXsSBrmlYjP7w3X5Mp9s+
         jJhaj3W6AfnPz+AlM3LgIBsWZeDUIredPVTdX6eSXhbpQGK1sJNSrN0OmG/lMeTpWhQI
         hRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066708; x=1790671508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xFj2nCVpKiIz+n9fFlODHsR1pKxI11t8bWPyNgAqBFI=;
        b=MkbVHYYtXsSQFtTUDnz54fYYRq048RI9MGMOFGz5AbU9E0I/aBoMfqhsMU/vInIylD
         yklsqJwx7DCDXmzSocO8J0/QeUKEvaJpJJ8wtoedRopSAPDlzVIDrY63kHtrnCYnzny4
         YEjqTy4YH+N8Y6qCz9/Tt1R5xrEQjffA3mQE2YThacjb1zK6tTsYewPNqaBbNNTtIg/H
         JqwTQZyN9Mj7OZRrLuF+0o0gF+CfybubKJNIgKHvlyYHp1KHHAvsyZjXpH868T+c3R5Q
         Awqw3pzMP3oZTLCCMXKJJQPb1wPOyrMZ9/8oulHi/4cMrIyn2MbgyA1AsGG7/7TbxS8m
         tJUw==
X-Forwarded-Encrypted: i=1; AKwUvByzwVWcAT9wTvSWhVvWNogFXebv6NOqPc7GOsqqJId2skj5mDap4hC1lO02jRIBGj/vbSX0ZA==@lists.linux.dev
X-Gm-Message-State: AFuF++mTt7hCwDsStC6KFQUfiwGxe6CK0TuHNSG+5GknHfFta4MtmHxt
	6N/6rot8JwgvYCfYvejMEAOY4ewhZyUQLqt1mOltA5ugXu40muXa54FQ
X-Gm-Gg: AYBFou3QFBzF15W6uD4YAYDvk3fyoBuHi+qwPwq5H3YVs8EnVEpi7fEsQRZrQ6PmIQt
	E/1Mrn19Srkkpk1I6t3Nbb0769L4bYEY09yImGmDSDuoAB517C8oigmrJCACP65cN/W2PNyugkO
	DvtXsfLe/ALZMH7PQbAVoZpU51m89Qkcluxq2xzK/SsiB1IZprDtFq5yt7qDbSFvP/ntqAgUc/d
	Gks+jOsOsfdzX3AZlIlZxDyjVYw612w4r8NKekNM28vAEB5cRfHQcEHIz/u6G33/Y2ZBTN0b8as
	mOkLoPREUxj1SBUYRgd3texP+wcqxTTpPbTa/rrGP1OqnLinJUhbAHdWDMjMoNkVusp3mSpF13U
	f41jbs7ho8HRVaRc4G4zq9aG/btADdB9kC+IzUVcwlzzY+5T/Qmu+FkL2tKM8pV0g7Lg2VN3vkR
	EOqNDvujrOREHTK0OlXKDf0coIp4dtLqtvdESljFVV0BYXVC3q6ZGv8N/vWq/rO8qiQoV27jaER
	tBdWSI/G+nWxhCR3snlsg==
X-Received: by 2002:a17:90b:1d8c:b0:39d:f4fd:8075 with SMTP id 98e67ed59e1d1-3a073182cebmr486642a91.19.1790066708546;
        Tue, 22 Sep 2026 01:45:08 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674a5ae4sm3670016a91.12.2026.09.22.01.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:45:07 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v7 9/9] crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF header
Date: Tue, 22 Sep 2026 16:42:56 +0800
Message-ID: <20260922084256.1515554-10-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922084256.1515554-1-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Reserve regions (for GPU, DSP, ...) carry no data useful for crash
analysis. Exclude MEMBLOCK_NODUMP regions from the vmcore ELF header to
reduce vmcore size and capture time. crash_should_skip_region() now also
returns true for MEMBLOCK_NODUMP.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Baoquan He <baoquan.he@linux.dev>
---
 kernel/crash_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index c7acb2e449df..fdfeee5afa1a 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -270,10 +270,10 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	return 0;
 }
 
-/* Exclude NOMAP regions from the vmcore. */
+/* Exclude NOMAP and NODUMP regions from the vmcore. */
 static bool crash_should_skip_region(struct memblock_region *reg)
 {
-	return memblock_is_nomap(reg);
+	return memblock_is_nomap(reg) || memblock_is_nodump(reg);
 }
 
 static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
-- 
2.43.0

