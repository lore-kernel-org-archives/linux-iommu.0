Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8E8C433EF
	for <iommu@archiver.kernel.org>; Mon, 20 Jun 2022 13:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB7C841845;
	Mon, 20 Jun 2022 13:38:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB7C841845
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MY0okBXn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2A_Cea64ZWnq; Mon, 20 Jun 2022 13:38:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9AE2741863;
	Mon, 20 Jun 2022 13:38:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9AE2741863
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73D39C0039;
	Mon, 20 Jun 2022 13:38:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA37EC002D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 13:38:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5CB260F95
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 13:38:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A5CB260F95
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=MY0okBXn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dhfyyma8w7tK for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 13:38:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 127EA60F93
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 127EA60F93
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 13:38:56 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5104A614A2;
 Mon, 20 Jun 2022 13:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33985C3411C;
 Mon, 20 Jun 2022 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1655732335;
 bh=+fFogW7MYgbcV+/+vdX3im2l7WY1OGpRvAvNxoxAPyI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MY0okBXnmX/EcirZ4FWy0Au4Y8zBCrkzVtpjevX0FoB6qwpJTz30gOQFAAt4oN6Wp
 DW3fpwxgyyETQUYYDXCMkZ3HFC4L2BRZ0in3174sgFIpi+tOiSnguvTwsE9p523sUu
 fFtI9jPYwiStyH0GgovpWMaPLWnOVLDFBXv5s+7c=
Date: Mon, 20 Jun 2022 15:38:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
Message-ID: <YrB4WLW/ZvKp1imo@kroah.com>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica>
 <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
 <YqrmdKNrYTCiS/MC@myrica>
 <d90e8ea5-2f18-2eda-b4b2-711083aa7ecd@linaro.org>
 <YrB1D9rv9G4h/BYU@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YrB1D9rv9G4h/BYU@myrica>
Cc: Yang Shen <shenyang39@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 linux-accelerators@lists.ozlabs.org
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

On Mon, Jun 20, 2022 at 02:24:31PM +0100, Jean-Philippe Brucker wrote:
> >From c7c2b051ec19285bbb973f8a2a5e58bb5326e00e Mon Sep 17 00:00:00 2001
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Date: Mon, 20 Jun 2022 10:10:41 +0100
> Subject: [PATCH] uacce: Tidy up locking
> 
> The uacce driver must deal with a possible removal of the parent driver
> or device at any time.

No it should not, if the reference counting logic is properly set up.
The parent driver should correctly tear things down here.

> At the moment there are several issues that may
> result in use-after-free. Tidy up the locking to handle module removal.

I don't think you did that, as module removal should never happen if a
file descriptor is opened as I previously mentioned.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
