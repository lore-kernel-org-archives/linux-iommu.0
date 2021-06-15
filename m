Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79CCC48BDF
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 11:36:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F49E61459
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 11:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F49E61459
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C568607F2;
	Tue, 15 Jun 2021 11:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jQm8edm6QprN; Tue, 15 Jun 2021 11:36:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E6EF66059F;
	Tue, 15 Jun 2021 11:36:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94FBAC000E;
	Tue, 15 Jun 2021 11:36:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3651CC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 11:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F3B5605C1
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 11:36:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zB6btWC03tFh for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 11:36:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85FA86059F
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 11:36:50 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42F3061455;
 Tue, 15 Jun 2021 11:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623757010;
 bh=zqO83SQtJrXsIa4nUcU7jcNl8x0S+gRKQQ7dM+nMLIc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O/OkMVQ30RWM0NcjsZ2o5QxEu/MSYmxuUw7zcT0IyoGsQ5MZQoiLTyVpOYN2rIUs+
 203tZixBo9RSgPONjH+aDtMhYbhTezNpeWA6zCJB6JtDGq8enJD9Jqze6aiT8RKrAv
 +beXksJVOknD9c8dLO/jU350yWtU8I/R+POvjySt19Vq/AecIl6TG8l6DyeXBRSBjo
 FFwK+3vwci5sGjfP4TWxcKwotz3vtpz+gbuRwj7b+BNLYrhwe+8vWx91uwZfB7cg53
 6i8GXM2ndwB7VRSWm8H7gG9ZumXZcFsjcFQh4XX/nsCsDqd8IKHqDYJIY5vR1rrxCf
 TLYjM4XA/dGSg==
Date: Tue, 15 Jun 2021 12:36:46 +0100
From: Will Deacon <will@kernel.org>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: remove unnecessary oom message
Message-ID: <20210615113645.GB20598@willie-the-truck>
References: <20210609125438.14369-1-thunder.leizhen@huawei.com>
 <20210611103220.GB15274@willie-the-truck>
 <2a0b7f37-156a-775f-ade4-015cade472c6@huawei.com>
 <20210615113417.GA20598@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210615113417.GA20598@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Robin Murphy <robin.murphy@arm.com>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Tue, Jun 15, 2021 at 12:34:17PM +0100, Will Deacon wrote:
> On Tue, Jun 15, 2021 at 07:22:10PM +0800, Leizhen (ThunderTown) wrote:
> > 
> > 
> > On 2021/6/11 18:32, Will Deacon wrote:
> > > On Wed, Jun 09, 2021 at 08:54:38PM +0800, Zhen Lei wrote:
> > >> Fixes scripts/checkpatch.pl warning:
> > >> WARNING: Possible unnecessary 'out of memory' message
> > >>
> > >> Remove it can help us save a bit of memory.
> > >>
> > >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > >> ---
> > >>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++------
> > >>  1 file changed, 2 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > >> index 2ddc3cd5a7d1..fd7c55b44881 100644
> > >> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > >> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > >> @@ -2787,10 +2787,8 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
> > >>  	void *strtab = smmu->strtab_cfg.strtab;
> > >>  
> > >>  	cfg->l1_desc = devm_kzalloc(smmu->dev, size, GFP_KERNEL);
> > >> -	if (!cfg->l1_desc) {
> > >> -		dev_err(smmu->dev, "failed to allocate l1 stream table desc\n");
> > >> +	if (!cfg->l1_desc)
> > > 
> > > What error do you get if devm_kzalloc() fails? I'd like to make sure it's
> > > easy to track down _which_ allocation failed in that case -- does it give
> > > you a line number, for example?
> > 
> > When devm_kzalloc() fails, the OOM information is printed. No line number information, but the
> > size(order) and call stack is printed. It doesn't matter which allocation failed, the failure
> > is caused by insufficient system memory rather than the fault of the SMMU driver. Therefore,
> > the current printing is not helpful for locating the problem of insufficient memory. After all,
> > when memory allocation fails, the SMMU driver cannot work at a lower specification.
> 
> I don't entirely agree. Another reason for the failure is because the driver
> might be asking for a huge (or negative) allocation, in which case it might
> be instructive to have a look at the actual caller, particularly if the
> size is derived from hardware or firmware properties.

That said, the callstack would solve this problem, so I think that's good
enough.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
