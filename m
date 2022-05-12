Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5EAC433FE
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 00:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88DB441976;
	Thu, 12 May 2022 00:35:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jsly7rP0n2yK; Thu, 12 May 2022 00:35:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E4F2B401D4;
	Thu, 12 May 2022 00:35:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8125C0039;
	Thu, 12 May 2022 00:35:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A230C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 00:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E7AF640BB0
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 00:35:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UqZ9pNlQO_Hk for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 00:35:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F568400B8
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 00:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652315716; x=1683851716;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dLBHzXs/7dIe56Ck53G1U2+PedWXR/Xhh4qftWNzQyo=;
 b=NHYdoFWRQhT8YgxbDkEjF0XzwH9VUOkaQdDwChO0iPEXCIVYey3Oigx6
 D+nhVQaEMdJ2D+vlXxuETdgAUIpFMWq92I1jngqHTXZWocMs+G+AyEW5e
 y6KC6bMSA6BoHbNxDCVY3rcP/uJ7COJ1Ql8zc3NrxI/mVk3JyutIxbbeE
 2K+pXsRD17mBxkcBc4BFoh9MdDyEn9l8f2V+nyBdMAxUPmGRxb5RCBx7K
 RLnrp6LDCD8DysbBqmMxI4LYeEEzSB5UG8WoWo8LwEIpGReQsK6WEhHOW
 HslzGGcEZTX/SRsmlapzSikUgZUTZiqENEga+ibT+qMhU6aYmwV8C3+Ol g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269979436"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="269979436"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 17:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="711708630"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by fmsmga001.fm.intel.com with ESMTP; 11 May 2022 17:35:14 -0700
Date: Wed, 11 May 2022 17:38:45 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 03/29] x86/apic/msi: Set the delivery mode
 individually for each IRQ
Message-ID: <20220512003845.GC16273@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-4-ricardo.neri-calderon@linux.intel.com>
 <8735hmh1f5.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8735hmh1f5.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 Ricardo Neri <ricardo.neri@intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On Fri, May 06, 2022 at 10:05:34PM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> > There are no restrictions in hardware to set  MSI messages with its
> > own delivery mode.
> 
> "messages with its own" ? Plural/singular confusion.

Yes, this is not correct. It should have read "messages with their own..."

> 
> > Use the mode specified in the provided IRQ hardware
> > configuration data. Since most of the IRQs are configured to use the
> > delivery mode of the APIC driver in use (set in all of them to
> > APIC_DELIVERY_MODE_FIXED), the only functional changes are where
> > IRQs are configured to use a specific delivery mode.
> 
> This does not parse. There are no functional changes due to this patch
> and there is no point talking about functional changes in subsequent
> patches here.

I will remove this.

> 
> > Changing the utility function __irq_msi_compose_msg() takes care of
> > implementing the change in the in the local APIC, PCI-MSI, and DMAR-MSI
> 
> in the in the

Sorry! This is not correct.

> 
> > irq_chips.
> >
> > The IO-APIC irq_chip configures the entries in the interrupt redirection
> > table using the delivery mode specified in the corresponding MSI message.
> > Since the MSI message is composed by a higher irq_chip in the hierarchy,
> > it does not need to be updated.
> 
> The point is that updating __irq_msi_compose_msg() covers _all_ MSI
> consumers including IO-APIC.
> 
> I had to read that changelog 3 times to make sense of it. Something like
> this perhaps:
> 
>   "x86/apic/msi: Use the delivery mode from irq_cfg for message composition
> 
>    irq_cfg provides a delivery mode for each interrupt. Use it instead
>    of the hardcoded APIC_DELIVERY_MODE_FIXED. This allows to compose
>    messages for NMI delivery mode which is required to implement a HPET
>    based NMI watchdog.
> 
>    No functional change as the default delivery mode is set to
>    APIC_DELIVERY_MODE_FIXED."

Thank you for your help on the changelog! I will take your suggestion.

BR,
Ricardo
> 
> Thanks,
> 
>         tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
