Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A373C433EF
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 15:39:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05FC163248
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 15:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 05FC163248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EBB4607EA;
	Tue, 16 Nov 2021 15:39:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vJaJSgco9hwa; Tue, 16 Nov 2021 15:39:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7312D607E9;
	Tue, 16 Nov 2021 15:39:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D9D2C001E;
	Tue, 16 Nov 2021 15:39:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B45ADC0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 15:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D2B0607F0
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 15:39:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cBWrWNTXiKUn for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 15:39:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EB3ED607EA
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 15:39:29 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id n26so13921399pff.3
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 07:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ytk8p6TdYJp6Y0bV41yrFTfo+pk8rHAune+7pZw0P98=;
 b=BXz0KFtLleSQa3skiYw7QDE1dXPqvkgmZsVeu4fLM5Yo+p5BS9ZqK8GmlqMk8KB2Jd
 MbFA1Sdyl8HeuFhTjRLnnl3I6jVDF41fuFlW3H6A+W4gc2Uds+KPsc9KT7JcuhVGbq/t
 XAcYRH7ZrHrS/7eajwuW1ku+LBiQ4Qc+oXHnk0LQfeobjP2mtKBjazQ5Ojyz1ZP9PGUs
 KqRxaCIQx43OP4enShtmT5F7s37Tk9u+0bvcviYRxBqU7AdqBL5xPuBzLRr/J69QC52x
 9+z78bSAAsg3A9UtUTA6eQyj+jhqQGR/7QgyARigUS1/lv1vKxm9S0dnSLpOzn5YgjJU
 DsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ytk8p6TdYJp6Y0bV41yrFTfo+pk8rHAune+7pZw0P98=;
 b=pDSqXJT5KgcptCQsq1FhDIYjEr5KEN81KnZbibkFkl3o+2oPANIB54rTjghSEozWM4
 amTOmemHdF8XZ00ZhHLFh5N/psbYmYXot1uk1gjdZKVBrcC0jSS90ZwBxwvM4yaIadu8
 t6pXBUQoISvqF0LWTvSiBA1mHiZxQFjbDfh9v0JoJ24R29LXrSsxdTjx807MTx4w52ke
 imhB63j67F3NetdOHsh7Qdiaq/3VWBpjzpQZP4Y+1s2JVL+GliLArUfZdIPKu3A4u3gu
 LKkV1s1XDarteA4tKqJXOtV/9oLDt9eQ56+hLvKWgwbjwOHwwY2wnI1B14KYVAIJ+9sb
 jz8w==
X-Gm-Message-State: AOAM531IkNGbbi4E6be8O3xwpY2v+UkJbrjyopx9WS/y9OkiMGdvQ22Y
 8eBDIXRnK7cZwKN34C+w1tw=
X-Google-Smtp-Source: ABdhPJwz59YenP80sWYPo5tTasO7qod/XFwabISMwdQ71s0CE7pvGan1FvjN3qeawYe/WCw9pDZXgA==
X-Received: by 2002:a62:5215:0:b0:49f:a996:b724 with SMTP id
 g21-20020a625215000000b0049fa996b724mr40917927pfb.3.1637077166648; 
 Tue, 16 Nov 2021 07:39:26 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:3:57e4:b776:c854:76dd])
 by smtp.gmail.com with ESMTPSA id x64sm1981948pfd.151.2021.11.16.07.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Nov 2021 07:39:25 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, jgross@suse.com, sstabellini@kernel.org,
 boris.ostrovsky@oracle.com, kys@microsoft.com, haiyangz@microsoft.com,
 sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 joro@8bytes.org, will@kernel.org, davem@davemloft.net, kuba@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com,
 xen-devel@lists.xenproject.org, michael.h.kelley@microsoft.com
Subject: [PATCH 0/5] x86/Hyper-V: Add Hyper-V Isolation VM support(Second part)
Date: Tue, 16 Nov 2021 10:39:18 -0500
Message-Id: <20211116153923.196763-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, brijesh.singh@amd.com, vkuznets@redhat.com
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

Tianyu Lan (5):
  x86/Swiotlb: Add Swiotlb bounce buffer remap function for HV IVM
  dma-mapping: Add vmap/vunmap_noncontiguous() callback in dma ops
  hyperv/IOMMU: Enable swiotlb bounce buffer for Isolation VM
  net: netvsc: Add Isolation VM support for netvsc driver
  scsi: storvsc: Add Isolation VM support for storvsc driver

 arch/x86/mm/mem_encrypt.c         |   4 +-
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
 kernel/dma/swiotlb.c              |  75 ++++++++++--
 14 files changed, 488 insertions(+), 45 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
