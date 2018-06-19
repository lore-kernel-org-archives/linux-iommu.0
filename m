From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm-v7s: Abort allocation when table
	address overflows the PTE
Date: Tue, 19 Jun 2018 14:01:30 +0100
Message-ID: <20180619130130.GI13984@arm.com>
References: <20180619125224.1008-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180619125224.1008-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 19, 2018 at 01:52:24PM +0100, Jean-Philippe Brucker wrote:
> When run on a 64-bit system in selftest, the v7s driver may obtain page
> table with physical addresses larger than 32-bit. Level-2 tables are 1KB
> and are are allocated with slab, which doesn't accept the GFP_DMA32
> flag. Currently map() truncates the address written in the PTE, causing
> iova_to_phys() or unmap() to access invalid memory. Kasan reports it as
> a use-after-free. To avoid any nasty surprise, test if the physical
> address fits in a PTE before returning a new table. 32-bit systems,
> which are the main users of this page table format, shouldn't see any
> difference.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Thanks, I'll queue this too.

It would be nice if we could use GFP_DMA32 instead of failing the request,
but that doesn't work at all with the kmem_cache so we'd have to roll our
own l2 allocator if we wanted to support this.

Will
