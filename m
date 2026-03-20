Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C843254B2
	for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774031266; cv=none; b=V2LoryrN+c3d0oJX9OZhHWJUlOYPrOOeIHAq23I2yZ6N4vWP3A63V+oe10YmawxeZjcR69XtzHyR3NOWx+IfM9nVv6kqDscw0SYkCPwh+5U6seD78N5mHZ9D1kjOFSt1ty2EXg28esw5tHeopQ/8QqXyvOTXpy09P53hbwgEl28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774031266; c=relaxed/simple;
	bh=rUJDpu/Tbsmr3Z96uyeTBTqVQmswY1ls9ES7BCAQFPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wk5FEjhed51Hq1kf/5pQkUMxWmP+TqvTlSRVbXUvEB86ODsc9zQV/vcTnax81sWXq8KfumsvWF16kLErXQdua8UDa7eiLYSYJWIj1o7rpvqZoItYQ7h+xbGlwSpiIBc1TvykM2yw0y3fbxCUkjfPHctFJv/+ys4AmtUGHo2bQ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B0M2bI2g; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B0M2bI2g"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b052562254so12905ad.0
        for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 11:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774031265; x=1774636065; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8W5cvFUR4VXf+WaiJdKnvQRdmelG4HkMeFFekxFTBY=;
        b=B0M2bI2gBeQj+QQ/4Dxr+NcU6000gY0C4IFudNggZabUrjAZi2Wpryp8fvIX6JPGvp
         I1B/cUZNzyavB59QnOfFq4OkjLl6/qEW2lKCJQMiiCxvQcHbOjqfa1m9ELPdkJG1ue13
         tE+ghht9F1xJocPm5K9iszs0Bn5m+3UTJvWSe6z1c9g72T+ACmm93aPNUrJlYwEG5fvx
         QaSlEFHv7xqPN04IhLZddoRP/nzw65s0CrjkFn5EBY57WkCQw8VyL89iT/7H5D1EYL08
         D4s3xT+yaoOoLLxwE0x9r16ciC5rokSvTPrbXOSx07XqQpLJikVi2guuesR9njPEmpDY
         lNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774031265; x=1774636065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8W5cvFUR4VXf+WaiJdKnvQRdmelG4HkMeFFekxFTBY=;
        b=gw/eYNZ9IgwOcbKmIqj4/+JjdmdjuvfoXDYbnZ7I9xobJVL0fglqySDUnN4/BO8Kt/
         608OodHBltAC5W+JDxIiTy3uGN4a4mZ4mEYqlz5a0AvyNvcwJcKs2G10j0KwYRuRQaF5
         W6xBw4yvKRZG3FxqwyeY3y47LRWTw0+ZGxDln4BFbGYnQp0ilDdR7GaNN8GFBD8DvzeQ
         GJqh3SK286rPaZaX45xVnHZ5P2wUyECPS4GDU/VahZ0XnCe1tuEHOthct4bgMveNRVsa
         ZbmfPuCtl3UXdfz/9GI/m4WmKJA4lR5NSvkgr2t3z75avACI7CwQEEiRItCYNtLhcVaE
         MG+g==
X-Forwarded-Encrypted: i=1; AJvYcCWV3aETvxFUO3rYabKKR6WsOl0zNIMU0XDtDh6pMPHHnD4StWsGtfPPNHKvQQFIK+9NIKziZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxkd8d8jsYmhzrHp/idWbhwiL3r8JTsm74lbOYJh/GLnF0ktn1/
	tkYJ5Th++RxAIVu7AIy0U0VezwO9vanIBd5DQR1ym42vGck5I7o7UWBDbQBmf661/Q==
X-Gm-Gg: ATEYQzyM0az7z8K4iTcKHt16SVKYsSfQuHWp6veMvubcGJthIBmm1KN428mo1tZYPAv
	34YRcA8OoEoqAYYkpB+leiMT7KqUasVdB+vOKMRGGXWQmyIbGcESBQc58cOvppa5lS9UZsIzMXC
	OKLE69clXaq+Ss3hFcDE4K+dJb5BqE1vr+ATjtmeO7LzLNkxrLlVN9R/6qTEsgK2w5A1v/68Fir
	9GtTeQsG0268KjGAhNl6xCDxwpeCbcp6LsvLlE7peuKZWAGQsvTuHDtwGwStoSwrBumSrVDz1DU
	nu2jVX9ZQA5PUEscQPCd6AvKec3XxbRP7YeYsCaF3dzxP3ep1xTti4tBfb1otyUsjXQ1uf6Nv2n
	k7rzUL7cunnue/y2/H1OigPuh3YZfCldnM2FkoUbP8KfNzCNozWVw1Y3KVNMCiaAy3qW4fVZJiD
	NZzgPGD2eIHxZECBGcqEV0MRL1XFzj/Qv2mkx/It4yghCQrEZSPqwjJfygmMmrcQ==
X-Received: by 2002:a17:902:f541:b0:2ae:45cc:aeb6 with SMTP id d9443c01a7336-2b08b40ab79mr410815ad.6.1774031264003;
        Fri, 20 Mar 2026 11:27:44 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a8176e7sm2212848a12.8.2026.03.20.11.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:27:43 -0700 (PDT)
Date: Fri, 20 Mar 2026 18:27:39 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <ab2Q_ZH_UIHk0Ne5@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
 <20260317202925.GA2582517.vipinsh@google.com>
 <ab0TPFo2esHZ6RIb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ab0TPFo2esHZ6RIb@google.com>

On Fri, Mar 20, 2026 at 09:28:28AM +0000, Pranjal Shrivastava wrote:
>On Tue, Mar 17, 2026 at 01:59:03PM -0700, Vipin Sharma wrote:
>> On Tue, Feb 03, 2026 at 10:09:38PM +0000, Samiullah Khawaja wrote:
>> > +
>> > +void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
>> > +{
>> > +	struct ioptdesc *iopt;
>> > +
>> > +	if (!count)
>> > +		return;
>> > +
>> > +	/* If less than zero then unpreserve all pages. */
>> > +	if (count < 0)
>> > +		count = 0;
>> > +
>> > +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
>> > +		kho_unpreserve_folio(ioptdesc_folio(iopt));
>> > +		if (count > 0 && --count ==  0)
>> > +			break;
>> > +	}
>> > +}
>>
>> I see you are trying to have common function for error handling in
>> iommu_preserve_pages() down and unpreserving in the next patch with
>> overloaded meaning of count.
>>
>>  < 0 means unpreserve all of the pages
>>  = 0 means do nothing
>>  > 0 unpreserve these many pages.
>>
>> It seems non-intuitive to me and code also end up having multiple ifs. I
>> will recommend to just have this function go through all of the pages
>> without passing count argument. In iommu_preserve_pages() function down,
>> handle the error case with a "goto err" statement. If this is the way
>> things happen in iommu codebase feel free to ignore this suggestion.
>>
>
>+1 to this. The current version of overloaded count is counter-intuitive
>as it expects a back-handed API contract. Since we're using lists here,
>I'd recommend using the list_for_each_entry_continue_reverse() helper:

Agreed. I will use this approach in next revision.

Thanks,
Sami

>
>+void iommu_unpreserve_pages(struct iommu_pages_list *list)
>+{
>+	struct ioptdesc *iopt;
>+
>+	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm)
>+		kho_unpreserve_folio(ioptdesc_folio(iopt));
>+}
>+EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
>+
>+int iommu_preserve_pages(struct iommu_pages_list *list)
>+{
>+	struct ioptdesc *iopt;
>+	int ret;
>+
>+	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
>+		ret = kho_preserve_folio(ioptdesc_folio(iopt));
>+		if (ret)
>+			goto err_rollback;
>+	}
>+	return 0;
>+
>+err_rollback:
>+	/* Rollback only the successfully preserved pages */
>+	list_for_each_entry_continue_reverse(iopt, &list->pages, iopt_freelist_elm)
>+		kho_unpreserve_folio(ioptdesc_folio(iopt));
>+	return ret;
>+}
>
>[ ---- snip >8---- ]
>
>Thanks,
>Praan
