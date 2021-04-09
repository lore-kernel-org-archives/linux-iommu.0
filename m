Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08985C433ED
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 12:24:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9117E611C2
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 12:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9117E611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55CBD406A0;
	Fri,  9 Apr 2021 12:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RwY6jgnTCbvD; Fri,  9 Apr 2021 12:24:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id C66C24069D;
	Fri,  9 Apr 2021 12:24:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A49B3C000B;
	Fri,  9 Apr 2021 12:24:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2D89C000B
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 12:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8FA944069E
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 12:24:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DAGse5Ov6Mp6 for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 12:24:54 +0000 (UTC)
X-Greylist: delayed 00:07:05 by SQLgrey-1.8.0
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AB09A4069D
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 12:24:53 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20210409121745euoutp022a580ea39a3f1977deca14468c00fae5~0L79uB1nZ1837518375euoutp02-
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 12:17:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20210409121745euoutp022a580ea39a3f1977deca14468c00fae5~0L79uB1nZ1837518375euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1617970665;
 bh=obKYiED5uZBbmmrBTD5Z9tgfZ9OYzo8BLBVf/O4bedU=;
 h=Subject:To:From:Date:In-Reply-To:References:From;
 b=Fk+xwSI5xxLknw4nFNg2WHrfUvfp7ZQqPzlmYcDbeOMw/LOQlv2MyW7JeDDxcOmkQ
 voVv5ip6IWLU3ZWzQ2BNkB5Xrmv4EVEQs+mGHPJI17JX6BMnzfy9wT6z6YdaD2FUZo
 VLC9e+nmX/rR3hZviHrrkb7fUUX5wK7qzk8EHOkc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20210409121745eucas1p28545be2592476d90872ede2b4ef86594~0L79fbyT_0550105501eucas1p2_;
 Fri,  9 Apr 2021 12:17:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 47.15.09444.8E540706; Fri,  9
 Apr 2021 13:17:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20210409121744eucas1p2a6a8d07e8e40c681f0f11a8ec26c1cb7~0L787sXnV0550105501eucas1p29;
 Fri,  9 Apr 2021 12:17:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210409121744eusmtrp14664072d6e5d54d48ca5217dd493c54a~0L7867tyV1867718677eusmtrp14;
 Fri,  9 Apr 2021 12:17:44 +0000 (GMT)
X-AuditID: cbfec7f4-dd5ff700000024e4-71-607045e8be82
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id AA.EA.08696.8E540706; Fri,  9
 Apr 2021 13:17:44 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210409121743eusmtip15476d007846b1c65da76fdc319d14a87~0L78Y6uKI1464914649eusmtip13;
 Fri,  9 Apr 2021 12:17:43 +0000 (GMT)
Subject: Re: [PATCH] iommu: exynos: remove unneeded local variable
 initialization
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <2a00f957-1f19-f398-ae18-908d8a17375d@samsung.com>
Date: Fri, 9 Apr 2021 14:17:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408201622.78009-1-krzysztof.kozlowski@canonical.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+c45OzsuJsdp7WVZq1FSQWqSNrDEomh0t4Ioqjn1oJk3NpeV
 RJZd3DKxotKTNcOV5roum2Z4rTSbudlKslZgzjJhkBqlRZbb6eJ/v+953u97nwc+CheV8iTU
 rrRMRp2mSpGRAsLSMmqb/2lFRmxo3hFcXtoQKddduM2X33GPYHJzbxdP7qgtIeVFtnpMfsQZ
 Hs1XuJouYQo25ySpMFfqSMVd40HFmVflSDFsnr6B3CZYnMCk7NrDqEOiYgVJ1u4xlHGO2pv/
 wE7mICepRz4U0AvhodGK65GAEtEVCI7qigmPIaK/IHDa0jljGMHnX6/R3xtl7dV8zihHUK8z
 Iu4wiGCk86v3XX96E3QadKTHCKB1GBhyn3oNkl4Aerfey0I6CkadP3keJuhZ4DC8xT08mY6D
 K+/HEDfjB23FLm8mH3ol2E5c8M7jtBSq3SU4x2J47TJgXDw7BZeHVBwvh2ds8R/dHwZaq/gc
 B4L1TD7hCQd0LoKejht87pCPwHG46E/RSHB2fB9PSo1vmAu3akM4eSm8+2gmPDLQvvDK7cdl
 8IXTlvM4Jwsh75iImw4CtvXmv7VN9uc4xwp4c+glrxDNZCe0ZCc0Yyc0Y/9nKEVEJRIzWk1q
 IqMJS2OygjWqVI02LTE4Pj3VjMY/kXWs9UsNKh8YDG5GGIWaEVC4LECYm5seKxImqPbtZ9Tp
 SrU2hdE0o6kUIRML46quK0V0oiqT2c0wGYz6r4tRPpIcLLlxWwcpi9H7f1gRWMgm3Q9r6R8+
 bfG9Osib1fYkoDIeb5nx423kqu4mQdsq5eyGgRIqRHR26GGMtlfQpyzwU241TS+rcduH+I1x
 BY8HLza+aQzf9HS2wR6Rranf3l/bP9dHHCl9sf+5CRtelmGUvNwpDef1btmb1QWfKqZ1W8YK
 MpfxNvR1LfnaGSV14KLEpWujt7wfbU2Y883kWl9Yc8Miqe3BeiUfukKMMSvrxH1H3z0K7WxY
 FHirhei5svn4gW8//FefP2VpX+e6eLsiwbZR8CQvT5ldtabJcc14bwcbLX22hp1iC4rQIt8s
 U7ZppHpPYLvw4LqfdZOM8RFWYbKM0CSpFszD1RrVb1o5UA6zAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7ovXAsSDDoXSlos2G9t0Tl7A7vF
 xrc/mCw2Pb7GanF51xw2ixnn9zFZtNwxdWD3eHJwHpPHrIZeNo9NqzrZPDYvqfeYfGM5o8fn
 TXIBbFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6
 Gadv/mMsmMZR0bP7AlsD4x22LkZODgkBE4nFZ7azg9hCAksZJY7utYKIy0icnNbACmELS/y5
 1gVUzwVU855RYtvWU2DNwgLBEhfnd4IlRAQ6mST+/3/JDlE1i1Fieu9nRpAqNgFDia63XWAd
 vAJ2Ej/v/AUbyyKgInF5/l1mEFtUIEmibfdMdogaQYmTM5+wgNicAu4S57tng9UzC5hJzNv8
 kBnClpfY/nYOlC0ucevJfKYJjIKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfm
 pesl5+duYgTG2LZjP7fsYFz56qPeIUYmDsZDjBIczEoivM3N+QlCvCmJlVWpRfnxRaU5qcWH
 GE2B/pnILCWanA+M8rySeEMzA1NDEzNLA1NLM2MlcV6TI2vihQTSE0tSs1NTC1KLYPqYODil
 Gpji53I59Hk946sS7thlzLonSnPBinvBb7bvWf895PaSfffW2ti/7dbSmN20m/VDjVKH0JUk
 T9c9mjMnbIs1mLn3oUMA784LvtMS9XiT0l2XWfrdk1y10/pbtNqx6v7LAh075Vu+sT+y/rGv
 g9nYx1rws57y1+2uCefer2K8uCF0uncEf8aJRxMWbS9bFWw+U8P5k3vuum71BQ/WO6kVT3qb
 mf5OXE2Iz1NFeneETstB/2de+wyezRdWbys97x7NZHBphgnjf7aupupnP9Ylz6lPMzVTstzN
 7Wcq9m+pbtRxoyOXxNO3/fx0847RzYBVBkEhXrO3bxRRvF+QO6H1avwidu+zaabm13s41h5+
 ul6JpTgj0VCLuag4EQBIGwpVOgMAAA==
X-CMS-MailID: 20210409121744eucas1p2a6a8d07e8e40c681f0f11a8ec26c1cb7
X-Msg-Generator: CA
X-RootMTR: 20210408201630eucas1p25551bcecf0073ac0361cfc03a4ef124a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210408201630eucas1p25551bcecf0073ac0361cfc03a4ef124a
References: <CGME20210408201630eucas1p25551bcecf0073ac0361cfc03a4ef124a@eucas1p2.samsung.com>
 <20210408201622.78009-1-krzysztof.kozlowski@canonical.com>
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

On 08.04.2021 22:16, Krzysztof Kozlowski wrote:
> The initialization of 'fault_addr' local variable is not needed as it is
> shortly after overwritten.
>
> Addresses-Coverity: Unused value
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/iommu/exynos-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index de324b4eedfe..8fa9a591fb96 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -407,7 +407,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
>   	struct sysmmu_drvdata *data = dev_id;
>   	const struct sysmmu_fault_info *finfo;
>   	unsigned int i, n, itype;
> -	sysmmu_iova_t fault_addr = -1;
> +	sysmmu_iova_t fault_addr;
>   	unsigned short reg_status, reg_clear;
>   	int ret = -ENOSYS;
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
