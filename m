From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
Date: Tue, 6 Jun 2017 14:05:17 +0200
Message-ID: <20170606120516.GD30388@8bytes.org>
References: <20170605195203.11512.20579.stgit@tlendack-t1.amdoffice.net>
	<20170605195235.11512.52995.stgit@tlendack-t1.amdoffice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170605195235.11512.52995.stgit-qCXWGYdRb2BnqfbPTmsdiZQ+2ll4COg0XqFh9Ls21Oc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
Cc: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hey Tom,

On Mon, Jun 05, 2017 at 02:52:35PM -0500, Tom Lendacky wrote:
> After reducing the amount of MMIO performed by the IOMMU during operation,
> perf data shows that flushing the TLB for all protection domains during
> DMA unmapping is a performance issue. It is not necessary to flush the
> TLBs for all protection domains, only the protection domains associated
> with iova's on the flush queue.
> 
> Create a separate queue that tracks the protection domains associated with
> the iova's on the flush queue. This new queue optimizes the flushing of
> TLBs to the required protection domains.
> 
> Reviewed-by: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c |   56 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 6 deletions(-)

I also did a major rewrite of the AMD IOMMU queue handling and flushing
code last week. It is functionally complete and I am currently testing,
documenting it, and cleaning it up. I pushed the current state of it to

	git://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git amd-iommu

Its quite intrusive as it implements a per-domain flush-queue, and uses
a ring-buffer instead of a real queue. But you see the details in the
code.

Can you please have a look and give it a test in your setup?


Thanks,

	Joerg
