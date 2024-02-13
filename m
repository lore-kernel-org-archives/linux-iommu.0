Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1053115A8
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 00:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707784277; cv=none; b=IwpAsqynwg36uJmeRuWglE5msildpp+x4OibDW+kiQg4pNeqN7eMcyfYBJxEPa7WTp0eSy1+0Q5PCyxC7lX7lekAL/bCRnBy2hyhqQszrWyo1McK7S3PGIjtsTEFPnaYTanqu+u+/U+MtRCln4tLFAyHkK0zON6/N5qRJepA5HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707784277; c=relaxed/simple;
	bh=mNvkRhiyjJq1dsRwNB7SCDE/0DcmbqdFX7FIWlgw6qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPyiexPuYx1+C65Bp/ZkYmNEzcYbki3fqKhWobw6pEJmjN5Rppb0aKIDbtcR2XVqIVMbyUfJLAdSCUVVljIQvdCsn0duyuk6J8camZzo0xJBZrzBawnGPxSNRzBAgOBTxVHh1s0Za2NV2X7sG5SqVIxeHUbzpYthuR3DZKi05Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T2lgtO2h; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T2lgtO2h"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e06d2180b0so3089398b3a.0
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 16:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707784275; x=1708389075; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=flZnqd6/OOEmgqviJI0+73E/bOCz1vKp47Qn2/+ubUU=;
        b=T2lgtO2hLASmwLvITNNUJCtGqMCGhA9vycXgpozmYX1XA80ljgIy2yEb7n7CRpMuaN
         KS9N2c5Y5VJZLO3A67xwmkiBSM5FzAIakHF3JbWiafZ1+iiT6m+7/lriVJkNyB0PKlNP
         zRjFiUVc5AWH3IzGIEv4s/JMzYcnaA4/1j9oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707784275; x=1708389075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flZnqd6/OOEmgqviJI0+73E/bOCz1vKp47Qn2/+ubUU=;
        b=AN0np/ZZopV3XYBtgmPo0fyKMpASFeNO4HdqomgIfPnV4Li61rL2KYPYkl5/+ChZ6y
         oE9GBe4rtdZ7tFX284vuXZiSRGMHEq0nljyh0GVJpaWPyWXwbimgKN8TZWfEMYrnjAIJ
         tvAX4d8JBuBy90yXqW75ax/pR382TGT0qTW1tD4+22Df1pVfBjOSbemo3dDxhC48hHqj
         aHNMw5gk7IM+sCtMcLDrNpcRrS+aJF9/1utKIeeD4QOpM2HuLZ5I0B5mQs+h4sUSatkw
         dqfaaI44n0Y3B1cND972dolcCja52BBHPKhwi8pgA6DKGuWjGpeZ0sJZSJEKG/XVBpbb
         XIQA==
X-Forwarded-Encrypted: i=1; AJvYcCWgEC+WA5g260VoypZ75uyza8cT0MLzXsn5xtkEK9ZvPpHaPDtQJ47Ove6ktXmSAMJa3op+UQ/SxkV5hC5+nWyhbVBvbSs=
X-Gm-Message-State: AOJu0YzoxYOFFrJC7wf66LgVApIIzF9zv2MWFSD+OlYaVJFGY92o7FrP
	SApdOv4WvG2/Ac5mS0NknJjnhVEPQtwHVRVPKSb4UdhLE+NsbhRX0SMFFRPx4w==
X-Google-Smtp-Source: AGHT+IHsEPTpCmxVYDDW4VNRs2b8vcpDA5pedBCL8vEwt1Ggt87wDXOPZix8VtuDgH+3BmZUWUlZIg==
X-Received: by 2002:aa7:82cf:0:b0:6e0:532a:d5f4 with SMTP id f15-20020aa782cf000000b006e0532ad5f4mr8655990pfn.27.1707784275520;
        Mon, 12 Feb 2024 16:31:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVin3ur0Lo35hIyXtrtSV/cxI4vE5dmFtYD7ma+HtymCNeVZ2kkanG/e5r7jRI36pyWBjot8aUQYx6+p6LxLQnTNSm6weM6lZK91Z+2GZNgFWSN1ZeGPUdII18cHDDsVeHwP11mF9V5Cx7kzsoj1L4MeBLF1x4j/5G3iuwVW/cTP1lf4+jBzT6BusTtY+yb9OGjtgQsofJ3OkNeTsayYI6YnYoZKrbYP+SHJhtSllHfModJO/AP/ecndTCmiLycnsruuY+Z40gfK+ULp/KuzCJadwMupixtnYmRy1qpaieFOXGBmUxKVebYBQ0gaBO4gCxV5LZFueIZuKXFN1hKsPJNUcqwQAcizpIU/tBevp8sdiOcfLOYzHw+qiVJ5y0NJXKlMkVOcYTz8gNCo2Trtk3ICusgR7eUFM9ClFTEXbX5b6LW+RJ/ig/7J0FeSsOgfn3w7cYxkYi1mdkcSJqxdN9sljTmLw1cIEQpfmCmqGt7ZJwcUfz23XgPMMkH71ZPnZetjfaB08ugB7risf0yWGIFil3W8xnDYSDsWINLekmP/5pikpXr/SqTlI/kZtFx+R/Y7TJBg8XH8Khjudt2EkinnfvJOM9iaWgaRsupKFap50ol2vCniI0xkB+mMpzAvI1TnOxHZV03YgDwM1rGiJW/RCt7Rwyl0PU01O+eYaViHIiyZq9bR2CK5gDad7BWj2SfRdv7IqqyEtq4V00x9ZYyIPD3WstNoZqvyyTnQ8AXIH01cMXd3g==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r16-20020aa78b90000000b006e0dd50b0d0sm2678139pfd.8.2024.02.12.16.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 16:31:15 -0800 (PST)
Date: Mon, 12 Feb 2024 16:31:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 23/35] mm/slub: Mark slab_free_freelist_hook()
 __always_inline
Message-ID: <202402121631.5954CFB@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-24-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-24-surenb@google.com>

On Mon, Feb 12, 2024 at 01:39:09PM -0800, Suren Baghdasaryan wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> It seems we need to be more forceful with the compiler on this one.

Sure, but why?

> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
