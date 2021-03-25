Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79440C433C1
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 14:27:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB62B619FE
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 14:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB62B619FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DA9184A14;
	Thu, 25 Mar 2021 14:27:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mtL-R3ipVe9u; Thu, 25 Mar 2021 14:27:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE1E784A0D;
	Thu, 25 Mar 2021 14:27:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95B3CC000E;
	Thu, 25 Mar 2021 14:27:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E89FBC000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 14:27:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB1C34054B
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 14:27:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vty0nWShQW6x for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 14:27:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA0B340549
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 14:27:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18E91143D;
 Thu, 25 Mar 2021 07:27:25 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 840A13F792;
 Thu, 25 Mar 2021 07:27:23 -0700 (PDT)
Subject: Re: [PATCH 5/9] iommu/arm-smmu: tegra: Detect number of instances at
 runtime
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>, 
 Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <20210325130332.778208-1-thierry.reding@gmail.com>
 <20210325130332.778208-6-thierry.reding@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2f2039a0-bf7e-9261-62f6-bea118c64b38@arm.com>
Date: Thu, 25 Mar 2021 14:27:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325130332.778208-6-thierry.reding@gmail.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-03-25 13:03, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Parse the reg property in device tree and detect the number of instances
> represented by a device tree node. This is subsequently needed in order
> to support single-instance SMMUs with the Tegra implementation because
> additional programming is needed to properly configure the SID override
> registers in the memory controller.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 49 ++++++++++++++------
>   1 file changed, 34 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> index 29117444e5a0..5b1170b028f0 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> @@ -20,13 +20,19 @@
>    * The third instance usage is through standard arm-smmu driver itself and
>    * is out of scope of this implementation.
>    */
> -#define NUM_SMMU_INSTANCES 2
> +#define MAX_SMMU_INSTANCES 2
>   
>   struct nvidia_smmu {
> -	struct arm_smmu_device	smmu;
> -	void __iomem		*bases[NUM_SMMU_INSTANCES];
> +	struct arm_smmu_device smmu;
> +	void __iomem *bases[MAX_SMMU_INSTANCES];
> +	unsigned int num_instances;

Surely it would make more sense to just add a second set of 
implementation ops without all the overrides that aren't needed for a 
single instance?

Also note that the binding currently requires the Tegra-specific 
compatible to have exactly two regions.

Robin.

>   };
>   
> +static inline struct nvidia_smmu *to_nvidia_smmu(struct arm_smmu_device *smmu)
> +{
> +	return container_of(smmu, struct nvidia_smmu, smmu);
> +}
> +
>   static inline void __iomem *nvidia_smmu_page(struct arm_smmu_device *smmu,
>   					     unsigned int inst, int page)
>   {
> @@ -47,9 +53,10 @@ static u32 nvidia_smmu_read_reg(struct arm_smmu_device *smmu,
>   static void nvidia_smmu_write_reg(struct arm_smmu_device *smmu,
>   				  int page, int offset, u32 val)
>   {
> +	struct nvidia_smmu *nvidia = to_nvidia_smmu(smmu);
>   	unsigned int i;
>   
> -	for (i = 0; i < NUM_SMMU_INSTANCES; i++) {
> +	for (i = 0; i < nvidia->num_instances; i++) {
>   		void __iomem *reg = nvidia_smmu_page(smmu, i, page) + offset;
>   
>   		writel_relaxed(val, reg);
> @@ -67,9 +74,10 @@ static u64 nvidia_smmu_read_reg64(struct arm_smmu_device *smmu,
>   static void nvidia_smmu_write_reg64(struct arm_smmu_device *smmu,
>   				    int page, int offset, u64 val)
>   {
> +	struct nvidia_smmu *nvidia = to_nvidia_smmu(smmu);
>   	unsigned int i;
>   
> -	for (i = 0; i < NUM_SMMU_INSTANCES; i++) {
> +	for (i = 0; i < nvidia->num_instances; i++) {
>   		void __iomem *reg = nvidia_smmu_page(smmu, i, page) + offset;
>   
>   		writeq_relaxed(val, reg);
> @@ -79,6 +87,7 @@ static void nvidia_smmu_write_reg64(struct arm_smmu_device *smmu,
>   static void nvidia_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
>   				 int sync, int status)
>   {
> +	struct nvidia_smmu *nvidia = to_nvidia_smmu(smmu);
>   	unsigned int delay;
>   
>   	arm_smmu_writel(smmu, page, sync, 0);
> @@ -90,7 +99,7 @@ static void nvidia_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
>   			u32 val = 0;
>   			unsigned int i;
>   
> -			for (i = 0; i < NUM_SMMU_INSTANCES; i++) {
> +			for (i = 0; i < nvidia->num_instances; i++) {
>   				void __iomem *reg;
>   
>   				reg = nvidia_smmu_page(smmu, i, page) + status;
> @@ -112,9 +121,10 @@ static void nvidia_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
>   
>   static int nvidia_smmu_reset(struct arm_smmu_device *smmu)
>   {
> +	struct nvidia_smmu *nvidia = to_nvidia_smmu(smmu);
>   	unsigned int i;
>   
> -	for (i = 0; i < NUM_SMMU_INSTANCES; i++) {
> +	for (i = 0; i < nvidia->num_instances; i++) {
>   		u32 val;
>   		void __iomem *reg = nvidia_smmu_page(smmu, i, ARM_SMMU_GR0) +
>   				    ARM_SMMU_GR0_sGFSR;
> @@ -157,8 +167,9 @@ static irqreturn_t nvidia_smmu_global_fault(int irq, void *dev)
>   	unsigned int inst;
>   	irqreturn_t ret = IRQ_NONE;
>   	struct arm_smmu_device *smmu = dev;
> +	struct nvidia_smmu *nvidia = to_nvidia_smmu(smmu);
>   
> -	for (inst = 0; inst < NUM_SMMU_INSTANCES; inst++) {
> +	for (inst = 0; inst < nvidia->num_instances; inst++) {
>   		irqreturn_t irq_ret;
>   
>   		irq_ret = nvidia_smmu_global_fault_inst(irq, smmu, inst);
> @@ -202,11 +213,13 @@ static irqreturn_t nvidia_smmu_context_fault(int irq, void *dev)
>   	struct arm_smmu_device *smmu;
>   	struct iommu_domain *domain = dev;
>   	struct arm_smmu_domain *smmu_domain;
> +	struct nvidia_smmu *nvidia;
>   
>   	smmu_domain = container_of(domain, struct arm_smmu_domain, domain);
>   	smmu = smmu_domain->smmu;
> +	nvidia = to_nvidia_smmu(smmu);
>   
> -	for (inst = 0; inst < NUM_SMMU_INSTANCES; inst++) {
> +	for (inst = 0; inst < nvidia->num_instances; inst++) {
>   		irqreturn_t irq_ret;
>   
>   		/*
> @@ -241,6 +254,7 @@ struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
>   	struct device *dev = smmu->dev;
>   	struct nvidia_smmu *nvidia_smmu;
>   	struct platform_device *pdev = to_platform_device(dev);
> +	unsigned int i;
>   
>   	nvidia_smmu = devm_krealloc(dev, smmu, sizeof(*nvidia_smmu), GFP_KERNEL);
>   	if (!nvidia_smmu)
> @@ -248,14 +262,19 @@ struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
>   
>   	/* Instance 0 is ioremapped by arm-smmu.c. */
>   	nvidia_smmu->bases[0] = smmu->base;
> +	nvidia_smmu->num_instances++;
> +
> +	for (i = 1; i < MAX_SMMU_INSTANCES; i++) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> +		if (!res)
> +			break;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	if (!res)
> -		return ERR_PTR(-ENODEV);
> +		nvidia_smmu->bases[i] = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(nvidia_smmu->bases[i]))
> +			return ERR_CAST(nvidia_smmu->bases[i]);
>   
> -	nvidia_smmu->bases[1] = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(nvidia_smmu->bases[1]))
> -		return ERR_CAST(nvidia_smmu->bases[1]);
> +		nvidia_smmu->num_instances++;
> +	}
>   
>   	nvidia_smmu->smmu.impl = &nvidia_smmu_impl;
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
