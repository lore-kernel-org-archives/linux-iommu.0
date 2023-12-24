Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC3101D5
	for <iommu@lists.linux.dev>; Sun, 24 Dec 2023 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2XWNsFgU"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-35ffc781b3bso58575ab.1
        for <iommu@lists.linux.dev>; Sun, 24 Dec 2023 13:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703453815; x=1704058615; darn=lists.linux.dev;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Os/oPiSZBtjIUvvwHAsDtB34DNNtYdnH9WgDGcFTsds=;
        b=2XWNsFgUbV/Mzzp+nu+qCyVY5KpgbuRQ2mHEYj2MUFyW26jocy5Qmw7aASR3c3BcyD
         HiWNEYq7D3zKp4kia+09kdqDoc73mq/7DbnQMTDTVX0NumdhUkf5V4cnjK87tgnOYaqb
         jkI4Uf3z3ypVwqxMf2ZEOpNDcTsBq3U0brwvRXLUEEN4JrvkcebKAB5MCYcNpdrl+Yki
         uj0+Irlksz2lmfsaI4wmcqE4LT2Z6GnzO3pSAmOTMWi8odLgmnjB3RTIypy/8oXtRJjA
         ihT9weOkGnZapqL3z+mocYk0hhN4fUFGM+ZNC0GwwAU6nZtUAYwate2FY2F2sJIpWqVL
         BMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703453815; x=1704058615;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Os/oPiSZBtjIUvvwHAsDtB34DNNtYdnH9WgDGcFTsds=;
        b=lnix3N80bSeNc7qxwBZzyuiXGuT6rH8xT+ZqvvhU11o1eGWHQdfX8FQq+bA8FmZZ79
         RzH7YdRWiRFZFRImmNZsBxYmm6lJJErVHHybPn+dGzC2gIo91iERywTXNtKYYMg3Ui7D
         qGF8+td6ufRENgzriJjrXmoF6gUeZ5E/f4crMnY391Qg2mtMo33Jf2HRiD1hS80Q7Phc
         YhamyPKsomKixck2zKoRfeJOYmPebDpq+FNujmY3azoFsLLk+bO3T85L1BpmjnsSRpKO
         n+xOsPcE22z9yv0PMw9FBF6YHRxBK//UZvR3cNgmm+5lqAtAQFHpzzw9KQTPphzeOV4i
         5AAg==
X-Gm-Message-State: AOJu0YywSy/+eyERKPYN9SLydGw42XCDw+hjtv89mJdTAxyn89DZMj0w
	4F+AI4ztY9pNBiHftLk06hyXEQz8RQ+w
X-Google-Smtp-Source: AGHT+IH2zcpLJWPKD+BeBsfBapGRJ4delpEMsonOf6psnFmaNZJ7wb6YGlKK2PGLdTvnRk1ktYgw3w==
X-Received: by 2002:a92:ca8b:0:b0:35f:65d8:dd50 with SMTP id t11-20020a92ca8b000000b0035f65d8dd50mr389199ilo.18.1703453814883;
        Sun, 24 Dec 2023 13:36:54 -0800 (PST)
Received: from [2620:0:1008:15:c723:e11e:854b:ac88] ([2620:0:1008:15:c723:e11e:854b:ac88])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b001d0ce267eaesm6915344plr.250.2023.12.24.13.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 13:36:54 -0800 (PST)
Date: Sun, 24 Dec 2023 13:36:53 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
    asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
    cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
    dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
    iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
    joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
    linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
    linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
    mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
    rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
    suravee.suthikulpanit@amd.com, sven@svenpeter.dev, 
    thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com, 
    vdumpa@nvidia.com, wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH v2 04/10] iommu/io-pgtable-dart: use page allocation
 function provided by iommu-pages.h
In-Reply-To: <20231130201504.2322355-5-pasha.tatashin@soleen.com>
Message-ID: <0db8fdb5-26ee-5069-30d2-118595516926@google.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com> <20231130201504.2322355-5-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Nov 2023, Pasha Tatashin wrote:

> Convert iommu/io-pgtable-dart.c to use the new page allocation functions
> provided in iommu-pages.h.
> 

... and remove unnecessary struct io_pgtable_cfg formal to 
__dart_alloc_pages() while there :)

> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Janne Grunau <j@jannau.net>

Acked-by: David Rientjes <rientjes@google.com>
