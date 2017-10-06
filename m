From: David Laight <David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org>
Subject: RE: the imfamous asix ax88179 iommu error
Date: Fri, 6 Oct 2017 16:37:45 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD008BF6D@AcuExch.aculab.com>
References: <20170929095807.6b02085b@nibenay.lan>
	<20171006111942.773eb515@nibenay.lan>
	<73af1113-86de-25f0-d688-d39e8cfc2c77@arm.com>
	<474710f0-4e19-e4c4-8698-b1d84acffccc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <474710f0-4e19-e4c4-8698-b1d84acffccc-5wv7dgnIgG8@public.gmane.org>
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
To: 'Robin Murphy' <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Trives <renevant-CkBdp7X+a1oIQCUVoCVjmQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> >> It appears that my ax88179 is working just fine now with the vendor
> >> driver. So perhaps it's possible to revert the old commit in the linux
> >> kernel and allow the use of scatter gather ? (perhaps for non-intel
> >> hosts ? I'm not sure if this device is effected by intel xhci errata)
> >
> > Thanks for the tip-off - as luck would have it I have an AX88179 dongle
> > to hand! Does the out-of-tree driver behave significantly differently to
> > the mainline driver (CONFIG_USB_NET_AX88179_178A)?
> 
> To answer myself - yes, the out-of-tree driver produces all manner of
> >PAGE_SIZE offsets for dma_map_sg():
> 
> ...
> [  571.019335] xhci_hcd 0000:04:00.0: ####### sg->offset = 0x7770
> [  571.025497] xhci_hcd 0000:04:00.0: ####### sg->offset = 0x7a60
> [  571.031402] xhci_hcd 0000:04:00.0: ####### sg->offset = 0x1100
> [  571.037353] xhci_hcd 0000:04:00.0: ####### sg->offset = 0x1c50
> [  571.043254] xhci_hcd 0000:04:00.0: ####### sg->offset = 0x27a0

I remember a load of XHCI patches I had that were needed to get the
AX88179 working reliably
I think most of the ones to do with the TRB boundaries and ZLP have
been fixed now.
There was a problem with an ASMedia host controller (1b21:1042) that
it needed the command ring doorbell rung in the command completion
code in order to process a second command.
Not sure I've seen a fix for that.
I've still got the host system, but not the dongle.

	David
