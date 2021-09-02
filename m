Return-Path: <SRS0=cE/7=NY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3F3C4320A
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 07:59:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C06360F90
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 07:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C06360F90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 010D440102;
	Thu,  2 Sep 2021 07:59:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ca1jqAw9Vrsw; Thu,  2 Sep 2021 07:59:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B5B1140104;
	Thu,  2 Sep 2021 07:59:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89C5EC001A;
	Thu,  2 Sep 2021 07:59:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB7C6C000E
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 07:59:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC52C605FD
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 07:59:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x7la8QrO6sL2 for <iommu@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 07:59:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C35EC605D2
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 07:59:46 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4E9586736F; Thu,  2 Sep 2021 09:59:39 +0200 (CEST)
Date: Thu, 2 Sep 2021 09:59:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH V4 00/13] x86/Hyper-V: Add Hyper-V Isolation VM support
Message-ID: <20210902075939.GB14986@lst.de>
References: <20210827172114.414281-1-ltykernel@gmail.com>
 <20210830120036.GA22005@lst.de>
 <MWHPR21MB15933503E7C324167CB4132CD7CC9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15933503E7C324167CB4132CD7CC9@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "x86@kernel.org" <x86@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Tianyu Lan <ltykernel@gmail.com>, Christoph Hellwig <hch@lst.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "pgonda@google.com" <pgonda@google.com>,
 "rientjes@google.com" <rientjes@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "martin.b.radev@gmail.com" <martin.b.radev@gmail.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
 "luto@kernel.org" <luto@kernel.org>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 vkuznets <vkuznets@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "jgross@suse.com" <jgross@suse.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "saravanand@fb.com" <saravanand@fb.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "rppt@kernel.org" <rppt@kernel.org>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "ardb@kernel.org" <ardb@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
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

On Tue, Aug 31, 2021 at 05:16:19PM +0000, Michael Kelley wrote:
> As a quick overview, I think there are four places where the
> shared_gpa_boundary must be applied to adjust the guest physical
> address that is used.  Each requires mapping a corresponding
> virtual address range.  Here are the four places:
> 
> 1)  The so-called "monitor pages" that are a core communication
> mechanism between the guest and Hyper-V.  These are two single
> pages, and the mapping is handled by calling memremap() for
> each of the two pages.  See Patch 7 of Tianyu's series.

Ah, interesting.

> 3)  The network driver send and receive buffers.  vmap_phys_range()
> should work here.

Actually it won't.  The problem with these buffers is that they are
physically non-contiguous allocations.  We really have two sensible
options:

 1) use vmap_pfn as in the current series.  But in that case I think
    we should get rid of the other mapping created by vmalloc.  I
    though a bit about finding a way to apply the offset in vmalloc
    itself, but I think it would be too invasive to the normal fast
    path.  So the other sub-option would be to allocate the pages
    manually (maybe even using high order allocations to reduce TLB
    pressure) and then remap them
 2) do away with the contiguous kernel mapping entirely.  This means
    the simple memcpy calls become loops over kmap_local_pfn.  As
    I just found out for the send side that would be pretty easy,
    but the receive side would be more work.  We'd also need to check
    the performance implications.

> 4) The swiotlb memory used for bounce buffers.  vmap_phys_range()
> should work here as well.

Or memremap if it works for 1.

> Case #2 above does unusual mapping.  The ring buffer consists of a ring
> buffer header page, followed by one or more pages that are the actual
> ring buffer.  The pages making up the actual ring buffer are mapped
> twice in succession.  For example, if the ring buffer has 4 pages
> (one header page and three ring buffer pages), the contiguous
> virtual mapping must cover these seven pages:  0, 1, 2, 3, 1, 2, 3.
> The duplicate contiguous mapping allows the code that is reading
> or writing the actual ring buffer to not be concerned about wrap-around
> because writing off the end of the ring buffer is automatically
> wrapped-around by the mapping.  The amount of data read or
> written in one batch never exceeds the size of the ring buffer, and
> after a batch is read or written, the read or write indices are adjusted
> to put them back into the range of the first mapping of the actual
> ring buffer pages.  So there's method to the madness, and the
> technique works pretty well.  But this kind of mapping is not
> amenable to using vmap_phys_range().

Hmm.  Can you point me to where this is mapped?  Especially for the
classic non-isolated case where no vmap/vmalloc mapping is involved
at all?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
