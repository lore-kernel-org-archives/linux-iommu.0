From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 00/10] KVM PCIe/MSI passthrough on ARM/ARM64: kernel
	part 1/3: iommu changes
Date: Thu, 21 Apr 2016 13:32:22 -0600
Message-ID: <20160421133222.76e45596@t450s.home>
References: <1461084994-2355-1-git-send-email-eric.auger@linaro.org>
	<5718C501.20906@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5718C501.20906-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, eric.auger-qxv4g6HH51o@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 21 Apr 2016 14:18:09 +0200
Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> Hi Alex, Robin,
> On 04/19/2016 06:56 PM, Eric Auger wrote:
> > This series introduces the dma-reserved-iommu api used to:
> > 
> > - create/destroy an iova domain dedicated to reserved iova bindings
> > - map/unmap physical addresses onto reserved IOVAs.
> > - search for an existing reserved iova mapping matching a PA window
> > - determine whether an msi needs to be iommu mapped
> > - translate an msi_msg PA address into its IOVA counterpart  
> 
> Following Robin's review, I understand one important point we have to
> clarify is how much this API has to be generic.
> 
> I agree with Robin on the fact there is quite a lot of duplication
> between this dma-reserved-iommu implementation and dma-iommu
> implementation. Maybe we could consider an msi-mapping API
> implementation upon dma-iommu.c. This implementation would add MSI
> doorbell binding list management, including, ref counting and locking.
> 
> We would need to add a map/unmap function taking an iova/pa/size as
> parameters in current dma-iommu.c
> 
> An important assumption is that the dma-mapping API and the msi-mapping
> API must not be used concurrently (be would be trying to use the same
> cookie to store a different iova_domain).
> 
> Any thought/suggestion?

Hi Eric,

I'm not attached to a generic interface, the important part for me is
that if we have an iommu domain with space reserved for MSI, the MSI
setup and allocation code should handle that so we don't need to play
the remapping tricks between vfio-pci and a vfio iommu driver that we
saw in early drafts of this.  My first inclination is always to try to
make a generic, re-usable interface, but I apologize if that's led us
astray here and we really do want the more simple, MSI specific
interface.

For the IOMMU API, rather than just a DOMAIN_ATTR_MSI_MAPPING flag,
what about DOMAIN_ATTR_MSI_GEOMETRY with both a get and set attribute?
Maybe something like:

struct iommu_domain_msi_geometry {
	dma_addr_t	aperture_start;
	dma_addr_t	aperture_end;
	bool		fixed; /* or 'programmable' depending on your polarity preference */
};

Calling \get\ on arm would return { 0, 0, false }, indicating it's
programmable, \set\ would allocate the iovad as specified.  That would
make it very easy to expand the API to x86 with reporting of the fixed
MSI range and it operates within the existing IOMMU API interfaces.
Thanks,

Alex
