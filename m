Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218843;
	b=aRaGd5F2KtS9oC5S4IdDO9amT/HuEGAddl+hS9d32hPIlv27BtGvcBpabXwoT1oYnsdU
	 ShQs3oZ7nQixrolNxzwTzjkMM7G7l7LC+hZ1Zt1f9oxUwpdUihSP/JwykkueRVlS2MB6T
	 2VSkBrFaoQm6lCkD5JqsyJ4//vgRQ/4mrpDGOhV1n/cHXaJJXvmMhj1W+mo2SbhRi2N+Z
	 3lBMjjuDncMf5UgjBVSYHWMp+vBd5CYWU4HLeyQCnuCZDM+HhN7VyaLwv4ztqbPKUOI1Z
	 ozN0syDksCWFgEu5nxKNYJTXcGTfE/Y/u90i96pRCN05qpD0InNfFWzgB/tGm/AHbEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=BCv0Nnsjb1CATtKd+NoK/9Eh7t2jtA8IE/DMvxos3og=;
	b=mjx6XHngkNYwtsZv0qGgOqNgka1y3arxdM+dT93lMrronU3s8hrgAlyQNJjYquxpxQUc
	 j3o1pArgzaYGmvXy/13AgLJ5hPpGFeGUXt7HRHrYi2AA2B/64UIPjnKmCAUN69Au1tHxO
	 YsMr+TwmJ3LsKzSGRsZTG06/j4Dx+cvcSi7/IQ+rPqYdio21m9aZ3MC9pS2xTpv11ezwj
	 TgNYkhW/GDBs0E9yIGjuDljj+WbyNEtm0U2xTzC+55JnYF52Jyh3JPYRB39GmGnLohM93
	 5x4qEasVdcoIwi8nwkjK0wOp0wR1w887T1i5uHcZo0YYLhPSaVzZdA5nL8wya99HWqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iceZCnk6;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C371D606D803
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 10:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C371D606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iceZCnk6
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so5546125e9.2
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 02:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794218841; x=1794823641; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BCv0Nnsjb1CATtKd+NoK/9Eh7t2jtA8IE/DMvxos3og=;
        b=iceZCnk66lK9ylJVC2qDP7oIUCtw8xlAL4Pmzi5siPuSOUPu9+YMNz5v7CgITB3PAx
         n46Rro8na4wNFvzXoJTOV59doedhDkHS6jTy2YavNRL68rwl9wDbtJ2jnvLoI4LrTBJr
         2lH5NyYxs5fzGT00RFFcHsQytpXH3AhiEHL5Qlmdmq/DB2CQKkNf04ENhZBaQkRmOieA
         1KPfqbXQgFoIazbwvbgkfcbPhwnf57HmxQlF78mmIu25592iSjumMPcQrclFt3ifA+6q
         0rCI5sanSSnmCMf/PLhDNr8+3wlPhpZcSbGlw1qgG/SfjeOIonLKk5jBHQw5zVN4QBG2
         6TnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794218841; x=1794823641;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BCv0Nnsjb1CATtKd+NoK/9Eh7t2jtA8IE/DMvxos3og=;
        b=aksQ4ORB6RiwJaWrTclPVDjAnsXmXGefm98Tay6XNN7AGIX410YpeBd42tVnpQcpLX
         XY9fpLgA9+xicQJU64E9TzTKMr+waTFVz2Am1VSAUpokCIWUdnN6ck8n8Fjln+3wOcxn
         1jkPUfNb55W6XKLGy2kD7hJIMDvZ7mVpPSWKcfzt3wGOk5QPwdF2lXiVyiMWK8VhOJNQ
         OFjHoGP4ZFSrBGRxEgBK6QWtNTTiJm5HKGVJGwKZjjcV/Z/Xvv1B2E8o0TfzExO/4vDE
         mlmx4P6qitML+dzKoF2mpb4p1k8QFz29LRC7TVhcewtKNJhjFB3iIYTTCqOl1Sy/nLuC
         Z/0Q==
X-Forwarded-Encrypted: i=1; AL+hErGIGbdGODsWTkp0GxvEJTdPT0Cq4J+G8IMJod2RYGLIOsowtT6c6xZZzjN0kDQMT/yeXCgWfQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+1NPsQPfFv4sYAIQMecD8wcgrcFuDD+T0e55MRtpHj83IjairA
	SFxj++fowSFemY5eDiZa5n/JPdXMTyP/sqSsSPl6kL0Dy5dvOM/YNw4o
X-Gm-Gg: AYBFou0Tc61Wl9zUis332t0raodN4vSDZYjelsTxdI3uJriE+nljJvgvlX+XtYjYkSo
	h5+RF/v1qUqWDU/qzZqSt+C/3rk297qb41Audn6pSWnVG+bRwkyB6f9/K6PtYm5w2P4SaQqsSVX
	v+MyKN4GKoprTYKiyiN5CFtSKNE3D/QAGzk9spq7KYQTcmKECqcFuhmdEA3Nny1ty5ciA91Chg0
	+jgMRtpnEQC1SoBlI9jweY+LHdId/7dXslnblRQQ2k2Oy9taXtHPIOSco6ffW0ocA6mVVzPRdqf
	TrDmyEWQvMFdRV7Vq8VxTnWGCsomkTNd3NDybZTfwYA9oUrljvC8veYF4NQDoVRN/OuEYkieq6B
	vjeiTdNlV44ySbsyiy4i77SPtyAPd/xzwZTwUdwInDH2chMc7WfstMq/PFBwihIuzdmnKxeYHVm
	85wcYmjMNJmh7AWg8P7K9ZdmMDuT3oK4YCF5KrfIFbLQMF8tH3+hRo52WeLrM6t8FK2OC8NMkBH
	OLltVoJ++7YV7xLluEIYaVZHJYXV9wQS+zJju2lTLvyaSujmjZgtD7uz9sxaKsSp/y30Wgg18l5
	+ElZcgLJBqHCU5vZAOBZYxo=
X-Received: by 2002:a05:600c:46cb:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4b94d762ec2mr69628225e9.1.1794218840912;
        Mon, 09 Nov 2026 02:07:20 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783f1d6sm8829668f8f.46.2026.11.09.02.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 02:07:20 -0800 (PST)
Message-ID: <bb6fa14e-0a98-4b31-899d-0b1c883d0608@gmail.com>
Date: Mon, 9 Nov 2026 11:07:17 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mm: limit pagecache folio refcount when splicing
 into pipes
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard
 <jhubbard@nvidia.com>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
 <20261107-refcount_overflow_stable-v2-2-c38f6809b106@kernel.org>
 <a9fb2d3c-d518-49d3-9479-a25fa2cfc5b3@gmail.com>
 <8d23b1eb-72aa-479d-9486-dbfd86d8414c@kernel.org>
 <43fc45ff-8636-4961-a80a-29844c15d7a1@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <43fc45ff-8636-4961-a80a-29844c15d7a1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/26 10:49 AM, David Hildenbrand (Arm) wrote:
> On 11/9/26 10:30, David Hildenbrand (Arm) wrote:
>> On 11/9/26 09:57, Jose A. Perez de Azpillaga wrote:
>>> On 11/7/26 11:23 PM, David Hildenbrand (Arm) wrote:
>>>> Similar to mapping pagecache folios into page tables, let's reject
>>>> additional references when splicing folios into a pipe if the refcount
>>>> is at its limit, similar to how we handle it during GUP.
>>>>
>>>> This will prevent more cases of possible folio refcount overflows with
>>>> large pagecache folios.
>>>>
>>>> Let's keep it simple and check in the two callers of
>>>> splice_folio_into_pipe(). Return -EOVERFLOW if the limit prevents any
>>>> progress, so do_splice_read() can fall back to copy_splice_read() when
>>>> read_iter is available. This keeps sendfile() and other splice users
>>>> working when ordinary reads would still succeed.
>>>>
>>>> Also fall back to copying in FUSE when taking another reference through
>>>> fuse_ref_folio() would exceed the limit.
>>>>
>>>> Also check in try_get_page() to cover pipe-buffer duplication by tee()
>>>> and partial pipe-to-pipe splicing.
>>>>
>>>> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>>>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>>>> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>>>> ---
>>>>  fs/fuse/dev.c      |  5 +++--
>>>>  fs/splice.c        |  8 +++++++-
>>>>  include/linux/mm.h |  9 ++++++---
>>>>  mm/filemap.c       | 11 ++++++++---
>>>>  mm/shmem.c         |  4 ++++
>>>>  5 files changed, 28 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>>>> index 3641abb90d6bb..4f6b7b42bfd3e 100644
>>>> --- a/fs/fuse/dev.c
>>>> +++ b/fs/fuse/dev.c
>>>> @@ -1265,9 +1265,10 @@ int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
>>>>  		if (cs->write && cs->pipebufs && folio) {
>>>>  			/*
>>>>  			 * Can't control lifetime of pipe buffers, so always
>>>> -			 * copy user pages.
>>>> +			 * copy user pages. Also copy folios at their refcount limit.
>>>>  			 */
>>>> -			if (cs->req->args->user_pages) {
>>>> +			if (cs->req->args->user_pages ||
>>>> +			    unlikely(folio_ref_count_over_limit(folio))) {
>>>>  				err = fuse_copy_fill(cs);
>>>>  				if (err)
>>>>  					return err;
>>>> diff --git a/fs/splice.c b/fs/splice.c
>>>> index e6d43329ed3f0..df73a4e65118b 100644
>>>> --- a/fs/splice.c
>>>> +++ b/fs/splice.c
>>>> @@ -956,6 +956,7 @@ static ssize_t do_splice_read(struct file *in, loff_t *ppos,
>>>>  			      unsigned int flags)
>>>>  {
>>>>  	unsigned int p_space;
>>>> +	ssize_t ret;
>>>>  
>>>>  	if (unlikely(!(in->f_mode & FMODE_READ)))
>>>>  		return -EBADF;
>>>> @@ -977,7 +978,12 @@ static ssize_t do_splice_read(struct file *in, loff_t *ppos,
>>>>  	 */
>>>>  	if ((in->f_flags & O_DIRECT) || IS_DAX(in->f_mapping->host))
>>>>  		return copy_splice_read(in, ppos, pipe, len, flags);
>>>> -	return in->f_op->splice_read(in, ppos, pipe, len, flags);
>>>> +	ret = in->f_op->splice_read(in, ppos, pipe, len, flags);
>>>> +
>>>> +	/* Fallback to copying when hitting folio refcount limits. */
>>>> +	if (unlikely(ret == -EOVERFLOW) && in->f_op->read_iter)
>>>> +		ret = copy_splice_read(in, ppos, pipe, len, flags);
>>>
>>> here it can't tell where the -EOVERFLOW came from, if another file
>>> returns -EOVERFLOW (i.e. tty_fops uses copy_splice_read, and
>>> n_hdlc_tty_read() returns -EOVERFLOW after dropping the frame), it now
>>> gets a second read.
>>
>>
>> That's what claude told me during review, and when asked whether that actually
>> happened in practice it said no ;)
>>
>> So is that actually a problem?
> 
> Double checked, claude managed to confuse itself.
> 
> n_hdlc_tty_read() can indeed return -EOVERFLOW.
> 
> I should just have let splice keep failing, dealing with copy fallback starts to
> get annoying.
> 
> I guess switching to -ETOOMANYREFS should work (and might be a better fitting error)

I agree with that :)

-- 
cheers,
jose a. p-a
