From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 5/5 v11] iommu/fsl: Freescale PAMU driver and iommu
	implementation.
Date: Wed, 3 Apr 2013 05:12:16 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D45040D@039-SN2MPN1-013.039d.mgd.msft.net>
References: <CAOZdJXWS50mpgMYu8o8K11yQFU6y-vNwxd9zPkqSd7euGt7XQg@mail.gmail.com>	(from
	timur@tabi.org on Tue Apr 2 20:35:54 2013) <1364953950.8690.4@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1364953950.8690.4@snotra>
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
To: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Wednesday, April 03, 2013 7:23 AM
> To: Timur Tabi
> Cc: Joerg Roedel; Sethi Varun-B16395; lkml; Kumar Gala; Yoder Stuart-
> B08248; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Benjamin Herrenschmidt;
> linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> Subject: Re: [PATCH 5/5 v11] iommu/fsl: Freescale PAMU driver and iommu
> implementation.
> 
> On 04/02/2013 08:35:54 PM, Timur Tabi wrote:
> > On Tue, Apr 2, 2013 at 11:18 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> >
> > > > +     panic("\n");
> > >
> > > A kernel panic seems like an over-reaction to an access violation.
> >
> > We have no way to determining what code caused the violation, so we
> > can't just kill the process.  I agree it seems like overkill, but what
> > else should we do?  Does the IOMMU layer have a way for the IOMMU
> > driver to stop the device that caused the problem?
> 
> At a minimum, log a message and continue.  Probably turn off the LIODN,
> at least if it continues to be noisy (otherwise we could get stuck in an
> interrupt storm as you note).  Possibly let the user know somehow,
> especially if it's a VFIO domain.
[Sethi Varun-B16395] Can definitely log the message and disable the LIODN (to avoid an interrupt storm), but
we definitely need a mechanism to inform vfio subsystem about the error. Also, disabling LIODN may not be a viable
option with the new LIODN allocation scheme (where LIODN would be associated with a domain).

> 
> Don't take down the whole kernel.  It's not just overkill; it undermines
> VFIO's efforts to make it safe for users to control devices.
> 
> > > Besides the device that caused the violation the system should still
> > > work, no?
> >
> > Not really.  The PAMU was designed to add IOMMU support to legacy
> > devices, which have no concept of an MMU.  If the PAMU detects an
> > access violation, there's no way for the device to recover, because it
> > has no idea that a violation has occurred.  It's going to keep on
> > writing to bad data.
> 
> I think that's only the case for posted writes (or devices which fail to
> take a hint and stop even after they see an I/O error).
> 
[Sethi Varun-B16395] Even in the case where the guest driver detects a failure, it may not be able to fix the problem without intervention from the VFIO subsystem.

-Varun
