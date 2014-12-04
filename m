From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 1/8] iommu: provide early initialisation hook for IOMMU
	drivers
Date: Thu, 04 Dec 2014 19:42:28 +0000
Message-ID: <5480B924.2010205@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<CAL_JsqKHvh9KSTYrrs1Pts5Kg=8dA1V6NiW57_2vdDH173qQGg@mail.gmail.com>
	<CACxGe6vyMkyE9ZRj_FQzi19ESEo7OV_RQoVV65xBYpdQV8cRGQ@mail.gmail.com>
	<2579924.PPXuLn3o19@wuerfel> <54805312.6000402@arm.com>
	<CACxGe6uR5J4Cjdh_xYhBPoQRgeYwHPv5=AnuRmQKSD3yZrMK9Q@mail.gmail.com>
	<54806504.20507@arm.com> <20141204144925.GB31464@ulmo.nvidia.com>
	<54809D09.2050406@arm.com>
	<CACxGe6tpFHdP1-5NWiNVAqzXx-diN1xfRbu0AQDyVJ6AU_4RXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CACxGe6tpFHdP1-5NWiNVAqzXx-diN1xfRbu0AQDyVJ6AU_4RXg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Grant,

On 04/12/14 17:58, Grant Likely wrote:
[...]
>>>> +struct of_iommu_node {
>>>> +       struct list_head list;
>>>> +       struct device_node *np;
>>>> +       struct iommu_ops *ops;
>>>
>>>
>>> Why can't this be const? Why would anyone ever need to modify it? Also
>>> drivers do define their iommu_ops structures const these days, so you'll
>>> either still have to cast away at some point or the compiler will
>>> complain once you start calling this from drivers.
>>>
>>
>> ...whereas if we make everything const then the drivers that _do_ want to
>> use the private data introduced by this series and thus pass mutable
>> per-instance iommu_ops will be the ones having to cast. We have no users
>> either way until this series is merged, and the need to stash the
>> per-instance data somewhere other than np->data is in the way of getting it
>> merged - this is just a quick hack to address that. I think we've already
>> agreed that mutable per-instance iommu_ops holding private data aren't
>> particularly pleasant and will (hopefully) go away in the next iteration[1],
>> at which point this all changes anyway.
>
> Do you expect drivers to modify that *priv pointer after the ops
> structure is registered? I'd be very surprised if that was the use
> case. It's fine for the driver to register a non-const version, but
> once it is registered, the infrastructure can treat it as const from
> then on.

Possibly not - certainly my current port of the ARM SMMU which makes use 
of *priv is only ever reading it - although we did also wave around 
reasons for mutable ops like dynamically changing the pgsize_bitmap and 
possibly even swizzling individual ops for runtime reconfiguration. On 
consideration though, I'd agree that things like that are mad enough to 
stay well within individual drivers if they did ever happen, and 
certainly shouldn't apply to this bit of the infrastructure at any rate.

Here's a respin the other way - making the get/set infrastructure fully 
const and fixing up the callsite in of_iommu_configure instead to avoid 
the warning. Trying to chase const-correctness beyond that quickly got 
too invasive and out of scope for this fix - I'm just keen to get the 
merge-blocker out of the way.

Regards,
Robin.

--->8---
 From 9eba5081aaf4fa8ed5158675a6e622be11a64ae2 Mon Sep 17 00:00:00 2001
Message-Id: 
<9eba5081aaf4fa8ed5158675a6e622be11a64ae2.1417719305.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Date: Thu, 4 Dec 2014 11:53:13 +0000
Subject: [PATCH v3] iommu: store DT-probed IOMMU data privately

Since the data pointer in the DT node is public and may be overwritten
by conflicting code, move the DT-probed IOMMU ops to a private list
where they will be safe.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
  drivers/iommu/of_iommu.c | 40 +++++++++++++++++++++++++++++++++++++++-
  include/linux/of_iommu.h | 12 ++----------
  2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 73236d3..39f581f 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -94,6 +94,44 @@ int of_get_dma_window(struct device_node *dn, const 
char *prefix, int index,
  }
  EXPORT_SYMBOL_GPL(of_get_dma_window);

+struct of_iommu_node {
+	struct list_head list;
+	struct device_node *np;
+	const struct iommu_ops *ops;
+};
+static LIST_HEAD(of_iommu_list);
+static DEFINE_SPINLOCK(of_iommu_lock);
+
+void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops)
+{
+	struct of_iommu_node *iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
+
+	if (WARN_ON(!iommu))
+		return;
+
+	INIT_LIST_HEAD(&iommu->list);
+	iommu->np = np;
+	iommu->ops = ops;
+	spin_lock(&of_iommu_lock);
+	list_add_tail(&iommu->list, &of_iommu_list);
+	spin_unlock(&of_iommu_lock);
+}
+
+const struct iommu_ops *of_iommu_get_ops(struct device_node *np)
+{
+	struct of_iommu_node *node;
+	const struct iommu_ops *ops = NULL;
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
@@ -110,7 +148,7 @@ struct iommu_ops *of_iommu_configure(struct device *dev)
  					   "#iommu-cells", idx,
  					   &iommu_spec)) {
  		np = iommu_spec.np;
-		ops = of_iommu_get_ops(np);
+		ops = (struct iommu_ops *)of_iommu_get_ops(np);

  		if (!ops || !ops->of_xlate || ops->of_xlate(dev, &iommu_spec))
  			goto err_put_node;
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index d03abbb..83f6d0b 100644
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
+void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
+const struct iommu_ops *of_iommu_get_ops(struct device_node *np);

  extern struct of_device_id __iommu_of_table;

-- 
1.9.1
