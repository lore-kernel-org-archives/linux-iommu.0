From: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: IOMMU and domain binding/unbinding logic
Date: Thu, 26 Mar 2015 13:58:58 -0400
Message-ID: <20150326175857.GA3196@gmail.com>
References: <20150326165046.GA2965@gmail.com>
	<20150326170935.GX4441@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150326170935.GX4441-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 26, 2015 at 06:09:35PM +0100, Joerg Roedel wrote:
> Hi Jerome,
> =

> On Thu, Mar 26, 2015 at 12:50:47PM -0400, Jerome Glisse wrote:
> > So how comes it still looks like it is working properly ? My best guest
> > it is because it is by default in passthrough, but i haven't checked th=
at
> > theory.
> =

> Your guess is correct, devices that might potentially use IOMMUv2
> functionality are identity mapped by default. The reason is that IOMMU
> hardware implements two dimensional paging, where the addresses in the
> guest page-tables (the ones translating PASID requests) are translated
> by the host page-tables. So to be able to use CPU page-tables (mm->pgd)
> for the IOMMU, the host page-tables need to be identity mapped.

Well this still doesn't explain how things works. So assume that you
boot computer and that the IOMMU bind to the GPU is not passthrough and
perform real remapping of bus address to physical address. You have :

  radeon_gpu_driver_init() {
    general_buffer =3D dma_map_page(gpu_dev, page);
    radeon_kfd_init() {
      amd_iommu_init_device(gpu_dev) {
        // bind new DOMAIN and detach old one, all previous dma address
        // are now invalid and will point to physical address directly,
        // if dma address where identity mapped at gpu_driver init time
        // than things are fine.
        //
        // Otherwise hw is accessing some random memory other then what
        // it believe general_buffer is at ie the first dma_map_page()
        // returned dma_addr !=3D page_to_phys(page)
      }
    }

More over after amd_iommu_init_device(gpu_dev), any dma_map_page() should
fails as it will return ERR_PTR(-EINVAL) because get_domain(dev) (from
drivers/iommu/amd_iommu.c) will return ERR_PTR(-EBUSY) as the new domain
is not DMA capable.

Of course if dev.archdata.dma_ops is pointing to nommu_dma_ops then every
things is fine, but here i am wondering for the case where the ops are
actualy amd_iommu_dma_ops. In the first place ie at iommu initialization
or when hotpluging a new device (as in the hotpluging case it always set
dev.archdata.dma_ops to amd_iommu_dma_ops AFAICT.

Cheers,
J=E9r=F4me
