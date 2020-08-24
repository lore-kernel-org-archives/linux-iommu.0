Return-Path: <SRS0=rIde=CC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F53C433E3
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 11:41:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DD0214F1
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 11:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KLAl8/rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DD0214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 29E10200E5;
	Mon, 24 Aug 2020 11:41:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jFAQE+PsXDJ2; Mon, 24 Aug 2020 11:40:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DE1E520031;
	Mon, 24 Aug 2020 11:40:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1907C07FF;
	Mon, 24 Aug 2020 11:40:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D3CFC0051
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 11:40:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6196B85FCB
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 11:40:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F7bC2sSeLyc9 for <iommu@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 11:40:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8540585F94
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 11:40:53 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200824114050euoutp02cb38dac2c4a062a1aa377945555caae1~uMWpk0RYL1948819488euoutp02t
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 11:40:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200824114050euoutp02cb38dac2c4a062a1aa377945555caae1~uMWpk0RYL1948819488euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1598269250;
 bh=ba4YL16aB6a2EgaaQucW8uhtGVOy2S8TT7bz8yWdugc=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=KLAl8/rj3via+ICyNo0UrZsfOePBv8yAnKLfFFNZkRLpi1AUovjtx1hj+gFec6B+F
 Uw0S26HFxG8sI6Xskt//PtxLlFnriEo6WuSpR09wfCWN7QsPgwc/brB4gFx9cblYxC
 4OyoWvO9wtyzaoJmBtjXOxcqRSp+SCHpjVL+Gz/g=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200824114050eucas1p22a241e6d641aab84d27b1ef438e39c3f~uMWpJBJnF2495524955eucas1p2m;
 Mon, 24 Aug 2020 11:40:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 2E.25.05997.247A34F5; Mon, 24
 Aug 2020 12:40:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200824114049eucas1p13aea77bc609874909fed72db8f8b9cc5~uMWok_7LR0700207002eucas1p10;
 Mon, 24 Aug 2020 11:40:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200824114049eusmtrp164506cbb2e6fd6c17cfe4ae606e3d8f6~uMWokBqNW1930519305eusmtrp18;
 Mon, 24 Aug 2020 11:40:49 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-cd-5f43a742d9db
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 2A.FE.06017.147A34F5; Mon, 24
 Aug 2020 12:40:49 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200824114048eusmtip189507904f024364f3e302a180a26ef55~uMWnEiCIc2041620416eusmtip1J;
 Mon, 24 Aug 2020 11:40:48 +0000 (GMT)
Subject: Re: [PATCH 00/18] Convert arch/arm to use iommu-dma
To: Robin Murphy <robin.murphy@arm.com>, hch@lst.de, joro@8bytes.org,
 linux@armlinux.org.uk
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <bf32cdea-ee5b-1431-3b97-c0889acdacc6@samsung.com>
Date: Mon, 24 Aug 2020 13:40:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1597931875.git.robin.murphy@arm.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTZxjNe+/b29u66qVAeOLMTKoucYsyhiaviB+oPy7RH+qyhJgo6+QG
 DB+aVhT8obVUUwoitBKxxWK0BgdYCSCwDqhUS6OkIKIVFYIKumFERDGRauZorzr+nec557zn
 OcnL0so+Zj67J2e/oMlRZ6kYOW7umu5dtqF6Y+pPZouC9Ix8wKTb/QqT2skRRO6+m2DIWZsZ
 kT9qvRQxD5dics69mhis5zEptNVLiV//UkoKyxxS0jASkJAyt19K+l2VDCmuvyoh/QV9iFT0
 dlCkcMrKEE95OyKPa8cZojfEk87XoxLSHuyQkArLGEMcz4wMmXbZMSlp304MgyvJsLkRr/+O
 H+20U3ydvQ7x/YE+mi/zL+P/tA5JeZvxjIRvqClk+MFAG8MPF/kovtFxhLcMVCP+rwc6hjfc
 dGP+RMErhi9pqkG8b6CF2hqxQ56YJmTtOSBoYtf+Js9wX39A7TNE5XlL4nToLGdCMha4FfDO
 9gabkJxVcpcQ3PB2UOIwhaBg4thn5i2C+/90Ml8srheVEpGoRvB8rOjzMIGg6eEtKqSK5BLB
 2/c3HcJR3E4Itn6UhkQ01yYBnXkYhwiGiwPTuCn8rIJbC5/8z1AIY24JOI8+DpujuV1w1XeP
 EjURcPPMaNgr4wgM9kyGMc0thJbxSlrEMfBwtCpcArgqGbx2BGnx7k1Qe2kKizgSXviapCJe
 AN2WYiwaChA86bksFYdiBP36CiSqVs/EBWdOZWcilsIVV6y4TgLvUFt4DdxcGBiPEI+YC+bm
 07S4VoDxuFJUfw9Wn/NrbOftO3QpUllnVbPOqmOdVcf6f+45hGtQjJCrzU4XtD/nCAeXa9XZ
 2tyc9OW792Y3oJmP3v2vb6oVuT7+7kEci1TfKN571qUqJeoD2vxsDwKWVkUpNvi7dykVaer8
 Q4Jmb6omN0vQetC3LFbFKOLPj+1Ucunq/UKmIOwTNF9YipXN16HE9PpgXnxK5q3mDF1R/uno
 4Dpn1jxZS8K2wK+O66d+TLavMToXX3iTNNmkwAknUlKuRUeWP5Lnrm9ddfHYo5f2tJOZeQnJ
 8+oG3UweozPp50QcKTfaPmx2Hr5WarIUbVmUjJPuxfyiPzQZO625/bS08Ulg6GiXxq/+9Pzw
 wd6uQJIKazPUcT/QGq36P1600WDkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0xTWRSGs8+txdh4bFE3ZKKmBjRGiqdYWTgM6mjIeVBjrHHG8YJHPSlG
 Sk1PMeporNIHWoWhEA0WrDe04SLpgMKIQIciImIxBENEIaitMRqLOlEjOkGBasLbl/3/315Z
 yZKTymd0rHxPtkU0ZwtZamYK1TXaMZiw0rMqY/GN0gXQHfxCQZdvmIKqd0EEDz68YeBsaRGC
 iqp2AoqGCik47/sZbK6LFNhLvTIIHH8tA7uzXAa1wT4anL6ADHobyxg46b1OQ29uD4KS+y0E
 2N+7GPCfakbwpCrMwHFbErS+DdHQ/LmFhpLilwyUP89jYKTRTUFB8wawDehgqKiOWjGbD7W6
 Cb7aXY343r4ekncGEvgbrkEZX5p3huZrK+0MP9DXxPBDJzoIvq78KF/80IP4m/1Whrd1+ig+
 P3eY4QuuVSK+42EDsX76H5pUsynHIs7NNEmWX9RbONBquBTQaJekaLik5G3LtDp1YlrqbjFr
 z37RnJi2Q5Ppa+sn9tmiD7QXcFZ0lnWgKDlml+DGV2W0A02RK9nLCHv/vkpEgp9w52krHWEV
 /r/PwURKYYRHa/6lxgMVm4rbe16Q4xzNbsPvPVXMOJNsE40vh2MjwgmEB+/a0HjAsBx2hB0T
 JQWbhr8Gnk+8U2wcrjn2ZOKjGex2HMz/SkY603HnmdDEsCgW8ED3OyoyYCl21z0lIzwHN4TL
 vvMs/Ch0jihEStck3TVJcU1SXJOU84iqRNFijmQ0GCWtRhKMUk62QbPLZKxFY/dVf3vk2j/I
 Maz3I1aO1FMVn/zLM5S0sF86aPQjLCfV0YpfA13blYrdwsFDotmUYc7JEiU/0o0t5yRjZ+wy
 jV1rtiWD03HJkMIlJyUnLQX1LEUe27pVyRoEi7hXFPeJ5h8eIY+KtaLa0JHC9Hq9p2XTxq3C
 zPSY4BG9HA7HXInbHN8W415lcspu/rfuBcy7Uxd3UbtW2bawJGGntfrkomfOR4nejyvnT9Ov
 LjoMHTohX1+/tyX9nuHP1DXF1F+HVPaK0fAFqPH0L172OP63pks74k9fmDliaPJefXmrW1X9
 e1aFWpXekKumpEyBW0iaJeEbK502LHUDAAA=
X-CMS-MailID: 20200824114049eucas1p13aea77bc609874909fed72db8f8b9cc5
X-Msg-Generator: CA
X-RootMTR: 20200820150857eucas1p18f5f2ad87703a68b6ed20a090f7c1c57
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200820150857eucas1p18f5f2ad87703a68b6ed20a090f7c1c57
References: <CGME20200820150857eucas1p18f5f2ad87703a68b6ed20a090f7c1c57@eucas1p1.samsung.com>
 <cover.1597931875.git.robin.murphy@arm.com>
Cc: geert+renesas@glider.be, dri-devel@lists.freedesktop.org,
 matthias.bgg@gmail.com, thierry.reding@gmail.com,
 laurent.pinchart@ideasonboard.com, digetx@gmail.com, will@kernel.org,
 linux-samsung-soc@vger.kernel.org, magnus.damm@gmail.com,
 kyungmin.park@samsung.com, jonathanh@nvidia.com, agross@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 inki.dae@samsung.com, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 sw0312.kim@samsung.com, linux-kernel@vger.kernel.org, t-kristo@ti.com,
 iommu@lists.linux-foundation.org
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

On 20.08.2020 17:08, Robin Murphy wrote:
> Hi all,
>
> After 5 years or so of intending to get round to this, finally the
> time comes! The changes themselves actualy turn out to be relatively
> mechanical; the bigger concern appears to be how to get everything
> merged across about 5 diffferent trees given the dependencies.
>
> I've lightly boot-tested things on Rockchip RK3288 and Exynos 4412
> (Odroid-U3), to the degree that their display drivers should be using
> IOMMU-backed buffers and don't explode (the Odroid doesn't manage to
> send a working HDMI signal to the one monitor I have that it actually
> detects, but that's a pre-existing condition...) Confirmation that the
> Mediatek, OMAP and Tegra changes work will be most welcome.
>
> Patches are based on 5.9-rc1, branch available here:
>
>    git://linux-arm.org/linux-rm arm/dma

Well, my first proposal for the ARM and ARM64 DMA-mapping unification 
has been posted long time ago: https://lkml.org/lkml/2016/2/19/79

Thanks for resurrecting it! :)

I've tested this patchset on various ARM32bit Exynos based boards (not 
only Exynos4412) and most of them works fine after your conversion. 
However there are issues you cannot learn from the code.

Conversion of the Exynos DRM was straightforward (thanks!), but there 
are other Exynos drivers that depends on the old ARM implementation. The 
S5P-MFC (only for the v5 hardware) and Exynos4 FIMC-ISP drivers depends 
on the first-fit IOVA allocation algorithm in the old ARM DMA-mapping. 
This was the main reason I've didn't continue my initial conversion attempt.

Both drivers allocate a buffer for their firmware and then in the 
hardware registers address video buffers as an offset from the 
begginning of the firmware. This doesn't work when underlying 
DMA-mapping allocates IOVA with the last-fit algorithm, what the 
drivers/iommu/dma-iommu.c does. So far I didn't find a good solution for 
that issue.

I'm open for suggestions. One more limitation for the S5P-MFC driver is 
that the hardware is capable only for addressing 128MiB. They will 
probably need to call IOMMU API directly, but I would like to keep as 
much from the IOMMU/DMA-mapping code as possible.


Anyway, we need to move ARM 32bit forward, so for the ARM DMA-mapping 
and Exynos DRM changes, feel free to add:

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
