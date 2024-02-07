Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2589C7C08C
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324228; cv=none; b=cZq97tp6IVbLaO/MRXqvdcGjgrkiMY18rlrxwEm3sxtWHHNhEJTyN7xMLIDy3Y8FfWSRem75BL/TkI/hUWH1mWOzBlOuf6MM7XlgSVGIGlxhPQLPvATSn1jHAJgK72V2hw0YKqJZuknAyIYEVYVtvtUkOZnkJ9qaGZ3wrIRK5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324228; c=relaxed/simple;
	bh=73eqAhaio1Jvt/RDlLJnvmMV8MkBMrgVbBKolRk2SLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=s//OdwQYFZz2OZqS2W4dmMRqFDXxNAsnU9IjZSsMMo2jmHfdUb5d0uiOaDqC6VKkN85FZwCApxAWuFUzNDXBxOKg0sC+yJkVqPfDL449mmUMYBRI11y47qXURE1SaaJRfWhqcIZg/t20xnMGYNZvSXLfb4DdlPu+1rYNha0m5AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5OTcUzI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5OTcUzI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707324226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJlJ97KV983cCFAs8Hh+z+jAcflqZylPwBHCx3rSV0I=;
	b=K5OTcUzItAh1fu17VePZ0wJ2kFNQ57w+zm+DUcZcmL2BThdVvqU0qeYLYbRPkx/+cS8deG
	g0G+rCDDsq/M6nh1UPLPHgzHv61Rsb+eYUS5TCpmRzCkWrJrh32MBV7sBX2K00dC55d2Yv
	2TQuwXIv7QDYHTMADC//RhPloI1za2I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-Vunh9rflPQWoJq6NZfArBQ-1; Wed, 07 Feb 2024 11:43:44 -0500
X-MC-Unique: Vunh9rflPQWoJq6NZfArBQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-68cb759751aso10882036d6.1
        for <iommu@lists.linux.dev>; Wed, 07 Feb 2024 08:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324224; x=1707929024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJlJ97KV983cCFAs8Hh+z+jAcflqZylPwBHCx3rSV0I=;
        b=ugbbJWKzdke68OJtq8iDlT7BYXzI+8OLhjMmyERkxM/TMYmiXQVURPDmFeS+C3ETBu
         Oq5F3y47QA371AV5jS8OZh4VQX7ebITJXF7r0zbedkg8m+UFit+n6feYxzRMq+7dSQ1z
         4oiVKe2ZcZAc3SNNwYakuAjBLqsvPUlONX1HCHA4t+ptZdwJUCVEDHaJx5guZmy2kQa+
         92b2UnC3UXzdoKyXwCmE+o1c2W3DXHCWvtYrJdILlAHeGLbjIJ80PJ0M0Auc7guefz6u
         m7QFowY7BGG1Xvr9lg6aC0p1ehR3TzjMggLz/6RtAPMkjNYadPGH8zu2Dme48UTO2cnd
         cjVg==
X-Gm-Message-State: AOJu0YxvQXWnAb8Bk6t/T0htZMT6FePv8nwuWrSkg9B+uz1hu9/elS/V
	Op2e4PbVJ/hvKnhgEf1vvmPVMJi0au6sKpYphzfWAqUNf4FQ9GnRNjkXfwJnsqOFGQi8c9u0Y3R
	6lRyUEhoM4JrNAq0g/F8/Y3hwfK5qwSaOxWi0Ge1cDtvu9vlfTbwu
X-Received: by 2002:a05:6214:529e:b0:68c:a92f:6fe with SMTP id kj30-20020a056214529e00b0068ca92f06femr6411185qvb.19.1707324224487;
        Wed, 07 Feb 2024 08:43:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFViM+VvNQsCrUuHVYLtV3yxtqkEeZd5GyiCCUjD0K9kKsflJ7U8nzX+CfETK3aRB4UrWsGpQ==
X-Received: by 2002:a05:6214:529e:b0:68c:a92f:6fe with SMTP id kj30-20020a056214529e00b0068ca92f06femr6411179qvb.19.1707324224248;
        Wed, 07 Feb 2024 08:43:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCug54+TMCrXgydIYnzZkcK8Zf+AEMYZcoUGAdVLQVsL6BrXRj/S/4zRvIwTHA7jOzFr8r9be2oB4GTtwwomjS4kbabSeK7Yav/4jUB6rUnFIdGCP1w0Q8eZf+ylYfw0dE+LMMDUYDRqhKRvTylGRXkv1aByYwyLrSVOspdW2Fi6kEnOjQA0nLLEzIvDg2oYKpb+zOz3040erLaiBRZ69/2odnG33B8khpJ0WKY8TYZGBHX/6iPpHJ6eD5qRmpCEkOwZeCxwrzUcY+xU62v0KEB09biS9dCCz10/8EBcBn7XYNVT4WQBkg
Received: from localhost (ip70-163-216-141.ph.ph.cox.net. [70.163.216.141])
        by smtp.gmail.com with ESMTPSA id ny12-20020a056214398c00b006869c05a875sm750260qvb.32.2024.02.07.08.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:43:43 -0800 (PST)
Date: Wed, 7 Feb 2024 09:43:42 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, pasha.tatashin@soleen.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rientjes@google.com, yosryahmed@google.com, john.g.garry@oracle.com
Subject: Re: [PATCH v3 3/3] iommu/iova: use named kmem_cache for iova
 magazines
Message-ID: <t2dueq5e5ora55y33yfewwohmz6ulv3ofgjzl3luin6mv3p54v@v5xmrmj5fo6p>
References: <cover.1707144953.git.robin.murphy@arm.com>
 <dc5c51aaba50906a92b9ba1a5137ed462484a7be.1707144953.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <dc5c51aaba50906a92b9ba1a5137ed462484a7be.1707144953.git.robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 05, 2024 at 03:32:41PM +0000, Robin Murphy wrote:
> From: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> The magazine buffers can take gigabytes of kmem memory, dominating all
> other allocations. For observability purpose create named slab cache so
> the iova magazine memory overhead can be clearly observed.
> 
> With this change:
> 
> > slabtop -o | head
>  Active / Total Objects (% used)    : 869731 / 952904 (91.3%)
>  Active / Total Slabs (% used)      : 103411 / 103974 (99.5%)
>  Active / Total Caches (% used)     : 135 / 211 (64.0%)
>  Active / Total Size (% used)       : 395389.68K / 411430.20K (96.1%)
>  Minimum / Average / Maximum Object : 0.02K / 0.43K / 8.00K
> 
> OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> 244412 244239 99%    1.00K  61103       4    244412K iommu_iova_magazine
>  91636  88343 96%    0.03K    739     124      2956K kmalloc-32
>  75744  74844 98%    0.12K   2367      32      9468K kernfs_node_cache
> 
> On this machine it is now clear that magazine use 242M of kmem memory.
> 
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> [ rm: adjust to rework of iova_cache_{get,put} ]
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

