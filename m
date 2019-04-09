Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0424CC10F0E
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:38:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD42720833
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD42720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 91224DD1;
	Tue,  9 Apr 2019 17:38:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F31CCB8A
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:38:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9793C7A6
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:38:00 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Apr 2019 10:37:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,330,1549958400"; d="scan'208";a="335248361"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
	by fmsmga006.fm.intel.com with ESMTP; 09 Apr 2019 10:37:56 -0700
Received: from andy by smile with local (Exim 4.92)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1hDuh1-0006Nb-1D; Tue, 09 Apr 2019 20:37:55 +0300
Date: Tue, 9 Apr 2019 20:37:55 +0300
From: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 08/18] iommu: Introduce cache_invalidate API
Message-ID: <20190409173755.GX9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1554767973-30125-9-git-send-email-jacob.jun.pan@linux.intel.com>
	<20190409100718.GE9224@smile.fi.intel.com>
	<20190409094328.03731c3c@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190409094328.03731c3c@jacob-builder>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Message-ID: <20190409173755.tpwRANHRoPUfHQQaqVC2__UOguZPQDm_YWXS2D0qxjo@z>

On Tue, Apr 09, 2019 at 09:43:28AM -0700, Jacob Pan wrote:
> On Tue, 9 Apr 2019 13:07:18 +0300
> Andriy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Apr 08, 2019 at 04:59:23PM -0700, Jacob Pan wrote:

> > > +int iommu_cache_invalidate(struct iommu_domain *domain, struct
> > > device *dev,
> > > +			   struct iommu_cache_invalidate_info
> > > *inv_info) +{
> > > +	int ret = 0;  
> > 
> > Redundant assignment.
> > 
> I am not a security expert but initialization of local variable can be
> more secure.
> I was looking at this talk.
> https://outflux.net/slides/2018/lss/danger.pdf
> https://cwe.mitre.org/data/definitions/457.html

I hardly see any of these applied to your case here.
Care to show what I'm missing?

> > > +	if (unlikely(!domain->ops->cache_invalidate))
> > > +		return -ENODEV;
> > > +
> > > +	ret = domain->ops->cache_invalidate(domain, dev, inv_info);
> > > +
> > > +	return ret;
> > > +}  

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
