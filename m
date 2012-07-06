From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 06/28] iommu/amd: Move informational prinks out of
 iommu_enable
Date: Thu, 05 Jul 2012 21:08:38 -0700
Message-ID: <1341547718.27760.5.camel@joe2Laptop>
References: <1341491808-23083-1-git-send-email-joerg.roedel@amd.com>
	 <1341491808-23083-7-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1341491808-23083-7-git-send-email-joerg.roedel@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2012-07-05 at 14:36 +0200, Joerg Roedel wrote:
> This function will be called before the PCI subsystem is
> initialized. Therefore dev_name doen't work and IOMMU
> information can't be printed to the klog as before. Move the
> code to print that information to a later point where PCI
> initializtion has already happened.
[]
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
[]
> @@ -1102,6 +1085,28 @@ static int iommu_init_pci(struct amd_iommu *iommu)
[]
> +static void print_iommu_info(void)
> +{
> +	static const char * const feat_str[] = {
> +		"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
> +		"IA", "GA", "HE", "PC", NULL
> +	};
> +	struct amd_iommu *iommu;
> +
> +	for_each_iommu(iommu) {
> +		int i;
> +		pr_info("AMD-Vi: Found IOMMU at %s cap 0x%hx\n",
> +			dev_name(&iommu->dev->dev), iommu->cap_ptr);
> +		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
> +			pr_info("AMD-Vi:  Extended features: ");
> +			for (i = 0; feat_str[i]; ++i)
> +				if (iommu_feature(iommu, (1ULL << i)))
> +					pr_cont(" %s", feat_str[i]);

I think this should use {} around the for loop
and this would be better as:

	static const char * const feat_str[] = {
		"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
		"IA", "GA", "HE", "PC"
	};
[]
			for (i = 0; ARRAY_SIZE(feat_str); i++) {
				if (iommu_feature(iommu, (1ULL << i)))
					pr_cont(" %s", feat_str[i]);
 			}

I don't see the utility of the separate function and
this could just be inlined in the calling function.
