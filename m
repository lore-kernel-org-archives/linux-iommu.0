Return-Path: <SRS0=mcPB=OE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD4EC433F5
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 09:08:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF9A960E97
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 09:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF9A960E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A4BB403E9;
	Tue, 14 Sep 2021 09:08:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a0Ca0a8ajn9F; Tue, 14 Sep 2021 09:08:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8B3AE403DD;
	Tue, 14 Sep 2021 09:08:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32912C000F;
	Tue, 14 Sep 2021 09:08:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22F4BC000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 09:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F040E80E1F
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 09:08:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tjS8CL-JfZ1f for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 09:08:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7779980E17
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 09:08:16 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60FA660E97;
 Tue, 14 Sep 2021 09:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1631610496;
 bh=3NSSJD/hUlD51TGtARk9UEMG5P8iV1pAjCtLdqOmFqE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gDIWrQO8/RKpruPUxvwf/Sj9HEmQ7iwkPPA6M9FqXUGB+8QJ3m/jVdYkjUiWlL1cv
 /ucrJIbWnYYZFyexK97osyzDFyf+r7FVOtpGYN6+CpxxFU1ibIc8IIDwlYKdgtxlMU
 kMCEu2P/DItYWd9idJzG9NBbp+PHXZ/8Mju1OvLE=
Date: Tue, 14 Sep 2021 11:08:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bixuan Cui <cuibixuan@huawei.com>
Subject: Re: [PATCH -next v3 1/2] platform-msi: Save the msg context to desc
 in platform_msi_write_msg()
Message-ID: <YUBmfXx5rVCrFVI/@kroah.com>
References: <20210828063916.39633-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210828063916.39633-1-cuibixuan@huawei.com>
Cc: jean-philippe@linaro.org, maz@kernel.org, rafael@kernel.org,
 will@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On Sat, Aug 28, 2021 at 02:39:14PM +0800, Bixuan Cui wrote:
> Save the msg context to desc when the msi interrupt is requested.
> The drivers can use it in special scenarios(such as resume).
> 
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
>  drivers/base/platform-msi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index 3d6c8f9caf43..60962a224fcc 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -90,6 +90,9 @@ static void platform_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
>  
>  	priv_data = desc->platform.msi_priv_data;
>  
> +	desc->msg.address_lo = msg->address_lo;
> +	desc->msg.address_hi = msg->address_hi;
> +	desc->msg.data = msg->data;
>  	priv_data->write_msg(desc, msg);
>  }
>  
> -- 
> 2.17.1
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
