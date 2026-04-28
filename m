Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A773A963C
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361943; cv=none; b=ZmkBG29orFDokmHHu2c86dn9DPgLF9LCpvH6FVn467wEORtikD+WqhAhJD+/gbE+MzKQ/bokR1uflK+9PiUUFwfni/QooVIyDBI//p5RZSOECU7ORdCtgFoQmDwvf7gqcSBtLzkd0Mqw3zSh7jfs5XVTzAjWycQyyerSQ0CUWFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361943; c=relaxed/simple;
	bh=LOmVa5HEYXAhxFxX5dmA5ibLhZjG/rAPjw3EsQuigAE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oH0DYR3FDraFllL1zsnwM+FpDJIHnwaW0NVURpKlawj8SbtKdofpbFobOfP/q3SDirjZpVQFR6OFOVRtndB9cB7rme0+L08rwszGGkECcpDGAKSHNeLVCTfUCdNExTXG4EAwvYlB/y91T5lF4NZE8BnNCyqDrI3bBvqaU5VIRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+6amBpY; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+6amBpY"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f460260cfso11167396b3a.2
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 00:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777361942; x=1777966742; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LOmVa5HEYXAhxFxX5dmA5ibLhZjG/rAPjw3EsQuigAE=;
        b=K+6amBpYOSyjnfsnnCFkM6SVbiKt6wtonbbvLJeJeODN2kepBctdCLCv9gQH5Gv9Az
         bbUKlI6kEzfrU6RJJ8Hbl8pxfAut2bP8ZRW8oOhzcBxR395e/tKk4ESPp6u5sQCLbmfi
         w/dT16TnokoEMGS33kl9NdaV69IK3IbUyLSQpHgLRKxZiaF+Lqy5BJ61UGfxUeNOEBOK
         vqjopbCiwu0OgsZ3WmOulRjuaOEykyNuLt+LIXERytipm8JF8sB7I0fEjYd/2FGkWHHI
         eaG7LrywbMwa0P/I9XQe2mnjougZg3eywErTodgaNGyf4962XtaQeu3zI+W/w8xPJnTs
         z8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777361942; x=1777966742;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOmVa5HEYXAhxFxX5dmA5ibLhZjG/rAPjw3EsQuigAE=;
        b=HEKeBuro5witEvX86l3fMmI6BXcpetWpjTqutlrhKl67c1cDz7HU4eCmh3uxAojRMD
         /kHF+dQ48NQ/WlxUX763+6jwz/bb2xY+zuYPJ0nzgQLqsZS3n/Dz6kulY9S+QhABOYgh
         agnQndnZRRXaKzxhYtLJrs5ykSCNLPYwijE/DCo2YfmxX+qQrJ72xurTbycQdSwWaXcX
         3Bo3y8FYtRz2yvQBYc9eq9PcWgwt+Oz6xOPVxrUJLj4genp5PkE4kcHq0PDIZfVzHZ7o
         efIBf+41vaTTcPH9GxYtlhF4m3SOejxynY5myX5izKQhWRKoBk0YGkztF8s6J6M7Ps24
         0jMw==
X-Forwarded-Encrypted: i=1; AFNElJ/XQ28Kv2vgr4tKd+Ld3WRDKGaKp5ZwD36cJD9a/orHsSqdRg0GptxJ50nxA5gQndK+6LVyJA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx78NXGgjWe7iRh7eyn95VJyXfZlYKvgmo1cuuM4JTvA/AGz6pN
	NicKkWZR6U4iKPs/JG8toO8IbrAO4U+YhKZKrBZL1OpIg4mlaTE9rasv0tYNXVqsPS08bSVM4b9
	kigNuulRGWiHCHwZLrjnP80eeAg==
X-Received: from pfwy28.prod.google.com ([2002:a05:6a00:1c9c:b0:82f:a201:42c7])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d22:b0:81e:12f1:d8a with SMTP id d2e1a72fcca58-834ddbe707fmr2002397b3a.34.1777361941509;
 Tue, 28 Apr 2026 00:39:01 -0700 (PDT)
Date: Tue, 28 Apr 2026 07:38:59 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428073859.1502047-1-joonwonkang@google.com>
Subject: [QUESTION] Is the ARM SMMU v3 implementation designed to always
 ignore SSID when SSID_VALID == 0?
From: Joonwon Kang <joonwonkang@google.com>
To: will@kernel.org, robin.murphy@arm.com, jpb@kernel.org
Cc: joro@8bytes.org, jgg@ziepe.ca, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stimim@google.com, cychu@google.com, 
	hhchung@google.com
Content-Type: text/plain; charset="UTF-8"

Hi team,

According to the ARM SMMU v3 spec, I believe that SSID should always be
ignored when SSID_VALID == 0 and the current ARM SMMU v3 module
implementation in the kernel seems to comply with this without exception.
For example, when handling an event from SMMU, the implementation checks
SSID_VALID(SSV) first and ignores SSID accordingly. If there is any
exception to this rule, I believe it is a bug.

Is it true for all the current and future cases? In other words, is it
**mandatory** that the ARM SMMU v3 implementation ignores SSID when
SSID_VALID == 0? or there might be some cases where the implementation
needs to refer to SSID even when SSID_VALID == 0?

Asking this question since our HW may not be able to clear SSID when
SSID_VALID == 0 and so there might be some garbage value in SSID at some
point of time(the HW will have a correct SSID when SSID_VALID == 1,
though). If the ARM SMMU v3 implementation is to refer to that garbage
value for any reason, the result would be devastating.

Thanks,
Joonwon Kang
