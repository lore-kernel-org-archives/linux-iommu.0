From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 08/11] of: Increase MAX_PHANDLE_ARGS
Date: Fri, 17 Jan 2014 12:00:35 +0100
Message-ID: <20140117110035.GU3471@alberich>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
	<1389876263-25759-9-git-send-email-andreas.herrmann@calxeda.com>
	<CAL_Jsq+fDUYne1OQAd4AeQw-JAoFBf0TCv4YVpy6Vt_UmdkA8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+fDUYne1OQAd4AeQw-JAoFBf0TCv4YVpy6Vt_UmdkA8A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 16, 2014 at 09:25:59AM -0500, Rob Herring wrote:
> On Thu, Jan 16, 2014 at 6:44 AM, Andreas Herrmann
> <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org> wrote:
> > arm-smmu driver uses of_parse_phandle_with_args when parsing DT
> > information to determine stream IDs for a master device.
> > Thus the number of stream IDs per master device is bound by
> > MAX_PHANDLE_ARGS.
> >
> > To support Calxeda ECX-2000 hardware arm-smmu driver requires a
> > slightly higher value for MAX_PHANDLE_ARGS as this hardware has 10
> > stream IDs for one master device.
> >
> > Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: Andreas Herrmann <herrmann.der.user-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> 
> One comment below...
> 
> > ---
> >  include/linux/of.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index 276c546..0807af8 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -67,7 +67,7 @@ struct device_node {
> >  #endif
> >  };
> >
> > -#define MAX_PHANDLE_ARGS 8
> > +#define MAX_PHANDLE_ARGS 10
> 
> Just bump this to 16. This is normally just a temporary on the stack
> and 8 more words on the stack is not going to cost much.

Yes, that seems reasonable.


Thanks,

Andreas
