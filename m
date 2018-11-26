From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Subject: Re: [PATCH] dma-mapping: fix return type of dma_set_max_seg_size()
Date: Mon, 26 Nov 2018 18:06:30 +0100
Message-ID: <20181126170630.GA24837@bigcity.dyn.berto.se>
References: <20180829212921.10665-1-niklas.soderlund+renesas@ragnatech.se>
	<20181102102254.GF22306@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181102102254.GF22306-ofJ5d6taAgIKcZgyrm77+z0dHWC0CY5B@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2018-11-02 11:22:54 +0100, Niklas S=F6derlund wrote:
> Hi,
> =

> A gentle ping on this patch.

A slightly harder ping :-)

> =

> On 2018-08-29 23:29:21 +0200, Niklas S=F6derlund wrote:
> > The function dma_set_max_seg_size() can return either 0 on success or
> > -EIO on error. Change its return type from unsigned int to int to
> > capture this.
> > =

> > Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.s=
e>
> > ---
> >  include/linux/dma-mapping.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > =

> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 1db6a6b46d0d3dbd..669cde2fa8723ac5 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -674,8 +674,7 @@ static inline unsigned int dma_get_max_seg_size(str=
uct device *dev)
> >  	return SZ_64K;
> >  }
> >  =

> > -static inline unsigned int dma_set_max_seg_size(struct device *dev,
> > -						unsigned int size)
> > +static inline int dma_set_max_seg_size(struct device *dev, unsigned in=
t size)
> >  {
> >  	if (dev->dma_parms) {
> >  		dev->dma_parms->max_segment_size =3D size;
> > -- =

> > 2.18.0
> > =

> =

> -- =

> Regards,
> Niklas S=F6derlund

-- =

Regards,
Niklas S=F6derlund
