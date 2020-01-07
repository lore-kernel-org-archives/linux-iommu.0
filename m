Return-Path: <SRS0=zmEc=24=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1528FC33C9E
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 17:40:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A152072A
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 17:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YazhU/1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A152072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9DEA886096;
	Tue,  7 Jan 2020 17:40:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rdPE1pryC8bX; Tue,  7 Jan 2020 17:40:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1254C86092;
	Tue,  7 Jan 2020 17:40:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03B2FC1796;
	Tue,  7 Jan 2020 17:40:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF9C9C0881
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 17:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9AD138526D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 17:38:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EoLnzf_hA9jd for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jan 2020 17:38:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7E21F852F6
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 17:38:43 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id l18so355376lfc.1
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jan 2020 09:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=YShlSsj6Xvg1OPo/28mdVtM8iXSk9E0UBpNiD7d4cxc=;
 b=YazhU/1g6LwFUIZeow4DmwAk2IRXPDITZkAOr2G/j4sCa4bGbUL7sYUao55R8VZ3ZQ
 Jv2Ml2OB7SXId3CCh1zEulZ3QjsySlL3rT53Y4ldWMtvsqes3QDo+aeIgRm+/pLEA+Tm
 5aThR1u/u5iFNvsiBzluecy1q1OyXe9+IJ3tht63Sq7JFgqxTMRn03XZzN0fvRdggLQF
 p//PkUf6nff51015iEzpZHBUNPubmqTws917O69DZZ+pI/GRjcKWwhKPoFEHYjjXqdnz
 UekIRCddL2f1Z2MlbWBZJRAs1cl/r2UVmMtlSKhppAdCQdR1Iz9eiypKiHjS68jCEYSU
 whfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=YShlSsj6Xvg1OPo/28mdVtM8iXSk9E0UBpNiD7d4cxc=;
 b=ky17mTDbFNnHmIPQDVvFFwwhNvVNn/3N/xmcZyvDsok/VPn7USsOcqtOvyseM44Qc9
 qtVSS47Jh0UzXs1tF7FPq+oy9hbPiuX3W40acLVkUdZidxGJgPsQyBgmAjgwY4Iiiy1n
 NrfLw4NErpbUnBMNjUrINZB/4E9QgrKDolA1OCYEikQS3MFnO+HTjOFMUoMW5f0VigQJ
 zDQucV3zjO2FGP6VDnIJ2SIATUcdUbzFhK6sIXFZn4+15UJpClHZiM+t7gLcb9I9CQ7a
 75vp0VQ0AHzFqpwilCe+XTqlN4rSYAs32KayoT7uT7p9GBhrjJxHRHwSdMXfM2erCRzu
 f/Hw==
X-Gm-Message-State: APjAAAUNHaO1Txet1vQ1Vlrvwto/9oBjanmFE9K9JGyhqDqcl2jXFgnI
 FixIZTVTFYbIPeneGtlRuy1/5mVp1aq3mZLVZttkTg==
X-Google-Smtp-Source: APXvYqzQpfWSWht2AsmDB2uHaiszhuxs88LR7mPSu6VSKvyO2MAlyzIQvfINY/+/sMaehSvr/ao1iKhlBnfVVXZebDI=
X-Received: by 2002:ac2:54b4:: with SMTP id w20mr352825lfk.67.1578418721583;
 Tue, 07 Jan 2020 09:38:41 -0800 (PST)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 7 Jan 2020 23:08:30 +0530
Message-ID: <CA+G9fYvMX4gMi6hmTmukzgr1xPsoJsj0WTm=AS3hC5Mq-dLvsQ@mail.gmail.com>
Subject: Re: dma-direct: don't check swiotlb=force in dma_direct_map_resource
To: hch@lst.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
X-Mailman-Approved-At: Tue, 07 Jan 2020 17:40:51 +0000
Cc: open list <linux-kernel@vger.kernel.org>,
 linux- stable <stable@vger.kernel.org>, iommu@lists.linux-foundation.org,
 lkft-triage@lists.linaro.org, robin.murphy@arm.com
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

Following build error on stable-rc 5.4.9-rc1 for arm architecture.

dma/direct.c: In function 'dma_direct_possible':
dma/direct.c:329:3: error: too many arguments to function 'dma_capable'
   dma_capable(dev, dma_addr, size, true);
   ^~~~~~~~~~~
In file included from
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/dma-direct.h:12:0,
                 from
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/kernel/dma/direct.c:10:
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/arch/arm/include/asm/dma-direct.h:17:20:
note: declared here
 static inline bool dma_capable(struct device *dev, dma_addr_t addr,
size_t size)
                    ^~~~~~~~~~~
In file included from
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/init.h:5:0,
                 from
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/memblock.h:12,
                 from
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/kernel/dma/direct.c:7:
dma/direct.c: In function 'dma_direct_map_resource':
dma/direct.c:378:16: error: too many arguments to function 'dma_capable'
  if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
                ^
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/compiler.h:78:42:
note: in definition of macro 'unlikely'
 # define unlikely(x) __builtin_expect(!!(x), 0)
                                          ^
In file included from
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/dma-direct.h:12:0,
                 from
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/kernel/dma/direct.c:10:
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/arch/arm/include/asm/dma-direct.h:17:20:
note: declared here
 static inline bool dma_capable(struct device *dev, dma_addr_t addr,
size_t size)
                    ^~~~~~~~~~~
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/scripts/Makefile.build:265:
recipe for target 'kernel/dma/direct.o' failed

Full build log link,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-5.4/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/44/consoleText

-- 
Linaro LKFT
https://lkft.linaro.org
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
