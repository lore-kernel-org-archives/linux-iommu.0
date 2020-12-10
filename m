Return-Path: <SRS0=6gDp=FO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1CEC433FE
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 22:51:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5209A23DE5
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 22:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5209A23DE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shazbot.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D4313203FF;
	Thu, 10 Dec 2020 22:51:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L2wbzLTUhwRN; Thu, 10 Dec 2020 22:51:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6AD722034B;
	Thu, 10 Dec 2020 22:51:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B7C6C0893;
	Thu, 10 Dec 2020 22:51:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94457C013B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 22:51:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 77DB6868B2
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 22:51:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UG1iNBhy-aLw for <iommu@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 22:51:06 +0000 (UTC)
X-Greylist: delayed 00:10:09 by SQLgrey-1.7.6
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4DB668685E
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 22:51:06 +0000 (UTC)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id B07DC5803C2;
 Thu, 10 Dec 2020 17:40:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 10 Dec 2020 17:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=4ETtXh
 KhnhOL0D8OIyRBHx/aOrVr0F66Bu8Pqn7fMl4=; b=Wx3zqIcA3pL5nyLZpJslP6
 o0Ai1lR/yUIGV+zcVbsi4xEWjvh/6euxqVO7J3PG/aDSg4ka8EXU6gW2rMZmkWOM
 hc6ZQTDiDHriaYp89lZpJstSCEn4Robe6BsagrzqxqSaOFrM4wJLon8tbWFX7AoL
 SddQp7ZOZ4ZNzwv1Q51Z2rfMvaXEWbQc73vEJLLSgfyFG2Y/SgA9RNDIP2P38foi
 zeOg9z26/E9RB62eW+VQdVFZ6xOSyjFtLVKDPPR/270Vsn2bb4wcEpeZDVgig5Nv
 HgrpWiS6vpnqJLy1EQJlEQVH74HPK/BE+1RdI6nGVmSwOb7z+zBV0kjUrbDUieyw
 ==
X-ME-Sender: <xms:9qPSX_PLckDvf8g6Fa-CIgt0z3SzBbHAh42sBGUd_5A8aGNfEJcj2g>
 <xme:9qPSX59EF5rZT67B7HSgXsnQC0C1tbPiXw_5Et9PaT6GvqL2TaVvrzstxjoFPUVJa
 isevg6Mz6FqglU68Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekuddgtdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfgjfhfogggtsehgtderreertddvnecuhfhrohhmpeetlhgvgicu
 hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
 htthgvrhhnpedtffegvefhgefgfeejueelhfeugfdvhfetleehffehheeutdejhefhffev
 feeiveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeelkedrfeekrdduud
 dvrddvudehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
 mheprghlvgigsehshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:9qPSX-Rpg58whPWpqoVNC7bB2JBvZviDj4sAdDEbYzmUH-nhl-fGng>
 <xmx:9qPSXztaKpejLErAx12LqOxxR-WWijktK6qaOzoB7JFzy71o_D6TLg>
 <xmx:9qPSX3cxwf7lji6-EWFlkTWDUOTEf66rvqdIz9KFmPFj1Vyfoh7UUQ>
 <xmx:-KPSX2yTMDoJ-6vt_Sdyb07FzM-irxYWtCFn9ZDpl_ggsPaecF4jKA>
Received: from shazbot.org (unknown [98.38.112.215])
 by mail.messagingengine.com (Postfix) with ESMTPA id 875C21080057;
 Thu, 10 Dec 2020 17:40:53 -0500 (EST)
Date: Thu, 10 Dec 2020 15:40:37 -0700
From: Alex Williamson <alex@shazbot.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 1/1] vfio/type1: Add vfio_group_iommu_domain()
Message-ID: <20201210154037.1205cc1d@shazbot.org>
In-Reply-To: <20201209014444.332772-1-baolu.lu@linux.intel.com>
References: <20201209014444.332772-1-baolu.lu@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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
Content-Type: multipart/mixed; boundary="===============4342120477182387850=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============4342120477182387850==
Content-Type: multipart/signed; boundary="Sig_/6majVZV6n.5l9uIZEIpGLwp";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/6majVZV6n.5l9uIZEIpGLwp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed,  9 Dec 2020 09:44:44 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Add the API for getting the domain from a vfio group. This could be used
> by the physical device drivers which rely on the vfio/mdev framework for
> mediated device user level access. The typical use case like below:
>=20
> 	unsigned int pasid;
> 	struct vfio_group *vfio_group;
> 	struct iommu_domain *iommu_domain;
> 	struct device *dev =3D mdev_dev(mdev);
> 	struct device *iommu_device =3D mdev_get_iommu_device(dev);
>=20
> 	if (!iommu_device ||
> 	    !iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
> 		return -EINVAL;
>=20
> 	vfio_group =3D vfio_group_get_external_user_from_dev(dev);
> 	if (IS_ERR_OR_NULL(vfio_group))
> 		return -EFAULT;
>=20
> 	iommu_domain =3D vfio_group_iommu_domain(vfio_group);
> 	if (IS_ERR_OR_NULL(iommu_domain)) {
> 		vfio_group_put_external_user(vfio_group);
> 		return -EFAULT;
> 	}
>=20
> 	pasid =3D iommu_aux_get_pasid(iommu_domain, iommu_device);
> 	if (pasid < 0) {
> 		vfio_group_put_external_user(vfio_group);
> 		return -EFAULT;
> 	}
>=20
> 	/* Program device context with pasid value. */
> 	...
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/vfio/vfio.c             | 18 ++++++++++++++++++
>  drivers/vfio/vfio_iommu_type1.c | 24 ++++++++++++++++++++++++
>  include/linux/vfio.h            |  4 ++++
>  3 files changed, 46 insertions(+)


Applied to vfio next branch for v5.11.  Thanks,

Alex


> Change log:
>  - v3: https://lore.kernel.org/linux-iommu/20201201012328.2465735-1-baolu=
.lu@linux.intel.com/
>  - Changed according to comments @ https://lore.kernel.org/linux-iommu/20=
201202144834.1dd0983e@w520.home/
>    - Rename group_domain to group_iommu_domain;
>    - Remove an unnecessary else branch.
>=20
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 2151bc7f87ab..4ad8a35667a7 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -2331,6 +2331,24 @@ int vfio_unregister_notifier(struct device *dev, e=
num vfio_notify_type type,
>  }
>  EXPORT_SYMBOL(vfio_unregister_notifier);
> =20
> +struct iommu_domain *vfio_group_iommu_domain(struct vfio_group *group)
> +{
> +	struct vfio_container *container;
> +	struct vfio_iommu_driver *driver;
> +
> +	if (!group)
> +		return ERR_PTR(-EINVAL);
> +
> +	container =3D group->container;
> +	driver =3D container->iommu_driver;
> +	if (likely(driver && driver->ops->group_iommu_domain))
> +		return driver->ops->group_iommu_domain(container->iommu_data,
> +						       group->iommu_group);
> +
> +	return ERR_PTR(-ENOTTY);
> +}
> +EXPORT_SYMBOL_GPL(vfio_group_iommu_domain);
> +
>  /**
>   * Module/class support
>   */
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_ty=
pe1.c
> index 67e827638995..0b4dedaa9128 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2980,6 +2980,29 @@ static int vfio_iommu_type1_dma_rw(void *iommu_dat=
a, dma_addr_t user_iova,
>  	return ret;
>  }
> =20
> +static struct iommu_domain *
> +vfio_iommu_type1_group_iommu_domain(void *iommu_data,
> +				    struct iommu_group *iommu_group)
> +{
> +	struct iommu_domain *domain =3D ERR_PTR(-ENODEV);
> +	struct vfio_iommu *iommu =3D iommu_data;
> +	struct vfio_domain *d;
> +
> +	if (!iommu || !iommu_group)
> +		return ERR_PTR(-EINVAL);
> +
> +	mutex_lock(&iommu->lock);
> +	list_for_each_entry(d, &iommu->domain_list, next) {
> +		if (find_iommu_group(d, iommu_group)) {
> +			domain =3D d->domain;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&iommu->lock);
> +
> +	return domain;
> +}
> +
>  static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 =
=3D {
>  	.name			=3D "vfio-iommu-type1",
>  	.owner			=3D THIS_MODULE,
> @@ -2993,6 +3016,7 @@ static const struct vfio_iommu_driver_ops vfio_iomm=
u_driver_ops_type1 =3D {
>  	.register_notifier	=3D vfio_iommu_type1_register_notifier,
>  	.unregister_notifier	=3D vfio_iommu_type1_unregister_notifier,
>  	.dma_rw			=3D vfio_iommu_type1_dma_rw,
> +	.group_iommu_domain	=3D vfio_iommu_type1_group_iommu_domain,
>  };
> =20
>  static int __init vfio_iommu_type1_init(void)
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 38d3c6a8dc7e..f45940b38a02 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -90,6 +90,8 @@ struct vfio_iommu_driver_ops {
>  					       struct notifier_block *nb);
>  	int		(*dma_rw)(void *iommu_data, dma_addr_t user_iova,
>  				  void *data, size_t count, bool write);
> +	struct iommu_domain *(*group_iommu_domain)(void *iommu_data,
> +						   struct iommu_group *group);
>  };
> =20
>  extern int vfio_register_iommu_driver(const struct vfio_iommu_driver_ops=
 *ops);
> @@ -126,6 +128,8 @@ extern int vfio_group_unpin_pages(struct vfio_group *=
group,
>  extern int vfio_dma_rw(struct vfio_group *group, dma_addr_t user_iova,
>  		       void *data, size_t len, bool write);
> =20
> +extern struct iommu_domain *vfio_group_iommu_domain(struct vfio_group *g=
roup);
> +
>  /* each type has independent events */
>  enum vfio_notify_type {
>  	VFIO_IOMMU_NOTIFY =3D 0,


--Sig_/6majVZV6n.5l9uIZEIpGLwp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEQvbATlQL0amee4qQI5ubbjuwiyIFAl/So+UACgkQI5ubbjuw
iyJJFg/9GY+pzJ1NsCya7cVMkzzFR0/e3Lt4X39ck/1i1Kkw4AB62pQ1ELam+sD+
dXtg3IOz8/xzXTd1m/FIuPiBHcN2/5GV2j1gdSN1XKw3vW7kOyOtpNi3ssZlOZwV
Q/Pj70gVPGilZKc4ms2SYHGWpnwA3KeI1Z/tfbbDhZyvTyCbb4Hkt81rinA0z+8i
yP2ruLvZALhZ9+Klz9fqo6EKHimykamQWt3AhjW7s2Nycs8JmokakolgGcU/sdKG
AuOWq9VLYmnbgQOdL9JeaCN3GlvHQF5BDhxS+JdDxsPr3JzYwHPmEeFyqSURbZW1
CduESlZuDTpqK3VfL+fyfkNIQvCnExHmVwYitdCxyEafobkgArp9ZOThALaQRJc6
jD8DaXy4oeo9jf4rmSQaStKvqMrKD3J88JEzWL2idbce/+3qQ3LaTlfvOa1jWgcn
r6nQfoidI+xWg+VdzqGW6CuXFeLdgooVZGTqQfC97qKK8Pv506KtYHtrhRbYza6Z
BmQfY7RY1PsxCRuu6R0yCbBy1jqMMY02+4r4/THNqd4y1wu/uUoyLpt65A6yc89Q
3/FMQqaYhWEZWztj8Y4Ns+Lc5DKHJmmUPhjvFhpvACETiVGpCX9yzWnHCwOzZ7pf
BC/0L1zHF+emJWmUzMTQy9sM3WtLog2VV8FUa88o6N7DSDy9PVw=
=Ao2x
-----END PGP SIGNATURE-----

--Sig_/6majVZV6n.5l9uIZEIpGLwp--

--===============4342120477182387850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4342120477182387850==--
