Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A404E15ACE
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 12:09:19 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-564fb1018bcso98248407b3.0
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 05:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053358; x=1688645358;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nnyvtjh+kF3RLE+cug+CO0eM4y0oqNNfVmWbOcSnIjQ=;
        b=utkX65Vz0L6sR2kZ/cV8/Bs95MrkpKlOYv55JrePCNTvQTBAgFotFEAPUv6jg38AXp
         pPL3iz7Ctht5pHtoRtBxwvw9x2NfbiqVTKpH2ZNeguEbnOsevwaiOBVDfxeOXEONADZ2
         DcmayF+B0d7NbXxLFqYu5iprNU0JTO5D03WCzRj83Hzfx3cVFfrlTxjUf7ltPXdwUf7k
         RyHBqhu2S/M83S/KCELU8K0i9QH1/vAIzQPKdQMc5oOsm5Bn5Y4Z0DaAOpgdKXj/XIux
         6eaZI5eRA+8QJuJImLEteMOOIXGGVJz2OAbBfK0GjVcUQQ35CBdkE3LyH0rgUwR31OxJ
         g/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053358; x=1688645358;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nnyvtjh+kF3RLE+cug+CO0eM4y0oqNNfVmWbOcSnIjQ=;
        b=KXJo4aB7Vs+5MIFfl5v5Iz8vq0tgNeO/rR35fjOV/IrdWsgRlYOoKQPj+HXCO05l8F
         fdKHVmpKXtruNAsvfaArVfeFE9M439J/M5v/0lt70Hs2dLhmjb42mfETcr9G4F2kNmHJ
         T1BUE0vyyDSCY8caPsSkc5G8vv/rjL/gAVpvPae17NcOYOCRxXpcl2qKpIneOyP1141d
         0n8a7U5WP1Ypc/Xw8RSce7gAtL2lGqLjEquJxW1HFHcgN0z2UOAw7o6Uc4k+2ryE1Ypn
         IA4kPxQyenJatx5fVm3nrGpgziNq7Zh6qfs7Jzhj39SyznyYcTsyDntDyHpRD7L08/MS
         R/5w==
X-Gm-Message-State: AC+VfDztq0X2wsmOzD2GVbfgW/rPXjfMMsb4i7DpmuxYsoxOnMFy0nSE
	J1B2MYsu/IeN0f0eb2Uo5fGKp4hgUF81
X-Google-Smtp-Source: ACHHUZ6aSekWgWC0uGTChOHJuA02dRoV0LxXIWREsHrUrDfzJsBIcspGSrMwdLO1U5pFvSvOs25/Qr7k3QY6
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a5b:5ca:0:b0:b9d:b6cd:2dfd with SMTP id
 w10-20020a5b05ca000000b00b9db6cd2dfdmr958857ybp.8.1686053358499; Tue, 06 Jun
 2023 05:09:18 -0700 (PDT)
Date: Tue,  6 Jun 2023 20:07:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-1-mshavit@google.com>
Subject: [PATCH v2 00/18] Add PASID support to SMMUv3 unmanaged domains
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

This patch series implements the set_dev_pasid operation for DMA
and UNMANAGED iommu domains.

As a first step, the patch series refactors stage 1 domains so that
they describe a single CD entry. On attach, stage 1 domains are
inserted into a CD table that is now owned by the arm_smmu_master
struct. Note that this does not preclude from attaching domains that
represent a CD table, such as for the proposed iommufd NESTED domains.

The patch series also heavily refactors the arm-smmu-v3-sva
implementation. The first set of clean-up patches were enabled by
earlier changes in the iommu pasid framework. Later patches take
advantage of the arm-smmu-v3 changes and makes use of its set_dev_pasid
implementation.

This patch series is also available on gerrit with Jean's SMMU test
engine patches rebased on top:
https://linux-review.googlesource.com/id/I0fcd9adc058d1c58a12d2599cc82fba73da7697a
This allowed testing of basic SVA functionality (e.g.: attaching, page
fault handling, and detaching).

Thanks,
Michael Shavit

Changelog
v2:
 * Reworded cover letter and commits based on v1 feedback.
 * Added SVA clean-up and refactor.
 * Split and reworked iommu/arm-smmu-v3: Move cdtable to
arm_smmu_master
 * A few other small bug fixes and cosmetics.
v1: https://lore.kernel.org/all/20230510205054.2667898-1-mshavit@google.com/

Michael Shavit (18):
  iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
  iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
  iommu/arm-smmu-v3: Refactor write_strtab_ent
  iommu/arm-smmu-v3: Refactor write_ctx_desc
  iommu/arm-smmu-v3: Use the master-owned s1_cfg
  iommu/arm-smmu-v3: Simplify arm_smmu_enable_ats
  iommu/arm-smmu-v3: Keep track of attached ssids
  iommu/arm-smmu-v3: Add helper for atc invalidation
  iommu/arm-smmu-v3: Implement set_dev_pasid
  iommu/arm-smmu-v3-sva: Remove bond refcount
  iommu/arm-smmu-v3-sva: Clean unused iommu_sva
  iommu/arm-smmu-v3-sva: Remove arm_smmu_bond
  iommu/arm-smmu-v3-sva: Add check when enabling sva
  iommu/arm-smmu-v3: Support domains with shared CDs
  iommu/arm-smmu-v3: Allow more re-use for SVA
  iommu/arm-smmu-v3-sva: Attach S1_SHARED_CD domain
  iommu/arm-smmu-v3-sva: Alloc notifier for {smmu,mn}
  iommu/arm-smmu-v3-sva: Remove atc_inv_domain_ssid

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 164 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 493 ++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  62 ++-
 3 files changed, 457 insertions(+), 262 deletions(-)


base-commit: 884fe9da1b7ccbea31b118f902fbc78f58366b4a
-- 
2.41.0.rc0.172.g3f132b7071-goog

