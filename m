Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9985C433DB
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 13:51:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316C22223D
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 13:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316C22223D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0520A20426;
	Tue, 26 Jan 2021 13:51:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V-ujKT7cBmdu; Tue, 26 Jan 2021 13:51:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C046220116;
	Tue, 26 Jan 2021 13:51:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CF43C08A1;
	Tue, 26 Jan 2021 13:51:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BB50C013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 13:50:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8269F8666F
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 13:50:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nNiSSEysmMzJ for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 13:50:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id B308686669
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 13:50:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E477B31B;
 Tue, 26 Jan 2021 05:50:54 -0800 (PST)
Received: from localhost (unknown [10.57.43.46])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A47043F68F;
 Tue, 26 Jan 2021 05:50:53 -0800 (PST)
Date: Tue, 26 Jan 2021 13:50:40 +0000
From: Robin Murphy <robin.murphy@arm.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH] iommu: Check dev->iommu in iommu_dev_xxx functions
Message-ID: <20210126135039.000039a0@arm.com>
In-Reply-To: <20210126130629.8928-1-shameerali.kolothum.thodi@huawei.com>
References: <20210126130629.8928-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, linux-kernel@vger.kernel.org,
 linuxarm@openeuler.org, iommu@lists.linux-foundation.org,
 prime.zeng@hisilicon.com, will@kernel.org
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, 26 Jan 2021 13:06:29 +0000
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> The device iommu probe/attach might have failed leaving dev->iommu
> to NULL and device drivers may still invoke these functions=A0resulting
> a crash in iommu vendor driver code. Hence make=A0sure we check that.
> =

> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ffeebda8d6de..cb68153c5cc0 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2867,7 +2867,7 @@ bool iommu_dev_has_feature(struct device *dev,
> enum iommu_dev_features feat) {
>  	const struct iommu_ops *ops =3D dev->bus->iommu_ops;
>  =

> -	if (ops && ops->dev_has_feat)
> +	if (dev->iommu && ops && ops->dev_has_feat)
>  		return ops->dev_has_feat(dev, feat);

Might make sense to make these more self-contained, e.g.:

	if (dev->iommu && dev->iommu->ops->foo)
		dev->iommu->ops->foo()

Robin.

 =

>  	return false;
> @@ -2878,7 +2878,7 @@ int iommu_dev_enable_feature(struct device
> *dev, enum iommu_dev_features feat) {
>  	const struct iommu_ops *ops =3D dev->bus->iommu_ops;
>  =

> -	if (ops && ops->dev_enable_feat)
> +	if (dev->iommu && ops && ops->dev_enable_feat)
>  		return ops->dev_enable_feat(dev, feat);
>  =

>  	return -ENODEV;
> @@ -2894,7 +2894,7 @@ int iommu_dev_disable_feature(struct device
> *dev, enum iommu_dev_features feat) {
>  	const struct iommu_ops *ops =3D dev->bus->iommu_ops;
>  =

> -	if (ops && ops->dev_disable_feat)
> +	if (dev->iommu && ops && ops->dev_disable_feat)
>  		return ops->dev_disable_feat(dev, feat);
>  =

>  	return -EBUSY;
> @@ -2905,7 +2905,7 @@ bool iommu_dev_feature_enabled(struct device
> *dev, enum iommu_dev_features feat) {
>  	const struct iommu_ops *ops =3D dev->bus->iommu_ops;
>  =

> -	if (ops && ops->dev_feat_enabled)
> +	if (dev->iommu && ops && ops->dev_feat_enabled)
>  		return ops->dev_feat_enabled(dev, feat);
>  =

>  	return false;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
