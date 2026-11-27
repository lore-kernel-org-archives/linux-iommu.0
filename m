Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770566;
	b=0A2lx2AKyECsXPJjTWSkOfHh3cKtEAKMYO8bOrUx3vn23lQ3Oxs6bmlUV+9VTMQL/B/w
	 7QYodGC4vVcK+9tU1464G1sFdwS04AAjXzxNpzzkqe01+YzB5Lnp59jndbvxkPMgA0dD0
	 ounXPGrcp9OAuiVKGT+aizWQZG86DK0oRBIkEizIOMxmFUKouCozJM7RJKGi73mhlOAfW
	 GXngAx+6WmuR1C+2S009GcJGQBoCp7aq3cvNdGbqEhYqcc/TOlNW2cfMbyoewttegJ5i5
	 pjU2Vp9OJn2Jikt0BhtwYDt9VtrtSjjK7za/JuEiumye8ypABU2OPJN6XiNQT6G/6lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oKmXp2d3TpfvxuGqVqHnwKm3WEcWPeyk8O3QNAPgerw=;
	b=KB4+CfRaYOgOJWs5+uKIAwNlbY1d0aOJ6WtoEHwk4YMe6cc4rX18OEqsvUI/wdHkZN8Z
	 MEPqKRXltq6nu1ai4DlFbHmyI1KcaUJHymwXbqUqahnZf7/7mm7Zic5i5kN5R5yYNUNPR
	 GZ8g8UURm9vw5uBIbJAS923K6Jzmb1xbMm8QPa/BquZkkTJGFzpIgW6VmWv9WfSneByPB
	 FPkIYE73iueI+5pUBsSbuna10cMJ7W7a+/GxIhEiKYxHV5as19JHM3a+JBHUTKwF4c44C
	 WOip1rNgqsKKo59o31+1fZd2Uz7IiLvCN+m0Uhlx1JufUbq8LSQ0YbVUihq+i2DLiaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zq8B7A97;
	arc=none smtp.remote-ip=74.125.227.139
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE1F606A31E
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 09:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EE1F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zq8B7A97
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2ea993271f2so32713575ad.0
        for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 01:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770565; x=1796375365; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oKmXp2d3TpfvxuGqVqHnwKm3WEcWPeyk8O3QNAPgerw=;
        b=zq8B7A97b0nyxWsobt/ab4F8mOuPzTwVqK5oF0A6gYMBSLKMp3e8sYF9zVx4gOwl61
         22H9flDv+rGGnZ5QmIRYL4hozthtSrPSpIvwAJDi3DU4yogdAiOc/BOVYscYblq2sQSW
         kES/jWdgEse5N5F7SzlJCgMEWOjl3/x+YGMc2ZUkNAXA/XKD08lP/UpJ6KkM4fA4QMgN
         +dO2ObZyGKeyBUL0xmEkN80JFx0RHP2bVTRsN+6dZByo90ShMQhR+lWJq2kSkOGhBKaH
         4qgU5YS1JIMH+YrHjJePY/wbgkVKsazFFB/aXEigc5IK5fcQ2dAKUQd4FnE8Awf2f/6C
         J/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770565; x=1796375365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oKmXp2d3TpfvxuGqVqHnwKm3WEcWPeyk8O3QNAPgerw=;
        b=nwyUh/YJmw01H8WqzLEJIx4lkyEOjVX1gZ7P+f6cY1prkwiKU6ST77XycGiF/+Ddne
         oWS0g1oiDj3vDnQTb6VK+eZ/IlVtXyc6KTuCA+di6+s+zbPZC/WM3IPOaJ7gTDUtLZ/q
         LPf5KbKwUpqe4+4DvJtW2vMLpOLBpwk3eel4TL/vj62HZuE0s1ye/s4D1zJ3+uXdnx4W
         BXIGJ2PkAYGyi6n3zWwYaGMfsDwPRX1Ero7ogEvOukgHjEwo8BdM7F9UcMhPGu4+MQ6F
         q5ifFFd1nRLUBAEjtLg3Tzdla+R9SCHmQLww56EURwIwB/Gk8zuXCaI4KQ9VNATaWqEe
         8j/Q==
X-Forwarded-Encrypted: i=1; AL+hErFLAlkI1QYYGpBrcAFYYhvd8h7sNW8xRloFoZWerQ83cit85sS5FoMBkrRl2GBmkZVx68oIyw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Xgi9rfiL8YaDiqidQvo8HOJfuSgIm59OXSCZ4jyUeNYuAoHZo
	1Q5+NC1HI3m+eBj87l3P/sdY1EBmCLQe/kSsGlkpUzIRvq1HwAuVhFU4
X-Gm-Gg: AZFdTZdAVgCtPDtHduppObH272CpNiKRRvwYG/3A2G7s2ZD5/ifbplQe+AQNKuIzPRf
	hTBh+jgXxvAX/SAdslwO3fqbjFWr0/y/gKog4x2fCccUVeuSpUR31rV1oB2xz7+eQIkzPI++DVI
	/cNJyOf/Gkc38TmIxsii+20iJYCDJVAOoy2se7GhbELCFLmcjEyIBYjxeApSNN42nOIiSIHI4MX
	nJA1A5E/5gwaMAFq1hVC44eLx2bXBKHTBWFtlvvtBHsd9wGDEOyshabKY5f++9fZ2187X+XnhRF
	12CjCbPO7T92crz3asd/Sy4+lq4w4nz8qk00k/o+KUDDzImILUtF2zQwuJoLnvhRvAZnFAXy9rL
	nrT2w8lIlEb0gv4tC5gyaoYT7SM/APwSwNfBKzFN7FhkUCsQtxGJcCIHJ04uwM9spFCjcjt4490
	BM9r+3ApTP/9wIvxCpPK91xWPOM2mAILfGgEsESZsiKr6Y3oJu4IKBs3Ah9XDx9ma6IiWF4biS+
	EMXqeIjpqMjPe50+ZfyfwDG+mOaTcb2P1ywVMH/6oLb8zi+2EqZNEFH4h1i+YWbk5IfwACgepi6
	Wew3lelr0e7V/OuazjrCQOFEkXpxQx/vP3tbdshF3Q==
X-Received: by 2002:a05:6a21:3a41:b0:3e2:30c1:fdf6 with SMTP id adf61e73a8af0-4014e5562aamr21306213637.89.1795770564971;
        Fri, 27 Nov 2026 01:09:24 -0800 (PST)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d06ee37sm11718725a12.28.2026.11.27.01.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:09:24 -0800 (PST)
From: Wandun Chen <chenwandun1@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
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
	ruanjinjie@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v10 8/8] crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF header
Date: Fri, 27 Nov 2026 17:07:23 +0800
Message-ID: <20261127090723.741253-9-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127090723.741253-1-chenwandun1@gmail.com>
References: <20261127090723.741253-1-chenwandun1@gmail.com>
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
index e161c8b65e00..0e2ddc933b22 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -283,10 +283,10 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
 }
 
 #ifdef CONFIG_ARCH_KEEP_MEMBLOCK
-/* Exclude NOMAP regions from the vmcore. */
+/* Exclude NOMAP and NODUMP regions from the vmcore. */
 static bool crash_should_skip_region(struct memblock_region *reg)
 {
-	return memblock_is_nomap(reg);
+	return memblock_is_nomap(reg) || memblock_is_nodump(reg);
 }
 
 unsigned int __weak arch_get_system_nr_ranges(void)
-- 
2.43.0

