Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BD280E
	for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 05:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BF4C433C7;
	Fri, 21 Jul 2023 05:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689918074;
	bh=0sR/hh3ymgnytwcEpN7e3Bxvyj2317uJ22SBojwoHrg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=XJDPOYQuBXaHkGuVBfzdpzhsD33Xk2F50SXMfBBoRdh7H3B4d1xP63rafQuE85o64
	 GzGVzyClLQN0eOZOiT2ZOv8JH/gflmNYGO16h710rOQwN9oXIM70iRP7TAoLad1bFo
	 VnityvhDx9ebyX8rp6eNFmOeuwNALolF68Skge2w=
Subject: Patch "arm64: errata: Add detection for TRBE overwrite in FILL mode" has been added to the 5.15-stable tree
To: anshuman.khandual@arm.com,catalin.marinas@arm.com,corbet@lwn.net,eahariha@linux.microsoft.com,easwar.hariharan@microsoft.com,gregkh@linuxfoundation.org,iommu@lists.linux.dev,joro@8bytes.org,leo.yan@linaro.org,linux-arm-kernel@lists.infradead.org,mark.rutland@arm.com,mathieu.poirier@linaro.org,mike.leach@linaro.org,robin.murphy@arm.com,suzuki.poulose@arm.com,will@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 21 Jul 2023 07:40:50 +0200
In-Reply-To: <1689895414-17425-2-git-send-email-eahariha@linux.microsoft.com>
Message-ID: <2023072150-synapse-whisking-923f@gregkh>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    arm64: errata: Add detection for TRBE overwrite in FILL mode

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     arm64-errata-add-detection-for-trbe-overwrite-in-fill-mode.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable-owner@vger.kernel.org Fri Jul 21 01:24:02 2023
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Thu, 20 Jul 2023 16:23:31 -0700
Subject: arm64: errata: Add detection for TRBE overwrite in FILL mode
To: stable@vger.kernel.org
Cc: easwar.hariharan@microsoft.com, catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net, robin.murphy@arm.com, joro@8bytes.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Message-ID: <1689895414-17425-2-git-send-email-eahariha@linux.microsoft.com>

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit b9d216fcef4298de76519e2baeed69ba482467bd upstream

Arm Neoverse-N2 and the Cortex-A710 cores are affected
by a CPU erratum where the TRBE will overwrite the trace buffer
in FILL mode. The TRBE doesn't stop (as expected in FILL mode)
when it reaches the limit and wraps to the base to continue
writing upto 3 cache lines. This will overwrite any trace that
was written previously.

Add the Neoverse-N2 erratum(#2139208) and Cortex-A710 erratum
(#2119858) to the detection logic.

This will be used by the TRBE driver in later patches to work
around the issue. The detection has been kept with the core
arm64 errata framework list to make sure :
  - We don't duplicate the framework in TRBE driver
  - The errata detection is advertised like the rest
    of the CPU errata.

Note that the Kconfig entries are not fully active until the
TRBE driver implements the work around.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
cc: Leo Yan <leo.yan@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20211019163153.3692640-3-suzuki.poulose@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/arm64/silicon-errata.rst |    4 +++
 arch/arm64/Kconfig                     |   41 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c         |   26 ++++++++++++++++++++
 arch/arm64/tools/cpucaps               |    1 
 4 files changed, 72 insertions(+)

--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -102,12 +102,16 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2457168        | ARM64_ERRATUM_2457168       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A710     | #2119858        | ARM64_ERRATUM_2119858       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -733,6 +733,47 @@ config ARM64_ERRATUM_2457168
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+	bool
+
+config ARM64_ERRATUM_2119858
+	bool "Cortex-A710: 2119858: workaround TRBE overwriting trace data in FILL mode"
+	default y
+	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	depends on CORESIGHT_TRBE
+	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+	help
+	  This option adds the workaround for ARM Cortex-A710 erratum 2119858.
+
+	  Affected Cortex-A710 cores could overwrite up to 3 cache lines of trace
+	  data at the base of the buffer (pointed to by TRBASER_EL1) in FILL mode in
+	  the event of a WRAP event.
+
+	  Work around the issue by always making sure we move the TRBPTR_EL1 by
+	  256 bytes before enabling the buffer and filling the first 256 bytes of
+	  the buffer with ETM ignore packets upon disabling.
+
+	  If unsure, say Y.
+
+config ARM64_ERRATUM_2139208
+	bool "Neoverse-N2: 2139208: workaround TRBE overwriting trace data in FILL mode"
+	default y
+	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	depends on CORESIGHT_TRBE
+	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+	help
+	  This option adds the workaround for ARM Neoverse-N2 erratum 2139208.
+
+	  Affected Neoverse-N2 cores could overwrite up to 3 cache lines of trace
+	  data at the base of the buffer (pointed to by TRBASER_EL1) in FILL mode in
+	  the event of a WRAP event.
+
+	  Work around the issue by always making sure we move the TRBPTR_EL1 by
+	  256 bytes before enabling the buffer and filling the first 256 bytes of
+	  the buffer with ETM ignore packets upon disabling.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -363,6 +363,18 @@ static struct midr_range broken_aarch32_
 };
 #endif
 
+#ifdef CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
+#ifdef CONFIG_ARM64_ERRATUM_2139208
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_2119858
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+#endif
+	{},
+};
+#endif	/* CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE */
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -564,6 +576,7 @@ const struct arm64_cpu_capabilities arm6
 		ERRATA_MIDR_ALL_VERSIONS(MIDR_NVIDIA_CARMEL),
 	},
 #endif
+
 #ifdef CONFIG_ARM64_ERRATUM_2457168
 	{
 		.desc = "ARM erratum 2457168",
@@ -581,6 +594,19 @@ const struct arm64_cpu_capabilities arm6
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 	},
 #endif
+#ifdef CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+	{
+		/*
+		 * The erratum work around is handled within the TRBE
+		 * driver and can be applied per-cpu. So, we can allow
+		 * a late CPU to come online with this erratum.
+		 */
+		.desc = "ARM erratum 2119858 or 2139208",
+		.capability = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
+		CAP_MIDR_RANGE_LIST(trbe_overwrite_fill_mode_cpus),
+	},
+#endif
 	{
 	}
 };
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -56,6 +56,7 @@ WORKAROUND_1508412
 WORKAROUND_1542419
 WORKAROUND_1742098
 WORKAROUND_2457168
+WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_CAVIUM_23154
 WORKAROUND_CAVIUM_27456
 WORKAROUND_CAVIUM_30115


Patches currently in stable-queue which might be from stable-owner@vger.kernel.org are

queue-5.15/arm64-errata-add-detection-for-trbe-overwrite-in-fill-mode.patch
queue-5.15/ksmbd-validate-session-id-and-tree-id-in-the-compound-request.patch
queue-5.15/ksmbd-fix-out-of-bound-read-in-smb2_write.patch
queue-5.15/ksmbd-use-ksmbd_req_buf_next-in-ksmbd_smb2_check_message.patch
queue-5.15/ksmbd-validate-command-payload-size.patch
