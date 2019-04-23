Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95007C10F03
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 15:16:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F86920685
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 15:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F86920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 306A5B8F;
	Tue, 23 Apr 2019 15:16:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2C0EDB5F
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 15:16:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com
	[209.85.217.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B5E8982B
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 15:16:20 +0000 (UTC)
Received: by mail-vs1-f65.google.com with SMTP id f22so8485074vso.7
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 08:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=5//6GxCMGJXBkcHJiA/F/s2ofx67rR4WEXlIKHqZL74=;
	b=oriCPt2QIJ46gzIxp5yCZcPzn+lPpO/RU7rOnc8Q+q1hj3YEA+VDGyG3qs+pccQBlC
	TIKWXt8KtMsTgrFfNlNdY18DlkWiQnsvXBkYDVKAE8p7oKjTh/EW2YjxDhGZ53k2SmCZ
	KjW1wSnsaJbZMjGOgrb/iScYFmJDZDvadlnJDKQuAVkt9+DruYo8ii0RifgQ8HaUjOVo
	vPCeCufLmcQvBOPgpHpSBbtZiBctFh6a/gB6XmeWS5jUpucRUkNe82UOBnNRdj5FtX8b
	L1CKECGfdhaMLM4G5El5BzbS6i/vwKsFRqZPCZ+aswmQZeaXvtiKj9jIUdpmwgGJ10Je
	ZnlA==
X-Gm-Message-State: APjAAAVseG0HyknzKCvd/hcXKJvmd6ZHjpPbak9XpJPdIQOZ6qG02wrd
	X2vLy/UoDboRhGN8wCkCQYU8cVhFb4GGTMcNfNw=
X-Google-Smtp-Source: APXvYqzuA6uuoZKLf7AbIB3uGMNyZDKDBdafvUoSNNMldjS+c4YMyifWr3MrDhdZlGLJS6sl4dUIijh7FINKVRNACLs=
X-Received: by 2002:a67:8317:: with SMTP id f23mr13103887vsd.63.1556032579395; 
	Tue, 23 Apr 2019 08:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190403182148.18058-1-geert+renesas@glider.be>
	<20190403182148.18058-7-geert+renesas@glider.be>
	<20190411083905.fpeicn5ia3ghbphe@verge.net.au>
In-Reply-To: <20190411083905.fpeicn5ia3ghbphe@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Apr 2019 17:16:08 +0200
Message-ID:
 <CAMuHMdVKr=gbMJzvxe-wRbWxWt8TM8TrVauB8eYaGMz45Ko67w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] iommu/ipmmu-vmsa: Add suspend/resume support
To: Simon Horman <horms@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <damm+renesas@opensource.se>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190423151608.uJSuKvEhsa3LRWaKhw_J8J3MHYYjE8voZvzMwu8XE0s@z>

Hi Simon,

On Thu, Apr 11, 2019 at 10:39 AM Simon Horman <horms@verge.net.au> wrote:
> On Wed, Apr 03, 2019 at 08:21:48PM +0200, Geert Uytterhoeven wrote:
> > During PSCI system suspend, R-Car Gen3 SoCs are powered down, and all
> > IPMMU state is lost.  Hence after s2ram, devices wired behind an IPMMU,
> > and configured to use it, will see their DMA operations hang.
> >
> > To fix this, restore all IPMMU contexts, and re-enable all active
> > micro-TLBs during system resume.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > This patch takes a different approach than the BSP, which implements a
> > bulk save/restore of all registers during system suspend/resume.
> >
> > v2:
> >   - Drop PSCI checks.
> > ---
> >  drivers/iommu/ipmmu-vmsa.c | 47 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 46 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index 56e84bcc9532e1ce..408ad0b2591925e0 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -36,7 +36,10 @@
> >  #define arm_iommu_detach_device(...) do {} while (0)
> >  #endif
> >
> > -#define IPMMU_CTX_MAX 8U
> > +#define IPMMU_CTX_MAX                8U
> > +#define IPMMU_CTX_INVALID    -1
> > +
> > +#define IPMMU_UTLB_MAX               48U
> >
> >  struct ipmmu_features {
> >       bool use_ns_alias_offset;
> > @@ -58,6 +61,7 @@ struct ipmmu_vmsa_device {
> >       spinlock_t lock;                        /* Protects ctx and domains[] */
> >       DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
> >       struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
>
> It might be possible to save a bit of memory on Gen 2 systems by
> making IPMMU_UTLB_MAX 32 when the driver is compiled for such systems.

This comment applies to the line below, right?

> > +     s8 utlb_ctx[IPMMU_UTLB_MAX];

So it's just 16 bytes, not 16 pointers.

Doing so would reduce struct ipmmu_vmsa_device from 148 to 132 bytes.
Given that structure is allocated by devm_kzalloc(), and devres alignment
was increased in commit a66d972465d15b1d ("devres: Align data[] to
ARCH_KMALLOC_MINALIGN"), I guess it won't make a difference.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
