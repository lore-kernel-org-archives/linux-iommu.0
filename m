From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 1/3] iommu: Move swap_pci_ref function to pci.h.
Date: Mon, 15 Apr 2013 17:13:01 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D486DF2@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1365966722-1804-1-git-send-email-Varun.Sethi@freescale.com>
	<20130415145834.GR6858@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130415145834.GR6858-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Fine, I will move it to iommu.h.

-Varun

> -----Original Message-----
> From: Joerg Roedel [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
> Sent: Monday, April 15, 2013 8:29 PM
> To: Sethi Varun-B16395
> Cc: Yoder Stuart-B08248; Wood Scott-B07421; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org;
> benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
> Subject: Re: [PATCH 1/3] iommu: Move swap_pci_ref function to pci.h.
> 
> On Mon, Apr 15, 2013 at 12:42:00AM +0530, Varun Sethi wrote:
> > swap_pci_ref function is used by the IOMMU API code for swapping pci
> > device pointers, while determining the iommu group for the device.
> > Currently this function was being implemented for different IOMMU
> drivers.
> > This patch moves the function to pci.h so that the implementation can
> > be shared across various IOMMU drivers.
> 
> The function is only used in IOMMU code, so I think its fine to keep it
> there (unless Bjorn disagrees and wants it in PCI code).
> 
> 
> 	Joerg
> 
> 
