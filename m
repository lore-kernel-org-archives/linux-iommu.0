From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 00/22] Generic DT bindings for PCI IOMMUs and ARM SMMU
Date: Mon, 19 Sep 2016 13:24:36 +0100
Message-ID: <20160919122435.GD9005@arm.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
 <11ebd81e-2ea5-5ff3-35b3-be95f03e05bd@redhat.com>
 <d03ea5e7-59f1-8b49-4ba2-d05fc2030ebc@arm.com>
 <04a0a682-4fdc-8d62-57cd-efdf730582c6@redhat.com>
 <c2645c5e-edd3-2b31-4311-0ca621a915e2@arm.com>
 <4d87d5f2-0350-b5f8-ffc3-4e9377cf1f87@redhat.com>
 <fc4ce398-4eeb-f2ca-b964-e9f466be79c4@arm.com>
 <1838c65d-5944-8946-781c-b420bea1acab@redhat.com>
 <f16db032-1905-9804-0607-fe007af72b0e@arm.com>
 <48f3bc10-3966-7d50-d070-7ec7f0946c92@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <48f3bc10-3966-7d50-d070-7ec7f0946c92-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 19, 2016 at 02:13:45PM +0200, Auger Eric wrote:
> On 16/09/2016 18:18, Robin Murphy wrote:
> > What I probably will do, though, since we have the functionality in
> > place for the sake of the old binding, and I think there are other folks
> > who want PCI iommu-map support but would prefer not to bother with DMA
> > ops on the host, is add a command-line option to disable DMA domains
> > even for the generic bindings.
> 
> Yes this would be a good thing I think. This series has an important
> impact on platforms which do not have smmu v3, where contexts are scarce
> HW resources.

Rather than disabling DMA domains entirely, we could specify a number
of contexts to reserve for other use (e.g. VFIO). It's a pity that these
options are global for the system, as opposed to per SMMU instance,
but I can't see a good way around that.

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
