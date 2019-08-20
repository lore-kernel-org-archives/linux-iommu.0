Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE657C3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 16:31:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B242222DD6
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 16:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOiIegOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B242222DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 65F6BC64;
	Tue, 20 Aug 2019 16:31:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A9224B7A
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 16:31:52 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 39D4D8A0
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 16:31:52 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 1244222CF4;
	Tue, 20 Aug 2019 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566318712;
	bh=eNN8u1G7jt8aE0PQaFLR3F9vjX84NbGrOG2wTM1DQQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOiIegOW/ffiPoGPin3qREttXHQAQBf1gJ9p1cPGdNP6iIJU7+U4GMT2yGhE/vUlR
	1Rm+ppC1hFr4r4DHXtRmtsCdQHrNUs2GT625iSk3GsfT1J4T/7mhNaaJctFjGctRZO
	t3ZSCQv5WY7vXeWwmtkECC51amT3YF5MhmeznnRk=
Date: Tue, 20 Aug 2019 17:31:48 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/4] iommu/arm-smmu-v3: Rework enabling/disabling of ATS
	for PCI masters
Message-ID: <20190820163147.j5v36uztlist5x6f@willie-the-truck>
References: <20190820154549.17018-1-will@kernel.org>
	<20190820154549.17018-3-will@kernel.org>
	<5c9822a6-395f-3f5a-657d-ac73dd20d521@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5c9822a6-395f-3f5a-657d-ac73dd20d521@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	iommu@lists.linux-foundation.org
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

On Tue, Aug 20, 2019 at 05:12:11PM +0100, Robin Murphy wrote:
> On 20/08/2019 16:45, Will Deacon wrote:
> > To prevent any potential issues arising from speculative Address
> > Translation Requests from an ATS-enabled PCIe endpoint, rework our ATS
> > enabling/disabling logic so that we enable ATS at the SMMU before we
> > enable it at the endpoint, and disable things in the opposite order.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >   drivers/iommu/arm-smmu-v3.c | 44 ++++++++++++++++++++++++++------------------
> >   1 file changed, 26 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index 3402b1bc8e94..9096eca0c480 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -2283,31 +2283,34 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
> >   	}
> >   }
> > -static int arm_smmu_enable_ats(struct arm_smmu_master *master)
> > +static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
> >   {
> > -	int ret;
> > -	size_t stu;
> >   	struct pci_dev *pdev;
> >   	struct arm_smmu_device *smmu = master->smmu;
> >   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
> >   	if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev) ||
> >   	    !(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS) || pci_ats_disabled())
> > -		return -ENXIO;
> > +		return false;
> >   	pdev = to_pci_dev(master->dev);
> > -	if (pdev->untrusted)
> > -		return -EPERM;
> > +	return !pdev->untrusted && pdev->ats_cap;
> > +}
> > -	/* Smallest Translation Unit: log2 of the smallest supported granule */
> > -	stu = __ffs(smmu->pgsize_bitmap);
> > +static void arm_smmu_enable_ats(struct arm_smmu_master *master)
> > +{
> > +	size_t stu;
> > +	struct pci_dev *pdev;
> > +	struct arm_smmu_device *smmu = master->smmu;
> > -	ret = pci_enable_ats(pdev, stu);
> > -	if (ret)
> > -		return ret;
> > +	if (master->ats_enabled || !dev_is_pci(master->dev))
> > +		return;
> > -	master->ats_enabled = true;
> > -	return 0;
> > +	/* Smallest Translation Unit: log2 of the smallest supported granule */
> > +	stu = __ffs(smmu->pgsize_bitmap);
> > +	pdev = to_pci_dev(master->dev);
> > +	if (pci_enable_ats(pdev, stu))
> > +		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
> >   }
> >   static void arm_smmu_disable_ats(struct arm_smmu_master *master)
> > @@ -2317,10 +2320,14 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
> >   	if (!master->ats_enabled || !dev_is_pci(master->dev))
> 
> Hmm, while you've got the lid off, that dev_is_pci() test is clearly
> redundant.

Good point; I'll kill it.

> >   		return;
> > +	pci_disable_ats(to_pci_dev(master->dev));
> > +	/*
> > +	 * Ensure ATS is disabled at the endpoint before we issue the
> > +	 * ATC invalidation via the SMMU.
> > +	 */
> > +	wmb();
> >   	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
> >   	arm_smmu_atc_inv_master(master, &cmd);
> > -	pci_disable_ats(to_pci_dev(master->dev));
> > -	master->ats_enabled = false;
> >   }
> >   static void arm_smmu_detach_dev(struct arm_smmu_master *master)
> > @@ -2335,10 +2342,10 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
> >   	list_del(&master->domain_head);
> >   	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> > +	arm_smmu_disable_ats(master);
> >   	master->domain = NULL;
> > +	master->ats_enabled = false;
> >   	arm_smmu_install_ste_for_dev(master);
> > -
> > -	arm_smmu_disable_ats(master);
> >   }
> >   static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > @@ -2383,12 +2390,13 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >   	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> >   	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
> > -		arm_smmu_enable_ats(master);
> > +		master->ats_enabled = arm_smmu_ats_supported(master);
> 
> So for non-bypass domains we pretend ATS is already enabled iff it could
> possibly be...
> 
> >   	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
> >   		arm_smmu_write_ctx_desc(smmu, &smmu_domain->s1_cfg);
> >   	arm_smmu_install_ste_for_dev(master);
> > +	arm_smmu_enable_ats(master);
> 
> ...which ensures this won't actually touch the PCIe cap, unless of course
> when STE.EATS == 0. Are you sure about that?

Argh, too many "ats_enabled" flags! (there's another one in the pci
device). I should probably invert the check, but let me have a play --
the idea is that arm_smmu_master::ats_enabled is initially used to
configure the STE and then acts as a proxy for the STE state after that.

Thanks for the review.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
