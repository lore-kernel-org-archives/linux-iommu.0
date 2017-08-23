From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/13] Introduce IOMMU-API TLB Flushing Interface
Date: Wed, 23 Aug 2017 14:09:07 +0200
Message-ID: <20170823120907.GC19533@8bytes.org>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
	<20170817083520.3329c0ff@w520.home>
	<20170817144308.GI16908@8bytes.org>
	<20170817085407.3de4e755@w520.home>
	<20170817152220.GK16908@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170817152220.GK16908-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 17, 2017 at 05:22:20PM +0200, Joerg Roedel wrote:
> What I absolutly don't want is that the whole explicit TLB flushing
> of the IOMMU-API (as introduced in this patch-set) is considered some
> optional part of the API, as it would be when I just introduce _async
> versions of map/unmap/map_sg.

Okay, forget that :)

The discussions I had around this interface made me change it a little
bit in the version 2 of the patch-set which I will post soon.

I thought a bit more about the iommu_map() code-path. It really doesn't
make any sense to remove the tlb-sync requirement from it, because in
almost all cases the hardware doesn't require any flushes after a map
operation anyway. And in the rare cases where it does - because the
hardware is emulated and slow - the iommu-driver can handle
that by doing a flush in its iommu_ops->map() call-back.

So I removed the iommu_map_sync() and iommu_map_sg_sync() functions from
this series. With those changes it also doesn't make sense anymore
to have different tlb-sync semantics between iommu_map() and
iommu_unmap(). So I ended up introducing a new iommu_unmap_fast()
function which can unmap ranges and return with dirty io-tlbs.

This makes the extension of couse look somewhat optional, which I tried
to avoid, but I hope the '_fast' part of the name is enough motivation for
iommu-api users to look into ways to use it in their code.


Regards,

	Joerg
