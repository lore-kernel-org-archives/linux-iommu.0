Return-Path: <SRS0=vHAQ=BX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45893C433DF
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 19:03:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12982206B2
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 19:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D+KqO8Dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12982206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BB7018723E;
	Thu, 13 Aug 2020 19:03:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u15BFDGmC9es; Thu, 13 Aug 2020 19:03:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4374A87209;
	Thu, 13 Aug 2020 19:03:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32B56C013C;
	Thu, 13 Aug 2020 19:03:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BEEEC004D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 19:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 244E12575D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 19:03:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1QEH7AhFOPKT for <iommu@lists.linux-foundation.org>;
 Thu, 13 Aug 2020 19:03:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 424882075B
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 19:03:02 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id x24so3581017lfe.11
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=exAlskjzIFOE1QMe0saylZOMoEP4iKWyM0PCmNmV2iE=;
 b=D+KqO8DxYbapI0GwZR2nNjGv6dp+d+eVYzQHwg5OMjCbe3Q6SGne/SURb84sC+W4Bf
 WlFabSyY/QeiyaXTbQEFykeACFf5RZkc3ed28jFSDCVYw1jr/QDpijkI6yyaYHoDWcFI
 MCFoMmJ6MPdGoGJ2OI3Xt9c/mIbtsjp3OvXv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=exAlskjzIFOE1QMe0saylZOMoEP4iKWyM0PCmNmV2iE=;
 b=rGvuy3KaXnNMaREnvetk+tLrk9FYoRvBuutigHBvnWtcSbuzH2zfEWj4Q7AfVxxmp0
 HyA+KuIjtCPR7WOWMGmluvvY/cLIcH5IrGYvYJhO+iGffA3VauPzbKCG223W+Ipsq/21
 IMSwUnVCzKTznU0FjY/jR2KoYE8Y7N2ow8QG1Sxn03CaNitplhfPDE5fk/KG6Sct6yr8
 f1T2Ae357xac+Uc92Pd+s7qrFJwxoXUEQ2EAF3aEMsTLukuyiNOUv+2sXc1G3R8NRqrv
 QTn6X3g3P0rolU9S9YW5VTf+rqzdMbRjQtG8XtoHCDTUFUzkBA5NsOznAZWVtzCmgD2l
 EmzQ==
X-Gm-Message-State: AOAM530ji0JNCFNk6mklg7g8Uz/fLUTNk8/KbNFs/LbFnGhIOla+F5bj
 TSXOgWxzgQJiGnDv4JckbCP3+msiUccAOQ==
X-Google-Smtp-Source: ABdhPJw3dHukqhloHIEAuVBnOlRV2Umsfg7OgWJlDz2yZkNRddIs2F/UbfU0PDEpDfwfaPrDMp9Kkw==
X-Received: by 2002:a19:c752:: with SMTP id x79mr2776288lff.197.1597345379561; 
 Thu, 13 Aug 2020 12:02:59 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com.
 [209.85.208.182])
 by smtp.gmail.com with ESMTPSA id q189sm1259704ljq.68.2020.08.13.12.02.58
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 12:02:58 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 185so7359481ljj.7
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 12:02:58 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr2566294lji.314.1597345377681; 
 Thu, 13 Aug 2020 12:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008122005240.11996@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008122005240.11996@eggly.anvils>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Aug 2020 12:02:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYLHtbeF6BFmoiik9PTjP2+pnpWxXLE9f0ccnT0LAd5A@mail.gmail.com>
Message-ID: <CAHk-=whYLHtbeF6BFmoiik9PTjP2+pnpWxXLE9f0ccnT0LAd5A@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: fix debug_dma_assert_idle(),
 use rcu_read_lock()
To: Hugh Dickins <hughd@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>, Christoph Hellwig <hch@lst.de>,
 Linux-MM <linux-mm@kvack.org>, iommu <iommu@lists.linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>
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

On Wed, Aug 12, 2020 at 8:17 PM Hugh Dickins <hughd@google.com> wrote:
>
> Since commit 2a9127fcf229 ("mm: rewrite wait_on_page_bit_common() logic")
> improved unlock_page(), it has become more noticeable how cow_user_page()
> in a kernel with CONFIG_DMA_API_DEBUG=y can create and suffer from heavy
> contention on DMA debug's radix_lock in debug_dma_assert_idle().

Ooh.

Yeah, that's ridiculously expensive, and serializes things for no good reason.

Your patch looks obviously correct to me (Christoph?), but it also
makes me go "why are we doing this in the first place"?

Because it looks to me like
 (a) the debug check is wrong
 (b) this is left-over from early debugging

In particular, I don't see why we couldn't do a COW on a page that is
under writeback at the same time. We're not changing the page that is
doing DMA.

In fact, the whole "COW with DMA" makes me feel like the real bug may
have been due that whole "ambiguous COW" thing, which was fixed in
17839856fd58 ("gup: document and work around "COW can break either
way" issue")

That debug thing goes back almost 7 years, and I don't think it has
caught anything in those seven years, but I could be wrong.

The commit that adds it does talk about a bug, but that code was
removed entirely eventually. And google shows no hits for
debug_dma_assert_idle() since - until your email.

So my gut feel is that we should remove the check entirely, although
your patch does seem like a big improvement.

Christoph?

(And Dan too, of course, in case he happens to be relaxing in front of
the computer away from a newborn baby ;)

               Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
