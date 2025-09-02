Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12BA2DF14B
	for <iommu@lists.linux.dev>; Tue,  2 Sep 2025 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804935; cv=none; b=KHlIbGh21ujUM+nTwZvsn+qFbrM2IPis7a0rfP5mYdrJKuqDvqQ3dSDBfb8432ACYRUvcvD9rZ9lRfRtoYFgT64sQ0PuoUYoaG7jC42CdBT7BwfglhfUHKWvt073NFoPjFsQZVpNMWllslT48Fg30c5P8ZAOqoCj8IJvwC2EWzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804935; c=relaxed/simple;
	bh=Pv1NlzKjL0xFo8BfGbhy/7KnNZN8WrItjraHEOkXixw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzTZP6ZDMNgQfDToWsJCVoQX5vZT3zSvnGxa8OZJkExt6ZA2c5yv+Pu1GN9o9l6rgQL7pt10eVIeIO5QYiEvm6A1JJUYoMMxFmT2yNKAe6dam8p8lFc4jOAYKB47hifww5UAO2l01Qt7klrb/qY4Z/yTi+b901mKfZIvef1mKAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=f4AZB+rR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="f4AZB+rR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b873a2092so23014425e9.1
        for <iommu@lists.linux.dev>; Tue, 02 Sep 2025 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1756804931; x=1757409731; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Be300C9M54HN2j6qqn3KzILYOn0Dm/rUn/s4aJntRQ=;
        b=f4AZB+rRIaUPyW89wvX5eDR/vABu88lRS92sbr7NU3y3ZHD8uehKtnnVIe3989cdMN
         t8fFlIKYNjc0HDb+iFVHDJr3+B3oVQr2zsZyIn+jsTE1JWGfoCeogzm/T3tWuTzFi1mz
         46nedIo4hjPDepLHZ8Q3LMamhv+4ZSoC1b2GyRy3Fr+djYEgxCAropArWXMKLLA6wxF/
         yXXjH75U1RH7/VNroONyXkYL4EF8uX/NFdvgPFO/YfBHyB0tdSgNhBhf/DVQGQtW/apo
         vnjlG+0TwBGyzHfVlfFzdMWaB1S7AVDYk6gGtN71xgqE43EL0dlYLWca1Xj4XfspVltF
         /drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756804931; x=1757409731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Be300C9M54HN2j6qqn3KzILYOn0Dm/rUn/s4aJntRQ=;
        b=jw86Z6PDIBBeRbHJhmkiT7cyai2NYt530Ado6Rq4kafywjXiyUCb7O6HkZDlavJziu
         uF22fi5475wtv+Y2YrajsgQHAnV/lZFSqxbZ8VDlPHUXpXyDu9SMn8behE68ON/PRLxW
         NlQWN5xB5kcwcv85N0Z7BdpFxcNlXyzStgWS5+4H5+RKW1C6APvx4apJsbe32X7jzipb
         65MNh1WlysyjIK4Ln8uP+6xc5DoGI1k6n341VBKeKw0Gi4oX5WqMKVDoXZ9VwOE0R3WE
         BVY5A4MKokr5t+bo36pDhqsI7OwW2/wbkaIkkt3TDrkX4zWBgR22tjStP+BiaTVL407v
         a4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWx22JzCuCwkCgf4DFjWYY9pdTeaVCeCpCq5NbCJFyYc14PtHgjmkFMiBq7e87fY1bh7cPMIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQ86hhux7NbMgt2WytMzZkEI2/JQnjhPI/7vwxwa1Em4N8KDJK
	W0Z0GdsWArWCvopnfEXWuC2R/6qKvdCOCY7qbCrziy44zJT6UC1PMsht9MkcD0QkCzDSjtDwI1k
	uoBQGI3o=
X-Gm-Gg: ASbGncuLZejpuIDvCNHPmXnmN2kfcKR1ISCcZP9p1WTS87baCb/2lU96lrFXG3NKxpL
	yvtrgbMhOVi4GfR0YS5EWBAa242Zn+7NW/PcLGl0INr9WlG/ndccckldhiFGldP/19vtUwUpTcP
	TyeUDfx1qwxvKNWTDLhcShNe8CSrMSCrcRvyI41DQgCCJ6RUH3ROFGu3ThbFOLPO4feIbbiaz1n
	cq4Y8mwX/1qZMiSidm3W5Z3YwviFpQ960+NbZLLyEfppP2e9n5ZiMUd3goHqR3Ytl5EAYbieYyr
	qaPKXdpTupb+a2QqTjF5VSxI/aQoupWdVvNtypeqi5wki/I6L5+7gbV/EjcTOTVh1eTxUQWBW7i
	JjLR3LA/W45RDVnvUvG2rgAWnwXwSLAYS7bU=
X-Google-Smtp-Source: AGHT+IFjGWdM7r4OC2xPYq10JBW42QzIVS9ISDbv655toZnOdc57tKWSkMByc2ni755H7QY3mBnVYA==
X-Received: by 2002:a05:600c:a04:b0:45b:7d24:beac with SMTP id 5b1f17b1804b1-45b8553335amr94619035e9.10.1756804930815;
        Tue, 02 Sep 2025 02:22:10 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0b9402299sm17994846f8f.18.2025.09.02.02.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 02:22:10 -0700 (PDT)
Message-ID: <4bbf5590-7591-4dfc-a23e-0bda6cb31a80@ursulin.net>
Date: Tue, 2 Sep 2025 10:22:09 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/37] drm/i915/gem: drop nth_page() usage within SG
 entry
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>,
 kasan-dev@googlegroups.com, kvm@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Marco Elver <elver@google.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
 Peter Xu <peterx@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
 wireguard@lists.zx2c4.com, x86@kernel.org, Zi Yan <ziy@nvidia.com>
References: <20250901150359.867252-1-david@redhat.com>
 <20250901150359.867252-27-david@redhat.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250901150359.867252-27-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 01/09/2025 16:03, David Hildenbrand wrote:
> It's no longer required to use nth_page() when iterating pages within a
> single SG entry, so let's drop the nth_page() usage.
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_pages.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
> index c16a57160b262..031d7acc16142 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
> @@ -779,7 +779,7 @@ __i915_gem_object_get_page(struct drm_i915_gem_object *obj, pgoff_t n)
>   	GEM_BUG_ON(!i915_gem_object_has_struct_page(obj));
>   
>   	sg = i915_gem_object_get_sg(obj, n, &offset);
> -	return nth_page(sg_page(sg), offset);
> +	return sg_page(sg) + offset;
>   }
>   
>   /* Like i915_gem_object_get_page(), but mark the returned page dirty */

LGTM. If you want an ack to merge via a tree other than i915 you have 
it. I suspect it might be easier to coordinate like that.

Regards,

Tvrtko

