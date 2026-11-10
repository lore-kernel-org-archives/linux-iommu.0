Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346502;
	b=Igs1ODndukGx7mQ3rN7JLbtV3WW1Zj7ncOOOGH3f9zeCXP6fhdoJp0gJU9uF26uTzbke
	 eoxZBVHL9ehBJPQ7746EGUqsFTCMfkp/i7KRZ0xQWjHhbVL9masOu1SzqgTm4DZ1VmDqn
	 BODighlBOiiBdiARqSWS9sqpy2eLc9CDJ+mKuq17oVDPhU9V0AaUD3oqfPIEvmCBQ9F50
	 LR4AhfZRxBTvbhLPMEozXCqbxLwXA81XoJzp/K8l6FYsedIi8Kd6EVvfCRJeaINE2ddcS
	 LEVLHo1/RUmxrqOSJyfaZXpZffkIe+LJI25qZ/aXxHl7sE+Hf3jRyDkV9LWUenHQyNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=mOqbf5f8IOrYsXobBY3T9L29gUMiYe3oysuU/ey3bJU=;
	b=4GjpzDD89JCdHctzwjI2KUV79JSgha/Z+QoGLUwZH1Y1vjUAZn7lHkLaqoHCybJmcchV
	 kRAEs8P2B84Q8NTlOxFOMw/G+r1oYZ7eKVpsBL6sCItrW0osfx6MB/C6vtNYsLUxZgXFk
	 QPmGoIauU3fafK44eqBI/8KKbw38DPR7G3dGPEno31sFxY6LXEYJkAmLkM/wVE7Z27HhT
	 dzkNeD352pOch/P0GBm+BOgz+KBWGEWCgEk9Zv/Qm98rk+1j3Rm410CwGTibKAsMIYAbH
	 lAXy/osaM8yU/eT+KRyAV1yk6r5ZunSFNyHNizixcDULTMW8st7YIPsB6BrGoBjTLRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wL8OKSjq;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15088606A32D
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 21:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15088606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wL8OKSjq
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso1705386f8f.1
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 13:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794346500; x=1794951300; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mOqbf5f8IOrYsXobBY3T9L29gUMiYe3oysuU/ey3bJU=;
        b=wL8OKSjqrT7e66TFZx381N2jUAvwAL6jqttipbAyiXSnC9cKfH/Byv+0htH5pVdOgi
         PW4wdtIv1YOhBPOPZua63fPAgGHSlMnWqQdXZsp2UbS8zJDX0ZI4q1+5Ki7qcl+G2d5O
         2NBnTGHTMAXh7HIshYHDQ8mURJeSFfHLTF7aUnYEHYJ6h1kF7vx0mh46DDCtR03wFJa9
         KeEM+hafG5dwwxHrsCRRQusSbu/pwzSOhIi7EsgF22wVU/U1UUNWEZ4Wct3Jk7SrGzfe
         uqiedFIHIkPHUxhGwuMq1R6R9sQiwKnGjco0O+BX15JnnOsi2wfSlujT6n0JvA7IFW44
         8Faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794346500; x=1794951300;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mOqbf5f8IOrYsXobBY3T9L29gUMiYe3oysuU/ey3bJU=;
        b=iwcDsD20AEZBzBJ2XfMbZyNAytOUXUrfSpEz+BLhh+5ggzBvZskR2M+gmVJe8Dj75A
         lm6fmLCmTUubvm1seiPTrhpOucmgHxOaj5W6QVQRbcD9PyZbl2w4tCTERpwIPclRjgaW
         2sJoqeaBdHXRX6Jwnqu/XXvA5XiIQgNZTqRqVpWROFI60L5LNoSe5LSSCVxPrEdy+5vw
         OqM3BOoOaGGi5J90b0zfioelhZPrthUgqpbydcaAHIbjA682MXlI46EKyRKdsAQr3HJ0
         SAryDtpiG5EbujQDOl9p1tE+qaHuBPiJYWgNgZ297PoL9nqRk25vm4q5ewj8Gbque4gI
         6e3Q==
X-Forwarded-Encrypted: i=1; AL+hErEq3HlIGxSCjbpuiXGnv/OgrnDhNHpFd9ZwuascwsnyDO5q8FrqhUMvTTTB6o6LRb5Nnut+eg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8QJTmGV2GlETbnRvV0Y03RxHH+sTew2fbwRrw81E4iG6bSiCro
	ejMbzWj+V88LyRpJ5nuEnPwsw+NTevtIJooSX4ZbNI8ap21jD4bKTcvL
X-Gm-Gg: AYBFou0oLGo9xWANBn1R+EjLL1We32v/zYga4RlB0jr6JpyjTpihcZ3uJmSFwk1/u2w
	YBkGZtn8i84D7UzttCy/T9dCSBWrtvbyCqw914uL/nTDQ2C/C5GmuxuvWiF526y4kgVUGDRQUHU
	3lc4IO0M8Jdx+ayWBg8BVSk0y6bBIqqU34MStPifAUQtB9VaVUif++rD6WVutVKiOBGILwXfz80
	ital/VcSe5/Xt94fsbQSjX61emaX4sEd4RgtIQ9J+hiTznex+985kh70SV9d12ZFSU8Dxbwgk/y
	3cTraKfPqsSrltFrqNuTn90veGqUZDGFnDbjAnu3TbQhoQj9OyY8pjLmMvP43z/RJ1csCQw7mmT
	2Jaj3AfJkyHLqPdTCYpkINZICs4nhCibMx4zSEvSIt6rNhmVG60W2UEMNxJFFbHE+pAtWHDS3Y7
	cnRCllgQ7gp6gaJBKFxS/Fjw3/jhHVfX77QhpI4T7BTWrwKAdPgIDc+EVA/ygjlrOcZfrotLtfl
	wzRs718sP3FKUMqcptymBNgTP8TXEWmKfM9I0V4pNsS3CwRWHiht6m5MW7Xc2oQEoJHaq3QdUMz
	IUjgCPpEZIpAemdQWtSc5KVt
X-Received: by 2002:a05:600c:364b:b0:4a1:d766:758 with SMTP id 5b1f17b1804b1-4ba08e1f572mr8423245e9.16.1794346500171;
        Tue, 10 Nov 2026 13:35:00 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498369a3fd2sm7670526f8f.52.2026.11.10.13.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 13:34:59 -0800 (PST)
Message-ID: <cbcd04e6-b0c6-4a8b-9f89-4f57a4c50864@gmail.com>
Date: Tue, 10 Nov 2026 22:34:55 +0100
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
Subject: Re: [PATCH v3 2/9] mm: limit pagecache folio refcount when splicing
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
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
 <20261110-refcount_overflow_stable-v3-2-318625d63a98@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261110-refcount_overflow_stable-v3-2-318625d63a98@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/26 9:35 PM, David Hildenbrand (Arm) wrote:
> Similar to mapping pagecache folios into page tables, let's reject
> additional references when splicing folios into a pipe if the refcount
> is at its limit, similar to how we handle it during GUP.
> 
> This will prevent more cases of possible folio refcount overflows with
> large pagecache folios.
> 
> Introduce folio_get_checked() for checked reference acquisition when
> the caller already holds a reference. It warns and fails on a non-positive
> refcount and rejects additional references at the limit.
> 
> Use folio_get_checked() in splice_folio_into_pipe() and
> fuse_ref_folio(), returning -EFAULT on failure, like we already do for
> pipe-buffer duplication. Similarly, make try_get_page() use it instead.
> 
> Likely try_get_page() should be renamed (or removed) later, as it doesn't
> match the folio_try_get() semantics and is confusing.
> 
> If we hit the limit after splicing some data, return the number of bytes
> already spliced. Teach the callers to handle errors, and stop
> filemap_splice_read() if we only spliced part of a folio, so we don't
> skip ahead to the next folio.
> 
> The check in try_get_page() also covers pipe-buffer duplication by tee()
> and partial pipe-to-pipe splicing.
> 
> Note that we deliberately will not fall back to the slow path of copying
> the folio, particularly as the folio might have an invalid refcount. If
> it is ever really required, we can revisit.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM :)

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
