From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v5] devicetree: Add generic IOMMU device tree bindings
Date: Tue, 19 Aug 2014 12:11:43 +0000
Message-ID: <6a3d4048ddb84bd19c847adf7f02fc52@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1406803383-11601-1-git-send-email-thierry.reding@gmail.com>
	<87a9774lf5.fsf@nvidia.com> <20140815115110.GO27466@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140815115110.GO27466-5wv7dgnIgG8@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Will Deacon
> Sent: Friday, August 15, 2014 5:21 PM
> To: Hiroshi Doyu
> Cc: Mark Rutland; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Stephen Warren; Arnd
> Bergmann; Rob Herring; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Thierry Reding;
> linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: Re: [PATCH v5] devicetree: Add generic IOMMU device tree bindings
> 
> On Thu, Aug 14, 2014 at 07:47:42AM +0100, Hiroshi Doyu wrote:
> > Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> >
> > > +Multiple-master IOMMU:
> > > +----------------------
> > > +
> > > +       iommu {
> > > +               /* the specifier represents the ID of the master */
> > > +               #iommu-cells = <1>;
> > > +       };
> > > +
> > > +       master@1 {
> > > +               /* device has master ID 42 in the IOMMU */
> > > +               iommus = <&{/iommu} 42>;
> > > +       };
> > > +
> > > +       master@2 {
> > > +               /* device has master IDs 23 and 24 in the IOMMU */
> > > +               iommus = <&{/iommu} 23>, <&{/iommu} 24>;
> > > +       };
> >
> > I think that this "master ID" will be parsed in IOMMU driver. For
> > example, ARM,SMMU expects "streamID" as "master ID", right?
> >
> > If a SoC has a feature to configure to assign streamID to devices at
> > runtime, "streamID" is not equal to "master ID".
> >
> >   iommus = <&{/smmu} "soc specific master ID">;
> >
> > "soc master ID" needs to be translated into "streamID" by SoC SW. It
> > seems that ARM,SMMU kernel driver doesn't expect this kind of ID
> > translation. If ARM,SMMU kernel driver is used as is, "soc master ID"
> > would be incompatible? ARM,SMMU needs such translation before parsing.
> > Is this my understanding right?
> >
> > If so I think that this master ID configuration/translation may be
> > quite reasonable requirment for SoC using ARM,SMMU.
> >
> > Can we consider this ID translation within ARM,SMMU compatibility?
> >
> > IOW, is it possible to implement some SoC specific hook for ID
> > translation/configuration in ARM,SMMU kernel driver?
> 
> I think there's some confusion here. The ARM architected SMMU does not
> perform any StreamID translation -- it sees an incoming ID and uses that to
> lookup a set of translation tables. 

I don't completely agree with this. In case of MMU-500  don't we have the "TBUID + device assigned stream ID" representing the stream ID for matching at the TCU? In case of our platform, we have hot pluggable device objects comprising of devices connected to different TBUs. We have a requirement to use a single stream ID for all the distributed objects. We will have to use the stream ID masking capability to mask out the TBU ID.

-Varun
