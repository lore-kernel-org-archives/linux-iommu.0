Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535BBC433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 14:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D40F684B4D;
	Mon,  6 Dec 2021 14:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nPjk3tY8VAZs; Mon,  6 Dec 2021 14:17:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D327682B08;
	Mon,  6 Dec 2021 14:17:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6283EC001E;
	Mon,  6 Dec 2021 14:17:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 404D6C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34A8860633
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:17:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rwqDgSHG2qAc for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 14:17:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B2C7E605D9
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:17:05 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id k64so2095327pfd.11
 for <iommu@lists.linux-foundation.org>; Mon, 06 Dec 2021 06:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=MlPjTzqAzGMiJV1XIvo3CWuIKKPvCgUAVf8fFzgqOVA=;
 b=aUNHCl+dyTHAibi55HobGp+ZEySdQG08OEI+Y5k9nKK1X7xf+qtKsmguZgkbi+whPm
 GdJx9SeuhwP2ruODw9GfMgbHlzGk1gA6u4kF0GNnRTEbqTtzWhv5aQOvFkSisqrp80Je
 AuiZLyvBxRbWVKNJfUOgUEgQe+/ruz2KLZzOD08be7j/r8WHZNcwGCfhgny3RP1zHKHA
 1KDnGlCjbWtR+gN0SkVDdYDBRV83mT0qrFufECTGnYo50zNSja6vhsEoHMcB7bAvEpfm
 2tJ0a1+Qw3wjhe2hKKQCf2+fKGAqtRWFQXDtWW6xNYHAMZ+JXZUxTRR80tunhwvY2yh9
 HWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=MlPjTzqAzGMiJV1XIvo3CWuIKKPvCgUAVf8fFzgqOVA=;
 b=R+U1t6GABO595/Nd5GMZxcCaQ7N11DdrXevurm4jl6WOcjdlvByfYZq5/Lqmivj6tR
 l4LwRT/F1r/4F3xJE9SjXD1Yeexcb85qrt3aaNOisN4obzeLXjvmdSTZZm2ieGgxH1iM
 2K8NfNE3CsLh64oM4P2ysl6CNjyHpClhMfC+Ra55AUp9L8UWU+63cQuNtNOzTsUE7kiG
 SYJrPSVIHbnBFWU/XxYEfHt58jMsSEBxewRck5pgILarUNMjmAu8ZdNxhy4tmPZ+BkEf
 7Nh4ILZ3b14lFKoWUnhgebuJ6AkvtOJi3T6ihJxqivaPIq4yeYeHRgh2X9WU08FlNqZb
 3lbA==
X-Gm-Message-State: AOAM53210/1WILjGJatl46ejNrkDE4ewTPxdUxro+9jfCdd080KSN8XY
 rhpt3dG34Q/M4oKL7r17FgA=
X-Google-Smtp-Source: ABdhPJwC0KD/zVGir6spSXosBbRFLHsih0Tulm1FqYapzoO5PMARObP84mGb9GeA31fKmf/7FDoFjA==
X-Received: by 2002:a62:1cc4:0:b0:49f:99b6:3507 with SMTP id
 c187-20020a621cc4000000b0049f99b63507mr37506196pfc.76.1638800225207; 
 Mon, 06 Dec 2021 06:17:05 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 d6sm10030597pgv.48.2021.12.06.06.16.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Dec 2021 06:17:04 -0800 (PST)
Message-ID: <ed333f81-0527-ae98-6348-a2bf6e783dae@gmail.com>
Date: Mon, 6 Dec 2021 22:16:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 1/5] Swiotlb: Add Swiotlb bounce buffer remap function
 for HV IVM
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20211205081815.129276-1-ltykernel@gmail.com>
 <20211205081815.129276-2-ltykernel@gmail.com> <20211206140916.GB5100@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20211206140916.GB5100@lst.de>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
 kys@microsoft.com, will@kernel.org, boris.ostrovsky@oracle.com,
 linux-arch@vger.kernel.org, michael.h.kelley@microsoft.com, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, linux-scsi@vger.kernel.org,
 x86@kernel.org, decui@microsoft.com, hch@infradead.org, mingo@redhat.com,
 kuba@kernel.org, haiyangz@microsoft.com, parri.andrea@gmail.com,
 thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com, arnd@arndb.de,
 konrad.wilk@oracle.com, jejb@linux.ibm.com, bp@alien8.de,
 xen-devel@lists.xenproject.org, tglx@linutronix.de, jgross@suse.com,
 martin.petersen@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com, davem@davemloft.net
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

On 12/6/2021 10:09 PM, Christoph Hellwig wrote:
> Please spell swiotlb with a lower case s.  Otherwise this look good
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> 
> Feel free to carry this in whatever tree is suitable for the rest of the
> patches.
> 

Sure. Thanks for your ack and will update "swiotlb" in the next version.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
