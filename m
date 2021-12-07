Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4DBC433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 07:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 706C58302F;
	Tue,  7 Dec 2021 07:56:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZLSY4MizSTQ9; Tue,  7 Dec 2021 07:56:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4F96A829DB;
	Tue,  7 Dec 2021 07:56:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A02AC001E;
	Tue,  7 Dec 2021 07:56:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8AF4C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 07:56:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D03DA4039C
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 07:56:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q2oilZcSePOc for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 07:56:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B006440284
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 07:56:05 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 gx15-20020a17090b124f00b001a695f3734aso1997275pjb.0
 for <iommu@lists.linux-foundation.org>; Mon, 06 Dec 2021 23:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KmCJousBiElqFxBD882RvdjUoER5eWaaA/AcR3+2s20=;
 b=Oo/euXON2UWgaLcGXKh/Dc34H8OjYvdS6Sg/Adiq6bSc7B4GBpMZ0KjBZBqnqzDa76
 tIf6SUphYqejTVrqOaln3BM6zGXisKufxqjqcyp9W82Bd2QLn1KZfjVofq9w7F6axoZ+
 cmq5lDx+7O2BPY9TZjJ/WgBNHlbFyyBmBa0eZE+h27XDUxxorXncYfVr7WpQnGCwY26/
 95Mr2CS2CDXWQMmGMdB3ORwTwN/5ORySJeSvTfTJeyx8/ao8BEXAgx0Ysgqrys5K9FNi
 oC+aWu8BUEd3WG+tFEDO2nDCN/BxDoK/r88am0Yk+h8Fna2uexZR/qu8CObNTIML2pxP
 7XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KmCJousBiElqFxBD882RvdjUoER5eWaaA/AcR3+2s20=;
 b=cuvDUld/mULHiP9GClV1rc96uJx2B5wriEtVeF7r9g0ygfflf7ahoAP6r3sUda6LMo
 /DkQy6v/1Nnp7cj0/x4RZvAVSCoOlsR29RyMX5aiBBZiNNv5IixV4M3B8BRSrJCNkzxI
 d8Ne6cF0TfwIOVrsPr6xTSyP/CERodWayD4U4W7A1bsCvPA7CvSsesUghwFz0W7CP7Bd
 nZkaTicvpZxMb9FpsRO4A3FC5eow5/OPJkVMi8VhCZ2iUrVVrp0yPFvzfSSueINPdYmi
 aVY9I39VS93C45iJtMEO6Zotup2bVPadkP12cglzPRpg2UuQi4EaTDxOVmnkrCMzy5dK
 KgYg==
X-Gm-Message-State: AOAM532rneI1rrXjZAhbp9IvdQgaaWOsJzDYmyyaYWVWEIn3mC6/YEr2
 zRjuYyAUHgimuvSznmaj2QM=
X-Google-Smtp-Source: ABdhPJzqgK74sj3n0s3QeazKBnvtozL+ghOHbSHk4SLEk7d0juOTTyMqAFeBgfH+LR5MfMv1CI3mmw==
X-Received: by 2002:a17:90b:4c85:: with SMTP id
 my5mr4669482pjb.26.1638863765142; 
 Mon, 06 Dec 2021 23:56:05 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:0:a463:d753:723:c3a9])
 by smtp.gmail.com with ESMTPSA id n15sm1794353pgs.59.2021.12.06.23.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Dec 2021 23:56:04 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, davem@davemloft.net, kuba@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, arnd@arndb.de,
 hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
 Tianyu.Lan@microsoft.com, thomas.lendacky@amd.com,
 michael.h.kelley@microsoft.com
Subject: [PATCH V6 0/5] x86/Hyper-V: Add Hyper-V Isolation VM support(Second
 part)
Date: Tue,  7 Dec 2021 02:55:56 -0500
Message-Id: <20211207075602.2452-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com, hch@lst.de
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

For SNP isolation VM, guest needs to access the shared memory via
extra address space which is specified by Hyper-V CPUID HYPERV_CPUID_
ISOLATION_CONFIG. The access physical address of the shared memory
should be bounce buffer memory GPA plus with shared_gpa_boundary
reported by CPUID.

This patchset is to enable swiotlb bounce buffer for netvsc/storvsc
in Isolation VM.

This version follows Michael Kelley suggestion in the following link.
https://lkml.org/lkml/2021/11/24/2044

Change sicne v5:
        * Modify "Swiotlb" to "swiotlb" in commit log.
	* Remove CONFIG_HYPERV check in the hyperv_cc_platform_has()

Change since v4:
	* Remove Hyper-V IOMMU IOMMU_INIT_FINISH related functions
	  and set SWIOTLB_FORCE and swiotlb_unencrypted_base in the
	  ms_hyperv_init_platform(). Call swiotlb_update_mem_attributes()
	  in the hyperv_init().

Change since v3:
	* Fix boot up failure on the host with mem_encrypt=on.
	  Move calloing of set_memory_decrypted() back from
	  swiotlb_init_io_tlb_mem to swiotlb_late_init_with_tbl()
	  and rmem_swiotlb_device_init().
	* Change code style of checking GUEST_MEM attribute in the
	  hyperv_cc_platform_has().
	* Add comment in pci-swiotlb-xen.c to explain why add
	  dependency between hyperv_swiotlb_detect() and pci_
	  xen_swiotlb_detect().
	* Return directly when fails to allocate Hyper-V swiotlb
	  buffer in the hyperv_iommu_swiotlb_init().

Change since v2:
	* Remove Hyper-V dma ops and dma_alloc/free_noncontiguous. Add
	  hv_map/unmap_memory() to map/umap netvsc rx/tx ring into extra
	  address space.
	* Leave mem->vaddr in swiotlb code with phys_to_virt(mem->start)
	  when fail to remap swiotlb memory.

Change since v1:
	* Add Hyper-V Isolation support check in the cc_platform_has()
	  and return true for guest memory encrypt attr.
	* Remove hv isolation check in the sev_setup_arch()

Tianyu Lan (5):
  swiotlb: Add swiotlb bounce buffer remap function for HV IVM
  x86/hyper-v: Add hyperv Isolation VM check in the cc_platform_has()
  hyper-v: Enable swiotlb bounce buffer for Isolation VM
  scsi: storvsc: Add Isolation VM support for storvsc driver
  net: netvsc: Add Isolation VM support for netvsc driver

 arch/x86/hyperv/hv_init.c         |  10 +++
 arch/x86/hyperv/ivm.c             |  28 ++++++
 arch/x86/kernel/cc_platform.c     |   8 ++
 arch/x86/kernel/cpu/mshyperv.c    |  11 ++-
 drivers/hv/hv_common.c            |  11 +++
 drivers/hv/vmbus_drv.c            |   4 +
 drivers/net/hyperv/hyperv_net.h   |   5 ++
 drivers/net/hyperv/netvsc.c       | 136 +++++++++++++++++++++++++++++-
 drivers/net/hyperv/netvsc_drv.c   |   1 +
 drivers/net/hyperv/rndis_filter.c |   2 +
 drivers/scsi/storvsc_drv.c        |  37 ++++----
 include/asm-generic/mshyperv.h    |   2 +
 include/linux/hyperv.h            |  14 +++
 include/linux/swiotlb.h           |   6 ++
 kernel/dma/swiotlb.c              |  43 +++++++++-
 15 files changed, 296 insertions(+), 22 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
