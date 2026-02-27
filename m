Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645871862
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 01:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154202; cv=none; b=n8R2LTy2HG/6Dci+0fUliW6PZsxvW4vTPgzbzbTattVxJ6GCQH07Y7WdeBIvrM3Euz6LHT/+J2Ku93vEOyAdM9uawfhUnELUCauIKEWNF5zkqdOfiG/tXML5ESGa6/QVH0OrOdZxISLxnIUS+O9neDU2z5TrzFYj+7SkCOVB1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154202; c=relaxed/simple;
	bh=4moxmzVHrdrAVQ3Wpcg0uPGs3o1ETCMNgVSry1NIHdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tta3L/FS1N9gSOkJOauIroye/Og+V08/xlyaCmcjG66ljQ3fgaTd2cqnuN7mSwdv7+vXhseATBdupBYyuVOtB+xaQ8aLB8BM6M1d81cbWyR0DYSEzZX6ghDDtUJSh9VP01WZaJ8kiwKIYawjbDAYakfVyycHJ/dIa148q2uVP+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bRFPXzSs; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bRFPXzSs"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-899c97c5addso16739426d6.3
        for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 17:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772154199; x=1772758999; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W8sfeIc4s5Af3K+2MPble1+p0RbLO1g1JdfLlBJahUc=;
        b=bRFPXzSsbkH6pGTs5mn2VelZuvI2ABHf4s/hV72r3kN3OKNIToahIE9VRyuLl0rzr2
         1pk+/+t+mFcAd/n9icyTMeac0IOWGSPOXi5U6Z3m1CMRT6exGkRX7H9tkF/nY/jb6+ro
         M21gfk6ftVNwdGoTQCYrNkBdIGg3YFxMpJ9HF4RfzvfSmL54dpHuU1tTHtwbwCWMRc23
         3sT4Khi6KKyleFFJi1YkBT+/Y7IdQIqelzy7O2ezMq1OLj8MfiW17vtKXMYiFKzUAC2U
         lxahLvuOQkQKbdeIep1QS2hNqTPWO8qtYKOZq/ZHA+bvEp1unldC/+RdWHVW244b3+0N
         LgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772154199; x=1772758999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8sfeIc4s5Af3K+2MPble1+p0RbLO1g1JdfLlBJahUc=;
        b=jvAgyil6cARz+/4IV8B4b4fMEkvaHB9anTvaEk4xpSIg58X0iluZh/ywvh7QrNzJ9c
         6GJggpQUqdKf8szfMmSG9/DKgoNsJNLIhSNupb+y/MBTYTzmO2MKk1z7DMullgJ3wyMr
         JJCKaL4xZvki8WCVRNp3rQP4t2aEOv5WJVTVt+/VHVvEdFMf3y0Lq8ZsRvzjbJ99Mb0F
         BmwzICbcOcYBC/cxkimyiRMK9fIvM1YXU2lmVsmg4jINwiMfGkRgptj8IhRHxd6rkF1R
         cMzPIO8oitr/gVKvYzHtSNuB77zM5FWj3Cw6NJuBrm/8qjc4XtXwQy3+2bf088xKW7FA
         6V3w==
X-Forwarded-Encrypted: i=1; AJvYcCW72OLieMBZBk2FP9nFqGNvrEsLDw8ex9SfUxE6niiyNvcHnycz6S/iUZxeGYip+c0J/xrltA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzl8Dj/a9jrUrIkHS1064oj5//BKunBGzXhdHLIMGSaFeXGxSi/
	V7Z2cIFBANN3mcNtVH/Y+1Rwc9G+rBWQfUMgrlTL4IZUF8FjxrJS1eZhW8v5+Osguc0=
X-Gm-Gg: ATEYQzzI1MAXnnrGOMzlgimtGFO4e7+WBxJkrFmz5Q4oMAiOITJeAUJ180BxDu9mJUV
	tN4+tk1GwPILoG7pKd5RjwZzCsbftKhSuZwrktY904COEYteLYe0Rl5KaXsODivo5Zm1rcQCdf8
	rDIrj3uLzLsBGztHW7qIZZQnOdzXeTepkwQNdteTOKKJPZfPrlvUK+wb950lKwUYIyidOQBXQPY
	NspsudvN42/G42l26AK4p7Nvqt8ZTB1+0Pdu+BSHyayaj9nJaOeYc4qwYHeYIPl6p+kUzkQSTU6
	CoSUYDjIa3+Z7Akx0hyseCtKc42b3kZw+Ul0Wb9cTBpttfXYKk9L5zq+HHoWoyQVFCc82dV2z2I
	pguI4mQzkKbguDJae1/4/gQxOC4YTaiJcpvAqslbNMbBKN8rHT3U946yaeTtlBhBDJCA63jjyAl
	j40xyyOeqsbzImw2e6LRD5cHMHMqQ22GVGevexn/3UkCZVzRlQg+5TguRyVR/MVr7UBc638z7jR
	TidFlV0
X-Received: by 2002:a05:6214:1c4a:b0:896:fea0:cd05 with SMTP id 6a1803df08f44-899d1dc4aafmr15567566d6.16.1772154199204;
        Thu, 26 Feb 2026 17:03:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507458f8b2asm40391191cf.4.2026.02.26.17.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 17:03:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vvmGD-00000000sD1-3Pf2;
	Thu, 26 Feb 2026 21:03:17 -0400
Date: Thu, 26 Feb 2026 21:03:17 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	dnaim@cachyos.org, Mario.Limonciello@amd.com
Subject: Re: [PATCH v1] iommu: Skip mapping at address 0x0 if it already
 exists
Message-ID: <20260227010317.GD44359@ziepe.ca>
References: <20260221235050.2558321-1-lkml@antheas.dev>
 <aZ36tRwNP8cRRX1l@ziepe.ca>
 <CAGwozwFPLLFfKP90fFrt-QC1rKPRCVo_iHuLm4roHX7erQ=Y5Q@mail.gmail.com>
 <aZ3/W8sw+gW5aTA5@ziepe.ca>
 <CAGwozwFKTeXW7_tPcUw8pYvNSoS9860mNJ=OUKCt2vEawYVOJA@mail.gmail.com>
 <6bac3817-9652-4146-ab44-2a9518c3b339@arm.com>
 <CAGwozwGXpVZ1ctUyZ79itwcX7RPjeLebFPWDVpNMq6-f_UtF3A@mail.gmail.com>
 <7e3a1d3c-64cb-43a8-bd2f-05b24a8d1611@arm.com>
 <CAGwozwGsh3_M+e35M2Ld7827W=w26-71xGXwgeEBu-ZcZGLACQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGwozwGsh3_M+e35M2Ld7827W=w26-71xGXwgeEBu-ZcZGLACQ@mail.gmail.com>

On Thu, Feb 26, 2026 at 09:40:10PM +0100, Antheas Kapenekakis wrote:
> I am still concerned about unaligned checks. It is a functional change
> that can cause regressions in all devices. The approach of this patch
> does not affect behavior in other devices. I would like for Jason to
> weigh in.

I think Robin's solution is very clever, but I share the concern
regarding what all the implementations do.

So, I fed this question to Claude. It did find two counter points (see
below for the whole report I had it generate):

     Implementations that lose the offset

     s390-iommu (drivers/iommu/s390-iommu.c:989): After the 3-level ZPCI walk,
     returns pte & ZPCI_PTE_ADDR_MASK with no sub-page offset added back.
     iova_to_phys(0) and iova_to_phys(1) return the same page-aligned PA.

     mtk_iommu_v1 (drivers/iommu/mtk_iommu_v1.c:396): Looks up the PTE by
     iova >> PAGE_SHIFT (discarding offset), then returns pte & ~(page_size-1). No
     step adds the sub-page offset back.

I checked myself and it seems correct. I didn't try to confirm that
the cases it says are OK are in fact OK, but it paints a convincing
picture.

I doubt S390 uses this function you are fixing, and I have no idea
about mtk. Below is also a diff how Claude thought to fix it, I didn't
try to check it.

So, I'd say if Robin is OK with these outliers then it a good and fine
approach.

Jason

iova_to_phys Implementation Survey

Entry point: iommu_iova_to_phys() in drivers/iommu/iommu.c:2502 calls
domain->ops->iova_to_phys(domain, iova) via iommu_domain_ops.

Category 1 — Delegates to io-pgtable

These drivers hold an io_pgtable_ops * and call ops->iova_to_phys(ops, iova).
The actual walk happens in one of the io-pgtable backends listed in Category
4.

  ----------------------------------------------------------------------------------------------------------
  Driver        Function (file:line)                               Ops assignment          Notes
  ------------- -------------------------------------------------- ----------------------- -----------------
  arm-smmu-v3   arm_smmu_iova_to_phys                              :3767                   Pure delegation
                drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3471                           

  arm-smmu      arm_smmu_iova_to_phys                              :1655                   S1 with
  v1/v2         drivers/iommu/arm/arm-smmu/arm-smmu.c:1387                                 FEAT_TRANS_OPS
                                                                                           uses hw ATS1PR
                                                                                           registers
                                                                                           (CB_PAR),
                                                                                           otherwise
                                                                                           io-pgtable

  apple-dart    apple_dart_iova_to_phys                            :1021                   Pure delegation →
                drivers/iommu/apple-dart.c:531                                             io-pgtable-dart

  qcom_iommu    qcom_iommu_iova_to_phys                            :605                    Delegation with
                drivers/iommu/arm/arm-smmu/qcom_iommu.c:492                                spinlock

  ipmmu-vmsa    ipmmu_iova_to_phys drivers/iommu/ipmmu-vmsa.c:702  :895                    Uses
                                                                                           ARM_32_LPAE_S1
                                                                                           format

  mtk_iommu     mtk_iommu_iova_to_phys                             :1073                   Delegation + 4GB
                drivers/iommu/mtk_iommu.c:861                                              mode PA remap
                                                                                           fixup
  ----------------------------------------------------------------------------------------------------------

Category 2 — Open-coded page table walk

These drivers implement their own page table traversal without io-pgtable.

  ---------------------------------------------------------------------------------------------------------
  Driver           Function (file:line)                 Ops assignment       Walk structure
  ---------------- ------------------------------------ -------------------- ------------------------------
  sun50i-iommu     sun50i_iommu_iova_to_phys            :860                 2-level (DTE → PTE)
                   drivers/iommu/sun50i-iommu.c:662                          

  exynos-iommu     exynos_iommu_iova_to_phys            :1487                2-level (section/large/small
                   drivers/iommu/exynos-iommu.c:1375                         page)

  riscv-iommu      riscv_iommu_iova_to_phys             :1355                Sv39/48/57 via
                   drivers/iommu/riscv/iommu.c:1280                          riscv_iommu_pte_fetch (:1166)

  omap-iommu       omap_iommu_iova_to_phys              :1727                iopgtable_lookup_entry helper
                   drivers/iommu/omap-iommu.c:1596                           (super
                                                                             section/section/large/small)

  rockchip-iommu   rk_iommu_iova_to_phys                :1190                2-level (DTE → PTE)
                   drivers/iommu/rockchip-iommu.c:651                        

  msm_iommu        msm_iommu_iova_to_phys               :709                 Hardware walk: writes VA to
                   drivers/iommu/msm_iommu.c:526                             V2PPR register, reads PA from
                                                                             PAR register

  s390-iommu       s390_iommu_iova_to_phys              :1186                3-level ZPCI (region → segment
                   drivers/iommu/s390-iommu.c:989                            → page)

  tegra-smmu       tegra_smmu_iova_to_phys              :1010                2-level via
                   drivers/iommu/tegra-smmu.c:806                            tegra_smmu_pte_lookup

  mtk_iommu_v1     mtk_iommu_v1_iova_to_phys            :593                 Flat single-level table
                   drivers/iommu/mtk_iommu_v1.c:396                          

  sprd-iommu       sprd_iommu_iova_to_phys              :423                 Flat single-level table
                   drivers/iommu/sprd-iommu.c:369                            
  ---------------------------------------------------------------------------------------------------------

Category 3 — Special / trivial

  -------------------------------------------------------------------------------------------
  Driver         Function (file:line)                  Ops assignment         Mechanism
  -------------- ------------------------------------- ---------------------- ---------------
  fsl_pamu       fsl_pamu_iova_to_phys                 :438                   Identity:
                 drivers/iommu/fsl_pamu_domain.c:172                          returns iova
                                                                              (after aperture
                                                                              bounds check)

  virtio-iommu   viommu_iova_to_phys                   :1105                  Interval tree
                 drivers/iommu/virtio-iommu.c:915                             reverse lookup
                                                                              (no page table)
  -------------------------------------------------------------------------------------------

Category 4 — io_pgtable_ops backends

These implement struct io_pgtable_ops.iova_to_phys and are the ultimate walk
functions called by Category 1 drivers.

  --------------------------------------------------------------------------------------------------
  Backend     Function (file:line)                     Ops assignment       Walk strategy
  ----------- ---------------------------------------- -------------------- ------------------------
  ARM LPAE    arm_lpae_iova_to_phys                    :950                 Visitor pattern via
  (64-bit)    drivers/iommu/io-pgtable-arm.c:734                            __arm_lpae_iopte_walk;
                                                                            covers ARM_64_LPAE_S1,
                                                                            S2, ARM_MALI_LPAE

  ARM v7s     arm_v7s_iova_to_phys                     :716                 Iterative do-while
  (32-bit)    drivers/iommu/io-pgtable-arm-v7s.c:644                        2-level; handles
                                                                            contiguous entries

  Apple DART  dart_iova_to_phys                        :402                 dart_get_last pre-walks
              drivers/iommu/io-pgtable-dart.c:336                           to leaf table, then
                                                                            single lookup
  --------------------------------------------------------------------------------------------------

Category 5 — generic_pt framework

All these drivers use IOMMU_PT_DOMAIN_OPS(fmt) which routes iova_to_phys into
the template function pt_iommu_<fmt>_iova_to_phys at
drivers/iommu/generic_pt/iommu_pt.h:170. The walk uses pt_walk_range +
PT_MAKE_LEVELS to generate a fully-inlined unrolled per-level walk; OA
extracted via pt_entry_oa_exact.

  ---------------------------------------------------------------------------------
  Driver           Ops struct (file:line)                          Format
  ---------------- ----------------------------------------------- ----------------
  AMD IOMMU v1     amdv1_ops drivers/iommu/amd/iommu.c:2662        amdv1

  AMD IOMMU v2     amdv2_ops drivers/iommu/amd/iommu.c:2740        x86_64

  Intel VT-d       intel_fs_paging_domain_ops                      x86_64
  first-stage      drivers/iommu/intel/iommu.c:3886                

  Intel VT-d       intel_ss_paging_domain_ops                      vtdss
  second-stage     drivers/iommu/intel/iommu.c:3897                

  iommufd selftest mock_domain_ops etc                             amdv1_mock /
                   drivers/iommu/iommufd/selftest.c:403,411,425    amdv1

  KUnit wrapper    pgtbl_ops                                       Delegates to
                   drivers/iommu/generic_pt/kunit_iommu_cmp.h:86   io_pgtable_ops
                                                                   for comparison
                                                                   testing
  ---------------------------------------------------------------------------------

Sub-page offset handling

When iova_to_phys(iova) is called with an IOVA that is not aligned to the
start of the mapped page/block (e.g. iova_to_phys(1) when a 4KB page is mapped
at IOVA 0), most implementations return the exact physical address including
the sub-page offset (phys_base + offset). Two do not.

Summary

  ------------------------------------------------------------------------------------------------------
  Implementation            Offset preserved?         Mechanism
  ------------------------- ------------------------- --------------------------------------------------
  arm_lpae (io-pgtable)     YES                       iopte_to_paddr(pte) | (iova & (block_size-1))

  arm_v7s (io-pgtable)      YES                       iopte_to_paddr(pte) | (iova & ~LVL_MASK)

  dart (io-pgtable)         YES                       iopte_to_paddr(pte) | (iova & (pgsize-1))

  sun50i-iommu              YES                       page_addr + FIELD_GET(GENMASK(11,0), iova)

  exynos-iommu              YES                       *_phys(entry) + *_offs(iova) per granularity

  riscv-iommu               YES                       pfn_to_phys(pfn) | (iova & (pte_size-1))

  omap-iommu                YES                       (descriptor & mask) | (va & ~mask)

  rockchip-iommu            YES                       pt_address(pte) + rk_iova_page_offset(iova)

  msm_iommu                 YES                       HW PAR register + VA low bits spliced back in

  s390-iommu                NO                        pte & ZPCI_PTE_ADDR_MASK — offset discarded

  tegra-smmu                YES                       SMMU_PFN_PHYS(pfn) + SMMU_OFFSET_IN_PAGE(iova)

  mtk_iommu_v1              NO                        pte & ~(page_size-1) — offset discarded

  sprd-iommu                YES                       (pte << PAGE_SHIFT) + (iova & (page_size-1))

  fsl_pamu                  YES (trivial)             return iova — identity mapping

  virtio-iommu              YES                       paddr + (iova - mapping->iova.start)

  generic_pt                YES                       _pt_entry_oa_fast() | log2_mod(va, entry_lg2sz)
  ------------------------------------------------------------------------------------------------------

Category 1 drivers (arm-smmu-v3, arm-smmu, apple-dart, qcom_iommu, ipmmu-vmsa,
mtk_iommu) inherit the behavior of their io-pgtable backend — all preserve
offset.

Implementations that lose the offset

s390-iommu (drivers/iommu/s390-iommu.c:989): After the 3-level ZPCI walk,
returns pte & ZPCI_PTE_ADDR_MASK with no sub-page offset added back.
iova_to_phys(0) and iova_to_phys(1) return the same page-aligned PA.

mtk_iommu_v1 (drivers/iommu/mtk_iommu_v1.c:396): Looks up the PTE by
iova >> PAGE_SHIFT (discarding offset), then returns pte & ~(page_size-1). No
step adds the sub-page offset back.


diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index c8d8eff5373d30..8db16989270cd8 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -401,7 +401,8 @@ static phys_addr_t mtk_iommu_v1_iova_to_phys(struct iommu_domain *domain, dma_ad
 
 	spin_lock_irqsave(&dom->pgtlock, flags);
 	pa = *(dom->pgt_va + (iova >> MT2701_IOMMU_PAGE_SHIFT));
-	pa = pa & (~(MT2701_IOMMU_PAGE_SIZE - 1));
+	pa = (pa & (~(MT2701_IOMMU_PAGE_SIZE - 1))) |
+	     (iova & (MT2701_IOMMU_PAGE_SIZE - 1));
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
 	return pa;
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index fe679850af2861..57d27f3a984ed6 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -1015,7 +1015,8 @@ static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
 			pto = get_st_pto(ste);
 			pte = READ_ONCE(pto[px]);
 			if (pt_entry_isvalid(pte))
-				phys = pte & ZPCI_PTE_ADDR_MASK;
+				phys = (pte & ZPCI_PTE_ADDR_MASK) |
+				       (iova & ~ZPCI_PTE_ADDR_MASK);
 		}
 	}
