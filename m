From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/6] powerpc/fsl_pci: Store the platform device
	information corresponding to the pci controller.
Date: Thu, 7 Mar 2013 11:37:41 +0100
Message-ID: <20130307103741.GB22602@8bytes.org>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
	<1361191939-21260-3-git-send-email-Varun.Sethi@freescale.com>
	<CALRxmdDc9TuxH7HgAF3_iLgatoaOUML6fUt8SU+sxHyz6ZVjfw@mail.gmail.com>
	<C5ECD7A89D1DC44195F34B25E172658D3BD338@039-SN2MPN1-013.039d.mgd.msft.net>
	<20130227104505.GE26252@8bytes.org>
	<C5ECD7A89D1DC44195F34B25E172658D3C24A9@039-SN2MPN1-013.039d.mgd.msft.net>
	<D109CC7C-09D2-41E6-82BF-376692C390CA@kernel.crashing.org>
	<C5ECD7A89D1DC44195F34B25E172658D3E74C7@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D3E74C7-RL0Hj/+nBVDYdknt8GnhQq4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Yes, please base your patches on the latest upstream-tag. I will move my
tree to v3.9-rc1 soon, there are some fixes that need to go upstream.

On Thu, Mar 07, 2013 at 09:14:21AM +0000, Sethi Varun-B16395 wrote:
> Hi Joerg,
> I have to post the next version of my patchset, should I base it on top of 3.9-rc1?
> By when would you move the iommu git tree to 3.9-rc1?
> 
> Regards
> Varun
> 
> > -----Original Message-----
> > From: Kumar Gala [mailto:galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org]
> > Sent: Thursday, February 28, 2013 9:15 PM
> > To: Sethi Varun-B16395
> > Cc: Joerg Roedel; Stuart Yoder; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> > linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wood Scott-
> > B07421; Yoder Stuart-B08248
> > Subject: Re: [PATCH 2/6] powerpc/fsl_pci: Store the platform device
> > information corresponding to the pci controller.
> > 
> > 
> > On Feb 27, 2013, at 4:56 AM, Sethi Varun-B16395 wrote:
> > 
> > > This patch is present in the "next branch" of linux ppc tree maintained
> > by Kumar Gala.
> > > Following is the commit id:
> > > 52c5affc545053d37c0b05224bbf70f5336caa20
> > >
> > > I am not sure if this would be part of 3.9-rc1.
> > >
> > > Regards
> > > varun
> > 
> > This is now in Linus's tree so will be in 3.9-rc1
> > 
> > - k
> > 
> 
> 
