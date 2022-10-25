Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6A27479;
	Tue, 25 Oct 2022 16:54:39 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id bs21so6256837wrb.4;
        Tue, 25 Oct 2022 09:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/ULxq2EdVWZOhwK21JX/tvDkCGf2dqu3n7qEL+lTOY=;
        b=gWB9UysqAbqOPf2utGCOJH9LJdHOTVvaB5IzqXJ++K/yLuCOmVzCGmTWOlhFwGnNZ0
         /1dY+xVgUo+QcHKWnYnpR5lT0jOKo+LhbGfj7zACigig7IiRakyNWEOebPeyBRg9NfRa
         gFWh5ww9Y0Jc+XhTLLpQqIOM21QcG72QsPGe+gi5I9OSY0fVe2rKCalR6BMzhJwfZ91Q
         Zgmp9N7XliVwx3Ml6S9CO1NA9AbKpCiYuL+qAWLMxnMXHUnEb69TTsEaOEJ0njKBXIrq
         NtiigBcNGVlOe3WJ7lJgbHvYDnRr3BeFTzYElFREinnm+LCJ0/Resp8Sv5GGG8mgsqVG
         ANjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/ULxq2EdVWZOhwK21JX/tvDkCGf2dqu3n7qEL+lTOY=;
        b=ciOs7b6hAy6PeeHbHLcnzPFiPgeomXaOIqmLdktAyoSbtl+X5luqPoJED2pbRHK51d
         4Vd3Md1F4JnoPQUEjCLTtV06bTRNMZMTGU3qm9EZhpdIm1YYzAap6pIL35sg1TASVdii
         Eaal6OuAEz9omkHrHjUV4yrfCdNMpdVyFb0+iRhmRfTJZFljDpnzk8Q2fd/O9OhcWZr9
         eSbMGsexbpe7VXhT+9xmV3+vc9X4eLRLIQHxKyNO0fUEDhAWCp/ul1EXUgITCGpU5AD3
         1/0WWwDaUUMQUX7e6gFQfhs16US47GEtJ5MeWWerQ1VJv4B9n0ja6YPO8HmBtW8xMmBX
         iiXg==
X-Gm-Message-State: ACrzQf1LVKOsx0xzcLwo1ZJaPZbF1c/nr/4o8Hjr+A1KF6VF2qttAGDy
	BWVwnR77DjxqGFzbnzM1FQQ=
X-Google-Smtp-Source: AMsMyM4V89EQvtcJaplOO/9x329iSAUjR7qxmdGlVdpsRjAzRPe8F7TxA5tDAipFjnBHO1jzESd3aA==
X-Received: by 2002:a05:6000:1c0a:b0:22e:5d8a:c903 with SMTP id ba10-20020a0560001c0a00b0022e5d8ac903mr25013588wrb.182.1666716878012;
        Tue, 25 Oct 2022 09:54:38 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c349400b003a6a3595edasm3023989wmq.27.2022.10.25.09.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:54:37 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: maxime@cerno.tech,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: wens@csie.org,
	samuel@sholland.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 4/5] iommu/sun50i: Fix flush size
Date: Tue, 25 Oct 2022 18:54:14 +0200
Message-Id: <20221025165415.307591-5-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025165415.307591-1-jernej.skrabec@gmail.com>
References: <20221025165415.307591-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function sun50i_table_flush() takes number of entries as an argument,
not number of bytes. Fix that mistake in sun50i_dte_get_page_table().

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index df871af04bcb..e62e245060ac 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -512,7 +512,7 @@ static u32 *sun50i_dte_get_page_table(struct sun50i_iommu_domain *sun50i_domain,
 		sun50i_iommu_free_page_table(iommu, drop_pt);
 	}
 
-	sun50i_table_flush(sun50i_domain, page_table, PT_SIZE);
+	sun50i_table_flush(sun50i_domain, page_table, NUM_PT_ENTRIES);
 	sun50i_table_flush(sun50i_domain, dte_addr, 1);
 
 	return page_table;
-- 
2.38.1

