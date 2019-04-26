Return-Path: <SRS0=codQ=S4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E8FC43218
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 15:18:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E36206BF
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 15:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E36206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C83252869;
	Fri, 26 Apr 2019 15:18:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2FBD222F5
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 15:16:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0511374A
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 15:16:21 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	26 Apr 2019 08:16:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; d="scan'208";a="165169094"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by fmsmga002.fm.intel.com with ESMTP; 26 Apr 2019 08:16:20 -0700
Date: Fri, 26 Apr 2019 08:19:03 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 08/19] ioasid: Add custom IOASID allocator
Message-ID: <20190426081903.164dcff3@jacob-builder>
In-Reply-To: <01fe1710-4022-0bf2-b2ff-307b15b9fabb@redhat.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556062279-64135-9-git-send-email-jacob.jun.pan@linux.intel.com>
	<4ef22c62-0947-8de5-3288-2835ce5fa7a9@redhat.com>
	<20190425142944.40661941@jacob-builder>
	<01fe1710-4022-0bf2-b2ff-307b15b9fabb@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190426151903.5-ssb2TLAsDxIOIOT7coCf548Q3qcyFmFLhodGZXwos@z>

On Fri, 26 Apr 2019 11:06:54 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 4/25/19 11:29 PM, Jacob Pan wrote:
> > Hi Eric,
> > 
> > Thanks for the review.
> > 
> > On Thu, 25 Apr 2019 12:03:42 +0200
> > Auger Eric <eric.auger@redhat.com> wrote:
> >   
> >> Hi Jacob,
> >>
> >> On 4/24/19 1:31 AM, Jacob Pan wrote:  
> >>> Sometimes, IOASID allocation must be handled by platform specific
> >>> code. The use cases are guest vIOMMU and pvIOMMU where IOASIDs
> >>> need to be allocated by the host via enlightened or paravirt
> >>> interfaces.
> >>>
> >>> This patch adds an extension to the IOASID allocator APIs such
> >>> that platform drivers can register a custom allocator, possibly
> >>> at boot time, to take over the allocation. Xarray is still used
> >>> for tracking and searching purposes internal to the IOASID code.
> >>> Private data of an IOASID can also be set after the allocation.
> >>>
> >>> There can be multiple custom allocators registered but only one is
> >>> used at a time. In case of hot removal of devices that provides
> >>> the allocator, all IOASIDs must be freed prior to unregistering
> >>> the allocator. Default XArray based allocator cannot be mixed with
> >>> custom allocators, i.e. custom allocators will not be used if
> >>> there are outstanding IOASIDs allocated by the default XA
> >>> allocator.    
> >>
> >> What's the exact use case behind allowing several custom IOASID
> >> allocators to be registered?  
> > It is mainly for supporting multiple PCI segments thus multiple
> > vIOMMUs. Even though, all allocators will end up calling the host to
> > allocate PASIDs.  
> 
> Yes that was my understanding actually.
> 
> Another question is how do you handle the reserved RID_PASID
> requirement?
> 
We always use PASID 0 for request w/o PASID, so it does not go through
the allocator.
 #define PASID_RID2PASID			0x0

>  QEMU does not support multiple PCI segments/domains
> > afaik but others might.  
>  [...]  
>  [...]  
> > Yes, more clear this way.
> >   
>  [...]  
> >> is already in use?  
>  [...]  
> >> s/The reason is that custom allocator/The reason is that custom
> >> allocators  
>  [...]  
> >> This last sentence may be moved to the unregister() kerneldoc  
>  [...]  
> >> The fact the first registered custom allocator gets automatically
> >> active was not obvious to me and may deserve a comment.  
>  [...]  
>  [...]  
>  [...]  
>  [...]  
>  [...]  
>  [...]  
>  [...]  
> >> At this stage it is difficult to assess whether using a BUG_ON() is
> >> safe here. Who is responsible for freeing the IOASIDs?  
>  [...]  
>  [...]  
> >> s/data also sanitiy check/data, also sanity check  
> >>> +		 */
> >>> +		min = id;
> >>> +		max = id + 1;
> >>> +	} else
> >>> +		default_allocator_used = 1;    
> >> shouldn't default_allocator_used be protected as well?  
>  [...]  
> >> wouldn't it be possible to integrate the default io asid allocator
> >> as any custom allocator, ie. implement an alloc callback using
> >> xa_alloc. Then the active io allocator could be either a custom or
> >> a default one.  
> > That is an interesting idea. I think it is possible.
> > But since default xa allocator is internal to ioasid infrastructure,
> > why implement it as a callback?  
> 
> I mean your could directly define a static const default_allocator in
> ioasid.c and assign it by default. Do I miss something?
> 
got it, seems cleaner. let me give it a try.

Thanks

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
