Return-Path: <SRS0=cHqw=D4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BDEC5DF9E
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 16:18:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B96E22249
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 16:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8ukPSf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B96E22249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E730F85D8F;
	Wed, 21 Oct 2020 16:18:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kKSCICXElukP; Wed, 21 Oct 2020 16:18:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E8C3885604;
	Wed, 21 Oct 2020 16:18:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD125C0052;
	Wed, 21 Oct 2020 16:18:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9693EC0051
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 16:18:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8F0DB8724F
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 16:18:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 61WYsUasCDJn for <iommu@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 16:18:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com
 [209.85.219.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 430CF873E0
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 16:18:42 +0000 (UTC)
Received: by mail-qv1-f67.google.com with SMTP id f5so1395522qvx.6
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CzKXJwhnXsatpgfBxJJmFGrX5HyZBJEIKL9JIRR+g5s=;
 b=D8ukPSf8Haz92tkcD9xdLoxLf3cJdNLzLMe6/3OB3u8gOfhMvE3Qfo/S4qoj6CMwUB
 CZ8cDdHBYNIqhLqT+SRrsSnrd7VLJyYDNmeJmwJOBjquQ7OdjMayHLQxCv3aPOshtyQg
 8CQckWQP0EUILR7vVRBnUjoieuQmEnLULrV2pcGbc2r5Ht60jY3nAwU0sykPICIzI50w
 kjBO1cp7oSZG0DBPUSPHrkdqLgONIYnGzggt0nbs9cVkfszxI7NYzkmM0Qyl4aBZDyfN
 +TYNtEPGEYAm2dBVeIyNPBL9m7PxnHHamzpgXRubnVuKht1f+I1Ja6sO48zFoNt/b3C3
 3Qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=CzKXJwhnXsatpgfBxJJmFGrX5HyZBJEIKL9JIRR+g5s=;
 b=Dms9HZsY/IrE5GoUXuhtxvJIWE53VT+IiovwX4No9y6mea4VaZwHt/5lWf10ID3ofQ
 dIUyx7cYPp6zx6TqIYIo4sGIXLFy3tXSJwWwM5IB5b7Ilrqdr+hzLCvuP6mMR4gWnm2Y
 +jHJ3MNuEhPMzDnoRj+BWTAaP7gLX2InQAsTD95Yqf4TfX6M2jbhi1gr5Tvz/PSm4DLe
 wwazG/qfTsrYu+KT9viUEx8a8H0aSdyx8SdrCrro4FAGyUoVFWzx7oC4HWTnx5S2HpEK
 QrQqGO9dcd1MnbSsffBUykYg0737s2MhCxWk70GTjC5praU+KAzpFrjEjEwwT+gyDs7A
 32VA==
X-Gm-Message-State: AOAM531q2dDBTlcUjKLgF25SILj6G+6OL/htHeRzqP6Teo/51YO7ZEEf
 KE4JwSRwXZCneZjLZXU81+g=
X-Google-Smtp-Source: ABdhPJzm4IIsqPihxypdU/hDH0/eZnfjM/QkTB3wKz8f9F9sCQeav7NdGj1QDwMCoX+46WaJUl131A==
X-Received: by 2002:ad4:44b3:: with SMTP id n19mr3609929qvt.39.1603297121078; 
 Wed, 21 Oct 2020 09:18:41 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
 by smtp.gmail.com with ESMTPSA id m15sm1511256qtc.90.2020.10.21.09.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 09:18:39 -0700 (PDT)
From: Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date: Wed, 21 Oct 2020 12:18:37 -0400
To: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
Message-ID: <20201021161837.GA3795579@rani.riverdale.lan>
References: <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
 <20200924173801.GA103726@rani.riverdale.lan>
 <c9ab2edf-1aaf-a1c9-92d5-2d37382a3163@oracle.com>
 <20200925191842.GA643740@rani.riverdale.lan>
 <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
 <20201015182654.lgtht5fd2aaunczu@tomti.i.net-space.pl>
 <20201016205151.GA1618249@rani.riverdale.lan>
 <20201019145153.7b6cg3rzj7g4njz6@tomti.i.net-space.pl>
 <20201019171822.GD2701355@rani.riverdale.lan>
 <20201021152833.b3oys643ckcl5evq@tomti.i.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201021152833.b3oys643ckcl5evq@tomti.i.net-space.pl>
Cc: linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
 Ross Philipson <ross.philipson@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 luto@amacapital.net, Arvind Sankar <nivedita@alum.mit.edu>, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, linux-integrity@vger.kernel.org,
 trenchboot-devel@googlegroups.com, tglx@linutronix.de
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

On Wed, Oct 21, 2020 at 05:28:33PM +0200, Daniel Kiper wrote:
> On Mon, Oct 19, 2020 at 01:18:22PM -0400, Arvind Sankar wrote:
> > On Mon, Oct 19, 2020 at 04:51:53PM +0200, Daniel Kiper wrote:
> > > On Fri, Oct 16, 2020 at 04:51:51PM -0400, Arvind Sankar wrote:
> > > > On Thu, Oct 15, 2020 at 08:26:54PM +0200, Daniel Kiper wrote:
> > > > >
> > > > > I am discussing with Ross the other option. We can create
> > > > > .rodata.mle_header section and put it at fixed offset as
> > > > > kernel_info is. So, we would have, e.g.:
> > > > >
> > > > > arch/x86/boot/compressed/vmlinux.lds.S:
> > > > >         .rodata.kernel_info KERNEL_INFO_OFFSET : {
> > > > >                 *(.rodata.kernel_info)
> > > > >         }
> > > > >         ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
> > > > >
> > > > >         .rodata.mle_header MLE_HEADER_OFFSET : {
> > > > >                 *(.rodata.mle_header)
> > > > >         }
> > > > >         ASSERT(ABSOLUTE(mle_header) == MLE_HEADER_OFFSET, "mle_header at bad address!")
> > > > >
> > > > > arch/x86/boot/compressed/sl_stub.S:
> > > > > #define mleh_rva(X) (((X) - mle_header) + MLE_HEADER_OFFSET)
> > > > >
> > > > >         .section ".rodata.mle_header", "a"
> > > > >
> > > > > SYM_DATA_START(mle_header)
> > > > >         .long   0x9082ac5a    /* UUID0 */
> > > > >         .long   0x74a7476f    /* UUID1 */
> > > > >         .long   0xa2555c0f    /* UUID2 */
> > > > >         .long   0x42b651cb    /* UUID3 */
> > > > >         .long   0x00000034    /* MLE header size */
> > > > >         .long   0x00020002    /* MLE version 2.2 */
> > > > >         .long   mleh_rva(sl_stub_entry)    /* Linear entry point of MLE (virt. address) */
> > > > >         .long   0x00000000    /* First valid page of MLE */
> > > > >         .long   0x00000000    /* Offset within binary of first byte of MLE */
> > > > >         .long   0x00000000    /* Offset within binary of last byte + 1 of MLE */
> > > > >         .long   0x00000223    /* Bit vector of MLE-supported capabilities */
> > > > >         .long   0x00000000    /* Starting linear address of command line (unused) */
> > > > >         .long   0x00000000    /* Ending linear address of command line (unused) */
> > > > > SYM_DATA_END(mle_header)
> > > > >
> > > > > Of course MLE_HEADER_OFFSET has to be defined as a constant somewhere.
> > > > > Anyway, is it acceptable?
> > >
> > > What do you think about my MLE_HEADER_OFFSET and related stuff proposal?
> > >
> >
> > I'm wondering if it would be easier to just allow relocations in these
> > special "header" sections. I need to check how easy/hard it is to do
> > that without triggering linker warnings.
> 
> Ross and I still bouncing some ideas. We came to the conclusion that
> putting mle_header into kernel .rodata.kernel_info section or even
> arch/x86/boot/compressed/kernel_info.S file would be the easiest thing
> to do at this point. Of course I would suggest some renaming too. E.g.
> .rodata.kernel_info to .rodata.kernel_headers, etc. Does it make sense
> for you?
> 
> Daniel

I haven't been able to come up with any different options that don't
require post-processing of the kernel image. Allowing relocations in
specific sections seems to not be possible with lld, and anyway would
require the fields to be 64-bit sized so it doesn't really help.

Putting mle_header into kernel_info seems like a reasonable thing to me,
and if you do that, putting it into kernel_info.S would seem to be
necessary?  Would you also have a fixed field with the offset of the
mle_header from kernel_info?  That seems nicer than having the
bootloader scan the variable data for magic strings.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
