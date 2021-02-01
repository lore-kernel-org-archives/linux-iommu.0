Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2E4C433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 18:55:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B0064DDF
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 18:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B0064DDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8989186322;
	Mon,  1 Feb 2021 18:55:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V6FUEuHTY-Vk; Mon,  1 Feb 2021 18:55:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A1582862E6;
	Mon,  1 Feb 2021 18:55:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9251AC0174;
	Mon,  1 Feb 2021 18:55:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0F79C013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 18:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BDCBD2052A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 18:55:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HCQ7uyMoXKvW for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 18:55:28 +0000 (UTC)
X-Greylist: delayed 00:25:05 by SQLgrey-1.7.6
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74])
 by silver.osuosl.org (Postfix) with ESMTPS id E977420526
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 18:55:27 +0000 (UTC)
Received: by mail-pj1-f74.google.com with SMTP id b4so132111pji.4
 for <iommu@lists.linux-foundation.org>; Mon, 01 Feb 2021 10:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to;
 bh=jmVH+B5byuoeCWBByF+rlgs1IXxlR3I67Dpk6zRz3g4=;
 b=SosvEstR48V1+HoHfiXGnSkDBo6c3RZs6iuOhiDQyZjm9TnrH7JIfkwKv8wGZRq6yS
 XEA9LefU8MB1mV5RA1WAXX5j+n+LUBkbMdz/mQbd5QviOoZKCN/lnUw618TSSfUPrrYt
 xePuFn6+rn4FC4tEsd5IgP9j2ohvNJ1tDqb4IHkjJpRq0v0bTyuPGPgimqUJD9Jhcpvb
 4eWManaTi4YMg0Rub+JEsVfoVWQEXxetnYgoJZ8btWoXceKQv1pjC9+aIMJQi1EQs479
 GVHei57xNQZbS00ckImI9fdie1QtctBpwObaFaZCvzO1heGZs6zbDzRc922TaadtIIVX
 Ui/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to; bh=jmVH+B5byuoeCWBByF+rlgs1IXxlR3I67Dpk6zRz3g4=;
 b=E6DIHJxwWnxLHA8APfenpJOCltFtMQq98QCU11X7N9MpxropLXfjNWHMr8PuwZbDPY
 Om8OS7/mMEfS8zcfFxlFmytF2K3mYPkK6hn9NZbbeVLT2hA3EyS5LEWnvZW+7bALHtOd
 xk2hdkjbUimJZcbFmZbhGcKgdVDdeVRJRbz3Xkh+RL3Ev7Fh1kUH3Llncmr5FZloPX8p
 WG523GpyXNE7x2GxIJuTXo4CyPn2ApyaIRfZLFZZ+Ph2xa4j3cPyqvVn61oRRReE8EIL
 CVR7EuytqnmOo4czbUDyR2q+VLxgRMbXkxOI9bli7mKLc9KwkLHbTv5Q3pCYGK7uL9Jg
 8TNw==
X-Gm-Message-State: AOAM533JJ0OvppjCcy5fln4gsTDhOtG7GJ6WnFp2km6SfGqQvnvdr5Ow
 EHQ3ckzlWK6NKOyN4US8HLDdI1jIcg==
X-Google-Smtp-Source: ABdhPJw91byWRyJEd+QII2hd/UYZLifFIxJy6ksqPbqPXXoI12a7ZnTaYTpJH9qVyZ2rTyjQMxFgH+s6dw==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:695f:7f9e:413c:e3c7])
 (user=jxgao job=sendgmr) by 2002:a17:902:6b88:b029:df:ff72:7bc6 with SMTP id
 p8-20020a1709026b88b02900dfff727bc6mr18389861plk.23.1612204221515; Mon, 01
 Feb 2021 10:30:21 -0800 (PST)
Date: Mon,  1 Feb 2021 10:30:14 -0800
Message-Id: <20210201183017.3339130-1-jxgao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH V2 0/3] SWIOTLB: Preserve swiotlb map offset when needed.
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
meta-data=/dev/nvme2n1   isize=512    agcount=4, agsize=131072 blks
         =               sectsz=512   attr=2, projid32bit=1
         =               crc=1        finobt=1, sparse=0, rmapbt=0, refl
ink=0
data     =               bsize=4096   blocks=524288, imaxpct=25
         =               sunit=0      swidth=0 blks
naming   =version 2      bsize=4096   ascii-ci=0 ftype=1
log      =internal log   bsize=4096   blocks=2560, version=2
         =               sectsz=512   sunit=0 blks, lazy-count=1
realtime =none           extsz=4096   blocks=0, rtextents=0
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
