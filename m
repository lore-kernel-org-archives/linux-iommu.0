Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E11E599A21
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 20:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094987; cv=none; b=WewcVgN1tsWUKaKhZEQxAdtHPKUCbZ9iNWniyCm6lDng4kWUiQA7YQcLyCFwkD+vQ+fgwR7EBpCZpll1FrfsmPP60B08BPf4hB0gIudcWOE8IcFaQI8ulNZ9p9Z0N92RcF4VVAkVxBPhvOdUbeM+0tw+E4Dj6g7hugzv1QRuLO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094987; c=relaxed/simple;
	bh=vuQ82iuTyv6dFRtcM5SHwsBOiusydyoSCEgHa3W9AvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YP3Rrphzy9sdh7AN7+ra2BF5Xff5H7QILuJb/8+2/qVyHfZxCq9ddykDyegO1OAUEeNDrJGvXhxYv6KvzEZ/xD/Jd2pDjfb1Q6QSIO1+li1gpWZVtsYF4pQW+XhpCgYGZfw/vbwPreUyu3x4ufU9rWEFmtcB0UfTU7Ax7sN5EME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PVhypNpY; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PVhypNpY"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a16db51147so37537915e9.3
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792094981; x=1792699781; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LIrVQ92JIOcBfxb2Vgbbd+S0vgGCTt9XwUnEmjZAhJs=;
        b=PVhypNpYeP2yS6e2oSYJKI9+ZPC32fQrli5cv2TUPAWI1DbJ5fmYerHY2qPaTzKMcx
         CMcohfWq809gWVxyUVoB2BB756q+zdkJJQzG28vmH+7EbD1Qx8N4l+uDGFoXn7W1dCp3
         dFeYszX7WUiEuSg073dplsk5TgB+8ABOGAdjrOmGFnM49hdezKYREiF+5b7i1UvOOYEO
         Akb9GR34OTpiqyTgoJSXqSnvDjzf2S7RwbKwKInOBFgElcs33P8MvjJgi4XuqLWZ/JP1
         iBflCQNz7FkLy4gf9h/KO5oy1wmxgLBNE3+9WtT0pOzLNOMBtPjCGzETPYMGII3qSBGr
         is4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792094981; x=1792699781;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LIrVQ92JIOcBfxb2Vgbbd+S0vgGCTt9XwUnEmjZAhJs=;
        b=ZzYW0gHmbM+vBUgnhSl8I153ttDkq92FS65mTKr6lEW/qPM7aseHRXf3L4WtvQSBT7
         LGe3uHr/TLveaxh9u9h8RcoANEEbuWP0ongo6XfjL0hwCgNdsHHGMBzUItZPhCfCYpW6
         yyMjcOOGyr9lPgRrZVdW7J1Fkq+bxLnvjdjIjZvZV/F9Gz8HnUVcgiMxsjew3qd4AyvZ
         RDLTD2IbgbcUX2J28OcX46fjJ/yygLH9/jqQh84yy+OvbHrJRUiruvvd59RwxcTuSR9O
         buN0F6JbovsfTvQLXTjX+cEhemosK4z7zyYxpeTX//KdLgTUY2/sq7OxFPwxTJC+jlc7
         VmUA==
X-Forwarded-Encrypted: i=1; AKwUvBzGeIRB6HytWIeQNSqgpUDABYKJUl78IwNqdLY+J3MY5m8Xx7U37oxs1V/u569BzJNu9miPLA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKQdDx1+57OEBkoL+eLCI2jYJljxX7fk4blvceyREXPCWHnWjUP
	baboXuX1t30bMeluH83BIJMCYqoUPP1vNfqSw9EqQ0h+xrhhBD3vIISRZEQJEwxm8u79ZAUAJXf
	3ytQYLTJhEe9vmQ==
X-Received: from wmoo13.prod.google.com ([2002:a05:600d:10d:b0:4a0:4b7:a33f])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c07:b0:4a1:b044:9ccd with SMTP id 5b1f17b1804b1-4a1b0449d00mr214328195e9.28.1792094981436;
 Thu, 15 Oct 2026 13:09:41 -0700 (PDT)
Date: Thu, 15 Oct 2026 20:08:56 +0000
In-Reply-To: <20261015200903.2735565-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261015200903.2735565-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261015200903.2735565-26-smostafa@google.com>
Subject: [PATCH v9 25/25] KVM: arm64: Add documentation for pKVM DMA isolation
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca, mark.rutland@arm.com, 
	qperret@google.com, tabba@google.com, vdonnefort@google.com, 
	nicolinc@nvidia.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Populate the section for DMA isolation in pKVM with the newly
added KVM IOMMU and pKVM SMMUv3 driver details.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 Documentation/virt/kvm/arm/pkvm.rst | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/arm/pkvm.rst b/Documentation/virt/kvm/arm/pkvm.rst
index 514992a79a83..ce67e2ae1f9a 100644
--- a/Documentation/virt/kvm/arm/pkvm.rst
+++ b/Documentation/virt/kvm/arm/pkvm.rst
@@ -77,7 +77,28 @@ Status: **Unimplemented.**
 DMA isolation using an IOMMU
 ----------------------------
 
-Status: **Unimplemented.**
+Status: Supported for devices behind SMMUv3 supporting dual stages
+of translation.
+
+With ``CONFIG_ARM_SMMU_V3_PKVM``, the hypervisor will take over the SMMUs
+on the system and provide an architectural emulation to the kernel SMMUv3
+driver.
+
+If some devices are not behind an IOMMU or behind another IOMMU architecture,
+DMA isolation is not supported, as a driver must be provided for that.
+
+DMA isolation is enforced by dual stages of translation; similar to the CPU
+where a driver can register their ops through ``kvm_iommu_register_driver``
+and implement ``host_stage2_idmap`` to shadow the CPU page table.
+
+The page tables for the stage-2 SMMUv3 will be allocated from a pool created
+at boot with size configured from the command line "kvm-arm.iommu_pgt_mem"
+The size must cover the worst case scenario for leaf mappings of system memory.
+
+This implementation trusts the system firmware not to allow the untrusted
+host kernel to bypass the SMMUv3.
+For example, by resetting the power. In that case, it is the firmware's
+responsibility to save/restore the SMMUv3 state.
 
 Proxying of Trustzone services
 ------------------------------
-- 
2.56.0.176.g3575e65682-goog

