From: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Subject: Re: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
Date: Wed, 21 Jun 2017 17:09:31 -0400
Message-ID: <1498079371.17007.18.camel@rutgers.edu>
References: <20170605195203.11512.20579.stgit@tlendack-t1.amdoffice.net>
	<20170605195235.11512.52995.stgit@tlendack-t1.amdoffice.net>
	<MWHPR12MB15181A6A020ACA2F53DF70339CCB0@MWHPR12MB1518.namprd12.prod.outlook.com>
	<1496954035.4188.1.camel@rutgers.edu>
	<1498062018.17007.6.camel@rutgers.edu>
	<bf685f44-019c-4c21-25d4-6a6ea647b7cc@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2472741425807392271=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <bf685f44-019c-4c21-25d4-6a6ea647b7cc-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, "Nath, Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>, Craig Stein <stein12c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============2472741425807392271==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-HZrnS4cmNgTz5lygLik3"


--=-HZrnS4cmNgTz5lygLik3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2017-06-21 at 12:01 -0500, Tom Lendacky wrote:
> On 6/21/2017 11:20 AM, Jan Vesely wrote:
> > Hi Arindam,
> >=20
> > has this patch been replaced by Joerg's "[PATCH 0/7] iommu/amd:
> > Optimize iova queue flushing" series?
>=20
> Yes, Joerg's patches replaced this patch.  He applied just the first two
> patches of this series.

Joerg's patches applied on top of 4.10.17 do not solve my issue (do I
need the first two patches of this series?). the machine still hangs on
boot with a flood of IOMMU wait loop timed out messages.

on the other hand patch 3/3 v1 applied on top of 4.10.17 fixes the
problem and the machine boots successfully

regards,
Jan


>=20
> Thanks,
> Tom
>=20
> >=20
> > Jan
> >=20
> > On Thu, 2017-06-08 at 22:33 +0200, Jan Vesely wrote:
> > > On Tue, 2017-06-06 at 10:02 +0000, Nath, Arindam wrote:
> > > > > -----Original Message-----
> > > > > From: Lendacky, Thomas
> > > > > Sent: Tuesday, June 06, 2017 1:23 AM
> > > > > To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > > > > Cc: Nath, Arindam <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>; Joerg Roedel
> > > > > <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>; Duran, Leo <leo.duran-5C7GfCeVMHo@public.gmane.org>; Suthikulpanit,
> > > > > Suravee <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> > > > > Subject: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
> > > > >=20
> > > > > After reducing the amount of MMIO performed by the IOMMU during
> > > > > operation,
> > > > > perf data shows that flushing the TLB for all protection domains =
during
> > > > > DMA unmapping is a performance issue. It is not necessary to flus=
h the
> > > > > TLBs for all protection domains, only the protection domains asso=
ciated
> > > > > with iova's on the flush queue.
> > > > >=20
> > > > > Create a separate queue that tracks the protection domains associ=
ated with
> > > > > the iova's on the flush queue. This new queue optimizes the flush=
ing of
> > > > > TLBs to the required protection domains.
> > > > >=20
> > > > > Reviewed-by: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
> > > > > Signed-off-by: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
> > > > > ---
> > > > > drivers/iommu/amd_iommu.c |   56
> > > > > ++++++++++++++++++++++++++++++++++++++++-----
> > > > > 1 file changed, 50 insertions(+), 6 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.=
c
> > > > > index 856103b..a5e77f0 100644
> > > > > --- a/drivers/iommu/amd_iommu.c
> > > > > +++ b/drivers/iommu/amd_iommu.c
> > > > > @@ -103,7 +103,18 @@ struct flush_queue {
> > > > > 	struct flush_queue_entry *entries;
> > > > > };
> > > > >=20
> > > > > +struct flush_pd_queue_entry {
> > > > > +	struct protection_domain *pd;
> > > > > +};
> > > > > +
> > > > > +struct flush_pd_queue {
> > > > > +	/* No lock needed, protected by flush_queue lock */
> > > > > +	unsigned next;
> > > > > +	struct flush_pd_queue_entry *entries;
> > > > > +};
> > > > > +
> > > > > static DEFINE_PER_CPU(struct flush_queue, flush_queue);
> > > > > +static DEFINE_PER_CPU(struct flush_pd_queue, flush_pd_queue);
> > > > >=20
> > > > > static atomic_t queue_timer_on;
> > > > > static struct timer_list queue_timer;
> > > > > @@ -2227,16 +2238,20 @@ static struct iommu_group
> > > > > *amd_iommu_device_group(struct device *dev)
> > > > >   *
> > > > >=20
> > > > > ***********************************************************
> > > > > ******************/
> > > > >=20
> > > > > -static void __queue_flush(struct flush_queue *queue)
> > > > > +static void __queue_flush(struct flush_queue *queue,
> > > > > +			  struct flush_pd_queue *pd_queue)
> > > > > {
> > > > > -	struct protection_domain *domain;
> > > > > 	unsigned long flags;
> > > > > 	int idx;
> > > > >=20
> > > > > 	/* First flush TLB of all known domains */
> > > > > 	spin_lock_irqsave(&amd_iommu_pd_lock, flags);
> > > > > -	list_for_each_entry(domain, &amd_iommu_pd_list, list)
> > > > > -		domain_flush_tlb(domain);
> > > > > +	for (idx =3D 0; idx < pd_queue->next; ++idx) {
> > > > > +		struct flush_pd_queue_entry *entry;
> > > > > +
> > > > > +		entry =3D pd_queue->entries + idx;
> > > > > +		domain_flush_tlb(entry->pd);
> > > > > +	}
> > > > > 	spin_unlock_irqrestore(&amd_iommu_pd_lock, flags);
> > > > >=20
> > > > > 	/* Wait until flushes have completed */
> > > > > @@ -2255,6 +2270,7 @@ static void __queue_flush(struct flush_queu=
e
> > > > > *queue)
> > > > > 		entry->dma_dom =3D NULL;
> > > > > 	}
> > > > >=20
> > > > > +	pd_queue->next =3D 0;
> > > > > 	queue->next =3D 0;
> > > > > }
> > > > >=20
> > > > > @@ -2263,13 +2279,15 @@ static void queue_flush_all(void)
> > > > > 	int cpu;
> > > > >=20
> > > > > 	for_each_possible_cpu(cpu) {
> > > > > +		struct flush_pd_queue *pd_queue;
> > > > > 		struct flush_queue *queue;
> > > > > 		unsigned long flags;
> > > > >=20
> > > > > 		queue =3D per_cpu_ptr(&flush_queue, cpu);
> > > > > +		pd_queue =3D per_cpu_ptr(&flush_pd_queue, cpu);
> > > > > 		spin_lock_irqsave(&queue->lock, flags);
> > > > > 		if (queue->next > 0)
> > > > > -			__queue_flush(queue);
> > > > > +			__queue_flush(queue, pd_queue);
> > > > > 		spin_unlock_irqrestore(&queue->lock, flags);
> > > > > 	}
> > > > > }
> > > > > @@ -2283,6 +2301,8 @@ static void queue_flush_timeout(unsigned lo=
ng
> > > > > unsused)
> > > > > static void queue_add(struct dma_ops_domain *dma_dom,
> > > > > 		      unsigned long address, unsigned long pages)
> > > > > {
> > > > > +	struct flush_pd_queue_entry *pd_entry;
> > > > > +	struct flush_pd_queue *pd_queue;
> > > > > 	struct flush_queue_entry *entry;
> > > > > 	struct flush_queue *queue;
> > > > > 	unsigned long flags;
> > > > > @@ -2292,10 +2312,22 @@ static void queue_add(struct dma_ops_doma=
in
> > > > > *dma_dom,
> > > > > 	address >>=3D PAGE_SHIFT;
> > > > >=20
> > > > > 	queue =3D get_cpu_ptr(&flush_queue);
> > > > > +	pd_queue =3D get_cpu_ptr(&flush_pd_queue);
> > > > > 	spin_lock_irqsave(&queue->lock, flags);
> > > > >=20
> > > > > 	if (queue->next =3D=3D FLUSH_QUEUE_SIZE)
> > > > > -		__queue_flush(queue);
> > > > > +		__queue_flush(queue, pd_queue);
> > > > > +
> > > > > +	for (idx =3D 0; idx < pd_queue->next; ++idx) {
> > > > > +		pd_entry =3D pd_queue->entries + idx;
> > > > > +		if (pd_entry->pd =3D=3D &dma_dom->domain)
> > > > > +			break;
> > > > > +	}
> > > > > +	if (idx =3D=3D pd_queue->next) {
> > > > > +		/* New protection domain, add it to the list */
> > > > > +		pd_entry =3D pd_queue->entries + pd_queue->next++;
> > > > > +		pd_entry->pd =3D &dma_dom->domain;
> > > > > +	}
> > > > >=20
> > > > > 	idx   =3D queue->next++;
> > > > > 	entry =3D queue->entries + idx;
> > > > > @@ -2309,6 +2341,7 @@ static void queue_add(struct dma_ops_domain
> > > > > *dma_dom,
> > > > > 	if (atomic_cmpxchg(&queue_timer_on, 0, 1) =3D=3D 0)
> > > > > 		mod_timer(&queue_timer, jiffies + msecs_to_jiffies(10));
> > > > >=20
> > > > > +	put_cpu_ptr(&flush_pd_queue);
> > > > > 	put_cpu_ptr(&flush_queue);
> > > > > }
> > > > >=20
> > > > > @@ -2810,6 +2843,8 @@ int __init amd_iommu_init_api(void)
> > > > > 		return ret;
> > > > >=20
> > > > > 	for_each_possible_cpu(cpu) {
> > > > > +		struct flush_pd_queue *pd_queue =3D
> > > > > per_cpu_ptr(&flush_pd_queue,
> > > > > +							      cpu);
> > > > > 		struct flush_queue *queue =3D per_cpu_ptr(&flush_queue,
> > > > > cpu);
> > > > >=20
> > > > > 		queue->entries =3D kzalloc(FLUSH_QUEUE_SIZE *
> > > > > @@ -2819,6 +2854,12 @@ int __init amd_iommu_init_api(void)
> > > > > 			goto out_put_iova;
> > > > >=20
> > > > > 		spin_lock_init(&queue->lock);
> > > > > +
> > > > > +		pd_queue->entries =3D kzalloc(FLUSH_QUEUE_SIZE *
> > > > > +					    sizeof(*pd_queue->entries),
> > > > > +					    GFP_KERNEL);
> > > > > +		if (!pd_queue->entries)
> > > > > +			goto out_put_iova;
> > > > > 	}
> > > > >=20
> > > > > 	err =3D bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
> > > > > @@ -2836,9 +2877,12 @@ int __init amd_iommu_init_api(void)
> > > > >=20
> > > > > out_put_iova:
> > > > > 	for_each_possible_cpu(cpu) {
> > > > > +		struct flush_pd_queue *pd_queue =3D
> > > > > per_cpu_ptr(&flush_pd_queue,
> > > > > +							      cpu);
> > > > > 		struct flush_queue *queue =3D per_cpu_ptr(&flush_queue,
> > > > > cpu);
> > > > >=20
> > > > > 		kfree(queue->entries);
> > > > > +		kfree(pd_queue->entries);
> > > > > 	}
> > > > >=20
> > > > > 	return -ENOMEM;
> > > >=20
> > > > Craig and Jan, can you please confirm whether this patch fixes the
> > > > IOMMU timeout errors you encountered before? If it does, then this =
is
> > > > a better implementation of the fix I provided few weeks back.
> > >=20
> > > I have only remote access to the machine, so I won't be able to test
> > > until June 22nd.
> > >=20
> > > Jan
> > >=20
> > > >=20
> > > > Thanks,
> > > > Arindam
> > >=20
> > >=20

--=-HZrnS4cmNgTz5lygLik3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJZSuCLAAoJEGPjP7c/SLIgqqkQALaKg/AuBzcxjZ/JwbDrReeV
NwXUS8tqPrChdBY+In+v8dT96Ybfg/kwgcepiu2arRVddCowPV76cChWJKb6F+62
A6XfIVPgGrK/7kcerLcyNidvnl9jhAEDFeSgModoR9bi/G4tcaZnhzUbsmmf1GIm
RR3bFjbW70fqcmbSnoQbC5IzT6UatTbgZ7X81B8vbPO5cJ7LIttW+rVZK38rv1Uw
q+/X3g1B4nkQtVwacDZBPJTB/reSt166VWm/j6sBbbAqEqy8/C3GXOJC9ZZHPA+z
fDRlu69AqNb0oCqCLZkkF15+g3JCc5ZJfLWg6ev8EI2xjE9SsbsS8QZuvbcrnU1H
710+IkX8YPHrlg4IpXtFq4TXDPmiM+OnIo2mW+JTPuwITHG/LXupTyXXLLmZYqDs
zV2/lJ8UQMJ/DvaM79cXyEy7P9YNnXG9S+Lbt0LTGb7+TWtwTYwHcp8slO5AGcxH
+6gNs2kkf3WbHPXUptoIZi90wiPu4WOH0Gl9hloycz0S+ylL2AvnMJRyr4+t17/E
swmMXRFe8i1qmKtAs5NcqYkOzOQsGW1T73eUaJialXMGVZZVFl7xnQvh6nQaJ99h
9kzsg0hsIJBe99l/oy0oZT/qRQAsMUj1afw+SWTUjJurPBltp6+4yuyC/zL14V/b
208LilT6ItrDjwwrOcoS
=aEz0
-----END PGP SIGNATURE-----

--=-HZrnS4cmNgTz5lygLik3--


--===============2472741425807392271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2472741425807392271==--
