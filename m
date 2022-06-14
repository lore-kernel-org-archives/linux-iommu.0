Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0877C43334
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 01:54:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A8CD4157D;
	Tue, 14 Jun 2022 01:54:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fw5wVsgCyC10; Tue, 14 Jun 2022 01:54:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0D71041551;
	Tue, 14 Jun 2022 01:54:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9B13C0039;
	Tue, 14 Jun 2022 01:54:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F0E2C002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 01:54:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2959760C0F
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 01:54:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BorhgYj-zKLe for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 01:54:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4672060AB0
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 01:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655171684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/D2zV8uYgr3E+2jnjqTkdGXtDdtpkC+Fc4LAvZ9Wl80=;
 b=EJJu5z0WBOm8F8LaS7D7+th9jdlPUdShrywsWZ5tBpTeQjS06h2gRvG4sK/7uYXWiYf1yZ
 /gnZ0tbQhtg6Z60aKErZCr/S/B8R/3HonSTfKaAaFbMQ9xWJ7vUwmYdEbv0vnUhKgDjIQN
 egU0S+njAB/MztnRvTwua2muFGGOmng=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-rDsRf83NOGagXe9F3z8bKw-1; Mon, 13 Jun 2022 21:54:43 -0400
X-MC-Unique: rDsRf83NOGagXe9F3z8bKw-1
Received: by mail-io1-f69.google.com with SMTP id
 r76-20020a6b2b4f000000b00669b75529e5so3583579ior.16
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 18:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/D2zV8uYgr3E+2jnjqTkdGXtDdtpkC+Fc4LAvZ9Wl80=;
 b=Xxd4FwL4Bs3BTQ3gYAlw19Yxw5S6+fs+ra6g9duQh9xjrUBqxZ/bJRywXDMpu0wt8G
 YndsMm6lHxR1rQYfekzafTfktSwO7/Uqok8Pq4D37hE3QpRCfAAFLI0B7qOtqn5+nCSe
 fYkb7317TDmjFlib9S+gYkbEU0Hj8sswasMo9bP+bthPKKPvdXiJizgiHRVeAv2ycpRG
 ptdBItxoEjWoBUENiCC5TGuNmyrIGHZx+tm4s8sV3LUBnRNDs/892LOlvqI/3Ls0YT4g
 2t9n80gK/44+NEy5ry+QpqcPJ7xRT2QpAZVAmCSJ25EYq6CU+NY+UJ4JlDT9cgcHSJSX
 d1Jg==
X-Gm-Message-State: AOAM530gQUs532KMiYe5G9vCI0dbafkujxig50Z1MrdMopiPQuFOKwuR
 MkVkZqpOCIPtD9XQTZhg80JGy4/wxrOe3CWrvoVcODVnBQYJQGl6o9GMxVNxv+S3qWuX/dKrzrF
 5Eajag7nq09xXtEhVxn1PqEVUrWJJdwfmZSMflwgGEAPjDA==
X-Received: by 2002:a5e:8404:0:b0:66a:13cc:f2bc with SMTP id
 h4-20020a5e8404000000b0066a13ccf2bcmr617843ioj.95.1655171682226; 
 Mon, 13 Jun 2022 18:54:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsfLw/TVvIYon6xpgZ7S5cc632g91mYFy2r2EN8TmALPXrHX43fQtvYEYYDydUa3e7swddjRYM/znMCdhYKgc=
X-Received: by 2002:a5e:8404:0:b0:66a:13cc:f2bc with SMTP id
 h4-20020a5e8404000000b0066a13ccf2bcmr617827ioj.95.1655171682008; Mon, 13 Jun
 2022 18:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
 <20220613205734.3x7i46bnsofzerr4@cantor>
 <673eb011-94f4-46b0-f1b4-24a02a269f4e@linux.intel.com>
 <CALzcddsXciFgKOLSkXxx4Rv_rwh21qe8hkyiEET280D8orP6Vw@mail.gmail.com>
 <9c943703-0c2f-b654-a28b-f594bf90bec9@linux.intel.com>
In-Reply-To: <9c943703-0c2f-b654-a28b-f594bf90bec9@linux.intel.com>
From: Jerry Snitselaar <jsnitsel@redhat.com>
Date: Mon, 13 Jun 2022 18:54:13 -0700
Message-ID: <CALzcdduU-baVF9VV-NnYD2rKn0YC5hzS_F9udExRE7guvMqXWg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
To: Baolu Lu <baolu.lu@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Dimitri Sivanich <sivanich@hpe.com>, Joerg Roedel <jroedel@suse.de>,
 Russ Anderson <russ.anderson@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
 Mike Travis <mike.travis@hpe.com>, David Woodhouse <dwmw2@infradead.org>,
 Kyung Min Park <kyung.min.park@intel.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>
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

On Mon, Jun 13, 2022 at 6:51 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2022/6/14 09:44, Jerry Snitselaar wrote:
> > On Mon, Jun 13, 2022 at 6:36 PM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
> >> On 2022/6/14 04:57, Jerry Snitselaar wrote:
> >>> On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
> >>>> To support up to 64 sockets with 10 DMAR units each (640), make the
> >>>> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> >>>> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> >>>> set.
> >>>>
> >>>> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> >>>> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> >>>> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> >>>> remapping doesn't support X2APIC mode x2apic disabled"; and the system
> >>>> fails to boot properly.
> >>>>
> >>>> Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
> >>>> ---
> >>>>
> >>>> Note that we could not find a reason for connecting
> >>>> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> >>>> it seemed like the two would continue to match on earlier processors.
> >>>> There doesn't appear to be kernel code that assumes that the value of
> >>>> one is related to the other.
> >>>>
> >>>> v2: Make this value a config option, rather than a fixed constant.  The default
> >>>> values should match previous configuration except in the MAXSMP case.  Keeping the
> >>>> value at a power of two was requested by Kevin Tian.
> >>>>
> >>>>    drivers/iommu/intel/Kconfig | 6 ++++++
> >>>>    include/linux/dmar.h        | 6 +-----
> >>>>    2 files changed, 7 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> >>>> index 247d0f2d5fdf..fdbda77ac21e 100644
> >>>> --- a/drivers/iommu/intel/Kconfig
> >>>> +++ b/drivers/iommu/intel/Kconfig
> >>>> @@ -9,6 +9,12 @@ config DMAR_PERF
> >>>>    config DMAR_DEBUG
> >>>>       bool
> >>>>
> >>>> +config DMAR_UNITS_SUPPORTED
> >>>> +    int "Number of DMA Remapping Units supported"
> >>> Also, should there be a "depends on (X86 || IA64)" here?
> >> Do you have any compilation errors or warnings?
> >>
> >> Best regards,
> >> baolu
> >>
> > I think it is probably harmless since it doesn't get used elsewhere,
> > but our tooling was complaining to me because DMAR_UNITS_SUPPORTED was
> > being autogenerated into the configs for the non-x86 architectures we
> > build (aarch64, s390x, ppcle64).
> > We have files corresponding to the config options that it looks at,
> > and I had one for x86 and not the others so it noticed the
> > discrepancy.
>
> So with "depends on (X86 || IA64)", that tool doesn't complain anymore,
> right?
>
> Best regards,
> baolu
>

Yes, with the depends it no longer happens.

Regards,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
