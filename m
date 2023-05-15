Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54454C139
	for <iommu@lists.linux.dev>; Mon, 15 May 2023 11:50:40 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3064099f9b6so8194879f8f.1
        for <iommu@lists.linux.dev>; Mon, 15 May 2023 04:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684151438; x=1686743438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GyzK6zODNZ80W+kK6XaRTPTEwX24SG6fcd1Iz/90fb8=;
        b=UTxsBakQU4eCusOYdatlhpnQ9g4/hE792zqadsLiaerX3oFqGbaE6QJH3nuV2Tw8DW
         41J37uxPHZjRsIdRSVwKE7YkvQYjQhanUes45CA8lfKM+AS7O8pUOvz5BaKjtzcfVHVV
         h1iX098ww8e8adpRDbKmZe8JDFzK4yM9kKWKN6wDkGxlH/JC3BlmQaHuMR+aqAD8JReW
         O3dBh8fjgo4XYOesAqD2LI3KSAvLeKXG08ySvCbGzDRTQDXt7Tfur9CxQ6A3+WkmvMRe
         4aptp5JI2i4+hVofB4sQqvO+TiC2GhU1rI4HymtiQiyKTezbxOsynLj77l0zM3ehpWna
         BesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684151438; x=1686743438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GyzK6zODNZ80W+kK6XaRTPTEwX24SG6fcd1Iz/90fb8=;
        b=c3rebInJpDf1Kfnx9aMuVDV08JXkoq+8kSksg3vtANuWk1TQP3K20VbdgCFSUUj3AH
         rWNI/YMDxyg9hquNy2GuTDlxFcmj95V2wVhJikL3lvFggcg83DLfEAtDD3VuNGKD86lo
         cnTj5iKrmxKFWCjqCHNjgPU0UhAoqeiUXG4ZD6z8tXM4vhQNaeZ8B4vu1scaOcsD6E+V
         z73QJPisdrq+mnuFTYE2vlOk2a01tiVmF4tZAPCUhRYRYtPNHOlUK+tUpT9BSJ4YLjGJ
         R8h6sB3xh2CwkhYn97Ut3HgFxK8OoLpW2FRFp+ca9k1kVteWpVxzpMSf+Ic1wL3+JiXc
         Yhow==
X-Gm-Message-State: AC+VfDwAZMBcMfmCHFpkCY+yZqiasD/jDEGKqq6pPc6lBxie7q0vQUeS
	xxt7BUndwrzzlAHLmru05eroRg==
X-Google-Smtp-Source: ACHHUZ5fwYAwjxp2LGlU56hWvOhWFldIqE1lVKGuVXgWQ/WSLETo9yNBvOKJeDm1tywC5gQEZcgzBA==
X-Received: by 2002:a5d:680e:0:b0:309:e24:57b0 with SMTP id w14-20020a5d680e000000b003090e2457b0mr5209363wru.30.1684151438281;
        Mon, 15 May 2023 04:50:38 -0700 (PDT)
Received: from localhost.localdomain (5750a5b3.skybroadband.com. [87.80.165.179])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d6186000000b003090cb7a9e6sm7555395wru.31.2023.05.15.04.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 04:50:37 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	eric.auger@redhat.com,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	akihiko.odaki@daynix.com,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 0/2] iommu/virtio: Fixes
Date: Mon, 15 May 2023 12:39:46 +0100
Message-Id: <20230515113946.1017624-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One fix reported by Akihiko, and another found while going over the
driver.

Jean-Philippe Brucker (2):
  iommu/virtio: Detach domain on endpoint release
  iommu/virtio: Return size mapped for a detached domain

 drivers/iommu/virtio-iommu.c | 57 ++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 16 deletions(-)

-- 
2.40.0

