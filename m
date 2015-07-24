From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] of: base: Allow more args than MAX_PHANDLE_ARGS if
	required
Date: Fri, 24 Jul 2015 16:27:18 -0500
Message-ID: <55B2ADB6.3040307@gmail.com>
References: <1437035444-13867-1-git-send-email-joro@8bytes.org>
	<1437035444-13867-2-git-send-email-joro@8bytes.org>
	<20150716102325.GC26390@arm.com> <20150716110900.GA30130@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150716110900.GA30130-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 16, 2015 at 6:09 AM, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org> wrote:
> Hi Will,
>
> On Thu, Jul 16, 2015 at 11:23:26AM +0100, Will Deacon wrote:
>> On Thu, Jul 16, 2015 at 09:30:43AM +0100, Joerg Roedel wrote:
>> > +struct of_phandle_args *of_alloc_phandle_args(int size)
>> > +{
>> > +   struct of_phandle_args *args;
>> > +   int e = max(0, size - MAX_PHANDLE_ARGS);
>> > +
>> > +   args =  kzalloc(sizeof(struct of_phandle_args) + e * sizeof(uint32_t),
>> > +                   GFP_KERNEL);
>>
>> Should you also update args->args_count to reflect the extended array?
>
> The args_count member just tells us how many of the array elements are
> used and not how many there are. So it doesn't need to be updated here.
>
>> That said, extending the fixed-size array member like this feels a bit
>> fragile. Does GCC not complain about out-of-bounds accesses if you
>> statically address args->args[MAX_PHANDLE_ARGS]? Admittedly, I can't
>> think *why* this would be break (things like additional padding will be
>> harmless), but I'm not intimate with the C standard.
>
> Yeah, I agree, it is not the best possible solution. But this way I
> don't need to update all callers, and thus it works better with our
> development model.

Our development model is not to work-around kernel APIs last time I checked.

> But I am open for suggestions on how to solve this problem better. In
> fact, my main motivation in sending this was to get the discussion about
> an upstreamable solution started :)
>
> Lets see what the device-tree maintainers have to say.

A good number of callers and all iommu callers loop thru the list of 
phandles which are just open coded ATM. So we should do loop iterators 
here. With iterators, we can do the allocation within the iterators. 
This can be much more efficient as we don't iterate thru the list from 
the start every time. Normally, the list is not big enough to matter, 
but in your case it may be.

I'm thinking something like this untested and not yet compiling patch. It 
still has the abuse of adding onto the end of the of_phandle_args 
struct which I don't really like. We could do a new struct, but I'd like 
to keep this code common.

I also need to refactor the existing code to use 
__of_parse_one_phandle_with_args.

Rob

8<--------------------------------------------------------------------------------------------
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8b5a187..c1c5a43 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1442,6 +1442,96 @@ void of_print_phandle_args(const char *msg, const struct of_phandle_args *args)
 	printk("\n");
 }
 
+
+static int __of_parse_one_phandle_with_args(const __be32 **list,
+					const char *cells_name,
+					int cell_count,
+					struct of_phandle_args **out_args)
+{
+	struct device_node *node;
+	phandle phandle;
+	struct of_phandle_args *args = *out_args;
+	const __be32 *start_list = *list;
+	u32 i, count = 0;
+	int ret;
+
+	/*
+	 * If phandle is 0, then it is an empty entry with no
+	 * arguments.  Skip forward to the next entry.
+	 */
+	phandle = be32_to_cpup(*list++);
+	if (phandle) {
+		/*
+		 * Find the provider node and parse the #*-cells
+		 * property to determine the argument length.
+		 *
+		 * This is not needed if the cell count is hard-coded
+		 * (i.e. cells_name not set, but cell_count is set),
+		 * except when we're going to return the found node
+		 * below.
+		 */
+		node = of_find_node_by_phandle(phandle);
+		if (!node)
+			return -ENOENT;
+
+		if (cells_name) {
+			ret = of_property_read_u32(node, cells_name, &count);
+			if (ret) {
+				pr_err("could not get %s for %s\n",
+				       cells_name, node->full_name);
+				return ret;
+			}
+		} else {
+			count = cell_count;
+		}
+	}
+
+	if (args && WARN_ON(count > MAX_PHANDLE_ARGS))
+		count = MAX_PHANDLE_ARGS;
+
+	if (!args) {
+		args = kzalloc(sizeof(*args) + (count * sizeof(uint32_t))), GFP_KERNEL);
+		*out_args = args;
+	}
+	if (!args)
+		return -ENOMEM;
+
+	if (!phandle) {
+		memset(args, 0, sizeof(*args));
+		return -ENOENT;
+	}
+
+	args->np = node;
+	args->val = start_list;
+	args->args_count = count;
+	for (i = 0; i < count; i++)
+		args->args[i] = be32_to_cpup(*list++);
+
+	return 0;
+}
+
+of_phandle_args *of_prop_next_phandle_args(struct property *prop,
+						const char *cells_name,
+						int cell_count,
+						struct of_phandle_args *last)
+{
+	struct of_phandle_args *args = NULL;
+	const __be32 *start_list;
+
+	if (!prop)
+		return NULL;
+
+	if (!last) {
+		start_list = prop->value;
+	} else {
+		start_list = last->val;
+		kfree(last);
+	}
+	__of_parse_one_phandle_with_args(list, cells_name, cell_count, &args);
+	return args;
+}
+EXPORT_SYMBOL_GPL(of_prop_next_phandle_args);
+
 static int __of_parse_phandle_with_args(const struct device_node *np,
 					const char *list_name,
 					const char *cells_name,
diff --git a/include/linux/of.h b/include/linux/of.h
index edc068d..a0f432c 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -879,6 +879,13 @@ static inline int of_property_read_s32(const struct device_node *np,
 		s;						\
 		s = of_prop_next_string(prop, s))
 
+#define of_property_for_each_phandle_with_args(np, propname, cells_name, cell_count, prop, arg)	\
+	for (prop = of_find_property(np, propname, NULL),	\
+		arg = of_prop_next_phandle_args(prop, NULL);	\
+		arg;						\
+		arg = of_prop_next_phandle_args(prop, arg))
+
+
 #define for_each_node_by_name(dn, name) \
 	for (dn = of_find_node_by_name(NULL, name); dn; \
 	     dn = of_find_node_by_name(dn, name))
