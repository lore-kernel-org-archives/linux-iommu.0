Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F9C25C6E6;
	Mon, 10 Feb 2025 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216957; cv=none; b=bLRX62C5npQFSjbDmFHNnTtzb/xQo4uWPvYq/+a59S2hWsr1RYd8IlqKW3gbr4sIZyWhj/vVF8T4L3NCN05dZedZzzp2J8mmEXofpINevmptyzFOpBfA76tTo8J8xjMbGwUz+CSj0k/2+asxb14KjbQJmCjHAOCXKCYHTcjRXDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216957; c=relaxed/simple;
	bh=Ty6k5I1/hnJTjgA0qZmIAImp0Z7XZeXOKWP8irziz4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDrlpN/kUcahxr413cr1GNbBYXbvqxi0Bt0G89cU8ubXMBuK5r1QPQn/lHn5AUwmONL58xY4FOHgeaq23te1HUem9gnilkMeKIg3yQHx9GmGi+HMKFjRTDk5QIcqDnnYr7MAqOBoxy0zk9P7sUbsL8xAosy3CvvxoV3tds6zHX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5de594e2555so4912725a12.2;
        Mon, 10 Feb 2025 11:49:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216953; x=1739821753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95fC/C95p1+hJwvVm5h6wvO5Q4omEjar82baF+zynPs=;
        b=Hc2Lb5XxwXfOXBNVFeLafcZH4fxKO5cd8rrFMvtFFGh2mQs5OCcVVxW3wHvzzH1lwl
         MDeggNApY5MTtYhms9oZtzw0W4b7cnCZK9mCsyZf9kszw6K/ygAcRn4Aij6RKJo7WDE9
         h84+oVQjTaGhmvrRUWpmdeaId6u5H/wYigH5hxL9lbWAsGrEI0F1Y/4Nvn6EYR85e7fH
         EnLVmDHvLj4f8kS/UW3g40RYwLoPC6dwWalGvZKvR7nmRxI0hVQMMEvO/wu8R5BwCrYY
         q3UarGEB6lhZdEXywNzdTTN+l2MEzr3dCaXGLLWv1wyud6428Lw8omG3Sc6RpagXsdTO
         kUog==
X-Forwarded-Encrypted: i=1; AJvYcCVgA9zHN8s2G4MifsPUrni/AX+9S/Fd9HOF6DECDpAFQCtrkrJq224gaLuy1yb+IJ66a57gzxE=@lists.linux.dev, AJvYcCVnYuUPDsTrz5PphaNSOtOJl4Gkhmv+WaD6cXxH4a/u4ZJE2k5oZzCpOGKGajIZgiz/dawN2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJjJiQuCKA7CWN9lJe31kY595rpy5TFtYnc5x+k/xL9SidmxA8
	O/nIkn3n7AloYGN8vUw5xVy7binzW3YgPX62FLxf8EreSTaNqlEBXjSc1wOsb/E=
X-Gm-Gg: ASbGncuemoqOmEJ9sQGUCz7V3xV4PHmDEyQGN9Tm851hmUJxRzNffuIQ1WqyygER3Zd
	yXc1cKp6Xnu0n3r0KZ7LIsv6RoQNKoXjtsJYmluX058/p3Wq/BtyDzdXY5GH61lMYbBrVmVoef+
	DxTebh8rKGNXRBJ44Ro1IAgiahmC/MUS9nfbi/ZdVLh3SP6zbCA1oRg2aEeR4KO3PCUGa/FnZmm
	q1UQjhInXjd/VrJfmAykL0f/eNFHVUq5AxC2sHieCWWxvHsW8Rfwaipk1KAzNTkJxdldT/M0SmP
	7lUYBdj2ihdaIRJlI9uF8mOW6sIOGHASObR5ZUyPtPsOww==
X-Google-Smtp-Source: AGHT+IHoX/uYw3YN4dYm6jpyyi9dl6DRA0TaT3bpL3AWIxwXOWvPjFWq/uIqGutRYm7nomVjvHZF+A==
X-Received: by 2002:a05:6402:5290:b0:5dc:ebb8:fe64 with SMTP id 4fb4d7f45d1cf-5de45019313mr16194293a12.14.1739216952988;
        Mon, 10 Feb 2025 11:49:12 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de59f893ebsm5723258a12.45.2025.02.10.11.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:49:12 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5de77a5d2a2so2777993a12.0;
        Mon, 10 Feb 2025 11:49:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPHK8PdQUXv6JsF2LSCJVDPSKNuxBJ889Jj1cHk6P57ofqxhMI1wYe8zFNItYawxuDXPHDz54=@lists.linux.dev, AJvYcCVgwdzn0C6yCHmJVGAz/sySM4Uk7OAUNwCo+p+9sPjidJGbO99yza0UwH+QWfLfhX3FGjFCfg==@lists.linux.dev
X-Received: by 2002:a05:6402:2106:b0:5dc:a44d:36bd with SMTP id
 4fb4d7f45d1cf-5de4500274cmr13498767a12.8.1739216951504; Mon, 10 Feb 2025
 11:49:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
In-Reply-To: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
From: Neal Gompa <neal@gompa.dev>
Date: Mon, 10 Feb 2025 14:48:35 -0500
X-Gmail-Original-Message-ID: <CAEg-Je9BskhHuehHLES=5WNPk2jjd=38207XsfEmFDMiF=b0bA@mail.gmail.com>
X-Gm-Features: AWEUYZnvFQWMfElhV3JVfcrxv5vOkguawqzwZra2J81VWXgm4X-CWu02f7-pmbw
Message-ID: <CAEg-Je9BskhHuehHLES=5WNPk2jjd=38207XsfEmFDMiF=b0bA@mail.gmail.com>
Subject: Re: [PATCH 0/5] iommu: apple-dart: Support locked DARTs
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 2:44=E2=80=AFPM Alyssa Rosenzweig <alyssa@rosenzwei=
g.io> wrote:
>
> Some DARTs on Apple SoCs are "locked" at boot time, meaning we cannot
> write most of their configuration registers. Currently, we refuse to
> probe locked DARTs and do not include any in the upstream device trees.
> However, the DARTs used for the display controller are locked, so we
> need to handle locked DARTs as a prerequisite for a KMS driver.
>
> This series teaches the iommu/apple-dart driver about locked DARTs,
> preparing for a future upstream display driver. It has been extensively
> tested downstream with our work-in-progress display driver.
>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---
> Alyssa Rosenzweig (5):
>       iommu/dart: Track if the DART is locked
>       iommu/dart: Skip reset for locked DARTs
>       iommu/dart: Set DMA domain for locked DARTs
>       iommu/dart: Reject identity domain for locked DARTs
>       iommu/dart: Assert !locked when configuring
>
>  drivers/iommu/apple-dart.c | 47 +++++++++++++++++++++++++++++++---------=
------
>  1 file changed, 32 insertions(+), 15 deletions(-)
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250210-locked-dart-d7ece05f19a8
>
> Best regards,
> --
> Alyssa Rosenzweig <alyssa@rosenzweig.io>
>
>

Series LGTM, having looked over this many times as part of kernel
maintenance for Fedora Asahi Remix.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
