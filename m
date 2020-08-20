Return-Path: <SRS0=3GNe=B6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B297C433E4
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 16:58:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA41D2072D
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 16:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA41D2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A75F022767;
	Thu, 20 Aug 2020 16:58:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KiaajR7WExa6; Thu, 20 Aug 2020 16:58:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BCF7C2047F;
	Thu, 20 Aug 2020 16:58:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A28B8C0889;
	Thu, 20 Aug 2020 16:58:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0A49C0051
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 16:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EA1142151F
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 16:58:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pkK77kyZreXL for <iommu@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 16:58:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 5B5622047F
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 16:58:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF2C030E;
 Thu, 20 Aug 2020 09:58:19 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 410683F66B;
 Thu, 20 Aug 2020 09:58:15 -0700 (PDT)
Subject: Re: [PATCH 10/18] iommu/msm: Add IOMMU_DOMAIN_DMA support
To: Rob Clark <robdclark@gmail.com>
References: <cover.1597931875.git.robin.murphy@arm.com>
 <93d7de3533cfd952aecd6198b9221d7a58c0e521.1597931876.git.robin.murphy@arm.com>
 <CAF6AEGuKa4P=gfus08CdfT2H5pG6a2PBumGb=Pw3qvD=NWueig@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b5aa001f-6a1c-af0b-1526-c5b7a2e29ef7@arm.com>
Date: Thu, 20 Aug 2020 17:58:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAF6AEGuKa4P=gfus08CdfT2H5pG6a2PBumGb=Pw3qvD=NWueig@mail.gmail.com>
Content-Language: en-GB
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 dri-devel <dri-devel@lists.freedesktop.org>, linux-tegra@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, digetx@gmail.com,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "moderated list:ARM/S5P EXYNOS AR..." <linux-samsung-soc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Andy Gross <agross@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, linux-media@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, t-kristo@ti.com,
 Kyungmin Park <kyungmin.park@samsung.com>
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

On 2020-08-20 16:55, Rob Clark wrote:
> Side note, I suspect we'll end up needing something like
> 0e764a01015dfebff8a8ffd297d74663772e248a .. if someone can dig a 32b
> device out of the closet and dust it off, the fix is easy enough.
> Just wanted to mention that here so anyone with a 32b device could
> find what is needed.

FWIW there shouldn't be any material change here - the generic default 
domain is installed under the same circumstances as the Arm 
dma_iommu_mapping was, so if any platform does have an issue, then it 
should already have started 4 years with f78ebca8ff3d ("iommu/msm: Add 
support for generic master bindings").

Robin.

> 
> BR,
> -R
> 
> On Thu, Aug 20, 2020 at 8:09 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> Now that arch/arm is wired up for default domains and iommu-dma,
>> implement the corresponding driver-side support for DMA domains.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/msm_iommu.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
>> index 3615cd6241c4..f34efcbb0b2b 100644
>> --- a/drivers/iommu/msm_iommu.c
>> +++ b/drivers/iommu/msm_iommu.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/init.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/dma-iommu.h>
>>   #include <linux/errno.h>
>>   #include <linux/io.h>
>>   #include <linux/io-pgtable.h>
>> @@ -314,13 +315,16 @@ static struct iommu_domain *msm_iommu_domain_alloc(unsigned type)
>>   {
>>          struct msm_priv *priv;
>>
>> -       if (type != IOMMU_DOMAIN_UNMANAGED)
>> +       if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
>>                  return NULL;
>>
>>          priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>>          if (!priv)
>>                  goto fail_nomem;
>>
>> +       if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(&priv->domain))
>> +               goto fail_nomem;
>> +
>>          INIT_LIST_HEAD(&priv->list_attached);
>>
>>          priv->domain.geometry.aperture_start = 0;
>> @@ -339,6 +343,7 @@ static void msm_iommu_domain_free(struct iommu_domain *domain)
>>          struct msm_priv *priv;
>>          unsigned long flags;
>>
>> +       iommu_put_dma_cookie(domain);
>>          spin_lock_irqsave(&msm_iommu_lock, flags);
>>          priv = to_msm_priv(domain);
>>          kfree(priv);
>> --
>> 2.28.0.dirty
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
