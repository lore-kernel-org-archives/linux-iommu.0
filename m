Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1875C433DB
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 21:23:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A4964E31
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 21:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A4964E31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D40C785E12;
	Mon,  1 Feb 2021 21:23:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IoUp-UbeShZQ; Mon,  1 Feb 2021 21:23:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5913785CC7;
	Mon,  1 Feb 2021 21:23:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 485EFC0FA7;
	Mon,  1 Feb 2021 21:23:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BFCBC013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 21:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 902CB857FB
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 21:22:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5DDd_oFKdCWv for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 21:22:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1648B85797
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 21:22:59 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id d20so4661654oiw.10
 for <iommu@lists.linux-foundation.org>; Mon, 01 Feb 2021 13:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yOWrw7a+Nf/KygeG78AKIm4KgYP1X9MsGHak8Pcn4zg=;
 b=o5jpmsDsoy2ji8gpSb36ZTjvFoA1b9ZgnxGP7BNO941bOozBAgb85HxfqP7ke9weQZ
 SpK7oyNLgUjJX2fDxDZQDiKj5OnmmA1iQLR9Pql9Y7kN07+suHgVlZpX849oC7jsFT57
 cW0DfuuM2Hw+BuZiiWMrn3sKFp79qYjY1DUgakhu1dQ4GghBwUHxOdFyECtLgJOMYpS7
 W8pMJq1aTdPk1qovkiZBrTCtatjVdjA9o1hN0/ieRYZ0JWHw8Q5D/5SEmXQsU5cXpIOn
 sy0df7yFz7oIgQHyrO6/mHCdDwFjmVgfsBhSFTnEzLu5c/U7EipCXJRYolPbbg8FIuOo
 2P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yOWrw7a+Nf/KygeG78AKIm4KgYP1X9MsGHak8Pcn4zg=;
 b=p+al0DX+ZB7vbAzR1KTJJpTPDjkA99RuJZ+GRvCovOWLe/RXQxHVkIvmWpTdB1rd1s
 HI69egVWJ98N2jJOvuhwE0iMANjhsvUk7bZevkOXkI40sPw2W9NUTCrA65/SCXTlJrlU
 cOFyWgo4HnY1ipiQEDCHaNSgJjefr2I5DNMUbQrTUuXyQ+2hjGXvCdg3saIH3pyOt8II
 Sc1QHVP74wE4YaV6sM2SXde8/dJcxHqz2RDrxtPi/Pn1alYYullRolYWxaf1LzTv3NbE
 5qUvNUcAVnU1ywLgs4138ha+cpkX2mwK5UPJUxTKAv7XEFAre6xGpEO67WylwHNxkzuJ
 afiw==
X-Gm-Message-State: AOAM530Ivs0ggOXPGPzpsuCVEenbt4b79PlDBvTe1DNlIOLxVSz8MKyN
 mbPDdR1tAoKcB5IVHmhQwFf/DZT7zVBJgdvyedK7Ww==
X-Google-Smtp-Source: ABdhPJwLLr7HE/FPtCzHw8vOCiRi6L3hhZDdCNDFos3jTHmz5rAH077nWm3ycDUwLoEjDXEKNGh/LvplLh9wMECNwRg=
X-Received: by 2002:aca:be0b:: with SMTP id o11mr575501oif.42.1612214578188;
 Mon, 01 Feb 2021 13:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
 <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com>
 <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
In-Reply-To: <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
Date: Mon, 1 Feb 2021 13:22:45 -0800
Message-ID: <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
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
>
> And more importantly, this isn't thread safe: one CPU may be setting the
> device's dma alignment mask to 0 while another CPU is expecting it to be
> NVME_CTRL_PAGE_SIZE - 1.

 I was having trouble getting the OS booted when setting it once during
 initialization. However when I rebased to the latest rc6 this morning it
 seems to be working with setting the mask on probe. I am still testing out
 and will appreciate any idea what may cause the nvme driver to fail
 with a single mask.
-- 
Jianxiong Gao
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
