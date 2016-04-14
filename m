From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch V2 1/2] iommu: remove the iommu_callback_data
Date: Thu, 14 Apr 2016 13:59:57 +0000
Message-ID: <20160414135957.GA21917@vultr.guest>
References: <1458771911-30785-1-git-send-email-richard.weiyang@gmail.com>
	<1458771911-30785-2-git-send-email-richard.weiyang@gmail.com>
Reply-To: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1458771911-30785-2-git-send-email-richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi, Alex

I think this one is correct. It applies on v4.5 and works fine.
Or I missed something else?

On Wed, Mar 23, 2016 at 10:25:10PM +0000, Wei Yang wrote:
>According to the code path, iommu_callback_data is passed in
>iommu_bus_init() and  just used in {add/remove}_iommu_group, by when the
>bus->iommu_ops is already set up properly.
>
>This patch removes the iommu_callback_data by retrieving iommu_ops from
>bus->iommu_ops directly.
>
>Signed-off-by: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>---
> drivers/iommu/iommu.c |   21 ++++++---------------
> 1 file changed, 6 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>index 0e3b009..2696a38 100644
>--- a/drivers/iommu/iommu.c
>+++ b/drivers/iommu/iommu.c
>@@ -37,10 +37,6 @@ static struct kset *iommu_group_kset;
> static struct ida iommu_group_ida;
> static struct mutex iommu_group_mutex;
> 
>-struct iommu_callback_data {
>-	const struct iommu_ops *ops;
>-};
>-
> struct iommu_group {
> 	struct kobject kobj;
> 	struct kobject *devices_kobj;
>@@ -867,8 +863,7 @@ struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
> 
> static int add_iommu_group(struct device *dev, void *data)
> {
>-	struct iommu_callback_data *cb = data;
>-	const struct iommu_ops *ops = cb->ops;
>+	const struct iommu_ops *ops = dev->bus->iommu_ops;
> 	int ret;
> 
> 	if (!ops->add_device)
>@@ -891,8 +886,7 @@ static int add_iommu_group(struct device *dev, void *data)
> 
> static int remove_iommu_group(struct device *dev, void *data)
> {
>-	struct iommu_callback_data *cb = data;
>-	const struct iommu_ops *ops = cb->ops;
>+	const struct iommu_ops *ops = dev->bus->iommu_ops;
> 
> 	if (ops->remove_device && dev->iommu_group)
> 		ops->remove_device(dev);
>@@ -953,13 +947,10 @@ static int iommu_bus_notifier(struct notifier_block *nb,
> 	return 0;
> }
> 
>-static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
>+static int iommu_bus_init(struct bus_type *bus)
> {
> 	int err;
> 	struct notifier_block *nb;
>-	struct iommu_callback_data cb = {
>-		.ops = ops,
>-	};
> 
> 	nb = kzalloc(sizeof(struct notifier_block), GFP_KERNEL);
> 	if (!nb)
>@@ -971,7 +962,7 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
> 	if (err)
> 		goto out_free;
> 
>-	err = bus_for_each_dev(bus, NULL, &cb, add_iommu_group);
>+	err = bus_for_each_dev(bus, NULL, NULL, add_iommu_group);
> 	if (err)
> 		goto out_err;
> 
>@@ -980,7 +971,7 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
> 
> out_err:
> 	/* Clean up */
>-	bus_for_each_dev(bus, NULL, &cb, remove_iommu_group);
>+	bus_for_each_dev(bus, NULL, NULL, remove_iommu_group);
> 	bus_unregister_notifier(bus, nb);
> 
> out_free:
>@@ -1012,7 +1003,7 @@ int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
> 	bus->iommu_ops = ops;
> 
> 	/* Do IOMMU specific setup for this bus-type */
>-	err = iommu_bus_init(bus, ops);
>+	err = iommu_bus_init(bus);
> 	if (err)
> 		bus->iommu_ops = NULL;
> 
>-- 
>1.7.9.5

-- 
Wei Yang
Help you, Help me
