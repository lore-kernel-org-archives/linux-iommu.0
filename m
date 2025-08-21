Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927072E1F17;
	Thu, 21 Aug 2025 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791839; cv=none; b=Ep4TJPUcvFcnbI8ajADuZe6e05wSyidnMbMpJKRE0aNbbNyrmjj/1uObs9oYLBWNUWEu+xU1prxU0QBFX9UM2txWMBakoPDYhM08CFYb6MoP1EVSa/MMePyC3boTrsn9cGNKLZ4wPm4BOEwHHAXGvIBnTziDzPD5P+H2vyXessk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791839; c=relaxed/simple;
	bh=iUK4B/CmqL3+Q73zw9YIpvF6fPa74yfaI3WOfamJS8k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qR9GnOmUccb0zmj5EXQIiaUUnFvIGq+A720h2q8AYnRgFnkWP+yZOb+eo4fLfTniA9w4RIC6dyofwjqn+RJOzHqAmthiD2gidRFjXIa3IysdWafR6LX1kf6Ag+05bMBsU+EDwYq6pLIOouz+QFytAM2VOdo53h4t2OhuCTO4Z4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbGgxtwc; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbGgxtwc"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-323267adb81so1287040a91.1;
        Thu, 21 Aug 2025 08:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791836; x=1756396636; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EqlRTlA4R1X2+J6LfIK/nlbcP+4L+ArUw8i4qlAeNpY=;
        b=cbGgxtwc/ekFlxX1sPZpkFa2/0BgqjxBeTSqGjtbbXA7OsMl4ofhGmrQq+Qh/O/n9d
         F4vvGUxCRxtGagqQ1XwJ17FTX360GkN18qIDy9v2jDWYAJO+d+io61WIHLqMgEszPnGW
         BQ9vZZQFMUjDpsIQHYtJ/QeHqcywtSgiOYd9hqKP2UyDR+VRBq8NBj33W7ghqlTrdNkG
         T6HfdsERLv5l/rkoO1BsoeTeTVR+uYn3OKh17OQJMv3hfYj8aoOFUSIzF9iYc8hjQRJx
         kJq8sNEuiDzLUcIvdv0BJioLoV8lyQSwPgU03bXjzjToIA00HL6zGU7JEfOEUuZ0QFlc
         z3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791836; x=1756396636;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqlRTlA4R1X2+J6LfIK/nlbcP+4L+ArUw8i4qlAeNpY=;
        b=b525/ZAp26eWu3r9iLB23Q0a2v6J7flyDTJXynNcHqXZ+JS3nlgI12HX+YGFPwboON
         RQsaUgV/WvZKDcnGvcc/lrEX3/6Ap+Q3u8D4UFjlkcHzz4+GXXn2IMfc9YFA0lLfp5JK
         cdBtIiF9O+EbZmGHaUxxnIa465d6mWEVeTA5+x0TEyB3+8oAaUdaaeFdxY90MWD+mvth
         Qu+Q0td0ctHMoaeIa/q7rsqE6TZJlWlFYtOCzmP+6PA+bdk13IEEEJIhYMCLM+wg3RlK
         tvXAVIefIuQnU9kyUzdSGJ2vTFGrk7KFexJvNssuyd25C/Ff3CstY04KTtan2+hRgqNx
         +BJw==
X-Forwarded-Encrypted: i=1; AJvYcCXz29ZnmptgONEf4HkDuAtMksftzK3xGSwffLE41NCS4wXrt8LicPyflSuLl6Kd8/g7WrLdXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4KOq44XZFIub9ssuQSo3DOMnGBEkxrdQhv+/t8kj8DQLKBsuZ
	V1epl7VVCykhCCbTTakhDBfT+EF45Ul9+Y6djUnggakfnipb7Qula1UEPrjpV+Hp
X-Gm-Gg: ASbGnctRTzTR+6VgZO0erf9Df4Zh6XuMScJ+6ZbMuAnms/lx5sF9qTzRZ8Na5/K4u0C
	Z9cY5ikG/mEyvQBzK3/nvRQi3uWqvvT9gMiJRmmrOMGFBeUAu6asxOUATUAJSILDg3NJ++M1jW/
	cBrV+C8HZgqL8b/OgTuqpWPYFXC4Q5AIrwEm9yvmJsNL5JS5B/9Npe5e3ODeWXd9K2VM48J5V5q
	xwQZBNT4GZ8MoNhVhhMMI89Xw0mfMJP6w8faKBCJp22HFeVGPkWXDGuKRgdsmxTAj1mgiJO/gEe
	rr0ekmlLU+knylnw01EKwEM3GQ6OVeWyIgyGgCMIgt6aBES6b/eZm97l1VrOEvOQpRvrd2hvo8x
	GJaoJA0/iEKI5ZNVNjtGijkQuX2j5d9k89xOJSGhmMpHU3/c=
X-Google-Smtp-Source: AGHT+IGY/0LdDkG3WlHhoiU3i1jzAfuDrGRNnzLZsjyafdBsIPbZDEnKdNCzVy+LG9syFh6upBaBLA==
X-Received: by 2002:a17:90a:d404:b0:312:1d2d:18e2 with SMTP id 98e67ed59e1d1-32515ec1334mr26076a91.20.1755791836352;
        Thu, 21 Aug 2025 08:57:16 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:15 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v3 0/9] Add support ANS2 NVMe on Apple A11
Date: Thu, 21 Aug 2025 23:56:37 +0800
Message-Id: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALVBp2gC/1WOQQqDMBBFr1Jm3ZRJNBq76j1KFyEZdaBqSSS0i
 HdvlC7s8n14j79ApMAU4XpaIFDiyNOYoTifwPV27EiwzwwKlUaDRswGpRZjGkjUhS1b563S3kM
 WXoFafu+x+yNzz3GewmdvJ7mtv4yUx0ySAgW1jVOIVJe2vnWD5efFTQNsmaSO6t+DpLJa6ao0z
 kvTEB7VdV2/kjB/D98AAAA=
X-Change-ID: 20250808-t8015-nvme-73a4fcda25dd
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3117; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=iUK4B/CmqL3+Q73zw9YIpvF6fPa74yfaI3WOfamJS8k=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HOLQWhVWXbaGc0BzFZVP9f/db2mKxsmWbHT
 9Fs8JqKVcKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdBzgAKCRABygi3psUI
 JEpREACw1A07RdsR5Kch8lz/TYoO2c2/cr6rKNdpFHUNRYoKSVzpHzJq/CcFTMSa2dygiXmFfqS
 Sj2mZgt8ht24uJwjnCb57ETwEovCfCDGovUQNM4AiLK3VPQIvWNNDwzPVd4kUUozSoDwNCJm1lv
 zLKjN+L0GUuMCSJDdybD3oKpeKJhW6xc7szELbdh/f4S2BtKI4NL5U8BKs4a3NDxJI9nt1dmj9o
 5pR6USYp/56avbgcDjzmxxpdMqjdSmvzLArJBdFn5JKIXLKfV+VVRkKVmq7oWTmPJJx67mN12Pl
 LZZTgJMtSxvEJAwLx33rXs+37v59BHH7ZA+FBW9T8h3tx2Yw0ml/nKcVHoH/7fUgNYh1lEHHENS
 LBghUUrpEKW2JnFzkT+oXQj0YWkaj8zoCOH+SbEy595B/274nXqoEflHWbaTibgJulEtHSBa4rX
 1aLaJqA0WcJmlKNt3+m0wd1zwOamCqhbe4Dbw0j+AwiGo9ok1aRQ+EXlPF0Edbc5HBhP3tKhGIt
 tzhn9rFqwuQTgHwapzdeZ6RYQ6NTaQIcDdFkROyd9g86X6EhWqJjcifwLYKquolcPqaQJnj7q3V
 iNs5ABIsDuxlumXhSAt5KknZurOdsAP4n4oIQc43f169Qk8bsJSQZNaR3CroHRlDlIV3ESd02zn
 khOxWVzrkMWUlkQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Apple A11 SoC comes with an NVMe controller that is similar to the
NVMe controller in M1, but less customized. Notably, it does not
have NVMMU or Linear SQ.

The controller is wired to an older variant of the SART address filter,
and uses an older variant of ASC mailbox, so add support for them too.

This variant of mailbox is also present on Apple T2 SoC.

This series has everything required to support NVMe on Apple A11 SoC.
However, due to RTKit protocol version support limitation, it will
only work when booted with at least iOS 14 iBoot.

Tested on A11 as well as M1 Pro (to make sure nothing broke).

Patch 1-2 adds support for the older mailbox
Patch 3-5 adds support for the older SART
Patch 6-7 adds support for the NVMe controller found in Apple A11 SoC
Patch 8-9 adds the required device tree nodes.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v3:
- Update comment about enabling NVMMU and Linear submission queues. It is
  required since T6000 and much of the comment has been removed as it was
  stating the T8015 (A11) code path as a possible alternative.
- Make sure all the code changes are within 80 columns
- Simplify apple_nvme_submit_cmd_t8015()
- Remove unnecessary cast of of_device_get_match_data()
- Use direct function calls for command submission
- Use existing enum in apple,sart binding when adding the "apple,t8015-sart"
  compatible.
- Link to v2: https://lore.kernel.org/r/20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com

Changes in v2:
- Remove bogus command_id decrement followed by increment in apple_nvme_handle_cqe()
- Split apple_nvme_submit_cmd() into two functions for t8015 and t8103 since these
  two code paths were not sharing much code.
- Link to v1: https://lore.kernel.org/r/20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com

---
Nick Chan (9):
      dt-bindings: mailbox: apple,mailbox: Add ASC mailboxes on Apple A11 and T2
      soc: apple: mailbox: Add Apple A11 and T2 mailbox support
      dt-bindings: iommu: apple,sart: Add Apple A11
      soc: apple: sart: Make allow flags SART version dependent
      soc: apple: sart: Add SARTv0 support
      dt-bindings: nvme: apple,nvme-ans: Add Apple A11
      nvme: apple: Add Apple A11 support
      arm64: dts: apple: t8015: Fix PCIE power domains dependencies
      arm64: dts: apple: t8015: Add NVMe nodes

 .../devicetree/bindings/iommu/apple,sart.yaml      |   1 +
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |   7 +
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |  15 +-
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi          |   1 +
 arch/arm64/boot/dts/apple/t8015.dtsi               |  34 ++++
 drivers/nvme/host/apple.c                          | 196 ++++++++++++++-------
 drivers/soc/apple/mailbox.c                        |  19 ++
 drivers/soc/apple/sart.c                           |  60 ++++++-
 8 files changed, 264 insertions(+), 69 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250808-t8015-nvme-73a4fcda25dd

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>

