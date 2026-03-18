Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAEB1D6193
	for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852866; cv=none; b=PBSpDzVW2N80VgGk+PlWILWghIUix3FNeAOWITGXUpB/UW5rMrWMivEoryKVJNbMEuuQyj8EmKyZLpstqOPCxso/zvkYCHfdLUZGlgUIxv9hQiTllJTQ5bbef+lqXAOggpfwj3roi4p5iSNwi6eW3KAdoO096n5uHkDX38Hb84w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852866; c=relaxed/simple;
	bh=5VBV/A5uYC0jGc3viP6Xi9yTNYCk7D9ZKDvsyPHOlcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZG0UpVhBCuRRfZC+bZzgL5If62vTK3/+6On03SbHscMiMNj9JXwKoXh5wLIxELcH6TUyV3oVcK+qZh8swtArqNiBLvndXKojRB8I/lP6jD+pUWy3a3YvwzNrkNmjeOZQDG7FrlUMRqu/cn6YliiKLKnXELFdL3TKdw2Ah9iEzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tqqXsV/4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tqqXsV/4"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so1305ad.0
        for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 09:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773852865; x=1774457665; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3JEhMqYUt8uX7RNOVC4nIPLjZyTL3AlX18iCN9fMlH8=;
        b=tqqXsV/4gZUVVFHh350xfTDtX+g4q0y89v/uTympMAfC/ZXJe5ehcxdnsv59tqbbSe
         +YgHrCZhHxku58k1XSVfG2KBzxksZyFmcFfgK7bjFpLiahjyuN3FT4zx344/qDjfwxrq
         urY9pMkAo0hG5dEzawxVXtnQ7OWFnJGJ09VBOoqTkbvMQhnMoZOAv7PxTCOOnRfGT1bq
         yaHqXG0kCff8sMHgFsLrUBrr9l6zb9XGl2GMGOGmeU/+zej4N4CXsnVKFcSTceHvgOVw
         XAabQd+kNQjz5dFjBY0jAITX6rCYp3ihhrqiuTXEje0E9vQTwcoAOSR6DrE+Tl1yiCmr
         qGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773852865; x=1774457665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JEhMqYUt8uX7RNOVC4nIPLjZyTL3AlX18iCN9fMlH8=;
        b=XaXu5Cs2CoxfuH4aHjAfDKc0EnJF8pmWGBjWxnpthhB4RON2QhPn9i12nHukCHU9Bp
         gyEGGbWAJLBDUHvfAVlo8QnU2xBz/kRXYFfQijDiNCwgVZgQimEIAyd/HZ+F6WofjrsK
         8CAJLT6H4+Q82V+Lfnw+9ztFjOrve3JP+x2idDUqxMRgYaVk48M/ojA4NdJHtdCU+T+b
         D8IU2qNL2NgIFZnETvpIsP6cHyYI6jlHa7B2Sku/UrGZthsNMhIfQ+FTa1mOO9qq5hlg
         cm9gv1MyZrkWlO28P6ggBVl8YFiyOfQ63PhWEG46sh4R+LDocmy6IDnJVA2Lj5PnuDCL
         jWWg==
X-Forwarded-Encrypted: i=1; AJvYcCUjhjJCBA0voVb4IBFSwgmChX0GGYwc81r5CiM1BF3gjtFE69HWIn//qneX7FcMIeqvQYn5rw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyFyGXjDvqHzsMTM1lZc/Ki6NT3rZ3DYWc43l3pYBXF3Gc9DCR
	VvBJAZZBxj/vbyR9OyyeSl2sSmxeJD2DVjJuSlUw/l/gPlLXEYEM3ymdlbEy0OiDWg==
X-Gm-Gg: ATEYQzzqeZ9pA36WzVqLuh5HtN6A+eEHdU3uN77aKkGOAju1kq6iC7jiJywWwtqH70l
	ZXwu5zDr0HGfnYXO0ISEP7B2OgC3M2T7THIyo0QikXdp/Rchnqt1UIa7tU/wyBwVrjMdXuGhHXc
	r64uo2XetASA4EY8tZgA53mUlrw4fCbsysnatOH+0xqFY5KOsD4wg7Ud8TozAJKhZb/+memhbek
	/KoAxIRoWiEIie9VJKm4CRJuug/SetuZIHrfIOqF+YiIVyMXc1qOYRJNdZSR0kIsMLbEzJTp6K8
	WTpwE/MB9JRP0aANHhrM+NbuTDA/PKreyxSWExjPWqXzPGZt9h88k/TgtPs8YEFrjgKYLDg/KHw
	EbHF4orEyP5hcKpOsEBFfQwFIncS51gExHA9joEUlzhGFiNczke4eGe7vHRGARzXwffE6LRHo1F
	SKtpgkOp9r6QKEoVHnkimAJM8/WhLAU/LDTkQZTPlOKqh/I9fjj+eD95IIJ0YcRQ==
X-Received: by 2002:a17:903:1a06:b0:2a8:ffed:4663 with SMTP id d9443c01a7336-2b06e871446mr3657205ad.12.1773852863842;
        Wed, 18 Mar 2026 09:54:23 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e603937sm33038865ad.57.2026.03.18.09.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:54:23 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:54:19 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 03/14] liveupdate: luo_file: Add internal APIs for file
 preservation
Message-ID: <abrUcJ__lv0N_fvp@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-4-skhawaja@google.com>
 <abp32cJgCUEWK6u-@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <abp32cJgCUEWK6u-@google.com>

On Wed, Mar 18, 2026 at 10:00:57AM +0000, Pranjal Shrivastava wrote:
>On Tue, Feb 03, 2026 at 10:09:37PM +0000, Samiullah Khawaja wrote:
>> From: Pasha Tatashin <pasha.tatashin@soleen.com>
>>
>> The core liveupdate mechanism allows userspace to preserve file
>> descriptors. However, kernel subsystems often manage struct file
>> objects directly and need to participate in the preservation process
>> programmatically without relying solely on userspace interaction.
>>
>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> ---
>>  include/linux/liveupdate.h       | 21 ++++++++++
>>  kernel/liveupdate/luo_file.c     | 71 ++++++++++++++++++++++++++++++++
>>  kernel/liveupdate/luo_internal.h | 16 +++++++
>>  3 files changed, 108 insertions(+)
>>
>> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
>> index fe82a6c3005f..8e47504ba01e 100644
>> --- a/include/linux/liveupdate.h
>> +++ b/include/linux/liveupdate.h
>> @@ -23,6 +23,7 @@ struct file;
>>  /**
>>   * struct liveupdate_file_op_args - Arguments for file operation callbacks.
>>   * @handler:          The file handler being called.
>> + * @session:          The session this file belongs to.
>>   * @retrieved:        The retrieve status for the 'can_finish / finish'
>>   *                    operation.
>>   * @file:             The file object. For retrieve: [OUT] The callback sets
>> @@ -40,6 +41,7 @@ struct file;
>>   */
>>  struct liveupdate_file_op_args {
>>  	struct liveupdate_file_handler *handler;
>> +	struct liveupdate_session *session;
>>  	bool retrieved;
>
>Nit: I don't think this is on the latest tree. I see `int retrieved` [1]
>in the latest tree. I guess we'd need to rebase it on the latest?

Will rebase this.
>
>https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/linux/liveupdate.h#n46
>
>>  	struct file *file;
>>  	u64 serialized_data;
>> @@ -234,6 +236,13 @@ int liveupdate_unregister_flb(struct liveupdate_file_handler *fh,
>>
>>  int liveupdate_flb_get_incoming(struct liveupdate_flb *flb, void **objp);
>>  int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb, void **objp);
>> +/* kernel can internally retrieve files */
>> +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
>> +				 struct file **filep);
>> +
>> +/* Get a token for an outgoing file, or -ENOENT if file is not preserved */
>> +int liveupdate_get_token_outgoing(struct liveupdate_session *s,
>> +				  struct file *file, u64 *tokenp);
>>
>>  #else /* CONFIG_LIVEUPDATE */
>>
>> @@ -281,5 +290,17 @@ static inline int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb,
>>  	return -EOPNOTSUPP;
>>  }
>>
>> +static inline int liveupdate_get_file_incoming(struct liveupdate_session *s,
>> +					       u64 token, struct file **filep)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static inline int liveupdate_get_token_outgoing(struct liveupdate_session *s,
>> +						struct file *file, u64 *tokenp)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>>  #endif /* CONFIG_LIVEUPDATE */
>>  #endif /* _LINUX_LIVEUPDATE_H */
>> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
>> index 32759e846bc9..7ac591542059 100644
>> --- a/kernel/liveupdate/luo_file.c
>> +++ b/kernel/liveupdate/luo_file.c
>> @@ -302,6 +302,7 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
>>  	mutex_init(&luo_file->mutex);
>>
>>  	args.handler = fh;
>> +	args.session = luo_session_from_file_set(file_set);
>>  	args.file = file;
>>  	err = fh->ops->preserve(&args);
>>  	if (err)
>> @@ -355,6 +356,7 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
>>  					   struct luo_file, list);
>>
>>  		args.handler = luo_file->fh;
>> +		args.session = luo_session_from_file_set(file_set);
>>  		args.file = luo_file->file;
>>  		args.serialized_data = luo_file->serialized_data;
>>  		args.private_data = luo_file->private_data;
>> @@ -383,6 +385,7 @@ static int luo_file_freeze_one(struct luo_file_set *file_set,
>>  		struct liveupdate_file_op_args args = {0};
>>
>>  		args.handler = luo_file->fh;
>> +		args.session = luo_session_from_file_set(file_set);
>>  		args.file = luo_file->file;
>>  		args.serialized_data = luo_file->serialized_data;
>>  		args.private_data = luo_file->private_data;
>> @@ -404,6 +407,7 @@ static void luo_file_unfreeze_one(struct luo_file_set *file_set,
>>  		struct liveupdate_file_op_args args = {0};
>>
>>  		args.handler = luo_file->fh;
>> +		args.session = luo_session_from_file_set(file_set);
>>  		args.file = luo_file->file;
>>  		args.serialized_data = luo_file->serialized_data;
>>  		args.private_data = luo_file->private_data;
>> @@ -590,6 +594,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
>>  	}
>>
>>  	args.handler = luo_file->fh;
>> +	args.session = luo_session_from_file_set(file_set);
>>  	args.serialized_data = luo_file->serialized_data;
>>  	err = luo_file->fh->ops->retrieve(&args);
>>  	if (!err) {
>> @@ -615,6 +620,7 @@ static int luo_file_can_finish_one(struct luo_file_set *file_set,
>>  		struct liveupdate_file_op_args args = {0};
>>
>>  		args.handler = luo_file->fh;
>> +		args.session = luo_session_from_file_set(file_set);
>>  		args.file = luo_file->file;
>>  		args.serialized_data = luo_file->serialized_data;
>>  		args.retrieved = luo_file->retrieved;
>> @@ -632,6 +638,7 @@ static void luo_file_finish_one(struct luo_file_set *file_set,
>>  	guard(mutex)(&luo_file->mutex);
>>
>>  	args.handler = luo_file->fh;
>> +	args.session = luo_session_from_file_set(file_set);
>>  	args.file = luo_file->file;
>>  	args.serialized_data = luo_file->serialized_data;
>>  	args.retrieved = luo_file->retrieved;
>> @@ -919,3 +926,67 @@ int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
>>  	return err;
>>  }
>>  EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
>> +
>> +/**
>> + * liveupdate_get_token_outgoing - Get the token for a preserved file.
>> + * @s:      The outgoing liveupdate session.
>> + * @file:   The file object to search for.
>> + * @tokenp: Output parameter for the found token.
>> + *
>> + * Searches the list of preserved files in an outgoing session for a matching
>> + * file object. If found, the corresponding user-provided token is returned.
>> + *
>> + * This function is intended for in-kernel callers that need to correlate a
>> + * file with its liveupdate token.
>> + *
>> + * Context: Can be called from any context that can acquire the session mutex.

I will reword this to convey that the session mutex should be acquired.
>> + * Return: 0 on success, -ENOENT if the file is not preserved in this session.
>> + */
>> +int liveupdate_get_token_outgoing(struct liveupdate_session *s,
>> +				  struct file *file, u64 *tokenp)
>> +{
>> +	struct luo_file_set *file_set = luo_file_set_from_session(s);
>> +	struct luo_file *luo_file;
>> +	int err = -ENOENT;
>> +
>> +	list_for_each_entry(luo_file, &file_set->files_list, list) {
>
>Shouldn't we hold a lock while traversing the file_set? Couldn't this
>race with an unpreserve? If a concurrent unpreserve (writer) calls
>list_del while this reader is mid-iteration, we'll likely follow a stale
>pointer..

The session mutex is supposed to be acquired when this function is
called. I will add a lockdep in this function to enforce that.

Also, we call this in preserve() of vfio-cdev and the session mutex is
already acquired by luo in that context.
>
>I noticed that luo_preserve_file / upreserve and retrieve also don't
>take locks while manipulating / iterating  over file_set->files_list..
>
>Shouldn't we protect these with a lock? Otherwise, how do we avoid
>races in situations like:
>
>1. CPU 0 (reader) is iterating the list A->B->C ..
>2. CPU 1 (writer) is handling an unpreserve which remove file B
>
>Am I missing something? If we're expecting the callers to hold a lock,
>we should have a lockdep_assert in these functions..

The LUO acquires session mutex before calling preserve/unpreserve to
protect agains race conditions. See luo_session.c for details.
>
>> +		if (luo_file->file == file) {
>> +			if (tokenp)
>> +				*tokenp = luo_file->token;
>> +			err = 0;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +/**
>> + * liveupdate_get_file_incoming - Retrieves a preserved file for in-kernel use.
>> + * @s:      The incoming liveupdate session (restored from the previous kernel).
>> + * @token:  The unique token identifying the file to retrieve.
>> + * @filep:  On success, this will be populated with a pointer to the retrieved
>> + *          'struct file'.
>> + *
>> + * Provides a kernel-internal API for other subsystems to retrieve their
>> + * preserved files after a live update. This function is a simple wrapper
>> + * around luo_retrieve_file(), allowing callers to find a file by its token.
>> + *
>> + * The operation is idempotent; subsequent calls for the same token will return
>> + * a pointer to the same 'struct file' object.
>> + *
>> + * The caller receives a new reference to the file and must call fput() when it
>> + * is no longer needed. The file's lifetime is managed by LUO and any userspace
>> + * file descriptors. If the caller needs to hold a reference to the file beyond
>> + * the immediate scope, it must call get_file() itself.
>> + *
>
>I'm little confused here, we say the op is idempotent, but also mention
>that the caller receives a new reference. I'm wondering of a situation
>where a driver calls this multiple times, incrementing the refcount with
>each call. Do we rely on flb_file_finish to drop all the refcounts?
>
>We should clarify the lifecycle requirements here: is the driver
>expected to call fput() for every single call to
>liveupdate_get_file_incoming(), or is the flb_finish callback intended
>to be a 'catch-all' that reaps these?

The user is supposed to call fput to release the reference as mentioned
in the kernel-doc above.

But I agree it is a little confusing with the idempotent. I will reword
the text.
>
>> + * Context: Can be called from any context in the new kernel that has a handle
>> + *          to a restored session.
>> + * Return: 0 on success. Returns -ENOENT if no file with the matching token is
>> + *         found, or any other negative errno on failure.
>> + */
>> +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
>> +				 struct file **filep)
>> +{
>> +	return luo_retrieve_file(luo_file_set_from_session(s), token, filep);
>> +}
>> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
>> index 8083d8739b09..a24933d24fd9 100644
>> --- a/kernel/liveupdate/luo_internal.h
>> +++ b/kernel/liveupdate/luo_internal.h
>> @@ -77,6 +77,22 @@ struct luo_session {
>>  	struct mutex mutex;
>>  };
>>
>> +static inline struct liveupdate_session *luo_session_from_file_set(struct luo_file_set *file_set)
>> +{
>> +	struct luo_session *session;
>> +
>> +	session = container_of(file_set, struct luo_session, file_set);
>> +
>> +	return (struct liveupdate_session *)session;
>> +}
>> +
>> +static inline struct luo_file_set *luo_file_set_from_session(struct liveupdate_session *s)
>> +{
>> +	struct luo_session *session = (struct luo_session *)s;
>> +
>> +	return &session->file_set;
>> +}
>> +
>>  int luo_session_create(const char *name, struct file **filep);
>>  int luo_session_retrieve(const char *name, struct file **filep);
>>  int __init luo_session_setup_outgoing(void *fdt);
>> --
>>
>
>Thanks,
>Praan
