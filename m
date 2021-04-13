Return-Path: <SRS0=gU7u=JK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3E8C433ED
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 15:37:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB496128C
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 15:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB496128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E1D1401CA;
	Tue, 13 Apr 2021 15:37:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id em8cguYhgnfg; Tue, 13 Apr 2021 15:37:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 09F2D400E3;
	Tue, 13 Apr 2021 15:37:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1244C000B;
	Tue, 13 Apr 2021 15:37:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EEE8C000A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 15:22:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B9A640100
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 15:22:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OAT_-DeFY0Og for <iommu@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 15:22:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 82688400E3
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 15:22:34 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id p16so4445253plf.12
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 08:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+srfers9E9q4+P9qtsCb4JStuWkS4WZj6vAcaSoVbMo=;
 b=BxpjZ6O/1c8XzgIAhlhju9pI7snp8yqWAuS8roa86byjm18CBnlXvlPSDp4K9ogLCA
 md0ln4yPw4zxAALH2i/ba9zXaZ6xqI5anhWQWsKTyXcjTA4PqPlOPAz4bVVBRKUdz1dw
 tFv19azdKvuMaVlNG1M78WQRzIKeeH2Yd81Lo+4JqXIkRzd++1sVVqFjHEHAnlc2uZmg
 hcNXFAYNfdrNLJ9IdG6DrMk0dn1h0KZrWl939rgLUvGMphJGsxCbkLNsZt8n2KWAvdOh
 pTS12g3TaF9aS/Undgp9qlRJeG/Q3B5s2DllAhmLTGxzifFjsah62AIskhiq0qHFiaLJ
 lQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+srfers9E9q4+P9qtsCb4JStuWkS4WZj6vAcaSoVbMo=;
 b=XLUKQGFl2+u547poViFRbYk8hqjHOwUK+IJHRkaVRFFS2RDywK/9x2TU7Q89H3sbRd
 FSBWCgZm+xHSNJGrHKcG4RZKS7ZIxVJjIDf12IGpQP3JziMzzOJ8Ke3aLzQpOs1fUb2C
 yi2noB0SoRBVwgeHQwwruo8uJtKUCLqsg92xLy1yInZjm3lU6M/5BOexny2s7U8ST8TG
 bBC9TK2gELm4b3uSidtdUMam24pgIN6C3BomEzNCutRn+ddUKVcDzDNL6IyIfSCcrKRh
 /HAKoL3O/h59CIVrPww36GTwAZublERkHlokIxMnypFKZ0LXHpKdPb5p9gfBy5BRw7JG
 OqwA==
X-Gm-Message-State: AOAM530PsVCNrljlU5h0mpBuEcB2lXgNjtjfHsSYp+E/acvpUfD2HAsb
 lw3uY72gQ3oXgPHtjyGpqpI=
X-Google-Smtp-Source: ABdhPJxkj7EMiqnlNwZhemaad9k8TJwF36mYJkC/cilAzSTY6lmSj1a708p3PUSfYTswP4gAS4KdrA==
X-Received: by 2002:a17:90a:5407:: with SMTP id
 z7mr581197pjh.228.1618327353881; 
 Tue, 13 Apr 2021 08:22:33 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:36:5b29:fe1a:45c9:c61c])
 by smtp.gmail.com with ESMTPSA id y3sm12882026pfg.145.2021.04.13.08.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 08:22:33 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
 gregkh@linuxfoundation.org, konrad.wilk@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, joro@8bytes.org,
 will@kernel.org, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com
Subject: [RFC V2 PATCH 00/12] x86/Hyper-V: Add Hyper-V Isolation VM support
Date: Tue, 13 Apr 2021 11:22:05 -0400
Message-Id: <20210413152217.3386288-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 13 Apr 2021 15:37:35 +0000
Cc: linux-arch@vger.kernel.org, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, brijesh.singh@amd.com, vkuznets@redhat.com,
 sunilmut@microsoft.com
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
and IO stack memory. So mark vmbus channel ring buffer visible to
host.

There are two exceptions - packets sent by vmbus_sendpacket_
pagebuffer() and vmbus_sendpacket_mpb_desc(). These packets
contains IO stack memory address and host will access these memory.
So add Hyper-V DMA Ops and use DMA API in the netvsc and storvsc
drivers to allocate bounce buffer via swiotlb interface.

For SNP isolation VM, guest needs to access the shared memory via
extra address space which is specified by Hyper-V CPUID HYPERV_CPUID_
ISOLATION_CONFIG. The access physical address of the shared memory
should be bounce buffer memory GPA plus with shared_gpa_boundary
reported by CPUID.

Change since v1:
       * Add DMA API support in the netvsc and storvsc driver.
       * Add Hyper-V DMA ops.
       * Add static branch for the check of isolation type snp.
       * Fix some code style comments.

Tianyu Lan (12):
  x86/HV: Initialize GHCB page in Isolation VM
  x86/HV: Initialize shared memory boundary in Isolation VM
  x86/Hyper-V: Add new hvcall guest address host visibility support
  HV: Add Write/Read MSR registers via ghcb
  HV: Add ghcb hvcall support for SNP VM
  HV/Vmbus: Add SNP support for VMbus channel initiate message
  HV/Vmbus: Initialize VMbus ring buffer for Isolation VM
  UIO/Hyper-V: Not load UIO HV driver in the isolation VM.
  swiotlb: Add bounce buffer remap address setting function
  HV/IOMMU: Add Hyper-V dma ops support
  HV/Netvsc: Add Isolation VM support for netvsc driver
  HV/Storvsc: Add Isolation VM support for storvsc driver

 arch/x86/hyperv/Makefile           |   2 +-
 arch/x86/hyperv/hv_init.c          |  70 +++++--
 arch/x86/hyperv/ivm.c              | 289 +++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |  22 +++
 arch/x86/include/asm/mshyperv.h    |  90 +++++++--
 arch/x86/kernel/cpu/mshyperv.c     |   5 +
 arch/x86/kernel/pci-swiotlb.c      |   3 +-
 drivers/hv/channel.c               |  44 ++++-
 drivers/hv/connection.c            |  68 ++++++-
 drivers/hv/hv.c                    |  73 ++++++--
 drivers/hv/hyperv_vmbus.h          |   3 +
 drivers/hv/ring_buffer.c           |  83 ++++++---
 drivers/hv/vmbus_drv.c             |   3 +
 drivers/iommu/hyperv-iommu.c       | 127 +++++++++++++
 drivers/net/hyperv/hyperv_net.h    |  11 ++
 drivers/net/hyperv/netvsc.c        | 137 +++++++++++++-
 drivers/net/hyperv/rndis_filter.c  |   3 +
 drivers/scsi/storvsc_drv.c         |  67 ++++++-
 drivers/uio/uio_hv_generic.c       |   5 +
 include/asm-generic/hyperv-tlfs.h  |   1 +
 include/asm-generic/mshyperv.h     |  18 +-
 include/linux/hyperv.h             |  12 +-
 include/linux/swiotlb.h            |   5 +
 kernel/dma/swiotlb.c               |  13 +-
 mm/ioremap.c                       |   1 +
 mm/vmalloc.c                       |   1 +
 26 files changed, 1068 insertions(+), 88 deletions(-)
 create mode 100644 arch/x86/hyperv/ivm.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
