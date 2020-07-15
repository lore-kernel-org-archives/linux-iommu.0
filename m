Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE919C433E2
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 23:32:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99AE820658
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 23:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AE820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 60FBC2340C;
	Wed, 15 Jul 2020 23:32:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k34Cu+cRixg4; Wed, 15 Jul 2020 23:32:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3652F25715;
	Wed, 15 Jul 2020 23:32:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B268C07FF;
	Wed, 15 Jul 2020 23:32:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B323BC0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 23:32:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8A6268B1D9
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 23:32:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wxiT4Xusgt6o for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 23:32:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ACD278B1D7
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 23:32:02 +0000 (UTC)
IronPort-SDR: bqBt22AH1IJLcV6hBIkC2SrHQqD8+Se1Z7ZyL5r2EW4SvHfCAnvZGM0XD3UQT/V3Y9jDcY3Cn2
 OsiEgeMkTJxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="150676150"
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; d="scan'208";a="150676150"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 16:32:01 -0700
IronPort-SDR: cZvsAGDgpGF+2NbxakPS01kIeZEkM3esK0Xo0RC0msz+O1PuaVl0fyjRi+rZ8CiAPRiGdMsLcJ
 Mfelb6mDMgGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; d="scan'208";a="308429363"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by fmsmga004.fm.intel.com with ESMTP; 15 Jul 2020 16:32:00 -0700
Date: Wed, 15 Jul 2020 16:32:00 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 03/12] docs: x86: Add documentation for SVA (Shared
 Virtual Addressing)
Message-ID: <20200715233200.GD64320@romley-ivt3.sc.intel.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-4-git-send-email-fenghua.yu@intel.com>
 <DM5PR11MB1435394EDA593222F19F3BF8C3610@DM5PR11MB1435.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM5PR11MB1435394EDA593222F19F3BF8C3610@DM5PR11MB1435.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Peter Zijlstra <peterz@infradead.org>, "Hansen,
 Dave" <dave.hansen@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 "Shankar, Ravi V" <ravi.v.shankar@intel.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, "Luck, Tony" <tony.luck@intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

Hi, Yi,

On Mon, Jul 13, 2020 at 08:25:20PM -0700, Liu, Yi L wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > Sent: Tuesday, July 14, 2020 7:48 AM
> > From: Ashok Raj <ashok.raj@intel.com>

Thank you for your comments!

But I think we don't need to update this patch because the current text
is better than suggested changes. I would rather to keep this patch
unchanged. Please see my following explanations for details.

> > +(PRI) allow devices to function much the same way as the CPU handling
> > +application page-faults. For more information please refer to PCIe
> > +specification Chapter 10: ATS Specification.
> > +
> 
> nit: may be helpful to mention Chapter 10 of PCIe spec since 4.0. before that, ATS has its
> own specification.

This doc only refers to the latest specs. Older specs are not useful
for this spec.

> > +ENQCMD is the glue that ensures applications can directly submit
> > +commands to the hardware and also permit hardware to be aware of
> > +application context to perform I/O operations via use of PASID.
> > +
> 
> maybe a reader will ask about ENQCMDs after reading ENQCMD/S spec. :-)

This doc only covers ENQCMD. ENQCMDS is out of scope of this doc.

> > +- Allocate the PASID, and program the process page-table (cr3) in the
> > +PASID
> > +  context entries.
> 
> nit: s/PASID context entries/PASID table entries/

Kernel IOMMU does use PASID context. So we would keep the current text.

> 
> > +- Register for mmu_notifier() to track any page-table invalidations to
> > +keep
> > +  the device tlb in sync. For example, when a page-table entry is
> 
> not only device tlb. I guess iotlb is also included.

I think they are same/similar concepts. No need to duplicate here.

> > +it into the new MSR to communicate the process identity to platform hardware.
> > +ENQCMD uses the PASID stored in this MSR to tag requests from this process.
> > +When a user submits a work descriptor to a device using the ENQCMD
> > +instruction, the PASID field in the descriptor is auto-filled with the
> > +value from MSR_IA32_PASID. Requests for DMA from the device are also
> > +tagged with the same PASID. The platform IOMMU uses the PASID in the
> 
> not quite get " Requests for DMA from the device are also tagged with the
> same PASID"

The DMA access from device to the process address space uses the same PASID
set up in the MSR.
 
> 
> > +transaction to perform address translation. The IOMMU api's setup the
> 
> s/api's/apis/ ?


> 
> > +corresponding PASID entry in IOMMU with the process address used by the CPU
> > (for e.g cr3 in x86).
> 
> with the process page tables used by the CPU (e.g. the page tables pointed by cr3 in x86).

We use address to match the "address space" specified in the term of PASID.
page table is implementation details. So we would keep the current text.

> > +The MSR must be configured on each logical CPU before any application
> 
> s/MSR/MSR_IA32_PASID/

The MSR refers to MSR_IA32_PASID. We don't need to repeat long
"MSR_IA32_PASID" everywhere while a short "the MSR" is better and clear
in the doc.

> > +thread can interact with a device. Threads that belong to the same
> > +process share the same page tables, thus the same MSR value.
> 
> s/MSR/PASID/

The "MSR" is better because we focus on the MSR value here that is set up for
each thread.

> 
> > +
> > +PASID is cleared when a process is created. The PASID allocation and
> 
> s/PASID/MSR_IA32_PASID/

No. It is PASID that is cleared per process creation. We are not talking about
the MSR here although the MSR will cleared as part of process FPU init.

> 
> > +MSR programming may occur long after a process and its threads have been
> > created.
> > +One thread must call bind() to allocate the PASID for the process. If a
> 
> s/bind()/iommu_sva_bind_device()/ or say "call iommu api to bind a process with
> a device." :-)

bind() is better because the binding function may be changed (e.g. it was
changed in 5.8). People know bind() means binding. Even in the future the
binding function is changed again, we don't need to change the text here
if using bind().

> 
> > +thread uses ENQCMD without the MSR first being populated, it will cause #GP.
> > +The kernel will fix up the #GP by writing the process-wide PASID into
> > +the thread that took the #GP. A single process PASID can be used
> > +simultaneously with multiple devices since they all share the same address space.
> 
> simultaneously with multiple devices if they all share the process address
> space.

Using "since" is better. It explains "why".

> 
> > +
> > +New threads could inherit the MSR value from the parent. But this would
> 
> s/MSR/MSR_IA32_PASID/

Ditto. It's unnecessary to use long "MSR_IA32_PASID" everywhere.
"The MSR" is concise and clear.

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
