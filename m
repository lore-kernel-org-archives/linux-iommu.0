From: Craig Stein <stein12c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
Date: Thu, 8 Jun 2017 17:31:27 -0600
Message-ID: <CAEm5wM=sabfXZOpzAtcaSccvV0vtkTxGYEcozQqOTn+hXH4gOA@mail.gmail.com>
References: <20170605195203.11512.20579.stgit@tlendack-t1.amdoffice.net>
	<20170605195235.11512.52995.stgit@tlendack-t1.amdoffice.net>
	<MWHPR12MB15181A6A020ACA2F53DF70339CCB0@MWHPR12MB1518.namprd12.prod.outlook.com>
	<1496954035.4188.1.camel@rutgers.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4600268082826753358=="
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
To: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Cc: "Lendacky, Thomas" <Thomas.Lendacky-5C7GfCeVMHo@public.gmane.org>, "Nath,
	Arindam" <arindam.nath-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============4600268082826753358==
Content-Type: multipart/alternative; boundary="001a113fbc1277bbb805517b4024"

--001a113fbc1277bbb805517b4024
Content-Type: text/plain; charset="UTF-8"

I will test as soon as I can, just getting ready for summer vacation right
now

On Jun 8, 2017 14:34, "Jan Vesely" <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org> wrote:

> On Tue, 2017-06-06 at 10:02 +0000, Nath, Arindam wrote:
> > > -----Original Message-----
> > > From: Lendacky, Thomas
> > > Sent: Tuesday, June 06, 2017 1:23 AM
> > > To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > > Cc: Nath, Arindam <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>; Joerg Roedel
> > > <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>; Duran, Leo <leo.duran-5C7GfCeVMHo@public.gmane.org>; Suthikulpanit,
> > > Suravee <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> > > Subject: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
> > >
> > > After reducing the amount of MMIO performed by the IOMMU during
> > > operation,
> > > perf data shows that flushing the TLB for all protection domains during
> > > DMA unmapping is a performance issue. It is not necessary to flush the
> > > TLBs for all protection domains, only the protection domains associated
> > > with iova's on the flush queue.
> > >
> > > Create a separate queue that tracks the protection domains associated
> with
> > > the iova's on the flush queue. This new queue optimizes the flushing of
> > > TLBs to the required protection domains.
> > >
> > > Reviewed-by: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
> > > Signed-off-by: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
> > > ---
> > > drivers/iommu/amd_iommu.c |   56
> > > ++++++++++++++++++++++++++++++++++++++++-----
> > > 1 file changed, 50 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > > index 856103b..a5e77f0 100644
> > > --- a/drivers/iommu/amd_iommu.c
> > > +++ b/drivers/iommu/amd_iommu.c
> > > @@ -103,7 +103,18 @@ struct flush_queue {
> > >     struct flush_queue_entry *entries;
> > > };
> > >
> > > +struct flush_pd_queue_entry {
> > > +   struct protection_domain *pd;
> > > +};
> > > +
> > > +struct flush_pd_queue {
> > > +   /* No lock needed, protected by flush_queue lock */
> > > +   unsigned next;
> > > +   struct flush_pd_queue_entry *entries;
> > > +};
> > > +
> > > static DEFINE_PER_CPU(struct flush_queue, flush_queue);
> > > +static DEFINE_PER_CPU(struct flush_pd_queue, flush_pd_queue);
> > >
> > > static atomic_t queue_timer_on;
> > > static struct timer_list queue_timer;
> > > @@ -2227,16 +2238,20 @@ static struct iommu_group
> > > *amd_iommu_device_group(struct device *dev)
> > >  *
> > >
> > > ***********************************************************
> > > ******************/
> > >
> > > -static void __queue_flush(struct flush_queue *queue)
> > > +static void __queue_flush(struct flush_queue *queue,
> > > +                     struct flush_pd_queue *pd_queue)
> > > {
> > > -   struct protection_domain *domain;
> > >     unsigned long flags;
> > >     int idx;
> > >
> > >     /* First flush TLB of all known domains */
> > >     spin_lock_irqsave(&amd_iommu_pd_lock, flags);
> > > -   list_for_each_entry(domain, &amd_iommu_pd_list, list)
> > > -           domain_flush_tlb(domain);
> > > +   for (idx = 0; idx < pd_queue->next; ++idx) {
> > > +           struct flush_pd_queue_entry *entry;
> > > +
> > > +           entry = pd_queue->entries + idx;
> > > +           domain_flush_tlb(entry->pd);
> > > +   }
> > >     spin_unlock_irqrestore(&amd_iommu_pd_lock, flags);
> > >
> > >     /* Wait until flushes have completed */
> > > @@ -2255,6 +2270,7 @@ static void __queue_flush(struct flush_queue
> > > *queue)
> > >             entry->dma_dom = NULL;
> > >     }
> > >
> > > +   pd_queue->next = 0;
> > >     queue->next = 0;
> > > }
> > >
> > > @@ -2263,13 +2279,15 @@ static void queue_flush_all(void)
> > >     int cpu;
> > >
> > >     for_each_possible_cpu(cpu) {
> > > +           struct flush_pd_queue *pd_queue;
> > >             struct flush_queue *queue;
> > >             unsigned long flags;
> > >
> > >             queue = per_cpu_ptr(&flush_queue, cpu);
> > > +           pd_queue = per_cpu_ptr(&flush_pd_queue, cpu);
> > >             spin_lock_irqsave(&queue->lock, flags);
> > >             if (queue->next > 0)
> > > -                   __queue_flush(queue);
> > > +                   __queue_flush(queue, pd_queue);
> > >             spin_unlock_irqrestore(&queue->lock, flags);
> > >     }
> > > }
> > > @@ -2283,6 +2301,8 @@ static void queue_flush_timeout(unsigned long
> > > unsused)
> > > static void queue_add(struct dma_ops_domain *dma_dom,
> > >                   unsigned long address, unsigned long pages)
> > > {
> > > +   struct flush_pd_queue_entry *pd_entry;
> > > +   struct flush_pd_queue *pd_queue;
> > >     struct flush_queue_entry *entry;
> > >     struct flush_queue *queue;
> > >     unsigned long flags;
> > > @@ -2292,10 +2312,22 @@ static void queue_add(struct dma_ops_domain
> > > *dma_dom,
> > >     address >>= PAGE_SHIFT;
> > >
> > >     queue = get_cpu_ptr(&flush_queue);
> > > +   pd_queue = get_cpu_ptr(&flush_pd_queue);
> > >     spin_lock_irqsave(&queue->lock, flags);
> > >
> > >     if (queue->next == FLUSH_QUEUE_SIZE)
> > > -           __queue_flush(queue);
> > > +           __queue_flush(queue, pd_queue);
> > > +
> > > +   for (idx = 0; idx < pd_queue->next; ++idx) {
> > > +           pd_entry = pd_queue->entries + idx;
> > > +           if (pd_entry->pd == &dma_dom->domain)
> > > +                   break;
> > > +   }
> > > +   if (idx == pd_queue->next) {
> > > +           /* New protection domain, add it to the list */
> > > +           pd_entry = pd_queue->entries + pd_queue->next++;
> > > +           pd_entry->pd = &dma_dom->domain;
> > > +   }
> > >
> > >     idx   = queue->next++;
> > >     entry = queue->entries + idx;
> > > @@ -2309,6 +2341,7 @@ static void queue_add(struct dma_ops_domain
> > > *dma_dom,
> > >     if (atomic_cmpxchg(&queue_timer_on, 0, 1) == 0)
> > >             mod_timer(&queue_timer, jiffies + msecs_to_jiffies(10));
> > >
> > > +   put_cpu_ptr(&flush_pd_queue);
> > >     put_cpu_ptr(&flush_queue);
> > > }
> > >
> > > @@ -2810,6 +2843,8 @@ int __init amd_iommu_init_api(void)
> > >             return ret;
> > >
> > >     for_each_possible_cpu(cpu) {
> > > +           struct flush_pd_queue *pd_queue =
> > > per_cpu_ptr(&flush_pd_queue,
> > > +                                                         cpu);
> > >             struct flush_queue *queue = per_cpu_ptr(&flush_queue,
> > > cpu);
> > >
> > >             queue->entries = kzalloc(FLUSH_QUEUE_SIZE *
> > > @@ -2819,6 +2854,12 @@ int __init amd_iommu_init_api(void)
> > >                     goto out_put_iova;
> > >
> > >             spin_lock_init(&queue->lock);
> > > +
> > > +           pd_queue->entries = kzalloc(FLUSH_QUEUE_SIZE *
> > > +                                       sizeof(*pd_queue->entries),
> > > +                                       GFP_KERNEL);
> > > +           if (!pd_queue->entries)
> > > +                   goto out_put_iova;
> > >     }
> > >
> > >     err = bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
> > > @@ -2836,9 +2877,12 @@ int __init amd_iommu_init_api(void)
> > >
> > > out_put_iova:
> > >     for_each_possible_cpu(cpu) {
> > > +           struct flush_pd_queue *pd_queue =
> > > per_cpu_ptr(&flush_pd_queue,
> > > +                                                         cpu);
> > >             struct flush_queue *queue = per_cpu_ptr(&flush_queue,
> > > cpu);
> > >
> > >             kfree(queue->entries);
> > > +           kfree(pd_queue->entries);
> > >     }
> > >
> > >     return -ENOMEM;
> >
> > Craig and Jan, can you please confirm whether this patch fixes the
> > IOMMU timeout errors you encountered before? If it does, then this is
> > a better implementation of the fix I provided few weeks back.
>
> I have only remote access to the machine, so I won't be able to test
> until June 22nd.
>
> Jan
>
> >
> > Thanks,
> > Arindam
>
> --
> Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>

--001a113fbc1277bbb805517b4024
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I will test as soon as I can, just getting ready for summ=
er vacation right now</div><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Jun 8, 2017 14:34, &quot;Jan Vesely&quot; &lt;<a href=3D"mailt=
o:jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org">jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org</a>&gt; wrote:<br type=3D"=
attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On Tue, 2017-06-06 at 10:02 +00=
00, Nath, Arindam wrote:<br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: Lendacky, Thomas<br>
&gt; &gt; Sent: Tuesday, June 06, 2017 1:23 AM<br>
&gt; &gt; To: <a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu@lis=
ts.linux-foundation.<wbr>org</a><br>
&gt; &gt; Cc: Nath, Arindam &lt;<a href=3D"mailto:Arindam.Nath-5C7GfCeVMHo@public.gmane.org">Ari=
ndam.Nath-5C7GfCeVMHo@public.gmane.org</a>&gt;; Joerg Roedel<br>
&gt; &gt; &lt;<a href=3D"mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org">joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org</a>&gt;; D=
uran, Leo &lt;<a href=3D"mailto:leo.duran-5C7GfCeVMHo@public.gmane.org">leo.duran-5C7GfCeVMHo@public.gmane.org</a>&gt=
;; Suthikulpanit,<br>
&gt; &gt; Suravee &lt;<a href=3D"mailto:Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org">Sura=
vee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org</a><wbr>&gt;<br>
&gt; &gt; Subject: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush=
<br>
&gt; &gt;<br>
&gt; &gt; After reducing the amount of MMIO performed by the IOMMU during<b=
r>
&gt; &gt; operation,<br>
&gt; &gt; perf data shows that flushing the TLB for all protection domains =
during<br>
&gt; &gt; DMA unmapping is a performance issue. It is not necessary to flus=
h the<br>
&gt; &gt; TLBs for all protection domains, only the protection domains asso=
ciated<br>
&gt; &gt; with iova&#39;s on the flush queue.<br>
&gt; &gt;<br>
&gt; &gt; Create a separate queue that tracks the protection domains associ=
ated with<br>
&gt; &gt; the iova&#39;s on the flush queue. This new queue optimizes the f=
lushing of<br>
&gt; &gt; TLBs to the required protection domains.<br>
&gt; &gt;<br>
&gt; &gt; Reviewed-by: Arindam Nath &lt;<a href=3D"mailto:arindam.nath@amd.=
com">arindam.nath-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; &gt; Signed-off-by: Tom Lendacky &lt;<a href=3D"mailto:thomas.lendacky=
@amd.com">thomas.lendacky-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; drivers/iommu/amd_iommu.c |=C2=A0 =C2=A056<br>
&gt; &gt; ++++++++++++++++++++++++++++++<wbr>++++++++++-----<br>
&gt; &gt; 1 file changed, 50 insertions(+), 6 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.=
c<br>
&gt; &gt; index 856103b..a5e77f0 100644<br>
&gt; &gt; --- a/drivers/iommu/amd_iommu.c<br>
&gt; &gt; +++ b/drivers/iommu/amd_iommu.c<br>
&gt; &gt; @@ -103,7 +103,18 @@ struct flush_queue {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0struct flush_queue_entry *entries;<br>
&gt; &gt; };<br>
&gt; &gt;<br>
&gt; &gt; +struct flush_pd_queue_entry {<br>
&gt; &gt; +=C2=A0 =C2=A0struct protection_domain *pd;<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt; +struct flush_pd_queue {<br>
&gt; &gt; +=C2=A0 =C2=A0/* No lock needed, protected by flush_queue lock */=
<br>
&gt; &gt; +=C2=A0 =C2=A0unsigned next;<br>
&gt; &gt; +=C2=A0 =C2=A0struct flush_pd_queue_entry *entries;<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt; static DEFINE_PER_CPU(struct flush_queue, flush_queue);<br>
&gt; &gt; +static DEFINE_PER_CPU(struct flush_pd_queue, flush_pd_queue);<br=
>
&gt; &gt;<br>
&gt; &gt; static atomic_t queue_timer_on;<br>
&gt; &gt; static struct timer_list queue_timer;<br>
&gt; &gt; @@ -2227,16 +2238,20 @@ static struct iommu_group<br>
&gt; &gt; *amd_iommu_device_group(struct device *dev)<br>
&gt; &gt;=C2=A0 *<br>
&gt; &gt;<br>
&gt; &gt; ******************************<wbr>*****************************<=
br>
&gt; &gt; ******************/<br>
&gt; &gt;<br>
&gt; &gt; -static void __queue_flush(struct flush_queue *queue)<br>
&gt; &gt; +static void __queue_flush(struct flush_queue *queue,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0struct flush_pd_queue *pd_queue)<br>
&gt; &gt; {<br>
&gt; &gt; -=C2=A0 =C2=A0struct protection_domain *domain;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0int idx;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0/* First flush TLB of all known domains */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;amd_iommu_<wbr>pd_lock,=
 flags);<br>
&gt; &gt; -=C2=A0 =C2=A0list_for_each_entry(domain, &amp;amd_iommu_pd_list,=
 list)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0domain_flush_tlb(domain=
);<br>
&gt; &gt; +=C2=A0 =C2=A0for (idx =3D 0; idx &lt; pd_queue-&gt;next; ++idx) =
{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct flush_pd_queue_e=
ntry *entry;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry =3D pd_queue-&gt;=
entries + idx;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0domain_flush_tlb(entry-=
&gt;pd);<br>
&gt; &gt; +=C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;amd_<wbr>iommu_pd_=
lock, flags);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0/* Wait until flushes have completed */<br>
&gt; &gt; @@ -2255,6 +2270,7 @@ static void __queue_flush(struct flush_queu=
e<br>
&gt; &gt; *queue)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;dma_dom =
=3D NULL;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0pd_queue-&gt;next =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0queue-&gt;next =3D 0;<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt; @@ -2263,13 +2279,15 @@ static void queue_flush_all(void)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0int cpu;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0for_each_possible_cpu(cpu) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct flush_pd_queue *=
pd_queue;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct flush_queue=
 *queue;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flag=
s;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queue =3D per_cpu_=
ptr(&amp;flush_queue, cpu);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pd_queue =3D per_cpu_pt=
r(&amp;flush_pd_queue, cpu);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(=
&amp;queue-&gt;<wbr>lock, flags);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (queue-&gt;next=
 &gt; 0)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0__queue_flush(queue);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0__queue_flush(queue, pd_queue);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqres=
tore(&amp;queue-<wbr>&gt;lock, flags);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; }<br>
&gt; &gt; @@ -2283,6 +2301,8 @@ static void queue_flush_timeout(unsigned lo=
ng<br>
&gt; &gt; unsused)<br>
&gt; &gt; static void queue_add(struct dma_ops_domain *dma_dom,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0unsigned long address, unsigned long pages)<br>
&gt; &gt; {<br>
&gt; &gt; +=C2=A0 =C2=A0struct flush_pd_queue_entry *pd_entry;<br>
&gt; &gt; +=C2=A0 =C2=A0struct flush_pd_queue *pd_queue;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0struct flush_queue_entry *entry;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0struct flush_queue *queue;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
&gt; &gt; @@ -2292,10 +2312,22 @@ static void queue_add(struct dma_ops_doma=
in<br>
&gt; &gt; *dma_dom,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0address &gt;&gt;=3D PAGE_SHIFT;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0queue =3D get_cpu_ptr(&amp;flush_queue);<br>
&gt; &gt; +=C2=A0 =C2=A0pd_queue =3D get_cpu_ptr(&amp;flush_pd_queue);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;queue-&gt;<wbr>lock, fl=
ags);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0if (queue-&gt;next =3D=3D FLUSH_QUEUE_SIZE)<br=
>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__queue_flush(queue);<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__queue_flush(queue, pd=
_queue);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0for (idx =3D 0; idx &lt; pd_queue-&gt;next; ++idx) =
{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pd_entry =3D pd_queue-&=
gt;entries + idx;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pd_entry-&gt;pd =3D=
=3D &amp;dma_dom-&gt;domain)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0break;<br>
&gt; &gt; +=C2=A0 =C2=A0}<br>
&gt; &gt; +=C2=A0 =C2=A0if (idx =3D=3D pd_queue-&gt;next) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* New protection domai=
n, add it to the list */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pd_entry =3D pd_queue-&=
gt;entries + pd_queue-&gt;next++;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pd_entry-&gt;pd =3D &am=
p;dma_dom-&gt;domain;<br>
&gt; &gt; +=C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0idx=C2=A0 =C2=A0=3D queue-&gt;next++;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0entry =3D queue-&gt;entries + idx;<br>
&gt; &gt; @@ -2309,6 +2341,7 @@ static void queue_add(struct dma_ops_domain=
<br>
&gt; &gt; *dma_dom,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0if (atomic_cmpxchg(&amp;queue_timer_<wbr>on, 0=
, 1) =3D=3D 0)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mod_timer(&amp;que=
ue_timer, jiffies + msecs_to_jiffies(10));<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0put_cpu_ptr(&amp;flush_pd_queue);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0put_cpu_ptr(&amp;flush_queue);<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt; @@ -2810,6 +2843,8 @@ int __init amd_iommu_init_api(void)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0for_each_possible_cpu(cpu) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct flush_pd_queue *=
pd_queue =3D<br>
&gt; &gt; per_cpu_ptr(&amp;flush_pd_queue,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct flush_queue=
 *queue =3D per_cpu_ptr(&amp;flush_queue,<br>
&gt; &gt; cpu);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queue-&gt;entries =
=3D kzalloc(FLUSH_QUEUE_SIZE *<br>
&gt; &gt; @@ -2819,6 +2854,12 @@ int __init amd_iommu_init_api(void)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto out_put_iova;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_init(&am=
p;queue-&gt;lock);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pd_queue-&gt;entries =
=3D kzalloc(FLUSH_QUEUE_SIZE *<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0sizeof(*pd_queue-&gt;entries),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0GFP_KERNEL);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pd_queue-&gt;entri=
es)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0goto out_put_iova;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0err =3D bus_set_iommu(&amp;pci_bus_type, &amp;=
amd_iommu_ops);<br>
&gt; &gt; @@ -2836,9 +2877,12 @@ int __init amd_iommu_init_api(void)<br>
&gt; &gt;<br>
&gt; &gt; out_put_iova:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0for_each_possible_cpu(cpu) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct flush_pd_queue *=
pd_queue =3D<br>
&gt; &gt; per_cpu_ptr(&amp;flush_pd_queue,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct flush_queue=
 *queue =3D per_cpu_ptr(&amp;flush_queue,<br>
&gt; &gt; cpu);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(queue-&gt;en=
tries);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(pd_queue-&gt;entr=
ies);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt;<br>
&gt; Craig and Jan, can=C2=A0you please=C2=A0confirm whether this patch fix=
es the<br>
&gt; IOMMU timeout errors you encountered before? If it does, then this is<=
br>
&gt; a better implementation of the fix I provided few weeks back.<br>
<br>
I have only remote access to the machine, so I won&#39;t be able to test<br=
>
until June 22nd.<br>
<br>
Jan<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Arindam<br>
<br>
--<br>
Jan Vesely &lt;<a href=3D"mailto:jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org">jan.vesely@rutgers=
.edu</a>&gt;</blockquote></div></div>

--001a113fbc1277bbb805517b4024--

--===============4600268082826753358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4600268082826753358==--
