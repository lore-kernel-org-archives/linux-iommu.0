Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1560158878;
	Fri, 28 Jun 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577668; cv=none; b=oTv0alOilqm4T3vJg0E3IvWkxFhz/2flTTFHWO4a96olVxFXufa776u0z7CO54x621ydtj0xDRrOwuBj3BcWxmXoEddwUubakiJNd5yIDO2cKumlMrUZExLnLszcUeNpg8gl0x5V8EO+IMBdjcNoEJmcCO7GyZ6MYetWG48eDzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577668; c=relaxed/simple;
	bh=cR9hwW6RbLbUXG6oU/iwUSWz39yoTnI9vJYrvNX6PsY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LBKhcyaW3tSYkVega5QNN+92BCNlC/KhY+GsAJ/464xukkx9Vb2Vo66sk50SwJkL3dYK9kKtcyZEJXApLxlDzxyQgoGxMFGXCo4Rh4JVsoHseOUo83fBcX85g65JtwCFpvs1TwTdGqNej7sSCTxrQQ8gbMtEUXDgcSrbt2qb5DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUKaTnMV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUKaTnMV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33C49C4AF0B;
	Fri, 28 Jun 2024 12:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719577668;
	bh=cR9hwW6RbLbUXG6oU/iwUSWz39yoTnI9vJYrvNX6PsY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZUKaTnMVlYOakPuqGcROXStsVp14aiEOfX7+MEEyuovAfFF+DzDdDycACiEvXyv6a
	 XVkfYsuEmFQoGaeG/GgnOtkW9MT3N+fe+/oCmoGW+rPEveZw4CG1J9S1RHshE2FWuV
	 nbufX5EwuvUW/Hqp5lKAHBSi9ZmT8dC2PvFmUuut2mUHNm338QEQeQqVTNzyTtDj6C
	 wtFOg03f5Nlh3ooBW/OhNkt/gsiRSP+5NrCCbpJKtlzNDPf9rR6EwTupRjXTSggv2D
	 sb2fse3IZmc+2tGyyZi4otJfuOMBXBJuhBa+btrCF3XFmGaizC5IAf53tBvcaGxMf3
	 ieVTSxGhLLqFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF99C2BD09;
	Fri, 28 Jun 2024 12:27:48 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Subject: [PATCH RFC 0/5] iommu/vt-d: Create a cache_tag_id to reduce
 argument passing
Date: Fri, 28 Jun 2024 14:27:38 +0200
Message-Id: <20240628-jag-revisit_cache_tag_assign-v1-0-a0c19063c983@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADqsfmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyML3azEdF2IwpL45MTkjNT4ksT0+MTi4sz0PF1DSwuTFAsDC2MzyzQ
 loBEFRalpmRVg46OVgtyclWJrawEXC1ascwAAAA==
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=cR9hwW6RbLbUXG6oU/iwUSWz39yoTnI9vJYrvNX6PsY=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGZ+rDsYYKC6MidKQAjlRDvFg//BAhVVpBLdD
 dclu5H24CmCsIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmfqw7AAoJELqXzVK3
 lkFPPJsL/jz6HY71bfDOzt+pzs3OdCZV2ZGPlvK5UfCKjYtBGvtRhzTgZlXbokny2wCwBk32cZz
 8C39Do+2N0UQ9xpoyws/CH08wHjdPXzV8aC4PLvWKa99E1gyfBnV/Fif3eTlHa1NvOLoE3+O0lA
 aBRzjORh5VSxz1GQq3g+gI4DKbWoFbJtN3aBHWjlIiI6wzC29pNwwrZEV3JqjtMhumw6zZaiRqe
 GlxofuwwQ1ax++K2FbV3Ut77HbTGcj5pRwaCdF8fclLSijIhmZyNXmwpYF3yMVKd/w0BjX6L2l7
 m5nb+KBwX6mCtZxsLBPX+070lGoQUW6SbwO29/a69kTkFZ33yGWiPSU7FS7r2k65p9f70uzV22K
 I0AIIPif+JEAOy4KTnNKmAVaiePTIxUA16/r0IFHl70pAmJDGM5x7efWkTWxYghuHsY7pTe53Wr
 A51ctu8/1XWFYqcQ52QPdE0VUyFr+Q8pmB7Ya69p/T0B/DjaQg1W/rfySehg7v0eKCzDXsrG7C7
 3U=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

Does it make sense to replace 4 arguments (domain id, dev, pasid and
type) with just one (cache_tag_id) in the {un}assignment functions in
drivers/iommu/intel/cache.c?

In working with this file I made a few changes so I could understand it
a bit better (no functional modifications). I can keep going if ppl see
that it make sense.

Comments are greatly appreciated.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
Joel Granados (5):
      iommu/vt-d: introduce cache_tag_id to the struct cache_tag
      iommu/vt-d: Replace cache_tag_match with a tag comparison function
      iommu/vt-d: Pass cache_tag_id to {un}assignment functions
      iommu/vt-d: Use ats_enable as an argument
      iommu/vt-d: Remove dev_iommu_priv_get call from domain_get_id_for_dev

 drivers/iommu/intel/cache.c | 184 ++++++++++++++++++++++----------------------
 drivers/iommu/intel/iommu.h |  24 +++---
 2 files changed, 104 insertions(+), 104 deletions(-)
---
base-commit: bcace518c52fd7d786a9093711e84847db98e1ef
change-id: 20240628-jag-revisit_cache_tag_assign-1984d808369f

Best regards,
-- 
Joel Granados <j.granados@samsung.com>


