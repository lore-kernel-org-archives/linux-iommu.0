From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: don't touch the secure STLBIALL register
Date: Wed, 7 Jan 2015 10:13:00 +0000
Message-ID: <20150107101300.GC7485@arm.com>
References: <1419356362-27343-1-git-send-email-mitchelh@codeaurora.org>
	<20150106141507.GB3484@arm.com>
	<vnkwiogjhdgm.fsf@mitchelh-linux.qualcomm.com>
	<CAL_JsqJYZ+-qt8UXPP7=pCsZFXeOkB8ogOzbuusdv1Cb+o1d2A@mail.gmail.com>
	<vnkw61cjebbq.fsf@mitchelh-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <vnkw61cjebbq.fsf-Yf+dfxj6toJBVvN7MMdr1KRtKmQZhJ7pQQ4Iyu8u01E@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 06, 2015 at 11:30:49PM +0000, Mitchel Humpherys wrote:
> On Tue, Jan 06 2015 at 02:35:28 PM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On Tue, Jan 6, 2015 at 2:16 PM, Mitchel Humpherys
> > <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> >> On Tue, Jan 06 2015 at 06:15:07 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> >>>>      /* Invalidate the TLB, just in case */
> >>>> -    writel_relaxed(0, gr0_base + ARM_SMMU_GR0_STLBIALL);
> >>>>      writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
> >>>>      writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
> >>>
> >>> I was slightly worried that this would break the Calxeda implementation
> >>> with ARM_SMMU_OPT_SECURE_CFG_ACCESS, but actually these registers aren't
> >>> even aliased there so I think there's a bigger bug for them.
> >>>
> >>> Anyway, given that their hardware has gone the way of the dodo, I'll take
> >>> the patch as-is unless you have any further comments?
> >>>
> >>> Will
> >>
> >> Yeah I agree that this shouldn't affect the (now defunct) Calxeda
> >> implementation.  I've tested this on some hardware here and we crash
> >> when we touch that register since it's secure-only (not banked, as you
> >> mentioned).
> >
> > It's not quite dead:
> >
> > http://www.eweek.com/servers/calxedas-arm-based-server-chips-re-emerge-with-new-company.html
> >
> > But AFAIK, production systems don't enable the SMMU, but someone could
> > still want to at some point. A note in the commit log here would be
> > nice so it gets recorded.
> 
> Actually, as Will mentioned this shouldn't affect Calxeda since this
> isn't a banked register.  I think the confusion is from the `S' prefix
> in the spec.  The /s/ (lower-case, italic) prefix means that there are
> secure and non-secure versions of the register, while the S (upper-case,
> non-italic) prefix means "this is a secure register" (which may or may
> not have a banked non-secure counterpart).  This particular register is
> an S-only register (there's no non-secure counterpart) so the Calxeda
> workaround isn't relevant here, AFAICT.

Right, but I think the problem is that we go and write zero to
ARM_SMMU_GR0_TLBIALLH and ARM_SMMU_GR0_TLBIALLNSNH at what *would be* their
non-secure aliases for the secure side (i.e. + 0x400).

If would be better to check for the ARM_SMMU_OPT_SECURE_CFG_ACCESS feature
and, if it's set then zero ARM_SMMU_GR0_STLBIALL at the correct address
otherwise do the ARM_SMMU_GR0_TLBIALLH and ARM_SMMU_GR0_TLBIALLNSNH.

Will
