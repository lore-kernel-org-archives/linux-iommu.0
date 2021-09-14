Return-Path: <SRS0=mcPB=OE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86722C4332F
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 13:39:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FDD760FD7
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 13:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0FDD760FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB1F8402A2;
	Tue, 14 Sep 2021 13:39:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jrrBLA7R5XpH; Tue, 14 Sep 2021 13:39:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 997B94029D;
	Tue, 14 Sep 2021 13:39:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B780C0011;
	Tue, 14 Sep 2021 13:39:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E8CAC000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 13:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 02C0A607FF
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 13:39:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KjYIQyxZ_jTr for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 13:39:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C94C0607EB
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 13:39:23 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id h3so12754320pgb.7
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 06:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BHnwRGLPqH2A09ZXeDyMyxAcljYFX6n5VugCn85EoaM=;
 b=pjWLs+F/UNZaQ69Ds31Zi6HGFXPIFegbFqnIPgAg/e7eumR7muKpnjQsK4h4ATjgb2
 by7YiKtMcGNpi+ZXill2CZ9odlQEVqCHILMVlph6YQFKC8hHwp1QpE3r+RuSLxydvPYZ
 eGAqVhTH+xBk/V/LWNCB2iXK6oGjpeCm6U1nP3C+AFVZg+TFR+itqQRDs0wgk7bN3jJj
 IMVP9rnCIplN4weSfeBPFdD9eNEmq4L1JXa8SxhKOq/LaXmZsBWdbgaymudmjb7zfL2E
 DKrQ17H/rltwz4VcgDwdq+noncaSP4fVO9efd8m4H7efVZrJSaN580PDrm6EaBFxrg5t
 ohzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BHnwRGLPqH2A09ZXeDyMyxAcljYFX6n5VugCn85EoaM=;
 b=uTmDs/VDJrFWhuvbJYWLXD6ictqZue0V7NHUzXZwcTvvS41VH0Tkc/zh40LCbdkcR3
 fH2u/+6Qu2sBV2cQp2y2injgSkidP4ru65rUQlMLjBHNzyyYxjUECb2d8+vrv1gBPzLy
 Oor943Sq1sDGQObtTbhXgJrj16xp12e5wxDzBgJQWp5aAfHHIS0bJtLuBdgUc6XrIxdh
 JrHKNYz7raJOlJZ6shCmJbTIt3TXGp6GHT41yf/PYA/EYAuwtiMCQLthYOVHaoijcY82
 fdtwRQGVcKGvti6IUVLpFj6njkhF8Hgkf4BOqj1hCiqx/l75bkNMmY1F/SkTWr2nsyXo
 wKOQ==
X-Gm-Message-State: AOAM533OYgD5Itps05HAYCxVkdrTUUFZIcr7bLQHmJwtpJDgPPyf9p3q
 eWCoA/FfuUa/jxVK5jIqDh8=
X-Google-Smtp-Source: ABdhPJysSi/ePEIpmop1TOOZL/EDUeVswpP9kBW06aQK1cw/R5aOGjFREOrMllhH8ENnzQcpU6ys4A==
X-Received: by 2002:a63:3d4a:: with SMTP id k71mr15619461pga.276.1631626762730; 
 Tue, 14 Sep 2021 06:39:22 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:7:6ea2:a529:4af3:5057])
 by smtp.gmail.com with ESMTPSA id v13sm10461234pfm.16.2021.09.14.06.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Sep 2021 06:39:22 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com,
 sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, gregkh@linuxfoundation.org, arnd@arndb.de,
 hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
 brijesh.singh@amd.com, Tianyu.Lan@microsoft.com, thomas.lendacky@amd.com,
 pgonda@google.com, akpm@linux-foundation.org,
 kirill.shutemov@linux.intel.com, rppt@kernel.org, sfr@canb.auug.org.au,
 aneesh.kumar@linux.ibm.com, saravanand@fb.com, krish.sadhukhan@oracle.com,
 xen-devel@lists.xenproject.org, tj@kernel.org, rientjes@google.com,
 michael.h.kelley@microsoft.com
Subject: [PATCH V5 00/12] x86/Hyper-V: Add Hyper-V Isolation VM support
Date: Tue, 14 Sep 2021 09:39:01 -0400
Message-Id: <20210914133916.1440931-1-ltykernel@gmail.com>
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

This patchset is based on the 5.15-rc1.

Change since v4:
	- Hide hv_mark_gpa_visibility() and set memory visibility via
	  set_memory_encrypted/decrypted() 
	- Change gpadl handle in netvsc and uio driver from u32 to
	  struct vmbus_gpadl.
	- Change vmbus_establish_gpadl()'s gpadl_handle parameter
	  to vmbus_gpadl data structure.
	- Remove hv_get_simp(), hv_get_siefp()  hv_get_synint_*()
	  helper function. Move the logic into hv_get/set_register().
	- Use scsi_dma_map/unmap() instead of dma_map/unmap_sg() in storvsc driver.
	- Allocate rx/tx ring buffer via alloc_pages() in Isolation VM  

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

Tianyu Lan (12):
  x86/hyperv: Initialize GHCB page in Isolation VM
  x86/hyperv: Initialize shared memory boundary in the Isolation VM.
  x86/hyperv: Add new hvcall guest address host visibility  support
  Drivers: hv: vmbus: Mark vmbus ring buffer visible to host in
    Isolation VM
  x86/hyperv: Add Write/Read MSR registers via ghcb page
  x86/hyperv: Add ghcb hvcall support for SNP VM
  Drivers: hv: vmbus: Add SNP support for VMbus channel initiate 
    message
  Drivers: hv : vmbus: Initialize VMbus ring buffer for Isolation VM
  x86/Swiotlb: Add Swiotlb bounce buffer remap function for HV IVM
  hyperv/IOMMU: Enable swiotlb bounce buffer for Isolation VM
  scsi: storvsc: Add Isolation VM support for storvsc driver
  net: netvsc: Add Isolation VM support for netvsc driver

 arch/x86/hyperv/Makefile           |   2 +-
 arch/x86/hyperv/hv_init.c          |  78 ++++++--
 arch/x86/hyperv/ivm.c              | 282 ++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |  17 ++
 arch/x86/include/asm/mshyperv.h    |  62 ++++--
 arch/x86/include/asm/sev.h         |   6 +
 arch/x86/kernel/cpu/mshyperv.c     |   5 +
 arch/x86/kernel/sev-shared.c       |  63 +++---
 arch/x86/mm/mem_encrypt.c          |   3 +-
 arch/x86/mm/pat/set_memory.c       |  19 +-
 arch/x86/xen/pci-swiotlb-xen.c     |   3 +-
 drivers/hv/Kconfig                 |   1 +
 drivers/hv/channel.c               |  73 ++++---
 drivers/hv/connection.c            |  96 ++++++++-
 drivers/hv/hv.c                    |  85 ++++++--
 drivers/hv/hv_common.c             |  12 ++
 drivers/hv/hyperv_vmbus.h          |   2 +
 drivers/hv/ring_buffer.c           |  55 ++++--
 drivers/hv/vmbus_drv.c             |   4 +
 drivers/iommu/hyperv-iommu.c       |  60 ++++++
 drivers/net/hyperv/hyperv_net.h    |  12 +-
 drivers/net/hyperv/netvsc.c        | 304 +++++++++++++++++++++++++++--
 drivers/net/hyperv/netvsc_drv.c    |   1 +
 drivers/net/hyperv/rndis_filter.c  |   2 +
 drivers/scsi/storvsc_drv.c         |  24 ++-
 drivers/uio/uio_hv_generic.c       |  20 +-
 include/asm-generic/hyperv-tlfs.h  |   1 +
 include/asm-generic/mshyperv.h     |  17 +-
 include/linux/hyperv.h             |  19 +-
 include/linux/swiotlb.h            |   6 +
 kernel/dma/swiotlb.c               |  41 +++-
 31 files changed, 1204 insertions(+), 171 deletions(-)
 create mode 100644 arch/x86/hyperv/ivm.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
