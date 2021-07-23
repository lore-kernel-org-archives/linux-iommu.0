Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FE7C43214
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 21:40:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79ED060F02
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 21:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 79ED060F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5858360C07;
	Fri, 23 Jul 2021 21:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8kR5O9KVBshi; Fri, 23 Jul 2021 21:40:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2EA2D60BB0;
	Fri, 23 Jul 2021 21:40:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48B56C0024;
	Fri, 23 Jul 2021 21:40:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94286C000E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B630405DE
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=wdc.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jq0tYOVCxrEW for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 21:40:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84F1A405F8
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1627076438; x=1658612438;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CVn7oX0CjfibpYFFpqHWKgpHrrL7Xnf/XJqEMEbWufY=;
 b=I3YhLYCYXOyjQmfd7NjMgSObNw8JiNTFxnRo8fqzh2qWV45pc5DfbL+Y
 5YvdAe4WfY4N4PZAjlnX9cZtX8ZrGun5JUlnuVyxvs7e6y7dnc5PrnYAh
 2f1/l1dvOBUW2gNkpXfE0hLm7fFRodvwlC1zxWRF91KdMD8h5J+x8SHW4
 Zs4mAh5ntglJIhbqVFsYr0jMYwGB5wXbzdljSipEBByVD8dYwnmQ64HTI
 VKkFu7C5T8iak80e/N0eIC3XQ6/lBKnE6aWHSD4J2VQ3E13sEeDNlWsqB
 mAvNf57iybdhlONt1QHcvV4qE9OkW64o4vz8ulVBxod3/dil/f2Y7Fdvz g==;
X-IronPort-AV: E=Sophos;i="5.84,265,1620662400"; d="scan'208";a="279198470"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2021 05:40:38 +0800
IronPort-SDR: Hlown/MIZ3X0k31csXzw+BoF5tuk6Sr6nXKVGF61sUcj3B/wTvM1hne8eAgr65D/CnKF9/GuvW
 eZSKPEyMJdc6shl518Xfi6eDsYgIgvk4rtYxuuVLvLMJBmZdo4MDClarg0qCzgQivlg4PVLPAF
 7O/jWePEoMs1GSjrnzcrXUTgQvqRuIUp9uR51U+SV0FBFg2e2YyhiPS6YzDdaXY9yIERgEzUUa
 WDGdA2pFAndBxBEgVevFrUqgxrj4knU0n/a7H29hwJwPS4HsAOjGMdegknRsmOqqgfVsUyJ4Lg
 5frQhfw6B1bG2EwX0hgXvjzt
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2021 14:18:27 -0700
IronPort-SDR: qhmdgrA1THlc1t/uoxnlsIj0rUGoMMu54qei7gUWzJ87apTwDnCvOIRNBoziAyb682Fgk8jRYW
 UcnQ0MFzhh8mMx4cCW8MaT8l+6SGuqwmTGzpjclU1SRda/TiKJfNmAERHZ7vruJbQbqj+9akst
 Zy3PrYdD05YDUud56v6fL93ksTdhe8tU/rO4Z3KZSrDBVeLvwxNigChWwMk+eKF4Kh9+8OoRpp
 HbIAUxanozLZ7K6AaSrtNE+1ypjkoxDYqn0/HSxVF48FGlduZ0tmkOcdTrI8grrvNtTC8wvyvW
 Vu0=
WDCIronportException: Internal
Received: from ucfbox21.ad.shared (HELO hulk.wdc.com) ([10.225.167.4])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Jul 2021 14:40:38 -0700
From: Atish Patra <atish.patra@wdc.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC 5/5] RISC-V: Support a new config option for non-coherent DMA
Date: Fri, 23 Jul 2021 14:40:31 -0700
Message-Id: <20210723214031.3251801-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210723214031.3251801-1-atish.patra@wdc.com>
References: <20210723214031.3251801-1-atish.patra@wdc.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 Tobias Klauser <tklauser@distanz.ch>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Atish Patra <atish.patra@wdc.com>,
 iommu@lists.linux-foundation.org, Guo Ren <guoren@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>
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

In future, there will be more RISC-V platforms with non-coherent DMA.
Instead of selecting all the required config options in every soc, create
a new config that selects all the required configs related non-coherent
DMA.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8fcceb8eda07..931b283c8ec9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -209,6 +209,14 @@ config PGTABLE_LEVELS
 config LOCKDEP_SUPPORT
 	def_bool y
 
+config RISCV_DMA_NONCOHERENT
+	bool
+	select ARCH_HAS_DMA_PREP_COHERENT
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SETUP_DMA_OPS
+	select DMA_GLOBAL_POOL
+
 source "arch/riscv/Kconfig.socs"
 source "arch/riscv/Kconfig.erratas"
 
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
