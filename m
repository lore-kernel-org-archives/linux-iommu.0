Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD8B29ACD7
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400678; cv=none; b=UKF86tXsZL09bVJhpuE5S0I2SrT8JRl+mlSBPph4j6yjOzkWddQPatB9GefJXc+7Fr39aaNbCAade/oBrgFC2ZSNX0XlgO9JXWbvVkjqFiGnWZ0zf5VU6FbDz9qtCuQSK+UW4HNvykqq+zv2367G76ZS6358/cMsuKb4Miyz2vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400678; c=relaxed/simple;
	bh=Vqe6GokABRYMaafm4AjHKLKguhAOb1wLGb65Hvcy+Ns=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Af2msTBBYs6PSNPmrM0jbe9vDc0/C9yi2tK11ad1/AeEkZ0G4JHNmXWVM8WqA9PrpNkd+rxj9/NUcVqb82B2YgfC+bX54Vasr2acPBFP1eQ6md54hW2P4ui2Uzdc46xv+KiVdreRs6VgM/Hh05BQEjovq3FLWaQ2p3dslA+D4y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lambdal.com; spf=pass smtp.mailfrom=lambdal.com; dkim=pass (1024-bit key) header.d=lambdal.com header.i=@lambdal.com header.b=c/kn2ZRg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lambdal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lambdal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lambdal.com header.i=@lambdal.com header.b="c/kn2ZRg"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b735b89501fso492622766b.0
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 09:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lambdal.com; s=google; t=1763400675; x=1764005475; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vqe6GokABRYMaafm4AjHKLKguhAOb1wLGb65Hvcy+Ns=;
        b=c/kn2ZRgpDzbjNzH9tokXstzYp/OElw2OfXImDpxh0b/wVuSyBtJSM4zOew2VfKRZM
         Dab+/WNZB3kPk6F9ITe1myw1/AFyc+RFN6W1rW3YkZNJoih0dcptopNi/6vEiP3LYvYj
         gBDUcIZCey/hpQJtraLomoRH8KQAPLgNBHOqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763400675; x=1764005475;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vqe6GokABRYMaafm4AjHKLKguhAOb1wLGb65Hvcy+Ns=;
        b=o8RWEDQRomt1lP3QlkL53DDis5SnzW6Js1lAbgj6jR9YJ3PQfdVwe4BPT+k7zTudQJ
         r/CGS5LeSs32TDff0UgH1aOPIJ/xQHWI9y6H4o6KlvBpn1Zew4WoQy990sCDtAKaPgM5
         nV0PKgkOzOMUYfZp0l5rgr+qu0fcl6irYUK9dGp1fG/iHFvE2GiCEjFxm8bBt+8Atc/U
         2q3DyuChA6oKqSP1VDXwcm7yH9F97Mn3vP2dsi+Q6uefVxRolTR6OuPxPq2rYlBgWjFD
         MCGF1mSGFbzJce9JRsB+g1sdB8ZTLA2lQ38YPVmNT/yxo9yEVBkRpUp2aRlUlriBixHR
         bJhw==
X-Gm-Message-State: AOJu0Yx0Lmg+5yFSgplPW+nF8emk/EqlexChE4jqDPqe0I8+kh+j/QXp
	tkzMAg7ZDWKVSP05xm/Vvqo92acarHc8xeCkYfgsv/3Bpza8jlpeXqHolzi9Q80YME01jNv3NaN
	IgOcsy/XEe391DH/7ncDGj/JEhHNtTelJOOQq51P1CIrkubnTIuh2D7g=
X-Gm-Gg: ASbGncvXh4IhCKrF3zt1NjggqQtoBPN1S97esY3sKpZVhSG3WDkuwLKK6waDbxJcOMO
	0kkWs7KMYV2JmKlmYIV5WaEQ5NPUlKdO2OZsrr3507+PK/wKiX/jlISAS+PHZ53g1up5PLtLnWQ
	A4sYSZq8Aph+aKixPgkHlsPsV9fhIxB491RFDn8DPqBanfSjcCkn2NCXSwsl6Nu6VQUbJEHILs2
	0AB4HVBl91widTUGMIpbbuyNdUzDgcKWpUCVLnI0rUqP2pkHdzECgRaC3ov2ZsPh9zmh75OBuzv
	aa4NOw==
X-Google-Smtp-Source: AGHT+IF3jbyoZ7GdL9CuqVLsknSR+eU9m3HZ4Qm1ga+fL+bmnSD923ySK3QBnRXjsC1SX97mMze/U3xfbK0S5m6eqdI=
X-Received: by 2002:a17:907:980d:b0:b70:ac7a:2a93 with SMTP id
 a640c23a62f3a-b736793d8demr1282675766b.43.1763400674788; Mon, 17 Nov 2025
 09:31:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Landon Clipp <landon@lambdal.com>
Date: Mon, 17 Nov 2025 11:31:03 -0600
X-Gm-Features: AWmQ_blIGFzxQdcbkJyW-9sVRTlW5wY5LvEzPJe3-tmavejk7BYnQ93jLXuDrxM
Message-ID: <CAOxhPvUbB4T+Q4VvmQ1Ed2fFqiOBM2gmCaDB+k-tgWjRcABFyw@mail.gmail.com>
Subject: Explanation of VM Boot Performance Gains with IOMMUFD
To: iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi folks,

I have a Kubernetes cluster whereby containers are spawned inside of
VMs (Kata Containers). These VMs have 8 NVIDIA H100 GPUs (from a
Supermicro HGX box) passed through with vfio-pci. Passing through the
GPUs with the legacy VFIO cdev corresponded to boot times of around 30
minutes, while passing through with the IOMMUFD API brought it down to
around 3 minutes.

I have asked numerous Linux virtualization experts as to why I am
seeing this behavior and none have been able to properly answer. I
wanted to know if there was some salient difference between how
IOMMUFD and the legacy VFIO API handle IOMMU page mappings that would
account for this performance difference.

Regards,
--
Landon Clipp
