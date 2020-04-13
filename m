Return-Path: <SRS0=l6pd=55=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930E7C2BA2B
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 20:36:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB42206DA
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 20:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB42206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 021DF203F3;
	Mon, 13 Apr 2020 20:36:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iLVUBNiOf3-K; Mon, 13 Apr 2020 20:36:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 74C6A204B3;
	Mon, 13 Apr 2020 20:36:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F90BC1D7D;
	Mon, 13 Apr 2020 20:36:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE1ECC0172
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 20:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BC4DD84789
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 20:36:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sir_PQiQYZKO for <iommu@lists.linux-foundation.org>;
 Mon, 13 Apr 2020 20:36:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8367A84785
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 20:36:04 +0000 (UTC)
IronPort-SDR: oZFi680NrtpR38Lvs+LJD6iMR8s2NdG14PGlKmltn0o/DbyFEbGxW2ttQlgx5V4I9GRmiPnrZE
 Cf1HVxSZWpyg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2020 13:36:03 -0700
IronPort-SDR: 8KdnmNC/S2jBKm/8t/7nreeftfVQskYS5x1Y0Cf7q8JjScwK0ZXbuP6L/N72Ms8BpZYkahDib/
 6MdQo45sA5NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,380,1580803200"; d="scan'208";a="241766661"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga007.jf.intel.com with ESMTP; 13 Apr 2020 13:36:03 -0700
Date: Mon, 13 Apr 2020 13:41:57 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Message-ID: <20200413134157.395981a6@jacob-builder>
In-Reply-To: <20200402113604.6eea1e6f@jacob-builder>
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
 <AADFC41AFE54684AB9EE6CBC0274A5D19D803AFF@SHSMSX104.ccr.corp.intel.com>
 <20200402113604.6eea1e6f@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
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

Hi All,

Just a gentle reminder, any feedback on the options I listed below? New
ideas will be even better.

Christoph, does the explanation make sense to you? We do have the
capability/flag based scheme for IOMMU API extension, the version is
mainly used for size lookup. Compatibility checking is another use of
the version, it makes checking easy when a vIOMMU is launched.

Thanks,

Jacob

On Thu, 2 Apr 2020 11:36:04 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> On Wed, 1 Apr 2020 05:32:21 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Tuesday, March 31, 2020 11:55 PM
> > > 
> > > On Tue, 31 Mar 2020 06:06:38 +0000
> > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > >     
> > > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > Sent: Tuesday, March 31, 2020 12:08 AM
> > > > >
> > > > > On Mon, 30 Mar 2020 05:40:40 +0000
> > > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > > >    
> > > > > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > > > Sent: Saturday, March 28, 2020 7:54 AM
> > > > > > >
> > > > > > > On Fri, 27 Mar 2020 00:47:02 -0700
> > > > > > > Christoph Hellwig <hch@infradead.org> wrote:
> > > > > > >    
> > > > > > > > On Fri, Mar 27, 2020 at 02:49:55AM +0000, Tian, Kevin
> > > > > > > > wrote:    
> > > > > > > > > If those API calls are inter-dependent for composing a
> > > > > > > > > feature (e.g. SVA), shouldn't we need a way to check
> > > > > > > > > them together before exposing the feature to the
> > > > > > > > > guest, e.g. through a iommu_get_uapi_capabilities
> > > > > > > > > interface?    
> > > > > > > >
> > > > > > > > Yes, that makes sense.  The important bit is to have a
> > > > > > > > capability flags and not version numbers.    
> > > > > > >
> > > > > > > The challenge is that there are two consumers in the
> > > > > > > kernel for this. 1. VFIO only look for compatibility, and
> > > > > > > size of each data struct such that it can copy_from_user.
> > > > > > >
> > > > > > > 2. IOMMU driver, the "real consumer" of the content.
> > > > > > >
> > > > > > > For 2, I agree and we do plan to use the capability flags
> > > > > > > to check content and maintain backward compatibility etc.
> > > > > > >
> > > > > > > For VFIO, it is difficult to do size look up based on
> > > > > > > capability flags.    
> > > > > >
> > > > > > Can you elaborate the difficulty in VFIO? if, as Christoph
> > > > > > Hellwig pointed out, version number is already avoided
> > > > > > everywhere, it is interesting to know whether this work
> > > > > > becomes a real exception or just requires a different
> > > > > > mindset. 
> > > > > From VFIO p.o.v. the IOMMU UAPI data is opaque, it only needs
> > > > > to do two things:
> > > > > 1. is the UAPI compatible?
> > > > > 2. what is the size to copy?
> > > > >
> > > > > If you look at the version number, this is really a "version
> > > > > as size" lookup, as provided by the helper function in this
> > > > > patch. An example can be the newly introduced clone3 syscall.
> > > > > https://lwn.net/Articles/792628/
> > > > > In clone3, new version must have new size. The slight
> > > > > difference here is that, unlike clone3, we have multiple data
> > > > > structures instead of a single struct clone_args {}. And each
> > > > > struct has flags to enumerate its contents besides size.    
> > > >
> > > > Thanks for providing that link. However clone3 doesn't include a
> > > > version field to do "version as size" lookup. Instead, as you
> > > > said, it includes a size parameter which sounds like the option
> > > > 3 (argsz) listed below.
> > > >    
> > > Right, there is no version in clone3. size = version. I view this
> > > as a 1:1 lookup.
> > >     
> > > > >
> > > > > Besides breaching data abstraction, if VFIO has to check IOMMU
> > > > > flags to determine the sizes, it has many combinations.
> > > > >
> > > > > We also separate the responsibilities into two parts
> > > > > 1. compatibility - version, size by VFIO
> > > > > 2. sanity check - capability flags - by IOMMU    
> > > >
> > > > I feel argsz+flags approach can perfectly meet above
> > > > requirement. The userspace set the size and flags for whatever
> > > > capabilities it uses, and VFIO simply copies the parameters by
> > > > size and pass to IOMMU for further sanity check. Of course the
> > > > assumption is that we do provide an interface for userspace to
> > > > enumerate all supported capabilities.   
> > > You cannot trust user for argsz. the size to be copied from user
> > > must be based on knowledge in kernel. That is why we have this
> > > version to size lookup.
> > > 
> > > In VFIO, the size to copy is based on knowledge of each VFIO UAPI
> > > structures and VFIO flags. But here the flags are IOMMU UAPI
> > > flags. As you pointed out in another thread, VFIO is one user.    
> > 
> > If that is the case, can we let VFIO only copy its own UAPI fields
> > while simply passing the user pointer of IOMMU UAPI structure to
> > IOMMU driver for further size check and copy? Otherwise we are
> > entering a dead end that VFIO doesn't want to parse a structure
> > which is not defined by him while using version to represent the
> > black box size is considered as a discarded scheme and doesn't
> > scale well... 
> I think this could be an other viable option. Let me try to summarize
> since this has been a long discussion since the original version.
> 
> Problem statements:
> 1. When launching vIOMMU in the guest, how can we ensure the host has
> compatible support upfront? as compared to fail later.
> 
> 2. As UAPI data gets extended (both in size and flags), how can we
> know the size to copy
> 
> 3. Maintain backward compatibility while allowing extensions?
> 
> I think we all agreed that using flags (capability or types) is the
> way to address #3. As Christoph pointed out, version number should
> not be used for this purpose.
> 
> So for problem 1 & 2, we have the following options:
> 1. Have a version-size mapping as proposed in this set. VFIO copies
> from user the correct size based on version-type lookup. Processing
> of the data is based on flags in IOMMU driver.
> 
> 2. VFIO copy its own minsz then pass the user pointer to IOMMU driver
> for further copy_from_user based on flags. (by Kevin)
> 
> 3. Adopt VFIO argsz scheme, caller fills in argsz for the offset the
> variable size union. VFIO do not check argsz in that it requires IOMMU
> specific knowledge. IOMMU driver Use flags to handle the variable
> size.(by Alex). I think this what we have in Yi's VFIO & QEMU patch.
> argsz filled by QEMU includes bind_data.
> 
> 4. Do not use a unified version, have a fixed size of all UAPI
> structures, padding in struct and union. (Wasteful, not preferred per
> V1 discussion)
> 
> For both 2 & 3, a unified version is not used, each API
> treated separately. vIOMMU will be launched w/o assurance of
> compatibility of all APIs. Fault handling may be more complex in
> normal operations.
> 
> Appreciate everyone's input. Joerg and Alex, could you help to make a
> decision here?
> 
> 
> Thanks,
> 
> Jacob
> 
> > >     
> >  [...]  
> >  [...]  
> >  [...]    
> > > > >
> > > > > [Jacob Pan]    
> > > 
> > > [Jacob Pan]    
> > 
> > Thanks
> > Kevin  
> 
> [Jacob Pan]

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
