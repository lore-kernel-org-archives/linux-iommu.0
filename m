Return-Path: <SRS0=b5RZ=T4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AB6C04AB6
	for <iommu@archiver.kernel.org>; Tue, 28 May 2019 18:31:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1840208CB
	for <iommu@archiver.kernel.org>; Tue, 28 May 2019 18:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cwZBumMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1840208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A2EEE226F;
	Tue, 28 May 2019 18:31:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9C78F225E
	for <iommu@lists.linux-foundation.org>;
	Tue, 28 May 2019 18:30:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from prod-mx.aristanetworks.com (mx.aristanetworks.com
	[162.210.129.12])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A56F96C5
	for <iommu@lists.linux-foundation.org>;
	Tue, 28 May 2019 18:30:01 +0000 (UTC)
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
	by prod-mx.aristanetworks.com (Postfix) with ESMTP id A549B4256C6;
	Tue, 28 May 2019 11:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1559068223;
	bh=gZKRKJcuRQSwe2TyYVhO9ixqNktFM8piGcLI2AKiDUY=;
	h=From:To:Cc:Subject:Date;
	b=cwZBumMWFxzPMJSF6cLFED0aHPey7MTEIZ7V3LnvIDFB5zxpZ43x7nB1GSzGOMlkG
	4sP5rjTFneL/y2Ame6XATZkW7t0LQmQN+qI+E9SDGKE2dAVmMgzxOr/WVHUdFTXCW4
	0FMqKkkxyPw9ZoUkD0xVBAiF9/cI8Tzo6WqNfJazzFp5vUZjzn4q+p0N16JnB0hBTi
	HXVqUB2EDr08rOxkje+1wNd5KnGv94z8vtv1E/CClOtnoqA37+PnE/aDoiLoVsWQGd
	fgoMdYp/gJp3Ya4kSsvXqc0CKM/Sm1Lu/oS3EZbZA1yXaqAhQaGOJQkVTUkkt/wHl2
	wHpQ2mLtfofbw==
Received: from chmeee (unknown [10.95.80.198])
	by prod-mx.aristanetworks.com (Postfix) with ESMTP id 9CEAB424472;
	Tue, 28 May 2019 11:30:23 -0700 (PDT)
Received: from kevmitch by chmeee with local (Exim 4.92)
	(envelope-from <kevmitch@chmeee>)
	id 1hVgrI-0000xK-LF; Tue, 28 May 2019 11:30:00 -0700
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/3] handle init errors more gracefully in amd_iommu
Date: Tue, 28 May 2019 11:29:55 -0700
Message-Id: <20190528182958.3623-1-kevmitch@arista.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
From: Kevin Mitchell via iommu <iommu@lists.linux-foundation.org>
Reply-To: Kevin Mitchell <kevmitch@arista.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

This series makes error handling more robust in the amd_iommu init
code. It was initially motivated by problematic firmware that does not
set up the physical address of the iommu. This led to a NULL dereference
panic when iommu_disable was called during cleanup.

While the first patch is sufficient to avoid the panic, the subsequent
two move the cleanup closer to the actual error and avoid calling the
cleanup code twice when amd_iommu=off is specified on the command line.

I have tested this series on a variety of AMD CPUs with firmware
exhibiting the issue. I have additionally tested on platforms where the
firmware has been fixed. I tried both with and without amd_iommu=off. I
have also tested on older CPUs where no IOMMU is detected and even one
where the GART driver ends up running.

Thanks,

Kevin

Kevin Mitchell (3):
  iommu/amd: make iommu_disable safer
  iommu/amd: move gart fallback to amd_iommu_init
  iommu/amd: only free resources once on init error

 drivers/iommu/amd_iommu_init.c | 45 ++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 21 deletions(-)

-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
