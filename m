Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02203C433E2
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 02:02:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC86207EA
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 02:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC86207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 44C0D86460;
	Tue, 15 Sep 2020 02:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2TF2WkOqrblV; Tue, 15 Sep 2020 02:02:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2AC0A8642E;
	Tue, 15 Sep 2020 02:02:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A80BC0864;
	Tue, 15 Sep 2020 02:02:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B01C8C0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 02:02:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 747B82043C
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 02:02:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oKO24kJYpjrx for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 02:02:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 9B9FE2040F
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 02:02:16 +0000 (UTC)
IronPort-SDR: e5POSe5rZcLQFaqrpYsk6Cu8Pd7QntKLY+f7sBhkof9RAsLVzUesyJOe84604NkNh6MjDBWFJc
 RzV7HeM36BNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="159234268"
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; d="scan'208";a="159234268"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2020 19:02:15 -0700
IronPort-SDR: N/Yz5aGcM6gsT2R3Poqs+0dJtTuuU+23RLSREefvakHjlB+NAFAaosxh7IeD8BOoc4ThbYgQNg
 42zOt3Ujv1Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; d="scan'208";a="330979588"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
 by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2020 19:02:14 -0700
Date: Tue, 15 Sep 2020 02:02:14 +0000
From: Fenghua Yu <fenghua.yu@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 3/9] docs: x86: Add documentation for SVA (Shared
 Virtual Addressing)
Message-ID: <20200915020214.GA437862@otcwcpicx6.sc.intel.com>
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
 <1598540794-132666-4-git-send-email-fenghua.yu@intel.com>
 <626fe21c-1f82-f4f8-e37b-32d91e7d557a@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <626fe21c-1f82-f4f8-e37b-32d91e7d557a@infradead.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Jacob Jun Pan <jacob.jun.pan@intel.com>,
 Andy Lutomirski <luto@kernel.org>, H Peter Anvin <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw2@infradead.org>
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

Hi, Randy,

On Sat, Sep 05, 2020 at 10:54:59AM -0700, Randy Dunlap wrote:
> Hi,
> 
> I'll add a few edits other than those that Borislav made.
> (nice review job, BP)
> 
> 
> On 8/27/20 8:06 AM, Fenghua Yu wrote:
> > From: Ashok Raj <ashok.raj@intel.com>
> > 
> > ENQCMD and Data Streaming Accelerator (DSA) and all of their associated
> > features are a complicated stack with lots of interconnected pieces.
> > This documentation provides a big picture overview for all of the
> > features.
> > 
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > ---
> > diff --git a/Documentation/x86/sva.rst b/Documentation/x86/sva.rst
> > new file mode 100644
> > index 000000000000..6e7ac565e127
> > --- /dev/null
> > +++ b/Documentation/x86/sva.rst
> > @@ -0,0 +1,254 @@
> > +MMIO. This doesn't scale as the number of threads becomes quite large. The
> > +hardware also manages the queue depth for Shared Work Queues (SWQ), and
> > +consumers don't need to track queue depth. If there is no space to accept
> > +a command, the device will return an error indicating retry. Also
> > +submitting a command to an MMIO address that can't accept ENQCMD will
> > +return retry in response. In the new DMWr PCIe terminology, devices need to
> 
> so how does a submitter know whether a return of "retry" means no_space or
> invalid_for_this_device?

I will add "A user should check Deferrable Memory Write (DMWr) capability on
the device and only submits ENQCMD when the device supports it."

So the user doesn't need to distinguish "no space" and "invalid for this device"
errors.

All of your other comments will be addressed in the next version.

Thank you very much for your comments!

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
