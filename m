Return-Path: <SRS0=/T8B=3Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952B9C3524A
	for <iommu@archiver.kernel.org>; Tue,  4 Feb 2020 06:11:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65EDB20674
	for <iommu@archiver.kernel.org>; Tue,  4 Feb 2020 06:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EDB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3D46E84BAF;
	Tue,  4 Feb 2020 06:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zrcbbmQ1cw6N; Tue,  4 Feb 2020 06:11:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5D90D8362C;
	Tue,  4 Feb 2020 06:11:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42E5FC1D81;
	Tue,  4 Feb 2020 06:11:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B682C0174
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 06:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 437AF84BAF
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 06:11:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bdZ8UXkMEdzb for <iommu@lists.linux-foundation.org>;
 Tue,  4 Feb 2020 06:11:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A3D328362C
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 06:11:48 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Feb 2020 22:11:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; d="scan'208";a="254308213"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.105])
 ([10.254.209.105])
 by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2020 22:11:46 -0800
Subject: Re: [PATCH] iommu/intel-iommu: set as DUMMY_DEVICE_DOMAIN_INFO if no
 IOMMU
To: Jian-Hong Pan <jian-hong@endlessm.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
References: <20200203091009.196658-1-jian-hong@endlessm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <aab0948d-c6a3-baa1-7343-f18c936d662d@linux.intel.com>
Date: Tue, 4 Feb 2020 14:11:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203091009.196658-1-jian-hong@endlessm.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux@endlessm.com,
 linux-kernel@vger.kernel.org
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

Hi,

On 2020/2/3 17:10, Jian-Hong Pan wrote:
> If the device has no IOMMU, it still invokes iommu_need_mapping during
> intel_alloc_coherent. However, iommu_need_mapping can only check the
> device is DUMMY_DEVICE_DOMAIN_INFO or not. This patch marks the device
> is a DUMMY_DEVICE_DOMAIN_INFO if the device has no IOMMU.
> 
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> ---
>   drivers/iommu/intel-iommu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 35a4a3abedc6..878bc986a015 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5612,8 +5612,10 @@ static int intel_iommu_add_device(struct device *dev)
>   	int ret;
>   
>   	iommu = device_to_iommu(dev, &bus, &devfn);
> -	if (!iommu)
> +	if (!iommu) {
> +		dev->archdata.iommu = DUMMY_DEVICE_DOMAIN_INFO;

Is this a DMA capable device? I am afraid some real bugs might be
covered up if we marking the device as IOMMU dummy here.

Best regards,
baolu

>   		return -ENODEV;
> +	}
>   
>   	iommu_device_link(&iommu->iommu, dev);
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
