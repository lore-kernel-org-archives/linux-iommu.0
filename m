Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98DE3D9C;
	Thu, 13 Oct 2022 18:12:46 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id r17so5660929eja.7;
        Thu, 13 Oct 2022 11:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k+VQ8PIgKw2wXGL8CyxmdjJZoYsv8YucY3sAmtvnacY=;
        b=DDVWrlzPxXMsngCDo/QcByWaD1OiWqjlNo0qm2fhXYTe6IpxdiNpfJhoQ/XRHqkNH/
         ZL8aGReXB//kbbUw2a2BpQbb+im3SQb+37YiU6sDPOFlAKSG3BIPbwgt2/nIyQlKaGJH
         uzCbiOq+YopE+Igm4SZFz95FNkQx2jKOZlrXdAdvRC52OhIFclBz7Ejq9Ry5EnUpU188
         taWgVhbhdQTEtx7KNLnZl8GOg+grIzHwF57Bkk9JwW7l+lT8lr7kfOn2yr1YCDW00lvy
         A8vWb9Y58cJMm/F8YEXB5QEawLZN685VujBFaZC76ctrWAr/uUU0GHqJrTOrt1KkmLVW
         qJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+VQ8PIgKw2wXGL8CyxmdjJZoYsv8YucY3sAmtvnacY=;
        b=v1R8I0fcveh2IeuSyjHRWJ1rbiCJ9sBLp7hgYxauk6Q+77o3oLZPrv8UlzBlCHzq0+
         Sny+JAWugkUkPL/ujS6SoliDOp8KKiMAWltrapIYUxazgzWPA/7O3dRff/S9AGyiJ0iU
         8MKfVf8TR/n6/RmEqwNguIyLwwhwRaRWc2UBe2XByWA+zEknWKGpkK4Dt6da80lDzen8
         ARq3asikc5cqHv2FFiPsnXapKU6RUyaR0MGphcStLy8ZZ8aaAszJXG2AZdC9UcbFjC1o
         pG8UTqbHCZOkGAoZiKIejsyfPONBUEbQ820Ng1YuDIXpWTY6FAnMgVryDchbgAEYB69L
         qRzQ==
X-Gm-Message-State: ACrzQf2C1IVlp2G2Un1h3Zt8pA3G67Uys/zOhvoohKbAc/KTPqXNw0d0
	Rn7dXzz13YVpXdA36FsSbzE=
X-Google-Smtp-Source: AMsMyM4ZxITJcZD3wjZMo6kOHrArjKX1JG1U07gSpHUbk5BeHsXrfW0RJfdb/yh86Mr9nLWyjuqABw==
X-Received: by 2002:a17:906:7308:b0:78e:191e:8389 with SMTP id di8-20020a170906730800b0078e191e8389mr759810ejc.170.1665684764848;
        Thu, 13 Oct 2022 11:12:44 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ku15-20020a170907788f00b0078b551d2fa3sm211109ejc.103.2022.10.13.11.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:12:44 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: maxime@cerno.tech,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	wens@csie.org,
	samuel@sholland.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 0/5] iommu/sun50i: Fix various issues
Date: Thu, 13 Oct 2022 20:12:15 +0200
Message-Id: <20221013181221.3247429-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Testing IOMMU together with video decoder (Cedrus) exposed many bugs in
sun50i-iommu driver. This series addresses all issues so video decoder
works well with IOMMU.

First two patches address recovery issues in interrupt when either page
faults or permission errors were reported. Third patch fixes permission
domain assignment. Fourth patch fixes dma sync size. Sometimes sync also
touched some other buffers and kernel generated warning in dmesg. Fifth
patch fixes issue with synching PDE and PTE tables. Without it, page
faults were randomly generated even with valid iova addresses.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (5):
  iommu/sun50i: Fix reset release
  iommu/sun50i: Consider all fault sources for reset
  iommu/sun50i: Fix R/W permission check
  iommu/sun50i: Fix flush size
  iommu/sun50i: Invalidate iova in map and unmap callback

 drivers/iommu/sun50i-iommu.c | 66 +++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 5 deletions(-)

--
2.38.0

