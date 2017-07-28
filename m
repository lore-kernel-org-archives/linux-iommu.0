From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [iommu:core 1/3] drivers/iommu/of_iommu.c:231:21-28: ERROR:
	PTR_ERR applied after initialization to constant on line 173
Date: Fri, 28 Jul 2017 13:09:42 +0100
Message-ID: <7fc4d02c-55e1-328e-586b-3162ce1def0f@arm.com>
References: <201707280858.aviPx7yO%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <201707280858.aviPx7yO%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: cocci-/FJkirnvOdkvYVN+rsErww@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Gilles.Muller-L2FTfq7BK8M@public.gmane.org, Julia.Lawall-L2FTfq7BK8M@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kbuild-all-JC7UmRfGjtg@public.gmane.org, kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 28/07/17 01:26, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git core
> head:   6bd4f1c754b2fafac403073b0d8469bed1d37e2d
> commit: d87beb749281404b4b4919930b1cc6352e3746f2 [1/3] iommu/of: Handle PCI aliases properly
> 
> 
> coccinelle warnings: (new ones prefixed by >>)
> 
>>> drivers/iommu/of_iommu.c:231:21-28: ERROR: PTR_ERR applied after initialization to constant on line 173

I don't think I can see what Coccinelle sees here :/

> vim +231 drivers/iommu/of_iommu.c
> 
> 2a0c5754 Robin Murphy     2017-04-10  169  
> 2a0c5754 Robin Murphy     2017-04-10  170  const struct iommu_ops *of_iommu_configure(struct device *dev,
> 2a0c5754 Robin Murphy     2017-04-10  171  					   struct device_node *master_np)
> 2a0c5754 Robin Murphy     2017-04-10  172  {
> d87beb74 Robin Murphy     2017-05-31 @173  	const struct iommu_ops *ops = NULL;

Fair enough, NULL is indeed a constant, but it's also a valid value for
this function to return, since we're looking up a pointer to something
which may or may not exist...

> d7b05582 Robin Murphy     2017-04-10  174  	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> d87beb74 Robin Murphy     2017-05-31  175  	int err;
> 7eba1d51 Will Deacon      2014-08-27  176  
> 2a0c5754 Robin Murphy     2017-04-10  177  	if (!master_np)
> 7eba1d51 Will Deacon      2014-08-27  178  		return NULL;
> 2a0c5754 Robin Murphy     2017-04-10  179  
> d7b05582 Robin Murphy     2017-04-10  180  	if (fwspec) {
> d7b05582 Robin Murphy     2017-04-10  181  		if (fwspec->ops)
> d7b05582 Robin Murphy     2017-04-10  182  			return fwspec->ops;
> d7b05582 Robin Murphy     2017-04-10  183  
> d7b05582 Robin Murphy     2017-04-10  184  		/* In the deferred case, start again from scratch */
> d7b05582 Robin Murphy     2017-04-10  185  		iommu_fwspec_free(dev);
> d7b05582 Robin Murphy     2017-04-10  186  	}
> d7b05582 Robin Murphy     2017-04-10  187  
> d87beb74 Robin Murphy     2017-05-31  188  	/*
> d87beb74 Robin Murphy     2017-05-31  189  	 * We don't currently walk up the tree looking for a parent IOMMU.
> d87beb74 Robin Murphy     2017-05-31  190  	 * See the `Notes:' section of
> d87beb74 Robin Murphy     2017-05-31  191  	 * Documentation/devicetree/bindings/iommu/iommu.txt
> d87beb74 Robin Murphy     2017-05-31  192  	 */
> d87beb74 Robin Murphy     2017-05-31  193  	if (dev_is_pci(dev)) {
> d87beb74 Robin Murphy     2017-05-31  194  		struct of_pci_iommu_alias_info info = {
> d87beb74 Robin Murphy     2017-05-31  195  			.dev = dev,
> d87beb74 Robin Murphy     2017-05-31  196  			.np = master_np,
> d87beb74 Robin Murphy     2017-05-31  197  		};
> d87beb74 Robin Murphy     2017-05-31  198  
> d87beb74 Robin Murphy     2017-05-31  199  		err = pci_for_each_dma_alias(to_pci_dev(dev),
> d87beb74 Robin Murphy     2017-05-31  200  					     of_pci_iommu_init, &info);
> d87beb74 Robin Murphy     2017-05-31  201  		if (err) /* err > 0 means the walk stopped, but non-fatally */
> d87beb74 Robin Murphy     2017-05-31  202  			ops = ERR_PTR(min(err, 0));
> d87beb74 Robin Murphy     2017-05-31  203  		else /* success implies both fwspec and ops are now valid */
> d87beb74 Robin Murphy     2017-05-31  204  			ops = dev->iommu_fwspec->ops;
> d87beb74 Robin Murphy     2017-05-31  205  	} else {
> d87beb74 Robin Murphy     2017-05-31  206  		struct of_phandle_args iommu_spec;
> d87beb74 Robin Murphy     2017-05-31  207  		int idx = 0;
> d87beb74 Robin Murphy     2017-05-31  208  
> d87beb74 Robin Murphy     2017-05-31  209  		while (!of_parse_phandle_with_args(master_np, "iommus",
> d87beb74 Robin Murphy     2017-05-31  210  						   "#iommu-cells",
> d87beb74 Robin Murphy     2017-05-31  211  						   idx, &iommu_spec)) {
> d87beb74 Robin Murphy     2017-05-31  212  			ops = of_iommu_xlate(dev, &iommu_spec);
> d87beb74 Robin Murphy     2017-05-31  213  			of_node_put(iommu_spec.np);
> d87beb74 Robin Murphy     2017-05-31  214  			idx++;
> d87beb74 Robin Murphy     2017-05-31  215  			if (IS_ERR_OR_NULL(ops))
> d87beb74 Robin Murphy     2017-05-31  216  				break;
> d87beb74 Robin Murphy     2017-05-31  217  		}
> d87beb74 Robin Murphy     2017-05-31  218  	}

...here we've done some stuff that may have set ops to a valid pointer
or an ERR_PTR value, or we may not have touched it at all such that it
stays NULL...

> d7b05582 Robin Murphy     2017-04-10  219  	/*
> d7b05582 Robin Murphy     2017-04-10  220  	 * If we have reason to believe the IOMMU driver missed the initial
> d7b05582 Robin Murphy     2017-04-10  221  	 * add_device callback for dev, replay it to get things in order.
> d7b05582 Robin Murphy     2017-04-10  222  	 */
> d7b05582 Robin Murphy     2017-04-10  223  	if (!IS_ERR_OR_NULL(ops) && ops->add_device &&
> d7b05582 Robin Murphy     2017-04-10  224  	    dev->bus && !dev->iommu_group) {
> d87beb74 Robin Murphy     2017-05-31  225  		err = ops->add_device(dev);
> d7b05582 Robin Murphy     2017-04-10  226  		if (err)
> d7b05582 Robin Murphy     2017-04-10  227  			ops = ERR_PTR(err);
> d7b05582 Robin Murphy     2017-04-10  228  	}
> 2a0c5754 Robin Murphy     2017-04-10  229  
> a37b19a3 Sricharan R      2017-05-27  230  	/* Ignore all other errors apart from EPROBE_DEFER */
> a37b19a3 Sricharan R      2017-05-27 @231  	if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER)) {

...but if and only if it *has* been changed to an ERR_PTR value (i.e.
explicitly not the value it was initialised with), we want to
special-case one specific value. Why would that be considered an error?

Notably, the check also doesn't fire (but then does for the dev_dbg
below) if I swizzle this part of the statement to the
semantically-equivalent but less-obvious-to-read "(ops !=
ERR_PTR(-EPROBE_DEFER))". From what I can tell it seems to be ignoring
the initial IS_ERR(ops) predicate here.

Robin.

> a37b19a3 Sricharan R      2017-05-27  232  		dev_dbg(dev, "Adding to IOMMU failed: %ld\n", PTR_ERR(ops));
> a37b19a3 Sricharan R      2017-05-27  233  		ops = NULL;
> a37b19a3 Sricharan R      2017-05-27  234  	}
> a37b19a3 Sricharan R      2017-05-27  235  
> 7b07cbef Laurent Pinchart 2017-04-10  236  	return ops;
> 7eba1d51 Will Deacon      2014-08-27  237  }
> 7eba1d51 Will Deacon      2014-08-27  238  
> 
> :::::: The code at line 231 was first introduced by commit
> :::::: a37b19a384914c60b7e1264a6c21e7bf96b637e8 iommu/of: Ignore all errors except EPROBE_DEFER
> 
> :::::: TO: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> :::::: CC: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
