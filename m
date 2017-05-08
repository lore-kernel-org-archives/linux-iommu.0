From: Geetha Akula <geethasowjanya.akula@gmail.com>
Subject: Re: [PATCH v3 2/7] iommu/arm-smmu-v3: Do resource size checks based
 on SMMU
Date: Mon, 8 May 2017 16:33:21 +0530
Message-ID: <CANHdaibz+RkLPwbme0NQ_Bq38=dLJS6OFDnFZpO1ubXKQzH_Zw@mail.gmail.com>
References: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
 <1493986091-30521-3-git-send-email-gakula@caviumnetworks.com>
 <20170505221844.GW16981@rric.localdomain> <20170508094437.GA26538@virtx40> <20170508100932.GH16981@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170508100932.GH16981@rric.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Robert Richter <robert.richter@cavium.com>
Cc: Linu Cherian <linu.cherian@cavium.com>, Geetha sowjanya <gakula@caviumnetworks.com>, Will Deacon <will.deacon@arm.com>, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, Hanjun Guo <hanjun.guo@linaro.org>, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, jcm@redhat.com, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, Sunil Goutham <sgoutham@cavium.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Charles.Garcia-Tobin@arm.com, Geetha Sowjanya <geethasowjanya.akula@cavium.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, May 8, 2017 at 3:39 PM, Robert Richter
<robert.richter@cavium.com> wrote:
> On 08.05.17 15:14:37, Linu Cherian wrote:
>> On Sat May 06, 2017 at 12:18:44AM +0200, Robert Richter wrote:
>> > On 05.05.17 17:38:06, Geetha sowjanya wrote:
>> > > From: Linu Cherian <linu.cherian@cavium.com>
>> > >
>> > > With implementations supporting only page 0 register space,
>> > > resource size can be 64k as well and hence perform size checks
>> > > based on SMMU option PAGE0_REGS_ONLY.
>> > >
>> > > For this, arm_smmu_device_dt_probe/acpi_probe has been moved before
>> > > platform_get_resource call, so that SMMU options are set beforehand.
>> > >
>> > > Signed-off-by:  Linu Cherian <linu.cherian@cavium.com>
>> > > Signed-off-by:  Geetha Sowjanya <geethasowjanya.akula@cavium.com>
>> > > ---
>> > >  drivers/iommu/arm-smmu-v3.c | 26 +++++++++++++++++---------
>> > >  1 file changed, 17 insertions(+), 9 deletions(-)
>> > >
>> > > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> > > index 107b4a6..f027676 100644
>> > > --- a/drivers/iommu/arm-smmu-v3.c
>> > > +++ b/drivers/iommu/arm-smmu-v3.c
>> > > @@ -2672,6 +2672,14 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>> > >   return ret;
>> > >  }
>> > >
>> > > +static unsigned long arm_smmu_resource_size(struct arm_smmu_device *smmu)
>> > > +{
>> > > + if (ARM_SMMU_PAGE0_REGS_ONLY(smmu))
>> > > +         return SZ_64K;
>> > > + else
>> > > +         return SZ_128K;
>> > > +}
>> > > +
>> >
>> > I think this can be dropped. See below.
>> >
>> > >  static int arm_smmu_device_probe(struct platform_device *pdev)
>> > >  {
>> > >   int irq, ret;
>> > > @@ -2688,9 +2696,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>> > >   }
>> > >   smmu->dev = dev;
>> > >
>> > > + if (dev->of_node) {
>> > > +         ret = arm_smmu_device_dt_probe(pdev, smmu);
>> > > + } else {
>> > > +         ret = arm_smmu_device_acpi_probe(pdev, smmu);
>> > > +         if (ret == -ENODEV)
>> > > +                 return ret;
>> > > + }
>> > > +
>> > >   /* Base address */
>> > >   res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> > > - if (resource_size(res) + 1 < SZ_128K) {
>> > > + if (resource_size(res) + 1 < arm_smmu_resource_size(smmu)) {
>> > >           dev_err(dev, "MMIO region too small (%pr)\n", res);
>> > >           return -EINVAL;
>> > >   }
>> >
>> > Why not just do the follwoing here:
>> >
>> >     /* Base address */
>> >     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> >     if (resource_size(res) + 1 < arm_smmu_resource_size(smmu)) {
>> >             dev_err(dev, "MMIO region too small (%pr)\n", res);
>> >             return -EINVAL;
>> >     }
>> >     ioaddr = res->start;
>> >
>> > +   /*
>> > +    * Override the size, for Cavium ThunderX2 implementation
>> > +    * which doesn't support the page 1 SMMU register space.
>> > +    */
>> > +   if (smmu->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY)
>> > +           res->end = res->size + SZ_64K -1;
>> > +
>> >     smmu->base = devm_ioremap_resource(dev, res);
>> >     if (IS_ERR(smmu->base))
>> >             return PTR_ERR(smmu->base);
>>
>>
>> This might not work, since platform_device_add is being called from
>> iort.c before the res->end gets fixed up here.
>
> It should. You added it with 128k and you get it back with
> platform_get_resource(), but before ioremap you shrink the size to
> 64k.
>
> -Robert

Hi Robert,

Linu is right. You are missing the sequence of event. If we skip the
changes in iort file, smmu initialization in acpi fails.


[    3.721647] ACPI: IORT: iort_add_smmu_platform_device
[    3.726826] platform arm-smmu-v3.1.auto: failed to claim resource
0: [mem 0x402310000-0x40232ffff]
[    3.736052] arm-smmu-v3 arm-smmu-v3.0.auto: option mask 0x1
[    3.741753] arm_smmu_device_probe


Thank you,
Geetha.
