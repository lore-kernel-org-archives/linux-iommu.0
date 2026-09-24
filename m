Received: from out13-173.antispamcloud.com (out13-173.antispamcloud.com [185.201.17.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5706748EBE4;
	Thu, 24 Sep 2026 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.17.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285979; cv=none; b=ChJDDybh7A6JrDZ1hhyYjaof/lt1o6bRIcFC06DwNehkQrbbyuUwFGYOQm4o/vv455dcRATosxcwRizGfJFtcTa1HexS11sizSnrvAtZL6rXH0QdHNFv0YPYx1OeQSz5f4nzcMPqib8JWr0v92sq4UY5O4xGMCIZMlHGrt/UOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285979; c=relaxed/simple;
	bh=JFow46Vnz8reduVDvIc0YSORwX6vyQZXYpGoWC0l8YY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uTeZp4SznZ1LE6LJ97WZVOQzCK3d6NKev6YkfQxI8xMhlAoc8o1pA/BHxAVgZ/C7kTBL+PVP5zNqtlF4WbYj6guMfEOgUTTA4jXOXhNExFFmba27nI48GRRGL5WV3ETJb5XjvNm//6yyV0mae5q1UpsUIaKw/f7vwRm9/pWhquE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=AzXV50BW; arc=none smtp.client-ip=185.201.17.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="AzXV50BW"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx320.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1x9qjI-004qQQ-3w; Thu, 24 Sep 2026 23:11:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uEt0FZh1h7xpn4K7s6fu7UzabzsKhHO6udvMeZH/uZk=; b=AzXV50BWlyJACCS5R1fdhrE0r+
	ODhijx4uUccgYGh1ymlbwUjTb3svX7h64NTsEGy2wOwOhGOd4FRiJkrdpfn0NAnaNSO/G9GHcgDBF
	m22QPLDzl3AZjPjNRcWB+xGscExOmHTHf7SwxDmAFSOB1Kdnni63p3+FMompRxwKad/HZ+naT3AoQ
	QWgPPqqYKsU8vPVVrKfTFCb1HzjV0Pfayr0lodxEqbyzExwL9Bj8E2hitb07aUnhGFEb7OXaaadwI
	dxCF3wtzOCMfw0PP0ESYndoqxjBgYjFL9fhffdSlVaf0Ve0iR42m36hfczAhXd9DX7vAU4cha3I9+
	hIj1ZDrQ==;
Received: from [188.251.249.2] (port=56840 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <dan@reactivated.net>)
	id 1x9qjE-00000006M7u-212g;
	Thu, 24 Sep 2026 21:11:41 +0000
From: Daniel Drake <dan@reactivated.net>
Date: Thu, 24 Sep 2026 22:10:51 +0100
Subject: [PATCH v6 1/6] iommu_pt: Fix test_pgsize_boundary() failure on
 narrow-OA formats
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-bcm2712-iommu-submit-v6-1-7b3cace86973@reactivated.net>
References: <20260924-bcm2712-iommu-submit-v6-0-7b3cace86973@reactivated.net>
In-Reply-To: <20260924-bcm2712-iommu-submit-v6-0-7b3cace86973@reactivated.net>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Daniel Drake <dan@reactivated.net>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com, 
 james.quinlan@broadcom.com, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.3
X-Get-Message-Sender-Via: s1041.use1.mysecurecloudhost.com: authenticated_id: dan@reactivated.net
X-Authenticated-Sender: s1041.use1.mysecurecloudhost.com: dan@reactivated.net
X-Spampanel-Domain: s1041.use1.mysecurecloudhost.com
X-Spampanel-Username: 192.250.231.249
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=192.250.231.249@s1041.use1.mysecurecloudhost.com
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: SB/global_tokens (0.00333623274584)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuU2O+qfgcr59iGtQ4XmGkfu4DtUDKTmhMFm
 HPH1gMFfYyu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVIOGqdhbHOpIYMrP9QmiyJbCGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWCfZW7a9uhvfuE0J/hsBuu+eB7itP8hgjDRserKv4bhb4rodgkl+wsfxZHakHKRaVZWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKefuLbx+lGq0svfyhth
 j0R6Iny++hg9dJLqN5zmWqF/oHgMZXS6X/fIHYslsKU0yPHM4JpSMI47HiFQBsGlm5AyJ9N3+CB9
 4aFbAhtG8w3Ly5ZVKmISsN3IhGLWYd0758WcWZORtrVlxIXk5jhWVNuX2TLvWiqA6BF3jwTykadj
 Eh4GKZ8tHsR5A+L9kzDG/K7jeiyzqcpyb6SLIRHv2KIjmIf7YZpqL+v4bQH3sWKlGBPtnYg5YizU
 E/EMRWxUHUQ0hYI+2t4HN3I9ouCIE9ZpmIIT4UMJhQzp+ktYysEoXYjyOpKyQ+6FJGgfvyfesL1T
 Yi2bf0F0JzgUQ/o6tR7CeAtyzyXh0NL4l5vWK73eqiIKw1M+yw2yzZUSfFbaoySugmxqcr8pFbGy
 g9Z1tlDRifW6JNJBY9PymNpC4Wmh+9PD5zE6IfxMIfQh9R3Td3D6I4o5YsP+Lyz6c5yHWp+lN7xB
 IcErjx6FK9ER9iaQgRs40cmSL9tPfD9p0Q30OpoIC5LN3kg+6pSfiZxgu6TiEuYXMjE4hTY0I3yy
 a8U2jinGDQ7KETlEGJUYMkyf+CuqgXx7tGuaZmhNrApMT0FouUljdE6zMT1Fx5vQ5mcmIHdXPd2m
 u86jxvGTfZNouT6f3He7jw4SoVhmTJ/3eP9ObDIxo+BEwlmvIb+xqTvIrBP+6w9smK/hg5o9u16q
 yIzlag+DgD9xY7Yj7fvC65xWAU3TJceJXG+jXar6FtDTl6SazWHDhW0k3iY0Nxd1+egvPpyylyRk
 sDtvh9EglVwlBP3PkVHlQGQFk2KBEkFw3+vw1RS8zKP8o2x05FSSJsC7k+LzVpQY05oubiJ9GrzY
 ++DuIQUs/5JJj4C/n4CILpFTKQlqbzX/LSb50zWeMLukQz+KohJ08RoXx3dChzUkmvNDzuj6WuOv
 dUXMSgmoUKJfN6DTVjUszJAalIcW0Bh5dbygTK7jtNAOpOLoYrBwYYKC6XIWdfPsJXrcrDW6vfdj
 zQ6YC7Heg3Xf7O1TOd7yUx++SDY6V9XDGiqeh8jJhxFbE1QSjfwMTndprmVkWxS1mi+nw+nJxqi8
 G/0EWIXREFLxjmxgLI9seXYsmOul/ykvktkddjH+uVRM1qnqHnNHf6G/7NjKIViWFaEeldR/m2+i
 TN8ji+Mhbk3TTo2Lw6nIoDr0sXUZ7YZoZ/GZ+slJL25ATsZTVifNjYlkFmCz0w5vcdcHI3py3L8t
 PqWAmEN/CjKjK3VVq9SDkpBDU8/nN9BMID38D/++xf97O23y3deP8vNnmz84mDUvZqxnHNc/wp8s
 bbUui5b8WkACIg5AB/ilm4apSU2goW8TQ8+z0w5vcdcHI3py3L8tPqWAC7xZyfryQF81aCkSJYKS
 vg==
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

test_pgsize_boundary() tests boundary mapping with a hardcoded physical
address that requires 38 bits of physical address space. However, the
upcoming page table format for the Broadcom BCM2712 IOMMU only supports
37 bits of output address space.

This causes a test failure as iommu_map() rejects the large address
with -ERANGE.

Drop the high bits of the address (they are not relevant to the
boundary calculations being tested) so that it fits into 32 bits.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Daniel Drake <dan@reactivated.net>
---
 drivers/iommu/generic_pt/kunit_iommu_pt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/generic_pt/kunit_iommu_pt.h b/drivers/iommu/generic_pt/kunit_iommu_pt.h
index ece1c9b8c55d..9fc71db74234 100644
--- a/drivers/iommu/generic_pt/kunit_iommu_pt.h
+++ b/drivers/iommu/generic_pt/kunit_iommu_pt.h
@@ -403,7 +403,7 @@ static void test_pgsize_boundary(struct kunit *test)
 	    priv->smallest_pgsz != SZ_4K)
 		kunit_skip(test, "Format does not have the required range");
 
-	do_map(test, 0xfef80000, 0x208b95d000, 0xfef9ffff - 0xfef80000 + 1);
+	do_map(test, 0xfef80000, 0x8b95d000, 0xfef9ffff - 0xfef80000 + 1);
 }
 
 /* See https://lore.kernel.org/r/20250826143816.38686-1-eugkoira@amazon.com */

-- 
2.55.0

