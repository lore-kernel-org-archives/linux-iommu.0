Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21043CF1E0
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204292; cv=none; b=GuqNtlR0yw+VhK2ODt0nW3uq8qVBnkiQ2+nKJwfeEmawv69YSzJ8WQjLGtB0VDH3l66paTtdoqO7D/iQLfpZFVrpUbh8T7uqHapE8N5ijCo0xap4YvI3tH6hjC3azWLJFucnKXopsveQCY9S+mAFhpblIRtU5kMVz2nlHX5fxrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204292; c=relaxed/simple;
	bh=/NW10gd3XiJjasTwnvkAvxDjB+x+y0bolKqdPwKnlUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEtNxGyZX8usSsjK8Lb2um2gOzJI0vykzYyhEeUu/7B6zVXtchnqzpmpQLovE6eguYotJOCWI6bAaakRKOKsuu/0Kqnsn0MvM0BgQz2f/0cLqNmXgDP5AVxQEYTIWeSKeyEIYcV2u+36nhvklfXEtkLvl3SG4jUcNban2fGHE0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIMJcLzg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIMJcLzg"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so31490865e9.1
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782204289; x=1782809089; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cd5zggzn9YY/eKp5MGwYc/7RumCc5LCFsD9dus6MWn0=;
        b=bIMJcLzg4lj+Zhu5cb67c18YJM0BdimkgcyCgU1LYf1vhNth++asH/h+gr1L98drvV
         GZNasFfTJL5oqbBBPwtNOFXqYmkcuvxdX/skjZio5n6sX3YsXrwXX4OyUuOa7CbHZwlq
         qvqpY6z3Yirh66hAChJqV/mwKpB+gUfcFmuEXklb4/XYFxaCNu8gVs1TwQbjm7pAz1Tl
         2X0g+rx1BsS5z8B6Q2TRZQn/6dMTZS9lvReMxPlMuL84fYszQrvgaVA7ELsBslvm7QVq
         vN+ZvOiydtLcSyd5aECHyan2lD9djr/ZdmJFzORur8IMreKhSNXJLTsbHslTS8J6inKS
         H8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782204289; x=1782809089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cd5zggzn9YY/eKp5MGwYc/7RumCc5LCFsD9dus6MWn0=;
        b=NIuzfPdJQP+9f4xT+zJIGy8AexAxrHlfoMhSLDoU5QxTDdO7ggCTEpRWpruTW9zBEa
         NEx6zB6YpxWmvAhUa5HtbluJ3qQV0L7l7ifCSS5Lvl4GT+p+LY2kcXSJEn8bFumcBNGY
         e6Aw0dzQgDkV/mWiSMyIbTDIchReotHX/NM/7JBoYS7IzimgaIPV2Sdse9xqai7T7T6u
         YSzzZuzhN1JD9eib+vZpJ4dwjVHCCTkdKXspoE7JI7XEYR5kLVgF1tYa9eXW4bvXMyqQ
         MWzoejfD7HJajFAd0y18dN6ycUSTHcEt3ArsIJ0dJvQmqa08FxqGttOJanvrq2a7/cus
         HAfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8LgrWHWVNHRDNJLW6OafwGbdo7IuAr/B50zrNn8HrlztXLG1ZRhOiOjr8df5ZintrybOyWSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YztpcGyaOYoHlyJzRtyZ4/swTLxjoPw4y7p6O2P20cR3lVkb2mJ
	GSI6r+WlSJlDgpjlfNdXpENYB2hHmOr8pNfEleNTIqgqMZRqx1MxtGB1
X-Gm-Gg: AfdE7ckut9OlW1bxR8OHFkJP7KjcEj2vhhGvf9ifxZAk5tJH4CXf1us4JXZXBkXmyDm
	WakgF/0AOemfHNYzXB65Q0pbg5Mrmob2Zg2G1218UK9OvJbECSBLinFV3cKxVxX5978UEs0jEul
	rg69hhjjcp1+m7TvrPqHBnd733bl4zXy+XUIdQpsmAYFKfU4v1Eyee5rihkcZLbCcaYjdu7Zr81
	tyql/XaGoLw+nG0zc9FlCmrBCI68o3zhfyZT9SlScvFCIaTVCYLOE4ENl0HVZf1UpEqYScBa0ih
	H0Ndpv1QxVSNp6CVkALltekKd5Ue0yVQseTkoYxuEV1Po9pb7bHNsuHZjJGcYG2e8aSHKqCsXyB
	8N4xK2K2P5/R8gTRs2BNKLXcp5xxZFoHjaWJukyVhIcLpWwvgTeWs8qhXu9UVBOfm6zVSjNrICZ
	8Ab3lwjSZtEPLiXAhAHihSEvty/CeISWfERc82Y7oxGzbGsAIRdQ==
X-Received: by 2002:a05:600d:640f:20b0:492:408b:d267 with SMTP id 5b1f17b1804b1-4925b394574mr18459465e9.13.1782204289054;
        Tue, 23 Jun 2026 01:44:49 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923392dsm530639635e9.2.2026.06.23.01.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 01:44:48 -0700 (PDT)
Date: Tue, 23 Jun 2026 09:44:46 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Hu <xuehaohu@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen
 <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Kevin Tian
 <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com,
 praan@google.com, kpberry@google.com, chriscli@google.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <20260623094446.4a8fc2ed@pumpkin>
In-Reply-To: <20260623015459.1153884-1-xuehaohu@google.com>
References: <20260621222130.1667453-1-xuehaohu@google.com>
	<20260623015459.1153884-1-xuehaohu@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 01:54:59 +0000
David Hu <xuehaohu@google.com> wrote:

> Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> first entry, resulting in non-page-aligned DMA addresses for all
> subsequent entries.

There is a separate issue of whether this code is even needed at all.
Where can transfers over 2G (never mind 4G) actually come from.

The read, write and similar system calls limit transfers to INT_MAX
(even on 64bit) and a lot of driver code will need fixing it longer
lengths are allowed though.
io_uring better enforce the same limits.
So the transfers can come directly from userspace.

Not only that but you also need a single physically contiguous buffer.
Good luck allocating that!

Now maybe there are some peer-to-peer places where the large buffer
is device memory, but they will be unusual and probably need
special treatment anyway.

	David
