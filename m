From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 0/5] add non-strict mode support for arm-smmu-v3
Date: Mon, 11 Jun 2018 12:05:30 +0100
Message-ID: <d6f46de0-f8c3-2c9e-4de3-5949db0cf7b5@arm.com>
References: <1528628843-10280-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1528628843-10280-1-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Guozhu Li <liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Libin <huawei.libin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Zhen Lei,

On 10/06/18 12:07, Zhen Lei wrote:
> v1 -> v2:
> Use the lowest bit of the io_pgtable_ops.unmap's iova parameter to pass the strict mode:
> 0, IOMMU_STRICT;
> 1, IOMMU_NON_STRICT;
> Treat 0 as IOMMU_STRICT, so that the unmap operation can compatible with
> other IOMMUs which still use strict mode. In other words, this patch series
> will not impact other IOMMU drivers. I tried add a new quirk IO_PGTABLE_QUIRK_NON_STRICT
> in io_pgtable_cfg.quirks, but it can not pass the strict mode of the domain from SMMUv3
> driver to io-pgtable module. 
> 
> Add a new member domain_non_strict in struct iommu_dma_cookie, this member will only be
> initialized when the related domain and IOMMU driver support non-strict mode.

It's not obvious from the commit messages or comments what the
non-strict mode involves exactly. Could you add a description, and point
out the trade-off associated with it?

In this mode you don't send an invalidate commands when removing a leaf
entry, but instead send invalidate-all commands at regular interval.
This improves performance but introduces a vulnerability window, which
should be pointed out to users.

IOVA allocation isn't the only problem, I'm concerned about the page
allocator. If unmap() returns early, the TLB entry is still valid after
the kernel reallocate the page. The device can then perform a
use-after-free (instead of getting a translation fault), so a buggy
device will corrupt memory and an untrusted one will access arbitrary data.

Or is there a way in mm to ensure that the page isn't reallocated until
the invalidation succeeds? Could dma-iommu help with this? Having
support from the mm would also help consolidate ATS, mark a page stale
when an ATC invalidation times out. But last time I checked it seemed
quite difficult to implement, and ATS is inherently insecure so I didn't
bother.

At the very least I think it might be worth warning users in dmesg about
this pitfall (and add_taint?). Tell them that an IOMMU in this mode is
good for scatter-gather performance but lacks full isolation. The
"non-strict" name seems somewhat harmless, and people should know what
they're getting into before enabling this.

Thanks,
Jean
