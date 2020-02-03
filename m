Return-Path: <SRS0=8Bah=3X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEC5C35247
	for <iommu@archiver.kernel.org>; Mon,  3 Feb 2020 21:12:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E200620721
	for <iommu@archiver.kernel.org>; Mon,  3 Feb 2020 21:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWWTirFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E200620721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BD56084D2E;
	Mon,  3 Feb 2020 21:12:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5JlmksyqGz66; Mon,  3 Feb 2020 21:12:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 09C17849B7;
	Mon,  3 Feb 2020 21:12:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3984C1D80;
	Mon,  3 Feb 2020 21:12:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E78AEC0174
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 21:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CBAF286AD4
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 21:12:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TIxyxeiDNZUk for <iommu@lists.linux-foundation.org>;
 Mon,  3 Feb 2020 21:12:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CF6CF86632
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 21:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580764365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dWzG7PtpFOpu0mSurhqb7LJ3vm61wF5WCX6YxfmtBrw=;
 b=KWWTirFA8NHoVBGWf73yvRw+vbPYBS4/A+dYmqCRP4CzSFUlH81wcUzD8h6OnwyYGf8qjH
 x4CMvvWUeQ5SiHF18YBvwR2BvkGNBUGHqrBbOeKBXCpxOSbgMAGfEuIPahB8xPCP9MbXwd
 +Qv/dUG9iasmgn30/e6zWKGrneY3Pig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-Xq85z_ccNJ2oJMixeqVHXg-1; Mon, 03 Feb 2020 16:12:42 -0500
X-MC-Unique: Xq85z_ccNJ2oJMixeqVHXg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F25A8014D7;
 Mon,  3 Feb 2020 21:12:40 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99EB019C58;
 Mon,  3 Feb 2020 21:12:36 +0000 (UTC)
Date: Mon, 3 Feb 2020 14:12:36 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 3/3] iommu/uapi: Add helper function for size lookup
Message-ID: <20200203141236.4e2d7a74@w520.home>
In-Reply-To: <20200203124143.05061d1e@jacob-builder>
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277724-66994-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200129144046.3f91e4c1@w520.home>
 <20200129151951.2e354e37@w520.home>
 <20200131155125.53475a72@jacob-builder>
 <20200203112708.14174ce2@w520.home>
 <20200203124143.05061d1e@jacob-builder>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

On Mon, 3 Feb 2020 12:41:43 -0800
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> On Mon, 3 Feb 2020 11:27:08 -0700
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > On Fri, 31 Jan 2020 15:51:25 -0800
> > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> >   
> > > Hi Alex,
> > > Sorry I missed this part in the previous reply. Comments below.
> > > 
> > > On Wed, 29 Jan 2020 15:19:51 -0700
> > > Alex Williamson <alex.williamson@redhat.com> wrote:
> > >     
> > > > Also, is the 12-bytes of padding in struct iommu_gpasid_bind_data
> > > > excessive with this new versioning scheme?  Per rule #2 I'm not
> > > > sure if we're allowed to repurpose those padding bytes,      
> > > We can still use the padding bytes as long as there is a new flag
> > > bit to indicate the validity of the new filed within the padding.
> > > I should have made it clear in rule #2 when mentioning the flags
> > > bits. Should define what extension constitutes.
> > > How about this?
> > > "
> > >  * 2. Data structures are open to extension but closed to
> > > modification.
> > >  *    Extension should leverage the padding bytes first where a new
> > >  *    flag bit is required to indicate the validity of each new
> > > member.
> > >  *    The above rule for padding bytes also applies to adding new
> > > union
> > >  *    members.
> > >  *    After padding bytes are exhausted, new fields must be added
> > > at the
> > >  *    end of each data structure with 64bit alignment. Flag bits
> > > can be
> > >  *    added without size change but existing ones cannot be altered.
> > >  *
> > > "
> > > So if we add new field by doing re-purpose of padding bytes, size
> > > lookup result will remain the same. New code would recognize the new
> > > flag, old code stays the same.
> > > 
> > > VFIO layer checks for UAPI compatibility and size to copy, version
> > > sanity check and flag usage are done in the IOMMU code.
> > >     
> > > > but if we add
> > > > fields to the end of the structure as the scheme suggests, we're
> > > > stuck with not being able to expand the union for new fields.      
> > > Good point, it does sound contradictory. I hope the rewritten rule
> > > #2 address that.
> > > Adding data after the union should be extremely rare. Do you see any
> > > issues with the example below?
> > >  
> > >  offsetofend() can still find the right size.
> > > e.g.
> > > V1
> > > struct iommu_gpasid_bind_data {
> > > 	__u32 version;
> > > #define IOMMU_PASID_FORMAT_INTEL_VTD	1
> > > 	__u32 format;
> > > #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> > > 	__u64 flags;
> > > 	__u64 gpgd;
> > > 	__u64 hpasid;
> > > 	__u64 gpasid;
> > > 	__u32 addr_width;
> > > 	__u8  padding[12];
> > > 	/* Vendor specific data */
> > > 	union {
> > > 		struct iommu_gpasid_bind_data_vtd vtd;
> > > 	};
> > > };
> > > 
> > > const static int
> > > iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = { /*
> > > IOMMU_UAPI_BIND_GPASID */ {offsetofend(struct
> > > iommu_gpasid_bind_data, vtd)}, ...
> > > };
> > > 
> > > V2, Add new_member at the end (forget padding for now).
> > > struct iommu_gpasid_bind_data {
> > > 	__u32 version;
> > > #define IOMMU_PASID_FORMAT_INTEL_VTD	1
> > > 	__u32 format;
> > > #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> > > #define IOMMU_NEW_MEMBER_VAL	(1 << 1) /* new member added */
> > > 	__u64 flags;
> > > 	__u64 gpgd;
> > > 	__u64 hpasid;
> > > 	__u64 gpasid;
> > > 	__u32 addr_width;
> > > 	__u8  padding[12];
> > > 	/* Vendor specific data */
> > > 	union {
> > > 		struct iommu_gpasid_bind_data_vtd vtd;
> > > 	};
> > > 	__u64 new_member;
> > > };
> > > const static int
> > > iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = { /*
> > > IOMMU_UAPI_BIND_GPASID */ 
> > > 	{offsetofend(struct iommu_gpasid_bind_data,
> > > 	vtd), offsetofend(struct
> > > iommu_gpasid_bind_data,new_member)},
> > > 
> > > };
> > > 
> > > V3, Add smmu to the union,larger than vtd
> > > 
> > > struct iommu_gpasid_bind_data {
> > > 	__u32 version;
> > > #define IOMMU_PASID_FORMAT_INTEL_VTD	1
> > > #define IOMMU_PASID_FORMAT_INTEL_SMMU	2
> > > 	__u32 format;
> > > #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> > > #define IOMMU_NEW_MEMBER_VAL	(1 << 1) /* new member added */
> > > #define IOMMU_SVA_SMMU_SUPP	(1 << 2) /* SMMU data supported
> > > */ __u64 flags;
> > > 	__u64 gpgd;
> > > 	__u64 hpasid;
> > > 	__u64 gpasid;
> > > 	__u32 addr_width;
> > > 	__u8  padding[12];
> > > 	/* Vendor specific data */
> > > 	union {
> > > 		struct iommu_gpasid_bind_data_vtd vtd;
> > > 		struct iommu_gpasid_bind_data_smmu smmu;
> > > 	};
> > > 	__u64 new_member;
> > > };
> > > const static int
> > > iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = {
> > > 	/* IOMMU_UAPI_BIND_GPASID */
> > > 	{offsetofend(struct iommu_gpasid_bind_data,vtd),
> > > 	offsetofend(struct iommu_gpasid_bind_data, new_member),
> > > 	offsetofend(struct iommu_gpasid_bind_data, new_member)},
> > > ...
> > > };
> > >     
> > 
> > How are you not breaking rule #3, "Versions are backward compatible"
> > with this?  If the kernel is at version 3 and userspace is at version
> > 2 then new_member exists at different offsets of the structure.  The
> > kernels iommu_uapi_data_size for V2 changed between version 2 and 3.
> > Thanks,
> >   
> You are right. if we want to add new member to the end of the structure
> as well as expanding union, I think we have to fix the size of the
> union. Would this work? (just an example for one struct)
> 
> 
> @@ -344,6 +348,11 @@ struct iommu_gpasid_bind_data_vtd {
>   * @gpasid:    Process address space ID used for the guest mm in guest
> IOMMU
>   * @addr_width:        Guest virtual address width
>   * @padding:   Reserved for future use (should be zero)
> + * @dummy      Reserve space for vendor specific data in the union. New
> + *             members added to the union cannot exceed the size of
> dummy.
> + *             The fixed size union is needed to allow further
> expansion
> + *             after the end of the union while still maintain backward
> + *             compatibility.
>   * @vtd:       Intel VT-d specific data
>   *
>   * Guest to host PASID mapping can be an identity or non-identity,
> where guest @@ -365,6 +374,7 @@ struct iommu_gpasid_bind_data {
>         __u8  padding[12];
>         /* Vendor specific data */
>         union {
> +               __u8 dummy[128];
>                 struct iommu_gpasid_bind_data_vtd vtd;
>         };
>  };

It's not the most space efficient thing and we're just guessing at what
might need to be added into that union in future, but it works... until
it doesn't ;)  One might also argue that we could inflate the padding
field even further to serve the same purpose.  The only other route I
can think of would be to let the user specify the offset of the
variable size data from the start of the structure, for example similar
to how we're laying out vfio migration region or how we do capabilities
in vfio ioctls.  This is where passing an argsz for each ioctl comes in
handy so we're not limited to a structure, we can link various
structures together in a chain.  Of course that requires work on both
the user and kernel side to pack and unpack, but it leaves a lot of
flexibility in extending it.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
