From: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Subject: Re: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
Date: Wed, 21 Jun 2017 12:20:18 -0400
Message-ID: <1498062018.17007.6.camel@rutgers.edu>
References: <20170605195203.11512.20579.stgit@tlendack-t1.amdoffice.net>
	<20170605195235.11512.52995.stgit@tlendack-t1.amdoffice.net>
	<MWHPR12MB15181A6A020ACA2F53DF70339CCB0@MWHPR12MB1518.namprd12.prod.outlook.com>
	<1496954035.4188.1.camel@rutgers.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2387508923836133276=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1496954035.4188.1.camel-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Nath, Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>, Craig Stein <stein12c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Lendacky, Thomas" <Thomas.Lendacky-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============2387508923836133276==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-/mZIvoDg6uIyPZgVZhDs"


--=-/mZIvoDg6uIyPZgVZhDs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arindam,

has this patch been replaced by Joerg's "[PATCH 0/7] iommu/amd:
Optimize iova queue flushing" series?

Jan

On Thu, 2017-06-08 at 22:33 +0200, Jan Vesely wrote:
> On Tue, 2017-06-06 at 10:02 +0000, Nath, Arindam wrote:
> > > -----Original Message-----
> > > From: Lendacky, Thomas
> > > Sent: Tuesday, June 06, 2017 1:23 AM
> > > To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > > Cc: Nath, Arindam <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>; Joerg Roedel
> > > <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>; Duran, Leo <leo.duran-5C7GfCeVMHo@public.gmane.org>; Suthikulpanit,
> > > Suravee <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> > > Subject: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
> > >=20
> > > After reducing the amount of MMIO performed by the IOMMU during
> > > operation,
> > > perf data shows that flushing the TLB for all protection domains duri=
ng
> > > DMA unmapping is a performance issue. It is not necessary to flush th=
e
> > > TLBs for all protection domains, only the protection domains associat=
ed
> > > with iova's on the flush queue.
> > >=20
> > > Create a separate queue that tracks the protection domains associated=
 with
> > > the iova's on the flush queue. This new queue optimizes the flushing =
of
> > > TLBs to the required protection domains.
> > >=20
> > > Reviewed-by: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
> > > Signed-off-by: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
> > > ---
> > > drivers/iommu/amd_iommu.c |   56
> > > ++++++++++++++++++++++++++++++++++++++++-----
> > > 1 file changed, 50 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > > index 856103b..a5e77f0 100644
> > > --- a/drivers/iommu/amd_iommu.c
> > > +++ b/drivers/iommu/amd_iommu.c
> > > @@ -103,7 +103,18 @@ struct flush_queue {
> > > 	struct flush_queue_entry *entries;
> > > };
> > >=20
> > > +struct flush_pd_queue_entry {
> > > +	struct protection_domain *pd;
> > > +};
> > > +
> > > +struct flush_pd_queue {
> > > +	/* No lock needed, protected by flush_queue lock */
> > > +	unsigned next;
> > > +	struct flush_pd_queue_entry *entries;
> > > +};
> > > +
> > > static DEFINE_PER_CPU(struct flush_queue, flush_queue);
> > > +static DEFINE_PER_CPU(struct flush_pd_queue, flush_pd_queue);
> > >=20
> > > static atomic_t queue_timer_on;
> > > static struct timer_list queue_timer;
> > > @@ -2227,16 +2238,20 @@ static struct iommu_group
> > > *amd_iommu_device_group(struct device *dev)
> > >  *
> > >=20
> > > ***********************************************************
> > > ******************/
> > >=20
> > > -static void __queue_flush(struct flush_queue *queue)
> > > +static void __queue_flush(struct flush_queue *queue,
> > > +			  struct flush_pd_queue *pd_queue)
> > > {
> > > -	struct protection_domain *domain;
> > > 	unsigned long flags;
> > > 	int idx;
> > >=20
> > > 	/* First flush TLB of all known domains */
> > > 	spin_lock_irqsave(&amd_iommu_pd_lock, flags);
> > > -	list_for_each_entry(domain, &amd_iommu_pd_list, list)
> > > -		domain_flush_tlb(domain);
> > > +	for (idx =3D 0; idx < pd_queue->next; ++idx) {
> > > +		struct flush_pd_queue_entry *entry;
> > > +
> > > +		entry =3D pd_queue->entries + idx;
> > > +		domain_flush_tlb(entry->pd);
> > > +	}
> > > 	spin_unlock_irqrestore(&amd_iommu_pd_lock, flags);
> > >=20
> > > 	/* Wait until flushes have completed */
> > > @@ -2255,6 +2270,7 @@ static void __queue_flush(struct flush_queue
> > > *queue)
> > > 		entry->dma_dom =3D NULL;
> > > 	}
> > >=20
> > > +	pd_queue->next =3D 0;
> > > 	queue->next =3D 0;
> > > }
> > >=20
> > > @@ -2263,13 +2279,15 @@ static void queue_flush_all(void)
> > > 	int cpu;
> > >=20
> > > 	for_each_possible_cpu(cpu) {
> > > +		struct flush_pd_queue *pd_queue;
> > > 		struct flush_queue *queue;
> > > 		unsigned long flags;
> > >=20
> > > 		queue =3D per_cpu_ptr(&flush_queue, cpu);
> > > +		pd_queue =3D per_cpu_ptr(&flush_pd_queue, cpu);
> > > 		spin_lock_irqsave(&queue->lock, flags);
> > > 		if (queue->next > 0)
> > > -			__queue_flush(queue);
> > > +			__queue_flush(queue, pd_queue);
> > > 		spin_unlock_irqrestore(&queue->lock, flags);
> > > 	}
> > > }
> > > @@ -2283,6 +2301,8 @@ static void queue_flush_timeout(unsigned long
> > > unsused)
> > > static void queue_add(struct dma_ops_domain *dma_dom,
> > > 		      unsigned long address, unsigned long pages)
> > > {
> > > +	struct flush_pd_queue_entry *pd_entry;
> > > +	struct flush_pd_queue *pd_queue;
> > > 	struct flush_queue_entry *entry;
> > > 	struct flush_queue *queue;
> > > 	unsigned long flags;
> > > @@ -2292,10 +2312,22 @@ static void queue_add(struct dma_ops_domain
> > > *dma_dom,
> > > 	address >>=3D PAGE_SHIFT;
> > >=20
> > > 	queue =3D get_cpu_ptr(&flush_queue);
> > > +	pd_queue =3D get_cpu_ptr(&flush_pd_queue);
> > > 	spin_lock_irqsave(&queue->lock, flags);
> > >=20
> > > 	if (queue->next =3D=3D FLUSH_QUEUE_SIZE)
> > > -		__queue_flush(queue);
> > > +		__queue_flush(queue, pd_queue);
> > > +
> > > +	for (idx =3D 0; idx < pd_queue->next; ++idx) {
> > > +		pd_entry =3D pd_queue->entries + idx;
> > > +		if (pd_entry->pd =3D=3D &dma_dom->domain)
> > > +			break;
> > > +	}
> > > +	if (idx =3D=3D pd_queue->next) {
> > > +		/* New protection domain, add it to the list */
> > > +		pd_entry =3D pd_queue->entries + pd_queue->next++;
> > > +		pd_entry->pd =3D &dma_dom->domain;
> > > +	}
> > >=20
> > > 	idx   =3D queue->next++;
> > > 	entry =3D queue->entries + idx;
> > > @@ -2309,6 +2341,7 @@ static void queue_add(struct dma_ops_domain
> > > *dma_dom,
> > > 	if (atomic_cmpxchg(&queue_timer_on, 0, 1) =3D=3D 0)
> > > 		mod_timer(&queue_timer, jiffies + msecs_to_jiffies(10));
> > >=20
> > > +	put_cpu_ptr(&flush_pd_queue);
> > > 	put_cpu_ptr(&flush_queue);
> > > }
> > >=20
> > > @@ -2810,6 +2843,8 @@ int __init amd_iommu_init_api(void)
> > > 		return ret;
> > >=20
> > > 	for_each_possible_cpu(cpu) {
> > > +		struct flush_pd_queue *pd_queue =3D
> > > per_cpu_ptr(&flush_pd_queue,
> > > +							      cpu);
> > > 		struct flush_queue *queue =3D per_cpu_ptr(&flush_queue,
> > > cpu);
> > >=20
> > > 		queue->entries =3D kzalloc(FLUSH_QUEUE_SIZE *
> > > @@ -2819,6 +2854,12 @@ int __init amd_iommu_init_api(void)
> > > 			goto out_put_iova;
> > >=20
> > > 		spin_lock_init(&queue->lock);
> > > +
> > > +		pd_queue->entries =3D kzalloc(FLUSH_QUEUE_SIZE *
> > > +					    sizeof(*pd_queue->entries),
> > > +					    GFP_KERNEL);
> > > +		if (!pd_queue->entries)
> > > +			goto out_put_iova;
> > > 	}
> > >=20
> > > 	err =3D bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
> > > @@ -2836,9 +2877,12 @@ int __init amd_iommu_init_api(void)
> > >=20
> > > out_put_iova:
> > > 	for_each_possible_cpu(cpu) {
> > > +		struct flush_pd_queue *pd_queue =3D
> > > per_cpu_ptr(&flush_pd_queue,
> > > +							      cpu);
> > > 		struct flush_queue *queue =3D per_cpu_ptr(&flush_queue,
> > > cpu);
> > >=20
> > > 		kfree(queue->entries);
> > > +		kfree(pd_queue->entries);
> > > 	}
> > >=20
> > > 	return -ENOMEM;
> >=20
> > Craig and Jan, can=C2=A0you please=C2=A0confirm whether this patch fixe=
s the
> > IOMMU timeout errors you encountered before? If it does, then this is
> > a better implementation of the fix I provided few weeks back.
>=20
> I have only remote access to the machine, so I won't be able to test
> until June 22nd.
>=20
> Jan
>=20
> >=20
> > Thanks,
> > Arindam
>=20
>=20

--=-/mZIvoDg6uIyPZgVZhDs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJZSpzCAAoJEGPjP7c/SLIgeAcP/11NGu1O6SaLEdpy1TjAqFvx
aAY1BpKG+IQqXE/R3R+8VwTSGaYPrQ0GK5sjnqu4qIZXRcp4vJ3mUj5BX6QMWq7e
wI6zDvjVnCgztEJ85iHXSC97r99fTOxq+kmpJLd4QJhuazPm7gmE4CUgzpWYaI8y
4G+1bz4W1msGqruo1w9yEyMCW4sszIejLkEAXIX5/WxW3s8kvj0KILlwy2DQMq6U
ym1POjq6t/T6VD8K8ymwyE3qyfDAMg3JsnSCoGmfAhHmmLltU5212St4NaHtklt5
p7bmLZUda6yl0g90WRIobxVqntl4XRZboKJJUp8ckXW+IbYAhRAdO7RKENN6lz0a
zod1BMua7a7B9MpZY3pl4cl6xpwH9U7MZb0x0JIewE413keF/6CZi0MTjovKPLbT
bPisLAobi0eVpSnQ78ePuAeQmYUHB3BVUu3g/DZ3Pu+x7sZ/MNAC4q+vPuYwQ3IM
SsKA4fJtQKiu3JqpzYbOcA+tHT8vhLHyaMehj6hCeTQbpcnZWNpvKVAfnC7TwGsI
55TY+fKnxOZLaewWemJ45W3wq3jqzYMrlvUrUS1BhCf2gGy+E4ZQ1KFSt4u9uU+G
VJdh4HuTYmyyNKw/xxd1QSu5tEQJqtDPLCbWI3jYm5HIwwzchiZOj3KfjKDf03sI
nIDoXm/Y3HnWLgK0+hZa
=AtBb
-----END PGP SIGNATURE-----

--=-/mZIvoDg6uIyPZgVZhDs--


--===============2387508923836133276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2387508923836133276==--
