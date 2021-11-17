Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEC9C433F5
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 13:22:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9A261B1E
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 13:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0F9A261B1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1C7A605DE;
	Wed, 17 Nov 2021 13:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U6NPgG1HazEE; Wed, 17 Nov 2021 13:22:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A007360670;
	Wed, 17 Nov 2021 13:22:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76143C002E;
	Wed, 17 Nov 2021 13:22:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78622C0012
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 13:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 61EB180E0E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 13:22:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pEENnoJ4s-K9 for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 13:22:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC91180D3A
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 13:22:40 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id z6so2645556pfe.7
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 05:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=n7Jf+5/Jh7KOEFSs12H1gnleHX5Ul1EJihf5cWALbbw=;
 b=NMtrHwlhumZZGG7ACQ5UZwJN7rtTqhVOALh7ylXTR9G6Y8zmsKtbGjwSxvzwVD314V
 mFlCILMpoJPcOxUNV38QoEdCs8zz43HlJK1GNiNc4P2QVifmYL23tPn/GqSDrxCGPg16
 bvAIjKJA0lzwI5sAj/KKF7Bc8fhHe/9Wx28bmwIGJrkCjDmdcCDuD5dw7cCpuvtFoqub
 iSkzJKRMidoqCXXQSY0sUPKp3Cs63451CNuN8JlBUt7M7BBJqI/PFOoctzgC3YAkmPjZ
 yOWSQXVn3LZwrWkLZBlx3QxZWWBmdX22onr58Glga9JdD2AAQeBuO5o77eDt6FelUOw8
 iVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=n7Jf+5/Jh7KOEFSs12H1gnleHX5Ul1EJihf5cWALbbw=;
 b=6wwHDqM7u7a4H0OwJnN6gIojtKMTt0uFTosvoIrVa35Dzb6N5AByxk2Nbe6Rwh45Ye
 UpYJN8tVJEu6S0Tj+ZBPCVYA50wRNfH2UWa0xi3nxCVMSIzaaRZdCkLgRVWUvw2LH0me
 NOEiNk8JAWOUwR/WrakrUsQCH4QwG6ZgIrKD4bHlcroczh8s+pPwGyBOQq6KiZ5iyoSv
 8mQBrRichxU59maifsqurhpwG8rm/G14WvFxe1C/sDgIkJqv+HALZDMtAGDgmQLTA4PK
 2DDOMjU5DWqdfw7KmzNTpP7xhaAW/aX7WReMZc3yKrYwZ1/F63itvN9jBOIS2+aKdgRu
 yfPg==
X-Gm-Message-State: AOAM531+uSjev8OP2Xwt5S3LAwaWAulR6JtLcy1EmV6JIdR7mr8c5Gst
 5HcvkBEkMqnJeSuZGuXxvVY=
X-Google-Smtp-Source: ABdhPJwYIet5fq/8KowjGXs7GPhnQ/zbG+7NtQHLznln3NXsAVsDB6ZMleQEQVqBwkPH6jdcXK5meg==
X-Received: by 2002:a05:6a00:2146:b0:44c:2922:8abf with SMTP id
 o6-20020a056a00214600b0044c29228abfmr48946221pfk.27.1637155360284; 
 Wed, 17 Nov 2021 05:22:40 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 t40sm23310231pfg.107.2021.11.17.05.22.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Nov 2021 05:22:39 -0800 (PST)
Message-ID: <fb9809f5-a830-733e-745b-aa1b1d2671f5@gmail.com>
Date: Wed, 17 Nov 2021 21:22:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 3/5] hyperv/IOMMU: Enable swiotlb bounce buffer for
 Isolation VM
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20211116153923.196763-1-ltykernel@gmail.com>
 <20211116153923.196763-4-ltykernel@gmail.com> <YZQCp6WWKAdOCbh8@zn.tnic>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <YZQCp6WWKAdOCbh8@zn.tnic>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
 kys@microsoft.com, will@kernel.org, hch@lst.de, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, linux-scsi@vger.kernel.org,
 boris.ostrovsky@oracle.com, x86@kernel.org, decui@microsoft.com,
 michael.h.kelley@microsoft.com, mingo@redhat.com, kuba@kernel.org,
 haiyangz@microsoft.com, parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 jejb@linux.ibm.com, luto@kernel.org, xen-devel@lists.xenproject.org,
 tglx@linutronix.de, jgross@suse.com, martin.petersen@oracle.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com, robin.murphy@arm.com,
 davem@davemloft.net
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



On 11/17/2021 3:12 AM, Borislav Petkov wrote:
> What you should do, instead, is add an isol. VM specific
> hv_cc_platform_has() just like amd_cc_platform_has() and handle
> the cc_attrs there for your platform, like return false for
> CC_ATTR_GUEST_MEM_ENCRYPT and then you won't need to add that hv_* thing
> everywhere.
> 
> And then fix it up in __set_memory_enc_dec() too.
>

Yes, agree. Will add hv cc_attrs and check via cc_platform_has().


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
