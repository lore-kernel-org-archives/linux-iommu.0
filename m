Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB1CC43331
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 02:51:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CFE2074D
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 02:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CFE2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CCD2389416;
	Fri, 27 Mar 2020 02:51:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XOX509CDxx1Q; Fri, 27 Mar 2020 02:51:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4FDDE89407;
	Fri, 27 Mar 2020 02:50:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 305C7C1831;
	Fri, 27 Mar 2020 02:50:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2142C0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 02:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BB909887BE
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 02:50:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OFmpLS1a02CC for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 02:50:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A2D9E88762
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 02:50:23 +0000 (UTC)
IronPort-SDR: t/LMy3ZAJX+wTr3RPtJ29SauqE0o9MQd6lLbhMOjlH9vP7xRHbGsyWUf4rZR7mSJn3+ZZdCy2N
 I/uBNc53Arvg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2020 19:50:23 -0700
IronPort-SDR: CHlZ3MPtzD1Hv8X8cXbqnrKK43/lz90izk92jfpDHQetDs0JwMhrpSMHDBm2N7M2lCTO3+byiq
 tVNAt+JykFiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,310,1580803200"; d="scan'208";a="241167286"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga008.jf.intel.com with ESMTP; 26 Mar 2020 19:50:22 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 19:50:22 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Mar 2020 19:50:21 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 19:50:21 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.145]) with mapi id 14.03.0439.000;
 Fri, 27 Mar 2020 10:49:55 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Christoph Hellwig
 <hch@infradead.org>
Subject: RE: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Thread-Topic: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Thread-Index: AQHWAvq+z2SPyfblHkGvV1oKjQsO9ahaFEoAgAB7VgCAAS14gA==
Date: Fri, 27 Mar 2020 02:49:55 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ECB45@SHSMSX104.ccr.corp.intel.com>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585178227-17061-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200326092316.GA31648@infradead.org>
 <20200326094442.5be042ce@jacob-builder>
In-Reply-To: <20200326094442.5be042ce@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
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

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Friday, March 27, 2020 12:45 AM
> 
> Hi Christoph,
> 
> Thanks for the review. Please see my comments inline.
> 
> On Thu, 26 Mar 2020 02:23:16 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Wed, Mar 25, 2020 at 04:17:05PM -0700, Jacob Pan wrote:
> > > Having a single UAPI version to govern the user-kernel data
> > > structures makes compatibility check straightforward. On the
> > > contrary, supporting combinations of multiple versions of the data
> > > can be a nightmare to maintain.
> > >
> > > This patch defines a unified UAPI version to be used for
> > > compatibility checks between user and kernel.
> >
> > This is bullshit.  Version numbers don't scale and we've avoided them
> > everywhere.  You need need flags specifying specific behavior.
> >
> We have flags or the equivalent in each UAPI structures. The flags
> are used for checking validity of extensions as well. And you are right
> we can use them for checking specific behavior.
> 
> So we have two options here:
> 1. Have a overall version for a quick compatibility check while
> starting a VM. If not compatible, we will stop guest SVA entirely.
> 
> 2. Let each API calls check its own capabilities/flags at runtime. It
> may fail later on and lead to more complex error handling.
> For example, guest starts with SVA support, allocate a PASID, bind
> guest PASID works great. Then when IO page fault happens, it try to do
> page request service and found out certain flags are not compatible.
> This case is more complex to handle.

If those API calls are inter-dependent for composing a feature (e.g. SVA),
shouldn't we need a way to check them together before exposing the 
feature to the guest, e.g. through a iommu_get_uapi_capabilities interface?

> 
> I am guessing your proposal is #2. right?
> 
> Overall, we don;t expect much change to the UAPI other than adding some
> vendor specific part of the union. Is the scalability concern based on
> frequent changes?
> 
> > > +#define IOMMU_UAPI_VERSION	1
> > > +static inline int iommu_get_uapi_version(void)
> > > +{
> > > +	return IOMMU_UAPI_VERSION;
> > > +}
> >
> > Also inline functions like this in UAPI headers that actually get
> > included by userspace programs simply don't work.
> 
> I will remove that, user can just use IOMMU_UAPI_VERSION directly.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
