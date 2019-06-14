Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14111C31E4B
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 18:12:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C312082C
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 18:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gYkilA5F";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="oaOJffTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C312082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A749F11EB;
	Fri, 14 Jun 2019 18:12:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 34118E1E
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 18:12:48 +0000 (UTC)
X-Greylist: delayed 00:07:38 by SQLgrey-1.7.6
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
	[198.182.61.142])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 25F20E5
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 18:12:46 +0000 (UTC)
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com
	[10.12.135.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 034BBC2289;
	Fri, 14 Jun 2019 18:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1560535508; bh=8l8rPS/BySgxKl7CjMynmtU9SAyJOl5r8Xw0NG8wAC0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=gYkilA5FB8HiSeRy3vKPpk5f4eCqFid+8N3qGOQkb+u9MEkuKLQtD60WF6LncCyVo
	QeoSjg/yuJsnQJNlqTgMX8qfrXg4rtoYa0SmFgUIuLZy28heStZIY24ATvCE0v5XST
	o35bQF3DWPTSqqMIg0nsbKSWi+1UEjWOtQHyf34TvDAs89UBINSd9Xttn8tVPVUojs
	8pKMnAwGkJnB/nf5HQMrhH4bbWfHoPncCwTd7GQ7gd03p28GmOUZhOvQqNdozrervd
	m6CdlpOb3owxqS340+5uaCiZ6i4T5ZfD2dA2DJ/lKZ977u9gXauvIVapnAnPrAZjyp
	6doF38xDoZ4Mw==
Received: from us01wehtc1.internal.synopsys.com
	(us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mailhost.synopsys.com (Postfix) with ESMTPS id D4B33A009B;
	Fri, 14 Jun 2019 18:05:03 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
	us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP
	Server (TLS) id 14.3.408.0; Fri, 14 Jun 2019 11:05:03 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
	by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
	14.3.408.0; Fri, 14 Jun 2019 11:05:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=8l8rPS/BySgxKl7CjMynmtU9SAyJOl5r8Xw0NG8wAC0=;
	b=oaOJffTjW0uTpKf34k7hA4ANFNsEMxaGhtz6N1kUgHH+s238w8ljAedjDNr8knG8MLj2PddmLsOGZXyqmdHBxD0xg28TxIF2IdAYdAMEYFE8Jljiiy/0hfPsaFrTUY6t7svusvAd9f8KO9dTFX9WiuJpZCZk5Gx/rdC0mQMAq8g=
Received: from SN6PR12MB2670.namprd12.prod.outlook.com (52.135.103.23) by
	SN6PR12MB2670.namprd12.prod.outlook.com (52.135.103.23) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.17; Fri, 14 Jun 2019 18:05:01 +0000
Received: from SN6PR12MB2670.namprd12.prod.outlook.com
	([fe80::cd10:94a4:d1b1:c3b2]) by
	SN6PR12MB2670.namprd12.prod.outlook.com
	([fe80::cd10:94a4:d1b1:c3b2%5]) with mapi id 15.20.1965.019;
	Fri, 14 Jun 2019 18:05:01 +0000
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: "hch@lst.de" <hch@lst.de>,
	Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 7/7] arc: use the generic remapping allocator for coherent
	DMA allocations
Thread-Topic: [PATCH 7/7] arc: use the generic remapping allocator for
	coherent DMA allocations
Thread-Index: AQHVIsAMmlRh09Vs6Ea+qlthrKcWyaabcdSA
Date: Fri, 14 Jun 2019 18:05:01 +0000
Message-ID: <78ac563f2815a9a14bfab6076d0ef948497f5b9f.camel@synopsys.com>
References: <20190614144431.21760-1-hch@lst.de>
	<20190614144431.21760-8-hch@lst.de>
In-Reply-To: <20190614144431.21760-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe65ae5e-8ab4-4807-cac3-08d6f0f2d1c4
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:SN6PR12MB2670; 
x-ms-traffictypediagnostic: SN6PR12MB2670:
x-microsoft-antispam-prvs: <SN6PR12MB2670A4F2AE9D22869844289FDEEE0@SN6PR12MB2670.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(979002)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(66476007)(99286004)(66946007)(91956017)(73956011)(118296001)(102836004)(76176011)(478600001)(76116006)(6506007)(305945005)(7736002)(2501003)(66446008)(64756008)(66556008)(8676002)(8936002)(81166006)(81156014)(316002)(53936002)(6436002)(86362001)(6512007)(229853002)(6486002)(4326008)(6246003)(68736007)(25786009)(54906003)(110136005)(14454004)(2906002)(66066001)(7416002)(5660300002)(3846002)(6116002)(6636002)(486006)(476003)(26005)(256004)(14444005)(71190400001)(71200400001)(186003)(36756003)(2616005)(11346002)(446003)(41533002)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR12MB2670;
	H:SN6PR12MB2670.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: synopsys.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YBo9AYdmhEZbwv5F7ged9mWrC7tql7NT/82/lk4XBk4yxnVTMeXKJkmO/NjR85T44P5fCtj9xLXlJq9Ucph+GJH4m3+N//zN8tQtYI06Dq4BBxo7v6XIpR22HYlb/2KyiFzVWZ+2nKz84PkZWPkOlIqHHuRcNZ0zWSY16jw5gdyNkT4h/gn7M3mtCfptPWK9h/g0BXFbxbkqC6xgvi/jttuP7GI6eHhrGNHGiGQIfpMalogyDPNVq8zTgVertmYirFJda3stU1kZIIRNzG6smhyRLoZfRYFcnaSs8tqepqOsbsk8RNRuzdww5tXASliJmsM2Hs3JpzT5a9idHU3GyP2F5IGaF4QyjSsW54WTao4IWUGOvUolro4T4ZUaXgvsiQCZDW8IhXZ8DvCk2pH1fNVZx0/w7eUJjwi/d8tuhX4=
Content-ID: <FCDD90A34BC48347BC639126DA077974@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fe65ae5e-8ab4-4807-cac3-08d6f0f2d1c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 18:05:01.0717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paltsev@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2670
X-OriginatorOrg: synopsys.com
Cc: "jonas@southpole.se" <jonas@southpole.se>,
	"linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
	"vladimir.murzin@arm.com" <vladimir.murzin@arm.com>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"deller@gmx.de" <deller@gmx.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stefan.kristiansson@saunalahti.fi" <stefan.kristiansson@saunalahti.fi>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
	"shorne@gmail.com" <shorne@gmail.com>, "linux-snps-arc@lists.infradead.org"
	<linux-snps-arc@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Christoph,

Regular question - do you have any public git repository with all this dma changes?
I want to test it for ARC.

Pretty sure the
 [PATCH 2/7] arc: remove the partial DMA_ATTR_NON_CONSISTENT support
is fine.

Not so sure about
 [PATCH 7/7] arc: use the generic remapping allocator for coherent DMA allocations
:)

On Fri, 2019-06-14 at 16:44 +0200, Christoph Hellwig wrote:
> Replace the code that sets up uncached PTEs with the generic vmap based
> remapping code.  It also provides an atomic pool for allocations from
> non-blocking context, which we not properly supported by the existing
> arc code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/Kconfig  |  2 ++
>  arch/arc/mm/dma.c | 62 ++++++++---------------------------------------
>  2 files changed, 12 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 23e063df5d2c..cdad7d30ff1d 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -10,6 +10,7 @@ config ARC
>  	def_bool y
>  	select ARC_TIMERS
>  	select ARCH_HAS_DMA_COHERENT_TO_PFN
> +	select ARCH_HAS_DMA_PREP_COHERENT
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_SETUP_DMA_OPS
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU
> @@ -19,6 +20,7 @@ config ARC
>  	select BUILDTIME_EXTABLE_SORT
>  	select CLONE_BACKWARDS
>  	select COMMON_CLK
> +	select DMA_DIRECT_REMAP
>  	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
>  	select GENERIC_CLOCKEVENTS
>  	select GENERIC_FIND_FIRST_BIT
> diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
> index 9832928f896d..0fa850709fac 100644
> --- a/arch/arc/mm/dma.c
> +++ b/arch/arc/mm/dma.c
> @@ -11,46 +11,15 @@
>  #include <asm/cacheflush.h>
>  
>  /*
> - * ARCH specific callbacks for generic noncoherent DMA ops (dma/noncoherent.c)
> + * ARCH specific callbacks for generic noncoherent DMA ops
>   *  - hardware IOC not available (or "dma-coherent" not set for device in DT)
>   *  - But still handle both coherent and non-coherent requests from caller
>   *
>   * For DMA coherent hardware (IOC) generic code suffices
>   */
> -void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> -		gfp_t gfp, unsigned long attrs)
> -{
> -	unsigned long order = get_order(size);
> -	struct page *page;
> -	phys_addr_t paddr;
> -	void *kvaddr;
> -
> -	/*
> -	 * __GFP_HIGHMEM flag is cleared by upper layer functions
> -	 * (in include/linux/dma-mapping.h) so we should never get a
> -	 * __GFP_HIGHMEM here.
> -	 */
> -	BUG_ON(gfp & __GFP_HIGHMEM);
> -
> -	page = alloc_pages(gfp | __GFP_ZERO, order);
> -	if (!page)
> -		return NULL;
> -
> -	/* This is linear addr (0x8000_0000 based) */
> -	paddr = page_to_phys(page);
> -
> -	*dma_handle = paddr;
> -
> -	/*
> -	 * A coherent buffer needs MMU mapping to enforce non-cachability.
> -	 * kvaddr is kernel Virtual address (0x7000_0000 based).
> -	 */
> -	kvaddr = ioremap_nocache(paddr, size);
> -	if (kvaddr == NULL) {
> -		__free_pages(page, order);
> -		return NULL;
> -	}
>  
> +void arch_dma_prep_coherent(struct page *page, size_t size)
> +{
>  	/*
>  	 * Evict any existing L1 and/or L2 lines for the backing page
>  	 * in case it was used earlier as a normal "cached" page.
> @@ -61,24 +30,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  	 * Currently flush_cache_vmap nukes the L1 cache completely which
>  	 * will be optimized as a separate commit
>  	 */
> -	dma_cache_wback_inv(paddr, size);
> -	return kvaddr;
> -}
> -
> -void arch_dma_free(struct device *dev, size_t size, void *vaddr,
> -		dma_addr_t dma_handle, unsigned long attrs)
> -{
> -	phys_addr_t paddr = dma_handle;
> -	struct page *page = virt_to_page(paddr);
> -
> -	iounmap((void __force __iomem *)vaddr);
> -	__free_pages(page, get_order(size));
> -}
> -
> -long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
> -		dma_addr_t dma_addr)
> -{
> -	return __phys_to_pfn(dma_addr);
> +	dma_cache_wback_inv(page_to_phys(page), size);
>  }
>  
>  /*
> @@ -155,3 +107,9 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  	dev_info(dev, "use %sncoherent DMA ops\n",
>  		 dev->dma_coherent ? "" : "non");
>  }
> +
> +static int __init atomic_pool_init(void)
> +{
> +	return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
> +}
> +postcore_initcall(atomic_pool_init);
-- 
 Eugeniy Paltsev
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
