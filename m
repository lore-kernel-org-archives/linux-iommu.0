Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991709;
	b=EC+1UiQLKH8WpzMhxum3y0UfSzTXt9WmPBb1V/TRVajGqDDhCtzTm2cKkZCgXeShyagg
	 3XXioGNh12DCc9zNIrdq5sfuvCJUvW8YotuF7h23HxNMawh5xYtzHN8zvNljQdkP3X4vV
	 h2gqrFbhuQ2Wjwe+WJgSKO80x9T56NRyc9Mo4gZ5XPT6/oyZGldkpRNBhafCqhfGOkxQC
	 fRW5JwqtHgCTe4hB6Wy4A40YturmUNw3ru+43u039oL4kBF1muDoAoKg3QmH39r5kXqM5
	 AbIMx73hXcLjdEjFQwtD4G/vpvKCg9spLJNSYcrkcmQwQ0u8619XL2sGmIF1kiB+QFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991709;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fL/YIVvmAkn6C9fFGJOz5bLgkfP9C+qON7W6Gihge+o=;
	b=c3HSPLES2CWK1TKCW27m/cj8LDIZxdoS3fq46iEsuWTOAUWpu8eQReuHXcp77QTVVgFJ
	 fLGnlEsfMnfxSRuAUr/uiDXsKjdE/tKFnAlM9wz2PgNul0fim/BduQMtqCGunZkvaDC1G
	 2zuZsE+ye8ccPPEkIOCu6yd25t2pYuXBAjGLvnidSaH8Cr+SGdL2aeYch5Rjp4jB7r1OC
	 TAkAckrgG2vzUpUtUpACGi683v4vnFWf1S4YaXueqpvDkqpaDjuY42ixasykHzrySrp8D
	 3JDVxcwtk2CkAdSXU3XcohPZHA8MtK/NgPIie4XKZVsXJJeoqLx28HHLYIwaykxnNtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=bHh0sPmG;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=3YIJ8IHR;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321F5606A32E
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 19:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 321F5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=bHh0sPmG;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=3YIJ8IHR
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6IwRW4771108
	for <iommu@lists.linux.dev>; Fri, 6 Nov 2026 14:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=fL/Y
	IVvmAkn6C9fFGJOz5bLgkfP9C+qON7W6Gihge+o=; b=bHh0sPmGt3w6lXJpywnU
	gHW9LA2ulBlmWFTk+UQxp4D6pW6D1GoHvpSXB8X9oDIwhPvW5oDvvSoFi4T+g54U
	wl/DjeX73g5dfCv4evrstZ41ulgHBIGQZp+0QxJ+oEZW/g5k3BTiMNdDRheJJDzq
	u/WHCscvDClGg8fhUS7TQVmByvxCyu7t8jDkYmUgTDfGF3LrUEb1rUHTZtUv4qbh
	3HqgA579/OhEdFiKYyd8k/50Na3RsFIWkTh5PX0wqQp15hguEjssTqkzbyJ4mpxW
	0QpTuzNfrddS4a2/tSjCEKbQ6wTvxozsfQBw/MRTVF4fGExBDbilpWxPTFWXmaPc
	cg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hsmn2013b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 14:01:48 -0500 (EST)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7d27e34c97dso226859137.0
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 11:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793991707; x=1794596507; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fL/YIVvmAkn6C9fFGJOz5bLgkfP9C+qON7W6Gihge+o=;
        b=3YIJ8IHR7qJkao7Ydq4kos/9VzEK6BsG/vsRoMcA8/sAr8uYXGCWPsUONqD3C3T0x0
         SwMqCg1h/TFwRmgNHwijCtF0Ajyu2A/3yciEqzF3cOaP8W88Ef0/YA/zK2Y/VzKztfD+
         IFOghQ3Fk3OCeHphM94eM4uHvBMq74wVm69sY5MDpc00GGoFOe2+hvLij5lCgjpGOQ2C
         vXIZVJCekjppFieIvJguM6BzKzqWZfqw74bfBW1IN+TZ2x1i8SY2x0Mv89XkgvwLh8nJ
         7CQw54S9LD64Y5LtRkx8oBsGWjnqtuci0+PsHEqfsQuE78wi3GKcrwW5xrHHziERTq/S
         XpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991707; x=1794596507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fL/YIVvmAkn6C9fFGJOz5bLgkfP9C+qON7W6Gihge+o=;
        b=ntFSEjhMfSFcdTiqCNHAvpnp6wXaM1WuLgVCCEgwxWqD3iT7jNrehW6IEPUzYOalYn
         J9w7yb9OnhRPajY25qOEnJhiCJkgYAj5BrMBkn7q4bdYW3w2y0PqIgtNkQZxSpnLQuPp
         niktFAJS34VkiQ10sRVirzKhFB/RdkPJ2/mMpCyub++4lefhqTCAGuzUaBVoaRRF0MOd
         zwDV41mWkiVGD/fHf1tp+p7t9Al+OQb197dBdDIp2FW9JCJlGGFoLxM5aYrA9STEXiYA
         PCW+jAY9u7Uy4Uocq8MaHIYwG+CObszPip6F7dZA8+iOJVbtxy+bgEF2jsmZlLcTVj8K
         wlaQ==
X-Gm-Message-State: APuU4Z+hQcr6PqMV2JuqS/GPxLZ/R/iM7nWKR4yR+K1rXhyMo4MAW8MA
	hFZuVIa+iNmLRACafPmme6L05RgJkRav5evkR0QOwMy3vMR/Y3qi47VmPxxm8X7+s2PxWiFWS8n
	kh7IKZgcInGLG6AmW4FOjXWaarELVOwPdv/GZ7Ld4ZujfV1Bxz1jZ
X-Gm-Gg: AYBFou2OOxlw1vyVbrXydc721ilA8bS1dBWKYsdPYo3GIA58Habz/xVX9c2SeexmTtk
	FUyboi0BFvydMI/Q24MMM9xjNda0bCk46BJZRXm8mSTmDMrUNhiGtWCVl2PqIOuhPL4KW5gg1dz
	fbEx+Y3EfoYRvwFwGu8bxy12tCk4lK/uGRmpXBuOWKuaeofwbFLU1vmh5+q83dOs+vy4TKBNeqm
	KcJz9Rr/3Y6phmkszlAXKPW495acxDrKjlGd2p4kCbukeEjPhbinRXcdgPZP5VB3eseQLkpziN3
	QPn/R+tzkb2AlLygeUQn0NYcAYJrfbqUmQE+cq3ZPX51LwTgFEJVk/V6YOF9Ispgu7+QIlSzj4v
	lVG09niTXC7emKI5SkvQeGhUaPCaEHNxMwK/nLKg+zdtjz++Z+IkkHLJYoY7LHjzJswjq+7qaDx
	tZxAUWfBwPIyWNdnL1zGd0
X-Received: by 2002:a05:6102:6e85:b0:7d2:75bf:2fb3 with SMTP id ada2fe7eead31-7d2a130dba5mr1434514137.1.1793991707085;
        Fri, 06 Nov 2026 11:01:47 -0800 (PST)
X-Received: by 2002:a05:6102:6e85:b0:7d2:75bf:2fb3 with SMTP id ada2fe7eead31-7d2a130dba5mr1434461137.1.1793991706468;
        Fri, 06 Nov 2026 11:01:46 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-224.net.columbia.edu. [128.59.176.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a71bfesm27276376d6.25.2026.11.06.11.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:01:45 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 06 Nov 2026 14:01:19 -0500
Subject: [PATCH v2 1/2] iommu: allocate the fwspec before dev->iommu in
 iommu_fwspec_init()
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-iommufd-folio-dirty-v2-1-3f0b0be58c4b@columbia.edu>
References: <20261106-iommufd-folio-dirty-v2-0-3f0b0be58c4b@columbia.edu>
In-Reply-To: <20261106-iommufd-folio-dirty-v2-0-3f0b0be58c4b@columbia.edu>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jpb@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793991701; l=1738;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=YImvvlZFrqDYla2YNZWpOm7iJ9MVG0DC+EbXLLfh3dU=;
 b=4qBysV3kPQuXymvnOmYM40zaYRun24qvJwtSagbCsn7iDgW1QXdVZHNrhWKtQtyp5lNkLdb8J
 S6OX8vIHdksBh3/k++tb4I1JuYTHNe0aG4bOjt1MEZoMmF7XxX4D9fT
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: MHSEdCvHBBLHs_YOCg8jYOgwITZNP641
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfX7W5L3T6ixxmQ
 tRpu6hOXfizLtkvZkgtm9tNxhnWnLOPm/UzOo6FtmznDk+yUZUL3nfLpTcV18JswHk8YYgedt5A
 D5mLQKJska/5s5YRFP4IB/yXwhhzp6/lxLS9rcC2cAkzluVbiPc2O5deEglALcg21LYImHJuTmu
 8JeJupjG+fnZDX7It6IBH83fagjFpefWNVay4Ugw459wNVYRzN27INz/ISJBOmrd839H3LB4wYT
 7uOdFlkRnlYnGHpj/Xq4GrfWYKQnfhA/IByDmoR+5xkXS/8YIv320qoNwcjdn1TFpgCBW4u0i38
 pqHy8hDX38XhvtGfwHygj6F2nAN2P4WGDgWSgrrz5hSartXLswihUzVZVAtHnAJQDYZJ+TfLx8X
 Sn086pSMWXNf6CdPLYv5a+hecQP8tReHncfs3k5vz3Og708sH0/JxV5bYL+5+qSAbN6kR4NE13Z
 FEWHbwVvDXbDZHkrwNw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfXwmBDMU6eRAH6
 jB9OJ5JUgWX54QJxSRmY7hQQ8oSeXcV2VApwwjL/naa+hmzNnA55oBe1/csznJue4HaAPNbAgis
 Y8RXQpVy/Ta0gmHQpGQUzwae7BY10HYigWVNYpqKY27e4VYKh1pX
X-Proofpoint-GUID: MHSEdCvHBBLHs_YOCg8jYOgwITZNP641
X-Authority-Analysis: v=2.4 cv=DoXDa2/+ c=1 sm=1 tr=0 ts=6aee241c cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=bIa82ERlpw6mw/X9g1H6cQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=zvkRjCzplxS6iKm8slIA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11958
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=10 clxscore=1015 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=10 adultscore=0 impostorscore=10
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060075

iommu_fwspec_init() allocates dev->iommu and then the fwspec. If the
fwspec allocation fails it returns -ENOMEM with dev->iommu left
allocated, which only iommu_probe_device() knows to clean up.
iommu_mock_device_add() calls it outside of a probe and returns straight
away on error, so dev->iommu leaks.

kmemleak reports it when iommufd_fail_nth injects the allocation
failure:

  unreferenced object 0xffff88811c138b00 (size 192):
    comm "iommufd_fail_nt", pid 783
    backtrace:
      __kmalloc_cache_noprof
      dev_iommu_get
      iommu_fwspec_init
      iommu_mock_device_add
      iommufd_test
      iommufd_fops_ioctl

Allocate the fwspec first and free it if dev_iommu_get() fails, so an
error leaves nothing for the caller to unwind.

Fixes: 2a918911ed3d ("iommufd: Register iommufd mock devices with fwspec")
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 drivers/iommu/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9a..8cdecdd119b6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3083,14 +3083,16 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
 	if (fwspec)
 		return iommu->ops == iommu_fwspec_ops(fwspec) ? 0 : -EINVAL;
 
-	if (!dev_iommu_get(dev))
-		return -ENOMEM;
-
 	/* Preallocate for the overwhelmingly common case of 1 ID */
 	fwspec = kzalloc_flex(*fwspec, ids, 1);
 	if (!fwspec)
 		return -ENOMEM;
 
+	if (!dev_iommu_get(dev)) {
+		kfree(fwspec);
+		return -ENOMEM;
+	}
+
 	fwnode_handle_get(iommu_fwnode);
 	fwspec->iommu_fwnode = iommu_fwnode;
 	dev_iommu_fwspec_set(dev, fwspec);

-- 
2.39.5

