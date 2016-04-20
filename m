From: Godfrey van der Linden via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v4 5/7] iommu/vt-d: avoid dev iotlb logic in intel-iommu
	for domains with no dev iotlbs
Date: Wed, 20 Apr 2016 08:17:33 -0700
Message-ID: <CANSfodEQC3YcVh0_THpDMQx_YZqD=p5Zw5BEnwRhm3hNgaLOhA@mail.gmail.com>
References: <cover.1461135861.git.mad@cs.technion.ac.il>
	<3780bc5682714a48a8d90ee0adf621dbd3529283.1461135861.git.mad@cs.technion.ac.il>
Reply-To: Godfrey van der Linden <gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0462361810559939150=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <3780bc5682714a48a8d90ee0adf621dbd3529283.1461135861.git.mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Cc: Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Tsafrir <dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, shli-b10kYP2dOMg@public.gmane.org, Kernel-team-b10kYP2dOMg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============0462361810559939150==
Content-Type: multipart/alternative; boundary=001a113a5abccb621a0530ec1737

--001a113a5abccb621a0530ec1737
Content-Type: text/plain; charset=UTF-8

Adam you mention in the 0/7 description that you have moved the location of
has_iotlb_device which is a good idea.

This patch did not move it after all, it is identical to the v3 version.

On 20 April 2016 at 01:33, Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org> wrote:

> From: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
>
> This patch avoids taking the device_domain_lock in iommu_flush_dev_iotlb()
> for domains with no dev iotlb devices.
>
> Signed-off-by: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
> [gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org: fixed locking issues]
> Signed-off-by: Godfrey van der Linden <gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> [mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org: rebased and reworded the commit message]
> Signed-off-by: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
> Reviewed-by: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
> Reviewed-by: Ben Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index be6d885..8381cfd 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -392,6 +392,7 @@ struct dmar_domain {
>                                          * to VT-d spec, section 9.3 */
>
>         struct list_head devices;       /* all devices' list */
> +       bool has_iotlb_device;
>         struct iova_domain iovad;       /* iova's that belong to this
> domain */
>
>         struct dma_pte  *pgd;           /* virtual address */
> @@ -1464,10 +1465,35 @@ iommu_support_dev_iotlb (struct dmar_domain
> *domain, struct intel_iommu *iommu,
>         return NULL;
>  }
>
> +static void domain_update_iotlb(struct dmar_domain *domain)
> +{
> +       struct device_domain_info *info;
> +       bool has_iotlb_device = false;
> +
> +       assert_spin_locked(&device_domain_lock);
> +
> +       list_for_each_entry(info, &domain->devices, link) {
> +               struct pci_dev *pdev;
> +
> +               if (!info->dev || !dev_is_pci(info->dev))
> +                       continue;
> +
> +               pdev = to_pci_dev(info->dev);
> +               if (pdev->ats_enabled) {
> +                       has_iotlb_device = true;
> +                       break;
> +               }
> +       }
> +
> +       domain->has_iotlb_device = has_iotlb_device;
> +}
> +
>  static void iommu_enable_dev_iotlb(struct device_domain_info *info)
>  {
>         struct pci_dev *pdev;
>
> +       assert_spin_locked(&device_domain_lock);
> +
>         if (!info || !dev_is_pci(info->dev))
>                 return;
>
> @@ -1487,6 +1513,7 @@ static void iommu_enable_dev_iotlb(struct
> device_domain_info *info)
>  #endif
>         if (info->ats_supported && !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>                 info->ats_enabled = 1;
> +               domain_update_iotlb(info->domain);
>                 info->ats_qdep = pci_ats_queue_depth(pdev);
>         }
>  }
> @@ -1495,6 +1522,8 @@ static void iommu_disable_dev_iotlb(struct
> device_domain_info *info)
>  {
>         struct pci_dev *pdev;
>
> +       assert_spin_locked(&device_domain_lock);
> +
>         if (!dev_is_pci(info->dev))
>                 return;
>
> @@ -1503,6 +1532,7 @@ static void iommu_disable_dev_iotlb(struct
> device_domain_info *info)
>         if (info->ats_enabled) {
>                 pci_disable_ats(pdev);
>                 info->ats_enabled = 0;
> +               domain_update_iotlb(info->domain);
>         }
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>         if (info->pri_enabled) {
> @@ -1523,6 +1553,9 @@ static void iommu_flush_dev_iotlb(struct dmar_domain
> *domain,
>         unsigned long flags;
>         struct device_domain_info *info;
>
> +       if (!domain->has_iotlb_device)
> +               return;
> +
>         spin_lock_irqsave(&device_domain_lock, flags);
>         list_for_each_entry(info, &domain->devices, link) {
>                 if (!info->ats_enabled)
> @@ -1740,6 +1773,7 @@ static struct dmar_domain *alloc_domain(int flags)
>         memset(domain, 0, sizeof(*domain));
>         domain->nid = -1;
>         domain->flags = flags;
> +       domain->has_iotlb_device = false;
>         INIT_LIST_HEAD(&domain->devices);
>
>         return domain;
> --
> 1.9.1
>
>

--001a113a5abccb621a0530ec1737
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Adam you mention in the 0/7 description that you have move=
d the location of has_iotlb_device which is a good idea.<div><br></div><div=
>This patch did not move it after all, it is identical to the v3 version.</=
div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 20 A=
pril 2016 at 01:33, Adam Morrison <span dir=3D"ltr">&lt;<a href=3D"mailto:m=
ad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org" target=3D"_blank">mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">From: Omer Peleg &lt;<a href=3D"=
mailto:omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org">omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org</a>&gt;<br>
<br>
This patch avoids taking the device_domain_lock in iommu_flush_dev_iotlb()<=
br>
for domains with no dev iotlb devices.<br>
<br>
Signed-off-by: Omer Peleg &lt;<a href=3D"mailto:omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org">ome=
r@cs.technion.ac.il</a>&gt;<br>
[<a href=3D"mailto:gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org">gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org</a>: fixed locking issu=
es]<br>
Signed-off-by: Godfrey van der Linden &lt;<a href=3D"mailto:gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org=
">gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
[<a href=3D"mailto:mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org">mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org</a>: rebase=
d and reworded the commit message]<br>
Signed-off-by: Adam Morrison &lt;<a href=3D"mailto:mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org">m=
ad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org</a>&gt;<br>
Reviewed-by: Shaohua Li &lt;<a href=3D"mailto:shli-b10kYP2dOMg@public.gmane.org">shli-b10kYP2dOMg@public.gmane.org</a>&=
gt;<br>
Reviewed-by: Ben Serebrin &lt;<a href=3D"mailto:serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org">serebr=
in-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/iommu/intel-iommu.c | 34 ++++++++++++++++++++++++++++++++++<b=
r>
=C2=A01 file changed, 34 insertions(+)<br>
<br>
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c<br>
index be6d885..8381cfd 100644<br>
--- a/drivers/iommu/intel-iommu.c<br>
+++ b/drivers/iommu/intel-iommu.c<br>
@@ -392,6 +392,7 @@ struct dmar_domain {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =
to VT-d spec, section 9.3 */<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct list_head devices;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* all devices&#39; list */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool has_iotlb_device;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iova_domain iovad;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* iova&#39;s that belong to this domain */<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dma_pte=C2=A0 *pgd;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* virtual address */<br>
@@ -1464,10 +1465,35 @@ iommu_support_dev_iotlb (struct dmar_domain *domain=
, struct intel_iommu *iommu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
=C2=A0}<br>
<br>
+static void domain_update_iotlb(struct dmar_domain *domain)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_domain_info *info;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool has_iotlb_device =3D false;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0assert_spin_locked(&amp;device_domain_lock);<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0list_for_each_entry(info, &amp;domain-&gt;devic=
es, link) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *pde=
v;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!info-&gt;dev |=
| !dev_is_pci(info-&gt;dev))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdev =3D to_pci_dev=
(info-&gt;dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pdev-&gt;ats_en=
abled) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0has_iotlb_device =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0domain-&gt;has_iotlb_device =3D has_iotlb_devic=
e;<br>
+}<br>
+<br>
=C2=A0static void iommu_enable_dev_iotlb(struct device_domain_info *info)<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pci_dev *pdev;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0assert_spin_locked(&amp;device_domain_lock);<br=
>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!info || !dev_is_pci(info-&gt;dev))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
@@ -1487,6 +1513,7 @@ static void iommu_enable_dev_iotlb(struct device_doma=
in_info *info)<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (info-&gt;ats_supported &amp;&amp; !pci_enab=
le_ats(pdev, VTD_PAGE_SHIFT)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;ats_enable=
d =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0domain_update_iotlb=
(info-&gt;domain);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;ats_qdep =
=3D pci_ats_queue_depth(pdev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
@@ -1495,6 +1522,8 @@ static void iommu_disable_dev_iotlb(struct device_dom=
ain_info *info)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pci_dev *pdev;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0assert_spin_locked(&amp;device_domain_lock);<br=
>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!dev_is_pci(info-&gt;dev))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
@@ -1503,6 +1532,7 @@ static void iommu_disable_dev_iotlb(struct device_dom=
ain_info *info)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (info-&gt;ats_enabled) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_disable_ats(pde=
v);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;ats_enable=
d =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0domain_update_iotlb=
(info-&gt;domain);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0#ifdef CONFIG_INTEL_IOMMU_SVM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (info-&gt;pri_enabled) {<br>
@@ -1523,6 +1553,9 @@ static void iommu_flush_dev_iotlb(struct dmar_domain =
*domain,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long flags;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_domain_info *info;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!domain-&gt;has_iotlb_device)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&amp;device_domain_lock, flag=
s);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 list_for_each_entry(info, &amp;domain-&gt;devic=
es, link) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!info-&gt;ats_e=
nabled)<br>
@@ -1740,6 +1773,7 @@ static struct dmar_domain *alloc_domain(int flags)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(domain, 0, sizeof(*domain));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 domain-&gt;nid =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 domain-&gt;flags =3D flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0domain-&gt;has_iotlb_device =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 INIT_LIST_HEAD(&amp;domain-&gt;devices);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return domain;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br></div>

--001a113a5abccb621a0530ec1737--

--===============0462361810559939150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0462361810559939150==--
