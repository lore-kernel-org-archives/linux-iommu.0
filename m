From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [v2 1/1] iommu/tegra: smmu: Support variable MMIO ranges/blocks
Date: Tue, 29 Jan 2013 10:03:51 -0700
Message-ID: <510800F7.7020507@wwwdotorg.org>
References: <50FD752A.6060706@wwwdotorg.org>
	<1359448450-24894-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1359448450-24894-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/29/2013 01:34 AM, Hiroshi Doyu wrote:
> Presently SMMU registers are located in discontiguous 3 blocks. They
> are interleaved by MC registers. Ideally SMMU register blocks should
> be in an independent one block, but it is too late to change this H/W
> design. In the future Tegra chips over some generations, it is
> expected that some of register block "size" can be extended towards
> the end and also more new register blocks will be added at most a few
> blocks. The starting address of each existing block won't change. This
> patch allocates multiple number of register blocks dynamically based
> on the info passed from DT. Those ranges are verified in the
> accessors{read,write}. This may sacrifice some performance because a
> new accessors prevents compiler optimization of a fixed size register
> offset calculation. Since SMMU register accesses are not so frequent,
> this would be acceptable. This patch is necessary to unify
> "tegra-smmu.ko" over some Tegra SoC generations.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

>  static inline u32 smmu_read(struct smmu_device *smmu, size_t offs)

> +	for (i = 0; i < smmu->nregs; i++) {
> +		void __iomem *addr = smmu->regbase + offs;

I don't really like the concept of "regbase", but I suppose it works
just fine and isn't entirely avoidable, so I won't object.

> +		BUG_ON(addr < smmu->regs[i]);
> +		if (addr <= smmu->rege[i])
> +			return readl(addr);

So here we assume that rege points at the last valid address in the range...

> @@ -1170,7 +1172,13 @@ static int tegra_smmu_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(smmu->regs); i++) {
> +	smmu->nregs = pdev->num_resources;
> +	smmu->regs = devm_kzalloc(dev, 2 * smmu->nregs * sizeof(*smmu->regs),
> +				  GFP_KERNEL);
> +	smmu->rege = smmu->regs + smmu->nregs;

... but here rege is set to the first address after the range. I think
the simplest solution is to change the <= to < in smmu_{read,write}().

> +	/* Same as "mc" 1st regiter block start address */
> +	smmu->regbase = (void __iomem *)((u32)smmu->regs[0] & ~PAGE_MASK);

I'm not sure if it's relevant how these register ranges are related to
the MC registers, given this is the SMMU driver?

s/regiter/register/ in the comment if you keep it.
