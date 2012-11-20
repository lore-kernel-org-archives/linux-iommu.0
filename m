From: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 09/12] iommu/exynos: add supoort for runtime pm and
	suspend/resume
Date: Tue, 20 Nov 2012 18:05:55 +0900
Message-ID: <CAHQjnOOj7sXWrc=d11ytykas4MHHstYws4F0kgx6PFx7bttQyw@mail.gmail.com>
References: <002301cdc6f0$f1a1dce0$d4e596a0$%cho@samsung.com>
	<CAH=HWYPkS0i4jo8X4XGiCd417dnUn88TtscxMqCAcH8fOq4M=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3636514475384528078=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAH=HWYPkS0i4jo8X4XGiCd417dnUn88TtscxMqCAcH8fOq4M=w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Prathyush K <prathyush-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush K <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Subash Patel <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sanghyun Lee <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============3636514475384528078==
Content-Type: multipart/alternative; boundary=f46d0408394da2351104cee98ae7

--f46d0408394da2351104cee98ae7
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Nov 20, 2012 at 5:03 PM, Prathyush K <prathyush-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> On Tue, Nov 20, 2012 at 1:00 PM, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
wrote:
>>
>> This change enables the client device drivers not to care about
>> the state of System MMU since the internal state of System MMU
>> is controlled by the runtime PM and suspend/resume callback functions.
>>
>> Signed-off-by: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>>  drivers/iommu/exynos-iommu.c | 175
>> ++++++++++++++++++++++---------------------
>>  1 file changed, 89 insertions(+), 86 deletions(-)
>>
>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>> index 8f9239c..169f56e 100644
>> --- a/drivers/iommu/exynos-iommu.c
>> +++ b/drivers/iommu/exynos-iommu.c
>> @@ -208,6 +208,7 @@ struct sysmmu_drvdata {
>>         struct iommu_domain *domain;
>>         sysmmu_fault_handler_t fault_handler;
>>         unsigned long pgtable;
>> +       bool runtime_active;
>>         void __iomem *sfrbases[0];
>>  };
>>
>> @@ -477,7 +478,8 @@ static bool __sysmmu_disable(struct sysmmu_drvdata
>> *drvdata)
>>                 drvdata->pgtable = 0;
>>                 drvdata->domain = NULL;
>>
>> -               __sysmmu_disable_nocount(drvdata);
>> +               if (drvdata->runtime_active)
>> +                       __sysmmu_disable_nocount(drvdata);
>>
>>                 dev_dbg(drvdata->sysmmu, "Disabled\n");
>>         } else  {
>> @@ -490,30 +492,6 @@ static bool __sysmmu_disable(struct sysmmu_drvdata
>> *drvdata)
>>         return disabled;
>>  }
>>
>> -static bool __exynos_sysmmu_disable(struct device *dev)
>> -{
>> -       unsigned long flags;
>> -       bool disabled = true;
>> -       struct exynos_iommu_owner *owner = dev->archdata.iommu;
>> -       struct device *sysmmu;
>> -
>> -       BUG_ON(!has_sysmmu(dev));
>> -
>> -       spin_lock_irqsave(&owner->lock, flags);
>> -
>> -       /* Every call to __sysmmu_disable() must return same result */
>> -       for_each_sysmmu(dev, sysmmu) {
>> -               struct sysmmu_drvdata *drvdata = dev_get_drvdata(sysmmu);
>> -               disabled = __sysmmu_disable(drvdata);
>> -               if (disabled)
>> -                       drvdata->master = NULL;
>> -       }
>> -
>> -       spin_unlock_irqrestore(&owner->lock, flags);
>> -
>> -       return disabled;
>> -}
>> -
>>  static void __sysmmu_enable_nocount(struct sysmmu_drvdata *drvdata)
>>  {
>>         int i;
>> @@ -554,7 +532,8 @@ static int __sysmmu_enable(struct sysmmu_drvdata
>> *drvdata,
>>                 drvdata->pgtable = pgtable;
>>                 drvdata->domain = domain;
>>
>> -               __sysmmu_enable_nocount(drvdata);
>> +               if (drvdata->runtime_active)
>> +                       __sysmmu_enable_nocount(drvdata);
>>
>>                 dev_dbg(drvdata->sysmmu, "Enabled\n");
>>         } else {
>> @@ -610,42 +589,31 @@ static int __exynos_sysmmu_enable(struct device
>> *dev, unsigned long pgtable,
>>
>>  int exynos_sysmmu_enable(struct device *dev, unsigned long pgtable)
>>  {
>> -       int ret;
>> -       struct device *sysmmu;
>> -
>>         BUG_ON(!memblock_is_memory(pgtable));
>>
>> -       for_each_sysmmu(dev, sysmmu) {
>> -               ret = pm_runtime_get_sync(sysmmu);
>> -               if (ret < 0)
>> -                       break;
>> -       }
>> -
>> -       if (ret < 0) {
>> -               struct device *start;
>> -               for_each_sysmmu_until(dev, start, sysmmu)
>> -                       pm_runtime_put(start);
>> -
>> -               return ret;
>> -       }
>> -
>> -       ret = __exynos_sysmmu_enable(dev, pgtable, NULL);
>> -       if (ret < 0)
>> -               for_each_sysmmu(dev, sysmmu)
>> -                       pm_runtime_put(sysmmu);
>> -
>> -       return ret;
>> +       return __exynos_sysmmu_enable(dev, pgtable, NULL);
>>  }
>>
>>  bool exynos_sysmmu_disable(struct device *dev)
>>  {
>> -       bool disabled;
>> +       unsigned long flags;
>> +       bool disabled = true;
>> +       struct exynos_iommu_owner *owner = dev->archdata.iommu;
>>         struct device *sysmmu;
>>
>> -       disabled = __exynos_sysmmu_disable(dev);
>> +       BUG_ON(!has_sysmmu(dev));
>>
>> -       for_each_sysmmu(dev, sysmmu)
>> -               pm_runtime_put(sysmmu);
>> +       spin_lock_irqsave(&owner->lock, flags);
>> +
>> +       /* Every call to __sysmmu_disable() must return same result */
>> +       for_each_sysmmu(dev, sysmmu) {
>> +               struct sysmmu_drvdata *drvdata = dev_get_drvdata(sysmmu);
>> +               disabled = __sysmmu_disable(drvdata);
>> +               if (disabled)
>> +                       drvdata->master = NULL;
>> +       }
>> +
>> +       spin_unlock_irqrestore(&owner->lock, flags);
>>
>>         return disabled;
>>  }
>> @@ -661,7 +629,8 @@ static void sysmmu_tlb_invalidate_entry(struct device
>> *dev, unsigned long iova)
>>                 data = dev_get_drvdata(sysmmu);
>>
>>                 spin_lock_irqsave(&data->lock, flags);
>> -               if (is_sysmmu_active(data)) {
>> +               if (is_sysmmu_active(data) &&
>> +                               data->runtime_active) {
>>                         int i;
>>                         for (i = 0; i < data->nsfrs; i++) {
>>                                 if (sysmmu_block(data->sfrbases[i])) {
>> @@ -899,6 +868,7 @@ static int __init exynos_sysmmu_probe(struct
>> platform_device *pdev)
>>
>>         ret = __sysmmu_setup(dev, data);
>>         if (!ret) {
>> +               data->runtime_active = !pm_runtime_enabled(dev);
>>                 data->sysmmu = dev;
>>                 spin_lock_init(&data->lock);
>>
>> @@ -911,6 +881,64 @@ static int __init exynos_sysmmu_probe(struct
>> platform_device *pdev)
>>         return ret;
>>  }
>>
>> +#ifdef CONFIG_PM_SLEEP
>> +static int sysmmu_suspend(struct device *dev)
>> +{
>> +       struct sysmmu_drvdata *drvdata = dev_get_drvdata(dev);
>> +       unsigned long flags;
>> +       spin_lock_irqsave(&drvdata->lock, flags);
>> +       if (is_sysmmu_active(drvdata) &&
>> +               (!pm_runtime_enabled(dev) || drvdata->runtime_active))
>> +               __sysmmu_disable_nocount(drvdata);
>> +       spin_unlock_irqrestore(&drvdata->lock, flags);
>> +       return 0;
>> +}
>> +
>> +static int sysmmu_resume(struct device *dev)
>> +{
>> +       struct sysmmu_drvdata *drvdata = dev_get_drvdata(dev);
>> +       unsigned long flags;
>> +       spin_lock_irqsave(&drvdata->lock, flags);
>> +       if (is_sysmmu_active(drvdata) &&
>> +               (!pm_runtime_enabled(dev) || drvdata->runtime_active)) {
>> +               __sysmmu_enable_nocount(drvdata);
>> +       }
>> +       spin_unlock_irqrestore(&drvdata->lock, flags);
>> +       return 0;
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_PM_RUNTIME
>> +static int sysmmu_runtime_suspend(struct device *dev)
>> +{
>> +       struct sysmmu_drvdata *drvdata = dev_get_drvdata(dev);
>> +       unsigned long flags;
>> +       spin_lock_irqsave(&drvdata->lock, flags);
>> +       if (is_sysmmu_active(drvdata))
>> +               __sysmmu_disable_nocount(drvdata);
>> +       drvdata->runtime_active = false;
>> +       spin_unlock_irqrestore(&drvdata->lock, flags);
>> +       return 0;
>> +}
>> +
>> +static int sysmmu_runtime_resume(struct device *dev)
>> +{
>> +       struct sysmmu_drvdata *drvdata = dev_get_drvdata(dev);
>> +       unsigned long flags;
>> +       spin_lock_irqsave(&drvdata->lock, flags);
>> +       drvdata->runtime_active = true;
>> +       if (is_sysmmu_active(drvdata))
>> +               __sysmmu_enable_nocount(drvdata);
>> +       spin_unlock_irqrestore(&drvdata->lock, flags);
>> +       return 0;
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops __pm_ops = {
>> +       SET_SYSTEM_SLEEP_PM_OPS(sysmmu_suspend, sysmmu_resume)
>> +       SET_RUNTIME_PM_OPS(sysmmu_runtime_resume, sysmmu_runtime_suspend,
>> NULL)
>
>
> The runtime PM ops are not set correctly. The suspend_fn should be first,
> followed
> by resume_fn as per SET_RUNTIME_PM_OPS.
>
> Thanks,
> Prathyush
>

Thank you.
I missed that. It will be fixed in the next version of this patch.

Cho KyongHo.

--f46d0408394da2351104cee98ae7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>On Tue, Nov 20, 2012 at 5:03 PM, Prathyush K &lt;<a href=3D"mailto:prat=
hyush-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">prathyush-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org</a>&gt; wrote:<br>&gt; On Tue, N=
ov 20, 2012 at 1:00 PM, Cho KyongHo &lt;<a href=3D"mailto:pullip.cho@samsun=
g.com">pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;<br>&gt;&gt; This change enables the client device drivers not to c=
are about<br>&gt;&gt; the state of System MMU since the internal state of S=
ystem MMU<br>&gt;&gt; is controlled by the runtime PM and suspend/resume ca=
llback functions.<br>
&gt;&gt;<br>&gt;&gt; Signed-off-by: KyongHo Cho &lt;<a href=3D"mailto:pulli=
p.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>&gt;&gt; ---<br>&gt;&g=
t; =A0drivers/iommu/exynos-iommu.c | 175<br>&gt;&gt; ++++++++++++++++++++++=
---------------------<br>
&gt;&gt; =A01 file changed, 89 insertions(+), 86 deletions(-)<br>&gt;&gt;<b=
r>&gt;&gt; diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos=
-iommu.c<br>&gt;&gt; index 8f9239c..169f56e 100644<br>&gt;&gt; --- a/driver=
s/iommu/exynos-iommu.c<br>
&gt;&gt; +++ b/drivers/iommu/exynos-iommu.c<br>&gt;&gt; @@ -208,6 +208,7 @@=
 struct sysmmu_drvdata {<br>&gt;&gt; =A0 =A0 =A0 =A0 struct iommu_domain *d=
omain;<br>&gt;&gt; =A0 =A0 =A0 =A0 sysmmu_fault_handler_t fault_handler;<br=
>&gt;&gt; =A0 =A0 =A0 =A0 unsigned long pgtable;<br>
&gt;&gt; + =A0 =A0 =A0 bool runtime_active;<br>&gt;&gt; =A0 =A0 =A0 =A0 voi=
d __iomem *sfrbases[0];<br>&gt;&gt; =A0};<br>&gt;&gt;<br>&gt;&gt; @@ -477,7=
 +478,8 @@ static bool __sysmmu_disable(struct sysmmu_drvdata<br>&gt;&gt; *=
drvdata)<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata-&gt;pgtable =3D 0;<br>&gt;=
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata-&gt;domain =3D NULL;<br>&gt;&g=
t;<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_disable_nocount(drvda=
ta);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drvdata-&gt;runtime_acti=
ve)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_disable_noc=
ount(drvdata);<br>&gt;&gt;<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_=
dbg(drvdata-&gt;sysmmu, &quot;Disabled\n&quot;);<br>&gt;&gt; =A0 =A0 =A0 =
=A0 } else =A0{<br>&gt;&gt; @@ -490,30 +492,6 @@ static bool __sysmmu_disab=
le(struct sysmmu_drvdata<br>
&gt;&gt; *drvdata)<br>&gt;&gt; =A0 =A0 =A0 =A0 return disabled;<br>&gt;&gt;=
 =A0}<br>&gt;&gt;<br>&gt;&gt; -static bool __exynos_sysmmu_disable(struct d=
evice *dev)<br>&gt;&gt; -{<br>&gt;&gt; - =A0 =A0 =A0 unsigned long flags;<b=
r>&gt;&gt; - =A0 =A0 =A0 bool disabled =3D true;<br>
&gt;&gt; - =A0 =A0 =A0 struct exynos_iommu_owner *owner =3D dev-&gt;archdat=
a.iommu;<br>&gt;&gt; - =A0 =A0 =A0 struct device *sysmmu;<br>&gt;&gt; -<br>=
&gt;&gt; - =A0 =A0 =A0 BUG_ON(!has_sysmmu(dev));<br>&gt;&gt; -<br>&gt;&gt; =
- =A0 =A0 =A0 spin_lock_irqsave(&amp;owner-&gt;lock, flags);<br>
&gt;&gt; -<br>&gt;&gt; - =A0 =A0 =A0 /* Every call to __sysmmu_disable() mu=
st return same result */<br>&gt;&gt; - =A0 =A0 =A0 for_each_sysmmu(dev, sys=
mmu) {<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sysmmu_drvdata *drv=
data =3D dev_get_drvdata(sysmmu);<br>
&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 disabled =3D __sysmmu_disable(drvdat=
a);<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (disabled)<br>&gt;&gt; - =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata-&gt;master =3D NULL;<br=
>&gt;&gt; - =A0 =A0 =A0 }<br>&gt;&gt; -<br>&gt;&gt; - =A0 =A0 =A0 spin_unlo=
ck_irqrestore(&amp;owner-&gt;lock, flags);<br>
&gt;&gt; -<br>&gt;&gt; - =A0 =A0 =A0 return disabled;<br>&gt;&gt; -}<br>&gt=
;&gt; -<br>&gt;&gt; =A0static void __sysmmu_enable_nocount(struct sysmmu_dr=
vdata *drvdata)<br>&gt;&gt; =A0{<br>&gt;&gt; =A0 =A0 =A0 =A0 int i;<br>&gt;=
&gt; @@ -554,7 +532,8 @@ static int __sysmmu_enable(struct sysmmu_drvdata<b=
r>
&gt;&gt; *drvdata,<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata-&gt;=
pgtable =3D pgtable;<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata-&g=
t;domain =3D domain;<br>&gt;&gt;<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
__sysmmu_enable_nocount(drvdata);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 if (drvdata-&gt;runtime_active)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_enable_noco=
unt(drvdata);<br>&gt;&gt;<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_d=
bg(drvdata-&gt;sysmmu, &quot;Enabled\n&quot;);<br>&gt;&gt; =A0 =A0 =A0 =A0 =
} else {<br>&gt;&gt; @@ -610,42 +589,31 @@ static int __exynos_sysmmu_enabl=
e(struct device<br>
&gt;&gt; *dev, unsigned long pgtable,<br>&gt;&gt;<br>&gt;&gt; =A0int exynos=
_sysmmu_enable(struct device *dev, unsigned long pgtable)<br>&gt;&gt; =A0{<=
br>&gt;&gt; - =A0 =A0 =A0 int ret;<br>&gt;&gt; - =A0 =A0 =A0 struct device =
*sysmmu;<br>
&gt;&gt; -<br>&gt;&gt; =A0 =A0 =A0 =A0 BUG_ON(!memblock_is_memory(pgtable))=
;<br>&gt;&gt;<br>&gt;&gt; - =A0 =A0 =A0 for_each_sysmmu(dev, sysmmu) {<br>&=
gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_runtime_get_sync(sysmmu);<=
br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret &lt; 0)<br>
&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>&gt;&gt; -=
 =A0 =A0 =A0 }<br>&gt;&gt; -<br>&gt;&gt; - =A0 =A0 =A0 if (ret &lt; 0) {<br=
>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device *start;<br>&gt;&gt; -=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_sysmmu_until(dev, start, sysmmu)<br>
&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(start=
);<br>&gt;&gt; -<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>&=
gt;&gt; - =A0 =A0 =A0 }<br>&gt;&gt; -<br>&gt;&gt; - =A0 =A0 =A0 ret =3D __e=
xynos_sysmmu_enable(dev, pgtable, NULL);<br>&gt;&gt; - =A0 =A0 =A0 if (ret =
&lt; 0)<br>
&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_sysmmu(dev, sysmmu)<br>&gt;=
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(sysmmu);<=
br>&gt;&gt; -<br>&gt;&gt; - =A0 =A0 =A0 return ret;<br>&gt;&gt; + =A0 =A0 =
=A0 return __exynos_sysmmu_enable(dev, pgtable, NULL);<br>
&gt;&gt; =A0}<br>&gt;&gt;<br>&gt;&gt; =A0bool exynos_sysmmu_disable(struct =
device *dev)<br>&gt;&gt; =A0{<br>&gt;&gt; - =A0 =A0 =A0 bool disabled;<br>&=
gt;&gt; + =A0 =A0 =A0 unsigned long flags;<br>&gt;&gt; + =A0 =A0 =A0 bool d=
isabled =3D true;<br>&gt;&gt; + =A0 =A0 =A0 struct exynos_iommu_owner *owne=
r =3D dev-&gt;archdata.iommu;<br>
&gt;&gt; =A0 =A0 =A0 =A0 struct device *sysmmu;<br>&gt;&gt;<br>&gt;&gt; - =
=A0 =A0 =A0 disabled =3D __exynos_sysmmu_disable(dev);<br>&gt;&gt; + =A0 =
=A0 =A0 BUG_ON(!has_sysmmu(dev));<br>&gt;&gt;<br>&gt;&gt; - =A0 =A0 =A0 for=
_each_sysmmu(dev, sysmmu)<br>
&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(sysmmu);<br>&gt;&gt; =
+ =A0 =A0 =A0 spin_lock_irqsave(&amp;owner-&gt;lock, flags);<br>&gt;&gt; +<=
br>&gt;&gt; + =A0 =A0 =A0 /* Every call to __sysmmu_disable() must return s=
ame result */<br>&gt;&gt; + =A0 =A0 =A0 for_each_sysmmu(dev, sysmmu) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sysmmu_drvdata *drvdata =3D d=
ev_get_drvdata(sysmmu);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 disabled =
=3D __sysmmu_disable(drvdata);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if=
 (disabled)<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvda=
ta-&gt;master =3D NULL;<br>
&gt;&gt; + =A0 =A0 =A0 }<br>&gt;&gt; +<br>&gt;&gt; + =A0 =A0 =A0 spin_unloc=
k_irqrestore(&amp;owner-&gt;lock, flags);<br>&gt;&gt;<br>&gt;&gt; =A0 =A0 =
=A0 =A0 return disabled;<br>&gt;&gt; =A0}<br>&gt;&gt; @@ -661,7 +629,8 @@ s=
tatic void sysmmu_tlb_invalidate_entry(struct device<br>
&gt;&gt; *dev, unsigned long iova)<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 data =3D dev_get_drvdata(sysmmu);<br>&gt;&gt;<br>&gt;&gt; =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;data-&gt;lock, flags);<br>&gt;&g=
t; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_sysmmu_active(data)) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_sysmmu_active(data) &amp;&amp=
;<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 data-&gt;runtime_active) {<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 int i;<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 for (i =3D 0; i &lt; data-&gt;nsfrs; i++) {<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if=
 (sysmmu_block(data-&gt;sfrbases[i])) {<br>&gt;&gt; @@ -899,6 +868,7 @@ sta=
tic int __init exynos_sysmmu_probe(struct<br>&gt;&gt; platform_device *pdev=
)<br>&gt;&gt;<br>&gt;&gt; =A0 =A0 =A0 =A0 ret =3D __sysmmu_setup(dev, data)=
;<br>
&gt;&gt; =A0 =A0 =A0 =A0 if (!ret) {<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 data-&gt;runtime_active =3D !pm_runtime_enabled(dev);<br>&gt;&gt; =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;sysmmu =3D dev;<br>&gt;&gt; =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 spin_lock_init(&amp;data-&gt;lock);<br>
&gt;&gt;<br>&gt;&gt; @@ -911,6 +881,64 @@ static int __init exynos_sysmmu_p=
robe(struct<br>&gt;&gt; platform_device *pdev)<br>&gt;&gt; =A0 =A0 =A0 =A0 =
return ret;<br>&gt;&gt; =A0}<br>&gt;&gt;<br>&gt;&gt; +#ifdef CONFIG_PM_SLEE=
P<br>&gt;&gt; +static int sysmmu_suspend(struct device *dev)<br>
&gt;&gt; +{<br>&gt;&gt; + =A0 =A0 =A0 struct sysmmu_drvdata *drvdata =3D de=
v_get_drvdata(dev);<br>&gt;&gt; + =A0 =A0 =A0 unsigned long flags;<br>&gt;&=
gt; + =A0 =A0 =A0 spin_lock_irqsave(&amp;drvdata-&gt;lock, flags);<br>&gt;&=
gt; + =A0 =A0 =A0 if (is_sysmmu_active(drvdata) &amp;&amp;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!pm_runtime_enabled(dev) || drvdata=
-&gt;runtime_active))<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_di=
sable_nocount(drvdata);<br>&gt;&gt; + =A0 =A0 =A0 spin_unlock_irqrestore(&a=
mp;drvdata-&gt;lock, flags);<br>
&gt;&gt; + =A0 =A0 =A0 return 0;<br>&gt;&gt; +}<br>&gt;&gt; +<br>&gt;&gt; +=
static int sysmmu_resume(struct device *dev)<br>&gt;&gt; +{<br>&gt;&gt; + =
=A0 =A0 =A0 struct sysmmu_drvdata *drvdata =3D dev_get_drvdata(dev);<br>&gt=
;&gt; + =A0 =A0 =A0 unsigned long flags;<br>
&gt;&gt; + =A0 =A0 =A0 spin_lock_irqsave(&amp;drvdata-&gt;lock, flags);<br>=
&gt;&gt; + =A0 =A0 =A0 if (is_sysmmu_active(drvdata) &amp;&amp;<br>&gt;&gt;=
 + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!pm_runtime_enabled(dev) || drvdata-&gt;run=
time_active)) {<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_enable_n=
ocount(drvdata);<br>
&gt;&gt; + =A0 =A0 =A0 }<br>&gt;&gt; + =A0 =A0 =A0 spin_unlock_irqrestore(&=
amp;drvdata-&gt;lock, flags);<br>&gt;&gt; + =A0 =A0 =A0 return 0;<br>&gt;&g=
t; +}<br>&gt;&gt; +#endif<br>&gt;&gt; +<br>&gt;&gt; +#ifdef CONFIG_PM_RUNTI=
ME<br>&gt;&gt; +static int sysmmu_runtime_suspend(struct device *dev)<br>
&gt;&gt; +{<br>&gt;&gt; + =A0 =A0 =A0 struct sysmmu_drvdata *drvdata =3D de=
v_get_drvdata(dev);<br>&gt;&gt; + =A0 =A0 =A0 unsigned long flags;<br>&gt;&=
gt; + =A0 =A0 =A0 spin_lock_irqsave(&amp;drvdata-&gt;lock, flags);<br>&gt;&=
gt; + =A0 =A0 =A0 if (is_sysmmu_active(drvdata))<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_disable_nocount(drvdata);<b=
r>&gt;&gt; + =A0 =A0 =A0 drvdata-&gt;runtime_active =3D false;<br>&gt;&gt; =
+ =A0 =A0 =A0 spin_unlock_irqrestore(&amp;drvdata-&gt;lock, flags);<br>&gt;=
&gt; + =A0 =A0 =A0 return 0;<br>
&gt;&gt; +}<br>&gt;&gt; +<br>&gt;&gt; +static int sysmmu_runtime_resume(str=
uct device *dev)<br>&gt;&gt; +{<br>&gt;&gt; + =A0 =A0 =A0 struct sysmmu_drv=
data *drvdata =3D dev_get_drvdata(dev);<br>&gt;&gt; + =A0 =A0 =A0 unsigned =
long flags;<br>
&gt;&gt; + =A0 =A0 =A0 spin_lock_irqsave(&amp;drvdata-&gt;lock, flags);<br>=
&gt;&gt; + =A0 =A0 =A0 drvdata-&gt;runtime_active =3D true;<br>&gt;&gt; + =
=A0 =A0 =A0 if (is_sysmmu_active(drvdata))<br>&gt;&gt; + =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 __sysmmu_enable_nocount(drvdata);<br>
&gt;&gt; + =A0 =A0 =A0 spin_unlock_irqrestore(&amp;drvdata-&gt;lock, flags)=
;<br>&gt;&gt; + =A0 =A0 =A0 return 0;<br>&gt;&gt; +}<br>&gt;&gt; +#endif<br=
>&gt;&gt; +<br>&gt;&gt; +static const struct dev_pm_ops __pm_ops =3D {<br>&=
gt;&gt; + =A0 =A0 =A0 SET_SYSTEM_SLEEP_PM_OPS(sysmmu_suspend, sysmmu_resume=
)<br>
&gt;&gt; + =A0 =A0 =A0 SET_RUNTIME_PM_OPS(sysmmu_runtime_resume, sysmmu_run=
time_suspend,<br>&gt;&gt; NULL)<br>&gt;<br>&gt;<br>&gt; The runtime PM ops =
are not set correctly. The suspend_fn should be first,<br>&gt; followed<br>=
&gt; by resume_fn as per SET_RUNTIME_PM_OPS.<br>
&gt;<br>&gt; Thanks,<br>&gt; Prathyush<br>&gt;<br><br>Thank you.<br>I misse=
d that. It will be fixed in the next version of this patch.<br><br>Cho Kyon=
gHo.<br>

--f46d0408394da2351104cee98ae7--

--===============3636514475384528078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3636514475384528078==--
