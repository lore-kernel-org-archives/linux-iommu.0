Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB52E414
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959880; cv=none; b=K/t/NFQt9DUy+8nQAuLouDjDwth8DvjlrG3s6rVAnZHZLEz0l/zGmhU8J64a1JW72DjzdGwYYuvTpqXAmS7qLqd4RyU+pZwfZcxiFkJGCNSrOvjuQ0oopfmVKG9UjnlYNR9EFlYZ8oaGfLT/oftMZ8cacTFDAe3QMH4AxlXUWho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959880; c=relaxed/simple;
	bh=Jmc/m/Z9EeCZ+Y6BMTBP0mKo2qFrjPj4TA4GMteOokk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QgbUSD2s7iV0EGWWO2LUVxGd/QdF+E9rn/b0ZBATZq2i00lwbE6NVOSPorrSx+yvY/YIjMcOgygQ9+rZiqhlznplAB1HCQ+EuN6iiqpwgJneItHKyBzewj/3j3yoQDm4kT5GD6N9LrcI59XR1VNBHmiO/wOyK8qc9zMJafwq6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFEYiMbA; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFEYiMbA"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-691bb56eb65so6674707b3.0
        for <iommu@lists.linux.dev>; Tue, 06 Aug 2024 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722959878; x=1723564678; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jmc/m/Z9EeCZ+Y6BMTBP0mKo2qFrjPj4TA4GMteOokk=;
        b=HFEYiMbAse3zNfOCblYC8ndo5U78p5IXNnnXcrI97cQz9BA4aksx72Pt6Dp1/wsSOh
         ny0FhBugTNO7sCTKq0bsWm7z24EeSI4wD3wbI4RapK7ZR2wCU+0OldC+2Ud7XsCmhM2W
         j9aEzyVyt9WyD7tDGKSeaUoKo54cx3323HOHlV6x1Wd07uNBNaw5RubapjpmYG/1l+np
         gqPZFNJQWjYPdtHShRqOPHKFlqZ4OgMLyMls8iIE98a+bL2XQBTOw8FxrRrdHgKpt1OE
         xXjwOgS/5Tj7F/l5NAwaKlZFTFPkyenRWDV5EqsRyRSoHRaMPNeCKPsq4olAYsnN0Lsj
         1rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722959878; x=1723564678;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jmc/m/Z9EeCZ+Y6BMTBP0mKo2qFrjPj4TA4GMteOokk=;
        b=Y2P5RUhHrebBYxK1QQKDsrAzzQmK1gnIVlENwMtcIOLN7RKtQcV1YJEZkoktVnK5lo
         JxvWDGWhjee96nRUGf2eYKOzbWQTQ3fH4XsYhOMlT1RhK73ORKy2mbY7aYMYPIT1RzNO
         yditDygkJL9BByAET7zFQC9bKqfsdU5aviUHUja0IdBXjlgoKiNE9gI/Qfx5xNIOenrz
         xfFprHqDJdCa1Flh8/gzqeyRiPkHbj/voG5UCCwL+49k5AppDYpHPhv2yLoCH1fuZTD4
         uO7xsrRIiOSwKxm3iTEc0emXutL4yH1Rze7ogsKKjoNu9+xV3vyTnB+DzDXPjixweRpo
         IUSg==
X-Gm-Message-State: AOJu0Ywy3Igjz3pXhQGM0CcQQkkUu9rxUu7IQi3CQ9JkCDCmfvlaliLq
	x7jeFY0AB1JyWtx3oZ+UisacC9iFz6YxRiH0kd7XJKOutFT1BzCgijKlJ6ysYZFXAfhi9qUtn1k
	EgpdTia53bR+vYA61ftEl8nNsNHbsRwQP
X-Google-Smtp-Source: AGHT+IH47vCiIyNM6NvlRnkDBM6cmoAkuc7lb7UDByYz2G48OozkL60BkgcvQIF4DhgxZfjj5b/cVpuZPAaZ5gxt+qE=
X-Received: by 2002:a81:8604:0:b0:61b:e645:3e94 with SMTP id
 00721157ae682-6895f7fa554mr171130027b3.5.1722959877900; Tue, 06 Aug 2024
 08:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Chathura Rajapaksha <chathura.abeyrathne.lk@gmail.com>
Date: Tue, 6 Aug 2024 11:57:47 -0400
Message-ID: <CAD7mqrxe5PwL-BZSyPQq8V2oOHZ+-fazDF2Mn44YLUabYi7qYA@mail.gmail.com>
Subject: Feasibility of having per-device permanently-mapped DMA buffers for networking
To: iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi All,

I came across this paper published in ASPLOS 2018
https://www.cs.tau.ac.il/~mad/publications/asplos2018-damn.pdf

In a brief summary, the paper proposes maintaining a set of permanently
mapped pages per networking device and using these pages for networking
DMA. The proposed solution claims to provide similar security to the
Linux strict IOMMU invalidation mode while demonstrating similar network
throughput to the deferred invalidation mode.

It also addresses the subpage vulnerability as data belonging to different
devices (and the kernel) will not be co-located on the same page.

I was wondering why this idea (or a similar concept) is not implemented
in the mainline Linux kernel as the results in the paper look promising for
high throughput networking.
Are there any feasibility concerns related to this concept/implementation?

Thanks in advance.
Best regards,
Chathura
