Return-Path: <SRS0=gESx=YZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E322FC47E49
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 16:28:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9FD920656
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 16:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWIoDTqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FD920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 62B81FC1;
	Fri,  1 Nov 2019 16:28:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 357CEDAC
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 16:28:30 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E031187C
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 16:28:29 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 285742080F;
	Fri,  1 Nov 2019 16:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572625709;
	bh=AGQ8iiY4Sv5ExrC2tV2HF7L3Htvu/REfvE6er7pPcDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWIoDTqvjr1SCA/3GbYgq+sLE9RAhMhlWeB1gGurTUZhTOIvM7KnkzLcVdTA5gedp
	uAwRBvfPV03Q9adG3rLnJwhDhpqJDlKRj+Wct6rHI3OlwDxhXDqNkRnLPE+CSK/k4r
	Fu02H3jtWb+tXTEXJgoOjKmVtX6ZO2qWHQZt38Ko=
Date: Fri, 1 Nov 2019 16:28:24 +0000
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: avoid pathological RPM behaviour for
	unmaps
Message-ID: <20191101162824.GB3603@willie-the-truck>
References: <20191031213102.17108-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191031213102.17108-1-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Rob Clark <robdclark@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
	open list <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, Oct 31, 2019 at 02:31:02PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> When games, browser, or anything using a lot of GPU buffers exits, there
> can be many hundreds or thousands of buffers to unmap and free.  If the
> GPU is otherwise suspended, this can cause arm-smmu to resume/suspend
> for each buffer, resulting 5-10 seconds worth of reprogramming the
> context bank (arm_smmu_write_context_bank()/arm_smmu_write_s2cr()/etc).
> To the user it would appear that the system just locked up.
> 
> A simple solution is to use pm_runtime_put_autosuspend() instead, so we
> don't immediately suspend the SMMU device.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/iommu/arm-smmu.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 7c503a6bc585..5abc0d210d90 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -122,7 +122,7 @@ static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
>  static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>  {
>  	if (pm_runtime_enabled(smmu->dev))
> -		pm_runtime_put(smmu->dev);
> +		pm_runtime_put_autosuspend(smmu->dev);
>  }
>  
>  static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
> @@ -1154,6 +1154,20 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	/* Looks ok, so add the device to the domain */
>  	ret = arm_smmu_domain_add_master(smmu_domain, fwspec);
>  
> +	/*
> +	 * Setup an autosuspend delay to avoid bouncing runpm state.
> +	 * Otherwise, if a driver for a suspendend consumer device

I fixed this typo and applied with Robin's reviewed-by from before.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
