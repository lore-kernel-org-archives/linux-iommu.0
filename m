Return-Path: <SRS0=En+E=3E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF4AC33CB1
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 16:17:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662E5222C3
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 16:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyuW482l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662E5222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 20BD3204CC;
	Wed, 15 Jan 2020 16:17:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Md1hX3QI+hau; Wed, 15 Jan 2020 16:17:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 10B06204F9;
	Wed, 15 Jan 2020 16:17:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1835C1D82;
	Wed, 15 Jan 2020 16:17:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E261AC077D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 16:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D0C80862A0
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 16:17:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r2ZYETFjDGf9 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jan 2020 16:17:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8E35F86117
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 16:17:21 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 617A6222C3;
 Wed, 15 Jan 2020 16:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579105041;
 bh=ukrQNfklcHgQLcXCXuNtN53CWWqys1txNDvrg263c4M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nyuW482lUGZB2PULa3IQt7cUjuRCEQEVx2g3VQ4GXNPaKyQojamqURrbldP4Ev0Wh
 SPzO+PCTcua153EUkXezNqb0c41e+W10ZK+DHfcoFD2dUxDSwI3nk111kPYmcMzWYU
 lJM9yUOkJu2WkDpF+kKpoe0IhAp1tOWD3ho1Y08Y=
Date: Wed, 15 Jan 2020 16:17:15 +0000
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, robin.murphy@arm.com
Subject: Re: [PATCH v4 11/13] iommu/arm-smmu-v3: Improve add_device() error
 handling
Message-ID: <20200115161714.GA30746@willie-the-truck>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20191219163033.2608177-12-jean-philippe@linaro.org>
 <20200114152538.GB2579@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200114152538.GB2579@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, guohanjun@huawei.com,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, sudeep.holla@arm.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org,
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

On Tue, Jan 14, 2020 at 03:25:39PM +0000, Will Deacon wrote:
> On Thu, Dec 19, 2019 at 05:30:31PM +0100, Jean-Philippe Brucker wrote:
> > Let add_device() clean up after itself. The iommu_bus_init() function
> > does call remove_device() on error, but other sites (e.g. of_iommu) do
> > not.
> > 
> > Don't free level-2 stream tables because we'd have to track if we
> > allocated each of them or if they are used by other endpoints. It's not
> > worth the hassle since they are managed resources.
> > 
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 28 +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> I think this is alright, with one caveat relating to:
> 
> 
> 	/*
> 	 * We _can_ actually withstand dodgy bus code re-calling add_device()
> 	 * without an intervening remove_device()/of_xlate() sequence, but
> 	 * we're not going to do so quietly...
> 	 */
> 	if (WARN_ON_ONCE(fwspec->iommu_priv)) {
> 		master = fwspec->iommu_priv;
> 		smmu = master->smmu;
> 	} ...
> 
> 
> which may be on shakey ground if the subsequent add_device() call can fail
> and free stuff that the first one allocated. At least, I don't know what
> we're trying to support with this, so it's hard to tell whether or not it
> still works as intended after your change.
> 
> How is this supposed to work? I don't recall ever seeing that WARN fire,
> so can we just remove this and bail instead? Robin?
> 
> Something like below before your changes...

FWIW, I've written this as a patch locally, since I'd like to apply it
on top of v5 of your series.

Will

--->8

From 6029102f406d4db5e7a465da5fd2e08a5b12c532 Mon Sep 17 00:00:00 2001
From: Will Deacon <will@kernel.org>
Date: Wed, 15 Jan 2020 15:35:16 +0000
Subject: [PATCH] iommu/arm-smmu-v3: Return -EBUSY when trying to re-add a
 device

Although we WARN in arm_smmu_add_device() if the device being added has
been added already without a subsequent call to arm_smmu_remove_device(),
we still continue half-heartedly, initialising the stream-table for any
new StreamIDs that may have magically appeared and re-establishing device
links that should still be there from last time.

Given that calling ->add_device() twice without removing the device in the
meantime is indicative of an error in the caller, just return -EBUSY after
warning.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jean Philippe-Brucker <jean-philippe@linaro.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index efa326601308..cc26e1323da3 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2841,28 +2841,23 @@ static int arm_smmu_add_device(struct device *dev)
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return -ENODEV;
-	/*
-	 * We _can_ actually withstand dodgy bus code re-calling add_device()
-	 * without an intervening remove_device()/of_xlate() sequence, but
-	 * we're not going to do so quietly...
-	 */
-	if (WARN_ON_ONCE(fwspec->iommu_priv)) {
-		master = fwspec->iommu_priv;
-		smmu = master->smmu;
-	} else {
-		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
-		if (!smmu)
-			return -ENODEV;
-		master = kzalloc(sizeof(*master), GFP_KERNEL);
-		if (!master)
-			return -ENOMEM;
 
-		master->dev = dev;
-		master->smmu = smmu;
-		master->sids = fwspec->ids;
-		master->num_sids = fwspec->num_ids;
-		fwspec->iommu_priv = master;
-	}
+	if (WARN_ON_ONCE(fwspec->iommu_priv))
+		return -EBUSY;
+
+	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
+	if (!smmu)
+		return -ENODEV;
+
+	master = kzalloc(sizeof(*master), GFP_KERNEL);
+	if (!master)
+		return -ENOMEM;
+
+	master->dev = dev;
+	master->smmu = smmu;
+	master->sids = fwspec->ids;
+	master->num_sids = fwspec->num_ids;
+	fwspec->iommu_priv = master;
 
 	/* Check the SIDs are in range of the SMMU and our stream table */
 	for (i = 0; i < master->num_sids; i++) {
-- 
2.25.0.rc1.283.g88dfdc4193-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
