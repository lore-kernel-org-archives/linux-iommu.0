Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC65370D6E
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355962; cv=none; b=E+Hz9Y4038ctcOsfjG01rTyDyiWYp31bC1YGepRSj4fZ0TQqfKuHXUfmAV+qgzErPUe0HOiVSf0VIxln7TK5vL5ruhrGOBwEsvM7zm2oIWnvE9QUXav4L9rKf1PhExgCs+MJea/LTyGhrVIeu3dznETUsJDKOSuEDu8HvswAphY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355962; c=relaxed/simple;
	bh=+cDRlUu2QCzryvbzD7LTu/UqKMvAgylgZ151GWHmn6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWcQVosRt7Qay5NI7hIGuvrfWDnT7RohSzljqPxjBzbOV374tosgeZqsYeu6Qmd6wX+wAZ3q8SR7/5MCc8zwwWZyOwpYy9eK3GmJGxb2vRVRmwwzNCy1/Ha+f/504Fx3zr1MTsx0NOAlUvNDlKZZ4Il4nh2jg86fLXa8o/CH638=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INN9+ZN0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INN9+ZN0"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so38559125e9.1
        for <iommu@lists.linux.dev>; Thu, 21 May 2026 02:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779355959; x=1779960759; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EVWPWIDSLM3eafPF6uEWUcBfdQa+Lwt5Bo7lrpafPQ=;
        b=INN9+ZN0dBfazlVBO12l9RWTgAJqgSri71bOgYnnwkth2vzUXjwZGtiRqklQhpnHfL
         SpiuZdp6QI6q5XeeXqXT94JpeIwb4k2eHCrDwYp7MWuX1d/YtqypZdKAxRFVi5WZAk9e
         Oitbj/OR6Gd7ce1rkyFsYKS6MQGH4kIRV2KKjMfJE7NzgNKLuv0RUfyGpAnTk1spOpQR
         IOr7Va0K5M2ys1KypN45tATnk4+tP+N6Nmm9BGGE8gon9wOq8wODam8UHyH9QR4ZN/Nz
         SBngEovnlXsM7n5iRToO7mBaK6Y46FKtDxZjCjWXJvEyO2l6yBLgkjEo20xIeo2Uzqs2
         NlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779355959; x=1779960759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9EVWPWIDSLM3eafPF6uEWUcBfdQa+Lwt5Bo7lrpafPQ=;
        b=HWDdGXsGqJWr9iPs733tq7/CPNZvJySmNc0Mn0LfS+z3Pv828bMM7yLPwRIOxvSO5f
         AhkUu3l9r+LAbQknUqtGdgBhGmr2Z0imIZb1zFe7iJJcKpR7vSXgey6NPxVuNb7rK2LR
         w4sgQuPV3EAOZnwr64KHL3EPPvbz6Ak9gaXzHXSebIBLMNaifwbZwA+frbjhwF+wtQeQ
         r7axcPMn6KvDHATx0bCpvg4UAXtPW9mVAVaeCCtQJWlPhlspMrPGQHKY64S1Ca/EX3s4
         NzN9MsK8ctk9Pz39+TrUckZ5PeX+U2emxHCF8m5mXuFnzsG1pQ2YLl1FnXzYbvkuNHyP
         Ze1A==
X-Forwarded-Encrypted: i=1; AFNElJ9KCU2jnSJq2KmOYAOzqkcgqWzRRIHJ0TLMdNw404Yvsf6mtZviQphGH8DWnzzLJzHnNtBSlg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwakzWSPxtzx4rDEbCZEQFewf6VeVYqYXWdd6IDvckqNLSEoxva
	X9yR2RX2MtaaS0dwjqJkOHUsSImk+T607Y7tSPjlOeV3B/3bihPQO2ty
X-Gm-Gg: Acq92OGCCWwNL6rG6+VFea0+yyfE9HaUulEmPs9GHZW3t0DXVPeVfM8OTerKrB1O1Wk
	42VOI/bX1Buw1/r/qzRj5bWBh58ap+45uGOagsJIqO4mkGUezqqx7fP9h/1Y2OFikPyMEG5lGHM
	RwMoBz2SVnQiqNZagWECdFGOUerV5+6iBJa3eSEHAC8bxcDyL5wit0iz0TrkxjiRoGdeFJpfC9z
	TVwQdf2dJkRu+dy8FLeZi573rgYO8mR3KVNkNAzoa1b8WGtuwhecJ4ap07F1KG+ZzSSikLPelUp
	ppYFxvvBas4eqnvw5vA7V0tTnUX7MR7M1pTVY5o5IaKiW/c30/d0JVfEYNWulSdN0a0btg9qB3n
	8Q0htXuVVH9SRVnKJ3h3ZmGiC0u62DeU7oUoVCtU8kTIJLLlRN165Xk+AGBTM/U+N0l4yTsQ+5Q
	D//9qqsSV1xedX9JgzgVTIkrBm0hAn0ij3SwvXT65Xflxtz7VuCf8nUHFf+4KN/SciQyFEjE31Z
	gZJvjoNc6o4aQ==
X-Received: by 2002:a05:600c:26cb:b0:48e:6db3:ff33 with SMTP id 5b1f17b1804b1-4903605d502mr18288435e9.14.1779355958345;
        Thu, 21 May 2026 02:32:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903cae778asm11707075e9.13.2026.05.21.02.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 02:32:38 -0700 (PDT)
Date: Thu, 21 May 2026 10:32:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: 2564278112@qq.com
Cc: Barry Song <baohua@kernel.org>, Qinxin Xia <xiaqinxin@huawei.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Wang Jiang <jiangwang@kylinos.cn>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma/dma_map_benchmark: fix fd leak on error and exit
Message-ID: <20260521103236.747dceef@pumpkin>
In-Reply-To: <tencent_E7BC2E2BDB10173E11B0FD519A84D414E509@qq.com>
References: <tencent_E7BC2E2BDB10173E11B0FD519A84D414E509@qq.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 16:02:41 +0800
2564278112@qq.com wrote:

> From: Wang Jiang <jiangwang@kylinos.cn>
> 
> Close the file descriptor when ioctl fails and on normal exit
> to fix file descriptor leak.

There isn't a leak, it is all tidied up by the kernel.

-- David

> 
> Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
> ---
>  tools/dma/dma_map_benchmark.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/dma/dma_map_benchmark.c b/tools/dma/dma_map_benchmark.c
> index eab0ac611a23..bdb8a837f020 100644
> --- a/tools/dma/dma_map_benchmark.c
> +++ b/tools/dma/dma_map_benchmark.c
> @@ -130,6 +130,7 @@ int main(int argc, char **argv)
>  
>  	if (ioctl(fd, cmd, &map)) {
>  		perror("ioctl");
> +		close(fd);
>  		exit(1);
>  	}
>  
> @@ -140,5 +141,6 @@ int main(int argc, char **argv)
>  	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",
>  			map.avg_unmap_100ns/10.0, map.unmap_stddev/10.0);
>  
> +	close(fd);
>  	return 0;
>  }

