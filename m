From: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/4] iommu/iova: Make dma_32bit_pfn implicit
Date: Thu, 20 Jul 2017 10:55:40 +0800
Message-ID: <59701BAC.7060800@huawei.com>
References: <201707192352.79mkRePJ%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <201707192352.79mkRePJ%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ashutosh Dixit <ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, kbuild-all-JC7UmRfGjtg@public.gmane.org, Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 2017/7/19 23:07, kbuild test robot wrote:
> Hi Zhen,
> 
> [auto build test WARNING on iommu/next]
> [also build test WARNING on v4.13-rc1]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Robin-Murphy/Optimise-64-bit-IOVA-allocations/20170719-060847
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> config: arm-multi_v7_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/iommu/iova.c: In function 'init_iova_domain':
>>> drivers/iommu/iova.c:53:41: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>      iovad->dma_32bit_pfn = iova_pfn(iovad, 1ULL << 32);
OK, I see. I think the problem is that "1ULL << 32" exceed the scope of 32bits general register. We should
replace "1ULL << 32" with DMA_BIT_MASK(32), the latter will minus one to keep it can be safely stored in
the general register.

iovad->dma_32bit_pfn = iova_pfn(iovad, DMA_BIT_MASK(32)) + 1;

>                                             ^~~~
> 
> vim +53 drivers/iommu/iova.c
> 
>     35	
>     36	void
>     37	init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>     38		unsigned long start_pfn)
>     39	{
>     40		/*
>     41		 * IOVA granularity will normally be equal to the smallest
>     42		 * supported IOMMU page size; both *must* be capable of
>     43		 * representing individual CPU pages exactly.
>     44		 */
>     45		BUG_ON((granule > PAGE_SIZE) || !is_power_of_2(granule));
>     46	
>     47		spin_lock_init(&iovad->iova_rbtree_lock);
>     48		iovad->rbroot = RB_ROOT;
>     49		iovad->cached_node = NULL;
>     50		iovad->cached32_node = NULL;
>     51		iovad->granule = granule;
>     52		iovad->start_pfn = start_pfn;
>   > 53		iovad->dma_32bit_pfn = iova_pfn(iovad, 1ULL << 32);
>     54		init_iova_rcaches(iovad);
>     55	}
>     56	EXPORT_SYMBOL_GPL(init_iova_domain);
>     57	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

-- 
Thanks!
BestRegards
