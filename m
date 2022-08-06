Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186C37C
	for <iommu@lists.linux.dev>; Sat,  6 Aug 2022 19:40:13 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id dc19so10163592ejb.12
        for <iommu@lists.linux.dev>; Sat, 06 Aug 2022 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tOIk9T3mrJJ6IuQUCBUTAzpxYi7UFUGbDAWnXcWZxT0=;
        b=ePpuRMrAKZw1DYzxtcv62TLH7DJlO326HoiUxhmUAzA0zfgGb9NwLIsmbLIB9w4L4t
         ZXCv3JltfSSLzfVDQ9mawK0U1XXajiwv0n1F9aZrD2MWbobLvwCn2dQOKWhc8634emfq
         xfx/Bf9l0Lc+eo4FmcJeKFU/GH/mTNAF1yLWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tOIk9T3mrJJ6IuQUCBUTAzpxYi7UFUGbDAWnXcWZxT0=;
        b=Hp4XXNqtNFUf13e0GFYA6Pqo5v51FsmzS50dsC5pquQYBBz4YNleLIJJrVQC4r+rZ/
         yoZR/SaTCX1rdvxc6dOVdFkoHin0vkX1JMSB7aREoz/mp6xzBWzac8F9ccl26wUrEGDK
         vj5zoGv8fMk9uCNvlGgW6F3QWdM9szll7nDYTH+koaW4OSWAXSjsWEKYOO78e3gi06P/
         PCX8oJtS9M6SlF5FNkHT4lhwHrIyGE00UKoWoBDDU2mArQyIaHsF5lw5JiwQZvHrAk5x
         tKuV764r9aRKHwa01pYvrx08Cv+fsogZ+bTQabytHp/5+oD8HGLzhW1GDVe3dSM101j/
         kMWQ==
X-Gm-Message-State: ACgBeo2+Sym/EWI2fdUHHfMjWDk0jnCm0WFU7f+IqrWjrRM1vXQA+QZl
	1afA3tlL2njDf2E4ttkgjX3tpRa99zO33xA4
X-Google-Smtp-Source: AA6agR6svMi1u6gty8q1vX5BnJytsLZy8iCn+/rgihukmVphiMLYUboy00eQKCp6R4Qivmcyx+QUWw==
X-Received: by 2002:a17:907:2815:b0:730:a098:725b with SMTP id eb21-20020a170907281500b00730a098725bmr8974921ejc.642.1659814812055;
        Sat, 06 Aug 2022 12:40:12 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id b4-20020a05640202c400b0043a6e807febsm1935722edx.46.2022.08.06.12.40.11
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 12:40:11 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id z17so6654714wrq.4
        for <iommu@lists.linux.dev>; Sat, 06 Aug 2022 12:40:11 -0700 (PDT)
X-Received: by 2002:a5d:6dae:0:b0:220:8005:7dff with SMTP id
 u14-20020a5d6dae000000b0022080057dffmr6988390wrs.442.1659814811001; Sat, 06
 Aug 2022 12:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <YuzlAT7RW1U36+ap@8bytes.org>
In-Reply-To: <YuzlAT7RW1U36+ap@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 6 Aug 2022 12:39:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whs5CR5FRZP_HUksrr9wX6=Rai-S_XTUFJN7jwB5wKN-Q@mail.gmail.com>
Message-ID: <CAHk-=whs5CR5FRZP_HUksrr9wX6=Rai-S_XTUFJN7jwB5wKN-Q@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v5.20
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 5, 2022 at 2:38 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> IOMMU Updates for Linux v5.20/v6.0:

I'm currently bisecting a boot failure on my desktop, and it's gone
into the iommu code.

I'm assuming it's the 64-bit thing, but I'll bisect further to make sure.

If it is, it will be reverted as hopelessly optimistic.

              Linus
