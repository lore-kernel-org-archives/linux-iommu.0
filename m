Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D0F485506
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788782524; cv=none; b=VA7LA1uOzIHu0MR4ES+aY9bYwfAv1ADYjE/51hBFApBsQitB+yR6wc/MqSNEFrNuBcX/uNjHiEQtF8sau24MIw4b5duqMuBfl9G/0So+h7+JRWFFxNRlcFeak54O3mYPjgVZR8IXCQrMa68AJa6SEiOcwphQWyKTdbAi3ouQA5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788782524; c=relaxed/simple;
	bh=e+LcscX4l8bSIJhRp6pj21O+RxjEFrIGAmY61xbEojg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnxxKbJIiOI+T5sdoIJG7iRaIwPZ/4UZkbK5p7txevXuS9d3ffm31ElO4OmtMTa5vF2XavGFzB6HLG3bci/DkuVbN2llOKs7TI4jJBxONtAP9F9iqmKEHLK5Fy95wlzSd+B9BjKKlAeLynQG7Aq9cB+wF8j/bydyW9WweUFE6b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCw6VXdF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCw6VXdF"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso2757446a91.3
        for <iommu@lists.linux.dev>; Mon, 07 Sep 2026 05:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782523; x=1789387323; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DWeanejvZj9bixBLqbHSIOUPluNyoy6AbNIxqL5gJ7A=;
        b=DCw6VXdFkOyB+Cw0N5wdojCId2dV8xUYQd2psRYXm9/gVJG0VuwJ3kuV8Nj7FFbM8k
         MGRP0jGL/dz4vwEGROxvGITCF/+HB8J66M1/G8svZKuAKHmXpY0cEERAlRi96EHH6FLf
         VpxpIO6mXBaqQcUFWUox/USauG9/ur9gO3mc9dn0XVM6NbXe6FbarEiWInHqYYa0hGyf
         60TvwmQfPlyczGJvaIzeKZWKt3H5qWFvRmVICgO25nFVqv58wRQCRG8SoH0f8Yu/pnGk
         VScgiR8VV/mTmbYkpqmkisJIbsNnSgnUEwwgLpBlYjYerRhh0fU3hB1E4MaQxWAh6cGt
         sPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782523; x=1789387323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DWeanejvZj9bixBLqbHSIOUPluNyoy6AbNIxqL5gJ7A=;
        b=b1GqJdmJwJ64/kqTndAdPwTZUp7AsEpw0jo1cS66/FMvgKMDF3vrmz4oKhs37iztoe
         2KCmABU87xxXnSnmbeRzVuzzDMkRVcsjq4mb/qffv5KP92vT068X9Qa8g5xdqQXJJEit
         UBtB3z+89QqK9Frt+3O57xgDJ9xwDc+t7S3hqNIut2ZeFf6Fs6Gj2n0PlqnoPZQ0B2c3
         f27TjccrwtMvl1ns3lQUBnUZA+0I5yX4zi11RwrxFCXyJjHSgoxhGv0xk3vccA/bUGEH
         cCxM7I1kTnP6wCkg+sZisi+fY3jONNXE1l+b6FVHDHc2S/3dwq0KcnKvL08NCfy2vkb5
         A+1g==
X-Forwarded-Encrypted: i=1; AKwUvBxMWOV1qiHAJCnqw/JT8ujP5XCak1DKnsJcH59VVokgMjBZdlUT5rX1jlLZgcmk/RFdzHt68w==@lists.linux.dev
X-Gm-Message-State: AFuF++mMVygEONdniAe8UJ3Z2f4tLvi7655efb3WwaaH28niYI/N3Q0d
	0uZrqQPbZmnAnXe0Tf1o91fen4xdkNRFgHSnIPeMHrBw67a+PtJ5BlkBtRKlvvk=
X-Gm-Gg: AYBFou1RBRKnNCf4SG44Z9lyUx/ISauRP09ruT5OEKe3Ldm9H5a+QX8KopWt3Ma+Nc0
	WU6D95jXYb/CPLdVu3W2Rwonuu2vy4PI8IPIxxa4/iM9TTqL+2PFQUxL8q5QwP9RvLCDfp3XfJf
	lTbH8Fjcgxskl9JGiN0FPCnwJlSJWiprAhP4UItmC7CEsY1Ftr6L2ktDO0xqFyrTqZmBcsVHemp
	nS7U0HvS2h26+lsbyReXvOf5VHmM/7H6zBfpxAUvtHkl41qxGsSRv8JVWlgTNlOrbLxCqXaoJ2x
	EWEpezyacK0pj1h/0WwE9pVfhbyZhEfzIa//ocAx6Prf6rZij+GSstqfQbCYFrDtVRbuWsMao3H
	SJ1jW/iVKZU20+eiMtuJZ/oIgTjES8yMXQ66wAYcQjdA1NgFPlcO4jrrg4dgiea4MZ76+jQ16h7
	E/tlZy7oaM7IHK8hcNVJw2baisM/oqvPRbcK8nJrzTBFXryIUs9tTQTKS0kb8TydS/Z7Xdzq3HE
	jubIgb5bCAM3FUm
X-Received: by 2002:a17:90b:54c3:b0:398:d6e8:f84e with SMTP id 98e67ed59e1d1-39b2612ecebmr35866634a91.9.1788782522669;
        Mon, 07 Sep 2026 05:02:02 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c39227sm26976118a91.9.2026.09.07.05.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:02:01 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH] dma-mapping: don't trace the DMA address when the allocation fails
Date: Mon,  7 Sep 2026 21:01:56 +0900
Message-ID: <20260907120156.603600-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ff20483d-c701-4cdb-8db8-15aa79bc32cf@samsung.com>
References: <20260905071919.30784-1-donggeunyoo.kernel@gmail.com> <ff20483d-c701-4cdb-8db8-15aa79bc32cf@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 07, 2026 at 01:05:20PM +0200, Marek Szyprowski wrote:
> Frankly speaking I would prefer to fix this in include/trace/events/dma.h with
> __entry->dma_addr = virt_addr ? dma_addr : 0;

Agreed, that is better. It also covers dma_alloc_pages() and
dma_alloc_sgt_err(), which share dma_alloc_class, and any caller added
later.

> Here You remove the debug_dma_alloc call for the failed case. Right, it
> is a noop now for the allocation failure, but it might be extended with
> some kind of debugging in the future, so I prefer to keep the current
> code here.

Fair enough. kernel/dma/mapping.c is untouched in v2.

include/trace/events/dma.h is not covered by the DMA MAINTAINERS entry,
only by TRACING, so v2 has Steven and Masami on To as well.

v2, tested this time rather than compile-tested only:

  https://lore.kernel.org/linux-iommu/20260907120124.603373-1-donggeunyoo.kernel@gmail.com/
