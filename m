From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/5] PCI: Prep for VFIO and IOMMU Groups
Date: Tue, 12 Jun 2012 08:20:00 +0200
Message-ID: <20120612062000.GA6932@8bytes.org>
References: <20120611152021.25959.71601.stgit@bling.home>
	<CAErSpo434tDtnSOxB_REG2jFNrZL=aZERWTmmK-cdjqM4z6yWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAErSpo434tDtnSOxB_REG2jFNrZL=aZERWTmmK-cdjqM4z6yWg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Bjorn,

On Mon, Jun 11, 2012 at 06:59:25PM -0600, Bjorn Helgaas wrote:
> On Mon, Jun 11, 2012 at 8:26 AM, Alex Williamson
> <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > v3:
> > =A0- Small change to device specific ACS check to allow quirk to
> > =A0 support yes/no/pass type functionality. (no change to other
> > =A0 patches and no trickle down through IOMMU series)
> >
> > Bjorn, what's needed to get these in? =A0Thanks,
> =

> Sorry for the delay.  I applied these to my "next" branch (headed for
> 3.6).  I didn't feel comfortable pushing them towards 3.5 since
> they're not bugfixes, and they haven't been in -next yet.

Great. Do you applied them directly to your next branch or do you have
them in a seperate branch I can pull in to merge the IOMMU Groups
patches on-top? The later would be really good :)

Regards,

	Joerg
