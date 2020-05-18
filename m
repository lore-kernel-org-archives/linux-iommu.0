Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F160BC433DF
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 09:06:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67DF20643
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 09:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67DF20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 76F61203AA;
	Mon, 18 May 2020 09:06:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fcXCSRzgNgJb; Mon, 18 May 2020 09:06:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2B3B92077C;
	Mon, 18 May 2020 09:06:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FC62C0881;
	Mon, 18 May 2020 09:06:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71321C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 09:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5D1752077C
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 09:06:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Phn1kK016qg for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 09:06:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by silver.osuosl.org (Postfix) with ESMTPS id 4FD7E20C45
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 09:06:52 +0000 (UTC)
Received: from mail-pl1-f198.google.com ([209.85.214.198])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1jabjW-0005d8-0N
 for iommu@lists.linux-foundation.org; Mon, 18 May 2020 09:06:50 +0000
Received: by mail-pl1-f198.google.com with SMTP id x4so6922195pll.19
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 02:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:content-transfer-encoding:mime-version
 :subject:message-id:date:cc:to;
 bh=fv0kKG3R4oPc9uFx9caWNL7elOwRa1h8BPa4WaUkiiM=;
 b=sLKzHcCbkL7XUqIjUrOohqXj1TrBoZakDvpbYNKHXR3jAEUJ7liqgCn7G5ufRMigLO
 qscrwX+Aan0E+PlyEUeRLx/Q+NQzgtuKH5hPs6AWpnVvqRgQXPaEZ4EoPhbGkekgTkVS
 fRHWS40rdvgzMweFGu7T4po70cdEEt9K2Js0lelegoErNIA4m2M2+3WKM5Xh6MNGc/C/
 D0DFdwOadz7oEhHvEnY5KlniRbuezqcoBM9AQf3lzP1fU2I5NUsrE5q0NEHxfFM8W8Jr
 /niPYIgkc/jGHGXg6022gsoJEKOwupZ+E0PfV0uu4Jn/MaR7XM1lJLfcwYVXfsowxL5k
 v5uw==
X-Gm-Message-State: AOAM530+xd++Uz3ghlviFRgWe01HDGrXwQZAqteEG2VQ1JkQDXT07v8E
 C8dIxBI/phIh2goIwFVb3hCOxq1kgjDehcdQOFeWcFw7YO7PIuEEjbfmocGATSWBk5Ex1fkmjIC
 f0jMsakBHikzaP59l4niSifcUKcbQyHh5eAqmUyOmGs2X81U=
X-Received: by 2002:a63:ef09:: with SMTP id u9mr14812920pgh.406.1589792808677; 
 Mon, 18 May 2020 02:06:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwRZ2pXW3DEvSMRoiu8LhnK3SCXnElDfQr9CARMhtvMOM3TQfOJr4A6y1/dCWHqF4xIEWWNg==
X-Received: by 2002:a63:ef09:: with SMTP id u9mr14812892pgh.406.1589792808351; 
 Mon, 18 May 2020 02:06:48 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net.
 [220.133.187.190])
 by smtp.gmail.com with ESMTPSA id z190sm8256455pfb.1.2020.05.18.02.06.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 May 2020 02:06:47 -0700 (PDT)
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: [Regression] "iommu/amd: Relax locking in dma_ops path" makes tg3
 ethernet transmit queue timeout
Message-Id: <4E9B03FB-9DA5-4831-B4CE-A0AA645D3F22@canonical.com>
Date: Mon, 18 May 2020 17:06:45 +0800
To: jroedel@suse.de
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Cc: iommu@lists.linux-foundation.org, open list <linux-kernel@vger.kernel.org>
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

Hi,

Broadcom ethernet tg3 unusable after commit 92d420ec028d ("iommu/amd: Relax locking in dma_ops path").
After a short period it stops:
[  122.717144] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:303 dev_watchdog+0x237/0x240()
[  122.717152] NETDEV WATCHDOG: enp3s0 (tg3): transmit queue 0 timed out

After testing the patch section by section, this is the part that caused the regression:

@@ -2578,19 +2580,8 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 
        dma_mask = *dev->dma_mask;
 
-       spin_lock_irqsave(&domain->lock, flags);
-
-       addr = __map_single(dev, domain->priv, paddr, size, dir, false,
+       return __map_single(dev, domain->priv, paddr, size, dir, false,
                            dma_mask);
-       if (addr == DMA_ERROR_CODE)
-               goto out;
-
-       domain_flush_complete(domain);
-
-out:
-       spin_unlock_irqrestore(&domain->lock, flags);
-
-       return addr;
 }

Particularly, as soon as the spinlock is removed, the issue can be reproduced.
Function domain_flush_complete() doesn't seem to affect the status.

However, the .map_page callback was removed by be62dbf554c5 ("iommu/amd: Convert AMD iommu driver to the dma-iommu api"), so there's no easy revert for this issue.

This is still reproducible as of today's mainline kernel, v5.7-rc6.

Kai-Heng
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
