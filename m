Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF850C4361B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 19:16:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1341023AAC
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 19:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1341023AAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7F3B520460;
	Wed,  9 Dec 2020 19:16:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fBLksh6hmPiG; Wed,  9 Dec 2020 19:16:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2A6942033E;
	Wed,  9 Dec 2020 19:16:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00D56C0893;
	Wed,  9 Dec 2020 19:16:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D8B8C013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 63EE087ACA
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:16:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WZaKlngx8Svm for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 19:15:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9669287AC1
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607541358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PjbYSkTUKJTra9F+rU4vKjR/ApBdCFoCJ6AA7j7gnIY=;
 b=TRW+/wOuQ3ent7EvF0fjt+PUA5g2Z6dhX2xrgU0a+hs3Eq6DXFOjURjEl2p0vgLtkWhdv7
 jzhqdOJ1gq5Np0wAeTDzp3Lf18mJuDuBX1uRRaeB+P+uUEi+YoUnFmTJSg4u4UcO2EqKCa
 z22U25RfzPFGe+gPqudmVJOPINvUUNU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-Qbn10QMbNrKlnub5LOPAlQ-1; Wed, 09 Dec 2020 14:15:53 -0500
X-MC-Unique: Qbn10QMbNrKlnub5LOPAlQ-1
Received: by mail-lj1-f197.google.com with SMTP id r22so2604617ljd.4
 for <iommu@lists.linux-foundation.org>; Wed, 09 Dec 2020 11:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PjbYSkTUKJTra9F+rU4vKjR/ApBdCFoCJ6AA7j7gnIY=;
 b=ZNGNJEVm45zqypG2OGFzyvHULeI96U88IBvmeJUlsyCoiighNUHEfTbpzfcKAaJlqu
 v1nIjQ5nWGpxPDutNQmX0WXXG0QnLZksjssQy1R4b74cU0h4DZnbbPSAAtuMnBudwkHq
 K+wnoLT3qVvCaitxAeLnlEEKul5ftWcL/0530Hh+ex/EmiCUWzo/SD6bO6rl45N0i7Hr
 B+F3UpsHLBa8Ik5cx3MLXnX2HttMfGS8jJA2Y5OMNM+haKVfdDNcz9pqT/URDANGLxaz
 tdTFDm+NlOI4B1sP6U926Kk+y1S6iSRkFPuzbN7mTfpy+4yo8Hu60pr1fotz951/vcHI
 QioA==
X-Gm-Message-State: AOAM530URzbGCY95xV+uAp9YtBa1xeL5zuZ3v6Rkmz+J3A168jBYwLnn
 8CljFXKysUxeGe3Ci8LYGxtjRdyq/mktZdBommuXZkeshHjjFw6aKCWJ5hdF8wCld6OZ2/jYv16
 qLc1zDR5GYgWTA3k0JziD1DIhzhpf+tKxel42OkamviD2yQ==
X-Received: by 2002:a05:651c:10c:: with SMTP id
 a12mr1658536ljb.414.1607541352071; 
 Wed, 09 Dec 2020 11:15:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9/CimOc3N+72fFhCbbXRSFzpfZduUqobE3ByMI+lzkU6larzWtaAlzRFEmIhhoEYzS/VQ4tAHzGnleY0WZpw=
X-Received: by 2002:a05:651c:10c:: with SMTP id
 a12mr1658530ljb.414.1607541351897; 
 Wed, 09 Dec 2020 11:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20201209141237.GA8092@willie-the-truck>
 <CAHk-=wht4inbTVVMt2TNDxR_cVjSNaBU3JYyKtRMVovWePb65g@mail.gmail.com>
 <20201209185020.GC8778@willie-the-truck> <87tusulrog.fsf@redhat.com>
In-Reply-To: <87tusulrog.fsf@redhat.com>
From: Jerry Snitselaar <jsnitsel@redhat.com>
Date: Wed, 9 Dec 2020 12:15:25 -0700
Message-ID: <CALzcdduYs4dng6R9j_dFFE5O13Kbpq9Rg05EFaQS1RSCHebYqg@mail.gmail.com>
Subject: Re: [GIT PULL] IOMMU fix for 5.10 (-final)
To: Will Deacon <will@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org
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

On Wed, Dec 9, 2020 at 12:12 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
>
> Will Deacon @ 2020-12-09 11:50 MST:
>
> > On Wed, Dec 09, 2020 at 10:07:46AM -0800, Linus Torvalds wrote:
> >> On Wed, Dec 9, 2020 at 6:12 AM Will Deacon <will@kernel.org> wrote:
> >> >
> >> > Please pull this one-liner AMD IOMMU fix for 5.10. It's actually a fix
> >> > for a fix, where the size of the interrupt remapping table was increased
> >> > but a related constant for the size of the interrupt table was forgotten.
> >>
> >> Pulled.
> >
> > Thanks.
> >
> >> However, why didn't this then add some sanity checking for the two
> >> different #defines to be in sync?
> >>
> >> IOW, something like
> >>
> >>    #define AMD_IOMMU_IRQ_TABLE_SHIFT 9
> >>
> >>    #define MAX_IRQS_PER_TABLE (1 << AMD_IOMMU_IRQ_TABLE_SHIFT)
> >>    #define DTE_IRQ_TABLE_LEN ((u64)AMD_IOMMU_IRQ_TABLE_SHIFT << 1)
>
> Since the field in the device table entry format expects it to be n
> where there are 2^n entries in the table I guess it should be:
>
> #define DTE_IRQ_TABLE_LEN 9
> #define MAX_IRQS_PER_TABLE (1 << DTE_IRQ_TABLE_LEN)
>
No, ignore that. I'm being stupid.


> >>
> >> or whatever. Hmm?
> >
> > This looks like a worthwhile change to me, but I don't have any hardware
> > so I've been very reluctant to make even "obvious" driver changes here.
> >
> > Suravee -- please can you post a patch implementing the above?
> >
> >> That way this won't happen again, but perhaps equally importantly the
> >> linkage will be more clear, and there won't be those random constants.
> >>
> >> Naming above is probably garbage - I assume there's some actual
> >> architectural name for that irq table length field in the DTE?
> >
> > The one in the spec is even better: "IntTabLen".
> >
> > Will
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
