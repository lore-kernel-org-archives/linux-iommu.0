Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CC6C48BE6
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 10:10:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE5F61351
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 10:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE5F61351
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D3C8405F8;
	Wed, 16 Jun 2021 10:10:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q9qt7n14Z-kx; Wed, 16 Jun 2021 10:10:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CA4B9405E2;
	Wed, 16 Jun 2021 10:10:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B461C000E;
	Wed, 16 Jun 2021 10:10:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7704C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 10:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 936C9405ED
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 10:10:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iPEDbaEUqPvm for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 10:10:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 46A47405E2
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 10:10:13 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF237610CA;
 Wed, 16 Jun 2021 10:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623838212;
 bh=X0+/rDJpX4eUJJNLurdGpBB3S9X2r0erNZtNknqJ61U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qXsgoZel49cEgevfzK8vWXWlhSZuvdDiglh6SIe8IIzLjIsp0G9ojv9apdeaZymje
 dIEjE42vsnUhn2fBeVEg9GkrsNLr7Rj22m4tDVXe/DPLGm9fg6o+3bYKNMxU5fEdrb
 jKSpOh3mqC8AWCvOtYWjeZ7yYJqdVDqnIrlBUJ9BIWV9LuTbbXVkRcrw97ajaY4K2g
 Xb4LClMspkpLP/795P+ZBeShyqxV1rsxmZGVq5xQfJ8zrYgKM/qAQyif4CPXz4V6jF
 t3ao7zk3tyKhI8+4JqI1eFhmLf7MZyBqLSHqY1wzCX5/GqQmEmA50rADKvBIsgtLU2
 Fo2ozKccE4kUg==
Date: Wed, 16 Jun 2021 11:10:08 +0100
From: Will Deacon <will@kernel.org>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: remove unnecessary oom message
Message-ID: <20210616101007.GA22350@willie-the-truck>
References: <20210609125438.14369-1-thunder.leizhen@huawei.com>
 <20210611103220.GB15274@willie-the-truck>
 <2a0b7f37-156a-775f-ade4-015cade472c6@huawei.com>
 <20210615113417.GA20598@willie-the-truck>
 <ab17a9d3-fe8b-dcd8-1a69-81f5604cfe81@arm.com>
 <20210615115507.GD20598@willie-the-truck>
 <c94b7ba9-b85b-4704-6335-17334bc56f1b@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c94b7ba9-b85b-4704-6335-17334bc56f1b@huawei.com>
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

On Wed, Jun 16, 2021 at 09:47:18AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/6/15 19:55, Will Deacon wrote:
> > On Tue, Jun 15, 2021 at 12:51:38PM +0100, Robin Murphy wrote:
> >> On 2021-06-15 12:34, Will Deacon wrote:
> >>> On Tue, Jun 15, 2021 at 07:22:10PM +0800, Leizhen (ThunderTown) wrote:
> >>>>
> >>>>
> >>>> On 2021/6/11 18:32, Will Deacon wrote:
> >>>>> On Wed, Jun 09, 2021 at 08:54:38PM +0800, Zhen Lei wrote:
> >>>>>> Fixes scripts/checkpatch.pl warning:
> >>>>>> WARNING: Possible unnecessary 'out of memory' message
> >>>>>>
> >>>>>> Remove it can help us save a bit of memory.
> >>>>>>
> >>>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>>>>> ---
> >>>>>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++------
> >>>>>>   1 file changed, 2 insertions(+), 6 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> >>>>>> index 2ddc3cd5a7d1..fd7c55b44881 100644
> >>>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> >>>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> >>>>>> @@ -2787,10 +2787,8 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
> >>>>>>   	void *strtab = smmu->strtab_cfg.strtab;
> >>>>>>   	cfg->l1_desc = devm_kzalloc(smmu->dev, size, GFP_KERNEL);
> >>>>>> -	if (!cfg->l1_desc) {
> >>>>>> -		dev_err(smmu->dev, "failed to allocate l1 stream table desc\n");
> >>>>>> +	if (!cfg->l1_desc)
> >>>>>
> >>>>> What error do you get if devm_kzalloc() fails? I'd like to make sure it's
> >>>>> easy to track down _which_ allocation failed in that case -- does it give
> >>>>> you a line number, for example?
> >>>>
> >>>> When devm_kzalloc() fails, the OOM information is printed. No line number information, but the
> >>>> size(order) and call stack is printed. It doesn't matter which allocation failed, the failure
> >>>> is caused by insufficient system memory rather than the fault of the SMMU driver. Therefore,
> >>>> the current printing is not helpful for locating the problem of insufficient memory. After all,
> >>>> when memory allocation fails, the SMMU driver cannot work at a lower specification.
> >>>
> >>> I don't entirely agree. Another reason for the failure is because the driver
> >>> might be asking for a huge (or negative) allocation, in which case it might
> >>> be instructive to have a look at the actual caller, particularly if the
> >>> size is derived from hardware or firmware properties.
> >>
> >> Agreed - other than deliberately-contrived situations I don't think I've
> >> ever hit a genuine OOM, but I definitely have debugged attempts to allocate
> >> -1 of something. If the driver-specific message actually calls out the
> >> critical information, e.g. "failed to allocate %d stream table entries", it
> >> gives debugging a head start since the miscalculation is obvious, but a
> >> static message that only identifies the callsite really only saves a quick
> >> trip to scripts/faddr2line, and personally I've never found that
> >> particularly valuable.
> > 
> > So it sounds like this particular patch is fine, but the one for smmuv2
> > should leave the IRQ allocation message alone (by virtue of it printing
> > something a bit more useful -- the number of irqs).
> 
>         num_irqs = 0;
>         while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
>                 num_irqs++;
>         }
> 
> As the above code, num_irqs is calculated based on the number of dtb or acpi
> configuration items, it can't be too large. That is, there is almost zero chance
> that devm_kcalloc() will fail because num_irqs is too large.

Right, because firmware is never wrong about anything :)

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
