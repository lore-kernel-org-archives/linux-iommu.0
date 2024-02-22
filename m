Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B3E63D5
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 00:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560551; cv=none; b=WCPqmFNUQL9hU700nsUAn9f9sQG9hcADeazXvh+D//HAyqxCc7egajjIRmO7kAcCPz7VQi1BKbFE9lZ7Fsvrz3kO4et7OnTKZFU1Su5aVxodysHNTPOy/wDgrSpvHhh1xkCPbRByq0xaxPRzxK0NcJW23xxe1WSRXbgQH6RBsGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560551; c=relaxed/simple;
	bh=aiZ2wjkXdUeF2DZJw2oBIl8u+9EyfQfZ9ycNkF8fAgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLD3XmI6yAk9IMaFtZBVW8UEPxKLSttGqUGS1WCDNG6bLyIhTo4zvUY11okzGj9SXViATaGlLjHRWErDdDS1ZGuup31RC/fRmPXrrYdQYgRLVvhmpTL0sbOEQi5JdAHJC61ZZhtYt9Qpzvvl94nSQGxv1/jW8MxVRcAUF9pxo0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=zRZzd3KK; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="zRZzd3KK"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d2940ad0e1so4605061241.1
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 16:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708560547; x=1709165347; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiZ2wjkXdUeF2DZJw2oBIl8u+9EyfQfZ9ycNkF8fAgk=;
        b=zRZzd3KK7IICEaBVvDWVK6m0SeykOiiIIasAVq4iGDq8w4K8rUvPToqCrtu5yQUAsE
         Alh0wMCW7Q//YBQ6tWhr2HHu2HbR//96z/tXv3Q02PvRI2bXAzxmYrujGxwdShhb/Uwi
         CHAyeb/JSFKqWvAdhpYsBFw/kT9e2Ti/8I0YgisYxrJtfGCIhlEsi5hVTJNCwCIcye8w
         XPY5W6v6x+ZCxq2bYTh1NFjJFafl4ELYPPGgqdhPMCJi0tiocVM0ibSl1NykkBdC9IR0
         gdhH4lu0Bd4qHvFtkHFDeQ4djle/osiTzo4EA4saVJPyoxu0Vn8+7Hi7S3mqp7cMJayt
         OZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708560547; x=1709165347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiZ2wjkXdUeF2DZJw2oBIl8u+9EyfQfZ9ycNkF8fAgk=;
        b=nCPiOogUw1ik0t1ybovcaAbIrdyE3kBmA2PNzulGoEVh1a8IREVeoCtFEVWA7BiE0z
         x+FdTWUEjoxh07L6Wh0MzoZqM8nrqBo9K2MoXfeEUwN7gbMBZJvi3G0uyUGpGwYaj5Uv
         bfWZRCQ6zvpJXrEr0/D6mU7+5GDk0bUJMM/jIzCsAhDPfZn1OQBFWIaXZEqps8ccrhkq
         dATJUHrQ3G15TIZWoqXM5Ry9hw1C2nXG4l+ozE1QN2xfhD9rgLzQ750OSXQy3DQBjdoR
         gxaqS3ba3zICZX+W9LEiV7KE8V0zHcLeKs7HgZn8gedISbMVnS/O5HcNZfGxC73IowLJ
         dSNg==
X-Forwarded-Encrypted: i=1; AJvYcCWK//nlDG6D2Lv6xYlS/cRVaZqPYtIb8P6vWtKQlBjTABihYBavKUeIv+8t4IdTJJNwJqrcq7+0gy0i/s0C62HqhaK/s+U=
X-Gm-Message-State: AOJu0YwcT69X1Qqi6yxZSXdZ/qwvN8Fk7v4fzwVUgbN+q5NmAPjVseZ0
	Wb4zt8AtPGElt4RH6ISKzG8Tcl/A4IIcM1UmzxjXizV91pmfVadCoD9NejA9uQH+V8x3cVZ+ib+
	zmIqGlv6f9DT/hANQjFSv6UE0ewxs3qZ10/H8FA==
X-Google-Smtp-Source: AGHT+IE8YdNcoy9yHPyWH3FSVi3grCuLLJ8fT8RNUBKoMQxE9UzcTUruywG2qiU3pKHX1/up6wOF6uOUyIuOPTAbvgM=
X-Received: by 2002:a05:6102:953:b0:470:605a:6a4 with SMTP id
 a19-20020a056102095300b00470605a06a4mr10156813vsi.21.1708560547208; Wed, 21
 Feb 2024 16:09:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-9-surenb@google.com>
In-Reply-To: <20240221194052.927623-9-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 19:08:30 -0500
Message-ID: <CA+CK2bD-AvHR45zWrLOGA7Y=HQeFf=Ty4vCB5bWxbX7XyMsYRw@mail.gmail.com>
Subject: Re: [PATCH v4 08/36] mm: introduce __GFP_NO_OBJ_EXT flag to
 selectively prevent slabobj_ext creation
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
> Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
> when allocating slabobj_ext on a slab.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
