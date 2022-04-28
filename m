Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07773C433FE
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 14:14:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B3B7440155;
	Thu, 28 Apr 2022 14:14:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id igwy82CellUx; Thu, 28 Apr 2022 14:14:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 72186401F8;
	Thu, 28 Apr 2022 14:14:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3795AC0032;
	Thu, 28 Apr 2022 14:14:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAFCEC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 985FC6077D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:14:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9NNlafuyAawD for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 14:14:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 136BF6058A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:14:33 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id q8so4474222plx.3
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tCLwNfkt8IkQwQwgXeFCHqx3e0FBGJobOavs3qCFjyE=;
 b=GE2h5rv5yNN4+7vkguJ2Fs9FpsVIhiTfyGcCgE7FFlDs7vtxejc0u1OXVkDMpWSpY5
 dPso+ae+h9Ubany5Nbo8AV9rGptAD7NUxqzWOXzcYLSAX77gbMKbS2SPpise1cqEJ7PF
 YEH7XUWWVudC88Wq+WjW6srlVdmfU1ZTwZJK+sDFiZwmHFCqnWmF/f02yj238C8n3/m5
 eNFA8e5mnXqWtbdwEEXlq2PU8+3hzL8XhZld2iq/aHXWicnDlj8s66wCKUhB/y4bmcjI
 z1MCL6R0jhwhmGiEt5SQI+rAWNifmU4J8NgbSqNarF0FhzIqOd13nSFwEwlc0T5yXR3c
 YClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tCLwNfkt8IkQwQwgXeFCHqx3e0FBGJobOavs3qCFjyE=;
 b=IOd192P9nwrCiGDjuBLtMSBO0Ac4EB1WIk5lCiOpA5b+yx/uD26/IBmS656gLUAmUn
 /7iSlIPK9rRW7c47M19vAplIy+rbfubL1hUnf9X2djj6HmtEW0CYCzDN+zLj1O4J4pku
 T/8plPfSlCbfr21330aQuJtijDPAtg1HwGa4HtTuD2Tggi27mcIS6zro6iGRlXV4O+oV
 hjx1UA54QMjT2Ac09pDZvNTuGL6PfX/FdxOyeZRLpAVj1MYbfzJIWkWIegdAwoi3k7bA
 dDhE6bMD0Ywj7FLv7H+KvkE2bqbq6Mwkk12+YfErXWyLmty09vCRFwEn0GQslk0tuYEz
 Awgg==
X-Gm-Message-State: AOAM530S5OoeP/gfPoC3gTyP/o4Yf7CbbxHU9dta4+Pf6wU57hzOnA+k
 jRjsWuSyO4s5Uvpd4sSgl5k=
X-Google-Smtp-Source: ABdhPJwpmHijuE7ZXlhdSTBhFqZEOROLYSOTgh9Uo7dkFKloVMWxiGYHSLCXstNQSnnAEy9YkBvoEQ==
X-Received: by 2002:a17:903:22c6:b0:15d:45d8:8f8a with SMTP id
 y6-20020a17090322c600b0015d45d88f8amr11088920plg.31.1651155273140; 
 Thu, 28 Apr 2022 07:14:33 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:f:de19:84:6ee0:6f2e])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a056a00198800b004fab740dbe6sm65331pfl.15.2022.04.28.07.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 07:14:32 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
 michael.h.kelley@microsoft.com, kys@microsoft.com
Subject: [RFC PATCH 0/2] swiotlb: Introduce swiotlb device allocation function
Date: Thu, 28 Apr 2022 10:14:27 -0400
Message-Id: <20220428141429.1637028-1-ltykernel@gmail.com>
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

This patchset splits the swiotlb into individual areas which have their
own lock. When there are swiotlb map/allocate request, allocate io tlb
buffer from areas averagely and free the allocation back to the associated
area.

Patch 2 introduces an helper function to allocate bounce buffer
from default IO tlb pool for devices with new IO TLB block unit
and set up IO TLB area for device queues to avoid spinlock overhead.
The area number is set by device driver according queue number.

The network test between traditional VM and Confidential VM.
The throughput improves from ~20Gb/s to ~34Gb/s  with this patchset.

Tianyu Lan (2):
  swiotlb: Split up single swiotlb lock
  Swiotlb: Add device bounce buffer allocation interface

 include/linux/swiotlb.h |  58 +++++++
 kernel/dma/swiotlb.c    | 340 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 362 insertions(+), 36 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
