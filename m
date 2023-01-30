Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6EA569C
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 17:06:01 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-4ff1fa82bbbso168393657b3.10
        for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 09:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jf6Gno5Ff0dyq7DhHlgvJXHlK7RmShhFzf2bK4ajpRc=;
        b=j4LEOYLrNL76NTObijY7YXLC4t96dJ8kb3jnT9Z4KLjjXjmnaczCBsSZ7eJWsIzV5n
         t/WVFhIJn7oZVX80U5QL82BYsHE6a/5rHhcBCBehPR+DPLTsjZ7ihzGQVell0V4Mjbw6
         MmxDe1H4gGWmKUaKMhGWf81K9t3sv8JtNV2rzglFX6ggWGZxerdPOaV3Nt56Ttz3mFfP
         hMgc0jYkr4sIPn8QQBkJLOLbZ1Iuo5pSJQOIukuthcUoibNOQovrbNizkJFky0ffo5hh
         Sy39ON+/vITAIZpvPaiUjGhpSLLcO2MMTgIx5NpgCIPQd1k4rjv7o0mOrkT8ATzkhKMv
         DwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jf6Gno5Ff0dyq7DhHlgvJXHlK7RmShhFzf2bK4ajpRc=;
        b=P9AxHLZrq6MlQpgjgx2yQTwBhO0UgzEILXQH3sxo1ie+p57OUlRpIVsYyrsyiZuFnI
         8992+bHMmUzdfDxizSrf7MDawqOEQJty3JaChLTRBYuTUce2lDSzrgcc2K75SEGfQNp3
         MeB4s//d1AwOudBYTpWfw6LCNAbgQX/MlT1gb4+DnlSDtW+oXzX8x9X9x9pIcHviYcEw
         UoqVeYfBNW+wgxeU9+LJFzcxPrwKGdFOeALloNQVchJ06Qd1CZfnnRmQY1uthW/6YgD7
         J7oZWsfirDSGDBRawZL4uO6BVK2VS7lqA6I0eOEq8RDcB+Ubc1GPymjrkkfEEKi7sTgs
         5bcQ==
X-Gm-Message-State: AO0yUKXOCPtRUyTWPIjDvZJsgTBHO6xBIKuFVe+snFW9fF/LwVqmXmMg
	O9BhhgFVxKQsIWM6N6Ebi4fFyA==
X-Google-Smtp-Source: AK7set/5cvu/Y4VbF9ce6JFU9HpdtREDJXkI9Z7P5HN59ix/E6X27128930KbFn8HyT2QvOZIxBzjA==
X-Received: by 2002:a05:7500:25a0:b0:f3:b3b7:2da0 with SMTP id bq32-20020a05750025a000b000f3b3b72da0mr807909gab.23.1675098360850;
        Mon, 30 Jan 2023 09:06:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id v4-20020a379304000000b006cec8001bf4sm8347900qkd.26.2023.01.30.09.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 09:06:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pMXbT-001KTE-LA;
	Mon, 30 Jan 2023 13:05:59 -0400
Date: Mon, 30 Jan 2023 13:05:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 31/34] selftests: iommu: Use installed kernel headers
 search path
Message-ID: <Y9f495UGJcLfwJ6t@ziepe.ca>
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
 <20230127135755.79929-32-mathieu.desnoyers@efficios.com>
 <a0dbbe49-ee6d-7e69-a472-5dc76d3e2c14@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0dbbe49-ee6d-7e69-a472-5dc76d3e2c14@linuxfoundation.org>

On Mon, Jan 30, 2023 at 10:01:23AM -0700, Shuah Khan wrote:
> On 1/27/23 06:57, Mathieu Desnoyers wrote:
> > Use $(KHDR_INCLUDES) as lookup path for installed kernel headers rather
> > than using kernel headers in include/uapi from the source kernel tree
> > kernel headers.
> > 
> > Remove bogus ../../../../include/ from the search path, because
> > kernel source headers are not needed by those user-space selftests, and
> > it causes issues because -I paths are searched before -isystem paths,
> > and conflicts for files appearing both in kernel sources and in uapi
> > headers with incompatible semantics (e.g. types.h).
> > 
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: Ingo Molnar <mingo@redhat.com>
> > ---
> >   tools/testing/selftests/iommu/Makefile | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
> > index 7cb74d26f141..32c5fdfd0eef 100644
> > --- a/tools/testing/selftests/iommu/Makefile
> > +++ b/tools/testing/selftests/iommu/Makefile
> > @@ -1,7 +1,6 @@
> >   # SPDX-License-Identifier: GPL-2.0-only
> >   CFLAGS += -Wall -O2 -Wno-unused-function
> > -CFLAGS += -I../../../../include/uapi/
> > -CFLAGS += -I../../../../include/
> > +CFLAGS += $(KHDR_INCLUDES)
> >   CFLAGS += -D_GNU_SOURCE
> 
> Adding iommu test maintainers:
> 
> I plan to take this through kselftest unless there are conflicts.
> In case there are conflicts and you want to take this through yours
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Go ahead please

Jason
