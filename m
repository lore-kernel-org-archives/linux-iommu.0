Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3EEC43461
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 14:56:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25CA9206DC
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 14:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CA9206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C8FF187678;
	Thu, 17 Sep 2020 14:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p8lsi7Z3sKaX; Thu, 17 Sep 2020 14:56:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2CCC187646;
	Thu, 17 Sep 2020 14:56:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 148DCC0864;
	Thu, 17 Sep 2020 14:56:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A5F4C0051
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 182F187675
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F5o7JTNDu8vv for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 14:56:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 13E6487646
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:56:13 +0000 (UTC)
IronPort-SDR: UToSdJ+2mrQXuI5vn+WK1pJbYA9y/HmTQhFF546YSO+/5DN1o2+zWVe8+hMwuPqnB0hnenybIa
 2V4Jjw+f4esw==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="221260496"
X-IronPort-AV: E=Sophos;i="5.77,437,1596524400"; d="scan'208";a="221260496"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2020 07:56:11 -0700
IronPort-SDR: QyFN85vOPnvWLorCFQzvTxleVhmEHePss429B5h+XJrYHl5eD0jZQ5fwuyoYb4Rx7BJtflaqaU
 TMdD1NUCff9Q==
X-IronPort-AV: E=Sophos;i="5.77,437,1596524400"; d="scan'208";a="332182841"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2020 07:56:11 -0700
Date: Thu, 17 Sep 2020 07:56:09 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v8 3/9] Documentation/x86: Add documentation for SVA
 (Shared Virtual Addressing)
Message-ID: <20200917145609.GB91028@otc-nc-03>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-4-git-send-email-fenghua.yu@intel.com>
 <20200917075338.GC31960@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200917075338.GC31960@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Andy Lutomirski <luto@kernel.org>,
 H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw2@infradead.org>, x86 <x86@kernel.org>
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

Hi Boris,

On Thu, Sep 17, 2020 at 09:53:38AM +0200, Borislav Petkov wrote:
> On Tue, Sep 15, 2020 at 09:30:07AM -0700, Fenghua Yu wrote:
> > +Background
> > +==========
> > +
> > +Shared Virtual Addressing (SVA) allows the processor and device to use the
> > +same virtual addresses avoiding the need for software to translate virtual
> > +addresses to physical addresses. SVA is what PCIe calls Shared Virtual
> > +Memory (SVM).
> > +
> > +In addition to the convenience of using application virtual addresses
> > +by the device, it also doesn't require pinning pages for DMA.
> > +PCIe Address Translation Services (ATS) along with Page Request Interface
> > +(PRI) allow devices to function much the same way as the CPU handling
> > +application page-faults. For more information please refer to the PCIe
> > +specification Chapter 10: ATS Specification.
> > +
> > +Use of SVA requires IOMMU support in the platform. IOMMU also is required
> > +to support PCIe features ATS and PRI. ATS allows devices to cache
> > +translations for virtual addresses. The IOMMU driver uses the mmu_notifier()
> > +support to keep the device TLB cache and the CPU cache in sync. PRI allows
> > +the device to request paging the virtual address by using the CPU page tables
> > +before accessing the address.
> 
> That still reads funny, the "the device to request paging the virtual
> address" part. Do you mean that per chance here:
> 
> "Before the device can access that address, the device uses the PRI in
> order to request the virtual address to be paged in into the CPU page
> tables."
> 
Agree, this reads a bit funny.

Just tweaked it a bit: 

"When ATS lookup fails for a virtual address, device should use PRI in
order to request the virtual address to be paged into the CPU page tables.
The device must use ATS again in order the fetch the translation again
before use"

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
