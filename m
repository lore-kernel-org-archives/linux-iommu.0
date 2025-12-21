Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCBD3002C8;
	Sun, 21 Dec 2025 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766333413; cv=none; b=csSx6+avZ9p7ByAKRrDwLH8mx75/gRYAnB1s5CXzEsEQsp6yi9xpHCJP0AUE0gzIVzMEHcWVawykjiQ4iffEMtRBFNVQ6jvLvAqN95AIbLo8Obu3h5RsFZcjEGMSGqWjRp2drpXHll88QV8C+B8z1KEy4YGtzgWY1ngfbI+/hXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766333413; c=relaxed/simple;
	bh=8JhW/AIVPr/MiSpHSTVTOPPu4Co1j1DWUKPY4klH/fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ag8DZJhG/6B8qnncgZtGUbCVN9AYDc64IVeEp3qJwmHtbV0Dz+suhXJ8p+MZv2lyvSZskAXWqcd4HkYAYBTwmiyi4XG/Evsd7oyhK7NnkzwWilp4qO1wZ5VqPgf6BA4IcsZOIuzNO8VyNMWcGDImn2Ip+2ri81bg5rm82gfZWfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVJW5TLI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVJW5TLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C90CC4CEFB;
	Sun, 21 Dec 2025 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766333412;
	bh=8JhW/AIVPr/MiSpHSTVTOPPu4Co1j1DWUKPY4klH/fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pVJW5TLIc1WnpPMtEBWqyDFeiziw+2Ln/n0405sG+BksRmHBVTGEKRBKDjs+JlTka
	 ul5sTVJ5CMnC3BpiRL4zTwL7XNx0gUf746gmyTVt7Z3TIBYfxm9HIO3fO76PtXo44o
	 58O+1CVeuIcXAPEGHLImvSA1ZvXko40pirqC+zt8DeHvh/hhCXJLM/lQzoVR1z4Ety
	 hmhsQq4Q0boOKFWEeCJ4C3v70mqtdYYFA+vBkK3N7trZYkcKJdickU1Ana+82uF6iI
	 AsPgJjaIx+SQEKNO1onWdwa3/0o2WBmEFAoGXoI0J7azcYkTGe8nj8p34cfuakb7YN
	 IeN2jr6s9DA7w==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	will@kernel.org,
	maz@kernel.org,
	tglx@linutronix.de,
	robin.murphy@arm.com,
	suzuki.poulose@arm.com,
	akpm@linux-foundation.org,
	jgg@ziepe.ca,
	steven.price@arm.com,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH v2 3/4] coco: host: arm64: Handle hostconf RHI calls in kernel
Date: Sun, 21 Dec 2025 21:39:19 +0530
Message-ID: <20251221160920.297689-4-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251221160920.297689-1-aneesh.kumar@kernel.org>
References: <20251221160920.297689-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - Mark hostconf RHI SMC IDs as handled in the SMCCC filter.
 - Return version/features plus PAGE_SIZE alignment for guest queries.
 - Drop the 4K page-size guard in RMI init now that realm can query IPA
   change alignment size via the hostconf RHI

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/kvm/hypercalls.c | 23 ++++++++++++++++++++++-
 arch/arm64/kvm/rmi.c        |  4 ----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 70ac7971416c..2861ca9063dd 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -8,6 +8,7 @@
 
 #include <kvm/arm_hypercalls.h>
 #include <kvm/arm_psci.h>
+#include <asm/rhi.h>
 
 #define KVM_ARM_SMCCC_STD_FEATURES				\
 	GENMASK(KVM_REG_ARM_STD_BMAP_BIT_COUNT - 1, 0)
@@ -77,6 +78,9 @@ static bool kvm_smccc_default_allowed(u32 func_id)
 	 */
 	case ARM_SMCCC_VERSION_FUNC_ID:
 	case ARM_SMCCC_ARCH_FEATURES_FUNC_ID:
+	case RHI_HOSTCONF_VERSION:
+	case RHI_HOSTCONF_FEATURES:
+	case RHI_HOSTCONF_GET_IPA_CHANGE_ALIGNMENT:
 		return true;
 	default:
 		/* PSCI 0.2 and up is in the 0:0x1f range */
@@ -157,7 +161,15 @@ static int kvm_smccc_filter_insert_reserved(struct kvm *kvm)
 			       GFP_KERNEL_ACCOUNT);
 	if (r)
 		goto out_destroy;
-
+	/*
+	 * Don't forward RHI_HOST_CONF related RHI calls
+	 */
+	r = mtree_insert_range(&kvm->arch.smccc_filter,
+			       RHI_HOSTCONF_VERSION, RHI_HOSTCONF_GET_IPA_CHANGE_ALIGNMENT,
+			       xa_mk_value(KVM_SMCCC_FILTER_HANDLE),
+			       GFP_KERNEL_ACCOUNT);
+	if (r)
+		goto out_destroy;
 	return 0;
 out_destroy:
 	mtree_destroy(&kvm->arch.smccc_filter);
@@ -376,6 +388,15 @@ int kvm_smccc_call_handler(struct kvm_vcpu *vcpu)
 	case ARM_SMCCC_TRNG_RND32:
 	case ARM_SMCCC_TRNG_RND64:
 		return kvm_trng_call(vcpu);
+	case RHI_HOSTCONF_VERSION:
+		val[0] = RHI_HOSTCONF_VER_1_0;
+		break;
+	case RHI_HOSTCONF_FEATURES:
+		val[0] = __RHI_HOSTCONF_GET_IPA_CHANGE_ALIGNMENT;
+		break;
+	case RHI_HOSTCONF_GET_IPA_CHANGE_ALIGNMENT:
+		val[0] = PAGE_SIZE;
+		break;
 	default:
 		return kvm_psci_call(vcpu);
 	}
diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
index 9957a71d21b1..bd345e051a24 100644
--- a/arch/arm64/kvm/rmi.c
+++ b/arch/arm64/kvm/rmi.c
@@ -1935,10 +1935,6 @@ EXPORT_SYMBOL_GPL(kvm_has_da_feature);
 
 void kvm_init_rmi(void)
 {
-	/* Only 4k page size on the host is supported */
-	if (PAGE_SIZE != SZ_4K)
-		return;
-
 	/* Continue without realm support if we can't agree on a version */
 	if (rmi_check_version())
 		return;
-- 
2.43.0

