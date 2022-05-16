Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409D0C433F5
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 10:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1258818BE;
	Mon, 16 May 2022 10:13:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VXaMTln3Pdne; Mon, 16 May 2022 10:13:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C44C38188B;
	Mon, 16 May 2022 10:13:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84D4BC0032;
	Mon, 16 May 2022 10:13:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FBE4C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 10:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1BD1460BCC
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 10:13:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kapsi.fi
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id znMvhCpqLNWI for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 10:13:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1029960B5B
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 10:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fWkwQsmctjZuzNgYxnAKr5+YEBZD6Vnzh24HSXGD4s4=; b=PyvF5wt/y7YPONshkgm9QvVDBg
 ofst1pJP0Wz+jy0MpOKmeONA+ui5V0E/rUyTSJz5lluFvjphLQUOW4m1TGTcb8rZizQ+fbHYWLWew
 /xQ9G4Psi7BDZQKEb4Zb39YdHsYSq0ksZ7L5J8D4EnKoSu4jl0vWKeCQyJdNgVu95mq5GeMNGHw0h
 nR+FiSXWtwr57cFQ5zPIPUbnAIEyV2xkoYwqpCgENWf13AKUlbX9cCwb3iku5748UtSaRtn/7+A5m
 E296JSCsnKVU5cbYlofpOk9K7Pdq6V9+++V2vUUERzQpS/IhCSKIn0a0MczNTBD+9xjWeWDoBglda
 6ZW8LDuA==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=[192.168.1.10])
 by mail.kapsi.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <cyndis@kapsi.fi>)
 id 1nqXjD-0000OD-HN; Mon, 16 May 2022 13:13:27 +0300
Message-ID: <4a170997-c893-1788-dcaa-8ed2193146ae@kapsi.fi>
Date: Mon, 16 May 2022 13:13:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu: Attach to host1x context device bus
Content-Language: en-US
To: Will Deacon <will@kernel.org>
References: <20220516085258.1227691-1-cyndis@kapsi.fi>
 <20220516085258.1227691-6-cyndis@kapsi.fi>
 <20220516100721.GA1927@willie-the-truck>
From: Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <20220516100721.GA1927@willie-the-truck>
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, krzysztof.kozlowski@canonical.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Mikko Perttunen <mperttunen@nvidia.com>, robin.murphy@arm.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 5/16/22 13:07, Will Deacon wrote:
> On Mon, May 16, 2022 at 11:52:54AM +0300, cyndis@kapsi.fi wrote:
>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>
>> Set itself as the IOMMU for the host1x context device bus, containing
>> "dummy" devices used for Host1x context isolation.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index 568cce590ccc..9ff54eaecf81 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -39,6 +39,7 @@
>>   
>>   #include <linux/amba/bus.h>
>>   #include <linux/fsl/mc.h>
>> +#include <linux/host1x_context_bus.h>
>>   
>>   #include "arm-smmu.h"
>>   
>> @@ -2053,8 +2054,20 @@ static int arm_smmu_bus_init(struct iommu_ops *ops)
>>   			goto err_reset_pci_ops;
>>   	}
>>   #endif
>> +#ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
>> +	if (!iommu_present(&host1x_context_device_bus_type)) {
>> +		err = bus_set_iommu(&host1x_context_device_bus_type, ops);
>> +		if (err)
>> +			goto err_reset_fsl_mc_ops;
>> +	}
>> +#endif
>> +
>>   	return 0;
>>   
>> +err_reset_fsl_mc_ops: __maybe_unused;
>> +#ifdef CONFIG_FSL_MC_BUS
>> +	bus_set_iommu(&fsl_mc_bus_type, NULL);
>> +#endif
> 
> bus_set_iommu() is going away:
> 
> https://lore.kernel.org/r/cover.1650890638.git.robin.murphy@arm.com
> 
> Will

Thanks for the heads-up. Robin had pointed out that this work was 
ongoing but I hadn't seen the patches yet. I'll look into it.

Mikko

>>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
