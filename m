Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41379392837
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131288; cv=none; b=VIuT2//aH4O8ulVm8mOKCH7ta/hptSlh1nzQla6yeg5nvDZro5MJmJqVA/2UVgNG9IrACUQlkC9Q15clX4gQauU/91gczTLFOmBRsGakbTynygszSL9U7/EJGRvuuK6LUVjioOJqK7RBGk6oGIkLUN/e2gFSQPIanFZKGQNNzIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131288; c=relaxed/simple;
	bh=E3Kryer03O2/9Oyd1Uw9KKyE+KASGqSz2vSPV4e+764=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVBs+B5uPf66bx8g6q9EposQ/Cw660Y1G5k+kfdB9D/n56dXC29W3ydTFD/KWEwBcE7J/pB8cM6yjBi7w3mR/rWbuV4W0XmSpA4NOCgjbyBXcP8/Wq/af7jMkPcOSVC6iLScviplymFRDNDCd2+1sywGlZ6jEsOxwvNZqgZmgV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ve+30HHm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ve+30HHm"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso1165ad.0
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779131286; x=1779736086; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZU0H6rmWmp4oi8XbArQtxOYDJ2GP70DX/0QfuCGiOE=;
        b=ve+30HHmoY5w+cNTtVov1iKjDVoILNHZ4GlGneD0qzHBbd6CEpE0aZcB3VPrr5kVtw
         UORCQ+hpDmnAq0CALERYbzX4fZB9YFG0ROXFuRvAumMnO5b5gTrrR/pve79fj2Vuli+p
         Y1Gqm/RBJ7Yy29TYzGqwVMIqGjT5Amo4mbM7L3dHszEaWrWK7NO5z9tQB92LMugI/FDS
         3xq7eel4MJ0nZXdF082BUBLg0TwGi/nhYzCs7eEXbuZDmGjukInkkrRBWh/u0rEdJ1An
         4avQRAmknBzv8Y9T4HMtEy7p/WQ5jUi95NWbIhPc3oHJAXPuNuaW4qDbZGdqWwcbSP2y
         03Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131286; x=1779736086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZU0H6rmWmp4oi8XbArQtxOYDJ2GP70DX/0QfuCGiOE=;
        b=Nhdm3d42wRB3N2qkoRHuX/WS54TEvm9cUIsdT04oYnSHh7J8uRhEIENUmJgAlzXBu4
         l/UkoNmDml8st8s7+TUvhHX56D4qxRyBt/wdYeiGtULhghbD8q0hmQ+Sa+tHuY82Zwp+
         l68hUxvnHMM54t2yVN8hXwc6bKvXTlw9XNk7ejVrN8HXzu8VZgJENceW6MP3xJu+gP+C
         8QIS4NVBYCGF2gOlY/TiJNVgKZ8KSJcljlke8DAAUPIWYJHlI2q+jrER/s3WNBgAc24m
         S710JzipVhoznfL+JbWLS0ldfJRZP7GkL5XX4G0rcXl5y5udHak0t3yfaXhVgMNUqPmU
         kjiA==
X-Forwarded-Encrypted: i=1; AFNElJ96EMzMY/nIGnmjBjIgvu2SfxGpMWjbJ9/yMJSCje4wE3+pcuFukNwI29ofI1wcqS4tVn05eg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyrb0OKAm4cOzpyIwuEA9g/BZcum6V6wt43EqSPP/fEcRXuNWhu
	iJuFd97fn8Hlc9AhlnLwm76AeCy5C0sW5ejDmAq/0go07ucA3nTX1F8iMftP/ciWsw==
X-Gm-Gg: Acq92OFpF3BIwnBK8pAGmXfuQPOEJcnVLuPtwBT76M7u/Y3/8i2Lj6uQU1ZWNl/YbaA
	U+DPN2V+F6X0fzgKj7Yldj9LJh3Mc+Zc2fvmCnq3P7BNKfjmvSOwzD4302kNm+dTwkf2WodGyaR
	5seRgQTE9Zime1w24QmxT+KSHapeBSdFQ3cImK841ix6zhU4Po63VmA6X29Hnkbkg+Xd3RSG1NZ
	CMtXtNiRzfJ1+TVuADurUS5CmcuCF0SdSKUPBS3x5qEauSdSpRV5tklq2OxxBcM5bQudYDdqhHB
	EHyRCO7mnlGjQGPfHX/p3pSn94dK+TslQMcU1knppaiEIMh204NEWu5jvSYaxAYjvcvxG/69Val
	NQro9IDv/mbTkmbw/GeSzMzpmEkngJ93f/96ANQm0DcXxiM2g/4s2vYtZhumK7sPVM2g/KsULKK
	CDnPP+K2sc+HdAhNKZJBXfr9HqzwJZLdphoaCApukO1VDlyl+mNP38ihZ1YJmLOrQuaf6eGw==
X-Received: by 2002:a17:903:46ce:b0:2bd:9e75:9e98 with SMTP id d9443c01a7336-2bdb329b484mr3857735ad.9.1779131285670;
        Mon, 18 May 2026 12:08:05 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb07b007sm14148605a12.11.2026.05.18.12.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:08:05 -0700 (PDT)
Date: Mon, 18 May 2026 19:08:01 +0000
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
Subject: Re: [PATCH v2 01/16] liveupdate: luo_file: Add internal APIs for
 file preservation
Message-ID: <agth8vZh96TfEYl_@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-2-skhawaja@google.com>
 <agr6yoyYYq2QFxjL@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agr6yoyYYq2QFxjL@google.com>

On Mon, May 18, 2026 at 11:40:58AM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:18PM +0000, Samiullah Khawaja wrote:
>> From: Pasha Tatashin <pasha.tatashin@soleen.com>
>>
>> The core liveupdate mechanism allows userspace to preserve file
>> descriptors. However, kernel subsystems often manage struct file
>> objects directly and need to participate in the preservation process
>> programmatically without relying solely on userspace interaction.
>>
>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>
>[..]
>
>> @@ -924,3 +931,65 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
>>  	luo_flb_unregister_all(fh);
>>  	list_del(&ACCESS_PRIVATE(fh, list));
>>  }
>> +EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
>> +

[snip]
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
>> + * The caller receives a new reference to the file and must call fput() when it
>> + * is no longer needed. The file's lifetime is managed by LUO and any userspace
>> + * file descriptors. If the caller needs to hold a reference to the file beyond
>> + * the immediate scope, it must call get_file() itself.
>
>Thanks for re-wording this and I'm sorry for being a stickler here, I'm
>a bit concerned that the last part here might lead to reference leaks in
>downstream drivers.
>
>Looking at the underlying luo_retrieve_file() implementation [1], it
>explicitly calls get_file() before returning the pointer (both on the
>initial retrieve and on cached ones). This means the caller inherently
>receives a reference that they own & the caller is responsible for
>exactly one fput().
>
>However, that last part of the comment can be misunderstood as the caller
>doesn't hold a lasting reference unless they call get_file() themselves.
>This makes the reader assume that LUO is going to automatically reap
>that initial reference from them.
>
>If a driver author assumes LUO is going to reap it, they will follow that
>last sentence and call get_file() to stash the pointer safely. They might
>end up holding two references (thinking one of them will be reaped), and
>could ultimately leak the struct file when they only call fput() once
>during teardown.
>
>Should we just drop that last sentence to make the lifecycle contract
>unambiguous? (i.e., The caller gets a newly bumped reference, and they
>are responsible for exactly one fput() per call).

I think these are all valid points. I will remove the last sentences for
clarity.
>
>> + *
>> + * Context: It must be called with session mutex acquired of a restored session.
>> + * Return: 0 on success. Returns -ENOENT if no file with the matching token is
>> + *         found, or any other negative errno on failure.
>> + */
>> +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
>> +				 struct file **filep)
>> +{
>> +	return luo_retrieve_file(luo_file_set_from_session_locked(s),
>> +				 token, filep);
>> +}
>
>Nit: Shouldn't we export both of these functions via EXPORT_SYMBOL_GPL?
>Since, these new APIs are intended for kernel subsystems to participate
>programmatically, there could be IOMMU drivers (or others) that can be
>compiled as loadable modules. Thus we should export these APIs via
>EXPORT_SYMBOL_GPL(). If they aren't exported, any loadable module
>attempting to use them will compile successfully (due to the header), but
>will fail to load at runtime with an Unknown symbol error.
>
>IIUC, if a function isn't exported with EXPORT_SYMBOL, it remains hidden
>inside vmlinux, (i.e. it isn't in the kernel's global symbol table used
>during modprobe).

Agreed. Will Update this.

I think there are other LUO APIs that are not exported and can be used
by modules. Let me check those also.
>
>Thanks,
>Praan
>
>[1] https://elixir.bootlin.com/linux/v7.0-rc3/source/kernel/liveupdate/luo_file.c#L560
>
