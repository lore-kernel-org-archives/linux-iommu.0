Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EE9271446
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043460; cv=none; b=YU3a9dWYyeWNxS804E/e3lij7GJ1Csieaxd72gPPVw9ParcOlPjjDz5C3PkWihJuG5tA/lGarJYN720lI6gtGepr4kSiaYHV+WqWHTnsVzFqODaoPQy2Fidv8NY13LYtM7DR6fCNJj5onV6MQJYLrkl/2waJrkrzGlv2+wX3COE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043460; c=relaxed/simple;
	bh=LQSsB569tHq9VHJp+YT8YnS0khI0VrYJiQIgsLVhLoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fG6ZpV2MTglSHGTf2lrEaN7ZDcsOIJKUwwCHASIWXU2iZ/Y7Zir0MvxJfWZRE69+IoO/med3G1KLxd4iNEvN+kNuVxocjrY3ebzwzOsw2Aut51i/o5sXHcuSaCElc+xfwv9HpVbBp9tAbKanHH9MM3kY7nTe7PARFOt/WiHekFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7ss6q7D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7ss6q7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABE0C4CEF5
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 06:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752043459;
	bh=LQSsB569tHq9VHJp+YT8YnS0khI0VrYJiQIgsLVhLoc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m7ss6q7De+/JMiUBKhr67WAAtz/Y6KPLPyZqQLNGkzeOocZsXvvLYVFH4/z99nChn
	 p+n+Mib6h/7wWFtu8+JvW6jhRxmymr3dIaFUAjE7VkwhFYsYitLBcoHNqc5vFcKasK
	 JrS/+L/G9YQWZr5viPl5HTLFoFFAfNNjwoe5c/fsyjhtEbKBBPDz/YlyvPB2YQXUsC
	 ywdZkz5eZ6NaY+RQN2la1AZOhqsyuZK33GLhkvgKnQ3ZV9gBx4NhnQFAB0D4LCC8tJ
	 XMnHsBfSXBwobGgi31Ep+h40IeNtkLEqqV4AScsHQ39aM+pUBJ+wiBNekbEghXMFb/
	 IbZ56cTvswgBw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-611a7c617b4so1476896eaf.3
        for <iommu@lists.linux.dev>; Tue, 08 Jul 2025 23:44:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXljVcSqbsQVlR1NJm15mn6uONJTnBfuQXIL/5Y8w4PC9KhopLt/d0IJRTeGE8yXJmVUKyjew==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZvosTO6YTxKuKnaRx+U1F2luEvzed5Aylx+NzaLh4DdlBLFGG
	gShwg1VZvsdGtxwpEd5o1ACgjpiMHxcaPLrfO2N5QCGlr4PERzfkEq4u7bfthLWjTzT19c3SDBL
	5zL6H3MxqNn6CVGnu//Pkollv1ffVVGI=
X-Google-Smtp-Source: AGHT+IEkc2wWAPLGpA+Df+Dz37BSSMGKPeqko3TaQhV1Kpi9RBTLw+UEgZfZ9QlXSIhRPHBowtulwpEGSU/cNLmOgok=
X-Received: by 2002:a05:6820:308e:b0:611:7626:b5df with SMTP id
 006d021491bc7-613cce21f05mr727326eaf.4.1752043458974; Tue, 08 Jul 2025
 23:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616203149.2649118-1-praan@google.com> <20250616203149.2649118-6-praan@google.com>
In-Reply-To: <20250616203149.2649118-6-praan@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Jul 2025 08:44:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jq7DL4z+q5XKcVUZQgojcxA8DgrMFncs1Z6skm+PVEmA@mail.gmail.com>
X-Gm-Features: Ac12FXxSUcWrE2HT3j7kB_3BQQNWKtuP4_KiX1Fd83rawnvAir3er_hbKdTPKMM
Message-ID: <CAJZ5v0jq7DL4z+q5XKcVUZQgojcxA8DgrMFncs1Z6skm+PVEmA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/8] pm: runtime: Introduce pm_runtime_get_if_not_suspended()
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 10:32=E2=80=AFPM Pranjal Shrivastava <praan@google.=
com> wrote:
>
> The existing opportunistic helpers like pm_runtime_get_if_active() and
> pm_runtime_get_if_in_use(), are too strict for certain use cases. They
> fail if the device is in a transient state like RPM_SUSPENDING, which
> can lead to drivers making incorrect assumptions about the dev's state.
>
> These helpers don't suffice for cases where one wishes to elide HW clean
> up like queue flushes or TLB invalidations if the device is powered off.
> It is wasteful to wake up the device in cases where the resume callback
> resets the device well OR if the HW resets in a clean state. Thus, if a
> device is powered off, it is preferred to elide any clean-up HW ops like
> queue flushes / TLB invalidations when the device will resume afresh.
>
> Consider the following sequence of operations:
>
> 1. The device is in `RPM_SUSPENDING` state
> 2. The driver calls pm_runtime_get_if_active/in_use
> 3. Depending on these API, the driver elides a HW clean-up op like:
>
> if (pm_runtime_get_if_in_active(dev))
>         invalidate_tlb(dev);
> else
>         // Skip flush, assuming device will fully suspend
>
> 4. Now, another rpm dev-linked device wakes up, causing the device's
>    state to bounce from RPM_SUSPENDING to RPM_ACTIVE without invoking
>    any rpm callbacks, preventing them from resetting the dev correctly.

This never happens.

If the status is RPM_SUSPENDING, the runtime suspend callback will be invok=
ed.
