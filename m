From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: don't touch the secure STLBIALL register
Date: Wed, 07 Jan 2015 10:35:41 -0800
Message-ID: <vnkwh9w2bfr6.fsf@mitchelh-linux.qualcomm.com>
References: <1419356362-27343-1-git-send-email-mitchelh@codeaurora.org>
	<20150106141507.GB3484@arm.com>
	<vnkwiogjhdgm.fsf@mitchelh-linux.qualcomm.com>
	<CAL_JsqJYZ+-qt8UXPP7=pCsZFXeOkB8ogOzbuusdv1Cb+o1d2A@mail.gmail.com>
	<vnkw61cjebbq.fsf@mitchelh-linux.qualcomm.com>
	<20150107101300.GC7485@arm.com>
	<vnkw4ms2cwb5.fsf@mitchelh-linux.qualcomm.com>
	<20150107180420.GR7485@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150107180420.GR7485-5wv7dgnIgG8@public.gmane.org> (Will Deacon's message of "Wed, 7
	Jan 2015 18:04:20 +0000")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 07 2015 at 10:04:20 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Wed, Jan 07, 2015 at 05:52:46PM +0000, Mitchel Humpherys wrote:
>> On Wed, Jan 07 2015 at 02:13:00 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>> > On Tue, Jan 06, 2015 at 11:30:49PM +0000, Mitchel Humpherys wrote:
>> >> On Tue, Jan 06 2015 at 02:35:28 PM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> >> > On Tue, Jan 6, 2015 at 2:16 PM, Mitchel Humpherys
>> >> > <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>> >> >> On Tue, Jan 06 2015 at 06:15:07 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>> >> >>>>      /* Invalidate the TLB, just in case */
>> >> >>>> -    writel_relaxed(0, gr0_base + ARM_SMMU_GR0_STLBIALL);
>> >> >>>>      writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
>> >> >>>>      writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
>> >> >>>
>> >> >>> I was slightly worried that this would break the Calxeda implementation
>> >> >>> with ARM_SMMU_OPT_SECURE_CFG_ACCESS, but actually these registers aren't
>> >> >>> even aliased there so I think there's a bigger bug for them.
>> >> >>>
>> >> >>> Anyway, given that their hardware has gone the way of the dodo, I'll take
>> >> >>> the patch as-is unless you have any further comments?
>> >> >>>
>> >> >>> Will
>> >> >>
>> >> >> Yeah I agree that this shouldn't affect the (now defunct) Calxeda
>> >> >> implementation.  I've tested this on some hardware here and we crash
>> >> >> when we touch that register since it's secure-only (not banked, as you
>> >> >> mentioned).
>> >> >
>> >> > It's not quite dead:
>> >> >
>> >> > http://www.eweek.com/servers/calxedas-arm-based-server-chips-re-emerge-with-new-company.html
>> >> >
>> >> > But AFAIK, production systems don't enable the SMMU, but someone could
>> >> > still want to at some point. A note in the commit log here would be
>> >> > nice so it gets recorded.
>> >> 
>> >> Actually, as Will mentioned this shouldn't affect Calxeda since this
>> >> isn't a banked register.  I think the confusion is from the `S' prefix
>> >> in the spec.  The /s/ (lower-case, italic) prefix means that there are
>> >> secure and non-secure versions of the register, while the S (upper-case,
>> >> non-italic) prefix means "this is a secure register" (which may or may
>> >> not have a banked non-secure counterpart).  This particular register is
>> >> an S-only register (there's no non-secure counterpart) so the Calxeda
>> >> workaround isn't relevant here, AFAICT.
>> >
>> > Right, but I think the problem is that we go and write zero to
>> > ARM_SMMU_GR0_TLBIALLH and ARM_SMMU_GR0_TLBIALLNSNH at what *would be* their
>> > non-secure aliases for the secure side (i.e. + 0x400).
>> 
>> This sounds like a separate problem.  Since these GR0 registers aren't
>> banked the calxeda workaround doesn't work...  SMMU_STLBIALL, on the
>> other hand, is not only not banked but it's also "secure only" so I
>> don't think we have any business touching it ever.
>> 
>> > If would be better to check for the ARM_SMMU_OPT_SECURE_CFG_ACCESS feature
>> > and, if it's set then zero ARM_SMMU_GR0_STLBIALL at the correct address
>> > otherwise do the ARM_SMMU_GR0_TLBIALLH and ARM_SMMU_GR0_TLBIALLNSNH.
>> 
>> I'm confused.  The problem I'm addressing here is that we're touching a
>> register that's marked as "secure only", which causes our system to
>> crash.  Why would we ever want to touch a secure only register, calxeda
>> workaround or not?
>
> Because I think the way the SMMU is wired for Calxeda is that the CPU can
> only see the secure side of the register interface, so the only way to nuke
> the whole TLB would be to use ARM_SMMU_GR0_STLBIALL.

Still not sure I understand what "the correct address" is for STLBIALL
on Calxeda (i.e. whether or not we need to use ARM_SMMU_GR0_NS), but
something like:

-- >8 --
Subject: [PATCH v2] iommu/arm-smmu: don't touch the secure STLBIALL register

Currently we do a STLBIALL when we initialize the SMMU.  However, on
systems with sane secure
configurations (i.e. !ARM_SMMU_OPT_SECURE_CFG_ACCESS) that register is
not supposed to be touched and is marked as "Secure only" in the spec.
Touching it results in a crash on those platforms.  However, on
platforms with ARM_SMMU_OPT_SECURE_CFG_ACCESS it's the only way to nuke
the whole TLB, so leave it in for them but rip it out for everyone else.

Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 60558f794922..d4c149d83f3d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1686,9 +1686,12 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	}
 
 	/* Invalidate the TLB, just in case */
-	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_STLBIALL);
-	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
-	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
+	if (smmu->options & ARM_SMMU_OPT_SECURE_CFG_ACCESS) {
+		writel_relaxed(0, gr0_base + ARM_SMMU_GR0_STLBIALL);
+	} else {
+		writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
+		writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
+	}
 
 	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
