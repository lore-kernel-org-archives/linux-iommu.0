From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: SMR masking and PCI
Date: Fri, 28 Oct 2016 18:43:09 +0100
Message-ID: <20161028174309.GA12946@leverpostej>
References: <VI1PR0401MB26389CC8820C9654337B578E8DAA0@VI1PR0401MB2638.eurprd04.prod.outlook.com>
	<c39b785a-0f18-fc0a-ce08-7ebe3cfaf8c5@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c39b785a-0f18-fc0a-ce08-7ebe3cfaf8c5-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi, 

On Fri, Oct 28, 2016 at 05:16:37PM +0100, Robin Murphy wrote:
> On 27/10/16 18:10, Stuart Yoder wrote:
> > A question about how the SMR masking defined in the arm,smmu binding
> > relates to the PCI iommu-map.
> > 
> > The #iommu-cells property defines the number of cells an "IOMMU specifier"
> > takes and 2 is specified to be:
> > 
> >    SMMUs with stream matching support and complex masters
> >    may use a value of 2, where the second cell represents
> >    an SMR mask to combine with the ID in the first cell.
> > 
> > An iommu-map entry is defined as:
> > 
> >    (rid-base,iommu,iommu-base,length)
> > 
> > What seems to be currently missing in the iommu-map support is
> > the possibility the case where #iommu-cells=<2>.
> 
> Indeed. The bindings have so far rather implicitly assumed the case of
> #{msi,iommu}-cells = 1, and the code has followed suit.

The intention was that neither the iommu or msi bindings had such a
requirement, but evidently I did not specify the intended behaviour
thoroughly enough.

I had intended that the offset was added to the final cell of the
iommu-specifier (i.e. that the iommu-specifier was treated as a large
number).

You can handle this case by adding additional entries in the map table,
with a single entry length.

> > In this case iommu-base which is an IOMMU specifier should
> > occupy 2 cells.  For example on an ls2085a we would want:
> > 
> > 	iommu-map = <0x0   0x6 0x7 0x3ff 0x1
> > 		       0x100 0x6 0x8 0x3ff 0x1>;
> > 
> > ...to mask our stream IDs to 10 bits.
> > 
> > This should work in theory and comply with the bindings, no?
> 
> In theory, but now consider:
> 
> 	iommu-map = <0x0 0x6 0x7 0x3ff 0x2>;
> 
> faced with ID 1. The input base is 0, the output base is the 2-cell
> value 0x7000003ff, so the final ID value should be 0x700000400, right?

That was the intended behaviour, yes.

> > (Also, I guess that msi-map is not affected by this since it
> > is not related to the IOMMU...but we do have common code
> > handling both maps.)
> 
> I'd say it's definitely affected, since #msi-cells can equally be more
> than 1, and encodes an equally opaque value.

Yes.

> It seems pretty reasonable to me that we could extend the binding to
> accommodate #cells > 1 iff length == 1. Mark?

I will try to come up with the wording to make the above explicit, for
both bindings.

Thanks,
Mark.
