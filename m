From: Geetha Akula <geethasowjanya.akula@gmail.com>
Subject: Re: [PATCH 2/3] iommu/arm-smmu-v3: Add workaround for Cavium
 ThunderX2 erratum #74
Date: Tue, 2 May 2017 12:01:15 +0530
Message-ID: <CANHdaibvzp22XEa3NnKAKUtrHcWGc9oUcnM8KubcYCzEfOaKJg@mail.gmail.com>
References: <1493293584-20287-1-git-send-email-gakula@caviumnetworks.com>
 <1493293584-20287-3-git-send-email-gakula@caviumnetworks.com>
 <20170427164237.GA7114@leverpostej> <20170427170030.GF1890@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170427170030.GF1890@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Geetha sowjanya <gakula@caviumnetworks.com>, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, jcm@redhat.com, Linu Cherian <linu.cherian@cavium.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, robert.richter@cavium.com, catalin.marinas@arm.com, Geetha <gakula@cavium.com>, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

SMMU_IIDR register is broken on T99, that the reason we are using MIDR.
If using MIDR is not accepted, can we enable errata based on SMMU resource size?
some thing like below.

static bool page0_reg_only = false;
+static unsigned long arm_smmu_resource_size(void)
+{
+       if (page0_reg_only)
+               return SZ_64K;
+       else
+               return SZ_128K;
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
        int irq, ret;
@@ -2674,7 +2692,13 @@ static int arm_smmu_device_probe(struct
platform_device *pdev)

        /* Base address */
        res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

+       /*
+     * Setting page0_reg_only flag, for Cavium CN99xx implementations
+     * which doesn't support the page 1 SMMU register space.
+     */
+       if (resource_size(res) == SZ_64K)
+                       page0_reg_only = true;
-        if (resource_size(res) + 1 < SZ_128K) {
+       if (resource_size(res) + 1 < arm_smmu_resource_size()) {
                dev_err(dev, "MMIO region too small (%pr)\n", res);
                return -EINVAL;
        }


Thank you,
Geetha.

On Thu, Apr 27, 2017 at 10:30 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Apr 27, 2017 at 05:42:37PM +0100, Mark Rutland wrote:
>> On Thu, Apr 27, 2017 at 05:16:23PM +0530, Geetha sowjanya wrote:
>> > +   /*
>> > +    * Override the size, for Cavium CN99xx implementations
>> > +    * which doesn't support the page 1 SMMU register space.
>> > +    */
>> > +   cpu_model = read_cpuid_id() & MIDR_CPU_MODEL_MASK;
>> > +   if (cpu_model == MIDR_THUNDERX_99XX ||
>> > +       cpu_model == MIDR_BRCM_VULCAN)
>> > +           size = SZ_64K;
>>
>> If you're trying to identify an SMMU erratum, identify the SMMU, not the
>> CPU it happens to be paired with this time.
>>
>> There are ID registers in the SMMU you can use to do so.
>>
>> NAK to using the CPU ID here.
>
> Agreed. I had some off-list discussion with Geetha where we agreed to use
> the "silicon ID", which I assumed was the SMMU IIDR register.
>
> Will
