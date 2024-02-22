Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF92BEC3
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560637; cv=none; b=BlzVbWW5ir/sTZrOz04LQ8qOQzB+Z6FXugFZE8yV1uAsCg3oHkJB2m90rxmhLeHISLH7QqHHUuKJNMsX13gAuS3LRdNX3mIBQat/7B4MDTdZjYiBdTmWh56MQGKfn2+iWZ7F0icA9EMyIMdzD0XyfCmvBtOvPE7RkGSOfj+09/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560637; c=relaxed/simple;
	bh=1D0pVaWMlr8hskhdGaW7hZtXBWle1reW17x7OUuU9Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsP3xLIxT8UFME2hU2PIKHAa8rFuJAXXgnJJzjP7Z0mqtReDOQUV0bJpbCJ2Rzg7rCJTAzMYL2TVbU67W0jxjLc86N5GXawCEI05DheTlVcECvGP3uQ1hm2Vt7RWuZOzj0UtM/1zEoB/+5ZAIauN825R61xFsjWi7ceJKhFiZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=H+7gfDE7; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="H+7gfDE7"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d5c2502ea2so2789211241.1
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 16:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708560635; x=1709165435; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D0pVaWMlr8hskhdGaW7hZtXBWle1reW17x7OUuU9Uk=;
        b=H+7gfDE7IKvyJx6iYVhjcFooEHPSkJw95Us+Eo00f8tYHfVhSsZ/W1kPsK4mUE951H
         4IEIbyvxKdmy/MQW2MhXBsxtNp0XOnm1NsDfnw9EfpfliDY8bp67ce6cmlfrIIlYMyrE
         EyOW8zBorJH8ngxT6VyagNBDk7aHtPQAFH5uJW+wcilHzdAKV1UvmfUFpNlhYdKVy/Yf
         yqMzcj6FVZ77sb/Z0+gyDUwgakM7RRm57DMYPf1UXJBgf0oJqD7NhODiq5y1uYz2zkoU
         ok/5CNloewgSsHkDnD71iTRL3qNvxHb4oq0W2hFFqhHxa+mtXd7Oukvvx8oBGM9M0yf6
         AGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708560635; x=1709165435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1D0pVaWMlr8hskhdGaW7hZtXBWle1reW17x7OUuU9Uk=;
        b=SrAOm2JxQam0LWbHqmnPHWIR+E4/OYJP9wsrHmfZ9D0qqT3bAGLduvVX7xHf2gxOSm
         PqvU4jmjSV8L6fPtWBs2SQAt3Hx7SeqItb0eHoYtpcUCfpRuVBS8ho2dQ9LFjUVf6vgD
         Btbzy1Q9vfwrVN6HR/3k1NMKi7HTB4xp9T+QF8SKXdjMl1nd/yqHaR0w4A1Ap9tDM6B1
         cJAFBSOSfZTcJclBAAHYt9ssAdSd6z3aESE5VKFkQSQ1qmFSewkbqp594tvQK6UtOIKb
         dsie7jb9uVoNYJama9S2JCDovMzyCe45Gc+UTsYkcJySGLx5o7PsgvDr/4KhRLDY5MUc
         bV+w==
X-Forwarded-Encrypted: i=1; AJvYcCUFYT38XLKxFwEeF626hha6xPW6u+8imZ3fhzVuIZ00V6gq8Oem5APRGst8tWv90XPAaPiYx9k13j94fwcVZbqSIIJWlWA=
X-Gm-Message-State: AOJu0Yw01fhLeCIG9bpCiF4kSn89FjG1RyDtI8a5npm98gwkWu/Kia4U
	mJDBTGF5X34422DJZkYit4uQSbj8JkjCCMuHv/AF1xwXHLW83GX916V8ZEAkt9T2Xbpuqdl5SmM
	jlW1wM9C8Yn9/mk72tBfBxwxs8WUUSL39Y05dJw==
X-Google-Smtp-Source: AGHT+IGvkzT3uz6qELPJtraK+YKtQ9uJucd+Pri79etJZSzYbQUZmm3eTGpEAZMzRr8Ip545g98kCtUJT9vyheZUmog=
X-Received: by 2002:a67:f54a:0:b0:470:3ade:af52 with SMTP id
 z10-20020a67f54a000000b004703adeaf52mr11439980vsn.6.1708560634875; Wed, 21
 Feb 2024 16:10:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-10-surenb@google.com>
In-Reply-To: <20240221194052.927623-10-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 19:09:58 -0500
Message-ID: <CA+CK2bDWkrNapWD7pv47XQo8PD4qJ3O=U99pL3o72KCnrzpsXQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/36] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid
 obj_ext creation
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Slab extension objects can't be allocated before slab infrastructure is
> initialized. Some caches, like kmem_cache and kmem_cache_node, are create=
d
> before slab infrastructure is initialized. Objects from these caches can'=
t
> have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mark these
> caches and avoid creating extensions for objects allocated from these
> slabs.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
