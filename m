Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9C2231A
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUMjEJvE"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-27d1aee5aa1so66907a91.0
        for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697048525; x=1697653325; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hN3Y1Gx/7diunP62IVxUnXD4EF9Jlv9k/rCp+joDrQ=;
        b=mUMjEJvEYY5aKXpONX4Rg6GNkQ9JPI1A4WD1xUjVK8ADVqn0//np/xKqaswVhduWvQ
         UNT/0/2ajBVQtUl5RK5SsUOoWSjAMzQkwbLAFAijDy/rcjfQ+vnqW1Bw0GO6UfVYpVfm
         2UOHfl3+wW1A4IOug31by41HDzqGqtksDp8jJvU6fV42Sqri+snaFBp8d/VugILl48OI
         6UfrB8zDm5pcr6ZVtEYZRGvuhopFEiuw7buJ8iWRFXm9jNWNRGuGvgbWR/+ZuwjMbQky
         TaYta0id27WDUVq9h7JXSwcX4votkl27Nq9RdQL3KNZhFt3PI5rkVzBzBbPjww6EYfCL
         IYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697048525; x=1697653325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hN3Y1Gx/7diunP62IVxUnXD4EF9Jlv9k/rCp+joDrQ=;
        b=I3w7sbqYuqL+XEHLv480iSQt9SSovblGGmv9Syt6Id4+Ur/rP38bOJHFiqg4mZv2Oy
         g6JOmBc/VpY9Mdj+2RC3oXguwjDYlSrFCXLgomME6WCOwFOozp6W/Y6wWa/MitSWs+Xw
         a4a2hao+l2LmEA5AGNaESabZ4dr2RL+Q1sHMVC9q3fYMaSk9xRfhgPTE43COAMExsUW8
         vliEj5CsRxEiNTuEP8N//eklfPmiL264167xW8S0NCKQJnINaFF5sVn7EeT00PngN8ZC
         gUIYFoyDR/GdDgwqxNep0rU/L5F+typ+KCcnx/2h070f3SFjBm14rOMZ4ay3hJNzQwsh
         c/Ag==
X-Gm-Message-State: AOJu0YzJBuUB1SpMW6L/KH8QTrkId96lRYR6cG172hq+40P+uMwqDlqm
	UE2nKyms5u4Vy6JuYwE0Tmw=
X-Google-Smtp-Source: AGHT+IE5i9kcTlfZR2H5tYKcfbjlJT+Ckal6PZYpU1eGohJyt0+C8lji4HPCyFEuAw/5DTaKt+dj2g==
X-Received: by 2002:a17:90a:348b:b0:27d:c5b:747c with SMTP id p11-20020a17090a348b00b0027d0c5b747cmr2765992pjb.2.1697048525371;
        Wed, 11 Oct 2023 11:22:05 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:298e:308c:8339:ebb8? ([2001:df0:0:200c:298e:308c:8339:ebb8])
        by smtp.gmail.com with ESMTPSA id e5-20020aa78c45000000b00692acfc4b3csm10246601pfd.136.2023.10.11.11.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 11:22:04 -0700 (PDT)
Message-ID: <12c7b0db-938c-9ca4-7861-dd703a83389a@gmail.com>
Date: Thu, 12 Oct 2023 07:21:52 +1300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/6] net: fec: use dma_alloc_noncoherent for m532x
Content-Language: en-US
To: Greg Ungerer <gerg@linux-m68k.org>, Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org,
 netdev@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>
References: <20231009074121.219686-1-hch@lst.de>
 <20231009074121.219686-6-hch@lst.de>
 <ea608718-8a50-4f87-aecf-fc100d283fe8@arm.com>
 <0299895c-24a5-4bd4-b7a4-dc50cc21e3d8@linux-m68k.org>
 <20231011055213.GA1131@lst.de>
 <cff2d9f0-4719-4b88-8ed5-68c8093bcebf@linux-m68k.org>
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <cff2d9f0-4719-4b88-8ed5-68c8093bcebf@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Greg,

On 12/10/23 02:09, Greg Ungerer wrote:
>
> I think this needs to be CONFIG_COLDFIRE is set and none of 
> CONFIG_HAVE_CACHE_CB or
> CONFIG_CACHE_D or CONFIG_CACHE_BOTH are set.
>
>
>
>> in the fec driver do the alloc_noncoherent and global cache flush
>> hack if:
>>
>> COMFIG_COLDFIRE && (CONFIG_CACHE_D || CONFIG_CACHE_BOTH)
>
> And then this becomes:
>
> CONFIG_COLDFIRE && (CONFIG_HAVE_CACHE_CB || CONFIG_CACHE_D || 
> CONFIG_CACHE_BOTH)

You appear to have dropped a '!' there ...

Cheers,

     Michael



