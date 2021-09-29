Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80721C433FE
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 04:56:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC76A613CD
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 04:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BC76A613CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D22540249;
	Wed, 29 Sep 2021 04:55:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R-T4x0AzjIoK; Wed, 29 Sep 2021 04:55:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8DA2040018;
	Wed, 29 Sep 2021 04:55:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62D65C000F;
	Wed, 29 Sep 2021 04:55:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B511C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 04:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DAF2760639
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 04:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id apsRtOA9fEjn for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 04:55:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 827FB605E7
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 04:55:53 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HK3wj5V1xz4xbL; Wed, 29 Sep 2021 14:55:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1632891349;
 bh=j4IJARptHYsiuLRuyIgK0+MiDtR8ZH5cGfenXvO/Lsg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Y0LPZwNlpB9G8ql9vsO06tGsfCZJryQyGg4+Zmb1Yx7WNTJOiQE1Z8PftrqquvEgQ
 LW9YtgfsTDwLK9EZiVCTrs+WHfJSNx0DL0szmCoWAzMkJHQD7KD/wb6aumdFnYVpGm
 /zU6Wq0un3M734iu/5xOfPFqD4IipRXxNcGQO+5s=
Date: Wed, 29 Sep 2021 14:55:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma interfaces
Message-ID: <YVPxzad5TYHAc1H/@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-7-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20210919063848.1476776-7-yi.l.liu@intel.com>
Cc: kvm@vger.kernel.org, jasowang@redhat.com, kwankhede@nvidia.com, hch@lst.de,
 jean-philippe@linaro.org, dave.jiang@intel.com, ashok.raj@intel.com,
 corbet@lwn.net, jgg@nvidia.com, kevin.tian@intel.com, parav@mellanox.com,
 alex.williamson@redhat.com, lkml@metux.net, dwmw2@infradead.org,
 jun.j.tian@intel.com, linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, robin.murphy@arm.com
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
Content-Type: multipart/mixed; boundary="===============1805000844944960501=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1805000844944960501==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LmpUe83dM2DcdbUy"
Content-Disposition: inline


--LmpUe83dM2DcdbUy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 19, 2021 at 02:38:34PM +0800, Liu Yi L wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> This extends iommu core to manage security context for passthrough
> devices. Please bear a long explanation for how we reach this design
> instead of managing it solely in iommufd like what vfio does today.
>=20
> Devices which cannot be isolated from each other are organized into an
> iommu group. When a device is assigned to the user space, the entire
> group must be put in a security context so that user-initiated DMAs via
> the assigned device cannot harm the rest of the system. No user access
> should be granted on a device before the security context is established
> for the group which the device belongs to.
>=20
> Managing the security context must meet below criteria:
>=20
> 1)  The group is viable for user-initiated DMAs. This implies that the
>     devices in the group must be either bound to a device-passthrough
>     framework, or driver-less, or bound to a driver which is known safe
>     (not do DMA).
>=20
> 2)  The security context should only allow DMA to the user's memory and
>     devices in this group;
>=20
> 3)  After the security context is established for the group, the group
>     viability must be continuously monitored before the user relinquishes
>     all devices belonging to the group. The viability might be broken e.g.
>     when a driver-less device is later bound to a driver which does DMA.
>=20
> 4)  The security context should not be destroyed before user access
>     permission is withdrawn.
>=20
> Existing vfio introduces explicit container/group semantics in its uAPI
> to meet above requirements. A single security context (iommu domain)
> is created per container. Attaching group to container moves the entire
> group into the associated security context, and vice versa. The user can
> open the device only after group attach. A group can be detached only
> after all devices in the group are closed. Group viability is monitored
> by listening to iommu group events.
>=20
> Unlike vfio, iommufd adopts a device-centric design with all group
> logistics hidden behind the fd. Binding a device to iommufd serves
> as the contract to get security context established (and vice versa
> for unbinding). One additional requirement in iommufd is to manage the
> switch between multiple security contexts due to decoupled bind/attach:
>=20
> 1)  Open a device in "/dev/vfio/devices" with user access blocked;

Probably worth clarifying that (1) must happen for *all* devices in
the group before (2) happens for any device in the group.

> 2)  Bind the device to an iommufd with an initial security context
>     (an empty iommu domain which blocks dma) established for its
>     group, with user access unblocked;
>=20
> 3)  Attach the device to a user-specified ioasid (shared by all devices
>     attached to this ioasid). Before attaching, the device should be first
>     detached from the initial context;

So, this step can implicitly but observably change the behaviour for
other devices in the group as well.  I don't love that kind of
difficult to predict side effect, which is why I'm *still* not totally
convinced by the device-centric model.

> 4)  Detach the device from the ioasid and switch it back to the initial
>     security context;

Same non-local side effect at this step, of course.

Btw, explicitly naming the "no DMA" context is probably a good idea,
rather than referring to the "initial security context" (it's
"initial" from the PoV of the iommufd, but not from the PoV of the
device fd which was likely bound to the default kernel context before
(2)).

> 5)  Unbind the device from the iommufd, back to access blocked state and
>     move its group out of the initial security context if it's the last
>     unbound device in the group;

Maybe worth clarifying that again (5) must happen for all devices in
the group before rebiding any devices to regular kernel drivers.
>=20
> (multiple attach/detach could happen between 2 and 5).
>=20
> However existing iommu core has problem with above transition. Detach
> in step 3/4 makes the device/group re-attached to the default domain
> automatically, which opens the door for user-initiated DMAs to attack
> the rest of the system. The existing vfio doesn't have this problem as
> it combines 2/3 in one step (so does 4/5).
>=20
> Fixing this problem requires the iommu core to also participate in the
> security context management. Following this direction we also move group
> viability check into the iommu core, which allows iommufd to stay fully
> device-centric w/o keeping any group knowledge (combining with the
> extension to iommu_at[de]tach_device() in a latter patch).
>=20
> Basically two new interfaces are provided:
>=20
>         int iommu_device_init_user_dma(struct device *dev,
>                         unsigned long owner);
>         void iommu_device_exit_user_dma(struct device *dev);
>=20
> iommufd calls them respectively when handling device binding/unbinding
> requests.
>=20
> The init_user_dma() for the 1st device in a group marks the entire group
> for user-dma and establishes the initial security context (dma blocked)
> according to aforementioned criteria. As long as the group is marked for
> user-dma, auto-reattaching to default domain is disabled. Instead, upon
> detaching the group is moved back to the initial security context.
>=20
> The caller also provides an owner id to mark the ownership so inadvertent
> attempt from another caller on the same device can be captured. In this
> RFC iommufd will use the fd context pointer as the owner id.
>=20
> The exit_user_dma() for the last device in the group clears the user-dma
> mark and moves the group back to the default domain.
>=20
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 145 +++++++++++++++++++++++++++++++++++++++++-
>  include/linux/iommu.h |  12 ++++
>  2 files changed, 154 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5ea3a007fd7c..bffd84e978fb 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -45,6 +45,8 @@ struct iommu_group {
>  	struct iommu_domain *default_domain;
>  	struct iommu_domain *domain;
>  	struct list_head entry;
> +	unsigned long user_dma_owner_id;

Using an opaque integer doesn't seem like a good idea.  I think you
probably want a pointer to a suitable struct dma_owner or the like
(you could have one embedded in each iommufd struct, plus a global
static kernel_default_owner).

> +	refcount_t owner_cnt;
>  };
> =20
>  struct group_device {
> @@ -86,6 +88,7 @@ static int iommu_create_device_direct_mappings(struct i=
ommu_group *group,
>  static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
>  static ssize_t iommu_group_store_type(struct iommu_group *group,
>  				      const char *buf, size_t count);
> +static bool iommu_group_user_dma_viable(struct iommu_group *group);
> =20
>  #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
>  struct iommu_group_attribute iommu_group_attr_##_name =3D		\
> @@ -275,7 +278,11 @@ int iommu_probe_device(struct device *dev)
>  	 */
>  	iommu_alloc_default_domain(group, dev);
> =20
> -	if (group->default_domain) {
> +	/*
> +	 * If any device in the group has been initialized for user dma,
> +	 * avoid attaching the default domain.
> +	 */
> +	if (group->default_domain && !group->user_dma_owner_id) {
>  		ret =3D __iommu_attach_device(group->default_domain, dev);
>  		if (ret) {
>  			iommu_group_put(group);
> @@ -1664,6 +1671,17 @@ static int iommu_bus_notifier(struct notifier_bloc=
k *nb,
>  		group_action =3D IOMMU_GROUP_NOTIFY_BIND_DRIVER;
>  		break;
>  	case BUS_NOTIFY_BOUND_DRIVER:
> +		/*
> +		 * FIXME: Alternatively the attached drivers could generically
> +		 * indicate to the iommu layer that they are safe for keeping
> +		 * the iommu group user viable by calling some function around
> +		 * probe(). We could eliminate this gross BUG_ON() by denying
> +		 * probe to non-iommu-safe driver.
> +		 */
> +		mutex_lock(&group->mutex);
> +		if (group->user_dma_owner_id)
> +			BUG_ON(!iommu_group_user_dma_viable(group));
> +		mutex_unlock(&group->mutex);
>  		group_action =3D IOMMU_GROUP_NOTIFY_BOUND_DRIVER;
>  		break;
>  	case BUS_NOTIFY_UNBIND_DRIVER:
> @@ -2304,7 +2322,11 @@ static int __iommu_attach_group(struct iommu_domai=
n *domain,
>  {
>  	int ret;
> =20
> -	if (group->default_domain && group->domain !=3D group->default_domain)
> +	/*
> +	 * group->domain could be NULL when a domain is detached from the
> +	 * group but the default_domain is not re-attached.
> +	 */
> +	if (group->domain && group->domain !=3D group->default_domain)
>  		return -EBUSY;
> =20
>  	ret =3D __iommu_group_for_each_dev(group, domain,
> @@ -2341,7 +2363,11 @@ static void __iommu_detach_group(struct iommu_doma=
in *domain,
>  {
>  	int ret;
> =20
> -	if (!group->default_domain) {
> +	/*
> +	 * If any device in the group has been initialized for user dma,
> +	 * avoid re-attaching the default domain.
> +	 */
> +	if (!group->default_domain || group->user_dma_owner_id) {
>  		__iommu_group_for_each_dev(group, domain,
>  					   iommu_group_do_detach_device);
>  		group->domain =3D NULL;
> @@ -3276,3 +3302,116 @@ int iommu_device_get_info(struct device *dev, enu=
m iommu_devattr attr, void *dat
>  	return ops->device_info(dev, attr, data);
>  }
>  EXPORT_SYMBOL_GPL(iommu_device_get_info);
> +
> +/*
> + * IOMMU core interfaces for iommufd.
> + */
> +
> +/*
> + * FIXME: We currently simply follow vifo policy to mantain the group's
> + * viability to user. Eventually, we should avoid below hard-coded list
> + * by letting drivers indicate to the iommu layer that they are safe for
> + * keeping the iommu group's user aviability.
> + */
> +static const char * const iommu_driver_allowed[] =3D {
> +	"vfio-pci",
> +	"pci-stub"
> +};
> +
> +/*
> + * An iommu group is viable for use by userspace if all devices are in
> + * one of the following states:
> + *  - driver-less
> + *  - bound to an allowed driver
> + *  - a PCI interconnect device
> + */
> +static int device_user_dma_viable(struct device *dev, void *data)

I think this wants a "less friendly" more obviously local name.
Really the only safe way to call this is via
iommu_group_user_dma_viable(), which isn't obvious from this name.

> +{
> +	struct device_driver *drv =3D READ_ONCE(dev->driver);
> +
> +	if (!drv)
> +		return 0;
> +
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev =3D to_pci_dev(dev);
> +
> +		if (pdev->hdr_type !=3D PCI_HEADER_TYPE_NORMAL)
> +			return 0;
> +	}
> +
> +	return match_string(iommu_driver_allowed,
> +			    ARRAY_SIZE(iommu_driver_allowed),
> +			    drv->name) < 0;
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LmpUe83dM2DcdbUy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFT8cgACgkQbDjKyiDZ
s5LDshAAueFk7I7J9EQynn1R/ejHdu7L+tBXBss/9oKVXmWsxGISBfaRvRufwDfb
HOTWvRLaACMqCl3m1wmx9yC2D3iULgMUtpHdr3IuQBAt5EYO9KnG+IPM4TrHtq4P
8CXUeF8cXHd4v0TWjrTCPMixBFHEgda2/TFa0WFMM5kTYqiVaHOPmlAZG6zfMtKK
/TmUzqHkQZgs2+XGW7nlKbgWqQ/ecSfv8GywlSOWsSl8sSp5DVqXEkAWdD92b0yM
wtXTJigVmCGkM+AXAnwHY+K9upDiKqU4qSE4rRS/1gvB1Mum3L1TQOxSbJ9ROkCj
u6Wnv4sZe10n4/zmmPtJrLinKFnvOdvHPjHOnPdz/5UlR12oo1NukIQ/6SCBWnoE
jgyzjN5C53l9PUiqgRg7etLoY0LOdlNqPRgA5LbYewDRioK0qiUF8e6GYqN/cnO1
v6kdUcnRj+kICfqZA0ngvZWHyL4uL6kVfcQsZtqNZTu6lAA4qpcyvqQ/ZiGAhM8Q
4fBtG6mOJTvfsHsP+XJNOsh4/6uKXLP4XJZVFIZ84SFQbpPnu3tydGuS29ZuLwkP
fETNAjRG9x3QtedeYKVus6a2MZney34LjGyCD2wT5b+sfrcNTmeq2bs20kJAZ9DJ
xurKzUUsz6hL70Bc7cfqcBpvzf1OMvPC8z/G2m5f2pwI5oD2KzU=
=w3D3
-----END PGP SIGNATURE-----

--LmpUe83dM2DcdbUy--

--===============1805000844944960501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1805000844944960501==--
