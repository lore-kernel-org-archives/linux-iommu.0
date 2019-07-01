Return-Path: <SRS0=o8L7=U6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10152C0650E
	for <iommu@archiver.kernel.org>; Mon,  1 Jul 2019 18:07:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E004021479
	for <iommu@archiver.kernel.org>; Mon,  1 Jul 2019 18:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+mTkh6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E004021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 79B7D3642;
	Mon,  1 Jul 2019 18:07:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DF179277D
	for <iommu@lists.linux-foundation.org>;
	Mon,  1 Jul 2019 18:07:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com
	[209.85.221.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6FADD782
	for <iommu@lists.linux-foundation.org>;
	Mon,  1 Jul 2019 18:07:36 +0000 (UTC)
Received: by mail-vk1-f195.google.com with SMTP id b64so2881581vke.13
	for <iommu@lists.linux-foundation.org>;
	Mon, 01 Jul 2019 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=lWONYKiUC+xNG+v0x99Ltv7YhSq18V7iywQoniSnrLY=;
	b=B+mTkh6VPC/HVnQ/2aPY6tcq2AbxaF1Ieqvp+5l4ijk9/nrIuBAJwhSsYqD/Lkik4W
	x+k4pLd8gMGKtMhht3Fll8Z+BbzMOMLQb/FqBjxPYlLYt2xkivfIRECPwxqWvzkYSwms
	q78SVjZsa2BdoiPBS9C0KhLfSN7Sh4cMPnid6WAwR0eh962wv/tCSUypcmIQJbluwuBd
	pqNgcsOw/e/yvw1i7IGN1XsbMx3m2art1A/7FZf8nLPSrCuoPP/PtgwZ2stipavisg9I
	t2MwBx7coZG+aEcR35I2h4h1t/ZprqqwTewkKoYWgFEBsg6qwTAj0pnUZtGPsqbMR/tb
	PXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=lWONYKiUC+xNG+v0x99Ltv7YhSq18V7iywQoniSnrLY=;
	b=OcX15v94BwGuZxaOeQ5M8baP3GkJ0lo444x+Zu9n5Oat/J168iVfjC7+nc2h+JvsFB
	yToPeXcM20nKB80Yp47poe3CJe+KAvOLStnHLd0VLxqmhO418VyWGTG8bS/GkeoOU2TX
	o60pB3LbBLl/l0QDxhPnrL+sHQixNyxT7PehN+nqV742AvwBmQuEUEZ1uH6aOOe3bK4h
	Tcg7DBv8U7WlwhO44QsMeTwFZB4FIM8R1+sd0H196VijQO7IYZfSbXCHyHv/HbqYkWLb
	FpgBZY2JKQo/2/GXf3TPksOZ9tgGgN7dmTY57nmlbIHltFmg2xHxxmtXBRfd8u1vf7Ph
	+sUA==
X-Gm-Message-State: APjAAAV48eYXy2yeZ6nclTB75qD0mqMiof6p/iot5DiVCVUvPSjgx9Ai
	fxNnG0EaB1QWBCxVtq7QipF0LeI2JglhW9VJtf4=
X-Google-Smtp-Source: APXvYqwRJwKQv7q3x+bK0rhEHYsq3B5RUxQ/uPaJ6fmEtHv4AFhRjDw9aFEkw+axhgsNwnA0UOwULvb0Zrsqeu6li5Q=
X-Received: by 2002:a1f:2896:: with SMTP id o144mr3222112vko.73.1562004455408; 
	Mon, 01 Jul 2019 11:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <CACDBo564RoWpi8y2pOxoddnn0s3f3sA-fmNxpiXuxebV5TFBJA@mail.gmail.com>
	<CACDBo55GfomD4yAJ1qaOvdm8EQaD-28=etsRHb39goh+5VAeqw@mail.gmail.com>
	<20190626175131.GA17250@infradead.org>
	<CACDBo56fNVxVyNEGtKM+2R0X7DyZrrHMQr6Yw4NwJ6USjD5Png@mail.gmail.com>
	<c9fe4253-5698-a226-c643-32a21df8520a@arm.com>
	<CACDBo57CcYQmNrsTdMbax27nbLyeMQu4kfKZOzNczNcnde9g3Q@mail.gmail.com>
	<0725b9aa-0523-daef-b4ff-7e2dd910cf3c@arm.com>
In-Reply-To: <0725b9aa-0523-daef-b4ff-7e2dd910cf3c@arm.com>
From: Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Date: Mon, 1 Jul 2019 23:37:24 +0530
Message-ID: <CACDBo56taTYwSvzH9ZPbTzPM6gMzknki94QsAoo+oNkyCLkTMA@mail.gmail.com>
Subject: Re: DMA-API attr - DMA_ATTR_NO_KERNEL_MAPPING
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
	linux-mm@kvack.org, iommu@lists.linux-foundation.org,
	Vlastimil Babka <vbabka@suse.cz>
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

On Mon, Jul 1, 2019 at 11:24 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 01/07/2019 18:47, Pankaj Suryawanshi wrote:
> >> If you want a kernel mapping, *don't* explicitly request not to have a
> >> kernel mapping in the first place. It's that simple.
> >>
> >
> > Do you mean do not use dma-api ? because if i used dma-api it will give you
> > mapped virtual address.
> > or i have to use directly cma_alloc() in my driver. // if i used this
> > approach i need to reserved more vmalloc area.
>
> No, I mean just call dma_alloc_attrs() normally *without* adding the
> DMA_ATTR_NO_KERNEL_MAPPING flag. That flag means "I never ever want to
> make CPU accesses to this buffer from the kernel" - that is clearly not
> the case for your code, so it is utterly nonsensical to still pass the
> flag but try to hack around it later.


Actually my use case is that i want virtual mapping only when i will
play video as my vpu/gpu driver is design like that.
and  i am using 32-bit so virtual memory is splitted as 3G/1G so dont
have enough memory for all the time to mapped with kernel space.

Lets say i am allocating 400MB for driver but i want only 30MB for
virtual mapping (not everytime) that is the case.
>
>
> Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
