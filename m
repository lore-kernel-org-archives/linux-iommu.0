Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436FBA32
	for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 21:47:07 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id da10so2816093edb.3
        for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 13:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LsTViMz2hRqetPY4sQxKqb1vlEy1xBU8MeejgMSjr1c=;
        b=gkf8frOWVmniar7ngn/Zq33yG209HWEzVqAr1yTwb3Gui4OURdAjyWRJP9b3m76d8n
         hnifc+WqEM1GMnUvW9ndHnJ6Q2cuKJ0hZCHkFclGxYTSDlypyNkzOru+VCjyGH1Fr0zo
         6Vx8hCsgiWNvsQnTUtamL5i3qi4sFqBggvjUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsTViMz2hRqetPY4sQxKqb1vlEy1xBU8MeejgMSjr1c=;
        b=nbsWXpS3MChLh7nwXKLP/Qqf3/TSW696tuytSauFOXb1IxMAVleid5gky+U+HMcbAj
         C2N9r6fJnoiFimqiF9stUctPHiosvxmmRJkYFe/W2ebm+14wNZ3AVmVMgtV8BPbszz+w
         ojUWMbOU5Tv/jObKJzJjELcRdQaqyJAoUU+hd8nPZ+hhh3NlVJzNDI4jtH+6qwMpgXNQ
         TYv1y8ptGHI62W98nm+NBGtXkHt0SBgraa9my8yRE/IstQzIXqBRvhEfLNjigqiRDCfK
         O2NNsQc3MUuF/vS5lvFM4LwRXXeMIBRfdsKhsRqLtvGgHNFi2wA6684lVVjCL4/jWRRk
         I5zw==
X-Gm-Message-State: AO0yUKUTVzYloBKEcG9IOBW1aclO884OQdGefDxf2V6dj1kDE2IiLyXZ
	VnFcpnD+7bHVt26K+PGq9I2ajw1HbBlheoNa5UYA2w==
X-Google-Smtp-Source: AK7set9hv7RyPesBhHLgax1XgOETkLD9qopr50b35gOJRkiS9Juz5YGs3XbJfxs/KVEs3lvxyrM9zQ==
X-Received: by 2002:a17:907:d488:b0:8ed:e8d6:42c4 with SMTP id vj8-20020a170907d48800b008ede8d642c4mr8988726ejc.12.1677275225024;
        Fri, 24 Feb 2023 13:47:05 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id u20-20020a170906655400b008f2b0c6052csm35961ejn.89.2023.02.24.13.47.04
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 13:47:04 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id ee7so2834681edb.2
        for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 13:47:04 -0800 (PST)
X-Received: by 2002:a50:8e51:0:b0:4af:70a5:4408 with SMTP id
 17-20020a508e51000000b004af70a54408mr3218039edx.5.1677275224153; Fri, 24 Feb
 2023 13:47:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Y/SGAafMEGBn4fWy@8bytes.org>
In-Reply-To: <Y/SGAafMEGBn4fWy@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Feb 2023 13:46:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg71g9S0F8V-=97XQsaf6Edbxhfx-xS+x894w8sMZW+=w@mail.gmail.com>
Message-ID: <CAHk-=wg71g9S0F8V-=97XQsaf6Edbxhfx-xS+x894w8sMZW+=w@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.3
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 21, 2023 at 12:51 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> Please note the first item in the tag-message, there is some potential
> for conflicts between these changes and other trees due to changed
> function signatures.

Ok. I wil be doing x86-64 and arm64 allmodconfig builds, but if there
are any cases outside of that set that triggers, I won't norice.

That _should_ certainly cover the majority of any new code that might
have a semantic conflict, though.

             Linus
