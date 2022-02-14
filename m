Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40B0C433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 11:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69C4E60EBF;
	Mon, 14 Feb 2022 11:28:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qdY3g26wyyLM; Mon, 14 Feb 2022 11:28:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 471586059F;
	Mon, 14 Feb 2022 11:28:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 222ABC001A;
	Mon, 14 Feb 2022 11:28:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38D50C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 11:28:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 267454092D
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 11:28:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zz9QFO6_xotF for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 11:28:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02E9C40913
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 11:28:48 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 d9-20020a17090a498900b001b8bb1d00e7so15485816pjh.3
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 03:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=UTXgoU8n+KrzppBWMa0hmTFNwCf9odk0keuvKtaxU/k=;
 b=cnBuoZw/RKHhZsGhbrd4qubVrdgqaBcgF2vbB3TLWl8veImaTHi6FiowKDVE2OsPaQ
 3+hEBVsaBZoUrga9sKj4zUSo7mwvsBepRCyWZAOkpyC7qZ/1ezKf3T64rZSWOA4XrXXs
 5K5UEu+nNpRJzOuKQyecbIjxZdyKqqVqMdQmmH/y99QQZ2kLWX23TkzeaP7dwJYBhTGx
 KWdHVfBFhbFbPJNr7CIbLXk7xUbGCPvkEZRtzuQdqKA4zrI/dlxwPXgbsbEVTWQ3y65D
 c4EGfc4mJuFpDkcNpdzxW1BLPwFzNXaHGJKkG/2srCpvk64MoTle8XsxOayWytNs2HVr
 dFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=UTXgoU8n+KrzppBWMa0hmTFNwCf9odk0keuvKtaxU/k=;
 b=VxvyhYQ/JXDCb3I3SotADXXb7hr3eZwrtaIGEHa7041wLT0DW+uvRYR2ibZIr10wvc
 KBJeqxqyvlcxqeeYNV+K5x5V7DSN/yfweCuywVEuaYa8nxdwbnUmw7zyaWGLAqwm9a0N
 JQvoK0f+uQoM0mEM84grouxM9tTi5KsYV9eKmkZouuFh16kEII3jT7HI7Gr9YiYbV/Lc
 VvITk8megGRtxaibEBknG/ssi10u3wQGJqRbBk3qQ3MJdwPskTIsLz2mN90zB4cG/CkL
 d240WEJkKpLfTuymhVRN1TzORvQC9/EG3J40VHM6h2w75aBbBiyst6qHcdihLMw9Ta07
 Z8iQ==
X-Gm-Message-State: AOAM5329Rf+ReJ6cXUmlM06gVxwCfMF8XUsxTRkdCcKIcJGTVAXtH8da
 ecNBKJPpc5xX/nR4FQCXPNs=
X-Google-Smtp-Source: ABdhPJzFsd/ZU8jacmR8tjLDWME3wdGPlEDldYIhUxu28Eo9nQBVjMthkkAZOx//XOQb15xsKiE/EA==
X-Received: by 2002:a17:90b:4c06:: with SMTP id
 na6mr14002951pjb.62.1644838128522; 
 Mon, 14 Feb 2022 03:28:48 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::52c? ([2404:f801:9000:1a:efea::52c])
 by smtp.gmail.com with ESMTPSA id
 16sm14490561pgz.76.2022.02.14.03.28.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Feb 2022 03:28:48 -0800 (PST)
Message-ID: <4f433f07-05be-f81f-43e8-55c3f1af23b3@gmail.com>
Date: Mon, 14 Feb 2022 19:28:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220209122302.213882-1-ltykernel@gmail.com>
 <20220209122302.213882-2-ltykernel@gmail.com> <20220214081919.GA18337@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20220214081919.GA18337@lst.de>
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

On 2/14/2022 4:19 PM, Christoph Hellwig wrote:
> Adding a function to set the flag doesn't really change much.  As Robin
> pointed out last time you should fine a way to just call
> swiotlb_init_with_tbl directly with the memory allocated the way you
> like it.  Or given that we have quite a few of these trusted hypervisor
> schemes maybe add an argument to swiotlb_init that specifies how to
> allocate the memory.

Thanks for your suggestion. I will try the first approach first approach.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
