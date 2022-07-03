Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1171623A4
	for <iommu@lists.linux.dev>; Sun,  3 Jul 2022 10:47:22 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id x10so877803edd.13
        for <iommu@lists.linux.dev>; Sun, 03 Jul 2022 03:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=xtZe00jcrHCWayegr58xFfUp2h3js8Bof36AjGw58FU=;
        b=LHTZ6sd9Ylw0mhtbQPt/yWf3J9vu7LgLvrQ2hPvUPpfNDO/Mv4xdqmhAlOM4oVSz9+
         yP+pH7VDq5J0bfVfFX/4ofM9et9VoauQO6/67ZpO5wlZ7/nxqo8QY/sZW9qbGIMFESzJ
         y2GhjpLU1+yjhJ3o7oruqb/tO9oUHnpq3BD1WJwxTuMrbGBwkysz2KQxInZkjmd2+HKo
         9hnAbYIlJrkOlO7IkbhGKjceeqBoVi9MdS994NI3MopaLTCo2YpYK4VAArGhkCsc/AN0
         scmcnr6I9vskBSXS5H3VqnLI42uKWD0fhbgUMkZD+dkgc7swGyy/1Rn/cwisYL3CB/z3
         es1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=xtZe00jcrHCWayegr58xFfUp2h3js8Bof36AjGw58FU=;
        b=5MGDB1BDoIF2V8k/QPx/KOTMWU6ho3l1nGgfx7e6mzBEtAOw6QgW35f2da+cknv3SC
         rN+lggA7ZjEHTNRlZSCLvEb838D+aVSTaQV7J6pK5c12o7Sg3rFedotLfiNXRynYpqix
         1kwhmSmng0aippgoYavpuKINQwXvw1swvuV/Uh/TpTvaXC9EQBZMGTbmmEHXrGpE2sXq
         FdOJNXH0i978Q5VT9bJlOIa5Dj9ARE52QSBG/65IC9LAJDhBJs7+pfNBkPvE7mCfm2+Y
         7bsA+3TFwlKaDSE4DiywNXFuFo7emvzuT1dBGVbv7rGw4PL9S9X/xxc6SDx1cEMDi5Tv
         i9tQ==
X-Gm-Message-State: AJIora/WoNEIiaaq5HcnzbZK/zwAK2fhVjMDUytflNGH5nbSM44dZXno
	OPD+CsCBEL2KuzJSx0nU+IY=
X-Google-Smtp-Source: AGRyM1tGVPJyIq3szdnRuDtIIMLXe+/hYDrptJIGBirIXbjThF7HJVmbD5r7tXNhzxzCPtbySChhdA==
X-Received: by 2002:a05:6402:1e88:b0:435:bf05:f0f with SMTP id f8-20020a0564021e8800b00435bf050f0fmr31256381edf.2.1656845241327;
        Sun, 03 Jul 2022 03:47:21 -0700 (PDT)
Received: from ?IPv6:2a02:ab88:368f:2080:5d6e:322:57b6:5f03? ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
        by smtp.gmail.com with ESMTPSA id kw24-20020a170907771800b0072a3216c23asm5791972ejc.154.2022.07.03.03.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 03:47:20 -0700 (PDT)
Message-ID: <67943ec4dcfe85d6d616a5507437d99f6c5638a2.camel@gmail.com>
Subject: Re: [PATCH 0/4] iommu/exynos: Add basic support for SysMMU v7
From: David Virag <virag.david003@gmail.com>
To: Sam Protsenko <semen.protsenko@linaro.org>, Marek Szyprowski
	 <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Janghyuck Kim <janghyuck.kim@samsung.com>, Cho
 KyongHo <pullip.cho@samsung.com>, Daniel Mentz <danielmentz@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux-foundation.org, 
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 03 Jul 2022 14:47:20 +0200
In-Reply-To: <CAPLW+4kYbG7PRYo_L6N5xMa+F9DFBpyph4B+zb2R4kBbE3EKHg@mail.gmail.com>
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
	 <CAPLW+4kYbG7PRYo_L6N5xMa+F9DFBpyph4B+zb2R4kBbE3EKHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <20220703124720.zFh-pS2Be3AeJ45DG8qCmb9__3pXLK0S210pm4bmEa8@z>

On Sun, 2022-07-03 at 00:48 +0300, Sam Protsenko wrote:
[...]
> Hi Marek,
>=20
> As I understand, you have some board with SysMMU v7, which is not VM
> capable (judging from the patches you shared earlier). Could you
> please somehow verify if this series works fine for you? For example,
> this testing driver [1] can be helpful.
>=20
> Thanks!
>=20
> [1]
> https://github.com/joe-skb7/linux/commit/bbadd46fa525fe1fef2ccbdfff81f7d2=
9caf0506

Hi Sam,

Not Marek here, but I wanted to try this on my jackpotlte (Exynos
7885). The driver reports it's DPU sysmmu as version 7.2, and manually
reading the capabilities registers it looks like it has the 2nd
capability register but not the VM capability.

After applying your patches, adding your test driver (with SYSMMU_BASE
corrected to 7885 value), and adding the sysmmu to dt, I tried to cat
the test file that it creates in debugfs and I got an SError kernel
panic.

I tried tracing where the SError happens and it looks like it's this
line:
	/* Preload for emulation */
	iowrite32(rw | vpn, obj->reg_base + MMU_EMU_PRELOAD);

Trying to read the EMU registers using devmem results in a "Bus error".

Could these emulation registers be missing from my SysMMU? Do you have
any info on what version should have it? Or maybe some capability bit?
I'll try testing it with DECON/DPP later and see if it works that way.

Best regards,
David
