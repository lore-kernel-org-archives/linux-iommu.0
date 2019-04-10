Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBF9C10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 21:19:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D60782082A
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 21:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60782082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A1036191D;
	Wed, 10 Apr 2019 21:19:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8481E1E40
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 21:18:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F065C174
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 21:18:56 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Apr 2019 14:18:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,334,1549958400"; d="scan'208";a="290458712"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga004.jf.intel.com with ESMTP; 10 Apr 2019 14:18:55 -0700
Date: Wed, 10 Apr 2019 14:21:31 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 08/18] iommu: Introduce cache_invalidate API
Message-ID: <20190410142131.50ee2e44@jacob-builder>
In-Reply-To: <20190409173755.GX9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1554767973-30125-9-git-send-email-jacob.jun.pan@linux.intel.com>
	<20190409100718.GE9224@smile.fi.intel.com>
	<20190409094328.03731c3c@jacob-builder>
	<20190409173755.GX9224@smile.fi.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Liu, Yi L" <yi.l.liu@linux.intel.com>, "Tian,
	Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Liu@smile.fi.intel.com, David Woodhouse <dwmw2@infradead.org>
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
Message-ID: <20190410212131.E9dR7KW5efQAeB0SHDtuaAG2A85YLKrkwZqr74M6ifE@z>

On Tue, 9 Apr 2019 20:37:55 +0300
Andriy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Apr 09, 2019 at 09:43:28AM -0700, Jacob Pan wrote:
> > On Tue, 9 Apr 2019 13:07:18 +0300
> > Andriy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> > > On Mon, Apr 08, 2019 at 04:59:23PM -0700, Jacob Pan wrote:  
> 
> > > > +int iommu_cache_invalidate(struct iommu_domain *domain, struct
> > > > device *dev,
> > > > +			   struct iommu_cache_invalidate_info
> > > > *inv_info) +{
> > > > +	int ret = 0;    
> > > 
> > > Redundant assignment.
> > >   
> > I am not a security expert but initialization of local variable can
> > be more secure.
> > I was looking at this talk.
> > https://outflux.net/slides/2018/lss/danger.pdf
> > https://cwe.mitre.org/data/definitions/457.html  
> 
> I hardly see any of these applied to your case here.
> Care to show what I'm missing?
> 
I thought your comments was that I should not need to initialize local
variable ret = 0. Always initialize local variable can be a good
security practice as suggested in the paper. Perhaps I missed
something :)
> > > > +	if (unlikely(!domain->ops->cache_invalidate))
> > > > +		return -ENODEV;
> > > > +
> > > > +	ret = domain->ops->cache_invalidate(domain, dev,
> > > > inv_info); +
> > > > +	return ret;
> > > > +}    
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
