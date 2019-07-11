Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65223C71142
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:50:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38227208E4
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wwR+A8Nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38227208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ECA5A548A;
	Thu, 11 Jul 2019 17:50:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EAFEE5485
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:39:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 964D9893
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:39:36 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
	[209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 4AA522166E
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562866776;
	bh=hugYgSrexBh5gjgXuDomklK72XYyZ8cT4nX0Qebg6ko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=wwR+A8NwWuDqr0JLLmsZL69uAwnfAQoNHYU4skeudiiubVvVaXt61l0BABrE0BkyF
	IHLHlJE1xdlF3ksKrp6jKvf3xezGxxoRLC5HsVKsujIL735fBzpihcLQj2knMAy2Tz
	QbxGn73Unfa4hIzIhENhFalum4Oss4FnkNoSJ58w=
Received: by mail-qt1-f178.google.com with SMTP id n11so5175711qtl.5
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 10:39:36 -0700 (PDT)
X-Gm-Message-State: APjAAAUYJ13w1xLBqWo3Ns+5i1xsrVlkMWmRfXcKUzk4nze8f2abTKVL
	FL7o1Aa8wCuX3ATBaAbq7wbWJtFvaslghP42+g==
X-Google-Smtp-Source: APXvYqyT2ZIwbJfQnc73mMGcKaDkblCm8BU7qO69rHW7ICOYosjRSUIAZS+oSsH0oZmtAhPdnjtyfqtcO0OJGH5XABE=
X-Received: by 2002:ac8:36b9:: with SMTP id a54mr2812702qtc.300.1562866775522; 
	Thu, 11 Jul 2019 10:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190710223119.8151-1-robh@kernel.org>
	<20190711102303.pnvy4zlitusjjku7@willie-the-truck>
In-Reply-To: <20190711102303.pnvy4zlitusjjku7@willie-the-truck>
From: Rob Herring <robh@kernel.org>
Date: Thu, 11 Jul 2019 11:39:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6W-fFqNr9m1zQOdERjZ5v9EpVLTVyChevHKYFU4j4Jg@mail.gmail.com>
Message-ID: <CAL_JsqJ6W-fFqNr9m1zQOdERjZ5v9EpVLTVyChevHKYFU4j4Jg@mail.gmail.com>
Subject: Re: [RFC PATCH] iommu: io-pgtable: Drop WARN for empty PTEs on unmap
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, Jul 11, 2019 at 4:23 AM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Jul 10, 2019 at 04:31:19PM -0600, Rob Herring wrote:
> > If a region has been mapped sparsely (such as on page faults), the user
> > has to keep track of what was mapped or not in order to avoid warnings
> > when unmapping the entire region. Remove the WARN on empty PTEs to allow
> > unmapping sparsely mapped regions.
> >
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: iommu@lists.linux-foundation.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > This is needed for large (up to 1GB AIUI) scratch buffers on panfrost
> > which are mapped on demand on GPU page faults and can be unmapped on
> > memory pressure. Alternatively, I'd need to have a bitmap of mapped
> > pages to track what is mapped or not. Dropping the WARN seems like a
> > much simpler solution.
>
> I suppose an alternative would be to do an iova_to_phys() before you do the
> unmap(). Would that be acceptable?

Yeah, that should work. Not that efficient, but I don't think
releasing the memory is hot path.

Thanks,
Rob

> The WARN_ON() indicates invalid usage by
> the IOMMU API, so it would be a shame to lose it entirely and I'm hesitant
> to continue adding quirks at the rate we're currently doing so!
>
> Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
