Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DE437C911
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296958; cv=pass; b=TN8bfomciTDOWw3Fl4JiM5hFqo/K3bsoK196WVp/RYXwbnkYtpdZkimJdin/l4V5bFdv/9TikXb1F7LA63ZZel1OATY4kdv9/UeGcYshzserpB18UCDZWzownbffDq8HpVxDvPNHIza3eObNk5hSce92uCCILHhpxvuhPaoYgOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296958; c=relaxed/simple;
	bh=iJmzK92A9g87s4Yqb0q0EqciKhIdjER1uzTkPCiG70c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kR2ElEsylNSXcQGamfTb4KhyIqHzLY8udePAOFu+xSGKrdtf18foX0WY/kI5+9IJSUQEieTEQXdy+k/tG6w+Bq8wLTo+mOiWLjRMsuAAJrJ0LtMt7aiD9pVnOMYTIXYO2XVkEXcrA5MJ8TuH5dL1QM5n3mRxAe6Q+Q4W21iC1BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owONDxiG; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owONDxiG"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b4ab40d839so197821e87.3
        for <iommu@lists.linux.dev>; Tue, 01 Sep 2026 14:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788296955; cv=none;
        d=google.com; s=arc-20260327;
        b=Qys71tdQudqKlK7fdRwVylaI+XGuzNDZfqwgpKF26Y4JGYNZgqDXkwar39KCBESL1O
         BU/ITDizw6v941utWukk9AnWWRUr2fsmRVXQeGk7gjlejbtYkrhdO0TZBeX9CzX6Gl9m
         G9cP5TnnDy4HSlYw3tsM8kPmg3En+wRhCfP3z+vcSTsRsjmznJKA2VdANMtXy9SbBv7N
         JnsD1FXJ3FV2TaJD8UZ/JuxFGtmOlaJtyr3MR+T1OvoudmiO3H1NAbaCJj/2N5MMzgAi
         vNjCX2H4F67d78E9LceQoCYtREr//e5OVvA4iePunp5AuxgyzIIlZ7lHWPdiSk1fSPCy
         zj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+JrNgLRwy2a+rZYVU8Y5uARTaNWjOc2o734+i3U9Gs8=;
        fh=qR3VQXVegcdGAIFOeV+QId1twGveXTs7Z7KH3dsxKxk=;
        b=eSPOzHKYIssUWNSv0/bmqExaA/qk9Hc6mQ9EuPmYErVq7PWgKVnGvm4fjYn+4dgLfS
         iHhYljxl2Mh6FZYBFy3NNf4JKiFEYIJ40CBl9Lug5WEk3kMWQA6nUaGgAvgF14n3m+xt
         IQu492O42P4caEHWh+nbUEd0/EAS48K0iZcAGAeb7ZjlQd6lTIQdrKw7dlmsndGY5BjL
         DZbS8CGvZXvU3xFya5spB57kDN+/c6O6MJE8/24ijvyjT9CGpqQOa3tQ2wbid5GAS/0R
         Rc+wWjU/cH//W4JAwwaf7FIJQXpIckrR47m68LuP7/ufnT91qQVwDR/FNrmf+SL4Nz+T
         qPEw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788296955; x=1788901755; darn=lists.linux.dev;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+JrNgLRwy2a+rZYVU8Y5uARTaNWjOc2o734+i3U9Gs8=;
        b=owONDxiGmqZE48ikyyymvSK90jD/B0pPcYMvA8cqb4v8eQNeFq4Pi84H3E3+qocxOZ
         hpufUyAdYyUq1qDVq2fppNLsfIfWeT47kkGeDQscJuTcN3TW3wgxQhMOuFTSW5flja2l
         G/SpuOTLWn+fxw9+T43/izwGlzQ/geCEMBOFGdeXzBXubwl9s7b0BniEpRmiLPdET5+V
         gQHCrvQd2Mu+GEwbJXpHvYzAcI59FkyOIdtaQnhBR9TudhqRmyL+hDrXz7qUH8g9FIks
         CME92jMgRHgF3XNYqq7ZyJABzGvNBvtaBLimGy1ROSCkn/4RBP9LCg7lMK4hn+PMbdU+
         FuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788296955; x=1788901755;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+JrNgLRwy2a+rZYVU8Y5uARTaNWjOc2o734+i3U9Gs8=;
        b=qEH8k+QT99zEvRoKbbOj9NwFltA47recbA6CYQkl13dugVTIfA+dRH2jekq3tMvMYP
         6q9E4YTIJWjLuiz1TWBLcwYweadfIyQ7mdf3iJchgK7eJxcSuX5ciYNZ7NdlBnoa8y7R
         hNdFkBVOaWK+HcyA5USM6SGjlJdAdS8z6fDI6ZtuLJN0u+Az921lHW1qg/M5pP3Vb1YS
         85YJa4AGVLWu68zDObb1PfAjdJ3FP2tX3BfF26hg8jQMWinUUGSvPU2TvpwEvT7udK6m
         n5bACluZMDhVnstIpv06a1nycZqJdbXTgvY7zlBL4haFejzH1oR4wMU2F4pTUkDGCa7/
         Z+DQ==
X-Gm-Message-State: AFuF++kYRmqEQy3F2fBgVPp3CHR3L66fjZaQLAcldjc4HuMVukAgEbbp
	7wtwOaMDmX601Kml1wIWOisbtwPv8Q6ikU2nt9cIRxeXDTmu90k6goVwTmyb2uxfP4KIXdLIZx+
	jgMYKXGKdc1NrfXxXJ0oCOx5UFacjxIPPCfAcTr0=
X-Gm-Gg: AYBFou1GUzm2qAs4ysTzT6DIx1y7whEbd3g6zqAyXgpt7y5vXF5zekFZ+pqVqLSPFp0
	Fp4cn+NTKOA1f8OUSHTuN+YaRGmUQofyPcGjsaqfOEyGSetkeBLcB8hX5zsAEYQ/24d8kNMy+yF
	c1yy5hfT9b0bAeZIRbo2cnBzqGtOuNBicPY4G17YD9Ba1uKjsW7gtE47tfkVC6AqXvgMvH8J1vI
	NPrTEQC04Npz2+g2JYiFS/22fhyz6Eyi2ksbMaOYA5CbTnHbTiC3stLs/5ZuysuNYYl8ZemJcUP
	6+TFuPuwppZ2Jl74EwTpwXVz9LmvfBpoFZOdINC3A3C9zivYxLHQm3/xgWGEh5Y8hW9IRAHDs/B
	WEQ4zh81P8BK0WxPBW4ohgF+Hf0yE0I/HzA==
X-Received: by 2002:a05:6512:3503:b0:5b6:4b2:de81 with SMTP id
 2adb3069b0e04-5b6087d8070mr118778e87.31.1788296954944; Tue, 01 Sep 2026
 14:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Timo Witte <timo.witte@gmail.com>
Date: Tue, 1 Sep 2026 23:09:03 +0200
X-Gm-Features: AcwNN1UOUPK9zHDNP7duuakP6z9DN_gmHnBJ_mL10m6jI7kVdKHmnAOz1lxICWE
Message-ID: <CANB4YXS=Nf-co3t8eMHtqrW4sn=1BDcP6o=EoTrgZm0WYMYTyw@mail.gmail.com>
Subject: [BUG] iommu/dma: "Not yet supported" CC_SHARED rejection regresses
 dma_alloc_attrs() on SME hosts with IOMMU-attached GPUs (commit 8277a12d0d60)
To: iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Commit 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select
them via attrs") added to iommu_dma_alloc():

    /* Not yet supported */
    if (is_alloc_cc_shared)
        return NULL;

dma_alloc_attrs() auto-sets __DMA_ATTR_ALLOC_CC_SHARED whenever
force_dma_unencrypted() is true. On an SME host (mem_encrypt=on) an AMD
GPU with a 44-bit DMA mask hits that condition, so every GTT (system-RAM)
allocation fails with NULL/-ENOMEM, amdgpu init aborts and the system
boots without a display.
IOMMU in Translated/DMA-FQ mode (iommu group 29).

Before the mentioned patch it worked: the IOMMU PTE carries the SME C-bit,
so the memory controller transparently decrypts for the device while pages stay
encrypted at rest. For IOMMU-backed devices force_dma_unencrypted() is a
false positive - the device DMA mask does not limit addressing once the
IOMMU translates, so CC_SHARED should not be auto-set for them.

When i remove the rejection and clear __DMA_ATTR_ALLOC_CC_SHARED
in iommu_dma_alloc(), so encrypted pages are mapped with the C-bit and
everything works again.

Maybe we can implement real CC_SHARED support in the IOMMU path,
so SEV + IOMMU works on x86?

I already reported this in the amdgpu driver:
https://gitlab.freedesktop.org/drm/amd/-/work_items/5735
But i think it should be fixed in the iommu code as it's a regression.
