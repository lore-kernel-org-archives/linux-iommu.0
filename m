Return-Path: <SRS0=QAQK=UU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265C3C48BE3
	for <iommu@archiver.kernel.org>; Fri, 21 Jun 2019 23:56:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01761206B6
	for <iommu@archiver.kernel.org>; Fri, 21 Jun 2019 23:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01761206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AE5A11423;
	Fri, 21 Jun 2019 23:56:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4BE521421
	for <iommu@lists.linux-foundation.org>;
	Fri, 21 Jun 2019 23:56:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C297A102
	for <iommu@lists.linux-foundation.org>;
	Fri, 21 Jun 2019 23:56:05 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	21 Jun 2019 16:56:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,402,1557212400"; d="scan'208";a="162822624"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
	by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2019 16:56:03 -0700
Date: Fri, 21 Jun 2019 16:55:41 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v4 20/21] iommu/vt-d: hpet: Reserve an interrupt
	remampping table entry for watchdog
Message-ID: <20190621235541.GA25773@ranerica-svr.sc.intel.com>
References: <1558660583-28561-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<alpine.DEB.2.21.1906162049300.1760@nanos.tec.linutronix.de>
	<alpine.DEB.2.21.1906171007360.1760@nanos.tec.linutronix.de>
	<CABPqkBTai76Bgb4E61tF-mJUkFNxVa4B8M2bxTEYVgBsuAANNQ@mail.gmail.com>
	<alpine.DEB.2.21.1906172343120.1963@nanos.tec.linutronix.de>
	<20190619084316.71ce5477@jacob-builder>
	<alpine.DEB.2.21.1906211732330.5503@nanos.tec.linutronix.de>
	<20190621103126.585ca6d3@jacob-builder>
	<20190621113938.1679f329@jacob-builder>
	<alpine.DEB.2.21.1906212201400.5503@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906212201400.5503@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Tony Luck <tony.luck@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, x86 <x86@kernel.org>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Juergen Gross <jgross@suse.com>, Bjorn Helgaas <bhelgaas@google.com>,
	iommu@lists.linux-foundation.org, Randy Dunlap <rdunlap@infradead.org>,
	Jacob Pan <jacob.jun.pan@intel.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andi Kleen <andi.kleen@intel.com>, Borislav Petkov <bp@suse.de>,
	Ingo Molnar <mingo@kernel.org>, Wincy Van <fanwenyi0529@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Jun 21, 2019 at 10:05:01PM +0200, Thomas Gleixner wrote:
> On Fri, 21 Jun 2019, Jacob Pan wrote:
> > On Fri, 21 Jun 2019 10:31:26 -0700
> > Jacob Pan <jacob.jun.pan@intel.com> wrote:
> > 
> > > On Fri, 21 Jun 2019 17:33:28 +0200 (CEST)
> > > Thomas Gleixner <tglx@linutronix.de> wrote:
> > > 
> > > > On Wed, 19 Jun 2019, Jacob Pan wrote:  
> > > > > On Tue, 18 Jun 2019 01:08:06 +0200 (CEST)
> > > > > Thomas Gleixner <tglx@linutronix.de> wrote:    
> > > > > > 
> > > > > > Unless this problem is not solved and I doubt it can be solved
> > > > > > after talking to IOMMU people and studying manuals,    
> > > > >
> > > > > I agree. modify irte might be done with cmpxchg_double() but the
> > > > > queued invalidation interface for IRTE cache flush is shared with
> > > > > DMA and requires holding a spinlock for enque descriptors, QI tail
> > > > > update etc.
> > > > > 
> > > > > Also, reserving & manipulating IRTE slot for hpet via backdoor
> > > > > might not be needed if the HPET PCI BDF (found in ACPI) can be
> > > > > utilized. But it might need more work to add a fake PCI device for
> > > > > HPET.    
> > > > 
> > > > What would PCI/BDF solve?  
> > > I was thinking if HPET is a PCI device then it can naturally
> > > gain slots in IOMMU remapping table IRTEs via PCI MSI code. Then
> > > perhaps it can use the IRQ subsystem to set affinity etc. w/o
> > > directly adding additional helper functions in IRQ remapping code. I
> > > have not followed all the discussions, just a thought.
> > > 
> > I looked at the code again, seems the per cpu HPET code already taken
> > care of HPET MSI management. Why can't we use IR-HPET-MSI chip and
> > domain to allocate and set affinity etc.?
> > Most APIC timer has ARAT not enough per cpu HPET, so per cpu HPET is
> > not used mostly.
> 
> Sure, we can use that, but that does not allow to move the affinity from
> NMI context either. Same issue with the IOMMU as with the other hack.

If I understand Thomas' point correctly, the problem is having to take
lock in NMI context to update the IRTE for the HPET; both as in my hack
and in the generic irq code. The problem is worse when using the generic
irq code as there are several layers and several locks that need to be
handled.

Thanks and BR,
Ricardo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
