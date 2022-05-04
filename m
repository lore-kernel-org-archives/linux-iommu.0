Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95030C433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 00:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2C08B405D9;
	Wed,  4 May 2022 00:52:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wLAqGZ_8Zr1m; Wed,  4 May 2022 00:52:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 02C0D40395;
	Wed,  4 May 2022 00:52:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE493C0032;
	Wed,  4 May 2022 00:52:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E70EC002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 00:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C972404CC
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 00:52:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DglrfKMQkIlu for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 00:52:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3556840395
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 00:52:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: dmitry.osipenko) with ESMTPSA id A66401F4433E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1651625544;
 bh=VHi2JQXOxZVX+vfNBsGibT8B9KC9CmTcEJVV5seb2ME=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cD2Qkx0zO0rJEAgHvaTzRnevQaJEOKtssl5WeGvASMCSVt+ZXT/dwV5n0FYs09wyE
 0If1OzaemkXfxr5y+tIhvw4gBcrdmKwbFADP+1C7QHw0ZpZgTJOdHp0XWlKp+6dlGa
 Ed+4aPl9r/96lBfpkmb/TmTK162/Ea8Epc2hkhvYAy9uox3LRLEjVRVryVJWoIrqwa
 65O+CcCk4Mz+wwdjqxfF+objr2GbvTMjV9vQjxsfkSLa41uIRtNtdGSf/K2UGJxIK9
 1LAQ71dWYdau3TRiQmse5AkC6HDRb0qkUVNPaTRTYjJrUI54WJYFGJro4mqK9PkgIp
 cd4q6Y4bYQMSQ==
Message-ID: <add31812-50d5-6cb0-3908-143c523abd37@collabora.com>
Date: Wed, 4 May 2022 03:52:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] drm/tegra: Stop using iommu_present()
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, thierry.reding@gmail.com
References: <1f7c304a79b8b8dd5d4716786cae7502a0cc31f5.1649684782.git.robin.murphy@arm.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <1f7c304a79b8b8dd5d4716786cae7502a0cc31f5.1649684782.git.robin.murphy@arm.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 dri-devel@lists.freedesktop.org, jonathanh@nvidia.com
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

On 4/11/22 16:46, Robin Murphy wrote:
> @@ -1092,6 +1092,19 @@ static bool host1x_drm_wants_iommu(struct host1x_device *dev)
>  	struct host1x *host1x = dev_get_drvdata(dev->dev.parent);
>  	struct iommu_domain *domain;
>  
> +	/* For starters, this is moot if no IOMMU is available */
> +	if (!device_iommu_mapped(&dev->dev))
> +		return false;

Unfortunately this returns false on T30 with enabled IOMMU because we
don't use IOMMU for Host1x on T30 [1] to optimize performance. We can't
change it until we will update drivers to support Host1x-dedicated buffers.

[1]
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/host1x/dev.c#L258

-- 
Best regards,
Dmitry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
