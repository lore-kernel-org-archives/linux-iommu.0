Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C634EC433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 07:27:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC2361261
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 07:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7FC2361261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4287F400FD;
	Thu, 30 Sep 2021 07:27:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id khr2MZHD7gTz; Thu, 30 Sep 2021 07:27:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 04A21402F7;
	Thu, 30 Sep 2021 07:27:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD89AC000F;
	Thu, 30 Sep 2021 07:27:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47C5EC000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 07:27:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 29FEA84061
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 07:27:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NhwHjUfDsONV for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 07:27:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D24B84050
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 07:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632986828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qy9WRhHp+DckeiCl72dOjoCeu3Wb9LP/kki0BngYX9Y=;
 b=Qb63dcWyEO3hbq1YJo2koaPvXaKAi0wpb9or6pL+YjP5087Uaroh5YMJhJItIVMBEbt6Rz
 G3gFmfPHO/iQRHbh7Xfi3+zSmPa4NAkHwpPX+hzBhIdUgP37FEKA3G5m4Mh7TLBsa0dV0h
 FwmZ8JP3Ri6MjEjc3aX9CKomz7s1u8I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-LIn0DooWOjy5eCMUMHhu_w-1; Thu, 30 Sep 2021 03:27:06 -0400
X-MC-Unique: LIn0DooWOjy5eCMUMHhu_w-1
Received: by mail-wm1-f71.google.com with SMTP id
 k5-20020a7bc3050000b02901e081f69d80so2501687wmj.8
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 00:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Qy9WRhHp+DckeiCl72dOjoCeu3Wb9LP/kki0BngYX9Y=;
 b=k7vrubK5x2fpFIeH8Ne9ZAB2PTdZXEUu4vN1svUoAUVhhf3kouAV955Pe8iBZ1oLwg
 blTDS7+fChabGLAlPrdFMhrV5BBqZqSiOCXEBXKPmnGME5yBU/xody5MT+ICMRTHCIkP
 nBvSHqocr1j6UOkiz8+2WCXA3dzjK7zmMyYFDMCNw9r+yhfoWl01WAkkylawAAJDtr7X
 HUb+NS8A0wN8/6KjQAzobJtmRmiwX6am+K/RutF6wXHzpS5svviHB1M7P9+egSgjqxUv
 MrPCouRPBpxbnVhcPMl25Bju2+0qwdpmzs632Gs6dg8lqUxJFekxXb1YwH6adIAB44bE
 FXPw==
X-Gm-Message-State: AOAM531RaGtxv1BI5WHxcVJIUQO6lO2iCsnhY0qkJMobq0PNfvxCzWXx
 vWaxht0YriYmKOENBf5wrn4RLtXWS2mbnifbyzpzvWqh+BzTTSJIscdRF6DYvy17w+pXvZSa3Ol
 1FHvV8GbnNH/q+6GARivhbMDw3joyzx5JRirOlybPUMtJNcakfHAAcdX6ZfLrIKuuoP2nQLRY2V
 P9Vw==
X-Received: by 2002:adf:fdc6:: with SMTP id i6mr4498894wrs.362.1632986825542; 
 Thu, 30 Sep 2021 00:27:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIDBiNNvN8SUl6rxuTL+jFXSZtDp5YR0avYG79v2If5x+IxDM4AS3UDfBBgfFDz0fitXteUA==
X-Received: by 2002:adf:fdc6:: with SMTP id i6mr4498858wrs.362.1632986825273; 
 Thu, 30 Sep 2021 00:27:05 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64bb.dip0.t-ipconnect.de. [91.12.100.187])
 by smtp.gmail.com with ESMTPSA id v23sm1494302wmj.4.2021.09.30.00.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Sep 2021 00:27:04 -0700 (PDT)
Subject: Re: [PATCH 1/2] dma-mapping: remove bogus test for pfn_valid from
 dma_map_resource
To: Mike Rapoport <rppt@kernel.org>, linux-arm-kernel@lists.infradead.org
References: <20210930013039.11260-1-rppt@kernel.org>
 <20210930013039.11260-2-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <8824cc96-3e7c-b65f-9631-c1acfbd1ed56@redhat.com>
Date: Thu, 30 Sep 2021 09:27:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210930013039.11260-2-rppt@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Will Deacon <will@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Alex Bee <knaerzche@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@linux.ibm.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On 30.09.21 03:30, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> dma_map_resource() uses pfn_valid() to ensure the range is not RAM.
> However, pfn_valid() only checks for availability of the memory map for a
> PFN but it does not ensure that the PFN is actually backed by RAM.
> 
> As dma_map_resource() is the only method in DMA mapping APIs that has this
> check, simply drop the pfn_valid() test from dma_map_resource().
> 
> Link: https://lore.kernel.org/all/20210824173741.GC623@arm.com/
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
