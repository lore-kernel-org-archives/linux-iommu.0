Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E0E3FADE0
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153820; cv=none; b=Vr+Ckk2N7mBiZHmVG1uza7JGq4tfgygnlsrM/dHaeXsctzKS7en0rZeSaya+mAx+FRB02fx2eRFIZGGd0trxMgRxNQRH/P6PqWqMfT0QpKhA+vq7ptomcDRjXCO0pyijLLLmvEFrGu1pL2ILoimLrRv9i0XgWN4erfL9p2MYRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153820; c=relaxed/simple;
	bh=EwJdYx0DkFLGAQ/IekPy/OuBYhXLLgmLidlbPoNrYxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIXzIFO6iCiPN8osgtp9nEbvKhCrJ41MMAD+s8O1WIAnQBiarNn8uk6RkE6gSQkVDX4UGVQwkhcGSM69Agm0zj0aigl9O+latrawwygNg2szwNISjxsnSwGEfsiqx7SILb8LQld208uOR1VWLwHlDu+d2H8SCqxEHzvxs+AOWHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Jioxe4ZQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Jioxe4ZQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 483641476;
	Mon, 27 Jul 2026 05:03:33 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 736C93F86F;
	Mon, 27 Jul 2026 05:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785153817; bh=EwJdYx0DkFLGAQ/IekPy/OuBYhXLLgmLidlbPoNrYxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jioxe4ZQQ2Z46lc7rSt5XFqxuDmRTAsNx2R1s6JvTpcRq56XiwnJwQzDNd4KhcEWw
	 IQSMYSwtlk4axVxA0H2V5tNgCKHwiuoLNBdU+wUl0v8EHTiSZIo8OOqUH6KRnMNQDu
	 ysEmWcA8jDa3SHHmD1iXZrmuwnp/gUxwGvGJJyWw=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	catalin.marinas@arm.com,
	joro@8bytes.org
Cc: jpb@kernel.org,
	jgg@nvidia.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] arm64: Add override for MMFR1.HAFDBS
Date: Mon, 27 Jul 2026 13:03:28 +0100
Message-ID: <d7b31cbcd984c1efa61d2fc97111150cc18e21b0.1785153415.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
In-Reply-To: <cover.1785153415.git.robin.murphy@arm.com>
References: <cover.1785153415.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In general it might be nice to have the ability to disable hardware
access/dirty bit management for debugging or performance comparison
purposes without having to rebuild the kernel. However once FEAT_HAFT
comes into the picture we also start to have a real functional concern
where the decision to use HAFT based on the boot CPUs can prevent SVA
or late-onlining if SMMUs/CPUs are later found to lack HAFT support.

To that end, add the appropriate MMFR1 override, with an easy "nohaft"
alias for the significant case, partly since the feature/field naming
isn't the most obvious, but also so it could potentially be redirected
in future if someone wanted to attempt a higher-level means of turning
off just HAFT usage independently from FEAT_HDBSS.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: No change.

 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 arch/arm64/kernel/pi/idreg-override.c           | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..7f23e5b8dc44 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -565,6 +565,9 @@ Kernel parameters
 	arm64.nogcs	[ARM64] Unconditionally disable Guarded Control Stack
 			support
 
+	arm64.nohaft	[ARM64] Unconditionally disable Hardware managed Access
+			Flag for Table descriptors support
+
 	arm64.nomops	[ARM64] Unconditionally disable Memory Copy and Memory
 			Set instructions support
 
diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
index bc57b290e5e7..0e051fec5afe 100644
--- a/arch/arm64/kernel/pi/idreg-override.c
+++ b/arch/arm64/kernel/pi/idreg-override.c
@@ -64,6 +64,7 @@ static const struct ftr_set_desc mmfr1 __prel64_initconst = {
 	.override	= &id_aa64mmfr1_override,
 	.fields		= {
 		FIELD("vh", ID_AA64MMFR1_EL1_VH_SHIFT, mmfr1_vh_filter),
+		FIELD("hafdbs", ID_AA64MMFR1_EL1_HAFDBS_SHIFT, NULL),
 		{}
 	},
 };
@@ -246,6 +247,7 @@ static const struct {
 	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
 	{ "nokaslr",			"arm64_sw.nokaslr=1" },
 	{ "rodata=off",			"arm64_sw.rodataoff=1" },
+	{ "arm64.nohaft",		"id_aa64mmfr1.hafdbs=2" },
 	{ "arm64.nolva",		"id_aa64mmfr2.varange=0" },
 	{ "arm64.no32bit_el0",		"id_aa64pfr0.el0=1" },
 	{ "arm64.nompam",		"id_aa64pfr0.mpam=0 id_aa64pfr1.mpam_frac=0" },
-- 
2.54.0.dirty

