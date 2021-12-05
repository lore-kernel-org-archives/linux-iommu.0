Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2FDC4332F
	for <iommu@archiver.kernel.org>; Sun,  5 Dec 2021 08:18:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D34AA60749;
	Sun,  5 Dec 2021 08:18:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tavL5Z4ZIA_J; Sun,  5 Dec 2021 08:18:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 23A266069C;
	Sun,  5 Dec 2021 08:18:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E441C002F;
	Sun,  5 Dec 2021 08:18:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6936C0012
 for <iommu@lists.linux-foundation.org>; Sun,  5 Dec 2021 08:18:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B8062606C8
 for <iommu@lists.linux-foundation.org>; Sun,  5 Dec 2021 08:18:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y8GB_pHAPCgS for <iommu@lists.linux-foundation.org>;
 Sun,  5 Dec 2021 08:18:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9ED7D6069C
 for <iommu@lists.linux-foundation.org>; Sun,  5 Dec 2021 08:18:18 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id k26so2821878pfp.10
 for <iommu@lists.linux-foundation.org>; Sun, 05 Dec 2021 00:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dfM94A9YIlyVB8rT/Fyc0cGVK5U5XvE0VXTSezF6RKs=;
 b=XjtWZ4TQugWlqSvIgCkbqi7HQ5b8zuwuwua6IwpffcpwfAyDaobtNwXYuWcvpbBFE4
 9WcjLsStsKid77+RD2YC7kd02/pHapke3O37ldqGjOQxX3qpaITr2seyiQsoxB3w7Wc0
 p/CMzw4L9gQcgza+P0xpVKrvTkJmfwAcQbe9cdQN/96UJkevU198ptb2fql3Nl42vmjo
 z6E4jbyPJsG1mpx5G3qbcemu+YT6WaxTXXHQPNWZTvdAzgx2cPqLhcMeWwsECq7ROn0S
 jdr1XwQiTJQJh0m1FBJbpNlLwobl8Bf+uppKRO+fqeRzV4k1EfksDNQY4LqGbBl9E3qY
 gIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dfM94A9YIlyVB8rT/Fyc0cGVK5U5XvE0VXTSezF6RKs=;
 b=wi00KLRGN71SVd0yMF1X8w+uxlkIhUZqyjYPBp9lxpq30aMuG9UKdlX+xC5UoeuQmX
 Y4pT6u0XQHdSVDDsxxSWD697b35J+/rni04CLV4RW0KhOk690nauMMWJNeNaa1wMF8rD
 745tsMRtxafanReWdch6QY3RlYZjhIVpql6ekYLZnWmv7pd2IJfZBbnAjd7MS1kGOP96
 I1uBZOzbAgfHAADq8/VAJUvHD5ds4/NTTHCywJjUef2nim9RBo/Sl9WdAXVZF1SJwzhq
 mmpvtPZH7OT6/0uqsH7KwmnpTRt/uGIlRAIbOvg82TihCJG4Ia0koYiAGq0y1h65GUgk
 3DYw==
X-Gm-Message-State: AOAM531OE15XiDIabpaj93dWWLZy5ZWyGci//dqG/3RrI1HIKg55xu+1
 fRkwbWGj7TTaK8l0/JzY96I=
X-Google-Smtp-Source: ABdhPJx1nL+30YTsDOKE6LJfYcCpMeKCOeoz9AVpsf63uFFgijhWvJ6bOiQ0k+V3CXM4JXAEUKtCKw==
X-Received: by 2002:aa7:8755:0:b0:494:67a6:1c84 with SMTP id
 g21-20020aa78755000000b0049467a61c84mr28292360pfo.26.1638692297989; 
 Sun, 05 Dec 2021 00:18:17 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:7:87aa:e334:f070:ebca])
 by smtp.gmail.com with ESMTPSA id s8sm6439905pgl.77.2021.12.05.00.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Dec 2021 00:18:17 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, jgross@suse.com, sstabellini@kernel.org,
 boris.ostrovsky@oracle.com, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, xen-devel@lists.xenproject.org,
 michael.h.kelley@microsoft.com
Subject: [PATCH V4 0/5] x86/Hyper-V: Add Hyper-V Isolation VM support(Second
 part)
Date: Sun,  5 Dec 2021 03:18:08 -0500
Message-Id: <20211205081815.129276-1-ltykernel@gmail.com>
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
  Swiotlb: Add Swiotlb bounce buffer remap function for HV IVM
  x86/hyper-v: Add hyperv Isolation VM check in the cc_platform_has()
  hyperv/IOMMU: Enable swiotlb bounce buffer for Isolation VM
  scsi: storvsc: Add Isolation VM support for storvsc driver
  hv_netvsc: Add Isolation VM support for netvsc driver

 arch/x86/hyperv/ivm.c             |  28 ++++++
 arch/x86/kernel/cc_platform.c     |  12 +++
 arch/x86/xen/pci-swiotlb-xen.c    |  12 ++-
 drivers/hv/hv_common.c            |  11 +++
 drivers/hv/vmbus_drv.c            |   4 +
 drivers/iommu/hyperv-iommu.c      |  58 +++++++++++++
 drivers/net/hyperv/hyperv_net.h   |   5 ++
 drivers/net/hyperv/netvsc.c       | 136 +++++++++++++++++++++++++++++-
 drivers/net/hyperv/netvsc_drv.c   |   1 +
 drivers/net/hyperv/rndis_filter.c |   2 +
 drivers/scsi/storvsc_drv.c        |  37 ++++----
 include/asm-generic/mshyperv.h    |   2 +
 include/linux/hyperv.h            |  14 +++
 include/linux/swiotlb.h           |   6 ++
 kernel/dma/swiotlb.c              |  43 +++++++++-
 15 files changed, 349 insertions(+), 22 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
