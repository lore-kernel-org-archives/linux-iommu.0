Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994574;
	b=XSRMyZS2a4pXhZmpUPAbl3Ge/Okcb7/MyxSshAbfzJBeDC7a9u5HOpevI6++jPm5N44w
	 3xwQMhZcD/vF3sJLIjUlmXk3/QgQm4NHQeIS5SbnWTvouqa78LV/oItdeWE6JEcis5qGO
	 KHhWYv7gvfKRr1ppdFpAQcgBBVrwpcu6tlW+qmXvrAcUhr2sQlkFfzjJ7MyKqxc3TOKYn
	 T/Z0owif5Hf/KTvU3oP6sc/YqU323pIfBkBvk+GQlfeyq5W3IFn7DiHf6b2Xstd7EjGWN
	 WgLYn6yUiY9bt2LbYSc1r7DuABBOQxyQTEwnreQIioeSgrYaubv9WqRTAhuEdEWN6nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dfckAU/Yd29uVy4cVx78aos11SmH7YOOmI0OtH69KLo=;
	b=vHtGApNT51to0j9OqFHyk8VkSEvyD22OZwKd0ZG1pW+ZhpuIxO6ck2RSxV+fUcSizUKu
	 YnLpTC5v77j5rbAzLFIL48d0BEdUSOppiBccOTyfvHeS1PV6o/erJwvSVdAANftokXZJ4
	 j2p+7iEMnxgbAI4kNcgtluetMwyOQbK34AJy8SGmfJqGBirtp+RIJJ5B6xr5awPzXgMJ6
	 i5IKczOnJ09xsSMMw2oqKvYsvlSBKugr27MJdP/X25+IDL78PVz+t2Y5dvsgXz2qjykl8
	 QdKJjiMcmQ00gqtu94odJG0veNYEMGXtzwAUrFHilxlQrhMBRGIQLdxUFLx+2a3QX1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ciNlOJXJ;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6D606A32C
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 19:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89E6D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ciNlOJXJ
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53653e30353so12708031cf.2
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 11:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793994572; x=1794599372; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dfckAU/Yd29uVy4cVx78aos11SmH7YOOmI0OtH69KLo=;
        b=ciNlOJXJkynGaFaCKvkWUFe2JF49Y/L5XtX5h1GrlldYjuPfVAMjX26IVP+HuGy7IL
         a8LqEPHrqXvRvdqhaIOM6oJjhVFd1ocxctzeiKUw6Z4B5L2Rf3SG35kVN49wY56FqiIX
         CihNEx9gDQhmm0GuC3tWwFh/wS+RywGCLXoYAPyFhl1/jgzPkmI9FMpzZca4nErYPyAJ
         uqddaSHRiWeFs+ihRFRpB+A0eKF0lKRQknkcDeiR3Qck6wT3R1JUdv0S6aRwelgnQi8f
         z5WecDgNhaSiPR9y01bbz8aC6h4U9hFsJssaEFSGo3rtvroF4p+8zaloqTwYzGDp6sib
         tkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994572; x=1794599372;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dfckAU/Yd29uVy4cVx78aos11SmH7YOOmI0OtH69KLo=;
        b=vFYZecY6kmD57ctLUueq/YLiAiwqSx3cU4h3O+7tH9KGCkMfd0HhHeceHFEDiXiwbo
         MhfN5IGEtQHiTqhpcNhD2UvB0DjxYLaP/0YhTcuGti4AC1Lu2uCQVcSxqxEgO5HBhrqZ
         wQMx7p9r17OvCtTIOaH4GqB+9O3RNFupg0yHLR5G82bk9iKoAXbUWM2rPt1XoZedF7vS
         OtojYuUsURLGZk5BlrrMzFD1fEbrJmhMcNMrZX1+B1maS/1JRMemQslNo4AOyTFeF+/m
         gNEgK6ZSYjWnTtooy12QAhqWK1MFUXHtSR0c5GTkFLe/lPPjWedx6jBBUVEU7AXl81kP
         sRgg==
X-Forwarded-Encrypted: i=1; AKwUvBy9aiKOX1O9OO6m2VaANfaS64VNeSAKQmlQimxhUp+MYwN9y463yJTEAyKjJUj9INmsbrvLuQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/cxF7lP6O5jx/41IK/RxJZLe4eLGt/OK4zVryWIXmNLhFt8J5n
	TXKuYjYp7Yd07kGV1EDEAu0ZleB/DvIBlsi7agQU8V8n+ykraQY6ojTZFUcGkopDOIs=
X-Gm-Gg: AYBFou2yCSoxhCbR7P30Z3q5fyiz5TlsYSdtL/+d4zMbJp6AEYf9jQiiXMwkSKxjHpF
	XSwkrdyNTEheOf6182kJWPKi9GxjbsS6N4aIm7DiOr++8SSqJVO9f4yecenpXB0+mg4esEqpUo+
	WP8UrAAJTsX1izEjtwgz78u7dZ1AkL//cNEinF/anO62TQ2t3zxWNXPl2yDInVJzi8nZP1XTPRl
	HVeYSIzGRyedxYxQ/R/O1/tikQqZa4rrzXugieV82gcNdQMUPo7PAaj201tqviUUVAsHMgUpeuS
	CwH2I5ecMkPL/oaDdVdDBVX+gJqCB8dp/fQNzs9SNVBa+qcx7FMK6HpYeqOD41caM+rBHT+NSVX
	C7vLlDnLPKiPPbxdhnaPzAH0pe1gqt8VcPIWED8neR0dDF8YDKi2eMJkWwt3Crop3kctWZgdzg1
	ERARRkzCuyr4gKx/LNmRPZ9pM2E/RGVSpi1PvPyiz5dNc3GmGcjj+6F+psg2AxfOcyW/jeVRHNv
	K7LqBnsKnRoYLP/faxZt0l6WynSHUwnybZ6+vH9BnmEtK3b6mVA5xwwbWjEw2mdYma2aTsXq0ez
	Wcs3l5E9P/czvwAH9yovYEtXcMIMeqCOUC+IIO3OoAEn4Q==
X-Received: by 2002:ac8:5f50:0:b0:535:30a:76a8 with SMTP id d75a77b69052e-54e15a65d6dmr55048351cf.59.1793994572184;
        Fri, 06 Nov 2026 11:49:32 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e26839a40sm27617471cf.20.2026.11.06.11.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:49:31 -0800 (PST)
Date: Fri, 06 Nov 2026 19:49:30 +0000
Message-ID: <2ab3b9da1c31ecfb5880542efa6508c8.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Chris Mason <mason@kernel.org>,
 Lance Yang <lance.yang@linux.dev>,
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 Kiryl Shutsemau <kas@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH 0/5] mm: limit pagecache folio refcount
In-Reply-To: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
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
Content-Transfer-Encoding: 7bit

On Thu, Nov 05, 2026 at 02:10:09PM +0100, David Hildenbrand (Arm) wrote:
> Users can create a lot of folio references to pagecache folios, making
> it possible to overflow the refcount of large folios.

This is a summary of my Claude review of everything, minus what has
already been said on the thread.  The numbers are from a TCG guest with
the limits lowered to user 6000 and admin 9000.

1) Small folios, 1/5 and 5/5

On an order-0 folio one FOLL_PIN is worth GUP_PIN_COUNTING_BIAS
references, so about 2M pins reach the limit.  That used to make GUP
refuse more pins, now it is also SIGBUS on new faults and failing fork
and splice for everybody else.  6 io_uring registered buffers on one
order-0 shmem page (ref 6146) and another task gets SIGBUS mapping it.
Mappings alone can't get a small folio near the limit, so could the
mapping and splice sites skip small folios?

2) Migration, 1/5

remove_migration_pte() and remove_migration_pmd() check the limit for
whoever migrates, not for the owner of the mapping, and kcompactd always
gets the user limit.  With mappings in the admin reserve the next
migration drops whatever is over the user limit, in rmap walk order.

At ref 7681, move_pages(MPOL_MF_MOVE_ALL) without CAP_SYS_RESOURCE left
1682 of 7168 PTEs unrestored, including all 512 of an mlock()ed VMA, and
touching them again got SIGBUS for all 1682.  Could the restore check
against the admin limit only?

3) fork, 1/5

If the VMA is only copied because it has an anon rmap, the pagecache
PTEs could be left out to refault in the child, like copy_huge_pmd()
does, instead of failing the fork.  Only the VM_COPY_ON_FORK cases need
the error.

4) splice, 2/5

filemap_splice_read() fails where read() still works.  sendfile(), the
copy_file_range() fallback and overlayfs copy-up get -ENOMEM, and nfsd
turns it into nfserr_jukebox so the client retries for as long as the
folio stays at the limit.  Could do_splice_read() fall back to
copy_splice_read(), like it does for O_DIRECT and DAX?

backing_file_splice_read() runs capable() under ctx->cred.  overlayfs
lowers CAP_SYS_RESOURCE there, so root never gets the reserve, and fuse
passthrough uses the server's cred, so an unprivileged reader may.

5) Errors

The one condition comes out as SIGBUS, -ENOMEM, -EFAULT (tee, pipe to
pipe, MADV_POPULATE_READ, process_vm_readv), -EIO (/proc/pid/mem),
-EOVERFLOW (vm_insert_page) and -EINVAL (memfd_pin_folios,
fuse_dev_splice_write).  Nothing is logged or counted, so there is
nothing that points at the folio.

6) khugepaged, 1/5

try_collapse_pte_mapped_thp() clears the PTEs and drops their
references, and then do_set_pmd() can refuse, so the mapping is gone
although the collapse would have lowered the refcount.

7) Changelogs, comments, stable

- 3/5 doesn't say what goes wrong without it.  It is tagged for
  10ebac4f95e7 (v6.9) while 1, 2 and 5 go back to v4.8, so 6.6 and older
  get the limits without the flush, and it doesn't say why that is fine.
- 3/5 leaves the "queue is (now) full" comments in asm-generic/tlb.h and
  above __tlb_remove_folio_pages_size() stale.
- The ufolios_count fix in 4/5 doesn't depend on the rest of the series,
  so it could be its own patch for stable.
- 5/5 needs 1/5 and 4/5, which isn't stated for stable.
- After 5/5 the check is the only guard for pins on small folios, the
  kernel-doc calls it "mostly unnecessary" for them.  The comment in
  folio_maybe_dma_pinned() still describes the negative refcount scheme.

Thanks,

Josef
