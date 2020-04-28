Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA203C83004
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 18:54:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B0B206D6
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 18:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B0B206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 38E3B857CE;
	Tue, 28 Apr 2020 18:54:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OOzFNAvzZxNX; Tue, 28 Apr 2020 18:54:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0CBBD844AA;
	Tue, 28 Apr 2020 18:54:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF718C0864;
	Tue, 28 Apr 2020 18:54:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DBB2C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 18:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 16083228D1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 18:54:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O6aL3hXMAiGa for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 18:54:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id 6D62F2277A
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 18:54:18 +0000 (UTC)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11]
 helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1jTVMo-0002sR-0A; Tue, 28 Apr 2020 20:54:02 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
 id 40B54100FC0; Tue, 28 Apr 2020 20:54:01 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Jacob Pan \(Jun\)" <jacob.jun.pan@intel.com>
Subject: Re: [PATCH 5/7] x86/mmu: Allocate/free PASID
In-Reply-To: <20200428112113.000033bd@intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-6-git-send-email-fenghua.yu@intel.com>
 <87pnbus3du.fsf@nanos.tec.linutronix.de> <20200428112113.000033bd@intel.com>
Date: Tue, 28 Apr 2020 20:54:01 +0200
Message-ID: <87tv13o306.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 jacob.jun.pan@intel.com, H Peter Anvin <hpa@zytor.com>,
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

"Jacob Pan (Jun)" <jacob.jun.pan@intel.com> writes:
> On Sun, 26 Apr 2020 16:55:25 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> Fenghua Yu <fenghua.yu@intel.com> writes:
>> > The PASID is freed when the process exits (so no need to keep
>> > reference counts on how many SVM devices are sharing the PASID).  
>> 
>> I'm not buying that. If there is an outstanding request with the PASID
>> of a process then tearing down the process address space and freeing
>> the PASID (which might be reused) is fundamentally broken.
>> 
> Device driver unbind PASID is tied to FD release. So when a process
> exits, FD close causes driver to do the following:
>
> 1. stops DMA
> 2. unbind PASID (clears the PASID entry in IOMMU, flush all TLBs, drain
> in flight page requests)

Fair enough. Explaining that somewhere might be helpful.

> For bare metal SVM, if the last mmdrop always happens after FD release,
> we can ensure no outstanding requests at the point of ioasid_free().
> Perhaps this is a wrong assumption?

If fd release cleans up then how should there be something in flight at
the final mmdrop?

> For guest SVM, there will be more users of a PASID. I am also
> working on adding refcounting to ioasid. ioasid_free() will not release
> the PASID back to the pool until all references are dropped.

What does more users mean?

>> > +	if (mm && mm->context.pasid && !(flags &
>> > SVM_FLAG_PRIVATE_PASID)) {
>> > +		/*
>> > +		 * Once a PASID is allocated for this mm, the PASID
>> > +		 * stays with the mm until the mm is dropped. Reuse
>> > +		 * the PASID which has been already allocated for
>> > the
>> > +		 * mm instead of allocating a new one.
>> > +		 */
>> > +		ioasid_set_data(mm->context.pasid, svm);  
>> 
>> So if the PASID is reused several times for different SVMs then every
>> time ioasid_data->private is set to a different SVM. How is that
>> supposed to work?
>> 
> For the lifetime of the mm, there is only one PASID. svm_bind/unbind_mm
> could happen many times with different private data: intel_svm.
> Multiple devices can bind to the same PASID as well. But private data
> don't change within the first bind and last unbind.

Ok. I read through that spaghetti of intel_svm_bind_mm() again and now I
start to get an idea how that is supposed to work. What a mess.

That function really wants to be restructured in a way so it is
understandable to mere mortals. 

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
