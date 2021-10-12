Return-Path: <SRS0=nyYM=PA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4518C433F5
	for <iommu@archiver.kernel.org>; Tue, 12 Oct 2021 08:01:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C9160F23
	for <iommu@archiver.kernel.org>; Tue, 12 Oct 2021 08:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48C9160F23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 092CE80E24;
	Tue, 12 Oct 2021 08:01:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UlwocEgddsSO; Tue, 12 Oct 2021 08:01:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ACD9580DF6;
	Tue, 12 Oct 2021 08:01:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8558EC0011;
	Tue, 12 Oct 2021 08:01:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7A9EC000D
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 08:01:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 978624027A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 08:01:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jnf1pqkAh3M3 for <iommu@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 08:01:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F1E0C40277
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 08:01:02 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id g8so77763562edt.7
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 01:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KfJZrcgRfPAygYP1cdVoz79nAFWF3P3lNeyc+uUIYy0=;
 b=2GavBjqfc+oauQ9xOAv56VtYHUSnaWMHkv3yliYOgbjt48jD3qN80dyj86rTmA5k4f
 K7rG4wq2/4PxHHkgurfbM+NLG0HbLsoHzGt3xS7DmUoKpgU9EuL/xptkDo9n2DqOl45m
 QmkwQPSDs9xEIuSnRiV00CtEm/tWfambYn38xUMR+41TOdUMUnL2qgZ27M/2dEQ2dzIM
 ovVxoXoX2lR+TCCLcNYigt7Rp2sji6rRSlD81bICT0h+ax6v2W/dWTezPVrirYHUKVRA
 lC53GgSbTN7E5wj7rGQBSJXy5SJQIyZSuZdx/nkilhum2cM4blcO5YdPTDe8N11l2xEX
 Ir/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KfJZrcgRfPAygYP1cdVoz79nAFWF3P3lNeyc+uUIYy0=;
 b=P7SPP+odMqgz6QSR1pAHJ8OOhTon3C45qq8OEQxHZLgxdlkzMHneAEN/xnwhlCDRNc
 e+3qUVKrV8x54AYgKEng512D9OX+4TCkF2h/wuRGQBZ6jQBhZakzC9zCpT0sRIwBvY2G
 Yw8YokbG7fTJ0//dj1iTEVrpY6rNQR7RI3Jn0FhS6HVkjzQN0ZDljc3VnFYH2a3xjMPG
 DurkP+16tmFSxlYDhuiKvGLoqCsRexxGDoZFqRB+Yqs964XFkaNPAWWRVqPItr1/fVe1
 jplexprQntAirkSl/H2b4EZyrIM3EY1hNSrTqOk4Q+4CNe9oZvWy5lFknFwWzssgogDR
 M/jQ==
X-Gm-Message-State: AOAM5334PVHTeS1hfWrcksfYgCc5bY05p5YDddr5R9AIK46fIDvdXBw0
 U+c40PlolRQ3B1iOc23iGVq0R/4ldII4Th+ENpwinw==
X-Google-Smtp-Source: ABdhPJyjgryazzbSrVkxnCARQE8G78mXqDfLQsroBl7jBnOTY8o6Kw5ZQHxSm1C864LdjD10IKOkyEedslIu0pOhgsA=
X-Received: by 2002:a17:906:52d6:: with SMTP id
 w22mr28980498ejn.248.1634025661043; 
 Tue, 12 Oct 2021 01:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <e24df2a9-1332-0eb3-b52a-230662fe46ba@arm.com>
 <CABdtJHvY5XnQN7wgQ9D8Zcu-NgHRmaUMFPgaPGZwM+AhmVpULw@mail.gmail.com>
 <3225875e-ebd9-6378-e92c-ed3894d8aedc@arm.com>
In-Reply-To: <3225875e-ebd9-6378-e92c-ed3894d8aedc@arm.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Tue, 12 Oct 2021 10:00:24 +0200
Message-ID: <CABdtJHsOShKrRMp33JvbVKuTMLEcHQKaDw0wtZ0igoeGeWJTQg@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
To: Robin Murphy <robin.murphy@arm.com>
Cc: Linuxarm <linuxarm@huawei.com>, Steven Price <steven.price@arm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>, Sami Mujawar <Sami.Mujawar@arm.com>,
 Will Deacon <will@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Mon, Oct 11, 2021 at 4:04 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-10-09 08:06, Jon Nettleton wrote:
> [...]
> >>> +             if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED) {
> >>> +                     type = IOMMU_RESV_DIRECT_RELAXABLE;
> >>> +                     /*
> >>> +                      * Set IOMMU_CACHE as IOMMU_RESV_DIRECT_RELAXABLE is
> >>> +                      * normally used for allocated system memory that is
> >>> +                      * then used for device specific reserved regions.
> >>> +                      */
> >>> +                     prot |= IOMMU_CACHE;
> >>> +             } else {
> >>> +                     type = IOMMU_RESV_DIRECT;
> >>> +                     /*
> >>> +                      * Set IOMMU_MMIO as IOMMU_RESV_DIRECT is normally used
> >>> +                      * for device memory like MSI doorbell.
> >>> +                      */
> >>> +                     prot |= IOMMU_MMIO;
> >>> +             }
> >>
> >> I'm not sure we ever got a definitive answer to this - does DPAA2
> >> actually go wrong if we use IOMMU_MMIO here? I'd still much prefer to
> >> make the fewest possible assumptions, since at this point it's basically
> >> just a stop-gap until we can fix the spec. It's become clear that we
> >> can't reliably rely on guessing attributes, so I'm not too fussed about
> >> theoretical cases that currently don't work (due to complete lack of RMR
> >> support) continuing to not work for the moment, as long as we can make
> >> the real-world cases we actually have work at all. Anything which only
> >> affects performance I'd rather leave until firmware can tell us what to do.
> >
> > Well it isn't DPAA2, it is FSL_MC_BUS that fails with IOMMU_MMIO
> > mappings.  DPAA2 is just one connected device.
>
> Apologies if I'm being overly loose with terminology there - my point of
> reference for this hardware is documentation for the old LS2080A, where
> the "DPAA2 Reference Manual" gives a strong impression that the MC is a
> component belonging to the overall DPAA2 architecture. Either way it
> technically stands to reason that the other DPAA2 components would only
> be usable if the MC itself works (unless I've been holding a major
> misconception about that for years as well).
>
> In the context of this discussion, please consider any reference I may
> make to bits of NXP's hardware to be shorthand for "the thing for which
> NXP have a vested interest in IORT RMRs".

Ultimately the spec doesn't mention what IOMMU properties the regions
should have.  Even marking them as IOMMU_READ/WRITE is as much
of an assumption as using IOMMU_MMIO or IOMMU_CACHE. It just seems
IOMMU_MMIO is the most popular since all the examples use it for MSI
doorbells in the documentation.

I am interested why this concern is only being brought up at this point
in a patchset that has been on the mailing list for 8+ months?  This is
based on a spec that has existed from Arm since 2020 with the most recent
revisions published in Feb 2021.  The lack of RMR support in the kernel
is affecting real world products, and the ability for SystemReady ES
certified systems from just fully working with recent distributions.  Even
worse, is that without this patchset customers are forced to jump through
hoops to purposefully re-enable smmu bypass making their systems less
secure.

How is this a good experience for customers of SystemReady hardware
when for any mainline distribution to work the first thing they have to do is
make their system less secure?

-Jon

>
> Thanks,
> Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
