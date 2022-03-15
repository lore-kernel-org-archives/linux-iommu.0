Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C43C433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 22:33:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0FBA040571;
	Tue, 15 Mar 2022 22:33:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AU9odXAd45iV; Tue, 15 Mar 2022 22:33:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 747994057F;
	Tue, 15 Mar 2022 22:33:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36996C001D;
	Tue, 15 Mar 2022 22:33:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F953C0012
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 22:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F14F960ECC
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 22:33:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9qFczhEzYGZ1 for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 22:33:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 23C2260D95
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 22:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647383586; x=1678919586;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OwBLenYoHPXhCBJxzxgniCNW9JRsFisichsORrmXtio=;
 b=R05t2Q21sRrFuD8N0L3hD2vQHYemSNY/x39kpszx6iYekM1DBRe5ChQQ
 nZpctGElSgoAvxVlVIucpn0tZZXsSaPm6t4Nl7Ggas0TaMdOgzeEuInuz
 +DVKMlOnGO3titOxEevF0KVti+qgGMdLLeaBH0bPaS4swezcNVj9IXPY4
 Je3dwsjCH0alQDjDPh+So01GzF8tS14Gc4/rHMJMfo5lFmzhihIvRgNBv
 SIKGyj2q2qBgdhJfJmE6wT/3vaDxfnI//xbCPCxWIrvvwGejJadSf6/T2
 LMRMW+0VsjpGB87YqRqCuLa8yXpwzpq9UYzcnfC2Qpx9IEbXA9mrUASx2 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="253995354"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; d="scan'208";a="253995354"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 15:33:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; d="scan'208";a="783241755"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 15:33:04 -0700
Date: Tue, 15 Mar 2022 15:36:20 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Message-ID: <20220315153620.710a30fa@jacob-builder>
In-Reply-To: <20220315143322.GW11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
 <20220315143322.GW11336@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Zanussi, 
 Tom" <tom.zanussi@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

Hi Jason,

On Tue, 15 Mar 2022 11:33:22 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Mar 14, 2022 at 10:07:07PM -0700, Jacob Pan wrote:
> > +	/*
> > +	 * Each domain could have multiple devices attached with
> > shared or per
> > +	 * device PASIDs. At the domain level, we keep track of unique
> > PASIDs and
> > +	 * device user count.
> > +	 * E.g. If a domain has two devices attached, device A has
> > PASID 0, 1;
> > +	 * device B has PASID 0, 2. Then the domain would have PASID
> > 0, 1, 2.
> > +	 */  
> 
> A 2d array of xarray's seems like a poor data structure for this task.
> 
> AFACIT this wants to store a list of (device, pasid) tuples, so a
> simple linked list, 1d xarray vector or a red black tree seems more
> appropriate..
> 
Agreed.
It might need some surgery for dmar_domain and device_domain_info, which
already has a simple device list. I am trying to leverage the existing data
struct, let me take a closer look.

> > +	if (entry) {
> > +		pinfo = entry;
> > +	} else {
> > +		pinfo = kzalloc(sizeof(*pinfo), GFP_ATOMIC);
> > +		if (!pinfo)
> > +			return -ENOMEM;
> > +		pinfo->pasid = pasid;
> > +		/* Store the new PASID info in the per domain array */
> > +		ret = xa_err(__xa_store(&dmar_domain->pasids, pasid,
> > pinfo,
> > +			     GFP_ATOMIC));
> > +		if (ret)
> > +			goto xa_store_err;
> > +	}
> > +	/* Store PASID in per device-domain array, this is for
> > tracking devTLB */
> > +	ret = xa_err(xa_store(&info->pasids, pasid, pinfo,
> > GFP_ATOMIC));
> > +	if (ret)
> > +		goto xa_store_err;
> > +
> > +	atomic_inc(&pinfo->users);
> > +	xa_unlock(&dmar_domain->pasids);
> > +
> > +	return 0;
> > +
> > +xa_store_err:
> > +	xa_unlock(&dmar_domain->pasids);
> > +	spin_lock_irqsave(&iommu->lock, flags);
> > +	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> > +	spin_unlock_irqrestore(&iommu->lock, flags);
> > +
> > +	if (!atomic_read(&pinfo->users)) {
> > +		__xa_erase(&dmar_domain->pasids, pasid);  
> 
> This isn't locked right
> 
good catch! need to move under xa_unlock.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
