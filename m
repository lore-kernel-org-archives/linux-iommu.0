Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8466C43331
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 05:36:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B363B2074D
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 05:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B363B2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 808018A2B7;
	Wed,  1 Apr 2020 05:36:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L8MBRRfT0qwu; Wed,  1 Apr 2020 05:36:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 633E38A2C9;
	Wed,  1 Apr 2020 05:36:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D332C1D89;
	Wed,  1 Apr 2020 05:36:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4039BC1AE2
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 05:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2E47B88EE7
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 05:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id umUG_gIa3Idt for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 05:32:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 308C488EDA
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 05:32:25 +0000 (UTC)
IronPort-SDR: l2y8z7XO4rTyX5olJSuee4LxT8IC5OoqMUANOQTpy0hB2+eJN6/Rjnp1K4ixPpYvSs+y861QdZ
 GIabbFWGSppA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 22:32:24 -0700
IronPort-SDR: rRNDlEbmxX4+3bAhcoyohLz++3lRP7Sbg19yAvMYAjj8XmOxz4AqLrUH/r8idCM6hvu5OS7vuH
 O+iRvpjeYmpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,330,1580803200"; d="scan'208";a="240347396"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga007.fm.intel.com with ESMTP; 31 Mar 2020 22:32:24 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 22:32:24 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.213]) with mapi id 14.03.0439.000;
 Wed, 1 Apr 2020 13:32:21 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Thread-Topic: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Thread-Index: AQHWAvq+z2SPyfblHkGvV1oKjQsO9ahaFEoAgAB7VgCAAS14gP//zqQAgAEODYCABAXlIIAALvMAgAFssACAACIBAIABY/uQ
Date: Wed, 1 Apr 2020 05:32:21 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D803AFF@SHSMSX104.ccr.corp.intel.com>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585178227-17061-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200326092316.GA31648@infradead.org>
 <20200326094442.5be042ce@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7ECB45@SHSMSX104.ccr.corp.intel.com>
 <20200327074702.GA27959@infradead.org>
 <20200327165335.397f24a3@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FE150@SHSMSX104.ccr.corp.intel.com>
 <20200330090746.23c5599c@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D8011A9@SHSMSX104.ccr.corp.intel.com>
 <20200331085444.44bee0bb@jacob-builder>
In-Reply-To: <20200331085444.44bee0bb@jacob-builder>
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
> Sent: Tuesday, March 31, 2020 11:55 PM
> 
> On Tue, 31 Mar 2020 06:06:38 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Tuesday, March 31, 2020 12:08 AM
> > >
> > > On Mon, 30 Mar 2020 05:40:40 +0000
> > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > >
> > > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > Sent: Saturday, March 28, 2020 7:54 AM
> > > > >
> > > > > On Fri, 27 Mar 2020 00:47:02 -0700
> > > > > Christoph Hellwig <hch@infradead.org> wrote:
> > > > >
> > > > > > On Fri, Mar 27, 2020 at 02:49:55AM +0000, Tian, Kevin wrote:
> > > > > > > If those API calls are inter-dependent for composing a
> > > > > > > feature (e.g. SVA), shouldn't we need a way to check them
> > > > > > > together before exposing the feature to the guest, e.g.
> > > > > > > through a iommu_get_uapi_capabilities interface?
> > > > > >
> > > > > > Yes, that makes sense.  The important bit is to have a
> > > > > > capability flags and not version numbers.
> > > > >
> > > > > The challenge is that there are two consumers in the kernel for
> > > > > this. 1. VFIO only look for compatibility, and size of each data
> > > > > struct such that it can copy_from_user.
> > > > >
> > > > > 2. IOMMU driver, the "real consumer" of the content.
> > > > >
> > > > > For 2, I agree and we do plan to use the capability flags to
> > > > > check content and maintain backward compatibility etc.
> > > > >
> > > > > For VFIO, it is difficult to do size look up based on capability
> > > > > flags.
> > > >
> > > > Can you elaborate the difficulty in VFIO? if, as Christoph Hellwig
> > > > pointed out, version number is already avoided everywhere, it is
> > > > interesting to know whether this work becomes a real exception
> > > > or just requires a different mindset.
> > > >
> > > From VFIO p.o.v. the IOMMU UAPI data is opaque, it only needs to do
> > > two things:
> > > 1. is the UAPI compatible?
> > > 2. what is the size to copy?
> > >
> > > If you look at the version number, this is really a "version as
> > > size" lookup, as provided by the helper function in this patch. An
> > > example can be the newly introduced clone3 syscall.
> > > https://lwn.net/Articles/792628/
> > > In clone3, new version must have new size. The slight difference
> > > here is that, unlike clone3, we have multiple data structures
> > > instead of a single struct clone_args {}. And each struct has flags
> > > to enumerate its contents besides size.
> >
> > Thanks for providing that link. However clone3 doesn't include a
> > version field to do "version as size" lookup. Instead, as you said,
> > it includes a size parameter which sounds like the option 3 (argsz)
> > listed below.
> >
> Right, there is no version in clone3. size = version. I view this as
> a 1:1 lookup.
> 
> > >
> > > Besides breaching data abstraction, if VFIO has to check IOMMU
> > > flags to determine the sizes, it has many combinations.
> > >
> > > We also separate the responsibilities into two parts
> > > 1. compatibility - version, size by VFIO
> > > 2. sanity check - capability flags - by IOMMU
> >
> > I feel argsz+flags approach can perfectly meet above requirement. The
> > userspace set the size and flags for whatever capabilities it uses,
> > and VFIO simply copies the parameters by size and pass to IOMMU for
> > further sanity check. Of course the assumption is that we do provide
> > an interface for userspace to enumerate all supported capabilities.
> >
> You cannot trust user for argsz. the size to be copied from user must
> be based on knowledge in kernel. That is why we have this version to
> size lookup.
> 
> In VFIO, the size to copy is based on knowledge of each VFIO UAPI
> structures and VFIO flags. But here the flags are IOMMU UAPI flags. As
> you pointed out in another thread, VFIO is one user.

If that is the case, can we let VFIO only copy its own UAPI fields while 
simply passing the user pointer of IOMMU UAPI structure to IOMMU
driver for further size check and copy? Otherwise we are entering a
dead end that VFIO doesn't want to parse a structure which is not
defined by him while using version to represent the black box size
is considered as a discarded scheme and doesn't scale well...

> 
> > Is there anything that I overlooked here? I suppose there might be
> > some difficulties that block you from going the argsz way...
> >
> > Thanks
> > Kevin
> >
> > >
> > > I think the latter matches what Christoph's comments. So we are in
> > > agreement at the IOMMU level :)
> > >
> > > For example:
> > > During guest PASID bind, IOMMU driver operates on the data passed
> > > from VFIO and check format & flags to take different code path.
> > >
> > > #define IOMMU_PASID_FORMAT_INTEL_VTD	1
> > > 	__u32 format;
> > > #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> > > 	__u64 flags;
> > >
> > > Jacob
> > >
> > > > btw the most relevant discussion which I can find out now is here:
> > > > 	https://lkml.org/lkml/2020/2/3/1126
> > > >
> > > > It mentioned 3 options for handling extension:
> > > > --
> > > > 1. Disallow adding new members to each structure other than reuse
> > > > padding bits or adding union members at the end.
> > > > 2. Allow extension of the structures beyond union, but union size
> > > > has to be fixed with reserved spaces
> > > > 3. Adopt VFIO argsz scheme, I don't think we need version for each
> > > > struct anymore. argsz implies the version that user is using
> > > > assuming UAPI data is extension only.
> > > > --
> > > >
> > > > the first two are both version-based. Looks most guys agreed with
> > > > option-1 (in this v2), but Alex didn't give his opinion at the
> > > > moment. The last response from him was the raise of option-3 using
> > > > argsz to avoid version. So, we also need hear from him. Alex?
> > > >
> > > > Thanks
> > > > Kevin
> > >
> > > [Jacob Pan]
> 
> [Jacob Pan]

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
