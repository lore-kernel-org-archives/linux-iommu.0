Return-Path: <SRS0=u5nN=W5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C605C3A59E
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 20:08:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F69120674
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 20:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JZ522zUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F69120674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1A449CCB;
	Mon,  2 Sep 2019 20:08:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 46809AC8
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 20:08:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F34395D3
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 20:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g/QEi3hgO0OyJQXGaAxJfuvSnqiwwXoSBsm20nYl6ts=;
	b=JZ522zUFE4TgteT9cqAHTzLL4/
	Eba+EGf6i8+nT+sXzDuwc5W20Wib2GPh1/YlDsLjqiNAivFibqLLoYxPz9ZPqxjhVyPeb6avIdBR0
	0ktWpSkpCEfEs0ik8IyeahsMmFZNvCPFW/IrWmqnMbR0/VNUMWhdC93XuKURqCkZsj5mFPa4AUm1k
	VDApvx/jIHwOx81BWF8+EgCn0tb7w9lhjXeCvHxj5q6yZZ9eXFX9wy/UQCgxBCsX0J2p9Ydf/GhT3
	symQlhobm+sUAHspQceXdlS0SVgnyKSyujk4o+aUklEGt9I/8qlbNxAPOEvix+YpPf6JsEI7Z+7/R
	44xFd5uw==;
Received: from [2001:4bb8:18c:1755:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1i4scW-0007Ni-OQ; Mon, 02 Sep 2019 20:08:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, Loic Pallardy <loic.pallardy@st.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 3/4] remoteproc: don't allow modular build
Date: Mon,  2 Sep 2019 22:07:45 +0200
Message-Id: <20190902200746.16185-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902200746.16185-1-hch@lst.de>
References: <20190902200746.16185-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Remoteproc started using dma_declare_coherent_memory recently, which is
a bad idea from drivers, and the maintainers agreed to fix that.  But
until that is fixed only allow building the driver built in so that we
can remove the dma_declare_coherent_memory export and prevent other
drivers from "accidentally" using it like remoteproc.  Note that the
driver would also leak the declared coherent memory on unload if it
actually was built as a module at the moment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/remoteproc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 28ed306982f7..94afdde4bc9f 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -2,7 +2,7 @@
 menu "Remoteproc drivers"
 
 config REMOTEPROC
-	tristate "Support for Remote Processor subsystem"
+	bool "Support for Remote Processor subsystem"
 	depends on HAS_DMA
 	select CRC32
 	select FW_LOADER
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
