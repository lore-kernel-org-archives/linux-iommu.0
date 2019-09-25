Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD6CC432C1
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 07:35:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F643217F4
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 07:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F643217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 678EABA9;
	Wed, 25 Sep 2019 07:35:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 54663B59
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 07:35:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 54B608A0
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 07:35:26 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Sep 2019 00:35:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,547,1559545200"; d="scan'208";a="188706169"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
	by fmsmga008.fm.intel.com with ESMTP; 25 Sep 2019 00:35:26 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
	FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Wed, 25 Sep 2019 00:35:25 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
	FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Wed, 25 Sep 2019 00:35:25 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
	SHSMSX152.ccr.corp.intel.com ([169.254.6.132]) with mapi id
	14.03.0439.000; Wed, 25 Sep 2019 15:35:23 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Peter Xu <peterx@redhat.com>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: RE: [RFC PATCH 4/4] iommu/vt-d: Identify domains using first level
	page table
Thread-Topic: [RFC PATCH 4/4] iommu/vt-d: Identify domains using first level
	page table
Thread-Index: AQHVcgpG/pXRrE8O1EK3Luw5SA+K6qc7cLwAgACSPnA=
Date: Wed, 25 Sep 2019 07:35:23 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D58F50F@SHSMSX104.ccr.corp.intel.com>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
	<20190923122454.9888-5-baolu.lu@linux.intel.com>
	<20190925065006.GN28074@xz-x1>
In-Reply-To: <20190925065006.GN28074@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWNjOWZjYmUtYzc2MS00MjE2LWJkYmYtYzU2YTdhNGI0OWMyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSnozQ1pmXC9STHptMktYYkRDZzRUWjJ6MUk0bzJ2NWgzcXIxXC9pK05WeW1VRkg5K2FVUWJyVG9jcUQyenU4cmdWIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: Yi Sun <yi.y.sun@linux.intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, "Sun, Yi Y" <yi.y.sun@intel.com>
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

> From: Peter Xu [mailto:peterx@redhat.com]
> Sent: Wednesday, September 25, 2019 2:50 PM
> 
> On Mon, Sep 23, 2019 at 08:24:54PM +0800, Lu Baolu wrote:
> > +/*
> > + * Check and return whether first level is used by default for
> > + * DMA translation.
> > + */
> > +static bool first_level_by_default(void)
> > +{
> > +	struct dmar_drhd_unit *drhd;
> > +	struct intel_iommu *iommu;
> > +
> > +	rcu_read_lock();
> > +	for_each_active_iommu(iommu, drhd)
> > +		if (!sm_supported(iommu) ||
> > +		    !ecap_flts(iommu->ecap) ||
> > +		    !cap_caching_mode(iommu->cap))
> > +			return false;
> > +	rcu_read_unlock();
> > +
> > +	return true;
> > +}
> 
> "If no caching mode, then we will not use 1st level."
> 
> Hmm, does the vIOMMU needs to support caching-mode if with the
> solution you proposed here?  Caching mode is only necessary for
> shadowing AFAICT, and after all you're going to use full-nested,
> then... then I would think it's not needed.  And if so, with this
> patch 1st level will be disabled. Sounds like a paradox...
> 
> I'm thinking what would be the big picture for this to work now: For
> the vIOMMU, instead of exposing the caching-mode, I'm thinking maybe
> we should expose it with ecap.FLTS=1 while we can keep ecap.SLTS=0
> then it's natural that we can only use 1st level translation in the
> guest for all the domains (and I assume such an ecap value should
> never happen on real hardware, am I right?).
> 

yes, that's also the picture in my mind. :-)

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
