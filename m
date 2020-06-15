Return-Path: <SRS0=8EFN=74=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF89C433E1
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 18:32:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF7B20707
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 18:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kZsZQvXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF7B20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4C55E88005;
	Mon, 15 Jun 2020 18:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XjWJxKV-vH29; Mon, 15 Jun 2020 18:32:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6565F87F8B;
	Mon, 15 Jun 2020 18:32:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DC4BC0888;
	Mon, 15 Jun 2020 18:32:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E2EDC016E
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 18:32:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 279B78856C
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 18:32:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vgYOZ5-2CNff for <iommu@lists.linux-foundation.org>;
 Mon, 15 Jun 2020 18:32:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 97216884F1
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 18:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=kaLeQNKpwo/3pmt93qdeNrph7VCKxinWeBQB+muxlqU=; b=kZsZQvXl1NJZtySSQyofXqG2gJ
 LGW3VjHm9TuX25UqvO3KZKb2oOIY9GxryxwgyWiyhctAhFfedcv/u0AMokGAfuDcuQv/YwEGvsQmY
 8hielzOiarmpwSn/5Z/0ZHjthHpnyNcIvvdozZPWoKwXF1+6ZCXlGxvI5cc6bKSJLMgkeQfJy9onI
 UNvacJvt2GszmscxRPRxdOJ3tSlgyXdm46wtChlF5IIN4RMh0tlBKzaD0+BDmhBAEVFIMAXXXwcY2
 cISoF7L3RZDb4UNipJqrTeB82lsBma2Gf1fHVAikvl9tjy6NvvycYEJ6lHhJjlERcYaO3c4E8tvMX
 H2PwgC9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkttx-000598-1L; Mon, 15 Jun 2020 18:32:09 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7A7430604B;
 Mon, 15 Jun 2020 20:32:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id B5E05203DCA15; Mon, 15 Jun 2020 20:32:04 +0200 (CEST)
Date: Mon, 15 Jun 2020 20:32:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200615183204.GE2531@hirez.programming.kicks-ass.net>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
 <20200615075649.GK2497@hirez.programming.kicks-ass.net>
 <20200615154854.GB13792@romley-ivt3.sc.intel.com>
 <20200615160357.GA2531@hirez.programming.kicks-ass.net>
 <20200615181921.GA33928@otc-nc-03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200615181921.GA33928@otc-nc-03>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>,
 Dave Hansen <dave.hansen@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Dave Jiang <dave.jiang@intel.com>, x86 <x86@kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, Ingo Molnar <mingo@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Jun Pan <jacob.jun.pan@intel.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>
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

On Mon, Jun 15, 2020 at 11:19:21AM -0700, Raj, Ashok wrote:
> On Mon, Jun 15, 2020 at 06:03:57PM +0200, Peter Zijlstra wrote:
> > 
> > I don't get why you need a rdmsr here, or why not having one would
> > require a TIF flag. Is that because this MSR is XSAVE/XRSTOR managed?
> > 
> > > > > +	 */
> > > > > +	rdmsrl(MSR_IA32_PASID, pasid_msr);
> > > > > +	if (pasid_msr & MSR_IA32_PASID_VALID)
> > > > > +		return false;
> > > > > +
> > > > > +	/* Fix up the MSR if the MSR doesn't have a valid PASID. */
> > > > > +	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
> > 
> > How much more expensive is the wrmsr over the rdmsr? Can't we just
> > unconditionally write the current PASID and call it a day?
> 
> The reason to check the rdmsr() is because we are using a hueristic taking
> GP faults. If we already setup the MSR, but we get it a second time it
> means the reason is something other than PASID_MSR not being set.
> 
> Ideally we should use the TIF_ to track this would be cheaper, but we were
> told those bits aren't easy to give out. 

Why do you need a TIF flag? Why not any other random flag in current?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
