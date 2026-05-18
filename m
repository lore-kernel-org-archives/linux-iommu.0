Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153E03F5BE4
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104475; cv=none; b=cGLF6qEkdufBqnnSAuHVPw1Q7Ru7S5XXwmRbqk8N+i5LuC4cK9jOf/qunIaGwLPB3L/GBlh2gt0wSfOGEMJ78Pmy+JAMcU56GrWA4jX5izCe1B+i0FyM4PQuQQNkDtER6z2/1EGv3xCq//qM/CMEWA8uulwCZA4vVXVATulZEZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104475; c=relaxed/simple;
	bh=JR0gj/1M/EUhnUgMaxAL6FZYgD0KFlF3q0h2HfpHoh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGZXvLeupygB4LKUem9ImeRxiIqu/8dS+y0CNQNq5hv+HDD+Tj/29+UsoBw6u5zzuSWtPpI/ucIomGR3SQS65vgsLdKkCrTjcTWSc2y68nSOx/EKLS0i/XkmpYsk8E5i7UBbdKGiaqYz5LF5IjOhX7Drrn+7V/+Dcu5aA1ewlOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gq+/vWnC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gq+/vWnC"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba180a022dso405ad.1
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 04:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779104469; x=1779709269; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0qOz3b3qR8FSsbmRfcqeQDHbaJBOBeBCeW2JkjDXVM=;
        b=Gq+/vWnCnoP2+Co6Kjt0ZmPIGpem+uw/XXFl+9n5qcsJvRDLLwCmicWjiAqTsAEHhg
         Sfy7dR5kWz1er0Ufmp6hlvTMhRiuNju5JC4eyNQRUyy06JUlRVMYQ2RHHQmYOtiCzSEo
         wlHlpi+87Jc+B5aFgLCRxzXVzKamqOQryiL+3b8rwVcQPsiRn6FZEfBnqGmGu4/q7kky
         wiKfaIxQoVO79+tX2OjpWtCdqjj10vT+zXxH7Wq3lWglL/rMIZ4Zhf4B9aYKCs/i17IJ
         MGWokSBh8oecWw5juH3yuqpiAJMt7c04mQCK+KUXxhXtYP20abuyHjzF8zy9MYrA0aeC
         XKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779104469; x=1779709269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0qOz3b3qR8FSsbmRfcqeQDHbaJBOBeBCeW2JkjDXVM=;
        b=sXtPdDNDV5KWpd+qzgea8beTx1OfCN0qBk4SlTzxXbmifYv+8ERqx9ijgPlM1It82R
         +PYtJIOwD/jtP8BwjB636f0kFo6b3KzmIrmnYMzWoovmlFHuTxxy3jl5gI1sahdCxWXX
         To8tVF6ku4IHo+e+Qo/vkXbVNS4cRdZL8JRVq5M7uAhtW9VOzku1W1Z3jLrma9ijkJSv
         nA5/6chC+xepqCk6ZRqT5J7Rf9oR/cwWiX6VOXUecCXhyOUEEQFszuFePVkFKvD+QSy4
         0iC72gecB0U2hz0U+qP5RNzlpF23Cxzux2A/eh0BdzA41jX/iCuKHAp4p2nS2Jwy83L1
         ufCQ==
X-Forwarded-Encrypted: i=1; AFNElJ91rSb3S9gl8GtPJlzXafhYbBBDu5Za7FBDo93+j1Qe3fI/Hp0CLnaDssXIzGjhOc7tTzEFcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlnCD6YXgaJY4opVpAx3CUteKfRmToC1KJqQbYgyic3RrK95l2
	5pERYoJx+visei9ZBddduUewIOcxXrKQjyRV7cV+AS/zdndfNQx9JkYvfRUqQ4N33Q==
X-Gm-Gg: Acq92OGRea3nZaVe4ikmnDbTU99guiRhVM66nqZMpgsyuX/CblqDNIUNdHPRZRSzJev
	OhJPhDufv3IomgiQqZ3kgNphioSSJTaNDnfl8+r3um+grZHz5KUgELYclDeU/JMTLECRUpj1guP
	VJUIL/n2GK9s2CABQqQ6MH0aA1Ezv3H1OALftz6BSxV8830lHc4NtZFYMOcaUyMNPStrl/Gj3Ex
	2F0Y3D1IvEmF4njFeMJKO353fQROL6EByRKoMKJ9PFfwuxU4jnuIOSwfoRqK9Y9YQxplcsaNYtJ
	GWPxjh5etCaK8TSIi1n0ZjvEr7JyJcsbUviSicnvJkrrQj2L0rKUc/936QZqos6mu2uZpz+L1QQ
	TqpAVjTkcJEeTcEiyXEd1uAnAA7XqGjJvTyrj8bmjRr/aJLVv+f2MpKm0C5c+07S8UHF7tN0uQd
	790f3Jyw2YvHJgwSO2h7XX7lL8YSPaJU8s8QfV/4fBnoPbtUF+rkNgItEW68TRaAgCfpPW
X-Received: by 2002:a17:903:22c8:b0:2a7:87c2:fcde with SMTP id d9443c01a7336-2bdb329b549mr2479455ad.15.1779104467825;
        Mon, 18 May 2026 04:41:07 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2cesm149846105ad.14.2026.05.18.04.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:41:06 -0700 (PDT)
Date: Mon, 18 May 2026 11:40:58 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 01/16] liveupdate: luo_file: Add internal APIs for
 file preservation
Message-ID: <agr6yoyYYq2QFxjL@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-2-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-2-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:18PM +0000, Samiullah Khawaja wrote:
> From: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> The core liveupdate mechanism allows userspace to preserve file
> descriptors. However, kernel subsystems often manage struct file
> objects directly and need to participate in the preservation process
> programmatically without relying solely on userspace interaction.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

[..]

> @@ -924,3 +931,65 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
>  	luo_flb_unregister_all(fh);
>  	list_del(&ACCESS_PRIVATE(fh, list));
>  }
> +EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
> +
> +/**
> + * liveupdate_get_token_outgoing - Get the token for a preserved file.
> + * @s:      The outgoing liveupdate session.
> + * @file:   The file object to search for.
> + * @tokenp: Output parameter for the found token.
> + *
> + * Searches the list of preserved files in an outgoing session for a matching
> + * file object. If found, the corresponding user-provided token is returned.
> + *
> + * This function is intended for in-kernel callers that need to correlate a
> + * file with its liveupdate token.
> + *
> + * Context: It must be called with session mutex acquired.
> + * Return: 0 on success, -ENOENT if the file is not preserved in this session.
> + */
> +int liveupdate_get_token_outgoing(struct liveupdate_session *s,
> +				  struct file *file, u64 *tokenp)
> +{
> +	struct luo_file_set *file_set = luo_file_set_from_session_locked(s);
> +	struct luo_file *luo_file;
> +	int err = -ENOENT;
> +
> +	list_for_each_entry(luo_file, &file_set->files_list, list) {
> +		if (luo_file->file == file) {
> +			if (tokenp)
> +				*tokenp = luo_file->token;
> +			err = 0;
> +			break;
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +/**
> + * liveupdate_get_file_incoming - Retrieves a preserved file for in-kernel use.
> + * @s:      The incoming liveupdate session (restored from the previous kernel).
> + * @token:  The unique token identifying the file to retrieve.
> + * @filep:  On success, this will be populated with a pointer to the retrieved
> + *          'struct file'.
> + *
> + * Provides a kernel-internal API for other subsystems to retrieve their
> + * preserved files after a live update. This function is a simple wrapper
> + * around luo_retrieve_file(), allowing callers to find a file by its token.
> + *
> + * The caller receives a new reference to the file and must call fput() when it
> + * is no longer needed. The file's lifetime is managed by LUO and any userspace
> + * file descriptors. If the caller needs to hold a reference to the file beyond
> + * the immediate scope, it must call get_file() itself.

Thanks for re-wording this and I'm sorry for being a stickler here, I'm
a bit concerned that the last part here might lead to reference leaks in
downstream drivers.

Looking at the underlying luo_retrieve_file() implementation [1], it 
explicitly calls get_file() before returning the pointer (both on the
initial retrieve and on cached ones). This means the caller inherently
receives a reference that they own & the caller is responsible for 
exactly one fput().

However, that last part of the comment can be misunderstood as the caller
doesn't hold a lasting reference unless they call get_file() themselves. 
This makes the reader assume that LUO is going to automatically reap
that initial reference from them.

If a driver author assumes LUO is going to reap it, they will follow that
last sentence and call get_file() to stash the pointer safely. They might
end up holding two references (thinking one of them will be reaped), and
could ultimately leak the struct file when they only call fput() once 
during teardown.

Should we just drop that last sentence to make the lifecycle contract 
unambiguous? (i.e., The caller gets a newly bumped reference, and they
are responsible for exactly one fput() per call).

> + *
> + * Context: It must be called with session mutex acquired of a restored session.
> + * Return: 0 on success. Returns -ENOENT if no file with the matching token is
> + *         found, or any other negative errno on failure.
> + */
> +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
> +				 struct file **filep)
> +{
> +	return luo_retrieve_file(luo_file_set_from_session_locked(s),
> +				 token, filep);
> +}

Nit: Shouldn't we export both of these functions via EXPORT_SYMBOL_GPL?
Since, these new APIs are intended for kernel subsystems to participate
programmatically, there could be IOMMU drivers (or others) that can be
compiled as loadable modules. Thus we should export these APIs via 
EXPORT_SYMBOL_GPL(). If they aren't exported, any loadable module 
attempting to use them will compile successfully (due to the header), but
will fail to load at runtime with an Unknown symbol error.

IIUC, if a function isn't exported with EXPORT_SYMBOL, it remains hidden
inside vmlinux, (i.e. it isn't in the kernel's global symbol table used
during modprobe).

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.0-rc3/source/kernel/liveupdate/luo_file.c#L560

