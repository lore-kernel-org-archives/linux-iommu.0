From: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 11/13] dma-direct: handle the memory encryption bit in
	common code
Date: Wed, 14 Mar 2018 10:44:29 -0500
Message-ID: <69e98163-beca-fb8a-a26b-66dfeef2f689@amd.com>
References: <20180305174655.9878-1-hch@lst.de>
	<20180305174655.9878-12-hch@lst.de>
	<114e27be-5814-4258-4985-af08763c8a74@amd.com>
	<0c9d3e4a-8407-282a-73eb-21d28047e0e3@amd.com>
	<20180313131005.GA6260@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180313131005.GA6260-jcswGhMUV9g@public.gmane.org>
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
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Muli Ben-Yehuda <mulix-BzGcCpaT2IbYtjvyW6yDsg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 03/13/2018 08:10 AM, Christoph Hellwig wrote:
> On Mon, Mar 12, 2018 at 02:48:51PM -0500, Tom Lendacky wrote:
>> Ok, I found one issue that allows this to work when the IOMMU isn't
>> enabled (see below).
> 
> Thanks, folded!
> 
>> But the bigger issue is when the IOMMU is enabled.  The IOMMU code uses
>> a common mapping routine to create the I/O page tables.  This routine
>> assumes that all memory being mapped is encrypted and therefore sets the
>> encryption bit in the I/O page tables.  With this patch, the call to
>> dma_alloc_direct() now returns un-encrypted memory which results in an
>> encryption mis-match.  I think keeping dma_alloc_direct() as it was prior
>> to this patch is the way to go.  It allows SME DMA allocations to remain
>> encrypted and avoids added complexity in the amd_iommu.c file.  This
>> would mean that SEV would still have special DMA operations (so that the
>> alloc/free can change the memory to un-encrypted).
>>
>> What do you think?
> 
> In terms of logic you are right.  I still don't like keeping a just
> slightly tweaked version of dma_alloc_direct around just for this, it
> will be perpetually out of sync in terms of features and bug fixes.
> 
> What do you think about this version that does the decision at runtime:
> 
> 	http://git.infradead.org/users/hch/misc.git/commitdiff/b89f24dc856595dc7610d672bf077195ab0dabf4
> 
> The full tree is available here for testing:
> 
> 	git://git.infradead.org/users/hch/misc.git dma-direct-x86
> 

Thanks for the pointer to the tree.  I did find one bug in the
allocation routine, that once fixed (see below), worked with SME
for IOMMU on and off and worked with an SEV guest.

I understand the comment about using sev_active() in the dma-direct
code, maybe we can up with something later to address that.

Thanks,
Tom

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index 856e140..988a3d8 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -82,10 +82,12 @@ void *dma_direct_alloc(struct device *dev, size_t
size, dma_addr_t *dma_handle,

 	if (!page)
 		return NULL;
-	*dma_handle = __phys_to_dma(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma(dev, page_to_phys(page));
 	ret = page_address(page);
-	if (sev_active())
+	if (sev_active()) {
+		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
 		set_memory_decrypted((unsigned long)ret, 1 << page_order);
+	}
 	memset(ret, 0, size);
 	return ret;
 }
