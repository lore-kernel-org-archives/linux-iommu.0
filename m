Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB0527281D
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774403903; cv=pass; b=ZaCxRrfk79P538RPDwb8849Tb6265A8mdLZ7PDHwXVDttSy2LZ5S6YP3ALF1F5J1oba/Eo6d639ALgHvu0G58x0M7elVd2x6OgonytkBvxDsICgm2jpdlcTICc6QHk4/gs+aYKUZjnkScnG0hcSJyobc9EZpaEyWC2fQc88hnhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774403903; c=relaxed/simple;
	bh=uATiCdJVNXsXbqp7wQweEzFd+VzHCHpWD2sO0E9ZBl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rp219wbbfM75yZGJ5SUKH+HycZqwb+2eeWhf8hg8g0ldomxITMEgcLS8VBvSBeiBjAUrFX4eWnp0vQzY1+v2oi/7Z0VQtbc3lrjVQUZiAkfwi6OotLApuNRaBMDnBWp88Q4CCmfh++knNZRZ2+8a6RsSIvMKRLsjRkIvPEWqkEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fF8tK2KY; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF8tK2KY"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c0bf0a0236so211831eec.1
        for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 18:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774403901; cv=none;
        d=google.com; s=arc-20240605;
        b=A/2Eh4mkz8pL02BcABNgL+5fFRzj79xJVJoZOq7re+s50JDwznkbpBx58SZ1THWkcJ
         My+vNPSqB4waW1PMz/+CMEW1XRtitLN6H0NHK5s+MXGD9GTdv6KO3vg1AvES6n9tVuNo
         dVa7dN9RQ4bzrQIsmoC4oIWsxfAXaJRuviXdTa9CNN8SoiH+HF/KLuCMV/ytoy8O/rXZ
         lDnbY7KHg+YEwo1y3y/bP+nUsfOKCLt7tKOsbVkI1HrVPP65rTEQXDdYWAWQv8Co4/Cy
         6eWRVHvzz5FF9QADvgobuVtD6YcOlI5ENiMYR6S2ynrkRRTGKeCeVwfSBY6y5TWfkGKF
         sGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uATiCdJVNXsXbqp7wQweEzFd+VzHCHpWD2sO0E9ZBl0=;
        fh=K5f4H9VHhPo18hUEpf/C+skATzT2hl1zIOn1q2TO7Yg=;
        b=IZzZ0UUbxtHabrNKHqGfcIpnEuwrfk/Cv9t8OuPS5s92MLRFi6mde/t5bYoLV4F4L5
         Sx+Nb8q7PBqOU0i3YBTwJcGBsvU8GRc8EKJbhaSdUpiXoA+YRL4KaFH6d4oMI/HMJWcH
         dvWiYfemdr6bB0rtNBlmnZGyyzdhxz1j14w6wAd8EIfPkP0g6G1x1x/5hItAXuixYrRP
         8+zts6pDJDERIOywEOtSANGWGvvEWFFYTyvUReJFWe4oYViFv9kQpto/PNeKedLw4GML
         kcw3T9euzUYOofdQ+8K78Ly4l/FTOE+c5zSOpXNr9pa8YISvevjjQbfIJzYcMporPWPb
         6X3g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774403901; x=1775008701; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uATiCdJVNXsXbqp7wQweEzFd+VzHCHpWD2sO0E9ZBl0=;
        b=fF8tK2KYGacWiRa+AOAUFchvbJIoDiewC5Xtqr75uGO/Jpx5GUuPo9R2nE0PeJYKWg
         xDpwuLB0nq1aUKgRCOe7D0/1P3XA4NOWsqDkq9jFV896BTYd1y9FYilv4veHwKt9ICKd
         VI+LkXFlPDnm1dpxm9Y/sah4DcDcI7R0itqIwBetgtHeLInZEB2joxfe6TF21foB0hUa
         iNJqe0Rw887y4mx/hdaywPvFhXEappGPHD55eXVv99yAZgbpVNPs6xs1z/1OwJceZuC/
         dqSnZxJx9/Z7QEjyojUzzvgeP6lC0gFbrEg4m40mePbGOk7hL108oZIKlyTxuQ4TX3Qp
         H/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774403901; x=1775008701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uATiCdJVNXsXbqp7wQweEzFd+VzHCHpWD2sO0E9ZBl0=;
        b=NF8rno+ckOD2QzmABjSW8zm2brZrRaznyn+n8Gmy/Zi6T6HcEJAOsrRR8WPbBTMW72
         uDymUfrThC9DkD5K/7MkmajpUI+13VLycN8bFnksOHD7Mcjx1IV4/37LpR0ebJAdt0vd
         oTX3HvJx6PUnqgBqNui/Hxd8GB24luTaYLl/PqOTg1vzD1WOGiAHdgwpRIBGFgig3nXF
         DmJ9Hgi44mO7wnzvx24PGCdfpMvpkhOl6HPApkB+F3pKkLOwD28hdtL77jVBIsE+YBRF
         SKPai0jv9NFaaSCoDG7qySF4WRnyDGu+tTBbXKskwJcpWsnYGAIAkNC+e/GJ7iymh3wk
         D5tw==
X-Forwarded-Encrypted: i=1; AJvYcCXaQEe+boIan6wpkRucqScqb41Wcmd0FaM5M9/m5pal8PO/A9cQwcPSMKRgxvNoIMhZba27SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVh1h0A7V61l2dgKhZYkel2IL3WkLByBg+kCE47Bhqq6Rvu7Sm
	ESuOvbnaKAWJrAUKx9qa4Dh7jxUAIOs5olX8O0aGjQi4EdBNT6ZKo2MAZV7CsQjhplBnNMd6xbd
	EEZY2pn0s7wPlvREk+235TETji7n52/k=
X-Gm-Gg: ATEYQzyckPe6yuewZuLJjcdZmPDCBsL43ageR/lpvdMAbTF+lw8xgqJ9jZj0kqUVYnj
	tw9LgnczM2eo6YhV38mYmtPQCgqHkn+8FQ8BVuMQ7w6qvo0JoDSKDz0hpHmBxJ0cvmHPV4mZ3E7
	BRjUbqcrmDEKrTEBlHfgtLrgXzuZIRaf9ylC9qoIqgf3/QewxEOLBxjxurqDpgnMwmtoZK7HlvB
	7LvefKfUPZbaj2SltTVYrmPGoL51Z3DQEcsEfxpWN5DipTuvGPg4OGabLSx8atDzhT05yLvqjD6
	akAw1bLyzCrpQZ402O14U5tHuL9s7+PAfrgPQPVrOooT3ZsD+QF1MTVKZ4ivf/pHLJT1WReFDhr
	6nW1tLyXgvilQhBzrcyHiI4w=
X-Received: by 2002:a05:7300:dc10:b0:2be:298c:a11 with SMTP id
 5a478bee46e88-2c15d3a8a70mr394983eec.3.1774403900918; Tue, 24 Mar 2026
 18:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260322192159.88138-1-ojeda@kernel.org> <CGME20260322194701eucas1p1f72625f53e50806fa4f430550f291e76@eucas1p1.samsung.com>
 <20260322194616.89847-1-ojeda@kernel.org> <1c4e429b-f30c-42a9-8de1-71cb2cbbc114@samsung.com>
In-Reply-To: <1c4e429b-f30c-42a9-8de1-71cb2cbbc114@samsung.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 25 Mar 2026 02:58:08 +0100
X-Gm-Features: AQROBzAYV4sPQIbCVLLNfW-UqAw-p0H5kvr5leqfcWwqgBKVIhpQi6sU039YVRU
Message-ID: <CANiq72=UPiXc7JLracLeC6k45ToByJWZedp3B3j5=5mAnyKZmA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Danilo Krummrich <dakr@kernel.org>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, driver-core@lists.linux.dev, 
	acourbot@nvidia.com, akpm@linux-foundation.org, aliceryhl@google.com, 
	anton.ivanov@cambridgegreys.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, david@davidgow.net, gary@garyguo.net, 
	johannes@sipsolutions.net, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, linux@armlinux.org.uk, llvm@lists.linux.dev, 
	lossin@kernel.org, mark.rutland@arm.com, mmaurer@google.com, morbo@google.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, nicolas.schier@linux.dev, 
	nsc@kernel.org, peterz@infradead.org, richard@nod.at, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, urezki@gmail.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 9:49=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Yes please, this looks like an oversight.

https://lore.kernel.org/rust-for-linux/20260325015548.70912-1-ojeda@kernel.=
org/

I hope that helps!

Cheers,
Miguel
