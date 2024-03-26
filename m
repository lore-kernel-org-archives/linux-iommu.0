Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309E413C3F4
	for <iommu@lists.linux.dev>; Tue, 26 Mar 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465425; cv=none; b=UU4Ar6gdqG17ff0p6eh/nLlG3M0yZt8v7O0Y1xyxV6iIQEiVguCHYSoSx1NOJxrpBAndvGLUyeSAjKdeTogqG0Q30kQnBhvHqhnfQNlYrAOXZa+PMX1FXFXRLTmwh1YLk5MhRFmN4D5lQx5A5g2Eor/WDsKheIyCCi5vSJ27HJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465425; c=relaxed/simple;
	bh=ExcLTQp7iKT4c7ldvFWHhVLbBQ0J2Wt1RPxz2DBljGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sh4msfYqlmJ8d7Tn22ilu9eS9VvoG+iPlE0E43LkDYzKJBsyCWnVm0A3RX2iZPlOfmYSXTgfFnrwIjWFS6TDvATDGWZzjSOn7/WUReRIy+4D/cw8If1moY1rDhZTNX3ozV6OM0vCz7iMfOXH88yA9AiQZDZObrLqLNnuxMenSmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HWZ//fsu; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HWZ//fsu"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-430b74c17aaso41387021cf.3
        for <iommu@lists.linux.dev>; Tue, 26 Mar 2024 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711465422; x=1712070222; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yZmVXdcDWPhXaTMyPMBaD6/fwX/FAGo/S1sSULtN0q0=;
        b=HWZ//fsu+cCLZ1V9KYQm5KJIz34s7dIT8en2FpH+tgGw7KTVqx3UA4m2x/1x6kDkb3
         cfoStAou61komeYHIQt0weO6GiX4sqR6Jlv+Vx3TNbo8iESyuWAiSxDySLbGXycSO0u6
         quloVWPut8/+dLLmSXkxf6bMBakoKe5MBCjramb6O21HEBAGMGiCbH9UtXJK4lTe4Par
         n+SPQACq9bIhX6EDfHT+YYCblRwNAPfmBORrvaUSbRWZihKcN0bTwEheG1FIokCBN8yp
         HAxsi7vB9WoL1V5P+Sf5zhzUsvVsJwXCQGKQ8jlhCsrtBFiU532b+Jf5kf9q/4fLx7im
         rD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711465422; x=1712070222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZmVXdcDWPhXaTMyPMBaD6/fwX/FAGo/S1sSULtN0q0=;
        b=GWJSmQL4OtMqZH+pjvumXwv5kGsHo3BIOdSyb3di5xOQTPRwDbEro//JewYlUeQl2p
         1oy+nhuPjtZI3fAnnYtFzr1qv5Q8y2yW5BOZdjnAsBLvBILFB2DbPo0GdGVI6JYS3dPz
         vZjCPGGys9lzqZ+Qj18uk97WqipgjPXwjz7grrMaPnYKPSZjSPoeg0/v5kOcxN3eYBj1
         0rmJUGH15h7JKW9Cc7mvxdLbHzW3VysAzMUjcbqbKwUTM4Q8d/Ke9xdD0OF25cnZV38q
         pWOWRNWAP4rYerxy9GKaCrF22CCKHH8PvIK71h1gIdU+7/CFEYhhR9Uj5id7wm5+G8nQ
         Px6A==
X-Forwarded-Encrypted: i=1; AJvYcCUAYpbFIzv0G0iP0UWwr699UXZCZ4ahdKbWXcGNJhU2LOCFaEZgEEXnKpQ3Mq0qhQBTmLfUMVCAl0DgPgc8sEGYRa+5Hgs=
X-Gm-Message-State: AOJu0YzGuSr+zbExGA8LFzaTHFZQ2jS0ZCzez03/b8DwQ/5m/GBU1qae
	yXd+zfsrNfZ2EpAIaF2nrmrdAhDgvJCQ04ElzC43i4rZPkKy3xlL2t0m1ar8wpQ=
X-Google-Smtp-Source: AGHT+IFbkghKVs0qjyIKFqbeUkN1cAZXdAcHb14STOhbg3JBqfd/rhDdojP76IXrbvnTZ+ibjllo/w==
X-Received: by 2002:a05:622a:1ba1:b0:431:32c1:e8b5 with SMTP id bp33-20020a05622a1ba100b0043132c1e8b5mr11952271qtb.50.1711465421858;
        Tue, 26 Mar 2024 08:03:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id gd14-20020a05622a5c0e00b0042f21fe66f7sm3749489qtb.73.2024.03.26.08.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:03:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rp8Ky-003QqR-SO;
	Tue, 26 Mar 2024 12:03:40 -0300
Date: Tue, 26 Mar 2024 12:03:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
Message-ID: <20240326150340.GE8419@ziepe.ca>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <31fcc276-acd6-4277-bd6c-4a871c7fb28a@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31fcc276-acd6-4277-bd6c-4a871c7fb28a@collabora.com>

On Tue, Mar 26, 2024 at 06:09:34PM +0500, Muhammad Usama Anjum wrote:
> Even after applying this config patch and following snippet (which doesn't
> terminate the program if mmap doesn't allocate exactly as the hint), I'm
> finding failed tests.
> 
> @@ -1746,7 +1748,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
>         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
>         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
>                    mmap_flags, -1, 0);
> -       assert(vrc == self->buffer);
> +       assert(vrc == self->buffer);// ???
> 
> On x86:
> # Totals: pass:176 fail:4 xfail:0 xpass:0 skip:0 error:0
> On ARM64:
> # Totals: pass:166 fail:14 xfail:0 xpass:0 skip:0 error:0
> 
> The log files are attached.

You probably don't have enough transparent huge pages available to the process

      echo 1024 > /proc/sys/vm/nr_hugepages

Jason
