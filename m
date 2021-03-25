Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF653C433C1
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 17:48:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5D561A23
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 17:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5D561A23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E4CA84A58;
	Thu, 25 Mar 2021 17:48:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id evLUrIBLpFnu; Thu, 25 Mar 2021 17:48:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27AE984A4F;
	Thu, 25 Mar 2021 17:48:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA882C000D;
	Thu, 25 Mar 2021 17:48:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83650C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 17:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 64DCF84A4F
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 17:48:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GQbKsO_4nzAo for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 17:48:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 89E0684A4D
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 17:48:13 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E7BB619DC;
 Thu, 25 Mar 2021 17:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616694493;
 bh=9bFU3KcAiurrg1ZHvCw0obn8sWQePDYcL3Zjxhv6ikw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s5WFMQS2fck6GL6JJ8Cp9VF2PusZjfU5Z7nZgFEM3Bq4A1ZBGyhsP9jT8xLF8WdO9
 4vwrzvTlsrLRYVNO9573QCDOZniG0ycrTG3P5EBXnMgmesYKdZTiZeXvotS5KsVkJi
 L1ErN+CYj94NEd1DJxbVuFEgPiYSFYgwSH/1HtTbFy7p/NmaApRRk+7w8TbCape5z7
 6EPhIAY7IKUBG9FytVlRq3YbsfjOGiTR27nfVEk2FrkD2+kSnfq1et4beNr9//k/CA
 iWWiknNzRXecn7N0QYel9ssLZXTMZtP6dk6+g9g5gnq5zR3cSBFYcdIrhEet+quLHr
 hyfYxNVbFCqnw==
Date: Thu, 25 Mar 2021 17:48:07 +0000
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v13 07/10] iommu/arm-smmu-v3: Maintain a SID->device
 structure
Message-ID: <20210325174807.GD15504@willie-the-truck>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
 <20210302092644.2553014-8-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210302092644.2553014-8-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com,
 linux-acpi@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
 vivek.gautam@arm.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-accelerators@lists.ozlabs.org, guohanjun@huawei.com,
 zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

On Tue, Mar 02, 2021 at 10:26:43AM +0100, Jean-Philippe Brucker wrote:
> When handling faults from the event or PRI queue, we need to find the
> struct device associated with a SID. Add a rb_tree to keep track of
> SIDs.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  13 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 157 ++++++++++++++++----
>  2 files changed, 140 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index f985817c967a..7b15b7580c6e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -639,6 +639,15 @@ struct arm_smmu_device {
>  
>  	/* IOMMU core code handle */
>  	struct iommu_device		iommu;
> +
> +	struct rb_root			streams;
> +	struct mutex			streams_mutex;
> +};
> +
> +struct arm_smmu_stream {
> +	u32				id;
> +	struct arm_smmu_master		*master;
> +	struct rb_node			node;
>  };
>  
>  /* SMMU private data for each master */
> @@ -647,8 +656,8 @@ struct arm_smmu_master {
>  	struct device			*dev;
>  	struct arm_smmu_domain		*domain;
>  	struct list_head		domain_head;
> -	u32				*sids;
> -	unsigned int			num_sids;
> +	struct arm_smmu_stream		*streams;
> +	unsigned int			num_streams;
>  	bool				ats_enabled;
>  	bool				sva_enabled;
>  	struct list_head		bonds;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 7edce914c45e..d148bb6d4289 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -909,8 +909,8 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
>  
>  	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
>  	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> -		for (i = 0; i < master->num_sids; i++) {
> -			cmd.cfgi.sid = master->sids[i];
> +		for (i = 0; i < master->num_streams; i++) {
> +			cmd.cfgi.sid = master->streams[i].id;
>  			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
>  		}
>  	}
> @@ -1355,6 +1355,28 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
>  	return 0;
>  }
>  
> +/* smmu->streams_mutex must be held */

Can you add a lockdep assertion for that?

> +__maybe_unused
> +static struct arm_smmu_master *
> +arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
> +{
> +	struct rb_node *node;
> +	struct arm_smmu_stream *stream;
> +
> +	node = smmu->streams.rb_node;
> +	while (node) {
> +		stream = rb_entry(node, struct arm_smmu_stream, node);
> +		if (stream->id < sid)
> +			node = node->rb_right;
> +		else if (stream->id > sid)
> +			node = node->rb_left;
> +		else
> +			return stream->master;
> +	}
> +
> +	return NULL;
> +}

[...]

> +static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
> +				  struct arm_smmu_master *master)
> +{
> +	int i;
> +	int ret = 0;
> +	struct arm_smmu_stream *new_stream, *cur_stream;
> +	struct rb_node **new_node, *parent_node = NULL;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
> +
> +	master->streams = kcalloc(fwspec->num_ids, sizeof(*master->streams),
> +				  GFP_KERNEL);
> +	if (!master->streams)
> +		return -ENOMEM;
> +	master->num_streams = fwspec->num_ids;
> +
> +	mutex_lock(&smmu->streams_mutex);
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		u32 sid = fwspec->ids[i];
> +
> +		new_stream = &master->streams[i];
> +		new_stream->id = sid;
> +		new_stream->master = master;
> +
> +		/*
> +		 * Check the SIDs are in range of the SMMU and our stream table
> +		 */
> +		if (!arm_smmu_sid_in_range(smmu, sid)) {
> +			ret = -ERANGE;
> +			break;
> +		}
> +
> +		/* Ensure l2 strtab is initialised */
> +		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
> +			ret = arm_smmu_init_l2_strtab(smmu, sid);
> +			if (ret)
> +				break;
> +		}
> +
> +		/* Insert into SID tree */
> +		new_node = &(smmu->streams.rb_node);
> +		while (*new_node) {
> +			cur_stream = rb_entry(*new_node, struct arm_smmu_stream,
> +					      node);
> +			parent_node = *new_node;
> +			if (cur_stream->id > new_stream->id) {
> +				new_node = &((*new_node)->rb_left);
> +			} else if (cur_stream->id < new_stream->id) {
> +				new_node = &((*new_node)->rb_right);
> +			} else {
> +				dev_warn(master->dev,
> +					 "stream %u already in tree\n",
> +					 cur_stream->id);
> +				ret = -EINVAL;
> +				break;
> +			}
> +		}
> +		if (ret)
> +			break;
> +
> +		rb_link_node(&new_stream->node, parent_node, new_node);
> +		rb_insert_color(&new_stream->node, &smmu->streams);
> +	}
> +
> +	if (ret) {
> +		for (i--; i >= 0; i--)

Is 'i--' really what you want for the initial value? Doesn't that correspond
to the ID you *didn't* add to the tree?

> +			rb_erase(&master->streams[i].node, &smmu->streams);
> +		kfree(master->streams);

Do you need to NULLify master->streams and/or reset master->num_streams
after this? Seems like they're left dangling.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
