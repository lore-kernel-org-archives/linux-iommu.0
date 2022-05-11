Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58ACC433EF
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 03:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74FB560BCA;
	Thu, 12 May 2022 03:39:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2jZYFT0WJ7J5; Thu, 12 May 2022 03:39:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4635D60784;
	Thu, 12 May 2022 03:39:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DE71C0032;
	Thu, 12 May 2022 03:39:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24886C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F19E560BCA
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HKMgIigPxYJg for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:39:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E4EA60784
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:14 +0000 (UTC)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20220512033911epoutp04e49341cd8977754c5af1a050bab16024~uPmz6Wdjg0644806448epoutp04S
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20220512033911epoutp04e49341cd8977754c5af1a050bab16024~uPmz6Wdjg0644806448epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1652326751;
 bh=/xvg08mm/FdFaeSMWR962Fm009CzGXkQON5XmH+sZS0=;
 h=From:To:Cc:Subject:Date:References:From;
 b=IVwH/Ub+MSSCEE2ScLiWUVqdp7jx0v6/ILq0ViuzrenYnBBlzNmJEvMBzImwi+w0L
 HsiDIoWKWheOs9FJKMETzKRiI9I5mZUYtAUF5yJ4nIyDrcr11/wE8BS/mCqUKk90GY
 0VkvGSou9gTiqDDwoftdfkdllZoRltA5/+yNBxyU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20220512033909epcas5p2e304c55788557dbc1da7cf9df8346359~uPmy6FGiG2890628906epcas5p26;
 Thu, 12 May 2022 03:39:09 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4KzHZK3gKWz4x9QC; Thu, 12 May
 2022 03:39:05 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 3C.51.10063.9518C726; Thu, 12 May 2022 12:39:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20220511121425epcas5p256b55554b32dc58566827818a817ac44~uC-YgTXlW1315313153epcas5p2Y;
 Wed, 11 May 2022 12:14:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220511121425epsmtrp1b2d76ae860b697eecdb90578918f70d9~uC-YfZeFg0052800528epsmtrp1B;
 Wed, 11 May 2022 12:14:24 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-05-627c8159e2e5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D6.0F.11276.0A8AB726; Wed, 11 May 2022 21:14:24 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
 [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20220511121423epsmtip20cb722f047df63de8dd763a9bec56aee~uC-XD16sg0269902699epsmtip2_;
 Wed, 11 May 2022 12:14:23 +0000 (GMT)
From: Ajay Kumar <ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Subject: [PATCH V2 0/6] IOMMU-DMA - support DMA_ATTR_LOW_ADDRESS attribute
Date: Wed, 11 May 2022 17:45:38 +0530
Message-Id: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmhm5kY02SQcdKGYuvJ36zWRx4f5DF
 4sG8bWwWC/ZbW3TO3sBusenxNVaLRVu/sFsc/PCE1aLljqkDp8eTg/OYPNbMW8PosXPWXXaP
 Tas62Tw2L6n3mHxjOaNH35ZVjAHsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW
 5koKeYm5qbZKLj4Bum6ZOUCHKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0
 ihNzi0vz0vXyUkusDA0MjEyBChOyM2b0WhasFazomv+NtYHxHW8XIyeHhICJxLaVp5i7GLk4
 hAR2M0p8WbAZyvnEKHHyXx87hPONUeLZ8f1sXYwcYC3tfywh4nsZJa5eWs8E4bQwSWw6f4QV
 ZC6bgLbEtuk3WUBsEYEWRom50+xBbGaBKolbWyYygdjCAl4ScxZMYwaxWQRUJZ5/nMMIsoBX
 wEZi1+koiPPkJVZvOAB2kYTAKXaJw+/aWSCOcJE498UTokZY4tXxLewQtpTEy/42KLta4twt
 kJtBejsYJToeroNK2EscuDIHbA6zgKbE+l36EGFZiamn1jFBnMkn0fv7CRNEnFdixzwQG2St
 msTWFX4QYRmJMwevQJV4SJzcvRvsEyGBWIkTOy+xTWCUnYWwYAEj4ypGydSC4tz01GLTAsO8
 1HJ4LCXn525iBCc2Lc8djHcffNA7xMjEwXiIUYKDWUmEd39fRZIQb0piZVVqUX58UWlOavEh
 RlNgiE1klhJNzgem1rySeEMTSwMTMzMzE0tjM0Mlcd7T6RsShQTSE0tSs1NTC1KLYPqYODil
 Gph0X+72qQrvWCV+O+3YpPiD8xdw7gjd2qLx+IPPhBvW01ZPS477mWZXVhkotfX5lSv7rydn
 WoYdeLthi3Dmrkl/liid43J4d/bhX8N4u3055ZO5LPNZ/2WcEFfZ4r7uTWUD/+I59/+vZfjw
 R+aSR8gfdSONHB3+wynsC0WYZhiWzPjOPKkkrSnxy3vWb3zalSc8Fp4uFptzzcPrTEL9dwuF
 18dSJe+u3vvBOeZIoqRBwTnnRaE/fkitjohVW6sVO2FZ7/znW1uWKoqrTTtq3Lov39ncM3D/
 IsX1L3duMeC/+iEjbMWlpq0aD52E5jeGfVpxIcHRvUwlMOfANpsPD09tqDyw8/bm3As/M7Ts
 703LV2Ipzkg01GIuKk4EABA5rm/1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJXnfBiuokg51NJhZfT/xmszjw/iCL
 xYN529gsFuy3tuicvYHdYtPja6wWi7Z+Ybc4+OEJq0XLHVMHTo8nB+cxeayZt4bRY+esu+we
 m1Z1snlsXlLvMfnGckaPvi2rGAPYo7hsUlJzMstSi/TtErgyZvRaFqwVrOia/421gfEdbxcj
 B4eEgIlE+x/LLkYuDiGB3YwS7zsOsXUxcgLFZSSe73jKAmELS6z895wdoqiJSWLm2hNgRWwC
 2hLbpt9kAUmICHQxSly9upcVJMEsUCfxdup0RhBbWMBLYs6CacwgNouAqsTzj3MYQTbzCthI
 7DodBbFAXmL1hgPMExh5FjAyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECA4zLc0d
 jNtXfdA7xMjEwXiIUYKDWUmEd39fRZIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNIT
 S1KzU1MLUotgskwcnFINTFN9tpeVbJLV9g6+Pyml8F40+3apb9ZOaUHRr2IvbDduvWVW57p/
 rUf4FK2tgp0lV1escts3nT1re8+s172Wq2zXp9ickyi8wCeygu2mieUVBr63t3a9Zj0yY+aW
 eDbOtke6OtkXFwidCCyx5NyvPUm7sO2nTdz1Cy515uy3fVuN+KTz8+W9PS+Kxe76nJ+1yiAz
 1v/vLL2dNadfG82OYvmytTHX4rehq4mV8l33VDOXy6UPQk/++TLxUSrft2fbZpSyNR+e6KkX
 Z33N4PtEPmntlY/Fdh+r2r+lgu2EfVmcj1YF/wH9ZQ/YNv5/neDN516m9fFV+t4WzWjfDxPv
 nuNt2CvMfqg4d0HtE8EkJZbijERDLeai4kQAyODziaICAAA=
X-CMS-MailID: 20220511121425epcas5p256b55554b32dc58566827818a817ac44
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220511121425epcas5p256b55554b32dc58566827818a817ac44
References: <CGME20220511121425epcas5p256b55554b32dc58566827818a817ac44@epcas5p2.samsung.com>
Cc: pankaj.dubey@samsung.com, alim.akhtar@samsung.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This patchset is a rebase of original patches from Marek Szyprowski:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2321261.html

The patches have been rebased on Joro's IOMMU tree "next" branch:
https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git

This patchset is needed to address the IOVA address dependency issue between
firmware buffers and other buffers in Samsung s5p-mfc driver.

There have been few discussions in the past on how to find a generic
soultion for this issue, ranging from adding an entirely new API to choose
IOVA window[1], to adding a DMA attribute DMA_ATTR_LOW_ADDRESS which handles
buffer allocation from lower address[2].
This is a continuation of initial work from Marek for approach [2].
Patches have been tested with latest version of Samsung s5p-mfc driver.

Changes since V1:
[PATCH V2 1/6]
- Rebase on latest tree.

[PATCH V2 2/6]
- Rebase on latest tree.
  Added a missing check for iova_pfn in __iova_rcache_get()
  Discard changes from drivers/iommu/intel/iommu.c which are not necessary

[PATCH V2 3/6]
- Rebase on latest tree.

[PATCH V2 4/6]
- Rebase on latest tree

[PATCH V2 5/6]
- Rebase on latest tree

[PATCH V2 6/6]
- Rebase on latest tree.

Marek Szyprowski (6):
  dma-mapping: add DMA_ATTR_LOW_ADDRESS attribute
  iommu: iova: properly handle 0 as a valid IOVA address
  iommu: iova: add support for 'first-fit' algorithm
  iommu: dma-iommu: refactor iommu_dma_alloc_iova()
  iommu: dma-iommu: add support for DMA_ATTR_LOW_ADDRESS
  media: platform: s5p-mfc: use DMA_ATTR_LOW_ADDRESS

References:
[1]
https://lore.kernel.org/linux-iommu/20200811054912.GA301@infradead.org/

[2]
https://lore.kernel.org/linux-mm/bff57cbe-2247-05e1-9059-d9c66d64c407@arm.com

 drivers/iommu/dma-iommu.c                     | 77 +++++++++++-----
 drivers/iommu/iova.c                          | 91 ++++++++++++++++++-
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c  |  8 +-
 include/linux/dma-mapping.h                   |  6 ++
 include/linux/iova.h                          |  3 +
 5 files changed, 156 insertions(+), 29 deletions(-)


base-commit: faf93cfaadfaaff2a5c35d6301b45aa2f6e4ddb2
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
