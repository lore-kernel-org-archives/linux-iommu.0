Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC0C33CA
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323923; cv=none; b=Tx+qyayroL8TjVAezcCwNqq5cdExSbjoBaQDRc3fFC9fJqEz+uxbAJf8aBmIYzVNvYNrpDMg/AAGUsyJ5qpJF/GfYa1WgH7e0ys0nawM2fTTg4kF1aEgoVLMb4csFhRRENMOYDbdkjeEn0IfhtzMby5TQvmh/rKOBpgEzRYhwVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323923; c=relaxed/simple;
	bh=yYV90edUO6IBYkZTKapElVIsZy637LpXyy4M8oFz3bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=r4fkhyH1OJ7CM4L9SRGViCMUG8PmKEMpaAG7LmzG4sHAHwdCsCQY46/cU1CG3IhmEooUoSFbddDv9oJXuoIxj56mbr9+0CzFuieOuKSWHL7F9ri1ZIiEJ2/krrIwh5hp2QjBV8wIKYuXJTCa2KhF56zeYSuppVaV+MkHnIfFCNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMghq/rH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMghq/rH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707323920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3J41sYakbr7nCpsD0r1AspXJMKiAGuYob6ug5klcDE=;
	b=iMghq/rHUGC5sOFPB8Hi9E7u5n5848J1z4rqtN654xuw8w7jDb0O6sRna4KaDHOvFUH1Lu
	0eG28+WHkAvlmUuQWdP+MkLxjzNtDHCZayPYgjttBPaasgrVUCGl4gzsloWJvISdmELXks
	zLEfe6ehcfzBM5mZ/lRR/sxnIIXe1I0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-UtFEMfuIP-u7oV0lc08cnw-1; Wed, 07 Feb 2024 11:38:39 -0500
X-MC-Unique: UtFEMfuIP-u7oV0lc08cnw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-783350c4584so112358785a.1
        for <iommu@lists.linux.dev>; Wed, 07 Feb 2024 08:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707323918; x=1707928718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3J41sYakbr7nCpsD0r1AspXJMKiAGuYob6ug5klcDE=;
        b=m9HG5a/n6rQYjq9nieGsmj04CgPYsqftiEYGRVebbythCSlAK4CnoBM0dSrZaHq+39
         Mdnp+VCZ/FU2iJQmHqXR9JF8HksXZj6GRCEpHhg96cnqMPC6HcixY1TmOhvw7NWxUkEe
         +IMxrFwDu6V47ImLbtCHhkZ21wTpwB9kWPbhJGFJ1bpjuQ7K8vpUzhUymiF4mxbg8C38
         z51xHPHN6NyNdUawQ1HxJZLxVIBzcyQuJyx4q+n6Y3VEL8Mp+sP3ivxIgy5F8gh4kdyK
         noQK/cC1HgGHf04msgpy2JLjzbjHPbWE0vCQJ26gs1DeZKH07UeU9urRCGfJVN4HlZw3
         qf2Q==
X-Gm-Message-State: AOJu0YxdqZwzmIM4wQ8WStx0LLMg2X/spEwqC0QbTns2qu9t2SwzKHl4
	PlN5Rv4SM4I9nBs5IBRfP6ZUA36Scn6ppBLgHGzlxqQbpslgN3pDG7rkF5b5CzEOMNtJm3tUhk6
	HoY7gFjiiIgbvCL9UD2tghr78ztcuIUhPr1UDUSSJkmWxAyQpxaKn
X-Received: by 2002:a05:620a:4620:b0:785:46d6:6453 with SMTP id br32-20020a05620a462000b0078546d66453mr8619128qkb.32.1707323918661;
        Wed, 07 Feb 2024 08:38:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiEbBDmZmhAUIBjpoTcJxQ/xfWi8GWUZO8r9kZQB4bZdUkJIFsHGgvQZ7LJqnB27/7UFJoFA==
X-Received: by 2002:a05:620a:4620:b0:785:46d6:6453 with SMTP id br32-20020a05620a462000b0078546d66453mr8619102qkb.32.1707323918350;
        Wed, 07 Feb 2024 08:38:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRlQ2kj5BCUsqdr5MMIndRdzdUBRc4MiqRznozuly6meVvpHGVfmkdbwYOUf94wUWuZrYm1uEJ9HtRqkUBtS5lZKBPN+R2DGN8vO6b59SWsRtYXgUKNLh0bU/9FJ3wzFW6urLaUjH2AGPo75FD0sBlLZonRd7lDrG0n3g4Q34FAWnM9ry2cxIemSn++NzGk2K6diNvTBS6UNh3+l3XbQwFJatQ5n651ju0MWDAxcY66G90/uaG4edgyJWxM6m958Bi4G1TL3tMZUvts2+fHxkYsdE6v6YuUiUqYDRdp/2x1SWhnzh/oUzO
Received: from localhost (ip70-163-216-141.ph.ph.cox.net. [70.163.216.141])
        by smtp.gmail.com with ESMTPSA id b3-20020a05620a088300b007832870e803sm658476qka.68.2024.02.07.08.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:38:37 -0800 (PST)
Date: Wed, 7 Feb 2024 09:38:36 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, pasha.tatashin@soleen.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rientjes@google.com, yosryahmed@google.com, john.g.garry@oracle.com
Subject: Re: [PATCH v3 1/3] iommu/iova: Tidy up iova_cache_get() failure
Message-ID: <bpw77hrrerzmhxk3jkw2b44cupnusddqqnrjaj2jjq7w2zukpr@ghcbjhexqxqw>
References: <cover.1707144953.git.robin.murphy@arm.com>
 <ae4a3bda2d6a9b738221553c838d30473bd624e7.1707144953.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ae4a3bda2d6a9b738221553c838d30473bd624e7.1707144953.git.robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 05, 2024 at 03:32:39PM +0000, Robin Murphy wrote:
> Failure handling in iova_cache_get() is a little messy, and we'd like
> to add some more to it, so let's tidy up a bit first. By leaving the
> hotplug handler until last we can take advantage of kmem_cache_destroy()
> being NULL-safe to have a single cleanup label. We can also improve the
> error reporting, noting that kmem_cache_create() already screams if it
> fails, so that one is redundant.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iova.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

