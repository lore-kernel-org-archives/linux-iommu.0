From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [iommu:core 3/3] drivers/iommu/iova.c:36: error: redefinition of
	'init_iova_domain'
Date: Thu, 23 Mar 2017 02:28:27 +0800
Message-ID: <201703230212.uKXA27d6%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git core
head:   21aff52ab2c831c2f07d48e2fa8d4bab26a66992
commit: 21aff52ab2c831c2f07d48e2fa8d4bab26a66992 [3/3] iommu: Add dummy implementations for !IOMMU_IOVA
config: x86_64-randconfig-a0-03222342 (attached as .config)
compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
reproduce:
        git checkout 21aff52ab2c831c2f07d48e2fa8d4bab26a66992
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> drivers/iommu/iova.c:36: error: redefinition of 'init_iova_domain'
   include/linux/iova.h:170: note: previous definition of 'init_iova_domain' was here
>> drivers/iommu/iova.c:202: error: redefinition of 'alloc_iova_mem'
   include/linux/iova.h:120: note: previous definition of 'alloc_iova_mem' was here
>> drivers/iommu/iova.c:208: error: redefinition of 'free_iova_mem'
   include/linux/iova.h:125: note: previous definition of 'free_iova_mem' was here
>> drivers/iommu/iova.c:214: error: redefinition of 'iova_cache_get'
   include/linux/iova.h:111: note: previous definition of 'iova_cache_get' was here
>> drivers/iommu/iova.c:235: error: redefinition of 'iova_cache_put'
   include/linux/iova.h:116: note: previous definition of 'iova_cache_put' was here
>> drivers/iommu/iova.c:261: error: redefinition of 'alloc_iova'
   include/linux/iova.h:137: note: previous definition of 'alloc_iova' was here
>> drivers/iommu/iova.c:323: error: redefinition of 'find_iova'
   include/linux/iova.h:177: note: previous definition of 'find_iova' was here
>> drivers/iommu/iova.c:343: error: redefinition of '__free_iova'
   include/linux/iova.h:133: note: previous definition of '__free_iova' was here
>> drivers/iommu/iova.c:361: error: redefinition of 'free_iova'
   include/linux/iova.h:129: note: previous definition of 'free_iova' was here
>> drivers/iommu/iova.c:380: error: redefinition of 'alloc_iova_fast'
   include/linux/iova.h:151: note: previous definition of 'alloc_iova_fast' was here
>> drivers/iommu/iova.c:421: error: redefinition of 'free_iova_fast'
   include/linux/iova.h:145: note: previous definition of 'free_iova_fast' was here
>> drivers/iommu/iova.c:435: error: redefinition of 'put_iova_domain'
   include/linux/iova.h:183: note: previous definition of 'put_iova_domain' was here
>> drivers/iommu/iova.c:511: error: redefinition of 'reserve_iova'
   include/linux/iova.h:158: note: previous definition of 'reserve_iova' was here
>> drivers/iommu/iova.c:552: error: redefinition of 'copy_reserved_iova'
   include/linux/iova.h:165: note: previous definition of 'copy_reserved_iova' was here
>> drivers/iommu/iova.c:572: error: redefinition of 'split_and_remove_iova'
   include/linux/iova.h:187: note: previous definition of 'split_and_remove_iova' was here
>> drivers/iommu/iova.c:887: error: redefinition of 'free_cpu_cached_iovas'
   include/linux/iova.h:195: note: previous definition of 'free_cpu_cached_iovas' was here

vim +/init_iova_domain +36 drivers/iommu/iova.c

9257b4a20 drivers/iommu/iova.c Omer Peleg            2016-04-20   30  				     unsigned long size,
9257b4a20 drivers/iommu/iova.c Omer Peleg            2016-04-20   31  				     unsigned long limit_pfn);
9257b4a20 drivers/iommu/iova.c Omer Peleg            2016-04-20   32  static void init_iova_rcaches(struct iova_domain *iovad);
9257b4a20 drivers/iommu/iova.c Omer Peleg            2016-04-20   33  static void free_iova_rcaches(struct iova_domain *iovad);
85b454562 drivers/iommu/iova.c Robin Murphy          2015-01-12   34  
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   35  void
0fb5fe874 drivers/iommu/iova.c Robin Murphy          2015-01-12  @36  init_iova_domain(struct iova_domain *iovad, unsigned long granule,
0fb5fe874 drivers/iommu/iova.c Robin Murphy          2015-01-12   37  	unsigned long start_pfn, unsigned long pfn_32bit)
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   38  {
0fb5fe874 drivers/iommu/iova.c Robin Murphy          2015-01-12   39  	/*
0fb5fe874 drivers/iommu/iova.c Robin Murphy          2015-01-12   40  	 * IOVA granularity will normally be equal to the smallest
0fb5fe874 drivers/iommu/iova.c Robin Murphy          2015-01-12   41  	 * supported IOMMU page size; both *must* be capable of
0fb5fe874 drivers/iommu/iova.c Robin Murphy          2015-01-12   42  	 * representing individual CPU pages exactly.
0fb5fe874 drivers/iommu/iova.c Robin Murphy          2015-01-12   43  	 */
0fb5fe874 drivers/iommu/iova.c Robin Murphy          2015-01-12   44  	BUG_ON((granule > PAGE_SIZE) || !is_power_of_2(granule));
0fb5fe874 drivers/iommu/iova.c Robin Murphy          2015-01-12   45  
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   46  	spin_lock_init(&iovad->iova_rbtree_lock);
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   47  	iovad->rbroot = RB_ROOT;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   48  	iovad->cached32_node = NULL;
0fb5fe874 drivers/iommu/iova.c Robin Murphy          2015-01-12   49  	iovad->granule = granule;
1b7225007 drivers/iommu/iova.c Robin Murphy          2015-01-12   50  	iovad->start_pfn = start_pfn;
f661197e0 drivers/pci/iova.c   David Miller          2008-02-06   51  	iovad->dma_32bit_pfn = pfn_32bit;
9257b4a20 drivers/iommu/iova.c Omer Peleg            2016-04-20   52  	init_iova_rcaches(iovad);
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   53  }
9b41760b0 drivers/iommu/iova.c Sakari Ailus          2015-07-13   54  EXPORT_SYMBOL_GPL(init_iova_domain);
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   55  
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   56  static struct rb_node *
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   57  __get_cached_rbnode(struct iova_domain *iovad, unsigned long *limit_pfn)
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   58  {
62280cf2e drivers/iommu/iova.c Robin Murphy          2016-11-11   59  	if ((*limit_pfn > iovad->dma_32bit_pfn) ||
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   60  		(iovad->cached32_node == NULL))
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   61  		return rb_last(&iovad->rbroot);
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   62  	else {
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   63  		struct rb_node *prev_node = rb_prev(iovad->cached32_node);
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   64  		struct iova *curr_iova =
eba484b51 drivers/iommu/iova.c Geliang Tang          2016-12-19   65  			rb_entry(iovad->cached32_node, struct iova, node);
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   66  		*limit_pfn = curr_iova->pfn_lo - 1;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   67  		return prev_node;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   68  	}
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   69  }
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   70  
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   71  static void
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   72  __cached_rbnode_insert_update(struct iova_domain *iovad,
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   73  	unsigned long limit_pfn, struct iova *new)
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   74  {
f661197e0 drivers/pci/iova.c   David Miller          2008-02-06   75  	if (limit_pfn != iovad->dma_32bit_pfn)
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   76  		return;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   77  	iovad->cached32_node = &new->node;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   78  }
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   79  
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   80  static void
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   81  __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   82  {
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   83  	struct iova *cached_iova;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   84  	struct rb_node *curr;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   85  
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   86  	if (!iovad->cached32_node)
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   87  		return;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   88  	curr = iovad->cached32_node;
eba484b51 drivers/iommu/iova.c Geliang Tang          2016-12-19   89  	cached_iova = rb_entry(curr, struct iova, node);
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21   90  
1c9fc3d11 drivers/pci/iova.c   Chris Wright          2011-05-28   91  	if (free->pfn_lo >= cached_iova->pfn_lo) {
1c9fc3d11 drivers/pci/iova.c   Chris Wright          2011-05-28   92  		struct rb_node *node = rb_next(&free->node);
eba484b51 drivers/iommu/iova.c Geliang Tang          2016-12-19   93  		struct iova *iova = rb_entry(node, struct iova, node);
1c9fc3d11 drivers/pci/iova.c   Chris Wright          2011-05-28   94  
1c9fc3d11 drivers/pci/iova.c   Chris Wright          2011-05-28   95  		/* only cache if it's below 32bit pfn */
1c9fc3d11 drivers/pci/iova.c   Chris Wright          2011-05-28   96  		if (node && iova->pfn_lo < iovad->dma_32bit_pfn)
1c9fc3d11 drivers/pci/iova.c   Chris Wright          2011-05-28   97  			iovad->cached32_node = node;
1c9fc3d11 drivers/pci/iova.c   Chris Wright          2011-05-28   98  		else
1c9fc3d11 drivers/pci/iova.c   Chris Wright          2011-05-28   99  			iovad->cached32_node = NULL;
1c9fc3d11 drivers/pci/iova.c   Chris Wright          2011-05-28  100  	}
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  101  }
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  102  
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  103  /* Insert the iova into domain rbtree by holding writer lock */
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  104  static void
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  105  iova_insert_rbtree(struct rb_root *root, struct iova *iova,
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  106  		   struct rb_node *start)
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  107  {
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  108  	struct rb_node **new, *parent = NULL;
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  109  
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  110  	new = (start) ? &start : &(root->rb_node);
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  111  	/* Figure out where to put new node */
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  112  	while (*new) {
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  113  		struct iova *this = rb_entry(*new, struct iova, node);
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  114  
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  115  		parent = *new;
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  116  
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  117  		if (iova->pfn_lo < this->pfn_lo)
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  118  			new = &((*new)->rb_left);
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  119  		else if (iova->pfn_lo > this->pfn_lo)
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  120  			new = &((*new)->rb_right);
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  121  		else {
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  122  			WARN_ON(1); /* this should not happen */
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  123  			return;
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  124  		}
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  125  	}
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  126  	/* Add new node and rebalance tree. */
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  127  	rb_link_node(&iova->node, parent, new);
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  128  	rb_insert_color(&iova->node, root);
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  129  }
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  130  
8f6429c7c drivers/iommu/iova.c Robin Murphy          2015-07-16  131  /*
8f6429c7c drivers/iommu/iova.c Robin Murphy          2015-07-16  132   * Computes the padding size required, to make the start address
8f6429c7c drivers/iommu/iova.c Robin Murphy          2015-07-16  133   * naturally aligned on the power-of-two order of its size
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  134   */
8f6429c7c drivers/iommu/iova.c Robin Murphy          2015-07-16  135  static unsigned int
8f6429c7c drivers/iommu/iova.c Robin Murphy          2015-07-16  136  iova_get_pad_size(unsigned int size, unsigned int limit_pfn)
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  137  {
8f6429c7c drivers/iommu/iova.c Robin Murphy          2015-07-16  138  	return (limit_pfn + 1 - size) & (__roundup_pow_of_two(size) - 1);
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  139  }
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  140  
ddf02886c drivers/pci/iova.c   mark gross            2008-03-04  141  static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
ddf02886c drivers/pci/iova.c   mark gross            2008-03-04  142  		unsigned long size, unsigned long limit_pfn,
ddf02886c drivers/pci/iova.c   mark gross            2008-03-04  143  			struct iova *new, bool size_aligned)
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  144  {
ddf02886c drivers/pci/iova.c   mark gross            2008-03-04  145  	struct rb_node *prev, *curr = NULL;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  146  	unsigned long flags;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  147  	unsigned long saved_pfn;
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  148  	unsigned int pad_size = 0;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  149  
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  150  	/* Walk the tree backwards */
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  151  	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  152  	saved_pfn = limit_pfn;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  153  	curr = __get_cached_rbnode(iovad, &limit_pfn);
ddf02886c drivers/pci/iova.c   mark gross            2008-03-04  154  	prev = curr;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  155  	while (curr) {
eba484b51 drivers/iommu/iova.c Geliang Tang          2016-12-19  156  		struct iova *curr_iova = rb_entry(curr, struct iova, node);
ddf02886c drivers/pci/iova.c   mark gross            2008-03-04  157  
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  158  		if (limit_pfn < curr_iova->pfn_lo)
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  159  			goto move_left;
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  160  		else if (limit_pfn < curr_iova->pfn_hi)
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  161  			goto adjust_limit_pfn;
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  162  		else {
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  163  			if (size_aligned)
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  164  				pad_size = iova_get_pad_size(size, limit_pfn);
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  165  			if ((curr_iova->pfn_hi + size + pad_size) <= limit_pfn)
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  166  				break;	/* found a free slot */
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  167  		}
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  168  adjust_limit_pfn:
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  169  		limit_pfn = curr_iova->pfn_lo - 1;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  170  move_left:
ddf02886c drivers/pci/iova.c   mark gross            2008-03-04  171  		prev = curr;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  172  		curr = rb_prev(curr);
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  173  	}
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  174  
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  175  	if (!curr) {
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  176  		if (size_aligned)
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  177  			pad_size = iova_get_pad_size(size, limit_pfn);
1b7225007 drivers/iommu/iova.c Robin Murphy          2015-01-12  178  		if ((iovad->start_pfn + size + pad_size) > limit_pfn) {
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  179  			spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  180  			return -ENOMEM;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  181  		}
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  182  	}
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  183  
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  184  	/* pfn_lo will point to size aligned address if size_aligned is set */
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  185  	new->pfn_lo = limit_pfn - (size + pad_size) + 1;
f76aec76e drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  186  	new->pfn_hi = new->pfn_lo + size - 1;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  187  
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  188  	/* If we have 'prev', it's a valid place to start the insertion. */
d751751a9 drivers/iommu/iova.c Marek Szyprowski      2017-02-24  189  	iova_insert_rbtree(&iovad->rbroot, new, prev);
ddf02886c drivers/pci/iova.c   mark gross            2008-03-04  190  	__cached_rbnode_insert_update(iovad, saved_pfn, new);
ddf02886c drivers/pci/iova.c   mark gross            2008-03-04  191  
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  192  	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
ddf02886c drivers/pci/iova.c   mark gross            2008-03-04  193  
ddf02886c drivers/pci/iova.c   mark gross            2008-03-04  194  
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  195  	return 0;
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  196  }
f8de50eb6 drivers/pci/iova.c   Keshavamurthy, Anil S 2007-10-21  197  
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  198  static struct kmem_cache *iova_cache;
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  199  static unsigned int iova_cache_users;
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  200  static DEFINE_MUTEX(iova_cache_mutex);
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  201  
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13 @202  struct iova *alloc_iova_mem(void)
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  203  {
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  204  	return kmem_cache_alloc(iova_cache, GFP_ATOMIC);
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  205  }
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  206  EXPORT_SYMBOL(alloc_iova_mem);
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  207  
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13 @208  void free_iova_mem(struct iova *iova)
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  209  {
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  210  	kmem_cache_free(iova_cache, iova);
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  211  }
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  212  EXPORT_SYMBOL(free_iova_mem);
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  213  
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13 @214  int iova_cache_get(void)
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  215  {
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  216  	mutex_lock(&iova_cache_mutex);
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  217  	if (!iova_cache_users) {
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  218  		iova_cache = kmem_cache_create(
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  219  			"iommu_iova", sizeof(struct iova), 0,
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  220  			SLAB_HWCACHE_ALIGN, NULL);
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  221  		if (!iova_cache) {
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  222  			mutex_unlock(&iova_cache_mutex);
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  223  			printk(KERN_ERR "Couldn't create iova cache\n");
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  224  			return -ENOMEM;
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  225  		}
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  226  	}
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  227  
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  228  	iova_cache_users++;
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  229  	mutex_unlock(&iova_cache_mutex);
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  230  
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  231  	return 0;
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  232  }
9b41760b0 drivers/iommu/iova.c Sakari Ailus          2015-07-13  233  EXPORT_SYMBOL_GPL(iova_cache_get);
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  234  
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13 @235  void iova_cache_put(void)
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  236  {
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  237  	mutex_lock(&iova_cache_mutex);
ae1ff3d62 drivers/iommu/iova.c Sakari Ailus          2015-07-13  238  	if (WARN_ON(!iova_cache_users)) {

:::::: The code at line 36 was first introduced by commit
:::::: 0fb5fe874c42942e16c450ae05da453e13a1c09e iommu: Make IOVA domain page size explicit

:::::: TO: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
:::::: CC: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--vtzGhvizbBRQ85DL
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--vtzGhvizbBRQ85DL--
