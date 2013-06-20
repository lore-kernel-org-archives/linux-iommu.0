From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [Linaro-mm-sig] [RFC 2/3] ARM: dma-mapping: Pass DMA attrs as
	IOMMU prot
Date: Thu, 20 Jun 2013 12:57:58 +0200
Message-ID: <201306201257.58419.arnd@arndb.de>
References: <CAMcxFTS0dUUEfGj-=-cb_rdfy+qWvtsaoR6Tv+-x05XX0mZmmw@mail.gmail.com>
	<201306201213.13644.arnd@arndb.de>
	<20130620.133407.798194318297047071.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130620.133407.798194318297047071.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "nishanth.p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <nishanth.p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thursday 20 June 2013, Hiroshi Doyu wrote:
> Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote @ Thu, 20 Jun 2013 12:13:13 +0200:
> 
> > On Thursday 20 June 2013, Hiroshi Doyu wrote:
> > > > If devices allocate via dma-mapping API, physical mem allocation, iova
> > > > allocation and iommu mapping happens internally.
> > > > Devices may allocate physical memory using any allocator (say ION
> > > > including carveout area), use "iommu mapping" API which will do iova
> > > > allocation and iommu mapping. The prot flags could be useful in this
> > > > case as well - not sure whether we would need dma-attrs here.
> > > 
> > > I haven't followed ION recently, but can't ION backed by DMA mapping
> > > API instead of using IOMMU API directly?
> > 
> > For a GPU with an IOMMU, you typically want per-process IOMMU contexts,
> > which are only available when using the IOMMU API directly, as the
> > dma-mapping abstraction uses only one context for kernel space.
> 
> Yes, we had some experiment for switching IOMMU context with DMA
> mapping API. We needed to add some new DMA mapping API, and didn't
> look so nice at that time. What do you think to introduce multiple
> context or switching context in dma-mapping abstruction?

My feeling is that drivers with the need for multiple contexts
are better off using the iommu API, since that is what it was
made for. The dma-mapping abstraction really tries to hide the
bus address assignment, while users with multiple contexts typically
also want to control the bus addresses.

	Arnd
