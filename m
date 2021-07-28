Return-Path: <SRS0=45t2=MU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5204DC4320E
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 14:53:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D6F60232
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 14:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1D6F60232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B813606C4;
	Wed, 28 Jul 2021 14:53:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t011-a6qqLuR; Wed, 28 Jul 2021 14:53:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 76EEF606F2;
	Wed, 28 Jul 2021 14:53:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E703C0010;
	Wed, 28 Jul 2021 14:53:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AA34C000E
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 14:53:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5719E405FC
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 14:53:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a2oXFg0PLMPp for <iommu@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 14:53:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F6864061A
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 14:53:04 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 k4-20020a17090a5144b02901731c776526so10381469pjm.4
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 07:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Dw5WYuI9KVHFCJFCuZejwMnhkTgwwA05j2VLkdgyjhM=;
 b=p8qM8rC90F/SM+apT/EKASeB6fk585n2JEbifixZyOxlq6Ktg1+eiu4rOMbpMYscY4
 JDfzCVUj9P+r/SbSk8+43y67Xs+hltMLq0r8e1vxWdiJYA32QLDKYaF7utDPLO8dLfdF
 l4v8OvMGbDTrSVvXSTCaVk15GCPLEQmwD09MewR60DSKGnLNjv+/+EnweU32/41Fs86F
 0L1ZWMlpQppSV+tmLg7d76sQrzEVzXrxEo4o6XYH2JXSmSe4szqvA/msBGK3U2Gnbyyg
 uh7t8h18JFBAPOUiE8jKhEBQHww4hFERe9e7SJLCaJq3eu3vAeflxbBbkXxSHBhPLqqJ
 zymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Dw5WYuI9KVHFCJFCuZejwMnhkTgwwA05j2VLkdgyjhM=;
 b=WkSgT0ak76NfVSi8HVF6Nshy6EClELEv3h/YOkoDrsRuFcbZxAngEck/Yk3KP4xjBS
 Kwt3O+VWlk+PGwSpk7J5sm7a+2dCx08NprznxHUcCMoLANU/QQS1Ucgfrbjsx6vUEkFL
 oGDDVOF0FDVqaSe5BrZm5XJ5xSjWUPNV5szi7ei39nnG783ZC3J/jGUMcc/DZLFd4++H
 7LZdCHyW8ayw5x3uzZYyReXo4V5b12PyoC1mscXBRxdH3lC2GEz2RsB2u2YE8AlbjQ9O
 WFgs981ERJKmeX0Elg+c8Cy1ioGQW1romHoOtI5DN5rmD4jAUAtIOBdALV7ip90e67tK
 sm8w==
X-Gm-Message-State: AOAM533RydBv6rfCSwfD+Xh+biZSzIg4shos4gSvKVqbOktShcgvOf0V
 702aYNoa43VdX5Lq5+mH6xo=
X-Google-Smtp-Source: ABdhPJyvKNqJV0d7lhBz81EV8gx+LUMnHngVQwyGZ1LUs86TzJ1AZOB/8lE8YF+OwPlhBwTvVwzTSQ==
X-Received: by 2002:a62:798e:0:b029:327:6d4a:c4db with SMTP id
 u136-20020a62798e0000b02903276d4ac4dbmr203576pfc.50.1627483984118; 
 Wed, 28 Jul 2021 07:53:04 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:0:3823:141e:6d51:f0ad])
 by smtp.gmail.com with ESMTPSA id n134sm277558pfd.89.2021.07.28.07.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jul 2021 07:53:03 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com,
 sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, thomas.lendacky@amd.com,
 brijesh.singh@amd.com, ardb@kernel.org, Tianyu.Lan@microsoft.com,
 rientjes@google.com, martin.b.radev@gmail.com, akpm@linux-foundation.org,
 rppt@kernel.org, kirill.shutemov@linux.intel.com,
 aneesh.kumar@linux.ibm.com, krish.sadhukhan@oracle.com, saravanand@fb.com,
 xen-devel@lists.xenproject.org, pgonda@google.com, david@redhat.com,
 keescook@chromium.org, hannes@cmpxchg.org, sfr@canb.auug.org.au,
 michael.h.kelley@microsoft.com
Subject: [PATCH 00/13] x86/Hyper-V: Add Hyper-V Isolation VM support
Date: Wed, 28 Jul 2021 10:52:15 -0400
Message-Id: <20210728145232.285861-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 anparri@microsoft.com, vkuznets@redhat.com
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

Change sicne RFC V4:
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
  x86/HV: Initialize GHCB page in Isolation VM
  x86/HV: Initialize shared memory boundary in the Isolation VM.
  x86/HV: Add new hvcall guest address host visibility support
  HV: Mark vmbus ring buffer visible to host in Isolation VM
  HV: Add Write/Read MSR registers via ghcb page
  HV: Add ghcb hvcall support for SNP VM
  HV/Vmbus: Add SNP support for VMbus channel initiate message
  HV/Vmbus: Initialize VMbus ring buffer for Isolation VM
  DMA: Add dma_map_decrypted/dma_unmap_encrypted() function
  x86/Swiotlb: Add Swiotlb bounce buffer remap function for HV IVM
  HV/IOMMU: Enable swiotlb bounce buffer for Isolation VM
  HV/Netvsc: Add Isolation VM support for netvsc driver
  HV/Storvsc: Add Isolation VM support for storvsc driver

 arch/x86/hyperv/Makefile           |   2 +-
 arch/x86/hyperv/hv_init.c          |  87 +++++++--
 arch/x86/hyperv/ivm.c              | 296 +++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |  18 ++
 arch/x86/include/asm/mshyperv.h    |  86 ++++++++-
 arch/x86/include/asm/sev.h         |   4 +
 arch/x86/kernel/cpu/mshyperv.c     |   5 +
 arch/x86/kernel/sev-shared.c       |  21 +-
 arch/x86/mm/pat/set_memory.c       |   6 +-
 arch/x86/xen/pci-swiotlb-xen.c     |   3 +-
 drivers/hv/Kconfig                 |   1 +
 drivers/hv/channel.c               |  48 ++++-
 drivers/hv/connection.c            |  71 ++++++-
 drivers/hv/hv.c                    | 129 +++++++++----
 drivers/hv/hyperv_vmbus.h          |   3 +
 drivers/hv/ring_buffer.c           |  84 ++++++--
 drivers/hv/vmbus_drv.c             |   3 +
 drivers/iommu/hyperv-iommu.c       |  65 +++++++
 drivers/net/hyperv/hyperv_net.h    |   6 +
 drivers/net/hyperv/netvsc.c        | 144 +++++++++++++-
 drivers/net/hyperv/rndis_filter.c  |   2 +
 drivers/scsi/storvsc_drv.c         |  68 ++++++-
 include/asm-generic/hyperv-tlfs.h  |   1 +
 include/asm-generic/mshyperv.h     |  53 +++++-
 include/linux/dma-map-ops.h        |   9 +
 include/linux/hyperv.h             |  16 ++
 include/linux/swiotlb.h            |   4 +
 kernel/dma/mapping.c               |  22 +++
 kernel/dma/swiotlb.c               |  11 +-
 29 files changed, 1166 insertions(+), 102 deletions(-)
 create mode 100644 arch/x86/hyperv/ivm.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
