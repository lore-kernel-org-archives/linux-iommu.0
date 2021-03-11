Return-Path: <SRS0=X4VR=IJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A19C433DB
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 17:55:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A299664FEE
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 17:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A299664FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 315464AA5C;
	Thu, 11 Mar 2021 17:55:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XM_336d-UWnF; Thu, 11 Mar 2021 17:55:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE85344E77;
	Thu, 11 Mar 2021 17:55:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A71D0C000B;
	Thu, 11 Mar 2021 17:55:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A50BC0001
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 17:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 681D142FFA
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 17:55:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NY_pNYDBesWU for <iommu@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 17:55:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86055414DB
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 17:55:22 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id y13so79586pfr.0
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 09:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7tZ+HS6prF5aUrltkb4FNPwzywOBjXvCQfT/EqBA63A=;
 b=RXwWSrnMizF7yOZD00BGRw6em+6tYDz9hNHyribTTmsGxGAwgUpOC0A7Wf0BJ9nypy
 +N38607vpaYVtraxSdJ0Gxd5dc95NoJ2+/3ADudPUHJv52a8NnBAEdlvINqnOYdUuMbW
 FcRwk0amvPBDPn/ULG2lrpx2rj9HADcsoJ9ozXLA4vUK38ttgWHs4q/Bv/mojmQIe/Zk
 bT8NarCtG1rE6ipalfa6ydM0/vrFuGBFdZ55DTDmpU7RCzwPxWeGj9LnmNqP6yRVCA2j
 pi+NCbR1qRB1c/fkvfC0FVfGM0qWXh9tp/XFi6L99eZUrEhosK2AIY0ZFarbFwviWYCZ
 ksTw==
X-Gm-Message-State: AOAM5326c9eRCvTIWZmOivGql4t1L6oEv1k4oHtznm/erWzxsygvKOjN
 OO2XDsDT4HsuEmRQxKa+uDQ=
X-Google-Smtp-Source: ABdhPJwL83azCPmYJtaPThACd9KaOQ6aUMLRVehcwqXg6/xywG5eRZlUEcGnG9aFnQQpHJo9tBt5OQ==
X-Received: by 2002:a05:6a00:1345:b029:1e3:d231:49cd with SMTP id
 k5-20020a056a001345b02901e3d23149cdmr8766983pfu.3.1615485321861; 
 Thu, 11 Mar 2021 09:55:21 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id 197sm2968008pgg.53.2021.03.11.09.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Mar 2021 09:55:20 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id E53364024E; Thu, 11 Mar 2021 17:55:19 +0000 (UTC)
Date: Thu, 11 Mar 2021 17:55:19 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
 iommu@lists.linux-foundation.org, andreas.noever@gmail.com,
 michael.jamet@intel.com, mika.westerberg@linux.intel.com,
 YehezkelShB@gmail.com, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/2] init/initramfs.c: allow asynchronous unpacking
Message-ID: <20210311175519.GV4332@42.do-not-panic.com>
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-2-linux@rasmusvillemoes.dk>
 <CAHk-=wiK_0RATa3AnRSODtSN2X5Cc0RfudLpr16aLhwxoU1yEA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wiK_0RATa3AnRSODtSN2X5Cc0RfudLpr16aLhwxoU1yEA@mail.gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>, Jessica Yu <jeyu@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
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

On Tue, Mar 09, 2021 at 02:07:36PM -0800, Linus Torvalds wrote:
> On Tue, Mar 9, 2021 at 1:17 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> >
> > So add an initramfs_async= kernel parameter, allowing the main init
> > process to proceed to handling device_initcall()s without waiting for
> > populate_rootfs() to finish.
> 
> I like this smaller second version of the patch, but am wondering why
> we even need the parameter.
> 
> It sounds mostly like a "maybe I didn't think of all cases" thing -
> and one that will mean that this code will not see a lot of actual
> test coverage..
> 
> And because of the lack of test coverage, I'd rather reverse the
> meaning, and have the async case on by default (without even the
> Kconfig option), and have the kernel command line purely as a "oops,
> it's buggy, easy to ask people to test if this is what ails them".

If we're going to set this as default it might be good to document on
init.h that components that need content in initramfs need the wait
call.

> What *can* happen early boot outside of firmware loading and usermodehelpers?

*In practice* the only thing I can think of at this time is races with
other rootfs_initcall() calls, granted ordering among these is done at
linker time, but I can't think of a issue with them:

arch/x86/kernel/pci-dma.c:rootfs_initcall(pci_iommu_init);
drivers/iommu/intel/irq_remapping.c:rootfs_initcall(ir_dev_scope_init);
drivers/mfd/sta2x11-mfd.c:rootfs_initcall(sta2x11_mfd_init);
drivers/thunderbolt/nhi.c:rootfs_initcall(nhi_init);

But Cc'ing the maintainers of these components just in case.

  Luis
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
