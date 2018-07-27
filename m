From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 0/7] Stop losing firmware-set DMA masks
Date: Fri, 27 Jul 2018 11:55:35 +0100
Message-ID: <8b8ac841-5c4c-ae27-21d5-d7aaaf4c277c@arm.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
	<c73bc8d2-b745-ff31-1949-7a59ab04ede6@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c73bc8d2-b745-ff31-1949-7a59ab04ede6-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Grygorii,

Thanks for the report.

On 27/07/18 00:45, Grygorii Strashko wrote:
[...]
> With this series applied I can't boot TI ARM32 am574x-idk any more.
> 
> And log output is full of "DMA mask not set" -

That's somewhat expected - as the relevant commit message mentions, 
there will be bugs flushed out by this change, but the point is to fix 
them :)

> nobody sets dma_mask for platform bus in case of OF boot :(

Right, after a brief investigation, that one turns out to be nice and 
straightforward to explain and fix; I'll write up the patch shortly.

[...]
> [    3.793493] ti-qspi 4b300000.qspi: dma_alloc_coherent failed, using PIO mode
> [    3.801088] Unable to handle kernel NULL pointer dereference at virtual address 00000080
[...]
> [    4.602777] [<c04d87a4>] (omap_dma_write) from [<c04d8dc0>] (omap_dma_start_desc+0x78/0x150)
> [    4.611258] [<c04d8d48>] (omap_dma_start_desc) from [<c04d9028>] (omap_dma_issue_pending+0x90/0x98)
> [    4.620347]  r9:ed002780 r8:00000000 r7:00000010 r6:ee2bdd00 r5:ee2bdd4c r4:ee2bdd00
> [    4.628130] [<c04d8f98>] (omap_dma_issue_pending) from [<c0608d1c>] (ti_qspi_dma_xfer+0x8c/0x13c)
> [    4.637039]  r5:00000000 r4:ee7e1b28
> [    4.640636] [<c0608c90>] (ti_qspi_dma_xfer) from [<c06090b0>] (ti_qspi_exec_mem_op+0x2e4/0x32c)

Hooray, a real bug! Since dma_alloc_coherent() could have failed due to 
lack of memory or any other reason, that's not even directly related to 
this change, we've simply helped uncover it. I guess that PIO fallback 
path hasn't been tested recently, because it clearly doesn't work. It 
would be good if someone who knows the ti-qspi driver and has the means 
to test it could figure that one out before also adding the missing 
dma_set_coherent_mask() call.

Robin.
