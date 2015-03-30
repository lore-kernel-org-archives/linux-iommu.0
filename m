From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: IOMMU and domain binding/unbinding logic
Date: Mon, 30 Mar 2015 11:46:46 +0200
Message-ID: <20150330094646.GY4441@8bytes.org>
References: <20150326165046.GA2965@gmail.com>
	<20150326170935.GX4441@8bytes.org>
	<20150326175857.GA3196@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150326175857.GA3196-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Jerome,

On Thu, Mar 26, 2015 at 01:58:58PM -0400, Jerome Glisse wrote:
> Of course if dev.archdata.dma_ops is pointing to nommu_dma_ops then every
> things is fine, but here i am wondering for the case where the ops are
> actualy amd_iommu_dma_ops. In the first place ie at iommu initialization
> or when hotpluging a new device (as in the hotpluging case it always set
> dev.archdata.dma_ops to amd_iommu_dma_ops AFAICT.

Yes, every device that is IOMMUv2 capable (ATS + PRI + PASID capability
present) is put into the passthrough domain at boot time. The dma_ops
point to nommu_dma_ops and after the device is used for IOMMUv2 mappings
the old DMA-API mappings remain valid.

For details you can have a look into the AMD IOMMU driver and how the
return value of pci_iommuv2_capable() is propageted.


	Joerg
