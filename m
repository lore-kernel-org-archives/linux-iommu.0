Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FAC2E6CC8
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775512848; cv=pass; b=kQ1P/GhisZ5RJiuhDYzQrCRnmyAJOn5fzKZK/Y76auq6M3afgp9oGHmFEMbAdNeeSzbyP5UKX14b+2dHluVA5aXmvPDDGcUZ5kQUUfUGjPhpLJaIjMVacxrMqVcHhKLv0cTX0qZmiMi8lY1UOR+GRcstBGtcVQf0R+w+s8qg7SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775512848; c=relaxed/simple;
	bh=AhRF60yZ5wlYEHmbfH7z43ugDhTw4ErR0cp+/TsXLy4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=e8n1J+P+IcauuGplHT2q3th9IjOrARrzvPXtl8vM7LwVHT7RigiA3lpXzcaGqg3J8D4QH81raC7HmfPt1iI4GK2IDCjPhe0MzXG77E5LQhWNZ56kQj9Ofr9nNaVu/Oi+FbTBqUEVDo19giXFJ/Jvrp9m+HcdQd9dnVasspLba5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=AWCVjSR2; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="AWCVjSR2"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79ee5037d44so58582387b3.0
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 15:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775512847; cv=none;
        d=google.com; s=arc-20240605;
        b=CTaMdFLRBLiCePFhvE9HfOvARG/5y/oW9K1FIKKTWzTGj1Subq1I7JkF6b2jgTJOrJ
         8SNSdCI/10T93kRHz5bOZxmb20inZ/dSi8BIdznayx7seYjE+7Qci/XrGHTeppATayj1
         jN7BNoJex+FfD5/A+sBFWcbhjBiCUrsRbjUS8VgQg/woufHvgXT/b0ChizHHd32HcsxD
         gQRx8DugRZllLVXwRgVVOxWzrrqbDO8aSEoWgHjZpo1+Ko/G2lyNowaHO3z4gr6TdwJE
         R6n8G2uPfoJDf8WS2kMQo8Jsn5oZd3QNc7Fdzw/htEMLQ7PzNoistXkgRFMbHwUgYnOu
         ozxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=IrXmhlnDFDN3/y/XfnM5ZPPgKttgJY7jZg+IfQOG2j0=;
        fh=cI8AGPINiUsFaPjgV8oxDD8ISv0XH4pyElfWI5xjzI0=;
        b=hD5BbhpuxJA0SMXz0R4XsvmvIslhcNpE0x8rUmnpM9HInhXQx3eXLz2PbazRTGAB1B
         HFdQKyANuT4BHcqNAfRAWAmxSI+FbGfzspo6rKtZOXXR9/PSpHRCkBJPI9HuxrcHha7K
         6bDkcbCACN36TFmpi1i3LT0+fCW4hpDM124cy61AVPo0Xpctl6YCtUTruTafXPeB0XiB
         8ZWmNJG+7LHg011XczijesMUUgtJsnZtav6yqLp4S0P6lZhLWPtYu6MGpBK/Pb9BaZuC
         tSctxl8Oqsu70po1q4QoUHW2YTvDxVTmUsjRp7E4pggmC5WO+GMNI7/yk1Qzj52o91y7
         ERqw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775512847; x=1776117647; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IrXmhlnDFDN3/y/XfnM5ZPPgKttgJY7jZg+IfQOG2j0=;
        b=AWCVjSR2z92RiAwqcBJooWg21DHdFP2kyfK4O2eUY7dhRJjCHgHWDH0HxJt8e7HwPG
         C/uxKYiudfe8tC5c+umHuHNFZ7ITx2RGAyrw8POnzf4JYn3X1NNUS/aC/c+h7RLxxt7i
         kC1lAWF2CZIk8fhcun6PkKxQQzKjI97LXJmA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775512847; x=1776117647;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IrXmhlnDFDN3/y/XfnM5ZPPgKttgJY7jZg+IfQOG2j0=;
        b=MsQHqfyL9hBYu/yXmAJMyIt/kkORTo92PZRoquYjg7NDE70lYAt51yHWNPa8HIexke
         VdC7ZxIZ8lapkZG8dz77zwPEQ+NYfv5jeoRFHA1d1rssx0aV7/10dHDk+9TzbWHKsJRF
         RUUkw98kfvpQIdoabyvorADPouwMSzbmrjp8dYbKeMSSOffuQv52z/IGP0nU8EMPVytx
         U/L/xdyXrSOPNTSh4Y6b3l6m9IKxWvawhG0Z4Z+2HY5G0QBb5mhY147DxLJI9Obr+uL2
         WD+HIN9d2ftXQT+OvllbapQfp4+Kod4b3fVn0ch2PforHdoGF2DRoj9Bf6/yZ1hhIRHZ
         nnqg==
X-Forwarded-Encrypted: i=1; AJvYcCXcS3JFdHTX+UmpoCix5ZIAjZrQxIUG/AFynTYbOfpNbBVQsRQkjWmIowxkduPpELHctfHddg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxst0JBlmfbkhvlA0pfoh5Bm5122Ihffw/nhg5u0cTopbCpLDUy
	KCa5ICv47Ybrzj52+EPmo2QUubpw/evwwMlKjq6XKR9keYKaWjnvNiKOlhspE2nXs6SmZSXdLrT
	QUHAP4/UT1xXxMpRft6esvJ4sHiJx3zcZlhLpYaOJgg==
X-Gm-Gg: AeBDiesv3dYnswgvntQ5Ff+YG1zV9RL7H/l9yq32rwGNYGgUln/5pStVxMZsTgLa9QV
	Fi81IyQZtnZXSHjj5mcp1L1WnRbwlCJdFZ2G/D3z1Yar/KenxXJP9w0/we0VpJgHS8VZ/Auk/eA
	FnulR03XdpXNSTyFOSa+Dchfmji8gpxAZMiLsOqJRtkdvIILTbMBxHC5pnAAjHYV08kOP5jTXF0
	WWIFfyZk7zttA6Z7K1mh0jlXriqLdjKglRuZyr/R3WYEitqBo5kqvlXSx7bXqOgFxp06j8eFCpr
	Mmozq/goudzEaDuN3R0j442xy6OVxxAAq6ss+6jtziN9KOobY9XUi3hvhZbr4oD4sSZWTZqayCr
	JhQDGLpTmOmU68CC6NGSRaUX8EDC9H8lp+XOxfF0boB17JHKKmvUpfYT0hTADJd0povvd9BUH6A
	==
X-Received: by 2002:a05:690c:9c0a:b0:79a:b409:b5e0 with SMTP id
 00721157ae682-7a3b8501632mr145564957b3.0.1775512846515; Mon, 06 Apr 2026
 15:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Sina Hassani <sina@openai.com>
Date: Mon, 6 Apr 2026 15:00:36 -0700
X-Gm-Features: AQROBzDj1uhH1bQgWEj0c8LOPX5fqDnQKRUjEk5oKgfET8whs1RVLalE8TLXmm4
Message-ID: <CAAJpGJTzJZ0OgEU8NhyJ3dR1Y1V5x6CwbBjLW_kYLu+FTt9woQ@mail.gmail.com>
Subject: [PATCH] Fixes a race in iopt_unmap_iova_range
To: jgg@ziepe.ca
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Aaron Wisner <awiz@openai.com>, Sina Hassani <sina@openai.com>, stable@vger.kernel.org
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
 drivers/iommu/iommufd/io_pagetable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c
b/drivers/iommu/iommufd/io_pagetable.c
index ee003bb2f647..965fa23df103 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -812,6 +812,7 @@ static int iopt_unmap_iova_range(struct
io_pagetable *iopt, unsigned long start,
                iopt_put_pages(pages);

                unmapped_bytes += area_last - area_first + 1;
+               start = area_last + 1;

                down_write(&iopt->iova_rwsem);
        }
--
2.43.0
