Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857BCC83004
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 20:40:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552462085B
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 20:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552462085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2722187941;
	Tue, 28 Apr 2020 20:40:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e6fLuywdPMBm; Tue, 28 Apr 2020 20:40:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 58E3A8753F;
	Tue, 28 Apr 2020 20:40:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31043C0864;
	Tue, 28 Apr 2020 20:40:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFD19C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 20:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DB92D8629B
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 20:40:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ve6CUv7yFrhP for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 20:40:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0775F860EA
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 20:40:11 +0000 (UTC)
IronPort-SDR: ugoI8ari/bDIg9+8QgxeqgKKT6bVAxAJ0C9xOksQVoZalyk42bKQ3SW1UXwQzTvQy0TU5NOJwb
 OCLNOJ7+a1Uw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2020 13:40:11 -0700
IronPort-SDR: v6udWB+U4wE/22S2l8Wz/OFuo988K6Pf+8JjY9MBQ2pKbKK8v+meEgtG9vZQqIntj8Th5MCUzK
 uvqiQkGvxSpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; d="scan'208";a="246624870"
Received: from jpan9-mobl2.amr.corp.intel.com (HELO localhost)
 ([10.212.240.17])
 by orsmga007.jf.intel.com with SMTP; 28 Apr 2020 13:40:10 -0700
Date: Tue, 28 Apr 2020 13:40:09 -0700
From: "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/7] x86/mmu: Allocate/free PASID
Message-ID: <20200428134009.00002f0d@intel.com>
In-Reply-To: <87tv13o306.fsf@nanos.tec.linutronix.de>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-6-git-send-email-fenghua.yu@intel.com>
 <87pnbus3du.fsf@nanos.tec.linutronix.de>
 <20200428112113.000033bd@intel.com>
 <87tv13o306.fsf@nanos.tec.linutronix.de>
Organization: intel
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 jacob.jun.pan@intel.com, H Peter Anvin <hpa@zytor.com>, David
 Woodhouse <dwmw2@infradead.org>
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

On Tue, 28 Apr 2020 20:54:01 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> "Jacob Pan (Jun)" <jacob.jun.pan@intel.com> writes:
> > On Sun, 26 Apr 2020 16:55:25 +0200
> > Thomas Gleixner <tglx@linutronix.de> wrote:  
> >> Fenghua Yu <fenghua.yu@intel.com> writes:  
> >> > The PASID is freed when the process exits (so no need to keep
> >> > reference counts on how many SVM devices are sharing the
> >> > PASID).    
> >> 
> >> I'm not buying that. If there is an outstanding request with the
> >> PASID of a process then tearing down the process address space and
> >> freeing the PASID (which might be reused) is fundamentally broken.
> >>   
> > Device driver unbind PASID is tied to FD release. So when a process
> > exits, FD close causes driver to do the following:
> >
> > 1. stops DMA
> > 2. unbind PASID (clears the PASID entry in IOMMU, flush all TLBs,
> > drain in flight page requests)  
> 
> Fair enough. Explaining that somewhere might be helpful.
> 
Will do. I plan to document this in a kernel doc for IOASID/PASID
lifecycle management.

> > For bare metal SVM, if the last mmdrop always happens after FD
> > release, we can ensure no outstanding requests at the point of
> > ioasid_free(). Perhaps this is a wrong assumption?  
> 
> If fd release cleans up then how should there be something in flight
> at the final mmdrop?
> 
> > For guest SVM, there will be more users of a PASID. I am also
> > working on adding refcounting to ioasid. ioasid_free() will not
> > release the PASID back to the pool until all references are
> > dropped.  
> 
> What does more users mean?
For VT-d, a PASID can be used by VFIO, IOMMU driver, KVM, and Virtual
Device Composition Module (VDCM*) at the same time.

*https://software.intel.com/en-us/download/intel-data-streaming-accelerator-preliminary-architecture-specification

There are HW context associated with the PASID in IOMMU, KVM, and VDCM.
So before the lifetime of the PASID is over, clean up must be done in
all of the above. PASID cannot be reclaimed until the last user drops
its reference. Our plan is to do notification and refcouting.


> 
> >> > +	if (mm && mm->context.pasid && !(flags &
> >> > SVM_FLAG_PRIVATE_PASID)) {
> >> > +		/*
> >> > +		 * Once a PASID is allocated for this mm, the
> >> > PASID
> >> > +		 * stays with the mm until the mm is dropped.
> >> > Reuse
> >> > +		 * the PASID which has been already allocated
> >> > for the
> >> > +		 * mm instead of allocating a new one.
> >> > +		 */
> >> > +		ioasid_set_data(mm->context.pasid, svm);    
> >> 
> >> So if the PASID is reused several times for different SVMs then
> >> every time ioasid_data->private is set to a different SVM. How is
> >> that supposed to work?
> >>   
> > For the lifetime of the mm, there is only one PASID.
> > svm_bind/unbind_mm could happen many times with different private
> > data: intel_svm. Multiple devices can bind to the same PASID as
> > well. But private data don't change within the first bind and last
> > unbind.  
> 
> Ok. I read through that spaghetti of intel_svm_bind_mm() again and
> now I start to get an idea how that is supposed to work. What a mess.
> 
> That function really wants to be restructured in a way so it is
> understandable to mere mortals. 
> 

Agreed. We are adding many new features and converging with generic
sva_bind_device. Things will get more clear after we have fewer moving
pieces.


> Thanks,
> 
>         tglx

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
