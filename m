Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782E41EB5C2
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808388; cv=none; b=D9PaHWIGfW9GxLP6hRRWuEyP/phltiWzehdhKfP9Hj4pGvymDjVW/OhwDrKMii5JdlmGdhPuV2sWoZ017v06xcjLlIg+rvdKpGKFuhT9EUg75a1e/ORG1uTXif1w6RmyfwZZmEIB3j/vm/QVtQB6D29yAD7gjJ4Qw9iYvv63UIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808388; c=relaxed/simple;
	bh=oA3XFTq+X9InxrtY53OI1FqTpqPTKR+1uoMqvtlA0+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7AckCEMwVaTmCB/59GGKjbxMy61XSv+0bFtB4RY/50CXmGOUxcoGetujiI4k5JHNzbk1GTyIRC1JAyJ+41d38JonEoQqJTpT/kIQ7joEy7WL0LExrjU8g02ylJ9TsgrDTtr5YE2sKy4+PdV1qEGkBPU0sAVVs2d1xj5WWedsCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UNWt2XVY; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UNWt2XVY"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70d7c7e96bdso7700056d6.2
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755808384; x=1756413184; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6aeG3+zXNcZH2d1Z1/su6zkQOg7Uc4j3Xw+oqie+iPw=;
        b=UNWt2XVYB360WFU+DvjqyOxO9mjeqjXocfTEYaYm5dEWH9ufJ93GdnIUmhikl4SwtC
         elDRznsbHk3pbtV2pK3T8jmBpzyuxabFhQsbxfUFBBVeOv2Gmi6UIGGiS1cEyvRQj4OG
         7ik4jdSyJuJ+ev4oKHcnwmpGEi5hyCRzFFf/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755808384; x=1756413184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aeG3+zXNcZH2d1Z1/su6zkQOg7Uc4j3Xw+oqie+iPw=;
        b=Y99e9PlZp2BdDvXKF+LKcqSqsvsT+5YbspQfn8dwZb3kgX6q1ULPO4NUoG9bOvpkWr
         GNtUXTFlk5KauQmcVExrMXSDQO1ugMLI94xaSkREBgOnRfM5mo4YHvTdoEaz/x0RMFZM
         VRVlJMRljWZ0wWLysA4TTbdhWR/6GNDt88v7/f4O8moK81NV7VhsacoF3ppyYOg/nVVp
         +QjlEDxRXITPIEZXsMz8XvjGtxE/SqDlHggq4bGSxgPPQIzY1DW9IRjYb2+MR4dzjmZT
         q5j7dkqSxz9yKm15JNXUU3/BbFhNVDUuW/oMGeJklNHNVi2STs3uaH8DrmkLdttBlFac
         VbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv7beNuRyWIOYmhY62hwwKWSP/o78w1Ka+5f+A+vFufojyzXcCZhfHME5hmTdzE0kyyLDkLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrrmfWiRLw2xXiuyxM39PYhN/luS5ZDlnf8ENedEqZONLOyMLX
	o10UdR7bISDLgxli8l2mKnfk/v+L5G1zgvkjq/r+bLLe5lpXkh9eJiMYSTn6OTfsrk7KsS5+dmG
	ici1ERA8=
X-Gm-Gg: ASbGncuorJlIxBravh6BBbC/AP2UDoT08mRIEzGGjeUqbHIvqwzORX2kUnhMkJFQZ5E
	Vcfj3+clfBP15u+bltVppCzYDXzVyE61KgnhnHbUwOOavKAkfMRIhOlrqizos34cJpxmSQZm0iz
	/wpHZ1upYLZzUDT3/OSQswReyJ9BO5BniO2hj0dY5S9F12taobZP6ZYRh3aMmQOmQ8CIz7AbSir
	JlS4JVPO8cpGKTIXhL/1xLKNYB9fLXUVePsr3cmQI6IA9TDvyi2ApP1/vktufr4sxYU7T7qCiBg
	jnxRBtJxCWMyhwvvXZQ6fVlxLMqc65tYrQYj9umDyYhM4UW7zN7Tr2f8Yh+Ybi3+NZbH1/+kdN3
	hz1A9lxl1T2nTVdbxvEh1oeHlhYEjG6LXbcJ7a5K69TS5U+xLN9efjYl/FTDh2NvX5Wh8S5HxWu
	ASybO+l2C0i1OOeuK+4JTvjA==
X-Google-Smtp-Source: AGHT+IGeDZRe5sFP9vQeiMgPY7pByuYt/2yGjaQ8pnBSzji/HIIsp0F8Do6q/Vu5/T3DZfA9OJuJ0Q==
X-Received: by 2002:a05:6214:411c:b0:707:44d4:2962 with SMTP id 6a1803df08f44-70d9722bcc4mr11442106d6.7.1755808384245;
        Thu, 21 Aug 2025 13:33:04 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9032801sm110033366d6.16.2025.08.21.13.33.04
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:33:04 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e870636870so156470685a.2
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:33:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXIdIguw/VMmsMhRD6VQzEkKxM3qBrI/XYDFB6nHS3TsOzsr8rZuLPZCbP/XSH1cKKSbaUIAg==@lists.linux.dev
X-Received: by 2002:a05:6122:1ad2:b0:53c:896e:2870 with SMTP id
 71dfb90a1353d-53c8a40b923mr212315e0c.12.1755807884664; Thu, 21 Aug 2025
 13:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-32-david@redhat.com>
In-Reply-To: <20250821200701.1329277-32-david@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Aug 2025 16:24:23 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com>
X-Gm-Features: Ac12FXxaZhwn04a0gbwY6rjh9UGLxnRlGOG0Jy0WjRbVAG0UxLDqNy0Wydj0GQk
Message-ID: <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com>
Subject: Re: [PATCH RFC 31/35] crypto: remove nth_page() usage within SG entry
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Potapenko <glider@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Brendan Jackman <jackmanb@google.com>, 
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	iommu@lists.linux.dev, io-uring@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
	John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com, kvm@vger.kernel.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-arm-kernel@axis.com, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
	virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, 
	x86@kernel.org, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 16:08, David Hildenbrand <david@redhat.com> wrote:
>
> -       page = nth_page(page, offset >> PAGE_SHIFT);
> +       page += offset / PAGE_SIZE;

Please keep the " >> PAGE_SHIFT" form.

Is "offset" unsigned? Yes it is, But I had to look at the source code
to make sure, because it wasn't locally obvious from the patch. And
I'd rather we keep a pattern that is "safe", in that it doesn't
generate strange code if the value might be a 's64' (eg loff_t) on
32-bit architectures.

Because doing a 64-bit shift on x86-32 is like three cycles. Doing a
64-bit signed division by a simple constant is something like ten
strange instructions even if the end result is only 32-bit.

And again - not the case *here*, but just a general "let's keep to one
pattern", and the shift pattern is simply the better choice.

             Linus
