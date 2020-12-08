Return-Path: <SRS0=rc6t=FM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5BEC4361B
	for <iommu@archiver.kernel.org>; Tue,  8 Dec 2020 13:53:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772CD23AA9
	for <iommu@archiver.kernel.org>; Tue,  8 Dec 2020 13:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772CD23AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0CA6186B52;
	Tue,  8 Dec 2020 13:53:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lip5GixboPKI; Tue,  8 Dec 2020 13:53:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 88C7B86B47;
	Tue,  8 Dec 2020 13:53:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71998C0FA7;
	Tue,  8 Dec 2020 13:53:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34E06C013B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 13:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 23E4A86B47
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 13:53:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id of9P4TQem-L4 for <iommu@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 13:53:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2C93F869E2
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 13:53:55 +0000 (UTC)
Date: Tue, 8 Dec 2020 13:53:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607435634;
 bh=LFoq8/eR7TIKRMZdILYL+wO0yPG8fc558hwEUuPwr6g=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=NSbHeUbj8aWhVYaylry/XkdI00uv05Z1updbz5+ZpK9VRu/ZKKHFWS1GYkwGRR/N6
 SdV1p4M3bShogON3QMV7nPiZJWNxvhvehTqR1i4n0U/8D3hj0+scGznrH722YSaIK8
 1xAXcY0ZpZnfGk+GkAcUb5aJSKIxJuHxKXL4FGELqqgjZyXNoVcBlVDxVw7EFno67M
 YQYkyUy8D2PeP4gQtlLvWZU9VkL20m2yNRt7p/mwiYHe4OEaYt4+zQpjyhUapSzIIb
 g0mTbS9XCdPO/9Sb5NUJfB53DnYCttSMzerNEYAsmnoMBMnLzc/sLMPTkHRJT88WE/
 ycOp6UPF5kS3Q==
From: Will Deacon <will@kernel.org>
To: Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Fix not checking return value
 about devm_add_action
Message-ID: <20201208135350.GA6274@willie-the-truck>
References: <1607429722-54861-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1607429722-54861-1-git-send-email-tiantao6@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jean-philippe@linaro.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com
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

On Tue, Dec 08, 2020 at 08:15:22PM +0800, Tian Tao wrote:
> Use devm_add_action_or_reset to avoid the situation where the release
> function is not called when devm_add_action returns an error.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
> v2:
> repositioning devm_add_action_or_reset in the function
> arm_smmu_setup_msis, and check the return value.
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2ddf5ec..b4d3b7d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2680,7 +2680,8 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
>  		ret = -ENOMEM;
>  	} else {
>  		cmdq->valid_map = bitmap;
> -		devm_add_action(smmu->dev, arm_smmu_cmdq_free_bitmap, bitmap);
> +		ret = devm_add_action_or_reset(smmu->dev,
> +					       arm_smmu_cmdq_free_bitmap, bitmap);
>  	}
>  
>  	return ret;
> @@ -2921,6 +2922,13 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>  		return;
>  	}
>  
> +	/* Add callback to free MSIs on teardown */
> +	ret = devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
> +	if (ret) {
> +		dev_warn(dev, "failed to add callback to free MSIs on teardown\n");
> +		return;

Honestly, wouldn't we just be better leaking memory in this case? Tearing
down the SMMU is a pretty specialist sport _anyway_, but this seems to throw
the baby out with the bath water by failing to initialise because we can't
defer freeing something that we've already allocated. I think we're better
off continuing and trying to get the device up and running.

In fact, the same applies to the cmdq 'valid_map' too -- why do we care?

WIll
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
