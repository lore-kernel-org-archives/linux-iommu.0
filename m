Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47DCC433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 00:26:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6002564EB9
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 00:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6002564EB9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 121F32153E;
	Tue,  2 Feb 2021 00:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B8of1Tsb44vw; Tue,  2 Feb 2021 00:26:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0740120334;
	Tue,  2 Feb 2021 00:26:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC5FBC0174;
	Tue,  2 Feb 2021 00:26:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83E3FC013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 00:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6389021509
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 00:26:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kiVbvTK3x4Lc for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 00:26:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by silver.osuosl.org (Postfix) with ESMTPS id 706AF20334
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 00:26:09 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id h14so18232120otr.4
 for <iommu@lists.linux-foundation.org>; Mon, 01 Feb 2021 16:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZaKN0kS6u64uQV+6FGLHQ/HFDrwuOhBJX+D4+gTt6r0=;
 b=tCDZIyKRfYkflVO/mtEEY/OhC27bA9kqcX/5z+t4BtDBqfjp5sZ49VjvxVeoplOarj
 AHmY7N+os6HUVETD7QEgDovkqXB9vRw9mosvTMB0EzWzWlaO05AsR204OzZKZglBwYiX
 pHQBMKa7/HwClvsBCbv5i43x7LoXh+9DL2zfBgKB+ONF2UqWACyeWSzlt2oyy3ElQkYU
 jU42fR2o3wK8iolXAqeuVQN1utwYgYnSs8VYPrrMqiVJVYcqHdUGJWMc9C9X41IuMgq9
 H5UcsTgNmbqCwr1LI57T+EnrptCtYRBZDYWAvgWbsMxvK6h1QSipoNDTD9tPto4A4sar
 N7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZaKN0kS6u64uQV+6FGLHQ/HFDrwuOhBJX+D4+gTt6r0=;
 b=qIdxdU+vbGO5l7LOmefwgikrDI8tb0eJyTwuTYr3ChBt1aRV8RsylHhZo/xVG25xkm
 R6K+f5l1pPdyBQHgwI4Up9DRqHXaaaiUhc0B10mkTuUU06b4IeJJOwd/26GvQq0tohmm
 RFiGOjWwCdYAoeUqYQSPM6i99Qfyqn1Od3IQifvPknSkCwaK37hJaUimlo9mdh6iSmuc
 XQy00fS6ttX4dMETUgI48B91AAWGmFw4YWL2iC/TdWQqCRn4KLz7/EYyrGAw0mhZnxQP
 kJ33rf2SgJFRAEwvVzziAlzQE7+Q3fhpijRKoz5p6fS71Ou/1zuTm1UHaZEoSGG4V4hu
 mrEg==
X-Gm-Message-State: AOAM530PqNM0AIigmEDyv7of0u43dxyxxOYxRT3+PdHmF8edpWoHOfEk
 8nd5CpuJr5EZxE5mycvSwMzFk6S/hN3ADWQ7SUK5TQ==
X-Google-Smtp-Source: ABdhPJyFgXBxhpe6iO2OHTC17kqmn9HUrbruwF7fouFTXMMPS3G9sjeY2vc7eAvB7AwHVf2zMFQpAJVvevVDT4EA30k=
X-Received: by 2002:a9d:7d12:: with SMTP id v18mr13319071otn.205.1612225568439; 
 Mon, 01 Feb 2021 16:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
 <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com>
 <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
 <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
In-Reply-To: <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
Date: Mon, 1 Feb 2021 16:25:55 -0800
Message-ID: <CAMGD6P0uwVxKuG503ahGTbPcwb+y2wRXSiE_gvzfdUrMfZ5YbA@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask
 to NVMe driver.
To: Keith Busch <kbusch@kernel.org>
Cc: heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 Saravana Kannan <saravanak@google.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Orr <marcorr@google.com>,
 gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, axboe@fb.com,
 bgolaszewski@baylibre.com, iommu@lists.linux-foundation.org, jroedel@suse.de,
 dan.j.williams@intel.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

> Why is this setting being done and undone on each IO? Wouldn't it be
> more efficient to set it once during device initialization?

I agree that setting it once is the right way of doing it.

So I have changed the patch to enable the mask once in nvme_probe.

 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 81e6389b2042..4ce78373f98d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2630,6 +2630,9 @@ static void nvme_reset_work(struct work_struct *work)
         */
        dma_set_max_seg_size(dev->dev, 0xffffffff);

+       if (dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1))
+               dev_warn(dev->dev, "dma_set_min_align_mask failed to
set offset\n");
+
        mutex_unlock(&dev->shutdown_lock);

        /*

However on boot of the system, the following error happens occasionally.
The error seems related to Journal service. Whenever "Stopping Journal
Service..."
appears, the boot succeeds. Otherwise boot fails with the following message.

----------------------------log start here--------------------------
[  OK  ] Started Journal Service.
[   10.774545] xfs filesystem being remounted at / supports timestamps
until 2038 (0x7fffffff)
[  OK  ] Started Remount Root and Kernel File Systems.
         Starting Flush Journal to Persistent Storage...
         Starting Load/Save Random Seed...
         Starting Create Static [   10.804340] systemd-journald[780]:
Received request to flush runtime journal from PID 1
Device Nodes in /dev...
[  OK  ] Started Load/Save Random Seed.
[  OK  ] Started Flush Journal to Persistent Storage.
[  OK  ] Started Create Static Device Nodes in /dev.
         Starting udev Kernel Device Manager...
[  OK  ] Reached target Local File Systems (Pre).
         Starting File System Check on /dev/disk/by-uuid/7281-17FC...
[  OK  ] Started File System Check on /dev/disk/by-uuid/7281-17FC.
         Mounting /boot/efi...
[  OK  ] Mounted /boo[   11.203461] systemd[1]: segfault at 2e0 ip
000055b08607cc24 sp 00007ffe13809090 error 4 in
systemd[55b086000000+140000]
t/efi.
[   11.216088] Code: 02 c7 44 24 10 fe ff ff ff 49 89 e4 89 06 48 8d
6c 24 08 48 8d 5c 24 10 48 c7 44 24 18 00 00 00 00 eb 10 0f 1f 00 48
8b 3c 24 <44> 39 b7 e0 02 00 00 74 3b 49 8b 7d 00 4c 89 e1 48 89 ea 48
89 de
---------------log ends here-----------

> Based on the Keith's comment it needs to be completely avoided in hot path.
>
> Did you get a chance to bisect the problem in the rc6 ? We need to know the
> root cause otherwise it might happen again after we add this patch.

I am now trying to bisect the problem.
I am not sure how the mapping offset could have caused the error.
Any suggestions are appreciated.

--
Jianxiong Gao
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
