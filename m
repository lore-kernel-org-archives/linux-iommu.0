From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V2 1/3] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Wed, 8 Feb 2017 11:40:02 +0000
Message-ID: <20170208114002.GD15459@leverpostej>
References: <1486055420-19671-1-git-send-email-sricharan@codeaurora.org>
	<1486055420-19671-2-git-send-email-sricharan@codeaurora.org>
	<20170202174218.GO31394@leverpostej>
	<017701d281f9$927c5fb0$b7751f10$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <017701d281f9$927c5fb0$b7751f10$@codeaurora.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 08, 2017 at 04:23:17PM +0530, Sricharan wrote:
> >On Thu, Feb 02, 2017 at 10:40:18PM +0530, Sricharan R wrote:
> >> +- clock-names:    Should be a pair of "smmu_iface_clk" and "smmu_bus_clk"
> >> +                  required for smmu's register group access and interface
> >> +                  clk for the smmu's underlying bus access.
> >> +
> >> +- clocks:         Phandles for respective clocks described by clock-names.
> >
> >Which SMMU implementations are those clock-names valid for?
> >
> >The SMMU architecture specifications do not architect the clocks, which
> >are implemementation-specific.
> >
> >AFAICT, this doesn't match MMU-400 or MMU-500.
> 
> Ok, should be more specific. Infact QCOM has MMU-500 and also
> a smmu v2 implementation which is fully compatible with
> "arm,smmu-v2", with the clocks being controlled by the soc's
> clock controller. i was trying to define these clock bindings
> so that its works across socs.

I don't think we can do that, if we don't know precisely what those
clocks are used for.

i.e. we'd need a compatible string for the QCOM SMMUv2 variant, which
would imply the set of clocks.

> So there are one or more interface clocks which are required for the
> smmu's interface or the configuration access and one or more clocks
> required for smmu's downstream bus access. That was the reason i was
> trying to iterate over the list of clocks down below.  But agree that
> the bindings should define each of the clocks required separately.

As above, I don't think the code should do this. It should only touch
the clocks it knows about.

> So one way here is, define a separate compatible for QCOM's SMMU
> implementation and define all the clock bindings as a part of it
> and handle it in the same way in the driver.

That would be my preference.

> But just thinking if it would scale well for any other soc that is
> compatible with arm,smmu-v2 driver and wants to handle clocks in the
> future ?

I don't think we can have our cake and eat it here. Either we handle the
clock management for each variant, or we don't do it at all. We have no
idea what requirements a future variant might have w.r.t. the management
of clocks we don't know about yet.

Thanks,
Mark.
