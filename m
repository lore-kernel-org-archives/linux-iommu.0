From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 00/20] iommu/exynos: Fixes and Enhancements of System
	MMU driver with DT
Date: Fri, 1 Nov 2013 12:42:24 +0100
Message-ID: <20131101114224.GG17455@8bytes.org>
References: <20131007105212.1c2a9e29166ff4b4a33468f8@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131007105212.1c2a9e29166ff4b4a33468f8-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Subash Patel <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 07, 2013 at 10:52:12AM +0900, Cho KyongHo wrote:
> Patch summary:
> [PATCH 01/20] iommu/exynos: do not include removed header
> [PATCH 02/20] iommu/exynos: add missing cache flush for removed page table entries
> [PATCH 03/20] iommu/exynos: change error handling when page table update is failed
> [PATCH 04/20] iommu/exynos: fix L2TLB invalidation
> [PATCH 05/20] iommu/exynos: allocate lv2 page table from own slab
> [PATCH 06/20] iommu/exynos: always enable runtime PM
> [PATCH 07/20] iommu/exynos: always use a single clock descriptor
> [PATCH 08/20] iommu/exynos: remove dbgname from drvdata of a System MMU
> [PATCH 09/20] iommu/exynos: use managed device helper functions
> [PATCH 10/20] clk: exynos: add gate clock descriptions of System MMU
> [PATCH 11/20] ARM: dts: Add description of System MMU of Exynos SoCs
> [PATCH 12/20] iommu/exynos: support for device tree
> [PATCH 13/20] iommu/exynos: gating clocks of master H/W
> [PATCH 14/20] iommu/exynos: remove custom fault handler
> [PATCH 15/20] iommu/exynos: remove calls to Runtime PM API functions
> [PATCH 16/20] iommu/exynos: turn on useful configuration options
> [PATCH 17/20] iommu/exynos: add support for power management subsystems.
> [PATCH 18/20] iommu/exynos: change rwlock to spinlock
> [PATCH 19/20] iommu/exynos: return 0 if iommu_attach_device() successes
> [PATCH 20/20] iommu/exynos: add devices attached to the System MMU to an IOMMU group
> 
> Diffstats:
>  .../devicetree/bindings/clock/exynos5250-clock.txt |   28 +
>  .../devicetree/bindings/clock/exynos5420-clock.txt |    3 +
>  .../bindings/iommu/samsung,exynos4210-sysmmu.txt   |   76 ++
>  arch/arm/boot/dts/exynos4.dtsi                     |  105 ++
>  arch/arm/boot/dts/exynos4210.dtsi                  |   21 +
>  arch/arm/boot/dts/exynos4x12.dtsi                  |   82 ++
>  arch/arm/boot/dts/exynos5250.dtsi                  |  262 +++++
>  arch/arm/boot/dts/exynos5420.dtsi                  |  296 ++++++
>  drivers/clk/samsung/clk-exynos5250.c               |   49 +-
>  drivers/clk/samsung/clk-exynos5420.c               |   12 +-
>  drivers/iommu/Kconfig                              |    5 +-
>  drivers/iommu/exynos-iommu.c                       | 1033 +++++++++++++-------
>  12 files changed, 1585 insertions(+), 387 deletions(-)

What is the state of this series? It would be good to have some
Acked-bys and/or Reviewed-bys on it.


	Joerg
