Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E279C4743C
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 21:15:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4541B61358
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 21:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4541B61358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12EEF83139;
	Mon, 21 Jun 2021 21:15:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g7g9_jGgfUfC; Mon, 21 Jun 2021 21:15:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E856E82EF0;
	Mon, 21 Jun 2021 21:15:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC46BC001A;
	Mon, 21 Jun 2021 21:15:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 439F2C000E
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 21:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D88740368
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 21:15:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8atrV-zq4jcG for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 21:15:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 43EE64035E
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 21:15:56 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D622B6128E
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 21:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624310155;
 bh=BMFxuktetIHIQ9p2t3t67WAB+tyoq+VgC9t9IHSehTw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=YEfVAWNXlhCfKRrrHNjTRotzRf5SOZCCIguVV8DVtvKueXVC37kFAbKVuKDqroJx1
 QnhuRbZsMtOCaYrAkxrV25Yel9kryGPCEqY1xk6SKq+Xx+8w7nM5Ib/D6krklrF7jO
 mmYx1xbwsUv07t9T9g9vPiLQz+ATTx+K/OSnGrX1WsOlxP9f8eNLcNWdyH+bPX6wfy
 5wk7vYeb4PgIStpweEiEyZPqZSvcP0Tf+Sm0MvDr8FIOpE7Ni/QBW1TODquvkTBpBy
 5CqZiEWziHbVO2MHtr/6o78r1ZX3UVEVqDbqhZM1ZZhLmS7SLg5346xgx9v8lUU53c
 75nzhoOw/B+1Q==
Received: by mail-ej1-f48.google.com with SMTP id nb6so30938397ejc.10
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 14:15:55 -0700 (PDT)
X-Gm-Message-State: AOAM5313psy9WYr1PKGMyZl/IkoOEcQWLz6n1LrJ4eXcIEMST15/9o0v
 ys9AZLj9HNfwsjdfGzY+vo1b7FlBIXuqbsxo4cteSg==
X-Google-Smtp-Source: ABdhPJzJvillf+fe0IVGNg4yoMts5knbu7LBH/8P0ZmQVvZmgMHS6H408uZUCQqsC7kGs1kXyPakC8BoyWYuca7XMlo=
X-Received: by 2002:a17:907:3e9f:: with SMTP id
 hs31mr132059ejc.253.1624310154427; 
 Mon, 21 Jun 2021 14:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
 <1624032777-7013-13-git-send-email-ross.philipson@oracle.com>
 <53edcf0e-c094-876c-ac3d-7c9752e9ea99@arm.com>
 <34d05f0e-b24c-b8cf-c521-8b30cc1df532@oracle.com>
In-Reply-To: <34d05f0e-b24c-b8cf-c521-8b30cc1df532@oracle.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 21 Jun 2021 14:15:42 -0700
X-Gmail-Original-Message-ID: <CALCETrUdEvLFKuvU7z_ut6cEfAgJogNp3oBXL-EdDLU=W+VeKA@mail.gmail.com>
Message-ID: <CALCETrUdEvLFKuvU7z_ut6cEfAgJogNp3oBXL-EdDLU=W+VeKA@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] iommu: Do not allow IOMMU passthrough with
 Secure Launch
To: Ross Philipson <ross.philipson@oracle.com>, Andi Kleen <ak@linux.intel.com>,
 Joerg Roedel <jroedel@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Wang <jasowang@redhat.com>, 
 Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 trenchboot-devel@googlegroups.com, X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>,
 linux-integrity <linux-integrity@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Jun 21, 2021 at 10:51 AM Ross Philipson
<ross.philipson@oracle.com> wrote:
>
> On 6/18/21 2:32 PM, Robin Murphy wrote:
> > On 2021-06-18 17:12, Ross Philipson wrote:
> >> The IOMMU should always be set to default translated type after
> >> the PMRs are disabled to protect the MLE from DMA.
> >>
> >> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >> ---
> >>   drivers/iommu/intel/iommu.c | 5 +++++
> >>   drivers/iommu/iommu.c       | 6 +++++-
> >>   2 files changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> >> index be35284..4f0256d 100644
> >> --- a/drivers/iommu/intel/iommu.c
> >> +++ b/drivers/iommu/intel/iommu.c
> >> @@ -41,6 +41,7 @@
> >>   #include <linux/dma-direct.h>
> >>   #include <linux/crash_dump.h>
> >>   #include <linux/numa.h>
> >> +#include <linux/slaunch.h>
> >>   #include <asm/irq_remapping.h>
> >>   #include <asm/cacheflush.h>
> >>   #include <asm/iommu.h>
> >> @@ -2877,6 +2878,10 @@ static bool device_is_rmrr_locked(struct device
> >> *dev)
> >>    */
> >>   static int device_def_domain_type(struct device *dev)
> >>   {
> >> +    /* Do not allow identity domain when Secure Launch is configured */
> >> +    if (slaunch_get_flags() & SL_FLAG_ACTIVE)
> >> +        return IOMMU_DOMAIN_DMA;
> >
> > Is this specific to Intel? It seems like it could easily be done
> > commonly like the check for untrusted external devices.
>
> It is currently Intel only but that will change. I will look into what
> you suggest.
>
> >
> >> +
> >>       if (dev_is_pci(dev)) {
> >>           struct pci_dev *pdev = to_pci_dev(dev);
> >>   diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >> index 808ab70d..d49b7dd 100644
> >> --- a/drivers/iommu/iommu.c
> >> +++ b/drivers/iommu/iommu.c
> >> @@ -23,6 +23,7 @@
> >>   #include <linux/property.h>
> >>   #include <linux/fsl/mc.h>
> >>   #include <linux/module.h>
> >> +#include <linux/slaunch.h>
> >>   #include <trace/events/iommu.h>
> >>     static struct kset *iommu_group_kset;
> >> @@ -2761,7 +2762,10 @@ void iommu_set_default_passthrough(bool cmd_line)
> >>   {
> >>       if (cmd_line)
> >>           iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
> >> -    iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
> >> +
> >> +    /* Do not allow identity domain when Secure Launch is configured */
> >> +    if (!(slaunch_get_flags() & SL_FLAG_ACTIVE))
> >> +        iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
> >
> > Quietly ignoring the setting and possibly leaving iommu_def_domain_type
> > uninitialised (note that 0 is not actually a usable type) doesn't seem
> > great. AFAICS this probably warrants similar treatment to the
>
> Ok so I guess it would be better to set it to IOMMU_DOMAIN_DMA event
> though passthrough was requested. Or perhaps something more is needed here?
>
> > mem_encrypt_active() case - there doesn't seem a great deal of value in
> > trying to save users from themselves if they care about measured boot
> > yet explicitly pass options which may compromise measured boot. If you
> > really want to go down that route there's at least the sysfs interface
> > you'd need to nobble as well, not to mention the various ways of
> > completely disabling IOMMUs...
>
> Doing a secure launch with the kernel is not a general purpose user use
> case. A lot of work is done to secure the environment. Allowing
> passthrough mode would leave the secure launch kernel exposed to DMA. I
> think what we are trying to do here is what we intend though there may
> be a better way or perhaps it is incomplete as you suggest.
>

I don't really like all these special cases.  Generically, what you're
trying to do is (AFAICT) to get the kernel to run in a mode in which
it does its best not to trust attached devices.  Nothing about this is
specific to Secure Launch.  There are plenty of scenarios in which
this the case:

 - Virtual devices in a VM host outside the TCB, e.g. VDUSE, Xen
device domains (did I get the name right), whatever tricks QEMU has,
etc.
 - SRTM / DRTM technologies (including but not limited to Secure
Launch -- plain old Secure Boot can work like this too).
 - Secure guest technologies, including but not limited to TDX and SEV.
 - Any computer with a USB-C port or other external DMA-capable port.
 - Regular computers in which the admin wants to enable this mode for
whatever reason.

Can you folks all please agree on a coordinated way for a Linux kernel
to configure itself appropriately?  Or to be configured via initramfs,
boot option, or some other trusted source of configuration supplied at
boot time?  We don't need a whole bunch of if (TDX), if (SEV), if
(secure launch), if (I have a USB-C port with PCIe exposed), if
(running on Xen), and similar checks all over the place.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
