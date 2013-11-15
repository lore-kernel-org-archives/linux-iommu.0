From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH -next] iommu/arm-smmu: fix error return code in
 arm_smmu_device_dt_probe()
Date: Fri, 15 Nov 2013 12:48:55 +0000
Message-ID: <20131115124855.GC19468@mudshark.cambridge.arm.com>
References: <CAPgLHd8siM4ZpmaqHWa9JXFmcGBvvb6J=Vo2DvP5=zMQE0d0fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd8siM4ZpmaqHWa9JXFmcGBvvb6J=Vo2DvP5=zMQE0d0fA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "yongjun_wei@trendmicro.com.cn" <yongjun_wei@trendmicro.com.cn>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 15, 2013 at 09:42:30AM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return -ENODEV instead of 0 when context interrupt number
> does no match in arm_smmu_device_dt_probe().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/iommu/arm-smmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 2349d62..2bc977b 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1858,6 +1858,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>  		dev_err(dev,
>  			"found only %d context interrupt(s) but %d required\n",
>  			smmu->num_context_irqs, smmu->num_context_banks);
> +		err = -ENODEV;
>  		goto out_put_parent;
>  	}

Applied to my devel branch. Thanks!

Will
