Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8BDC43463
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 15:28:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D186238D6
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 15:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fBSvv4lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D186238D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1D04B8740C;
	Fri, 18 Sep 2020 15:28:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GnTF7SGhipnk; Fri, 18 Sep 2020 15:28:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1D7B3873E9;
	Fri, 18 Sep 2020 15:28:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01D0BC0859;
	Fri, 18 Sep 2020 15:28:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15A9BC0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 15:28:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DF58887852
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 15:28:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k0gwZxmDhaTe for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 15:28:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 189FC8783F
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 15:27:59 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200918152758euoutp0214fa4d9015d50bd45e4daeb00b05de14~16lFyEsGS1899118991euoutp02L
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 15:27:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200918152758euoutp0214fa4d9015d50bd45e4daeb00b05de14~16lFyEsGS1899118991euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1600442878;
 bh=7q9X4ht4qg068rhMEDk1IiNVl8/FCQE3QBqkeITjINg=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=fBSvv4lc4JCkZitGCS7vdIUeJ44i2IUFD50Ef0+x8erXllOg/Skj2qeSNVMsIGQ1V
 VbxyL8cVa1M+xU90Rw0DbCiFz61seZpumK8Qv90y0mUnxb3yKfO8y37kgVWjFhh/Yq
 Qie6L1RE+gC3aqEXrN7iZ2u9qPkTkGXJyvV/itE4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200918152757eucas1p2caaa036bd15c31b1a9af65e0be48240d~16lFmJ4pF0966909669eucas1p2k;
 Fri, 18 Sep 2020 15:27:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 75.36.06318.DF1D46F5; Fri, 18
 Sep 2020 16:27:57 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200918152757eucas1p282c4f6b559ed7df4d44e219828be29b1~16lFTbObG0966909669eucas1p2j;
 Fri, 18 Sep 2020 15:27:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200918152757eusmtrp1b91f716957e263bf509cd6d2efee5f35~16lFS0cAX1120811208eusmtrp17;
 Fri, 18 Sep 2020 15:27:57 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-e5-5f64d1fd06a5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id C8.62.06314.DF1D46F5; Fri, 18
 Sep 2020 16:27:57 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200918152757eusmtip14cf039ee57707354f7eff0dbd19456a6~16lExQzil0520505205eusmtip1I;
 Fri, 18 Sep 2020 15:27:56 +0000 (GMT)
Subject: Re: [PATCH] iommu/exynos: add missing put_device() call in
 exynos_iommu_of_xlate()
To: Yu Kuai <yukuai3@huawei.com>, joro@8bytes.org, kgene@kernel.org,
 krzk@kernel.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <9f5b25ee-3dad-1798-fe55-9c1af9cde513@samsung.com>
Date: Fri, 18 Sep 2020 17:27:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918011335.909141-1-yukuai3@huawei.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djP87p/L6bEGzQtN7VYsN/aonP2BnaL
 /sevmS3OnweyNj2+xmpxedccNosZ5/cxWVx7d4bNYs5CNgdOjycH5zF5tBx5y+qxaVUnm8fm
 JfUek28sZ/T4vEkugC2KyyYlNSezLLVI3y6BK+Nrt3bBda6K1W+MGhiPc3QxcnJICJhIdN9f
 z9LFyMUhJLCCUWLlzGWsEM4XRonLn6awQzifGSWeTP3BCNOy5ccZRojEckaJF017mCGc94wS
 lyb2MYNUCQvESuy69xesQ0QgTGLahi9gc5kFljBKzJqzkR0kwSZgKNH1tosNxOYVsJOYsu8S
 mM0ioCqx+el2sEGiAnESx049YoGoEZQ4OfMJkM3BwSlgKfH+dCBImFlAXmL72znMELa4xK0n
 85kgLt3HLvH2gTOE7SIx+88TZghbWOLV8S3sELaMxOnJPeAAkBBoZpR4eG4tO4TTAwyAphlQ
 P1tL3Dn3iw1kMbOApsT6XfoQYUeJA9uawe6REOCTuPFWEOIGPolJ26YzQ4R5JTrahCCq1SRm
 HV8Ht/bghUvMExiVZiF5bBaSb2Yh+WYWwt4FjCyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLz
 czcxAhPT6X/Hv+5g3Pcn6RCjAAejEg/vi3kp8UKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxK
 LcqPLyrNSS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJg1OqgdHlQjXD86gzvicd5PzO
 VXW1ijdc/j0p7YH+hNcSsjtt/iWZMdvuOXnh5fZoRi9Xv2VaBwv2KdtYFYpNKn3zxTzvf/CK
 m0vXXOZrfNw++dnqH/fqcu12TmlouW7i0ipqsi/h5bdFR3yD841XrNzL2fld5HVdyGY9YdlX
 2vkl3/4siHQ4ffHyxK1KLMUZiYZazEXFiQC421h7SAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7p/L6bEG1y7q2yxYL+1RefsDewW
 /Y9fM1ucPw9kbXp8jdXi8q45bBYzzu9jsrj27gybxZyFbA6cHk8OzmPyaDnyltVj06pONo/N
 S+o9Jt9YzujxeZNcAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1K
 ak5mWWqRvl2CXsbXbu2C61wVq98YNTAe5+hi5OSQEDCR2PLjDGMXIxeHkMBSRol/m3pZIRIy
 EienNUDZwhJ/rnWxQRS9ZZS40zWbGSQhLBArseveX6BuDg4RgTCJlRuyQGqYBZYwSuw+sIEV
 oqEHyJm1kQ2kgU3AUKLrbReYzStgJzFl3yUwm0VAVWLz0+1gQ0UF4iTO9LyAqhGUODnzCQvI
 Ak4BS4n3pwNBwswCZhLzNj9khrDlJba/nQNli0vcejKfaQKj0Cwk3bOQtMxC0jILScsCRpZV
 jCKppcW56bnFhnrFibnFpXnpesn5uZsYgZG47djPzTsYL20MPsQowMGoxMP7Yl5KvBBrYllx
 Ze4hRgkOZiURXqezp+OEeFMSK6tSi/Lji0pzUosPMZoC/TaRWUo0OR+YJPJK4g1NDc0tLA3N
 jc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTBOXt0+syf7zXkRFY3eWY+8Dv88ZdBk
 aF6ucDPgZIpvWINo8Zlkvj4x2TupDHVqZZM15R0+dc1uKOdjzlx3QG7905y1s03vlgR+E31x
 sGGF7kqNk7lS9V+YzdaJ7vn8m2fvQoF+j73S7Nn/05nuec34GTH5Wt8k6T6t4+qXvivsnuTB
 EmbV56jEUpyRaKjFXFScCAAYuaPQ2gIAAA==
X-CMS-MailID: 20200918152757eucas1p282c4f6b559ed7df4d44e219828be29b1
X-Msg-Generator: CA
X-RootMTR: 20200918011240eucas1p1e16e5b1b11a4ea6c078ffeceaf554966
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200918011240eucas1p1e16e5b1b11a4ea6c078ffeceaf554966
References: <CGME20200918011240eucas1p1e16e5b1b11a4ea6c078ffeceaf554966@eucas1p1.samsung.com>
 <20200918011335.909141-1-yukuai3@huawei.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 yi.zhang@huawei.com
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

Hi

On 18.09.2020 03:13, Yu Kuai wrote:
> if of_find_device_by_node() succeed, exynos_iommu_of_xlate() doesn't have
> a corresponding put_device(). Thus add put_device() to fix the exception
> handling for this function implementation.
>
> Fixes: aa759fd376fb ("iommu/exynos: Add callback for initializing devices from device tree")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Thanks for the fix!

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/iommu/exynos-iommu.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index bad3c0ce10cb..de324b4eedfe 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1295,13 +1295,17 @@ static int exynos_iommu_of_xlate(struct device *dev,
>   		return -ENODEV;
>   
>   	data = platform_get_drvdata(sysmmu);
> -	if (!data)
> +	if (!data) {
> +		put_device(&sysmmu->dev);
>   		return -ENODEV;
> +	}
>   
>   	if (!owner) {
>   		owner = kzalloc(sizeof(*owner), GFP_KERNEL);
> -		if (!owner)
> +		if (!owner) {
> +			put_device(&sysmmu->dev);
>   			return -ENOMEM;
> +		}
>   
>   		INIT_LIST_HEAD(&owner->controllers);
>   		mutex_init(&owner->rpm_lock);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
