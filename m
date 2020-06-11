Return-Path: <SRS0=H3NW=7Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF1EC433DF
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 20:41:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC252073E
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 20:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiOahcEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC252073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8EDCE87B03;
	Thu, 11 Jun 2020 20:41:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4k7KhsZ-HW2e; Thu, 11 Jun 2020 20:41:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2E5C387ABE;
	Thu, 11 Jun 2020 20:41:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13DD0C0178;
	Thu, 11 Jun 2020 20:41:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFF02C016F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 20:41:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 72DF020403
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 20:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RzatkjC48+9V for <iommu@lists.linux-foundation.org>;
 Thu, 11 Jun 2020 20:40:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id 67C16203CA
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 20:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591908058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v0NyQn/Xw2NXLmViDd928++8fD4huUOKhaypCG3R/Hc=;
 b=CiOahcEhO9ak5P5F5ns9xezZQ/y41ZpT3Xj1pMb3TfJzlhUb7WUPPXokB1/0CIkZ65b9w8
 QUsn7ySHJjfFAuK1N+E7exUVicEjJ4fzF9zepVdv1A7MTbPUjRJOrSsiuS/oRFCIPnRA85
 yMO4sFER5DAEGHUlWoF1teEfBJ51JYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-VSUovNspMcmAe9qF0QuECA-1; Thu, 11 Jun 2020 16:40:53 -0400
X-MC-Unique: VSUovNspMcmAe9qF0QuECA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F411BEC1A9;
 Thu, 11 Jun 2020 20:40:51 +0000 (UTC)
Received: from x1.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3055F10013D7;
 Thu, 11 Jun 2020 20:40:48 +0000 (UTC)
Date: Thu, 11 Jun 2020 14:40:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 1/3] docs: IOMMU user API
Message-ID: <20200611144047.79613c32@x1.home>
In-Reply-To: <20200611125205.1e0280d3@jacob-builder>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1591848735-12447-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200611094741.6d118fa8@w520.home>
 <20200611125205.1e0280d3@jacob-builder>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
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

On Thu, 11 Jun 2020 12:52:05 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> Hi Alex,
> 
> On Thu, 11 Jun 2020 09:47:41 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > On Wed, 10 Jun 2020 21:12:13 -0700
> > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> >   
> > > IOMMU UAPI is newly introduced to support communications between
> > > guest virtual IOMMU and host IOMMU. There has been lots of
> > > discussions on how it should work with VFIO UAPI and userspace in
> > > general.
> > > 
> > > This document is indended to clarify the UAPI design and usage. The
> > > mechenics of how future extensions should be achieved are also
> > > covered in this documentation.
> > > 
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > ---
> > >  Documentation/userspace-api/iommu.rst | 210
> > > ++++++++++++++++++++++++++++++++++ 1 file changed, 210 insertions(+)
> > >  create mode 100644 Documentation/userspace-api/iommu.rst
> > > 
> > > diff --git a/Documentation/userspace-api/iommu.rst
> > > b/Documentation/userspace-api/iommu.rst new file mode 100644
> > > index 000000000000..e95dc5a04a41
> > > --- /dev/null
> > > +++ b/Documentation/userspace-api/iommu.rst
> > > @@ -0,0 +1,210 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +.. iommu:
> > > +
> > > +=====================================
> > > +IOMMU Userspace API
> > > +=====================================
> > > +
> > > +IOMMU UAPI is used for virtualization cases where communications
> > > are +needed between physical and virtual IOMMU drivers. For native
> > > +usage, IOMMU is a system device which does not need to communicate
> > > +with user space directly.
> > > +
> > > +The primary use cases are guest Shared Virtual Address (SVA) and
> > > +guest IO virtual address (IOVA), wherein virtual IOMMU (vIOMMU) is
> > > +required to communicate with the physical IOMMU in the host.
> > > +
> > > +.. contents:: :local:
> > > +
> > > +Functionalities
> > > +====================================================
> > > +Communications of user and kernel involve both directions. The
> > > +supported user-kernel APIs are as follows:
> > > +
> > > +1. Alloc/Free PASID
> > > +2. Bind/unbind guest PASID (e.g. Intel VT-d)
> > > +3. Bind/unbind guest PASID table (e.g. ARM sMMU)
> > > +4. Invalidate IOMMU caches
> > > +5. Service page request
> > > +
> > > +Requirements
> > > +====================================================
> > > +The IOMMU UAPIs are generic and extensible to meet the following
> > > +requirements:
> > > +
> > > +1. Emulated and para-virtualised vIOMMUs
> > > +2. Multiple vendors (Intel VT-d, ARM sMMU, etc.)
> > > +3. Extensions to the UAPI shall not break existing user space
> > > +
> > > +Interfaces
> > > +====================================================
> > > +Although the data structures defined in IOMMU UAPI are
> > > self-contained, +there is no user API functions introduced.
> > > Instead, IOMMU UAPI is +designed to work with existing user driver
> > > frameworks such as VFIO. +
> > > +Extension Rules & Precautions
> > > +-----------------------------
> > > +When IOMMU UAPI gets extended, the data structures can *only* be
> > > +modified in two ways:
> > > +
> > > +1. Adding new fields by re-purposing the padding[] field. No size
> > > change. +2. Adding new union members at the end. May increase in
> > > size. +
> > > +No new fields can be added *after* the variable size union in that
> > > it +will break backward compatibility when offset moves. In both
> > > cases, a +new flag must be accompanied with a new field such that
> > > the IOMMU +driver can process the data based on the new flag.
> > > Version field is +only reserved for the unlikely event of UAPI
> > > upgrade at its entirety. +
> > > +It's *always* the caller's responsibility to indicate the size of
> > > the +structure passed by setting argsz appropriately.
> > > +
> > > +When IOMMU UAPI extension results in size increase, user such as
> > > VFIO +has to handle the following scenarios:
> > > +
> > > +1. User and kernel has exact size match
> > > +2. An older user with older kernel header (smaller UAPI size)
> > > running on a
> > > +   newer kernel (larger UAPI size)
> > > +3. A newer user with newer kernel header (larger UAPI size) running
> > > +   on a older kernel.
> > > +4. A malicious/misbehaving user pass illegal/invalid size but
> > > within
> > > +   range. The data may contain garbage.
> > > +
> > > +
> > > +Feature Checking
> > > +----------------
> > > +While launching a guest with vIOMMU, it is important to ensure
> > > that host +can support the UAPI data structures to be used for
> > > vIOMMU-pIOMMU +communications. Without the upfront compatibility
> > > checking, future +faults are difficult to report even in normal
> > > conditions. For example, +TLB invalidations should always succeed
> > > from vIOMMU's +perspective. There is no architectural way to report
> > > back to the vIOMMU +if the UAPI data is incompatible. For this
> > > reason the following IOMMU +UAPIs cannot fail:
> > > +
> > > +1. Free PASID
> > > +2. Unbind guest PASID
> > > +3. Unbind guest PASID table (SMMU)
> > > +4. Cache invalidate
> > > +5. Page response
> > > +
> > > +User applications such as QEMU is expected to import kernel UAPI
> > > +headers. Only backward compatibility is supported. For example, an
> > > +older QEMU (with older kernel header) can run on newer kernel.
> > > Newer +QEMU (with new kernel header) may fail on older kernel.    
> > 
> > "Build your user application against newer kernels and it may break on
> > older kernels" is not a great selling point of this UAPI.  Clearly new
> > features may not be available on older kernels and an application that
> > depends on a newer feature may be restricted to newer kernels.
> >   
> Perhaps "fail on older kernel" is not the right statement. I meant to
> say "Newer QEMU (with new kernel header) may fail the compatibility
> check on older kernel". Here compatibility check involves argsz check
> and feature check.
> 
> Does it sound right?

If simply recompiling QEMU against a new kernel header causes it to
fail on an old kernel, we've done something very wrong in this UAPI.

> > > +
> > > +IOMMU vendor driver should report the below features to IOMMU UAPI
> > > +consumers (e.g. via VFIO).
> > > +
> > > +1. IOMMU_NESTING_FEAT_SYSWIDE_PASID
> > > +2. IOMMU_NESTING_FEAT_BIND_PGTBL
> > > +3. IOMMU_NESTING_FEAT_BIND_PASID_TABLE
> > > +4. IOMMU_NESTING_FEAT_CACHE_INVLD
> > > +5. IOMMU_NESTING_FEAT_PAGE_REQUEST
> > > +
> > > +Take VFIO as example, upon request from VFIO user space (e.g.
> > > QEMU), +VFIO kernel code shall query IOMMU vendor driver for the
> > > support of +the above features. Query result can then be reported
> > > back to the +user-space caller. Details can be found in
> > > +Documentation/driver-api/vfio.rst.
> > > +
> > > +
> > > +Data Passing Example with VFIO
> > > +------------------------------
> > > +As the ubiquitous userspace driver framework, VFIO is already IOMMU
> > > +aware and share many key concepts such as device model, group, and
> > > +protection domain. Other user driver frameworks can also be
> > > extended +to support IOMMU UAPI but it is outside the scope of this
> > > document. +
> > > +In this tight-knit VFIO-IOMMU interface, the ultimate consumer of
> > > the +IOMMU UAPI data is the host IOMMU driver. VFIO facilitates
> > > user-kernel +transport, capability checking, security, and life
> > > cycle management of +process address space ID (PASID).
> > > +
> > > +Unlike normal user data passed via VFIO UAPI IOTCL, IOMMU driver
> > > is the +ultimate consumer of its UAPI data. At VFIO layer, the
> > > IOMMU UAPI data +is wrapped in a VFIO UAPI data for sanity
> > > checking. It follows the +pattern below:
> > > +
> > > +::
> > > +
> > > +   struct {
> > > +	__u32 argsz;
> > > +	__u32 flags;
> > > +	__u8  data[];
> > > +  }
> > > +
> > > +Here data[] contains the IOMMU UAPI data structures.
> > > +
> > > +In order to determine the size and feature set of the user data,
> > > argsz +and flags are also embedded in the IOMMU UAPI data
> > > structures. +A "__u32 argsz" field is *always* at the beginning of
> > > each structure. +
> > > +For example:
> > > +::
> > > +
> > > +   struct iommu_gpasid_bind_data {
> > > +	__u32 argsz;
> > > +	__u32 version;
> > > +	#define IOMMU_PASID_FORMAT_INTEL_VTD	1
> > > +	__u32 format;
> > > +	#define IOMMU_SVA_GPASID_VAL	(1 << 0)
> > > +	__u64 flags;
> > > +	__u64 gpgd;
> > > +	__u64 hpasid;
> > > +	__u64 gpasid;
> > > +	__u32 addr_width;
> > > +	__u8  padding[12];
> > > +	/* Vendor specific data */
> > > +	union {
> > > +		struct iommu_gpasid_bind_data_vtd vtd;
> > > +	};
> > > +  };
> > > +
> > > +Use bind guest PASID as an example, VFIO code shall process IOMMU
> > > UAPI +request as follows:
> > > +
> > > +::
> > > +
> > > + 1        /* Minsz must include IOMMU UAPI "argsz" of __u32 */
> > > + 2        minsz = offsetofend(struct vfio_iommu_type1_bind, flags)
> > > +
> > > +                              sizeof(u32);    
> > 
> > In the example structure above:
> >   
> > > +   struct {
> > > +	__u32 argsz;
> > > +	__u32 flags;
> > > +	__u8  data[];
> > > +  }    
> > 
> > This presumes that vfio does not use flags to identify a different
> > layout, for example a field before data or defining a flag that
> > provides no data.  IOW, the IOMMU guarantees argsz at the beginning of
> > all structures, but let's not limit how vfio chooses to bundle that
> > structure.  minsz should be based on flags, which we'll evaluate to
> > determine how much more to copy.
> >   
> Got it, VFIO owns its flags therefore minsz. How about reword the
> example data struct as:
>    struct {
> 	__u32 argsz;
> 	__u32 flags;
> 	__u8  data[];
>   }
> 
> Here data[] contains the IOMMU UAPI data structures. VFIO has the
> freedom to bundle the data as well as parse data size based on its own flags.
> 
> In the example code:
> 
> "Use bind guest PASID as an example, VFIO code shall first
> process the flags field to determine the size to copy for IOMMU UAPI.
> The flags could indicate different layout of the VFIO data and the types
> of IOMMU UAPI data."

I think this should probably go no further than to say that the IOMMU
UAPI data structure is expected to be embedded opaquely into the VFIO
API, for example, VFIO may use a structure such as:

    struct {
 	__u32 argsz;
 	__u32 flags;
 	__u8  data[];
   }

where data[] contains an IOMMU UAPI structure, including the user
provided argsz field relative to that embedded structure.  This format
allows VFIO to multiplex multiple IOMMU UAPI interfaces through a
reduced set of ioctls.

> > > UAPI +request as follows:  
> 
> > > + 3        copy_from_user(&vfio_bind, (void __user *)arg, minsz);
> > > + 4
> > > + 5        /* Check VFIO argsz */
> > > + 6        if (vfio_bind.argsz < minsz)
> > > + 7                return -EINVAL;
> > > + 8
> > > + 9        /* VFIO flags must be included in minsz */
> > > + 10        switch (vfio_bind.flags) {
> > > + 11        case VFIO_IOMMU_BIND_GUEST_PGTBL:
> > > + 12                /*
> > > + 13                 * Get the current IOMMU bind GPASID data size,
> > > + 14                 * which accounted for the largest union member.
> > > + 15                 */
> > > + 16                data_size = sizeof(struct
> > > iommu_gpasid_bind_data);
> > > + 17                iommu_argsz = vfio_bind.argsz - minsz;    
> > 
> > Note that by including the IOMMU UAPI argsz within minsz, this is
> > incorrect.
> >   
> Good catch, should be:
> iommu_argsz = vfio_bind.argsz - minsz - sizeof(u32)
> 
> > > + 18                if (iommu_argsz > data_size) {
> > > + 19                        /* User data > current kernel */
> > > + 20                        return -E2BIG;
> > > + 21                }    
> > 
> > Now I see why you're making the claim that QEMU compiled against an
> > new kernel may not work on an older kernel.  We can do better.  The
> > current sizeof the data structure should be the maximum we'll copy
> > from the user, and we can update the user provided IOMMU UAPI argsz
> > as we pass it down from the user to avoid exposing ourselves to an
> > arbitrarily large user buffer.  The IOMMU UAPI interfaces should then
> > also use argsz and flags to determine whether the data is present for
> > a specified flag. That should allow a user application compiled
> > against a newer kernel header, but only using features found on older
> > kernels to continue to work on older kernels, which seems like a
> > basic requirement to me.
> >   
> I got your point. But I don't understand why VFIO layer will update
> IOMMU argsz, IOMMU layer is not exposed to arbitrary large user size in
> that it can not exceed the current UAPI data size.

I was thinking about the case where userspace is compiled against a
newer kernel and might provide argsz = sizeof(struct iommu_uapi_foo')
but vfio only knows sizeof(struct iommu_uapi_foo).  We don't want to
copy an arbitrary amount of data from userspace, so vfio would use
MIN(argsz, sizeof(struct iommu_uapi_foo)) for the copy_from_user().  The
IOMMU UAPI would then need to depend on the reduced argsz.

But then I thought it even better if VFIO leaves the entire
copy_from_user() to the layer consuming it.

> I agree we should make effort to allow features found in the older
> kernel continue to work.

That's a requirement.  Breaking existing userspace without following a
deprecation model is a bug.  But I think so too is the fact that this
interface actually specifies and provides an example where simply
recompiling existing userspace against a new kernel header where the
size of structure may be changed to support a feature will cause that
application to fail to run on older kernels.  That's not feasible for a
distribution to support.

> > > + 22                copy_from_user(&iommu_bind, (void __user *)
> > > + 23                               vfio_bind.data, iommu_argsz);
> > > + 24               /*
> > > + 25                * Deal with trailing bytes that is bigger than
> > > user
> > > + 26                * provided UAPI size but smaller than the
> > > current
> > > + 27                * kernel data size. Zero fill the trailing
> > > bytes.
> > > + 28                */
> > > + 29                memset(iommu_bind + iommu_argsz, 0, data_size -
> > > + 30                       iommu_argsz;    
> > 
> > The IOMMU UAPI interface having access to argsz should make this
> > unnecessary.  Performing this memset() seems like it suggests to the
> > next layer that it can rely on all fields being present and valid,
> > which defeats the purpose of argsz.
> >   
> This memset does not suggest all fields are present and valid. Only
> filter out the obvious invalid data based on current size. My intention
> is to reduce the burden of checking not eliminate.

I'm afraid that reducing the burden on the IOMMU UAPI layers leads to
reduced visibility which leads to less stringent validation.  We're
defining a UAPI layer for the kernel where VFIO just happens to be an
interface through to that UAPI.  The UAPI should therefore be providing
the validation, not VFIO.  Create a wrapper in the IOMMU UAPI layer if
you want to share common validation.

> > > + 31
> > > + 32                iommu_sva_bind_gpasid(domain, dev,
> > > iommu_bind_data);
> > > + 33                break;
> > > +
> > > +
> > > +Case #1 & 2 are supported per backward compatibility rule.
> > > +
> > > +Case #3 will fail with -E2BIG at line #20. Case    
> > 
> > This is not acceptable IMO.
> >   
> Got it. Will copy up to the current data size and let IOMMU driver
> handle supported flags/features.
> 
> > > +Case #4 may result in other error processed by IOMMU vendor
> > > driver. However, +the damage shall not exceed the scope of the
> > > offending user.    
> > 
> > This is a concern in this double wrapped interface, the IOMMU UAPI
> > layer may expect the vfio layer to validate the data.  Zeroing the
> > remainder of the data structure is evidence towards that.  The IOMMU
> > UAPI layer needs to consider all of this untrusted, so why would we
> > not reflect that by passing a __user pointer through to the IOMMU
> > UAPI such that it can copy the data from the user itself rather than
> > being mislead that the contents have been somehow verified?  Thanks,
> >   
> I am OK with IOMMU layer does the copy_from_user. One of my
> original thinking was that since some APIs (e.g page response) also
> used by in-kernel code, I would avoid user pointer or another
> wrapper.
> 
> Perhaps need to clarify the roles of each layer, IMHO the roles are:
> - VFIO
> 	1. bundle IOMMU UAPI data with flags & argsz
> 	2. sanity check argsz > minsz
> 	3. determine the copy_from_user size based on VFIO flags & argsz
> 
> - IOMMU UAPI
> 	1. check argsz against current kernel IOMMU UAPI data size, its
> 	own minsz
> 	2. parse data based on feature/flags
> 
> So if VFIO already can decide the copy_from_user size as in VFIO.3, why
> can't it just do the copy as well. VFIO only checks and ensures size,
> nothing specific to the content of IOMMU UAPI. Does the role partition
> sound right?

As above, the only way that this can be a generic UAPI is if VFIO is
just a passthrough, otherwise this just becomes VFIO API and we might
as well not pretend we're creating a UAPI between the VFIO and IOMMU.
If a second user of the UAPI would duplicate the code from VFIO, then
it shouldn't be in VFIO.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
