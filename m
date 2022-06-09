Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5DEC43334
	for <iommu@archiver.kernel.org>; Thu,  9 Jun 2022 17:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F56A61106;
	Thu,  9 Jun 2022 17:18:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8c380Rwdojci; Thu,  9 Jun 2022 17:18:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6AA1C61108;
	Thu,  9 Jun 2022 17:18:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35CCBC0032;
	Thu,  9 Jun 2022 17:18:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EF0AC002D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 17:18:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F328240C70
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 17:18:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SKUW51HnZ3CO for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 17:18:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7448940C61
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 17:18:44 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id j7so21903520pjn.4
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jun 2022 10:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=dBDuOA7Ag4D41J0FVo2zI0CMf8MV1Q4H90cDsiRjqs0=;
 b=RsO60poNqtXH+KVGPusliFl3dMOEqGEf0rR7/37hvp3fmJ4hM6DrEjDcYHrjmW3JsR
 4ynoNapJinKsYBr41WyWo8Pqq2/tHIqMqjrCDXgka1+E+rvFUlGTIF54Mdkx/KWdNhWX
 tC0lB98Kyhd2F9p0cqXTpK4Mpf4jZ8wIPh6NYr38VN1lDPw4R7bsZ2aQUYcT48mpAExE
 jSdc+sCxhir+Sp2Xw3OuR8DXe4HxY7p/TCMY7DTVqFrhg7Qob/RM+fxIDbXxNsMftMtH
 87WrvbaK6TtRnPuW5PO56g8xLU+866NwKT9RAobEj3rtJnebTeOfal4vX2LSHuNqGacb
 iJ7g==
X-Gm-Message-State: AOAM530TaKFkGvdLajGswE6nd3esrXNE7LiX5zDacfzCT/KRqgPzT1f7
 Z6pkoj7l4GSN+ODULn8uGnM=
X-Google-Smtp-Source: ABdhPJxSk2cA7JFtd6Y65O6LCndnGyH7rcIrk4lhHhvjln2O2sPxd9TjLkzxezsdsn9gL7KtW74Jsg==
X-Received: by 2002:a17:902:d409:b0:167:7425:caa8 with SMTP id
 b9-20020a170902d40900b001677425caa8mr23376154ple.72.1654795123675; 
 Thu, 09 Jun 2022 10:18:43 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8a44:a3e:c994:3f4b?
 ([2620:15c:211:201:8a44:a3e:c994:3f4b])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a170902780800b001645730e71bsm17115350pll.59.2022.06.09.10.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jun 2022 10:18:42 -0700 (PDT)
Message-ID: <a2585983-75d7-c627-13ba-38a464cf716e@acm.org>
Date: Thu, 9 Jun 2022 10:18:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, damien.lemoal@opensource.wdc.com,
 joro@8bytes.org, will@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
 <1654507822-168026-4-git-send-email-john.garry@huawei.com>
 <fe365aa8-00d5-153d-ceb2-f887a71a6927@acm.org>
 <31417477-953d-283e-808e-cf8701e820a8@huawei.com>
 <bccbcc9b-4750-a1a7-130f-69eeea5dcb23@acm.org>
 <5b214e95-dd95-551a-496e-a2139a74e8eb@huawei.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5b214e95-dd95-551a-496e-a2139a74e8eb@huawei.com>
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org,
 liyihang6@hisilicon.com, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org
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

On 6/9/22 01:00, John Garry wrote:
> On 08/06/2022 22:07, Bart Van Assche wrote:
>> On 6/8/22 10:50, John Garry wrote:
>>> Please note that this limit only applies if we have an IOMMU enabled 
>>> for the scsi host dma device. Otherwise we are limited by dma direct 
>>> or swiotlb max mapping size, as before.
>>
>> SCSI host bus adapters that support 64-bit DMA may support much larger 
>> transfer sizes than 128 KiB.
> 
> Indeed, and that is my problem today, as my storage controller is 
> generating DMA mapping lengths which exceeds 128K and they slow 
> everything down.
> 
> If you say that SRP enjoys best peformance with larger transfers then 
> can you please test this with an IOMMU enabled (iommu group type DMA or 
> DMA-FQ)?

Hmm ... what exactly do you want me to test? Do you perhaps want me to 
measure how much performance drops with an IOMMU enabled? I don't have 
access anymore to the SRP setup I referred to in my previous email. But 
I do have access to devices that boot from UFS storage. For these 
devices we need to transfer 2 MiB per request to achieve full bandwidth.

Thanks,

Bart.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
