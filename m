From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v2 8/8] iommu/arm-smmu: implement add_reserved_regions
	callback
Date: Thu, 10 Nov 2016 19:00:52 +0100
Message-ID: <f4537e43-0237-e478-eacd-b107458628b8@redhat.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
	<1478258646-3117-9-git-send-email-eric.auger@redhat.com>
	<20161110154606.GH2078@8bytes.org>
	<04ed9694-707d-260b-70c6-f367d292ceca@redhat.com>
	<20161110161331.GJ2078@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161110161331.GJ2078-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 10/11/2016 17:13, Joerg Roedel wrote:
> On Thu, Nov 10, 2016 at 04:57:51PM +0100, Auger Eric wrote:
>> It does not only serve the purpose to register the MSI IOVA region. We
>> also need to allocate an iova_domain where MSI IOVAs will be allocated
>> upon the request of the relevant MSI controllers. Do you mean you don't
>> like to use the iova allocator for this purpose?
> 
> Yes, it looks like the only purpose of iommu_get_dma_msi_region_cookie()
> is to get the msi-region information into into the reserved-list.
> 
> Why do you need to 'allocate' the MSI region after all? Except for
> IOMMU_DOMAIN_DMA domains the iommu-core code does not care about address
> allocation. This is up to the users of the domain, which includes that
> the user has to take care of the MSI region.
The purpose is to reuse the transparent MSI IOVA allocation scheme
introduced by Robin in [PATCH v7 00/22] Generic DT bindings for PCI
IOMMUs and ARM SMMU (commit 44bb7e243bd4b4e5c79de2452cd9762582f58925).

GICv2m and GICV3 ITS use dma-mapping iommu_dma_map_msi_msg to allocate
an MSI IOVA on-demand. This relies on the existence of an allocated
iova_domain whose handle is stored in domain->iova_cookie.

the iommu_dma_init_domain could be done in VFIO instead of in the
IOMMU-code, on the basis of dm region info. But we would need to
differentiate the MSI window from P2P windows.

msi-region start/length are arbitrarily chosen and the setup of the
reserved region list does not depend on iommu_get_dma_msi_region_cookie;
but maybe I completely misunderstand your question.


> Besides that, 'iommu_get_dma_msi_region_cookie' is a terrible function
> name and does not describe at all what the function does or is supposed
> to do.
Yes this was discussed with Alex& Robin already
(https://patchwork.kernel.org/patch/9363989/). I proposed to rename into
iommu_setup_dma_msi_region but this was not validated.

Thanks

Eric
> 
> 
> 	Joerg
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
