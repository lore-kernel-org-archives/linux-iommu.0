Return-Path: <SRS0=ckUw=NL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCE0C4338F
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 10:41:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2E26056C
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 10:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA2E26056C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A73EE80F0C;
	Fri, 20 Aug 2021 10:41:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nca2JFUnXOQX; Fri, 20 Aug 2021 10:41:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7F9BD8105C;
	Fri, 20 Aug 2021 10:41:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 552B8C0010;
	Fri, 20 Aug 2021 10:41:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CAAEC000E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 10:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65AD340524
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 10:41:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GgVBIGI7IhWK for <iommu@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 10:41:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B0B0340542
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 10:41:16 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AF466056C;
 Fri, 20 Aug 2021 10:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629456076;
 bh=j9scAOD9ml/UjU+E7F1nVCcyussEtA5A5JvgyeOg91I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=b6qBWNapTru/r/hZvx1kh/qOf/LUCLhCu+jyhg6U+6/bwDsZbjR7nT9h6Tr8q/8DK
 QbC4uy2mDwgJl9FJ1RI8PM7U1FwCCV1ee+XecftAd0Py2JnLGfmOUfe3sKDM0EQUMq
 BXIYkgvwg1xwrgxyq6FIty9wQ07yVCVpsNeppcXLMFh+fv0loDJP3a0XpOxxd5myz7
 lkH0LQ7DMRmXlG9sgXfzvC5Js4emGsgzmYnLleREtLbix9RHlkS6UR22T6LNDO9DVP
 PPzp2WriBpjMxtMe+MyGGWgtLf9xxSwqfEWQBFQGHUo/vwxG03U5u+bdKuudswtz+j
 Lw621ZrsPzhvw==
Date: Fri, 20 Aug 2021 11:41:11 +0100
From: Will Deacon <will@kernel.org>
To: Yang Yingliang <yangyingliang@huawei.com>, joro@8bytes.org
Subject: Re: [PATCH -next] iommu/arm-smmu: Fix missing unlock on error in
 arm_smmu_device_group()
Message-ID: <20210820104111.GC17267@willie-the-truck>
References: <20210820074949.1946576-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210820074949.1946576-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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

On Fri, Aug 20, 2021 at 03:49:49PM +0800, Yang Yingliang wrote:
> Add the missing unlock before return from function arm_smmu_device_group()
> in the error handling case.
> 
> Fixes: b1a1347912a7 ("iommu/arm-smmu: Fix race condition during iommu_group creation")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 73893180ec7e..4bc75c4ce402 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1478,8 +1478,10 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
>  	mutex_lock(&smmu->stream_map_mutex);
>  	for_each_cfg_sme(cfg, fwspec, i, idx) {
>  		if (group && smmu->s2crs[idx].group &&
> -		    group != smmu->s2crs[idx].group)
> +		    group != smmu->s2crs[idx].group) {
> +			mutex_unlock(&smmu->stream_map_mutex);
>  			return ERR_PTR(-EINVAL);
> +		}

Urgh, I should really have spotted that in review. Thanks:

Acked-by: Will Deacon <will@kernel.org>

Joerg -- please can you throw this on top?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
