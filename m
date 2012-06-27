From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Wed, 27 Jun 2012 12:02:46 -0600
Message-ID: <4FEB4AC6.2060909@wwwdotorg.org>
References: <20120626105513.GA9552@avionic-0098.mockup.avionic-design.de>
	<20120626160224.40ba10a26e3dd3a56b1f312c@nvidia.com>
	<20120626140033.GC1115@avionic-0098.mockup.avionic-design.de>
	<20120627154400.d9d7db67128404079d98ab39@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120627154400.d9d7db67128404079d98ab39-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 06/27/2012 06:44 AM, Hiroshi Doyu wrote:
...
> I think that there are 2 cases:
> 
>   (1) discontiguous memory with IOMMU
>   (2) contiguous memory without IOMMU(called "carveout" in general?)
...
> For (2), although memory is mostly anonymous one, we may need to know
> how much to allocate, where we only need "size". This size is not from
> h/w feature, but it depends on the system load/usage. So I think that
> this size can be passed from kernel command line? For exmaple, we can
> specify how much contiguous memory is necessary with putting
> "coherent_pool=??M" in the kernel command line as below:
> 
> 	coherent_pool=nn[KMG]	[ARM,KNL]
> 			Sets the size of memory pool for coherent, atomic dma
> 			allocations.

I guess if that's the standard way of initializing CMA, then that's fine.

It'd be nice if there was a way to specify that from the DT too; that
way the user/distro/bootloader constructing the kernel command-line
wouldn't have to remember to add "random" (potentially
Tegra-/board-specific) extra arguments onto the command-line; the Tegra
command-line in the upstream kernel is quite clean right now, especially
compare to the enormous number of options we require downstream:-(
