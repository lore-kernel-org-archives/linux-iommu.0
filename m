Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147F9C433E0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 02:18:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E5264D9F
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 02:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E5264D9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BCDDE86DD4;
	Thu, 28 Jan 2021 02:18:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ohf0fPSn9gPg; Thu, 28 Jan 2021 02:18:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F406E86365;
	Thu, 28 Jan 2021 02:18:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4D35C08A1;
	Thu, 28 Jan 2021 02:18:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D5A6C013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 02:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 203A986365
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 02:18:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qgdheRFUO8Rj for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 02:18:17 +0000 (UTC)
X-Greylist: delayed 01:16:53 by SQLgrey-1.7.6
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com
 [209.85.222.202])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0031F86DCC
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 02:18:16 +0000 (UTC)
Received: by mail-qk1-f202.google.com with SMTP id p185so3096767qkc.9
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 18:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to;
 bh=jmVH+B5byuoeCWBByF+rlgs1IXxlR3I67Dpk6zRz3g4=;
 b=ika8x4rgJdL4GFh0YJshUwWatHQjTXQ6jtilrMjzjB5sX9mt0EINzDY8IG5gykxg+V
 gtt0xZreieN+Cl9Zk4vH0z+L75qd0s7an5EkYb64eAua3UBdHun+3RuVtNay74rRmljF
 w5FPFyJlgdiwd0MdSbvafLRju/MC00+cfc/WbLCEtHZUfpqz6G5N0GL3pImWJyq728PK
 YpGO0gtXK2jnCNQoOP//2fEhqOtPi8l/Kif+ts7PTih+MaXF9ASUVT2b7QL1viThPJSu
 nBl/vQz8MYZ+b63p0HxtEj+3y1yHtHp8vbQsXi2xfJj8uwDwMO5ETL38SDXURD71ibF7
 ChIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to; bh=jmVH+B5byuoeCWBByF+rlgs1IXxlR3I67Dpk6zRz3g4=;
 b=cwgNLr9HsxucyYFbr6pyExo0FdqQGywI4QMy64CFl1TcYeSSFUHdIcJY7vGbxeBDjx
 e8dTOmEEcA5InODupZnOFVXF6s16REPBwaonHtIJQ7eVRk2xDyp5ikaEh19a+jhpq3/Z
 KvPId1S0AvCJFmjEWrz+hU6hBj4vpc+wWO22LdkJwM/zJgLjQEbnxXNeAmLloFbcj3T0
 oFGOIfQOTkfbUPXJHAsG4H8WR6ZXmyaq9LhA2iUWItb127IyKDBCQi+1PyfKIDQXdsSV
 rvSPp5cVUX4dDLuqPRCDxOFDFSHPb4dQnjOrBT5HydplSUeJZRXdHE3CFklhnRkU7zo9
 rUTQ==
X-Gm-Message-State: AOAM531pci3DIkxVm+Qa4s9uAqpc2tsMBKVk42vQl1sdSy786nKQ6rkp
 w8TEEd8wDvibUQeswtm7MbrTlcZ+jg==
X-Google-Smtp-Source: ABdhPJxZSrbWZzQDr55mdPo+6c30/Ybjdp+n6lXqVs1jxzQEstypPUxE0mNfzMHFA3Zn+gC3p6cqscaGjw==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:4d90:620d:7a68:ffc5])
 (user=jxgao job=sendgmr) by 2002:a17:902:67:b029:de:c5e0:87ca with SMTP id
 94-20020a1709020067b02900dec5e087camr13986024pla.64.1611794321730; Wed, 27
 Jan 2021 16:38:41 -0800 (PST)
Date: Wed, 27 Jan 2021 16:38:26 -0800
Message-Id: <20210128003829.1892018-1-jxgao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 0/3] Adding offset keeping option when mapping data via
 SWIOTLB.*
To: jxgao@google.com, erdemaktas@google.com, marcorr@google.com, hch@lst.de, 
 m.szyprowski@samsung.com, robin.murphy@arm.com, gregkh@linuxfoundation.org,
 saravanak@google.com, heikki.krogerus@linux.intel.com, 
 rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
 dan.j.williams@intel.com, bgolaszewski@baylibre.com, jroedel@suse.de, 
 iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, kbusch@kernel.org, 
 axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org
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
From: Jianxiong Gao via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jianxiong Gao <jxgao@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

NVMe driver and other applications may depend on the data offset
to operate correctly. Currently when unaligned data is mapped via
SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. This
patch adds an option to make sure the mapped data preserves its
offset of the orginal addrss.

Without the patch when creating xfs formatted disk on NVMe backends,
with swiotlb=force in kernel boot option, creates the following error:
meta-data=/dev/nvme2n1           isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=0, rmapbt=0, refl
ink=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
mkfs.xfs: pwrite failed: Input/output error

Jianxiong Gao (3):
  Adding page_offset_mask to device_dma_parameters
  Add swiotlb offset preserving mapping when
    dma_dma_parameters->page_offset_mask is non zero.
  Adding device_dma_parameters->offset_preserve_mask to NVMe driver.

 drivers/nvme/host/pci.c     |  4 ++++
 include/linux/device.h      |  1 +
 include/linux/dma-mapping.h | 17 +++++++++++++++++
 kernel/dma/swiotlb.c        | 16 +++++++++++++++-
 4 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
