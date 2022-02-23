Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C9AC433F5
	for <iommu@archiver.kernel.org>; Wed, 23 Feb 2022 09:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F86C41517;
	Wed, 23 Feb 2022 09:46:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id royWwlJIN9rN; Wed, 23 Feb 2022 09:46:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6D34541518;
	Wed, 23 Feb 2022 09:46:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EB7FC001A;
	Wed, 23 Feb 2022 09:46:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69F17C0011
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 09:46:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51EA360F41
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 09:46:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l8C5nfeSThLb for <iommu@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 09:46:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D0A5460F35
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 09:46:47 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id i21so14790905pfd.13
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 01:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=JB14j33OIPs1OGizD0q9pEqsxND8clVKLhTJqZTYOEc=;
 b=h2qK/+1UhNIaADfvFYzi0SHlb7e0Q/Ppl0nuTgX88goT4YiO3WoB5x46n31RnWQ6FK
 rQ4PIPSEy2IREvN5KHI8eBNErn2eu0xq7kJOc7Lsk6hL9nFBEZTEIqB9LIfQc57AsnlE
 jklVKf/CwE3i1EgmHTfY/xIbeY7EXJq/gdSgDKa4kPAUU7gnMj/Q7eQDHW+8r9xv2I46
 Rs3Zjq+UJKWXzGx0Kz3M/QjATpgD7wR8rIpeH7gvrh7sXAFhUgUUP7eeRTEZ2chkYNWr
 xE/Bula0Tta+VO7n7NXnjhT4SJwVZ5qhrEjLUkxA5BUaY8HcNlW07ZOUTpNcXW+bIO5n
 2ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=JB14j33OIPs1OGizD0q9pEqsxND8clVKLhTJqZTYOEc=;
 b=B/LsQZGuVceeZM+9OMRsAoBt/Z+TuuyCmQ3SDcL0TMfXBXuHnzIxQpX+ERVwIc0GlP
 5BydTDhsAtIKel9AdGIom7JAoi+ozqP3vibA2ASTkdvmrCzbwhGZZMu8k8WyAxbcLRjt
 xJ5Q1u5Bm/gXyh3fGPkNfWulQmEdFdY/FkoHL0GaQip4E32qAqnWHj8NHYBq/WqUKwUJ
 OzShXd7nb5rC53TRUDKGHrqpSJKfDak8WaMlddPMpEyweqXbG7GwG1RM1uh8DDquvbsl
 NXb5lxZfUQ2QWNvu4ti9l1iKFEJpV9rHa4YVzYpmWD0Yiy+vnJaC1GDQscye2sXmEjRi
 ESQQ==
X-Gm-Message-State: AOAM532//ZaEDRyk9dEFTRGpJZdSF7oEZPQt7tsMFGB/YKoVLTxh2BH3
 JjCSBxmaX4Rf5TLTnqTZNQs=
X-Google-Smtp-Source: ABdhPJwO+VZiM9CHOaWQb//I+ozQnEAAeKik4xggTRSisdu0hPGa/PxgcNPeZUw+9X4py3EPVZSr8A==
X-Received: by 2002:a05:6a00:a92:b0:4e0:57a7:2d5d with SMTP id
 b18-20020a056a000a9200b004e057a72d5dmr29045712pfl.81.1645609607206; 
 Wed, 23 Feb 2022 01:46:47 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::754? ([2404:f801:9000:1a:efea::754])
 by smtp.gmail.com with ESMTPSA id
 w2sm19827467pfb.139.2022.02.23.01.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Feb 2022 01:46:46 -0800 (PST)
Message-ID: <40f91949-58fa-4be2-5b01-ea34dda58670@gmail.com>
Date: Wed, 23 Feb 2022 17:46:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220209122302.213882-1-ltykernel@gmail.com>
 <20220209122302.213882-2-ltykernel@gmail.com> <20220214081919.GA18337@lst.de>
 <4f433f07-05be-f81f-43e8-55c3f1af23b3@gmail.com>
 <20220214135834.GA30150@lst.de>
 <8d052867-ccff-f00f-7c89-cc26a4bfa347@gmail.com>
 <23f4a64d-5977-1816-8faa-fe7691ace2ff@gmail.com>
 <20220222080543.GA5412@lst.de>
 <00112505-4999-ac41-877e-49c4cc45312e@gmail.com>
 <20220222160039.GA13380@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20220222160039.GA13380@lst.de>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com,
 hch@infradead.org, wei.liu@kernel.org, sthemmin@microsoft.com, x86@kernel.org,
 decui@microsoft.com, michael.h.kelley@microsoft.com, mingo@redhat.com,
 parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com
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



On 2/23/2022 12:00 AM, Christoph Hellwig wrote:
> On Tue, Feb 22, 2022 at 11:07:19PM +0800, Tianyu Lan wrote:
>> Thanks for your comment. That means we need to expose an
>> swiotlb_device_init() interface to allocate bounce buffer and initialize
>> io tlb mem entry. DMA API Current  rmem_swiotlb_device_init() only works
>> for platform with device tree. The new API should be called in the bus
>> driver or new DMA API. Could you check whether this is a right way before
>> we start the work.
> 
> Do these VMs use ACPI?  We'd probably really want some kind of higher
> level configuration and not have the drivers request it themselves.

Yes, Hyper-V isolation VM uses ACPI. Devices are enumerated via vmbus 
host and there is no child device information in ACPI table. The host 
driver seems to be the right place to call new API.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
