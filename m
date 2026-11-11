Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794375422;
	b=2ksNtKBQKjdgAOX5+kI6nVV5PSqKuYWKsSGcf2bIIbOuEVYPp87rASmpSfdehERS9Iee
	 9xUi7GwtNB/DSX1S5a7f/IB+vtJcIFd4/Zp29OArk+R+uAVnBEp8hPRvXyDjQUOT7K2QG
	 N9KLSroqR+KEAjmYp33X7CPGjssdhTqcwwtS0s3gXhXzmLKppgDeYM6RbHDeplnM/vi4R
	 t3OwNcoN3+u29qYkUoR6VPVgInsy8w7vOjbDkDuGDtoZzImGLUbs6n1mzx1g9e4bPHGch
	 KB/MbBJsu1zyy+juRZaZMlWpawZZLIh344uWdhs3NKjNNTq03lJcAX1tqwPtK+oY6AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794375422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=eLmVTYOfswJ+cGfMoCZUFy1VK5TCu4veYLS+0REM4CM=;
	b=3gNquYQA94CRycLbLUTqpOq1j4/6eD+YRmzTElJfOoft+Tpfla0PDNxW61vyFnJF90nS
	 Mf/kbTU/w2aqgwrNWlKc/Hu5vLhfll0L/BvFHlcCbEoPwXGFcvadaK0EztrQu7RDe8+Tm
	 9DpY8hM9u/KCdCeynVMUhKNUOy9VXkPe3wAY2dDv68NLEgpt4DdDAlknt1qV1k0ytS+N8
	 k34qCswXpPU8Dy9Gk4tmwWQg77ZjQfiQfq/SxNeLK+iDgPNSKu361zhctKBlIC5lDzkb4
	 p3GQ3DGQaqAhGOtFp+ThoMiisvNvyV4xtfBol2LVsuZ1XAqOVDN8RO6sYxZiZOgffpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="aJwd/VBZ";
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D5F606A31C
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 05:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92D5F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aJwd/VBZ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a17741243eso16831775e9.0
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 21:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794375420; x=1794980220; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eLmVTYOfswJ+cGfMoCZUFy1VK5TCu4veYLS+0REM4CM=;
        b=aJwd/VBZ5H3S76TkGYnhLvdmlgi0PesjJEPw50oKLOIcWvZ3FUK0AbbMwCBc2680oZ
         COKUpz/2VnoBEWcCPx0SoVRqzrnB47CrSiupVETbebXxjJzVBprCvktuPcpt7HBnpG0D
         QXkyJLUCVo2QXcqyBwpUnPlWOU3JCiHh78+OfxoMRoVNpBpzxLyMyLY+nNOUYMc4tHWV
         wsP+4Rr0v3L6CmM9Y93iukiAL9gmozeNkAMgqtdm+VWJuJne0zTR0Ew3R38DXXx5uR4C
         sE/epKomqaeW6b/58GQbgdIonY6huio9cn+e+MCKGyIdKBiGbQVaqykP0+Um9OpKjY74
         RG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794375420; x=1794980220;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eLmVTYOfswJ+cGfMoCZUFy1VK5TCu4veYLS+0REM4CM=;
        b=TKQHApnu7O+tj3LL2FStYBDTVXWrnRY6055aibTMbtPDBT3YhIGhzfUAxKS+v7lp6V
         bH530QOgQlMTrjJxP/ZODCVHHM1W+yubcZt6g657FYHlG7Cvav0I0RkruJ6abjG49nI5
         JHADNFS3W23OJDiXpb9nJrZ78+OPviaL4FomF1wZgLURgpElwsuIbrzqjdPRB/2JXMFG
         VmqAyOJzDpep14qsVbD8Ojzf8CNdrJNzsE1IlFmIf83XrHj9qYl9YH+hQy1YgsaR52Rm
         tAGP2uTYVS1FDQdNpehoYANOCTAtROrn0ITK25hFsZ5uCCAWRVqkW+7ZneLsFvVuj8+p
         bbsQ==
X-Forwarded-Encrypted: i=1; AL+hErHF8ZZ075WWR2NmNbmh5TzpxBghZ4Lrih0CH/JgVDK/TZTdgISPGN3BrynpV+8pyyrRpelV/Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z9UuttQyEkw4wypDxm2sA19Iaqn4nkw6lgqKpYs7dxvPqUtpprK
	YaEoz/IgEsXr8FD8J+9hhHT/sU5GhM9udvmFIt1l+4IFlvHXhxpHoiRxAGdfbcPGTYmY0pYCGEm
	bf1+B25S8tBz59j2n/Q==
X-Received: from wmsl10.prod.google.com ([2002:a05:600c:1d0a:b0:4a3:5d5b:9ad9])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:810c:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4ba09379cc1mr15865455e9.7.1794375419814;
 Tue, 10 Nov 2026 21:36:59 -0800 (PST)
Date: Wed, 11 Nov 2026 05:36:58 +0000
In-Reply-To: <DMRJJX2ZSYQT.2U1TTBGE7R4RA@soleen.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <DMRJJX2ZSYQT.2U1TTBGE7R4RA@soleen.com>
Message-ID: <9huz5wy4q685.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 00/19] kho, liveupdate: Add feature header for
 fine-grained ABI compatibility
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"Pasha Tatashin" <pasha.tatashin@soleen.com> writes:

> On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:
>> This v4 of feature flags support for LUO and KHO is no longer an RFC.
...skip
>>
>> Each serialized structure is preceded in memory by struct kho_ser_hdr
>> and registered via DECLARE_KHO_SER(name, payload_size, nr_required,
>> nr_optional). Both struct kho_kexec_metadata and struct pci_dev_ser are
>> explicitly marked with __aligned(8) because their largest member is a
>> 32-bit integer, and 8-byte alignment is required by DECLARE_KHO_SER() so
>
> I do not believe we need __aligned(8), because the struct immediately 
> follows the newly introduced kho_ser_hdr, which is 8-byte aligned. 
> However, we should verify that the combined size (header + payload) 
> is 8-byte aligned.

Yes, we can check total size alignment and remove the __aligned(8). I
will update it.

~Tarun

>
>> trailing feature payloads remain 8-byte aligned across 32-bit and 64-bit
>> kernels.
>>
>> Also, Introduce DECLARE_KHO_SER_HDR(ser_name, fhdr) which is just the
>> wrapper for struct kho_ser_hdr fhdr, This makes it clear
>> To which ser_name, this fhdr belongs to.
>>
>>
>> Series structure:
>>   - Patch 1 removes __packed from KHO, LUO, and memfd ABI structures and
>>     asserts their natural size and 8-byte alignment under CONFIG_64BIT.
>>   - Patch 2 records entry_size in struct kho_block_header_ser so the
>>     incoming kernel derives the entry stride from the block header.
>>   - Patch 3 converts callers that embedded struct kho_vmalloc by value
>>     (memfd_luo and test_kho) to reference it via DECLARE_KHOSER_PTR so
>>     struct kho_vmalloc can grow independently.
>>   - Patch 4 converts struct luo_session_ser to reference
>>     struct luo_file_set_ser via DECLARE_KHOSER_PTR instead of embedding
>>     it by value so both structures can grow independently.
>>   - Patch 5 introduces struct kho_ser_hdr, DECLARE_KHO_SER(),
>>     DECLARE_KHO_SER_HDR(), and the serialization/validation helpers in
>>     include/linux/kho/abi/feature.h.
>>   - Patches 6-18 add the feature header to each of the 13 KHO, LUO, PCI,
>>     and memfd serialized structures in independent patches.
>>   - Patch 19 adds a KUnit test suite (kho_feature) covering the feature
>>     header helpers.
>>
>> [1] https://lore.kernel.org/all/20260903023452.721732-1-loganodell@google.com/
>> [2] https://lore.kernel.org/all/20261021152527.375070-1-tarunsahu@google.com/
>> [3] https://lore.kernel.org/all/20261026174217.603114-1-tarunsahu@google.com/
>>
>> Tarun Sahu (19):
>>   liveupdate, kho: Remove __packed from KHO, LUO and memfd ABI
>>     structures
>>   kho: block: Record the entry size in the block header
>>   kho, memfd_luo: Reference struct kho_vmalloc via serialized pointer
>>   liveupdate: Reference struct luo_file_set_ser via serialized pointer
>>   kho: Add feature header for fine-grained ABI compatibility
>>   kho: kexec_metadata: Add the feature header
>>   kho: vmalloc: Add the feature header
>>   kho: block: Add the feature header to blocks
>>   liveupdate: Add feature header to struct luo_ser
>>   liveupdate: Add feature header to struct luo_session_ser
>>   liveupdate: Add feature header to struct luo_file_set_ser
>>   liveupdate: Add feature header to struct luo_file_ser
>>   liveupdate: Add feature header to struct luo_flb_header_ser
>>   liveupdate: Add feature header to struct luo_flb_ser
>>   PCI: liveupdate: Add feature header to struct pci_ser
>>   PCI: liveupdate: Add feature header to struct pci_dev_ser
>>   mm: memfd_luo: Add feature header to struct memfd_luo_ser
>>   mm: memfd_luo: Add feature header to struct memfd_luo_folio_ser
>>   kho: Add KUnit test for the feature header helpers
>>
>>  MAINTAINERS                            |   1 +
>>  drivers/pci/liveupdate.c               |  99 +++----
>>  include/linux/kexec_handover.h         |  15 +-
>>  include/linux/kho/abi/block.h          |  21 +-
>>  include/linux/kho/abi/feature.h        | 372 +++++++++++++++++++++++++
>>  include/linux/kho/abi/kexec_handover.h |  11 +-
>>  include/linux/kho/abi/kexec_metadata.h |  17 +-
>>  include/linux/kho/abi/luo.h            | 102 ++++---
>>  include/linux/kho/abi/memfd.h          |  27 +-
>>  include/linux/kho/abi/pci.h            |  66 ++---
>>  include/linux/kho_block.h              |   8 +-
>>  kernel/liveupdate/kexec_handover.c     |  98 ++++---
>>  kernel/liveupdate/kho_block.c          | 172 +++++++++---
>>  kernel/liveupdate/luo_core.c           |  43 +--
>>  kernel/liveupdate/luo_file.c           |  58 ++--
>>  kernel/liveupdate/luo_flb.c            |  69 +++--
>>  kernel/liveupdate/luo_internal.h       |   9 +-
>>  kernel/liveupdate/luo_session.c        |  55 +++-
>>  lib/Kconfig.debug                      |  13 +
>>  lib/test_kho.c                         |  38 ++-
>>  lib/tests/Makefile                     |   1 +
>>  lib/tests/kho_feature_kunit.c          | 184 ++++++++++++
>>  mm/memfd_luo.c                         | 183 ++++++++----
>>  23 files changed, 1271 insertions(+), 391 deletions(-)
>>  create mode 100644 include/linux/kho/abi/feature.h
>>  create mode 100644 lib/tests/kho_feature_kunit.c
>
> -- 
> Pasha
