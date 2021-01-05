Return-Path: <SRS0=smho=GI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077F3C433E0
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 17:23:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885C822D3E
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 17:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885C822D3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 52A058522E;
	Tue,  5 Jan 2021 17:23:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EeLEE539cG1w; Tue,  5 Jan 2021 17:23:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D49D985010;
	Tue,  5 Jan 2021 17:23:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B587BC0891;
	Tue,  5 Jan 2021 17:23:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E5E1C013A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 17:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7C5E28511C
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 17:23:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dhp_kx1B0A3N for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 17:23:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 70EFD85010
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 17:23:54 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C6C722CF6;
 Tue,  5 Jan 2021 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609867434;
 bh=i2IODYjn+i46NdlesxUj5wRKx0YQu7Fw4OMe/pz2JfE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qWJxiJ78LfdEAThnVcRgqOg66D3pynto5T0vZBQ5bd76QQgE118KlI6FpwgLaTKll
 B+7EPkOg/AI5KvnI7cGoy3FUzmzlNcaKXYcWyQlcR22U7BZ1BV4briTr3AmHczSI9V
 uBFc00HE75Sd3YTyjyJiPe5YtZF+zQm2dhrn4JgDtUvA+snsHUDuvq7v+D/sfa6BJp
 X7vp4xSEx4kTz+zLcBwK+c8jpItKeQoy1BL6NHiDdapALG9dz5p2T+3InxjB7vjaVc
 nEvzOYUVF4Mmvy05D4sE+ZYkJqTXPpse2qcPXYlIbL0gPQfOFe8P/FLb9m0sxaEiS+
 phyRCu2chmn8w==
Date: Tue, 5 Jan 2021 17:23:49 +0000
From: Will Deacon <will@kernel.org>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 3/3] iommu/vt-d: Fix ineffective devTLB invalidation
 for subdevices
Message-ID: <20210105172348.GA12032@willie-the-truck>
References: <20201229032513.486395-1-yi.l.liu@intel.com>
 <20201229032513.486395-4-yi.l.liu@intel.com>
 <c109eb64-2805-5e87-2283-b52c5704a31f@linux.intel.com>
 <DM5PR11MB1435E814408F19A947263C07C3D10@DM5PR11MB1435.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM5PR11MB1435E814408F19A947263C07C3D10@DM5PR11MB1435.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>
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

On Tue, Jan 05, 2021 at 05:50:22AM +0000, Liu, Yi L wrote:
> > > +static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
> > > +				    u64 addr, unsigned int mask)
> > > +{
> > > +	u16 sid, qdep;
> > > +
> > > +	if (!info || !info->ats_enabled)
> > > +		return;
> > > +
> > > +	sid = info->bus << 8 | info->devfn;
> > > +	qdep = info->ats_qdep;
> > > +	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> > > +			   qdep, addr, mask);
> > > +}
> > > +
> > >   static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
> > >   				  u64 addr, unsigned mask)
> > >   {
> > > -	u16 sid, qdep;
> > >   	unsigned long flags;
> > >   	struct device_domain_info *info;
> > > +	struct subdev_domain_info *sinfo;
> > >
> > >   	if (!domain->has_iotlb_device)
> > >   		return;
> > >
> > >   	spin_lock_irqsave(&device_domain_lock, flags);
> > > -	list_for_each_entry(info, &domain->devices, link) {
> > > -		if (!info->ats_enabled)
> > > -			continue;
> > > +	list_for_each_entry(info, &domain->devices, link)
> > > +		__iommu_flush_dev_iotlb(info, addr, mask);
> > >
> > > -		sid = info->bus << 8 | info->devfn;
> > > -		qdep = info->ats_qdep;
> > > -		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> > > -				qdep, addr, mask);
> > > +	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
> > > +		__iommu_flush_dev_iotlb(get_domain_info(sinfo->pdev),
> > > +					addr, mask);
> > >   	}
> > 
> > Nit:
> > 	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
> > 		info = get_domain_info(sinfo->pdev);
> > 		__iommu_flush_dev_iotlb(info, addr, mask);
> > 	}
> 
> you are right. this should be better.

Please can you post a v4, with Lu's acks and the issue reported by Dan fixed
too?

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
