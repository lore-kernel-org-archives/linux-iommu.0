From: Christoph Schwerdtfeger <cstealth-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: AMD IOMMU: Please support Marvell 88SE91xx SATA Controllers
Date: Mon, 24 Jun 2013 13:02:26 +0000 (UTC)
Message-ID: <loom.20130624T145837-452@post.gmane.org>
References: <519A93F0.8070606@gmx.ch> <20130521203526.GE7424@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Joerg Roedel <joro@...> writes:

> 
> On Mon, May 20, 2013 at 11:21:52PM +0200, Manfred Schwarb wrote:
> > Is anybody working on this issue for the AMD part? I would be very
> > grateful if such support could be added to the linux kernel. I would
> > be prepared to test patches, if needed.
> 
> I will look into the best way to port this to the AMD IOMMU driver. Will
> send you a patch for testing when I have somthing.
> 
> 	Joerg
> 
> 


Is there any progress regarding this controller?

I'm having the same issue with a non working S-ATA controller on an AMD
board (Gigabyte GA-990FXA-UD5[1] mainboard).

I have also the same issue with IOMMU off as reported somewhere else (forgot
where I read it): If I disable IOMMU in the BIOS/(U)EFI the Marvell
controller is working but the USB ports and my network (LAN and WLAN) are not.

Kind regards

Christoph

[1] http://www.gigabyte.de/products/product-page.aspx?pid=4455#ov
