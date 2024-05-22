Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0827A50
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381963; cv=none; b=VCiBEub/ygdW/Bhj3JkvKAp8636J/Fn735TIRjrqrk6mRyzZct8MG1R87QcdFiPnWncnxASixXruj1qHf8hYrc64DkTI626L/GtAvxwzsvH+Bugt9kneBBQgQhrPA/xW5Qvi/JOzxFSw1hHeUHYPgaYfEpkNp3BHf/Y2YNZ4FOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381963; c=relaxed/simple;
	bh=ZQJQmXhWg9nPg2zrXMvCQ7J/HQIRLAQCnGo6p6LlhiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJxKKXAaxCpNZhGvjbCocwh21FUPd4ZsYcv+qo1Tm4C8Tj5Z45ewhzkptpcIamJf1fQi8uW6fhYxXW74GobhcVGa1h52lPqZj5GDqKV9d2aEq+addYq7pcPyZ7ut+PcAU4ATi/OZT/KTYypzVbAenClGTu7pihaly6YnQT0aoNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MrwSWp7q; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MrwSWp7q"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-24c10207d15so1797373fac.2
        for <iommu@lists.linux.dev>; Wed, 22 May 2024 05:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716381961; x=1716986761; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WijfuUs+156edccXDFhHVcWXKQ+B4/XZiPfwdG70AgA=;
        b=MrwSWp7q09Xtu9XySC3AFyntEJDNg/GqQ6anzk3j+7PG3k4NJp9G/kxArAUec5kLZY
         bLFRn/16fA3agqK4r7CAygNxmk7TI/kdvbneMINb4PJ6U/ko+eLtoB0rBQq/CgvyebGm
         kJ/dxIDmexg4RKO0E/0w61bRTJH6yHosSPZeVAsUL9uAqHq8d1YVt4hASYQVHc//8Zqk
         GBHpIMNxvMV7Me4jjDwi6rBYf0itPdo+uGqHViMnDpVvfvuOaawHAtkbi/2Iqd8cix9b
         YseBDkEFdm9FzQbhvx0W9rHRwNoy3iK3kVkZE6QrkozaLFNP7Ljn5N1mwn1ienA7cCPP
         dYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716381961; x=1716986761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WijfuUs+156edccXDFhHVcWXKQ+B4/XZiPfwdG70AgA=;
        b=rQZUGCJw6uj12GR+DrE76yxnuQfajd8mr8E/j8zLOWFHKoG5KfHtSGyqb+waTdw2cK
         W5CztIvReMCYUr6jMxZxteqCGVu5MD1krSgQfQ1IqkniV+o+WDvWpyMjgFG8FdxJbHpz
         x26OBUKjcSw/HPVWWuPUuZJif9Cw2w3Cl2LN4pCbXjgcG4ED9r7eUJg++MsLkm94OoOI
         X0rlbCewTcPeOlCg6bTdr6vIJW+LUwOnGOyXtUZba5ePW/4pmTttym050GHyXyeDXw8y
         y1C9wof/udnJf9wgQGc0ObvAXVS8G1K7s/Oq7VLW2c2do7vE/fEZoz21R9FpOXejPoLv
         cudA==
X-Forwarded-Encrypted: i=1; AJvYcCUBlHGT+PQl00gIQ1w6v14HpzdnxIhGB97+MhAJYkAbJ8Xn0wBLTdWTvzmqlAGGXIDRS2DieTrkwvylRYr8ZhmSRZ6+gAs=
X-Gm-Message-State: AOJu0YzKx261S4dhaDaAMjLxyUy6n9MiNntWgP56nEMMaXM3jG0s7Vte
	ZTmvqPmt+z5vI0MI9zMOxw+cQyEOoXzHKG+WOPdJtXuQKWU3ularObTfmKkWWSY=
X-Google-Smtp-Source: AGHT+IETP3qReUQJuxRlhxnWJn7QpbV+LVqvRpkT9nppkVGnw4JfRUuMImdtGPF2qcpBugAZnHpoew==
X-Received: by 2002:a05:6870:d88e:b0:23d:a1d0:7334 with SMTP id 586e51a60fabf-24c68a33ae2mr2153288fac.17.1716381960558;
        Wed, 22 May 2024 05:46:00 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e074719d1sm151805451cf.35.2024.05.22.05.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 05:46:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s9lLy-00C914-Bg;
	Wed, 22 May 2024 09:45:58 -0300
Date: Wed, 22 May 2024 09:45:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH v5 23/68] selftests/iommu: Drop duplicate -D_GNU_SOURCE
Message-ID: <20240522124558.GC69273@ziepe.ca>
References: <20240522005913.3540131-1-edliaw@google.com>
 <20240522005913.3540131-24-edliaw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522005913.3540131-24-edliaw@google.com>

On Wed, May 22, 2024 at 12:57:09AM +0000, Edward Liaw wrote:
> -D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/iommu/Makefile | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
