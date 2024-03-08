Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B46366
	for <iommu@lists.linux.dev>; Fri,  8 Mar 2024 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911425; cv=none; b=fc5lSwDf/Eal7sRiJRAoUOIOMyX4IOdmzz2iKU8oanDpfL/CICjtM+zkN1qdmqDpzs+ALg8AiOicYhz3/i3KEw3iqHz2AoiWhSo8jF1tGQSZiWHeN+TdRMFaUYoXTWZsq/rBhrhSmVLrr+S9HF8/la1JiuHNENUi/uU5JS22QgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911425; c=relaxed/simple;
	bh=smFQqtDCLvrCK6zU35YKk9vivzb3zYgAYB2LYuAuGDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvrQ0Xu4nWlu+P/ME4DqMfkXhTzh3V70ChZXG636Sw8AF6pf2GRmSMDK8XfF97jP31UAulgzIOwPTiWSCRjy0uEXhl1TvsKgmnTiBYHzSqGJ8XZ2DTZYoyY3uJWnAvx1l6pD1YETMDLmSMqSjMoN5956/aRKQG84aq5ShhuSvt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaQ3tdHa; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaQ3tdHa"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso1652683a12.2
        for <iommu@lists.linux.dev>; Fri, 08 Mar 2024 07:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709911424; x=1710516224; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcBcmCbNUNK8QMRYlD0suSpFuYeDhzgpUC/IVV9/I8w=;
        b=HaQ3tdHaDTQbpHrEeUDOQW2nxeiBsbZ3xTv3y57w3zRTz0GQDdL7E8vQQkbsgDBZ8o
         daqrIzgpRvW70fOdkF3c7m08NsnpV0n2Ch6DKY7n+JjQQYMlJO86Jkl/i0NZtRP3JyGy
         2AcTZHyrR79CVt93txR+0B0Ai4cRzKo93/VtzVEJE6vAQ+F1vPKua/k86wBZyU43fQmx
         rXJukl8UWwfroGRecBh4Ia5UiKVh7NPfPeWPeSFqBuY0z5Nfty9oHfhlEi9P7NZi6KTd
         zCF1ZmO0zPuDh8C6j6kuVsCQuCzyxR7gB6UnWseFedCXzXC05X2n9YQHTmO9K8eBWp0u
         +KEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709911424; x=1710516224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcBcmCbNUNK8QMRYlD0suSpFuYeDhzgpUC/IVV9/I8w=;
        b=b6nN+UILcLYffSMGToSvbcHNwm93m91UmRoWaElBeyqTbLGgCL4Oqs5/apvgEBsko+
         PTpR7XLDuK6zqdC6lVr51yAXx9RxDo5ry5SPIH+bUzp3v5wcitHXkHKvVBZPTPGwcLhy
         RIrGISMhMn35XE8ihGJ7r+eNIOKHJi6SQkXmk/73eGUT2XokMApgbdsIZ0C6gWqYVBEf
         /uHiv3zYqEBX3VnWuczWs1AqnJE7VbouH8YvCM8COlOOvBjuBSy498NIjdbxGTzxMPdj
         tAT0q6s5pCg5ImMJYW1sNPYphocse3LdYqrh4wvFKfw5wADmG5BjbWYb8wbDgGFWNDPn
         eJ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGVyShq2IxAgkkxulWzKL10w8pUe5QIjXctw+2DL/SUTCopLFrqfPTK/bONvTtGmKL+8L8feGHrcdKfXGv9SNi6WfqsW8=
X-Gm-Message-State: AOJu0Yzktb+NCGEo5ZdzlsEqNXF0SFDvxiUJSx1oX9eL33/E0hjPB7A6
	ZvuIrG1D9BG8Kbtbz12MQTGkbvYGXkzqs97ZTZPVBGmU5mJb3JRlcPo4bbYTr7P4Pe8Pz1Rf5O/
	m4iF/ATvhX16hb0u8nxofB5VFxw4=
X-Google-Smtp-Source: AGHT+IF9xXotb4fKJPIBJiGa5DZoshLJXVEv2bCNouhUyzFoUp1xvycg5pN3kRgz/qcs+lTDSybyD1fvb7+yeBualoQ=
X-Received: by 2002:a17:90b:613:b0:29b:90d7:36dc with SMTP id
 gb19-20020a17090b061300b0029b90d736dcmr281082pjb.19.1709911423609; Fri, 08
 Mar 2024 07:23:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com> <20240306182440.2003814-25-surenb@google.com>
In-Reply-To: <20240306182440.2003814-25-surenb@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 8 Mar 2024 16:23:30 +0100
Message-ID: <CANiq72mUJ6Nv+tDFoGbRYJs8Nzw18peFU3U-2cnz9MViyiG5ow@mail.gmail.com>
Subject: Re: [PATCH v5 24/37] rust: Add a rust helper for krealloc()
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 7:26=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> +void * __must_check rust_helper_krealloc(const void *objp, size_t new_si=
ze,
> +                                        gfp_t flags) __realloc_size(2)

The `__realloc_size(2)` should be placed earlier, i.e. this triggers:

rust/helpers.c:162:20: error: GCC does not allow '__alloc_size__'
attribute in this position on a function definition [-Wgcc-compat]

With that fixed:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
