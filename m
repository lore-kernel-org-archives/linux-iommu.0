Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5257CC433DF
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 14:05:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB0A207D4
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 14:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB0A207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E7B9B86EA0;
	Mon, 18 May 2020 14:05:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jLQwmMsPW0rC; Mon, 18 May 2020 14:05:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 042A5877EC;
	Mon, 18 May 2020 14:05:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF195C0888;
	Mon, 18 May 2020 14:05:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C770C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 14:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E37752051C
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 14:05:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id quH+lvq46RFX for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 14:05:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by silver.osuosl.org (Postfix) with ESMTPS id 8C85B2047B
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 14:05:40 +0000 (UTC)
Received: from mail-pg1-f199.google.com ([209.85.215.199])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1jagOg-0003fA-Gm
 for iommu@lists.linux-foundation.org; Mon, 18 May 2020 14:05:38 +0000
Received: by mail-pg1-f199.google.com with SMTP id v1so8065078pgl.4
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 07:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=eAqYxR1VuKxANFGYDzoTuNI/yexhnse0Gr19klQrpbA=;
 b=HLpeop8X9NGl44UK3+7RSPwrZ3j6kVma3bbKZTwl3jJRN0+Ud4LRNmkhq0lEdiEzcG
 ALXS9JKUpuHf2VpbSkFpMNrUzNjhWBShjmO31bz3nZeWmuRVRcmh/RdlIbt8X9np4wsh
 1mGh6zb4DV5XrhtjsaN/Vpi/hyKMmhkOQ8Gw7/Ex1bXddBdsNlkIMsLej6kWA/7zuMq+
 S3Mcup/KqnnBlfuJQ95OyzRkwPFQL7+qcxIkgrh4EKOORHyfBGhmUTo/Tz/shQVIUHQh
 ZMCYHInmDqhHrIV8w9usqiN7LHFOno6Mda5f+Bvucbv5o0R1JrdEuaWdlZJFT8+3H5Yl
 OlSQ==
X-Gm-Message-State: AOAM531d5s4rkW0Vsuhl0FT39jj1DbzwhvsR7dNb1cXXAtdqWxwORZl9
 fjaXurH7sdcd+eqgJ9BEB9rE7cBSzOaw4ak6ZwyRTjsUBGX6x9t7i5ZRQ+TuzLTfp8180snKQdu
 jkv3t8SR29LcWjAFU1vuHNowi6kl/tsh0VhP5M2fwuIQt8+4=
X-Received: by 2002:a17:902:8344:: with SMTP id
 z4mr16353681pln.207.1589810736905; 
 Mon, 18 May 2020 07:05:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycffwbiHEQeNnNPZHbLIlc4DR6IBr7Axdu2pVGpb6ozEfZIbMcE3K2RMJRPR58CpoAsG+cNQ==
X-Received: by 2002:a17:902:8344:: with SMTP id
 z4mr16353654pln.207.1589810736557; 
 Mon, 18 May 2020 07:05:36 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net.
 [220.133.187.190])
 by smtp.gmail.com with ESMTPSA id a16sm7971187pfl.167.2020.05.18.07.05.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 May 2020 07:05:36 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [Regression] "iommu/amd: Relax locking in dma_ops path" makes tg3
 ethernet transmit queue timeout
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200518133209.GM8135@suse.de>
Date: Mon, 18 May 2020 22:05:33 +0800
Message-Id: <381D21C9-C913-4C33-A6F4-0440B5D11670@canonical.com>
References: <4E9B03FB-9DA5-4831-B4CE-A0AA645D3F22@canonical.com>
 <20200518133209.GM8135@suse.de>
To: Joerg Roedel <jroedel@suse.de>
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



> On May 18, 2020, at 21:32, Joerg Roedel <jroedel@suse.de> wrote:
> 
> On Mon, May 18, 2020 at 05:06:45PM +0800, Kai-Heng Feng wrote:
>> Particularly, as soon as the spinlock is removed, the issue can be reproduced.
>> Function domain_flush_complete() doesn't seem to affect the status.
>> 
>> However, the .map_page callback was removed by be62dbf554c5
>> ("iommu/amd: Convert AMD iommu driver to the dma-iommu api"), so
>> there's no easy revert for this issue.
>> 
>> This is still reproducible as of today's mainline kernel, v5.7-rc6.
> 
> Is there any error message from the IOMMU driver?
> 

As of mainline kernel, there's no error message from IOMMU driver.
There are some complains from v4.15-rc1:
https://pastebin.ubuntu.com/p/qn4TXkFxsc/

Kai-Heng
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
