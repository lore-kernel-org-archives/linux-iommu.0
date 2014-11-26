From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v4 0/8] Introduce automatic DMA configuration for
	IOMMU masters
Date: Wed, 26 Nov 2014 17:47:07 +0000
Message-ID: <20141126174707.GO14866@arm.com>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
	<546C7D36.7030400@samsung.com> <20141119114150.GD15985@arm.com>
	<54743139.2020804@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54743139.2020804-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi all,

On Tue, Nov 25, 2014 at 07:35:21AM +0000, Marek Szyprowski wrote:
> On 2014-11-19 12:41, Will Deacon wrote:
> > On Wed, Nov 19, 2014 at 11:21:26AM +0000, Marek Szyprowski wrote:
> >> On 2014-11-14 19:56, Will Deacon wrote:
> >>> Hello everybody,
> >>>
> >>> Here is the fourth iteration of the RFC I've previously posted here:
> >>>
> >>>     RFCv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/283023.html
> >>>     RFCv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283752.html
> >>>     RFCv3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287031.html
> >>>
> >>> Changes since RFCv3 include:
> >>>
> >>>     - Drastic simplification of the data structures, so that we no longer
> >>>       pass around lists of domains. Instead, dma-mapping is expected to
> >>>       allocate the domain (Joerg talked about adding a get_default_domain
> >>>       operation to iommu_ops).
> >>>
> >>>     - iommu_ops is used to hold the per-instance IOMMU data
> >>>
> >>>     - Configuration of DMA segments added to of_dma_configure
> >>>
> >>> All feedback welcome.
> >> I've rebased my Exynos SYSMMU patches on top of this patchset and it
> >> works fine,
> >> You can find them in the "[PATCH v3 00/19] Exynos SYSMMU (IOMMU)
> >> integration with DT
> >> and DMA-mapping subsystem" thread.
> > I just saw that and it looks great, thanks! FWIW, I'll take the first 3
> > patches you have into my series in some shape or another.
> 
> It would be great if the iommu integration patches were merged to -next 
> to give
> them a try for a few days. Joerg: do you plan to take those patches to 
> v3.19 or
> do you want to wait more?

I don't know what the plan is to get this series upstream.

Joerg, would you expect this to go via your tree or via something broader
like arm-soc, with your Ack on the IOMMU bits (patches 1, 3 and 4) instead?

I certainly don't see why patches 1-5 couldn't be queued, then we could add
the ARM bits later. I just need to know where to send them!

Will
