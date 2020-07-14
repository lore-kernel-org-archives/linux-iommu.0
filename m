Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A96C433E0
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 11:41:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D441B22201
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 11:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ob6A/0Of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D441B22201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B32588A607;
	Tue, 14 Jul 2020 11:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UalwjCQM4Cf3; Tue, 14 Jul 2020 11:41:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9BC438A535;
	Tue, 14 Jul 2020 11:41:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 954D8C0891;
	Tue, 14 Jul 2020 11:41:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A48DCC0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 11:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6286122660
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 11:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xS+U+jiD6PO2 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 11:40:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by silver.osuosl.org (Postfix) with ESMTPS id 402D720788
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 11:40:58 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200714114055euoutp018f262ca36d47956fe64e0e6798185b2c~hm6BDCcln0732207322euoutp01T
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 11:40:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200714114055euoutp018f262ca36d47956fe64e0e6798185b2c~hm6BDCcln0732207322euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1594726855;
 bh=+vo5dveH6ZFKZMq3As9W8YeuRHrXn42cbLcShGHpbog=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=Ob6A/0OfbQ5r4QH2yY1SwypZvbImeu2P1HkAsYHBMehGTJoP4isLEMcKuvWfOmm5G
 +q3bsUsDI504G6pRepr6shDfsEeimEO4GR1kaKFA2b4/SQCngB5QmTmee5Diy9amvy
 Z071D0g5dkCQE3Pzfj3lKBdWJUdiALhyvrs8//7I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200714114055eucas1p1f251cddfc4abcd0841510326c4e88e58~hm6A4d5rx2334823348eucas1p1i;
 Tue, 14 Jul 2020 11:40:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 9A.A1.05997.7C99D0F5; Tue, 14
 Jul 2020 12:40:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200714114054eucas1p1514a975ade3dff5479b035181f8a5480~hm6AXWU_g2297722977eucas1p1l;
 Tue, 14 Jul 2020 11:40:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200714114054eusmtrp26593e9daba4daa1ee46db7e9ffa2e74a~hm6AWqz4g1283912839eusmtrp2Z;
 Tue, 14 Jul 2020 11:40:54 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-25-5f0d99c7e0aa
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 4C.51.06314.6C99D0F5; Tue, 14
 Jul 2020 12:40:54 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200714114054eusmtip225d086594279c40f756e4767ec999934~hm6AF7IFz0874308743eusmtip2J;
 Tue, 14 Jul 2020 11:40:54 +0000 (GMT)
Subject: Re: [PATCH] iommu/exynos: Rename update_pte()
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <f6c29336-1d9a-e66f-b462-b12507d04746@samsung.com>
Date: Tue, 14 Jul 2020 13:40:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <615eb039388e399da86bd90fc61792b88e39adac.1594726393.git.robin.murphy@arm.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduznOd3jM3njDVqmSlks2G9t0Tl7A7vF
 wQ9PWB2YPZ4cnMfksWbeGkaPyTeWMwYwR3HZpKTmZJalFunbJXBlzHr2irlgtVjF8fWH2BsY
 /wh2MXJySAiYSDz/1ccEYgsJrGCU2P23rouRC8j+wijRP3EzM0TiM6PEiXYumIajl5awQRQt
 Z5T4eXwuO4TznlFi5pLJrCBVwgJmEpcu9rKD2CICFhIHf7wFm8QsoCJx/9MvFhCbTcBQoutt
 FxuIzStgJ7Ho8RqwehYBVYkvd+eA1YsKxEmsf7mdCaJGUOLkzCdgvZwC0RIdl5azQMyUl9j+
 dg7UfHGJW0/mM4EcJCHQzC5x+slrRoizXSS+v5jAAmELS7w6voUdwpaR+L8TroFR4uG5tewQ
 Tg+jxOWmGVDd1hJ3zv0COpUDaIWmxPpd+hBhR4nlh36ChSUE+CRuvBWEOIJPYtK26cwQYV6J
 jjYhiGo1iVnH18GtPXjhEvMERqVZSF6bheSdWUjemYWwdwEjyypG8dTS4tz01GKjvNRyveLE
 3OLSvHS95PzcTYzANHL63/EvOxh3/Uk6xCjAwajEwzsBmF6EWBPLiitzDzFKcDArifA6nT0d
 J8SbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVAPj2hXbSlk7
 J4ccqnqb9Tu14n5IkN3zn08DD8ee79p14iFj24eif673zNa9un9YbvbPbTd2HOq9W7LycYSk
 pwBXR1Tk34rz5pdeB3d9/G//dAqbRHVz3lXjha9fpB3nUtVx0/wrfby05Xp2jOnSW/Iua7LL
 UirOd+aZxjxf9/nblbhFtVOvLNASUWIpzkg01GIuKk4EAArGUCUfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7rHZvLGG/y6bWaxYL+1RefsDewW
 Bz88YXVg9nhycB6Tx5p5axg9Jt9YzhjAHKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdo
 bB5rZWSqpG9nk5Kak1mWWqRvl6CXMevZK+aC1WIVx9cfYm9g/CPYxcjJISFgInH00hK2LkYu
 DiGBpYwSz7fPZoNIyEicnNbACmELS/y51gUWFxJ4yyixuJERxBYWMJO4dLGXHcQWEbCQOPjj
 LTOIzSygInH/0y8WiKHrGCU27d/PBJJgEzCU6HoLMYhXwE5i0eM1YM0sAqoSX+7OAWsWFYiT
 WL5lPjtEjaDEyZlPWEBsToFoiY5Ly1kgFphJzNv8EGqZvMT2t3OgbHGJW0/mM01gFJqFpH0W
 kpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzByth37uXkH46WNwYcYBTgY
 lXh4JwAjSog1say4MvcQowQHs5IIr9PZ03FCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA+M
 6rySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYzT8kX3si0Scvyu
 +lioRaiK+ZHaYvnpP1+d2KI0odWSoyHgnLiI7sTEJTbrls9o4NM+9mDl2l5u+ykfJlzl+BVl
 +2GBuIbV4i/tk3sMJM5Iq4tP947ZFnXPfEdF+epVm0QPKvLtD/vxVWwCv9VVm7tzNrcGuq1c
 1fHv5u6Qq5+OvJvff+h/shenEktxRqKhFnNRcSIAgwLhBLICAAA=
X-CMS-MailID: 20200714114054eucas1p1514a975ade3dff5479b035181f8a5480
X-Msg-Generator: CA
X-RootMTR: 20200714113319eucas1p1e085aac4c6404e047cf1ce66be44adbc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200714113319eucas1p1e085aac4c6404e047cf1ce66be44adbc
References: <CGME20200714113319eucas1p1e085aac4c6404e047cf1ce66be44adbc@eucas1p1.samsung.com>
 <615eb039388e399da86bd90fc61792b88e39adac.1594726393.git.robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org
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

Hi Robin,

On 14.07.2020 13:33, Robin Murphy wrote:
> The name "update_pte" is a little too generic, and can end up clashing
> with architecture pagetable code leaked out of common mm headers. Rename
> it to something mroe appropriately namespaced.
s/mroe/more
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/iommu/exynos-iommu.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 60c8a56e4a3f..75cdd37fae38 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -721,7 +721,7 @@ static struct platform_driver exynos_sysmmu_driver __refdata = {
>   	}
>   };
>   
> -static inline void update_pte(sysmmu_pte_t *ent, sysmmu_pte_t val)
> +static inline void exynos_iommu_set_pte(sysmmu_pte_t *ent, sysmmu_pte_t val)
>   {
>   	dma_sync_single_for_cpu(dma_dev, virt_to_phys(ent), sizeof(*ent),
>   				DMA_TO_DEVICE);
> @@ -933,7 +933,7 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *domain,
>   		if (!pent)
>   			return ERR_PTR(-ENOMEM);
>   
> -		update_pte(sent, mk_lv1ent_page(virt_to_phys(pent)));
> +		exynos_iommu_set_pte(sent, mk_lv1ent_page(virt_to_phys(pent)));
>   		kmemleak_ignore(pent);
>   		*pgcounter = NUM_LV2ENTRIES;
>   		handle = dma_map_single(dma_dev, pent, LV2TABLE_SIZE,
> @@ -994,7 +994,7 @@ static int lv1set_section(struct exynos_iommu_domain *domain,
>   		*pgcnt = 0;
>   	}
>   
> -	update_pte(sent, mk_lv1ent_sect(paddr, prot));
> +	exynos_iommu_set_pte(sent, mk_lv1ent_sect(paddr, prot));
>   
>   	spin_lock(&domain->lock);
>   	if (lv1ent_page_zero(sent)) {
> @@ -1018,7 +1018,7 @@ static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr, size_t size,
>   		if (WARN_ON(!lv2ent_fault(pent)))
>   			return -EADDRINUSE;
>   
> -		update_pte(pent, mk_lv2ent_spage(paddr, prot));
> +		exynos_iommu_set_pte(pent, mk_lv2ent_spage(paddr, prot));
>   		*pgcnt -= 1;
>   	} else { /* size == LPAGE_SIZE */
>   		int i;
> @@ -1150,7 +1150,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *iommu_domain,
>   		}
>   
>   		/* workaround for h/w bug in System MMU v3.3 */
> -		update_pte(ent, ZERO_LV2LINK);
> +		exynos_iommu_set_pte(ent, ZERO_LV2LINK);
>   		size = SECT_SIZE;
>   		goto done;
>   	}
> @@ -1171,7 +1171,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *iommu_domain,
>   	}
>   
>   	if (lv2ent_small(ent)) {
> -		update_pte(ent, 0);
> +		exynos_iommu_set_pte(ent, 0);
>   		size = SPAGE_SIZE;
>   		domain->lv2entcnt[lv1ent_offset(iova)] += 1;
>   		goto done;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
