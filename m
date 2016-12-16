From: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH] Docs: dt: Be explicit and consistent in reference to
	IOMMU specifiers
Date: Fri, 16 Dec 2016 14:08:09 +0000
Message-ID: <VI1PR0401MB263816D0AA09CF94E2B5C7E58D9C0@VI1PR0401MB2638.eurprd04.prod.outlook.com>
References: <1481847373-2602-1-git-send-email-stuart.yoder@nxp.com>
	<20161216113317.GB20265@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161216113317.GB20265@leverpostej>
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
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland-5wv7dgnIgG8@public.gmane.org]
> Sent: Friday, December 16, 2016 5:33 AM
> To: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
> Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org
> Subject: Re: [PATCH] Docs: dt: Be explicit and consistent in reference to IOMMU specifiers
> 
> Hi Stuart,
> 
> On Thu, Dec 15, 2016 at 06:16:13PM -0600, Stuart Yoder wrote:
> > The generic IOMMU binding says that the meaning of an 'IOMMU specifier'
> > is defined by the binding of a specific SMMU.  The ARM SMMU binding
> > never explicitly uses the term 'specifier' at all.  Update implicit
> > references to use the explicit term.
> >
> > In the iommu-map binding change references to iommu-specifier to
> > "IOMMU specifier" so we are 100% consistent everywhere with terminology
> > and capitalization.
> 
> Elsewhere, we always use lower case "xxx-specifier" or "xxx specifier",
> e.g. Documentation/devicetree/bindings/gpio/gpio.txt defines
> "gpio-specifier", ePAPR defines "interrupt specifier".
> 
> Given we're morstly consistent on "iommu-specifier" today,could we
> please jsut update the ARM SMMU binding to match that? If we're going to
> fix the dash mismatch, that's a more general, cross-binding thing.

The notable place where we don't use "iommu-specifier" in in the generic
IOMMU binding itself where we use "IOMMU specifier".  You're suggesting
using "iommu-specifier" everywhere including the generic binding?  Sounds
fine to me.  It's a nit but would like to see it consistent everywhere.

Thanks,
Stuart
