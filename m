Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0507D3644C6;
	Mon, 11 May 2026 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483942; cv=none; b=pyPPdWD8I23Wqn2Q7dx3wv98Tx80yHRwsLawXV/hwQNrFtAOzLrsM9HiO4ghuKFU+WiJlHKlOgJ13xLvxsmgmZO8Py6KA0niF5MMejzyOcsoFWr0gIwx9RczkZjxOy5AWhppXKsu7pTVdHRzOZ7RjTMQGormYefoA7R1AGiSM+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483942; c=relaxed/simple;
	bh=YlUMgn6eywvdd+m8xsMAbtxx9sf3bufm2FHgr9rZp3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q9IFv+DmrtSaFXvbMJlc3TDRpO4rjfQWnQ0OOMrquBYpC0dNgngZs6auW0Bxwt1iaVSdRoZFMSqUez/iSGIYnx1LCDwOG/T16BiWqJMr6NITCcDM0+wC84e/5PyKMBPA3huMhL8b6M1YKmyFGlcO7/gDp+2a49AsiV4tFsrHgd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZLZ8ena; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZLZ8ena"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9B6C2BCB0;
	Mon, 11 May 2026 07:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778483941;
	bh=YlUMgn6eywvdd+m8xsMAbtxx9sf3bufm2FHgr9rZp3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cZLZ8enaAWGNplfv/sllWtTTdqqOopEt9SagU5SvHYtu+YhhmJ6L5MV38yCV8xdOh
	 tOq3m0MhsVCh1TXf5xoDyo8Hhu4O0edW2pIYvYIGzTKbyIa/v+K8/MkIxT7dfzIifE
	 OuBzUF9fKGxnvADk7ZSTFglT/lV8fBmlte+XYLsJdNXqhCAAi4vBMtpwsCdsmGtIVH
	 wKICPKqVWmJVdI9nke9ZXmKOlHZi+WrSkrv9lTKGKbz71YzKV8hMCwhphqTzJcA9l1
	 OrouE6dPUU60X6Gnitry1EJxX76p9mw7VHTX1tjpZR/+utMy/HOCMNrmE/SkdS25QP
	 P7VvP8B4sjK7g==
From: Thomas Gleixner <tglx@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg
 Roedel <joro@8bytes.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] [RFC] debugobjects: avoid gcc-16.0.1 section mismatch
In-Reply-To: <d52dcd45-959a-4ff4-9e82-0bae133785f1@app.fastmail.com>
References: <20260203162406.2215716-1-arnd@kernel.org> <874ikf9i34.ffs@tglx>
 <d52dcd45-959a-4ff4-9e82-0bae133785f1@app.fastmail.com>
Date: Mon, 11 May 2026 09:18:57 +0200
Message-ID: <87y0hq8lcu.ffs@tglx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 11 2026 at 08:17, Arnd Bergmann wrote:
> On Sun, May 10, 2026, at 21:31, Thomas Gleixner wrote:
>> On Tue, Feb 03 2026 at 17:23, Arnd Bergmann wrote:
>>> WARNING: modpost: vmlinux: section mismatch in reference: lookup_object_or_alloc.part.0+0x1ac (section: .text) -> is_static_object (section: .init.text)
>>>
>>> From what I can tell, the transformation is correct, as this
>>> is only called when lookup_object_or_alloc() is called from
>>> debug_objects_selftest(), which is also __init.
>>
>> So clearly the compiler is buggy. It creates an __init specific copy of
>> lookup_object_or_alloc() and then fails to attribute it correctly.
>
> I don't see what else the compiler is supposed to do, it has no idea what
> __init means in the kernel, or what the rules are for calling between
> that and normal functions. Putting a non-inlined lookup_object_or_alloc()
> into a special section without an explicit attribute would clearly
> be a bug.

I agree that the compiler does not know what __init means, but this
sucks as it leaves an unused copy of lookup_object_or_alloc() around
after init.

What happens if you mark is_static_object() with 'noinline'?

Thanks,

        tglx
