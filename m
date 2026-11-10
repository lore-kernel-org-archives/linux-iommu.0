Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311521;
	b=R7Cv6R1f0VmVMjS4EFzMXLaNJAICXHSw/sJy89zeWu2fDrd8H9IGf+JBwzv42cRLBn1S
	 jtU5d8Z3JBOoJwWFaN4EFYBz4mmtloZH/cWV8OU8pWNVENK5qgzzLssigkmfEwQOb/L1d
	 ad3ZTbXAOYp7yLv269EcuVyZTYc447hjtBIGdqa2eu8eo5D7cGC12Xa1OUEbXj1glpF1V
	 EiB/4nD1gZnKd67x/nathl9kR+1ACyWVfq+/89veDU+qWlHsg0fW7yPEAuEjhrx6e23TL
	 aveo9X/frIk7pkAJ2ijZlg035GduMwZX/r3QEJ/jkFkOL65yj8yVTneZdjx24hUxGyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311521;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=4q4KITe/x0LR89wVeImCxXpGZNZhR+1TKC6XBD/Ac4g=;
	b=ONuNGKNOvIDssLo3anzyrJ/xNFxCJW+bd0CqgGoRPRESJc8aL/xIGEqp/7Uo8WJfjWp6
	 Mcyd+kobLgC09+ZjbQgwBodukEMqTFddVYrxKXQ25VpyDtsCMTtFk4m8fEc2VPlHh1Aiu
	 IUdE5F/QJ9Pu6CSPtaeFSceAaXkOl1ZEzRwdiW4RjKC0e0Zjjib/HVgpO6WgQBeg2VQ/9
	 +mi84w/GWdQvv134iY6Dy4DfG3+c4Lxk8D/k58zaRJFBxOI7HqSp2RQlC7ToGJe3IMPCy
	 3DRVYvXTM0dLUUmhSuV9mu/GFEq9KOAHMste9noQJp1fZfKhb8d6KA13McIXVBOjz9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212AA606A330
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 11:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 212AA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jP4kc0NQRz8XrrX;
	Tue, 10 Nov 2026 19:51:52 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl2.zte.com.cn with SMTP id 6AABpdZk005559;
	Tue, 10 Nov 2026 19:51:39 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Tue, 10 Nov 2026 19:51:42 +0800
X-Zmail-TransId: 3e816af3054502b-e4c51
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: tanchi25@mails.ucas.ac.cn
Cc: alex@ghiti.fr, andrew.jones@oss.qualcomm.com, anup@brainfault.org,
        aou@eecs.berkeley.edu, atish.patra@linux.dev,
        fangyu.yu@linux.alibaba.com, gong.shuai@sanechips.com.cn,
        gsh517025@gmail.com, iommu@lists.linux.dev, jgg@ziepe.ca,
        joro@8bytes.org, kevin.tian@intel.com, kvm-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        pbonzini@redhat.com, pjw@kernel.org, robin.murphy@arm.com,
        seanjc@google.com, tomasz.jeznach@linux.dev, will@kernel.org,
        wu.fei9@sanechips.com.cn, zhao.qingye@sanechips.com.cn
Subject: Re: [RFC PATCH v2 9/9] iommu/riscv: Add riscv_iommu_attach_dev_nested
Date: Tue, 10 Nov 2026 19:51:37 +0800
Message-ID: <20261110115137.184160-1-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105144944.10193-1-tanchi25@mails.ucas.ac.cn>
References: <20261105144944.10193-1-tanchi25@mails.ucas.ac.cn>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 6AABpdZk005559
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 19:51:52 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF30558.000/4jP4kc0NQRz8XrrX

Hi Tan Chi,

Thanks for your review and for pointing these out.

> Hi Shuai and Fei,
> 
> I noticed a potential issue with fixing the physical DC's PSCID to 0.
> 
> In QEMU, different VFIO devices can have separate stage-1 HWPTs while
> sharing the same vIOMMU and stage-2 parent. This means two devices may
> have different first-stage page table roots but the same host GSCID
> and PSCID=0.
> 
> According to the RISC-V IOMMU specification, DC.ta.PSCID identifies
> the first-stage address space when PDTV=0 and the first stage is not
> Bare. Could this cause the physical IOMMU to reuse cached translations
> across different stage-1 address spaces? Even broader invalidations
> would not prevent such cache aliasing.

You are right. We kept PSCID at zero as a simplification for the RFC,
but this was based on a misunderstanding of the PSCID semantics. When
PDTV=0 and stage 1 is not Bare, DC.ta.PSCID identifies the S1
address space. Sharing it across different page tables can cause cached
translations to alias.

> 
> There also seems to be a related issue in patch 6.
> riscv_viommu_cache_invalidate() unconditionally forces PSCV=1 and
> PSCID=0. However, an IOTINVAL.VMA with PSCV=0 also invalidates global
> mappings, while PSCV=1 excludes them. This appears to narrow the
> guest's requested invalidation scope and could leave stale global
> translations cached.

Agreed.

> 
> One possible approach might be to use the PSCID from the guest-provided
> DC.ta when allocating the nested domain, and preserve the guest's PSCID
> and PSCV settings during invalidation while substituting the host GSCID.
> I'm not sure whether additional considerations are needed for PSCID
> reuse or domain lifetime, though.

Thanks for the suggestion. While analyzing this issue, we found that
using the guest PSCID is the right direction, but preserving it alone
is not sufficient when multiple vIOMMUs share the same host GSCID.
Different vIOMMUs may have independent guest PSCID namespaces, so two
vIOMMUs sharing an S2 parent may use the same guest PSCID for different
S1 address spaces.

My understanding is that the ultimate goal is to ensure that the
(GSCID, PSCID) pair programmed into the physical DC uniquely identifies
the correct nested address space, and therefore the cached translations
belonging to it.

So far, we have identified three possible approaches:

  1. Share the S2 parent's GSCID and use the guest PSCID directly.

     This requires PSCID uniqueness across all vIOMMUs sharing that S2
     parent, so that different S1 address spaces cannot be assigned the
     same (GSCID, PSCID) pair. This uniqueness can be provided by the
     guest itself or through VMM/guest coordination.

     The current ARM mainline model similarly uses the guest ASID directly
     while inheriting the VMID from the S2 parent. For Linux guests, the
     SMMUv3 driver's global ASID allocator can provide ASID uniqueness
     across vSMMUs. The Linux RISC-V driver also uses a global PSCID
     allocator. The main question is whether we want to rely on this
     guest implementation property.

  2. Use the guest PSCID directly, but allocate a separate host GSCID for
     each vIOMMU.

     This allows independent vIOMMUs to reuse the same guest PSCID without
     aliasing, even when they share an S2 parent.

     The proposed ARM series follows this model by moving VMID allocation
     from the S2 domain to the vSMMU [1].

  3. Share the GSCID and maintain a per-vIOMMU mapping from each guest
     PSCID to a host-allocated PSCID.

     AMD mainline uses an analogous model for DomID. It maintains a
     per-vIOMMU gDomID-to-hDomID mapping and programs the mapped hDomID
     into the physical DTE.

Option 2 seems better because it gives each vIOMMU its own GSCID, which
isolates the PSCID namespace of each vIOMMU without requiring a mapping
table or relying on a guest implementation property such as a global
PSCID allocator. Its main costs are additional GSCID consumption and the
need to invalidate each vIOMMU's GSCID whenever the shared S2 parent
changes. I would appreciate your thoughts on which approach we should
take.

[1] https://lore.kernel.org/lkml/05dd00dcb2f0d077f59bcbccac1820534ad7b5cf.1773949042.git.nicolinc@nvidia.com/

Thanks,
Shuai

> 
> Thanks,
> Tan Chi
> 
