From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v8 3/5] iommu/arm-smmu: Invoke pm_runtime during probe,
	add/remove device
Date: Wed, 7 Mar 2018 22:52:22 +0900
Message-ID: <CAAFQd5BTdF176x5ycatCmCHrMyVX2OZqdXd-JGq06RyDUb0N3g@mail.gmail.com>
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
	<20180302101050.6191-4-vivek.gautam@codeaurora.org>
	<d0f2b3ed-136d-7704-2aef-1173a342a89c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d0f2b3ed-136d-7704-2aef-1173a342a89c-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 7, 2018 at 9:38 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 02/03/18 10:10, Vivek Gautam wrote:
>>
>> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>
>> The smmu device probe/remove and add/remove master device callbacks
>> gets called when the smmu is not linked to its master, that is without
>> the context of the master device. So calling runtime apis in those places
>> separately.
>>
>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> [vivek: Cleanup pm runtime calls]
>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>   drivers/iommu/arm-smmu.c | 96
>> ++++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 88 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index c8b16f53f597..3d6a1875431f 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -209,6 +209,8 @@ struct arm_smmu_device {
>>         struct clk_bulk_data            *clks;
>>         int                             num_clks;
>>   +     bool                            rpm_supported;
>> +
>
>
> Can we not automatically infer this from whether clocks and/or power domains
> are specified or not, then just use pm_runtime_enabled() as the fast-path
> check as Tomasz originally proposed?

I wouldn't tie this to presence of clocks, since as a next step we
would want to actually control the clocks separately. (As far as I
understand, on QCom SoCs we might want to have runtime PM active for
the translation to work, but clocks gated whenever access to SMMU
registers is not needed.) Moreover, you might still have some super
high scale thousand-core systems that require clocks to be
prepare-enabled, but runtime PM would be undesirable for the reasons
we discussed before.

>
> I worry that relying on statically-defined matchdata is just going to blow
> up the driver and DT binding into a maintenance nightmare; I really don't
> want to start needing separate definitions for e.g. "arm,juno-etr-mmu-401"
> and "arm,juno-hdlcd-mmu-401" just because one otherwise-identical instance
> within the SoC is in a separate controllable power domain while the others
> aren't.

I don't see a reason why both couldn't just have RPM supported
regardless of whether there is a real power domain. It would
effectively be just a no-op for those that don't have one. IMHO the
only reason to avoid having the RPM enabled is the scalability issue
we discussed before.

Best regards,
Tomasz
