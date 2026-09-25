Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CCF36215D
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345742; cv=none; b=gtvakZyZxZEC7F+0oUjuDVOcbMwj+pTeYm1oKprxzpIm3gJ7SBJpAq/B/aTVL+x8mAHRIZRUzZeHM5JnHBrFT1Ct/XLwi+pA4ahDaOwjhViuVv/uRzdWJ+naJ0ktlfTfVTxgvSL5p15U9P3qJfkV/e4sTDz3KDb+2cFEVgRsYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345742; c=relaxed/simple;
	bh=tvSSoRq2UFePIVL6RzNDddV/WFF+MdKd2YkIq0J7MbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCH4PgBNmGBCdNeH1UPnofYQTSwZYgaWxGXVr5PTtBLQz/TzXM29P+Icgw9ta4YuXC5UucklCOnyNgMAYeRRDhLP5cz0vxz88sBxkjdtL7HeFzEKXGt7q0TarJDhOSvjKHH6fC2/v8/pbx6kgH3gpLF99yhXOxqEEEWfHF6MrzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Yx+gdAsb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ownh1sgV; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Yx+gdAsb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ownh1sgV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 654DE140015A;
	Fri, 25 Sep 2026 10:15:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 25 Sep 2026 10:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1790345737; x=1790432137; bh=dFImymqJ58
	2yn/mBoWa/LNPDaCA7McUmWhyuGJ48+PA=; b=Yx+gdAsbx4AWAIjS25buGp2077
	xb5dk9nY7aDBEetOb9+iEljCwXp0GXY+cr3mD3UadrUVXhwEy1W9fK+BoLaR0IAD
	/rKPwGBzEsWGlDCkcNycYnG0V+AQP+CX7Qt0+k/MqIsH2EqZZVJ1KqtgE9zfYe4w
	I8gc137E0cZJiB1r6aecfJ1hZdsGGebL1o465TnAjrb5tJskZnw19vgL+g2CJzlH
	bRK2KA7bd1tlLn//cISk4pfxfcTNQKUX9AsFEuPX5c8oACT+vahV54aEFaqj+gOd
	rpJd9TuL7BvGfEZzynuvuGalA349ZTWieoZi/gfSqBMO2d8rLbG5tWdbTAgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790345737; x=1790432137; bh=dFImymqJ582yn/mBoWa/LNPDaCA7McUmWhy
	uGJ48+PA=; b=ownh1sgVfit33Dq6Hr0h0d9eBW9LdYZdqH0hk7OFOatLgoZrvn1
	lQzE03KiOxuC40LbL1LyvGM3s+DgN4I8RVe761qVYR60/BsoL1cZEkC0yb9BJ8vl
	I/VxTCJrohJ0LbA4ET6krM00+bvK6aofV5uWugN+OIuwOVy2SDaB2kLsvOl3/YqK
	Z3t2EIWV1RDmJK4CHanvjSmq3Md9KBwSU6RjV3BPoqwBkojfyZNYv3R/n0Zw+W8m
	5WUcn2gXzUIXqn9pTrTSbQ4uLQ6L5plszHtQD/7robnDBnAI3W1HhONAbGpGm1hv
	e+zeN8j6QNVOjz3lUFMM/QiokMLOj4GMXOg==
X-ME-Sender: <xms:CIK2apFJVQfYdIMDSgoBmj7f6POWt0j2ZnQFvSxgZxoy1WjGrj1Nbw>
    <xme:CIK2al8RzEYzWunRyVM2yTQxVaNs9A-ryAk0SzA9xzYWruKFjoggKB5oYKQC9DXr0
    NhemUncKwM3K39ZnJCeGf8IxNgCxe7KFHEofohzY1XQqGnXV9F6VvQ>
X-ME-Received: <xmr:CIK2arXG2_cqHfnlcUN8Xh0vdYHWXQad_Oiy1m0u0Y1nU1A3easlkI1gw8E>
X-ME-Proxy-Cause: dmFkZTFtVMPCrlBVoZqL+SJIZp0s2Jd7Wu3nUF+AUN1gAS1aD7ulj63R8JOoTdDeAqN4Tu
    9hGImosjjpSUvLz/rROF2ESivswRYFsyWEvAExY7WLxcp3hJhBaW2wSSR+iSE2AMoMCOvv
    wmePoZYRugZRdfBQwTMOyRLBvCAqdTaSXY/seQ96bpaeJrtuxpKpyUpyLLZM4zsSNKA6R9
    sfIelzdHvwllgaTwh00ExxojlXwovGySFTNIiWbIvOqOAy3EnOxM/prZZsE/BWUIpsaIJ7
    +7mZ3xSvs/WxDcigCm+xwvVCb4WaJPHtXplm6EEvzWBLbhDSQk6/C5Kc+QdpbVJmCmQpB+
    LtlgLh6gUd7oDD4RO57CXVC/g623izbtBgqI+wI9DqrYOogHJmBB/lAtYLexjw5TdMZBu9
    AVZDpilsZH/aQmKRTTpTvbjiyA5HJexCZveLOdp/xyrh9tuVwaZUsVPNAR5uN5R2LSouiV
    U9Tx0IZsKKG5568r2MnwbTP1jqP8Vv1Kwc8pFK6AhFVrIbcp455BZNyQW9epkLjOmztdiV
    Q5/VHyC5N6kcloNjjffjuHuAlayxZqz9EiC6rEsueLWje9q+y/qKdbri1Mde+gqWkad85o
    Cjs1usZWPO95e3N3zH5xrlHvht/1rBPun6TWZVJvD7m+Hr4PkzT6Zbj4EcJw
X-ME-Proxy: <xmx:CIK2anEeuIil0U4Pi78Su9EC5qoqpkhIoJxcbRhPP7bbxqQ9ySSLeQ>
    <xmx:CIK2av4i_HVn6oKbP3VUK2yapK3fq-m7epeqWq8rN1lgQRCq3hLZAg>
    <xmx:CIK2apK27Re_JCRxFyCoIFudINbYucZ96mMg6qLMGF3mbqfoTExk5g>
    <xmx:CIK2aqDbJq9Lq22JpbJTlzKycJM1_y4nT4n3D28MKtPld-G-IJsSuQ>
    <xmx:CYK2ajXSQLGawnttQoZeXhEGVNSYejMEKMoU_N5PDPKC-8h1xpjNLFb0>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 10:15:36 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Breno Leitao <leitao@debian.org>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Yuanhe Shu <xiangzao@linux.alibaba.com>,
	Kyle McMartin <jkkm@meta.com>,
	Usama Arif <usama.arif@linux.dev>,
	kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] iommu/arm-smmu-v3: Make the queue depths tunable, and shrink them in a kdump kernel
Date: Fri, 25 Sep 2026 15:15:28 +0100
Message-ID: <20260925141532.1274962-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

The queues are sized from the IDR1 maxima and allocated at probe, costing
megabytes per queue per SMMU instance. A kdump capture kernel pays that out
of a small crashkernel reservation, for queues it barely uses and two of
which it switches off anyway.

Patch 1 adds a cmdq_max_n_shift module parameter, decided in a per-queue
helper and floored at one page. Patch 2 has a kdump kernel size all three
queues at one page through the same helper. The parameter does not apply
there.

Yuanhe Shu tested v6 on an arm64 server with six SMMUv3 instances, 64K
pages and a 512 MiB crashkernel reservation. Without the series the queues
took 192 MiB and the capture kernel OOMed before makedumpfile ran. With it
they take about 1 MiB and the vmcore is saved.

Measured per instance under QEMU on -M virt,iommu=smmuv3 with the virtio
devices behind the SMMU, the capture kernel identified by elfcorehdr= on
the command line:

                        4K page          64K page
      cmdq         1 MB -> 4 KB      8 MB -> 64 KB
      evtq         1 MB -> 4 KB     16 MB -> 64 KB

cmdq_max_n_shift moves the command queue alone outside kdump and is
ignored inside it; zero gives one page. QEMU exposes no PRI queue, which
takes the same path. No CMD_SYNC timeout, GERROR or context fault in any
run. Build-tested across 4K/16K/64K, TEGRA241_CMDQV=n, CRASH_DUMP=n and
ARM_SMMU_V3=m, every commit warning-free.

v7:
 - Flatten the depth helper as Jason suggested: floor the limit, then min
   with the hardware maximum; callers pass their alignment cap as the
   limit.
 - Initialise cmdq_max_n_shift to CMDQ_MAX_SZ_SHIFT, so zero is no longer
   the "default" sentinel; it asks for the smallest queue, one page.
 - A kdump kernel always gets one page; cmdq_max_n_shift no longer
   overrides it.
 - Tags: Breno's and Jason's Reviewed-by on patch 1, Jason's Reviewed-by
   and Yuanhe's Tested-by on patch 2.

v6: https://lore.kernel.org/all/20260909095228.2174031-1-kas@kernel.org/
v5: https://lore.kernel.org/all/20260907095835.1233352-1-kas@kernel.org/
v4: https://lore.kernel.org/all/20260902121724.3494954-1-kas@kernel.org/
v3: https://lore.kernel.org/all/20260706084708.8072-1-kas@kernel.org/

Range-diff against v6:

1:  ee766da1c34e ! 1:  65d617205157 iommu/arm-smmu-v3: Add a cmdq_max_n_shift module parameter
    @@ Commit message
     
         Add cmdq_max_n_shift, a cap on the depth given as the log2 of the entry
         count, the form the hardware itself takes in the LOG2SIZE field of
    -    CMDQ_BASE. Decide the depth in arm_smmu_cmdq_max_n_shift(), which caps the
    -    IDR1 value for natural alignment and then applies the parameter, so the
    -    queue is allocated at the requested size. The Tegra241 CMDQV sizes its
    -    VCMDQs from IDR1 itself, so route that through the same helper.
    +    CMDQ_BASE. It defaults to the largest depth the driver allocates, so an
    +    unset parameter changes nothing. Decide the depth in
    +    arm_smmu_cmdq_max_n_shift(), which applies the parameter to the IDR1
    +    value, so the queue is allocated at the requested size. The Tegra241 CMDQV
    +    sizes its VCMDQs from IDR1 itself, so route that through the same helper.
     
         Floor the request at one page worth of entries. Without the floor, a small
         request trips the CMDQ_BATCH_ENTRIES check in arm_smmu_device_hw_probe()
    @@ Commit message
         fills the page.
     
         Assisted-by: LLM
    +    Reviewed-by: Breno Leitao <leitao@debian.org>
    +    Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
         Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
     
      ## drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c ##
    @@ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: module_param(disable_msipolling, bo
      MODULE_PARM_DESC(disable_msipolling,
      	"Disable MSI-based polling for CMD_SYNC completion.");
      
    -+static unsigned int cmdq_max_n_shift;
    ++static unsigned int cmdq_max_n_shift = CMDQ_MAX_SZ_SHIFT;
     +module_param(cmdq_max_n_shift, uint, 0444);
     +MODULE_PARM_DESC(cmdq_max_n_shift,
    -+	"Cap on the command queue depth, as log2 of the number of entries. Zero means the hardware maximum; the queue never shrinks below one page.");
    ++	"Cap on the command queue depth, as log2 of the number of entries. Defaults to the hardware maximum; the queue never shrinks below one page.");
     +
      static const struct iommu_ops arm_smmu_ops;
      static struct iommu_dirty_ops arm_smmu_dirty_ops;
    @@ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: static struct iommu_dirty_ops arm_s
     +
     +/**
     + * arm_smmu_queue_max_n_shift() - pick the log2 depth of a queue
    -+ * @ceiling: default log2 depth ceiling of the queue
    ++ * @hw_max_n_shift: log2 depth the hardware advertises in IDR1
     + * @ent_sz_shift: log2 of the queue entry size in bytes
    -+ * @shift: log2 depth asked for, or zero for the default
    ++ * @limit_n_shift: log2 depth to cap the queue at
     + *
    -+ * @shift is floored at one page, because coherent DMA is page granular: a
    -+ * shallower queue occupies the same memory as one that fills the page, and
    -+ * arm_smmu_init_one_queue() stops shrinking at a page too.
    ++ * @limit_n_shift is floored at one page, because coherent DMA is page
    ++ * granular: a shallower queue occupies the same memory as one that fills the
    ++ * page, and arm_smmu_init_one_queue() stops shrinking at a page too.
     + */
    -+static u32 arm_smmu_queue_max_n_shift(u32 ceiling, u32 ent_sz_shift, u32 shift)
    ++static u32 arm_smmu_queue_max_n_shift(u32 hw_max_n_shift, u32 ent_sz_shift,
    ++				      u32 limit_n_shift)
     +{
    -+	u32 floor = PAGE_SHIFT - ent_sz_shift;
    ++	u32 floor_n_shift = PAGE_SHIFT - ent_sz_shift;
     +
    -+	if (!shift)
    -+		return ceiling;
    -+
    -+	return min(ceiling, max(shift, floor));
    ++	limit_n_shift = max(limit_n_shift, floor_n_shift);
    ++	return min(hw_max_n_shift, limit_n_shift);
     +}
     +
     +/*
     + * Command queues are also allocated by the Tegra241 CMDQV for its VCMDQs, which
     + * need the same depth decision.
     + */
    -+u32 arm_smmu_cmdq_max_n_shift(u32 ceiling)
    ++u32 arm_smmu_cmdq_max_n_shift(u32 hw_max_n_shift)
     +{
     +	/* Capped to ensure natural alignment */
    -+	ceiling = min(CMDQ_MAX_SZ_SHIFT, ceiling);
    -+
    -+	return arm_smmu_queue_max_n_shift(ceiling, CMDQ_ENT_SZ_SHIFT,
    -+					  cmdq_max_n_shift);
    ++	return arm_smmu_queue_max_n_shift(hw_max_n_shift, CMDQ_ENT_SZ_SHIFT,
    ++					  min(CMDQ_MAX_SZ_SHIFT, cmdq_max_n_shift));
     +}
     +
      int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
    @@ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h: static inline void arm_smmu_domain_
      
      void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
      			      struct arm_smmu_cmdq *cmdq);
    -+u32 arm_smmu_cmdq_max_n_shift(u32 ceiling);
    ++u32 arm_smmu_cmdq_max_n_shift(u32 hw_max_n_shift);
      int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
      			    struct arm_smmu_queue *q, void __iomem *page,
      			    unsigned long prod_off, unsigned long cons_off,
2:  a1fc639ce127 ! 2:  07a25755ccf1 iommu/arm-smmu-v3: Default queue depths to one page in a kdump kernel
    @@ Commit message
         that either serve the handful of devices used to save the dump or are
         switched off outright, and it is memory the dump itself needs.
     
    -    Default all three depths to one page worth of entries when
    -    is_kdump_kernel(). The queues carry commands and fault records rather than
    -    DMA data, so dump throughput is unaffected. A shallower command queue only
    -    bounds how many commands may be in flight before a sync, which does not
    -    matter for the few devices that save the dump.
    -
    -    An explicit cmdq_max_n_shift still wins, so a capture kernel that wants a
    -    deeper command queue can ask for one on the command line.
    +    Size all three queues at one page worth of entries when is_kdump_kernel().
    +    The queues carry commands and fault records rather than DMA data, so dump
    +    throughput is unaffected. A shallower command queue only bounds how many
    +    commands may be in flight before a sync, which does not matter for the few
    +    devices that save the dump. The cmdq_max_n_shift parameter therefore does
    +    not apply in a capture kernel.
     
         Suggested-by: Kyle McMartin <jkkm@meta.com>
         Assisted-by: LLM
    +    Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
    +    Tested-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
         Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
     
      ## drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c ##
    +@@ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: MODULE_PARM_DESC(disable_msipolling,
    + static unsigned int cmdq_max_n_shift = CMDQ_MAX_SZ_SHIFT;
    + module_param(cmdq_max_n_shift, uint, 0444);
    + MODULE_PARM_DESC(cmdq_max_n_shift,
    +-	"Cap on the command queue depth, as log2 of the number of entries. Defaults to the hardware maximum; the queue never shrinks below one page.");
    ++	"Cap on the command queue depth, as log2 of the number of entries. Defaults to the hardware maximum; the queue never shrinks below one page. A kdump kernel always uses one page.");
    + 
    + static const struct iommu_ops arm_smmu_ops;
    + static struct iommu_dirty_ops arm_smmu_dirty_ops;
     @@ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: static struct iommu_dirty_ops arm_smmu_dirty_ops = {
       * @ent_sz_shift: log2 of the queue entry size in bytes
    -  * @shift: log2 depth asked for, or zero for the default
    +  * @limit_n_shift: log2 depth to cap the queue at
       *
    -+ * The default is @ceiling, except in a kdump capture kernel, which defaults to
    -+ * one page worth of entries.
    ++ * A kdump capture kernel gets one page worth of entries whatever the limit.
     + *
    -  * @shift is floored at one page, because coherent DMA is page granular: a
    -  * shallower queue occupies the same memory as one that fills the page, and
    -  * arm_smmu_init_one_queue() stops shrinking at a page too.
    -@@ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: static u32 arm_smmu_queue_max_n_shift(u32 ceiling, u32 ent_sz_shift, u32 shift)
    +  * @limit_n_shift is floored at one page, because coherent DMA is page
    +  * granular: a shallower queue occupies the same memory as one that fills the
    +  * page, and arm_smmu_init_one_queue() stops shrinking at a page too.
    +@@ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: static u32 arm_smmu_queue_max_n_shift(u32 hw_max_n_shift, u32 ent_sz_shift,
      {
    - 	u32 floor = PAGE_SHIFT - ent_sz_shift;
    + 	u32 floor_n_shift = PAGE_SHIFT - ent_sz_shift;
      
    --	if (!shift)
    -+	if (shift)
    -+		shift = max(shift, floor);
    -+	else if (is_kdump_kernel())
    -+		shift = floor;
    -+	else
    - 		return ceiling;
    - 
    --	return min(ceiling, max(shift, floor));
    -+	return min(ceiling, shift);
    -+}
    ++	if (is_kdump_kernel())
    ++		return min(hw_max_n_shift, floor_n_shift);
     +
    -+static inline u32 arm_smmu_evtq_max_n_shift(u32 ceiling)
    -+{
    -+	/* Capped to ensure natural alignment */
    -+	ceiling = min(EVTQ_MAX_SZ_SHIFT, ceiling);
    -+
    -+	return arm_smmu_queue_max_n_shift(ceiling, EVTQ_ENT_SZ_SHIFT, 0);
    -+}
    -+
    -+static inline u32 arm_smmu_priq_max_n_shift(u32 ceiling)
    -+{
    -+	/* Capped to ensure natural alignment */
    -+	ceiling = min(PRIQ_MAX_SZ_SHIFT, ceiling);
    -+
    -+	return arm_smmu_queue_max_n_shift(ceiling, PRIQ_ENT_SZ_SHIFT, 0);
    + 	limit_n_shift = max(limit_n_shift, floor_n_shift);
    + 	return min(hw_max_n_shift, limit_n_shift);
      }
      
    ++static inline u32 arm_smmu_evtq_max_n_shift(u32 hw_max_n_shift)
    ++{
    ++	/* Capped to ensure natural alignment */
    ++	return arm_smmu_queue_max_n_shift(hw_max_n_shift, EVTQ_ENT_SZ_SHIFT,
    ++					  EVTQ_MAX_SZ_SHIFT);
    ++}
    ++
    ++static inline u32 arm_smmu_priq_max_n_shift(u32 hw_max_n_shift)
    ++{
    ++	/* Capped to ensure natural alignment */
    ++	return arm_smmu_queue_max_n_shift(hw_max_n_shift, PRIQ_ENT_SZ_SHIFT,
    ++					  PRIQ_MAX_SZ_SHIFT);
    ++}
    ++
      /*
    +  * Command queues are also allocated by the Tegra241 CMDQV for its VCMDQs, which
    +  * need the same depth decision.
     @@ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
      	if (reg & IDR1_ATTR_TYPES_OVR)
      		smmu->features |= ARM_SMMU_FEAT_ATTR_TYPES_OVR;

Kiryl Shutsemau (Meta) (2):
  iommu/arm-smmu-v3: Add a cmdq_max_n_shift module parameter
  iommu/arm-smmu-v3: Default queue depths to one page in a kdump kernel

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 68 +++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  2 +-
 3 files changed, 63 insertions(+), 8 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.54.0

