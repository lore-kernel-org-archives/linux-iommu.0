Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01C5C4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 18:25:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478E460724
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 18:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 478E460724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1376B606B4;
	Tue, 10 Aug 2021 18:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LpXzXYR_jOEi; Tue, 10 Aug 2021 18:25:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CAED6605D1;
	Tue, 10 Aug 2021 18:25:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1B64C001A;
	Tue, 10 Aug 2021 18:25:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B0F6C000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 18:25:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1DA2381C71
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 18:25:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R-05MYk0VuVp for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 18:24:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9CE1E81B84
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 18:24:59 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 159936056C;
 Tue, 10 Aug 2021 18:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628619899;
 bh=XbSvD674RGlSPfIxav1H631OYTL4qbTMztVKJu94RmE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DP2yJU21UM40aoq+olIUxsGijAPx/54KDW0L2HA9jcuB1s+ob8A/qEGqH/gcz4Rt/
 k3iS9l6IciBEPaKctYkl2yetJYVe+XwpYQ1BEkg+dZ5tbX6r8tUUfbk057P2kSZtAR
 hZFuezBTIUpwZzyO6ItV0yJlvISdEuGVKBhNb3f373gCXm4U58DjStb+oJgC6hS6qI
 OTHGqyaPt5CtqkCgDXGYFqBpva3OaIKo3fwTPU1xbHaP16id6w77LpiO5fWvZchRN/
 zoojfv8EZAOYTrNjppNhBoAbrnYL2DYTz7E6rEUMDJrXuCDaG5ffmuU4+WD89C3mMa
 j5cdq7t96Dxew==
Date: Tue, 10 Aug 2021 19:24:54 +0100
From: Will Deacon <will@kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH RFC 2/8] iommu/arm-smmu-v3: Add and use static helper
 function arm_smmu_cmdq_issue_cmd_with_sync()
Message-ID: <20210810182454.GB3296@willie-the-truck>
References: <20210626110130.2416-1-thunder.leizhen@huawei.com>
 <20210626110130.2416-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210626110130.2416-3-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Robin Murphy <robin.murphy@arm.com>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
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

On Sat, Jun 26, 2021 at 07:01:24PM +0800, Zhen Lei wrote:
> The obvious key to the performance optimization of commit 587e6c10a7ce
> ("iommu/arm-smmu-v3: Reduce contention during command-queue insertion") is
> to allow multiple cores to insert commands in parallel after a brief mutex
> contention.
> 
> Obviously, inserting as many commands at a time as possible can reduce the
> number of times the mutex contention participates, thereby improving the
> overall performance. At least it reduces the number of calls to function
> arm_smmu_cmdq_issue_cmdlist().
> 
> Therefore, function arm_smmu_cmdq_issue_cmd_with_sync() is added to insert
> the 'cmd+sync' commands at a time.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++--------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2433d3c29b49ff2..a5361153ca1d6a4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -858,11 +858,25 @@ static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>  	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, false);
>  }
>  
> -static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
> +static int __maybe_unused arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>  {
>  	return arm_smmu_cmdq_issue_cmdlist(smmu, NULL, 0, true);
>  }
>  
> +static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
> +					     struct arm_smmu_cmdq_ent *ent)
> +{
> +	u64 cmd[CMDQ_ENT_DWORDS];
> +
> +	if (arm_smmu_cmdq_build_cmd(cmd, ent)) {
> +		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
> +			 ent->opcode);
> +		return -EINVAL;
> +	}
> +
> +	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, true);
> +}

This function is almost identical to arm_smmu_cmdq_issue_cmd(). How about
moving the guts out into a helper:

	static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
					     struct arm_smmu_cmdq_ent *ent,
					     bool sync);

and then having arm_smmu_cmdq_issue_cmd_with_sync() and
arm_smmu_cmdq_issue_cmd() wrap that?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
