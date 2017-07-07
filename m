From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 0/2] Add sideband data extraction
Date: Fri, 7 Jul 2017 14:21:31 +0100
Message-ID: <20170707132131.GA3425@leverpostej>
References: <1499411399-25103-1-git-send-email-srinath.mannam@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1499411399-25103-1-git-send-email-srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 07, 2017 at 12:39:57PM +0530, Srinath Mannam wrote:
> These patches implements optional DT properties to generate
> smaller sideband data from RID which can be further mapped
> to MSI Device ID or Stream ID
> 
> On some of the systems, sideband data is smaller than RID
> (16bits). For such system, sideband data has to be generated
> by dropping some of the RID bits
> 
> the process of sideband data extracted from RID can be expressed
> using optional DT property {iommu/msi}-map-drop-mask.
> 
> Example: If drop-mask is 0xFF09 then sideband data is
> 8 bits bus number followed by 1 bit of device number and
> 1 bit function number. This means drop-mask=0xFF09 will
> convert RID=0x1a10 (16bits) to sideband data 0x6a (10bits).

So IIUC, here's you're using this not only to mask bits out, but also to
determine a *shift* to apply to the value, implicitly provided by the
(contiguous) low bits of the mask.

That's really not obvious from the name.

Mark.

> 
> Srinath Mannam (2):
>   dt-bindings: pci: Add drop mask property for MSI and IOMMU
>   pcie: sideband data by dropping RID bits
> 
>  .../devicetree/bindings/pci/pci-iommu.txt          | 31 ++++++++++++++
>  Documentation/devicetree/bindings/pci/pci-msi.txt  | 33 +++++++++++++++
>  drivers/iommu/of_iommu.c                           |  4 +-
>  drivers/of/irq.c                                   |  3 +-
>  drivers/of/of_pci.c                                | 48 ++++++++++++++++++++--
>  include/linux/of_pci.h                             |  6 ++-
>  6 files changed, 117 insertions(+), 8 deletions(-)
> 
> -- 
> 2.7.4
> 
