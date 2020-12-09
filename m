Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2BCC4361B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 19:23:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A40122C7B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 19:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A40122C7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2613B86ADB;
	Wed,  9 Dec 2020 19:23:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wxQhPgAZLrA5; Wed,  9 Dec 2020 19:23:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3CEDE86A36;
	Wed,  9 Dec 2020 19:23:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FFF9C0893;
	Wed,  9 Dec 2020 19:23:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DEBAC013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1216D87ABB
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:23:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r8sIuoEumGxI for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 19:23:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C705187AB2
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607541816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1JiCuAJtsnJo9IaenHy9QA62PZ6HCKOgtQt5HnnymsY=;
 b=Yyq4HwOJPLrjVO2o1Rmn3sTvS8F0B2b7fbntMrXbBUN6u+eMU+yak0KcJbCPmw7zvezWJO
 Rk51QoygsiOrKz6gZfIAkBkO3ASQHinT2xQEtUic0dwfqmlv7WGQ9NcniuwRm/6Wf194fH
 p7ymoXeBQKiydOisj10749JoJXUXeU0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-WMRrOsw8O46gPidgHgBiMw-1; Wed, 09 Dec 2020 14:23:35 -0500
X-MC-Unique: WMRrOsw8O46gPidgHgBiMw-1
Received: by mail-lj1-f200.google.com with SMTP id c8so1830341ljj.3
 for <iommu@lists.linux-foundation.org>; Wed, 09 Dec 2020 11:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1JiCuAJtsnJo9IaenHy9QA62PZ6HCKOgtQt5HnnymsY=;
 b=HGdbdp6cJzNzWExgaQPDBa08DKWfemSKFQeFld9zT/SfRFUI0qqhMjZW65DPz6fYek
 vTuEX3tb0A8/WFE2tyb36AqzLGApYUMUji+lnbWWB92uSYCH0MUfzlhFwfsIMwYIhT7l
 ONALy1rNtOQO3HnF5czU3FSfR1+pcwVRKCTdefHVhnbwVT7WDStmecV8U62Yi1MsvIot
 PJiqdctgXSLshCCkN0yEOITEgJsTXDCwk11FLUuVvSbm97bXCL6pByHjqQpIN2fl0QoS
 tnYVOoMivQodXZypbibVTxNMXt9y105jP8120mNVfsBx33msxk/5kgYhM7rGER9aUXeZ
 lFjA==
X-Gm-Message-State: AOAM532+BhKeXQt8yspHzdnk/aH4OtaCsbSVcdHQszVZkEYb8irenoCZ
 LX5WVb24gJQw3acsDk8fe1XxouorSjSMMrl+zoptOLKnSWOUDmAr9bT4Agp/JjKl2HAELpgeYeY
 LQM+A+2GFqenZOaz1NY4t6E60Wrrl6rTrTiGk6yyYZad3mQ==
X-Received: by 2002:a19:3c5:: with SMTP id 188mr1461086lfd.202.1607541812611; 
 Wed, 09 Dec 2020 11:23:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGoODFbEOcKQz/ScpB8oV7Mi7tniiV7k9AAEt8DGQLQC64ieiPFOacte5n9SNYVXZHhEFWrD/sl1+aaOWjS04=
X-Received: by 2002:a19:3c5:: with SMTP id 188mr1461076lfd.202.1607541812435; 
 Wed, 09 Dec 2020 11:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20201209141237.GA8092@willie-the-truck>
 <CAHk-=wht4inbTVVMt2TNDxR_cVjSNaBU3JYyKtRMVovWePb65g@mail.gmail.com>
 <20201209185020.GC8778@willie-the-truck> <87tusulrog.fsf@redhat.com>
 <CAHk-=wg370+69ZoXFdUABwwqNaej3hrjcqAsb56J++h2oXKJpg@mail.gmail.com>
In-Reply-To: <CAHk-=wg370+69ZoXFdUABwwqNaej3hrjcqAsb56J++h2oXKJpg@mail.gmail.com>
From: Jerry Snitselaar <jsnitsel@redhat.com>
Date: Wed, 9 Dec 2020 12:23:06 -0700
Message-ID: <CALzcddv8DfL67uZCEWK-d=uMFJD34=kaWEHVcHoXMvrStaoe2w@mail.gmail.com>
Subject: Re: [GIT PULL] IOMMU fix for 5.10 (-final)
To: Linus Torvalds <torvalds@linux-foundation.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Wed, Dec 9, 2020 at 12:18 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Dec 9, 2020 at 11:12 AM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
> >
> > Since the field in the device table entry format expects it to be n
> > where there are 2^n entries in the table I guess it should be:
> >
> > #define DTE_IRQ_TABLE_LEN 9
> > #define MAX_IRQS_PER_TABLE (1 << DTE_IRQ_TABLE_LEN)
>
> No, that "DTE_IRQ_TABLE_LEN" is not the size shift - it's the size
> shift value in that DTE field, which is shifted up by 1.
>
> That's why the current code does that
>
>    #define DTE_IRQ_TABLE_LEN       (9ULL << 1)
>
> there..
>
> Which was why I suggested that new #define that is the *actual* shift
> value, and then the DTE thing and the MAX_IRQS_PER_TABLE values would
> depend on that.
>
>            Linus
>

Yes, when I read it my head was translating it as setting them both to
512 and then
I forgot that it gets shifted over 1. Which considering I was the once
who noticed the
original problem  of it still being 8 was a nice brain fart. This
should be fixed like you suggest.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
