Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC95AC2B9F4
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 05:36:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353D6613E2
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 05:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353D6613E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EED3440563;
	Thu, 17 Jun 2021 05:36:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MhlZMEsnoQm1; Thu, 17 Jun 2021 05:36:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C21ED40150;
	Thu, 17 Jun 2021 05:36:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 913B5C000D;
	Thu, 17 Jun 2021 05:36:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3354DC000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 05:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1995C60752
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 05:36:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T9tao7rhsxuC for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 05:36:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gw.atmark-techno.com (gw.atmark-techno.com [13.115.124.170])
 by smtp3.osuosl.org (Postfix) with ESMTP id E650F6074B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 05:36:39 +0000 (UTC)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by gw.atmark-techno.com (Postfix) with ESMTPS id 50FC880453
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 14:36:38 +0900 (JST)
Received: by mail-pg1-f197.google.com with SMTP id
 m13-20020a633f0d0000b0290222ece48979so653741pga.1
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 22:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=r4K6MpRTPV0jY/7atoPTp6yk6TP7qhEuUGZiRkCr2zQ=;
 b=lTvS+DevfB5P8B/A3BoVyRPw4WIEpDgZRNqFHSyn7RVKUBxZzras7ieUzHsoX+xgqe
 znz5AKXBxBdhfeYKArVAEIAbbGEqssOxJY7JmhVk/IZ3s6EgteHsqQOvA+P6SedlJ2k0
 +pttE+fdBzmrFLLISrfOgfiTVrn9TxKyQrO1NI8SjQ3w2vUeXS87t/iMdQhczkYiKiT8
 QUnpVUqq6lH6DwzUPun8qCakn61m9yu0zTDP5MMHhz/8suwvRo8wn+3WQ78DFI6g2Jj+
 9dg4IDC95iRtBv83rdOdTBPVz6XtxzsA5nDKCnVDjawCC9Q281bY+8n5TtNQmxRZhlPO
 BqdA==
X-Gm-Message-State: AOAM531KkrkfONHdN5HarLgPGNX2pocUJuDpwSHRNrMeH9j4IthR0+JV
 EYT4m8LLS+tE8T8/lG2z+ClZLETTNqJ0vPIYRjVdl8Moht5ZWqa/Bdi5YJmDpM6aPX6NaR1+gcQ
 3K6pcz6dTaMbduZBBkWkrRJB9rg9dWyOA2A==
X-Received: by 2002:a17:90b:3696:: with SMTP id
 mj22mr3678205pjb.42.1623908197374; 
 Wed, 16 Jun 2021 22:36:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztIscCdlZzD+giyPAZOggDuCPdjDOLTlJ90UW2jHvI7/gp0XO7pZjbkYSBv6oX4Oss6ySEEA==
X-Received: by 2002:a17:90b:3696:: with SMTP id
 mj22mr3678172pjb.42.1623908197065; 
 Wed, 16 Jun 2021 22:36:37 -0700 (PDT)
Received: from pc-0115 (126.88.200.35.bc.googleusercontent.com.
 [35.200.88.126])
 by smtp.gmail.com with ESMTPSA id y27sm3846134pff.202.2021.06.16.22.36.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Jun 2021 22:36:36 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
 (envelope-from <martinet@pc-0115>)
 id 1ltkhe-00FfYs-Dp; Thu, 17 Jun 2021 14:36:34 +0900
Date: Thu, 17 Jun 2021 14:36:24 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
Message-ID: <YMrfWBLsJxCRhX5U@atmark-techno.com>
References: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local>
 <YL7XXNOnbaDgmTB9@atmark-techno.com>
 <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com>
 <20210611062153.GA30906@lst.de> <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
 <CAMGD6P1v2JoJoxSuAYL8UjdtCaLCc4K_7xzVkumspeb0qn=LBQ@mail.gmail.com>
 <YMqW+/gQvM+uWUTw@fedora> <YMqZswFnSNKk4Z7B@atmark-techno.com>
 <20210617051232.GB27192@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210617051232.GB27192@lst.de>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Orr <marcorr@google.com>,
 Lukas Hartmann <lukas@mntmn.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Peter Gonda <pgonda@google.com>, Konrad Rzeszutek Wilk <konrad@darnok.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Jianxiong Gao <jxgao@google.com>
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

Christoph Hellwig wrote on Thu, Jun 17, 2021 at 07:12:32AM +0200:
> On Thu, Jun 17, 2021 at 09:39:15AM +0900, Dominique MARTINET wrote:
> > Konrad Rzeszutek Wilk wrote on Wed, Jun 16, 2021 at 08:27:39PM -0400:
> > > Thank you for testing that - and this is a bummer indeed.
> > 
> > Hm, actually not that surprising if it was working without the offset
> > adjustments and doing non-aligned mappings -- perhaps the nvme code just
> > needs to round the offsets down instead of expecting swiotlb to do it?
> 
> It can't.  The whole point of the series was to keep the original offsets.

Right, now I'm reading this again there are two kind of offsets (quoting
code from today's master)
---
static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
                           enum dma_data_direction dir)
{
        struct io_tlb_mem *mem = io_tlb_default_mem;
        int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
        phys_addr_t orig_addr = mem->slots[index].orig_addr;
---

There is:
 - (tlb_addr - mem->start) alignment that Linus added up
 - mem->slots[index].orig_addr alignment (within IO_TLB_SIZE blocks)


I would assume that series made it possible to preserve offsets within a
block for orig_addr, but in the process broke the offsets of a bounce
within an memory slot (the first one) ; I assume we want to restore here
the offset within the IO_TLB_SIZE block in orig_addr so it needs another
offseting of that orig_addr offset e.g. taking a block and offsets
within blocks, we have at the start of function:

 |-----------------|-------------------|--------------------------|
 ^                 ^                   ^
 block start       slot orig addr      tlb_addr

and want the orig_addr variable to align with tlb_addr.


So I was a bit hasty in saying nvme needs to remove offsets, it's more
that current code only has the second one working while the quick fix
breaks the second one in the process of fixing the first...



Jianxiong Gao, before spending more time on this, could you also try
Chanho Park's patch?
https://lore.kernel.org/linux-iommu/20210510091816.GA2084@lst.de/T/#m0d0df6490350a08dcc24c9086c8edc165b402d6f

I frankly don't understand many details of that code at this point,
in particular I have no idea why or if the patch needs another offset
with mem->start or where the dma_get_min_align_mask(dev) comes from,
but it'll be interesting to test.


Thanks,
-- 
Dominique
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
