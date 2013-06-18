From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: DMA mapping API(IOMMU) for ARM64?
Date: Tue, 18 Jun 2013 17:20:45 +0200
Message-ID: <20130618.182045.1828458783306503680.hdoyu@nvidia.com>
References: <20130618.140137.1551430695673122122.hdoyu@nvidia.com><20130618125054.GL9930@arm.com><201306181615.27341.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <201306181615.27341.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "Will.Deacon-5wv7dgnIgG8@public.gmane.org" <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote @ Tue, 18 Jun 2013 16:15:27 +0200:

> On Tuesday 18 June 2013, Catalin Marinas wrote:
> > > 1, Copy arch/arm/mm/dma-mapping.c arch/arm64/mm/dma-mapping.c(+swiotlb)
> > > 2, Adapt arch/arm64/mm/dma-mapping.c(+swiotlb) to 64bit compatible.
> > > 3, Factor out the common code from them into mm/dma-mapping.c
> > 
> > Or add the relevant code to something like lib/iommu-helper.c, convert
> > arm64 to use that and we can work on converting arm and other
> > architectures afterwards.
> 
> Yes, that would work too.

Ok, this seems to be the way to go. Thank you for the guide.
