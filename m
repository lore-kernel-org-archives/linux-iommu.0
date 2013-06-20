From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/5 v11] powerpc: Add iommu domain pointer to device
	archdata
Date: Thu, 20 Jun 2013 14:29:30 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D5CB5D4@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1364500442-20927-1-git-send-email-Varun.Sethi@freescale.com>
	<1364500442-20927-3-git-send-email-Varun.Sethi@freescale.com>
	<AC9BAE34-A9CB-4A24-A357-0AA7734CE443@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <AC9BAE34-A9CB-4A24-A357-0AA7734CE443-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
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
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,
My PAMU driver patches depend on this patch which was Ack by Kumar. Should I resubmit this patch as well?

Regards
Varun

> -----Original Message-----
> From: Kumar Gala [mailto:galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org]
> Sent: Thursday, April 11, 2013 11:46 PM
> To: Sethi Varun-B16395
> Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; Yoder Stuart-B08248; Wood Scott-B07421;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
> Subject: Re: [PATCH 2/5 v11] powerpc: Add iommu domain pointer to device
> archdata
> 
> 
> On Mar 28, 2013, at 2:53 PM, Varun Sethi wrote:
> 
> > Add an iommu domain pointer to device (powerpc) archdata.  Devices are
> > attached to iommu domains and this pointer provides a mechanism to
> > correlate between a device and the associated iommu domain.  This
> > field is set when a device is attached to a domain.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> > - no change in v11.
> > - no change in v10.
> > - Added CONFIG_IOMMU_API in v9.
> > arch/powerpc/include/asm/device.h |    6 ++++++
> > 1 files changed, 6 insertions(+), 0 deletions(-)
> 
> Acked-by: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> 
> - k
