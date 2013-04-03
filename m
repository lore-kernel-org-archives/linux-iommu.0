From: Scott Wood <scottwood@freescale.com>
Subject: Re: RFC: vfio API changes needed for powerpc
Date: Wed, 3 Apr 2013 13:39:43 -0500
Message-ID: <1365014383.25627.5@snotra>
References: <1364938725.2882.184.camel@bling.home>
	<1364943035.24520.28@snotra>
	<CALRxmdBjF12q1eQgsjD8UUdpqvjUUoRHWcms4yLYYuB_su5J3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CALRxmdBjF12q1eQgsjD8UUdpqvjUUoRHWcms4yLYYuB_su5J3w@mail.gmail.com>
	(from b08248@gmail.com on Wed Apr  3 13:32:26 2013)
Content-Disposition: inline
Sender: kvm-owner@vger.kernel.org
To: Stuart Yoder <b08248@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Wood Scott-B07421 <B07421@freescale.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "agraf@suse.de" <agraf@suse.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Yoder Stuart-B08248 <B08248@freescale.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Bhushan Bharat-R65777 <R65777@freescale.com>
List-Id: iommu@lists.linux-foundation.org

On 04/03/2013 01:32:26 PM, Stuart Yoder wrote:
> On Tue, Apr 2, 2013 at 5:50 PM, Scott Wood <scottwood@freescale.com>  
> wrote:
> > On 04/02/2013 04:38:45 PM, Alex Williamson wrote:
> >>
> >> On Tue, 2013-04-02 at 16:08 -0500, Stuart Yoder wrote:
> >> >     VFIO_IOMMU_MAP_MSI(iova, size)
> >
> >
> > Not sure how you mean "size" to be used -- for MPIC it would be 4K  
> per bank,
> > and you can only map one bank at a time (which bank you're mapping  
> should be
> > a parameter, if only so that the kernel doesn't have to keep  
> iteration state
> > for you).
> 
> The intent was for user space to tell the kernel which windows to use
> for MSI.   So I envisioned a total size of window-size *  
> msi-bank-count.

Size doesn't tell the kernel *which* banks to use, only how many.  If  
it already knows which banks are used by the group, then it also knows  
how many are used.  And size is misleading because the mapping is not  
generally going to be contiguous.

-Scott
