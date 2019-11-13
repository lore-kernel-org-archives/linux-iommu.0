Return-Path: <SRS0=M1C0=ZF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D803C17447
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 11:31:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D36E222C9
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 11:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D36E222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EB465F49;
	Wed, 13 Nov 2019 11:31:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4E81B2F
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 11:31:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 43796DF
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 11:31:03 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	13 Nov 2019 03:31:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,300,1569308400"; d="scan'208";a="235239419"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
	by fmsmga002.fm.intel.com with ESMTP; 13 Nov 2019 03:31:01 -0800
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
	FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Wed, 13 Nov 2019 03:31:00 -0800
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
	FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Wed, 13 Nov 2019 03:31:00 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
	shsmsx102.ccr.corp.intel.com ([169.254.2.108]) with mapi id
	14.03.0439.000; Wed, 13 Nov 2019 19:30:58 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [RFC v2 3/3] vfio/type1: bind guest pasid (guest page tables)
	to host
Thread-Topic: [RFC v2 3/3] vfio/type1: bind guest pasid (guest page tables)
	to host
Thread-Index: AQHVimn49qwPncOwpUK3oA3gYR4tBqd/6QGAgAdz7JCAAASEAIABX3gg//++iYCAAJBogA==
Date: Wed, 13 Nov 2019 11:30:58 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A0F8D22@SHSMSX104.ccr.corp.intel.com>
References: <1571919983-3231-1-git-send-email-yi.l.liu@intel.com>
	<1571919983-3231-4-git-send-email-yi.l.liu@intel.com>
	<20191107162041.31e620a4@x1.home>
	<A2975661238FB949B60364EF0F2C25743A0F6894@SHSMSX104.ccr.corp.intel.com>
	<20191112102534.75968ccd@x1.home>
	<A2975661238FB949B60364EF0F2C25743A0F8A70@SHSMSX104.ccr.corp.intel.com>
	<20191113102913.GA40832@lophozonia>
In-Reply-To: <20191113102913.GA40832@lophozonia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzhlMTRkZGYtNDc0Yi00ZDM0LWJjMmQtMzE0NTliYjQxZWJmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSUpFWnNvZFFUUXRHOGpGcGl1bWJjM1ZkVHlDaFltRkVFU08wdERIbmFJTHB5dXdVOVdaRGV5bGt6SUNuRCt3XC8ifQ==
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
	"Tian, Jun J" <jun.j.tian@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"Lu, Baolu" <baolu.lu@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>, "Sun, 
	Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

> From: Jean-Philippe Brucker [mailto:jean-philippe@linaro.org]
> Sent: Wednesday, November 13, 2019 6:29 PM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v2 3/3] vfio/type1: bind guest pasid (guest page tables) to host
> 
> On Wed, Nov 13, 2019 at 07:43:43AM +0000, Liu, Yi L wrote:
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Wednesday, November 13, 2019 1:26 AM
> > > To: Liu, Yi L <yi.l.liu@intel.com>
> > > Subject: Re: [RFC v2 3/3] vfio/type1: bind guest pasid (guest page tables) to host
> > >
> > > On Tue, 12 Nov 2019 11:21:40 +0000
> > > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> > >
> > > > > From: Alex Williamson < alex.williamson@redhat.com >
> > > > > Sent: Friday, November 8, 2019 7:21 AM
> > > > > To: Liu, Yi L <yi.l.liu@intel.com>
> > > > > Subject: Re: [RFC v2 3/3] vfio/type1: bind guest pasid (guest page tables) to
> host
> > > > >
> > > > > On Thu, 24 Oct 2019 08:26:23 -0400
> > > > > Liu Yi L <yi.l.liu@intel.com> wrote:
> > > > >
> > > > > > This patch adds vfio support to bind guest translation structure
> > > > > > to host iommu. VFIO exposes iommu programming capability to user-
> > > > > > space. Guest is a user-space application in host under KVM solution.
> > > > > > For SVA usage in Virtual Machine, guest owns GVA->GPA translation
> > > > > > structure. And this part should be passdown to host to enable nested
> > > > > > translation (or say two stage translation). This patch reuses the
> > > > > > VFIO_IOMMU_BIND proposal from Jean-Philippe Brucker, and adds new
> > > > > > bind type for binding guest owned translation structure to host.
> > > > > >
> > > > > > *) Add two new ioctls for VFIO containers.
> > > > > >
> > > > > >   - VFIO_IOMMU_BIND: for bind request from userspace, it could be
> > > > > >                    bind a process to a pasid or bind a guest pasid
> > > > > >                    to a device, this is indicated by type
> > > > > >   - VFIO_IOMMU_UNBIND: for unbind request from userspace, it could be
> > > > > >                    unbind a process to a pasid or unbind a guest pasid
> > > > > >                    to a device, also indicated by type
> > > > > >   - Bind type:
> > > > > > 	VFIO_IOMMU_BIND_PROCESS: user-space request to bind a
> process
> > > > > >                    to a device
> > > > > > 	VFIO_IOMMU_BIND_GUEST_PASID: bind guest owned translation
> > > > > >                    structure to host iommu. e.g. guest page table
> > > > > >
> > > > > > *) Code logic in vfio_iommu_type1_ioctl() to handle
> > > VFIO_IOMMU_BIND/UNBIND
> > > > > >
> > [...]
> > > > > > +static long vfio_iommu_type1_unbind_gpasid(struct vfio_iommu *iommu,
> > > > > > +					    void __user *arg,
> > > > > > +					    struct vfio_iommu_type1_bind
> *bind)
> > > > > > +{
> > > > > > +	struct iommu_gpasid_bind_data gbind_data;
> > > > > > +	unsigned long minsz;
> > > > > > +	int ret = 0;
> > > > > > +
> > > > > > +	minsz = sizeof(*bind) + sizeof(gbind_data);
> > > > > > +	if (bind->argsz < minsz)
> > > > > > +		return -EINVAL;
> > > > >
> > > > > But gbind_data can change size if new vendor specific data is added to
> > > > > the union, so kernel updates break existing userspace.  Fail.
> 
> I guess we could take minsz up to the vendor-specific data, copy @format,
> and then check the size of vendor-specific data?

Agreed.

> 
> > > >
> > > > yes, we have a version field in struct iommu_gpasid_bind_data. How
> > > > about doing sanity check per versions? kernel knows the gbind_data
> > > > size of specific versions. Does it make sense? If yes, I'll also apply it
> > > > to the other sanity check in this series to avoid userspace fail after
> > > > kernel update.
> > >
> > > Has it already been decided that the version field will be updated for
> > > every addition to the union?
> >
> > No, just my proposal. Jacob may help to explain the purpose of version
> > field. But if we may be too  "frequent" for an uapi version number updating
> > if we inc version for each change in the union part. I may vote for the
> > second option from you below.
> >
> > > It seems there are two options, either
> > > the version definition includes the possible contents of the union,
> > > which means we need to support multiple versions concurrently in the
> > > kernel to maintain compatibility with userspace and follow deprecation
> > > protocols for removing that support, or we need to consider version to
> > > be the general form of the structure and interpret the format field to
> > > determine necessary length to copy from the user.
> >
> > As I mentioned above, may be better to let @version field only over the
> > general fields and let format to cover the possible changes in union. e.g.
> > IOMMU_PASID_FORMAT_INTEL_VTD2 may means version 2 of Intel
> > VT-d bind. But either way, I think we need to let kernel maintain multiple
> > versions to support compatible userspace. e.g. may have multiple versions
> > iommu_gpasid_bind_data_vtd struct in the union part.
> 
> I couldn't find where the @version field originated in our old
> discussions, but I believe our plan for allowing future extensions was:
> 
> * Add new vendor-specific data by introducing a new format
>   (IOMMU_PASID_FORMAT_INTEL_VTD2,
> IOMMU_PASID_FORMAT_ARM_SMMUV2...), and
>   extend the union.
> 
> * Add a new common field, if it fits in the existing padding bytes, by
>   adding a flag (IOMMU_SVA_GPASID_*).
> 
> * Add a new common field, if it doesn't fit in the current padding bytes,
>   or completely change the structure layout, by introducing a new version
>   (IOMMU_GPASID_BIND_VERSION_2). In that case the kernel has to handle
>   both new and old structure versions. It would have both
>   iommu_gpasid_bind_data and iommu_gpasid_bind_data_v2 structs.
> 
> I think iommu_cache_invalidate_info and iommu_page_response use the same
> scheme. iommu_fault is a bit more complicated because it's
> kernel->userspace and requires some negotiation:
> https://lore.kernel.org/linux-iommu/77405d39-81a4-d9a8-5d35-
> 27602199867a@arm.com/

Thanks for the excellent recap.

> [...]
> > > If the ioctls have similar purpose and form, then re-using a single
> > > ioctl might make sense, but BIND_PROCESS is only a place-holder in this
> > > series, which is not acceptable.  A dual purpose ioctl does not
> > > preclude that we could also use a union for the data field to make the
> > > structure well specified.
> >
> > yes, BIND_PROCESS is only a place-holder here. From kernel p.o.v., both
> > BIND_GUEST_PASID and BIND_PROCESS are bind requests from userspace.
> > So the purposes are aligned. Below is the content the @data[] field
> > supposed to convey for BIND_PROCESS. If we use union, it would leave
> > space for extending it to support BIND_PROCESS. If only data[], it is a little
> > bit confusing why we define it in such manner if BIND_PROCESS is included
> > in this series. Please feel free let me know which one suits better.
> >
> > +struct vfio_iommu_type1_bind_process {
> > +	__u32	flags;
> > +#define VFIO_IOMMU_BIND_PID		(1 << 0)
> > +	__u32	pasid;
> > +	__s32	pid;
> > +};
> > https://patchwork.kernel.org/patch/10394927/
> 
> Note that I don't plan to upstream BIND_PROCESS at the moment. It was
> useful for testing but I don't know of anyone actually needing it.

yes, you told me during KVM forum. But if we want to share IOCTL, may
need to leave a place for you to extend. If @data[] is not good, then may
use union.

> > > > > That bind data
> > > > > structure expects a format (ex. IOMMU_PASID_FORMAT_INTEL_VTD).  How
> > > does
> > > > > a user determine what formats are accepted from within the vfio API (or
> > > > > even outside of the vfio API)?
> > > >
> > > > The info is provided by vIOMMU emulator (e.g. virtual VT-d). The vSVA patch
> > > > from Jacob has a sanity check on it.
> > > > https://lkml.org/lkml/2019/10/28/873
> > >
> > > The vIOMMU emulator runs at a layer above vfio.  How does the vIOMMU
> > > emulator know that the vfio interface supports virtual VT-d?  IMO, it's
> > > not acceptable that the user simply assume that an Intel host platform
> > > supports VT-d.  For example, consider what happens when we need to
> > > define IOMMU_PASID_FORMAT_INTEL_VTDv2.  How would the user learn that
> > > VTDv2 is supported and the original VTD format is not supported?
> >
> > I guess this may be another info VFIO_IOMMU_GET_INFO should provide.
> > It makes sense that vfio be aware of what platform it is running on. right?
> > After vfio gets the info, may let vfio fill in the format info. Is it the correct
> > direction?
> 
> I thought you were planning to put that information in sysfs?  We last
> discussed this over a year ago so I don't remember where we left it. I

yes, we did have such discussion to do hardware iommu capability query via
sysfs. If only want to let vIOMMU learn what format it should use, then GET_INFO
may be enough. e.g. vfio just asks its backed iommu driver. hey, do you support
nested translation? what format do you prefer? But I'm open on it.

> know Alex isn't keen on putting in sysfs what can be communicated through
> VFIO, but it is a convenient way to describe IOMMU features:
> http://www.linux-arm.org/git?p=linux-
> jpb.git;a=commitdiff;h=665370d5b5e0022c24b2d2b57975ef6fe7b40870;hp=7ce780
> d838889b53f5e04ba5d444520621261eda
> 
> My problem with GET_INFO was that it could be difficult to extend, and
> to describe things like variable-size list of supported page table
> formats, but I guess the new info capabilities make this easier.

yeah, you also need to make the info generic if want to extend something.
As I said, I'm open with it. Please feel free let me know if you've got other
ideas.

Regards,
Yi Liu

> Thanks,
> Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
