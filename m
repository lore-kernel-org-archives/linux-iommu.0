Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0380D277815
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767120; cv=none; b=D4IZiSWInRWJ3ig/LtetuIJ98GlUp7KRNT55vpn8l2iZq/t2QzY4OtKXEFFKeqXUJrQgWXDzx8wfpM35GfTZKMII/WUlZMfLoh8uPMrGyh9BIzKZ/BoWrtuxASZ1nICWCzqT6KPhlFvVxjLEQI6PtnfRJ4TkodfHuH9axxtaRVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767120; c=relaxed/simple;
	bh=djccPEEFMYaKHClDuUek9aMXVl4Z7KLTcuB2qpFbJlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRSPXXHG9eB8InQuQof+YdDhkA6JT2sv+dUJ72kuAcLi0MO2iM5lMhbYB6H47G/xLcmojV+choAlmNBOjgl7NK7wfuv55k7Cvs9IuPz1dM4uv4mweItN4MWzhw7cJelUblCsSDcpprxx400F0XpYKRkc/rVIw47G6JXoFlT+mBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B77B4176C;
	Fri, 28 Feb 2025 10:25:33 -0800 (PST)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59A823F6A8;
	Fri, 28 Feb 2025 10:25:15 -0800 (PST)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	suzuki.poulose@arm.com,
	yang@os.amperecomputing.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	joro@8bytes.org,
	jean-philippe@linaro.org,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	oliver.upton@linux.dev,
	james.morse@arm.com,
	broonie@kernel.org,
	maz@kernel.org,
	david@redhat.com,
	akpm@linux-foundation.org,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	mshavit@google.com,
	jsnitsel@redhat.com,
	smostafa@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v2 3/4] arm64/mm: Elide tlbi in contpte_convert() under BBML2
Date: Fri, 28 Feb 2025 18:24:03 +0000
Message-ID: <20250228182403.6269-5-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250228182403.6269-2-miko.lenczewski@arm.com>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If we support bbml2 without conflict aborts, we can avoid the final
flush and have hardware manage the tlb entries for us. Avoiding flushes
is a win.

Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/contpte.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 145530f706a9..77ed03b30b72 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -72,9 +72,6 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
 		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
 
 	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
-
-	if (system_supports_bbml2_noabort())
-		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
 }
 
 void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
-- 
2.45.3

