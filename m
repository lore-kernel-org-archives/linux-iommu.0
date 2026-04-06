Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CA52D12F3
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516834; cv=pass; b=MqPbFPdPdtK9O2425ZkkSBdsxSd0JtUgj3/Jffajep3pMHhWGIGA1+em9MlO5yANlXT8VFHXbjxobXNzZxEdsts5oB/k7RPVFqfzKbMfhc9NVc/utxmFqLF1rOmZXoa0s2ic5cCDkPC8uIxcYrkwh0IOSSg/ScEi214U5ghlmA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516834; c=relaxed/simple;
	bh=CbERZQC17/1PoShTGE/NPjrUpQC94UvYfWpdVNsODS8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ggh5CBjYEnAsvjW4bp8q5uv4kFmk9tPrfC49E0dpRKwJjNN8uYJJPjaKRWjU+cEfm7LxXXMGXJKugUXGZHYq8/bmH6ofEBerb6HvoXSsJwe0+gDA8QRZEFj92e8COFPpO6H6l4Z/M3+KUVQvPlds8QIznXTRZJcY7wAfHRggEO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Ca0Zf/4V; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Ca0Zf/4V"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79db5e18ac6so49251367b3.1
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 16:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775516832; cv=none;
        d=google.com; s=arc-20240605;
        b=BhdmBSMN8K0JEyCImKqbr58qSyzVRQ/PuVfGLCWOfRhAkGhTpTtT1PdnxgiHm8qrCw
         zN/S8q0wDiUdNUQ8GWQ6ghAKiitpe1s3s5X8zxRVPw7lgCkC0hL0SmpskOXwnHXnJyan
         EA1j4t1kMGCEw7uw+gUfYzA9WqbDcIq7/gYxmZYPlk0DZSN2nQcb8KmDAsD8laZxa4ch
         29sDSIF+l4jP9+G5XB24eAPc/pTjICXk/DixFywdY9pYxmE14gGr/b0gR9aNMCp7cL2D
         7YAiI55kxaymtNNRXzE+IxL+SO0rDUn08LRNsvWnGkn/qmMdd9ilV4XxlUNoz9/6hGUH
         nmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=L3Od81lft/9iTZV5t8cEzGB2LzR86DDU9DJfU96Ox18=;
        fh=afyatCoU4klsvvYQbnULTT1yPPOgCERQCqYoaIpjOwY=;
        b=fgcJeP+L7UIHsU9Bwiyb9lx4biDWkGVBSBX/yYZgEVFyyyrEZKlR6T1ldfXpL092O/
         yCeWjJ6X/aLeL9PEEOuDpU5FEa0upCv+0i12Kjkws6FM49fk7Kxs6gT0ST6TaEWQWwL8
         vJfZ7PKox0AHjlnxQUOIV2YF+k+C/uZ9nGyTn5DdnmUAnvZBMW4d3ppMJI0ACeDuRciI
         pl5PTUlVEKmQUC0XfMtqghctjwHhZDkbOow2iEqpSQ66rcVL3QwhQjO6317OE2Zd42Tm
         jal6qHPYWa/aQbrJXnza/EfOVlhAq4sx8TWbGTPkipgqRaSEBcXNxwt/cDOtnXCDY1Le
         ubCA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775516832; x=1776121632; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L3Od81lft/9iTZV5t8cEzGB2LzR86DDU9DJfU96Ox18=;
        b=Ca0Zf/4VujasCqbRwF0yVI+KFneQ1A4IIbgRIwO6t1ZlOBqJ+Re2l3untG+UHmxahZ
         5Sy9x5HfVFNj23seqAshlZdSf4Yr2ovTM5eIvcOp9FOKLE3fep0sIt2Tc8cI2Gy3jgPY
         2cZL7YXqhFUYgorRz3jMxwjD6PzihvvIMV2Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775516832; x=1776121632;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L3Od81lft/9iTZV5t8cEzGB2LzR86DDU9DJfU96Ox18=;
        b=DPgrsom+iWSlB3RfQ2J2vwOEQcROJ5JL8e7jlNJFrNaSa+AwCwZzaiBL1GwU7QY+kW
         0KA0C260U5/sgcyNW2fbeTguR3eWFXR4qpNgUr9Sn4IDf3f0Xagx8mcxDwZBNsdr1IkM
         we2k3lAqmN6Fl6V6ipg2LlCk2MUTlGyrg/O+rjphnAamJYtw+s6vmuqUpA/EfmB3MNIF
         qXWWwZn2uPEI0koggmr4YeC4S1FzT3Xpwi5jBGCC5UT27hWeIF+KC+2DkGQCOx3rw67g
         hT9uNKzMkiMpnn0OM/OOBzm7rfQQeiUbI6ylMhchgB9eBtpoxWI8i5zQKzN4XxH4KELl
         BkFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXABPAt7142Z7qqTgPhHXr6R4jaZlSHMmxCmEU7eIQoka6Fyc9QTRMLvCeABl1zaJ09pbCCeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0Z7er8TRaDKrh3Rmctgnh5KSdh695X6svuZeS5+GS6PUhoYI4
	kYX14iPKUaOYDLMpVCzIayWvWhJ6g8M7TOMqjtZ7o50GsV5iDDiLfbLzLbB6rRyve1VCNEN4gwe
	qkkV8SbSAWjrCWNOcTOecctN1cHiKr45d1YNuOfwylQ==
X-Gm-Gg: AeBDiesfM4Bpao4/LqAC5YbKg4mFKE3dTreTOj1bl8WSEt9KH0KFSWTRQ4MFgZAGq0A
	gbVx3XhV+cFbLIZ4iHDkJxNGcoYEUiA52sm3h1VhJag5v5AYg9iW2CPnZOR/mGwodbrbVK2zFl0
	0qYm06gVR1MGtzEiV0ugFhk6INGCFkR2MHhHMOcuRq0Lb8L6psQMJco0a1RKaPyt/AMEDmFMmm+
	+Q4C+URwcFBhmzQPN37knrGuX+jOP+hHjne7kwBGbNfRaD8GWhkcTg24uU4UXd7dcsgUKJam2ep
	wRXhzBSU/apizGv5q1U9/7WIvNObl0t0nOBmhdSU1Me/A3D+r9nh9jYOO5YfGmZuRQPILHaVss3
	tjXEW7yALQWoX0LCdNHV4J+xySCvVKxX+bgB+fJAw50PsYKdsEkE2mpL1k5sE3Rg=
X-Received: by 2002:a05:690c:f06:b0:79b:82b2:f284 with SMTP id
 00721157ae682-7a3bdd8177bmr137403337b3.17.1775516832586; Mon, 06 Apr 2026
 16:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Sina Hassani <sina@openai.com>
Date: Mon, 6 Apr 2026 16:07:01 -0700
X-Gm-Features: AQROBzD2O2l_CHT8-ax6fGxbh3AX0FfbqXbleB2YomgxanwhD99Y69vm8oR3hmM
Message-ID: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>
Subject: [PATCH v2] Fixes a race in iopt_unmap_iova_range
To: jgg@ziepe.ca
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Aaron Wisner <awiz@openai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bug: iopt_unmap_iova_range releases the lock on iova_rwsem inside the loop
body when getting to the more expensive unmap operations. This is fine on
its own except the loop condition is based on the first area that matches
the unmap address range. If a concurrent call to map picks an area that was
unmapped in the previous iterations, this loop will try to mistakenly unmap
them.

How to reproduce: I was able to reproduce this by having one userspace
thread mapping buffers and passing them to another thread that maps
them. The problem easily shows up as ebusy errors if you use single page
mappings.

The fix: A simple fix that I implemented here is to advance the start
pointer after we unmap an area. That way we are only looking at the
IOVA range that is mapped and hence guaranteed to not have any overlaps
in each iteration.

Test: I tested this against the repro mentioned above and it works fine.

Cc: stable@vger.kernel.org
Signed-off-by: Sina Hassani <sina@openai.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c
b/drivers/iommu/iommufd/io_pagetable.c
index ee003bb2f647..c69af341219a 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -814,6 +814,15 @@ static int iopt_unmap_iova_range(struct
io_pagetable *iopt, unsigned long start,
                unmapped_bytes += area_last - area_first + 1;

                down_write(&iopt->iova_rwsem);
+
+               /* Do not reconsider things already unmapped in case of
+                * concurrent allocation */
+               start = area_last + 1;
+               if (start < area_last) {
+                       /* Overflow. IOVA ranges do not wrap around so we can
+                        * exit here */
+                       break;
+               }
        }

 out_unlock_iova:
--
2.43.0
