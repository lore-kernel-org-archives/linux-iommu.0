Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B973A4F4F
	for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828076; cv=none; b=JHZ+ThE800j8uBMdEHXycVGej5QK3D9q0qL3REpVPFlJBAi6svFA1Sj67bwv/OjG1PHFlrBIo5DNqSCAm/oqwp1AfMkbjc5G2P7q8WuHGizOnp/yLQzt0j+ztK/XPN1TP/jpq3KtdT/IPQ4pE4ygmt7uyrUpR0L9ttP+5eopf4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828076; c=relaxed/simple;
	bh=JPaXyjJ1A5i2yIOTLMc9vKqsMLWVu5GnkzNLGI49TKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHM1rh60dZQ5hWDk/dHe4SznTsboXhcTaUYls5gWK1yjXV1CLx4OKZWLYfGetUzZZj3H5VhSsjBQ4BqSrCJ2rjiYbPTC9UQ2+GS3r/6RtVrOBs6XRYi6jravI58rWqGdx9UKS/9vaoUpMjy79WQcKgQAYvrsJaSMbMPe/3CrIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhdxMWbE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhdxMWbE"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b052ec7176so58355ad.1
        for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 03:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773828067; x=1774432867; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z4qZe0+PX9efFctzFLR678BcWWeiXKEHS5jhgninu1g=;
        b=PhdxMWbEUBAgs3dMF97SpLyXYk9+5pYWSleoHQbTdcZEVpXIGnDe4Hw1EkCkH372wQ
         Mog9PZ9UJwBld77bDNCMvTVT1YYZRUoRca3xZuIIh7QbnfMJJyUS7WMBfdU7Q/ISH9vq
         3TBaZNY1my83lDnQmCXtumYxFTgyZzaRT4CzQybfeWn0iqt1dv2bLXoB3gElf0K6Qxaj
         CzYfIbUkqE5FNpEuT10ylV2VorybyDlyOzjN6n6C4O8Vy7RcFlpOg2sKZA/runJ9vIVL
         7Cpz4pmDDo3n3YqbxHRt6DAigR9G8EjpExwlmnwnb/j7kTru/8wrv/sMNHUm62vVJG0V
         fvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773828067; x=1774432867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4qZe0+PX9efFctzFLR678BcWWeiXKEHS5jhgninu1g=;
        b=lqXanugoFn6Aqna+G3ae7J1b3PxVOM0/xSalPENlPkt4zMSZW7yBIpOubq3HqVfw3Z
         37+W3FLR2xjBgfczycOCqtsdWhwhWUNpQsKzLGb6+MPfKVECoHwj+/XVVTghzHU7sE+m
         0JdVfPZ1mvGhDmNiDIUmdy7v1JEu1ksweCz2nIme5Etsmx70jgIo0PH6fLQO9l5OfYfY
         TeRs6AI+1Q1fezHG1UWbPAvQ2anXJfPTdxPm1uo6MW1d6pup5b7eR8OPxlb/tavmfQCP
         ZGEPGvNer1rGybp/2WPNJYoxKWWbBpp4IujYkqNgAB3YN6n+04G0NzKP7QMu70SzTSF/
         9KVg==
X-Forwarded-Encrypted: i=1; AJvYcCVMrdV2g3me85s9yexALcXmnmXHZEhJ1X3lDQJVCKRZy1fKQjjTdgBhBVPRlvR6a0V1MIh8Ow==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNnCRVFz4rHNo9Mnv/wiEiDn32QZD0syisOOHZfzxNR3Zlynr4
	Dx7TfVKN9JZxqo1vSaLO2C69xYABmWMhAd7RdkclECDx7YXw3Af6UiXvPOlPSEZHRw==
X-Gm-Gg: ATEYQzz6AlEFodGM5o4m/Ef6c0Rkn0uGNd53A4ft9UOgtZy4ib3fsuQQmvHfRreTC2b
	T2rRdfUFi7AEysfuOEocLvyfGIqGA0ucIncxVyJEJZaMv+fR3iVYpr1TBrvQPI2lDgyHewjraET
	k/LF5FtzChDCzJ7woX1KjCpwr+DMHS0cz8tRFpt+5Nr/nitWdHyX9+juyB1vtHeP0rOKsobRMx3
	uRFcBaqR2zVfIi+oxto4Kf6DPV7LtOcgCaj2xu+LRVywDqGnkSQMiYGMLGRfoc+B3z9FQ1X2H37
	6+QVhKv/O4/PmCu+0j6B+mm9ApgG2xBQMoCr9Fj0ScboQJyw9Z2eJGWwXHx0vcFqbOZ7q8wKpOE
	dbLrvqGk9vRGYVqTSPsCCbIcNjqpgcZslMuPTK0y2oVwRtKQzefBNMb89jhmdRf61Dbjo0SUdbe
	DBb1YLfkinWnJmRqJx15Xx4Cujt3MQIW+I60vFpj2GED+UhyXVPjc9ehtTaw==
X-Received: by 2002:a17:902:cccf:b0:2b0:4613:2e35 with SMTP id d9443c01a7336-2b06e6e6b53mr2897865ad.0.1773828066650;
        Wed, 18 Mar 2026 03:01:06 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bba509b1esm2184209a91.8.2026.03.18.03.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 03:01:06 -0700 (PDT)
Date: Wed, 18 Mar 2026 10:00:57 +0000
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
Subject: Re: [PATCH 03/14] liveupdate: luo_file: Add internal APIs for file
 preservation
Message-ID: <abp32cJgCUEWK6u-@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-4-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-4-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:37PM +0000, Samiullah Khawaja wrote:
> From: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> The core liveupdate mechanism allows userspace to preserve file
> descriptors. However, kernel subsystems often manage struct file
> objects directly and need to participate in the preservation process
> programmatically without relying solely on userspace interaction.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/liveupdate.h       | 21 ++++++++++
>  kernel/liveupdate/luo_file.c     | 71 ++++++++++++++++++++++++++++++++
>  kernel/liveupdate/luo_internal.h | 16 +++++++
>  3 files changed, 108 insertions(+)
> 
> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> index fe82a6c3005f..8e47504ba01e 100644
> --- a/include/linux/liveupdate.h
> +++ b/include/linux/liveupdate.h
> @@ -23,6 +23,7 @@ struct file;
>  /**
>   * struct liveupdate_file_op_args - Arguments for file operation callbacks.
>   * @handler:          The file handler being called.
> + * @session:          The session this file belongs to.
>   * @retrieved:        The retrieve status for the 'can_finish / finish'
>   *                    operation.
>   * @file:             The file object. For retrieve: [OUT] The callback sets
> @@ -40,6 +41,7 @@ struct file;
>   */
>  struct liveupdate_file_op_args {
>  	struct liveupdate_file_handler *handler;
> +	struct liveupdate_session *session;
>  	bool retrieved;

Nit: I don't think this is on the latest tree. I see `int retrieved` [1]
in the latest tree. I guess we'd need to rebase it on the latest?

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/linux/liveupdate.h#n46

>  	struct file *file;
>  	u64 serialized_data;
> @@ -234,6 +236,13 @@ int liveupdate_unregister_flb(struct liveupdate_file_handler *fh,
>  
>  int liveupdate_flb_get_incoming(struct liveupdate_flb *flb, void **objp);
>  int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb, void **objp);
> +/* kernel can internally retrieve files */
> +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
> +				 struct file **filep);
> +
> +/* Get a token for an outgoing file, or -ENOENT if file is not preserved */
> +int liveupdate_get_token_outgoing(struct liveupdate_session *s,
> +				  struct file *file, u64 *tokenp);
>  
>  #else /* CONFIG_LIVEUPDATE */
>  
> @@ -281,5 +290,17 @@ static inline int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb,
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int liveupdate_get_file_incoming(struct liveupdate_session *s,
> +					       u64 token, struct file **filep)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int liveupdate_get_token_outgoing(struct liveupdate_session *s,
> +						struct file *file, u64 *tokenp)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif /* CONFIG_LIVEUPDATE */
>  #endif /* _LINUX_LIVEUPDATE_H */
> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index 32759e846bc9..7ac591542059 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
> @@ -302,6 +302,7 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
>  	mutex_init(&luo_file->mutex);
>  
>  	args.handler = fh;
> +	args.session = luo_session_from_file_set(file_set);
>  	args.file = file;
>  	err = fh->ops->preserve(&args);
>  	if (err)
> @@ -355,6 +356,7 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
>  					   struct luo_file, list);
>  
>  		args.handler = luo_file->fh;
> +		args.session = luo_session_from_file_set(file_set);
>  		args.file = luo_file->file;
>  		args.serialized_data = luo_file->serialized_data;
>  		args.private_data = luo_file->private_data;
> @@ -383,6 +385,7 @@ static int luo_file_freeze_one(struct luo_file_set *file_set,
>  		struct liveupdate_file_op_args args = {0};
>  
>  		args.handler = luo_file->fh;
> +		args.session = luo_session_from_file_set(file_set);
>  		args.file = luo_file->file;
>  		args.serialized_data = luo_file->serialized_data;
>  		args.private_data = luo_file->private_data;
> @@ -404,6 +407,7 @@ static void luo_file_unfreeze_one(struct luo_file_set *file_set,
>  		struct liveupdate_file_op_args args = {0};
>  
>  		args.handler = luo_file->fh;
> +		args.session = luo_session_from_file_set(file_set);
>  		args.file = luo_file->file;
>  		args.serialized_data = luo_file->serialized_data;
>  		args.private_data = luo_file->private_data;
> @@ -590,6 +594,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
>  	}
>  
>  	args.handler = luo_file->fh;
> +	args.session = luo_session_from_file_set(file_set);
>  	args.serialized_data = luo_file->serialized_data;
>  	err = luo_file->fh->ops->retrieve(&args);
>  	if (!err) {
> @@ -615,6 +620,7 @@ static int luo_file_can_finish_one(struct luo_file_set *file_set,
>  		struct liveupdate_file_op_args args = {0};
>  
>  		args.handler = luo_file->fh;
> +		args.session = luo_session_from_file_set(file_set);
>  		args.file = luo_file->file;
>  		args.serialized_data = luo_file->serialized_data;
>  		args.retrieved = luo_file->retrieved;
> @@ -632,6 +638,7 @@ static void luo_file_finish_one(struct luo_file_set *file_set,
>  	guard(mutex)(&luo_file->mutex);
>  
>  	args.handler = luo_file->fh;
> +	args.session = luo_session_from_file_set(file_set);
>  	args.file = luo_file->file;
>  	args.serialized_data = luo_file->serialized_data;
>  	args.retrieved = luo_file->retrieved;
> @@ -919,3 +926,67 @@ int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
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
> + * Context: Can be called from any context that can acquire the session mutex.
> + * Return: 0 on success, -ENOENT if the file is not preserved in this session.
> + */
> +int liveupdate_get_token_outgoing(struct liveupdate_session *s,
> +				  struct file *file, u64 *tokenp)
> +{
> +	struct luo_file_set *file_set = luo_file_set_from_session(s);
> +	struct luo_file *luo_file;
> +	int err = -ENOENT;
> +
> +	list_for_each_entry(luo_file, &file_set->files_list, list) {

Shouldn't we hold a lock while traversing the file_set? Couldn't this
race with an unpreserve? If a concurrent unpreserve (writer) calls 
list_del while this reader is mid-iteration, we'll likely follow a stale
pointer..

I noticed that luo_preserve_file / upreserve and retrieve also don't
take locks while manipulating / iterating  over file_set->files_list..

Shouldn't we protect these with a lock? Otherwise, how do we avoid
races in situations like:

1. CPU 0 (reader) is iterating the list A->B->C ..
2. CPU 1 (writer) is handling an unpreserve which remove file B

Am I missing something? If we're expecting the callers to hold a lock,
we should have a lockdep_assert in these functions..

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
> + * The operation is idempotent; subsequent calls for the same token will return
> + * a pointer to the same 'struct file' object.
> + *
> + * The caller receives a new reference to the file and must call fput() when it
> + * is no longer needed. The file's lifetime is managed by LUO and any userspace
> + * file descriptors. If the caller needs to hold a reference to the file beyond
> + * the immediate scope, it must call get_file() itself.
> + *

I'm little confused here, we say the op is idempotent, but also mention
that the caller receives a new reference. I'm wondering of a situation 
where a driver calls this multiple times, incrementing the refcount with
each call. Do we rely on flb_file_finish to drop all the refcounts?

We should clarify the lifecycle requirements here: is the driver 
expected to call fput() for every single call to 
liveupdate_get_file_incoming(), or is the flb_finish callback intended
to be a 'catch-all' that reaps these? 

> + * Context: Can be called from any context in the new kernel that has a handle
> + *          to a restored session.
> + * Return: 0 on success. Returns -ENOENT if no file with the matching token is
> + *         found, or any other negative errno on failure.
> + */
> +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
> +				 struct file **filep)
> +{
> +	return luo_retrieve_file(luo_file_set_from_session(s), token, filep);
> +}
> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
> index 8083d8739b09..a24933d24fd9 100644
> --- a/kernel/liveupdate/luo_internal.h
> +++ b/kernel/liveupdate/luo_internal.h
> @@ -77,6 +77,22 @@ struct luo_session {
>  	struct mutex mutex;
>  };
>  
> +static inline struct liveupdate_session *luo_session_from_file_set(struct luo_file_set *file_set)
> +{
> +	struct luo_session *session;
> +
> +	session = container_of(file_set, struct luo_session, file_set);
> +
> +	return (struct liveupdate_session *)session;
> +}
> +
> +static inline struct luo_file_set *luo_file_set_from_session(struct liveupdate_session *s)
> +{
> +	struct luo_session *session = (struct luo_session *)s;
> +
> +	return &session->file_set;
> +}
> +
>  int luo_session_create(const char *name, struct file **filep);
>  int luo_session_retrieve(const char *name, struct file **filep);
>  int __init luo_session_setup_outgoing(void *fdt);
> -- 
>

Thanks,
Praan
