Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506F43A9622;
	Wed, 21 Jan 2026 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768975824; cv=none; b=mgCb66kKcZ7QO5iZCVBS5x1+HMkxronBOW4VrSLV4AKQeUTuqH3kEB2KSrywR7BoRcyBxY6X+OwFBoshbx/J0W+LClb3s23Twc4BiI5YUWoWUJ0vjTRHtAf3+A94Um19oBCxJefwu4JP5E0yFljxPsylFXxqg+V5vK3sE/H/9cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768975824; c=relaxed/simple;
	bh=hRU+kmY0lWlctWiCRClg6Hs8MNl31uLxyjX7+5kTLrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i4AbPjpw1JyGJwjakmLsb4uu+HBfdjqCKZWF4qNpmcTqIqhNO+pdeYLhqRDImyK0/tArqlEMSi5u6/cQ6f9KR5RSoX2zTnhlCdDwxHR3Q76WLWpsGZBgcOJUJ1qv/SmyYYmqmEmZ31DlGOjAI5tN3axonPmsXm6CW/CplcD1CS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIDceXpf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIDceXpf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D354EC116D0;
	Wed, 21 Jan 2026 06:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768975823;
	bh=hRU+kmY0lWlctWiCRClg6Hs8MNl31uLxyjX7+5kTLrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nIDceXpffZioRMvWOGD+DBk84MsM/xjMwXvg4fmOl9T5bHFRJmzWQGdiesZFElCnT
	 Z4B+A7+NxlLQq/fR/ICBx9Vjj88v2ecbxdBNlymDPvamf9dhul9UtCwGikhTQjVhxK
	 7pGI5PtUUHF1EhT0Bu06y+2hu2MV8oTIjhC1QacR9m2NyJkVGUqWrEs42kp2YuSim+
	 9AROtNVvyHBvZmJC5Gx/5V3YDamI6ZqFmhLfmlesfDRGT6iFe4iMOHfYqmUZ534LyF
	 lirUpSS36dO1RyKYU48Inwco52qX0CA75TzbVjt4Ku2QvKy0B/M5aT9ps+KB799fXT
	 sANyxweSQpirQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, suzuki.poulose@arm.com,
	steven.price@arm.com
Subject: Re: [PATCH] arm64: swiotlb: =?utf-8?Q?Don=E2=80=99t?= shrink
 default buffer when bounce
 is forced
In-Reply-To: <028734f6-2a72-4509-81e0-7e69bda20253@arm.com>
References: <20260120070102.182977-1-aneesh.kumar@kernel.org>
 <028734f6-2a72-4509-81e0-7e69bda20253@arm.com>
Date: Wed, 21 Jan 2026 11:40:12 +0530
Message-ID: <yq5ah5sfjy2j.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Robin Murphy <robin.murphy@arm.com> writes:

> On 2026-01-20 7:01 am, Aneesh Kumar K.V (Arm) wrote:
>> arm64 reduces the default swiotlb size (for unaligned kmalloc()
>> bouncing) when it detects that no swiotlb bouncing is needed.
>> 
>> If swiotlb bouncing is explicitly forced via the command line
>> (swiotlb=force), this heuristic must not apply. Add a swiotlb helper to
>> query the forced-bounce state and use it to skip the resize when
>> bouncing is forced.
>
> This doesn't appear to be an arm64-specific concern though... Since 
> swiotlb_adjust_size() already prevents resizing if the user requests a 
> specific size on the command line, it seems logical enough to also not 
> reduce the size (but I guess still allow it to be enlarged) there if 
> force is requested.
>

Something like the below? I am wondering whether we are doing more than
what the function name suggests. Not allowing the size to be adjusted
when the kernel parameter specifies a swiotlb size seems fine. However,
I am not sure whether adding the force_bounce check is a good idea. I
only found RISC-V doing a similar size adjustment to arm64. Maybe we can
fix both architectures?

@@ -211,6 +211,8 @@ unsigned long swiotlb_size_or_default(void)
 
 void __init swiotlb_adjust_size(unsigned long size)
 {
+	unsigned long nslabs;
+
 	/*
 	 * If swiotlb parameter has not been specified, give a chance to
 	 * architectures such as those supporting memory encryption to
@@ -220,7 +222,13 @@ void __init swiotlb_adjust_size(unsigned long size)
 		return;
 
 	size = ALIGN(size, IO_TLB_SIZE);
-	default_nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
+	nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
+	/*
+	 * Don't allow to reduce size if we are forcing swiotlb bounce.
+	 */
+	if (swiotlb_force_bounce && nslabs < default_nslabs)
+		return;
+	default_nslabs = nslabs;
 	if (round_up_default_nslabs())
 		size = default_nslabs << IO_TLB_SHIFT;
 	pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);

