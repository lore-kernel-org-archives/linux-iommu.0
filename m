From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] iommu: Fix offsetof() usage
Date: Tue, 9 Apr 2019 03:00:26 -0700
Message-ID: <20190409100025.GA22084@infradead.org>
References: <85778a4619eab832eb0b003a68f377aea9d97b22.1554727307.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <85778a4619eab832eb0b003a68f377aea9d97b22.1554727307.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, David Laight <David.Laight@ACULAB.COM>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

> index 74e944bd4a8d..81d449451494 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1484,8 +1484,7 @@ static int arm_smmu_add_device(struct device *dev)
>  	}
>  
>  	ret = -ENOMEM;
> -	cfg = kzalloc(offsetof(struct arm_smmu_master_cfg, smendx[i]),
> -		      GFP_KERNEL);
> +	cfg = kzalloc(struct_size(cfg, smendx, i), GFP_KERNEL);

This looks like a huge improvement, but I find the usage of i
here still very obsfucating.  Can we please use fwspec->num_ids
directly instead of make it much more obvious?
