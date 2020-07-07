Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62F2C433E1
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 15:04:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965B7206E2
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 15:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="juPMhYDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965B7206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5A8F927BB6;
	Tue,  7 Jul 2020 15:04:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AFWCnPW9oSdz; Tue,  7 Jul 2020 15:04:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 40CCD2353A;
	Tue,  7 Jul 2020 15:04:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C0ADC0893;
	Tue,  7 Jul 2020 15:04:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62E7FC016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 15:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5F1FF87C0D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 15:04:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lb+UZWsGyEbz for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 15:04:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9407E8696A
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 15:04:40 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200707150438euoutp02a7b60af7071be9a1c6a83a6d304fb646~fgK4sqclk0055000550euoutp02O
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 15:04:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200707150438euoutp02a7b60af7071be9a1c6a83a6d304fb646~fgK4sqclk0055000550euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1594134278;
 bh=FTWBgSiQtF0ed1VCSck4DM2K0jkOrJ4+MQW7TYZuyB0=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=juPMhYDQHFTkyTJ/BvUhMvGn8NbPIpEPi9sycWWyv7K3YIFsKwd64bIGPupJBD3y5
 D45HdXR6PzKyBE2TMMwSTjumpzlNXFYkZonCpXQ0c0szpoRFj7y+i8+XFZTTZLsYeZ
 7PNatz/Bm++6KQaA16mR3zS02znbFyczawMmpJRk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200707150438eucas1p2318735a3509334865cbbeacaef3acbed~fgK4Ti_H31374913749eucas1p2h;
 Tue,  7 Jul 2020 15:04:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id A5.C4.06456.60F840F5; Tue,  7
 Jul 2020 16:04:38 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200707150437eucas1p2c085b63bad068a32748d149579e67dbe~fgK4A9Kve1373413734eucas1p2k;
 Tue,  7 Jul 2020 15:04:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200707150437eusmtrp2a81281ea1ec00732187da092a41d35c0~fgK4APMao1541015410eusmtrp2N;
 Tue,  7 Jul 2020 15:04:37 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-bd-5f048f06c387
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 79.59.06017.50F840F5; Tue,  7
 Jul 2020 16:04:37 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200707150436eusmtip20f381b51ddf04859b0b2a43db4fd1802~fgK2rCApt1489614896eusmtip2O;
 Tue,  7 Jul 2020 15:04:36 +0000 (GMT)
Subject: Re: [PATCH v7 07/36] drm: exynos: use common helper for a
 scatterlist contiguity check
From: Andrzej Hajda <a.hajda@samsung.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Message-ID: <1618dbcb-f17c-3713-2c98-487802f9d409@samsung.com>
Date: Tue, 7 Jul 2020 17:04:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8e25b060-2901-6d8d-f5ee-9f7cc0f02b77@samsung.com>
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjuOzeP1uo4q71llI0I7eqoHyeMmdLlIAb1o34Yasc8OGlbtqOW
 9WNiUZZ0HdISKYlMTdfK2zRFadTERlpmoWVNsUwj6TJnmWRtnkn+e973fZ73eZ+Pj8bl3eRS
 Ol2fKRj0vFZJBRH1jonO9dQlIjly4ouMvdDRjrEPzFaS7fZ8pdiKyicYW9IaxY51D2Bs9eBr
 kn35sJhizZ0tGGt5/C6AffTtA8maTSPUtnlc1Y0qxNnG+0nOVdCGcTW3jdzbqUGcM/WUIa6p
 N5fiLtbeRZy7evmewISgramCNj1bMGxUHwzSfL64MqMPO37OtjgXFWPnUSANzGbIM1vI8yiI
 ljPlCLqcblwqxhBMjnwKkAo3AmtDacCMpGrIgaRBGYKB3ya/5KuXZflJ+lghDA8X2t9TPkwx
 EfCnpncaL2RqEZwq3OkT4EwhBoP1LbhvIGPU4KqbnLYgmFVwf+js9KJFTBJYR2yYxAmG9usf
 CB8OZKLhucWEfBhnVoBttBiXsALyxipI6VRPADjy4yW8HSpNrbiEQ+BzW60/zjL423jT/xpG
 cJWfnk4DTD6CuvuNfkEU9HX89iagvQYRYH24UWrHQM/UG+RrAzMfekaDpRPmw9X6a7jUlkH+
 GbnEXgmuZ3X+hQoofe6hLiNl0axgRbPCFM0KU/TftwQRd5FCyBJ1aYKo0gvHNoi8TszSp204
 dERXjbx/zTnV9qMBebpS7IihkXKeTMMTyXKSzxZzdHYENK5cKIt95kySy1L5nBOC4UiyIUsr
 iHYUShNKhWzTrZFEOZPGZwqHBSFDMMxMMTpwaS7K6wt3RjT3400WY6WRfBX9q3l/Z6g77IXZ
 Er9OkelQN8XFWDISWtJSkraJJ+0fsz/e+9OlWrs/fFdN203b097I1TVzC05axx3slajdRxUF
 HUKCZkFOYmppWVgXqHckkwdM2n0HdXvr23eNEodit8w5lzM8LH53Ti5Rxd053P/DqCREDa9a
 gxtE/h8gdCgWZwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xe7qs/SzxBtdbjSx6z51kstg4Yz2r
 xZWv79ksVq4+ymSxYL+1xZcrD5ksNj2+xmpxedccNosZ5/cxWaw9cpfd4uCHJ6wWMya/ZHPg
 8Vgzbw2jx/ZvD1g97ncfZ/LYvKTe4/a/x8wek28sZ/TYfbOBzaNvyypGj8+b5AI4o/RsivJL
 S1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyXvUpFtxhqujc
 LtbAOIepi5GTQ0LARGLNs2OMXYxcHEICSxklOta/ZYZIiEvsng9jC0v8udbFBmILCbxllHi8
 tAzEFhZIlJh98zzYIDYBTYm/m2+ygQwSEdjCKPFsxWGwqcwC05kkbnb9YIVY8YtR4v2p02Bj
 eQXsJO5v/c0OYrMIqEhseNbOCmKLCsRJLN8ynx2iRlDi5MwnLCA2p4C9xIW1kxlBbGYBM4l5
 mx8yQ9jyEtvfzoGyxSWavqxkncAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xkV5xYm5x
 aV66XnJ+7iZGYCxvO/Zzyw7GrnfBhxgFOBiVeHgzElnihVgTy4orcw8xSnAwK4nwOp09HSfE
 m5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cA0k1cSb2hqaG5haWhubG5sZqEkztshcDBGSCA9
 sSQ1OzW1ILUIpo+Jg1OqgTHr1ruVyxr+Cy51qV5jEvvraQ7XT8dFyQaP2F5Y3Ymq6X1couun
 r7jhcdGza7qMf90312Qv3fA6fFWca2IOQ8jjexc2Ld+x95rS29RTaT8TrG3DHG7q3v+p01X/
 hjPGcJFQ98zoW/vedvzNKA9cstKikV+H4dy9u2kb67RZHu0SjiiYvm3mhXtKLMUZiYZazEXF
 iQCoWcUo+wIAAA==
X-CMS-MailID: 20200707150437eucas1p2c085b63bad068a32748d149579e67dbe
X-Msg-Generator: CA
X-RootMTR: 20200619103657eucas1p24bff92408adbd4715130fb47595a6187
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103657eucas1p24bff92408adbd4715130fb47595a6187
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
 <CGME20200619103657eucas1p24bff92408adbd4715130fb47595a6187@eucas1p2.samsung.com>
 <20200619103636.11974-8-m.szyprowski@samsung.com>
 <8e25b060-2901-6d8d-f5ee-9f7cc0f02b77@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


On 07.07.2020 11:35, Andrzej Hajda wrote:
> Hi,
>
> On 19.06.2020 12:36, Marek Szyprowski wrote:
>> Use common helper for checking the contiguity of the imported dma-buf.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Just fixing my signature :)

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Regards
Andrzej

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
