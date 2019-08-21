Return-Path: <SRS0=Juc9=WR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE44C3A59E
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 12:05:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D4622CF7
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 12:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJQMXCeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D4622CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 31393F85;
	Wed, 21 Aug 2019 12:05:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 23957F75
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 12:05:20 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 56B0C89E
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 12:05:18 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A73982089E;
	Wed, 21 Aug 2019 12:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566389118;
	bh=5Sh2+WP2x9AdtA4AaPxS+nHcYtV0WYYMvsvQ6+udKUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJQMXCeDwHAS18qo8h5FW9zsjkJbkK8pKf8uWacSRdQueflNv4I07bq17qPY5zZOZ
	LUdR82vLRiL3epdrSy83MyRyWkuIQKmY/D9n5RiGXXGclCChh/j/l9RMCqPvnjsMy6
	zqU9sIcpPlsUiW2HQqS+bZd+Y/WB9RCHvh3Y4RHY=
Date: Wed, 21 Aug 2019 13:05:12 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 10/13] iommu/io-pgtable: Replace ->tlb_add_flush() with
	->tlb_add_page()
Message-ID: <20190821120512.4ihfyh4eqsnst6xh@willie-the-truck>
References: <20190814175634.21081-1-will@kernel.org>
	<20190814175634.21081-11-will@kernel.org>
	<6e54ef6f-75e6-dd80-e524-b726483c88cd@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6e54ef6f-75e6-dd80-e524-b726483c88cd@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Vijay Kilary <vkilari@codeaurora.org>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	David Woodhouse <dwmw2@infradead.org>
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

Hi Robin,

Thanks for looking at this.

On Wed, Aug 21, 2019 at 12:42:11PM +0100, Robin Murphy wrote:
> On 14/08/2019 18:56, Will Deacon wrote:
> > The ->tlb_add_flush() callback in the io-pgtable API now looks a bit
> > silly:
> > 
> >    - It takes a size and a granule, which are always the same
> >    - It takes a 'bool leaf', which is always true
> >    - It only ever flushes a single page
> > 
> > With that in mind, replace it with an optional ->tlb_add_page() callback
> > that drops the useless parameters.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>

[...]

> > -static const struct iommu_flush_ops arm_smmu_s2_tlb_ops_v2 = {
> > -	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
> > -	.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
> > -	.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
> > -	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
> > -	.tlb_sync	= arm_smmu_tlb_sync_context,
> > +static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v2 = {
> > +	.tlb = {
> > +		.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
> > +		.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
> > +		.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
> > +		.tlb_add_page	= arm_smmu_tlb_add_page,
> > +		.tlb_sync	= arm_smmu_tlb_sync_context,
> > +	},
> > +	.tlb_inv_range		= arm_smmu_tlb_inv_range_nosync,
> >   };
> > -static const struct iommu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
> > -	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
> > -	.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
> > -	.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
> > -	.tlb_add_flush	= arm_smmu_tlb_inv_vmid_nosync,
> > -	.tlb_sync	= arm_smmu_tlb_sync_vmid,
> > +static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
> > +	.tlb = {
> > +		.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
> > +		.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
> > +		.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
> 
> Urgh, that ain't right... :(
> 
> Sorry I've only spotted it now while trying to rebase onto Joerg's queue,
> but we can't use either of those callbacks for v1 stage 2 since the
> registers they access don't exist. I'll spin a fixup patch first, then come
> back to the question of whether it's more practical to attempt merging my v2
> or concede to rebasing a v3.

Although the code is quite difficult to follow, I think it's alright because
the tlb_flush_{walk,leaf} functions just indirect back through the
tlb_inv_range callback. This patch is supposed to be a big NOP moving
drivers over to the new API, but not actually exploiting its benefits.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
