From: Kai Huang <dev.kai.huang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch Part2 V1 03/14] iommu/vt-d: simplify function
	get_domain_for_dev()
Date: Wed, 8 Jan 2014 11:06:40 +0800
Message-ID: <CAOtp4KrK8yOktru+hgLSxYNZ67Nm2WYVGi2aGaJ3JJWLrdOq_g@mail.gmail.com>
References: <1389085234-22296-1-git-send-email-jiang.liu@linux.intel.com>
	<1389085234-22296-4-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7120826124548461151=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1389085234-22296-4-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============7120826124548461151==
Content-Type: multipart/alternative; boundary=001a113399b82ac35204ef6cc874

--001a113399b82ac35204ef6cc874
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jan 7, 2014 at 5:00 PM, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> Function get_domain_for_dev() is a little complex, simplify it
> by factoring out dmar_search_domain_by_dev_info() and
> dmar_insert_dev_info().
>
> Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c |  161
> ++++++++++++++++++++-----------------------
>  1 file changed, 75 insertions(+), 86 deletions(-)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 1704e97..da65884 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1957,18 +1957,70 @@ find_domain(struct pci_dev *pdev)
>         return NULL;
>  }
>
> +static inline struct dmar_domain *
> +dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
> +{
> +       struct device_domain_info *info;
> +
> +       list_for_each_entry(info, &device_domain_list, global)
> +               if (info->segment == segment && info->bus == bus &&
> +                   info->devfn == devfn)
> +                       return info->domain;
> +
> +       return NULL;
> +}
> +
> +static int dmar_insert_dev_info(int segment, int bus, int devfn,
> +                               struct pci_dev *dev, struct dmar_domain
> **domp)
> +{
> +       struct dmar_domain *found, *domain = *domp;
> +       struct device_domain_info *info;
> +       unsigned long flags;
> +
> +       info = alloc_devinfo_mem();
> +       if (!info)
> +               return -ENOMEM;
> +
> +       info->segment = segment;
> +       info->bus = bus;
> +       info->devfn = devfn;
> +       info->dev = dev;
> +       info->domain = domain;
> +       if (!dev)
> +               domain->flags |= DOMAIN_FLAG_P2P_MULTIPLE_DEVICES;
> +
> +       spin_lock_irqsave(&device_domain_lock, flags);
> +       if (dev)
> +               found = find_domain(dev);
> +       else
> +               found = dmar_search_domain_by_dev_info(segment, bus,
> devfn);
> +       if (found) {
> +               spin_unlock_irqrestore(&device_domain_lock, flags);
> +               free_devinfo_mem(info);
> +               if (found != domain) {
> +                       domain_exit(domain);
> +                       *domp = found;
> +               }
> +       } else {
> +               list_add(&info->link, &domain->devices);
> +               list_add(&info->global, &device_domain_list);
> +               if (dev)
> +                       dev->dev.archdata.iommu = info;
> +               spin_unlock_irqrestore(&device_domain_lock, flags);
> +       }
> +
> +       return 0;
> +}
>

I am a little bit confused about the "alloc before check" sequence in above
function. I believe the purpose of allocating the device_domain_info before
searching the domain with spin_lock hold is to avoid the memory allocation
in the spin_lock? In this case, why can't we use mutex instead of
spin_lock? In my understanding, if we use mutex, we can first check if the
domain exists or not before we really allocate device_domain_info, right?

Another question is when is info->iommu field initialized? Looks it is not
initialized here?

-Kai

+
>  /* domain is initialized */
>  static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int
> gaw)
>  {
> -       struct dmar_domain *domain, *found = NULL;
> +       struct dmar_domain *domain;
>         struct intel_iommu *iommu;
>         struct dmar_drhd_unit *drhd;
> -       struct device_domain_info *info, *tmp;
> -       struct pci_dev *dev_tmp;
> +       struct pci_dev *bridge;
>         unsigned long flags;
> -       int bus = 0, devfn = 0;
> -       int segment;
> -       int ret;
> +       int segment, bus, devfn;
>
>         domain = find_domain(pdev);
>         if (domain)
> @@ -1976,119 +2028,56 @@ static struct dmar_domain
> *get_domain_for_dev(struct pci_dev *pdev, int gaw)
>
>         segment = pci_domain_nr(pdev->bus);
>
> -       dev_tmp = pci_find_upstream_pcie_bridge(pdev);
> -       if (dev_tmp) {
> -               if (pci_is_pcie(dev_tmp)) {
> -                       bus = dev_tmp->subordinate->number;
> +       bridge = pci_find_upstream_pcie_bridge(pdev);
> +       if (bridge) {
> +               if (pci_is_pcie(bridge)) {
> +                       bus = bridge->subordinate->number;
>                         devfn = 0;
>                 } else {
> -                       bus = dev_tmp->bus->number;
> -                       devfn = dev_tmp->devfn;
> +                       bus = bridge->bus->number;
> +                       devfn = bridge->devfn;
>                 }
>                 spin_lock_irqsave(&device_domain_lock, flags);
> -               list_for_each_entry(info, &device_domain_list, global) {
> -                       if (info->segment == segment &&
> -                           info->bus == bus && info->devfn == devfn) {
> -                               found = info->domain;
> -                               break;
> -                       }
> -               }
> +               domain = dmar_search_domain_by_dev_info(segment, bus,
> devfn);
>                 spin_unlock_irqrestore(&device_domain_lock, flags);
>                 /* pcie-pci bridge already has a domain, uses it */
> -               if (found) {
> -                       domain = found;
> +               if (domain)
>                         goto found_domain;
> -               }
>         }
>
> -       domain = alloc_domain();
> -       if (!domain)
> -               goto error;
> -
> -       /* Allocate new domain for the device */
>         drhd = dmar_find_matched_drhd_unit(pdev);
>         if (!drhd) {
>                 printk(KERN_ERR "IOMMU: can't find DMAR for device %s\n",
>                         pci_name(pdev));
> -               free_domain_mem(domain);
>                 return NULL;
>         }
>         iommu = drhd->iommu;
>
> -       ret = iommu_attach_domain(domain, iommu);
> -       if (ret) {
> +       /* Allocate new domain for the device */
> +       domain = alloc_domain();
> +       if (!domain)
> +               goto error;
> +       if (iommu_attach_domain(domain, iommu)) {
>                 free_domain_mem(domain);
>                 goto error;
>         }
> -
>         if (domain_init(domain, gaw)) {
>                 domain_exit(domain);
>                 goto error;
>         }
>
>         /* register pcie-to-pci device */
> -       if (dev_tmp) {
> -               info = alloc_devinfo_mem();
> -               if (!info) {
> +       if (bridge) {
> +               if (dmar_insert_dev_info(segment, bus, devfn, NULL,
> &domain)) {
>                         domain_exit(domain);
>                         goto error;
>                 }
> -               info->segment = segment;
> -               info->bus = bus;
> -               info->devfn = devfn;
> -               info->dev = NULL;
> -               info->domain = domain;
> -               /* This domain is shared by devices under p2p bridge */
> -               domain->flags |= DOMAIN_FLAG_P2P_MULTIPLE_DEVICES;
> -
> -               /* pcie-to-pci bridge already has a domain, uses it */
> -               found = NULL;
> -               spin_lock_irqsave(&device_domain_lock, flags);
> -               list_for_each_entry(tmp, &device_domain_list, global) {
> -                       if (tmp->segment == segment &&
> -                           tmp->bus == bus && tmp->devfn == devfn) {
> -                               found = tmp->domain;
> -                               break;
> -                       }
> -               }
> -               if (found) {
> -                       spin_unlock_irqrestore(&device_domain_lock, flags);
> -                       free_devinfo_mem(info);
> -                       domain_exit(domain);
> -                       domain = found;
> -               } else {
> -                       list_add(&info->link, &domain->devices);
> -                       list_add(&info->global, &device_domain_list);
> -                       spin_unlock_irqrestore(&device_domain_lock, flags);
> -               }
>         }
>
>  found_domain:
> -       info = alloc_devinfo_mem();
> -       if (!info)
> -               goto error;
> -       info->segment = segment;
> -       info->bus = pdev->bus->number;
> -       info->devfn = pdev->devfn;
> -       info->dev = pdev;
> -       info->domain = domain;
> -       spin_lock_irqsave(&device_domain_lock, flags);
> -       /* somebody is fast */
> -       found = find_domain(pdev);
> -       if (found != NULL) {
> -               spin_unlock_irqrestore(&device_domain_lock, flags);
> -               if (found != domain) {
> -                       domain_exit(domain);
> -                       domain = found;
> -               }
> -               free_devinfo_mem(info);
> +       if (dmar_insert_dev_info(segment, pdev->bus->number, pdev->devfn,
> +                                pdev, &domain) == 0)
>                 return domain;
> -       }
> -       list_add(&info->link, &domain->devices);
> -       list_add(&info->global, &device_domain_list);
> -       pdev->dev.archdata.iommu = info;
> -       spin_unlock_irqrestore(&device_domain_lock, flags);
> -       return domain;
>  error:
>         /* recheck it here, maybe others set it */
>         return find_domain(pdev);
> --
> 1.7.10.4
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

--001a113399b82ac35204ef6cc874
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Tue, Jan 7, 2014 at 5:00 PM, Jiang Liu <span dir=3D"ltr">&lt;<a =
href=3D"mailto:jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" target=3D"_blank">jiang.liu@linux=
.intel.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Function get_domain_for_dev() is a little co=
mplex, simplify it<br>
by factoring out dmar_search_domain_by_dev_info() and<br>
dmar_insert_dev_info().<br>
<br>
Signed-off-by: Jiang Liu &lt;<a href=3D"mailto:jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org">j=
iang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org</a>&gt;<br>
---<br>
=A0drivers/iommu/intel-iommu.c | =A0161 ++++++++++++++++++++---------------=
--------<br>
=A01 file changed, 75 insertions(+), 86 deletions(-)<br>
<br>
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c<br>
index 1704e97..da65884 100644<br>
--- a/drivers/iommu/intel-iommu.c<br>
+++ b/drivers/iommu/intel-iommu.c<br>
@@ -1957,18 +1957,70 @@ find_domain(struct pci_dev *pdev)<br>
=A0 =A0 =A0 =A0 return NULL;<br>
=A0}<br>
<br>
+static inline struct dmar_domain *<br>
+dmar_search_domain_by_dev_info(int segment, int bus, int devfn)<br>
+{<br>
+ =A0 =A0 =A0 struct device_domain_info *info;<br>
+<br>
+ =A0 =A0 =A0 list_for_each_entry(info, &amp;device_domain_list, global)<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (info-&gt;segment =3D=3D segment &amp;&amp=
; info-&gt;bus =3D=3D bus &amp;&amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info-&gt;devfn =3D=3D devfn)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return info-&gt;domain;<br>
+<br>
+ =A0 =A0 =A0 return NULL;<br>
+}<br>
+<br>
+static int dmar_insert_dev_info(int segment, int bus, int devfn,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pci_de=
v *dev, struct dmar_domain **domp)<br>
+{<br>
+ =A0 =A0 =A0 struct dmar_domain *found, *domain =3D *domp;<br>
+ =A0 =A0 =A0 struct device_domain_info *info;<br>
+ =A0 =A0 =A0 unsigned long flags;<br>
+<br>
+ =A0 =A0 =A0 info =3D alloc_devinfo_mem();<br>
+ =A0 =A0 =A0 if (!info)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
+<br>
+ =A0 =A0 =A0 info-&gt;segment =3D segment;<br>
+ =A0 =A0 =A0 info-&gt;bus =3D bus;<br>
+ =A0 =A0 =A0 info-&gt;devfn =3D devfn;<br>
+ =A0 =A0 =A0 info-&gt;dev =3D dev;<br>
+ =A0 =A0 =A0 info-&gt;domain =3D domain;<br>
+ =A0 =A0 =A0 if (!dev)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 domain-&gt;flags |=3D DOMAIN_FLAG_P2P_MULTIPL=
E_DEVICES;<br>
+<br>
+ =A0 =A0 =A0 spin_lock_irqsave(&amp;device_domain_lock, flags);<br>
+ =A0 =A0 =A0 if (dev)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D find_domain(dev);<br>
+ =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D dmar_search_domain_by_dev_info(segm=
ent, bus, devfn);<br>
+ =A0 =A0 =A0 if (found) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;device_domain_loc=
k, flags);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_devinfo_mem(info);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (found !=3D domain) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 domain_exit(domain);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *domp =3D found;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add(&amp;info-&gt;link, &amp;domain-&gt;=
devices);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add(&amp;info-&gt;global, &amp;device_do=
main_list);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev-&gt;dev.archdata.iommu =
=3D info;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;device_domain_loc=
k, flags);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br></blockquote><div><br></div><div>I am a little bit confused about the=
 &quot;alloc before check&quot; sequence in above function. I believe the p=
urpose of allocating the device_domain_info before searching the domain wit=
h spin_lock hold is to avoid the memory allocation in the spin_lock? In thi=
s case, why can&#39;t we use mutex instead of spin_lock? In my understandin=
g, if we use mutex, we can first check if the domain exists or not before w=
e really allocate device_domain_info, right?</div>
<div><br></div><div>Another question is when is info-&gt;iommu field initia=
lized? Looks it is not initialized here?</div><div><br></div><div>-Kai</div=
><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">

+<br>
=A0/* domain is initialized */<br>
=A0static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int =
gaw)<br>
=A0{<br>
- =A0 =A0 =A0 struct dmar_domain *domain, *found =3D NULL;<br>
+ =A0 =A0 =A0 struct dmar_domain *domain;<br>
=A0 =A0 =A0 =A0 struct intel_iommu *iommu;<br>
=A0 =A0 =A0 =A0 struct dmar_drhd_unit *drhd;<br>
- =A0 =A0 =A0 struct device_domain_info *info, *tmp;<br>
- =A0 =A0 =A0 struct pci_dev *dev_tmp;<br>
+ =A0 =A0 =A0 struct pci_dev *bridge;<br>
=A0 =A0 =A0 =A0 unsigned long flags;<br>
- =A0 =A0 =A0 int bus =3D 0, devfn =3D 0;<br>
- =A0 =A0 =A0 int segment;<br>
- =A0 =A0 =A0 int ret;<br>
+ =A0 =A0 =A0 int segment, bus, devfn;<br>
<br>
=A0 =A0 =A0 =A0 domain =3D find_domain(pdev);<br>
=A0 =A0 =A0 =A0 if (domain)<br>
@@ -1976,119 +2028,56 @@ static struct dmar_domain *get_domain_for_dev(stru=
ct pci_dev *pdev, int gaw)<br>
<br>
=A0 =A0 =A0 =A0 segment =3D pci_domain_nr(pdev-&gt;bus);<br>
<br>
- =A0 =A0 =A0 dev_tmp =3D pci_find_upstream_pcie_bridge(pdev);<br>
- =A0 =A0 =A0 if (dev_tmp) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pci_is_pcie(dev_tmp)) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D dev_tmp-&gt;subordina=
te-&gt;number;<br>
+ =A0 =A0 =A0 bridge =3D pci_find_upstream_pcie_bridge(pdev);<br>
+ =A0 =A0 =A0 if (bridge) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pci_is_pcie(bridge)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D bridge-&gt;subordinat=
e-&gt;number;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfn =3D 0;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D dev_tmp-&gt;bus-&gt;n=
umber;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfn =3D dev_tmp-&gt;devfn;<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D bridge-&gt;bus-&gt;nu=
mber;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfn =3D bridge-&gt;devfn;<b=
r>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;device_domain_lock, =
flags);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(info, &amp;device_domain_=
list, global) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (info-&gt;segment =3D=3D s=
egment &amp;&amp;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info-&gt;bus =3D=3D b=
us &amp;&amp; info-&gt;devfn =3D=3D devfn) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D inf=
o-&gt;domain;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 domain =3D dmar_search_domain_by_dev_info(seg=
ment, bus, devfn);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;device_domain_l=
ock, flags);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* pcie-pci bridge already has a domain, us=
es it */<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (found) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 domain =3D found;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (domain)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto found_domain;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
=A0 =A0 =A0 =A0 }<br>
<br>
- =A0 =A0 =A0 domain =3D alloc_domain();<br>
- =A0 =A0 =A0 if (!domain)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;<br>
-<br>
- =A0 =A0 =A0 /* Allocate new domain for the device */<br>
=A0 =A0 =A0 =A0 drhd =3D dmar_find_matched_drhd_unit(pdev);<br>
=A0 =A0 =A0 =A0 if (!drhd) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR &quot;IOMMU: can&#39;t find=
 DMAR for device %s\n&quot;,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_name(pdev));<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_domain_mem(domain);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;<br>
=A0 =A0 =A0 =A0 }<br>
=A0 =A0 =A0 =A0 iommu =3D drhd-&gt;iommu;<br>
<br>
- =A0 =A0 =A0 ret =3D iommu_attach_domain(domain, iommu);<br>
- =A0 =A0 =A0 if (ret) {<br>
+ =A0 =A0 =A0 /* Allocate new domain for the device */<br>
+ =A0 =A0 =A0 domain =3D alloc_domain();<br>
+ =A0 =A0 =A0 if (!domain)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;<br>
+ =A0 =A0 =A0 if (iommu_attach_domain(domain, iommu)) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_domain_mem(domain);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;<br>
=A0 =A0 =A0 =A0 }<br>
-<br>
=A0 =A0 =A0 =A0 if (domain_init(domain, gaw)) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 domain_exit(domain);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;<br>
=A0 =A0 =A0 =A0 }<br>
<br>
=A0 =A0 =A0 =A0 /* register pcie-to-pci device */<br>
- =A0 =A0 =A0 if (dev_tmp) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 info =3D alloc_devinfo_mem();<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!info) {<br>
+ =A0 =A0 =A0 if (bridge) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dmar_insert_dev_info(segment, bus, devfn,=
 NULL, &amp;domain)) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 domain_exit(domain);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 info-&gt;segment =3D segment;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 info-&gt;bus =3D bus;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 info-&gt;devfn =3D devfn;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 info-&gt;dev =3D NULL;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 info-&gt;domain =3D domain;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* This domain is shared by devices under p2p=
 bridge */<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 domain-&gt;flags |=3D DOMAIN_FLAG_P2P_MULTIPL=
E_DEVICES;<br>
-<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* pcie-to-pci bridge already has a domain, u=
ses it */<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D NULL;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;device_domain_lock, fl=
ags);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(tmp, &amp;device_domain_l=
ist, global) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tmp-&gt;segment =3D=3D se=
gment &amp;&amp;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp-&gt;bus =3D=3D bu=
s &amp;&amp; tmp-&gt;devfn =3D=3D devfn) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D tmp=
-&gt;domain;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (found) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;d=
evice_domain_lock, flags);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_devinfo_mem(info);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 domain_exit(domain);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 domain =3D found;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add(&amp;info-&gt;link, =
&amp;domain-&gt;devices);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add(&amp;info-&gt;global=
, &amp;device_domain_list);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;d=
evice_domain_lock, flags);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
=A0 =A0 =A0 =A0 }<br>
<br>
=A0found_domain:<br>
- =A0 =A0 =A0 info =3D alloc_devinfo_mem();<br>
- =A0 =A0 =A0 if (!info)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;<br>
- =A0 =A0 =A0 info-&gt;segment =3D segment;<br>
- =A0 =A0 =A0 info-&gt;bus =3D pdev-&gt;bus-&gt;number;<br>
- =A0 =A0 =A0 info-&gt;devfn =3D pdev-&gt;devfn;<br>
- =A0 =A0 =A0 info-&gt;dev =3D pdev;<br>
- =A0 =A0 =A0 info-&gt;domain =3D domain;<br>
- =A0 =A0 =A0 spin_lock_irqsave(&amp;device_domain_lock, flags);<br>
- =A0 =A0 =A0 /* somebody is fast */<br>
- =A0 =A0 =A0 found =3D find_domain(pdev);<br>
- =A0 =A0 =A0 if (found !=3D NULL) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;device_domain_loc=
k, flags);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (found !=3D domain) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 domain_exit(domain);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 domain =3D found;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_devinfo_mem(info);<br>
+ =A0 =A0 =A0 if (dmar_insert_dev_info(segment, pdev-&gt;bus-&gt;number, pd=
ev-&gt;devfn,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdev, &amp=
;domain) =3D=3D 0)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return domain;<br>
- =A0 =A0 =A0 }<br>
- =A0 =A0 =A0 list_add(&amp;info-&gt;link, &amp;domain-&gt;devices);<br>
- =A0 =A0 =A0 list_add(&amp;info-&gt;global, &amp;device_domain_list);<br>
- =A0 =A0 =A0 pdev-&gt;dev.archdata.iommu =3D info;<br>
- =A0 =A0 =A0 spin_unlock_irqrestore(&amp;device_domain_lock, flags);<br>
- =A0 =A0 =A0 return domain;<br>
=A0error:<br>
=A0 =A0 =A0 =A0 /* recheck it here, maybe others set it */<br>
=A0 =A0 =A0 =A0 return find_domain(pdev);<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.10.4<br>
<br>
_______________________________________________<br>
iommu mailing list<br>
<a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu-cunTk1MwBs9QetFLy7KEm2CgeU+1il2p@public.gmane.org=
ation.org</a><br>
<a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/iommu" target=
=3D"_blank">https://lists.linuxfoundation.org/mailman/listinfo/iommu</a><br=
>
</font></span></blockquote></div><br></div></div>

--001a113399b82ac35204ef6cc874--

--===============7120826124548461151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7120826124548461151==--
