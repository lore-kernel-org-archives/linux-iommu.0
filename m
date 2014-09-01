From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/6] iommu/arm-smmu: add support for iova_to_phys through
	ATS1PR
Date: Mon, 1 Sep 2014 17:15:09 +0100
Message-ID: <20140901161509.GI24594@arm.com>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
	<1407891099-24641-4-git-send-email-mitchelh@codeaurora.org>
	<20140819124431.GL23128@arm.com>
	<vnkwa970qrfq.fsf@mitchelh-linux.qualcomm.com>
	<20140826135451.GQ23445@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140826135451.GQ23445-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 26, 2014 at 02:54:51PM +0100, Will Deacon wrote:
> On Tue, Aug 19, 2014 at 07:12:41PM +0100, Mitchel Humpherys wrote:
> > On Tue, Aug 19 2014 at 05:44:32 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > >> @@ -2005,6 +2073,11 @@ int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
> > >>  		return -ENODEV;
> > >>  	}
> > >>  
> > >> +	if (smmu->version == 1 || (!(id & ID0_ATOSNS) && (id & ID0_S1TS))) {
> > >
> > > Are you sure about this? The v2 spec says that is ATOSNS is clear then S1TS
> > > is also clear.
> > 
> > I was looking at Section 4.1.1 of ARM IHI 0062C ID091613 which states:
> > 
> >     In SMMUv2, the address translation registers are OPTIONAL. The
> >     address translation registers are implemented only when both:
> > 
> >         o The SMMU_IDR0.S1TS bit is set to 1.
> >         o The SMMU_IDR0.ATOSNS bit is set to 0.
> > 
> > I assume you're referring to section 9.6.1 of the same document:
> > 
> >     ATOSNS, bit[26]
> >     Address Translation Operations Not Supported. The possible values of
> >     this bit are:
> > 
> >         0 Address translation operations are supported. Stage 1
> >           translation is not supported, that is, the S1TS bit is set to 0.
> > 
> >         1 Address translation operations are not supported. Stage 1
> >           translation is supported, that is, the S1TS bit is set to 1.
> > 
> > If that really means that S1TS and ATOSNS always have the same value
> > then Section 4.1.1 doesn't make any sense. Or am I missing something?
> 
> I'll get this checked, as those two paragraphs don't make an awful lot of
> sense together.

Right, word from above says that ATOS is implemented iff:

  IDR0.S1TS == 1 && IDR0.ATOSNS == 0

Basically, ATOS only works for stage-1 when it's present, so that explains
the dependency. Looking at the piece of diff at the top of this mail, I
think that means your code is correct

Will
