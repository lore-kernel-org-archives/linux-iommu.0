From: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v9 2/2] iommu/exynos: Add iommu driver for Exynos Platforms
Date: Wed, 29 Feb 2012 14:25:45 +0900
Message-ID: <CAHQjnOOy__H8C0YAJq5TOD0Tv-18LRwaTosqp+pc9L8-Dq9TYw@mail.gmail.com>
References: <001a01ccf5e3$74a0d360$5de27a20$%cho@samsung.com>
	<CAH9JG2UDXdDwfsynPEZ8rN9_Wbw4axYDWnMHEU5GoHPFJvZ_Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAH9JG2UDXdDwfsynPEZ8rN9_Wbw4axYDWnMHEU5GoHPFJvZ_Rg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Subash Patel <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Younglak Kim <younglak1004.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sanghyun Lee <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 28, 2012 at 4:53 PM, Kyungmin Park
<kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> +void exynos_sysmmu_set_prefbuf(struct device *owner,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long =
base0, unsigned long size0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long =
base1, unsigned long size1)
>> +{
>> + =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(owner->archdat=
a.iommu);
>> + =A0 =A0 unsigned long flags;
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 BUG_ON((base0 + (size0 - 1)) <=3D base0);
>> + =A0 =A0 BUG_ON((base1 + (size1 - 1)) <=3D base1);
> Do you want to check size? BUG_ON(size <=3D 1);?

My mistake. :)
Thank you.

>> +
>> + =A0 =A0 read_lock_irqsave(&data->lock, flags);
>> + =A0 =A0 if (!is_sysmmu_active(data))
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto finish;
>> +
>> + =A0 =A0 for (i =3D 0; i < data->nsfrs; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((readl(data->sfrbases[i] + S5P_MMU_VERSION=
) >> 28) =3D=3D 3) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_block(data->sfrbases[i]=
);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (size1 =3D=3D 0) {
> Is it possible? if size1 is '0', it can't pass the BUG_ON condition.
Although the above BUG_ON condition is incorrect, it can pass if size1
and base1 are 0
because the type of them is unsigned.

>> +
>> + =A0 =A0 for (i =3D 0; i < data->nsfrs; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_set_ptbase(data->sfrbases[i], pgtable=
);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((readl(data->sfrbases[i] + S5P_MMU_VERSION=
) >> 28) =3D=3D 3) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* System MMU version is 3.x */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel((1 << 12) | (2 <<=
 28),
> Can you use the DEFINE instead of hard-code?

Do you think it is required even though it is used nowhere else here?

>> +static int exynos_iommu_attach_device(struct iommu_domain *domain,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
device *dev)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 struct exynos_iommu_domain *priv =3D domain->priv;
>> + =A0 =A0 struct iommu_client *client =3D NULL;
>> + =A0 =A0 struct list_head *pos;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 spin_lock_irqsave(&priv->lock, flags);
>> +
>> + =A0 =A0 list_for_each(pos, &priv->clients) {
> Simply list_for_each_entry.

Variable 'client' must not be used as a loop cursor
because its value must not be changed unless a condition meets.

>> + =A0 =A0 =A0 =A0 =A0 =A0 struct iommu_client *cur;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 cur =3D list_entry(pos, struct iommu_client, n=
ode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cur->dev =3D=3D dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 client =3D cur;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (client !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "%s: IOMMU with pgtable 0x%lx alr=
eady attached\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 __func__, __pa(priv->pgtable));
>> + =A0 =A0 =A0 =A0 =A0 =A0 client->refcnt++;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 spin_unlock_irqrestore(&priv->lock, flags);
>> +
>> + =A0 =A0 if (client !=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 client =3D kmalloc(sizeof(*client), GFP_KERNEL);
> Maybe attach called frequently. how about to use kmem_cache-*?
Thank you for advice.

>> + =A0 =A0 if (!client)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 INIT_LIST_HEAD(&client->node);
>> + =A0 =A0 client->dev =3D dev;
>> + =A0 =A0 client->refcnt =3D 1;
> Dose it possible attach more than one? OMAP has multiple attach codes.
Yes. This function returns earlier than this if client->refcnt is larger th=
an 1.
Please check "if (client !=3D NULL) return 0;" statement in this function.

>> + =A0 =A0 ret =3D __exynos_sysmmu_enable(dev, __pa(priv->pgtable), domai=
n);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(client);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 spin_lock_irqsave(&priv->lock, flags);
>> + =A0 =A0 list_add_tail(&client->node, &priv->clients);
>> + =A0 =A0 spin_unlock_irqrestore(&priv->lock, flags);
>> +
>> + =A0 =A0 dev_dbg(dev, "%s: Attached new IOMMU with pgtable 0x%lx\n", __=
func__,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 __pa(priv->pgtable));
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void exynos_iommu_detach_device(struct iommu_domain *domain,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 device *dev)
>> +{
>> + =A0 =A0 struct exynos_iommu_domain *priv =3D domain->priv;
>> + =A0 =A0 struct iommu_client *client =3D NULL;
>> + =A0 =A0 struct list_head *pos;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 spin_lock_irqsave(&priv->lock, flags);
>> +
>> + =A0 =A0 list_for_each(pos, &priv->clients) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct iommu_client *cur;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 cur =3D list_entry(pos, struct iommu_client, n=
ode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cur->dev =3D=3D dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur->refcnt--;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 client =3D cur;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 spin_unlock_irqrestore(&priv->lock, flags);
>> +
>> + =A0 =A0 if (WARN_ON(client =3D=3D NULL))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 if (client->refcnt > 0) {
> It never triggered. as you use true/false scheme. I remember you said
> previous patch. use the refcount but actual meaning is true/false.

I think you are talking about the conversations about v6 patchset.
client->refcnt is really a reference counter.

>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "%s: Detaching IOMMU with pgtable=
 0x%lx delayed\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 __func__, __pa(priv->pgtable));
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 BUG_ON(client->refcnt !=3D 0);
> Do you think "minus value"?

Yes. but I think it never be happened logically.
It is just "assert(client->refcnt =3D=3D 0)".
May it is better to remove the BUG_ON.


Thank you for kind review.

Cho KyongHo.
