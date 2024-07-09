Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74EC34545
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524640; cv=none; b=OlfXaN2+L067QCq8dQk963Tpa6MzMM0AU7D7CVWrryc/0NySdjbnl79vMZ2yqGeflDUv5DLuLzvG0XY37KsKuxKP9vrNETEo60dABDTO6E5Vu2PYe8nQTZKqHViCGOweIrwB2kAmKITYfP5U1Ndmim/37U+LrHrUCDJUYQC0trQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524640; c=relaxed/simple;
	bh=fIX6ixrAYdf6dI/dZkfwDgBUu1sXkxgK8sJ2KThkAKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJHQbyaWzZpCPEdpyIQjrPTAo/IF3ridL39bSJYvsvDexf24kMg5ynwvDaxjBTaht45YTJlaXpJ0pTBtffky1Q2AygbcyyZ6ptgnuQB4NZQfbyOvPqro52051LC34zrCV6gcKB36DX69HuHUfN2nX93DjvZRd7HCMNRB5yvTx1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DavWH/bL; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DavWH/bL"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-38b1ce72526so1021705ab.0
        for <iommu@lists.linux.dev>; Tue, 09 Jul 2024 04:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720524638; x=1721129438; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OybDJgpz6EY+j/3mJEj8sCqVPmrO9HMmhiXf8ikWJtY=;
        b=DavWH/bLyFn3tLeKmKOh9SfAdRSFDWI8kaQ7o9PMTY8qmfLZ4kZwkhZBksqO5f0g83
         YpvjavgQjy4b94bNFRS8Da50rntgrFUzFCUJFO8Lo+gUbwRvhZTW24JHHVYwtT68nDWc
         xEADbY9h6TuyVIjTfENn5c4iU5H/e1/5fcaCoOPfZmUX1f2r+krX3zzlNNKU4FDmUOdj
         VwO0QYOw8FXIKfgdLINxu9SvRyCYQKNCqhMibG6ilkSs6r7z/u0ecAyjrLSBrad4bQ9F
         kf1zisVAakjp1KmIkK1s0UvTTLxBILPx4it/BywFTRzRm6PFTIxl5l58vhkR6xU2qxpx
         ZAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720524638; x=1721129438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OybDJgpz6EY+j/3mJEj8sCqVPmrO9HMmhiXf8ikWJtY=;
        b=vL99faPbT5bPgXrrlJ5ZhzawCFyIzce8n6tave7Qc/aFGYVKwqsvUlOnZwKMUwnYPr
         MSMfhdlT4hINpNVXE/SR1bCb6t9eKldP/xkWpwAQ9gAkS2TrYyIbZosJ1Z+BXw2gaBlf
         3PA1o//rnfB9ptmcSjmc8wOpvDdgSI0ZxwAiubNk2QVe39fc3W1PrME/p+/1SzaOfGqG
         BCCGf7nzMQ0A8Tb+UYBi+RFKjOx/NRe8aDzggF4p7GOa/YdujgwkHchAorNg0LOll5tn
         pFxlWuPvE+n6A6Oa2ga0CC/Z+wp+OFrEcx424YRJTztigwr9jcgxAnhIM0N6evyfYe+F
         PsKw==
X-Forwarded-Encrypted: i=1; AJvYcCVsdL0vbHOCPmPOpynJOJGH1+jiEJUWrsrcFGatZQbHV9cKFdRVY4jy8SmknLcpeL4EZgkLSiPuJoawmdb4BLdeFzzBKb8=
X-Gm-Message-State: AOJu0YxweBp8rYYhUfGCxK+jLzTD69WNnMRss8j7R4ZzWMwGfaEbdGRF
	6l+KEsidG/ZJdCkWpZzOo1gvlGrwX1NHKR34k9fuvxQU+HgUkEpGOMQb1Q0o8nv+ZyWJp0jOdXP
	Wo+it2DUJ6dTm3oR+3r6tcs4KVPw=
X-Google-Smtp-Source: AGHT+IFPPY70EF131mrWS92AdxahsTxcIjvT/UMQ5GCEha7X5m+AdeBkpVaMR0Kgsk0JXGV9ftk+CsXREEzIyZTvwPw=
X-Received: by 2002:a05:6e02:1c03:b0:382:7825:fe4e with SMTP id
 e9e14a558f8ab-38a585851d4mr26758075ab.16.1720524637800; Tue, 09 Jul 2024
 04:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240708230613.448846-1-quic_obabatun@quicinc.com>
In-Reply-To: <20240708230613.448846-1-quic_obabatun@quicinc.com>
From: Klara Modin <klarasmodin@gmail.com>
Date: Tue, 9 Jul 2024 13:30:27 +0200
Message-ID: <CABq1_vjvPeF-h19-H99q5D1u7wvtbRPoKKqroMJFaMb+yUFLgg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Revert use of Unflatten_devicetree APIs from reserved_mem
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: robh@kernel.org, saravanak@google.com, aisheng.dong@nxp.com, hch@lst.de, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, will@kernel.org, 
	catalin.marinas@arm.com, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Den tis 9 juli 2024 kl 01:06 skrev Oreoluwa Babatunde
<quic_obabatun@quicinc.com>:
>
> With recent changes made to initialize the cma regions before the page
> tables are setup, commit f2a524d9ef5b ("of: reserved_mem: Restructure
> code to call reserved mem init functions earlier"), an issue was
> introduced where the initialization of the cma regions fail and are
> initialized as "non-reusable" regions instead of "reusable". [1], [2]
>
> This issue occurs because the device_node of the regions are not yet
> created by the time the cma regions are being initialized.
>
> The cma regions need to be initialized before the page tables are setup
> for them to be configured correctly as was realized in [3].
>
> Hence, since the unflatten_devicetree APIs are not available until after
> the page tables have been setup, revert back to using the fdt APIs. This
> makes it possible to store a reference to each cma node in the
> reserved_mem array by the time it is needed in the init function.
>
> [1] https://lore.kernel.org/all/DU0PR04MB9299C3EC247E1FE2C373440F80DE2@DU0PR04MB9299.eurprd04.prod.outlook.com/
>
> [2] https://lore.kernel.org/all/986361f4-f000-4129-8214-39f2fb4a90da@gmail.com/
>
> [3] https://lore.kernel.org/all/20240610213403.GA1697364@thelio-3990X/
>

These reverts also fixes the issue for me. Feel free to CC me when you
decide to send the next version if you want and I can retest it.

Regards,
Tested-by: Klara Modin <klarasmodin@gmail.com>

> Oreoluwa Babatunde (4):
>   Revert "of: reserved_mem: Restructure code to call reserved mem init
>     functions earlier"
>   Revert "of: reserved_mem: Rename fdt_* functions to refelct the change
>     from using fdt APIs"
>   Revert "of: reserved_mem: Use unflatten_devicetree APIs to scan
>     reserved memory nodes"
>   of: reserved_mem: Restructure code to call rmem init functions earlier
>
>  drivers/of/fdt.c                |   2 +-
>  drivers/of/of_private.h         |   2 +-
>  drivers/of/of_reserved_mem.c    | 103 +++++++++++++++++---------------
>  include/linux/of_reserved_mem.h |   2 +-
>  kernel/dma/coherent.c           |  10 ++--
>  kernel/dma/contiguous.c         |   8 +--
>  kernel/dma/swiotlb.c            |  10 ++--
>  7 files changed, 72 insertions(+), 65 deletions(-)
>
> --
> 2.34.1
>
