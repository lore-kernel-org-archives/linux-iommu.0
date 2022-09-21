Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B508F5A90
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 16:24:47 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id x23-20020a056830409700b00655c6dace73so4282727ott.11
        for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=IIhmePtQyz8T33+pbjoIxj/dwgnHGLvrBq+uOaeYXY8=;
        b=U/VqAntmt8ExRWsNRYhZR0oaZfqMSxDhubxnGHZSPRrgQiW26iLuvsTs6LtUI+90KI
         MR/9+tEfV6l2HZz9PKe9QcXt27cEbSot0ICn2vHp+Scu+p4Z4fCvFnfO7cPiR7YB20w6
         ICE2BcrAD9m6xArawiTjvB6dFxpzWP+B9KTgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IIhmePtQyz8T33+pbjoIxj/dwgnHGLvrBq+uOaeYXY8=;
        b=dTo3Y2rE/LA4BWfsqS2rHkC5YI2Dqibvg+umNUiJ9b/u/2Brnkqk66xr4/JKxl9UJO
         Djm/tgBHF9mYd13ZdStqpw76YwtDlNujITIoTRLRzKCLXRPybnVsljMjrh5xuA9mhwMY
         cT9sU+l42tHnMJ7N84oTspB4qQ2M5jLwQcepqr33pZKjuY1uNCQNlQnhLn4n2NWVw9l7
         7c1QrqVhkVjgaMb45T1dMf0Rkkcu+YJTu+rqZMGBljSzUcQtDKr2+qqQrTMXIoY5rPy8
         1hqn5NJ5nUIZb98y9P+cZo6EPHMc8gOyHFHivuKtucYAR+wW7xD/yZ9iCS90IZlcF/dL
         e1Gg==
X-Gm-Message-State: ACrzQf0ekcYYtdcM4Tg3wm7eP+DtKJjSnox6lHfr+r0bC+WKKYZWQD6u
	c8EnwEANpNHGokkTcfc+9fILNPhVIKvmZQ==
X-Google-Smtp-Source: AMsMyM5Z2rO7iT9rY/MOMSizEqoMDFhXdZQ/voHFNLPr0Dtg7OcfnRoTMD09FXElHU+/2ni1QtLK9g==
X-Received: by 2002:a9d:4e8a:0:b0:65a:b48:f4ff with SMTP id v10-20020a9d4e8a000000b0065a0b48f4ffmr7179245otk.228.1663777486288;
        Wed, 21 Sep 2022 09:24:46 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id a19-20020a4ab793000000b0047271772dd0sm1188409oop.19.2022.09.21.09.24.45
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 09:24:45 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id o64so8657168oib.12
        for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 09:24:45 -0700 (PDT)
X-Received: by 2002:a05:6808:11cf:b0:34b:8f4f:314b with SMTP id
 p15-20020a05680811cf00b0034b8f4f314bmr4299822oiv.126.1663777485133; Wed, 21
 Sep 2022 09:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2b0ca6254dd0102bf559b2a73e9b51da089afbe3.1663764627.git.robin.murphy@arm.com>
In-Reply-To: <2b0ca6254dd0102bf559b2a73e9b51da089afbe3.1663764627.git.robin.murphy@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Sep 2022 09:24:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whdwG2LaaktZTYab2JO2TkPYEmSc-sOJ=qL5wtOWpRpKA@mail.gmail.com>
Message-ID: <CAHk-=whdwG2LaaktZTYab2JO2TkPYEmSc-sOJ=qL5wtOWpRpKA@mail.gmail.com>
Subject: Re: [PATCH v2] iommu: Optimise PCI SAC address trick
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 21, 2022 at 5:53 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Per the reasoning in commit 4bf7fda4dce2 ("iommu/dma: Add config for
> PCI SAC address trick") and its subsequent revert, this mechanism no
> longer serves its original purpose, but now only works around broken
> hardware/drivers in a way that is unfortunately too impactful to remove.

I was going to test this, since the previous version failed for me.
But it's based on linux-next, and I didn't want to fight the conflicts
(including - but not limited to - the header file being moved) so I
dropped that plan.

If you think it's worth testing on the setup that used to fail, and
you send me a version that applies on my current tree, I can do so.

               Linus
