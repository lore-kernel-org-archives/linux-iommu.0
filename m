Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0911A5BBD;
	Fri,  7 Mar 2025 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378070; cv=none; b=g65hdw7yIioUqDAF5wdQFBT2OzVvhgyFmRaFefc6O6BzTIv7ZSwYsSrCiSX2sxMm75O4+p6p2QaLn/mKsY9anzh9S6DgpP3K4GNSA3Xhz8FJMtfr0wkx1hXOTGyE9yX+thwCf8ApGVFYdu5aRnyY/IlnURSWCw/aHG/+2fIgOko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378070; c=relaxed/simple;
	bh=aL+XZM/7p7Esweo3/w1A7NMI9JjtTr5G50MAaH4HdCs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=trQ5eV2HFx0AC4ZrASrfLdc5LhEW+ihCUavJcgy8+B3D6ZeSUkVue6ZgBJ1DbeIZGKXwjT3eZvWtzfoqzgEwugRmfwgO2pdC3gKH2p7UEKW82WUc4S7dfeyKDcTNdX+bD6U7Y8eesjOKJK+TD32sY7cleW3sYAmKDF7IZw58+hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMnuoiV3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMnuoiV3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E54D6C4CED1;
	Fri,  7 Mar 2025 20:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741378070;
	bh=aL+XZM/7p7Esweo3/w1A7NMI9JjtTr5G50MAaH4HdCs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FMnuoiV3Nzp4OWlLE5VAXd3CJvw2kMN6G5vuInuDGb1BTQZjtWRRmhrJnkgZsGlVG
	 t3a+I7DdNGJ7wLbv+gm101+uTjike5WDaHuEDKGyS9u98LBkU2x7J/L9fcCnTOOg5/
	 1cCU1DIQA3+2BF+z2xbtojsvjraOrINpOctX9uAbbRIOaD9IVA8cuyGWQ2Woy6ezHD
	 EDByOkK6GLydLpq3HI86PJHA8FcX4KmKI1pMIFpiUP7GfHXFj3tmBR1I3fBQ5oe+hy
	 9HnxCzIeT2Hke50o+yELn2Qup/WHwGm5sABvj8JvdrOoU8MV0MYF9YOYK4EEJAW1Z1
	 qI6Uy2S8OPBpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4373C19F32;
	Fri,  7 Mar 2025 20:07:49 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] iommu: apple-dart: Support the ISP DART
Date: Fri, 07 Mar 2025 21:07:44 +0100
Message-Id: <20250307-isp-dart-v3-0-684fe4489591@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABBSy2cC/22Myw6CMBBFf8V0bU1nQARX/odxMdApTCKPtKTRE
 P7dwoqFy3Nzz1lUYC8c1P20KM9RgoxDgux8Uk1HQ8tabGKFBq8G8aYlTNqSn7Urs6KqibipQaX
 75NnJZ089X4k7CfPov3s5wrb+iUTQRkMBXAG73OXFo+1J3pdm7NUWiXgUy4OISTRMtgSqDKM9i
 uu6/gDB3Ik42QAAAA==
X-Change-ID: 20250227-isp-dart-f8369baaecb1
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741378068; l=965;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=aL+XZM/7p7Esweo3/w1A7NMI9JjtTr5G50MAaH4HdCs=;
 b=TymRhGh67bcUCvfAFG+jHbf8FOmhN8c2DfiA24iqbzxriblvi9pdbes4+hbhn2xAcjeQY+Kh0
 8kPtqo0/QtbC3iXPTr7yVkK78hCipfoGXZDbX4wZYDkoP3HBpq6usEo
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

The ISP block has 3 linked DARTs with mismatched bypass support.
This series adds support for this setup.

(The ISP driver itself is sent as a separate series
https://lore.kernel.org/asahi/20250219-isp-v1-0-6d3e89b67c31@gmail.com/T/ )

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
Changes in v3:
- Just added r-b, effectively a resend
- Link to v2: https://lore.kernel.org/r/20250228-isp-dart-v2-0-0ead81a90e2d@gmail.com

Changes in v2:
- Made comments and code a closer match for each other
- Link to v1: https://lore.kernel.org/r/20250227-isp-dart-v1-0-161e91ef4f46@gmail.com

---
Hector Martin (2):
      iommu: apple-dart: Increase MAX_DARTS_PER_DEVICE to 3
      iommu: apple-dart: Allow mismatched bypass support

 drivers/iommu/apple-dart.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)
---
base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
change-id: 20250227-isp-dart-f8369baaecb1


