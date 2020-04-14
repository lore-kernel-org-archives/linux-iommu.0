Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1A2C2BBFD
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 04:59:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE97520678
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 04:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE97520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BC12A852F6;
	Tue, 14 Apr 2020 04:59:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VIhV1KJiYqCn; Tue, 14 Apr 2020 04:59:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6A7F985168;
	Tue, 14 Apr 2020 04:59:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43042C1D7D;
	Tue, 14 Apr 2020 04:59:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82B71C0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 04:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6AF7F85497
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 04:59:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0e9-+N3YI7pM for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 04:59:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E0975853E3
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 04:59:22 +0000 (UTC)
IronPort-SDR: cbm2sQIKXUtAeNi/TRMn9LlTW/1IFMiWL3hp+DNzRkmE8QiFr5agv+2WnREw2KdE2DWd85V93z
 1JPspyK7Um6Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2020 21:59:21 -0700
IronPort-SDR: CPedGsBVdwDwZVjQ+zHYU1TRgVgUqzuChefRVP3nj21Epo8DLbHcN50alAjE4GMujoedDdxytk
 Wd9bO/XfeA3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; d="scan'208";a="241873091"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga007.jf.intel.com with ESMTP; 13 Apr 2020 21:59:21 -0700
Date: Mon, 13 Apr 2020 22:05:15 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Message-ID: <20200413220515.25a107b6@jacob-builder>
In-Reply-To: <20200413162129.313b3b5a@w520.home>
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
 <20200413134157.395981a6@jacob-builder>
 <20200413162129.313b3b5a@w520.home>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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

Hi Alex,
Thanks a lot for the feedback, my comments inline.

On Mon, 13 Apr 2020 16:21:29 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Mon, 13 Apr 2020 13:41:57 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > Hi All,
> > 
> > Just a gentle reminder, any feedback on the options I listed below?
> > New ideas will be even better.
> > 
> > Christoph, does the explanation make sense to you? We do have the
> > capability/flag based scheme for IOMMU API extension, the version is
> > mainly used for size lookup. Compatibility checking is another use
> > of the version, it makes checking easy when a vIOMMU is launched.
> > 
> > Thanks,
> > 
> > Jacob
> > 
> > On Thu, 2 Apr 2020 11:36:04 -0700
> > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> >   
> > > On Wed, 1 Apr 2020 05:32:21 +0000
> > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > >     
> > > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > Sent: Tuesday, March 31, 2020 11:55 PM
> > > > > 
> > > > > On Tue, 31 Mar 2020 06:06:38 +0000
> > > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > > >         
> > > > > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > > > Sent: Tuesday, March 31, 2020 12:08 AM
> > > > > > >
> > > > > > > On Mon, 30 Mar 2020 05:40:40 +0000
> > > > > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > > > > >        
> > > > > > > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > > > > > Sent: Saturday, March 28, 2020 7:54 AM
> > > > > > > > >
> > > > > > > > > On Fri, 27 Mar 2020 00:47:02 -0700
> > > > > > > > > Christoph Hellwig <hch@infradead.org> wrote:
> > > > > > > > >        
> > > > > > > > > > On Fri, Mar 27, 2020 at 02:49:55AM +0000, Tian,
> > > > > > > > > > Kevin wrote:        
> > > > > > > > > > > If those API calls are inter-dependent for
> > > > > > > > > > > composing a feature (e.g. SVA), shouldn't we need
> > > > > > > > > > > a way to check them together before exposing the
> > > > > > > > > > > feature to the guest, e.g. through a
> > > > > > > > > > > iommu_get_uapi_capabilities interface?        
> > > > > > > > > >
> > > > > > > > > > Yes, that makes sense.  The important bit is to
> > > > > > > > > > have a capability flags and not version
> > > > > > > > > > numbers.        
> > > > > > > > >
> > > > > > > > > The challenge is that there are two consumers in the
> > > > > > > > > kernel for this. 1. VFIO only look for compatibility,
> > > > > > > > > and size of each data struct such that it can
> > > > > > > > > copy_from_user.
> > > > > > > > >
> > > > > > > > > 2. IOMMU driver, the "real consumer" of the content.
> > > > > > > > >
> > > > > > > > > For 2, I agree and we do plan to use the capability
> > > > > > > > > flags to check content and maintain backward
> > > > > > > > > compatibility etc.
> > > > > > > > >
> > > > > > > > > For VFIO, it is difficult to do size look up based on
> > > > > > > > > capability flags.        
> > > > > > > >
> > > > > > > > Can you elaborate the difficulty in VFIO? if, as
> > > > > > > > Christoph Hellwig pointed out, version number is
> > > > > > > > already avoided everywhere, it is interesting to know
> > > > > > > > whether this work becomes a real exception or just
> > > > > > > > requires a different mindset.     
> > > > > > > From VFIO p.o.v. the IOMMU UAPI data is opaque, it only
> > > > > > > needs to do two things:
> > > > > > > 1. is the UAPI compatible?
> > > > > > > 2. what is the size to copy?
> > > > > > >
> > > > > > > If you look at the version number, this is really a
> > > > > > > "version as size" lookup, as provided by the helper
> > > > > > > function in this patch. An example can be the newly
> > > > > > > introduced clone3 syscall.
> > > > > > > https://lwn.net/Articles/792628/ In clone3, new version
> > > > > > > must have new size. The slight difference here is that,
> > > > > > > unlike clone3, we have multiple data structures instead
> > > > > > > of a single struct clone_args {}. And each struct has
> > > > > > > flags to enumerate its contents besides size.        
> > > > > >
> > > > > > Thanks for providing that link. However clone3 doesn't
> > > > > > include a version field to do "version as size" lookup.
> > > > > > Instead, as you said, it includes a size parameter which
> > > > > > sounds like the option 3 (argsz) listed below.
> > > > > >        
> > > > > Right, there is no version in clone3. size = version. I view
> > > > > this as a 1:1 lookup.
> > > > >         
> > > > > > >
> > > > > > > Besides breaching data abstraction, if VFIO has to check
> > > > > > > IOMMU flags to determine the sizes, it has many
> > > > > > > combinations.
> > > > > > >
> > > > > > > We also separate the responsibilities into two parts
> > > > > > > 1. compatibility - version, size by VFIO
> > > > > > > 2. sanity check - capability flags - by IOMMU        
> > > > > >
> > > > > > I feel argsz+flags approach can perfectly meet above
> > > > > > requirement. The userspace set the size and flags for
> > > > > > whatever capabilities it uses, and VFIO simply copies the
> > > > > > parameters by size and pass to IOMMU for further sanity
> > > > > > check. Of course the assumption is that we do provide an
> > > > > > interface for userspace to enumerate all supported
> > > > > > capabilities.       
> > > > > You cannot trust user for argsz. the size to be copied from
> > > > > user must be based on knowledge in kernel. That is why we
> > > > > have this version to size lookup.
> > > > > 
> > > > > In VFIO, the size to copy is based on knowledge of each VFIO
> > > > > UAPI structures and VFIO flags. But here the flags are IOMMU
> > > > > UAPI flags. As you pointed out in another thread, VFIO is one
> > > > > user.        
> > > > 
> > > > If that is the case, can we let VFIO only copy its own UAPI
> > > > fields while simply passing the user pointer of IOMMU UAPI
> > > > structure to IOMMU driver for further size check and copy?
> > > > Otherwise we are entering a dead end that VFIO doesn't want to
> > > > parse a structure which is not defined by him while using
> > > > version to represent the black box size is considered as a
> > > > discarded scheme and doesn't scale well...     
> > > I think this could be an other viable option. Let me try to
> > > summarize since this has been a long discussion since the
> > > original version.
> > > 
> > > Problem statements:
> > > 1. When launching vIOMMU in the guest, how can we ensure the host
> > > has compatible support upfront? as compared to fail later.  
> 
> This sounds like a feature/extension interface, both KVM and vfio have
> them to allow userspace to check support of specific features.
> 
Yes, the specific features are the APIs:
- bind guest PASID
- cache invalidation
- page requests & response

> > > 2. As UAPI data gets extended (both in size and flags), how can we
> > > know the size to copy  
> 
> For vfio we of course use the argsz/flags trick where the user tells
> us how big the buffer is and flags in the header tell us what fields
> beyond the base specification are enabled.  This can get tricky to
> extend and there can be confusion whether a flag indicates the
> presence of a field or the validity of a field.
> 
> We also have interfaces where the ioctl is a header plus a data blob
> where flags tell us what the data is.  These can serve double duty as
> a extension check too as we've done for VFIO_DEVICE_FEATURE.  This
> doesn't really support extension of a defined feature though, rather
> we'd be more likely to create a set of flags that indicate the data
> object is feature-v2 and redefine the structure, or of course we
> revisit the entire featuring question within the structure of that
> data blob.
> 
> We also implement capability chains, though they're more meant for
> passing data to the user, where the user provides a buffer and we link
> capabilities together within that buffer for the user to walk.  We've
> defined a mechanism through -ENOSPC and argsz to tell the user how
> large a buffer is necessary.  I dare mention we have a version per
> capability as these are largely modeled after capability chains in PCI
> config space.  We haven't actually incremented any versions, but I
> imagine we'd do so like PCI, maintaining backwards compatibility and
> only defining unused bits and adding fields as the version increases.
> 
I guess capability chain is more suitable since the IOCTL uses
container FD instead of device FD in VFIO_DEVICE_FEATURE?

We can give that a try by treating IOMMU UAPIs as capabilities. That
would address problem #1. We really need to check compatibility upfront
in that there is no way to fail some of the UAPIs. e.g. unbind guest
PASID, cache invalidation.

> Is the objection to a global version or to any version fields?  I
> don't really understand the global version, I'd think a mechanism to
> check extensions plus a per structure flags/version would be
> preferred.  The former should resolve how userspace can test support
> for features requiring multiple interfaces.
Currently we already have individual version & flags per UAPI data. The
reason why I introduced a global/unifier is to simplify the
compatibility checking. Global version is optional.
With individual version & flags, user may have to keep track of
combinations of per structure versions.

>  A global version also
> implies that we're only ever adding features and never removing.  For
> example, feature Foo is added in version 4, but it's replaced by
> feature Bar in version 5, now userspace can't simply test version >=
> 4 must include feature Foo.
> 
Yes, this is why I was hoping to stick with the rule: open for
extension, closed to modification.
It also makes the code backward compatible easy since there old code
would have no change when adding new features.

> It seems to me that version and flags can also be complimentary, for
> example a field might be defined by a version but a flag could
> indicate if it's implemented.  With only the flag, we'd infer the
> field from the flag, with only the version we'd need to assume the
> field is always implemented.  So I have a hard time making a blanket
> statement that all versions fields should be avoided.
>  
> > > 3. Maintain backward compatibility while allowing extensions?
> > > 
> > > I think we all agreed that using flags (capability or types) is
> > > the way to address #3. As Christoph pointed out, version number
> > > should not be used for this purpose.
> > > 
> > > So for problem 1 & 2, we have the following options:
> > > 1. Have a version-size mapping as proposed in this set. VFIO
> > > copies from user the correct size based on version-type lookup.
> > > Processing of the data is based on flags in IOMMU driver.
> > > 
> > > 2. VFIO copy its own minsz then pass the user pointer to IOMMU
> > > driver for further copy_from_user based on flags. (by Kevin)
> > > 
> > > 3. Adopt VFIO argsz scheme, caller fills in argsz for the offset
> > > the variable size union. VFIO do not check argsz in that it
> > > requires IOMMU specific knowledge. IOMMU driver Use flags to
> > > handle the variable size.(by Alex). I think this what we have in
> > > Yi's VFIO & QEMU patch. argsz filled by QEMU includes bind_data.
> > > 
> > > 4. Do not use a unified version, have a fixed size of all UAPI
> > > structures, padding in struct and union. (Wasteful, not preferred
> > > per V1 discussion)
> > > 
> > > For both 2 & 3, a unified version is not used, each API
> > > treated separately. vIOMMU will be launched w/o assurance of
> > > compatibility of all APIs. Fault handling may be more complex in
> > > normal operations.
> > > 
> > > Appreciate everyone's input. Joerg and Alex, could you help to
> > > make a decision here?  
> 
> As above, I think using a global API version number to imply support
> for a feature is doomed to fail, we should instead expose an interface
> to check for specific features.
I agree. I feel we can use the capability chain at container level as
you mentioned, right?

>  In any of the proposed solutions, the
> IOMMU driver is ultimately responsible for validating the user data,
> so do we want vfio performing the copy_from_user() to an object that
> could later be assumed to be sanitized, or should vfio just pass a
> user pointer to make it obvious that the consumer is responsible for
> all the user protections?  Seems like the latter.
I like the latter as well.

>  That still really
> doesn't address what's in that user data blob yet, but the vfio
> interface could be:
> 
> struct {
> 	__u32 argsz;
> 	__u32 flags;
> 	__u8  data[];
> }
> 
> Where flags might be partitioned like we do for DEVICE_FEATURE to
> indicate the format of data and what vfio should do with it, and data
> might simply be defined as a (__u64 __user *).
> 
So, __user * will be passed to IOMMU driver if VFIO checks minsz
include flags and they are valid.
IOMMU driver can copy the rest based on the mandatory version/minsz and
flags in the IOMMU uAPI structs.
Does it sound right? This is really choice #2.

> This user pointer would then likely be an IOMMU UAPI struct, so I've
> only just gotten back the the IOMMU UAPI question at hand, but I don't
> really see the disadvantage to including both version and flags fields
> per structure.  Perhaps this is choice 1. above, but with a version at
> a per structure level indicating the backwards compatible size and
> layout of the structure and flags being used to indicate support for
> optional features within those fields.

Per structure version & flags is what we have in the mainline. It
applies to both choice 1 & 2. The global/unified version is just a
re-interpretation of the versions such that we have a monolithic
incrementing version. Again, global version is optional.

>  Is a version field still taboo
> for such a use case?  Thanks,

I will leave that to Christoph :)

Thanks

Jacob
> 
> Alex
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
