From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 5/7] iommu: supress loff_t compilation error on powerpc
Date: Thu, 26 Sep 2013 17:20:44 -0500
Message-ID: <1380234044.24959.339.camel@snotra.buserror.net>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
	<1379575763-2091-6-git-send-email-Bharat.Bhushan@freescale.com>
	<1380127227.3030.316.camel@ul30vt.home>
	<6A3DF150A5B70D4F9B66A25E3F7C888D07183CA4@039-SN2MPN1-011.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D07183CA4-RL0Hj/+nBVCMXPU/2EZmt64g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2013-09-25 at 22:53 -0500, Bhushan Bharat-R65777 wrote:
> 
> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> > Sent: Wednesday, September 25, 2013 10:10 PM
> > To: Bhushan Bharat-R65777
> > Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; linux-
> > kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-
> > pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; agraf-l3A5Bk7waGM@public.gmane.org; Wood Scott-B07421; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> > foundation.org; Bhushan Bharat-R65777
> > Subject: Re: [PATCH 5/7] iommu: supress loff_t compilation error on powerpc
> > 
> > On Thu, 2013-09-19 at 12:59 +0530, Bharat Bhushan wrote:
> > > Signed-off-by: Bharat Bhushan <bharat.bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > ---
> > >  drivers/vfio/pci/vfio_pci_rdwr.c |    3 ++-
> > >  1 files changed, 2 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c
> > > b/drivers/vfio/pci/vfio_pci_rdwr.c
> > > index 210db24..8a8156a 100644
> > > --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> > > +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> > > @@ -181,7 +181,8 @@ ssize_t vfio_pci_vga_rw(struct vfio_pci_device *vdev, char
> > __user *buf,
> > >  			       size_t count, loff_t *ppos, bool iswrite)  {
> > >  	int ret;
> > > -	loff_t off, pos = *ppos & VFIO_PCI_OFFSET_MASK;
> > > +	loff_t off;
> > > +	u64 pos = (u64 )(*ppos & VFIO_PCI_OFFSET_MASK);
> > >  	void __iomem *iomem = NULL;
> > >  	unsigned int rsrc;
> > >  	bool is_ioport;
> > 
> > What's the compile error that this fixes?
> 
> I was getting below error; and after some googling I came to know that this is how it is fixed by other guys.
> 
> /home/r65777/linux-vfio/drivers/vfio/pci/vfio_pci_rdwr.c:193: undefined reference to `__cmpdi2'
> /home/r65777/linux-vfio/drivers/vfio/pci/vfio_pci_rdwr.c:193: undefined reference to `__cmpdi2'

It looks like PPC Linux implements __ucmpdi2, but not the signed
version.  That should be fixed, rather than hacking up random code to
avoid it.

-Scott
