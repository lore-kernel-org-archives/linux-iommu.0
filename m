From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 19/20] iommu/tegra: gart: Simplify clients-tracking code
Date: Tue, 25 Sep 2018 12:09:09 +0200
Message-ID: <20180925100909.GH7097@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
	<20180924004153.8232-20-digetx@gmail.com>
	<20180924111047.GP21032@ulmo>
	<aefb6b78-4923-0259-0f3a-2ce3b95ca456@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2948423812985870407=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <aefb6b78-4923-0259-0f3a-2ce3b95ca456-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============2948423812985870407==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2xzXx3ruJf7hsAzo"
Content-Disposition: inline


--2xzXx3ruJf7hsAzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 08:50:35PM +0300, Dmitry Osipenko wrote:
> On 9/24/18 2:10 PM, Thierry Reding wrote:
> > On Mon, Sep 24, 2018 at 03:41:52AM +0300, Dmitry Osipenko wrote:
> >> GART is a simple IOMMU provider that has single address space. There is
> >> no need to setup global clients list and manage it for tracking of the
> >> active domain, hence lot's of code could be safely removed and replaced
> >> with a simpler alternative.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> ---
> >>  drivers/iommu/tegra-gart.c | 157 +++++++++----------------------------
> >>  1 file changed, 39 insertions(+), 118 deletions(-)
> >>
> >> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> >> index 306e9644a676..7182445c3b76 100644
> >> --- a/drivers/iommu/tegra-gart.c
> >> +++ b/drivers/iommu/tegra-gart.c
> >> @@ -19,7 +19,6 @@
> >> =20
> >>  #include <linux/io.h>
> >>  #include <linux/iommu.h>
> >> -#include <linux/list.h>
> >>  #include <linux/module.h>
> >>  #include <linux/platform_device.h>
> >>  #include <linux/slab.h>
> >> @@ -42,30 +41,20 @@
> >>  #define GART_PAGE_MASK						\
> >>  	(~(GART_PAGE_SIZE - 1) & ~GART_ENTRY_PHYS_ADDR_VALID)
> >> =20
> >> -struct gart_client {
> >> -	struct device		*dev;
> >> -	struct list_head	list;
> >> -};
> >> -
> >>  struct gart_device {
> >>  	void __iomem		*regs;
> >>  	u32			*savedata;
> >>  	u32			page_count;	/* total remappable size */
> >>  	dma_addr_t		iovmm_base;	/* offset to vmm_area */
> >>  	spinlock_t		pte_lock;	/* for pagetable */
> >> -	struct list_head	client;
> >> -	spinlock_t		client_lock;	/* for client list */
> >> +	spinlock_t		dom_lock;	/* for active domain */
> >> +	unsigned int		active_devices;	/* number of active devices */
> >>  	struct iommu_domain	*active_domain;	/* current active domain */
> >>  	struct device		*dev;
> >> =20
> >>  	struct iommu_device	iommu;		/* IOMMU Core handle */
> >>  };
> >> =20
> >> -struct gart_domain {
> >> -	struct iommu_domain domain;		/* generic domain handle */
> >> -	struct gart_device *gart;		/* link to gart device   */
> >> -};
> >> -
> >>  static struct gart_device *gart_handle; /* unique for a system */
> >> =20
> >>  static bool gart_debug;
> >> @@ -73,11 +62,6 @@ static bool gart_debug;
> >>  #define GART_PTE(_pfn)						\
> >>  	(GART_ENTRY_PHYS_ADDR_VALID | ((_pfn) << PAGE_SHIFT))
> >> =20
> >> -static struct gart_domain *to_gart_domain(struct iommu_domain *dom)
> >> -{
> >> -	return container_of(dom, struct gart_domain, domain);
> >> -}
> >> -
> >>  /*
> >>   * Any interaction between any block on PPSB and a block on APB or AHB
> >>   * must have these read-back to ensure the APB/AHB bus transaction is
> >> @@ -166,128 +150,69 @@ static inline bool gart_iova_range_valid(struct=
 gart_device *gart,
> >>  static int gart_iommu_attach_dev(struct iommu_domain *domain,
> >>  				 struct device *dev)
> >>  {
> >> -	struct gart_domain *gart_domain =3D to_gart_domain(domain);
> >>  	struct gart_device *gart =3D gart_handle;
> >> -	struct gart_client *client, *c;
> >> -	int err =3D 0;
> >> -
> >> -	client =3D kzalloc(sizeof(*c), GFP_KERNEL);
> >> -	if (!client)
> >> -		return -ENOMEM;
> >> -	client->dev =3D dev;
> >> -
> >> -	spin_lock(&gart->client_lock);
> >> -	list_for_each_entry(c, &gart->client, list) {
> >> -		if (c->dev =3D=3D dev) {
> >> -			dev_err(gart->dev, "GART: %s is already attached\n",
> >> -				dev_name(dev));
> >> -			err =3D -EINVAL;
> >> -			goto fail;
> >> -		}
> >> -	}
> >> -	if (gart->active_domain && gart->active_domain !=3D domain) {
> >> -		dev_err(gart->dev,
> >> -			"GART: Only one domain can be active at a time\n");
> >> -		err =3D -EINVAL;
> >> -		goto fail;
> >> -	}
> >> -	gart->active_domain =3D domain;
> >> -	gart_domain->gart =3D gart;
> >> -	list_add(&client->list, &gart->client);
> >> -	spin_unlock(&gart->client_lock);
> >> -	dev_dbg(gart->dev, "GART: Attached %s\n", dev_name(dev));
> >> -	return 0;
> >> +	int ret =3D 0;
> >> =20
> >> -fail:
> >> -	kfree(client);
> >> -	spin_unlock(&gart->client_lock);
> >> -	return err;
> >> -}
> >> +	spin_lock(&gart->dom_lock);
> >> =20
> >> -static void __gart_iommu_detach_dev(struct iommu_domain *domain,
> >> -				    struct device *dev)
> >> -{
> >> -	struct gart_domain *gart_domain =3D to_gart_domain(domain);
> >> -	struct gart_device *gart =3D gart_domain->gart;
> >> -	struct gart_client *c;
> >> -
> >> -	list_for_each_entry(c, &gart->client, list) {
> >> -		if (c->dev =3D=3D dev) {
> >> -			list_del(&c->list);
> >> -			kfree(c);
> >> -			if (list_empty(&gart->client)) {
> >> -				gart->active_domain =3D NULL;
> >> -				gart_domain->gart =3D NULL;
> >> -			}
> >> -			dev_dbg(gart->dev, "GART: Detached %s\n",
> >> -				dev_name(dev));
> >> -			return;
> >> -		}
> >> +	if (gart->active_domain && gart->active_domain !=3D domain) {
> >> +		ret =3D -EBUSY;
> >=20
> > This omits the error message and returns -EBUSY instead of -EINVAL. Was
> > this intended? For what it's worth, I do agree with the changes, it's
> > just that I think you could've made those in the earlier patch that
> > introduced them.
>=20
> The message isn't really needed and EBUSY seems fit better than EINVAL he=
re.
>=20
> > But this is all one series and the end result looks fine, so no need to
> > be that picky.
>=20
> Good, thanks.
>=20
> >> +	} else if (dev->archdata.iommu !=3D domain) {
> >> +		dev->archdata.iommu =3D domain;
> >> +		gart->active_domain =3D domain;
> >> +		gart->active_devices++;
> >>  	}
> >> =20
> >> -	dev_err(gart->dev, "GART: Couldn't find %s to detach\n",
> >> -		dev_name(dev));
> >> +	spin_unlock(&gart->dom_lock);
> >> +
> >> +	return ret;
> >>  }
> >> =20
> >>  static void gart_iommu_detach_dev(struct iommu_domain *domain,
> >>  				  struct device *dev)
> >>  {
> >> -	struct gart_domain *gart_domain =3D to_gart_domain(domain);
> >> -	struct gart_device *gart =3D gart_domain->gart;
> >> +	struct gart_device *gart =3D gart_handle;
> >> +
> >> +	spin_lock(&gart->dom_lock);
> >> =20
> >> -	spin_lock(&gart->client_lock);
> >> -	__gart_iommu_detach_dev(domain, dev);
> >> -	spin_unlock(&gart->client_lock);
> >> +	if (dev->archdata.iommu =3D=3D domain) {
> >> +		dev->archdata.iommu =3D NULL;
> >> +
> >> +		if (--gart->active_devices =3D=3D 0)
> >> +			gart->active_domain =3D NULL;
> >> +	}
> >> +
> >> +	spin_unlock(&gart->dom_lock);
> >>  }
> >> =20
> >>  static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
> >>  {
> >> -	struct gart_domain *gart_domain;
> >> -	struct gart_device *gart;
> >> +	struct gart_device *gart =3D gart_handle;
> >> +	struct iommu_domain *domain;
> >> =20
> >>  	if (type !=3D IOMMU_DOMAIN_UNMANAGED)
> >>  		return NULL;
> >> =20
> >> -	gart =3D gart_handle;
> >> -	if (!gart)
> >> -		return NULL;
> >> -
> >> -	gart_domain =3D kzalloc(sizeof(*gart_domain), GFP_KERNEL);
> >> -	if (!gart_domain)
> >> -		return NULL;
> >> -
> >> -	gart_domain->domain.geometry.aperture_start =3D gart->iovmm_base;
> >> -	gart_domain->domain.geometry.aperture_end =3D gart->iovmm_base +
> >> +	domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
> >> +	if (domain) {
> >> +		domain->geometry.aperture_start =3D gart->iovmm_base;
> >> +		domain->geometry.aperture_end =3D gart->iovmm_base +
> >>  					gart->page_count * GART_PAGE_SIZE - 1;
> >> -	gart_domain->domain.geometry.force_aperture =3D true;
> >> +		domain->geometry.force_aperture =3D true;
> >> +	}
> >> =20
> >> -	return &gart_domain->domain;
> >> +	return domain;
> >>  }
> >> =20
> >>  static void gart_iommu_domain_free(struct iommu_domain *domain)
> >>  {
> >> -	struct gart_domain *gart_domain =3D to_gart_domain(domain);
> >> -	struct gart_device *gart =3D gart_domain->gart;
> >> -
> >> -	if (gart) {
> >> -		spin_lock(&gart->client_lock);
> >> -		if (!list_empty(&gart->client)) {
> >> -			struct gart_client *c, *tmp;
> >> -
> >> -			list_for_each_entry_safe(c, tmp, &gart->client, list)
> >> -				__gart_iommu_detach_dev(domain, c->dev);
> >> -		}
> >> -		spin_unlock(&gart->client_lock);
> >> -	}
> >> -
> >> -	kfree(gart_domain);
> >> +	kfree(domain);
> >>  }
> >=20
> > Doesn't this now make it possible to free a potentially active domain?
>=20
> Yes, don't do it. I can add a WARN_ON() here, though I think IOMMU core
> should be the one taking care about that.

Yeah, might be good to have the WARN_ON() either here or in the IOMMU
core. Force-detaching is probably a good idea, too, otherwise the users
of the freed domain are just going to crash anyway, right? Maybe
something to discuss more generally with Joerg.

I think in the meantime just having the WARN_ON() here is probably good
enough. It should point out the cases where we do free the domain with
devices still attached, which hopefully don't exist, and we can fix
them.

> >>  static int gart_iommu_map(struct iommu_domain *domain, unsigned long =
iova,
> >>  			  phys_addr_t pa, size_t bytes, int prot)
> >>  {
> >> -	struct gart_domain *gart_domain =3D to_gart_domain(domain);
> >> -	struct gart_device *gart =3D gart_domain->gart;
> >> +	struct gart_device *gart =3D gart_handle;
> >=20
> > Hmm... this now introduces more uses of the gart_handle that I hoped we
> > could get rid of. I think we could still keep around struct gart_domain
> > and just make sure it is unique. The small amounts of casting here seem
> > mostly harmless to me, especially since they will be nops, so we end up
> > with just one dereference to get at the struct gart_device. I think the
> > benefits of not having this global variable around are worth the one
> > dereference here.
>=20
> What are the benefits? I don't see anything other than the pedantic oddit=
y.
>=20
> I've removed gart_domain in the end because it is an extra code (and
> consumed resources) without any benefit. Let's keep that part as it is
> now. I'll be happy to change that code if you'll explain why it is worth
> it.

I thought I did explain. Anyway, it's always been like this, so no need
to change it as part of this series.

Thierry

--2xzXx3ruJf7hsAzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluqCUUACgkQ3SOs138+
s6G/UQ/8Cq+keTTSr0rMlqLC763bG/Sn3T0KZZueywks0/aoZfeYxGRPirjdFr6S
E9FzVgtboWpm9x4PxcOdzItx+Q6GNgWLVTLacFBAEYbOTejEyMZZDrh0J3lo6qch
yCsNoyhoATwPoQEqZiusngtccszUGzfMwBaoax+NI9l54Cec7OXL8VDo/O01LYf+
S9ej8RAdN29XF88RhMK8QTFU8AM0ykG5CoQw1scVBF9h3KgS5dMUttQAbznvK3xH
TbVDSLbGhS6NNiB8YbrTkvq0fi2l1ftvJZikir46nFv6dYhKSSQ4PLAptIPASqNB
JiojoF5p0wqOQqEHHlNvXNC/pqIn6G+5nFAS1lMg9RyBhIG15QgGPzEPccGuLwEE
S2kk60e45V3MnkcRsdzVY2EMZ/knMXHs8Q1bcJmBDLkRhAnIFQsBiNKVOR5eeg28
YDO5i4PGLwZQjUTB8OUhyeaXURol6QQJ152NdJUD66YiSpKfWAFLHAml/LdOHPmv
V6qtQhECrJBRWtbJEPwnKyI77OyM80NU/z5lvrazInz0B90pSbS8FHBJYu37rC/3
r4FaREzk6tmY4tdo3H7hj30yoM+vrKBBreNr1iaBvKN4n70kq4yUps5LUAIRmFmS
dwLT5wkgjiUxStwzDp3IfQyIIH7hRx6NkYeEcPuHKXlMX8flqLQ=
=1iE+
-----END PGP SIGNATURE-----

--2xzXx3ruJf7hsAzo--

--===============2948423812985870407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2948423812985870407==--
