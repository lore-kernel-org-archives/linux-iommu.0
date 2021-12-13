Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0375BC433FE
	for <iommu@archiver.kernel.org>; Mon, 13 Dec 2021 07:14:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9097B60EF7;
	Mon, 13 Dec 2021 07:14:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O9rc7muF1Zs9; Mon, 13 Dec 2021 07:14:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3A45D60B00;
	Mon, 13 Dec 2021 07:14:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D7C7C001E;
	Mon, 13 Dec 2021 07:14:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD2F7C0012
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 07:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96D1542716
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 07:14:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XwAOflhGysEf for <iommu@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 07:14:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 756234270F
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 07:14:20 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id x7so11239784pjn.0
 for <iommu@lists.linux-foundation.org>; Sun, 12 Dec 2021 23:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UfuTaJDyXzWWoDYpJEZSIO5JTCFYXSinj9/66++nx+8=;
 b=RZ0YY+OjZHDPoom122dz/JrubEt5dlGUC6OFfP4osjDd9rIXLDP06olqgI1BIaJMep
 kMALBWOtjoDYEk7G2/NWri/6CYjTHBH8WpjIXAvLqvzecxg0T1wABbrWy2j70yN/ZnDW
 Q3BVQcLOF5xUtk1ic8okW3uixLUoeKltjcsXNdp0ehE3FdBs2M6KTlZ2j/DmikpmShKa
 g2n70MTxmRobd3Xagotay0kyXpJswrV1BoY/3CtcWLgJBTX1T1n4GAnioELXVkmmX4kX
 PO9BleMTznOu0XaJwSo9ZWTgZuUiZfIRcB4aqw5+E4+0G61nu/9fQ65nzlK0k+fryyyL
 5pLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UfuTaJDyXzWWoDYpJEZSIO5JTCFYXSinj9/66++nx+8=;
 b=xGUmGo3/4VALWoyp0JCoSluQe8NlGnFhGjXuM258T3iSLfW5NGkVkfq57wHDCBrGYY
 nbphSE3Nwgnv03mKYXe8fiC/hGlHQoSpZYu4ZBtejs79atl/7ZVCc2+vVTnGyzJTWHQP
 pSL7zOl65EHYUAkVBl4ly8d7/mcS5EM9og/Mq5YNMCKfg4qazhakX8FOgDbwy/2hPLnb
 /tczP+vuXQeL9Yi/lB/9w3mL4tBPbcG1Ucvhh3z3/RJ/3uNVQel2mXI3w7qx3Tz9hwSi
 +H0sG1hVTrUGN3Y5Inq7tu4xBMNNcfm47/6Gr6kW4n5WFYKWaFgcChZNw6k/+1D74Am/
 Qgcw==
X-Gm-Message-State: AOAM532/8PSJqTBkVqsCA4LIZCFBKPfq0rzbmIFw8HQkHcaClzo2RRQz
 UNxyWgxYTUtSUaMoiG0urxU=
X-Google-Smtp-Source: ABdhPJwRsynwa0p4Q+W3Ffv/Pbq1OH3Vp7CAdAtnzgtPcoNFneam7RHH/ich5nSp4fignTT/cNGGhw==
X-Received: by 2002:a17:902:7616:b0:143:a8cd:ef0 with SMTP id
 k22-20020a170902761600b00143a8cd0ef0mr93169802pll.48.1639379659905; 
 Sun, 12 Dec 2021 23:14:19 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:36:a586:a4cb:7d3:4f27])
 by smtp.gmail.com with ESMTPSA id qe12sm6079401pjb.29.2021.12.12.23.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Dec 2021 23:14:19 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, davem@davemloft.net, kuba@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, arnd@arndb.de,
 hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
 thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 michael.h.kelley@microsoft.com
Subject: [PATCH V7 0/5] x86/Hyper-V: Add Hyper-V Isolation VM support(Second
 part)
Date: Mon, 13 Dec 2021 02:14:01 -0500
Message-Id: <20211213071407.314309-1-ltykernel@gmail.com>
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
drivers in Isolation VM.

Change since v6:
        * Fix compile error in hv_init.c and mshyperv.c when swiotlb
	  is not enabled.
	* Change the order in the cc_platform_has() and check sev first. 

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

 arch/x86/hyperv/hv_init.c         |  12 +++
 arch/x86/hyperv/ivm.c             |  28 ++++++
 arch/x86/kernel/cc_platform.c     |   8 ++
 arch/x86/kernel/cpu/mshyperv.c    |  15 +++-
 drivers/hv/hv_common.c            |  11 +++
 drivers/hv/vmbus_drv.c            |   4 +
 drivers/net/hyperv/hyperv_net.h   |   5 ++
 drivers/net/hyperv/netvsc.c       | 136 +++++++++++++++++++++++++++++-
 drivers/net/hyperv/netvsc_drv.c   |   1 +
 drivers/net/hyperv/rndis_filter.c |   2 +
 drivers/scsi/storvsc_drv.c        |  37 ++++----
 include/asm-generic/mshyperv.h    |   2 +
 include/linux/hyperv.h            |   6 ++
 include/linux/swiotlb.h           |   6 ++
 kernel/dma/swiotlb.c              |  43 +++++++++-
 15 files changed, 294 insertions(+), 22 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
