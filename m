From: Prathyush K <prathyush-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 09/12] iommu/exynos: add supoort for runtime pm and
	suspend/resume
Date: Tue, 20 Nov 2012 13:33:11 +0530
Message-ID: <CAH=HWYPkS0i4jo8X4XGiCd417dnUn88TtscxMqCAcH8fOq4M=w@mail.gmail.com>
References: <002301cdc6f0$f1a1dce0$d4e596a0$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8276453655607152320=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <002301cdc6f0$f1a1dce0$d4e596a0$%cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush K <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Subash Patel <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sanghyun Lee <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============8276453655607152320==
Content-Type: multipart/alternative; boundary=047d7b2e43e647065b04cee8aabe

--047d7b2e43e647065b04cee8aabe
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Nov 20, 2012 at 1:00 PM, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:

> This change enables the client device drivers not to care about
> the state of System MMU since the internal state of System MMU
> is controlled by the runtime PM and suspend/resume callback functions.
>
> Signed-off-by: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iommu/exynos-iommu.c | 175
> ++++++++++++++++++++++---------------------
>  1 file changed, 89 insertions(+), 86 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 8f9239c..169f56e 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -208,6 +208,7 @@ struct sysmmu_drvdata {
>         struct iommu_domain *domain;
>         sysmmu_fault_handler_t fault_handler;
>         unsigned long pgtable;
> +       bool runtime_active;
>         void __iomem *sfrbases[0];
>  };
>
> @@ -477,7 +478,8 @@ static bool __sysmmu_disable(struct sysmmu_drvdata
> *drvdata)
>                 drvdata->pgtable = 0;
>                 drvdata->domain = NULL;
>
> -               __sysmmu_disable_nocount(drvdata);
> +               if (drvdata->runtime_active)
> +                       __sysmmu_disable_nocount(drvdata);
>
>                 dev_dbg(drvdata->sysmmu, "Disabled\n");
>         } else  {
> @@ -490,30 +492,6 @@ static bool __sysmmu_disable(struct sysmmu_drvdata
> *drvdata)
>         return disabled;
>  }
>
> -static bool __exynos_sysmmu_disable(struct device *dev)
> -{
> -       unsigned long flags;
> -       bool disabled = true;
> -       struct exynos_iommu_owner *owner = dev->archdata.iommu;
> -       struct device *sysmmu;
> -
> -       BUG_ON(!has_sysmmu(dev));
> -
> -       spin_lock_irqsave(&owner->lock, flags);
> -
> -       /* Every call to __sysmmu_disable() must return same result */
> -       for_each_sysmmu(dev, sysmmu) {
> -               struct sysmmu_drvdata *drvdata = dev_get_drvdata(sysmmu);
> -               disabled = __sysmmu_disable(drvdata);
> -               if (disabled)
> -                       drvdata->master = NULL;
> -       }
> -
> -       spin_unlock_irqrestore(&owner->lock, flags);
> -
> -       return disabled;
> -}
> -
>  static void __sysmmu_enable_nocount(struct sysmmu_drvdata *drvdata)
>  {
>         int i;
> @@ -554,7 +532,8 @@ static int __sysmmu_enable(struct sysmmu_drvdata
> *drvdata,
>                 drvdata->pgtable = pgtable;
>                 drvdata->domain = domain;
>
> -               __sysmmu_enable_nocount(drvdata);
> +               if (drvdata->runtime_active)
> +                       __sysmmu_enable_nocount(drvdata);
>
>                 dev_dbg(drvdata->sysmmu, "Enabled\n");
>         } else {
> @@ -610,42 +589,31 @@ static int __exynos_sysmmu_enable(struct device
> *dev, unsigned long pgtable,
>
>  int exynos_sysmmu_enable(struct device *dev, unsigned long pgtable)
>  {
> -       int ret;
> -       struct device *sysmmu;
> -
>         BUG_ON(!memblock_is_memory(pgtable));
>
> -       for_each_sysmmu(dev, sysmmu) {
> -               ret = pm_runtime_get_sync(sysmmu);
> -               if (ret < 0)
> -                       break;
> -       }
> -
> -       if (ret < 0) {
> -               struct device *start;
> -               for_each_sysmmu_until(dev, start, sysmmu)
> -                       pm_runtime_put(start);
> -
> -               return ret;
> -       }
> -
> -       ret = __exynos_sysmmu_enable(dev, pgtable, NULL);
> -       if (ret < 0)
> -               for_each_sysmmu(dev, sysmmu)
> -                       pm_runtime_put(sysmmu);
> -
> -       return ret;
> +       return __exynos_sysmmu_enable(dev, pgtable, NULL);
>  }
>
>  bool exynos_sysmmu_disable(struct device *dev)
>  {
> -       bool disabled;
> +       unsigned long flags;
> +       bool disabled = true;
> +       struct exynos_iommu_owner *owner = dev->archdata.iommu;
>         struct device *sysmmu;
>
> -       disabled = __exynos_sysmmu_disable(dev);
> +       BUG_ON(!has_sysmmu(dev));
>
> -       for_each_sysmmu(dev, sysmmu)
> -               pm_runtime_put(sysmmu);
> +       spin_lock_irqsave(&owner->lock, flags);
> +
> +       /* Every call to __sysmmu_disable() must return same result */
> +       for_each_sysmmu(dev, sysmmu) {
> +               struct sysmmu_drvdata *drvdata = dev_get_drvdata(sysmmu);
> +               disabled = __sysmmu_disable(drvdata);
> +               if (disabled)
> +                       drvdata->master = NULL;
> +       }
> +
> +       spin_unlock_irqrestore(&owner->lock, flags);
>
>         return disabled;
>  }
> @@ -661,7 +629,8 @@ static void sysmmu_tlb_invalidate_entry(struct device
> *dev, unsigned long iova)
>                 data = dev_get_drvdata(sysmmu);
>
>                 spin_lock_irqsave(&data->lock, flags);
> -               if (is_sysmmu_active(data)) {
> +               if (is_sysmmu_active(data) &&
> +                               data->runtime_active) {
>                         int i;
>                         for (i = 0; i < data->nsfrs; i++) {
>                                 if (sysmmu_block(data->sfrbases[i])) {
> @@ -899,6 +868,7 @@ static int __init exynos_sysmmu_probe(struct
> platform_device *pdev)
>
>         ret = __sysmmu_setup(dev, data);
>         if (!ret) {
> +               data->runtime_active = !pm_runtime_enabled(dev);
>                 data->sysmmu = dev;
>                 spin_lock_init(&data->lock);
>
> @@ -911,6 +881,64 @@ static int __init exynos_sysmmu_probe(struct
> platform_device *pdev)
>         return ret;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int sysmmu_suspend(struct device *dev)
> +{
> +       struct sysmmu_drvdata *drvdata = dev_get_drvdata(dev);
> +       unsigned long flags;
> +       spin_lock_irqsave(&drvdata->lock, flags);
> +       if (is_sysmmu_active(drvdata) &&
> +               (!pm_runtime_enabled(dev) || drvdata->runtime_active))
> +               __sysmmu_disable_nocount(drvdata);
> +       spin_unlock_irqrestore(&drvdata->lock, flags);
> +       return 0;
> +}
> +
> +static int sysmmu_resume(struct device *dev)
> +{
> +       struct sysmmu_drvdata *drvdata = dev_get_drvdata(dev);
> +       unsigned long flags;
> +       spin_lock_irqsave(&drvdata->lock, flags);
> +       if (is_sysmmu_active(drvdata) &&
> +               (!pm_runtime_enabled(dev) || drvdata->runtime_active)) {
> +               __sysmmu_enable_nocount(drvdata);
> +       }
> +       spin_unlock_irqrestore(&drvdata->lock, flags);
> +       return 0;
> +}
> +#endif
> +
> +#ifdef CONFIG_PM_RUNTIME
> +static int sysmmu_runtime_suspend(struct device *dev)
> +{
> +       struct sysmmu_drvdata *drvdata = dev_get_drvdata(dev);
> +       unsigned long flags;
> +       spin_lock_irqsave(&drvdata->lock, flags);
> +       if (is_sysmmu_active(drvdata))
> +               __sysmmu_disable_nocount(drvdata);
> +       drvdata->runtime_active = false;
> +       spin_unlock_irqrestore(&drvdata->lock, flags);
> +       return 0;
> +}
> +
> +static int sysmmu_runtime_resume(struct device *dev)
> +{
> +       struct sysmmu_drvdata *drvdata = dev_get_drvdata(dev);
> +       unsigned long flags;
> +       spin_lock_irqsave(&drvdata->lock, flags);
> +       drvdata->runtime_active = true;
> +       if (is_sysmmu_active(drvdata))
> +               __sysmmu_enable_nocount(drvdata);
> +       spin_unlock_irqrestore(&drvdata->lock, flags);
> +       return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops __pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(sysmmu_suspend, sysmmu_resume)
> +       SET_RUNTIME_PM_OPS(sysmmu_runtime_resume, sysmmu_runtime_suspend,
> NULL)
>

The runtime PM ops are not set correctly. The suspend_fn should be first,
followed
by resume_fn as per SET_RUNTIME_PM_OPS.

Thanks,
Prathyush


> +};
> +
>  /*
>   * Descriptions of Device Tree node for System MMU
>   *
> @@ -948,6 +976,7 @@ static struct platform_driver exynos_sysmmu_driver
> __refdata = {
>         .driver         = {
>                 .owner          = THIS_MODULE,
>                 .name           = "exynos-sysmmu",
> +               .pm             = &__pm_ops,
>                 .of_match_table = of_match_ptr(sysmmu_of_match),
>         }
>  };
> @@ -1009,13 +1038,9 @@ static void exynos_iommu_domain_destroy(struct
> iommu_domain *domain)
>         spin_lock_irqsave(&priv->lock, flags);
>
>         list_for_each_entry_safe(owner, n, &priv->clients, client) {
> -               struct device *sysmmu;
> -               while (!__exynos_sysmmu_disable(owner->dev))
> +               while (!exynos_sysmmu_disable(owner->dev))
>                         ; /* until System MMU is actually disabled */
>                 list_del_init(&owner->client);
> -
> -               for_each_sysmmu(owner->dev, sysmmu)
> -                       pm_runtime_put(sysmmu);
>         }
>
>         spin_unlock_irqrestore(&priv->lock, flags);
> @@ -1038,7 +1063,6 @@ static int exynos_iommu_attach_device(struct
> iommu_domain *domain,
>         struct exynos_iommu_domain *priv = domain->priv;
>         unsigned long flags;
>         int ret;
> -       struct device *sysmmu;
>
>         if (WARN_ON(!list_empty(&owner->client))) {
>                 bool found = false;
> @@ -1063,20 +1087,6 @@ static int exynos_iommu_attach_device(struct
> iommu_domain *domain,
>                 return 0;
>         }
>
> -       for_each_sysmmu(dev, sysmmu) {
> -               ret = pm_runtime_get_sync(sysmmu);
> -               if (ret < 0)
> -                       break;
> -       }
> -
> -       if (ret < 0) {
> -               struct device *start;
> -               for_each_sysmmu_until(dev, start, sysmmu)
> -                       pm_runtime_put(start);
> -
> -               return ret;
> -       }
> -
>         spin_lock_irqsave(&priv->lock, flags);
>
>         ret = __exynos_sysmmu_enable(dev, __pa(priv->pgtable), domain);
> @@ -1091,15 +1101,12 @@ static int exynos_iommu_attach_device(struct
> iommu_domain *domain,
>
>         spin_unlock_irqrestore(&priv->lock, flags);
>
> -       if (ret < 0) {
> +       if (ret < 0)
>                 dev_err(dev, "%s: Failed to attach IOMMU with pgtable
> %#lx\n",
>                                 __func__, __pa(priv->pgtable));
> -               for_each_sysmmu(dev, sysmmu)
> -                       pm_runtime_put(sysmmu);
> -       } else {
> +       else
>                 dev_dbg(dev, "%s: Attached new IOMMU with pgtable 0x%lx\n",
>                                         __func__, __pa(priv->pgtable));
> -       }
>
>         return ret;
>  }
> @@ -1115,7 +1122,7 @@ static void exynos_iommu_detach_device(struct
> iommu_domain *domain,
>
>         list_for_each_entry_safe(owner, n, &priv->clients, client) {
>                 if (owner == dev->archdata.iommu) {
> -                       if (__exynos_sysmmu_disable(dev))
> +                       if (exynos_sysmmu_disable(dev))
>                                 list_del_init(&owner->client);
>                         else
>                                 BUG();
> @@ -1125,14 +1132,10 @@ static void exynos_iommu_detach_device(struct
> iommu_domain *domain,
>
>         spin_unlock_irqrestore(&priv->lock, flags);
>
> -       if (owner == dev->archdata.iommu) {
> -               struct device *sysmmu;
> +       if (owner == dev->archdata.iommu)
>                 dev_dbg(dev, "%s: Detached IOMMU with pgtable %#lx\n",
>                                         __func__, __pa(priv->pgtable));
> -               for_each_sysmmu(dev, sysmmu)
> -                       pm_runtime_put(sysmmu);
> -
> -       } else
> +       else
>                 dev_dbg(dev, "%s: No IOMMU is attached\n", __func__);
>  }
>
> --
> 1.8.0
>
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

--047d7b2e43e647065b04cee8aabe
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Tue, N=
ov 20, 2012 at 1:00 PM, Cho KyongHo <span dir=3D"ltr">&lt;<a href=3D"mailto=
:pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;</=
span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">This change enables the client device drivers not to care =
about<br>

the state of System MMU since the internal state of System MMU<br>
is controlled by the runtime PM and suspend/resume callback functions.<br>
<br>
Signed-off-by: KyongHo Cho &lt;<a href=3D"mailto:pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">pu=
llip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
---<br>
=A0drivers/iommu/exynos-iommu.c | 175 ++++++++++++++++++++++---------------=
------<br>
=A01 file changed, 89 insertions(+), 86 deletions(-)<br>
<br>
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c<br=
>
index 8f9239c..169f56e 100644<br>
--- a/drivers/iommu/exynos-iommu.c<br>
+++ b/drivers/iommu/exynos-iommu.c<br>
@@ -208,6 +208,7 @@ struct sysmmu_drvdata {<br>
=A0 =A0 =A0 =A0 struct iommu_domain *domain;<br>
=A0 =A0 =A0 =A0 sysmmu_fault_handler_t fault_handler;<br>
=A0 =A0 =A0 =A0 unsigned long pgtable;<br>
+ =A0 =A0 =A0 bool runtime_active;<br>
=A0 =A0 =A0 =A0 void __iomem *sfrbases[0];<br>
=A0};<br>
<br>
@@ -477,7 +478,8 @@ static bool __sysmmu_disable(struct sysmmu_drvdata *drv=
data)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata-&gt;pgtable =3D 0;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata-&gt;domain =3D NULL;<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_disable_nocount(drvdata);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drvdata-&gt;runtime_active)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_disable_nocount(drvd=
ata);<br>
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(drvdata-&gt;sysmmu, &quot;Disabled\=
n&quot;);<br>
=A0 =A0 =A0 =A0 } else =A0{<br>
@@ -490,30 +492,6 @@ static bool __sysmmu_disable(struct sysmmu_drvdata *dr=
vdata)<br>
=A0 =A0 =A0 =A0 return disabled;<br>
=A0}<br>
<br>
-static bool __exynos_sysmmu_disable(struct device *dev)<br>
-{<br>
- =A0 =A0 =A0 unsigned long flags;<br>
- =A0 =A0 =A0 bool disabled =3D true;<br>
- =A0 =A0 =A0 struct exynos_iommu_owner *owner =3D dev-&gt;archdata.iommu;<=
br>
- =A0 =A0 =A0 struct device *sysmmu;<br>
-<br>
- =A0 =A0 =A0 BUG_ON(!has_sysmmu(dev));<br>
-<br>
- =A0 =A0 =A0 spin_lock_irqsave(&amp;owner-&gt;lock, flags);<br>
-<br>
- =A0 =A0 =A0 /* Every call to __sysmmu_disable() must return same result *=
/<br>
- =A0 =A0 =A0 for_each_sysmmu(dev, sysmmu) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sysmmu_drvdata *drvdata =3D dev_get_dr=
vdata(sysmmu);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 disabled =3D __sysmmu_disable(drvdata);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (disabled)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata-&gt;master =3D NULL;<=
br>
- =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 spin_unlock_irqrestore(&amp;owner-&gt;lock, flags);<br>
-<br>
- =A0 =A0 =A0 return disabled;<br>
-}<br>
-<br>
=A0static void __sysmmu_enable_nocount(struct sysmmu_drvdata *drvdata)<br>
=A0{<br>
=A0 =A0 =A0 =A0 int i;<br>
@@ -554,7 +532,8 @@ static int __sysmmu_enable(struct sysmmu_drvdata *drvda=
ta,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata-&gt;pgtable =3D pgtable;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata-&gt;domain =3D domain;<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_enable_nocount(drvdata);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drvdata-&gt;runtime_active)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_enable_nocount(drvda=
ta);<br>
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(drvdata-&gt;sysmmu, &quot;Enabled\n=
&quot;);<br>
=A0 =A0 =A0 =A0 } else {<br>
@@ -610,42 +589,31 @@ static int __exynos_sysmmu_enable(struct device *dev,=
 unsigned long pgtable,<br>
<br>
=A0int exynos_sysmmu_enable(struct device *dev, unsigned long pgtable)<br>
=A0{<br>
- =A0 =A0 =A0 int ret;<br>
- =A0 =A0 =A0 struct device *sysmmu;<br>
-<br>
=A0 =A0 =A0 =A0 BUG_ON(!memblock_is_memory(pgtable));<br>
<br>
- =A0 =A0 =A0 for_each_sysmmu(dev, sysmmu) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_runtime_get_sync(sysmmu);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret &lt; 0)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
- =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 if (ret &lt; 0) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device *start;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_sysmmu_until(dev, start, sysmmu)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(start);<br>
-<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
- =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 ret =3D __exynos_sysmmu_enable(dev, pgtable, NULL);<br>
- =A0 =A0 =A0 if (ret &lt; 0)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_sysmmu(dev, sysmmu)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(sysmmu);<br>
-<br>
- =A0 =A0 =A0 return ret;<br>
+ =A0 =A0 =A0 return __exynos_sysmmu_enable(dev, pgtable, NULL);<br>
=A0}<br>
<br>
=A0bool exynos_sysmmu_disable(struct device *dev)<br>
=A0{<br>
- =A0 =A0 =A0 bool disabled;<br>
+ =A0 =A0 =A0 unsigned long flags;<br>
+ =A0 =A0 =A0 bool disabled =3D true;<br>
+ =A0 =A0 =A0 struct exynos_iommu_owner *owner =3D dev-&gt;archdata.iommu;<=
br>
=A0 =A0 =A0 =A0 struct device *sysmmu;<br>
<br>
- =A0 =A0 =A0 disabled =3D __exynos_sysmmu_disable(dev);<br>
+ =A0 =A0 =A0 BUG_ON(!has_sysmmu(dev));<br>
<br>
- =A0 =A0 =A0 for_each_sysmmu(dev, sysmmu)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(sysmmu);<br>
+ =A0 =A0 =A0 spin_lock_irqsave(&amp;owner-&gt;lock, flags);<br>
+<br>
+ =A0 =A0 =A0 /* Every call to __sysmmu_disable() must return same result *=
/<br>
+ =A0 =A0 =A0 for_each_sysmmu(dev, sysmmu) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sysmmu_drvdata *drvdata =3D dev_get_dr=
vdata(sysmmu);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 disabled =3D __sysmmu_disable(drvdata);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (disabled)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata-&gt;master =3D NULL;<=
br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 spin_unlock_irqrestore(&amp;owner-&gt;lock, flags);<br>
<br>
=A0 =A0 =A0 =A0 return disabled;<br>
=A0}<br>
@@ -661,7 +629,8 @@ static void sysmmu_tlb_invalidate_entry(struct device *=
dev, unsigned long iova)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D dev_get_drvdata(sysmmu);<br>
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;data-&gt;lock, flags=
);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_sysmmu_active(data)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_sysmmu_active(data) &amp;&amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;runt=
ime_active) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i &lt; data-&=
gt;nsfrs; i++) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sysmmu_=
block(data-&gt;sfrbases[i])) {<br>
@@ -899,6 +868,7 @@ static int __init exynos_sysmmu_probe(struct platform_d=
evice *pdev)<br>
<br>
=A0 =A0 =A0 =A0 ret =3D __sysmmu_setup(dev, data);<br>
=A0 =A0 =A0 =A0 if (!ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;runtime_active =3D !pm_runtime_enabl=
ed(dev);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;sysmmu =3D dev;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_init(&amp;data-&gt;lock);<br>
<br>
@@ -911,6 +881,64 @@ static int __init exynos_sysmmu_probe(struct platform_=
device *pdev)<br>
=A0 =A0 =A0 =A0 return ret;<br>
=A0}<br>
<br>
+#ifdef CONFIG_PM_SLEEP<br>
+static int sysmmu_suspend(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 struct sysmmu_drvdata *drvdata =3D dev_get_drvdata(dev);<br>
+ =A0 =A0 =A0 unsigned long flags;<br>
+ =A0 =A0 =A0 spin_lock_irqsave(&amp;drvdata-&gt;lock, flags);<br>
+ =A0 =A0 =A0 if (is_sysmmu_active(drvdata) &amp;&amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!pm_runtime_enabled(dev) || drvdata-&gt;runt=
ime_active))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_disable_nocount(drvdata);<br>
+ =A0 =A0 =A0 spin_unlock_irqrestore(&amp;drvdata-&gt;lock, flags);<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int sysmmu_resume(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 struct sysmmu_drvdata *drvdata =3D dev_get_drvdata(dev);<br>
+ =A0 =A0 =A0 unsigned long flags;<br>
+ =A0 =A0 =A0 spin_lock_irqsave(&amp;drvdata-&gt;lock, flags);<br>
+ =A0 =A0 =A0 if (is_sysmmu_active(drvdata) &amp;&amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!pm_runtime_enabled(dev) || drvdata-&gt;runt=
ime_active)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_enable_nocount(drvdata);<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 spin_unlock_irqrestore(&amp;drvdata-&gt;lock, flags);<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+#endif<br>
+<br>
+#ifdef CONFIG_PM_RUNTIME<br>
+static int sysmmu_runtime_suspend(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 struct sysmmu_drvdata *drvdata =3D dev_get_drvdata(dev);<br>
+ =A0 =A0 =A0 unsigned long flags;<br>
+ =A0 =A0 =A0 spin_lock_irqsave(&amp;drvdata-&gt;lock, flags);<br>
+ =A0 =A0 =A0 if (is_sysmmu_active(drvdata))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_disable_nocount(drvdata);<br>
+ =A0 =A0 =A0 drvdata-&gt;runtime_active =3D false;<br>
+ =A0 =A0 =A0 spin_unlock_irqrestore(&amp;drvdata-&gt;lock, flags);<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int sysmmu_runtime_resume(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 struct sysmmu_drvdata *drvdata =3D dev_get_drvdata(dev);<br>
+ =A0 =A0 =A0 unsigned long flags;<br>
+ =A0 =A0 =A0 spin_lock_irqsave(&amp;drvdata-&gt;lock, flags);<br>
+ =A0 =A0 =A0 drvdata-&gt;runtime_active =3D true;<br>
+ =A0 =A0 =A0 if (is_sysmmu_active(drvdata))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_enable_nocount(drvdata);<br>
+ =A0 =A0 =A0 spin_unlock_irqrestore(&amp;drvdata-&gt;lock, flags);<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+#endif<br>
+<br>
+static const struct dev_pm_ops __pm_ops =3D {<br>
+ =A0 =A0 =A0 SET_SYSTEM_SLEEP_PM_OPS(sysmmu_suspend, sysmmu_resume)<br>
+ =A0 =A0 =A0 SET_RUNTIME_PM_OPS(sysmmu_runtime_resume, sysmmu_runtime_susp=
end, NULL)<br></blockquote><div><br></div><div><div>The runtime PM ops are =
not set correctly. The suspend_fn should be first, followed</div><div>by re=
sume_fn as per=A0SET_RUNTIME_PM_OPS.</div>
<div><br></div><div>Thanks,</div><div>Prathyush</div></div><div>=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;pad=
ding-left:1ex">

+};<br>
+<br>
=A0/*<br>
=A0 * Descriptions of Device Tree node for System MMU<br>
=A0 *<br>
@@ -948,6 +976,7 @@ static struct platform_driver exynos_sysmmu_driver __re=
fdata =3D {<br>
=A0 =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,<=
br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot;exynos-=
sysmmu&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D &amp;__pm_ops=
,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D of_match_ptr(sysmmu_of_=
match),<br>
=A0 =A0 =A0 =A0 }<br>
=A0};<br>
@@ -1009,13 +1038,9 @@ static void exynos_iommu_domain_destroy(struct iommu=
_domain *domain)<br>
=A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;priv-&gt;lock, flags);<br>
<br>
=A0 =A0 =A0 =A0 list_for_each_entry_safe(owner, n, &amp;priv-&gt;clients, c=
lient) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device *sysmmu;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!__exynos_sysmmu_disable(owner-&gt;dev=
))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!exynos_sysmmu_disable(owner-&gt;dev))=
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ; /* until System MMU is ac=
tually disabled */<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del_init(&amp;owner-&gt;client);<br>
-<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_sysmmu(owner-&gt;dev, sysmmu)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(sysmmu);<br>
=A0 =A0 =A0 =A0 }<br>
<br>
=A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;priv-&gt;lock, flags);<br>
@@ -1038,7 +1063,6 @@ static int exynos_iommu_attach_device(struct iommu_do=
main *domain,<br>
=A0 =A0 =A0 =A0 struct exynos_iommu_domain *priv =3D domain-&gt;priv;<br>
=A0 =A0 =A0 =A0 unsigned long flags;<br>
=A0 =A0 =A0 =A0 int ret;<br>
- =A0 =A0 =A0 struct device *sysmmu;<br>
<br>
=A0 =A0 =A0 =A0 if (WARN_ON(!list_empty(&amp;owner-&gt;client))) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool found =3D false;<br>
@@ -1063,20 +1087,6 @@ static int exynos_iommu_attach_device(struct iommu_d=
omain *domain,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
=A0 =A0 =A0 =A0 }<br>
<br>
- =A0 =A0 =A0 for_each_sysmmu(dev, sysmmu) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_runtime_get_sync(sysmmu);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret &lt; 0)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
- =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 if (ret &lt; 0) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device *start;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_sysmmu_until(dev, start, sysmmu)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(start);<br>
-<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
- =A0 =A0 =A0 }<br>
-<br>
=A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;priv-&gt;lock, flags);<br>
<br>
=A0 =A0 =A0 =A0 ret =3D __exynos_sysmmu_enable(dev, __pa(priv-&gt;pgtable),=
 domain);<br>
@@ -1091,15 +1101,12 @@ static int exynos_iommu_attach_device(struct iommu_=
domain *domain,<br>
<br>
=A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;priv-&gt;lock, flags);<br>
<br>
- =A0 =A0 =A0 if (ret &lt; 0) {<br>
+ =A0 =A0 =A0 if (ret &lt; 0)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, &quot;%s: Failed to attach IOM=
MU with pgtable %#lx\n&quot;,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, _=
_pa(priv-&gt;pgtable));<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_sysmmu(dev, sysmmu)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(sysmmu);<br>
- =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 else<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, &quot;%s: Attached new IOMMU w=
ith pgtable 0x%lx\n&quot;,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 __func__, __pa(priv-&gt;pgtable));<br>
- =A0 =A0 =A0 }<br>
<br>
=A0 =A0 =A0 =A0 return ret;<br>
=A0}<br>
@@ -1115,7 +1122,7 @@ static void exynos_iommu_detach_device(struct iommu_d=
omain *domain,<br>
<br>
=A0 =A0 =A0 =A0 list_for_each_entry_safe(owner, n, &amp;priv-&gt;clients, c=
lient) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (owner =3D=3D dev-&gt;archdata.iommu) {<=
br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (__exynos_sysmmu_disable(d=
ev))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (exynos_sysmmu_disable(dev=
))<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del_in=
it(&amp;owner-&gt;client);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();<br>
@@ -1125,14 +1132,10 @@ static void exynos_iommu_detach_device(struct iommu=
_domain *domain,<br>
<br>
=A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;priv-&gt;lock, flags);<br>
<br>
- =A0 =A0 =A0 if (owner =3D=3D dev-&gt;archdata.iommu) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device *sysmmu;<br>
+ =A0 =A0 =A0 if (owner =3D=3D dev-&gt;archdata.iommu)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, &quot;%s: Detached IOMMU with =
pgtable %#lx\n&quot;,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 __func__, __pa(priv-&gt;pgtable));<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_sysmmu(dev, sysmmu)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(sysmmu);<br>
-<br>
- =A0 =A0 =A0 } else<br>
+ =A0 =A0 =A0 else<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, &quot;%s: No IOMMU is attached=
\n&quot;, __func__);<br>
=A0}<br>
<span class=3D""><font color=3D"#888888"><br>
--<br>
1.8.0<br>
<br>
<br>
_______________________________________________<br>
iommu mailing list<br>
<a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu-cunTk1MwBs9QetFLy7KEm2CgeU+1il2p@public.gmane.org=
ation.org</a><br>
<a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/iommu" target=
=3D"_blank">https://lists.linuxfoundation.org/mailman/listinfo/iommu</a><br=
>
</font></span></blockquote></div><br></div>

--047d7b2e43e647065b04cee8aabe--

--===============8276453655607152320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8276453655607152320==--
