Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA98246778;
	Fri,  2 May 2025 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746186970; cv=none; b=Gmbl5/IGSGSt9XBKumujofPZHu2IoCv95UTvTnSHx5X/H2SzVqYhX16QaMiW3mMkk5iBu1cndc4VXnUFqrWWZ81SZ5zBSvDOZ67QU+rwz+P6t+MJ/nrlFQK87mUTB8VzrYu3cdelr1VQs4HpwKGKJ9IBFohZuR047+AQKwvRTB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746186970; c=relaxed/simple;
	bh=C0OUS0W6cxfA76GnIZ86F8ow5n8XNEot5PI7yC4q6Mk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L10cSMPOGz+YYQGkdYtaDcEa1oajmurx+J5pze7DaJJxqL+ePSmCuBw3lGvKHJzRXiyd5h/pIBnQ2YLgy8zQJEBBNC2bzgmX1Q0T//oQNbVAEyGctFNvt0w8jytS/dxgy1ray+R/EkXqOYFpeXKGCQFdua/wJ7XozRSUSXrVF7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 May
 2025 13:40:55 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.039; Fri, 2 May 2025 13:40:55 +0200
From: John Ernberg <john.ernberg@actia.se>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>
CC: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, John Ernberg
	<john.ernberg@actia.se>
Subject: [PATCH 0/2] xen: swiotlb: 2 fixes SoCs w/o IOMMU (e.g. iMX8QXP)
Thread-Topic: [PATCH 0/2] xen: swiotlb: 2 fixes SoCs w/o IOMMU (e.g. iMX8QXP)
Thread-Index: AQHbu1cQRZF4GUbfuk+26xI8NrrtUw==
Date: Fri, 2 May 2025 11:40:55 +0000
Message-ID: <20250502114043.1968976-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
x-esetresult: clean, is OK
x-esetid: 37303A2956B14453667460
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

There's 2 problems with DMA today when running Xen on the iMX8QXP SoC.

The first identifies as a USB corruption, but is actually a memory
corruption risk with any small DMA transfer, and just manifests itself
in USB transfers.

This is a regression fix tracing back to Linux 6.5 when the blamed commit
(patch series) landed.

The second one causes any attempt to use DMA via the iMX8QXP eDMA v3 block
to fail with DMA_MAPPING_ERROR when running under Xen because this DMA
controller wants to do DMA in MMIO space.

I'm a little bit more on the fence with the second one, as that never
worked, but is still fixing an issue. There is no Fixes or Cc stable on
this one because of this.

John Ernberg (2):
  xen: swiotlb: Use swiotlb bouncing if kmalloc allocation demands it
  xen: swiotlb: Implement map_resource callback

 drivers/xen/swiotlb-xen.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--=20
2.49.0
