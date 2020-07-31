Return-Path: <SRS0=v9UM=BK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B68C433E0
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 12:43:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E87921D95
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 12:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGGoPa3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E87921D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1C50E86A47;
	Fri, 31 Jul 2020 12:43:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vjcI02sloBah; Fri, 31 Jul 2020 12:43:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A49FF8623F;
	Fri, 31 Jul 2020 12:43:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DFEBC004F;
	Fri, 31 Jul 2020 12:43:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80112C004D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 12:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6E13D88688
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 12:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LY1-UjEuvJsM for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 12:43:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0038A885C4
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 12:43:56 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 563B821744;
 Fri, 31 Jul 2020 12:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596199436;
 bh=b5/U1wgoIEPrdzMA84HkS4OihCc1YAbTQnQ8sQla5qo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TGGoPa3FxkRdtMK/f/PzpAV8qgydfvN+CZpjMwMMxC81tqLtHZ+BUo7AK97f77XMy
 VMotX5EhFMJ2IAnM+AYie7MEGfR55Oi45K48InpniY0VQ6LwCANR6uLiUTtMHMzNmC
 WWYR3i+AF5dICfdDJXeEkAWvqglLwxDEp0h1YsNY=
Date: Fri, 31 Jul 2020 13:43:52 +0100
From: Will Deacon <will@kernel.org>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: disable MSI polling if SEV polling
 is faster
Message-ID: <20200731124351.GC26817@willie-the-truck>
References: <20200731083343.18152-1-song.bao.hua@hisilicon.com>
 <a425bd85-4872-bf1a-d273-c605c68fa9e1@huawei.com>
 <B926444035E5E2439431908E3842AFD25CFDC3@DGGEMI525-MBS.china.huawei.com>
 <20200731122149.GA26817@willie-the-truck>
 <B926444035E5E2439431908E3842AFD25D003C@DGGEMI525-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <B926444035E5E2439431908E3842AFD25D003C@DGGEMI525-MBS.china.huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Linuxarm <linuxarm@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Fri, Jul 31, 2020 at 12:30:27PM +0000, Song Bao Hua (Barry Song) wrote:
> Thanks for your comment. I had a patch with command line option as below.
> If it is what you prefer, I'd refine this one and send.
> 
> [PATCH] iommu/arm-smmu-v3: permit users to disable msi polling
> ---
>  drivers/iommu/arm-smmu-v3.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index f578677a5c41..4fb1681308e4 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -418,6 +418,11 @@ module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
>  MODULE_PARM_DESC(disable_bypass,
>  	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
>  
> +static bool disable_msipolling = 1;
> +module_param_named(disable_msipolling, disable_msipolling, bool, S_IRUGO);
> +MODULE_PARM_DESC(disable_msipolling,
> +	"Don't use MSI to poll the completion of CMD_SYNC if it is slower than SEV");

Reword this to "Disable MSI-based polling for CMD_SYNC completion."

> +
>  enum pri_resp {
>  	PRI_RESP_DENY = 0,
>  	PRI_RESP_FAIL = 1,
> @@ -992,7 +997,7 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
>  	 * Beware that Hi16xx adds an extra 32 bits of goodness to its MSI
>  	 * payload, so the write will zero the entire command on that platform.
>  	 */
> -	if (smmu->features & ARM_SMMU_FEAT_MSI &&
> +	if (!disable_msipolling && smmu->features & ARM_SMMU_FEAT_MSI &&
>  	    smmu->features & ARM_SMMU_FEAT_COHERENCY) {

Probably now cleaner to wrap this up into a helper:

static bool arm_smmu_use_msipolling(struct arm_smmu_device *smmu)
{
	return !disable_msipolling &&
	       smmu->features & ARM_SMMU_FEAT_COHERENCY &&
	       smmu->features & ARM_SMMU_FEAT_MSI;
}

>  		ent.sync.msiaddr = q->base_dma + Q_IDX(&q->llq, prod) *
>  				   q->ent_dwords * 8;
> @@ -1332,7 +1337,7 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
>  static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
>  					 struct arm_smmu_ll_queue *llq)
>  {
> -	if (smmu->features & ARM_SMMU_FEAT_MSI &&
> +	if (!disable_msipolling && smmu->features & ARM_SMMU_FEAT_MSI &&
>  	    smmu->features & ARM_SMMU_FEAT_COHERENCY)

Then you can use the new helper here too.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
