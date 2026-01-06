Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B46306B11;
	Tue,  6 Jan 2026 06:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767681592; cv=none; b=CU63avmPc5VayLUn6RMxNTYAmtdoDl/u/yKuo4WNhMNCBbzhpcJbYUts4v2aJqIs8hOskJnJh0xNT5dQX9VDZmPhQxq5niLysw6kToW2R5cda4CeCvNw8ok/W00P6bBHKUloLHRhxqFSp9ALb8RdokrHTae/auL7hOWwhmNxiNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767681592; c=relaxed/simple;
	bh=BN+TWnmNdOA+F/DmI99DzHmyTksArNl2AaNzWqG3JK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H3bR4Id6U/ud9PhreXzoHJItMW2wJULCV0AK2ZzrOaBstmFNUHZMxNfRp3Qtvk8GjbfeqyOgV/2J4sapCQq4xLmAX9wZ0I9ODxRHcdnQwhmv1pmmt/vIPz2ZeskNSoWK9XTBmzaMIJoQSS94aEZq9abiwJSGtUU9Uljk84amCeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa3TqpWS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa3TqpWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EB7C116C6;
	Tue,  6 Jan 2026 06:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767681591;
	bh=BN+TWnmNdOA+F/DmI99DzHmyTksArNl2AaNzWqG3JK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Fa3TqpWS2k1O+lDyc7kHEf8oqN7d1dSAGg2BTYVbxpM7VVxD3jaK/sFr9qnLNvkRS
	 zXBXzfh+6ZmULWWJWF/4as87uTJITNiSde79xH/8V+iTARfzxPVn2vSE0F0aKabLjB
	 Li5C3AjsWItWFjIynmT4eAQIwpid61ufDF8jw5tLyOhrV7eXOJBXA0XlCDnyokE0sA
	 lIxd16gN0u3Q9cPl3uNh8ecFBrO/Gs48S1BPyEqcfht+t6VN/RDopBvEtb9iwcvIQO
	 h25KVLyIqBBRHaUFP/0/X/oErvYjoajq6VwrrrC2ke/yptBAujBC6gYaEjEYKarLGU
	 iRoK3wJZ1KcFA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	maz@kernel.org, tglx@linutronix.de, robin.murphy@arm.com,
	suzuki.poulose@arm.com, akpm@linux-foundation.org,
	steven.price@arm.com
Subject: Re: [PATCH v2 0/4] Enforce host page-size alignment for shared buffers
In-Reply-To: <20260106011143.GP125261@ziepe.ca>
References: <20251221160920.297689-1-aneesh.kumar@kernel.org>
 <20260106011143.GP125261@ziepe.ca>
Date: Tue, 06 Jan 2026 12:09:45 +0530
Message-ID: <yq5a4iozjlce.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Sun, Dec 21, 2025 at 09:39:16PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> Hi all,
>>=20
>> This patch series addresses alignment requirements for buffers shared be=
tween
>> private-memory guests and the host.
>>=20
>> When running private-memory guests, the guest kernel must apply addition=
al
>> constraints when allocating buffers that are shared with the hypervisor.=
 These
>> shared buffers are also accessed by the host kernel and therefore must be
>> aligned to the host=E2=80=99s page size.
>>=20
>> Architectures such as Arm can tolerate realm physical address space PFNs=
 being
>> mapped as shared memory, as incorrect accesses are detected and reported=
 as GPC
>> faults. However, relying on this mechanism alone is unsafe and can still=
 lead to
>> kernel crashes.
>>=20
>> This is particularly likely when guest_memfd allocations are mmapped and
>> accessed from userspace. Once exposed to userspace, it is not possible to
>> guarantee that applications will only access the intended 4K shared regi=
on
>> rather than the full 64K page mapped into their address space. Such user=
space
>> addresses may also be passed back into the kernel and accessed via the l=
inear
>> map, potentially resulting in a GPC fault and a kernel crash.
>>=20
>> To address this, the series introduces a new helper, `mem_encrypt_align(=
)`,
>> which allows callers to enforce the required alignment for shared buffer=
s.
>
> This explanation makes sense, but to maybe bottom line the requirement
> to something very simple..
>
>  In ARM64 the guest shared/private granule size must be >=3D the
>  hypervisor PAGE_SIZE, which may be larger than the VM's natural
>  PAGE_SIZE.
>
> Meaning we have to go through an change all the places doing
> shared/private stuff to work on a shared/private granual size. I think
> this is not just alignment, but allocation size as well?
>

That is correct. I updated the commit message to

These shared buffers are also accessed by the host kernel and therefore
must be aligned to the host=E2=80=99s page size, and have a size that is a
multiple of the host page size.

-aneesh
