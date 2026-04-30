Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95E23A75BD
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777549831; cv=pass; b=rzvzYgvuPKt8C5bI85GQ151iYbbSw/9TY8RaODZgrRjQ+Ms087mDUBVNWPcqtyWgz38ykCXdtSG2U/S95hs+E1jKZZEk9dhJ4CFFXb4XfTpJtS3Rkigdn4ivuMwNYzwiR8auxoBwaQxKJaYzzoC9B0FoLnXSvX3MDV/4+gLu6Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777549831; c=relaxed/simple;
	bh=KihtfK9D9cPL9XluiFB9tIj1YOnUMt8+Kkxl64Ym1F0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nueVNr7LfUEHNscGhzcHMVBT4HaiOGjJYA9Lkp2hi5tVr/uP3aOCdLldSSIHvR8jwhY1M8buGHH+0CWwTzaEBU/paGAQUGh4zq6DMTbz6c068OM3P4fPRnuiyLxPaLD+JeOzZlpvtAx2xL0GDJ7MLcKmdCRtmBC4iq/crNvlL7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXEO73ly; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXEO73ly"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891cd41959so7595125e9.3
        for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 04:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777549826; cv=none;
        d=google.com; s=arc-20240605;
        b=GUj/5gaLnuHIth8yI5QBXmKTNqEsjmAnenaGsEydDcJFN28zeeyPddWfAoWWWSXlp7
         c0uDbiZQOlSIThBSY9B4yUzazHbY7RtfeftfcWYf8TYq54qAY3qmujIGRodMfuBv+HPk
         PDJLvIJocCm2fP7y1aBm+e7SjAaJOjQ1YZKYSwjmnYI/gAmYohG0NoUOiutOoyiy5sky
         PgdM5vEu6/PHUJYd5rFe/e5meBEvdFXIsOJHB9RrOxOYlPebtWC/BnC69qg8WmSeOuKB
         8rlGPRJE/otI8mCYdW/RAEI5ck4Wmtk815dYscQlsFdp40zJmWmMzAg6lzlNoE36yneD
         Kg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=KihtfK9D9cPL9XluiFB9tIj1YOnUMt8+Kkxl64Ym1F0=;
        fh=eN+hC+lN0HtJNF1TW00xQ+Fv8uQRg7upeO+95xDRHqo=;
        b=Segp+rQsEXw/M8vm7uxIgDX3Stb693r1NO4kf0WRoFID+5M0HdmeKy/edd3RfoeMkh
         gf86WXtm9rdsMuDEgQKANeUB42Et1kEkjhYLNsV/C56QDLGvqUHqtszlLfAT1uSiOOXE
         ml6qgv3XawYZ4oRvwedPa+2vDw47JawHNpzOyQxnHUiFP7M5SwYlihLGULN8sJzO5iEK
         /Ap55RKLVSu2QD9WefM9lw08+Oy00KppF45kb3lb+YEuROmZTDDCPwN1F2ucvuc05vzR
         xqPSGDYHOIlmLRbn4mk/OlXN1bTwf6F/8wZVQHQU69GeNEzpeyx2ZS3Tdas+B2YfEgw9
         9mGA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777549826; x=1778154626; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KihtfK9D9cPL9XluiFB9tIj1YOnUMt8+Kkxl64Ym1F0=;
        b=JXEO73lyfeNUvOyeIUCUP55Q1eDiGqouh+U90L0LxCYgFFzBgle5D8wX5Y1GV1W/g5
         jtqB/BUdnaQ9ybftEOmtbXqTI5aL9M5v3WIpCL8wJOES9vCsXCjWb/2oaryyewOxkf2m
         Z1TmfzDbyP/z2xdteZwrn2S+dn/c+TvmhuqemzKOl9PxM8EZMjONgnvi/Kbmnmo8h835
         F7tPnXzZE127UUO73MLsJShEVxNZ6zHRumitX85a1+6GcbMUPJhXLcIs4IbODXdJuru8
         PESV5nEUvVpFkITSWDZkp5tFUv10wDKTr/tKNcqRZ3gwbkX2RSpFCej2KNOuinZoDUQk
         rvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777549826; x=1778154626;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KihtfK9D9cPL9XluiFB9tIj1YOnUMt8+Kkxl64Ym1F0=;
        b=Q3qqwx80U/FGes9YzhO1aWREVQ4khkKBHHf5cE6RzehM/64QdyjmP7ezRHlofvdF3L
         L4b2Pj8jk+IPxnmYyQ6FU0NZzvgXgc30z0yX2lxRPzEjnOh3E0em8aY0q/2acpWSCGaR
         iYcIdQgupcW8dz88gx7eSGmT07rk9XiY26oWahYNi+Y9pkR077gqaL0nsdy0A4JiuoPP
         EhZv4EKzoscnEEX5YzYRAOCJzXvn19dS0YEglKKEOu01yuCaMUOxaAUgJC2UfISbELKb
         4q5+VqGR5XXu2ElXay6TjC9vvJLCmnAJNs45qgVSlbBa+S2I4gmuOR3lHyWCw2EXKmxv
         qpdg==
X-Gm-Message-State: AOJu0YwkaHzKrqUhKwRsbmkXbpT6bBJipsdEPT+aWJV5We7UNWhfq0RI
	GZpkRFQhobEztXsYpND6mI4t+CGcLH0WUtA3a5F8kiSwes2z4md17WryfLwmIKpBzH2W6vnBnfc
	svTgiJ7wD0Y36JEWJ1EdarRZ0dUOjLuzzY/6N
X-Gm-Gg: AeBDieuG+FbX/guTs8KqlBhJ2/HLGhuBKX37s4AVb0vVtX46Ec+FXs3z9bBQXtWjT7z
	TmkRfCWPytpbCfLE1mL8rtn0wvYy48XsQzF/eixFJT7LBUkWNGR0etekgrkdohCwYVyaqWmzlBg
	LuKdaqtZcS4wUBghxa2qiQy9GPHRH1ZIbr6Wj4gX6sqdrXXyRxy1VhXyy+HoHaqJYCOdNwUGCRv
	4C7tzI0YzVDjVgj4uh9RI8ei/CRMVM3WYll4olxuNETQ+/7PGsQ5mmuwX11rBKYddw2iIZWT/1u
	vE985BMvCxOIXxZgx6w=
X-Received: by 2002:a05:600c:a49:b0:48a:f18:ece4 with SMTP id
 5b1f17b1804b1-48a8445d265mr42858075e9.24.1777549825854; Thu, 30 Apr 2026
 04:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: =?UTF-8?B?6Y2+6IiI55KH?= <ao403268@gmail.com>
Date: Thu, 30 Apr 2026 19:50:13 +0800
X-Gm-Features: AVHnY4IH_Y0eaJhXMRctf9PVH1s5z5dPGUBu4ntvPfSIAs0WAH6mtfZttcV5elc
Message-ID: <CAFjZNbmNt10d=cfWPCFwquZCFtVGbSJY0XkT1QZER4+yq=zfBA@mail.gmail.com>
Subject: [Question] SVA PASID lifecycle during rapid bind/unbind
To: jpb@kernel.org, will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi all,

I am currently working on a driver utilizing ARM SMMU SVA on Linux
v6.12. As I am still familiarizing myself with the SVA subsystem, I
would like to consult you regarding PASID lifecycle management during
rapid bind and unbind operations.

The Issue
When repeatedly calling iommu_sva_bind_device() and
iommu_sva_unbind_device(), subsequent bind attempts occasionally fail
with -ENOSPC (-28). Based on my debugging, the allocation failure
occurs here:
https://elixir.bootlin.com/linux/v6.12/source/drivers/iommu/iommu.c#L3452

Root Cause Analysis
In our current design, we limit the number of available PASIDs to 1. I
found that iommu_sva_unbind_device() does not immediately trigger
iommu_free_global_pasid() because the mm_count has not yet decreased
to 1 at that moment.

Specifically, iommu_sva_bind_device() increases mm_count by 2, and
iommu_sva_unbind_device() decreases it by 1. The remaining reference
is held until the mmu_notifier drops it. Because the mmu_notifier
teardown executes asynchronously in a separate kthread, we are forced
to wait for the scheduler to complete the mm_struct teardown before
the PASID is actually freed and becomes available again.

My Questions
Since waiting for the kthread is non-deterministic and the PASID
lifecycle is strictly tied to the process (meaning we must wait for
the bound process to fully terminate before we can bind to another),
I have two questions

Synchronous Teardown: Would it be feasible to manually call
iommu_free_global_pasid() and free the iommu_mm synchronously within
our driver (similar to how mm_pasid_drop functions)? Are there
underlying race conditions or locking concerns with this approach?

Alternative Approaches: Do you have any recommendations on how to
reduce this teardown latency for release PASID, or how we might handle
this PASID exhaustion more gracefully?

(Note: Apologies if you receive a duplicate of this email; I
previously sent it to an incorrect mailing address).

Thanks,
Ryan
