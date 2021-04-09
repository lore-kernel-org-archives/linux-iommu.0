Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4431BC433B4
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 03:13:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF0860238
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 03:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF0860238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4FFB60E4A;
	Fri,  9 Apr 2021 03:13:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6myxTYllVpxd; Fri,  9 Apr 2021 03:13:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F0C2607DB;
	Fri,  9 Apr 2021 03:13:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73F99C000B;
	Fri,  9 Apr 2021 03:13:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C607C000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 465B7419D1
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:13:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AjAnNW_vO-3N for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 03:13:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86AE2419BD
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:13:11 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id t140so2804212pgb.13
 for <iommu@lists.linux-foundation.org>; Thu, 08 Apr 2021 20:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+DOjZGX/u6rbr2K2XlXD1oEUmYKSnesPXX/ShoCtN0M=;
 b=NvIL21zOmeCCpYpUvhPnREkyrOsjc6hDE4wd7oEcgjEBnUjKXFuKhCvH3956iRzqDa
 6jfYI7Ci7hhvI/TgSk3LDPqIO/ScZGcG1XJZrL3k24KXr8tihXsqm7PnHQZAceEXGvj/
 ItQkL5tzl22HoBJu78izANiE0gu53bIOXuGSI0JSnU19pxMvnxhpMCTWMzI9co/PkbJ2
 ohvt6wDatg/Py7H8bjjKeks9OEcVkw7pXd8wQIQ+PO1rRRFyR5o6zWPLOaefjZtrF4q6
 DulaFT+yP3NRTKYNEEtWeQ6JkUd7ZhTOe3fQGxMp1uVO1z2svZ16gCVwIoJeL7yXFQZR
 RfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+DOjZGX/u6rbr2K2XlXD1oEUmYKSnesPXX/ShoCtN0M=;
 b=IyxZZEzgIqWQA04bRlM3E3B+2XnrJmFPjuh7wWg0NYLru74Jq/E8y2fLD7MAzStIdX
 ljFp3+E4dU9LCEilNJs/drezoLsFXvLnDxhGreY44lW7Uco02b1zkALGaEQZeKvg+izP
 9oImLYhqYxZm2qq1KPsxDHejLaUfhX2+AcnBD5LaOnZtkOfuvVg30rBtzmh4FvlPYa3r
 ofFSQoWwhhWY3mWM5rw4vsfKz47EEhmgW2jmBZOPLVu/BZbkDRoTMZD6cf6YonBgwYm0
 cyJtM5N7ETy90xZLaDUE3dzs/YuOHHMItEk5cJdnLROtvvdviL6eteUlZq+P3b/gvASL
 aY9A==
X-Gm-Message-State: AOAM530Bk/CHPz36vp/IgLyAqjYi7RsGkM8/oI3sD2LA7Wnh16Z3Nj/J
 aWTAYxXitPy3Lchn8nkQDvfONwyOSyM=
X-Google-Smtp-Source: ABdhPJxRQVtg0/bwI9ZbPf1bAEwjzRMn66tsTWxNgC1iYvkUTAX9QtsvwyheLFsjw+xAuuDvJoMXNg==
X-Received: by 2002:aa7:800c:0:b029:22d:3f81:553 with SMTP id
 j12-20020aa7800c0000b029022d3f810553mr10333434pfi.41.1617937990429; 
 Thu, 08 Apr 2021 20:13:10 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id b17sm664893pfv.187.2021.04.08.20.13.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Apr 2021 20:13:09 -0700 (PDT)
Subject: Re: [PATCH v3] swiotlb: Make SWIOTLB_NO_FORCE perform no allocation
To: Christoph Hellwig <hch@lst.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20210321033740.312500-1-f.fainelli@gmail.com>
 <20210323015350.399493-1-f.fainelli@gmail.com> <20210324084250.GA4474@lst.de>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2ad22811-24e8-0776-3e55-ea2a4ac55f55@gmail.com>
Date: Thu, 8 Apr 2021 20:13:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210324084250.GA4474@lst.de>
Content-Language: en-US
Cc: "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
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



On 3/24/2021 1:42 AM, Christoph Hellwig wrote:
> On Mon, Mar 22, 2021 at 06:53:49PM -0700, Florian Fainelli wrote:
>> When SWIOTLB_NO_FORCE is used, there should really be no allocations of
>> default_nslabs to occur since we are not going to use those slabs. If a
>> platform was somehow setting swiotlb_no_force and a later call to
>> swiotlb_init() was to be made we would still be proceeding with
>> allocating the default SWIOTLB size (64MB), whereas if swiotlb=noforce
>> was set on the kernel command line we would have only allocated 2KB.
>>
>> This would be inconsistent and the point of initializing default_nslabs
>> to 1, was intended to allocate the minimum amount of memory possible, so
>> simply remove that minimal allocation period.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Thanks! Konrad, can you apply this patch to your for-linus-5.13 branch
if you are also happy with it?
-- 
Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
