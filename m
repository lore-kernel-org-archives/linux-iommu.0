Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95038C2BA19
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 01:27:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621BF2076D
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 01:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621BF2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3919585FC7;
	Thu, 16 Apr 2020 01:27:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IsgzFC2-nqHk; Thu, 16 Apr 2020 01:27:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0FC388458E;
	Thu, 16 Apr 2020 01:27:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAC75C089E;
	Thu, 16 Apr 2020 01:27:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 001A6C0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 01:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DE8B587812
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 01:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G9hCZO0zYHgn for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 01:27:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1C199873E3
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 01:27:48 +0000 (UTC)
IronPort-SDR: pMqkSU3kyCBD374c0/cxmBocL4kSg6w1bradHEfXBMwl2tmTm5Y2mKWvdixvjrgx7BL0i5p78x
 q2jQMpF3pPHA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 18:27:47 -0700
IronPort-SDR: Wk3nxhxHRz6SOJx4koO+5TLJ19Tk+Xep0f/M6EQz7uv9hWQFF1lTYEQhkp3EGAYA81lqyf9aPT
 wg4pqRCeUC5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; d="scan'208";a="242491517"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga007.jf.intel.com with ESMTP; 15 Apr 2020 18:27:47 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 18:27:46 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 18:27:45 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.89]) with mapi id 14.03.0439.000;
 Thu, 16 Apr 2020 09:27:44 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Thread-Topic: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Thread-Index: AQHWAvq+z2SPyfblHkGvV1oKjQsO9ahaFEoAgAB7VgCAAS14gP//zqQAgAEODYCABAXlIIAALvMAgAFssACAACIBAIABY/uQgAHtwgCAEWzRgIAAG8+AgABw0ICAALrWAIAAEIMAgABZOwCAAJqrwIAAhCAAgAEpdxA=
Date: Thu, 16 Apr 2020 01:27:43 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D822943@SHSMSX104.ccr.corp.intel.com>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200326092316.GA31648@infradead.org>
 <20200326094442.5be042ce@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7ECB45@SHSMSX104.ccr.corp.intel.com>
 <20200327074702.GA27959@infradead.org>
 <20200327165335.397f24a3@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FE150@SHSMSX104.ccr.corp.intel.com>
 <20200330090746.23c5599c@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D8011A9@SHSMSX104.ccr.corp.intel.com>
 <20200331085444.44bee0bb@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D803AFF@SHSMSX104.ccr.corp.intel.com>
 <20200402113604.6eea1e6f@jacob-builder>
 <20200413134157.395981a6@jacob-builder>	<20200413162129.313b3b5a@w520.home>
 <20200413220515.25a107b6@jacob-builder>	<20200414101358.3ae66ac5@w520.home>
 <20200414101304.27e587eb@jacob-builder>
 <20200414153226.30d8cab3@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D81F901@SHSMSX104.ccr.corp.intel.com>
 <20200415083854.6fefac01@jacob-builder>
In-Reply-To: <20200415083854.6fefac01@jacob-builder>
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
> Sent: Wednesday, April 15, 2020 11:39 PM
> 
> On Tue, 14 Apr 2020 23:47:40 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Wednesday, April 15, 2020 6:32 AM
> > >
> > > On Tue, 14 Apr 2020 10:13:04 -0700
> > > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> > >
> > > > > > >  In any of the proposed solutions, the
> > > > > > > IOMMU driver is ultimately responsible for validating the
> > > > > > > user data, so do we want vfio performing the
> > > > > > > copy_from_user() to an object that could later be assumed
> > > > > > > to be sanitized, or should vfio just pass a user pointer to
> > > > > > > make it obvious that the consumer is responsible for all
> > > > > > > the user protections?  Seems like the latter.
> > > > > > I like the latter as well.
> > > > > >
> > > On a second thought, I think the former is better. Two reasons:
> > >
> > > 1. IOMMU API such as page_response is also used in baremetal. So it
> > > is not suitable to pass a __user *.
> > > https://www.spinics.net/lists/arm-kernel/msg798677.html
> >
> > You can have a wrapped version accepting a __user* and an internal
> > version for kernel pointers.
> >
> I have thought about that also but the problem is that some of the
> flags are processed in the vendor IOMMU ops so it is hard to do that in
> a generic wrapper.

All vendor IOMMU ops are defined in the same header file, so they
can be verified in one common IOMMU wrapper, just like how you
dealt with it in VFIO originally...

> 
> > >
> > > 2. Some data are in the mandatory (fixed offset, never removed or
> > > extended) portion of the uAPI structure. It is simpler for VFIO to
> > > extract that and pass it to IOMMU API. For example, the PASID value
> > > used for unbind_gpasid(). VFIO also need to sanitize the PASID
> > > value to make sure it belongs to the same VM that did the
> > > allocation.
> >
> > I don't think this makes much difference. If anyway you still plan to
> > let IOMMU driver parse some user pointers, why not making a clear
> > split to have it sparse all IOMMU specific fields?
> >
> The plan is not to have IOMMU driver parse user pointers. This is the
> "former" case in Alex's comment. I.e. vfio performing the
> copy_from_user based on argsz in IOMMU uAPI.
> 

I'm confused. I thought Alex proposed the latter one:
---[quote]
> So, __user * will be passed to IOMMU driver if VFIO checks minsz
> include flags and they are valid.
> IOMMU driver can copy the rest based on the mandatory version/minsz and
> flags in the IOMMU uAPI structs.
> Does it sound right? This is really choice #2.

Sounds like each IOMMU UAPI struct just needs to have an embedded size
and flags field, but yes.
----

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
