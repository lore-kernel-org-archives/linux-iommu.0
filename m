From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 1/3] iommu/fsl: Fix PAMU window size check.
Date: Fri, 4 Jul 2014 12:47:44 +0000
Message-ID: <6425d2420c6f4f03b15f2d7ce5be3215@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
	<1403618237-26248-2-git-send-email-Varun.Sethi@freescale.com>
	<20140704104430.GD13434@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140704104430.GD13434-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Joerg Roedel [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
> Sent: Friday, July 04, 2014 4:15 PM
> To: Sethi Varun-B16395
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> Subject: Re: [PATCH 1/3] iommu/fsl: Fix PAMU window size check.
> 
> On Tue, Jun 24, 2014 at 07:27:15PM +0530, Varun Sethi wrote:
> >  	/* window size is 2^(WSE+1) bytes */
> > -	return __ffs(addrspace_size) - 1;
> > +	return fls64(addrspace_size) - 2;
> 
> This looks bogus, why do you replace ffs (find-first-bit) by fls (find-
> last-bit)?
> 
Address space size is always a power of 2. This change was required to handle address sizes > 32bit width on 32 bit architectures.

-Varun
