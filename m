Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D133F39D7;
	Sun, 18 Oct 2026 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341524; cv=none; b=ZjVgmsA47zldq0+XHUwqb2/+UCtr9GiPwLg2UIPhlAOwMm1K5omXIcZ1l8laJkh9vl6RrKdEwqwotsMeEthP1O6cFAPky+RSMHo5Sc2kga7QBTLUzQ3UB4FSRH4VWF5KzaywcQZdqEG3KvAl+TrumZB0/VUw8tAwSsFTzPuVeKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341524; c=relaxed/simple;
	bh=dwrfSgV2nHOf/ZOxHpEE/3lScDNfCAg1zmz1MabeAUc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CLh+Yz63H7mzNg8sXLLloCESu3fNcCh50j1dtISvb4nCZbH+svjSOatlPSiLV+7+qJyH1ZMgRgFakQk8Y+oWoKyPGZ7bkCHYUPob+44dIFwzIcwn34avovJNBN+JhoQIm0/7fFaBsFKP9WcBz/3ZxvoXspLeR84Q4a7e7/hJ31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=ZhXrfsmD; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="ZhXrfsmD"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1792341505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zNjcjVDRgVo1MMyTUVNWq2nJccrPEQJlUoGpHdejRwk=;
	b=ZhXrfsmD7AmgkPokPNxyvijzrV4PymNsbwLTud/MoUuXNqAvVanj9BTsDWi0LdrJXHbVvs
	cKaW90CW+vPZBiEeC8PiX1gXM2NiaUrw7LikoPzZXwFmdheecUTKXq6O8qNWn4Ki5Wvo1s
	tkT/3uN7meu9IRBzBZgy4DzxKT7wNAI=
Subject: [PATCH 0/2] Add Apple SART4 support
Date: Sun, 18 Oct 2026 18:38:09 +0200
Message-Id: <20261018-apple-sartv4-v1-0-1eaa5d63f6a2@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0Nz3cSCgpxU3eLEopIyE91Ek6QU09TUFGMDQ0sloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loASRV2tHAAAAA=
X-Change-ID: 20261017-apple-sartv4-a4bd5eed3019
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

Hi,

this patch series adds the dt-bindings and driver changes required to
get the new SART4 IOMMU on the Apple Silicon T6050 (M5 Pro/Max) SoCs
up and running, which is required to use the internal NVMe.

The dt-bindings and device tree nodes for the ANS2 are omitted here,
since the minimal device tree is not ready yet.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
Yureka Lilian (2):
      dt-bindings: iommu: apple,sart: Add apple,t6050-sart compatible
      soc: apple: sart: Add SART4 support

 .../devicetree/bindings/iommu/apple,sart.yaml      |  1 +
 drivers/soc/apple/sart.c                           | 45 ++++++++++++++++++++++
 2 files changed, 46 insertions(+)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20261017-apple-sartv4-a4bd5eed3019

Best regards,
--  
Yureka Lilian <yureka@cyberchaos.dev>

