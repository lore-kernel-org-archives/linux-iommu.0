From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 2/2] Documentation: dt-bindings: Add option to
 workaround STE.VALID in Broadcom Vulcan
Date: Thu, 17 Dec 2015 12:00:26 +0000
Message-ID: <20151217120026.GC13389@leverpostej>
References: <1450346376-30920-1-git-send-email-pmallapp@broadcom.com>
 <1450346376-30920-2-git-send-email-pmallapp@broadcom.com>
 <20151217115102.GC11456@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151217115102.GC11456-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Prem Mallappa <pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 17, 2015 at 11:51:03AM +0000, Will Deacon wrote:
> [adding devicetree since I'd like an Ack from them if possible]
> 
> On Thu, Dec 17, 2015 at 03:29:36PM +0530, Prem Mallappa wrote:
> > Signed-off-by: Prem Mallappa <pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> 
> Please can you add a commit message for this?
> 
> > ---
> >  Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > index 947863a..9c1218e 100644
> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > @@ -43,6 +43,11 @@ the PCIe specification.
> >  - hisilicon,broken-prefetch-cmd
> >                      : Avoid sending CMD_PREFETCH_* commands to the SMMU.
> >  
> > +- broadcom,broken-ste-valid-check
> > +                    : Broadcom specific, h/w peeks into more than just 
> > +		      STE.VALID bit in "Bypass" mode. Enabling this, 
> > +		      populates needed bits.
> 
> This should really describe more about what happens, I think. For example,
> 
> "Enable ATS and Stage-2 AArch64 translation in bypass STEs, since some
>  hardware requires this in order for an STE to be treated as valid."

We certainly need to define the "needed bits".

Assuming your example cover all of those, it sounds fine to me.

Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
