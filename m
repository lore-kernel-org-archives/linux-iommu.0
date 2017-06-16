From: Bharat Bhushan <bharat.bhushan@nxp.com>
Subject: RE: [virtio-dev] [RFC PATCH linux] iommu: Add virtio-iommu driver
Date: Fri, 16 Jun 2017 08:48:00 +0000
Message-ID: <AM5PR0401MB25450471C7161CC6386FC8CE9AC10@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
 <20170407192314.26720-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170407192314.26720-1-jean-philippe.brucker@arm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "cdall@linaro.org" <cdall@linaro.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>
List-Id: iommu@lists.linux-foundation.org

Hi Jean

> -----Original Message-----
> From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-
> open.org] On Behalf Of Jean-Philippe Brucker
> Sent: Saturday, April 08, 2017 12:53 AM
> To: iommu@lists.linux-foundation.org; kvm@vger.kernel.org;
> virtualization@lists.linux-foundation.org; virtio-dev@lists.oasis-open.or=
g
> Cc: cdall@linaro.org; will.deacon@arm.com; robin.murphy@arm.com;
> lorenzo.pieralisi@arm.com; joro@8bytes.org; mst@redhat.com;
> jasowang@redhat.com; alex.williamson@redhat.com;
> marc.zyngier@arm.com
> Subject: [virtio-dev] [RFC PATCH linux] iommu: Add virtio-iommu driver
>=20
> The virtio IOMMU is a para-virtualized device, allowing to send IOMMU
> requests such as map/unmap over virtio-mmio transport. This driver should
> illustrate the initial proposal for virtio-iommu, that you hopefully rece=
ived
> with it. It handle attach, detach, map and unmap requests.
>=20
> The bulk of the code is to create requests and send them through virtio.
> Implementing the IOMMU API is fairly straightforward since the virtio-iom=
mu
> MAP/UNMAP interface is almost identical. I threw in a custom
> map_sg() function which takes up some space, but is optional. The core
> function would send a sequence of map requests, waiting for a reply
> between each mapping. This optimization avoids yielding to the host after
> each map, and instead prepares a batch of requests in the virtio ring and
> kicks the host once.
>=20
> It must be applied on top of the probe deferral work for IOMMU, currently
> under discussion. This allows to dissociate early driver detection and de=
vice
> probing: device-tree or ACPI is parsed early to find which devices are
> translated by the IOMMU, but the IOMMU itself cannot be probed until the
> core virtio module is loaded.
>=20
> Enabling DEBUG makes it extremely verbose at the moment, but it should be
> calmer in next versions.
>=20
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/iommu/Kconfig             |  11 +
>  drivers/iommu/Makefile            |   1 +
>  drivers/iommu/virtio-iommu.c      | 980
> ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/Kbuild         |   1 +
>  include/uapi/linux/virtio_ids.h   |   1 +
>  include/uapi/linux/virtio_iommu.h | 142 ++++++
>  6 files changed, 1136 insertions(+)
>  create mode 100644 drivers/iommu/virtio-iommu.c  create mode 100644
> include/uapi/linux/virtio_iommu.h
>=20
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig index
> 37e204f3d9be..8cd56ee9a93a 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -359,4 +359,15 @@ config MTK_IOMMU_V1
>=20
>  	  if unsure, say N here.
>=20
> +config VIRTIO_IOMMU
> +	tristate "Virtio IOMMU driver"
> +	depends on VIRTIO_MMIO
> +	select IOMMU_API
> +	select INTERVAL_TREE
> +	select ARM_DMA_USE_IOMMU if ARM
> +	help
> +	  Para-virtualised IOMMU driver with virtio.
> +
> +	  Say Y here if you intend to run this kernel as a guest.
> +
>  endif # IOMMU_SUPPORT
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile index
> 195f7b997d8e..1199d8475802 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -27,3 +27,4 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) +=3D tegra-
> smmu.o
>  obj-$(CONFIG_EXYNOS_IOMMU) +=3D exynos-iommu.o
>  obj-$(CONFIG_FSL_PAMU) +=3D fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) +=3D s390-iommu.o
> +obj-$(CONFIG_VIRTIO_IOMMU) +=3D virtio-iommu.o
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> new file mode 100644 index 000000000000..1cf4f57b7817
> --- /dev/null
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -0,0 +1,980 @@
> +/*
> + * Virtio driver for the paravirtualized IOMMU
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,
> USA.
> + *
> + * Copyright (C) 2017 ARM Limited
> + *
> + * Author: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>  */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/amba/bus.h>
> +#include <linux/delay.h>
> +#include <linux/dma-iommu.h>
> +#include <linux/freezer.h>
> +#include <linux/interval_tree.h>
> +#include <linux/iommu.h>
> +#include <linux/module.h>
> +#include <linux/of_iommu.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/wait.h>
> +
> +#include <uapi/linux/virtio_iommu.h>
> +
> +struct viommu_dev {
> +	struct iommu_device		iommu;
> +	struct device			*dev;
> +	struct virtio_device		*vdev;
> +
> +	struct virtqueue		*vq;
> +	struct list_head		pending_requests;
> +	/* Serialize anything touching the vq and the request list */
> +	spinlock_t			vq_lock;
> +
> +	struct list_head		list;
> +
> +	/* Device configuration */
> +	u64				pgsize_bitmap;
> +	u64				aperture_start;
> +	u64				aperture_end;
> +};
> +
> +struct viommu_mapping {
> +	phys_addr_t			paddr;
> +	struct interval_tree_node	iova;
> +};
> +
> +struct viommu_domain {
> +	struct iommu_domain		domain;
> +	struct viommu_dev		*viommu;
> +	struct mutex			mutex;
> +	u64				id;
> +
> +	spinlock_t			mappings_lock;
> +	struct rb_root			mappings;
> +
> +	/* Number of devices attached to this domain */
> +	unsigned long			attached;
> +};
> +
> +struct viommu_endpoint {
> +	struct viommu_dev		*viommu;
> +	struct viommu_domain		*vdomain;
> +};
> +
> +struct viommu_request {
> +	struct scatterlist		head;
> +	struct scatterlist		tail;
> +
> +	int				written;
> +	struct list_head		list;
> +};
> +
> +/* TODO: use an IDA */
> +static atomic64_t viommu_domain_ids_gen;
> +
> +#define to_viommu_domain(domain) container_of(domain, struct
> +viommu_domain, domain)
> +
> +/* Virtio transport */
> +
> +static int viommu_status_to_errno(u8 status) {
> +	switch (status) {
> +	case VIRTIO_IOMMU_S_OK:
> +		return 0;
> +	case VIRTIO_IOMMU_S_UNSUPP:
> +		return -ENOSYS;
> +	case VIRTIO_IOMMU_S_INVAL:
> +		return -EINVAL;
> +	case VIRTIO_IOMMU_S_RANGE:
> +		return -ERANGE;
> +	case VIRTIO_IOMMU_S_NOENT:
> +		return -ENOENT;
> +	case VIRTIO_IOMMU_S_FAULT:
> +		return -EFAULT;
> +	case VIRTIO_IOMMU_S_IOERR:
> +	case VIRTIO_IOMMU_S_DEVERR:
> +	default:
> +		return -EIO;
> +	}
> +}
> +
> +static int viommu_get_req_size(struct virtio_iommu_req_head *req, size_t
> *head,
> +			       size_t *tail)
> +{
> +	size_t size;
> +	union virtio_iommu_req r;
> +
> +	*tail =3D sizeof(struct virtio_iommu_req_tail);
> +
> +	switch (req->type) {
> +	case VIRTIO_IOMMU_T_ATTACH:
> +		size =3D sizeof(r.attach);
> +		break;
> +	case VIRTIO_IOMMU_T_DETACH:
> +		size =3D sizeof(r.detach);
> +		break;
> +	case VIRTIO_IOMMU_T_MAP:
> +		size =3D sizeof(r.map);
> +		break;
> +	case VIRTIO_IOMMU_T_UNMAP:
> +		size =3D sizeof(r.unmap);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	*head =3D size - *tail;
> +	return 0;
> +}
> +
> +static int viommu_receive_resp(struct viommu_dev *viommu, int
> +nr_expected) {
> +
> +	unsigned int len;
> +	int nr_received =3D 0;
> +	struct viommu_request *req, *pending, *next;
> +
> +	pending =3D list_first_entry_or_null(&viommu->pending_requests,
> +					   struct viommu_request, list);
> +	if (WARN_ON(!pending))
> +		return 0;
> +
> +	while ((req =3D virtqueue_get_buf(viommu->vq, &len)) !=3D NULL) {
> +		if (req !=3D pending) {
> +			dev_warn(viommu->dev, "discarding stale
> request\n");
> +			continue;
> +		}
> +
> +		pending->written =3D len;
> +
> +		if (++nr_received =3D=3D nr_expected) {
> +			list_del(&pending->list);
> +			/*
> +			 * In an ideal world, we'd wake up the waiter for this
> +			 * group of requests here. But everything is painfully
> +			 * synchronous, so waiter is the caller.
> +			 */
> +			break;
> +		}
> +
> +		next =3D list_next_entry(pending, list);
> +		list_del(&pending->list);
> +
> +		if (WARN_ON(list_empty(&viommu->pending_requests)))
> +			return 0;
> +
> +		pending =3D next;
> +	}
> +
> +	return nr_received;
> +}
> +
> +/* Must be called with vq_lock held */
> +static int _viommu_send_reqs_sync(struct viommu_dev *viommu,
> +				  struct viommu_request *req, int nr,
> +				  int *nr_sent)
> +{
> +	int i, ret;
> +	ktime_t timeout;
> +	int nr_received =3D 0;
> +	struct scatterlist *sg[2];
> +	/*
> +	 * FIXME: as it stands, 1s timeout per request. This is a voluntary
> +	 * exaggeration because I have no idea how real our ktime is. Are we
> +	 * using a RTC? Are we aware of steal time? I don't know much about
> +	 * this, need to do some digging.
> +	 */
> +	unsigned long timeout_ms =3D 1000;
> +
> +	*nr_sent =3D 0;
> +
> +	for (i =3D 0; i < nr; i++, req++) {
> +		/*
> +		 * The backend will allocate one indirect descriptor for each
> +		 * request, which allows to double the ring consumption, but
> +		 * might be slower.
> +		 */
> +		req->written =3D 0;
> +
> +		sg[0] =3D &req->head;
> +		sg[1] =3D &req->tail;
> +
> +		ret =3D virtqueue_add_sgs(viommu->vq, sg, 1, 1, req,
> +					GFP_ATOMIC);
> +		if (ret)
> +			break;
> +
> +		list_add_tail(&req->list, &viommu->pending_requests);
> +	}
> +
> +	if (i && !virtqueue_kick(viommu->vq))
> +		return -EPIPE;
> +
> +	/*
> +	 * Absolutely no wiggle room here. We're not allowed to sleep as
> callers
> +	 * might be holding spinlocks, so we have to poll like savages until
> +	 * something appears. Hopefully the host already handled the
> request
> +	 * during the above kick and returned it to us.
> +	 *
> +	 * A nice improvement would be for the caller to tell us if we can
> sleep
> +	 * whilst mapping, but this has to go through the IOMMU/DMA API.
> +	 */
> +	timeout =3D ktime_add_ms(ktime_get(), timeout_ms * i);
> +	while (nr_received < i && ktime_before(ktime_get(), timeout)) {
> +		nr_received +=3D viommu_receive_resp(viommu, i -
> nr_received);
> +		if (nr_received < i) {
> +			/*
> +			 * FIXME: what's a good way to yield to host? A
> second
> +			 * virtqueue_kick won't have any effect since we
> haven't
> +			 * added any descriptor.
> +			 */
> +			udelay(10);
> +		}
> +	}
> +	dev_dbg(viommu->dev, "request took %lld us\n",
> +		ktime_us_delta(ktime_get(), ktime_sub_ms(timeout,
> timeout_ms * i)));
> +
> +	if (nr_received !=3D i)
> +		ret =3D -ETIMEDOUT;
> +
> +	if (ret =3D=3D -ENOSPC && nr_received)
> +		/*
> +		 * We've freed some space since virtio told us that the ring is
> +		 * full, tell the caller to come back later (after releasing the
> +		 * lock first, to be fair to other threads)
> +		 */
> +		ret =3D -EAGAIN;
> +
> +	*nr_sent =3D nr_received;
> +
> +	return ret;
> +}
> +
> +/**
> + * viommu_send_reqs_sync - add a batch of requests, kick the host and
> wait for
> + *                         them to return
> + *
> + * @req: array of requests
> + * @nr: size of the array
> + * @nr_sent: contains the number of requests actually sent after this
> function
> + *           returns
> + *
> + * Return 0 on success, or an error if we failed to send some of the
> requests.
> + */
> +static int viommu_send_reqs_sync(struct viommu_dev *viommu,
> +				 struct viommu_request *req, int nr,
> +				 int *nr_sent)
> +{
> +	int ret;
> +	int sent =3D 0;
> +	unsigned long flags;
> +
> +	*nr_sent =3D 0;
> +	do {
> +		spin_lock_irqsave(&viommu->vq_lock, flags);
> +		ret =3D _viommu_send_reqs_sync(viommu, req, nr, &sent);
> +		spin_unlock_irqrestore(&viommu->vq_lock, flags);
> +
> +		*nr_sent +=3D sent;
> +		req +=3D sent;
> +		nr -=3D sent;
> +	} while (ret =3D=3D -EAGAIN);
> +
> +	return ret;
> +}
> +
> +/**
> + * viommu_send_req_sync - send one request and wait for reply
> + *
> + * @head_ptr: pointer to a virtio_iommu_req_* structure
> + *
> + * Returns 0 if the request was successful, or an error number
> +otherwise. No
> + * distinction is done between transport and request errors.
> + */
> +static int viommu_send_req_sync(struct viommu_dev *viommu, void
> +*head_ptr) {
> +	int ret;
> +	int nr_sent;
> +	struct viommu_request req;
> +	size_t head_size, tail_size;
> +	struct virtio_iommu_req_tail *tail;
> +	struct virtio_iommu_req_head *head =3D head_ptr;
> +
> +	ret =3D viommu_get_req_size(head, &head_size, &tail_size);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(viommu->dev, "Sending request 0x%x, %zu bytes\n",
> head->type,
> +		head_size + tail_size);
> +
> +	tail =3D head_ptr + head_size;
> +
> +	sg_init_one(&req.head, head, head_size);
> +	sg_init_one(&req.tail, tail, tail_size);
> +
> +	ret =3D viommu_send_reqs_sync(viommu, &req, 1, &nr_sent);
> +	if (ret || !req.written || nr_sent !=3D 1) {
> +		dev_err(viommu->dev, "failed to send command\n");
> +		return -EIO;
> +	}
> +
> +	ret =3D -viommu_status_to_errno(tail->status);
> +
> +	if (ret)
> +		dev_dbg(viommu->dev, " completed with %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int viommu_tlb_map(struct viommu_domain *vdomain, unsigned
> long iova,
> +			  phys_addr_t paddr, size_t size)
> +{
> +	unsigned long flags;
> +	struct viommu_mapping *mapping;
> +
> +	mapping =3D kzalloc(sizeof(*mapping), GFP_ATOMIC);
> +	if (!mapping)
> +		return -ENOMEM;
> +
> +	mapping->paddr =3D paddr;
> +	mapping->iova.start =3D iova;
> +	mapping->iova.last =3D iova + size - 1;
> +
> +	spin_lock_irqsave(&vdomain->mappings_lock, flags);
> +	interval_tree_insert(&mapping->iova, &vdomain->mappings);
> +	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
> +
> +	return 0;
> +}
> +
> +static size_t viommu_tlb_unmap(struct viommu_domain *vdomain,
> +			       unsigned long iova, size_t size) {
> +	size_t unmapped =3D 0;
> +	unsigned long flags;
> +	unsigned long last =3D iova + size - 1;
> +	struct viommu_mapping *mapping =3D NULL;
> +	struct interval_tree_node *node, *next;
> +
> +	spin_lock_irqsave(&vdomain->mappings_lock, flags);
> +	next =3D interval_tree_iter_first(&vdomain->mappings, iova, last);
> +	while (next) {
> +		node =3D next;
> +		mapping =3D container_of(node, struct viommu_mapping,
> iova);
> +
> +		next =3D interval_tree_iter_next(node, iova, last);
> +
> +		/*
> +		 * Note that for a partial range, this will return the full
> +		 * mapping so we avoid sending split requests to the device.
> +		 */
> +		unmapped +=3D mapping->iova.last - mapping->iova.start + 1;
> +
> +		interval_tree_remove(node, &vdomain->mappings);
> +		kfree(mapping);
> +	}
> +	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
> +
> +	return unmapped;
> +}
> +
> +/* IOMMU API */
> +
> +static bool viommu_capable(enum iommu_cap cap) {
> +	return false; /* :( */
> +}
> +
> +static struct iommu_domain *viommu_domain_alloc(unsigned type) {
> +	struct viommu_domain *vdomain;
> +
> +	if (type !=3D IOMMU_DOMAIN_UNMANAGED && type !=3D
> IOMMU_DOMAIN_DMA)
> +		return NULL;
> +
> +	vdomain =3D kzalloc(sizeof(struct viommu_domain), GFP_KERNEL);
> +	if (!vdomain)
> +		return NULL;
> +
> +	vdomain->id =3D
> atomic64_inc_return_relaxed(&viommu_domain_ids_gen);
> +
> +	mutex_init(&vdomain->mutex);
> +	spin_lock_init(&vdomain->mappings_lock);
> +	vdomain->mappings =3D RB_ROOT;
> +
> +	pr_debug("alloc domain of type %d -> %llu\n", type, vdomain->id);
> +
> +	if (type =3D=3D IOMMU_DOMAIN_DMA &&
> +	    iommu_get_dma_cookie(&vdomain->domain)) {
> +		kfree(vdomain);
> +		return NULL;
> +	}
> +
> +	return &vdomain->domain;
> +}
> +
> +static void viommu_domain_free(struct iommu_domain *domain) {
> +	struct viommu_domain *vdomain =3D to_viommu_domain(domain);
> +
> +	pr_debug("free domain %llu\n", vdomain->id);
> +
> +	iommu_put_dma_cookie(domain);
> +
> +	/* Free all remaining mappings (size 2^64) */
> +	viommu_tlb_unmap(vdomain, 0, 0);
> +
> +	kfree(vdomain);
> +}
> +
> +static int viommu_attach_dev(struct iommu_domain *domain, struct
> device
> +*dev) {
> +	int i;
> +	int ret =3D 0;
> +	struct iommu_fwspec *fwspec =3D dev->iommu_fwspec;
> +	struct viommu_endpoint *vdev =3D fwspec->iommu_priv;
> +	struct viommu_domain *vdomain =3D to_viommu_domain(domain);
> +	struct virtio_iommu_req_attach req =3D {
> +		.head.type	=3D VIRTIO_IOMMU_T_ATTACH,
> +		.address_space	=3D cpu_to_le32(vdomain->id),
> +	};
> +
> +	mutex_lock(&vdomain->mutex);
> +	if (!vdomain->viommu) {
> +		struct viommu_dev *viommu =3D vdev->viommu;
> +
> +		vdomain->viommu =3D viommu;
> +
> +		domain->pgsize_bitmap		=3D viommu-
> >pgsize_bitmap;
> +		domain->geometry.aperture_start	=3D viommu-
> >aperture_start;
> +		domain->geometry.aperture_end	=3D viommu-
> >aperture_end;
> +		domain->geometry.force_aperture	=3D true;
> +
> +	} else if (vdomain->viommu !=3D vdev->viommu) {
> +		dev_err(dev, "cannot attach to foreign VIOMMU\n");
> +		ret =3D -EXDEV;
> +	}
> +	mutex_unlock(&vdomain->mutex);
> +
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * When attaching the device to a new domain, it will be detached
> from
> +	 * the old one and, if as as a result the old domain isn't attached to
> +	 * any device, all mappings are removed from the old domain and it is
> +	 * freed. (Note that we can't use get_domain_for_dev here, it
> returns
> +	 * the default domain during initial attach.)
> +	 *
> +	 * Take note of the device disappearing, so we can ignore unmap
> request
> +	 * on stale domains (that is, between this detach and the upcoming
> +	 * free.)
> +	 *
> +	 * vdev->vdomain is protected by group->mutex
> +	 */
> +	if (vdev->vdomain) {
> +		dev_dbg(dev, "detach from domain %llu\n", vdev-
> >vdomain->id);
> +		vdev->vdomain->attached--;
> +	}
> +
> +	dev_dbg(dev, "attach to domain %llu\n", vdomain->id);
> +
> +	for (i =3D 0; i < fwspec->num_ids; i++) {
> +		req.device =3D cpu_to_le32(fwspec->ids[i]);
> +
> +		ret =3D viommu_send_req_sync(vdomain->viommu, &req);
> +		if (ret)
> +			break;
> +	}
> +
> +	vdomain->attached++;
> +	vdev->vdomain =3D vdomain;
> +
> +	return ret;
> +}
> +
> +static int viommu_map(struct iommu_domain *domain, unsigned long iova,
> +		      phys_addr_t paddr, size_t size, int prot) {
> +	int ret;
> +	struct viommu_domain *vdomain =3D to_viommu_domain(domain);
> +	struct virtio_iommu_req_map req =3D {
> +		.head.type	=3D VIRTIO_IOMMU_T_MAP,
> +		.address_space	=3D cpu_to_le32(vdomain->id),
> +		.virt_addr	=3D cpu_to_le64(iova),
> +		.phys_addr	=3D cpu_to_le64(paddr),
> +		.size		=3D cpu_to_le64(size),
> +	};
> +
> +	pr_debug("map %llu 0x%lx -> 0x%llx (%zu)\n", vdomain->id, iova,
> +		 paddr, size);

A query, when I am tracing above prints I see same physical address is mapp=
ed with two different virtual address, do you know why kernel does this?

Thanks
-Bharat

> +
> +	if (!vdomain->attached)
> +		return -ENODEV;
> +
> +	if (prot & IOMMU_READ)
> +		req.flags |=3D cpu_to_le32(VIRTIO_IOMMU_MAP_F_READ);
> +
> +	if (prot & IOMMU_WRITE)
> +		req.flags |=3D cpu_to_le32(VIRTIO_IOMMU_MAP_F_WRITE);
> +
> +	ret =3D viommu_tlb_map(vdomain, iova, paddr, size);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D viommu_send_req_sync(vdomain->viommu, &req);
> +	if (ret)
> +		viommu_tlb_unmap(vdomain, iova, size);
> +
> +	return ret;
> +}
> +
> +static size_t viommu_unmap(struct iommu_domain *domain, unsigned
> long iova,
> +			   size_t size)
> +{
> +	int ret;
> +	size_t unmapped;
> +	struct viommu_domain *vdomain =3D to_viommu_domain(domain);
> +	struct virtio_iommu_req_unmap req =3D {
> +		.head.type	=3D VIRTIO_IOMMU_T_UNMAP,
> +		.address_space	=3D cpu_to_le32(vdomain->id),
> +		.virt_addr	=3D cpu_to_le64(iova),
> +	};
> +
> +	pr_debug("unmap %llu 0x%lx (%zu)\n", vdomain->id, iova, size);
> +
> +	/* Callers may unmap after detach, but device already took care of it.
> */
> +	if (!vdomain->attached)
> +		return size;
> +
> +	unmapped =3D viommu_tlb_unmap(vdomain, iova, size);
> +	if (unmapped < size)
> +		return 0;
> +
> +	req.size =3D cpu_to_le64(unmapped);
> +
> +	ret =3D viommu_send_req_sync(vdomain->viommu, &req);
> +	if (ret)
> +		return 0;
> +
> +	return unmapped;
> +}
> +
> +static size_t viommu_map_sg(struct iommu_domain *domain, unsigned
> long iova,
> +			    struct scatterlist *sg, unsigned int nents, int prot) {
> +	int i, ret;
> +	int nr_sent;
> +	size_t mapped;
> +	size_t min_pagesz;
> +	size_t total_size;
> +	struct scatterlist *s;
> +	unsigned int flags =3D 0;
> +	unsigned long cur_iova;
> +	unsigned long mapped_iova;
> +	size_t head_size, tail_size;
> +	struct viommu_request reqs[nents];
> +	struct virtio_iommu_req_map map_reqs[nents];
> +	struct viommu_domain *vdomain =3D to_viommu_domain(domain);
> +
> +	if (!vdomain->attached)
> +		return 0;
> +
> +	pr_debug("map_sg %llu %u 0x%lx\n", vdomain->id, nents, iova);
> +
> +	if (prot & IOMMU_READ)
> +		flags |=3D VIRTIO_IOMMU_MAP_F_READ;
> +
> +	if (prot & IOMMU_WRITE)
> +		flags |=3D VIRTIO_IOMMU_MAP_F_WRITE;
> +
> +	min_pagesz =3D 1 << __ffs(domain->pgsize_bitmap);
> +	tail_size =3D sizeof(struct virtio_iommu_req_tail);
> +	head_size =3D sizeof(*map_reqs) - tail_size;
> +
> +	cur_iova =3D iova;
> +
> +	for_each_sg(sg, s, nents, i) {
> +		size_t size =3D s->length;
> +		phys_addr_t paddr =3D sg_phys(s);
> +		void *tail =3D (void *)&map_reqs[i] + head_size;
> +
> +		if (!IS_ALIGNED(paddr | size, min_pagesz)) {
> +			ret =3D -EFAULT;
> +			break;
> +		}
> +
> +		/* TODO: merge physically-contiguous mappings if any */
> +		map_reqs[i] =3D (struct virtio_iommu_req_map) {
> +			.head.type	=3D VIRTIO_IOMMU_T_MAP,
> +			.address_space	=3D cpu_to_le32(vdomain->id),
> +			.flags		=3D cpu_to_le32(flags),
> +			.virt_addr	=3D cpu_to_le64(cur_iova),
> +			.phys_addr	=3D cpu_to_le64(paddr),
> +			.size		=3D cpu_to_le64(size),
> +		};
> +
> +		ret =3D viommu_tlb_map(vdomain, cur_iova, paddr, size);
> +		if (ret)
> +			break;
> +
> +		sg_init_one(&reqs[i].head, &map_reqs[i], head_size);
> +		sg_init_one(&reqs[i].tail, tail, tail_size);
> +
> +		cur_iova +=3D size;
> +	}
> +
> +	total_size =3D cur_iova - iova;
> +
> +	if (ret) {
> +		viommu_tlb_unmap(vdomain, iova, total_size);
> +		return 0;
> +	}
> +
> +	ret =3D viommu_send_reqs_sync(vdomain->viommu, reqs, i,
> &nr_sent);
> +
> +	if (nr_sent !=3D nents)
> +		goto err_rollback;
> +
> +	for (i =3D 0; i < nents; i++) {
> +		if (!reqs[i].written || map_reqs[i].tail.status)
> +			goto err_rollback;
> +	}
> +
> +	return total_size;
> +
> +err_rollback:
> +	/*
> +	 * Any request in the range might have failed. Unmap what was
> +	 * successful.
> +	 */
> +	cur_iova =3D iova;
> +	mapped_iova =3D iova;
> +	mapped =3D 0;
> +	for_each_sg(sg, s, nents, i) {
> +		size_t size =3D s->length;
> +
> +		cur_iova +=3D size;
> +
> +		if (!reqs[i].written || map_reqs[i].tail.status) {
> +			if (mapped)
> +				viommu_unmap(domain, mapped_iova,
> mapped);
> +
> +			mapped_iova =3D cur_iova;
> +			mapped =3D 0;
> +		} else {
> +			mapped +=3D size;
> +		}
> +	}
> +
> +	viommu_tlb_unmap(vdomain, iova, total_size);
> +
> +	return 0;
> +}
> +
> +static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
> +				       dma_addr_t iova)
> +{
> +	u64 paddr =3D 0;
> +	unsigned long flags;
> +	struct viommu_mapping *mapping;
> +	struct interval_tree_node *node;
> +	struct viommu_domain *vdomain =3D to_viommu_domain(domain);
> +
> +	spin_lock_irqsave(&vdomain->mappings_lock, flags);
> +	node =3D interval_tree_iter_first(&vdomain->mappings, iova, iova);
> +	if (node) {
> +		mapping =3D container_of(node, struct viommu_mapping,
> iova);
> +		paddr =3D mapping->paddr + (iova - mapping->iova.start);
> +	}
> +	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
> +
> +	pr_debug("iova_to_phys %llu 0x%llx->0x%llx\n", vdomain->id, iova,
> +		 paddr);
> +
> +	return paddr;
> +}
> +
> +static struct iommu_ops viommu_ops;
> +static struct virtio_driver virtio_iommu_drv;
> +
> +static int viommu_match_node(struct device *dev, void *data) {
> +	return dev->parent->fwnode =3D=3D data;
> +}
> +
> +static struct viommu_dev *viommu_get_by_fwnode(struct
> fwnode_handle
> +*fwnode) {
> +	struct device *dev =3D driver_find_device(&virtio_iommu_drv.driver,
> NULL,
> +						fwnode,
> viommu_match_node);
> +	put_device(dev);
> +
> +	return dev ? dev_to_virtio(dev)->priv : NULL; }
> +
> +static int viommu_add_device(struct device *dev) {
> +	struct iommu_group *group;
> +	struct viommu_endpoint *vdev;
> +	struct viommu_dev *viommu =3D NULL;
> +	struct iommu_fwspec *fwspec =3D dev->iommu_fwspec;
> +
> +	if (!fwspec || fwspec->ops !=3D &viommu_ops)
> +		return -ENODEV;
> +
> +	viommu =3D viommu_get_by_fwnode(fwspec->iommu_fwnode);
> +	if (!viommu)
> +		return -ENODEV;
> +
> +	vdev =3D kzalloc(sizeof(*vdev), GFP_KERNEL);
> +	if (!vdev)
> +		return -ENOMEM;
> +
> +	vdev->viommu =3D viommu;
> +	fwspec->iommu_priv =3D vdev;
> +
> +	/*
> +	 * Last step creates a default domain and attaches to it. Everything
> +	 * must be ready.
> +	 */
> +	group =3D iommu_group_get_for_dev(dev);
> +
> +	return PTR_ERR_OR_ZERO(group);
> +}
> +
> +static void viommu_remove_device(struct device *dev) {
> +	kfree(dev->iommu_fwspec->iommu_priv);
> +}
> +
> +static struct iommu_group *
> +viommu_device_group(struct device *dev) {
> +	if (dev_is_pci(dev))
> +		return pci_device_group(dev);
> +	else
> +		return generic_device_group(dev);
> +}
> +
> +static int viommu_of_xlate(struct device *dev, struct of_phandle_args
> +*args) {
> +	u32 *id =3D args->args;
> +
> +	dev_dbg(dev, "of_xlate 0x%x\n", *id);
> +	return iommu_fwspec_add_ids(dev, args->args, 1); }
> +
> +/*
> + * (Maybe) temporary hack for device pass-through into guest userspace.
> +On ARM
> + * with an ITS, VFIO will look for a region where to map the doorbell,
> +even
> + * though the virtual doorbell is never written to by the device, and
> +instead
> + * the host injects interrupts directly. TODO: sort this out in VFIO.
> + */
> +#define MSI_IOVA_BASE			0x8000000
> +#define MSI_IOVA_LENGTH			0x100000
> +
> +static void viommu_get_resv_regions(struct device *dev, struct
> +list_head *head) {
> +	struct iommu_resv_region *region;
> +	int prot =3D IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> +
> +	region =3D iommu_alloc_resv_region(MSI_IOVA_BASE,
> MSI_IOVA_LENGTH, prot,
> +					 IOMMU_RESV_MSI);
> +	if (!region)
> +		return;
> +
> +	list_add_tail(&region->list, head);
> +}
> +
> +static void viommu_put_resv_regions(struct device *dev, struct
> +list_head *head) {
> +	struct iommu_resv_region *entry, *next;
> +
> +	list_for_each_entry_safe(entry, next, head, list)
> +		kfree(entry);
> +}
> +
> +static struct iommu_ops viommu_ops =3D {
> +	.capable		=3D viommu_capable,
> +	.domain_alloc		=3D viommu_domain_alloc,
> +	.domain_free		=3D viommu_domain_free,
> +	.attach_dev		=3D viommu_attach_dev,
> +	.map			=3D viommu_map,
> +	.unmap			=3D viommu_unmap,
> +	.map_sg			=3D viommu_map_sg,
> +	.iova_to_phys		=3D viommu_iova_to_phys,
> +	.add_device		=3D viommu_add_device,
> +	.remove_device		=3D viommu_remove_device,
> +	.device_group		=3D viommu_device_group,
> +	.of_xlate		=3D viommu_of_xlate,
> +	.get_resv_regions	=3D viommu_get_resv_regions,
> +	.put_resv_regions	=3D viommu_put_resv_regions,
> +};
> +
> +static int viommu_init_vq(struct viommu_dev *viommu) {
> +	struct virtio_device *vdev =3D dev_to_virtio(viommu->dev);
> +	vq_callback_t *callback =3D NULL;
> +	const char *name =3D "request";
> +	int ret;
> +
> +	ret =3D vdev->config->find_vqs(vdev, 1, &viommu->vq, &callback,
> +				     &name, NULL);
> +	if (ret)
> +		dev_err(viommu->dev, "cannot find VQ\n");
> +
> +	return ret;
> +}
> +
> +static int viommu_probe(struct virtio_device *vdev) {
> +	struct device *parent_dev =3D vdev->dev.parent;
> +	struct viommu_dev *viommu =3D NULL;
> +	struct device *dev =3D &vdev->dev;
> +	int ret;
> +
> +	viommu =3D kzalloc(sizeof(*viommu), GFP_KERNEL);
> +	if (!viommu)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&viommu->vq_lock);
> +	INIT_LIST_HEAD(&viommu->pending_requests);
> +	viommu->dev =3D dev;
> +	viommu->vdev =3D vdev;
> +
> +	ret =3D viommu_init_vq(viommu);
> +	if (ret)
> +		goto err_free_viommu;
> +
> +	virtio_cread(vdev, struct virtio_iommu_config, page_sizes,
> +		     &viommu->pgsize_bitmap);
> +
> +	viommu->aperture_end =3D -1UL;
> +
> +	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
> +			     struct virtio_iommu_config, input_range.start,
> +			     &viommu->aperture_start);
> +
> +	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
> +			     struct virtio_iommu_config, input_range.end,
> +			     &viommu->aperture_end);
> +
> +	if (!viommu->pgsize_bitmap) {
> +		ret =3D -EINVAL;
> +		goto err_free_viommu;
> +	}
> +
> +	viommu_ops.pgsize_bitmap =3D viommu->pgsize_bitmap;
> +
> +	/*
> +	 * Not strictly necessary, virtio would enable it later. This allows to
> +	 * start using the request queue early.
> +	 */
> +	virtio_device_ready(vdev);
> +
> +	ret =3D iommu_device_sysfs_add(&viommu->iommu, dev, NULL, "%s",
> +				     virtio_bus_name(vdev));
> +	if (ret)
> +		goto err_free_viommu;
> +
> +	iommu_device_set_ops(&viommu->iommu, &viommu_ops);
> +	iommu_device_set_fwnode(&viommu->iommu, parent_dev-
> >fwnode);
> +
> +	iommu_device_register(&viommu->iommu);
> +
> +#ifdef CONFIG_PCI
> +	if (pci_bus_type.iommu_ops !=3D &viommu_ops) {
> +		pci_request_acs();
> +		ret =3D bus_set_iommu(&pci_bus_type, &viommu_ops);
> +		if (ret)
> +			goto err_unregister;
> +	}
> +#endif
> +#ifdef CONFIG_ARM_AMBA
> +	if (amba_bustype.iommu_ops !=3D &viommu_ops) {
> +		ret =3D bus_set_iommu(&amba_bustype, &viommu_ops);
> +		if (ret)
> +			goto err_unregister;
> +	}
> +#endif
> +	if (platform_bus_type.iommu_ops !=3D &viommu_ops) {
> +		ret =3D bus_set_iommu(&platform_bus_type, &viommu_ops);
> +		if (ret)
> +			goto err_unregister;
> +	}
> +
> +	vdev->priv =3D viommu;
> +
> +	dev_info(viommu->dev, "probe successful\n");
> +
> +	return 0;
> +
> +err_unregister:
> +	iommu_device_unregister(&viommu->iommu);
> +
> +err_free_viommu:
> +	kfree(viommu);
> +
> +	return ret;
> +}
> +
> +static void viommu_remove(struct virtio_device *vdev) {
> +	struct viommu_dev *viommu =3D vdev->priv;
> +
> +	iommu_device_unregister(&viommu->iommu);
> +	kfree(viommu);
> +
> +	dev_info(&vdev->dev, "device removed\n"); }
> +
> +static void viommu_config_changed(struct virtio_device *vdev) {
> +	dev_warn(&vdev->dev, "config changed\n"); }
> +
> +static unsigned int features[] =3D {
> +	VIRTIO_IOMMU_F_INPUT_RANGE,
> +};
> +
> +static struct virtio_device_id id_table[] =3D {
> +	{ VIRTIO_ID_IOMMU, VIRTIO_DEV_ANY_ID },
> +	{ 0 },
> +};
> +
> +static struct virtio_driver virtio_iommu_drv =3D {
> +	.driver.name		=3D KBUILD_MODNAME,
> +	.driver.owner		=3D THIS_MODULE,
> +	.id_table		=3D id_table,
> +	.feature_table		=3D features,
> +	.feature_table_size	=3D ARRAY_SIZE(features),
> +	.probe			=3D viommu_probe,
> +	.remove			=3D viommu_remove,
> +	.config_changed		=3D viommu_config_changed,
> +};
> +
> +module_virtio_driver(virtio_iommu_drv);
> +
> +IOMMU_OF_DECLARE(viommu, "virtio,mmio", NULL);
> +
> +MODULE_DESCRIPTION("virtio-iommu driver"); MODULE_AUTHOR("Jean-
> Philippe
> +Brucker <jean-philippe.brucker@arm.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild index
> 1f25c86374ad..c0cb0f173258 100644
> --- a/include/uapi/linux/Kbuild
> +++ b/include/uapi/linux/Kbuild
> @@ -467,6 +467,7 @@ header-y +=3D virtio_console.h  header-y +=3D
> virtio_gpu.h  header-y +=3D virtio_ids.h  header-y +=3D virtio_input.h
> +header-y +=3D virtio_iommu.h
>  header-y +=3D virtio_mmio.h
>  header-y +=3D virtio_net.h
>  header-y +=3D virtio_pci.h
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_=
ids.h
> index 6d5c3b2d4f4d..934ed3d3cd3f 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -43,5 +43,6 @@
>  #define VIRTIO_ID_INPUT        18 /* virtio input */
>  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
>  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> +#define VIRTIO_ID_IOMMU	    61216 /* virtio IOMMU (temporary) */
>=20
>  #endif /* _LINUX_VIRTIO_IDS_H */
> diff --git a/include/uapi/linux/virtio_iommu.h
> b/include/uapi/linux/virtio_iommu.h
> new file mode 100644
> index 000000000000..ec74c9a727d4
> --- /dev/null
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -0,0 +1,142 @@
> +/*
> + * Copyright (C) 2017 ARM Ltd.
> + *
> + * This header is BSD licensed so anyone can use the definitions
> + * to implement compatible drivers/servers:
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in th=
e
> + *    documentation and/or other materials provided with the distributio=
n.
> + * 3. Neither the name of ARM Ltd. nor the names of its contributors
> + *    may be used to endorse or promote products derived from this
> software
> + *    without specific prior written permission.
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
> CONTRIBUTORS
> + * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
> NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
> FITNESS
> + * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL IBM
> OR
> + * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
> OF
> + * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
> CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
> + * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
> OUT
> + * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> + * SUCH DAMAGE.
> + */
> +#ifndef _UAPI_LINUX_VIRTIO_IOMMU_H
> +#define _UAPI_LINUX_VIRTIO_IOMMU_H
> +
> +/* Feature bits */
> +#define VIRTIO_IOMMU_F_INPUT_RANGE		0
> +#define VIRTIO_IOMMU_F_IOASID_BITS		1
> +#define VIRTIO_IOMMU_F_MAP_UNMAP		2
> +#define VIRTIO_IOMMU_F_BYPASS			3
> +
> +__packed
> +struct virtio_iommu_config {
> +	/* Supported page sizes */
> +	__u64					page_sizes;
> +	struct virtio_iommu_range {
> +		__u64				start;
> +		__u64				end;
> +	} input_range;
> +	__u8 					ioasid_bits;
> +};
> +
> +/* Request types */
> +#define VIRTIO_IOMMU_T_ATTACH			0x01
> +#define VIRTIO_IOMMU_T_DETACH			0x02
> +#define VIRTIO_IOMMU_T_MAP			0x03
> +#define VIRTIO_IOMMU_T_UNMAP			0x04
> +
> +/* Status types */
> +#define VIRTIO_IOMMU_S_OK			0x00
> +#define VIRTIO_IOMMU_S_IOERR			0x01
> +#define VIRTIO_IOMMU_S_UNSUPP			0x02
> +#define VIRTIO_IOMMU_S_DEVERR			0x03
> +#define VIRTIO_IOMMU_S_INVAL			0x04
> +#define VIRTIO_IOMMU_S_RANGE			0x05
> +#define VIRTIO_IOMMU_S_NOENT			0x06
> +#define VIRTIO_IOMMU_S_FAULT			0x07
> +
> +__packed
> +struct virtio_iommu_req_head {
> +	__u8					type;
> +	__u8					reserved[3];
> +};
> +
> +__packed
> +struct virtio_iommu_req_tail {
> +	__u8					status;
> +	__u8					reserved[3];
> +};
> +
> +__packed
> +struct virtio_iommu_req_attach {
> +	struct virtio_iommu_req_head		head;
> +
> +	__le32					address_space;
> +	__le32					device;
> +	__le32					reserved;
> +
> +	struct virtio_iommu_req_tail		tail;
> +};
> +
> +__packed
> +struct virtio_iommu_req_detach {
> +	struct virtio_iommu_req_head		head;
> +
> +	__le32					device;
> +	__le32					reserved;
> +
> +	struct virtio_iommu_req_tail		tail;
> +};
> +
> +#define VIRTIO_IOMMU_MAP_F_READ			(1 << 0)
> +#define VIRTIO_IOMMU_MAP_F_WRITE		(1 << 1)
> +#define VIRTIO_IOMMU_MAP_F_EXEC			(1 << 2)
> +
> +#define VIRTIO_IOMMU_MAP_F_MASK
> 	(VIRTIO_IOMMU_MAP_F_READ |	\
> +
> VIRTIO_IOMMU_MAP_F_WRITE |	\
> +
> VIRTIO_IOMMU_MAP_F_EXEC)
> +
> +__packed
> +struct virtio_iommu_req_map {
> +	struct virtio_iommu_req_head		head;
> +
> +	__le32					address_space;
> +	__le32					flags;
> +	__le64					virt_addr;
> +	__le64					phys_addr;
> +	__le64					size;
> +
> +	struct virtio_iommu_req_tail		tail;
> +};
> +
> +__packed
> +struct virtio_iommu_req_unmap {
> +	struct virtio_iommu_req_head		head;
> +
> +	__le32					address_space;
> +	__le32					flags;
> +	__le64					virt_addr;
> +	__le64					size;
> +
> +	struct virtio_iommu_req_tail		tail;
> +};
> +
> +union virtio_iommu_req {
> +	struct virtio_iommu_req_head		head;
> +
> +	struct virtio_iommu_req_attach		attach;
> +	struct virtio_iommu_req_detach		detach;
> +	struct virtio_iommu_req_map		map;
> +	struct virtio_iommu_req_unmap		unmap;
> +};
> +
> +#endif
> --
> 2.12.1
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
