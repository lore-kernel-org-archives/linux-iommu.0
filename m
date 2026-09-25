Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9A3489881;
	Fri, 25 Sep 2026 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329659; cv=none; b=r1I4xlv9bqXky50Lpr3sydoqx7TGF3cbku0T9NE3k4YRBc5SZGVTDa65pQICQb3zOKCRW2WWZtAflWCt5UwLBkJ+UhJaClgEdEHJDIAjWm2YZGQsHdnrFZFiwcJvmcv6cDKs4bEwccDqM4UhsnorjitZBuvY5/jK9pJbu8/myQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329659; c=relaxed/simple;
	bh=Dc1QaOYmmuNE63L7xcIpm4eSBgJtkgeoCe4TL84F//s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLSigXQCOAXs6f1VDxoGfNyGhyTfv2lyFiCyCaLIzVkCRxN/snmklwniIrzEIXbolgJveQ6ckEy6Gz56EgDm7yJ65YBR4GJKTyKxLN5s7EZjYakARfGYb1uXm1BO0UbdPxyt0OWXHtuSpDhLsI1zcANtQuoTbHKS6fydFuA2qvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=oHj1bDvk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tUZScL9w; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="oHj1bDvk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tUZScL9w"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 95CFAEC00FA;
	Fri, 25 Sep 2026 05:47:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 25 Sep 2026 05:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790329654;
	 x=1790416054; bh=9stiKh1brdV60JVlc1BIK4a4T0baaaOuIAMUuT70TzA=; b=
	oHj1bDvk46mUBU6x+4WR1Nyhdvgf6bF/VSONFU2uPuChjW+9tnzHlfvkx5CuoT2G
	qtTvmeclziPXDvbl+6mz7PYSg/KzTWfS917pU/jhRC9bf2YytHdgpjV/5VgSaLwV
	JtXM2tlwxQ2Lyn6U9T2nyfa2P8S2v4qDDgDBR9WKeaRSqnCQgJTaw8/3V0Z0w25z
	3oDFDsD2HxBb+jBbpnBxOIr7H8QjHrnjXEJYwKsl5Bu3MNWtXru++HqQV/NSDpQ+
	z3z2qQlXabpinP/3HLo8Dkj0qgxUHidBrJwL2Mzrx0Bir5viWxmccBQXbFHK9hTY
	5MRBe5/dWza4WVnLgm1/7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790329654; x=
	1790416054; bh=9stiKh1brdV60JVlc1BIK4a4T0baaaOuIAMUuT70TzA=; b=t
	UZScL9w4sSeDxZSrPOwUTzKm3VobXD337ZIlxF1FTPKNYc1GYtpYgc6bcxDMksLp
	vdhL8vTLdywfTr1/EdaeteHEETDz/wXZ/lS/bmUs14JSdySxLXvTJBMy+k7GXgfI
	DHBcnQlA6Y776rB+h6Y3BxYXMj3ahwlT3W1HGBaI/tJ4zOYGSc++kYz7lsEuMiMN
	avRFQXyRvETS7QZP+F3UfmtBjVAIEkoR1Vhl3OLKEY/8/utKj22+cXH9jNiaVNHm
	JqMDOKDigTSHEZgXIMtg4T8cIE5OyNHRr4eiPPlrJp/cYsYY3GafHZoTjsQ5dtmi
	mrHA01kF3E8UUqTDne0Eg==
X-ME-Sender: <xms:NkO2aqLlFonORfrdvC9m7y9w4wlBQbpA-UmmjPBkguxS2A0FvvSBjw>
    <xme:NkO2apPowt666ieOH5Fm0m9VyeST7TvN9NjNmMOwlK_9NhJxNeDGla8KS8Kw6I4FQ
    Bt7CDyOEeekPqupUq9KFW7qtIIB78LOGt9DT9MkAcBQfPCV6jp98fA8>
X-ME-Received: <xmr:NkO2aiY6P-Gz-cdAUifIjdomIbgHuTWf6nzvWwztPhVBdAiEFABGxrRiPQZ7FIpG8ShWlDU>
X-ME-Proxy-Cause: dmFkZTFP6PUo/lQVBZRAGilmAGunRANLi0uAHVA7y830k3rqWSjaVEvNWERJzKXbwZtlHZ
    cNlbIhyYTFvbD3jYp4cfBOyrpBVbT87licp/ieW8Afo5PXSWzMDa8OIQd96+i3cCvYUlpy
    Fj2u5DH+gQH3jpAcQkTCzbltLGM+VMCyCVriIFDxshBqP5zeUlbX9SoDT9JaBfv2geLJ9I
    ia0XFJLhrXj3dpkh7HszhcCg+xW4ggcTlMs1zLlLZH7ZoL632UfjMH3EotcWgGACQ+mmgG
    wC5+aKbORdLMszbjsaq0yIkqzFGBRGKV1mDBeTD8j1pwg06s37eLF3mslkTfoHMbWd2dkk
    nxEIjtvqpxL1ABD0bgmfQZ6McyUj7kjAnHNKp884PmyeBh1LJ+mQZ46R6HseFCMPWp7wJ3
    sGfYPKrI/f3jv1o0OQ1clEE/1ae/regCrnjn4Oho3ZKkhnMG+kIrJJy5MoIhVmSOKjwTdt
    VLDhsP9gzkbG6KseMxoBzNxt7koJf5V0D97p/g5TDDQdJ+zCptg0p0db2DvzrgBJ3FXQhR
    mXTXyrr/EfLEO4q3YTMD0qW3jMFc/t/2hy2KghwtC+Dz1o6X4Qz0UqO6+lqibVLMoFzsZR
    b9NKz0DSsZxwLpQALlxauh/Kunzmltj1HmkAxX8ZKsZ6D7yNaIqrnzDtA33Q
X-ME-Proxy: <xmx:NkO2alyaQA9J2smTVDc5F6aZ1hsHGmCHPAwdQTKgTQ37sP8cJq1SfA>
    <xmx:NkO2auFuuhxHFw80jm8Ja5f6qRbReX2eZ9fhlEadt2nfZ3rLQrFRCQ>
    <xmx:NkO2agoNPa5q2IvLu17ape_f-XK7gKQffXEaRHue5ON_mDyR62Pt2g>
    <xmx:NkO2asyNHFbHF01aMdPw1TiFU1pgC5uyTyiic36oDs_H2HY2SMN2ow>
    <xmx:NkO2aiBJuJIaWbscqpB6RIWmZQo8dmIg1MXy_1jesNkJHWgLLBtvX9Pq>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 05:47:33 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 25 Sep 2026 10:22:48 +0200
Subject: [PATCH 1/7] MAINTAINERS: Add NVMe devicetree bindings
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-apple-m3-nvme-v1-1-5e832e2f4aa9@jannau.net>
References: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
In-Reply-To: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, iommu@lists.linux.dev, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=j@jannau.net;
 h=from:subject:message-id; bh=Dc1QaOYmmuNE63L7xcIpm4eSBgJtkgeoCe4TL84F//s=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxtzlr9UX8Pfn3v8+ff5YfFDstl1VauOyXzc6tLR6/+7
 Letz5cWdUxkYRDjYrAUU2RJ0n7ZwbC6RjGm9kEYzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFPdIcrIsFfT0GGHcaeWw9Z3PooLpnKe21+ueZNN20l6y9kU46DQlQz/nSQ9v/b
 JlCy+ttp951dfYe5+o2vzHFyFl2VdeHKJMXc7GwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Commit 82b96552f15a ("dt-bindings: nvme: Add Apple ANS NVMe") added only
the Apple bindings file to the apple-soc MAINTAINERS entry but did not
add the directory to the NVMe driver entry.
The apple driver is the only driver requiring dt-bindings and might
remain the only one so this shouldn't have caused issues.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..6f9d1736d13f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19578,6 +19578,7 @@ W:	http://git.infradead.org/nvme.git
 T:	git git://git.infradead.org/nvme.git
 F:	Documentation/ABI/stable/sysfs-nvme
 F:	Documentation/admin-guide/nvme-multipath.rst
+F:	Documentation/devicetree/bindings/nvme/
 F:	Documentation/fault-injection/nvme-fault-injection.rst
 F:	Documentation/nvme/
 F:	drivers/nvme/common/

-- 
2.55.0

