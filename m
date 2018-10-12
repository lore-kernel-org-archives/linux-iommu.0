From: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RFC PATCH v3 10/10] iommu/sva: Add support for private PASIDs
Date: Fri, 12 Oct 2018 08:32:29 -0600
Message-ID: <20181012143229.GI9977@jcrouse-lnx.qualcomm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
	<20180920170046.20154-11-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180920170046.20154-11-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
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
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 20, 2018 at 06:00:46PM +0100, Jean-Philippe Brucker wrote:
> Provide an API for allocating PASIDs and populating them manually. To ease
> cleanup and factor allocation code, reuse the io_mm structure for private
> PASID. Private io_mm has a NULL mm_struct pointer, and cannot be bound to
> multiple devices. The mm_alloc() IOMMU op must now check if the mm
> argument is NULL, in which case it should allocate io_pgtables instead of
> binding to an mm.
> 
> Signed-off-by: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> ---
> Sadly this probably won't be the final thing. The API in this patch is
> used like this:
> 
>         iommu_sva_alloc_pasid(dev, &io_mm) -> PASID
>         iommu_sva_map(io_mm, ...)
>         iommu_sva_unmap(io_mm, ...)
>         iommu_sva_free_pasid(dev, io_mm)
> 
> The proposed API for auxiliary domains is in an early stage but might
> replace this patch and could be used like this:
> 
>         iommu_enable_aux_domain(dev)
>         d = iommu_domain_alloc()
>         iommu_attach_aux(dev, d)
>         iommu_aux_id(d) -> PASID
>         iommu_map(d, ...)
>         iommu_unmap(d, ...)
>         iommu_detach_aux(dev, d)
>         iommu_domain_free(d)
> 
> The advantage being that the driver doesn't have to use a special
> version of map/unmap/etc.

Hi Jean-Phillippe -

Have you thought about this any more? I want to send out a
refresh for the per-context pagetables for arm-smmu so if we want to change
the underlying assumptions this would be a great time.

For my part I'm okay with either model. In fact the second one is closer
to the original implementation that I sent out so I have a clear development
path in mind for either option depending on what the community decides.

Thanks,
Jordan

<snip the rest of the patch>

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
