Return-Path: <SRS0=kL4S=ZE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01870C17440
	for <iommu@archiver.kernel.org>; Tue, 12 Nov 2019 17:26:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B5D2084E
	for <iommu@archiver.kernel.org>; Tue, 12 Nov 2019 17:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPd1HCAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B5D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9C09AE61;
	Tue, 12 Nov 2019 17:25:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EA669E5A
	for <iommu@lists.linux-foundation.org>;
	Tue, 12 Nov 2019 17:25:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com
	(us-smtp-delivery-1.mimecast.com [207.211.31.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 8578E12F
	for <iommu@lists.linux-foundation.org>;
	Tue, 12 Nov 2019 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1573579555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=RgNm5vGJQ9dRe37oDh+EYyVmulqOmkZWRS+WQ/0s2fI=;
	b=iPd1HCAigV87Zgmp2Z8+hUO2FZ30g2kcQ24SxkJrxVU/6M2EwQzNPyAPNMCOVNcGiadJyi
	mekAf2gz4Kr25pv4EyWhLRgI1ssnEsnExHQJITQsUeoiLyOsqgUEVNvu5a3gd8iYjS1+dR
	ccmMFe9bkAZVRqPoPMTZXF1G+yJxzco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
	[209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-297-GPS7cFSANueYBwKZXvK8mA-1; Tue, 12 Nov 2019 12:25:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 193581938923;
	Tue, 12 Nov 2019 17:25:46 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 28C636046C;
	Tue, 12 Nov 2019 17:25:35 +0000 (UTC)
Date: Tue, 12 Nov 2019 10:25:34 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v2 3/3] vfio/type1: bind guest pasid (guest page tables)
	to host
Message-ID: <20191112102534.75968ccd@x1.home>
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A0F6894@SHSMSX104.ccr.corp.intel.com>
References: <1571919983-3231-1-git-send-email-yi.l.liu@intel.com>
	<1571919983-3231-4-git-send-email-yi.l.liu@intel.com>
	<20191107162041.31e620a4@x1.home>
	<A2975661238FB949B60364EF0F2C25743A0F6894@SHSMSX104.ccr.corp.intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: GPS7cFSANueYBwKZXvK8mA-1
X-Mimecast-Spam-Score: 0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
	"Tian, Jun J" <jun.j.tian@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"Sun, Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>, "Lu,
	Baolu" <baolu.lu@intel.com>
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

On Tue, 12 Nov 2019 11:21:40 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson < alex.williamson@redhat.com >
> > Sent: Friday, November 8, 2019 7:21 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [RFC v2 3/3] vfio/type1: bind guest pasid (guest page tables) to host
> > 
> > On Thu, 24 Oct 2019 08:26:23 -0400
> > Liu Yi L <yi.l.liu@intel.com> wrote:
> >   
> > > This patch adds vfio support to bind guest translation structure
> > > to host iommu. VFIO exposes iommu programming capability to user-
> > > space. Guest is a user-space application in host under KVM solution.
> > > For SVA usage in Virtual Machine, guest owns GVA->GPA translation
> > > structure. And this part should be passdown to host to enable nested
> > > translation (or say two stage translation). This patch reuses the
> > > VFIO_IOMMU_BIND proposal from Jean-Philippe Brucker, and adds new
> > > bind type for binding guest owned translation structure to host.
> > >
> > > *) Add two new ioctls for VFIO containers.
> > >
> > >   - VFIO_IOMMU_BIND: for bind request from userspace, it could be
> > >                    bind a process to a pasid or bind a guest pasid
> > >                    to a device, this is indicated by type
> > >   - VFIO_IOMMU_UNBIND: for unbind request from userspace, it could be
> > >                    unbind a process to a pasid or unbind a guest pasid
> > >                    to a device, also indicated by type
> > >   - Bind type:
> > > 	VFIO_IOMMU_BIND_PROCESS: user-space request to bind a process
> > >                    to a device
> > > 	VFIO_IOMMU_BIND_GUEST_PASID: bind guest owned translation
> > >                    structure to host iommu. e.g. guest page table
> > >
> > > *) Code logic in vfio_iommu_type1_ioctl() to handle VFIO_IOMMU_BIND/UNBIND
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > ---
> > >  drivers/vfio/vfio_iommu_type1.c | 136  
> > ++++++++++++++++++++++++++++++++++++++++  
> > >  include/uapi/linux/vfio.h       |  44 +++++++++++++
> > >  2 files changed, 180 insertions(+)
> > >
> > > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > > index 3d73a7d..1a27e25 100644
> > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > @@ -2325,6 +2325,104 @@ static int vfio_iommu_type1_pasid_free(struct  
> > vfio_iommu *iommu,  
> > >  	return ret;
> > >  }
> > >
> > > +static int vfio_bind_gpasid_fn(struct device *dev, void *data)
> > > +{
> > > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > > +	struct iommu_gpasid_bind_data *ustruct =
> > > +		(struct iommu_gpasid_bind_data *) dc->data;
> > > +
> > > +	return iommu_sva_bind_gpasid(dc->domain, dev, ustruct);
> > > +}
> > > +
> > > +static int vfio_unbind_gpasid_fn(struct device *dev, void *data)
> > > +{
> > > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > > +	struct iommu_gpasid_bind_data *ustruct =
> > > +		(struct iommu_gpasid_bind_data *) dc->data;
> > > +
> > > +	return iommu_sva_unbind_gpasid(dc->domain, dev,
> > > +						ustruct->hpasid);
> > > +}
> > > +
> > > +/*
> > > + * unbind specific gpasid, caller of this function requires hold
> > > + * vfio_iommu->lock
> > > + */
> > > +static long vfio_iommu_type1_do_guest_unbind(struct vfio_iommu *iommu,
> > > +		  struct iommu_gpasid_bind_data *gbind_data)
> > > +{
> > > +	return vfio_iommu_lookup_dev(iommu, vfio_unbind_gpasid_fn, gbind_data);
> > > +}
> > > +
> > > +static long vfio_iommu_type1_bind_gpasid(struct vfio_iommu *iommu,
> > > +					    void __user *arg,
> > > +					    struct vfio_iommu_type1_bind *bind)
> > > +{
> > > +	struct iommu_gpasid_bind_data gbind_data;
> > > +	unsigned long minsz;
> > > +	int ret = 0;
> > > +
> > > +	minsz = sizeof(*bind) + sizeof(gbind_data);
> > > +	if (bind->argsz < minsz)
> > > +		return -EINVAL;
> > > +
> > > +	if (copy_from_user(&gbind_data, arg, sizeof(gbind_data)))
> > > +		return -EFAULT;
> > > +
> > > +	mutex_lock(&iommu->lock);
> > > +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
> > > +		ret = -EINVAL;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	ret = vfio_iommu_lookup_dev(iommu, vfio_bind_gpasid_fn, &gbind_data);
> > > +	/*
> > > +	 * If bind failed, it may not be a total failure. Some devices within
> > > +	 * the iommu group may have bind successfully. Although we don't enable
> > > +	 * pasid capability for non-singletion iommu groups, a unbind operation
> > > +	 * would be helpful to ensure no partial binding for an iommu group.
> > > +	 */
> > > +	if (ret)
> > > +		/*
> > > +		 * Undo all binds that already succeeded, no need to check the
> > > +		 * return value here since some device within the group has no
> > > +		 * successful bind when coming to this place switch.
> > > +		 */
> > > +		vfio_iommu_type1_do_guest_unbind(iommu, &gbind_data);
> > > +
> > > +out_unlock:
> > > +	mutex_unlock(&iommu->lock);
> > > +	return ret;
> > > +}
> > > +
> > > +static long vfio_iommu_type1_unbind_gpasid(struct vfio_iommu *iommu,
> > > +					    void __user *arg,
> > > +					    struct vfio_iommu_type1_bind *bind)
> > > +{
> > > +	struct iommu_gpasid_bind_data gbind_data;
> > > +	unsigned long minsz;
> > > +	int ret = 0;
> > > +
> > > +	minsz = sizeof(*bind) + sizeof(gbind_data);
> > > +	if (bind->argsz < minsz)
> > > +		return -EINVAL;  
> > 
> > But gbind_data can change size if new vendor specific data is added to
> > the union, so kernel updates break existing userspace.  Fail.  
> 
> yes, we have a version field in struct iommu_gpasid_bind_data. How
> about doing sanity check per versions? kernel knows the gbind_data
> size of specific versions. Does it make sense? If yes, I'll also apply it
> to the other sanity check in this series to avoid userspace fail after
> kernel update.

Has it already been decided that the version field will be updated for
every addition to the union?  It seems there are two options, either
the version definition includes the possible contents of the union,
which means we need to support multiple versions concurrently in the
kernel to maintain compatibility with userspace and follow deprecation
protocols for removing that support, or we need to consider version to
be the general form of the structure and interpret the format field to
determine necessary length to copy from the user.

> > > +
> > > +	if (copy_from_user(&gbind_data, arg, sizeof(gbind_data)))
> > > +		return -EFAULT;
> > > +
> > > +	mutex_lock(&iommu->lock);
> > > +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
> > > +		ret = -EINVAL;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	ret = vfio_iommu_type1_do_guest_unbind(iommu, &gbind_data);
> > > +
> > > +out_unlock:
> > > +	mutex_unlock(&iommu->lock);
> > > +	return ret;
> > > +}
> > > +
> > >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> > >  				   unsigned int cmd, unsigned long arg)
> > >  {
> > > @@ -2484,6 +2582,44 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
> > >  		default:
> > >  			return -EINVAL;
> > >  		}
> > > +
> > > +	} else if (cmd == VFIO_IOMMU_BIND) {
> > > +		struct vfio_iommu_type1_bind bind;
> > > +
> > > +		minsz = offsetofend(struct vfio_iommu_type1_bind, bind_type);
> > > +
> > > +		if (copy_from_user(&bind, (void __user *)arg, minsz))
> > > +			return -EFAULT;
> > > +
> > > +		if (bind.argsz < minsz)
> > > +			return -EINVAL;
> > > +
> > > +		switch (bind.bind_type) {
> > > +		case VFIO_IOMMU_BIND_GUEST_PASID:
> > > +			return vfio_iommu_type1_bind_gpasid(iommu,
> > > +					(void __user *)(arg + minsz), &bind);  
> > 
> > Why are we defining BIND_PROCESS if it's not supported?  How does the
> > user learn it's not supported?  
> 
> I think I should drop it so far since I only add BIND_GUEST_PASID. I think
> Jean Philippe may need it in his native SVA enabling patchset. For the way
> to let user learn it, may be using VFIO_IOMMU_GET_INFO as you mentioned
> below?
> 
> >   
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +	} else if (cmd == VFIO_IOMMU_UNBIND) {
> > > +		struct vfio_iommu_type1_bind bind;
> > > +
> > > +		minsz = offsetofend(struct vfio_iommu_type1_bind, bind_type);
> > > +
> > > +		if (copy_from_user(&bind, (void __user *)arg, minsz))
> > > +			return -EFAULT;
> > > +
> > > +		if (bind.argsz < minsz)
> > > +			return -EINVAL;
> > > +
> > > +		switch (bind.bind_type) {
> > > +		case VFIO_IOMMU_BIND_GUEST_PASID:
> > > +			return vfio_iommu_type1_unbind_gpasid(iommu,
> > > +					(void __user *)(arg + minsz), &bind);
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> > >  	}
> > >
> > >  	return -ENOTTY;
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index 04de290..78e8c64 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -832,6 +832,50 @@ struct vfio_iommu_type1_pasid_request {
> > >   */
> > >  #define VFIO_IOMMU_PASID_REQUEST	_IO(VFIO_TYPE, VFIO_BASE + 27)
> > >
> > > +enum vfio_iommu_bind_type {
> > > +	VFIO_IOMMU_BIND_PROCESS,
> > > +	VFIO_IOMMU_BIND_GUEST_PASID,
> > > +};
> > > +
> > > +/*
> > > + * Supported types:
> > > + *	- VFIO_IOMMU_BIND_GUEST_PASID: bind guest pasid, which invoked
> > > + *			by guest, it takes iommu_gpasid_bind_data in data.
> > > + */
> > > +struct vfio_iommu_type1_bind {
> > > +	__u32				argsz;
> > > +	enum vfio_iommu_bind_type	bind_type;
> > > +	__u8				data[];
> > > +};  
> > 
> > I don't think enum defines a compiler invariant data size.  We can't
> > use it for a kernel/user interface.  Also why no flags field as is
> > essentially standard for every vfio ioctl?  Couldn't we specify
> > process/guest-pasid with flags?  
> 
> I remember there is an early comment in community which pointed out
> that using flags potentially allows to config multiples types in one IOCTL.
> Regards to it, defining explicit emums avoids it. But I agree with you,
> it makes variant size. I'll fix it if this matter more.
> 
> > For that matter couldn't we specify
> > bind/unbind using a single ioctl?  I think that would be more
> > consistent with the pasid alloc/free ioctl in the previous patch.  
> 
> yes, let me make it in next version.
> 
> > Why are we appending opaque data to the end of the structure when
> > clearly we expect a struct iommu_gpasid_bind_data?  
> 
> This is due to the intention to support BIND_GUEST_PASID and
> BIND_PROCESS with a single IOCTL. Maybe we can use a separate
> IOCTL for BIND_PROCESS. what's your opinion here?

If the ioctls have similar purpose and form, then re-using a single
ioctl might make sense, but BIND_PROCESS is only a place-holder in this
series, which is not acceptable.  A dual purpose ioctl does not
preclude that we could also use a union for the data field to make the
structure well specified.
 
> > That bind data
> > structure expects a format (ex. IOMMU_PASID_FORMAT_INTEL_VTD).  How does
> > a user determine what formats are accepted from within the vfio API (or
> > even outside of the vfio API)?  
> 
> The info is provided by vIOMMU emulator (e.g. virtual VT-d). The vSVA patch
> from Jacob has a sanity check on it.
> https://lkml.org/lkml/2019/10/28/873

The vIOMMU emulator runs at a layer above vfio.  How does the vIOMMU
emulator know that the vfio interface supports virtual VT-d?  IMO, it's
not acceptable that the user simply assume that an Intel host platform
supports VT-d.  For example, consider what happens when we need to
define IOMMU_PASID_FORMAT_INTEL_VTDv2.  How would the user learn that
VTDv2 is supported and the original VTD format is not supported?

> > > +
> > > +/*
> > > + * VFIO_IOMMU_BIND - _IOWR(VFIO_TYPE, VFIO_BASE + 28, struct  
> > vfio_iommu_bind)
> >                             ^
> > The semantics appear to just be _IOW, nothing is written back to the
> > userspace buffer on return.  
> 
> will fix it. thanks.
> 
> > > + *
> > > + * Manage address spaces of devices in this container. Initially a TYPE1
> > > + * container can only have one address space, managed with
> > > + * VFIO_IOMMU_MAP/UNMAP_DMA.
> > > + *
> > > + * An IOMMU of type VFIO_TYPE1_NESTING_IOMMU can be managed by both  
> > MAP/UNMAP  
> > > + * and BIND ioctls at the same time. MAP/UNMAP acts on the stage-2 (host) page
> > > + * tables, and BIND manages the stage-1 (guest) page tables. Other types of
> > > + * IOMMU may allow MAP/UNMAP and BIND to coexist, where MAP/UNMAP  
> > controls  
> > > + * non-PASID traffic and BIND controls PASID traffic. But this depends on the
> > > + * underlying IOMMU architecture and isn't guaranteed.
> > > + *
> > > + * Availability of this feature depends on the device, its bus, the underlying
> > > + * IOMMU and the CPU architecture.  
> > 
> > And the user discovers this is available by...?  There's no probe here,
> > are they left only to setup a VM to the point of trying to use this
> > before they fail the ioctl?  Could VFIO_IOMMU_GET_INFO fill this gap?
> > Thanks,  
> 
> I think VFIO_IOMMU_GET_INFO could help. let me extend it to fill this gap
> if you agree.

It's a start.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
