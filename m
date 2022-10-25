Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11A37479;
	Tue, 25 Oct 2022 16:54:35 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id j15so11623310wrq.3;
        Tue, 25 Oct 2022 09:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uS90p+hsrRE9B1prQWjGTxZ3q09/vh+vkeEVG+A77cc=;
        b=D1P9GpRfJZNcT1U+eUclmqyHKr0Tvag/y5A8g1b+zEoYaI4TE/mM3lculExvJuyXMm
         DNUxNOY3XFeHgkiXYwRFZH16I0iRPwM/ygbyjmanVd6hRKz7X2CCrkS8UpCkM0sh7vc1
         nTZlqG6wyfvNNXGiXamEvkUfEeVjlWhn0hmm13XdBzpT/hSiDqt3S1nBYJaJxBNNCGkC
         Wk0HFGiybyd19SirggP/sTW9Dv6Y0OOZsnE5NwiwCO8XOve7200agX8Df2oU8OwwKLCv
         +TqtwlkmbKWt+t6m5xZ+Ae+jFS16VpoBZDOyiN1guR8s5tHm29bW7TjoenZY+oHjpcC7
         n51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uS90p+hsrRE9B1prQWjGTxZ3q09/vh+vkeEVG+A77cc=;
        b=XtyYrUphvsXZBn9nwxxN9BR+MAB6LVY+388JPgwgnI1dTdTdHqC+JW/Nj/tgmPTZGo
         kbsoPKTSR8dYxIdwLWAzH/TY0GNK9pSkp5w2aTJ6QOYC8DgdQXvO66XdCH4q6v4PTVcl
         CnWFh1iFT6VpP4dIk4Ki7d9VB4PMF0Mv7tO84Q7ijMOy3nLsedTPTc4/FCtLzX4yNVLy
         qvft2Y1MQshV4MgH8vN6Zmy6k0t8I45ZCEqhO8xFcx/ZauPNKgaqClFZ8jqAdKo0WCYI
         2OK9ZBZimvCbWfvjRVKRkUG454SKAnVmgWc5b8OOUu08FlkPlIc1AjtWvqYr3mL4No1r
         lsOw==
X-Gm-Message-State: ACrzQf0BoLcUKDWMCnAMTu+g+EugCiK8Ml1eXlH+AnnR7EuoxdFVW0XS
	JIj1QjFy0jkEUoYjxTKIiuI=
X-Google-Smtp-Source: AMsMyM7osCtL7dKCqolh+3Z3vX4GYaQzlWb1z13VKMCG2LFb9T5Quv+2EobiuqiVwzTyaKKbjmbzBw==
X-Received: by 2002:a5d:59a8:0:b0:22e:d6ff:3a7c with SMTP id p8-20020a5d59a8000000b0022ed6ff3a7cmr24909840wrr.128.1666716873721;
        Tue, 25 Oct 2022 09:54:33 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c349400b003a6a3595edasm3023989wmq.27.2022.10.25.09.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:54:33 -0700 (PDT)
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
Subject: [PATCH v2 0/5] iommu/sun50i: Fix various fixes
Date: Tue, 25 Oct 2022 18:54:10 +0200
Message-Id: <20221025165415.307591-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
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
patch fixes issue with syncing PDE and PTE tables. Without it, page
faults were randomly generated even with valid iova addresses.

Please take a look.

Best regards,
Jernej

Changes from v1:
- rebase on top of v6.1-rc1
- replace last patch with new one - Implement iotlb_sync_map instead
  of invalidating each page at each allocation

Jernej Skrabec (5):
  iommu/sun50i: Fix reset release
  iommu/sun50i: Consider all fault sources for reset
  iommu/sun50i: Fix R/W permission check
  iommu/sun50i: Fix flush size
  iommu/sun50i: Implement .iotlb_sync_map

 drivers/iommu/sun50i-iommu.c | 88 ++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 5 deletions(-)

--
2.38.1

