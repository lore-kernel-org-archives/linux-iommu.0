Return-Path: <SRS0=6vqp=5Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225DBC2D0EF
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 06:06:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED2B420748
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 06:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED2B420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B167F86490;
	Tue, 31 Mar 2020 06:06:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g2tA5JmE42WW; Tue, 31 Mar 2020 06:06:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ED2C385F15;
	Tue, 31 Mar 2020 06:06:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0B42C1D90;
	Tue, 31 Mar 2020 06:06:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C88EC1D8D
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 06:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7B82824B85
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 06:06:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sRRcWXTr70A8 for <iommu@lists.linux-foundation.org>;
 Tue, 31 Mar 2020 06:06:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 0618420004
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 06:06:41 +0000 (UTC)
IronPort-SDR: bAT/G6eOOh3hgesY+vYLttCEeol8BxN0sntzvCjZqXMdCoSz7CuhYLRv/Wu1lVfJJ1xavuA9M+
 Gz2LoS5HUGeA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 23:06:41 -0700
IronPort-SDR: J6huhyhGhOkmDuoqZEOkpb0JECRSVTko7DSCE/TudLhGxJ1l4uWL8X1U5Qab8kKGLjp/6wljFR
 ZCzBY0OcWWtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; d="scan'208";a="294830873"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2020 23:06:41 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 23:06:41 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 30 Mar 2020 23:06:41 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 30 Mar 2020 23:06:40 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.22]) with mapi id 14.03.0439.000;
 Tue, 31 Mar 2020 14:06:39 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Thread-Topic: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Thread-Index: AQHWAvq+z2SPyfblHkGvV1oKjQsO9ahaFEoAgAB7VgCAAS14gP//zqQAgAEODYCABAXlIIAALvMAgAFssAA=
Date: Tue, 31 Mar 2020 06:06:38 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D8011A9@SHSMSX104.ccr.corp.intel.com>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585178227-17061-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200326092316.GA31648@infradead.org>
 <20200326094442.5be042ce@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7ECB45@SHSMSX104.ccr.corp.intel.com>
 <20200327074702.GA27959@infradead.org>
 <20200327165335.397f24a3@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FE150@SHSMSX104.ccr.corp.intel.com>
 <20200330090746.23c5599c@jacob-builder>
In-Reply-To: <20200330090746.23c5599c@jacob-builder>
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
> Sent: Tuesday, March 31, 2020 12:08 AM
> 
> On Mon, 30 Mar 2020 05:40:40 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Saturday, March 28, 2020 7:54 AM
> > >
> > > On Fri, 27 Mar 2020 00:47:02 -0700
> > > Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > > On Fri, Mar 27, 2020 at 02:49:55AM +0000, Tian, Kevin wrote:
> > > > > If those API calls are inter-dependent for composing a feature
> > > > > (e.g. SVA), shouldn't we need a way to check them together
> > > > > before exposing the feature to the guest, e.g. through a
> > > > > iommu_get_uapi_capabilities interface?
> > > >
> > > > Yes, that makes sense.  The important bit is to have a capability
> > > > flags and not version numbers.
> > >
> > > The challenge is that there are two consumers in the kernel for
> > > this. 1. VFIO only look for compatibility, and size of each data
> > > struct such that it can copy_from_user.
> > >
> > > 2. IOMMU driver, the "real consumer" of the content.
> > >
> > > For 2, I agree and we do plan to use the capability flags to check
> > > content and maintain backward compatibility etc.
> > >
> > > For VFIO, it is difficult to do size look up based on capability
> > > flags.
> >
> > Can you elaborate the difficulty in VFIO? if, as Christoph Hellwig
> > pointed out, version number is already avoided everywhere, it is
> > interesting to know whether this work becomes a real exception
> > or just requires a different mindset.
> >
> From VFIO p.o.v. the IOMMU UAPI data is opaque, it only needs to do two
> things:
> 1. is the UAPI compatible?
> 2. what is the size to copy?
> 
> If you look at the version number, this is really a "version as size"
> lookup, as provided by the helper function in this patch. An example
> can be the newly introduced clone3 syscall.
> https://lwn.net/Articles/792628/
> In clone3, new version must have new size. The slight difference here
> is that, unlike clone3, we have multiple data structures instead of a
> single struct clone_args {}. And each struct has flags to enumerate its
> contents besides size.

Thanks for providing that link. However clone3 doesn't include a version
field to do "version as size" lookup. Instead, as you said, it includes a
size parameter which sounds like the option 3 (argsz) listed below.

> 
> Besides breaching data abstraction, if VFIO has to check IOMMU flags to
> determine the sizes, it has many combinations.
> 
> We also separate the responsibilities into two parts
> 1. compatibility - version, size by VFIO
> 2. sanity check - capability flags - by IOMMU

I feel argsz+flags approach can perfectly meet above requirement. The
userspace set the size and flags for whatever capabilities it uses, and
VFIO simply copies the parameters by size and pass to IOMMU for
further sanity check. Of course the assumption is that we do provide
an interface for userspace to enumerate all supported capabilities.

Is there anything that I overlooked here? I suppose there might be
some difficulties that block you from going the argsz way...

Thanks
Kevin

> 
> I think the latter matches what Christoph's comments. So we are in
> agreement at the IOMMU level :)
> 
> For example:
> During guest PASID bind, IOMMU driver operates on the data passed from
> VFIO and check format & flags to take different code path.
> 
> #define IOMMU_PASID_FORMAT_INTEL_VTD	1
> 	__u32 format;
> #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> 	__u64 flags;
> 
> Jacob
> 
> > btw the most relevant discussion which I can find out now is here:
> > 	https://lkml.org/lkml/2020/2/3/1126
> >
> > It mentioned 3 options for handling extension:
> > --
> > 1. Disallow adding new members to each structure other than reuse
> > padding bits or adding union members at the end.
> > 2. Allow extension of the structures beyond union, but union size has
> > to be fixed with reserved spaces
> > 3. Adopt VFIO argsz scheme, I don't think we need version for each
> > struct anymore. argsz implies the version that user is using assuming
> > UAPI data is extension only.
> > --
> >
> > the first two are both version-based. Looks most guys agreed with
> > option-1 (in this v2), but Alex didn't give his opinion at the
> > moment. The last response from him was the raise of option-3 using
> > argsz to avoid version. So, we also need hear from him. Alex?
> >
> > Thanks
> > Kevin
> 
> [Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
