Return-Path: <SRS0=9BbX=AP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AF8C433DF
	for <iommu@archiver.kernel.org>; Sat,  4 Jul 2020 09:19:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610CD208D5
	for <iommu@archiver.kernel.org>; Sat,  4 Jul 2020 09:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610CD208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2F52888231;
	Sat,  4 Jul 2020 09:19:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2u-50AE-mWtB; Sat,  4 Jul 2020 09:19:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A263E87781;
	Sat,  4 Jul 2020 09:19:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65D37C0733;
	Sat,  4 Jul 2020 09:19:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95E52C0733
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 09:19:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7527987781
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 09:19:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TT44yzZGa+0p for <iommu@lists.linux-foundation.org>;
 Sat,  4 Jul 2020 09:19:48 +0000 (UTC)
X-Greylist: delayed 00:07:13 by SQLgrey-1.7.6
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn
 [202.108.3.20])
 by whitealder.osuosl.org (Postfix) with SMTP id E76FA88231
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 09:19:47 +0000 (UTC)
Received: from unknown (HELO localhost.localdomain)([61.51.227.93])
 by sina.com with ESMTP
 id 5F00476E0001E34C; Sat, 4 Jul 2020 17:10:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 75361915073700
From: Hillf Danton <hdanton@sina.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 07/34] iommu: Add probe_device() and release_device()
 call-backs
Date: Sat,  4 Jul 2020 17:09:57 +0800
Message-Id: <20200704090957.8892-1-hdanton@sina.com>
In-Reply-To: <20200429133712.31431-8-joro@8bytes.org>
References: <20200429133712.31431-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: Hillf Danton <hdanton@sina.com>, Joerg Roedel <jroedel@suse.de>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Markus Elfring <Markus.Elfring@web.de>,
 Robin Murphy <robin.murphy@arm.com>
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


On Wed, 29 Apr 2020 15:36:45 +0200 Joerg Roedel wrote:
> 
> +static int __iommu_probe_device(struct device *dev)
> +{
> +	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +	struct iommu_device *iommu_dev;
> +	struct iommu_group *group;
> +	int ret;
> +
> +	iommu_dev = ops->probe_device(dev);
> +	if (IS_ERR(iommu_dev))
> +		return PTR_ERR(iommu_dev);
> +
> +	dev->iommu->iommu_dev = iommu_dev;
> +
> +	group = iommu_group_get_for_dev(dev);
> +	if (!IS_ERR(group)) {

Typo?

> +		ret = PTR_ERR(group);
> +		goto out_release;
> +	}
> +	iommu_group_put(group);
> +
> +	iommu_device_link(iommu_dev, dev);
> +
> +	return 0;
> +
> +out_release:
> +	ops->release_device(dev);
> +
> +	return ret;
> +}

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
