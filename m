From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [iommu:x86/vt-d 6/11] drivers/iommu/intel-iommu.c:5079:2-8:
	preceding lock on line 5061
Date: Thu, 4 Jun 2015 19:16:18 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1506041915090.2677@hadrien>
References: <201506050119.zh0T6mBM%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <201506050119.zh0T6mBM%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, zhen-hual-VXdhtT5mjnY@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Bill Sumner <billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kbuild-JC7UmRfGjtg@public.gmane.org, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

It looks suspicious.  Please take a look.

julia

On Fri, 5 Jun 2015, kbuild test robot wrote:

> TO: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
> CC: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> CC: Bill Sumner <billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git x86/vt-d
> head:   79400f4610f6d17cbeeb4cfa5355e7e5c36385aa
> commit: 5908f10af4b9b5f2afbcf9124bc5753e4ff5609f [6/11] iommu/vt-d: datatypes and functions used for kdump
> :::::: branch date: 2 days ago
> :::::: commit date: 6 days ago
>
> >> drivers/iommu/intel-iommu.c:5079:2-8: preceding lock on line 5061
>
> git remote add iommu git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
> git remote update iommu
> git checkout 5908f10af4b9b5f2afbcf9124bc5753e4ff5609f
> vim +5079 drivers/iommu/intel-iommu.c
>
> 5908f10a Li, Zhen-Hua 2015-05-11  5055  	unsigned long flags;
> 5908f10a Li, Zhen-Hua 2015-05-11  5056
> 5908f10a Li, Zhen-Hua 2015-05-11  5057  	q = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
> 5908f10a Li, Zhen-Hua 2015-05-11  5058  	if (!q)
> 5908f10a Li, Zhen-Hua 2015-05-11  5059  		return -1;
> 5908f10a Li, Zhen-Hua 2015-05-11  5060
> 5908f10a Li, Zhen-Hua 2015-05-11 @5061  	spin_lock_irqsave(&iommu->lock, flags);
> 5908f10a Li, Zhen-Hua 2015-05-11  5062
> 5908f10a Li, Zhen-Hua 2015-05-11  5063  	/* Load the root-entry table from the old kernel
> 5908f10a Li, Zhen-Hua 2015-05-11  5064  	 * foreach context_entry_table in root_entry
> 5908f10a Li, Zhen-Hua 2015-05-11  5065  	 *   Copy each entry table from old kernel
> 5908f10a Li, Zhen-Hua 2015-05-11  5066  	 */
> 5908f10a Li, Zhen-Hua 2015-05-11  5067  	if (!iommu->root_entry) {
> 5908f10a Li, Zhen-Hua 2015-05-11  5068  		iommu->root_entry =
> 5908f10a Li, Zhen-Hua 2015-05-11  5069  			(struct root_entry *)alloc_pgtable_page(iommu->node);
> 5908f10a Li, Zhen-Hua 2015-05-11  5070  		if (!iommu->root_entry) {
> 5908f10a Li, Zhen-Hua 2015-05-11  5071  			spin_unlock_irqrestore(&iommu->lock, flags);
> 5908f10a Li, Zhen-Hua 2015-05-11  5072  			return -ENOMEM;
> 5908f10a Li, Zhen-Hua 2015-05-11  5073  		}
> 5908f10a Li, Zhen-Hua 2015-05-11  5074  	}
> 5908f10a Li, Zhen-Hua 2015-05-11  5075
> 5908f10a Li, Zhen-Hua 2015-05-11  5076  	iommu->root_entry_old_phys = q & VTD_PAGE_MASK;
> 5908f10a Li, Zhen-Hua 2015-05-11  5077  	if (!iommu->root_entry_old_phys) {
> 5908f10a Li, Zhen-Hua 2015-05-11  5078  		pr_err("Could not read old root entry address.");
> 5908f10a Li, Zhen-Hua 2015-05-11 @5079  		return -1;
> 5908f10a Li, Zhen-Hua 2015-05-11  5080  	}
> 5908f10a Li, Zhen-Hua 2015-05-11  5081
> 5908f10a Li, Zhen-Hua 2015-05-11  5082  	iommu->root_entry_old_virt = ioremap_cache(iommu->root_entry_old_phys,
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
>
