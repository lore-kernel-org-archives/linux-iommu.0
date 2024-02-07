Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980E6823AF
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324072; cv=none; b=S+gFOYUrx+jmHOZLhyNSEKSlXhj/OUyWB4yhCGSApRuLZ/bF2Xc69F01kQALowlDwPxaGHMdEuNe3G01lxwH8VICqyr7S8cMDqBDJgncAEVRDLKAM6MWaGSJHSf9gzyqbXfP+E3npZCZuTbGNuBkQ26K/4cok4Ru/AOKc2cv8T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324072; c=relaxed/simple;
	bh=ysRZQj+fMnSP0kwWwLlGUpk66/SFquxkGeUnwQ0KwWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PG3eeCoa181yTN2Ow09uOH+xbQTqFA3qTomixUoq9z0dwu3M7BRcfWdKG/8qbmNpRvz4cUuQJCNmmFAJS2wE6yfOtDPOYASqJoUrQUcIKdU77cU68t1O50n8y8DXijTUjfRNuKZ3091bmfTeOWApXXGzm9W4pD00YzrygtpB1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OeyoffAt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeyoffAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707324069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pLHmOri0rwabgYHmtFqkZU7UR9oorDvGKBxIT2pvDE4=;
	b=OeyoffAt9znlUBvPx6jjzffZp2gv/ptcpw21Hltex52Fv4Mc7rTcmf1q05e+KRe9yhs3gC
	lzB4M38B9Tkl7ae5UNYMDDpAQy4SUJrCbmGqTstoA6zkOOMKzbDbx/YfFvxc6Gaarp9xWT
	IR3d4PylOyx0LBacJu/mx5wz0FhOA/E=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-5Nv6I5tZN_yryZ-_WGAhnw-1; Wed, 07 Feb 2024 11:41:08 -0500
X-MC-Unique: 5Nv6I5tZN_yryZ-_WGAhnw-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-46d367c3200so152333137.1
        for <iommu@lists.linux.dev>; Wed, 07 Feb 2024 08:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324067; x=1707928867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLHmOri0rwabgYHmtFqkZU7UR9oorDvGKBxIT2pvDE4=;
        b=SpY6WBpojvq7aIpQavA75+jNL/vtHBi5dkUCRn+ga9S9k5uMSj94q0v/y7VTNwMxHX
         iai90XvJsDMnxvw+3HkuQTKp9R+mCjZ7rDpKu/y/NSfoH+H2QFT1950Iv5A7TnSy0Xhk
         enBC3tZ7JObAj52ffbgbDq+iDyLEGIP101wBVWLXrUZey3mimuDVA4Rkz9Pl6GBOSkmH
         yfeAql11yThSKk9KuRfMq1Cgphslrjp2iFZb8At+iZXXuM0yD9uGAHnq0iZSsvHeFjtY
         3d/qFDy/iz3fGljPMGWep7trditgEf9Z3gQLMGOE0jhc+jTgCztqIr13L7g+jLB2gzkH
         FdJA==
X-Gm-Message-State: AOJu0YyiB+0yPSHJJ/u7by+JQAseo4QajmOmkw+ILXOx7yqPUXlUluYV
	x7ODJvP3tuPxzhof+0slLtesWdD7P6xGvGf7REbbYIWXh/7Hrjw4ctFgOCIMdnrsY/LlxVEyS6M
	/bWhNVUI5Ztvw6O0M0dJ1oR/xAxg1dvoONG4Z9IHMtI3OUZwZogRK
X-Received: by 2002:a05:6102:4423:b0:46d:2719:7a8d with SMTP id df35-20020a056102442300b0046d27197a8dmr3213011vsb.6.1707324067569;
        Wed, 07 Feb 2024 08:41:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI7L8pil6iYGjgA+wbXsRO5bpLfCdQiwFjFbu6u3Xk4AfE+eFX5x0ob1pS5dKI4b5MoLT5EQ==
X-Received: by 2002:a05:6102:4423:b0:46d:2719:7a8d with SMTP id df35-20020a056102442300b0046d27197a8dmr3212990vsb.6.1707324067181;
        Wed, 07 Feb 2024 08:41:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4YpG9ByTiv189vcqpCJjfwcaVnc97uYfbTiy23VL7e+NLa8gM9pBl6B7kahhJlhqPHbEWl1XrMx1P6vyzoGOLmOjIwXlHMo0TjnydXq4DVhDrEtKwKzTMw6Sgw7f3lqOVbokB9BkbKPkhIIg0AXeDiKMIl3K7BVl6U01MzR9wcqhOUR8vItXu26DH+pDjjT/X2LSNjgf7atpGli3k8+2OZNR5+Swewic0KcHarXUWGvcqf+weW1kCNMMwndWRbvMKAF/79tUpApSiN7K4JKYba49PH8dCPLyO8L4ZE0jabc3kc4HpsQ+C
Received: from localhost (ip70-163-216-141.ph.ph.cox.net. [70.163.216.141])
        by smtp.gmail.com with ESMTPSA id mf7-20020a0562145d8700b006852ff71ac2sm738818qvb.30.2024.02.07.08.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:41:06 -0800 (PST)
Date: Wed, 7 Feb 2024 09:41:05 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, pasha.tatashin@soleen.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rientjes@google.com, yosryahmed@google.com, john.g.garry@oracle.com
Subject: Re: [PATCH v3 2/3] iommu/iova: Reorganise some code
Message-ID: <oskl6xbmrv24vs2mmau23mnzb35x2mvhh4ujg6ntcih7pribkj@oxurium75tnu>
References: <cover.1707144953.git.robin.murphy@arm.com>
 <d4753562f4faa0e6b3aeebcbf88fdb60cc22d715.1707144953.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d4753562f4faa0e6b3aeebcbf88fdb60cc22d715.1707144953.git.robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 05, 2024 at 03:32:40PM +0000, Robin Murphy wrote:
> The iova_cache_{get,put}() calls really represent top-level lifecycle
> management for the whole IOVA library, so it's long been rather
> confusing to have them buried right in the middle of the allocator
> implementation details. Move them to a more expected position at the end
> of the file, where it will then also be easier to expand them. With
> this, we can also move the rcache hotplug handler (plus another stray
> function) into the rcache portion of the file.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iova.c | 128 +++++++++++++++++++++----------------------
>  1 file changed, 64 insertions(+), 64 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

