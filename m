Return-Path: <SRS0=BH3E=XF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAEAC49ED7
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 15:01:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F61E2082C
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 15:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F61E2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2AD77DD9;
	Tue, 10 Sep 2019 15:01:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6385EDC5
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 15:01:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id DB8968A2
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 15:01:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65DD228;
	Tue, 10 Sep 2019 08:01:40 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C724B3F71F;
	Tue, 10 Sep 2019 08:01:38 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu: fix "hang" when games exit
To: Rob Clark <robdclark@gmail.com>, iommu@lists.linux-foundation.org
References: <20190907175013.24246-1-robdclark@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <418d8426-f299-1269-2b2e-f86677cf22c2@arm.com>
Date: Tue, 10 Sep 2019 16:01:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190907175013.24246-1-robdclark@gmail.com>
Content-Language: en-GB
Cc: Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
	freedreno@lists.freedesktop.org, "moderated list:ARM SMMU DRIVERS"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 07/09/2019 18:50, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> When games, browser, or anything using a lot of GPU buffers exits, there
> can be many hundreds or thousands of buffers to unmap and free.  If the
> GPU is otherwise suspended, this can cause arm-smmu to resume/suspend
> for each buffer, resulting 5-10 seconds worth of reprogramming the
> context bank (arm_smmu_write_context_bank()/arm_smmu_write_s2cr()/etc).
> To the user it would appear that the system is locked up.
> 
> A simple solution is to use pm_runtime_put_autosuspend() instead, so we
> don't immediately suspend the SMMU device.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> Note: I've tied the autosuspend enable/delay to the consumer device,
> based on the reasoning that if the consumer device benefits from using
> an autosuspend delay, then it's corresponding SMMU probably does too.
> Maybe that is overkill and we should just unconditionally enable
> autosuspend.

I'm not sure there's really any reason to expect that a supplier's usage 
model when doing things for itself bears any relation to that of its 
consumer(s), so I'd certainly lean towards the "unconditional" argument 
myself.

Of course ideally we'd skip resuming altogether in the map/unmap paths 
(since resume implies a full TLB reset anyway), but IIRC that approach 
started to get messy in the context of the initial RPM patchset. I'm 
planning to fiddle around a bit more to clean up the implementation of 
the new iommu_flush_ops stuff, so I've made a note to myself to revisit 
RPM to see if there's a sufficiently clean way to do better. In the 
meantime, though, I don't have any real objection to using some 
reasonable autosuspend delay on the principle that if we've been woken 
up to map/unmap one page, there's a high likelihood that more will 
follow in short order (and in the configuration slow-paths it won't have 
much impact either way).

Robin.

>   drivers/iommu/arm-smmu.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index c2733b447d9c..73a0dd53c8a3 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -289,7 +289,7 @@ static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
>   static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>   {
>   	if (pm_runtime_enabled(smmu->dev))
> -		pm_runtime_put(smmu->dev);
> +		pm_runtime_put_autosuspend(smmu->dev);
>   }
>   
>   static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
> @@ -1445,6 +1445,15 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   	/* Looks ok, so add the device to the domain */
>   	ret = arm_smmu_domain_add_master(smmu_domain, fwspec);
>   
> +#ifdef CONFIG_PM
> +	/* TODO maybe device_link_add() should do this for us? */
> +	if (dev->power.use_autosuspend) {
> +		pm_runtime_set_autosuspend_delay(smmu->dev,
> +			dev->power.autosuspend_delay);
> +		pm_runtime_use_autosuspend(smmu->dev);
> +	}
> +#endif
> +
>   rpm_put:
>   	arm_smmu_rpm_put(smmu);
>   	return ret;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
