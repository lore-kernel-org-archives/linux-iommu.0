Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415664;
	b=yQkNMVQGDHEHp3vs4v45KO8YKX7ZENMkWKYcvQbCT3bv77SZ5+t/QUcxJhUfEwFbUfwY
	 iMYX5BXgOzqRwIbpJKYvrYkNffyheHfKA393BjCFuaFA8gwpvmruJ3yazFGFAua/lmVT2
	 XcDTHOmldHOtJhlIAR4POFR2RQ8G1rFaCZOjWlLLpW+CH3ugU/ZwRW7UNQatr0DeTY7C6
	 uZQtjXfKkHQRYavdrWIC3Y5xBc8FXUfKyrpYYZJsrni1W4B0zeOSE9kJDbrDoVYdxYPb+
	 k+FF1N70wZjATLCmBBRN6g3jD2UDFIEOtq1d92jHMuzvncS8bx7f3knuYWUXMPQ/TSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JEN1we3zUbJ34wQgamBpttlVbDethKWGuPURScqYgfU=;
	b=fHnw0RZh2gF3L54si/Kd2Q1Ei/QHRt4LTvwiHGh+fNdlf6eQ/K/JLJd7rhK1R63nMnwd
	 aIvfcwJ44kONFlXLxmsI/GjCUPwNyTofLGggn1UDeGOrZ8GVA1eXIolagFm44Ox8vM0Sf
	 ahF99oLLMwAuRbuZ3l6KfCgE2UOtEOn/c9p5EJIB+r0rHk1u1RswEfRfqKkfj+kIEopio
	 3VUxlBqGbo64XHh/CEOA/e3utXpn39iCw6G/Ewc2HjK6VjzMB6FP63oXRh5hsHwahYN4o
	 2EKI3+Q3UVHiUQOe8BeGY9bxGaz25b5IRImCUpFzHXGKrhA2rQcYdeHTrqfa8D4//VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pxV0d1bK;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B996606A337
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 16:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B996606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pxV0d1bK
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso7920f8f.1
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 08:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794415663; x=1795020463; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JEN1we3zUbJ34wQgamBpttlVbDethKWGuPURScqYgfU=;
        b=pxV0d1bKyYUe1+xmb+QH9TTW/DktKeNIDnHt+AkmmCoTokOXse5avDBLuBhKr1+lFM
         1dt2Bt1+bx68ANjER7DiZeo1NoSfxWV/ii5NVjHJ1HBD8aWAmo/828eWqRgxhvD/H9RG
         jUmhJfrvQNuDeR7v8bPCsSDP3GcENj0i2XD/vKba56ZxIVXLPXDhZTQhn3Sf4XQUs9WU
         XvJs1Bv4iROFpViYH3GT7nq0BvQm9ihxCmioGVJwbtrVYGeP/H2bFnwGtjijnaCE2+g/
         G522IBicYbSodCoZjLkGhtrTcPAJvhv2DeYXL9HpvTRXi/eJzX71VBHffCXvJlJWJ0rJ
         1EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415663; x=1795020463;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JEN1we3zUbJ34wQgamBpttlVbDethKWGuPURScqYgfU=;
        b=1qMqSuSm6Sc7oX9lFQ8jU4eUmX7kEwqkmFB8mQ7IjWU3DF+lu34xstVBUOya9D0wuU
         VtlrAHNHmK62qas5T+FpOJhc0fpXvxTIcpoQpI2KjdjVRW93xf7ZHtTt3ZaBH57lGJAT
         czVFLng56I/O+zaTxQmbtv7jStkn9jKgPmZypGHabKTrgGfju3eDb5/dja6aiDrvo9a6
         vgk6k88vQCBYfXJGb/SVp3R4Kqt02WDv+Yf2mLNgXtOJQXlbsrcoeeDquQlpIaL1L6Bi
         64wV2zzdRDdRMhJETZ0I3xnjwpl5djzTQRCF3K3CLIWrRq++nXZ5O7hLR6ftxPWukwFq
         xqQg==
X-Forwarded-Encrypted: i=1; AL+hErE91sv8F4C2VbPPl2iFRqIcZDnq007elOLVNI1BX7YdQ3W7DPZnSu28k9R7HU73Qm0JQI+EVQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z90fVUhsAmIkJ0wNn+KG2lZQFYBYnh+xlCZGHYiHS1cCc6R4RCG
	vx/U2c7P2YS6paE5vRjbbGa9yKgJw/7x0+todBOOcteCjLQCtKccKfmiuTYDzPygLA==
X-Gm-Gg: AYBFou0o7bzWhmK+7iQAZY7F8O65KeuM8DmBXLv9cKn+8oF0uDktinVPe77weNQq0Aw
	Gs30RjGTUyDAwD4izpbdUD+XZKiM+sbaOKCMOq3WjE6SFduPgq6TIzRvb6etSj8uCwyJFGflfip
	KBlVNuoaqXE+ZRTkXZlf2p6bVKk95Jmk58N52TXrQagNVcszHz5yglsEEQmSFCseyhpuHAc79dj
	GyEQ8SUce+SFyZaz1diInxdtc6jaXsSYynSqeCmuEUpXNPDx8hUSKASw/s3xPOaI+cl/dE4V+yA
	kSGe8N8RXAOtQ2zTRyVxjvb3vg21iHgiObEGxXDCiQftiZWs48d8r3Gnyzyc/f1df0C0hM3xDMJ
	48kjqZ2l5UUHoKAKEV83XuQEVdKEUvkA5W3WaRXWjaECrYqHBfiFWe6C5ROCzVLhbnmQQJUNbyx
	A93UL0i+6/cY8BHQsSUZmhyMOO/T3gsh1axzzwMqdU9Xar//YZjrVC21jIJ4lnU6VfKsGAODkn8
	607FPy8hxyvgmGKyjLGrUkLd+a4/3SNjW4iYF3+mH/WbT6eiLAHteWH2CQNUiMOJkG8YyywyqSM
	Dd56x06CjFrFPscVq84dvGHkTIuHpoKWt44BAj4BCuw+XO3I6dMQCe5TwetHVzpEzw==
X-Received: by 2002:a05:600c:3f07:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4bb4e27994emr1100895e9.6.1794415662004;
        Wed, 11 Nov 2026 08:47:42 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365cd06fsm11724877f8f.40.2026.11.11.08.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:47:41 -0800 (PST)
Date: Wed, 11 Nov 2026 16:47:38 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: akpm@linux-foundation.org, dgilbert@interlog.com, mkp@kernel.org,
	loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
	vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com,
	eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
	rostedt@goodmis.org, mhiramat@kernel.org, jgg@ziepe.ca,
	kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org,
	James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org,
	christian.koenig@amd.com, phasta@kernel.org, joro@8bytes.org,
	will@kernel.org, linux-scsi@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	iommu@lists.linux.dev, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, bobbyeshleman@meta.com,
	mathieu.desnoyers@efficios.com, robin.murphy@arm.com,
	mason@kernel.org, aesteve@redhat.com, tjmercier@google.com,
	harry@kernel.org, vbabka@suse.cz, cuitao@kylinos.cn
Subject: Re: [PATCH 4/7] tracing: account ring buffer pages and trace_array
 metadata to memcg
Message-ID: <avScKhR22kFOQ1z4@google.com>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-5-cui.tao@linux.dev>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106131829.3228926-5-cui.tao@linux.dev>

On Fri, Nov 06, 2026 at 09:18:26PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Creating an instance immediately allocates two full sets of per-cpu
> ring buffers, array buffer plus snapshot, about 1.375MB per cpu per set
> on the default config, plus the trace_array and its name.  None of it
> is charged: neither trace.c nor ring_buffer.c passes __GFP_ACCOUNT,
> while user_events in the same directory accounts everything it
> allocates.
> 
> Instance creation is currently gated by tracefs file permissions
> alone, so a
> rootful container with the host tracefs bound in can create instances
> until the host runs out of memory.  Charge the ring buffer pages and
> the trace_array metadata to the creating cgroup.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  kernel/trace/ring_buffer.c | 8 +++++++-
>  kernel/trace/trace.c       | 6 +++---
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 1fd28a72e6ee..676c059c112c 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -441,7 +441,13 @@ static struct buffer_data_page *alloc_cpu_data(int cpu, int order)
>  	 * gracefully without invoking oom-killer and the system is not
>  	 * destabilized.
>  	 */
> -	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO;
> +	/*
> +	 * The subbuffers are charged to the memcg of whoever caused the
> +	 * allocation: the creator of a trace instance, or root at boot for
> +	 * the global trace.
> +	 */
> +	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO |
> +		  __GFP_ACCOUNT;
>  
>  	page = alloc_pages_node(cpu_to_node(cpu), mflags, order);
>  	if (!page)

Hum, by default tracefs is root only. 

And even if made accessible to other users: 

  1. The life span of a trace instance is not tied to the caller.
  2. The ring buffer is shared by multiple users.

Overall I am not convinced charging the creator makes much sense.

Eventually a few allocations for iterators could be GFP_ACCOUNT.

-- 
Vincent

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e8c4efa8107b..04b60b9cc4f5 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8693,11 +8693,11 @@ trace_array_create_systems(const char *name, const char *systems,
>  	int ret;
>  
>  	ret = -ENOMEM;
> -	tr = kzalloc_obj(*tr);
> +	tr = kzalloc_obj(*tr, GFP_KERNEL_ACCOUNT);
>  	if (!tr)
>  		return ERR_PTR(ret);
>  
> -	tr->name = kstrdup(name, GFP_KERNEL);
> +	tr->name = kstrdup(name, GFP_KERNEL_ACCOUNT);
>  	if (!tr->name)
>  		goto out_free_tr;
>  
> @@ -8708,7 +8708,7 @@ trace_array_create_systems(const char *name, const char *systems,
>  		goto out_free_tr;
>  
>  	if (systems) {
> -		tr->system_names = kstrdup_const(systems, GFP_KERNEL);
> +		tr->system_names = kstrdup_const(systems, GFP_KERNEL_ACCOUNT);
>  		if (!tr->system_names)
>  			goto out_free_tr;
>  	}
> -- 
> 2.43.0
> 
