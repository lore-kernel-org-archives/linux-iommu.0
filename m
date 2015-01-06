From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: don't touch the secure STLBIALL register
Date: Tue, 06 Jan 2015 12:16:25 -0800
Message-ID: <vnkwiogjhdgm.fsf@mitchelh-linux.qualcomm.com>
References: <1419356362-27343-1-git-send-email-mitchelh@codeaurora.org>
	<20150106141507.GB3484@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150106141507.GB3484-5wv7dgnIgG8@public.gmane.org> (Will Deacon's message of "Tue, 6
	Jan 2015 14:15:07 +0000")
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 06 2015 at 06:15:07 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>>  	/* Invalidate the TLB, just in case */
>> -	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_STLBIALL);
>>  	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
>>  	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
>
> I was slightly worried that this would break the Calxeda implementation
> with ARM_SMMU_OPT_SECURE_CFG_ACCESS, but actually these registers aren't
> even aliased there so I think there's a bigger bug for them.
>
> Anyway, given that their hardware has gone the way of the dodo, I'll take
> the patch as-is unless you have any further comments?
>
> Will

Yeah I agree that this shouldn't affect the (now defunct) Calxeda
implementation.  I've tested this on some hardware here and we crash
when we touch that register since it's secure-only (not banked, as you
mentioned).


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
