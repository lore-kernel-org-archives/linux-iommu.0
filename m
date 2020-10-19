Return-Path: <SRS0=3ib5=D2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6AAC43457
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 17:06:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3483C22314
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 17:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSfCaGE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3483C22314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8185087242;
	Mon, 19 Oct 2020 17:06:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pSAnEXdUFivg; Mon, 19 Oct 2020 17:06:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DE8D286DED;
	Mon, 19 Oct 2020 17:06:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7F2CC0052;
	Mon, 19 Oct 2020 17:06:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3A77C0051
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 17:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BA04486D9A
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 17:06:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qavg7-sCmJz0 for <iommu@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 17:06:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1873786D95
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 17:06:19 +0000 (UTC)
Received: by mail-qt1-f195.google.com with SMTP id h19so335967qtq.4
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 10:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QlZ9jQiPI8wiI9R/8Eu0+GjPBdTOfIetM3KH+KtgMXI=;
 b=TSfCaGE5nALMYvm6jXC7miu7tdEMeBbQ/oo3OvVvTIzuhQs5UqEpBSvY5xi8Zva1Or
 OEmq6yA8Xwttc6yR4yh/GzBqDWS/8vZ3OcawGCl2JSSGA5gmjBcBPOQKJ/l6phRk5knh
 bZrFVjTIQoVxXaD/4aONZoqa0BchWNbGQ3vHn6IzPxldgquacqdFtfT06wDMoNJybhmx
 xPmSczVEDJjvs4T8ePUIE79ol1KcwWM1r7inus1jwbZ3OuU2qM9o2IZgDfQspyVEGjGY
 IG+D8+VldXK00eD5H9N2rSitkxqWC0fjHNr3zM6elj0WNiqh0gePl/DqLCMcfgLOO93L
 JsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=QlZ9jQiPI8wiI9R/8Eu0+GjPBdTOfIetM3KH+KtgMXI=;
 b=CcmB4SVEhX1dTy1DuLikP1pZgvUXOoS79z+NexTwfmUfVUVil3FH+0nZ/aE+i3d2GN
 C5+7FHR6I7Fhwq65fMcKD53px5IMz19pwT42Dsqd7RuqMOyEfFNrh2hMBYp+lPIFv+Zp
 CWRC1BjSd0g5tHSIx69OL/x+xRpOgnS4zI8LLOpPHRSytKQu7D6ngpwIbFc87LfmmrzO
 WfqnfWkV+1cOLEDxtjuncK9AViTXg8I/tiPIslbi+1acdU9rU/oVa3COIgce7vKK4kr5
 V55Cs64VzmZpK+N3qLSS/OcBH3Y7uE+9h/YHWrUYGANQMqruM8cRl7KW6e05Y5H/WS+e
 mznQ==
X-Gm-Message-State: AOAM533jkw8O119tIHamgJ3KLbKdbQL5xJn3hyqzGmZD1A+rwLnz2UWM
 iF9wOQdvSy+nZSRTILm6NPg=
X-Google-Smtp-Source: ABdhPJwoZOuQWDFVA3DgogqmZ+TbE08fVV8ZWC3ILvYzlMSC4BsTgymar/lGVLzLn2+P+AQ6+IEIsA==
X-Received: by 2002:ac8:5b82:: with SMTP id a2mr424004qta.176.1603127177979;
 Mon, 19 Oct 2020 10:06:17 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
 by smtp.gmail.com with ESMTPSA id v14sm180923qta.44.2020.10.19.10.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 10:06:16 -0700 (PDT)
From: Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date: Mon, 19 Oct 2020 13:06:15 -0400
To: Ross Philipson <ross.philipson@oracle.com>
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
Message-ID: <20201019170615.GB2701355@rani.riverdale.lan>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
 <20200924173801.GA103726@rani.riverdale.lan>
 <c9ab2edf-1aaf-a1c9-92d5-2d37382a3163@oracle.com>
 <20200925191842.GA643740@rani.riverdale.lan>
 <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
 <20201015182654.lgtht5fd2aaunczu@tomti.i.net-space.pl>
 <20201016205151.GA1618249@rani.riverdale.lan>
 <7529a1e7-4dd6-ab3a-6363-23fd2de6c338@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7529a1e7-4dd6-ab3a-6363-23fd2de6c338@oracle.com>
Cc: linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
 Daniel Kiper <daniel.kiper@oracle.com>, x86@kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Arvind Sankar <nivedita@alum.mit.edu>, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, linux-integrity@vger.kernel.org, luto@amacapital.net,
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

On Mon, Oct 19, 2020 at 10:38:08AM -0400, Ross Philipson wrote:
> On 10/16/20 4:51 PM, Arvind Sankar wrote:
> > On Thu, Oct 15, 2020 at 08:26:54PM +0200, Daniel Kiper wrote:
> >>
> >> I am discussing with Ross the other option. We can create
> >> .rodata.mle_header section and put it at fixed offset as
> >> kernel_info is. So, we would have, e.g.:
> >>
> >> arch/x86/boot/compressed/vmlinux.lds.S:
> >>         .rodata.kernel_info KERNEL_INFO_OFFSET : {
> >>                 *(.rodata.kernel_info)
> >>         }
> >>         ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
> >>
> >>         .rodata.mle_header MLE_HEADER_OFFSET : {
> >>                 *(.rodata.mle_header)
> >>         }
> >>         ASSERT(ABSOLUTE(mle_header) == MLE_HEADER_OFFSET, "mle_header at bad address!")
> >>
> >> arch/x86/boot/compressed/sl_stub.S:
> >> #define mleh_rva(X) (((X) - mle_header) + MLE_HEADER_OFFSET)
> >>
> >>         .section ".rodata.mle_header", "a"
> >>
> >> SYM_DATA_START(mle_header)
> >>         .long   0x9082ac5a    /* UUID0 */
> >>         .long   0x74a7476f    /* UUID1 */
> >>         .long   0xa2555c0f    /* UUID2 */
> >>         .long   0x42b651cb    /* UUID3 */
> >>         .long   0x00000034    /* MLE header size */
> >>         .long   0x00020002    /* MLE version 2.2 */
> >>         .long   mleh_rva(sl_stub_entry)    /* Linear entry point of MLE (virt. address) */
> >>         .long   0x00000000    /* First valid page of MLE */
> >>         .long   0x00000000    /* Offset within binary of first byte of MLE */
> >>         .long   0x00000000    /* Offset within binary of last byte + 1 of MLE */
> >>         .long   0x00000223    /* Bit vector of MLE-supported capabilities */
> >>         .long   0x00000000    /* Starting linear address of command line (unused) */
> >>         .long   0x00000000    /* Ending linear address of command line (unused) */
> >> SYM_DATA_END(mle_header)
> >>
> >> Of course MLE_HEADER_OFFSET has to be defined as a constant somewhere.
> >> Anyway, is it acceptable?
> >>
> >> There is also another problem. We have to put into mle_header size of
> >> the Linux kernel image. Currently it is done by the bootloader but
> >> I think it is not a role of the bootloader. The kernel image should
> >> provide all data describing its properties and do not rely on the
> >> bootloader to do that. Ross and I investigated various options but we
> >> did not find a good/simple way to do that. Could you suggest how we
> >> should do that or at least where we should take a look to get some
> >> ideas?
> >>
> >> Daniel
> > 
> > What exactly is the size you need here? Is it just the size of the
> > protected mode image, that's startup_32 to _edata. Or is it the size of
> 
> It is the size of the protected mode image. Though how to reference
> those symbols to get the size might all more relocation issues.
> 

Ok, then I think mleh_rva(_edata) should get you that -- I assume you
don't want to include the uninitialized data in the size? The kernel
will access memory beyond _edata (upto the init_size in the setup
header), but that's not part of the image itself.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
