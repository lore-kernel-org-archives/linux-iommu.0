Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC088AD3B
	for <iommu@lists.linux.dev>; Fri, 23 Dec 2022 22:51:46 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id a17so5642615wrt.11
        for <iommu@lists.linux.dev>; Fri, 23 Dec 2022 14:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zgisrB3GXNhfj5QT7PKxGigPHzkLxOAE80ws9v/ODJ8=;
        b=JE2sWa4Yu8dThdpQj3hdzwoPJgLu7Ek5c1lxnDvQGaciiOYLhqdLmVr3wa029wMEVA
         6RuDnZ7fgmAgEVNjPeqrGXqldcw28ogkJ6BXpLLr9NvUcrUYREikb6fgHV9ykx57N+b0
         V9UAD25tyEQHR6fEK2gnne+2qD00QGios7IH4uLz89LRIkYTx+OjTLSin4Kj2L5fCYb3
         5Qf+3OlzC1jwjSB7w4NFkZwFxu7ra9pE3TarAc2MUmL9SJ/Zz9YaMN3OyRuYEbhUozU9
         TmB/IqMvA70grEzKQMOr2medIZ0O/Svb79/FFFRpyFvMgOWvP8AprwywHQN9IADSATjH
         yLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgisrB3GXNhfj5QT7PKxGigPHzkLxOAE80ws9v/ODJ8=;
        b=Yzvsj7jFy0HjpXDJnUwDhrIfeiCYh9vDtSu09PO1+izgBZyH0RVeVdcsm2YGv1KAsU
         BmnpStAaDXh/hQeN7feUakqh7K09zmDajvyLD0m719JA9W4MWqpv0PGHdCVrzmr8m3Qs
         B7fFK59kpPb4If9CtX/3ZF+G457657xljjoKwjBbwk/xRd8qbCDRmVrT0WvvRCLLXqwW
         hZE565NOpz7GCocPDWlkXd1JaCMen/N4om8cgDUfm8WF67/XsKxjbefDkryYjJbsYoIn
         +4wd70fOGPf/zsVc5YIMEnCw70iJHDHfVRFuPASwglIIYdejPn/sdl8qOZ0/1aEkyIsT
         N3nQ==
X-Gm-Message-State: AFqh2koXtlhpO3vvkNlrKPY8RvDgxyzrA8xFX2Q781fr+OoxJISTPlus
	ysW7JXyaVNjMkoxSB/tAACw=
X-Google-Smtp-Source: AMrXdXtt+Ih5c4VxAqOcpkOcTe0xqgySyIhL7c0oN5cdG0RpuCrrNVzwFokN2JmYf7bRN2PMMucddQ==
X-Received: by 2002:adf:de05:0:b0:260:4cca:ffb8 with SMTP id b5-20020adfde05000000b002604ccaffb8mr7179240wrm.36.1671835904860;
        Fri, 23 Dec 2022 14:51:44 -0800 (PST)
Received: from ?IPV6:2a02:1810:3e1d:aa00:47f0:a197:6e87:4e8f? (ptr-1v3h17jmmq23dx2hcb3.18120a2.ip6.access.telenet.be. [2a02:1810:3e1d:aa00:47f0:a197:6e87:4e8f])
        by smtp.gmail.com with ESMTPSA id p11-20020adfe60b000000b002366e3f1497sm4355665wrm.6.2022.12.23.14.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 14:51:44 -0800 (PST)
Message-ID: <43ef46fc-2fbc-31b7-d683-f7496b39dae5@gmail.com>
Date: Fri, 23 Dec 2022 23:51:43 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arch/arm/mm/dma-mapping.c: fix __alloc_from_pool
 returning a dirty buffer
Content-Language: ru, nl, en-US
To: Christoph Hellwig <hch@lst.de>, linux@armlinux.org.uk
Cc: iommu@lists.linux.dev, robin.murphy@arm.com, m.szyprowski@samsung.com,
 linux-arm-kernel@lists.infradead.org
References: <14dccd8c-e29a-fe93-5d4c-f0c3ff4f2430@gmail.com>
 <20221223143938.GA29147@lst.de>
From: Igor Klochko <igor.klochko@gmail.com>
In-Reply-To: <20221223143938.GA29147@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks Christoph,

Added fixes and a changelog.
This issue is present in all current LTS versions.

----
Buffers allocated by __alloc_from_pool() should be zeroed out as done by other allocators.
Certain drivers expect a clean buffer and clearing the buffer is beneficial from the security point of view.
---
Fixes: 36d0fd2198da3 (*arm: use genalloc for the atomic pool*)
Signed-off-by: Igor Klochko <igor.klochko@gmail.com>
---
 arch/arm/mm/dma-mapping.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c135f6e37a00..bb2bb3ab497a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -366,6 +366,7 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
 
 		*ret_page = phys_to_page(phys);
 		ptr = (void *)val;
+		memset(ptr, 0, size);
 	}
 
 	return ptr;
-- 
2.39.0




Kind regards,
Igor Klochko




On 23/12/2022 15:39, Christoph Hellwig wrote:
> On Fri, Dec 23, 2022 at 03:15:47PM +0100, Igor Klochko wrote:
>>
>> Hi, 
>>
>> A small patch for __alloc_from_pool to clean the buffer before returning.
> 
> This does look correct.  The "normal" allocators seems to do the
> memset through __dma_clear_buffer, but the __alloc_from_pool seems to be
> missing it.  Please write a proper changelog with a signoff, and
> preferably a Fixes tag if you can find what introduced this.  Also
> the ARM code needs to go to the ARM maintainer and arm mailing list.
