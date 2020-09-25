Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D07C4363D
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 14:12:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA6520936
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 14:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KiBRQVTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA6520936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F206F86CD0;
	Fri, 25 Sep 2020 14:12:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id buNBgALtNmDe; Fri, 25 Sep 2020 14:12:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7EC6E86C92;
	Fri, 25 Sep 2020 14:12:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 694ADC0890;
	Fri, 25 Sep 2020 14:12:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D788DC0859
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 14:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C900286DCA
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 14:12:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7JcGRXZtYNaD for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 14:12:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BB21586DBC
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 14:12:33 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200925141231euoutp0276e5a8413a78b88c3920a01bf4e787da~4DEOKNBqi0695406954euoutp02D
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 14:12:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200925141231euoutp0276e5a8413a78b88c3920a01bf4e787da~4DEOKNBqi0695406954euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1601043151;
 bh=wGeLbKboFdr/tqZI1Rt5Qegc3ri464oOUQrZYBxud1M=;
 h=From:To:Cc:Subject:Date:References:From;
 b=KiBRQVTJ6mQFMIF5amxeSuZpZrnOqccS+kD1p5Lpb1lqWaYcPMCQA8NQ+kxeKp7W5
 yYPU0z9XUpqCRfMMQsHtez26upki+etsRfnVDCDBBKVsK8Blm85EmgL+a+2Gzi7xPr
 XfzJE/k4HuaS8hB+PlVnQBncF5yfdGee/86nTyjo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200925141231eucas1p16b578c2724139227149654a5732434db~4DENyDIBX1940019400eucas1p1Y;
 Fri, 25 Sep 2020 14:12:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 65.D3.06318.FCAFD6F5; Fri, 25
 Sep 2020 15:12:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200925141230eucas1p1b4bb8a7e17a887c6ca6a7b8caa7cf9c7~4DENPSaKn2129921299eucas1p1U;
 Fri, 25 Sep 2020 14:12:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200925141230eusmtrp203f60fb1015cc87490a4e60dc0a5d363~4DENOmj6i2568825688eusmtrp2E;
 Fri, 25 Sep 2020 14:12:30 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-73-5f6dfacfc028
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id ED.39.06314.ECAFD6F5; Fri, 25
 Sep 2020 15:12:30 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200925141230eusmtip17224b43806866ba6215d9dde1cfddbe4~4DEMrufQ11697816978eusmtip14;
 Fri, 25 Sep 2020 14:12:30 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linux IOMMU <iommu@lists.linux-foundation.org>,
 linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 0/8] IOMMU-DMA - support old allocation algorithm used on ARM
Date: Fri, 25 Sep 2020 16:12:10 +0200
Message-Id: <20200925141218.13550-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7rnf+XGGyxayGexccZ6VouVq48y
 WSzYb23ROXsDu8X580Di8q45bBY9G7ayWsw4v4/JYu2Ru+wWBz88YbVof/qS2eJz6z82Bx6P
 JwfnMXmsmbeG0WN2w0UWj02rOtk8Jt9Yzuix+2YDm0ffllWMHp83yQVwRHHZpKTmZJalFunb
 JXBldJz0LvglWrHuZSNjA+MnwS5GTg4JAROJ2fOWsHQxcnEICaxglHh49CiU84VR4u7y00wQ
 zmdGiQsbvjPCtDybNB8qsZxRounHfka4lisT37CDVLEJGEp0ve1i62Lk4BARKJFYdoIPpIZZ
 4AmTxJ6/C5lAaoQF/CVeNEwAs1kEVCX6D59nBbF5BWwlLn3aALVNXmL1hgPMEHY3u8TUTnMI
 20Wi6xFMXFji1fEt7BC2jMT/nRDXSQg0Az10bi07hNPDKHG5aQbUVGuJO+d+gV3HLKApsX6X
 PkTYUeLT16/MIGEJAT6JG2/BgcQMZE7aNh0qzCvR0SYEUa0mMev4Ori1By9cgjrHQ+LDlb9g
 bwkJxEq82NHAPIFRbhbCrgWMjKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECE8vpf8e/
 7mDc9yfpEKMAB6MSD++JR7nxQqyJZcWVuYcYJTiYlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7E
 KM3BoiTOa7zoZayQQHpiSWp2ampBahFMlomDU6qB0eW61deXS75Hnn57lds/Zm9WSkVS8jGB
 N4JPL++0+hIvdCU3fs6aHKX4f/1Vq54pRqquDqz9KTxdQeLP4jzNb8m6s25I8J5MfNPnf3vR
 ZpUlDywSWj2fLLlS1bdIuORSh2jUV5P2U2VtZfsfN33ze8X4s2Hak0MbRXI4d8jsMzq7Vsjo
 y4m5q5VYijMSDbWYi4oTAaVB8GsoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsVy+t/xu7rnfuXGG2y9pGmxccZ6VouVq48y
 WSzYb23ROXsDu8X580Di8q45bBY9G7ayWsw4v4/JYu2Ru+wWBz88YbVof/qS2eJz6z82Bx6P
 JwfnMXmsmbeG0WN2w0UWj02rOtk8Jt9Yzuix+2YDm0ffllWMHp83yQVwROnZFOWXlqQqZOQX
 l9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehldJz0LvglWrHuZSNjA+Mn
 wS5GTg4JAROJZ5PmM3UxcnEICSxllFh8+wk7REJG4uS0BlYIW1jiz7UuNhBbSOATo8SnBmYQ
 m03AUKLrLURcRKBMouPKVmaQQcwCb5gk7r76ATZIWMBX4uT1VYwgNouAqkT/4fNgQ3kFbCUu
 fdrACLFAXmL1hgPMExh5FjAyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAgM6G3Hfm7ewXhp
 Y/AhRgEORiUe3hOPcuOFWBPLiitzDzFKcDArifA6nT0dJ8SbklhZlVqUH19UmpNafIjRFGj5
 RGYp0eR8YLTllcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgnNJw
 dJPr22lxm64ei08rSDO7OrFA7HYlN0vPvLhIZ9HKJ1Ois//vurvhP/PRSPYgG7X++Pys3uk7
 p7kW2yx3e3peaTPPpZsiJtri+56u/nbaY5aoz/J7T+U/nE210kurYN3HtOnxqau7ahf9ymj1
 TApjMtokbdX0dIVDtLqUoEVkVvuHBbwvlFiKMxINtZiLihMBp9SQTX4CAAA=
X-CMS-MailID: 20200925141230eucas1p1b4bb8a7e17a887c6ca6a7b8caa7cf9c7
X-Msg-Generator: CA
X-RootMTR: 20200925141230eucas1p1b4bb8a7e17a887c6ca6a7b8caa7cf9c7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200925141230eucas1p1b4bb8a7e17a887c6ca6a7b8caa7cf9c7
References: <CGME20200925141230eucas1p1b4bb8a7e17a887c6ca6a7b8caa7cf9c7@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Sylwester Nawrocki <snawrocki@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

Hi,

This patchset is a continuation of the planned rework of the ARM
IOMMU/DMA-mapping code proposed by Robin Murphy in [1]. However, there
are drivers (for example S5P-MFC and Exynos4-IS) which depend on the way
the old ARM IOMMU/DMA-mapping glue code worked (it used 'first-fit' IOVA
allocation algorithm), so before switching ARM to the generic code, such
drivers have to be updated.

This patchset provides the needed extensions to the generic IOMMU-DMA
framework to enable support for the drivers that relied on the old ARM
IOMMU/DMA-mapping behavior. This patchset is based on the idea proposed
by Robin Murphy in [2] after the discussion of the workaround implemented
directly in the mentioned drivers [3].

Here is a git branch with this patchset and [1] patches applied on top of
linux next-20200925:
https://github.com/mszyprow/linux/tree/v5.9-next-20200925-arm-dma-iommu-low-address

Best regards,
Marek Szyprowski


References:

[1] https://lore.kernel.org/lkml/cover.1597931875.git.robin.murphy@arm.com/
[2] https://lore.kernel.org/linux-iommu/bff57cbe-2247-05e1-9059-d9c66d64c407@arm.com/
[3] https://lore.kernel.org/linux-samsung-soc/20200918144833.14618-1-m.szyprowski@samsung.com/T/


Patch summary:

Marek Szyprowski (8):
  dma-mapping: add DMA_ATTR_LOW_ADDRESS attribute
  iommu: iova: properly handle 0 as a valid IOVA address
  iommu: iova: add support for 'first-fit' algorithm
  iommu: dma-iommu: refactor iommu_dma_alloc_iova()
  iommu: dma-iommu: add support for DMA_ATTR_LOW_ADDRESS
  media: platform: exynos4-is: remove all references to physicall
    addresses
  media: platform: exynos4-is: use DMA_ATTR_LOW_ADDRESS
  media: platform: s5p-mfc: use DMA_ATTR_LOW_ADDRESS

 drivers/iommu/dma-iommu.c                     | 79 ++++++++++++-----
 drivers/iommu/intel/iommu.c                   | 12 +--
 drivers/iommu/iova.c                          | 88 ++++++++++++++++++-
 .../media/platform/exynos4-is/fimc-capture.c  |  6 +-
 drivers/media/platform/exynos4-is/fimc-core.c | 28 +++---
 drivers/media/platform/exynos4-is/fimc-core.h | 18 ++--
 drivers/media/platform/exynos4-is/fimc-is.c   | 23 ++---
 drivers/media/platform/exynos4-is/fimc-is.h   |  6 +-
 .../media/platform/exynos4-is/fimc-lite-reg.c |  4 +-
 drivers/media/platform/exynos4-is/fimc-lite.c |  2 +-
 drivers/media/platform/exynos4-is/fimc-lite.h |  4 +-
 drivers/media/platform/exynos4-is/fimc-m2m.c  |  8 +-
 drivers/media/platform/exynos4-is/fimc-reg.c  | 18 ++--
 drivers/media/platform/exynos4-is/fimc-reg.h  |  4 +-
 drivers/media/platform/s5p-mfc/s5p_mfc.c      |  8 +-
 include/linux/dma-mapping.h                   |  6 ++
 include/linux/iova.h                          |  4 +
 17 files changed, 221 insertions(+), 97 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
