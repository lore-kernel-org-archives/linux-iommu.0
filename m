Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BE0C433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 16:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CA6261BE2;
	Wed,  1 Dec 2021 16:03:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4MVncELIRBWE; Wed,  1 Dec 2021 16:03:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D4F1561BD5;
	Wed,  1 Dec 2021 16:03:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC78BC0012;
	Wed,  1 Dec 2021 16:03:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75B2FC000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 16:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 600FF61BD5
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 16:03:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l3BpgIjlJuOW for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 16:03:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE9D661BAD
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 16:03:04 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 nh10-20020a17090b364a00b001a69adad5ebso1994959pjb.2
 for <iommu@lists.linux-foundation.org>; Wed, 01 Dec 2021 08:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rlwCB8WctxDfzc6GjE9sqD8LeMvFTR6Cy4YHzp8XozM=;
 b=g65nlico0J7bcL2aCYAvGlzhTnCKVbRduh36LX8XvjEFFN6wHfS2L0u8BDmelEHEXY
 Wv2DKXAKifhTQ2TpjjT56A67ntJ/hLaAeFO4OjbN4Ti7m1iEE1qu9F65fiYof7/4PEPV
 ZCP/wMs4XoUk93Q/OO68b2EbvB6PER51u6kuhgNSK6ZzO9ZORgPO6UIUg5xjG8sFLdGd
 ls4FlMeHyYU9uABxxpZWR+w8CK7IGHVPGRX+JHnBOypkPhIhIwhSSMvJYvCaN/oA8IVr
 9XQqbYS4GRZB8sJJVE4lMBsN5HiN6zBTtQSYbnnf3R6OllAQ6RujK5AFIFhuwjrdXs5b
 YyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rlwCB8WctxDfzc6GjE9sqD8LeMvFTR6Cy4YHzp8XozM=;
 b=53eKCNCJlcuutdrW0+dzDspmkowJQCX46r3Z5ElwB5kU+94TszE/I3unpHJ+oAoB0G
 0PIPh8ByYcZQ/DE3WKFIzCJOFbFYwiFQknfSI/rChFV4XPab3IC/MgqfXW9GKOtGydDF
 Psww1r4zgcZGSNF1BYR5lxOanhHeHc6oMLzE1AurIBd0LrFDb/CqQuOC4zRp/6H/Gx3g
 7jeZWMG2GBA+sZp+ZtgC3D/03yYfs2ONJydwzsj53NOyetggt6mcr+AyfMjUmyr+v+tc
 E3n1txpa7Pej1/sa9k99txq2/dlirr3W/nDRBa4tdWSV/Bl+d3FzjtoBNVo+P7O/SRQJ
 zDJw==
X-Gm-Message-State: AOAM532IPXFyE0W1Z5TV7CyrMbJ/cJJY4+eNcQPinqrd63IxRce0xYke
 XSslOegDXFjUmGuEHW8Q8EY=
X-Google-Smtp-Source: ABdhPJzx8p2vypCygtN2v0ahrkMP7/JwVPIEscHdxdl4qbo3ST4qz0+r/UT4/nSDoAKM/Jt7Mpx/+Q==
X-Received: by 2002:a17:902:748c:b0:141:c45e:c612 with SMTP id
 h12-20020a170902748c00b00141c45ec612mr8329728pll.73.1638374584178; 
 Wed, 01 Dec 2021 08:03:04 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:f:7fe9:3f1e:749e:5d26])
 by smtp.gmail.com with ESMTPSA id i193sm260316pfe.87.2021.12.01.08.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Dec 2021 08:03:03 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, jgross@suse.com, sstabellini@kernel.org,
 boris.ostrovsky@oracle.com, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, Tianyu.Lan@microsoft.com,
 thomas.lendacky@amd.com, xen-devel@lists.xenproject.org,
 michael.h.kelley@microsoft.com
Subject: [PATCH V3 0/5] x86/Hyper-V: Add Hyper-V Isolation VM support(Second
 part)
Date: Wed,  1 Dec 2021 11:02:51 -0500
Message-Id: <20211201160257.1003912-1-ltykernel@gmail.com>
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
  Swiotlb: Add Swiotlb bounce buffer remap function for HV IVM
  x86/hyper-v: Add hyperv Isolation VM check in the cc_platform_has()
  hyperv/IOMMU: Enable swiotlb bounce buffer for Isolation VM
  scsi: storvsc: Add Isolation VM support for storvsc driver
  hv_netvsc: Add Isolation VM support for netvsc driver

 arch/x86/hyperv/ivm.c             |  28 ++++++
 arch/x86/kernel/cc_platform.c     |  15 ++++
 arch/x86/xen/pci-swiotlb-xen.c    |   3 +-
 drivers/hv/hv_common.c            |  11 +++
 drivers/hv/vmbus_drv.c            |   4 +
 drivers/iommu/hyperv-iommu.c      |  56 ++++++++++++
 drivers/net/hyperv/hyperv_net.h   |   5 ++
 drivers/net/hyperv/netvsc.c       | 136 +++++++++++++++++++++++++++++-
 drivers/net/hyperv/netvsc_drv.c   |   1 +
 drivers/net/hyperv/rndis_filter.c |   2 +
 drivers/scsi/storvsc_drv.c        |  37 ++++----
 include/asm-generic/mshyperv.h    |   2 +
 include/linux/hyperv.h            |  14 +++
 include/linux/swiotlb.h           |   6 ++
 kernel/dma/swiotlb.c              |  47 +++++++++--
 15 files changed, 342 insertions(+), 25 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
