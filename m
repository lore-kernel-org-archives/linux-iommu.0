Return-Path: <SRS0=n6uX=NS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E29C4320A
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 17:21:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB88F60F6C
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 17:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB88F60F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 97BBD407E2;
	Fri, 27 Aug 2021 17:21:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lugDT0lUprh4; Fri, 27 Aug 2021 17:21:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 40BB440813;
	Fri, 27 Aug 2021 17:21:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0F96C001A;
	Fri, 27 Aug 2021 17:21:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15448C000E
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 03A556157E
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:21:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YlQxOhU2wf-T for <iommu@lists.linux-foundation.org>;
 Fri, 27 Aug 2021 17:21:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 399EB61567
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:21:21 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id v123so6216371pfb.11
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 10:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JYTZo1EPFzxHx7wJIoJCzUP9GEH1Yym5lq7cwfCdAwc=;
 b=sOsMz6fnS+QgIpFYVjcXYRvxDOeMD9h2bMw2GBTmeCUkkk23vrYd780herBfwXgbvA
 hGA78c9LQ5mFrIxGoV5bh92RPIkBNV3zC7aQWqPvZwzqR7eUipC3F6tCE1lS99UNu4qv
 /jGXM6dXDIj5E3xUFJJk/TohEampnyBbRIYD1hLJy5pBxUTK37a84VmpHtj16lZu5LT0
 G4r2Bzmm/nfXZDV23kipSRDeoxZKgWHSNBDvgeDYycwMlF9Ol+JBrPSsMJATGXvDUGHL
 2knvJbm+YsN9tX0nrsuUr2ArVRQaH8IUpNj0nizy6pNhKxUJ87d02iccTWQAYTy6Q9Rt
 HxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JYTZo1EPFzxHx7wJIoJCzUP9GEH1Yym5lq7cwfCdAwc=;
 b=Sdkpnn7L0YAOAk/Uz0R72CkBAas3VEsS8Lb0SOZIs2zXxJtSbK1DNN9YTnWbeZmo5h
 4aKhg9ja19qJMUxbeuenrYKKTCCkbnEVfOxIm3AinPXkFcEa/7pu2+65kKIxXkdg8vbx
 t6sa8/2BMC4gR3UvrgQsBGXC3SdWBlD5xFTBrc6AxWefUldmDjrw75EdA5Tce5ux877e
 db3hAxNXoNISC1/eSPSGT/FKptCSD8azkHSD1MAfZLwECSQfWjMoSx3YTTovm7RLUABH
 q4BaTfyDd1nWwEJ9O4hqQIIOaB4a1soR6RYfr4DBJ0uN20h1SwozHDKt7CF3jkWDY+S3
 q7tw==
X-Gm-Message-State: AOAM532ZmK1ulOl87fy3RZCWh7VS1/CIxs4demJ3OTxbdnIYQrUogqe0
 hd/Z76ficC4UolssNwJV2bc=
X-Google-Smtp-Source: ABdhPJy8nJHUvt2VMPE+PZOZMLCaAJdSlRB5iqGhbKn5tvohwh3WTNMW4inTU/nRNNiQJDSPg3loUQ==
X-Received: by 2002:a63:5a64:: with SMTP id k36mr8614505pgm.378.1630084880519; 
 Fri, 27 Aug 2021 10:21:20 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:36:ef50:8fcd:44d1:eb17])
 by smtp.gmail.com with ESMTPSA id f5sm7155015pjo.23.2021.08.27.10.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Aug 2021 10:21:19 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org,
 joro@8bytes.org, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, gregkh@linuxfoundation.org, arnd@arndb.de,
 hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
 brijesh.singh@amd.com, thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 pgonda@google.com, martin.b.radev@gmail.com, akpm@linux-foundation.org,
 kirill.shutemov@linux.intel.com, rppt@kernel.org, hannes@cmpxchg.org,
 aneesh.kumar@linux.ibm.com, krish.sadhukhan@oracle.com, saravanand@fb.com,
 linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org,
 rientjes@google.com, ardb@kernel.org, michael.h.kelley@microsoft.com
Subject: [PATCH V4 00/13] x86/Hyper-V: Add Hyper-V Isolation VM support
Date: Fri, 27 Aug 2021 13:20:58 -0400
Message-Id: <20210827172114.414281-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V provides two kinds of Isolation VMs. VBS(Virtualization-based
security) and AMD SEV-SNP unenlightened Isolation VMs. This patchset
is to add support for these Isolation VM support in Linux.

The memory of these vms are encrypted and host can't access guest
memory directly. Hyper-V provides new host visibility hvcall and
the guest needs to call new hvcall to mark memory visible to host
before sharing memory with host. For security, all network/storage
stack memory should not be shared with host and so there is bounce
buffer requests.

Vmbus channel ring buffer already plays bounce buffer role because
all data from/to host needs to copy from/to between the ring buffer
and IO stack memory. So mark vmbus channel ring buffer visible.

There are two exceptions - packets sent by vmbus_sendpacket_
pagebuffer() and vmbus_sendpacket_mpb_desc(). These packets
contains IO stack memory address and host will access these memory.
So add allocation bounce buffer support in vmbus for these packets.

For SNP isolation VM, guest needs to access the shared memory via
extra address space which is specified by Hyper-V CPUID HYPERV_CPUID_
ISOLATION_CONFIG. The access physical address of the shared memory
should be bounce buffer memory GPA plus with shared_gpa_boundary
reported by CPUID.

This patchset is based on the Hyper-V next branch.

Change since V3:
	- Initalize GHCB page in the cpu init callbac.
	- Change vmbus_teardown_gpadl() parameter in order to
	  mask the memory back to non-visible to host.
	- Merge hv_ringbuffer_post_init() into hv_ringbuffer_init().
	- Keep Hyper-V bounce buffer size as same as AMD SEV VM
	- Use dma_map_sg() instead of dm_map_page() in the storvsc driver.

Change since V2:
       - Drop x86_set_memory_enc static call and use platform check
         in the __set_memory_enc_dec() to run platform callback of
	 set memory encrypted or decrypted.

Change since V1:
       - Introduce x86_set_memory_enc static call and so platforms can
         override __set_memory_enc_dec() with their implementation
       - Introduce sev_es_ghcb_hv_call_simple() and share code
         between SEV and Hyper-V code.
       - Not remap monitor pages in the non-SNP isolation VM
       - Make swiotlb_init_io_tlb_mem() return error code and return
         error when dma_map_decrypted() fails.

Change since RFC V4:
       - Introduce dma map decrypted function to remap bounce buffer
          and provide dma map decrypted ops for platform to hook callback.        
       - Split swiotlb and dma map decrypted change into two patches
       - Replace vstart with vaddr in swiotlb changes.

Change since RFC v3:
       - Add interface set_memory_decrypted_map() to decrypt memory and
         map bounce buffer in extra address space
       - Remove swiotlb remap function and store the remap address
         returned by set_memory_decrypted_map() in swiotlb mem data structure.
       - Introduce hv_set_mem_enc() to make code more readable in the __set_memory_enc_dec().

Change since RFC v2:
       - Remove not UIO driver in Isolation VM patch
       - Use vmap_pfn() to replace ioremap_page_range function in
       order to avoid exposing symbol ioremap_page_range() and
       ioremap_page_range()
       - Call hv set mem host visibility hvcall in set_memory_encrypted/decrypted()
       - Enable swiotlb force mode instead of adding Hyper-V dma map/unmap hook
       - Fix code style


Tianyu Lan (13):
  x86/hyperv: Initialize GHCB page in Isolation VM
  x86/hyperv: Initialize shared memory boundary in the Isolation VM.
  x86/hyperv: Add new hvcall guest address host visibility support
  hyperv: Mark vmbus ring buffer visible to host in Isolation VM
  hyperv: Add Write/Read MSR registers via ghcb page
  hyperv: Add ghcb hvcall support for SNP VM
  hyperv/Vmbus: Add SNP support for VMbus channel initiate  message
  hyperv/vmbus: Initialize VMbus ring buffer for Isolation VM
  DMA: Add dma_map_decrypted/dma_unmap_encrypted() function
  x86/Swiotlb: Add Swiotlb bounce buffer remap function for HV IVM
  hyperv/IOMMU: Enable swiotlb bounce buffer for Isolation VM
  hv_netvsc: Add Isolation VM support for netvsc driver
  hv_storvsc: Add Isolation VM support for storvsc driver

 arch/arm64/include/asm/mshyperv.h  |  23 ++
 arch/x86/hyperv/Makefile           |   2 +-
 arch/x86/hyperv/hv_init.c          |  78 +++++--
 arch/x86/hyperv/ivm.c              | 325 +++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |  17 ++
 arch/x86/include/asm/mshyperv.h    |  88 +++++++-
 arch/x86/include/asm/sev.h         |   3 +
 arch/x86/kernel/cpu/mshyperv.c     |   5 +
 arch/x86/kernel/sev-shared.c       |  63 +++---
 arch/x86/mm/mem_encrypt.c          |   3 +-
 arch/x86/mm/pat/set_memory.c       |  19 +-
 arch/x86/xen/pci-swiotlb-xen.c     |   3 +-
 drivers/hv/Kconfig                 |   1 +
 drivers/hv/channel.c               |  55 +++--
 drivers/hv/connection.c            |  81 ++++++-
 drivers/hv/hv.c                    | 120 +++++++----
 drivers/hv/hv_common.c             |  12 ++
 drivers/hv/hyperv_vmbus.h          |   1 +
 drivers/hv/ring_buffer.c           |  56 +++--
 drivers/hv/vmbus_drv.c             |   4 +
 drivers/iommu/hyperv-iommu.c       |  61 ++++++
 drivers/net/hyperv/hyperv_net.h    |   6 +
 drivers/net/hyperv/netvsc.c        | 151 +++++++++++++-
 drivers/net/hyperv/rndis_filter.c  |   2 +
 drivers/scsi/storvsc_drv.c         |  41 ++--
 drivers/uio/uio_hv_generic.c       |  14 +-
 include/asm-generic/hyperv-tlfs.h  |   1 +
 include/asm-generic/mshyperv.h     |  19 +-
 include/linux/dma-map-ops.h        |   9 +
 include/linux/hyperv.h             |  15 +-
 include/linux/swiotlb.h            |   4 +
 kernel/dma/mapping.c               |  22 ++
 kernel/dma/swiotlb.c               |  32 ++-
 33 files changed, 1166 insertions(+), 170 deletions(-)
 create mode 100644 arch/x86/hyperv/ivm.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
