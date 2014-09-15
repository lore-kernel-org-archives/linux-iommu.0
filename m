From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/6] iommu/arm-smmu: add support for specifying clocks
Date: Mon, 15 Sep 2014 11:38:14 -0700
Message-ID: <vnkwbnqgn2zt.fsf@mitchelh-linux.qualcomm.com>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
	<1407891099-24641-2-git-send-email-mitchelh@codeaurora.org>
	<20140819125833.GO23128@arm.com> <53F39F6D.1040205@codeaurora.org>
	<20140826142757.GU23445@arm.com>
	<vnkwa968b6ux.fsf@mitchelh-linux.qualcomm.com>
	<20140910182739.GM1710@arm.com>
	<vnkwbnqn9tt9.fsf@mitchelh-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <vnkwbnqn9tt9.fsf-Yf+dfxj6toJBVvN7MMdr1KRtKmQZhJ7pQQ4Iyu8u01E@public.gmane.org> (Mitchel
	Humpherys's message of "Wed, 10 Sep 2014 12:09:06 -0700")
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
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 10 2014 at 12:09:06 PM, Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> On Wed, Sep 10 2014 at 11:27:39 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>> On Wed, Sep 10, 2014 at 02:29:42AM +0100, Mitchel Humpherys wrote:
>>> On Tue, Aug 26 2014 at 07:27:58 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>>> > On Tue, Aug 19, 2014 at 08:03:09PM +0100, Olav Haugan wrote:
>>> >> Clients of the SMMU driver are required to vote for clocks and power
>>> >> when they know they need to use the SMMU. However, the clock and power
>>> >> needed to be on for the SMMU to service bus masters aren't necessarily
>>> >> the same as the ones needed to read/write registers...See below.
>>> >
>>> > The case I'm thinking of is where a device masters through the IOMMU, but
>>> > doesn't make use of any translations. In this case, its transactions will
>>> > bypass the SMMU and I want to ensure that continues to happen, regardless of
>>> > the power state of the SMMU.
>>> 
>>> Then I assume the driver for such a device wouldn't be attaching to (or
>>> detaching from) the IOMMU, so we won't be touching it at all either
>>> way. Or am I missing something?
>>
>> As long as its only the register file that gets powered down, then there's
>> no issue. However, that's making assumptions about what these clocks are
>> controlling. Is there a way for the driver to know which aspects of the
>> device are controlled by which clock?
>
> Yes, folks should only be putting "config" clocks here. In our system,
> at least, the clocks for configuring the SMMU are different than those
> for using it. Maybe I should make a note about what "kinds" of clocks
> can be specified here in the bindings (i.e. only those that can be
> safely disabled while still allowing translations to occur)?

Let me amend this statement slightly.  Folks should be putting all
clocks necessary to program SMMU registers here.  On our system, this
actually does include the "core" clocks in addition to the "config"
clocks.  Clients won't vote for "config" clocks since they have no
business programming SMMU registers, so those will get shut down when we
remove our vote for them.  Clients *should* hold their votes for "core"
clocks for as long as they want to use the SMMU.  Also, for the bypass
case, clients should be voting for clocks and power for the SMMU
themselves.

In light of all this I guess there isn't really anything to say in the
DT bindings.


-Mitch

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
