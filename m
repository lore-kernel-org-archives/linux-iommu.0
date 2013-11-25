From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: Report from 2013 ARM kernel summit
Date: Mon, 25 Nov 2013 18:03:52 +0000
Message-ID: <20131125180352.GC28201@mudshark.cambridge.arm.com>
References: <20131119.114054.663999769447782808.hdoyu@nvidia.com>
 <20131119173524.GK11778@mudshark.cambridge.arm.com>
 <528BCDCE.6070006@gmail.com>
 <20131120.083955.1386179068365424976.hdoyu@nvidia.com>
 <CAL_Jsq+AxEWhkOhxwAZ=+rpzDZ+yC1b3ZV541UhOu9kiwUhUdQ@mail.gmail.com>
 <20131121110024.GA8395@mudshark.cambridge.arm.com>
 <528E539C.8080603@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <528E539C.8080603-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "ksummit-2013-discuss-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org" <ksummit-2013-discuss-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org" <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "lwn-T1hC0tSOHrs@public.gmane.org" <lwn-T1hC0tSOHrs@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Stephen,

On Thu, Nov 21, 2013 at 06:40:28PM +0000, Stephen Warren wrote:
> On 11/21/2013 04:00 AM, Will Deacon wrote:
> > On Wed, Nov 20, 2013 at 08:02:10PM +0000, Rob Herring wrote:
> >> For the topology above where you are chaining iommu's, I think
> >> something like this is more accurately describing the hierarchy:
> >>
> >>   smmu_b: iommu@xxxxxxxx {
> >>         #iommu-cells = <3>;
> >>          iommus = <&smmu_a param1 param2>;
> >>        ....
> >>   };
> >>   device_a {
> >>          iommus = <&smmu_b param1 param2 param3>;
> >>   };
> >>
> >> I remember discussing this with Will and seem to recall some issue
> >> with describing things this way. But looking at it now, I don't see
> >> what that was.
> > 
> > I think it was the usual issue with StreamID remastering. For example, if
>              ^^^ s/was/had/ I assume

Take your pick!

> > you had a device going into two chained IOMMUs, you need a way to relate the
> > StreamIDs of the device to the remastered IDs coming out of the first SMMU.
> 
> That seems pretty easy to deal with. Am I missing something. Here's how
> I assume that would work:
> 
> 1)
> 
> If the mapping is static in HW, then you simply have a table that
> describes the remapping. A table representation could be in the DT or
> the driver itself. Either way, any static mapping is a property of the
> HW itself, so shouldn't need to leak into the client DT nodes at all, right?
> 
> That might look like:
> 
> smmu_a: iommu@xxxxxxxx {
> 	#iommu-cells = <1>;
> };
> smmu_b: iommu@xxxxxxxx {
> 	#iommu-cells = <1>;
> 
> 	// a) All stream IDs squashed down to 1 ID
> 	iommus = <&smmu_a SMMU_B's_STREAM_ID_IN_SMMU_A>;
> 
> 	// OR b) stream IDs translated:
> 	iommus = <&smmu_a 0>,
> 		 <&smmu_a 1>,
> 		 <&smmu_a 2> ...;
> 	// this table could be in the driver instead
> 	iommu-stream-id-map =
> 		<DEV_A's_STREAM_ID_IN_SMMU_B 0>,
> 		<DEV_B's_STREAM_ID_IN_SMMU_B 1>,
> 		<DEV_C's_STREAM_ID_IN_SMMU_B 2>,

Actually, something like this could work. I think we should also support the
case where a range of IDs are `windowed' (i.e. there is a constant offset
applied to incoming IDs to get the outgoing IDs) to avoid huge tables in
some cases.

> };
> device_a {
> 	iommus = <&smmu_b DEV_A's_STREAM_ID_IN_SMMU_B>;
> };
> 
> or 2)
> 
> If the remapping is entirely dynamic, then you'd either need a table in
> the DT to describe how to set it up for the particular use-case (similar
> to the above), or a function in the driver to manage the mapping at
> run-time, probably hooked into the of_xlate() of the parent IOMMU, which
> would call into some function of the source IOMMU.
> 
> In other words, of_xlate for smmu_a would do both:
> 
> a) Parse the SMMU specifier in the client's iommus property
> 
> b) If the parse specifier represents a "dynamic stream ID device/IOMMU",
> call some function in the client driver to find out which stream ID(s)
> the parse iommus entry (specifier) represents.

Sure. We just need to get the binding right so we're prepared when these
platforms turn up. There's also the usual problem of continuing to support
what we already do for existing SMMU bindings.

Will
