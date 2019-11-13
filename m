Return-Path: <SRS0=M1C0=ZF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF806C43331
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 10:29:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F72222C1
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 10:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RumFIDs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F72222C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3D84A1166;
	Wed, 13 Nov 2019 10:29:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9202C1153
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 10:29:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 65670102
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 10:29:18 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id l17so1395846wmh.0
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 02:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=bsjIZLYia+vrFTNwavj/iNfV5EniSbT9I24Iyxf6/hk=;
	b=RumFIDs9Le6eVObHIFr/VwWrTJW7U8jwLsqux2O+F7waURQ5/vC5NsmjciJiQLhNdS
	EDUeMzFnud2BYjktI4Sz3xjzi86fRLwgrcxgESiETrTdlwjX7SckobTDMfwNSuCgD4WP
	R4jsvIxWLefAjyIGlSkf0cf7R8AZDQ1IsJB+UbfxcepMgAHCRGj8JjpcJ1DfZ9ugp+8L
	viGcY1Kq6yK0iYBpc7FrA2+1BagiTXblowW2v9yBkwrbE3Rln77rZfWjy3NwagD5rSAV
	+p4gaxCdQsIUWzcLDeWvpyW9Mw0MEtRXLB1iJ6S02BalnUIc6CBjwObg8mbV9YoJFMN1
	MQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=bsjIZLYia+vrFTNwavj/iNfV5EniSbT9I24Iyxf6/hk=;
	b=iUMisdWcVUeunmscD+rMRKvFjFRACNI48LO7hs4W2P+3GYlSGiIvlaDQ3E9/cFZCJu
	PZCd0CoG9rRDQSNQWeqbskuj0gruK1Q/zosrKsfKmyEU84AoJO1X14TffkLIceDbA8Pj
	44gBFW1YypdHZQ44dewRZ9tJR++u85Kdz35S0vuejmw1d1FqAHeEQY710aNJcL5YqTDo
	l0mdpAP1LrA4KCfqwdQe5+VRacpZwK95f+HQklU+H9Lz1CGhV5SRGwrfJjLBzqjyTKrW
	Yni+4EFuvTDZcf7sKRhbDIFnTzXCa7SacIUQBQHvpmjjsUEd3AC52PhW+a0z9O9Ud4yW
	pIOA==
X-Gm-Message-State: APjAAAUCyK4wm/vM2VWwc/+y/8duOpnx9jAKret5bKlaJe75s9GS4dA2
	l2pObHnHsuvupdwN+zhjUAsy3Q==
X-Google-Smtp-Source: APXvYqzfQeYKABOrX6ucivv+kycxhOS8kp6SIcU13zgINoNC5n22DLPCvjZpdzQ0XMcUtvtTRZS4hg==
X-Received: by 2002:a05:600c:218e:: with SMTP id
	e14mr1917018wme.22.1573640956906; 
	Wed, 13 Nov 2019 02:29:16 -0800 (PST)
Received: from lophozonia (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
	by smtp.gmail.com with ESMTPSA id
	p10sm1828726wmi.44.2019.11.13.02.29.15
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 13 Nov 2019 02:29:16 -0800 (PST)
Date: Wed, 13 Nov 2019 11:29:13 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v2 3/3] vfio/type1: bind guest pasid (guest page tables) to
	host
Message-ID: <20191113102913.GA40832@lophozonia>
References: <1571919983-3231-1-git-send-email-yi.l.liu@intel.com>
	<1571919983-3231-4-git-send-email-yi.l.liu@intel.com>
	<20191107162041.31e620a4@x1.home>
	<A2975661238FB949B60364EF0F2C25743A0F6894@SHSMSX104.ccr.corp.intel.com>
	<20191112102534.75968ccd@x1.home>
	<A2975661238FB949B60364EF0F2C25743A0F8A70@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A0F8A70@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
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

On Wed, Nov 13, 2019 at 07:43:43AM +0000, Liu, Yi L wrote:
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Wednesday, November 13, 2019 1:26 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [RFC v2 3/3] vfio/type1: bind guest pasid (guest page tables) to host
> > 
> > On Tue, 12 Nov 2019 11:21:40 +0000
> > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> > 
> > > > From: Alex Williamson < alex.williamson@redhat.com >
> > > > Sent: Friday, November 8, 2019 7:21 AM
> > > > To: Liu, Yi L <yi.l.liu@intel.com>
> > > > Subject: Re: [RFC v2 3/3] vfio/type1: bind guest pasid (guest page tables) to host
> > > >
> > > > On Thu, 24 Oct 2019 08:26:23 -0400
> > > > Liu Yi L <yi.l.liu@intel.com> wrote:
> > > >
> > > > > This patch adds vfio support to bind guest translation structure
> > > > > to host iommu. VFIO exposes iommu programming capability to user-
> > > > > space. Guest is a user-space application in host under KVM solution.
> > > > > For SVA usage in Virtual Machine, guest owns GVA->GPA translation
> > > > > structure. And this part should be passdown to host to enable nested
> > > > > translation (or say two stage translation). This patch reuses the
> > > > > VFIO_IOMMU_BIND proposal from Jean-Philippe Brucker, and adds new
> > > > > bind type for binding guest owned translation structure to host.
> > > > >
> > > > > *) Add two new ioctls for VFIO containers.
> > > > >
> > > > >   - VFIO_IOMMU_BIND: for bind request from userspace, it could be
> > > > >                    bind a process to a pasid or bind a guest pasid
> > > > >                    to a device, this is indicated by type
> > > > >   - VFIO_IOMMU_UNBIND: for unbind request from userspace, it could be
> > > > >                    unbind a process to a pasid or unbind a guest pasid
> > > > >                    to a device, also indicated by type
> > > > >   - Bind type:
> > > > > 	VFIO_IOMMU_BIND_PROCESS: user-space request to bind a process
> > > > >                    to a device
> > > > > 	VFIO_IOMMU_BIND_GUEST_PASID: bind guest owned translation
> > > > >                    structure to host iommu. e.g. guest page table
> > > > >
> > > > > *) Code logic in vfio_iommu_type1_ioctl() to handle
> > VFIO_IOMMU_BIND/UNBIND
> > > > >
> [...]
> > > > > +static long vfio_iommu_type1_unbind_gpasid(struct vfio_iommu *iommu,
> > > > > +					    void __user *arg,
> > > > > +					    struct vfio_iommu_type1_bind *bind)
> > > > > +{
> > > > > +	struct iommu_gpasid_bind_data gbind_data;
> > > > > +	unsigned long minsz;
> > > > > +	int ret = 0;
> > > > > +
> > > > > +	minsz = sizeof(*bind) + sizeof(gbind_data);
> > > > > +	if (bind->argsz < minsz)
> > > > > +		return -EINVAL;
> > > >
> > > > But gbind_data can change size if new vendor specific data is added to
> > > > the union, so kernel updates break existing userspace.  Fail.

I guess we could take minsz up to the vendor-specific data, copy @format,
and then check the size of vendor-specific data?

> > >
> > > yes, we have a version field in struct iommu_gpasid_bind_data. How
> > > about doing sanity check per versions? kernel knows the gbind_data
> > > size of specific versions. Does it make sense? If yes, I'll also apply it
> > > to the other sanity check in this series to avoid userspace fail after
> > > kernel update.
> > 
> > Has it already been decided that the version field will be updated for
> > every addition to the union?
> 
> No, just my proposal. Jacob may help to explain the purpose of version
> field. But if we may be too  "frequent" for an uapi version number updating
> if we inc version for each change in the union part. I may vote for the
> second option from you below.
> 
> > It seems there are two options, either
> > the version definition includes the possible contents of the union,
> > which means we need to support multiple versions concurrently in the
> > kernel to maintain compatibility with userspace and follow deprecation
> > protocols for removing that support, or we need to consider version to
> > be the general form of the structure and interpret the format field to
> > determine necessary length to copy from the user.
> 
> As I mentioned above, may be better to let @version field only over the
> general fields and let format to cover the possible changes in union. e.g.
> IOMMU_PASID_FORMAT_INTEL_VTD2 may means version 2 of Intel
> VT-d bind. But either way, I think we need to let kernel maintain multiple
> versions to support compatible userspace. e.g. may have multiple versions
> iommu_gpasid_bind_data_vtd struct in the union part.

I couldn't find where the @version field originated in our old
discussions, but I believe our plan for allowing future extensions was:

* Add new vendor-specific data by introducing a new format
  (IOMMU_PASID_FORMAT_INTEL_VTD2, IOMMU_PASID_FORMAT_ARM_SMMUV2...), and
  extend the union.

* Add a new common field, if it fits in the existing padding bytes, by
  adding a flag (IOMMU_SVA_GPASID_*).

* Add a new common field, if it doesn't fit in the current padding bytes,
  or completely change the structure layout, by introducing a new version
  (IOMMU_GPASID_BIND_VERSION_2). In that case the kernel has to handle
  both new and old structure versions. It would have both
  iommu_gpasid_bind_data and iommu_gpasid_bind_data_v2 structs.

I think iommu_cache_invalidate_info and iommu_page_response use the same
scheme. iommu_fault is a bit more complicated because it's
kernel->userspace and requires some negotiation:
https://lore.kernel.org/linux-iommu/77405d39-81a4-d9a8-5d35-27602199867a@arm.com/

[...]
> > If the ioctls have similar purpose and form, then re-using a single
> > ioctl might make sense, but BIND_PROCESS is only a place-holder in this
> > series, which is not acceptable.  A dual purpose ioctl does not
> > preclude that we could also use a union for the data field to make the
> > structure well specified.
> 
> yes, BIND_PROCESS is only a place-holder here. From kernel p.o.v., both
> BIND_GUEST_PASID and BIND_PROCESS are bind requests from userspace.
> So the purposes are aligned. Below is the content the @data[] field
> supposed to convey for BIND_PROCESS. If we use union, it would leave
> space for extending it to support BIND_PROCESS. If only data[], it is a little
> bit confusing why we define it in such manner if BIND_PROCESS is included
> in this series. Please feel free let me know which one suits better.
> 
> +struct vfio_iommu_type1_bind_process {
> +	__u32	flags;
> +#define VFIO_IOMMU_BIND_PID		(1 << 0)
> +	__u32	pasid;
> +	__s32	pid;
> +};
> https://patchwork.kernel.org/patch/10394927/

Note that I don't plan to upstream BIND_PROCESS at the moment. It was
useful for testing but I don't know of anyone actually needing it.

> > > > That bind data
> > > > structure expects a format (ex. IOMMU_PASID_FORMAT_INTEL_VTD).  How
> > does
> > > > a user determine what formats are accepted from within the vfio API (or
> > > > even outside of the vfio API)?
> > >
> > > The info is provided by vIOMMU emulator (e.g. virtual VT-d). The vSVA patch
> > > from Jacob has a sanity check on it.
> > > https://lkml.org/lkml/2019/10/28/873
> > 
> > The vIOMMU emulator runs at a layer above vfio.  How does the vIOMMU
> > emulator know that the vfio interface supports virtual VT-d?  IMO, it's
> > not acceptable that the user simply assume that an Intel host platform
> > supports VT-d.  For example, consider what happens when we need to
> > define IOMMU_PASID_FORMAT_INTEL_VTDv2.  How would the user learn that
> > VTDv2 is supported and the original VTD format is not supported?
> 
> I guess this may be another info VFIO_IOMMU_GET_INFO should provide.
> It makes sense that vfio be aware of what platform it is running on. right?
> After vfio gets the info, may let vfio fill in the format info. Is it the correct
> direction?

I thought you were planning to put that information in sysfs?  We last
discussed this over a year ago so I don't remember where we left it. I
know Alex isn't keen on putting in sysfs what can be communicated through
VFIO, but it is a convenient way to describe IOMMU features:
http://www.linux-arm.org/git?p=linux-jpb.git;a=commitdiff;h=665370d5b5e0022c24b2d2b57975ef6fe7b40870;hp=7ce780d838889b53f5e04ba5d444520621261eda

My problem with GET_INFO was that it could be difficult to extend, and
to describe things like variable-size list of supported page table
formats, but I guess the new info capabilities make this easier.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
