Return-Path: <SRS0=+KdK=3D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F61C33CB2
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 11:07:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F90206D5
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 11:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUXDxIj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F90206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 439A085BFA;
	Tue, 14 Jan 2020 11:07:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oqVNbKbuRCDP; Tue, 14 Jan 2020 11:07:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8BB2885514;
	Tue, 14 Jan 2020 11:07:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F8D3C1D83;
	Tue, 14 Jan 2020 11:07:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B033C077D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 11:07:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4215F85701
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 11:07:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d6hZdSdAFCWG for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jan 2020 11:06:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C170C8546F
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 11:06:58 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C6F0206D5;
 Tue, 14 Jan 2020 11:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579000018;
 bh=NUepL9I8VxhkL/G0N0NYGcEM4cH+wKLTDcaEIcpguBw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZUXDxIj3k1xuPdIk/43rzWfhLIyHVCsu6peTMrszGiIL2GjqQGiwJBY+YMhXjZ9Qu
 hYIVZExluD75rG7RLmMDyAZDrmqM0ooSK5PGWTvVRgb5PqsNA9meXdzClU84zB9kZu
 vjyxEKvFPeISAkzr+LkiY2R4VxGgYDHQba/bS0es=
Date: Tue, 14 Jan 2020 11:06:52 +0000
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 06/13] iommu/arm-smmu-v3: Add context descriptor
 tables allocators
Message-ID: <20200114110651.GA29222@willie-the-truck>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20191219163033.2608177-7-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191219163033.2608177-7-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 sudeep.holla@arm.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, guohanjun@huawei.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
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

On Thu, Dec 19, 2019 at 05:30:26PM +0100, Jean-Philippe Brucker wrote:
> Support for SSID will require allocating context descriptor tables. Move
> the context descriptor allocation to separate functions.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 57 ++++++++++++++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index b287e303b1d7..43d6a7ded6e4 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -568,6 +568,7 @@ struct arm_smmu_cd_table {
>  struct arm_smmu_s1_cfg {
>  	struct arm_smmu_cd_table	table;
>  	struct arm_smmu_ctx_desc	cd;
> +	u8				s1cdmax;
>  };
>  
>  struct arm_smmu_s2_cfg {
> @@ -1455,6 +1456,31 @@ static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>  }
>  
>  /* Context descriptor manipulation functions */
> +static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
> +					struct arm_smmu_cd_table *table,
> +					size_t num_entries)
> +{
> +	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
> +
> +	table->ptr = dmam_alloc_coherent(smmu->dev, size, &table->ptr_dma,
> +					 GFP_KERNEL);
> +	if (!table->ptr) {
> +		dev_warn(smmu->dev,
> +			 "failed to allocate context descriptor table\n");
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +static void arm_smmu_free_cd_leaf_table(struct arm_smmu_device *smmu,
> +					struct arm_smmu_cd_table *table,
> +					size_t num_entries)
> +{
> +	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
> +
> +	dmam_free_coherent(smmu->dev, size, table->ptr, table->ptr_dma);
> +}

I think we'd be better off taking the 'arm_smmu_s1_cfg' as a parameter here
instead of the table pointer and a num_entries value, since the code above
implies that we support partial freeing of the context descriptors.

I can do that as a follow-up patch if you agree. Thoughts?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
