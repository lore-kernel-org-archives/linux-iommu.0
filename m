Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7EDC433DB
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 17:46:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59F22076E
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 17:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59F22076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9D0758671B;
	Thu,  7 Jan 2021 17:46:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LfvnNpe2nN0i; Thu,  7 Jan 2021 17:46:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 044E3866EA;
	Thu,  7 Jan 2021 17:46:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF61EC0891;
	Thu,  7 Jan 2021 17:46:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86D64C013A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 17:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 724A48671B
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 17:46:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FuPM1sc0SfKJ for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 17:46:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D5857866EA
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 17:46:28 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id m6so4308845pfm.6
 for <iommu@lists.linux-foundation.org>; Thu, 07 Jan 2021 09:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BpWY74vWVa1L8Raewx13V4/TopbXG6j16e2kYWK8TMo=;
 b=RjsCv0SB3G2nr2VhqjbT5oDz8W7DNBKHdnzTnNqkj1iJof0+bV7fP3DrwRkndy/u4k
 Ygt4ObgL6c6fDwINAZBbrt6q9Nyu03KM8Jtf+6CaIHJDQhHurg1bvBaIn5xYb5DYi3P3
 O7pPyZUh0Fpetb+g793rmuwtHVk+BC0HuhiVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BpWY74vWVa1L8Raewx13V4/TopbXG6j16e2kYWK8TMo=;
 b=XDtijaHBEf2pnKsCF9dHKxtFJJlG/mGl8rEnpxoHTBuqVy3J4M7d4wdVl8Xyn7+t8M
 C8UnkbiRTxqSbQBTbaD1S9U+unIAPV7ilzqOLMn750tTyDF54NRtOE+mrf4SpSMcRt4M
 8Y8M2eYt3kKKDHHbEcYXXNXkkJjc+xRrHBt7cYhQi+ATX2cv+8EWXkN4CreaHbc/sxs1
 9TYMaxTozAnnvsFg6ZI0r2baNAHrng7Zwf6U0NKL6ZQIMFMbtr3iKGILlChqwUIXJWTY
 +18027CNl3LfdlzsW/1fFXDyUkgmwfqSHTU1tqp+MFimsOTJw8OtZ8SrAD3BYZvBTyZ/
 9WBA==
X-Gm-Message-State: AOAM532pPCvhL1+b+SZoxPkOFJc10K6hrU3mElOcErsGxgb1tOJT7XLe
 7XoLFeu3cB83XwoUy4NKHC1bh9qAca6bZ0ws
X-Google-Smtp-Source: ABdhPJyZXcfinJl2fvGcG0Lg8inT1I9T48Ja/fkoKA1Uv5Aek2Ra4ZsRVUNmZL5lKMIdSTsUOqBjHg==
X-Received: by 2002:aa7:9e43:0:b029:19c:d0ab:2684 with SMTP id
 z3-20020aa79e430000b029019cd0ab2684mr9764594pfq.42.1610041588183; 
 Thu, 07 Jan 2021 09:46:28 -0800 (PST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com.
 [209.85.215.170])
 by smtp.gmail.com with ESMTPSA id x21sm7392897pgi.75.2021.01.07.09.46.27
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Jan 2021 09:46:27 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id i5so5463554pgo.1
 for <iommu@lists.linux-foundation.org>; Thu, 07 Jan 2021 09:46:27 -0800 (PST)
X-Received: by 2002:a92:c206:: with SMTP id j6mr9799328ilo.189.1610041168940; 
 Thu, 07 Jan 2021 09:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-3-tientzu@chromium.org>
 <20210106185241.GA109735@localhost.localdomain>
In-Reply-To: <20210106185241.GA109735@localhost.localdomain>
From: Claire Chang <tientzu@chromium.org>
Date: Fri, 8 Jan 2021 01:39:18 +0800
X-Gmail-Original-Message-ID: <CALiNf2-HDf6tFcvVgCttr-ta=88ZMH=OvB5XoryTPc6MNvwV+Q@mail.gmail.com>
Message-ID: <CALiNf2-HDf6tFcvVgCttr-ta=88ZMH=OvB5XoryTPc6MNvwV+Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, rafael.j.wysocki@intel.com, Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, will@kernel.org,
 dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 rdunlap@infradead.org, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 xypron.glpk@gmx.de, Robin Murphy <robin.murphy@arm.com>
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

Hi Greg and Konrad,

This change is intended to be non-arch specific. Any arch that lacks DMA access
control and has devices not behind an IOMMU can make use of it. Could you share
why you think this should be arch specific?

Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
