From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: iommu/rockchip: Make clock properties
	optional
Date: Fri, 13 Apr 2018 16:02:26 -0500
Message-ID: <20180413210226.x4jx7b6kmui3oa3f@rob-hp-laptop>
References: <20180410092612.2653-1-heiko@sntech.de>
	<20180410092612.2653-2-heiko@sntech.de>
	<99245ec4-6835-7fa7-3bad-dd21874f92c0@arm.com>
	<2406273.dIyKc4zb8g@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2406273.dIyKc4zb8g@phil>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 10, 2018 at 01:26:41PM +0200, Heiko Stuebner wrote:
> Hi Robin,
> 
> Am Dienstag, 10. April 2018, 13:18:48 CEST schrieb Robin Murphy:
> > On 10/04/18 10:26, Heiko Stuebner wrote:
> > > Rockchip IOMMUs are used without explicit clock handling for 4 years
> > > now, so we should keep compatibility with old devicetrees if possible.
> > > Therefore make iommu clocks optional.
> > 
> > Do we need to touch the binding itself? Obviously the driver has to 
> > treat clocks as optional in existing DTs (and I feel a bit dumb now for 
> > managing to overlook that in review), but the binding effectively only 
> > covers future DTs, and I'd assume we want to encourage the clocks to be 
> > correctly specified there.

I'd prefer the DT docs reflect what is correct for new/current dts 
files. That's the only way the docs can validate the dts files.

> I guess that depends on your definition of the timespan for backwards
> compatibility. I'm always starting out at indefinite till convinced
> otherwise ;-). Hence the clocks would need to stay optional for (nearly)
> forever.
> 
> Also, having the binding claim them as required but the code handling
> them as optional just calls for someone to remove the optional handling :-D

A comment in the code saying why missing clocks are allowed should 
suffice.

> Not sure if there is a established way of saying
> "we want this for all future devices, but allow it to be missing for old dts".

We don't really...

Rob
