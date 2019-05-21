Return-Path: <SRS0=R8za=TV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DD6C04E87
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 19:07:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C9442173E
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 19:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gbnC1vLA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fQQgaWEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9442173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DED53C8E;
	Tue, 21 May 2019 19:07:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D74382C
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 19:07:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 46E6B27B
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 19:07:31 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1109260FED; Tue, 21 May 2019 19:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1558465651;
	bh=Bq0PqBuwpfVlS/G6x8WkoQpKA+0M/oyw1AbxmwdvCt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gbnC1vLASkBxI+dXMIuhV+VdrpUzCQb+P0BmH+O3+tP0jO0JeTXa45s7v0X9pbKLO
	My4Yl0CN5P0dnOTxC2oxSdAEgcN/3I4iMEVOr9I9CSHDoy25BKXTyRrsjXU0sULqUJ
	PmVoODfJEvBTs5gQYh5sWrM1npgpccuocUln4L9k=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
	[199.106.103.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jcrouse@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B30460DB2;
	Tue, 21 May 2019 19:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1558465649;
	bh=Bq0PqBuwpfVlS/G6x8WkoQpKA+0M/oyw1AbxmwdvCt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fQQgaWEv9g16dpf+vs6FZ18DEgmBuWXAqY5BDqeMLnGpoz3yhvTWgcEsk8O72TH3H
	SdnKtgG0bTOsmLaMwkMutCE0Znk6n4GpkOE/UqonWDVnyef0gOqo/XFcPfBzsvDHkI
	Bs/4BgYRJpyxRAY0v+F3diL22sltyS6TFmeHLMD8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B30460DB2
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Tue, 21 May 2019 13:07:26 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 01/15] iommu/arm-smmu: Allow IOMMU enabled devices to
	skip DMA domains
Message-ID: <20190521190726.GA2034@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Robin Murphy <robin.murphy@arm.com>,
	freedreno@lists.freedesktop.org, jean-philippe.brucker@arm.com,
	linux-arm-msm@vger.kernel.org, hoegsberg@google.com,
	dianders@chromium.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Will Deacon <will.deacon@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org
References: <1558455243-32746-1-git-send-email-jcrouse@codeaurora.org>
	<1558455243-32746-2-git-send-email-jcrouse@codeaurora.org>
	<6c5898e5-4b14-b77b-15b7-e926233c07d0@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6c5898e5-4b14-b77b-15b7-e926233c07d0@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>, dianders@chromium.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	hoegsberg@google.com, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org
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

On Tue, May 21, 2019 at 06:43:34PM +0100, Robin Murphy wrote:
> On 21/05/2019 17:13, Jordan Crouse wrote:
> >Allow IOMMU enabled devices specified on an opt-in list to create a
> >default identity domain for a new IOMMU group and bypass the DMA
> >domain created by the IOMMU core. This allows the group to be properly
> >set up but otherwise skips touching the hardware until the client
> >device attaches a unmanaged domain of its own.
> 
> All the cool kids are using iommu_request_dm_for_dev() to force an identity
> domain for particular devices, won't that suffice for this case too? There
> is definite scope for improvement in this area, so I'd really like to keep
> things as consistent as possible to make that easier in future.

I initially rejected iommu_request_dm_for_dev() since it still allowed the DMA
domain to consume the context bank but now that I look at it again as long as
the domain free returns the context bank to the pool it might work. Let me give
it a shot and see if it does what we need.

Jordan

> >Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> >---
> >
> >  drivers/iommu/arm-smmu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/iommu/iommu.c    | 29 +++++++++++++++++++++++------
> >  include/linux/iommu.h    |  3 +++
> >  3 files changed, 68 insertions(+), 6 deletions(-)
> >
> >diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> >index 5e54cc0..a795ada 100644
> >--- a/drivers/iommu/arm-smmu.c
> >+++ b/drivers/iommu/arm-smmu.c
> >@@ -1235,6 +1235,35 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
> >  	return 0;
> >  }
> >+struct arm_smmu_client_match_data {
> >+	bool use_identity_domain;
> >+};
> >+
> >+static const struct arm_smmu_client_match_data qcom_adreno = {
> >+	.use_identity_domain = true,
> >+};
> >+
> >+static const struct arm_smmu_client_match_data qcom_mdss = {
> >+	.use_identity_domain = true,
> >+};
> >+
> >+static const struct of_device_id arm_smmu_client_of_match[] = {
> >+	{ .compatible = "qcom,adreno", .data = &qcom_adreno },
> >+	{ .compatible = "qcom,mdp4", .data = &qcom_mdss },
> >+	{ .compatible = "qcom,mdss", .data = &qcom_mdss },
> >+	{ .compatible = "qcom,sdm845-mdss", .data = &qcom_mdss },
> >+	{},
> >+};
> >+
> >+static const struct arm_smmu_client_match_data *
> >+arm_smmu_client_data(struct device *dev)
> >+{
> >+	const struct of_device_id *match =
> >+		of_match_device(arm_smmu_client_of_match, dev);
> >+
> >+	return match ? match->data : NULL;
> >+}
> >+
> >  static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >  {
> >  	int ret;
> >@@ -1552,6 +1581,7 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
> >  {
> >  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> >  	struct arm_smmu_device *smmu = fwspec_smmu(fwspec);
> >+	const struct arm_smmu_client_match_data *client;
> >  	struct iommu_group *group = NULL;
> >  	int i, idx;
> >@@ -1573,6 +1603,18 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
> >  	else
> >  		group = generic_device_group(dev);
> >+	client = arm_smmu_client_data(dev);
> >+
> >+	/*
> >+	 * If the client chooses to bypass the dma domain, create a identity
> >+	 * domain as a default placeholder. This will give the device a
> >+	 * default domain but skip DMA operations and not consume a context
> >+	 * bank
> >+	 */
> >+	if (client && client->no_dma_domain)
> >+		iommu_group_set_default_domain(group, dev,
> >+			IOMMU_DOMAIN_IDENTITY);
> >+
> >  	return group;
> >  }
> >diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >index 67ee662..af3e1ed 100644
> >--- a/drivers/iommu/iommu.c
> >+++ b/drivers/iommu/iommu.c
> >@@ -1062,6 +1062,24 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
> >  	return group;
> >  }
> >+struct iommu_domain *iommu_group_set_default_domain(struct iommu_group *group,
> >+		struct device *dev, unsigned int type)
> >+{
> >+	struct iommu_domain *dom;
> >+
> >+	dom = __iommu_domain_alloc(dev->bus, type);
> >+	if (!dom)
> >+		return NULL;
> >+
> >+	/* FIXME: Error if the default domain is already set? */
> >+	group->default_domain = dom;
> >+	if (!group->domain)
> >+		group->domain = dom;
> >+
> >+	return dom;
> >+}
> >+EXPORT_SYMBOL_GPL(iommu_group_set_default_domain);
> >+
> >  /**
> >   * iommu_group_get_for_dev - Find or create the IOMMU group for a device
> >   * @dev: target device
> >@@ -1099,9 +1117,12 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
> >  	if (!group->default_domain) {
> >  		struct iommu_domain *dom;
> >-		dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
> >+		dom = iommu_group_set_default_domain(group, dev,
> >+			iommu_def_domain_type);
> >+
> >  		if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
> >-			dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
> >+			dom = iommu_group_set_default_domain(group, dev,
> >+				IOMMU_DOMAIN_DMA);
> >  			if (dom) {
> >  				dev_warn(dev,
> >  					 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
> >@@ -1109,10 +1130,6 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
> >  			}
> >  		}
> >-		group->default_domain = dom;
> >-		if (!group->domain)
> >-			group->domain = dom;
> >-
> >  		if (dom && !iommu_dma_strict) {
> >  			int attr = 1;
> >  			iommu_domain_set_attr(dom,
> >diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> >index a815cf6..4ef8bd5 100644
> >--- a/include/linux/iommu.h
> >+++ b/include/linux/iommu.h
> >@@ -394,6 +394,9 @@ extern int iommu_group_id(struct iommu_group *group);
> >  extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
> >  extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
> >+struct iommu_domain *iommu_group_set_default_domain(struct iommu_group *group,
> >+		struct device *dev, unsigned int type);
> >+
> >  extern int iommu_domain_get_attr(struct iommu_domain *domain, enum iommu_attr,
> >  				 void *data);
> >  extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
> >

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
