Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93A3C63798
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 13:03:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 366C12080A
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 13:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCepca15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366C12080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BF85386084;
	Mon, 23 Nov 2020 13:03:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AIt8xQWq4PGV; Mon, 23 Nov 2020 13:03:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 49EDA86004;
	Mon, 23 Nov 2020 13:03:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25980C163C;
	Mon, 23 Nov 2020 13:03:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EED35C0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 13:03:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BCA558704D
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 13:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eSKDPPV5KSQi for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 13:03:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0CF638704A
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 13:03:42 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A49CA2075A;
 Mon, 23 Nov 2020 13:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606136621;
 bh=SgFY9Gwsrv3cNr7rUy8goxKDpPOG69zeXOVMmE/645Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZCepca15RXI93b6UId4XfpVNUKZvC1BVdBowf9oVGXzYgQKXnu1ZEvpBxY6+URyr+
 9Mskf+4qf6955vyhKyya/dAiiOzJpNEeUbgfYUQuKxLS7tSOhiJkK0izBSvY/eTzus
 PbkA1Nkrn9dBkqI2hJalKLYUgbaxwJcu+urJZajc=
Date: Mon, 23 Nov 2020 13:03:36 +0000
From: Will Deacon <will@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v9 1/4] iommu: Move def_domain type check for untrusted
 device into core
Message-ID: <20201123130335.GD10233@willie-the-truck>
References: <20201121135620.3496419-1-baolu.lu@linux.intel.com>
 <20201121135620.3496419-2-baolu.lu@linux.intel.com>
 <20201123120449.GB10233@willie-the-truck>
 <5f6f0d5e-0cfc-2274-b186-180f50b8b1df@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5f6f0d5e-0cfc-2274-b186-180f50b8b1df@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

Hi Baolu,

On Mon, Nov 23, 2020 at 08:55:17PM +0800, Lu Baolu wrote:
> On 2020/11/23 20:04, Will Deacon wrote:
> > On Sat, Nov 21, 2020 at 09:56:17PM +0800, Lu Baolu wrote:
> > > @@ -1645,13 +1655,10 @@ struct __group_domain_type {
> > >   static int probe_get_default_domain_type(struct device *dev, void *data)
> > >   {
> > > -	const struct iommu_ops *ops = dev->bus->iommu_ops;
> > >   	struct __group_domain_type *gtype = data;
> > >   	unsigned int type = 0;
> > > -	if (ops->def_domain_type)
> > > -		type = ops->def_domain_type(dev);
> > > -
> > > +	type = iommu_get_mandatory_def_domain_type(dev);
> > 
> > afaict, this code is only called from probe_alloc_default_domain(), which
> > has:
> > 
> >          /* Ask for default domain requirements of all devices in the group */
> >          __iommu_group_for_each_dev(group, &gtype,
> >                                     probe_get_default_domain_type);
> > 
> >          if (!gtype.type)
> >                  gtype.type = iommu_def_domain_type;
> > 
> > so is there actually a need to introduce the new
> > iommu_get_mandatory_def_domain_type() function, given that a type of 0
> > always ends up resolving to the default domain type?
> 
> Another consumer of this helper is in the next patch:
> 
> +	dev_def_dom = iommu_get_mandatory_def_domain_type(dev);
> +
> +	/* Check if user requested domain is supported by the device or not */
> +	if (!type) {
> +		/*
> +		 * If the user hasn't requested any specific type of domain and
> +		 * if the device supports both the domains, then default to the
> +		 * domain the device was booted with
> +		 */
> +		type = iommu_get_def_domain_type(dev);
> +	} else if (dev_def_dom && type != dev_def_dom) {
> +		dev_err_ratelimited(prev_dev, "Device cannot be in %s domain\n",
> +				    iommu_domain_type_str(type));
> +		ret = -EINVAL;
> +		goto out;
> +	}
> 
> I also added the untrusted device check in
> iommu_get_mandatory_def_domain_type(), so that we don't need to care
> about this in multiple places.

I see, but isn't this also setting the default domain type in the case that
it gets back a type of 0? I think it would be nice to avoid having both
iommu_get_mandatory_def_domain_type() and iommu_get_def_domain_type() of we
can, as it's really not clear which one to use when and what is meant by
"mandatory" imo.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
