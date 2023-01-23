Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7BB3224
	for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 16:52:02 +0000 (UTC)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
	by linux.microsoft.com (Postfix) with ESMTPSA id B136320E1ABC;
	Mon, 23 Jan 2023 08:51:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B136320E1ABC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1674492722;
	bh=i0eNBC8geNLV8JqFCv2fcWa+3Po0NQl3CMraZjyG/Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dO2HSdBdZIJS/Y+jT+0mTPO/b066+d6d8bahWzMpmk+tj1pybEaX3acD7STrMRqYs
	 CSrpN0FGXUsyxKKfPJEd4MAPNa/JoTd4A0zxzsaOAHx56uxZkU8QvzKBR3TeA4EsxY
	 +Eo+MAtUvYWGlE274l3mnSlEBX873JB4mL7mfDSA=
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: Jeremi Piotrowski <jpiotrowski@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Tianyu Lan <Tianyu.Lan@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	iommu@lists.linux.dev,
	Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Subject: [RFC PATCH v1 5/6] iommu/amd: Don't fail snp_enable when running virtualized
Date: Mon, 23 Jan 2023 16:51:27 +0000
Message-Id: <20230123165128.28185-6-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123165128.28185-1-jpiotrowski@linux.microsoft.com>
References: <20230123165128.28185-1-jpiotrowski@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeremi Piotrowski <jpiotrowski@microsoft.com>

Hyper-V VMs do not have access to an IOMMU but can support hosting SNP
VMs. amd_iommu_snp_enable() is on the SNP init path and should not fail
in that case.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 drivers/iommu/amd/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d1270e3c5baf..8049dbe78a27 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3619,6 +3619,12 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 int amd_iommu_snp_enable(void)
 {
+	/*
+	 * If we're running virtualized there doesn't have to be an IOMMU for SNP to work.
+	 */
+	if (init_state == IOMMU_NOT_FOUND && boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return 0;
+
 	/*
 	 * The SNP support requires that IOMMU must be enabled, and is
 	 * not configured in the passthrough mode.
-- 
2.25.1

