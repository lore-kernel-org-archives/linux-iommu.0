Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8A16106
	for <iommu@lists.linux.dev>; Fri, 23 Dec 2022 10:24:28 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so3219103wmb.5
        for <iommu@lists.linux.dev>; Fri, 23 Dec 2022 02:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRuUJZVOpUtgPvjJSw65Ev7JgBrVcaaYMlRw59e9HHo=;
        b=aKDfNpRXZ27jsLjGo3FBvyZVLAnFXagcPNocTyT8aZNnWT5jO3bG9yr+ZtkR3R+XQB
         rwB35v6+Oo4WigU65Z+wI/bekDZ2yxSCox341aiSxK5S6iyTfgCNGuvFX3H2ulB58IM/
         qppT5/mM4+jUO4B/15KM8irHnM7SVwf7dl9mKm15Q/1feN1QPZIPDE+Ex352sLWYnDNr
         zvwE+jGsjnHqrQ/87Yxost4XxnWU+8r38zNrapRMJzx18Mm1WzWR+/xJ/h8dJ+6TmmhU
         ZhwZyzKC4DSyj8R45zXrbkHiKoA7ebU7eopWFpiIi/AcQw+nJbEwctHFfQAzQ4oB81+M
         2cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRuUJZVOpUtgPvjJSw65Ev7JgBrVcaaYMlRw59e9HHo=;
        b=HpQh7Sj3M3Bcnx3+lqo/tsCabr9L+19R0UmN/Hmlu2hlZwR9FnOXGIdJ83/VPbxZOf
         Fi0LkL2VgIE1u9a2RID/RzRTqM8Qnmv0SoFQExItLhQWmWh5xBIFaCMvZB+R2T3U6GbV
         bGNKXwyBmCFqTGRy89TaYPtZcutbj4i9Cwbw9SVHgJuf0CaXtT3K11cPy9Wpf2MFL85x
         nSrohD+L1YhE8azHB34dwygVyLbIlfFK9v75tl+wNuu8T5pn86dXVqdTJDBuE2Pb1vaZ
         0XW6eIGpNUzAAeou9WsXLm1v2UQ1XqOxK5sjVKCQUvOizonmreLzo39+6BcY3sRJoLeW
         8QKg==
X-Gm-Message-State: AFqh2ko8ow0feBCtA5IMvAGnd2SjxXvCUrhqE84DWN9/NCvoPj+0lHhF
	v4cdjSzepOycERqIpHqADfA=
X-Google-Smtp-Source: AMrXdXuqkbabnF7DzHU0Ej1s4hVLvQJ+bsyuWTyXaxsjS1VNZXTjdjD4EiZQnf6FSm8KN1A3U8ddKQ==
X-Received: by 2002:a05:600c:a4f:b0:3d3:5c35:8919 with SMTP id c15-20020a05600c0a4f00b003d35c358919mr6783088wmq.30.1671791066352;
        Fri, 23 Dec 2022 02:24:26 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d5681000000b002714b3d2348sm2880136wrv.25.2022.12.23.02.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 02:24:25 -0800 (PST)
Date: Fri, 23 Dec 2022 10:24:25 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] vmalloc: reject vmap with VM_FLUSH_RESET_PERMS
Message-ID: <Y6WB2ZGoL7FaFK+f@lucifer>
References: <20221223092703.61927-1-hch@lst.de>
 <20221223092703.61927-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223092703.61927-3-hch@lst.de>

On Fri, Dec 23, 2022 at 10:27:03AM +0100, Christoph Hellwig wrote:
> VM_FLUSH_RESET_PERMS is just for use with vmalloc as it is tied to freeing
> the underlying pages.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/vmalloc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 9e30f0b3920325..88a644cde9fb12 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2849,6 +2849,9 @@ void *vmap(struct page **pages, unsigned int count,
>
>  	might_sleep();
>
> +	if (WARN_ON_ONCE(flags & VM_FLUSH_RESET_PERMS))
> +		return NULL;
> +

Might it be worth adding a specific vmap mask that explicitly indicates what
flags are permissible on vmap()? Then this could become e.g.:-

	if (WARN_ON_ONCE(flags & ~VM_VMAP_PERMITTED_MASK))
		return NULL;

And would be self-documenting as to why we are disallowing flags (i.e. they are
not part of the permitted vmap mask).
