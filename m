From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
	of_dma_configure
Date: Thu, 8 Jan 2015 10:53:06 +0000
Message-ID: <20150108105306.GC11583@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<7693528.krAZff0s6I@wuerfel> <20150107185704.GV7485@arm.com>
	<2577020.XPDvrs2bDx@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2577020.XPDvrs2bDx@wuerfel>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 07, 2015 at 07:29:15PM +0000, Arnd Bergmann wrote:
> On Wednesday 07 January 2015 18:57:05 Will Deacon wrote:
> > Sorry for the delay on this, I had to do a bit of digging.
> > 
> > On Mon, Dec 22, 2014 at 01:36:01PM +0000, Arnd Bergmann wrote:
> > > Do you think it's possible that we might have to deal with a single PCI host
> > > that is connected two different SMMU instances for the purposes of extending
> > > the StreamID space from 15 to 16 bits? I think we would have trouble
> > > expressing this with the current syntax.
> > 
> > Unfortunately, this sounds like something we may well have to support.
> > Whilst the SMMUv2 architecture did grow a late extension to support 16-bit
> > StreamIDs, that may have been too late for all silicon vendors and, as such,
> > I'm not confident that such systems will present a single software interface
> > for their SMMU.
> 
> So it's technically possible to connect two SMMU instances to a single
> PCIe root complex? I knew that there is at least one vendor (AMD) that
> can only do 128 bus numbers on PCIe, which seems a much simpler workaround.

I think you'd need to add some additional logic around the host controller,
but I don't see why it wouldn't be possible to send the first 32k SIDs off
to one SMMU and the other 32k off somewhere else -- those IDs are carried on
the bus, after all.

That said, something being `technically possible' isn't always a good reason
for us to support it :)

Will
