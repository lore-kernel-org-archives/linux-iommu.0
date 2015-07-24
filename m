From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [RFC PATCH 3/4] iommu/arm-smmu: Add support for specifying clocks
Date: Fri, 24 Jul 2015 17:56:10 +0530
Message-ID: <005e01d0c60b$f1f130c0$d5d39240$@codeaurora.org>
References: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org> <1437152005-25092-4-git-send-email-sricharan@codeaurora.org> <20150721150122.GH31095@arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150721150122.GH31095-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-us
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Will Deacon' <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

> -----Original Message-----
> From: linux-arm-msm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-arm-msm-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Will Deacon
> Sent: Tuesday, July 21, 2015 8:31 PM
> To: Sricharan R
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
> Subject: Re: [RFC PATCH 3/4] iommu/arm-smmu: Add support for specifying
> clocks
> 
> On Fri, Jul 17, 2015 at 05:53:24PM +0100, Sricharan R wrote:
> > From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> >
> > On some platforms with tight power constraints it is polite to only
> > leave your clocks on for as long as you absolutely need them.
> > Currently we assume that all clocks necessary for SMMU register access
> > are always on.
> 
> You've borrowed this commit message from Mitch's previous version of this
> patch, but now you leave the clocks enabled most of the time so it doesn't
> make much sense anymore.
> 
 Sorry, I should have changed that to make it clear.

> Anyway, I'm OK with this kind of clock management in the driver, but I
think
> that anything more fine-grained needs to be designed into the IOMMU core.
> 
  Ok. Tried this to get the right direction.
 I will  check for the power savings and if there are not much then I would
use
 the above approach.

Regards,
  Sricharan

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
