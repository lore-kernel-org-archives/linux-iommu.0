Return-Path: <SRS0=1qmC=NX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B238FC432BE
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 08:59:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456AC61057
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 08:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 456AC61057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18DBF80CA6;
	Wed,  1 Sep 2021 08:59:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MK4EoFybNqiH; Wed,  1 Sep 2021 08:59:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E00B380C96;
	Wed,  1 Sep 2021 08:59:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB5F3C0010;
	Wed,  1 Sep 2021 08:59:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08A5EC000E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 08:59:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB8856061C
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 08:59:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=samsung.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IXr-4OxKlgKo for <iommu@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 08:59:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D9E760618
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 08:59:42 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20210901085938euoutp01ba97c59eb0794425eaa942b67f2c0f03~gpxYSSxGh0723807238euoutp01P
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 08:59:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20210901085938euoutp01ba97c59eb0794425eaa942b67f2c0f03~gpxYSSxGh0723807238euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1630486778;
 bh=/1GWJyf9MK6LNUf7rLIeoa/dSMUhJddwZqa7qTr55GY=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=d/HQmSx/H9hCQ0lgBqo2maeB6ZIi1anAVuZKyjfssxFM5h4Qh2kxgVPSo4lqBsIpq
 5T4NZ6FqF0kNGUnkNkKeBMSUrpupsjeQm2HmBgXWuY3iQOke/h5hrK0aOsXPTOVMeg
 ZBYu/h8/PITwkXrr+Dln/xY/1VA9WbPVN0+UHjNM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210901085938eucas1p19514e1a426e8cba3cec1948e1ae66667~gpxX_wevz1196611966eucas1p1P;
 Wed,  1 Sep 2021 08:59:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 11.89.42068.9F04F216; Wed,  1
 Sep 2021 09:59:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20210901085937eucas1p2d02da65cac797706ca3a10b8a2eb8ba2~gpxXezz5H1730917309eucas1p25;
 Wed,  1 Sep 2021 08:59:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210901085937eusmtrp2c07fabf822921f71f6623492e0635ca4~gpxXd7y330123601236eusmtrp2P;
 Wed,  1 Sep 2021 08:59:37 +0000 (GMT)
X-AuditID: cbfec7f4-c71ff7000002a454-2e-612f40f929c8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.72.20981.9F04F216; Wed,  1
 Sep 2021 09:59:37 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210901085936eusmtip18900cbf99202977ada04e8db3280ec0c~gpxWrEZrL3209732097eusmtip1z;
 Wed,  1 Sep 2021 08:59:36 +0000 (GMT)
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating
 PCI devices
To: Wang Xingang <wangxingang5@huawei.com>, robh@kernel.org,
 will@kernel.org, joro@8bytes.org, helgaas@kernel.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <01314d70-41e6-70f9-e496-84091948701a@samsung.com>
Date: Wed, 1 Sep 2021 10:59:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djPc7o/HfQTDd5PtrRoXryezeLVmbVs
 Fgv2W1t0zt7AbrHp8TVWi8u75rBZnJ13nM2ide8Rdov/e3awWxz88ITVYt7NdewWLXdMLXYs
 ncnuwOvx5OA8Jo8189YwerQcecvqsWlVJ5vH/rlr2D02L6n3mHxjOaPH501yARxRXDYpqTmZ
 ZalF+nYJXBnnj5xjLFglXHHh3Cv2BsYT/F2MnBwSAiYSp743MnUxcnEICaxglJi7p4sdwvnC
 KDF/430o5zOjRH/TRmaYlg3XuxghEssZJaZ+bGMBSQgJfGSUaOwKA7GFBSIklrxvB4uLCBRL
 NG39C2YzCyxgkpjYDVbDJmAo0fW2iw3E5hWwk3i9/haYzSKgInF/016welGBZImJTyaxQtQI
 Spyc+QQszingIbH0wVKomfIS29/OYYawxSVuPZkP9o+EwGxOiYXXtzNBXO0i8WjyC6gPhCVe
 Hd/CDmHLSPzfCdPQzCjx8Nxadginh1HictMMRogqa4k7534BnccBtEJTYv0ufYiwo8SaGdtY
 QcISAnwSN94KQhzBJzFp23RmiDCvREebEES1msSs4+vg1h68cIl5AqPSLCSvzULyziwk78xC
 2LuAkWUVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYGI7/e/4lx2My1991DvEyMTBeIhR
 goNZSYSX9aFeohBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHepC1r4oUE0hNLUrNTUwtSi2CyTByc
 Ug1MBmfuRlxccu7dB26BrKTboUKl5+vDeIvlvsdvTmWell7tqOry6TnLX47tclIXw7Lvbjy6
 Ktx7t8XbaFu+VQd5qr6dX+5uNqVJ4FPg3zWyyxTV/Kd4rY1M5qtzUNA149/h8H9Z8pGGPCk2
 49S2Cau73K5qzJUOmiDLcbXz45zdy9qjmR9uEjJmtEqrNLCa9v0O7+aS3pTeND/vvHSNJcdW
 Luf9zbttuTDrtOl9rV9XcX016eK2DmbZu2mpwbL7Aj7n7Z+bb/z/8HLWF9HzYWcvCJR4TvKa
 cy63fAqbsc6C/usHQvMfvSqTDFm94GMww4eqn28Lz7maftwo/pK94oPxM+eVS0qdmC/lqzxg
 tU9RYinOSDTUYi4qTgQAOWa029sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xu7o/HfQTDbbeE7JoXryezeLVmbVs
 Fgv2W1t0zt7AbrHp8TVWi8u75rBZnJ13nM2ide8Rdov/e3awWxz88ITVYt7NdewWLXdMLXYs
 ncnuwOvx5OA8Jo8189YwerQcecvqsWlVJ5vH/rlr2D02L6n3mHxjOaPH501yARxRejZF+aUl
 qQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnnj5xjLFglXHHh
 3Cv2BsYT/F2MnBwSAiYSG653MXYxcnEICSxllJi67wcrREJG4uS0BihbWOLPtS42iKL3jBLX
 mp8xgSSEBSIkNr74wwJiiwgUS7x+NIMVpIhZYAGTRM/ar4wgCSEBd4klnz+CTWITMJToegsy
 iZODV8BO4vX6W2A2i4CKxP1Ne8EGiQokS3w4vZQVokZQ4uTMJ2BxTgEPiaUPloLZzAJmEvM2
 P2SGsOUltr+dA2WLS9x6Mp9pAqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucVGesWJucWl
 eel6yfm5mxiBsbzt2M8tOxhXvvqod4iRiYPxEKMEB7OSCC/rQ71EId6UxMqq1KL8+KLSnNTi
 Q4ymQP9MZJYSTc4HJpO8knhDMwNTQxMzSwNTSzNjJXFekyNr4oUE0hNLUrNTUwtSi2D6mDg4
 pRqY9qrdDD/wL/l0peLHH1+SKo7k9t50rGKYOnuXZFF+YeRWVvaKdZc3TjO7Guv+YP0bft83
 S3pMOxfri/nxOW3m1XP8yM4w9dZbVfZK6e3CcdvS9LX2x4q0soRGh3WXireoWvz/GRO5Vnxq
 jkCdQuoyD/vOW4t1pbuyPJ+tU1PUt5/510xKe/6W60ytD4qyd3We49jXFl11jmHn8W1sRxIX
 PphlfPDKlVuTZKQ/e/sxbUr8WdOc5fbR5bZI77LYOOGMZ+4dxusKzHwaWVOlPG2U9mRILVU7
 v3/qlXevqzLep8xxudC0n9/5Rk/ef4V9Xfv2pLM8493/KOzKnl3V9m/0pKY0buI5fsLzzrSX
 1kxKLMUZiYZazEXFiQCB4iyHbgMAAA==
X-CMS-MailID: 20210901085937eucas1p2d02da65cac797706ca3a10b8a2eb8ba2
X-Msg-Generator: CA
X-RootMTR: 20210901085937eucas1p2d02da65cac797706ca3a10b8a2eb8ba2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210901085937eucas1p2d02da65cac797706ca3a10b8a2eb8ba2
References: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
 <CGME20210901085937eucas1p2d02da65cac797706ca3a10b8a2eb8ba2@eucas1p2.samsung.com>
Cc: xieyingtai@huawei.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-pci@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On 21.05.2021 05:03, Wang Xingang wrote:
> From: Xingang Wang <wangxingang5@huawei.com>
>
> When booting with devicetree, the pci_request_acs() is called after the
> enumeration and initialization of PCI devices, thus the ACS is not
> enabled. And ACS should be enabled when IOMMU is detected for the
> PCI host bridge, so add check for IOMMU before probe of PCI host and call
> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
> devices.
>
> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
> configuring IOMMU linkage")
> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>

This patch landed in linux-next as commit 57a4ab1584e6 ("iommu/of: Fix 
pci_request_acs() before enumerating PCI devices"). Sadly it breaks PCI 
operation on ARM Juno R1 board (arch/arm64/boot/dts/arm/juno-r1.dts). It 
looks that the IOMMU controller is not probed for some reasons:

# cat /sys/kernel/debug/devices_deferred
2b600000.iommu

Reverting this patch on top of current linux-next fixes this issue. If 
you need more information to debug this issue, just let me know.

> ---
>   drivers/iommu/of_iommu.c | 1 -
>   drivers/pci/of.c         | 8 +++++++-
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index a9d2df001149..54a14da242cc 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>   			.np = master_np,
>   		};
>   
> -		pci_request_acs();
>   		err = pci_for_each_dma_alias(to_pci_dev(dev),
>   					     of_pci_iommu_init, &info);
>   	} else {
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index da5b414d585a..2313c3f848b0 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -581,9 +581,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>   
>   int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>   {
> -	if (!dev->of_node)
> +	struct device_node *node = dev->of_node;
> +
> +	if (!node)
>   		return 0;
>   
> +	/* Detect IOMMU and make sure ACS will be enabled */
> +	if (of_property_read_bool(node, "iommu-map"))
> +		pci_request_acs();
> +
>   	bridge->swizzle_irq = pci_common_swizzle;
>   	bridge->map_irq = of_irq_parse_and_map_pci;
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
