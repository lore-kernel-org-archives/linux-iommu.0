Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE3BC433FE
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 19:18:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44CCC23C90
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 19:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CCC23C90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9E8C1876CD;
	Wed,  9 Dec 2020 19:18:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yji1ysYoFCaP; Wed,  9 Dec 2020 19:18:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7DFAA87693;
	Wed,  9 Dec 2020 19:18:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68A98C0893;
	Wed,  9 Dec 2020 19:18:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD9B6C013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:18:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C4EB487693
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:18:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f02h2osrzyTN for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 19:18:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 01BD987684
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:18:15 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id f11so3744715ljm.8
 for <iommu@lists.linux-foundation.org>; Wed, 09 Dec 2020 11:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TOdxg1NYtVXt5G5UnjVeP8cr61+u8IQ69hUIDhx99vI=;
 b=Z9p/tmKsmOC83zvCFtHtvphx12PkgBTkQDx5VUQMHPKdW/yXt4ZVKmDtW3EHXknybH
 3ttqK6IydOkQMKlbM7Ps646F0xkUlhv/kD2h2saS2KzzTX0xNXxEMDzkP09sKpOOhv6G
 hQacjVksK2YnSqwF/GbSYU1xxowa8yAnv12pU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TOdxg1NYtVXt5G5UnjVeP8cr61+u8IQ69hUIDhx99vI=;
 b=inhWQaaFb4pA6ketLdgDfZv8nwnf3rsATE7idVPT/xL0iPPrhqbOe/Eh2nRC4AYBj8
 Wjn7q4FZb/iiuJQJf66kWHD6/iQPSFq5xBw8zhHZ63tYfdY8VNFC0fGVuXTRe80EcK06
 vFUt1E7m25Ss4biK7bdK36d6Yt94f3Ga1OgkDLZj4jFVeWK0RM926U1au+YV6oT3P7v6
 4XZnc/NUpTagrdHCsziHqvq9R7vTBx6FC2MzY2AheyxcT34lVjy0ARWObHrOEjQvkT8N
 5B53PwYvUkHhLpCFb87gJEuuwuxxNoqhxS0HRjtyBeXjEDutNz77LpPbFH1A6tpveNkU
 ofjA==
X-Gm-Message-State: AOAM530cNKRzzV0wHjUPliFtpXqzW2Hw8hgnyjj6bim+BVGVuco+pV49
 vBOpyUkdLboUNL3HYvXIA5/K9uyhaq+OKv+7
X-Google-Smtp-Source: ABdhPJwXUIawCrOazlxOYd7W+VziZvYNEXNk1FG3XUbSZGZvrTdp5O76V2YIGxgg7zcioUa7Y5uLlg==
X-Received: by 2002:a05:651c:1b2:: with SMTP id
 c18mr1633465ljn.385.1607541493655; 
 Wed, 09 Dec 2020 11:18:13 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id v28sm335586ljv.29.2020.12.09.11.18.12
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Dec 2020 11:18:12 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id y19so4600514lfa.13
 for <iommu@lists.linux-foundation.org>; Wed, 09 Dec 2020 11:18:12 -0800 (PST)
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr1412125lfi.377.1607541492434; 
 Wed, 09 Dec 2020 11:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20201209141237.GA8092@willie-the-truck>
 <CAHk-=wht4inbTVVMt2TNDxR_cVjSNaBU3JYyKtRMVovWePb65g@mail.gmail.com>
 <20201209185020.GC8778@willie-the-truck> <87tusulrog.fsf@redhat.com>
In-Reply-To: <87tusulrog.fsf@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Dec 2020 11:17:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg370+69ZoXFdUABwwqNaej3hrjcqAsb56J++h2oXKJpg@mail.gmail.com>
Message-ID: <CAHk-=wg370+69ZoXFdUABwwqNaej3hrjcqAsb56J++h2oXKJpg@mail.gmail.com>
Subject: Re: [GIT PULL] IOMMU fix for 5.10 (-final)
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>
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

On Wed, Dec 9, 2020 at 11:12 AM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
> Since the field in the device table entry format expects it to be n
> where there are 2^n entries in the table I guess it should be:
>
> #define DTE_IRQ_TABLE_LEN 9
> #define MAX_IRQS_PER_TABLE (1 << DTE_IRQ_TABLE_LEN)

No, that "DTE_IRQ_TABLE_LEN" is not the size shift - it's the size
shift value in that DTE field, which is shifted up by 1.

That's why the current code does that

   #define DTE_IRQ_TABLE_LEN       (9ULL << 1)

there..

Which was why I suggested that new #define that is the *actual* shift
value, and then the DTE thing and the MAX_IRQS_PER_TABLE values would
depend on that.

           Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
