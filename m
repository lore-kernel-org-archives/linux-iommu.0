Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312022;
	b=JFQtw0L4wFI/dFxSsmUGHJqggI528tGsM1P05qvLHj2sz7mucTGkOcWhLtXACNdcV5ms
	 iKmg4ZFkyVZpjzmG+sYcDwzF+NpZwOly3GF5Z6MG0V+Qq3X0ChF6sbJ+MUDlL/uGdKsOM
	 LnD4wWPYQASc7EXI8PTeyMytEglvp2+aKIVNaI6kCf+sxiVtnGXVxV2parJy1jyHg5m/V
	 F2oHyMO3FZ7x6cbGc0FgHwmD+ZCPgId3jSwFcCKpyHJaNgoj34LgDvSz6bOgU+84MP0Z7
	 y2QuRxAS91TQIim+JgNDVkfwDs0j0lnMI5TPdsUx1Xtn+kUfzPtORuGwOQsqtaACsRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5X3zb3VH4w0Ie2RKn7QlDBjKtcvMvn58SYuQeOEmpyc=;
	b=cakIfNE8G+Izany0KcmAoR4Y9RHCC5ue7vK0+JvSMDMuUWjYZX5Ov3P8Juvwo7qYdOmv
	 q20uQN4NWfYWYI4GynOw9UGUTzTc1lf1IvAldJlXuJGvS1MEg7q3/9opnK9qDMl/AGCe4
	 JNG0zZy0m1ezAwt0yAB7BKVqt67M6JUwBXNxQiVQNhJITS6qu/bSwA7BkAnexRBBz/f/x
	 AdSAdcTaL68Hjv9xGgXBHDD/Nl85LmALWW1+9Hj17CFEIWbuhwbb70duczjoQAWfnxnhI
	 UsdIJfTinZOae0apU/Ul1Vl87mOXh2Tf0+H+ssvZxgCQFx+504foH62BwWISZ9YlbFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xupZvciD;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D30606A330
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 12:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31D30606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xupZvciD
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so15721985e9.2
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 04:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794312020; x=1794916820; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5X3zb3VH4w0Ie2RKn7QlDBjKtcvMvn58SYuQeOEmpyc=;
        b=xupZvciD983KeVpDKTiSJVc4wYaOAS3D4FKcbvF4M3bVxSHuXzvHQgjbS1MyAR10Q0
         Frb1tNT3ZPNyQi/4xAlzC2D2djgLiNzYSm/UP62PYtq4gmToMcj+Cr2Oop5XYwJ7KeBE
         xA9QZH9svRgF9N62OVI1EsswI6tKbU2zq9tXimzRrjLI1JnRrR+wkE04L7zLWzOI9vo/
         Lba/yVGHhrOUNCmyLYmmOzgiZuSF5mzxsbDE8wy6GLPjZp/ztVXT6dAeiiitum6ZiLq7
         NZlWy3xEuHXAcu2sSwRzIemAaTgnzX/JUplpuB30anKlAcsoYqN6ChP7E0eBNm1as6Z6
         zQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794312020; x=1794916820;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5X3zb3VH4w0Ie2RKn7QlDBjKtcvMvn58SYuQeOEmpyc=;
        b=MJz7xOB8kBp5B1uTtvdB0cPwJJ8rQzxLyTwW5QQ7ZZ0k0uZSHPqSELeJ+37fjSsWQV
         Rw+a7mecqSJOwLF9/A3Iz0cMiuQOo95/91k8ScDJn9ugeJUlWODfORQktGiTXDCjPQsJ
         ulM6OqgRpiSrIQs/gQTuY1c84A7DtiIKLHJj5KkI3EcDzsBcIUqFIao1XCQO61ubK7g/
         g+OrWoqg/uZXlpiYV0RDt7rWU2dzsv/lpT3WFVuI8mtLxgNvWVXqOkAbJ9cbBPdV0S2A
         NNY/V0/9gC8a2m4kO5VDm1oKA89RvUaTKo7SEBt/LdzeYcU+0VubIItDCwuQOFiLs0Wh
         98Ew==
X-Forwarded-Encrypted: i=1; AL+hErFPai/5uM4SCutzVQTgv4rFi2txFKgruF2KV3IciLD53o9udkNYbksr29NW/OT0t3nOXewjUA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8NjuSk+te6nAy92Vo1o4JHTRrCc8Tfw+4OlFcgw4RgeRK/18Yi
	zlTNZX2ctYBN4+z/K3T/lHz4YkYeFLtpZXLa6hjH85pfQLVyiMQdQNfm
X-Gm-Gg: AYBFou10TQXIxbYmrapBAK89HBUI9BTtsKDHFnmNwqM4uqps0MyExsDhkDmR6jCWWur
	xNrXNf1Wxdsybu89COOC57A2MWe58hSwhvi255ZoJtl7MpwVb3SMxOfdUmgTeTb7cpbDvNiKyxq
	BEz/lcNkcwfEktnbjz4cNE9xAlcrCrWzw97hV/PRNegmlBvrY2mlJFfohLvrnq4RjkuCJgZXPlE
	4zne3qW6hvCZ+NOfvi172A860wFOZggAE9eDtduWCoL+flr1QCbGpfxhTPJljOLRDMpes9opasd
	P8rY8X1RE86fiBQ6sNWerv0sPHI7+zeBQTQ1H9X/FUhOn56cV/3J6tpWkR2etIWwUYwLqUTcNax
	TCUSLF4vwls4GQBgXT8Pvkglb6qivWDNLo2zf+2Dp04pIDHXdyWCEnFr5TfmxZnXqzmebKRJeUU
	DwZus0Z1K6pHHR/ZBXwkkUKHFl6mILyV8gbPMYpRKSGAQB6px5c8nbtuKaVnl1cCR9jwo0NULcv
	0Yi8bQG5UKAvFgN/qBS8RFleBRVaiFUIwjowoupd2VY0qS9Wn/mSMdUZcb9iZUTrHbxH62x7L1J
	/X/aBqBREz471p19kRShurZ6
X-Received: by 2002:a05:600c:3e07:b0:4a1:e69d:90e8 with SMTP id 5b1f17b1804b1-4ba0234a8f3mr43245435e9.22.1794312020086;
        Tue, 10 Nov 2026 04:00:20 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea9eesm97526925e9.11.2026.11.10.04.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 04:00:19 -0800 (PST)
Message-ID: <d4bb71af-cd1f-4d42-b724-916064f4cf0f@gmail.com>
Date: Tue, 10 Nov 2026 13:00:16 +0100
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
 <jhubbard@nvidia.com>, Josef Bacik <josef@toxicpanda.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
 <20261107-refcount_overflow_stable-v2-2-c38f6809b106@kernel.org>
 <c8dd3102-38f8-4972-ad2d-97545fd8c8d4@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <c8dd3102-38f8-4972-ad2d-97545fd8c8d4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/26 11:38 AM, David Hildenbrand (Arm) wrote:
> On 11/7/26 23:23, David Hildenbrand (Arm) wrote:
>> Similar to mapping pagecache folios into page tables, let's reject
>> additional references when splicing folios into a pipe if the refcount
>> is at its limit, similar to how we handle it during GUP.
>>
>> This will prevent more cases of possible folio refcount overflows with
>> large pagecache folios.
>>
>> Let's keep it simple and check in the two callers of
>> splice_folio_into_pipe(). Return -EOVERFLOW if the limit prevents any
>> progress, so do_splice_read() can fall back to copy_splice_read() when
>> read_iter is available. This keeps sendfile() and other splice users
>> working when ordinary reads would still succeed.
>>
>> Also fall back to copying in FUSE when taking another reference through
>> fuse_ref_folio() would exceed the limit.
>>
>> Also check in try_get_page() to cover pipe-buffer duplication by tee()
>> and partial pipe-to-pipe splicing.
>>
>> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  fs/fuse/dev.c      |  5 +++--
>>  fs/splice.c        |  8 +++++++-
>>  include/linux/mm.h |  9 ++++++---
>>  mm/filemap.c       | 11 ++++++++---
>>  mm/shmem.c         |  4 ++++
>>  5 files changed, 28 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 3641abb90d6bb..4f6b7b42bfd3e 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -1265,9 +1265,10 @@ int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
>>  		if (cs->write && cs->pipebufs && folio) {
>>  			/*
>>  			 * Can't control lifetime of pipe buffers, so always
>> -			 * copy user pages.
>> +			 * copy user pages. Also copy folios at their refcount limit.
>>  			 */
>> -			if (cs->req->args->user_pages) {
>> +			if (cs->req->args->user_pages ||
>> +			    unlikely(folio_ref_count_over_limit(folio))) {
> 
> Linus points out off-list (thanks!), that fuse_ref_folio() should have
> really used try_get_page() right from the start.
> 
> And that we should just not fallback to a copy, in particular,
> if the refcount is invalid (<= 0).

now that is said out loud, makes sense.

> So the following is what I have for now. Once we remove the limit
> handling again, that code won't change, which is good.
> 
> I went back and forth with folio_get_checked() naming, but decided to
> not mix in the "try" as that just reminds of our speculative refcount
> handling. (folio_try_get_checked / folio_try_get_referenced)

agreed with that.

[snip]

> -			if (pipe_is_full(pipe))
> +			if (pipe_is_full(pipe) || *ppos < folio_next_pos(folio))
>  				goto out;

nice!

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
