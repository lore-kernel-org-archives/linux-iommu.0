Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC011432E64
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252454; cv=none; b=N6QAiaJITztkchCtVgjb4rtUZhN+ASAc1YdQmpGu5P8vJywgCQuqsfl6H3THR0VufSgO2dnlHfVVq1cFLmzuFtZbG3oiOEESS+9yeSl4b4quvTUO46c6z0qix0wTNPuxNi1uw/SogaWjwpRkifZMRYb+7ERNgKeiAVBq7IfBRic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252454; c=relaxed/simple;
	bh=GuYMv+3OeZM7dBc1rScPdv7HA9p75oDjDJJKhqaCJCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuxkIxPgMDwiJO6T7vtEThAnkdAQg420GMTd20I29Zkpn522hwK5fpEKqwJsUpO+knonWTxhH2t2qsWKxB3hIjta05U5Kbjm36c36dux7nnZBSF9E2r5VNFUL1419VijnaVuBBF6icHG83x0UqxxdBvVwNYsUTPuwIo4njOpXBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LHZFhDVE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHZFhDVE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49ccf12bed0so25715e9.1
        for <iommu@lists.linux.dev>; Tue, 01 Sep 2026 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788252451; x=1788857251; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k+HrXbMbxa/Y02K3QZMbt843lXkhHRmzbDFOaV/a9gQ=;
        b=LHZFhDVE9Ce5q9FcldaIj1qztrfFaDbZIT47Db1YvWEIV8OQ7S7yymjmkIkMyOYUQt
         sK2EkvXetMtV+3t9Kt0twDSJF+zXDWqBjfjBZxRjGeEiIIupiB3EGy7YLJjlE536waTu
         77ssxpjdCB80XJ5nOcab+G84fHmRXTMUe9fBKorC88mAWDqFAeCeXg4lCi5gHvwT0d6B
         D/+ZHM4DEBbOMJl8O3ocbyBlGzIQGrM1NibXrFSquQGKh2AUkMj6Pulh+FJClr5e8eNG
         1+M/MyEi5aY5q3dc8rp1d7HdBtzq4GC2Zi6+CVJo1FlGj5qCC2Ib5fQPtxQjalR0HgWQ
         pRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252451; x=1788857251;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k+HrXbMbxa/Y02K3QZMbt843lXkhHRmzbDFOaV/a9gQ=;
        b=IfKH85OeG5Vzdh1EpsMk1ocB6/bRP6o13dC2IqhyJSMF/SsVzR7g6p/nsDrBT9qOTR
         EytfII0yddzTjA84e6dV0MfAbwvLrK9RPEAA6lUxALytugnxog4KhZif7tRzW8qR/sDX
         fkdZVQeRuIe32WQ0O49ShcZ96b0zHVYDgsn4pmVr4SOpsCn2ZvzhkX5RNrAUxLAy3qrT
         bwcDimEbbho0uguxP7jTooNzmotK2baxXjKUkf5g3Kjhoc5CH4cBf0hjVBj7gm7A6Ro1
         K5OUq+kcA0YbI+n/cVwe2CL0MBdSRVGjRoOhVw5IWoZuNoQPhiTFzxUph1jQRwd+ubne
         +RFA==
X-Forwarded-Encrypted: i=1; AHgh+RqPztD0eT3iqbcsy8h/f0gazI38SxtLlC16E+COBkOrYPrpXfvph+y4ruwWYMSHt/REUkm/LA==@lists.linux.dev
X-Gm-Message-State: AFuF++kpbKA51l/htJJ+6Kwz/ug9VWHRiC6EJHMwIaoQvMYgSovr6XKu
	/rDOceOqqcNMQAgVoo+GxVb03v3GQp5mp6uXcTtNc0eafXZ7Uvh7FFqFaKsEsPZ+wQ==
X-Gm-Gg: AR+sD11Q2ZfD7X6RnKBlV19c+4VSnFKWpKK/y6/OgxbnyVAfStqj7LmTh/+GsY2b5kP
	BnaaoW8TABbKEhy54JCgobgBPlz2q/wK49D/GrMjN1l+3ihgBQxEZtQmRr7sdJbNGrmMyYEoiPP
	/jSl/GcJ3bpFUCKDEbaTIWC39a45VlKFP6CJ2+fm5GklDfa3kr/ClwIyhce7IYLsXuKpboN/w1S
	3UJZ7aucRJGZ8ONUj3apDSlm3bPxeofzvbRIyVwoBUxJN5pLS2GHAmQpOqm+WLjNVafDqlsvnIC
	YFhJ0AQjxlviFZQT2ykpZ+I9Wsi4Gy8GlKNuY8BSEJLHpxL0MSQtEpTWj1zzqZT58M1G23Ji74B
	YmKlyxoOqJUnCLrKjC1pnvwZClH08CCDFrYX0fw1e0isi/q6u7ZoYD8XW7H5xtEvHvkT7RdkJqX
	OmN7+x9c9qz5pfzZo+7BmUm7HJ9NmNk+SRf1Eb1Yl5qYuPQU2IeqRUszfui7c6Nc+X8Uzs2Oxu4
	Uq2f8XCf9jrWMIzE3WwrcYtJXD7Vg==
X-Received: by 2002:a05:600c:12c2:b0:499:be2c:94f3 with SMTP id 5b1f17b1804b1-49cdd26e207mr507145e9.6.1788252450501;
        Tue, 01 Sep 2026 01:47:30 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49c5a903eebsm220827575e9.4.2026.09.01.01.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:47:29 -0700 (PDT)
Date: Tue, 1 Sep 2026 08:47:25 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
	nicolinc@nvidia.com, praan@google.com
Subject: Re: [PATCH 3/7] iommu/arm-smmu-v3-iommufd: Fix error path in
 arm_vsmmu_cache_invalidate()
Message-ID: <apaRHXMxfM7lxdJV@google.com>
References: <20260828125409.1921538-1-smostafa@google.com>
 <20260828125409.1921538-4-smostafa@google.com>
 <178792724269.3808739.17189675074822824146.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178792724269.3808739.17189675074822824146.b4-review@b4>

On Fri, Aug 28, 2026 at 11:27:22AM -0300, Jason Gunthorpe wrote:
> > arm_vsmmu_cache_invalidate() issues commands in batch size.
> > However, if arm_vsmmu_convert_user_cmd() fails, it will return to the
> > user that it processed "cur - cmds" which may be part of a batch not
> > issued yet.
> > 
> > Fix this by calculating the returned entry_num solely based on the
> > "last" that tracks the last batch that was successfully issued.
> > 
> > Also, fix the number of commands for early failing condition.
> > 
> > Fixes: d68beb276ba2 ("iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object")
> > Reported-by: Sashiko <>
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> 
> Nicolin's series fixes this and the other sashiko note about over
> allocation:
> 
> https://lore.kernel.org/all/cover.1785258826.git.nicolinc@nvidia.com/
> 

I see, I will add it to my review list. Hopefully I can get to it by
this week.

Thanks,
Mostafa

> I think it is in good shape, I would rather merge it than hack on this
> further.
> 
> -- 
> Jason
