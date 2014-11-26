From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v4 6/8] dma-mapping: set dma segment properties in
	of_dma_configure
Date: Wed, 26 Nov 2014 11:37:23 +0000
Message-ID: <20141126113723.GC14866@arm.com>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
	<1415991397-9618-7-git-send-email-will.deacon@arm.com>
	<54747EA0.1020001@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54747EA0.1020001-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 25, 2014 at 01:05:36PM +0000, Robin Murphy wrote:
> On 14/11/14 18:56, Will Deacon wrote:
> > of_dma_configure determines the size of the DMA range for a device by
> > either parsing the dma-ranges property or inspecting the coherent DMA
> > mask. This same information can be used to initialise the max segment
> > size and boundary_mask to a default value.
> >
> > Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> 
> Sadly, NAK on this one. After a thorough investigation and testing, 
> generic code really shouldn't be touching dma_parms like this, and I 
> have some corrupted files on my USB filesystem to prove it ;) It seems 
> it's a bad idea to effectively change the default segment size 
> universally unless you really want to go through the entire block layer 
> (and who-knows-what-else) to find and fix everything that relies on it 
> being 64k.
> 
> Simply dropping this patch and letting the existing defaults in 
> dma_set_max_seg_size and dma_get_seg_boundary stand seems like the 
> correct action.
> 
> 
> Marek, I believe you may have some use case for this - if so, as I 
> understand it your individual drivers should be setting up their own 
> dma_parms directly, to tell the IOMMU they can handle it merging 
> scatterlists into arbitrarily long segments, without affecting the other 
> drivers that assume they'll never see >64k segments and go wrong if they 
> do (including the generic USB stack, apparently).

Ok, I'll drop this patch from the series for the time being. It's certainly
not a crucial part of the patchset and filesystem corruption is always bad.

Will
