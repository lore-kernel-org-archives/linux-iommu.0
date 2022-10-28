Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AE212286
	for <iommu@lists.linux.dev>; Fri, 28 Oct 2022 19:12:51 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id 21so9244923edv.3
        for <iommu@lists.linux.dev>; Fri, 28 Oct 2022 12:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUVwjtsAbEyzghccJECNwNsjlSoqmLTE2vHEiHldKUM=;
        b=CkF81J/bLhvEkbgXDZGNJrKhZjbpw+En5vy4szWyGlma2xmTKHj5xj9sZzF5Q8OWsc
         X/636m+maiTax3O8F/vnzePPJ+ep/UPQtYyXQRhxy6oRL6BaETpoXRxf1ljWNYZh6CFK
         2wAcy6JjIS5d4JaN4blaIfzXY3ksGwPhPrE44iAXEbyBqBdiN7EXrHJE2AoMGpw++KaB
         ATi151tirBbCWy7f+OYD6hoPFbYlqeZBf02NlIlvuyWBxXIZXdrJzn/df1+qIyPZGP8+
         pgMCUhO/un3a41nf6CmoyGdHEpDTI6gAQY9WE+vGWvxYZs1bZScdTCWZPL4EIgdetta/
         kW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUVwjtsAbEyzghccJECNwNsjlSoqmLTE2vHEiHldKUM=;
        b=7j0jMia05m54RjrbUAInvT2T3kt1L61SmhNpqMB81z84OpIFBk8gdoD9rF9YhWRDF3
         aJVxS0cRe/JWhqM1v8CbjsMeD4hMV2OwNlKHpKXxqqwQu7OiWMlulQykOXlj4DPfHBnJ
         7A475aYFs3zvHrG2bDxpWtiw+7QsVptEHtF75w96hl4Nj9GdqLkZz/kpI3Ol7May1Ndy
         XMLMdRoi4yKi/jR/2rMnxFx/Qqw4BI2yzU6hdt+ZiMAJq6R9bfzh9cYKL9ktsQ0UKteY
         J3QKTYIeHqXitEJdsp+0LiBICn9BurHEBzxdTXhUUioQU0p2ITbWdaJhKD4nnSfSHQX7
         zd8Q==
X-Gm-Message-State: ACrzQf2PDdKWYE0dcTKVg9kVGaeouNSB/S7eW33TJisQFPiuj3/9bK7P
	eZxDE840pcU5pC1Z+z2sK79uVw==
X-Google-Smtp-Source: AMsMyM73CJQV9riRlOH59LzJeHaMT4ntFQfG7aPZVrY8/uEhUdNtkiyoiLeQF8sy6jwfL8NE7PaAfg==
X-Received: by 2002:a05:6402:847:b0:453:943b:bf4 with SMTP id b7-20020a056402084700b00453943b0bf4mr886550edz.301.1666984369908;
        Fri, 28 Oct 2022 12:12:49 -0700 (PDT)
Received: from localhost (cgw.msart-bajzova4.ke.cust.o2bs.sk. [90.176.4.227])
        by smtp.gmail.com with ESMTPSA id ky20-20020a170907779400b00770812e2394sm2512302ejc.160.2022.10.28.12.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:12:49 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Janghyuck Kim <janghyuck.kim@samsung.com>,
	Cho KyongHo <pullip.cho@samsung.com>,
	Daniel Mentz <danielmentz@google.com>,
	David Virag <virag.david003@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/4] iommu/exynos: Fix retval on getting clocks in probe
Date: Fri, 28 Oct 2022 21:12:41 +0200
Message-Id: <20221028191243.31721-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221028191243.31721-1-semen.protsenko@linaro.org>
References: <20221028191243.31721-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch reports next warning for clock getting code in probe
function:

    WARNING: ENOSYS means 'invalid syscall nr' and nothing else

Replace it with -ENOINT to make checkpatch happy.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/exynos-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 45fd4850bacb..0d150b383d04 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -689,7 +689,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	if (!data->clk && (!data->aclk || !data->pclk)) {
 		dev_err(dev, "Failed to get device clock(s)!\n");
-		return -ENOSYS;
+		return -ENOENT;
 	}
 
 	data->clk_master = devm_clk_get(dev, "master");
-- 
2.35.1

