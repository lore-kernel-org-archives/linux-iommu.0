From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] iommu: Do physical merging in iommu_map_sg()
Date: Tue, 6 Nov 2018 16:38:14 +0100
Message-ID: <20181106153814.sxehqvr5t6fzlnsy@8bytes.org>
References: <90d22e679e64e9830ebe993665e2c04a612fdaf9.1539018455.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <90d22e679e64e9830ebe993665e2c04a612fdaf9.1539018455.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 11, 2018 at 04:56:42PM +0100, Robin Murphy wrote:
> The original motivation for iommu_map_sg() was to give IOMMU drivers the
> chance to map an IOVA-contiguous scatterlist as efficiently as they
> could. It turns out that there isn't really much driver-specific
> business involved there, so now that the default implementation is
> mandatory let's just improve that - the main thing we're after is to use
> larger pages wherever possible, and as long as domain->pgsize_bitmap
> reflects reality, iommu_map() can already do that in a generic way. All
> we need to do is detect physically-contiguous segments and batch them
> into a single map operation, since whatever we do here is transparent to
> our caller and not bound by any segment-length restrictions on the list
> itself.
> 
> Speaking of efficiency, there's really very little point in duplicating
> the checks that iommu_map() is going to do anyway, so those get cleared
> up in the process.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Looks correct, applied, thanks.
