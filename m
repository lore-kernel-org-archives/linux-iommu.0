Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16347C4332F
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 12:54:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACFAD83118;
	Mon,  2 May 2022 12:54:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jKsVvQ62a6ij; Mon,  2 May 2022 12:54:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7E527830AB;
	Mon,  2 May 2022 12:54:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32E4DC0039;
	Mon,  2 May 2022 12:54:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 859FDC002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 12:54:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62DAB60DCA
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 12:54:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dTmE5S_2THwc for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 12:54:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C275F60BED
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 12:54:44 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id h1so12204948pfv.12
 for <iommu@lists.linux-foundation.org>; Mon, 02 May 2022 05:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lbEov+FhR+8nc69KMMmSEUhJy6W9UVkpDOopEtF89fc=;
 b=hUvx/25zW89ms9GhbHqU48k8kF2xs+CDUa7/+K3+2uP0ln3Nl8DQF+KgsKbdHT+oBY
 XPT70s/dZuefWTzw5Az544RpQLgfWnJgG5YjZrL1YJWgKeuf48yBgnkq8EugUx3PMwaV
 vfWPmUe0j9DvB7qnfFXrQnIXnYJGGzDHXBlssPp5FSGH3j3CKZVOt2+Pc3HrAbl/v1Kt
 b11cr7EfKdfyTgpX1HXw1erl0CfirRI+DpJeRDXV52/dcQ+ufwHKb6+4Y+PK7oftlQ+s
 VIgizyJ5YsjfYa17rpBTpvocw358t5quqZoNdsNTiYo/lL24BFtMIcnHt2NMbCtlDSFu
 fS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lbEov+FhR+8nc69KMMmSEUhJy6W9UVkpDOopEtF89fc=;
 b=oIMg1OePDciyIP8XTPPqfYkiC1r/yIl+vfaFsigrwEfMdAkmFUp/YdEeR/vGmUOmsM
 cdpgQgSzZu3ozPnhQ4OR9S7cbXNZ4xDUL2TEseCILO/X588//Rz5Er5xI4gJQgKP489v
 JlAt51+Lt1ZkW4bjag0TlYA4NaDrU63xE/9zfwH6/dnyiVZ2TJYpatEjo3Af0QhLCFYX
 KzU06YW2u2wZ1DxW5oQSL/+3qfYtgrsI+pttm6rSHxReqJ/QiAeW0et80kWdgD9MgRb8
 DbO+TJZLjL+t7NDmEbfVx3AWIwXKogOJj1g5lKikKt6wNh906ZWufWsEaQIZTk3yqNxV
 aBAw==
X-Gm-Message-State: AOAM532fl4WYVKEkXqIRMpQe7RJGrdeoKa9istAWqQ+Fxa1hGrNE7qQY
 ZeW6TXF7OHaRRsT1yjf3/nw=
X-Google-Smtp-Source: ABdhPJzXf5hMGAiB6o95CsJMVMem8LRUsG1FjHy8vj+Fb6+9Oi+3CUoVcaBLjiqSZx0wvTClo68J2w==
X-Received: by 2002:a63:2bc4:0:b0:3ab:1d76:64db with SMTP id
 r187-20020a632bc4000000b003ab1d7664dbmr9372414pgr.508.1651496083959; 
 Mon, 02 May 2022 05:54:43 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:3:7753:ad69:7fc0:9dfc])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a62e505000000b0050dc76281cesm4634892pff.168.2022.05.02.05.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 May 2022 05:54:43 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
 michael.h.kelley@microsoft.com, kys@microsoft.com
Subject: [RFC PATCH V2 0/2] swiotlb: Add child io tlb mem support
Date: Mon,  2 May 2022 08:54:34 -0400
Message-Id: <20220502125436.23607-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com, wei.liu@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-hyperv@vger.kernel.org,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 kirill.shutemov@intel.com, iommu@lists.linux-foundation.org,
 andi.kleen@intel.com, brijesh.singh@amd.com, vkuznets@redhat.com, hch@lst.de
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

Traditionally swiotlb was not performance critical because it was only
used for slow devices. But in some setups, like TDX/SEV confidential
guests, all IO has to go through swiotlb. Currently swiotlb only has a
single lock. Under high IO load with multiple CPUs this can lead to
significant lock contention on the swiotlb lock.

This patch adds child IO TLB mem support to resolve spinlock overhead
among device's queues. Each device may allocate IO tlb mem and setup
child IO TLB mem according to queue number. The number child IO tlb
mem maybe set up equal with device queue number and this helps to resolve
swiotlb spinlock overhead among devices and queues.

Patch 2 introduces IO TLB Block concepts and swiotlb_device_allocate()
API to allocate per-device swiotlb bounce buffer. The new API Accepts
queue number as the number of child IO TLB mem to set up device's IO
TLB mem.

Tianyu Lan (2):
  swiotlb: Add Child IO TLB mem support
  Swiotlb: Add device bounce buffer allocation interface

 include/linux/swiotlb.h |  40 ++++++
 kernel/dma/swiotlb.c    | 290 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 317 insertions(+), 13 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
