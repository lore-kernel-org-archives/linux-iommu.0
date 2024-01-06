Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C85E523E
	for <iommu@lists.linux.dev>; Sat,  6 Jan 2024 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oubAGR+z"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4297c79f732so97171cf.1
        for <iommu@lists.linux.dev>; Sat, 06 Jan 2024 00:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704531085; x=1705135885; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iCsV72cag3qoM2HUBF6xbU+vCCYedwftXxFg335ucq8=;
        b=oubAGR+z1YTcvxDKc+fiOZ/XhYCPu/JGKVJAzvRl2WxFLOuhf1mUgZy/nSqA/ztqmW
         dCfATYg/sw2fBB3erJfOnXZQ60pUYFcezHaCd+WhhGM3tyY+Ey0yJw4x2OPiIwj3s/pX
         UGKHuSHiX92sUpEK6cmR9I4ZqZ2ds7Xecq3YfBLycAuHhJOX4emSdHFNSNTZtnbZhrBO
         MDK/Q0L9vnBaV8d8j3Fv2nW/l10wVuQCaJzE1i91DRKgQXDgA33o6VWXrnjZ2WOhdQTN
         4/bs8tZlDpjKnGMgNbaD6yU3ttNqD4mT5F1aKptfunQmF3v6jqqs8mpNz3tKw/ZiHBMC
         eurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704531085; x=1705135885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCsV72cag3qoM2HUBF6xbU+vCCYedwftXxFg335ucq8=;
        b=iG6MUDdw0vUDaRl8QQHpAX9iONrQNodmydlnQqCP6o8iXevpdmRAOEb3i8PycmPwGl
         HDi2v4qXTEEPFxLAzNjQgji9SMK5jnCRZFwzU5i9kPxeeqdF4mLdk2kat5351ceT3yLT
         EQr0sQvifXZW456q3JpHe6hAjo5e5UcWeI+75CCW1gm3BdF+bpAyU9n9bFy7hQ0ilz1H
         BScnUQ8JZpuXBoyrJ8w9LUxSLlUDTt38OVSqwELixxt3DVETs4+3NYZtqxwpTt+S1WEz
         GhvkmU+6GTWdHMrx8g6+Xkav3szV7KBeVC0vkJbu2dE3kVolGNm1gMsUAXn3iUxyn1UJ
         3bHg==
X-Gm-Message-State: AOJu0Yx6v8cCa0YD6HB3Bw3gGvS8fIL0Xl1MXJuocLAoY/MSgAqBIYv+
	YyngfmkcA7w664AFn64SAJaO09U4o+kpZYA1HEM51O0V8iHs
X-Google-Smtp-Source: AGHT+IHwkdLFoBNekYthSqYuPImkD/vNJoOBMFQ6v+xyvlCzJpMFGKjt8OXJ0MzCabOEh1MJYOy+pR7NQfc/o3h1LQg=
X-Received: by 2002:ac8:7d41:0:b0:429:8163:54a2 with SMTP id
 h1-20020ac87d41000000b00429816354a2mr76737qtb.26.1704531084767; Sat, 06 Jan
 2024 00:51:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231020113918.GD3952@nvidia.com> <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
 <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
 <ZX7xu8jN/rBZ4A/d@nvidia.com> <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
 <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com>
 <20231227154648.GB50406@nvidia.com> <CAKHBV26yjLu-EUoBJT8EL_EbLE5oqLUL-_hwh2YDp2JH1EyAMw@mail.gmail.com>
 <20240102144814.GC50406@nvidia.com> <CAKHBV26TD-gzv3dB8VkGSJ9T8rrynPa-DL48s_VzfF1xb7xQjA@mail.gmail.com>
 <20240103175043.GS50406@nvidia.com>
In-Reply-To: <20240103175043.GS50406@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Sat, 6 Jan 2024 16:50:48 +0800
Message-ID: <CAKHBV27FxaSsm7nPPR9RLSfVQy6X-b63ZN-Fg88iyStkJw+uHg@mail.gmail.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming independent
 of the callers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

> I'm fine with this, if you think it is better please sort out the rest
> of the bits and send me a diff and I'll integrate it
>
> Thanks,
> Jason

Integrated and re-sent the 3 relevant patches; although git-send-email
gave two of them a different subject so they may appear as a different
thread depending on your email client.

Please note that I didn't update the commit description on the two
patches that you initially wrote. Also note that the Kunit test patch
does not yet add tests for any CD updates (outside of generic logic
which is shared with STE update). I'm on vacation for the next week
and haven't had a chance to expand the test coverage.
