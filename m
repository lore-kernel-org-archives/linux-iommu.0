From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH v2 0/7] Stop losing firmware-set DMA masks
Date: Mon, 6 Aug 2018 14:13:34 +0200
Message-ID: <20180806121334.GA5340@lst.de>
References: <cover.1532382222.git.robin.murphy@arm.com>
	<CAK8P3a3HDJ6svNN_cwvegxu20yNv8+tvc0D1A6Ooeq8agawbFg@mail.gmail.com>
	<1ccccc4b-7d4c-a3ee-23a2-f108916705e9@arm.com>
	<CAK8P3a3ZcOeHMR_qFnsBdXED+2X8_AEMKoS5MeAQhbapbGmm9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3ZcOeHMR_qFnsBdXED+2X8_AEMKoS5MeAQhbapbGmm9w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gregkh <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, the arch/x86 maintainers <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 06, 2018 at 12:01:34PM +0200, Arnd Bergmann wrote:
> There are a few subtle corner cases here, in particular in which cases
> the new dma_set_mask() behavior on arm64 reports success or
> failure when truncating the mask to the bus_dma_mask.

Going forward my plan was to make dma_set_mask() never fail.  The idea
is that it sets the mask that the device is capable of, and the core
dma code is responsible for also looking at bus_dma_mask and otherwise
make things just work.

Robin brought up the case where a platform can't handle a given limitation
ever, e.g. a PCI(e) device with a 24-bit dma mask on a device with a dma
offset that means we'll never have any physical memory reachable in that
range.  So we'll either still need to allow it to fail for such corner
cases or delay such error until later, e.g. when dma_alloc_* (or in the
corner case of the corner case dma_map_*) is called.  I'm still undecided
which way to go, but not allowing error returns from dma_set_mask and
its variants sounds very tempting.
