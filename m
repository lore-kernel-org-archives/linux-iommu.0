From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [iommu:default-domains 6/22] drivers/iommu/iommu.c:719:8: error:
	'struct iommu_group' has no member named 'domain'
Date: Tue, 9 Jun 2015 09:19:29 +0200
Message-ID: <20150609071929.GW16345@suse.de>
References: <201506081333.obotfEnw%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201506081333.obotfEnw%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kbuild-all-JC7UmRfGjtg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 08, 2015 at 01:51:34PM +0800, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git default-domains
> head:   4c5de9feccd92ecab4cd5d8ef6d9e0b552e98268
> commit: 840136773f5f2e0ed2a6ac671f8635792633c8cf [6/22] iommu: Allocate a default domain for iommu groups
> config: x86_64-rhel (attached as .config)
> reproduce:
>   git checkout 840136773f5f2e0ed2a6ac671f8635792633c8cf
>   # save the attached .config to linux build tree
>   make ARCH=x86_64 
> 
> Note: the iommu/default-domains HEAD 4c5de9feccd92ecab4cd5d8ef6d9e0b552e98268 builds fine.
>       It only hurts bisectibility.
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/iommu/iommu.c: In function 'iommu_group_get_for_pci_dev':
> >> drivers/iommu/iommu.c:719:8: error: 'struct iommu_group' has no member named 'domain'
>       group->domain = group->default_domain;
>            ^
> 
> vim +719 drivers/iommu/iommu.c
> 
>    713			/*
>    714			 * Try to allocate a default domain - needs support from the
>    715			 * IOMMU driver.
>    716			 */
>    717			group->default_domain = __iommu_domain_alloc(pdev->dev.bus,
>    718								     IOMMU_DOMAIN_DMA);
>  > 719			group->domain = group->default_domain;
>    720		}
>    721	
>    722		return group;

Fixed. Thanks for the report!
