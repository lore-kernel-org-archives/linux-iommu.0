From: "Akula, Geethasowjanya" <Geethasowjanya.Akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] arm64: SMMU-v2: Workaround for Cavium ThunderX erratum
	28168
Date: Mon, 24 Oct 2016 15:29:49 +0000
Message-ID: <CY4PR07MB3128A4F864133F60D7228AD2E0A90@CY4PR07MB3128.namprd07.prod.outlook.com>
References: <1> <1477112061-12868-1-git-send-email-gakula@caviumnetworks.com>,
	<fbc51a32-aaba-0ee6-c0bd-07a02fb2a6b4@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1789806598473194236=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <fbc51a32-aaba-0ee6-c0bd-07a02fb2a6b4-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "Kapoor, Prasun" <Prasun.Kapoor-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============1789806598473194236==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR07MB3128A4F864133F60D7228AD2E0A90CY4PR07MB3128namp_"

--_000_CY4PR07MB3128A4F864133F60D7228AD2E0A90CY4PR07MB3128namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Marc, Robin.


Thanks for your feedback. I will resend the updated patch soon.




Thank you,

Geetha.


________________________________
From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Sent: Monday, October 24, 2016 7:14:35 PM
To: Akula, Geethasowjanya; robin.murphy-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org; mark.=
rutland-5wv7dgnIgG8@public.gmane.org
Cc: Kapoor, Prasun; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Chalamarla, Tirumales=
h; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Thomas Gleixner; Jason Cooper; lin=
ux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: [PATCH] arm64: SMMU-v2: Workaround for Cavium ThunderX erratum=
 28168

Geetha,

On 22/10/16 05:54, Geetha sowjanya wrote:
> From: Tirumalesh Chalamarla <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>
>   This patch implements Cavium ThunderX erratum 28168.
>
>   PCI requires stores complete in order. Due to erratum #28168
>   PCI-inbound MSI-X store to the interrupt controller are delivered
>   to the interrupt controller before older PCI-inbound memory stores
>   are committed.
>   Doing a sync on SMMU will make sure all prior transactions are
>   completed.
>
> Signed-off-by: Tirumalesh Chalamarla <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> ---
>  arch/arm64/Kconfig               |   11 +++++++++++
>  drivers/iommu/arm-smmu.c         |   38 ++++++++++++++++++++++++++++++++=
++++++
>  drivers/irqchip/irq-gic-common.h |    1 +
>  drivers/irqchip/irq-gic-v3-its.c |   22 ++++++++++++++++++++++
>  kernel/irq/chip.c                |    4 ++++

Thanks Robin for looping me in. Geetha, please use get_maintainers.pl to
keep the relevant people on CC, specially as you're touching some of the
core infrastructure.

>  5 files changed, 76 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 30398db..57f5c9b 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -474,6 +474,17 @@ config CAVIUM_ERRATUM_27456
>
>          If unsure, say Y.
>
> +config CAVIUM_ERRATUM_28168
> +     bool "Cavium erratum 28168: Make sure ITS and SMMU TLB are in sync"
> +     default y
> +     help
> +      Due to erratum #28168 PCI-inbound MSI-X store to the interrupt
> +      controller are delivered to the interrupt controller before older
> +      PCI-inbound memory stores are committed. Doing a sync on SMMU
> +      will make sure all prior transactions are completed.
> +
> +      If unsure, say Y.

Please add an entry to Documentation/arm64/silicon-errata.txt.

> +
>  endmenu
>
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 9740846..20a61c6 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c

I'll skip the SMMU code on which Robin has commented already, and move
to the irq part, which is equally entertaining.

[...]

> diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-c=
ommon.h
> index 205e5fd..0228ba0 100644
> --- a/drivers/irqchip/irq-gic-common.h
> +++ b/drivers/irqchip/irq-gic-common.h
> @@ -38,4 +38,5 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk=
 *quirks,
>
>  void gic_set_kvm_info(const struct gic_kvm_info *info);
>
> +void cavium_smmu_tlb_sync(void *iommu);
>  #endif /* _IRQ_GIC_COMMON_H */
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v=
3-its.c
> index 003495d..88e9958 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -112,6 +112,7 @@ struct its_device {
>        struct its_node         *its;
>        struct event_lpi_map    event_map;
>        void                    *itt;
> +     struct device           *dev;

This doesn't work in the presence of anything that will multiplex
multiple RequesterIDs onto a single DeviceID (non transparent PCI
bridge, for example).

>        u32                     nr_ites;
>        u32                     device_id;
>  };
> @@ -664,10 +665,29 @@ static void its_irq_compose_msi_msg(struct irq_data=
 *d, struct msi_msg *msg)
>        iommu_dma_map_msi_msg(d->irq, msg);
>  }
>
> +/**
> + * Due to erratum in ThunderX,
> + * we need to make sure SMMU is in sync with ITS translations.
> + **/
> +static void its_ack_irq(struct irq_data *d)
> +{
> +     struct its_device *its_dev =3D irq_data_get_irq_chip_data(d);
> +     struct pci_dev *pdev;
> +
> +             if (!dev_is_pci(its_dev->dev))
> +                     return;

How about non PCI devices?

> +
> +             pdev =3D to_pci_dev(its_dev->dev);
> +             if (pdev->vendor !=3D 0x177d)
> +                     cavium_smmu_tlb_sync(its_dev->dev);

What makes Cavium devices so special that they do not need to respect
the PCI memory ordering with respect to MSI delivery?

> +
> +}
> +
>  static struct irq_chip its_irq_chip =3D {
>        .name                   =3D "ITS",
>        .irq_mask               =3D its_mask_irq,
>        .irq_unmask             =3D its_unmask_irq,
> +     .irq_ack                =3D its_ack_irq,

Nice try, but no, thank you. If you really want to go down that road,
have a look at CONFIG_IRQ_PREFLOW_FASTEOI, and make this workaround a
per interrupt thing. At least, you won't pollute the core code with
another hack.

Also, it would be good to find a way for that hack to be confined to the
SMMU driver, since that's where the oddity is being handled. Something
that would occur when the device is mapping memory is probably on good spot=
.

>        .irq_eoi                =3D irq_chip_eoi_parent,
>        .irq_set_affinity       =3D its_set_affinity,
>        .irq_compose_msi_msg    =3D its_irq_compose_msi_msg,
> @@ -1422,6 +1442,8 @@ static int its_msi_prepare(struct irq_domain *domai=
n, struct device *dev,
>        if (!its_dev)
>                return -ENOMEM;
>
> +     its_dev->dev =3D dev;
> +
>        pr_debug("ITT %d entries, %d bits\n", nvec, ilog2(nvec));
>  out:
>        info->scratchpad[0].ptr =3D its_dev;
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index be3c34e..6add8da 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -585,6 +585,10 @@ void handle_fasteoi_irq(struct irq_desc *desc)
>                goto out;
>        }
>
> +#ifdef CONFIG_CAVIUM_ERRATUM_28168
> +     if (chip->irq_ack)
> +             chip->irq_ack(&desc->irq_data);
> +#endif
>        kstat_incr_irqs_this_cpu(desc);
>        if (desc->istate & IRQS_ONESHOT)
>                mask_irq(desc);
>

Overall, this workaround is not acceptable as it is. You need to find
ways to make it less invasive, and hopefully the above pointers will
help. Please keep the current distribution list posted once you update
this patch.

Thanks,

        M.
--
Jazz is not dead. It just smells funny...

--_000_CY4PR07MB3128A4F864133F60D7228AD2E0A90CY4PR07MB3128namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" style=3D"font-size:10pt; color:#000000; =
font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Hi Marc, Robin.</p>
<p><br>
</p>
<p>Thanks for your feedback. I will resend the updated patch soon. <br>
</p>
<p><br>
</p>
<p><br>
</p>
<p><br>
</p>
<p>Thank you,</p>
<p>Geetha.<br>
</p>
<p><br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Marc Zyngier &lt;ma=
rc.zyngier-5wv7dgnIgG8@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, October 24, 2016 7:14:35 PM<br>
<b>To:</b> Akula, Geethasowjanya; robin.murphy-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org=
; mark.rutland-5wv7dgnIgG8@public.gmane.org<br>
<b>Cc:</b> Kapoor, Prasun; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Chalamarla, Ti=
rumalesh; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Thomas Gleixner; Jason Coop=
er; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] arm64: SMMU-v2: Workaround for Cavium ThunderX =
erratum 28168</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Geetha,<br>
<br>
On 22/10/16 05:54, Geetha sowjanya wrote:<br>
&gt; From: Tirumalesh Chalamarla &lt;Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org&gt;<b=
r>
&gt; <br>
&gt;&nbsp;&nbsp; This patch implements Cavium ThunderX erratum 28168.<br>
&gt; <br>
&gt;&nbsp;&nbsp; PCI requires stores complete in order. Due to erratum #281=
68<br>
&gt;&nbsp;&nbsp; PCI-inbound MSI-X store to the interrupt controller are de=
livered<br>
&gt;&nbsp;&nbsp; to the interrupt controller before older PCI-inbound memor=
y stores<br>
&gt;&nbsp;&nbsp; are committed.<br>
&gt;&nbsp;&nbsp; Doing a sync on SMMU will make sure all prior transactions=
 are<br>
&gt;&nbsp;&nbsp; completed.<br>
&gt; <br>
&gt; Signed-off-by: Tirumalesh Chalamarla &lt;Tirumalesh.Chalamarla@cavium.=
com&gt;<br>
&gt; Signed-off-by: Geetha sowjanya &lt;gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; arch/arm64/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 11 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/iommu/arm-smmu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp;&nbsp; 38 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/irqchip/irq-gic-common.h |&nbsp;&nbsp;&nbsp; 1 &#43;<br>
&gt;&nbsp; drivers/irqchip/irq-gic-v3-its.c |&nbsp;&nbsp; 22 &#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; kernel/irq/chip.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 4 &#43;&#43=
;&#43;&#43;<br>
<br>
Thanks Robin for looping me in. Geetha, please use get_maintainers.pl to<br=
>
keep the relevant people on CC, specially as you're touching some of the<br=
>
core infrastructure.<br>
<br>
&gt;&nbsp; 5 files changed, 76 insertions(&#43;), 0 deletions(-)<br>
&gt; <br>
&gt; diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig<br>
&gt; index 30398db..57f5c9b 100644<br>
&gt; --- a/arch/arm64/Kconfig<br>
&gt; &#43;&#43;&#43; b/arch/arm64/Kconfig<br>
&gt; @@ -474,6 &#43;474,17 @@ config CAVIUM_ERRATUM_27456<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If unsure, say Y=
.<br>
&gt;&nbsp; <br>
&gt; &#43;config CAVIUM_ERRATUM_28168<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Cavium erratum 28168: Make su=
re ITS and SMMU TLB are in sync&quot;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; default y<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; help<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Due to erratum #28168 PCI-inbound =
MSI-X store to the interrupt<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; controller are delivered to the in=
terrupt controller before older<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCI-inbound memory stores are comm=
itted. Doing a sync on SMMU<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; will make sure all prior transacti=
ons are completed.<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If unsure, say Y.<br>
<br>
Please add an entry to Documentation/arm64/silicon-errata.txt.<br>
<br>
&gt; &#43;<br>
&gt;&nbsp; endmenu<br>
&gt;&nbsp; <br>
&gt;&nbsp; <br>
&gt; diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c<br>
&gt; index 9740846..20a61c6 100644<br>
&gt; --- a/drivers/iommu/arm-smmu.c<br>
&gt; &#43;&#43;&#43; b/drivers/iommu/arm-smmu.c<br>
<br>
I'll skip the SMMU code on which Robin has commented already, and move<br>
to the irq part, which is equally entertaining.<br>
<br>
[...]<br>
<br>
&gt; diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gi=
c-common.h<br>
&gt; index 205e5fd..0228ba0 100644<br>
&gt; --- a/drivers/irqchip/irq-gic-common.h<br>
&gt; &#43;&#43;&#43; b/drivers/irqchip/irq-gic-common.h<br>
&gt; @@ -38,4 &#43;38,5 @@ void gic_enable_quirks(u32 iidr, const struct gi=
c_quirk *quirks,<br>
&gt;&nbsp; <br>
&gt;&nbsp; void gic_set_kvm_info(const struct gic_kvm_info *info);<br>
&gt;&nbsp; <br>
&gt; &#43;void cavium_smmu_tlb_sync(void *iommu);<br>
&gt;&nbsp; #endif /* _IRQ_GIC_COMMON_H */<br>
&gt; diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gi=
c-v3-its.c<br>
&gt; index 003495d..88e9958 100644<br>
&gt; --- a/drivers/irqchip/irq-gic-v3-its.c<br>
&gt; &#43;&#43;&#43; b/drivers/irqchip/irq-gic-v3-its.c<br>
&gt; @@ -112,6 &#43;112,7 @@ struct its_device {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct its_node&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *its;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct event_lpi_map&nbsp;&n=
bsp;&nbsp; event_map;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *itt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct device&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dev;<br>
<br>
This doesn't work in the presence of anything that will multiplex<br>
multiple RequesterIDs onto a single DeviceID (non transparent PCI<br>
bridge, for example).<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; nr_ites;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; device_id;<br>
&gt;&nbsp; };<br>
&gt; @@ -664,10 &#43;665,29 @@ static void its_irq_compose_msi_msg(struct i=
rq_data *d, struct msi_msg *msg)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iommu_dma_map_msi_msg(d-&gt;=
irq, msg);<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; &#43;/**<br>
&gt; &#43; * Due to erratum in ThunderX,<br>
&gt; &#43; * we need to make sure SMMU is in sync with ITS translations.<br=
>
&gt; &#43; **/<br>
&gt; &#43;static void its_ack_irq(struct irq_data *d)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct its_device *its_dev =3D irq_data_=
get_irq_chip_data(d);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *pdev;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (!dev_is_pci(its_dev-&gt;dev))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
<br>
How about non PCI devices?<br>
<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pdev =3D to_pci_dev(its_dev-&gt;dev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (pdev-&gt;vendor !=3D 0x177d)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cavium_smmu_tlb_syn=
c(its_dev-&gt;dev);<br>
<br>
What makes Cavium devices so special that they do not need to respect<br>
the PCI memory ordering with respect to MSI delivery?<br>
<br>
&gt; &#43;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static struct irq_chip its_irq_chip =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =3D &quot;ITS&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .irq_mask&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D its_m=
ask_irq,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .irq_unmask&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D its_unmask_irq,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .irq_ack&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D its_ack_irq,=
<br>
<br>
Nice try, but no, thank you. If you really want to go down that road,<br>
have a look at CONFIG_IRQ_PREFLOW_FASTEOI, and make this workaround a<br>
per interrupt thing. At least, you won't pollute the core code with<br>
another hack.<br>
<br>
Also, it would be good to find a way for that hack to be confined to the<br=
>
SMMU driver, since that's where the oddity is being handled. Something<br>
that would occur when the device is mapping memory is probably on good spot=
.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .irq_eoi&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
irq_chip_eoi_parent,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .irq_set_affinity&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D its_set_affinity,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .irq_compose_msi_msg&nbsp;&n=
bsp;&nbsp; =3D its_irq_compose_msi_msg,<br>
&gt; @@ -1422,6 &#43;1442,8 @@ static int its_msi_prepare(struct irq_domain=
 *domain, struct device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!its_dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; its_dev-&gt;dev =3D dev;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;ITT %d entrie=
s, %d bits\n&quot;, nvec, ilog2(nvec));<br>
&gt;&nbsp; out:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;scratchpad[0].ptr =
=3D its_dev;<br>
&gt; diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c<br>
&gt; index be3c34e..6add8da 100644<br>
&gt; --- a/kernel/irq/chip.c<br>
&gt; &#43;&#43;&#43; b/kernel/irq/chip.c<br>
&gt; @@ -585,6 &#43;585,10 @@ void handle_fasteoi_irq(struct irq_desc *desc=
)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; &#43;#ifdef CONFIG_CAVIUM_ERRATUM_28168<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (chip-&gt;irq_ack)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; chip-&gt;irq_ack(&amp;desc-&gt;irq_data);<br>
&gt; &#43;#endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kstat_incr_irqs_this_cpu(des=
c);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (desc-&gt;istate &amp; IR=
QS_ONESHOT)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mask_irq(desc);<br>
&gt; <br>
<br>
Overall, this workaround is not acceptable as it is. You need to find<br>
ways to make it less invasive, and hopefully the above pointers will<br>
help. Please keep the current distribution list posted once you update<br>
this patch.<br>
<br>
Thanks,<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; M.<br>
-- <br>
Jazz is not dead. It just smells funny...<br>
</div>
</span></font>
</body>
</html>

--_000_CY4PR07MB3128A4F864133F60D7228AD2E0A90CY4PR07MB3128namp_--

--===============1789806598473194236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1789806598473194236==--
