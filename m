Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482448476
	for <iommu@lists.linux.dev>; Fri, 23 Dec 2022 14:15:50 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id kw15so12277355ejc.10
        for <iommu@lists.linux.dev>; Fri, 23 Dec 2022 06:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxcMe0Os2CLd8DrC5SPm9UsJfIj4MxnAyfLWs8/rZ6Q=;
        b=C2CWmMZmvz+JkpMFwXq8tGoHtLqvc36gmbDJD/lUkNHSf/STjVrn+1LmpacEBM4OXg
         ufUrYbgv91eGE7PEKCAv44nsQLxhd2fdoxfuPzDup/iG033Ayv2ogauR6buwZmnd17iR
         XufsnJtXM2XrgOeiEiVdmLsEFEQOh4mJOn+PoGrLAiO3udbXHmtoSq771ZT2ubje40Vn
         sc8NATkkC6lRfxB79kIWkAP90EZiPvhejeRoGlxoHcjFLFR/Adq3PaBiejuWg+CRxwhb
         ADA0dttWZzpLhM33TZy9yOm1BSlQYBRnOnxgnji2/61bO//q077AZ8OxiQ4Z7Ct6xaPy
         okSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XxcMe0Os2CLd8DrC5SPm9UsJfIj4MxnAyfLWs8/rZ6Q=;
        b=lZjk5rOUl/DzSBSioj0SPMHunAIGrfsh5WYDuSKfZvdKkplOOR9TmUaqmSds3HMaED
         fLqp0/FYHkAv/yXfnHZ8btsXjTlC00XSqJJO+t9TySjE1/eo06KkIZ2xwOcOyvQ4TPiJ
         GX/FuXONPUJFbWPlMd+TttCpz8RkA11yVh1HTN4X/sHbmb4yJw+gMD+BNLDpJHPQrV8/
         IxueeGWD9E4Kn66Y43ifOpcUjfx5CYKwO4q74wSJG2kwjQ8QiVHLwEw8ieazbQiRyQXD
         kQIsWphZNvjU9rA4JyTEwJehvjy6o4XP9kyep4EXwOSzm2psxxzYrK4L1tjkMqTYVYSZ
         pTeQ==
X-Gm-Message-State: AFqh2koKZHZIor42uCc3gAeg8FAyTCzyQ2xtqFk7e+VfsDkZtHAutd27
	wXqkGF3RPCPHaf3W1DEKft8=
X-Google-Smtp-Source: AMrXdXtynENf3tIE0bQJup9upFNaHJqdVlwP0H7Otd6vetF5y2pyZvV88caCKrEZXJC0CSDzOW37EQ==
X-Received: by 2002:a17:907:9d19:b0:7b9:f9d8:9554 with SMTP id kt25-20020a1709079d1900b007b9f9d89554mr7244445ejc.40.1671804948374;
        Fri, 23 Dec 2022 06:15:48 -0800 (PST)
Received: from ?IPV6:2a02:1810:3e1d:aa00:47f0:a197:6e87:4e8f? (ptr-1v3h17jmmq23dx2hcb3.18120a2.ip6.access.telenet.be. [2a02:1810:3e1d:aa00:47f0:a197:6e87:4e8f])
        by smtp.gmail.com with ESMTPSA id lb2-20020a170907784200b0084aade9d6b5sm221045ejc.17.2022.12.23.06.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 06:15:47 -0800 (PST)
Message-ID: <14dccd8c-e29a-fe93-5d4c-f0c3ff4f2430@gmail.com>
Date: Fri, 23 Dec 2022 15:15:47 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: ru, nl, en-US
To: hch@lst.de
Cc: iommu@lists.linux.dev, robin.murphy@arm.com, m.szyprowski@samsung.com
From: Igor Klochko <igor.klochko@gmail.com>
Subject: [PATCH] arch/arm/mm/dma-mapping.c: fix __alloc_from_pool returning a
 dirty buffer
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi, 

A small patch for __alloc_from_pool to clean the buffer before returning.
 
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
