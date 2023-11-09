Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5270138DDD
	for <iommu@lists.linux.dev>; Thu,  9 Nov 2023 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZCy7fBZ3"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so2318618a12.1
        for <iommu@lists.linux.dev>; Thu, 09 Nov 2023 13:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699566450; x=1700171250; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=57/MzW+inXIQgaszl6DSxcjhZsZp6Ijm+kZhgGNRRf4=;
        b=ZCy7fBZ34K4SILsbWvR9m4uVVqLazqssyfdLn0ic/o4SYljZ1Ki+RpjTmIyd0oxRMT
         f8vMwnE5B4PvC+IvkISo1pPHiFs2PvHnFrWAEBQCQwyauN3vN0ALbAcBb2LgDjZ2kQeT
         tO0dBZyg2JqD78GPRuSb5O9Jr/QptUQvNZ8uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699566450; x=1700171250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57/MzW+inXIQgaszl6DSxcjhZsZp6Ijm+kZhgGNRRf4=;
        b=f5mk1Gh5l1M6SqMLnJfv6vZqPICx1ho5vs8Y/aGTiVP4ybiGHC5m4EalynMqJYP5GJ
         SkS5XloJxn5SQGRwOT5gC5Vjc/Ce8HBAr8H48OSNq4KQxSckr5V5th6z7kuRtDKUOGhs
         MOAAxKxdtVWLL9NVeRgp7iPrGnCXKQ0JPtGoQRvYQ+v1Uf9zDIFj5vjB38PV+e1EgWkJ
         65JILFoe0IS99i6Ee+9aBXpl0Boesbr+K3nnj61tssf2kcTXqEzAkcHr5+gjwaGr8aRS
         BKUZHQ2Z/t7mq/yvZu7u5LV27Im6G3/myVudD8qAqqLfQnuIRahROOlYfy79srOPEnW3
         H8Ow==
X-Gm-Message-State: AOJu0YyL84H30t6+SUsEvs+5IXvh8gAqkLnoZbyGobA6CNawsKYfJ8ey
	lvDlxgg4sG+x3q7Vqtu/t4m8wbqrZnTLLHUX3aJQoQ==
X-Google-Smtp-Source: AGHT+IG+YE1dayHUpXCtZNdjMU+BXaEOL6vMwgghzwx4h4WCwzEocNwFjZdk0haRgCnFApD+0jP2xQ==
X-Received: by 2002:a50:f60e:0:b0:542:fb42:3631 with SMTP id c14-20020a50f60e000000b00542fb423631mr5088104edn.0.1699566450074;
        Thu, 09 Nov 2023 13:47:30 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id o21-20020aa7dd55000000b00543525d9fddsm306761edw.21.2023.11.09.13.47.29
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 13:47:29 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so2297295a12.3
        for <iommu@lists.linux.dev>; Thu, 09 Nov 2023 13:47:29 -0800 (PST)
X-Received: by 2002:a50:cdc4:0:b0:53e:2e74:7e0c with SMTP id
 h4-20020a50cdc4000000b0053e2e747e0cmr5745536edj.24.1699566448940; Thu, 09 Nov
 2023 13:47:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZUkXojmVf2CmkXHh@8bytes.org>
In-Reply-To: <ZUkXojmVf2CmkXHh@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Nov 2023 13:47:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHyBy2Mttaj8kySJBpZ9hUiCe09ZJPo8trCRHfhi7NBg@mail.gmail.com>
Message-ID: <CAHk-=wjHyBy2Mttaj8kySJBpZ9hUiCe09ZJPo8trCRHfhi7NBg@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.7
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Nov 2023 at 08:43, Joerg Roedel <joro@8bytes.org> wrote:
>
> There are conflicts with the current upstream code, mainly
> from iommufd changes. My resolution is attached.

Hmm. My resolution is slightly different. In particular, in the
selftest code, I removed mock_domain_alloc() entirely in favor of
mock_domain_alloc_paging(), the same way commit 13fbceb1b8e9
("iommufd: Convert to alloc_domain_paging()") did.

That not only seems to logically match that change, it also matches
what I think Jason (cc'd) intended with commit b2b67c997bf7 ("iommufd:
Organize the mock domain alloc functions closer to Joerg's tree").

Holler if something looks odd.

                  Linus
