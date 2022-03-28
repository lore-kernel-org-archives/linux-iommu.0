Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96652C433EF
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 21:38:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33F6360F4C;
	Mon, 28 Mar 2022 21:38:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nXmO_Yult95F; Mon, 28 Mar 2022 21:38:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC6D160FBF;
	Mon, 28 Mar 2022 21:38:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEF62C001D;
	Mon, 28 Mar 2022 21:38:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9149EC0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 21:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7025240213
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 21:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KNBQV_Qg35Xv for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 21:38:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4BAC34014A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 21:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648503514; x=1680039514;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MoJJ7PpyY30zJiWm4s27HVjf2QmYd2IbqH48aFV+r4o=;
 b=K2r/qAXzWarpVx8KS+lKtIkwnGZjziZwkFKg8tGErJKFkW4SppVlBG/a
 2WH+y7/XmDUcypwtHS8pGV15VcFjX4dt2gkUhP7Y2gkHAUsFeTOhln3Sy
 pEyMKyorF0ikiWFjYVUv2uwqC1DJEOIsnTocRdnURFZbAsdwd4c7l7xXO
 tVgauMqYwvTJHlrbCsChWxu2jj/OF+9O8PWrzLQvmHn+grj9u75yPKofc
 GPxb9MfvVs9S6/IV7KLAUhfsovJDJY7j71cqS2rxzt626wCRFKR+xXsxl
 ClJ+opMx156fWUinWseyK73ipZKaouBEFsGjZ4+bV+Sj1VzOkJUs6b6D+ A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="259295124"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; d="scan'208";a="259295124"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2022 14:38:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; d="scan'208";a="564026275"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2022 14:38:33 -0700
Date: Mon, 28 Mar 2022 14:41:56 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Message-ID: <20220328144156.66ba6f39@jacob-builder>
In-Reply-To: <BN9PR11MB5276FF347A54098F469936978C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
 <20220315143322.GW11336@nvidia.com>
 <BN9PR11MB5276E98AE37EA912B01EB0B68C119@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220316140140.76bb24c6@jacob-builder>
 <BN9PR11MB5276FF347A54098F469936978C139@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Luck, Tony" <tony.luck@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
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

Hi Kevin,

On Fri, 18 Mar 2022 05:33:38 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan
> > Sent: Thursday, March 17, 2022 5:02 AM
> > 
> > Hi Kevin,
> > 
> > On Wed, 16 Mar 2022 07:41:34 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> > wrote:
> >   
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Tuesday, March 15, 2022 10:33 PM
> > > >
> > > > On Mon, Mar 14, 2022 at 10:07:07PM -0700, Jacob Pan wrote:  
> > > > > +	/*
> > > > > +	 * Each domain could have multiple devices attached with
> > > > > shared or  
> > > > per  
> > > > > +	 * device PASIDs. At the domain level, we keep track of
> > > > > unique PASIDs  
> > > > and  
> > > > > +	 * device user count.
> > > > > +	 * E.g. If a domain has two devices attached, device A
> > > > > has PASID 0, 1;
> > > > > +	 * device B has PASID 0, 2. Then the domain would have
> > > > > PASID 0, 1, 2.
> > > > > +	 */  
> > > >
> > > > A 2d array of xarray's seems like a poor data structure for this
> > > > task.  
> > >  
> > Perhaps i mis-presented here, I am not using 2D array. It is an 1D
> > xarray for domain PASIDs only. Then I use the existing device list in
> > each domain, adding another xa to track per-device-domain PASIDs.  
> > > besides that it also doesn't work when we support per-device PASID
> > > allocation in the future. In that case merging device PASIDs together
> > > is conceptually wrong.
> > >  
> > Sorry, could you elaborate? If we do per-dev PASID allocation, we could
> > use the ioasid_set for each pdev, right?  
> 
> My point is simply about the comment above which says the domain
> will have PASID 0, 1, 2 when there is [devA, PASID0] and [devB, PASID0].
> You can maintain a single  PASID list only when it's globally allocated
> cross devices. otherwise this has to be a tuple including device and
> PASID.
> 
Got you, you are right we don't want to limit to globally allocated scheme.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
