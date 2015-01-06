From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: don't touch the secure STLBIALL register
Date: Tue, 6 Jan 2015 16:35:28 -0600
Message-ID: <CAL_JsqJYZ+-qt8UXPP7=pCsZFXeOkB8ogOzbuusdv1Cb+o1d2A@mail.gmail.com>
References: <1419356362-27343-1-git-send-email-mitchelh@codeaurora.org>
 <20150106141507.GB3484@arm.com> <vnkwiogjhdgm.fsf@mitchelh-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <vnkwiogjhdgm.fsf@mitchelh-linux.qualcomm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mitchel Humpherys <mitchelh@codeaurora.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 6, 2015 at 2:16 PM, Mitchel Humpherys
<mitchelh@codeaurora.org> wrote:
> On Tue, Jan 06 2015 at 06:15:07 AM, Will Deacon <will.deacon@arm.com> wrote:
>>>      /* Invalidate the TLB, just in case */
>>> -    writel_relaxed(0, gr0_base + ARM_SMMU_GR0_STLBIALL);
>>>      writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
>>>      writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
>>
>> I was slightly worried that this would break the Calxeda implementation
>> with ARM_SMMU_OPT_SECURE_CFG_ACCESS, but actually these registers aren't
>> even aliased there so I think there's a bigger bug for them.
>>
>> Anyway, given that their hardware has gone the way of the dodo, I'll take
>> the patch as-is unless you have any further comments?
>>
>> Will
>
> Yeah I agree that this shouldn't affect the (now defunct) Calxeda
> implementation.  I've tested this on some hardware here and we crash
> when we touch that register since it's secure-only (not banked, as you
> mentioned).

It's not quite dead:

http://www.eweek.com/servers/calxedas-arm-based-server-chips-re-emerge-with-new-company.html

But AFAIK, production systems don't enable the SMMU, but someone could
still want to at some point. A note in the commit log here would be
nice so it gets recorded.

Rob
