Return-Path: <SRS0=0DsW=3G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C94C33CB1
	for <iommu@archiver.kernel.org>; Fri, 17 Jan 2020 17:01:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814F42083E
	for <iommu@archiver.kernel.org>; Fri, 17 Jan 2020 17:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sxcGKW37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814F42083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4D9A38696D;
	Fri, 17 Jan 2020 17:01:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FKmyr1yy0aQT; Fri, 17 Jan 2020 17:01:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E6EE086964;
	Fri, 17 Jan 2020 17:01:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE676C18DC;
	Fri, 17 Jan 2020 17:01:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62042C077D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jan 2020 17:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4B0EE86CDB
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jan 2020 17:00:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id abfNbKAj3d6V for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jan 2020 17:00:53 +0000 (UTC)
X-Greylist: delayed 00:59:44 by SQLgrey-1.7.6
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2663B869EC
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jan 2020 17:00:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cl91XAA6QmDmmSR/VAp36/iAhj0xI7zHTjcIQWrMq09kdiObkBWYSikp+kjPx1avwhme4xDzd7SVIt5JdFxWO1jN0vWQoZbr0bZOxoprawj3vi6rsxuIac6r/73Jfkxstdsfdu6A04PBKezkxjbIk1ZlYxw0+xmm6THrl4zbMStaPeIPbahVvoZ6aGmn7xIok50VypIsVlFGfNsyM9ZWNpYSKCYu1xvNhcJ18n/Bp45XOinqvh67rrI3jTpsAgvULWWnU9A1FxoIkD4S/0EiEgcHeS5rAXk2fnc0NdXoQzO2wads68BBU3FhE6yuhTR8G5uq/+Fcfabv5kDyWq/OxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIpMDPJI6SEyzJ0mtaxcKR1WnnkZmQCBpwGlxNjdj3M=;
 b=DTtWg8bwhWOuby8csCbTIfs8b6FN09NNyucc61ODQS9XcgBanyqDP2/aWCUtCsLXZka3aBElUakZq0P9A+BQkF775k0FFAbLD3SK0tc3BDMThFg+KAwlOv0rl/OvXhKn0KojwBSqEePag0snk0Z3SxLHqNMKTdpKX28aZyCdTdJb9eeeBPeoTAYFIUkmNm+AEy4FwywDd7MqczHQYvl1z+VgIDQ0Jf6FtIZtIMwlht9iVU8+74gIWlPzdAsd1PsSivRFwTi6Fu6Q9OvlJp453neM8AwHDOnfu4EQKxIFPcJYY/C/aCPAr9i1b+y0UYTiwb0o+utJzNJ3UwYCeyE4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIpMDPJI6SEyzJ0mtaxcKR1WnnkZmQCBpwGlxNjdj3M=;
 b=sxcGKW37FPS7uYEkrytM85XANg8DnVhODWT8ObYXhBm4HF/7+eludatH9cDi+UY9K5Y+pEpzOTvFc/Fv584QDBAjX9dXJCUfyznFKZk/5q3+W+kE1GykUnNCIIReR47a9A3IQp2gL1AlmOTim6yGTn010eUoXWvblqyc2RZVRlw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.71.154) by
 DM6PR12MB2732.namprd12.prod.outlook.com (20.176.116.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.16; Fri, 17 Jan 2020 15:28:20 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a0cd:463:f444:c270]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a0cd:463:f444:c270%7]) with mapi id 15.20.2623.017; Fri, 17 Jan 2020
 15:28:20 +0000
Subject: Re: [rfc] dma-mapping: preallocate unencrypted DMA atomic pool
To: David Rientjes <rientjes@google.com>, Christoph Hellwig <hch@lst.de>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com>
Date: Fri, 17 Jan 2020 09:28:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
Content-Language: en-US
X-ClientProxiedBy: DM5PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:3:117::23) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
Received: from [10.236.30.74] (165.204.77.1) by
 DM5PR13CA0061.namprd13.prod.outlook.com (2603:10b6:3:117::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.10 via Frontend Transport; Fri, 17 Jan 2020 15:28:19 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 888e90ba-ca74-42f5-cba4-08d79b61e1fd
X-MS-TrafficTypeDiagnostic: DM6PR12MB2732:|DM6PR12MB2732:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27325902E1B037DD4D6518E3EC310@DM6PR12MB2732.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-Forefront-PRVS: 0285201563
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(136003)(39850400004)(346002)(189003)(199004)(316002)(186003)(6486002)(66476007)(66556008)(2616005)(26005)(110136005)(36756003)(31696002)(16576012)(956004)(2906002)(16526019)(54906003)(478600001)(8676002)(4326008)(86362001)(30864003)(81156014)(8936002)(31686004)(66946007)(5660300002)(81166006)(53546011)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2732;
 H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XB3hOODR/uepY+L9lu7yoKFUA/ksA0Cfx7rMm2F5vWKyAdLXaaCkUXFJ14T3k2LEgGec5Bim30QlvIYioriywcQk3sM8xaasOUzUfUes5eenZuCNHc4r+gLEY1fhjnkB9F0tZpM+ZCSyRcs3sGkffCF5Xk22TqgKJlXC+1YzRKfRz6b8bxmFjbBWJ4TQyTRlVa9bCoB+YbK0ZGD15YkXTJDPpwQohymBYHpuN2L83GqGvo10tJ8ZunJgksett9dcKfuNfpBiDe+UKClbTWrAd1r8SZFzhebr5+YHg1ATpq6ETLGiBX3wl1aFAesRS8BuiIUdKSayuX5FFAwMhSEvA0WUU/08k431ScwI+GHfP4gKFGJ7y1w+7JiCDVymIvRka7TuJogsJjmNjDDxuD37dAu0f7lECigoWtXUoxFmqxE2MbrXKIW8P8kyi8umlKvk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888e90ba-ca74-42f5-cba4-08d79b61e1fd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 15:28:20.6001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDQ6xsySneGSUjGAC/xOqGPGOVzE719n+9P0M82kSMmhxmcZtqvYq4g1zYfC6G5Y7QJnGacTAXalUktjx3JYtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2732
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "Grimm, Jon" <jon.grimm@amd.com>,
 baekhw@google.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 12/31/19 7:54 PM, David Rientjes wrote:
> Christoph, Thomas, is something like this (without the diagnosic 
> information included in this patch) acceptable for these allocations?  
> Adding expansion support when the pool is half depleted wouldn't be *that* 
> hard.

Sorry for the delay in responding...  Overall, I think this will work
well. If you want the default size to be adjustable, you can always go
with a Kconfig setting or a command line parameter or both (I realize the
command line parameter is not optimal).

Just a couple of overall comments about the use of variable names and
messages using both unencrypted and encrypted, I think the use should be
consistent throughout the patch.

Thanks,
Tom

> 
> Or are there alternatives we should consider?  Thanks!
> 
> 
> 
> 
> When AMD SEV is enabled in the guest, all allocations through 
> dma_pool_alloc_page() must call set_memory_decrypted() for unencrypted 
> DMA.  This includes dma_pool_alloc() and dma_direct_alloc_pages().  These 
> calls may block which is not allowed in atomic allocation contexts such as 
> from the NVMe driver.
> 
> Preallocate a complementary unecrypted DMA atomic pool that is initially 
> 4MB in size.  This patch does not contain dynamic expansion, but that 
> could be added if necessary.
> 
> In our stress testing, our peak unecrypted DMA atomic allocation 
> requirements is ~1.4MB, so 4MB is plenty.  This pool is similar to the 
> existing DMA atomic pool but is unencrypted.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  Based on v5.4 HEAD.
> 
>  This commit contains diagnostic information and is not intended for use 
>  in a production environment.
> 
>  arch/x86/Kconfig            |   1 +
>  drivers/iommu/dma-iommu.c   |   5 +-
>  include/linux/dma-mapping.h |   7 ++-
>  kernel/dma/direct.c         |  16 ++++-
>  kernel/dma/remap.c          | 116 ++++++++++++++++++++++++++----------
>  5 files changed, 108 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1530,6 +1530,7 @@ config X86_CPA_STATISTICS
>  config AMD_MEM_ENCRYPT
>  	bool "AMD Secure Memory Encryption (SME) support"
>  	depends on X86_64 && CPU_SUP_AMD
> +	select DMA_DIRECT_REMAP
>  	select DYNAMIC_PHYSICAL_MASK
>  	select ARCH_USE_MEMREMAP_PROT
>  	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -928,7 +928,7 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
>  
>  	/* Non-coherent atomic allocation? Easy */
>  	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> -	    dma_free_from_pool(cpu_addr, alloc_size))
> +	    dma_free_from_pool(dev, cpu_addr, alloc_size))
>  		return;
>  
>  	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
> @@ -1011,7 +1011,8 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
>  
>  	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
>  	    !gfpflags_allow_blocking(gfp) && !coherent)
> -		cpu_addr = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
> +		cpu_addr = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page,
> +					       gfp);
>  	else
>  		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
>  	if (!cpu_addr)
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -629,9 +629,10 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
>  			pgprot_t prot, const void *caller);
>  void dma_common_free_remap(void *cpu_addr, size_t size);
>  
> -bool dma_in_atomic_pool(void *start, size_t size);
> -void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags);
> -bool dma_free_from_pool(void *start, size_t size);
> +bool dma_in_atomic_pool(struct device *dev, void *start, size_t size);
> +void *dma_alloc_from_pool(struct device *dev, size_t size,
> +			  struct page **ret_page, gfp_t flags);
> +bool dma_free_from_pool(struct device *dev, void *start, size_t size);
>  
>  int
>  dma_common_get_sgtable(struct device *dev, struct sg_table *sgt, void *cpu_addr,
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -10,6 +10,7 @@
>  #include <linux/dma-direct.h>
>  #include <linux/scatterlist.h>
>  #include <linux/dma-contiguous.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/dma-noncoherent.h>
>  #include <linux/pfn.h>
>  #include <linux/set_memory.h>
> @@ -131,6 +132,13 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	struct page *page;
>  	void *ret;
>  
> +	if (!gfpflags_allow_blocking(gfp) && force_dma_unencrypted(dev)) {
> +		ret = dma_alloc_from_pool(dev, size, &page, gfp);
> +		if (!ret)
> +			return NULL;
> +		goto done;
> +	}
> +
>  	page = __dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
>  	if (!page)
>  		return NULL;
> @@ -156,7 +164,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>  		__dma_direct_free_pages(dev, size, page);
>  		return NULL;
>  	}
> -
> +done:
>  	ret = page_address(page);
>  	if (force_dma_unencrypted(dev)) {
>  		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
> @@ -185,6 +193,12 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
>  {
>  	unsigned int page_order = get_order(size);
>  
> +	if (force_dma_unencrypted(dev) &&
> +	    dma_in_atomic_pool(dev, cpu_addr, size)) {
> +		dma_free_from_pool(dev, cpu_addr, size);
> +		return;
> +	}
> +
>  	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
>  	    !force_dma_unencrypted(dev)) {
>  		/* cpu_addr is a struct page cookie, not a kernel address */
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -8,6 +8,7 @@
>  #include <linux/dma-contiguous.h>
>  #include <linux/init.h>
>  #include <linux/genalloc.h>
> +#include <linux/set_memory.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  
> @@ -100,9 +101,11 @@ void dma_common_free_remap(void *cpu_addr, size_t size)
>  
>  #ifdef CONFIG_DMA_DIRECT_REMAP
>  static struct gen_pool *atomic_pool __ro_after_init;
> +static struct gen_pool *atomic_pool_unencrypted __ro_after_init;
>  
>  #define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
>  static size_t atomic_pool_size __initdata = DEFAULT_DMA_COHERENT_POOL_SIZE;
> +static size_t atomic_pool_unencrypted_size __initdata = SZ_4M;
>  
>  static int __init early_coherent_pool(char *p)
>  {
> @@ -120,10 +123,11 @@ static gfp_t dma_atomic_pool_gfp(void)
>  	return GFP_KERNEL;
>  }
>  
> -static int __init dma_atomic_pool_init(void)
> +static int __init __dma_atomic_pool_init(struct gen_pool **pool,
> +				size_t pool_size, bool unencrypt)
>  {
> -	unsigned int pool_size_order = get_order(atomic_pool_size);
> -	unsigned long nr_pages = atomic_pool_size >> PAGE_SHIFT;
> +	unsigned int pool_size_order = get_order(pool_size);
> +	unsigned long nr_pages = pool_size >> PAGE_SHIFT;
>  	struct page *page;
>  	void *addr;
>  	int ret;
> @@ -136,78 +140,128 @@ static int __init dma_atomic_pool_init(void)
>  	if (!page)
>  		goto out;
>  
> -	arch_dma_prep_coherent(page, atomic_pool_size);
> +	arch_dma_prep_coherent(page, pool_size);
>  
> -	atomic_pool = gen_pool_create(PAGE_SHIFT, -1);
> -	if (!atomic_pool)
> +	*pool = gen_pool_create(PAGE_SHIFT, -1);
> +	if (!*pool)
>  		goto free_page;
>  
> -	addr = dma_common_contiguous_remap(page, atomic_pool_size,
> +	addr = dma_common_contiguous_remap(page, pool_size,
>  					   pgprot_dmacoherent(PAGE_KERNEL),
>  					   __builtin_return_address(0));
>  	if (!addr)
>  		goto destroy_genpool;
>  
> -	ret = gen_pool_add_virt(atomic_pool, (unsigned long)addr,
> -				page_to_phys(page), atomic_pool_size, -1);
> +	ret = gen_pool_add_virt(*pool, (unsigned long)addr, page_to_phys(page),
> +				pool_size, -1);
>  	if (ret)
>  		goto remove_mapping;
> -	gen_pool_set_algo(atomic_pool, gen_pool_first_fit_order_align, NULL);
> +	gen_pool_set_algo(*pool, gen_pool_first_fit_order_align, NULL);
> +	if (unencrypt)
> +		set_memory_decrypted((unsigned long)page_to_virt(page), nr_pages);
>  
> -	pr_info("DMA: preallocated %zu KiB pool for atomic allocations\n",
> -		atomic_pool_size / 1024);
> +	pr_info("DMA: preallocated %zu KiB pool for atomic allocations%s\n",
> +		pool_size >> 10, unencrypt ? " (unencrypted)" : "");
>  	return 0;
>  
>  remove_mapping:
> -	dma_common_free_remap(addr, atomic_pool_size);
> +	dma_common_free_remap(addr, pool_size);
>  destroy_genpool:
> -	gen_pool_destroy(atomic_pool);
> -	atomic_pool = NULL;
> +	gen_pool_destroy(*pool);
> +	*pool = NULL;
>  free_page:
>  	if (!dma_release_from_contiguous(NULL, page, nr_pages))
>  		__free_pages(page, pool_size_order);
>  out:
> -	pr_err("DMA: failed to allocate %zu KiB pool for atomic coherent allocation\n",
> -		atomic_pool_size / 1024);
> +	pr_err("DMA: failed to allocate %zu KiB pool for atomic coherent allocation%s\n",
> +		pool_size >> 10, unencrypt ? " (unencrypted)" : "");
>  	return -ENOMEM;
>  }
> +
> +static int __init dma_atomic_pool_init(void)
> +{
> +	int ret;
> +
> +	ret = __dma_atomic_pool_init(&atomic_pool, atomic_pool_size, false);
> +	if (ret)
> +		return ret;
> +	return __dma_atomic_pool_init(&atomic_pool_unencrypted,
> +				      atomic_pool_unencrypted_size, true);
> +}
>  postcore_initcall(dma_atomic_pool_init);
>  
> -bool dma_in_atomic_pool(void *start, size_t size)
> +static inline struct gen_pool *dev_to_pool(struct device *dev)
>  {
> -	if (unlikely(!atomic_pool))
> -		return false;
> +	if (force_dma_unencrypted(dev))
> +		return atomic_pool_unencrypted;
> +	return atomic_pool;
> +}
> +
> +bool dma_in_atomic_pool(struct device *dev, void *start, size_t size)
> +{
> +	struct gen_pool *pool = dev_to_pool(dev);
>  
> -	return addr_in_gen_pool(atomic_pool, (unsigned long)start, size);
> +	if (unlikely(!pool))
> +		return false;
> +	return addr_in_gen_pool(pool, (unsigned long)start, size);
>  }
>  
> -void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
> +static struct gen_pool *atomic_pool __ro_after_init;
> +static size_t encrypted_pool_size;
> +static size_t encrypted_pool_size_max;
> +static spinlock_t encrypted_pool_size_lock;
> +
> +void *dma_alloc_from_pool(struct device *dev, size_t size,
> +			  struct page **ret_page, gfp_t flags)
>  {
> +	struct gen_pool *pool = dev_to_pool(dev);
>  	unsigned long val;
>  	void *ptr = NULL;
>  
> -	if (!atomic_pool) {
> -		WARN(1, "coherent pool not initialised!\n");
> +	if (!pool) {
> +		WARN(1, "%scoherent pool not initialised!\n",
> +			force_dma_unencrypted(dev) ? "encrypted " : "");
>  		return NULL;
>  	}
>  
> -	val = gen_pool_alloc(atomic_pool, size);
> +	val = gen_pool_alloc(pool, size);
>  	if (val) {
> -		phys_addr_t phys = gen_pool_virt_to_phys(atomic_pool, val);
> +		phys_addr_t phys = gen_pool_virt_to_phys(pool, val);
>  
>  		*ret_page = pfn_to_page(__phys_to_pfn(phys));
>  		ptr = (void *)val;
>  		memset(ptr, 0, size);
> +		if (force_dma_unencrypted(dev)) {
> +			unsigned long flags;
> +
> +			spin_lock_irqsave(&encrypted_pool_size_lock, flags);
> +			encrypted_pool_size += size;
> +			if (encrypted_pool_size > encrypted_pool_size_max) {
> +				encrypted_pool_size_max = encrypted_pool_size;
> +				pr_info("max encrypted pool size now %lu\n",
> +					encrypted_pool_size_max);
> +			}
> +			spin_unlock_irqrestore(&encrypted_pool_size_lock, flags);
> +		}
>  	}
>  
>  	return ptr;
>  }
>  
> -bool dma_free_from_pool(void *start, size_t size)
> +bool dma_free_from_pool(struct device *dev, void *start, size_t size)
>  {
> -	if (!dma_in_atomic_pool(start, size))
> +	struct gen_pool *pool = dev_to_pool(dev);
> +
> +	if (!dma_in_atomic_pool(dev, start, size))
>  		return false;
> -	gen_pool_free(atomic_pool, (unsigned long)start, size);
> +	gen_pool_free(pool, (unsigned long)start, size);
> +	if (force_dma_unencrypted(dev)) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&encrypted_pool_size_lock, flags);
> +		encrypted_pool_size -= size;
> +		spin_unlock_irqrestore(&encrypted_pool_size_lock, flags);
> +	}
>  	return true;
>  }
>  
> @@ -220,7 +274,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  	size = PAGE_ALIGN(size);
>  
>  	if (!gfpflags_allow_blocking(flags)) {
> -		ret = dma_alloc_from_pool(size, &page, flags);
> +		ret = dma_alloc_from_pool(dev, size, &page, flags);
>  		if (!ret)
>  			return NULL;
>  		goto done;
> @@ -251,7 +305,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  void arch_dma_free(struct device *dev, size_t size, void *vaddr,
>  		dma_addr_t dma_handle, unsigned long attrs)
>  {
> -	if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
> +	if (!dma_free_from_pool(dev, vaddr, PAGE_ALIGN(size))) {
>  		phys_addr_t phys = dma_to_phys(dev, dma_handle);
>  		struct page *page = pfn_to_page(__phys_to_pfn(phys));
>  
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
