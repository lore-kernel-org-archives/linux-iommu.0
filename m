Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42E3D8F
	for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 23:14:41 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id ec43so3387075edb.8
        for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 15:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FDST2wkPRWvHQ65nOtR6NGENXRjzl9toU3LAW8CGWC4=;
        b=CyDDFTt/F3/H13vGxJ3s6LwCojFc9mpfq17dldA6sEdum7g624H4R0/TVod34xyoHV
         SlhlxV/4VNMr6VdCjFsAxcV9WeVp3/5AgPek1VC/0fQFV2gORxj7n5mQ+ikq5wjNjjF3
         dAXFLPG/o7wtN6HbK645i2DBtB5EXJBeFbQzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDST2wkPRWvHQ65nOtR6NGENXRjzl9toU3LAW8CGWC4=;
        b=5hjlhCjU+v9XPs2OlshZXCUOU5I8bgC0gxowGg1T4NGSnI0SDWviX9LK6uir1CCyUT
         lp5QDC0f4yFjRG8cM1IKqWbwmtqhb29ndPcYyBS1mVdwaaB6/oB5i5PtxZmfFwnaZCTH
         JTELMmDYCs3W5LJIfMO+OrRYRuGtHoZD8J/kvI4TlcJ6nvcszyaErHMdaL0HoljjXA1v
         Rdw625jraFJ6eVJ/rjRNLqJxabpe6o9giuxBeSEmmNQGyi+chWUnT/tRvAzCe+cmdT7j
         ZZBxANAd60jONyUNRxqYPFPJKUIVh8/M96ObzK3TRFR+gMzu6U6jXq7hfpnL2QyAuYQg
         0yZg==
X-Gm-Message-State: AO0yUKV3LpajZvkUZoGDcPp16GNRT6dzgC1iiBcY/nFRPyMuAm0nT7dI
	rfD5B5wQk+pBGJ9FknqEDly50B1VuYLPTvMIKaCI9A==
X-Google-Smtp-Source: AK7set/YVzW3rwwl71iLn8bMDgcTEPbxhf+7QvjHirvGpm/Wl8ucuZWgZWqGl9N1W/9sTYYoBGEFVw==
X-Received: by 2002:a05:6402:401:b0:4ab:4011:ff3d with SMTP id q1-20020a056402040100b004ab4011ff3dmr16928674edv.0.1677280479654;
        Fri, 24 Feb 2023 15:14:39 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id n30-20020a50935e000000b004af640933desm232176eda.78.2023.02.24.15.14.38
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 15:14:39 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id d30so3473807eda.4
        for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 15:14:38 -0800 (PST)
X-Received: by 2002:a50:f694:0:b0:4ad:6d57:4e16 with SMTP id
 d20-20020a50f694000000b004ad6d574e16mr8362677edn.5.1677280478558; Fri, 24 Feb
 2023 15:14:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Y/SGAafMEGBn4fWy@8bytes.org> <CAHk-=wg71g9S0F8V-=97XQsaf6Edbxhfx-xS+x894w8sMZW+=w@mail.gmail.com>
 <Y/k1pGjjRIznCIu2@8bytes.org>
In-Reply-To: <Y/k1pGjjRIznCIu2@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Feb 2023 15:14:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg__gUh4gSVzCJqoCFMDiiQRDRuBaX=Yhra3=mxb7uSHA@mail.gmail.com>
Message-ID: <CAHk-=wg__gUh4gSVzCJqoCFMDiiQRDRuBaX=Yhra3=mxb7uSHA@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.3
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 24, 2023 at 2:09 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> Aside from the conflicts with upstream, which I resolved in the merge
> commit, the only other conflict that Stephen reported for linux-next was
> in the rdma tree, iirc. So fingers crossed that this is the only one.

I suspect you mean rpmsg, not rdma. Because I just pulled the latter
with no conflicts that I can tell.

            Linus
