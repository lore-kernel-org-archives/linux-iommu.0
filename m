Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460CEA939;
	Tue, 14 Mar 2023 20:15:23 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id x13so19643683edd.1;
        Tue, 14 Mar 2023 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678824921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOERF+jCyt6cMLRNcuzDfYHf9edQe6iKfmTk13evlgE=;
        b=AAj+e5IIgIccY1twGYsHPNoORZcdlYW3Rx1rQW/alPuaVuGooEwW2bykJEcIYTbFGt
         OyDOEmDWuHvVGB9cCPI+DaKdclt+pSBfPRV0/zunyYa6S4bA36AT0jO63wQtE+Ihd87D
         GLW5eq4pfVTn86QBtqYQVneVgR3McQ0YWojYD+LTg0WT5Kzl327rg8J6EUSUMqaeLNPI
         y/JKNIHsDqZmeoT8u4/7Rjp+W1pzZy1sIaotANbKBGHnXRzJMA4a36FYaXszRB8a2+QL
         3YYZhyyQ1Mkhcw1d/dcKfu+ggNpjRMdN4eXPIUSOSzh44CgJfNtwTC+XYAvm9LBXKeQO
         QTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678824921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOERF+jCyt6cMLRNcuzDfYHf9edQe6iKfmTk13evlgE=;
        b=gKR7u86Ghsd6kr6vHQOSPHOECuDHhBaadA+ZGEvc+KmvWSKeoYNNKiEddosDONacLk
         g/8nG2HTNkPboYELpcspgRwQTydBWtiIbIVmTbkLYtEuyUW2Mi/ItAGt5/Tg/q1cyMqu
         c2I26o7o4QNX62PVmhzlFdbM+LwFCWC4iZMDu7d4OyP37MYuzmEVV7NOlN3obLyQbWr0
         HlW2+xcc9WFSnZU6zhdhbNigcJsyIUsURd6TMroJPvtKDes0l/v8xmTPmBL32Q4J7DVY
         2pcbSLaH7MnfOqHrHw/GOvu07uvN1aI2wH5EuO/MS0WTZ8963RHOj/juVku9JjCC+m9m
         4ArQ==
X-Gm-Message-State: AO0yUKWWHmSVcMbVbIBqgwQx/8r5DFBQBLmt2okEpW3B1TUdmQ/vwNHw
	1fQd2laCGLxhB9XTWrCt4Po=
X-Google-Smtp-Source: AK7set/sMm0YjG7LDT1uBapw5l8BoDwtxlSY3JrUw3fv9um7gVJMKXwWuCWON77Fb1UYIhJnPAPx3w==
X-Received: by 2002:a17:907:76ea:b0:928:9add:3f20 with SMTP id kg10-20020a17090776ea00b009289add3f20mr3871873ejc.61.1678824921286;
        Tue, 14 Mar 2023 13:15:21 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id jz14-20020a17090775ee00b00926f89e2213sm1527267ejc.190.2023.03.14.13.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:15:20 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: mcgrof@kernel.org, Nick Alcock <nick.alcock@oracle.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 07/27] iommu/sun50i: remove MODULE_LICENSE in non-modules
Date: Tue, 14 Mar 2023 21:15:16 +0100
Message-ID: <22999869.6Emhk5qWAg@jernej-laptop>
In-Reply-To: <20230224150811.80316-8-nick.alcock@oracle.com>
References:
 <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-8-nick.alcock@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne petek, 24. februar 2023 ob 16:07:51 CET je Nick Alcock napisal(a):
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: iommu@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev
> ---
>  drivers/iommu/sun50i-iommu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index 5b585eace3d4..63ac9d15b859 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -1077,4 +1077,3 @@ builtin_platform_driver_probe(sun50i_iommu_driver,
> sun50i_iommu_probe); MODULE_DESCRIPTION("Allwinner H6 IOMMU driver");
>  MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
>  MODULE_AUTHOR("zhuxianbin <zhuxianbin@allwinnertech.com>");
> -MODULE_LICENSE("Dual BSD/GPL");

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



