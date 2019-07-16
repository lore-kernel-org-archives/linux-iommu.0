Return-Path: <SRS0=AIpH=VN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632A5C7618F
	for <iommu@archiver.kernel.org>; Tue, 16 Jul 2019 23:57:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E072184E
	for <iommu@archiver.kernel.org>; Tue, 16 Jul 2019 23:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kY0Sj05a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E072184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C9972AF0;
	Tue, 16 Jul 2019 23:57:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 61FF22C
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Jul 2019 23:57:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 13142876
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Jul 2019 23:57:22 +0000 (UTC)
Received: from localhost (unknown [23.100.24.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 7B0AE2184C;
	Tue, 16 Jul 2019 23:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563321442;
	bh=ASzjUP46Go4gqGA2McCcDj63FgjSSd2/+EiMsRppPsU=;
	h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Subject:In-Reply-To:
	References:From;
	b=kY0Sj05aXFNcIOlODQZS0nc2hyQzWCvP34ACx1lkLd1pWTtspSiT7/8iSoACSlTkU
	OsVWgIzjZk/UHv0q51BRm5uimgsTQb/eaZ4qLS9PRZb5DhhlUVSGXoIFs+QNpsQqCO
	mP+pppMWenoRFnhyR9lwKkY5LWrizJZjrtpE9aGs=
Date: Tue, 16 Jul 2019 23:57:21 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Dmitry Safonov <dima@arista.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Don't queue_iova() if there is no flush
	queue
In-Reply-To: <20190716213806.20456-1-dima@arista.com>
References: <20190716213806.20456-1-dima@arista.com>
Message-Id: <20190716235722.7B0AE2184C@mail.kernel.org>
Cc: , Dmitry Safonov <0x7f454c46@gmail.com>, stable@vger.kernel.org,
	iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 13cf01744608 iommu/vt-d: Make use of iova deferred flushing.

The bot has tested the following trees: v5.2.1, v5.1.18, v4.19.59, v4.14.133.

v5.2.1: Build OK!
v5.1.18: Build OK!
v4.19.59: Failed to apply! Possible dependencies:
    02b4da5f84d1 ("intel-iommu: mark intel_dma_ops static")
    0bbeb01a4faf ("iommu/vt-d: Manage scalalble mode PASID tables")
    524a669bdd5f ("iommu/vt-d: remove the mapping_error dma_map_ops method")
    932a6523ce39 ("iommu/vt-d: Use dev_printk() when possible")
    964f2311a686 ("iommu/intel: small map_page cleanup")
    ef848b7e5a6a ("iommu/vt-d: Setup pasid entry for RID2PASID support")
    f7b0c4ce8cb3 ("iommu/vt-d: Flush IOTLB for untrusted device in time")

v4.14.133: Failed to apply! Possible dependencies:
    0bbeb01a4faf ("iommu/vt-d: Manage scalalble mode PASID tables")
    2e2e35d51279 ("iommu/vt-d: Missing checks for pasid tables if allocation fails")
    2f13eb7c580f ("iommu/vt-d: Enable 5-level paging mode in the PASID entry")
    3e781fcafedb ("iommu/vt-d: Remove unnecessary WARN_ON()")
    4774cc524570 ("iommu/vt-d: Apply per pci device pasid table in SVA")
    4fa064b26c2e ("iommu/vt-d: Clear pasid table entry when memory unbound")
    524a669bdd5f ("iommu/vt-d: remove the mapping_error dma_map_ops method")
    562831747f62 ("iommu/vt-d: Global PASID name space")
    7ec916f82c48 ("Revert "iommu/intel-iommu: Enable CONFIG_DMA_DIRECT_OPS=y and clean up intel_{alloc,free}_coherent()"")
    85319dcc8955 ("iommu/vt-d: Add for_each_device_domain() helper")
    932a6523ce39 ("iommu/vt-d: Use dev_printk() when possible")
    964f2311a686 ("iommu/intel: small map_page cleanup")
    971401015d14 ("iommu/vt-d: Use real PASID for flush in caching mode")
    9ddbfb42138d ("iommu/vt-d: Move device_domain_info to header")
    a7fc93fed94b ("iommu/vt-d: Allocate and free pasid table")
    af39507305fb ("iommu/vt-d: Apply global PASID in SVA")
    be9e6598aeb0 ("iommu/vt-d: Handle memory shortage on pasid table allocation")
    cc580e41260d ("iommu/vt-d: Per PCI device pasid table interfaces")
    d657c5c73ca9 ("iommu/intel-iommu: Enable CONFIG_DMA_DIRECT_OPS=y and clean up intel_{alloc,free}_coherent()")
    ef848b7e5a6a ("iommu/vt-d: Setup pasid entry for RID2PASID support")
    f7b0c4ce8cb3 ("iommu/vt-d: Flush IOTLB for untrusted device in time")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

--
Thanks,
Sasha
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
