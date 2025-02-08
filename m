Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D6633DF;
	Sat,  8 Feb 2025 04:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738989169; cv=none; b=PPMc3Riot19JIvP30ZAI43OAPBdVGe6o1WR96NwV1YpIVCTIXB9+Cp/cv4tJoKutsW3kcThuC5+1ZgiH2bH0ZQHbXnQSjl1cpY2Vn7ZFi/xYKlwe1gv1BU92d9SyX7YMpzFDyPwmwF8m+D5AhPIoL//rWDCeNd3ImZ6dzBAoeQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738989169; c=relaxed/simple;
	bh=wmh/8jYIUYxyRYGpDj0Jb28UtTLUVOJ2/JUbq/LUa4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ91u5LY2Y9ggdZF88OOprgO1lnPBhLWz+o3HThwGcRnZHYfqAZ/SDW/FdXugAOA4k3KN95CDd9DHUoQUOazcvEydiCRwwJV0yrKspFABgyRViU3scaqGJ2KIMR0e29l2IFN1BfiL5Kv/PjNmop8Y5+ynxO5RBPBhLumShmYaAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD5DC4CED6;
	Sat,  8 Feb 2025 04:32:46 +0000 (UTC)
Date: Fri, 7 Feb 2025 23:32:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Dr. Greg" <greg@enjellic.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Hector Martin <marcan@marcan.st>, Dave Airlie <airlied@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>, phasta@kernel.org,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Bj??rn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
Message-ID: <Z6beaw3CPXeXT-W4@home.goodmis.org>
References: <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
 <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com>
 <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st>
 <CAHk-=wi=ZmP2=TmHsFSUGq8vUZAOWWSK1vrJarMaOhReDRQRYQ@mail.gmail.com>
 <20250207121638.GA7356@wind.enjellic.com>
 <Z6bdCrgGEq8Txd-s@home.goodmis.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6bdCrgGEq8Txd-s@home.goodmis.org>

On Fri, Feb 07, 2025 at 11:26:50PM -0500, Steven Rostedt wrote:
> 
> Note, even though PREEMPT_RT started in 2004 and wasn't fully merged until
> 2024, it slowly did creep in bit by bit. For example, here's a few things that
> came from the RT patch, and each was rewritten at least 3 times to become
> acceptable by the upstream maintainers:
> 
>   - NOHZ
>   - High res timers
>   - threaded interrupts
>   - mutex code (yes, before RT everything used a semaphore)
>   - lockdep
>   - ftrace
>   - generic interrupt code
>   - generic timer code
>   - priority inheritance
>   - SCHED_DEADLINE
>   - RT push/pull scheduling
> 
> and more.
> 

Here's a little bit of Linux trivia. KVM was first introduced to Linux via the
RT patch. Because it was such a new technology and they didn't want to break
the Linux workflow, we agreed to take their changes so that they could try out
different methods and have users without being committed to something and have
their changes break upstream Linux.

Sound familiar?

-- Steve

