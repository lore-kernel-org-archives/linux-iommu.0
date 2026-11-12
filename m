Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504537;
	b=cltiMqCLzUzX8Veaa46YY+t5UTViEvIj+vr6nsbM7ZuW4gksa4KTW38/8b7LsihRCact
	 MmzE7Eu9qN/Xv5+cydlOxBtOFLKxzVtYwBlI5UU81vPZtOjYtAeAFEmGLJmAz8D1qXZc1
	 xlvs1/224c+RV5kmHyVmPnYLkFxnteb/MC/b5BEu+MxxgRb/zk4ogQqVnt0hwuzSAfnTn
	 u8QJtx7avYugtnYKt+1jyCwbu9Ct10uOViAcMxbkb5AOWZAJ6McCughNGGnIoLelgwPZz
	 BYi6LH2BbqOl20Hca5cJsrp4qogeaR73hNn7l7c++omYzSYVX4J6oTChCacUFAczY2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=AVq19U8dsLUULl5Arm+uFElP0L4F8s4K16OEcmVJkjM=;
	b=n1fP6SB/sP3IhRBHopYxcFRCV75autzkvAUlvLnfAyX5rfnSzmWhgRDocUlkisKi2jZx
	 D7kyMosYvK0ppwznMgrcgxOplAHq/KctqCV363XnS9nHj4hIpGyzqmMfCOXbtQ7y4kYcr
	 ChM08tcPcHzYGkhhIFO17vmFl+Ts09VlRxsaDKyaSMWyn2IWshZgDZiZPrhgUHJ4erqPM
	 u0bpq+tgD2Z2H7e2YQzaM8FFqQZyfZLovLVZ3P8zGuzDozlKXdarKn6uEq++QtK08q0lK
	 Idi1csbCHZA3bHRj2Xm3ircTjiwwm3YR+f+Tl/a+nprNd6t+bGVHu+zgzQwupTq5lew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=KZ+xhsZ1;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8F9606A32A
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 17:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E8F9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=KZ+xhsZ1
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b56bbf8330so55015a12.3
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 09:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794504534; x=1795109334; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVq19U8dsLUULl5Arm+uFElP0L4F8s4K16OEcmVJkjM=;
        b=KZ+xhsZ1vr86w8qtaQJC+DvIHnreoD7ec/L8LNBr6crbodrUBwnxjAwiq3osOW2Rfe
         7gE1XusPEpUmmA24CSo9+Y7SLwfxsOskcMvO+zqYBMP90IdEX6zt1rwo5m/wcY74rrm6
         eyVfsMFUCkD5oBQdcwPHIIwpWXFY9wZthMloI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504534; x=1795109334;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AVq19U8dsLUULl5Arm+uFElP0L4F8s4K16OEcmVJkjM=;
        b=lArPpL/2YZ6a+reJLdi1D9f+O7T+5I0TgpJ55gPdrwXrhUb6Yu1oS8Q4XVnvd9770U
         aqhUdHBkx5Rjmm6TsnxWIFrx/PYl6J1revikm2N9+MXv8sppEtnK+YCw8+9WCIbpcUUH
         DCHvpivur18NWZ3365cY7IpNRoo5z+9wl8VFWYZGHAnC45ydfPYhkWkLckd4G3MScPEh
         hy2Ue/UoBkV4ig46ZmuoDBIkRujYJXaytSRUDuLkRL5UWCiZVln3ABLM0FoH8vYy+mO7
         ea47nUcZI/tseZWehRs2jqTPhDYLNCOmA5Ov707afvambZlKsBfuOIg/5e75EuVFEsbQ
         hxKQ==
X-Forwarded-Encrypted: i=1; AL+hErFWmFe3n4BZJDHIJLGnmgXGHhS7U5ke9UUf9wUG92QSvH/X4osfNg1gN55F1x0sel/91iKALQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/pt7WTIVfFzymhmCYiQiJEaFAyKjTybFzjMafvdV1JdBYBcwYC
	BcOyUpDFyvGzAlZr7xrBRTmhoVllytxICfYiPFTAIlVQTBvCZc2xfF9m5i4JPrzYPjhTI81a0Dy
	b7440dTWLLw==
X-Gm-Gg: AYBFou32BgtoDx9AZsZNMf09m1Zg3qXVr0Dj0FlKuPxld9rRy60u+1OviJKFbX1U7cl
	dpvEEB0vu7itSTIX1pEIkxSBRWUwjqmMxx3zPkMFPOQhtT2VnWhCNWqthpN+FWJvVLPv8JCtJUc
	EvCpP7pP0VQot82vbHQB8eLnk7nAOBdppYO/wm3Ga783CrG9W0E3E6eey7UN1bPVoRlG2gkff82
	Ouh80/m9kHkAY7ZpUKMCMSKg7ey/+sYghcqnkKDO719WAbukWVmvVDLZtLGWX3kS7ixd7Zi5WxU
	C+t4XDcFA38abhUzWBviQWKPtSvldDf69toZsEn5LX5b7ytTA0fbW1QLJuF3wBZ07snQJrdiesM
	ckY0lS75D2c/YeYJ0MSB3iBX+3GQl38RYNF7OIgto/qwFzwHs3b6686g2/0tmbDlxI3Jb216TrA
	siSQfzF5RTVvsYMsyn96WvoDHxRQ7LAVgepFmhwAjkK5Lqls2+9VpBBRUbq3DyoAb22Tyvu438j
	MJ6ENK1h9c4rFTut8ZvIR9KKCSvmVX+3ll1Nof1zjfNcCcvPwtxb3bC0IZJDUdtuuckqivB3wIi
	qvBvgNB3bH9vtK4AvIVglcY+3kAYbqtx9XoNpGGncuv3zXkvqM4bj8kTx4MJvAFEawqRDZe6Fss
	KZr8=
X-Received: by 2002:a17:907:da17:b0:c3f:153a:8649 with SMTP id a640c23a62f3a-c506694dfebmr642569366b.7.1794504534593;
        Thu, 12 Nov 2026 09:28:54 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b6f6eesm915466b.63.2026.11.12.09.28.54
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 09:28:54 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4395d31228so625360466b.1
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 09:28:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF9RqkDdwzKj1mMkmxspXRGSPKwc/vsyePsIbPajVD9DX+j/Md6lm5JL/itGh+Uzr9sq9T58w==@lists.linux.dev
X-Received: by 2002:a17:907:3ea7:b0:c4c:e344:ece7 with SMTP id
 a640c23a62f3a-c5066afe5dbmr615605366b.10.1794504534261; Thu, 12 Nov 2026
 09:28:54 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
 <20261110-refcount_overflow_stable-v3-2-318625d63a98@kernel.org>
 <avW3v-oLxcHXXNQD@pedro-suse.tail5790ac.ts.net> <4ae22b7a-c160-4003-a029-8a20381d196f@kernel.org>
 <avXFlI_5fhUvFyct@pedro-suse.tail5790ac.ts.net> <42373222-8e37-4658-bebd-dd27230a1dfa@kernel.org>
In-Reply-To: <42373222-8e37-4658-bebd-dd27230a1dfa@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Nov 2026 09:28:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh995y1B461rPAcgLagg26vsyXPoe=7JKgHowB+uHJJXA@mail.gmail.com>
X-Gm-Features: AclHuK90rViBZMbITCUjh4KTAKhE7_4EYJcdTbdgYzXWPc1JsLWFSAsYMdn-r7I
Message-ID: <CAHk-=wh995y1B461rPAcgLagg26vsyXPoe=7JKgHowB+uHJJXA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] mm: limit pagecache folio refcount when splicing
 into pipes
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
	Rik van Riel <riel@surriel.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Steve Sistare <steven.sistare@oracle.com>, 
	John Hubbard <jhubbard@nvidia.com>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	linux-arch@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 06:31, David Hildenbrand (Arm) <david@kernel.org> wrote:
>
> On 11/12/26 15:00, Pedro Falcato wrote:
> >
> > ETOOMANYREFS I think is good, also EBUSY, EMLINK (though this would be weird)
> > or even a generic -EIO.
>
> So I used EFAULT because that's also what we currently return when
> generic_pipe_buf_get() fails through pipe_buf_get() in splice_pipe_to_pipe() and
> link_pipe().

Yes. It's not a very intuitive error code, I admit, but:

 (a) it *is* the error code we already use

 (b) it is a fairly unique error code that isn't normal (ie EINVAL etc
that can happen for multiple reasons)

 (c) this is  something that nobody should EVER EVER test for anyway

IOW, the actual error code doesn't matter. Nobody sane will ever care.
Some of them may be entirely unreachable due to resource allocation
issues. And we already use EFAULT for random historical reasons.

                Linus
