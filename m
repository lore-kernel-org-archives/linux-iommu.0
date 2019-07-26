Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653D6C7618F
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 19:33:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3337521994
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 19:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZhAyKvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3337521994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EC70AC83;
	Fri, 26 Jul 2019 19:33:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6AE5DC3F
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 19:33:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
	[209.85.214.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2597489D
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 19:33:51 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id b3so25129953plr.4
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 12:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=7tkH22Ffe0DvxT70J0560IP/vxuVnKp0sgsAZ7ct/kU=;
	b=sZhAyKvQ0pJENnvl74GI+1vSNcqkR7Zxt27F7+yk8XwPzP5vyrblpmuDnWM8eA7j4u
	VQAKprvKigJ+ytQQcWxx7oQUnaXYmgdZQEORKjvLR4HwbP/U0j3btuSHOCRH4wvw4ASL
	lxgEpkfzoCwStLlspH78nOXbYqjs7qEVDbCe+a7t1+cxH0xyRm9aaRANiP1UBsnGsvX4
	svCSscP6id4Vk1p0+Ra0pHr335yFW/iRoU/3gY4uEMpNs+NBpDGq9zAskyH5m+OOsvEX
	+f+NWJi0hVJXVqzQ5991FwCpjBNAa+iLTeI9VHHm5pJvwgcSuqtg/cHqc6SjLm3ntMw9
	KBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=7tkH22Ffe0DvxT70J0560IP/vxuVnKp0sgsAZ7ct/kU=;
	b=cLmfE1p6Zzpyfx6/SiNwMvk9EGxhjHBUR2Q50J+39FfcrVbADFNW8+FQNlBCE85r2R
	6WMh25yILPS5bHWGUi2pZbN9eCkR9F00Uo+SCdxoLHQS4A0y1qrlfFP+us9hVw9TD9Ps
	6NMXcAfZJ1DOmkqNANUk/dd8wUCCHlhUXZ50r4nVvEEViTt1Li9nFYycnzx8mEvcUerm
	Ohh7b+csleK/5vK+FzIXmBfW7PgdIrz16GfVLSA2rUHxp3Zbjy4xZskfkWlEeLE0MA1I
	URt8VzpW/5HkUKSSu0EOwg7/Fj09lpdVgqWD3Hi8aPqPtQZ4NU4M+G5uY3pV0pYTxJ9A
	3Eow==
X-Gm-Message-State: APjAAAX9pQqOi93PL+954luJzxfB/rrFGIiALNmP9b3Sdb4L1Wk8D8EA
	o4KyjHQayxvW3/3MmGb5dVE=
X-Google-Smtp-Source: APXvYqx7SUpoM/Zcr020mWM3NZGJfkkvDWZ4q/gV2rr6L837Ox7xNkubltz0joMFZej0ufvDUqwtvA==
X-Received: by 2002:a17:902:2aa8:: with SMTP id
	j37mr93425919plb.316.1564169630686; 
	Fri, 26 Jul 2019 12:33:50 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	e189sm31824212pgc.15.2019.07.26.12.33.49
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 26 Jul 2019 12:33:50 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: dafna.hirschfeld@collabora.com, hch@lst.de, m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH v2 0/2] dma-contiguous: two bug fixes for dma_{alloc,
	free}_contiguous()
Date: Fri, 26 Jul 2019 12:34:31 -0700
Message-Id: <20190726193433.12000-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

There are two obvious bugs in these two functions. So having
two patches to fix them.

Changlog
v1->v2:
 * PATCH-1: Confine cma_align inside the if-condition.
 * PATCH-1: Updated commit message to be precise for the corner case.
 * PATCH-2: Added Reviewed-by from Christoph.

Nicolin Chen (2):
  dma-contiguous: do not overwrite align in dma_alloc_contiguous()
  dma-contiguous: page-align the size in dma_free_contiguous()

 kernel/dma/contiguous.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
