Return-Path: <SRS0=rAFC=PC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2947C433FE
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 06:22:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CF661152
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 06:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70CF661152
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C52540419;
	Thu, 14 Oct 2021 06:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zgCgWoyJrdXL; Thu, 14 Oct 2021 06:22:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7D93240223;
	Thu, 14 Oct 2021 06:22:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35BDFC0011;
	Thu, 14 Oct 2021 06:22:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DABEC000D
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 06:22:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 37AEB831F2
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 06:22:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p7MTK-bmda_J for <iommu@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:22:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7F61831A0
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 06:22:36 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HVK7r2S38z4xqT; Thu, 14 Oct 2021 17:22:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1634192552;
 bh=OTTe4+lAhyLUWJzZiGJrOam3cYsUQwZJXvJ/DxMrddo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HQWLk7Fe8segL63WWDIUMVqqyL9MO5uGR7AItks/wHEwX735Oj/tg6WqkCmzoWJKM
 7DfgLmb2hIyVO1woDdbTyetbzXEQXd1DWP/QjwrUc5UqcCCvvDK1M7n2nxl0KP/KPu
 twP6rH6BjHRpv5PDiYtX//j87GI7cYEk9G8C5qO4=
Date: Thu, 14 Oct 2021 16:24:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC 13/20] iommu: Extend iommu_at[de]tach_device() for multiple
 devices group
Message-ID: <YWe+88sfCbxgMYPN@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-14-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20210919063848.1476776-14-yi.l.liu@intel.com>
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
Content-Type: multipart/mixed; boundary="===============4848557257220759101=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4848557257220759101==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yqSnmJuJEfpVkol+"
Content-Disposition: inline


--yqSnmJuJEfpVkol+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 19, 2021 at 02:38:41PM +0800, Liu Yi L wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> These two helpers could be used when 1) the iommu group is singleton,
> or 2) the upper layer has put the iommu group into the secure state by
> calling iommu_device_init_user_dma().
>=20
> As we want the iommufd design to be a device-centric model, we want to
> remove any group knowledge in iommufd. Given that we already have
> iommu_at[de]tach_device() interface, we could extend it for iommufd
> simply by doing below:
>=20
>  - first device in a group does group attach;
>  - last device in a group does group detach.
>=20
> as long as the group has been put into the secure context.
>=20
> The commit <426a273834eae> ("iommu: Limit iommu_attach/detach_device to
> device with their own group") deliberately restricts the two interfaces
> to single-device group. To avoid the conflict with existing usages, we
> keep this policy and put the new extension only when the group has been
> marked for user_dma.

I still kind of hate this interface because it means an operation that
appears to be explicitly on a single device has an implicit effect on
other devices.

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index bffd84e978fb..b6178997aef1 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -47,6 +47,7 @@ struct iommu_group {
>  	struct list_head entry;
>  	unsigned long user_dma_owner_id;
>  	refcount_t owner_cnt;
> +	refcount_t attach_cnt;
>  };
> =20
>  struct group_device {
> @@ -1994,7 +1995,7 @@ static int __iommu_attach_device(struct iommu_domai=
n *domain,
>  int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>  {
>  	struct iommu_group *group;
> -	int ret;
> +	int ret =3D 0;
> =20
>  	group =3D iommu_group_get(dev);
>  	if (!group)
> @@ -2005,11 +2006,23 @@ int iommu_attach_device(struct iommu_domain *doma=
in, struct device *dev)
>  	 * change while we are attaching
>  	 */
>  	mutex_lock(&group->mutex);
> -	ret =3D -EINVAL;
> -	if (iommu_group_device_count(group) !=3D 1)
> +	if (group->user_dma_owner_id) {
> +		if (group->domain) {
> +			if (group->domain !=3D domain)
> +				ret =3D -EBUSY;
> +			else
> +				refcount_inc(&group->attach_cnt);
> +
> +			goto out_unlock;
> +		}
> +	} else if (iommu_group_device_count(group) !=3D 1) {

With this condition in the else, how can you ever attach the first
device of a multi-device group?

> +		ret =3D -EINVAL;
>  		goto out_unlock;
> +	}
> =20
>  	ret =3D __iommu_attach_group(domain, group);
> +	if (!ret && group->user_dma_owner_id)
> +		refcount_set(&group->attach_cnt, 1);
> =20
>  out_unlock:
>  	mutex_unlock(&group->mutex);
> @@ -2261,7 +2274,10 @@ void iommu_detach_device(struct iommu_domain *doma=
in, struct device *dev)
>  		return;
> =20
>  	mutex_lock(&group->mutex);
> -	if (iommu_group_device_count(group) !=3D 1) {
> +	if (group->user_dma_owner_id) {
> +		if (!refcount_dec_and_test(&group->attach_cnt))
> +			goto out_unlock;
> +	} else if (iommu_group_device_count(group) !=3D 1) {

Shouldn't this path (detach a thing that's not attached), be a no-op
regardless of whether it's a singleton group or not?  Why does one
deserve a warning and one not?

>  		WARN_ON(1);
>  		goto out_unlock;
>  	}
> @@ -3368,6 +3384,7 @@ static int iommu_group_init_user_dma(struct iommu_g=
roup *group,
> =20
>  	group->user_dma_owner_id =3D owner;
>  	refcount_set(&group->owner_cnt, 1);
> +	refcount_set(&group->attach_cnt, 0);
> =20
>  	/* default domain is unsafe for user-initiated dma */
>  	if (group->domain =3D=3D group->default_domain)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yqSnmJuJEfpVkol+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFnvvEACgkQbDjKyiDZ
s5Klnw/+LwB1ZX7cilbD1febQTg36WiCbtZJYQYs6KgI10I8omcDnltCppdJDejN
8wo0M6cE+7lfXmtWs0amn1FFt+dlCr34htN5695HAH5G++WpRNCiFGpbMwu9oz67
XMeSylngf19m34qnVzrjgeKIEEvVOqI7S/CCMBh0iuM3UAry9TvxkDupppYUDP0u
TYFTETu5VfYyL68RfBjOdU4CFe8+k6XQzXu4gwpYkBxLWEhV63qyS77hXnWZBj12
6dQ3j3KwVJ3BnEXCh9op3iExD231zblX9zukstgxhXPVfLEMhRhMaKnIjjwmT95a
OPCFCqMHLUItBtBeIlc+O+rBXN6ywokSNZc3RNI+rLSs47V+PFW/a/bgTDxTOnKL
1Urv1GTfzuISUVZjn8JTrz81iew7LLXsKFisj9vyZtSFMlhU+Q1GTjBXYBUBGDFr
4JPW42uttcw8/GNGWeiX6tonnVhyneO+suiW+AGzrjDuYqvsw8yIiVNR+UKe8jPI
CI3kvSycu2R3JcDQ54ynzvwgT59Rt2YJkparBySyq5n6WvgFTtgm52daRve2XLDn
CUKdS8ajgzhm4ib36yiWe2KM9lGC/izFE5sy5xkT0LIr0Pwt/TJ8g7Wa7YoLztvP
6V2lwyOwb9fzU3Olv8EHEPAo1Ze6BVKLOXvelQ5fIJBRgQ0B00M=
=NemI
-----END PGP SIGNATURE-----

--yqSnmJuJEfpVkol+--

--===============4848557257220759101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4848557257220759101==--
