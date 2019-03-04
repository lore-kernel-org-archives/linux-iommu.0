From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 0/2][RFC] kernel/dma: Support platform-specific default
	CMA sizes
Date: Mon, 4 Mar 2019 12:01:29 +0000
Message-ID: <fe3f4ae9-6a51-0b50-09e9-6c7f52e530d3@arm.com>
References: <20190304115255.2088-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190304115255.2088-1-tzimmermann-l3A5Bk7waGM@public.gmane.org>
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
To: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>, hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: ptesarik-AlSwsSmVLrQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Thomas,

On 04/03/2019 11:52, Thomas Zimmermann wrote:
> This is an RFC patch set that adds support for configuring a default CMA
> size, depending on the platform.
> 
> At SUSE, our ARM installer image runs on a variety of platforms. One of
> these, the Raspberry Pi 3, requires CMA to be allocated on order to provide
> graphics output. Currently this can be done with the kernel's cma command-
> line parameter, or with a compile-time setting. The cma parameter requires
> user intervention during boot. Using a compile-time constant affects all
> platforms. So both options are undesireable.
> 
> This patch set adds a data structure and look-up code to select a default
> CMA size, depending on the device's model name. The kernel's cma parameter
> or a compile-time setting take precedence of the per-device default.

Is there some issue with specifying a board-specific default CMA region 
via the existing DT binding[1]? I assume there are no ACPI concerns in 
this particular case.

Robin.

[1] Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt

> For the Raspberry Pi 3, the CMA allocator now reserves 64 MiB (out of
> 1 GiB) by default. We found that this is enough memory to run a graphics
> installer or a simple desktop environment under X11.
> 
> Thomas Zimmermann (2):
>    kernel/dma: Support device-specific CMA defaults
>    kernel/dma: Default to 64 MiB of contiguous memory on Raspberry Pi 3
> 
>   kernel/dma/contiguous.c | 62 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
> 
