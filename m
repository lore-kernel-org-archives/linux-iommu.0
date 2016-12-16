From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] Docs: dt: Be explicit and consistent in reference to
	IOMMU specifiers
Date: Fri, 16 Dec 2016 14:56:25 +0000
Message-ID: <20161216145625.GF20265@leverpostej>
References: <1481847373-2602-1-git-send-email-stuart.yoder@nxp.com>
	<20161216113317.GB20265@leverpostej>
	<VI1PR0401MB263816D0AA09CF94E2B5C7E58D9C0@VI1PR0401MB2638.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <VI1PR0401MB263816D0AA09CF94E2B5C7E58D9C0-9IDQY6o3qQjcXZ0H4ZLnAo3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 16, 2016 at 02:08:09PM +0000, Stuart Yoder wrote:
> 
> > -----Original Message-----
> > From: Mark Rutland [mailto:mark.rutland-5wv7dgnIgG8@public.gmane.org]
> > 
> > On Thu, Dec 15, 2016 at 06:16:13PM -0600, Stuart Yoder wrote:

> > > In the iommu-map binding change references to iommu-specifier to
> > > "IOMMU specifier" so we are 100% consistent everywhere with terminology
> > > and capitalization.
> > 
> > Elsewhere, we always use lower case "xxx-specifier" or "xxx specifier",
> > e.g. Documentation/devicetree/bindings/gpio/gpio.txt defines
> > "gpio-specifier", ePAPR defines "interrupt specifier".
> > 
> > Given we're morstly consistent on "iommu-specifier" today,could we
> > please jsut update the ARM SMMU binding to match that? If we're going to
> > fix the dash mismatch, that's a more general, cross-binding thing.
> 
> The notable place where we don't use "iommu-specifier" in in the generic
> IOMMU binding itself where we use "IOMMU specifier". 

True; I failed to notice that. You are right in that the pci-iommu
binding is the odd one out. Sorry for the misinformation above. :/

> You're suggesting using "iommu-specifier" everywhere including the
> generic binding?  Sounds fine to me.  It's a nit but would like to see
> it consistent everywhere.

I certainly agree that we should be consistent.

So FWIW, for this patch (as-is):

Acked-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>

Thanks,
Mark.
