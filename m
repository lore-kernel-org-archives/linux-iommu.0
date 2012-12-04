From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 4/4 v6] iommu/fsl: Freescale PAMU driver and IOMMU API
	implementation.
Date: Tue, 4 Dec 2012 12:11:06 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D2B715D@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1354360921-20850-1-git-send-email-Varun.Sethi@freescale.com>
	<50BD056F.7070701@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <50BD056F.7070701-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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
To: Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Tabi Timur-B04825
> Sent: Tuesday, December 04, 2012 1:33 AM
> To: Sethi Varun-B16395
> Cc: joerg.roedel-5C7GfCeVMHo@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-
> dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wood Scott-B07421
> Subject: Re: [PATCH 4/4 v6] iommu/fsl: Freescale PAMU driver and IOMMU
> API implementation.
> 
> Varun Sethi wrote:
> 
> > +	out_be32(&pamu_regs->ppbah, ((u64)ppaact_phys) >> 32);
> > +	out_be32(&pamu_regs->ppbal, ppaact_phys);
> > +	ppaact_phys = ppaact_phys + PAACT_SIZE;
> > +	out_be32(&pamu_regs->pplah, ((u64)ppaact_phys) >> 32);
> > +	out_be32(&pamu_regs->pplal, ppaact_phys);
> 
> Instead of  ((u64)ppaact_phys) >> 32, use upper_32_bits() and
> lower_32_bits().
> 
> > +#define PAACE_NUMBER_ENTRIES    0xFF
> 
> This is going to break with large LIODNs.  Instead of hard-coding the
> size of the PPAACT, you need to scan the device tree for the largest
> LIODN, and make the array dynamically sized.
This would in any case change with the new LIODN allocation scheme. I intend on introducing the new scheme as a separate patch.

-Varun
