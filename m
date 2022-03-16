Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349A6C433F5
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 20:46:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA87860F6A;
	Wed, 16 Mar 2022 20:46:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HDHnuw3FW84j; Wed, 16 Mar 2022 20:46:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8D30860BC6;
	Wed, 16 Mar 2022 20:46:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FFFCC001A;
	Wed, 16 Mar 2022 20:46:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4042CC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 20:46:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 19CFE60BFF
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 20:46:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k_OnDxEcYfd0 for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 20:46:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 46F1660BC6
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 20:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647463611; x=1678999611;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=amVRG1zmPs9HJDAJXGSv/XhAzDgNn5MXqtThTcMFz2o=;
 b=ZLMoLh3VMfl8+3IqEeWdDqzsjV1Cg6XYT7Rq+80Edo1uhJD2lLgpF29b
 5qnbxG2VJuvBMaGIFp6w4znlmOdshmn7cFcK0DQi8BxOVoXLXw1gQ9Vhj
 qEys2AJSoUi9DMUvZlaXk0vZStl6DEGSg9dQ2Am6+8jre7YbDRbqoN+0L
 PyB4RGxCla1vVY1KR9/DsJJxgnkmzOy0b+qknfHCNoLNSINoHZSpSPMfZ
 c+8uqP0Tztyx1ON5z5R+ef8P6KEt19ZhUmEqcKy382Ddh9gT0A4/KRSPf
 PDYB/fdZ4szgneQVvZ0o/k62jlNIlEOaAxZpC3YIpg1bxH4GxaDMoiHs1 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="244161191"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="244161191"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 13:46:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="513175592"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 13:46:48 -0700
Date: Wed, 16 Mar 2022 13:50:04 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Message-ID: <20220316135004.61ae1611@jacob-builder>
In-Reply-To: <20220315230457.GO11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
 <20220315143322.GW11336@nvidia.com>
 <20220315153620.710a30fa@jacob-builder>
 <20220315230457.GO11336@nvidia.com>
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

On Tue, 15 Mar 2022 20:04:57 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Mar 15, 2022 at 03:36:20PM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Tue, 15 Mar 2022 11:33:22 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > On Mon, Mar 14, 2022 at 10:07:07PM -0700, Jacob Pan wrote:  
> > > > +	/*
> > > > +	 * Each domain could have multiple devices attached with
> > > > shared or per
> > > > +	 * device PASIDs. At the domain level, we keep track of
> > > > unique PASIDs and
> > > > +	 * device user count.
> > > > +	 * E.g. If a domain has two devices attached, device A has
> > > > PASID 0, 1;
> > > > +	 * device B has PASID 0, 2. Then the domain would have
> > > > PASID 0, 1, 2.
> > > > +	 */    
> > > 
> > > A 2d array of xarray's seems like a poor data structure for this task.
> > > 
> > > AFACIT this wants to store a list of (device, pasid) tuples, so a
> > > simple linked list, 1d xarray vector or a red black tree seems more
> > > appropriate..
> > >   
> > Agreed.
> > It might need some surgery for dmar_domain and device_domain_info, which
> > already has a simple device list. I am trying to leverage the existing
> > data struct, let me take a closer look.  
> 
> Maybe the core code should provide this data structure in the
> iommu_domain.
> 
> Figuring out what stuff is attached is something every driver has to
> do right?
yeah, seems we already have some duplicated device list in vendor domain
struct, e.g. VT-d's dmar_domain, AMD's protection_domain. Similarly for 
device_domain_info equivalent.

If core code provides domain-device-pasid tracking, we could do device-pasid
tracking in ioasid.c, when we support per device PASID allocation, each
phy device could be an IOASID set, thus its own namespace.

Perhaps, we could do the following: add a device list to struct
iommu_domain, this will replace vender's domain lists. The data would be
something like:
struct iommu_dev_pasid_data {
	struct list_head list;	  /* For iommu_domain->dev_list */
	struct ioasid_set *pasids;  /* For the PASIDs used by the device */
	struct device *dev;
};

I guess a list of (device, pasid) tuples as you suggested could work but it
will have duplicated device entries since each device could have multiple
PASIDs. right?

Have to code this up to see.

Thanks for the pointers,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
