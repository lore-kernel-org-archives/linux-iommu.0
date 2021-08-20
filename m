Return-Path: <SRS0=ckUw=NL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABB4C4338F
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 04:22:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE77660F4A
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 04:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE77660F4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B83A613D4;
	Fri, 20 Aug 2021 04:22:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RVbyH4McOhGO; Fri, 20 Aug 2021 04:22:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 42B90613B7;
	Fri, 20 Aug 2021 04:22:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F147EC001A;
	Fri, 20 Aug 2021 04:21:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56058C000E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 04:21:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3124C40631
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 04:21:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ShPq026bmNDP for <iommu@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 04:21:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 609DE402BF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 04:21:57 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id E02696736F; Fri, 20 Aug 2021 06:21:51 +0200 (CEST)
Date: Fri, 20 Aug 2021 06:21:51 +0200
From: "hch@lst.de" <hch@lst.de>
To: Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH V3 12/13] HV/Netvsc: Add Isolation VM support for
 netvsc driver
Message-ID: <20210820042151.GB26450@lst.de>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-13-ltykernel@gmail.com>
 <MWHPR21MB15936FE72E65A62FBA3EF4F2D7C09@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15936FE72E65A62FBA3EF4F2D7C09@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 vkuznets <vkuznets@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
 KY Srinivasan <kys@microsoft.com>, "will@kernel.org" <will@kernel.org>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "x86@kernel.org" <x86@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Tianyu Lan <ltykernel@gmail.com>, "hch@lst.de" <hch@lst.de>,
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
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "jgross@suse.com" <jgross@suse.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "saravanand@fb.com" <saravanand@fb.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "rppt@kernel.org" <rppt@kernel.org>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "tj@kernel.org" <tj@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
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

On Thu, Aug 19, 2021 at 06:14:51PM +0000, Michael Kelley wrote:
> > +	if (!pfns)
> > +		return NULL;
> > +
> > +	for (i = 0; i < size / HV_HYP_PAGE_SIZE; i++)
> > +		pfns[i] = virt_to_hvpfn(buf + i * HV_HYP_PAGE_SIZE)
> > +			+ (ms_hyperv.shared_gpa_boundary >> HV_HYP_PAGE_SHIFT);
> > +
> > +	vaddr = vmap_pfn(pfns, size / HV_HYP_PAGE_SIZE, PAGE_KERNEL_IO);
> > +	kfree(pfns);
> > +
> > +	return vaddr;
> > +}
> 
> This function appears to be a duplicate of hv_map_memory() in Patch 11 of this
> series.  Is it possible to structure things so there is only one implementation?  In

So right now it it identical, but there is an important difference:
the swiotlb memory is physically contiguous to start with, so we can
do the simple remap using vmap_range as suggested in the last mail.
The cases here are pretty weird in that netvsc_remap_buf is called right
after vzalloc.  That is we create _two_ mappings in vmalloc space right
after another, where the original one is just used for establishing the
"GPADL handle" and freeing the memory.  In other words, the obvious thing
to do here would be to use a vmalloc variant that allows to take the
shared_gpa_boundary into account when setting up the PTEs.

And here is somthing I need help from the x86 experts:  does the CPU
actually care about this shared_gpa_boundary?  Or does it just matter
for the generated DMA address?  Does somehow have a good pointer to
how this mechanism works?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
