From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: RE: [PATCH v2 7/9] dpaa_eth: fix iova handling for contiguous frames
Date: Thu, 2 May 2019 09:10:38 +0000
Message-ID: <VI1PR04MB513490961A52D86E46C02B49EC340@VI1PR04MB5134.eurprd04.prod.outlook.com>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
 <20190427071031.6563-8-laurentiu.tudor@nxp.com>
 <20190427164612.GA12450@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190427164612.GA12450@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Madalin-cristian Bucur <madalin.bucur@nxp.com>, Roy Pledge <roy.pledge@nxp.com>, Camelia Alexandra Groza <camelia.groza@nxp.com>, Leo Li <leoyang.li@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Saturday, April 27, 2019 7:46 PM
>=20
> On Sat, Apr 27, 2019 at 10:10:29AM +0300, laurentiu.tudor@nxp.com wrote:
> > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >
> > The driver relies on the no longer valid assumption that dma addresses
> > (iovas) are identical to physical addressees and uses phys_to_virt() to
> > make iova -> vaddr conversions. Fix this by adding a function that does
> > proper iova -> phys conversions using the iommu api and update the code
> > to use it.
> > Also, a dma_unmap_single() call had to be moved further down the code
> > because iova -> vaddr conversions were required before the unmap.
> > For now only the contiguous frame case is handled and the SG case is
> > split in a following patch.
> > While at it, clean-up a redundant dpaa_bpid2pool() and pass the bp
> > as parameter.
>=20
> Err, this is broken.  A driver using the DMA API has no business
> call IOMMU APIs.  Just save the _virtual_ address used for the mapping
> away and use that again.  We should not go through crazy gymnastics
> like this.

I think that due to the particularity of this hardware we don't have a way =
of saving the VA, but I'd let my colleagues maintaining this driver to comm=
ent more on why we need to do this.

---
Best Regards, Laurentiu
