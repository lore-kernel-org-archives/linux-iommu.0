Return-Path: <SRS0=oZX7=VP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE3EC76191
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 10:17:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85B82173B
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 10:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85B82173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 78CE114F8;
	Thu, 18 Jul 2019 10:17:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0C94A1411
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 10:17:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 356CF25A
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 10:17:13 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C2B1C057EC0;
	Thu, 18 Jul 2019 10:17:12 +0000 (UTC)
Received: from [10.36.116.38] (ovpn-116-38.ams2.redhat.com [10.36.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 63FE519C5B;
	Thu, 18 Jul 2019 10:17:00 +0000 (UTC)
From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [RFC v1 4/4] vfio/type1: bind guest pasid (guest page tables) to
	host
To: "Liu, Yi L" <yi.l.liu@intel.com>, alex.williamson@redhat.com
References: <1562324772-3084-1-git-send-email-yi.l.liu@intel.com>
	<1562324772-3084-5-git-send-email-yi.l.liu@intel.com>
Message-ID: <6add8033-8a22-5ea5-09ce-270dec42f20b@redhat.com>
Date: Thu, 18 Jul 2019 12:16:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1562324772-3084-5-git-send-email-yi.l.liu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Thu, 18 Jul 2019 10:17:12 +0000 (UTC)
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

Yi,

On 7/5/19 1:06 PM, Liu, Yi L wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
> 
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
You may add that only VFIO_IOMMU_BIND_GUEST_PASID gets implemented in
this patch
> 
> *) Code logic in vfio_iommu_type1_ioctl() to handle VFIO_IOMMU_BIND/UNBIND
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 151 ++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       |  56 +++++++++++++++
>  2 files changed, 207 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index d5e0c01..57826ed 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1920,6 +1920,119 @@ static int vfio_iommu_type1_pasid_free(struct vfio_iommu *iommu, int pasid)
>  	return ret;
>  }
>  
> +static int vfio_bind_gpasid_fn(struct device *dev, void *data)
> +{
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct vfio_iommu_type1_bind_guest_pasid *guest_bind = data;
> +
> +	return iommu_sva_bind_gpasid(domain, dev, &guest_bind->bind_data);
> +}
> +
> +static int vfio_unbind_gpasid_fn(struct device *dev, void *data)
> +{
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct vfio_iommu_type1_bind_guest_pasid *guest_bind = data;
> +
> +	return iommu_sva_unbind_gpasid(domain, dev,
> +					guest_bind->bind_data.hpasid);
> +}
> +
> +/*
> + * unbind specific gpasid, caller of this function requires hold
> + * vfio_iommu->lock
> + */
> +static long vfio_iommu_type1_do_guest_unbind(struct vfio_iommu *iommu,
> +		  struct vfio_iommu_type1_bind_guest_pasid *guest_bind)
> +{
> +	struct vfio_domain *domain;
> +	struct vfio_group *group;
> +	int ret = 0;
> +
> +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	list_for_each_entry(domain, &iommu->domain_list, next) {
> +		list_for_each_entry(group, &domain->group_list, next) {
> +			ret = iommu_group_for_each_dev(group->iommu_group,
> +			   guest_bind, vfio_unbind_gpasid_fn);
can it fail individually, in which case we end up with something half
unset or it is safe? A comment may be worth.
> +			if (ret)
> +				goto out;
> +		}
> +	}
you may use vfio_iommu_lookup_dev() introduced in
[RFC v1 2/4] vfio: VFIO_IOMMU_CACHE_INVALIDATE
> +
> +	return 0;
not needed
> +
> +out:
> +	return ret;
> +}
> +
> +static long vfio_iommu_type1_bind_gpasid(struct vfio_iommu *iommu,
> +					    void __user *arg,
> +					    struct vfio_iommu_type1_bind *bind)
> +{
> +	struct vfio_iommu_type1_bind_guest_pasid guest_bind;
> +	struct vfio_domain *domain;
> +	struct vfio_group *group;
> +	unsigned long minsz;
> +	int ret = 0;
> +
> +	minsz = sizeof(*bind) + sizeof(guest_bind);
> +	if (bind->argsz < minsz)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&guest_bind, arg, sizeof(guest_bind)))
> +		return -EFAULT;
> +
> +	mutex_lock(&iommu->lock);
> +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	list_for_each_entry(domain, &iommu->domain_list, next) {
> +		list_for_each_entry(group, &domain->group_list, next) {
> +			ret = iommu_group_for_each_dev(group->iommu_group,
> +			   &guest_bind, vfio_bind_gpasid_fn);
> +			if (ret)
> +				goto out_unbind;
use vfio_iommu_lookup_dev
> +		}

> +	}
> +
> +	mutex_unlock(&iommu->lock);
> +	return 0;
> +
> +out_unbind:
> +	/* Undo all binds that already succeeded */
> +	vfio_iommu_type1_do_guest_unbind(iommu, &guest_bind);
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
> +	struct vfio_iommu_type1_bind_guest_pasid guest_bind;
> +	unsigned long minsz;
> +	int ret = 0;
nit: init not needed
> +
> +	minsz = sizeof(*bind) + sizeof(guest_bind);
> +	if (bind->argsz < minsz)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&guest_bind, arg, sizeof(guest_bind)))
> +		return -EFAULT;
> +
> +	mutex_lock(&iommu->lock);
> +	ret = vfio_iommu_type1_do_guest_unbind(iommu, &guest_bind);
> +	mutex_unlock(&iommu->lock);
> +	return ret;
> +}
> +
>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>  				   unsigned int cmd, unsigned long arg)
>  {
> @@ -2061,6 +2174,44 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
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
> index af03c9f..4167bbd 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -823,6 +823,62 @@ struct vfio_iommu_type1_pasid_request {
>   */
>  #define VFIO_IOMMU_PASID_REQUEST	_IO(VFIO_TYPE, VFIO_BASE + 27)
>  
> +/*
> + * In guest use of SVA, the first level page tables is managed by the guest.
> + * we can either bind guest PASID table or explicitly bind a PASID with guest
> + * page table.
> + */
> +struct vfio_iommu_type1_bind_guest_pasid {
> +	struct gpasid_bind_data bind_data;
> +};
do you need this encapsulation? Why not directly using iommu.h uapi struct?
> +
> +enum vfio_iommu_bind_type {
> +	VFIO_IOMMU_BIND_PROCESS,
> +	VFIO_IOMMU_BIND_GUEST_PASID,
> +};
> +
> +/*
> + * Supported types:
> + *     - VFIO_IOMMU_BIND_PROCESS: bind native process, which takes
> + *                      vfio_iommu_type1_bind_process in data.
> + *     - VFIO_IOMMU_BIND_GUEST_PASID: bind guest pasid, which invoked
> + *                      by guest process binding, it takes
> + *                      vfio_iommu_type1_bind_guest_pasid in data.
> + */
> +struct vfio_iommu_type1_bind {
> +	__u32				argsz;
> +	enum vfio_iommu_bind_type	bind_type;
The rest of the API does not use enum directly in structs. __u8/__u32?
> +	__u8				data[];
> +};
> +
> +/*
> + * VFIO_IOMMU_BIND - _IOWR(VFIO_TYPE, VFIO_BASE + 28, struct vfio_iommu_bind)
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
> 

Thanks

Eric
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
