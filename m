Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5D1C433F5
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 14:30:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 490F04046D;
	Tue, 23 Nov 2021 14:30:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A4TFg9t1MP2v; Tue, 23 Nov 2021 14:30:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 182A34044C;
	Tue, 23 Nov 2021 14:30:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4451C001E;
	Tue, 23 Nov 2021 14:30:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CE98C0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E4B14044D
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:30:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gQL46x4a-9Wf for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 14:30:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 749724044C
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:30:42 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id m24so17205113pls.10
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 06:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6bsx4hw5NbHCVF2W/NeRmzNghpOYrhv8l8EVf1kn67w=;
 b=cvvJrI1QX3F1CXlrV/8eUkgWUDHfoWCFWFkSOpXBjzB6SsWy2BUpETC33HUCl3JzTF
 kIURt3zkpyvrRd5BJrEeSEm/UeNRI0jzQJP0m2xbAh8qArEft0zYP0V+cQBtcAs7BgXe
 hubXmlepTZ1/aixT1F0M57MbeLtKiw9eZqaaKWVLz4jMeIT5j4lV5bD107ayuaXbeECP
 rtuzlbe5kcIN2LU3rSq94rECq16TEjPrQ9ly9dNq7guAar0qlH4KasIVmcb4DLprmlVi
 Ps4+1+L6gpTnOxtdD/M0ImoIgHwuJ6I7ONj72SCZBB3ifD4OS0vdnWkEqF1QPkouSXf+
 SJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6bsx4hw5NbHCVF2W/NeRmzNghpOYrhv8l8EVf1kn67w=;
 b=j8h4eUGxe9aofaJB6gzfDcW2u6Skm2+21MAh7TBp7ptZRF6krHdug4V4V1OMYQAKzI
 a8KCW/sdIF48j51O8+9pAiK2/GOfCDCT0WLe9rw3p+RGTTmrFwbu5tRkCKYce10cN6P5
 8Cru1m+xzE+X+Cw7XTO1+GuciLmHYNrmm/lM1N7pyDGOUiZAIhEPTKx9uIXQo5W+sUm5
 ITgJ18zagbfn1R/4N5k+7EoceRL9uEQHfndzRIo5cYrjqgXEhURYqG1bj1lZ71IBt+Go
 f35QHrfPMEW37YUa0h0OhEYlA6IxDn56qoFwyl2Qqtyhkm6YUwQwa/VRfK918196Kyv0
 Dmrw==
X-Gm-Message-State: AOAM530X5RvPnZEBTkyj/UPSjO3o1uknDzGxuqtvYnB+i99jIYj6lgd4
 k8FKIobQDrAD1poPmiX1PeU=
X-Google-Smtp-Source: ABdhPJynwRwiHm1UVLqQsERKisSlFY0WvQFTxlH3IfWaqqHV5AmDuFLcHWKC+Om+8FB9dQD/WFJFWg==
X-Received: by 2002:a17:902:a60b:b0:142:7621:be0b with SMTP id
 u11-20020a170902a60b00b001427621be0bmr7298513plq.58.1637677841802; 
 Tue, 23 Nov 2021 06:30:41 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:1:af65:c3d4:6df:5a8b])
 by smtp.gmail.com with ESMTPSA id j13sm11926127pfc.151.2021.11.23.06.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 06:30:41 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 luto@kernel.org, peterz@infradead.org, jgross@suse.com,
 sstabellini@kernel.org, boris.ostrovsky@oracle.com, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, joro@8bytes.org, will@kernel.org, davem@davemloft.net,
 kuba@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
 hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
 Tianyu.Lan@microsoft.com, thomas.lendacky@amd.com,
 xen-devel@lists.xenproject.org, michael.h.kelley@microsoft.com
Subject: [PATCH V2 0/6] x86/Hyper-V: Add Hyper-V Isolation VM support(Second
 part)
Date: Tue, 23 Nov 2021 09:30:31 -0500
Message-Id: <20211123143039.331929-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com,
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

For SNP isolation VM, guest needs to access the shared memory via
extra address space which is specified by Hyper-V CPUID HYPERV_CPUID_
ISOLATION_CONFIG. The access physical address of the shared memory
should be bounce buffer memory GPA plus with shared_gpa_boundary
reported by CPUID.

This patchset is to enable swiotlb bounce buffer for netvsc/storvsc
in Isolation VM. Add Hyper-V dma ops and provide dma_alloc/free_
noncontiguous and vmap/vunmap_noncontiguous callback. Allocate
rx/tx ring via dma_alloc_noncontiguous() and map them into extra
address space via dma_vmap_noncontiguous().

Change since v1:
     * Add Hyper-V Isolation support check in the cc_platform_has()
       and return true for guest memory encrypt attr.
     * Remove hv isolation check in the sev_setup_arch()

Tianyu Lan (6):
  Swiotlb: Add Swiotlb bounce buffer remap function for HV IVM
  dma-mapping: Add vmap/vunmap_noncontiguous() callback in dma ops
  x86/hyper-v: Add hyperv Isolation VM check in the cc_platform_has()
  hyperv/IOMMU: Enable swiotlb bounce buffer for Isolation VM
  net: netvsc: Add Isolation VM support for netvsc driver
  scsi: storvsc: Add Isolation VM support for storvsc driver

 arch/x86/kernel/cc_platform.c     |  15 +++
 arch/x86/mm/mem_encrypt.c         |   1 +
 arch/x86/xen/pci-swiotlb-xen.c    |   3 +-
 drivers/hv/Kconfig                |   1 +
 drivers/hv/vmbus_drv.c            |   6 +
 drivers/iommu/hyperv-iommu.c      | 164 +++++++++++++++++++++++++
 drivers/net/hyperv/hyperv_net.h   |   5 +
 drivers/net/hyperv/netvsc.c       | 192 +++++++++++++++++++++++++++---
 drivers/net/hyperv/rndis_filter.c |   2 +
 drivers/scsi/storvsc_drv.c        |  37 +++---
 include/linux/dma-map-ops.h       |   3 +
 include/linux/hyperv.h            |  17 +++
 include/linux/swiotlb.h           |   6 +
 kernel/dma/mapping.c              |  18 ++-
 kernel/dma/swiotlb.c              |  53 ++++++++-
 15 files changed, 482 insertions(+), 41 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
