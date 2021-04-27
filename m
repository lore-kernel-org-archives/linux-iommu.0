Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FF6C433ED
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 11:34:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95977613DC
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 11:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95977613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3051560705;
	Tue, 27 Apr 2021 11:34:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RS9vHso6cj2o; Tue, 27 Apr 2021 11:34:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C437606A6;
	Tue, 27 Apr 2021 11:34:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDA0DC000F;
	Tue, 27 Apr 2021 11:34:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98BF8C000B
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 11:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8750A4022B
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 11:34:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QXi2xxQxFjt8 for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 11:34:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A245840217
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 11:34:31 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 y124-20020a1c32820000b029010c93864955so6898380wmy.5
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 04:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=z9C6sQ611y/zGRe/UW7/e4zr9l8XoO00RXrJcagkHXI=;
 b=ADceqTv77JagwuFR5s9XYfyWOZzLEa1itzG63x+/awj4LHL6EimuX3bNg/jqkU679E
 mKYqV/UOts733gmwYFpMRjNgmhi2N/F64p3P3rqX/Uh5do7cQ7vlossntalvaozE7NGz
 kf/KxYbXgYme8cHq/udvl2WQPFNraJMgMh5PWGdoZ2XI/Lb1WUhJVPFqjXfS8Ex1etJR
 vnz6sdSPEJYuc+LL2v0LHFIgtyGkM3GysbI39aqeENl2J24DoRvo1T/0CK25s4cqrKdC
 f7wIbcrSWQ8GvgsAEhmJ9tc7sjf5CdBnZgX8IDpB5GZNfz+WJ536dSma3F9vkDZXxIA6
 LA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=z9C6sQ611y/zGRe/UW7/e4zr9l8XoO00RXrJcagkHXI=;
 b=AxCcVnKVsdQBEtS3O/6GROAK8MZDpKC3a8LSU3RPW8jN11zXDJLMYEifj026k+0fM3
 Qs74hX+2goO6aYhCbWBKzdsMCLFtxSTGLVOP1RvxOSgk6TDq84fGjItN1OLw7EdAUHfe
 Y0Nd0Ezoabo6Y3XSghRQ6MmGj2z+rDCKmv5peRC/nlrsbf/Eildd4L5+GtkffOk+ui7F
 3NByQxIYxWFjjXJZK1+FpKc/MMqj4bC/6/lM1bh8NeXt1shi+8ZUPJNuZsv+ND38feI+
 QCRXvg58AK/NrW5Qgq0UNfrVko/kSpVeZ3BOjVQ7RMsuM92s6ZzjvyOeE5KDxeSepVkE
 Pp2w==
X-Gm-Message-State: AOAM533VMp6dMZRFSi/xypgXwn12D4UAFci9lmyKKBKb2BuPBzbFkENQ
 BOYPVegXl8O60lfVhucjRZ0=
X-Google-Smtp-Source: ABdhPJxx8bbd49gBf2BOW+mAj9jkSpFMqNRJrMWmqgLw490R5M0aOVJ384sGI0gsYJgtbMJNzHybmw==
X-Received: by 2002:a1c:f402:: with SMTP id z2mr3883978wma.21.1619523269928;
 Tue, 27 Apr 2021 04:34:29 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
 by smtp.googlemail.com with ESMTPSA id k10sm2989203wmf.0.2021.04.27.04.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 04:34:29 -0700 (PDT)
Date: Tue, 27 Apr 2021 13:34:27 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
Subject: dma-api debugfs directory is not created since debugfs is not
 initialized
Message-ID: <YIf2w1navFNeYjMS@Red>
MIME-Version: 1.0
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Hello

I try to debug some DMA problem on next-20210427, and so I have enabled CONFIG_DMA_API_DEBUG=y.
But the dma-api directory does show up in debugfs, but lot of other directory exists in it.

After debugging it seems due to commit 56348560d495 ("debugfs: do not attempt to create a new file before the filesystem is initalized")
Reverting the commit permit to "dma-api" debugfs to be found. (but seems not the right way to fix it).

Regards
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
