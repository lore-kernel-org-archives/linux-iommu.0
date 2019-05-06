Return-Path: <SRS0=Zlue=TG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E683C04A6B
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 17:58:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF6F20675
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 17:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF6F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 545234B1F;
	Mon,  6 May 2019 17:58:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D6E244953
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 17:57:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7BB5CFD
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 17:57:03 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 May 2019 10:57:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; d="scan'208";a="297649416"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga004.jf.intel.com with ESMTP; 06 May 2019 10:57:02 -0700
Date: Mon, 6 May 2019 10:59:51 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 08/19] ioasid: Add custom IOASID allocator
Message-ID: <20190506105951.472ac4fd@jacob-builder>
In-Reply-To: <20190426081903.164dcff3@jacob-builder>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556062279-64135-9-git-send-email-jacob.jun.pan@linux.intel.com>
	<4ef22c62-0947-8de5-3288-2835ce5fa7a9@redhat.com>
	<20190425142944.40661941@jacob-builder>
	<01fe1710-4022-0bf2-b2ff-307b15b9fabb@redhat.com>
	<20190426081903.164dcff3@jacob-builder>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, 26 Apr 2019 08:19:03 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> > >>> +		default_allocator_used = 1;      
> > >> shouldn't default_allocator_used be protected as well?    
> >  [...]    
> > >> wouldn't it be possible to integrate the default io asid
> > >> allocator as any custom allocator, ie. implement an alloc
> > >> callback using xa_alloc. Then the active io allocator could be
> > >> either a custom or a default one.    
> > > That is an interesting idea. I think it is possible.
> > > But since default xa allocator is internal to ioasid
> > > infrastructure, why implement it as a callback?    
> > 
> > I mean your could directly define a static const default_allocator
> > in ioasid.c and assign it by default. Do I miss something?
> >   
> got it, seems cleaner. let me give it a try.

Hi Eric,

Just sent out v3 last week. I did look into this but could not find a
clean way of making the default allocator as another custom allocator.
The reason is that default allocator is not interchangeable with
other custom allocators, XArray is shared. So it ends up having lots of
special cases anyway. Feel free to change this.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
