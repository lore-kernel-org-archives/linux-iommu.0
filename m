Return-Path: <SRS0=LOQj=BI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A9BC433DF
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 20:55:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406852074B
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 20:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406852074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 12C2F87E14;
	Wed, 29 Jul 2020 20:55:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dHgY0LlnoAsf; Wed, 29 Jul 2020 20:55:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4D3D887DFE;
	Wed, 29 Jul 2020 20:55:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D62BC004F;
	Wed, 29 Jul 2020 20:55:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B44A8C004D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 20:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9A8A386A3C
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 20:55:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2EzsdCvlmcQz for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jul 2020 20:55:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6C5FA86A15
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 20:55:27 +0000 (UTC)
IronPort-SDR: FBVjWDL4rjMQ78P2P2WBxiTlxnIWhv8maTng6ODG47dxtQeESUG90xNprZkFf5NrTcj0RRv4Sr
 uuQ9+pEMBb4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="151478332"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; d="scan'208";a="151478332"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 13:55:26 -0700
IronPort-SDR: 0DKM30f/id2JQ/CzHqYbno4kUOprMvG1Qm70P/dUa79Jylsb1npgZ7A6/qw2aMjACkNgSg4bLv
 J2FwDP+m5iDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; d="scan'208";a="304347308"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga002.jf.intel.com with ESMTP; 29 Jul 2020 13:55:26 -0700
Date: Wed, 29 Jul 2020 14:02:15 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v6 1/6] docs: IOMMU user API
Message-ID: <20200729140215.0f8c4aca@jacob-builder>
In-Reply-To: <MWHPR11MB1645BA0C8436C3280DBDC5468C700@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <1595525140-23899-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1595525140-23899-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200728131950.2aff140d@x1.home>
 <MWHPR11MB1645BA0C8436C3280DBDC5468C700@MWHPR11MB1645.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Jonathan
 Corbet <corbet@lwn.net>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@infradead.org>, Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Wed, 29 Jul 2020 01:18:04 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Wednesday, July 29, 2020 3:20 AM
> >   
> [...]
> > > +
> > > +For example, IOTLB invalidations should always succeed. There is
> > > no +architectural way to report back to the vIOMMU if the UAPI
> > > data is +incompatible. If that happens, in order to guarantee
> > > IOMMU iosolation,  
> > 
> > isolation
> >   
> > > +we have to resort to not giving completion status in vIOMMU.
> > > This may +result in VM hang.
> > > +
> > > +For this reason the following IOMMU UAPIs cannot fail without
> > > +catastrophic effect:
> > > +
> > > +1. Free PASID
> > > +2. Unbind guest PASID
> > > +3. Unbind guest PASID table (SMMU)
> > > +4. Cache invalidate  
> > 
> > I'm not entirely sure what we're trying to assert here.  Clearly
> > cache invalidation can fail and patch 5/6 goes on to add over a
> > dozen checks of the user provided data that return an -errno.  Any
> > user ioctl can fail if the user botches the parameters.  So are we
> > just trying to explain the feature checking that should allow the
> > user to know supported combinations and if they adhere to them,
> > these should not fail?  It's not quite worded to that effect.
> > Thanks, 
> 
> I guess the above wording is messed by what a UAPI should
> behave and whether the vIOMMU reports associated errors.
> UAPI can always fail, as you pointed out. vIOMMU may not
> have a matching error code though, e.g. on Intel VT-d there is no
> error reporting mechanism for cache invalidation. However,
> it is not wise to assert UAPI behavior according to vIOMMU
> definition. An error is an error. vIOMMU should just react to
> UAPI errors according to its architecture definition (e.g. ignore,
> forward to guest, hang, etc.). From this matter I feel above
> section could better be removed.
> 
Yes, I agreed, the scope is not drawn clearly. This section is kind of
the relic of a previous version where responsibility of feature
checking lies with IOMMU UAPI instead of VFIO.

How about just briefly mention that upfront feature checking is
encouraged to avoid complex and catastrophic error at runtime?

I will remove the rest.

> Thanks
> Kevin

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
