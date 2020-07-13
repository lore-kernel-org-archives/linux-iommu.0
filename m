Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576DBC433E0
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 13:33:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257F3206F0
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 13:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jebLbqpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257F3206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3380588CE5;
	Mon, 13 Jul 2020 13:33:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1QY7IPIvSSr0; Mon, 13 Jul 2020 13:33:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4374488C9A;
	Mon, 13 Jul 2020 13:33:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35827C0888;
	Mon, 13 Jul 2020 13:33:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EFE1C0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 13:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8745788C99
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 13:33:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ddgyuxt9r5di for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 13:33:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6537B88C9A
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 13:33:31 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CD012206F0;
 Mon, 13 Jul 2020 13:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594647211;
 bh=V6r4Vd0ntf60ms9BvuVNTsa0FkIV6RXDVM+LwGICXLw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jebLbqpU9BkeoVARZiIrMIIpbl3sUjLWNqnwQQ2WDCSlwQ8i8dKzW/gqYFKA7+bGw
 DxLSazw26HbvtDAtyGTI7VXXv5Y3D+wk9lZlsQ7tOz8E8EB0qoNnbAp4RJ6Np/AmmA
 1P2GA7GUN8Nbuzv6Kvic8JC292fM30ZxjLrlEK2k=
Date: Mon, 13 Jul 2020 14:33:26 +0100
From: Will Deacon <will@kernel.org>
To: Jordan Crouse <jcrouse@codeaurora.org>, joro@8bytes.org
Subject: Re: [PATCH v2] iommu/arm-smmu: Mark qcom_smmu_client_of_match as
 possibly unused
Message-ID: <20200713133326.GB2739@willie-the-truck>
References: <20200604203905.31964-1-jcrouse@codeaurora.org>
 <20200608151308.GB8060@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200608151308.GB8060@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Jun 08, 2020 at 04:13:08PM +0100, Will Deacon wrote:
> On Thu, Jun 04, 2020 at 02:39:04PM -0600, Jordan Crouse wrote:
> > When CONFIG_OF=n of_match_device() gets pre-processed out of existence
> > leaving qcom-smmu_client_of_match unused. Mark it as possibly unused to
> > keep the compiler from warning in that case.
> > 
> > Fixes: 0e764a01015d ("iommu/arm-smmu: Allow client devices to select direct mapping")
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Acked-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> > 
> >  drivers/iommu/arm-smmu-qcom.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
> > index cf01d0215a39..be4318044f96 100644
> > --- a/drivers/iommu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm-smmu-qcom.c
> > @@ -12,7 +12,7 @@ struct qcom_smmu {
> >  	struct arm_smmu_device smmu;
> >  };
> >  
> > -static const struct of_device_id qcom_smmu_client_of_match[] = {
> > +static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
> >  	{ .compatible = "qcom,adreno" },
> >  	{ .compatible = "qcom,mdp4" },
> >  	{ .compatible = "qcom,mdss" },
> 
> Thanks. Joerg -- can you pick this one up, please? I don't have any other
> SMMU fixes pending at the moment.

I can't see this in Joerg's tree or in linux-next. Joerg: did you pick this
one up? (I thought you did, but I can't find it!).

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
