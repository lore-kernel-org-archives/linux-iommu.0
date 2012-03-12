From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH v11 3/3] iommu/exynos: Add iommu driver for Exynos
 Platforms
Date: Mon, 12 Mar 2012 16:01:56 +0100
Message-ID: <20120312150156.GF18973@amd.com>
References: <017a01ccfdee$4e5e7a00$eb1b6e00$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <017a01ccfdee$4e5e7a00$eb1b6e00$%cho@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Cho KyongHo <pullip.cho@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Subash Patel' <subash.ramaswamy@linaro.org>, 'Younglak Kim' <younglak1004.kim@samsung.com>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Sanghyun Lee' <sanghyun75.lee@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 09, 2012 at 09:15:24PM +0900, Cho KyongHo wrote:
> +/* We does not consider super section mapping (16MB) */
> +struct iommu_client {
> +	struct list_head node;
> +	struct device *dev;
> +};
> +
> +struct exynos_iommu_domain {
> +	struct list_head clients; /* list of iommu_client */
> +	unsigned long *pgtable; /* lv1 page table, 16KB */
> +	short *lv2entcnt; /* free lv2 entry counter for each section */
> +	spinlock_t lock; /* lock for this structure and attached iommu_client */
> +	spinlock_t pgtablelock; /* lock for modifying page table @ pgtable */
> +};
> +
> +struct sysmmu_drvdata {
> +	struct device *sysmmu;
> +	char *dbgname;
> +	int nsfrs;
> +	void __iomem **sfrbases;
> +	struct clk *clk[2];
> +	int activations;
> +	rwlock_t lock;
> +	struct iommu_domain *domain;
> +	sysmmu_fault_handler_t fault_handler;
> +	unsigned long pgtable;
> +	struct iommu_client client;
> +};

Is there any reason why 'struct iommu_client' is a seperate data
structure? Otherwise it can be merged with 'truct sysmmu_drvdata'.

> +static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
> +{
> +	struct exynos_iommu_domain *priv = domain->priv;
> +	struct list_head *pos, *n;
> +	unsigned long flags;
> +	int i;
> +
> +	WARN_ON(!list_empty(&priv->clients));
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	list_for_each_safe(pos, n, &priv->clients) {
> +		struct iommu_client *client;
> +
> +		client = list_entry(pos, struct iommu_client, node);
> +		exynos_sysmmu_disable(client->dev);
> +		kfree(client);
> +	}

Why this kfree here? Aren't all iommu_clients just a part of another
data-structre?


-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
