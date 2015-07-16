From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 1/2] of: base: Allow more args than MAX_PHANDLE_ARGS if
 required
Date: Thu, 16 Jul 2015 13:09:00 +0200
Message-ID: <20150716110900.GA30130@suse.de>
References: <1437035444-13867-1-git-send-email-joro@8bytes.org>
 <1437035444-13867-2-git-send-email-joro@8bytes.org>
 <20150716102325.GC26390@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150716102325.GC26390-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Thu, Jul 16, 2015 at 11:23:26AM +0100, Will Deacon wrote:
> On Thu, Jul 16, 2015 at 09:30:43AM +0100, Joerg Roedel wrote:
> > +struct of_phandle_args *of_alloc_phandle_args(int size)
> > +{
> > +	struct of_phandle_args *args;
> > +	int e = max(0, size - MAX_PHANDLE_ARGS);
> > +
> > +	args =  kzalloc(sizeof(struct of_phandle_args) + e * sizeof(uint32_t),
> > +			GFP_KERNEL);
> 
> Should you also update args->args_count to reflect the extended array?

The args_count member just tells us how many of the array elements are
used and not how many there are. So it doesn't need to be updated here.

> That said, extending the fixed-size array member like this feels a bit
> fragile. Does GCC not complain about out-of-bounds accesses if you
> statically address args->args[MAX_PHANDLE_ARGS]? Admittedly, I can't
> think *why* this would be break (things like additional padding will be
> harmless), but I'm not intimate with the C standard.

Yeah, I agree, it is not the best possible solution. But this way I
don't need to update all callers, and thus it works better with our
development model.

But I am open for suggestions on how to solve this problem better. In
fact, my main motivation in sending this was to get the discussion about
an upstreamable solution started :)

Lets see what the device-tree maintainers have to say.

> I guess the more worrying possibility is if somebody adds a new member to
> the end of of_phandle_args.

I should probably add a comment there.



	Joerg

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
