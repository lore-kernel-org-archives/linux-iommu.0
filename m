Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A0B28FE
	for <iommu@lists.linux.dev>; Sat,  3 Jun 2023 16:50:07 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f619c2ba18so767722e87.1
        for <iommu@lists.linux.dev>; Sat, 03 Jun 2023 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685811005; x=1688403005;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Za3JwyNUM6yl+naXXldCKnK+dNxMe8IEOxSvG25sGMY=;
        b=CFa8OLiG1JnXPIPGzSSp/ngDXZ4zVzuJxC4CfuR+sVhHchzZHZ84MDX8KWIzZv6qMm
         97HB7CuV6aUG/l9wMTNB8C6DF1STGQzuFhMtLa30hrxR/e0g81HNxFWBloZaRosnwDol
         8OT1DZlmQS0/uk9SO+Gkrt1pk+Zjop8P1jFgHYdF9qDgTE+5oqrWjMYep+GIMSGmUtOC
         XB+Y0bbm7hFKVw9qTA/N8fcrVczoLQT08pzjtWg0e9y1QzZpgChCjc7OMVMlFu76lJpp
         FnD5XlqfnnHacLNDk/OCraJO+v+H8Uz9xMvHhJn/2aaxuGNPGAN0f8pxPo/17pULEM20
         pT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685811005; x=1688403005;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Za3JwyNUM6yl+naXXldCKnK+dNxMe8IEOxSvG25sGMY=;
        b=jsnVy4f9JXuXcU0cun+bmvxJl7U6NWseBhuqIpKoX/MoBk1gYQ2Rj6UuqSBGUC1Som
         PU78v5aWFlA5b4HI7+mOFzwmi7ZUnzReuD3nd3INs3n5PObA4iLcTecc06KkGOmNVwel
         ii09SPvgpzPNT5ZbBNfJ+vVsxdDJbcA8fWLMKZzPHCX9Egj7RPHgTqBz+JXbCAMoiE4M
         fvqumpHU9eQ25t4H4l0acI1GDLOpKr/2/jMuW0R9eMnprlXlicac9i/Y0j1oTKWTVmpk
         LFLowq6K+DXMJ/Pv/eIwCHqeRdEsNInRtZU82YYKSM3xfMe/7roICwfa3k5HWrBmgZBx
         pMNQ==
X-Gm-Message-State: AC+VfDzrIBcKZnjivvVX3iaCt0Ola7lQh6/OmY+lXOjesUHL93jIT1GZ
	k5PvxCkLD/lPtNnpGwPq+l9S95njxnS2xBodDh1YQHEi8v2pDw==
X-Google-Smtp-Source: ACHHUZ5l4REtX6hh1qWMMeKuTdQzEOs+ieQxI1/xuYz4YE8DO0EXqNcz0JzhMgvbcrdSYNJBdIQLGBpoUzJzv8ZXs0g=
X-Received: by 2002:a19:ee13:0:b0:4f3:b520:e0af with SMTP id
 g19-20020a19ee13000000b004f3b520e0afmr3402100lfb.13.1685811005335; Sat, 03
 Jun 2023 09:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Chathura Rajapaksha <chathura.abeyrathne.lk@gmail.com>
Date: Sat, 3 Jun 2023 12:49:53 -0400
Message-ID: <CAD7mqryC_JROVXY9eD--iigjCU9266+ufPvZO2BujhVfM7qYfw@mail.gmail.com>
Subject: IOMMU software bounce buffers and their overhead
To: iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi All,

I have a few questions about IOMMU software bounce buffering.
Description of the kernel config IOMMU_DEFAULT_DMA_STRICT mentions that,
"Untrusted devices always use this mode, with an additional layer of
bounce-buffering such that they cannot gain access to any unrelated data
within a mapped page.".

What I am trying to do:
What I understood from the above description is that the STRICT mode
provides an additional layer of security for the hardware IOMMU.
I want to measure the overhead of this additional layer of protection
(software bounce buffers).

My questions are:
1. Is my understanding correct regarding the software bounce buffers
being used alongside hardware IOMMU, or do software bounce buffers replace
the hardware IOMMU?

2. Are untrusted PCI devices use SW bounce buffers by default in the upstream
kernel?

3. Are there already available numbers for the performance/memory overhead
of software bounce buffers?

3. How can I enable/disable software bounce buffers without
enabling/disabling strict IOTLB invalidations?
Details:
Since I want to measure the overhead of SW bounce buffers, I want to
know if there is a way to enable/disable only the bounce buffers while
keeping all other configurations the same. Any suggestions on how to
properly measure the overhead is welcome.

I tried to find answers to these questions in kernel mailing lists and
documentation but I could not find the exact answers.
References I looked at so far:
https://www.kernel.org/doc/Documentation/x86/x86_64/boot-options.txt
https://www.kernel.org/doc/html/v6.3/admin-guide/kernel-parameters.html
https://lore.kernel.org/lkml/20190730045229.3826-9-baolu.lu@linux.intel.com/T/
https://lwn.net/Articles/786558/

I really appreciate any help on this. Thank you in advance.

Regards,
Chathura
