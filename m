Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD2FA933
	for <iommu@lists.linux.dev>; Mon, 10 Jul 2023 08:23:30 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2FBA51F38D;
	Mon, 10 Jul 2023 08:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688977409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dirNkRoYAPOKgnokI62rBUKnm7Cm3Bq2fLafnXLX2rM=;
	b=2WvQvESn1/36HSzhMXVcSdjik+t5nYMXFKF1KG0UIusg8sySF8R7ITMWNIFtYhJeqKxy2O
	2KPFJpEbMJJaKLPNuVQjBi00LhQBwiIaRrPmGrF4blFthGkD+N2RyyqB/WriWGWOjCFh2N
	cdQ+D4xx8pVLj0yAENQAG3kCj9N2/Ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688977409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dirNkRoYAPOKgnokI62rBUKnm7Cm3Bq2fLafnXLX2rM=;
	b=SOrq1aFHj7y8/rOc5/XQp3i66j+CCZYnz5Q8FmAeO+0g1n+bwvV7x4RLNNfRR9K8JGsuoH
	/EGw8tcK+oLYHoBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B91FA13A05;
	Mon, 10 Jul 2023 08:23:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id pNAqKwDAq2QcDAAAMHmgww
	(envelope-from <svarbanov@suse.de>); Mon, 10 Jul 2023 08:23:28 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [RFC PATCH] iommu: arm-smmu-nvidia: Add default domain type implementation op
Date: Mon, 10 Jul 2023 11:22:52 +0300
Message-ID: <20230710082252.9702-1-svarbanov@suse.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add def_domain_type implementation op and override default IOMMU
domain Kconfig option (CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y), which
could be enabled on some distros. The current quirk has been done
for Tegra234 machine, because I found the issue on it. The issue
itself appears on USB host controller which cannot be initialized
without IOMMU translation. Something more, we proved that IOMMU
translation is needed for display and GPU drivers as well.

I evaluated few possible options to solve that:

 a) select default IOMMU domain from .def_domain_type op
 b) Unset CONFIG_IOMMU_DEFAULT_PASSTHROUGH=n
 c) add iommu.passthrough=0 on the kernel cmdline
 d) firmware - ACPI / DT

a) This option is implemented in the proposed patch.

b) Since that the community has agreed that pass-through is preferred
as a default IOMMU domain option because this will avoid performance
impacts on some of the platforms [1]. On the other side we have examples
where you cannot even install Linux distribution on a machine where the
storage media cannot be detected and the system just hangs.

c) - This option involves installer's knowledge of platforms/devices
which needs IOMMU translations.

d) - IORT ACPI table / DT - I'm not sure is that option even possible
but firmware looks like a good place for such.

Please, treat this as an RFC and a call for proper solution.

[1] https://marc.info/?l=linux-arm-kernel&m=148864682514762

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
index 87bf522b9d2e..691b57d1e699 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
@@ -286,6 +286,22 @@ static int nvidia_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
+static int nvidia_smmu_def_domain_type(struct device *dev)
+{
+	if (of_machine_is_compatible("nvidia,tegra234"))
+		return IOMMU_DOMAIN_DMA;
+
+	return 0;
+}
+
+static int nvidia_smmu_single_def_domain_type(struct device *dev)
+{
+	if (of_machine_is_compatible("nvidia,tegra234"))
+		return IOMMU_DOMAIN_DMA;
+
+	return 0;
+}
+
 static const struct arm_smmu_impl nvidia_smmu_impl = {
 	.read_reg = nvidia_smmu_read_reg,
 	.write_reg = nvidia_smmu_write_reg,
@@ -297,11 +313,13 @@ static const struct arm_smmu_impl nvidia_smmu_impl = {
 	.context_fault = nvidia_smmu_context_fault,
 	.probe_finalize = nvidia_smmu_probe_finalize,
 	.init_context = nvidia_smmu_init_context,
+	.def_domain_type = nvidia_smmu_def_domain_type,
 };
 
 static const struct arm_smmu_impl nvidia_smmu_single_impl = {
 	.probe_finalize = nvidia_smmu_probe_finalize,
 	.init_context = nvidia_smmu_init_context,
+	.def_domain_type = nvidia_smmu_single_def_domain_type,
 };
 
 struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
-- 
2.41.0

