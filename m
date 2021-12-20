Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FD8C433EF
	for <iommu@archiver.kernel.org>; Mon, 20 Dec 2021 18:42:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C976A60AB2;
	Mon, 20 Dec 2021 18:42:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KHejQdmloD1a; Mon, 20 Dec 2021 18:42:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9DBA96058D;
	Mon, 20 Dec 2021 18:42:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72785C002F;
	Mon, 20 Dec 2021 18:42:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89BAAC0012
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 18:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69833824E3
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 18:42:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rbIjMZL8WFzk for <iommu@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 18:42:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8166082423
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 18:42:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C2BC6D;
 Mon, 20 Dec 2021 10:42:35 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 904723F774;
 Mon, 20 Dec 2021 10:42:30 -0800 (PST)
Message-ID: <b05183b4-e08a-77ff-219c-009a4e42a32b@arm.com>
Date: Mon, 20 Dec 2021 18:42:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 4/5] iommu/arm-smmu-v3: Add host support for NVIDIA
 Grace CMDQ-V
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org, will@kernel.org
References: <20211119071959.16706-1-nicolinc@nvidia.com>
 <20211119071959.16706-5-nicolinc@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211119071959.16706-5-nicolinc@nvidia.com>
Cc: jean-philippe@linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 thierry.reding@gmail.com, jgg@nvidia.com, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-11-19 07:19, Nicolin Chen wrote:
> From: Nate Watterson <nwatterson@nvidia.com>
> 
> NVIDIA's Grace Soc has a CMDQ-Virtualization (CMDQV) hardware,
> which extends the standard ARM SMMU v3 IP to support multiple
> VCMDQs with virtualization capabilities. In-kernel of host OS,
> they're used to reduce contention on a single queue. In terms
> of command queue, they are very like the standard CMDQ/ECMDQs,
> but only support CS_NONE in the CS field of CMD_SYNC command.
> 
> This patch adds a new nvidia-grace-cmdqv file and inserts its
> structure pointer into the existing arm_smmu_device, and then
> adds related function calls in the arm-smmu-v3 driver.
> 
> In the CMDQV driver itself, this patch only adds minimal part
> for host kernel support. Upon probe(), VINTF0 is reserved for
> in-kernel use. And some of the VCMDQs are assigned to VINTF0.
> Then the driver will select one of VCMDQs in the VINTF0 based
> on the CPU currently executing, to issue commands.

Is there a tangible difference to DMA API or VFIO performance?

[...]
> +struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> +{
> +	struct nvidia_grace_cmdqv *cmdqv = smmu->nvidia_grace_cmdqv;
> +	struct nvidia_grace_cmdqv_vintf *vintf0 = &cmdqv->vintf0;
> +	u16 qidx;
> +
> +	/* Check error status of vintf0 */
> +	if (!FIELD_GET(VINTF_STATUS, vintf0->status))
> +		return &smmu->cmdq;
> +
> +	/*
> +	 * Select a vcmdq to use. Here we use a temporal solution to
> +	 * balance out traffic on cmdq issuing: each cmdq has its own
> +	 * lock, if all cpus issue cmdlist using the same cmdq, only
> +	 * one CPU at a time can enter the process, while the others
> +	 * will be spinning at the same lock.
> +	 */
> +	qidx = smp_processor_id() % cmdqv->num_vcmdqs_per_vintf;

How does ordering work between queues? Do they follow a global order 
such that a sync on any queue is guaranteed to complete all prior 
commands on all queues?

The challenge to make ECMDQ useful to Linux is how to make sure that all 
the commands expected to be within scope of a future CMND_SYNC plus that 
sync itself all get issued on the same queue, so I'd be mildly surprised 
if you didn't have the same problem.

Robin.

> +	return &vintf0->vcmdqs[qidx];
> +}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
