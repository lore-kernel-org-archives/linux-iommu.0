Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571556;
	b=UaNv+YARz0PHpZJwUpmPw4RE4jrNZFR2+ZdnqAu/H6Z45i4sOsBKUh+ixaSBtWGG2OBC
	 /4nmpTk8LC0hFNvlABQ2B1RAfMNCubX6weH5ut5B+/aMbf9d/kmoho0cUOBMZvK21kQAZ
	 QsfgmjcuzJ7Y4er5tSnWJ5Y91QgKr45BOTGEe8e8f6kUMPbHRV8T8l7xDrdAMHmNvR5O5
	 D44rdTmUmUH2Vo2I+bh4KQ4LoAvtYJlBaPQ54OUFoydTrtPy9zqumSBEC/kQyuxsvUh2L
	 AkQgNj9nWAg1EejTOx/oXEqGWcIqiFIOppnAgusXkV1k0O7s0m5Hekf4U9n8wDG3E6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oKmXp2d3TpfvxuGqVqHnwKm3WEcWPeyk8O3QNAPgerw=;
	b=Y2bRzmAm/9yp1YyhLFdtbY0j3NhPHou2AsU/A6S2qVlKw5ctp9W1umafsySqM3cF6KRQ
	 TOE63wxd7KbAjJNvpIHk4EiCSEkGnVk7fWjzZ+eBeHQGkp1ZQywrZzPtgHEhS151ltrDK
	 9tgwnz+0s1IMAwlo8IR9VeZ52/uNWUSG1X8bjOuvmbLdbWxuXoh9Vc+K1i+ksWMNisz6E
	 iyv7sIUcDWzytWpLB4OTEv2CVtP6++dq1q0Z/y+PwJ2uG0Pk523SN0DARU5AFfaUn7m7j
	 PGjIt4+Q1qowkfa0kj3be8RIphqSrtt9aSJSM+Cxgyj+SUMjSpGx20GBxRTUG82p5Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bc8ZhHVu;
	arc=none smtp.remote-ip=74.125.228.1
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F8A606A319
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 08:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0F8A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bc8ZhHVu
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-cd63952c9f2so54640a12.1
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571555; x=1793176355; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oKmXp2d3TpfvxuGqVqHnwKm3WEcWPeyk8O3QNAPgerw=;
        b=bc8ZhHVua1M5CQ73QCiRBB0i3DOOLo6vRVKPaPQ1I4If3jejdRmgPd7aRtxM4By9Bw
         IyrrJQsXbv0dADCeOxU7rDrST3L+YhJa6GfoO9yxqjpTjk4dfiekwsnox8v6KUnqyWA5
         qO01zX8xTJ2J4b9RSLyLRfwEBWFq9TisIhiehmj5Nkuc90fxOJ5FdrRStTRTYBbkLz49
         jVu+Z/qvlcYtKikDoMp3rLl/VriolzrWBdRskRh7M43i7O6kQIz2c45OdEfR21BifD/C
         6Vp776pe8QGEpoVRiXJ/48EOI/N6GcmyspcH436pugwsceBFDk064WnqROMoTivH2DhH
         9Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571555; x=1793176355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oKmXp2d3TpfvxuGqVqHnwKm3WEcWPeyk8O3QNAPgerw=;
        b=X14HCjvtnx4W7BbmlvayKDID8eAsnOzEKw+eDATFsRbrk/QCtV4SGLgXPeeZan/Kkr
         6jx2zJc8MCFr76GlkUIMxSRi/DuuqFAZSxKIiyE/tOTcRayj4NEBYhVKCeZBf/+JC0p5
         RJ4+A00NbNdApRTvD4WlOSzLRggsTIO3gEVyJi4HP7peZjkG35czNu5ropXhL9C/eCEa
         QzNKe3Ou2NmFXuyWzj7UeRMaIIzsXP8NoFEunPJ0jyuQoLMQwfEHR9c9teeeHgux5hnr
         zJeDn+RGLjB3ZrVNTflHzGER21WisqeKVaztrzi7buwpP3K0xrOAQYQ7KBKLxvTcJSxQ
         8A5g==
X-Forwarded-Encrypted: i=1; AKwUvBzisoGQ4itbnE+eT4zanoxS6z0f5bi7hg1tXkfY3f1qk36g/flKzavsqQqT9SgVu6eL4Sx6gw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJpR6vVbhZ54EytxGSlN3ohhYIgPB36S5fm+Dcz9iWpL2h19uMA
	i1QK0QsSVgGFtf3qdEn9S3Gu2BRiWfLlyvmgHs7lS7dH/VmZ9780lX+R
X-Gm-Gg: AYBFou0sLcwKE9VQmWETBErXS9+dgca3OFWKbQiWypRFzkgpGzS9EYLxaGWO9e+4E3b
	4M0HD/RS2VXAa7SJAlFHaKLa+NXMPEGZB5ENb4bqDgXqZCsDZ50h0ta76Ze4od0a/ZjgxWSgNA2
	iFi9Z1YHK57Oj3jIzpe2xYgjLVcFATjzc2t5etxy3Mpj9sTSga0PYPvQLLoH4qCNg8MJo9gP3/v
	VTo1U/auy/V/l63KbFy/omAYVGvzRx5YVYe0OrEgnl+MyWtlBggFGs6lUbwvUIx9CPKRnQY/odx
	1Bzwo1qXtB+0hCPAaCt+sjV76lZmUQL0CoZYPUS1E7ZmLxpGJ43jOvnrrrAWdwziJi2NSrzAk1S
	BMWYMD0U6CvZ1IWnKWLxztCKNwmRDx7l6xHM335zDBhP30Qp8dAY0KHthGU2q4MdrCtNKx4Ajow
	RiXYnB+OuTn0zLDzPSRmS0deXTgl3MhamUb3cbJNonblYuDB7tf0HYf2qoKKaYqFzS9pQoVUcAv
	rnZMlQlEOoZt2vKdVS/RLZYn3+BQ4wNuzdZ1x0QgWLa1H8NcMLtQp9IDyOl3UkiXdcp
X-Received: by 2002:a05:6a00:1786:b0:89f:3f60:cd81 with SMTP id d2e1a72fcca58-8a089d539cdmr1130152b3a.51.1792571555108;
        Wed, 21 Oct 2026 01:32:35 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895e273bsm600653b3a.41.2026.10.21.01.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:32:33 -0700 (PDT)
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
Subject: [PATCH v9 8/8] crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF header
Date: Wed, 21 Oct 2026 16:30:11 +0800
Message-ID: <20261021083011.2170525-9-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021083011.2170525-1-chenwandun1@gmail.com>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
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

