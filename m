Return-Path: <SRS0=Ybkk=5L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C36FC2D0E7
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 09:36:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C0D20714
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 09:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MdEKy25/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C0D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1626387E3D;
	Thu, 26 Mar 2020 09:36:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E2nBt9J-ZTit; Thu, 26 Mar 2020 09:36:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2F84787DDE;
	Thu, 26 Mar 2020 09:36:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12029C1D87;
	Thu, 26 Mar 2020 09:36:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77D4CC0177
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 09:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 669D821511
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 09:36:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wOduj5z-VOUX for <iommu@lists.linux-foundation.org>;
 Thu, 26 Mar 2020 09:36:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by silver.osuosl.org (Postfix) with ESMTPS id DDA07204AE
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 09:36:47 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id m17so6796273wrw.11
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 02:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=G7p7PJ6AcDeKyfPDjNpk4b1tbVGXZ0s/DSwOXa4tJGU=;
 b=MdEKy25/rECSTKfRqslDXiTmq8aAghSsjHwwsraYtjVMg3oQK/FR4Nq2Iq/su6rA+O
 HrqEBktp/2UIDjuDsUKfy6MTCLHLczrMrygOfZrt4/dGb4gee3s//As5K5zRdCQOQz6w
 OAF2yOm5oXjpmNjBHl2HKhlxdse3NT0WvqCdTsD/4lKYiygz/WPyXDQA7WW+NKzeZs8P
 zqjZEBsu675cHpDtIRgL61hZeGPZtjRtgJ/uVLoO4B3O5xsTCNj6XZ1DV+iT+s6ZVfkM
 0NYqou+KrkDnZk9UzPKso9DceJifYwBiVzS5fnacYDQr5fsNh6kS9hUpn/OhOA6h8p2V
 S3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=G7p7PJ6AcDeKyfPDjNpk4b1tbVGXZ0s/DSwOXa4tJGU=;
 b=JbAf1sZQ8DUTrDhrWDNmI1/NXE1qu6+J0RvTosJ1h3XhxcuPaTJyfGQ5TNPakgp1QF
 ZKKaZSpjRE3YrcsAlaQGTfTNWXzkfavIP6/ItkJKUrMcW0+pVGZuQUaXDxHAeYYgNeEZ
 5ydTQH1S2Ax4aCye/e9ZowU4nztA8+RRPG5DZ/NZrwcUjcZRSi10r7SwdBYHNHiJL8BF
 fZLX6ihriyd63HHZL63wfDz9x9T0bhJaK4pBXYe3uRxoETnMeV/GCA6yiLjLABbyfRyd
 UKStMHSibpdGaFpyzKHPCKAxIeZ12m00UWKvJXwNdkrmAvgNUl85A8wrIkS9RM1wONfB
 ifBA==
X-Gm-Message-State: ANhLgQ2crzAM0tJcr+nGAY6jnS+KQE8SZGjcPF/cAojJCYoaIDIDRqvt
 1A0RR3LZyhC7KcjJ2bj70ZaFdcGrXGD4ng==
X-Google-Smtp-Source: ADFU+vtbZ1yGAz4pBh/4O+sIsvZFx+dJfbGrrMYuEMAEEDTRAA+DU6/7rWZWh0cSNFmldDCc8fR4rw==
X-Received: by 2002:a05:6000:12c6:: with SMTP id
 l6mr8834464wrx.152.1585215405995; 
 Thu, 26 Mar 2020 02:36:45 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u8sm2670165wrn.69.2020.03.26.02.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 02:36:45 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 0/3] iommu/virtio: Misc fixes
Date: Thu, 26 Mar 2020 10:35:55 +0100
Message-Id: <20200326093558.2641019-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, bbhushan2@marvell.com,
 jasowang@redhat.com
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

A collection of fixes for the virtio-iommu driver. It might be too late
for v5.6 since they need more review. Patch 2 is new, the others were
posted separately. 

Jean-Philippe Brucker (3):
  iommu/virtio: Fix sparse warning
  iommu/virtio: Fix freeing of incomplete domains
  iommu/virtio: Reject IOMMU page granule larger than PAGE_SIZE

 include/uapi/linux/virtio_iommu.h | 12 ++++++------
 drivers/iommu/virtio-iommu.c      | 30 +++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 15 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
