Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24BB3D8F
	for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 22:51:05 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id o15so775421edr.13
        for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 14:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XetVmJJp94Tm+T8Ok6omBAdD9XAfcZ6uupziRkiZMk4=;
        b=O992ZC0d4Fin+fSMDEuc/r4oFcV7GuLj9xW5Jaak+IJxNIGgsgHvuvCcZiaX+GMlBS
         N776OX1MKa2ocMIExB/CvqrGqgUncIQxhKN3EjfIdflSlixcjzb9Pf0PvLdScnculsFz
         Jb+JalT+9UXEQKhI1dBBcBnwv7Q14O8TVsOwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XetVmJJp94Tm+T8Ok6omBAdD9XAfcZ6uupziRkiZMk4=;
        b=d4Dc+oDDj3FYOPU0PK6eyA/bfdTjNbQoZlTdjzvhlfMwetgmdtJsBQ+Zty5BvoAXuc
         z5PQzpk3XjeZ79NB0enOvg/2yn9BWXJ4X5ykW91sTmdsaXmip07xG52j/ixpBbsnPfC/
         5oDNdp4/tFXlriens/Ozf1XL/M6fL8qarLY13xmrIDWlQT/NCR9/4ehcG6eScuJMht//
         GmhAOn80bp6qlZ3B/2mhowqFUCwa4Oh/WbtcN1heKJEs39FhuybmQMNefLKhxdtkPaVu
         D9/HK7BUHJLipN2RO3aAYTn590C8jGmI8Ya/v2unpLoXcWjZXaPsEKH/VXSCU7YCAm/L
         aXGQ==
X-Gm-Message-State: AO0yUKXB9/fRg84Btw8tUh1zNoY83gleNnoWO8CMLl6XzX8rHAi/0Sk2
	EmdSgTE8WjSKXNYjAeejaO2BbCtmDugSviRzHkgHOQ==
X-Google-Smtp-Source: AK7set+6+NiP5RioIaQD1kyBw8vrEpNh7Xrm+krtchYOdNm0j4hocPlHPgUXOGmTweLIP2ReHVGz5g==
X-Received: by 2002:a17:906:6c99:b0:8b1:2998:6474 with SMTP id s25-20020a1709066c9900b008b129986474mr24542478ejr.16.1677279063738;
        Fri, 24 Feb 2023 14:51:03 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id la13-20020a170907780d00b008eabe71429bsm94913ejc.63.2023.02.24.14.51.02
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 14:51:02 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id h16so3167958edz.10
        for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 14:51:02 -0800 (PST)
X-Received: by 2002:a50:9fae:0:b0:4ab:4d34:9762 with SMTP id
 c43-20020a509fae000000b004ab4d349762mr8258013edf.5.1677279062350; Fri, 24 Feb
 2023 14:51:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Y/Tlx8j3i17n5bzL@nvidia.com>
In-Reply-To: <Y/Tlx8j3i17n5bzL@nvidia.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Feb 2023 14:50:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiy2XRdvxchyuVYJJ618sAcGiPPam14z8yAW+kyCzgPmA@mail.gmail.com>
Message-ID: <CAHk-=wiy2XRdvxchyuVYJJ618sAcGiPPam14z8yAW+kyCzgPmA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 21, 2023 at 7:39 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> iommufd for 6.3
>
> Some polishing and small fixes for iommufd:

Hmm. About half the patches seem to not be about iommufd, but about
'isolated_msi', which isn't even mentioned in the pull request at all
(well, it's there in the shortlog, but not in the actual "this is what
happened")

I already merged it, and am not sure what I would add to the commit
message, but I really would have liked to see that mentioned,
considering that it wasn't some small part of it all.

              Linus
