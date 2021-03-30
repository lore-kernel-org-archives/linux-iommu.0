Return-Path: <SRS0=H7Zn=I4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6FEC433DB
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 17:30:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FD9619D1
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 17:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FD9619D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 987CD600B8;
	Tue, 30 Mar 2021 17:30:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lyyT74HihjDv; Tue, 30 Mar 2021 17:30:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9398C6065A;
	Tue, 30 Mar 2021 17:30:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A744C000C;
	Tue, 30 Mar 2021 17:30:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99032C000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 17:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8753D6065A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 17:30:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s0vnpBP11xtX for <iommu@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 17:30:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 09CF1600B8
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 17:30:03 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F5D4619C7;
 Tue, 30 Mar 2021 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617125402;
 bh=C8O0alZVc/4m1eevRMOdvFYGpb/wNNuDuufNDrLUuQQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YlhQsQQWUsLXlFqsj68qjAmIgwrUB402VoS+aB1erd03q1KOtJUCQb4U3Wqqgs3SB
 iTOrSWjppww4kGCLWZZI91Y2m/j+eP9OmPXhydxgZgfbLsrqJIkmQNtk8bP0v+jzSx
 TzeQjHeg5mqpcqD0e+KpcPYJMMteIb4Av6YuXlE+5P7dyrr1LCOjlf1f5O6Lgajas+
 zNgTDQXLJzHb/6M8m8Mo8XsHxB2fsNF6A4XX0rnAgxxGk8JSqW0GkayeK8I2df+7X1
 TZxQLOAh6IZUxUJ6H6x7ULZIO+4bNvxITYEnjczyVgn7ZP3pZjCMaZVOqwYTXT0P0y
 bhWPgaKY+z35Q==
Date: Tue, 30 Mar 2021 22:59:58 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: Re: [PATCH 14/30] Revert "s3c24xx-dma.c: Fix a typo"
Message-ID: <YGNgFuLWc91aGoQj@vkoul-mobl.Dlink>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
 <1d989f71fbebd15de633c187d88cb3be3a0f2723.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1d989f71fbebd15de633c187d88cb3be3a0f2723.1616971780.git.unixbhaskar@gmail.com>
Cc: dave.jiang@intel.com, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 dmaengine@vger.kernel.org, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, hch@lst.de
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

On 29-03-21, 05:23, Bhaskar Chowdhury wrote:
> s/transferred/transfered/
> 
> This reverts commit a2ddb8aea8106bd5552f8516ad7a8a26b9282a8f.

This is not upstream, why not squash in. Also would make sense to write
sensible changelog and not phrases and use the right subsystem
conventions!

Droped the series now


-- 
~Vinod
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
