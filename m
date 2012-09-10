From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: DMA Remapping and Marvell 88SE9172, 88SE9128 SATA controllers
Date: Mon, 10 Sep 2012 08:25:49 -0600
Message-ID: <1347287149.24938.11.camel@ul30vt.home>
References: <CAJtEV7aGSvRvyevveysWkDn18Oz3n3qF6EpPtgvwC4dsJU41HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAJtEV7aGSvRvyevveysWkDn18Oz3n3qF6EpPtgvwC4dsJU41HA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: pawel.zaq-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2012-08-28 at 00:05 +0800, Andrew Cooks wrote:
> There's a problem relating to DMA Remapping which affects systems with
> Marvell SATA controllers. It was first reported on 2012-01-28 on
> bugzilla.kernel.org[1] and is best described by Don Dutile: "...the
> lspci dump in the bugzilla report doesn't show a device w/BDF=0b:00.1;
> so, if the SATA device (which is 0b:00.0) is spitting out 0b:00.1 as
> the source of any of its DMA packets, the IOMMU will fault on it,
> since 0b:00.1 didn't request DMA mappings (0b:00.0 did)."[2]
> 
> Is this kind of problem caused by a missing/incorrect entry in an ACPI
> table? Is it feasible to introduce a fake device for the missing
> function using a pci quirk?

We've added pci_get_dma_source() to help with such devices, but it's
only used by the IOMMU grouping code and requires a struct pci_dev for
the actual DMA source.  I think for this device we're going to need to
run a quirk when we scan it that creates a fake device, add it to
pci_get_dma_source(), then make use of it in the dma mapping path.  I
think the only other alternative would be to disable hardware IOMMUs
when this device is found in the system.  Thanks,

Alex
