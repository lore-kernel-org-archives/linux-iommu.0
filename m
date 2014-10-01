From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v4 2/2] iommu/arm-smmu: add support for iova_to_phys
	through ATS1PR
Date: Wed, 01 Oct 2014 12:52:04 -0700
Message-ID: <vnkwoatv600r.fsf@mitchelh-linux.qualcomm.com>
References: <1412126893-15796-1-git-send-email-mitchelh@codeaurora.org>
	<1412126893-15796-3-git-send-email-mitchelh@codeaurora.org>
	<61772524.IxG1939KJq@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <61772524.IxG1939KJq@wuerfel> (Arnd Bergmann's message of "Wed,
	01 Oct 2014 10:27:27 +0200")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 01 2014 at 01:27:27 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Tuesday 30 September 2014 18:28:13 Mitchel Humpherys wrote:
>> +       if (readl_poll_timeout_atomic(cb_base + ARM_SMMU_CB_ATSR, tmp,
>> +                               !(tmp & ATSR_ACTIVE), 50, 100)) {
>> 
>
> This looks really bad.
>
> You are doing up to 50 100us delays, each of which can be much longer,
> so you can do up to 10ms total delay with interrupts disabled.
>
> Don't do that.

Oh wow somehow I forgot I was in atomic context even though I was
explicitly moving to the `_atomic' polling function in this version.
Don't ask.

Let me ratchet that down to a maximum of 10 delays of 5 microseconds
each for v5.


-Mitch

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
