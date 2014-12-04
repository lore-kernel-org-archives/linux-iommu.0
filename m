From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 1/8] iommu: provide early initialisation hook for IOMMU
	drivers
Date: Thu, 04 Dec 2014 13:43:32 +0000
Message-ID: <54806504.20507@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<CAL_JsqKHvh9KSTYrrs1Pts5Kg=8dA1V6NiW57_2vdDH173qQGg@mail.gmail.com>
	<CACxGe6vyMkyE9ZRj_FQzi19ESEo7OV_RQoVV65xBYpdQV8cRGQ@mail.gmail.com>
	<2579924.PPXuLn3o19@wuerfel> <54805312.6000402@arm.com>
	<CACxGe6uR5J4Cjdh_xYhBPoQRgeYwHPv5=AnuRmQKSD3yZrMK9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CACxGe6uR5J4Cjdh_xYhBPoQRgeYwHPv5=AnuRmQKSD3yZrMK9Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Grant, thanks for the advice - silly micro-optimisations removed, and 
I'll make a note to do so from my in-development code, too ;)

I didn't much like the casting either, so rather than push it elsewhere 
or out to the caller I've just changed the prototype to obviate it 
completely. Since we're also expecting to churn this again to use 
something more suitable than iommu_ops as the private data, I think 
keeping things simple wins over const-correctness for now.

Thanks,
Robin

--->8---
 From b2e8c91ac49bef4008661e4628cd6b7249d84af5 Mon Sep 17 00:00:00 2001
Message-Id: 
<b2e8c91ac49bef4008661e4628cd6b7249d84af5.1417698001.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Date: Thu, 4 Dec 2014 11:53:13 +0000
Subject: [PATCH v2] iommu: store DT-probed IOMMU data privately

Since the data pointer in the DT node is public and may be overwritten
by conflicting code, move the DT-probed IOMMU ops to a private list
where they will be safe.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
  drivers/iommu/of_iommu.c | 40 ++++++++++++++++++++++++++++++++++++++++
  include/linux/of_iommu.h | 12 ++----------
  2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 73236d3..c7078f6 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -94,6 +94,46 @@ int of_get_dma_window(struct device_node *dn, const 
char *prefix, int index,
  }
  EXPORT_SYMBOL_GPL(of_get_dma_window);

+struct of_iommu_node {
+	struct list_head list;
+	struct device_node *np;
+	struct iommu_ops *ops;
+};
+static LIST_HEAD(of_iommu_list);
+static DEFINE_SPINLOCK(of_iommu_lock);
+
+void of_iommu_set_ops(struct device_node *np, struct iommu_ops *ops)
+{
+	struct of_iommu_node *iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
+
+	if (!iommu) {
+		__WARN();
+		return;
+	}
+
+	INIT_LIST_HEAD(&iommu->list);
+	iommu->np = np;
+	iommu->ops = ops;
+	spin_lock(&of_iommu_lock);
+	list_add_tail(&iommu->list, &of_iommu_list);
+	spin_unlock(&of_iommu_lock);
+}
+
+struct iommu_ops *of_iommu_get_ops(struct device_node *np)
+{
+	struct of_iommu_node *node;
+	struct iommu_ops *ops = NULL;
+
+	spin_lock(&of_iommu_lock);
+	list_for_each_entry(node, &of_iommu_list, list)
+		if (node->np == np) {
+			ops = node->ops;
+			break;
+		}
+	spin_unlock(&of_iommu_lock);
+	return ops;
+}
+
  struct iommu_ops *of_iommu_configure(struct device *dev)
  {
  	struct of_phandle_args iommu_spec;
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index d03abbb..16c7554 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -31,16 +31,8 @@ static inline struct iommu_ops 
*of_iommu_configure(struct device *dev)

  #endif	/* CONFIG_OF_IOMMU */

-static inline void of_iommu_set_ops(struct device_node *np,
-				    const struct iommu_ops *ops)
-{
-	np->data = (struct iommu_ops *)ops;
-}
-
-static inline struct iommu_ops *of_iommu_get_ops(struct device_node *np)
-{
-	return np->data;
-}
+void of_iommu_set_ops(struct device_node *np, struct iommu_ops *ops);
+struct iommu_ops *of_iommu_get_ops(struct device_node *np);

  extern struct of_device_id __iommu_of_table;

-- 
1.9.1

On 04/12/14 12:42, Grant Likely wrote:
> On Thu, Dec 4, 2014 at 12:26 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>> Hi Arnd,
>>
>> On 03/12/14 19:57, Arnd Bergmann wrote:
>> [...]
>>>>
>>>> Good catch. This is not good. The data pointer should be avoided since
>>>> there are no controls over its use. Until a better solution can be
>>>> implemented, probably the safest thing to do is add a struct iommu_ops
>>>> pointer to struct device_node. However, assuming that only a small
>>>> portion of nodes will actually have iommu_ops set, I'd rather see a
>>>> separate registry that matches device_nodes to iommu_ops.
>>>
>>>
>>> Fair enough. Will, can you take a copy of drivers/dma/of-dma.c and
>>> adapt it as needed? It should be exactly what we need to start
>>> out and can be extended and generalized later.
>>
>>
>> I'm quite keen to see this series go in, since I'm depending on it to make
>> arm64 IOMMU DMA ops "just work". Will and I came to the conclusion the other
>> day that we pretty much need to build up some kind of bus abstraction based
>> on the probe data in order to be able to assign IOMMU groups correctly,
>> which can also subsume this particular problem in the long run. Since I've
>> made a start on that already, I've hacked the following short-term fix out
>> of it. Tested on my Juno - admittedly with only two SMMUs and one master
>> (EHCI) being probed, but it didn't blow up or regress anything.
>>
>> Regards,
>> Robin.
>>
>> --->8---
>>  From 1f3d2612682c239e53f2c20e2ac5d19ef3f5387c Mon Sep 17 00:00:00 2001
>> Message-Id:
>> <1f3d2612682c239e53f2c20e2ac5d19ef3f5387c.1417695078.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> Date: Thu, 4 Dec 2014 11:53:13 +0000
>> Subject: [PATCH] iommu: store DT-probed IOMMU data privately
>>
>> Since the data pointer in the DT node is public and may be overwritten
>> by conflicting code, move the DT-probed IOMMU ops to a private list
>> where they will be safe.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>
> Looks reasonable to me. Comments below...
>
>> ---
>>   drivers/iommu/of_iommu.c | 38 ++++++++++++++++++++++++++++++++++++++
>>   include/linux/of_iommu.h | 12 ++----------
>>   2 files changed, 40 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 73236d3..5cd451c 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -94,6 +94,44 @@ int of_get_dma_window(struct device_node *dn, const char
>> *prefix, int index,
>>   }
>>   EXPORT_SYMBOL_GPL(of_get_dma_window);
>>
>> +struct of_iommu_node {
>> +       struct hlist_node list;
>> +       struct device_node *np;
>> +       const struct iommu_ops *ops;
>> +};
>> +static HLIST_HEAD(of_iommu_list);
>
> Just use a list_head. hlist_head merely saves one pointer in this case.
>
>> +static DEFINE_SPINLOCK(of_iommu_lock);
>> +
>> +void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops)
>> +{
>> +       struct of_iommu_node *iommu = kmalloc(sizeof(*iommu), GFP_KERNEL);
>
> kzalloc()
>
>> +
>> +       if (!iommu)
>> +               return;
>
> Shouldn't there be a WARN() here on failure? I don't think failing
> silently is desired.
>
>> +
>> +       INIT_HLIST_NODE(&iommu->list);
>> +       iommu->np = np;
>> +       iommu->ops = ops;
>> +       spin_lock(&of_iommu_lock);
>> +       hlist_add_head(&iommu->list, &of_iommu_list);
>> +       spin_unlock(&of_iommu_lock);
>> +}
>> +
>> +struct iommu_ops *of_iommu_get_ops(struct device_node *np)
>> +{
>> +       struct of_iommu_node *node;
>> +       const struct iommu_ops *ops = NULL;
>> +
>> +       spin_lock(&of_iommu_lock);
>> +       hlist_for_each_entry(node, &of_iommu_list, list)
>> +               if (node->np == np) {
>> +                       ops = node->ops;
>> +                       break;
>> +               }
>> +       spin_unlock(&of_iommu_lock);
>> +       return (struct iommu_ops *)ops;
>
> The cast looks fishy. If you need to use a cast, then the data types
> are probably wrong. If you drop the const from *ops here and in the
> structure then it should probably work fine. Due to the way it is
> being used, there isn't any advantage to using const (unless you
> changes of_iommu_get_ops() to return a const pointer, then const would
> make sense).
>
>> +}
>> +
>>   struct iommu_ops *of_iommu_configure(struct device *dev)
>>   {
>>          struct of_phandle_args iommu_spec;
>> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
>> index d03abbb..e27c53a 100644
>> --- a/include/linux/of_iommu.h
>> +++ b/include/linux/of_iommu.h
>> @@ -31,16 +31,8 @@ static inline struct iommu_ops *of_iommu_configure(struct
>> device *dev)
>>
>>   #endif /* CONFIG_OF_IOMMU */
>>
>> -static inline void of_iommu_set_ops(struct device_node *np,
>> -                                   const struct iommu_ops *ops)
>> -{
>> -       np->data = (struct iommu_ops *)ops;
>> -}
>> -
>> -static inline struct iommu_ops *of_iommu_get_ops(struct device_node *np)
>> -{
>> -       return np->data;
>> -}
>> +void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
>> +struct iommu_ops *of_iommu_get_ops(struct device_node *np);
>>
>>   extern struct of_device_id __iommu_of_table;
>>
>> --
>> 1.9.1
>>
>>
>
