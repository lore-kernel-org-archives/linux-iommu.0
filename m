Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189231F17E8
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766281390; cv=none; b=pTyeq4L+Jmw3t0soBPHw0VEqt0jf822t+6wuHdKQNMqGDrnHt63BFAeMrkigAbnq9b+8EY9TaOdcqX6GI4R39EmpTl/GBR05SNszW/cAzx7xLX6T55+TBZGcGOS9poFYeLE1HWNBY7NuP+8k2vtKbyEXI23lJRBDQbEaUOdDCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766281390; c=relaxed/simple;
	bh=zDutoCUcJC5KUV1zaO2F8pH53d/mYymyKDL8EVxDtN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o/0ysrrjQ7FSWUi43jLRDxA/QJZAfQleSF4SEQVNMOAO2f7AlS8vvnKztfzLokHpZJwr+VyVXHkPpGfNSttc6GbLJalUx6rPedGavKUCWaJbH1IzVAhzoJqjsh/wJZrWGlUtRb+1LtULmgW5QtqdrpTVQv1k8jyZ3SFKXE9UTbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bumBIeAP; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bumBIeAP"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so3498882a12.3
        for <iommu@lists.linux.dev>; Sat, 20 Dec 2025 17:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1766281387; x=1766886187; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GXP2AYUno/m9zOnTlGzVwAr7evEHTglaPCKMGi0tEos=;
        b=bumBIeAPuSM9dVUjgDMYDD4P37lOzqp4YIdbEJ1kEZprUEzwg6+Nk7M7fgSUqwBhtd
         oyGNejziiQCbEfpAMfkzGZiHblOAUuF7LAmpd4s6G/myBVM9nzhbQ3qndcSDcSr4Osnx
         NZsaXXYhKJaJCBEHdmu58/5RJs5Icoz9wL/tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766281387; x=1766886187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXP2AYUno/m9zOnTlGzVwAr7evEHTglaPCKMGi0tEos=;
        b=qzZX0ESP7Sj5W//2+1WJ9OrA8GX+G2QI+SgNSOQcl2XucyDKP8vwCUh+mR4QLnOfdk
         0+euohd4mMNF4Rixvsmdr940deO9BKI4AIKA88foKCPYQk2iYal4CIloY+O3FhaTn3iZ
         o/67Xdpz0UNbGUH9lFVoanIohmOzOeLNU8suXLlcjLagFZhA2eufmOGDWREaRbn8+l7F
         dor/Ytibw+XGpSs3LkdAzI3+69/e01J99mTh4I52b9+mfOrf2AYahKq1z54EtfJHjS8/
         RkgQAa5xEzPDWBpixUrVlErYsqIZK18U5YRqQn/qFNsUjpV60frHK3VBRi7hJjIFJpts
         w+Gg==
X-Forwarded-Encrypted: i=1; AJvYcCU87YD94OYrg+/2T3y+ofC/BaWd4p9iEKmCNNNYnenAJN4FXJvrVS3pS2r+yGXmjNn9a0HRyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaihA/2LL7wUO+9591EwuQez/xbkG3tRAVKB7f5GqqA2YqLls4
	hRiv6516kesKoFUdktKCMs8FX+tvrO1Gq4bNnMboaVHPC2uPhGLKqolPG00SzEUP2A==
X-Gm-Gg: AY/fxX5tkRwkqhCfEM48e18Rnk0mHdap5TJVhDtSAl7xgzi7ZOXSJcO+Xet03hgH2xH
	WipCT6Jh6KsJqDeRn8Cj43WdeSvCbqtPfvjUUxDKkTd4IQEvr8Gru2AeYth/0ehpgHiy9YTw0Ys
	FHhenY0munbn0hg48CFVVMxi5c2s2kz5rIVqM1jmjBpZx/EK5u+PlomegiVgl95/Un+KbH9aYHk
	RbnnXxzgpX59/zqBIq9QY+/hXfD1yZtfxz/u9n02i/vKpKnIgLdEoCL7igCfepv0SQa29MQYG5Z
	cjNc8UqGtgeAT1COIm+yKI3IfekcAjeGf0szkbzNcmQuNbeLI9JGOh660gA3NbHMYVzZPBiHB1s
	MBr2cNonfXZewjIEmMsBloPVzTV3kjzOq5vIrh/iyxF+855fMynbrNSsXmmh/R4KR6n7A2JUb8+
	oT0eZ6ODH4b92LwWpJNSDq7sqGsy5iBRjyzNlcGYYc
X-Google-Smtp-Source: AGHT+IESK5mMwY1zy0Db+6R63Cf832kYS2WIorg+x5Tr6gnz07sfYPFNBr5QFMDqRL4FQ86hnjpA4g==
X-Received: by 2002:a05:6402:2343:b0:641:3492:723d with SMTP id 4fb4d7f45d1cf-64b8eb73c83mr6940048a12.11.1766281387522;
        Sat, 20 Dec 2025 17:43:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:a31b:20c3:6680:4cc9:1698:dce5:4976])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91494cd7sm6035057a12.16.2025.12.20.17.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 17:43:07 -0800 (PST)
From: Dmytro Maluka <dmaluka@chromium.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH 0/2] iommu/vt-d: Ensure memory ordering in context & root entry updates
Date: Sun, 21 Dec 2025 02:43:00 +0100
Message-ID: <20251221014302.17738-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in [1], we don't currently prevent the compiler from
reordering memory writes when updating context entries, which is
potentially dangerous, as it may cause setting the present bit (i.e.
enabling DMA translation for the given device) before finishing setting
up other bits in the context entry (and thus creating a time window when
a DMA from the device may result in an unpredicted behavior).

Fix this in the same way as how this is already addressed for PASID
entries, i.e. by using READ_ONCE/WRITE_ONCE in the helpers used for
setting individual bits in context entries, so that memory writes done
by those helpers are ordered in relation to each other (plus, prevent
load/store tearing and so on).

While at it, similarly paranoidally fix updating root entries as well:
use WRITE_ONCE to make sure that the present bit is set atomically
together with the context table address bits, not before them.

[1] https://lore.kernel.org/all/aTG7gc7I5wExai3S@google.com/

Dmytro Maluka (2):
  iommu/vt-d: Ensure memory ordering in context entry updates
  iommu/vt-d: Use WRITE_ONCE for setting root table entries

 drivers/iommu/intel/iommu.c |  2 +-
 drivers/iommu/intel/iommu.h | 37 +++++++++++++++++++++----------------
 drivers/iommu/intel/pasid.c |  3 ++-
 3 files changed, 24 insertions(+), 18 deletions(-)

-- 
2.47.3

