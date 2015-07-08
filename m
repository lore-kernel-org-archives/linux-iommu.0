From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 5/9] iommu/arm-smmu: skip the execution of
 CMD_PREFETCH_CONFIG
Date: Wed, 8 Jul 2015 18:11:07 +0100
Message-ID: <20150708171107.GC6348@arm.com>
References: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
 <1436239822-14132-6-git-send-email-thunder.leizhen@huawei.com>
 <559D1F91.6000508@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <559D1F91.6000508@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <Robin.Murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Tianhong Ding <dingtianhong@huawei.com>, "huxinwei@huawei.com" <huxinwei@huawei.com>, iommu <iommu@lists.linux-foundation.org>, Zefan Li <lizefan@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

FWIW, I already queued this ;)

On Wed, Jul 08, 2015 at 02:03:13PM +0100, Robin Murphy wrote:
> On 07/07/15 04:30, Zhen Lei wrote:
> > Hisilicon SMMUv3 devices treat CMD_PREFETCH_CONFIG as a illegal command,
> > execute it will trigger GERROR interrupt. Although the gerror code manage
> > to turn the prefetch into a SYNC, and the system can continue to run
> > normally, but it's ugly to print error information.
> 
> No mention of the DT binding change, and no corresponding documentation 
> update either.

I've added that.

> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > ---
> [...]
> > +static struct arm_smmu_option_prop arm_smmu_options[] = {
> > +	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
> > +	{ 0, NULL},
> > +};
> [...]
> > +static void parse_driver_options(struct arm_smmu_device *smmu)
> > +{
> > +	int i = 0;
> > +
> > +	do {
> > +		if (of_property_read_bool(smmu->dev->of_node,
> > +						arm_smmu_options[i].prop)) {
> > +			smmu->options |= arm_smmu_options[i].opt;
> > +			dev_notice(smmu->dev, "option %s\n",
> > +				arm_smmu_options[i].prop);
> > +		}
> > +	} while (arm_smmu_options[++i].opt);
> > +}
> > +
> 
> Nitpicking for sure, but I'm still waiting for a good excuse to rewrite 
> this overcomplicated loop logic in the SMMUv2 driver - can't we just 
> treat a static array as a static array and iterate over the thing in the 
> obvious way?
> 
> 	for (i = 0; i < ARRAY_SIZE(arm_smmu_options); i++)

I'd rather have consistency with the other driver and I really have no
personal preference about how we iterate over an array. If you have a
technical reason to change both the drivers, please send a patch.

Will
