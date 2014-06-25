From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
Date: Wed, 25 Jun 2014 10:18:59 +0100
Message-ID: <20140625091858.GG6153@arm.com>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com>
	<CAL_JsqKumG1PSFoVfeGpLLG+MjXFeF4aUjun=vv1BJpaxk0Byg@mail.gmail.com>
	<4545972.cM7IP1qTXQ@wuerfel> <53A4C0C9.2050908@codeaurora.org>
	<20140624091808.GC26013@arm.com> <53A9BC18.2090106@codeaurora.org>
	<20140624181150.GB4067@arm.com> <53A9EF3A.2070704@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53A9EF3A.2070704-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 24, 2014 at 10:35:54PM +0100, Olav Haugan wrote:
> On 6/24/2014 11:11 AM, Will Deacon wrote:
> > On Tue, Jun 24, 2014 at 06:57:44PM +0100, Olav Haugan wrote:
> >> On 6/24/2014 2:18 AM, Will Deacon wrote:
> >>> On Sat, Jun 21, 2014 at 12:16:25AM +0100, Olav Haugan wrote:
> >>>> We have multiple-master SMMUs and each master emits a variable number of
> >>>> StreamIDs. However, we have to apply a mask (the ARM SMMU spec allows
> >>>> for this) to the StreamIDs due to limited number of StreamID 2 Context
> >>>> Bank entries in the SMMU. If my understanding is correct we would
> >>>> represent this in the DT like this:
> >>>>
> >>>> 	iommu {
> >>>> 		#address-cells = <2>;
> >>>> 		#size-cells = <0>;
> >>>> 	};
> >>>>
> >>>> 	master@a {
> >>>> 		...
> >>>> 		iommus = <&iommu StreamID0 MASK0>,
> >>>> 			 <&iommu StreamID1 MASK1>,
> >>>> 			 <&iommu StreamID2 MASK2>;
> >>>> 	};
> >>>
> >>> Stupid question, but why not simply describe the masked IDs? What use does
> >>> the `raw' ID have to Linux?
> >>
> >> We do describe the masked StreamID (SID) but we need to specify the mask
> >> that the SMMU should apply to the incoming SIDs, right?
> >>
> >> We have a bus master that emits 43 unique SIDs. However, we have only 40
> >> SMMU_SMRn registers in the SMMU. So we need to mask out some of the
> >> incoming SID bits so that the 43 SIDs can match one of 40 entries in the
> >> SMR.
> > 
> > Hmm, so you're talking about stream matching, right? That doesn't belong in
> > the device-tree. I appreciate that the current driver does a terrible job at
> > allocating the SMRs (it's bloody difficult!), but we should try to improve
> > the dynamic behaviour instead of moving configuration of the SMMU out into
> > device-tree, where it's inflexible at best.
> 
> I am talking about SMMU_SMRn[MASK] register bits. This is not something
> that can be dynamically detected at run-time. It is configuration at the
> same level as the actual StreamIDs.

Why can't it be dynamically detected? Whilst the StreamIDs are fixed in
hardware (from the SMMU architecture perspective), the SMRs are completely
programmable. Why doesn't something like Andreas's proposal work for you?
The idea there was to find the constant bits among the StreamIDs for a
master and create the mask accordingly.

Will
