Return-Path: <SRS0=3PM5=Y7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1510DC43331
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 23:20:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD8621882
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 23:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+NiYpHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD8621882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 93264B88;
	Thu,  7 Nov 2019 23:20:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3F158AF3
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 23:20:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 3FE86196
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 23:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1573168850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=9rfrHXvjlEObNs2iWxw5KSPyr0exJJ9zhEFMLURmLY8=;
	b=N+NiYpHT4KrgnM1qFm8WO1UrX1l/APeaPvflgjyKJ9JN5nDjXSvQL+zOw7G81iGnJEHvqX
	jPJUaI9lIE+hF0sGT4jzfUALU7+aXFVKl0jN7L8OE6YfWICSmI5fNkdZNMW2POeMHWuHj5
	5LVJRvKL535ATVjMmheuS2NWAalo5kE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
	[209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-283-cfrIKcAGPrm55-3vRuCOdg-1; Thu, 07 Nov 2019 18:20:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF54E1005500;
	Thu,  7 Nov 2019 23:20:47 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 85E74600F4;
	Thu,  7 Nov 2019 23:20:41 +0000 (UTC)
Date: Thu, 7 Nov 2019 16:20:41 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC v2 3/3] vfio/type1: bind guest pasid (guest page tables)
	to host
Message-ID: <20191107162041.31e620a4@x1.home>
In-Reply-To: <1571919983-3231-4-git-send-email-yi.l.liu@intel.com>
References: <1571919983-3231-1-git-send-email-yi.l.liu@intel.com>
	<1571919983-3231-4-git-send-email-yi.l.liu@intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: cfrIKcAGPrm55-3vRuCOdg-1
X-Mimecast-Spam-Score: 0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
	jean-philippe.brucker@arm.com, jun.j.tian@intel.com,
	iommu@lists.linux-foundation.org, yi.y.sun@intel.com
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

On Thu, 24 Oct 2019 08:26:23 -0400
Liu Yi L <yi.l.liu@intel.com> wrote:

> This patch adds vfio support to bind guest translation structure
> to host iommu. VFIO exposes iommu programming capability to user-
> space. Guest is a user-space application in host under KVM solution.
> For SVA usage in Virtual Machine, guest owns GVA->GPA translation
> structure. And this part should be passdown to host to enable nested
> translation (or say two stage translation). This patch reuses the
> VFIO_IOMMU_BIND proposal from Jean-Philippe Brucker, and adds new
> bind type for binding guest owned translation structure to host.
> 
> *) Add two new ioctls for VFIO containers.
> 
>   - VFIO_IOMMU_BIND: for bind request from userspace, it could be
>                    bind a process to a pasid or bind a guest pasid
>                    to a device, this is indicated by type
>   - VFIO_IOMMU_UNBIND: for unbind request from userspace, it could be
>                    unbind a process to a pasid or unbind a guest pasid
>                    to a device, also indicated by type
>   - Bind type:
> 	VFIO_IOMMU_BIND_PROCESS: user-space request to bind a process
>                    to a device
> 	VFIO_IOMMU_BIND_GUEST_PASID: bind guest owned translation
>                    structure to host iommu. e.g. guest page table
> 
> *) Code logic in vfio_iommu_type1_ioctl() to handle VFIO_IOMMU_BIND/UNBIND
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 136 ++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       |  44 +++++++++++++
>  2 files changed, 180 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 3d73a7d..1a27e25 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2325,6 +2325,104 @@ static int vfio_iommu_type1_pasid_free(struct vfio_iommu *iommu,
>  	return ret;
>  }
>  
> +static int vfio_bind_gpasid_fn(struct device *dev, void *data)
> +{
> +	struct domain_capsule *dc = (struct domain_capsule *)data;
> +	struct iommu_gpasid_bind_data *ustruct =
> +		(struct iommu_gpasid_bind_data *) dc->data;
> +
> +	return iommu_sva_bind_gpasid(dc->domain, dev, ustruct);
> +}
> +
> +static int vfio_unbind_gpasid_fn(struct device *dev, void *data)
> +{
> +	struct domain_capsule *dc = (struct domain_capsule *)data;
> +	struct iommu_gpasid_bind_data *ustruct =
> +		(struct iommu_gpasid_bind_data *) dc->data;
> +
> +	return iommu_sva_unbind_gpasid(dc->domain, dev,
> +						ustruct->hpasid);
> +}
> +
> +/*
> + * unbind specific gpasid, caller of this function requires hold
> + * vfio_iommu->lock
> + */
> +static long vfio_iommu_type1_do_guest_unbind(struct vfio_iommu *iommu,
> +		  struct iommu_gpasid_bind_data *gbind_data)
> +{
> +	return vfio_iommu_lookup_dev(iommu, vfio_unbind_gpasid_fn, gbind_data);
> +}
> +
> +static long vfio_iommu_type1_bind_gpasid(struct vfio_iommu *iommu,
> +					    void __user *arg,
> +					    struct vfio_iommu_type1_bind *bind)
> +{
> +	struct iommu_gpasid_bind_data gbind_data;
> +	unsigned long minsz;
> +	int ret = 0;
> +
> +	minsz = sizeof(*bind) + sizeof(gbind_data);
> +	if (bind->argsz < minsz)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&gbind_data, arg, sizeof(gbind_data)))
> +		return -EFAULT;
> +
> +	mutex_lock(&iommu->lock);
> +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	ret = vfio_iommu_lookup_dev(iommu, vfio_bind_gpasid_fn, &gbind_data);
> +	/*
> +	 * If bind failed, it may not be a total failure. Some devices within
> +	 * the iommu group may have bind successfully. Although we don't enable
> +	 * pasid capability for non-singletion iommu groups, a unbind operation
> +	 * would be helpful to ensure no partial binding for an iommu group.
> +	 */
> +	if (ret)
> +		/*
> +		 * Undo all binds that already succeeded, no need to check the
> +		 * return value here since some device within the group has no
> +		 * successful bind when coming to this place switch.
> +		 */
> +		vfio_iommu_type1_do_guest_unbind(iommu, &gbind_data);
> +
> +out_unlock:
> +	mutex_unlock(&iommu->lock);
> +	return ret;
> +}
> +
> +static long vfio_iommu_type1_unbind_gpasid(struct vfio_iommu *iommu,
> +					    void __user *arg,
> +					    struct vfio_iommu_type1_bind *bind)
> +{
> +	struct iommu_gpasid_bind_data gbind_data;
> +	unsigned long minsz;
> +	int ret = 0;
> +
> +	minsz = sizeof(*bind) + sizeof(gbind_data);
> +	if (bind->argsz < minsz)
> +		return -EINVAL;

But gbind_data can change size if new vendor specific data is added to
the union, so kernel updates break existing userspace.  Fail.

> +
> +	if (copy_from_user(&gbind_data, arg, sizeof(gbind_data)))
> +		return -EFAULT;
> +
> +	mutex_lock(&iommu->lock);
> +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	ret = vfio_iommu_type1_do_guest_unbind(iommu, &gbind_data);
> +
> +out_unlock:
> +	mutex_unlock(&iommu->lock);
> +	return ret;
> +}
> +
>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>  				   unsigned int cmd, unsigned long arg)
>  {
> @@ -2484,6 +2582,44 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  		default:
>  			return -EINVAL;
>  		}
> +
> +	} else if (cmd == VFIO_IOMMU_BIND) {
> +		struct vfio_iommu_type1_bind bind;
> +
> +		minsz = offsetofend(struct vfio_iommu_type1_bind, bind_type);
> +
> +		if (copy_from_user(&bind, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (bind.argsz < minsz)
> +			return -EINVAL;
> +
> +		switch (bind.bind_type) {
> +		case VFIO_IOMMU_BIND_GUEST_PASID:
> +			return vfio_iommu_type1_bind_gpasid(iommu,
> +					(void __user *)(arg + minsz), &bind);

Why are we defining BIND_PROCESS if it's not supported?  How does the
user learn it's not supported?

> +		default:
> +			return -EINVAL;
> +		}
> +
> +	} else if (cmd == VFIO_IOMMU_UNBIND) {
> +		struct vfio_iommu_type1_bind bind;
> +
> +		minsz = offsetofend(struct vfio_iommu_type1_bind, bind_type);
> +
> +		if (copy_from_user(&bind, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (bind.argsz < minsz)
> +			return -EINVAL;
> +
> +		switch (bind.bind_type) {
> +		case VFIO_IOMMU_BIND_GUEST_PASID:
> +			return vfio_iommu_type1_unbind_gpasid(iommu,
> +					(void __user *)(arg + minsz), &bind);
> +		default:
> +			return -EINVAL;
> +		}
>  	}
>  
>  	return -ENOTTY;
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 04de290..78e8c64 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -832,6 +832,50 @@ struct vfio_iommu_type1_pasid_request {
>   */
>  #define VFIO_IOMMU_PASID_REQUEST	_IO(VFIO_TYPE, VFIO_BASE + 27)
>  
> +enum vfio_iommu_bind_type {
> +	VFIO_IOMMU_BIND_PROCESS,
> +	VFIO_IOMMU_BIND_GUEST_PASID,
> +};
> +
> +/*
> + * Supported types:
> + *	- VFIO_IOMMU_BIND_GUEST_PASID: bind guest pasid, which invoked
> + *			by guest, it takes iommu_gpasid_bind_data in data.
> + */
> +struct vfio_iommu_type1_bind {
> +	__u32				argsz;
> +	enum vfio_iommu_bind_type	bind_type;
> +	__u8				data[];
> +};

I don't think enum defines a compiler invariant data size.  We can't
use it for a kernel/user interface.  Also why no flags field as is
essentially standard for every vfio ioctl?  Couldn't we specify
process/guest-pasid with flags?  For that matter couldn't we specify
bind/unbind using a single ioctl?  I think that would be more
consistent with the pasid alloc/free ioctl in the previous patch.

Why are we appending opaque data to the end of the structure when
clearly we expect a struct iommu_gpasid_bind_data?  That bind data
structure expects a format (ex. IOMMU_PASID_FORMAT_INTEL_VTD).  How does
a user determine what formats are accepted from within the vfio API (or
even outside of the vfio API)?

> +
> +/*
> + * VFIO_IOMMU_BIND - _IOWR(VFIO_TYPE, VFIO_BASE + 28, struct vfio_iommu_bind)
                            ^
The semantics appear to just be _IOW, nothing is written back to the
userspace buffer on return.

> + *
> + * Manage address spaces of devices in this container. Initially a TYPE1
> + * container can only have one address space, managed with
> + * VFIO_IOMMU_MAP/UNMAP_DMA.
> + *
> + * An IOMMU of type VFIO_TYPE1_NESTING_IOMMU can be managed by both MAP/UNMAP
> + * and BIND ioctls at the same time. MAP/UNMAP acts on the stage-2 (host) page
> + * tables, and BIND manages the stage-1 (guest) page tables. Other types of
> + * IOMMU may allow MAP/UNMAP and BIND to coexist, where MAP/UNMAP controls
> + * non-PASID traffic and BIND controls PASID traffic. But this depends on the
> + * underlying IOMMU architecture and isn't guaranteed.
> + *
> + * Availability of this feature depends on the device, its bus, the underlying
> + * IOMMU and the CPU architecture.

And the user discovers this is available by...?  There's no probe here,
are they left only to setup a VM to the point of trying to use this
before they fail the ioctl?  Could VFIO_IOMMU_GET_INFO fill this gap?
Thanks,

Alex

> + *
> + * returns: 0 on success, -errno on failure.
> + */
> +#define VFIO_IOMMU_BIND		_IO(VFIO_TYPE, VFIO_BASE + 28)
> +
> +/*
> + * VFIO_IOMMU_UNBIND - _IOWR(VFIO_TYPE, VFIO_BASE + 29, struct vfio_iommu_bind)
> + *
> + * Undo what was done by the corresponding VFIO_IOMMU_BIND ioctl.
> + */
> +#define VFIO_IOMMU_UNBIND	_IO(VFIO_TYPE, VFIO_BASE + 29)
> +
>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>  
>  /*

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
