Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793278364;
	b=rbgdyQrLGW67oZhkgBCPQsrVOE2SN6elyTtw+k+sT7C+NMCVc9jIvhP5QTIXapsSk+Sj
	 gYwkvyjYz54Uipa1d+WjOM3Zj4tEjhaBhJwmoux7scl0EBwA4gIYu7ggcvIBvBvezy8pz
	 gZ2b2pqFxdEz+OhVorWx7J3LJtVgvaKfG1k8d5Wb+Utnu0u9GV69QSQifIf1VzahQp/Z3
	 nruQqx0qCwTeEgoxBLkusRtmZCIuR9RwllICsUApGizHhf4N1U8jjrdCUp/Q7FWNrdXQx
	 hriAaPJrZY1g+IyQPH8rASKr5bp1/tJnb905v0i2qlnm+wmLytK3XPk5jypGxlMOzTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=zf2xViTkAeLxB49iEkeFNan7sx9Snfm1yj/XBegFK/Q=;
	b=fuHR5/ZLnlC7/LkVPG5nnu+9gMdRwiAvGnlYv45MWai/IawuAHxtAzaj+ROXHUFN4Ct9
	 m0k7ZUzU3+/HTsPcDJQoQ70yc8x11EyHiwdFoYr3Sp7nf8C8SIdmS9tXqhgKp+iSwsOh9
	 p1kp3FzrBRIWZn02A5Q2utNrQVrH3vbKys4KzctjU1id+qEzA1RnhSzrPCAzjVFUWOhN+
	 LJJhljUAqZTI7HkqamlZc2E5JN1+IzC5LrOUjKz5aSMaE1apzjXCDD3eXilM79UJed9Q6
	 UuirvVL5UFmgN1cQHExRZ39MSD77GZqThATiOBBoSxZj5+S18WFhIPOF92Sa0jQwdcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AV1Hgm0i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5E606A31C
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 12:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DB5E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AV1Hgm0i
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91c63449320so21560126d6.1
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 05:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793278362; cv=none;
        d=google.com; s=arc-20260327;
        b=Gx7e912bZOh+nmQfZWtpJM1b0wMKSckptgGEn7SwaVMczsqnXLqcLU/9OIYMacTyXs
         WhbXhxuNTOIo1R7FMSnpkYvoVCca8KNp+0SD7CzmIZhUJzQ1iUmy7Zyz5uBXI9SZZMgA
         GtHI0XxPGQSj0/EingvJ1oCBJCfzHOAqH5lWl8RNpldKEmCDpBD4SDE5abCUrTGu5Z3H
         ruE3TSM2BgnaOcXaCL6WpfOFZpCcyQmHzDi/9aE8aj8duJFHbvKfr6HX8JbnZ3jHkPZE
         YlK8pJtjByR8lO/xRg+AM7/hGfq4mVGNaHgYA4qmcUifWikexkcD6CCv92S/eIUsecpK
         1KqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=zf2xViTkAeLxB49iEkeFNan7sx9Snfm1yj/XBegFK/Q=;
        fh=1Zl/ji5qzz7h17eFgsPAV9kJFz+ppNyp/UVzHtW1RQ0=;
        b=JhWRWEjiD5O5Mbd5zLWX3xi2dh09DPC0mBDJ/uyG1ZIs/+dSGI7BIpiZyMi37PYpco
         AiBsdJWMA879sd8tqSOlBJmWvwFDMzqd5v1cwsmYIxfnOQWDwaJVl0nfwi0chu8OfkWF
         lgUDUh29n29DpdrqzrDr2i9Bn9a0YZP8BTo/xN6TuvK5ATiRrE4Lp9mdWa5S+FRRjhMs
         HLMYbNV6V4HK/9N6Z0/YZS1KuOZXjjxfrHShoVcP0VAgcZSIEJLLPgk6+odDK8gGNEBQ
         Cg4PtYK2dJLjeWmsNDd+lqdNSmbeZXzU11gLfrQjsXUoTS4efwNfE1tAEI70MSvG7L55
         BKcA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793278362; x=1793883162; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zf2xViTkAeLxB49iEkeFNan7sx9Snfm1yj/XBegFK/Q=;
        b=AV1Hgm0iFHWzZGsDVHXCb2IYpeVv6EW98uFBcMPayNo5zowTitCRsaZEsM86QmXaj4
         hchpPqMY9PX1QQ2cPWm7vibDab93DeznX5yk7hBYy2fD7m6S9H37ihFFsJVywMnUn75w
         hojAZQ+/1QdS3oLsp7dKNIsW+idqKsMz69t3b7KPR4Qk9zpRsv1l4rI05Ii8mXd52ucw
         CK+xEBLrvAhnttPArV1xrrGrmOmUEPHf9svnbV+VbJXuZWsb0/+niZ1X5HYCsaKiAoKu
         r5d7BhOrxqSShvA728f9VawWElGawpqef14vxNHyh+lc2pkaviE7a8Qx3izPK2q/RAK7
         ajnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793278362; x=1793883162;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zf2xViTkAeLxB49iEkeFNan7sx9Snfm1yj/XBegFK/Q=;
        b=g+Eq3qFgHRN/NHNEHu+tyNvHI5OxpJ5wtgoiWJsOIYXOeiikT/OGu5Pr9qzYCyk1qg
         77vOsVHZuOvUEoW1nWetjZy7yvc//FmkwLOmIpS/LkA2b0sXARlicBhM3oV9C3JY3SJC
         6EhwLJS4gzsbwl0a+1uVvXAKaReCTFUHMO3FgG6gOn9XusyOFqwhP0dHaiZEEBkF4op5
         mXDd0Pt8okyhHyGw6kzo9Ay+SIE0s/c8SdovXTrHPF8rvgiKJ5EHClLTZRSJzE5tteSx
         60uYux3/QnAmK97x01Gyg/p/5i0oei9I0yMBBxZnJr9hiV4ab7Nyu5ptkMlEP/11evp5
         2C2A==
X-Forwarded-Encrypted: i=1; AKwUvBxG7rKHO6sg7Hxs9RwdJgT12dxA1bioiSAD6Qky/p4/XDdJ2FMCEH3jUgqPzSTW7M8VlC2iPQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLcHTtsnYdKV0rYOQ1soqBtbApfLnpZ/al5nIP1yxPzPKhHou9F
	0irlp4V+SeevqIjsG5U4K7Pz0lw8H41AYobRe07RzLMvqnQcd5xSIB+HOI2kv801NCe8uAg6h9Z
	nYRjCK6gOkyNwZg9FNbE3xyp60CuMHB4G2++6Nhk9
X-Gm-Gg: AYBFou1dlSlcYHZ7kSSKCPXDtG2nfDDzWrvNG2WhoSv0FmMgdgNiqIUFypBAqaGoTne
	jFX1J7yeNTmpn5mQI3JVJ9qtxlzMp9RzKY3uNr+gkUhjsN02+PKjt5a/fhol6qaaR7AmAwRYrcB
	OYCayyqSFY7b2rMYjhuivNIuxWRmMZmOWuw5q2vepNVEpX/j/LAZ5Q4GwIlKAePJACIIlh2/VvU
	6N5dLZhn7OR2jyG2sSeoHIiZDBB5La6m9ZrDFccUHlMvDrjc3cdbzCPoa8zc0sWE8Pf45jg1nGc
	QuNmw+pIG0FjPsafW5VnerEpNKkvj1ZWKEyZqMhm/f6B2LJIKOgJK8kPXEJ1FpycWvGqu+aaaTP
	uErWaArDdovGkzvm8h429YJ2u8i2ENNhMR9b0rk0saMR/DufsTqmjzhonWgsoPajJ6A==
X-Received: by 2002:ad4:5747:0:b0:91b:9496:6a18 with SMTP id
 6a1803df08f44-91c7d1ae53bmr83041376d6.37.1793278361370; Thu, 29 Oct 2026
 05:52:41 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 05:52:40 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261027154649.91571-12-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com> <20261027154649.91571-12-griffoul@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 05:52:40 -0700
X-Gm-Features: AclHuK85LBuCmtDdaaOWg4OEyIMQUVa8mDtLyPY6JdCBNPTut6N07RXjZEiRQWQ
Message-ID: <CAEvNRgGn09qrCZjUM5sdqQohPWE62GN4c52iK7ZV_gi5wro_Ww@mail.gmail.com>
Subject: Re: [RFC PATCH 11/14] KVM: guest_memfd: Add kvm_gmem_restore() for
 PFN mode providers
To: Fred Griffoul <griffoul@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Alexey Kardashevskiy <aik@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, 
	Ashish Kalra <ashish.kalra@amd.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, Bill Wendling <morbo@google.com>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Connor Williamson <connordw@amazon.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@kernel.org>, 
	David Rientjes <rientjes@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Erdem Aktas <erdemaktas@google.com>, Frank van der Linden <fvdl@google.com>, 
	Gregory Price <gourry@gourry.net>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	James Houghton <jthoughton@google.com>, Jan Kara <jack@suse.cz>, Jianxiong Gao <jxgao@google.com>, 
	Joerg Roedel <joro@8bytes.org>, Joey Gouly <joey.gouly@arm.com>, 
	John Starks <John.Starks@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Stitt <justinstitt@google.com>, Lorenzo Stoakes <ljs@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Michael Roth <michael.roth@amd.com>, Mike Rapoport <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Oliver Upton <oupton@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <shuah@kernel.org>, Steffen Eiden <seiden@linux.ibm.com>, 
	Steven Price <steven.price@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Tarun Sahu <tarunsahu@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
	Xu Yilun <yilun.xu@linux.intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, x86@kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Fuad Tabba <fuad.tabba@linux.dev>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, llvm@lists.linux.dev, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fred Griffoul <griffoul@gmail.com> writes:

> From: Fred Griffoul <fgriffo@amazon.co.uk>
>
> A device cannot fault, so when a PFN mode provider gives frames to pages
> that had none, or makes a read-only frame writable, a subsystem that
> maps the file must be told.

Totally makes sense that guest_memfd needs a way to actively map pages
into the IOMMU page tables, rather than passively like for userspace
page tables and stage 2 page tables.

When the memory is owned by guest_memfd, on a to-shared conversion,
guest_memfd would do the mapping for IOMMU, which can't handle faults
like Stage 2 or userspace page tables.

> kvm_gmem_revoke() does not fit: it would
> zap the guest's and the VMM's mappings and reclaim frames that a guest
> may already use.
>

I'd drop this paragraph from the commit message, kvm_gmem_revoke() is
the complete opposite and isn't a candidate at all for the goal, which
is to notify importers that a page is now available (and they can map it
in).

> Add kvm_gmem_restore(), the counterpart to kvm_gmem_revoke() that the
> sample provider leaves for users that cannot fault. It only updates the
> exports, under the shared invalidate lock.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
> ---
>  arch/x86/kvm/Makefile       |  1 +
>  include/linux/guest_memfd.h | 37 ++++++++++++++++++++++---------------
>  virt/kvm/guest_memfd.c      | 35 +++++++++++++++++++++++++++++++++--
>  3 files changed, 56 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index 25fb3d6e2032..3255280884b5 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -63,6 +63,7 @@ exports_grep_trailer := --include='*.[ch]' -nrw $(srctree)/virt/kvm $(srctree)/a
>  				-e kvm_write_track_remove_gfn \
>  				-e kvm_file_to_kvm_fn \
>  				-e kvm_gmem_revoke \
> +				-e kvm_gmem_restore \

provider --1--> guest_memfd --2--> IOMMU

2 is definitely required, but why is 1 required?

Between the first .get_pfn() or .lookup_pfn_range() () and
.put_pfn_range() or kvm_gmem_revoke(), the provider should consider the
memory in-use by guest_memfd.

When it's in-use by guest_memfd, then guest_memfd should use --2--> to
map into IOMMU page tables as necessary.

When it's not in-use by guest_memfd, why would the provider force it
into guest_memfd?

If the guest VM knows that the page is now usable (some other
communication channel), it would touch the memory and do a .get_pfn(),
that would be successful this time. Perhaps that's when --2--> needs to
be performed?

>  				-e kvm_gmem_export
>
>  # Force grep to emit a goofy group separator that can in turn be replaced with
>
> [...snip...]
>
