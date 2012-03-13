From: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v11 3/3] iommu/exynos: Add iommu driver for Exynos
	Platforms
Date: Tue, 13 Mar 2012 17:50:16 +0900
Message-ID: <CAHQjnOOCQb4G1aeFB0FQVBstXpaXmahnQO8+FoinPcQNZEieGg@mail.gmail.com>
References: <017a01ccfdee$4e5e7a00$eb1b6e00$%cho@samsung.com>
	<20120312150156.GF18973@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120312150156.GF18973-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Younglak Kim <younglak1004.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Subash Patel <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sanghyun Lee <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 13, 2012 at 12:01 AM, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org> wrote:
> On Fri, Mar 09, 2012 at 09:15:24PM +0900, Cho KyongHo wrote:
>> +/* We does not consider super section mapping (16MB) */
>> +struct iommu_client {
>> + =A0 =A0 struct list_head node;
>> + =A0 =A0 struct device *dev;
>> +};
>> +
>> +struct exynos_iommu_domain {
>> + =A0 =A0 struct list_head clients; /* list of iommu_client */
>> + =A0 =A0 unsigned long *pgtable; /* lv1 page table, 16KB */
>> + =A0 =A0 short *lv2entcnt; /* free lv2 entry counter for each section */
>> + =A0 =A0 spinlock_t lock; /* lock for this structure and attached iommu=
_client */
>> + =A0 =A0 spinlock_t pgtablelock; /* lock for modifying page table @ pgt=
able */
>> +};
>> +
>> +struct sysmmu_drvdata {
>> + =A0 =A0 struct device *sysmmu;
>> + =A0 =A0 char *dbgname;
>> + =A0 =A0 int nsfrs;
>> + =A0 =A0 void __iomem **sfrbases;
>> + =A0 =A0 struct clk *clk[2];
>> + =A0 =A0 int activations;
>> + =A0 =A0 rwlock_t lock;
>> + =A0 =A0 struct iommu_domain *domain;
>> + =A0 =A0 sysmmu_fault_handler_t fault_handler;
>> + =A0 =A0 unsigned long pgtable;
>> + =A0 =A0 struct iommu_client client;
>> +};
>
> Is there any reason why 'struct iommu_client' is a seperate data
> structure? Otherwise it can be merged with 'truct sysmmu_drvdata'.
>

There is no reason to separate it.
It is not cleanly refactored since patch version 10.

>> +static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
>> +{
>> + =A0 =A0 struct exynos_iommu_domain *priv =3D domain->priv;
>> + =A0 =A0 struct list_head *pos, *n;
>> + =A0 =A0 unsigned long flags;
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 WARN_ON(!list_empty(&priv->clients));
>> +
>> + =A0 =A0 spin_lock_irqsave(&priv->lock, flags);
>> +
>> + =A0 =A0 list_for_each_safe(pos, n, &priv->clients) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct iommu_client *client;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 client =3D list_entry(pos, struct iommu_client=
, node);
>> + =A0 =A0 =A0 =A0 =A0 =A0 exynos_sysmmu_disable(client->dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(client);
>> + =A0 =A0 }
>
> Why this kfree here? Aren't all iommu_clients just a part of another
> data-structre?

It is absolutely my fault. It must be removed.
I have forgot to care about updating iommu_domain_destroy()
when modifying exynos_iommu_attach/detach_device().

Thank you.

The problems will be soon fixed and I will post next patch tomorrow.

Cho KyongHo/
