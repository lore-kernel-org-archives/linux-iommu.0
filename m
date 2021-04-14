Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCF1C43470
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:50:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C16613BB
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C16613BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC61D405B9;
	Wed, 14 Apr 2021 14:50:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0-5Fq7snAB1w; Wed, 14 Apr 2021 14:50:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 587844055E;
	Wed, 14 Apr 2021 14:50:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E654C000B;
	Wed, 14 Apr 2021 14:50:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 126AAC000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F40588456A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qxb4iRxR5w8A for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 14:50:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C85FA84567
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:24 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id s14so5549769pjl.5
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 07:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LNgcA9L88xzjpALKOwngs/ZZOUv2+a7fU6REsc6ybGE=;
 b=Kat+1cK16+lA3fCdvi1QgvBekDwhFQI9zTdR95B/p5DxNaEeytnPDLuc8bIDW4qaNZ
 7MpGRgPVZJzbiZWX/2tPApbjldX4DT/yH2etG5/hd1N3IIZI8QH+wVoqgqhWp0lF9zhF
 CYGHyy10+pifT7vPIU8a1YJKBRRKjCFoFUlwqa0ZYU1zKN1P0MSOE2YG3UYx6CrVAeTs
 S/3QmZA+TgI/n5i8fooUaW/2BE5mCZdJELj+D7VrR0e2/FBSyNvZpxE7D+wE8EzB8Mu4
 JRbfzHGuUKsnRr6MReu4PWeuJtTyvI2ywUjv+b0j2IkcSFIsSs16cK++DMmmd0ZF0Exz
 D8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LNgcA9L88xzjpALKOwngs/ZZOUv2+a7fU6REsc6ybGE=;
 b=FLdp3wG8h3DMEqzfZKS7AJWqO+sRO+OPQ8CjACV8IhcmPwIl6y4g9/X2cc1/5Btgu6
 f7TL072rY130aBzU0WqQNNRnPMNvfm95+sJVU3lsNCHFZLU485vVPFZwpwfLBdyEJOJB
 zWkJwpT3qVFFUI3uqMueAQqYFA1BfD6W4Wo8cqRVWx8KMkJZyfYzI18hb7nGwu28RvdP
 ePlyaCy5Oin9opgCYPBUrV79Vp5FwlU6xvC7s1s4qbRFl12uOTpn2ufigGNl4EPyF/5O
 CjKyG2xmE7MLc8TkkgNc5Dq/tO+2gZibl4YFMez75OhFI96RnQwohtUcywa/LQgXcpcL
 8rfg==
X-Gm-Message-State: AOAM530pTfmUq9OvQsEMiEp8cQOzaFR14GhnA42DCJdD95mvpg8+khn3
 H0poNyNTyrhwpltbCs1VCZo=
X-Google-Smtp-Source: ABdhPJwAcY4DhPfoRZeotqpbll3PUeqlXCvJZF6LQPCij0BG2ENhkips5kIT10gOWWvPvHcpnEMIUA==
X-Received: by 2002:a17:902:f687:b029:e8:da63:6195 with SMTP id
 l7-20020a170902f687b02900e8da636195mr38390847plg.75.1618411824189; 
 Wed, 14 Apr 2021 07:50:24 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:35:ebad:12c1:f579:e332])
 by smtp.gmail.com with ESMTPSA id w67sm17732522pgb.87.2021.04.14.07.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Apr 2021 07:50:23 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
 gregkh@linuxfoundation.org, konrad.wilk@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, joro@8bytes.org,
 will@kernel.org, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com
Subject: [Resend RFC PATCH V2 00/12] x86/Hyper-V: Add Hyper-V Isolation VM
 support
Date: Wed, 14 Apr 2021 10:49:33 -0400
Message-Id: <20210414144945.3460554-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

"Resend all patches because someone in CC list didn't receive all
patchset. Sorry for nosy."

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
