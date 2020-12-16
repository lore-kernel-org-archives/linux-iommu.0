Return-Path: <SRS0=vTls=FU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C430EC1B0D8
	for <iommu@archiver.kernel.org>; Wed, 16 Dec 2020 22:22:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56477235FD
	for <iommu@archiver.kernel.org>; Wed, 16 Dec 2020 22:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56477235FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D2DAA852CB;
	Wed, 16 Dec 2020 22:22:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8smuhRMSs+5J; Wed, 16 Dec 2020 22:22:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 028D4850CF;
	Wed, 16 Dec 2020 22:22:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC1EAC088E;
	Wed, 16 Dec 2020 22:22:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E699C013B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 22:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5550C87204
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 22:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qMENYfMdysZ8 for <iommu@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 22:22:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D1B34871E0
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 22:22:13 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id m25so52348833lfc.11
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 14:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/v0hHuTQJANmvCHJQOT6cv+aYzklwaQBsw7a+SjqaAo=;
 b=Py++p8U61BKV5jezbYzGa5rfeT+dQm2cIzUuGb4r0JMdVqX1ojA8O+pRU+mKYywEyV
 a+CE1mT/C+ZVnAxn7nwMjoPp58+uu7IK+jXDueismZ2GvuLdTUn7IrhpsKsyOZWRLCKl
 o/rr8hG2wI46saGDp9+rsapwJDsoz8nogfugo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/v0hHuTQJANmvCHJQOT6cv+aYzklwaQBsw7a+SjqaAo=;
 b=KHQLz5Q/zv6VLI5XgUakXy60P86ZjfOdZj7a66sXdAVJi6rmX2j89ikvYaDlmv6brI
 BhjRx0mkipEUqtV+TS6YziZpY4rwSmpKFwGm7zniVJibTb3neradorxEIGN5aZZO/j+q
 sOoAMGyInu363V7Z5aNFZOemlYKQzzNIZ3/sFenlY5Gc1c8ddqeDwk91l1kEE/TRggAH
 VspL0HzBgA1RchXrvSp5FklwE84G1gmCfJ9tFp34yJemTYIwxQHsEx3M281yGSALlJ6q
 DjgVm9a+t7FhZdrbNwkhtVd2WeOJenoKvNrprT55O26G+SNb1HxnIdpsak7r+ot4BYcY
 Y0Jw==
X-Gm-Message-State: AOAM5311gljqe4uUC1ef7vXJq0BXZflSp/AxHgHUsiZaWX6YzzXut7TM
 iGQaEDjJDMTNq9BrkG4lQwfvOTNTgsq5RnU2
X-Google-Smtp-Source: ABdhPJwGab5D18OI4YpTuVePgRxvM9IqLQc0XnbRxCE4lENvG4Ox1GNE3pGPWCQuz0xGfnJoXh847w==
X-Received: by 2002:ac2:4437:: with SMTP id w23mr14429772lfl.618.1608157331531; 
 Wed, 16 Dec 2020 14:22:11 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com.
 [209.85.167.46])
 by smtp.gmail.com with ESMTPSA id o26sm429648ljg.55.2020.12.16.14.22.10
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Dec 2020 14:22:10 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id l11so52433175lfg.0
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 14:22:10 -0800 (PST)
X-Received: by 2002:a19:8557:: with SMTP id h84mr12893163lfd.201.1608157330146; 
 Wed, 16 Dec 2020 14:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20201214234518.GA14575@willie-the-truck>
 <20201216185352.GA16598@willie-the-truck>
 <CAHk-=wijH15u2KfpON3VCECQODAVNJ6DtgQajDaKo+PB_c-L3g@mail.gmail.com>
 <20201216221035.GA16915@willie-the-truck>
In-Reply-To: <20201216221035.GA16915@willie-the-truck>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 16 Dec 2020 14:21:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg33UY7U_bDpMDjQh7HrHEZrjiiug0R==iH_Gh6ZAySTg@mail.gmail.com>
Message-ID: <CAHk-=wg33UY7U_bDpMDjQh7HrHEZrjiiug0R==iH_Gh6ZAySTg@mail.gmail.com>
Subject: Re: [GIT PULL] IOMMU updates for 5.11
To: Will Deacon <will@kernel.org>
Cc: Android Kernel Team <kernel-team@android.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Dec 16, 2020 at 2:10 PM Will Deacon <will@kernel.org> wrote:
>
> Brill, cheers. I didn't realise you were going by subsystem, so that's
> why I was getting worried.

My "by subsystem" is a bit fuzzy, and it only really happens when I
have a _lot_ of pending pull requests. Which this merge window has had
more than most, since usually they come in a bit more spread out.

But when I have tens of pull requests in my mailbox, I tend to do them
by a very rough "similarity" metric, ie I'll generally bunch up
filesystem pulls together, but also pulls from the same person
together.

So it's not necessarily by any really strict subsystem thing, but you
can kind of see some patterns.

For example, today I started out with a group of audit and security
layer ones (and printk, which doesn't really group with much anything
else), then moved through virtualization platforms to some arch
updates, and then on to io_uring and block. Which got me to scsi and
rdma, and then iommu.

Not really much of a logical ordering really, more just me trying to
not be _entirely_ random.

But the grouping is definitely also about when things come in - I had
a different group of security layer and architecture updates on
Monday. The ones today hadn't come in yet at that point.

By tomorrow, my pending pile has hopefully shrunk so much that I do
things mainly by when they come in, rather than have a big pile and
trying to do them by some rough grouping.

           Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
