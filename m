Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BD3C4338F
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 16:12:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5678661102
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 16:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5678661102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22B2360848;
	Mon,  2 Aug 2021 16:12:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r54_v520bXSf; Mon,  2 Aug 2021 16:12:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EA03D6063C;
	Mon,  2 Aug 2021 16:12:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C374FC001B;
	Mon,  2 Aug 2021 16:12:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F677C000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 16:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D7A8403D9
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 16:12:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WJbWYAn5d6eJ for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 16:12:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AABA3400EF
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 16:12:12 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E9EA60F9C;
 Mon,  2 Aug 2021 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627920732;
 bh=b2Ng61RAPlMVP2k8p8ptM8+ZLyJnqh59TBkLJy5ROis=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FB6RhytU9h1IMIKzRWu6GmLzfCEBjk6A6rHDieSWy6K/7PP1AFgKx9dq2kwTHFCzd
 96MaL/uwcP5Fa2sUBheTQ6kHqmxsFUaNqmPubydLZvP96CB2xWespEO0qCy4S4bf1s
 64Wn5fBpxIwpst/c9+Uue/GKmDdOf7CbaeqxCeCc7U1ZWCmNcD8Ukah0f1QYNfSNMH
 pmVu5gX6k4DPHSTUAAbIfNp97VAE7oHns/Gz1vxI3UGZRR3x4pvo/i/vVyluLojbRb
 44MjxhWYGFkSZkPEruKKiiwocVA2+J5Yct+2FsADX+6Y9o4Ld+VfGByp9IedbE3py5
 LmcCM5PZdGYVA==
Date: Mon, 2 Aug 2021 17:12:06 +0100
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH] iommu/arm-smmu: Add clk_bulk_{prepare/unprepare} to
 system pm callbacks
Message-ID: <20210802161206.GA29168@willie-the-truck>
References: <20210727093322.13202-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210727093322.13202-1-saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Taniya Das <tdas@codeaurora.org>, robdclark@chromium.org,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, srimuc <srimuc@codeaurora.org>,
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

On Tue, Jul 27, 2021 at 03:03:22PM +0530, Sai Prakash Ranjan wrote:
> Some clocks for SMMU can have parent as XO such as gpu_cc_hub_cx_int_clk
> of GPU SMMU in QTI SC7280 SoC and in order to enter deep sleep states in
> such cases, we would need to drop the XO clock vote in unprepare call and
> this unprepare callback for XO is in RPMh (Resource Power Manager-Hardened)
> clock driver which controls RPMh managed clock resources for new QTI SoCs
> and is a blocking call.
> 
> Given we cannot have a sleeping calls such as clk_bulk_prepare() and
> clk_bulk_unprepare() in arm-smmu runtime pm callbacks since the iommu
> operations like map and unmap can be in atomic context and are in fast
> path, add this prepare and unprepare call to drop the XO vote only for
> system pm callbacks since it is not a fast path and we expect the system
> to enter deep sleep states with system pm as opposed to runtime pm.
> 
> This is a similar sequence of clock requests (prepare,enable and
> disable,unprepare) in arm-smmu probe and remove.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Co-developed-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)

[+Rob]

How does this work with that funny GPU which writes to the SMMU registers
directly? Does the SMMU need to remain independently clocked for that to
work or is it all in the same clock domain?

> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index d3c6f54110a5..9561ba4c5d39 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2277,6 +2277,13 @@ static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>  
>  static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>  {
> +	int ret;
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
> +	ret = clk_bulk_prepare(smmu->num_clks, smmu->clks);
> +	if (ret)
> +		return ret;
> +
>  	if (pm_runtime_suspended(dev))
>  		return 0;

If we subsequently fail to enable the clks in arm_smmu_runtime_resume()
should we unprepare them again?

Will

> @@ -2285,10 +2292,19 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>  
>  static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
>  {
> +	int ret = 0;
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
>  	if (pm_runtime_suspended(dev))
> -		return 0;
> +		goto clk_unprepare;
>  
> -	return arm_smmu_runtime_suspend(dev);
> +	ret = arm_smmu_runtime_suspend(dev);
> +	if (ret)
> +		return ret;
> +
> +clk_unprepare:
> +	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
> +	return ret;
>  }
>  
>  static const struct dev_pm_ops arm_smmu_pm_ops = {
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
