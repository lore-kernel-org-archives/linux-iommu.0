Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA86216E1B
	for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156264; cv=none; b=AKDRp+ewn3BFGNzim+8BcG6rMzL00G3yGShCdczCofjA/RUEO6cuGKqUyX8nZ3PJOUBJVw7PHXFM8XCIFfP009qSLeJYtmS5tUI9703wwli8GBKi5W+KrRoqb+tltyZf5+SJWRqmZKBGCvHDKhQMsZ6AiWnT8ORHad5ocsLFsxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156264; c=relaxed/simple;
	bh=yVEU9Z9Cc8B9W4xNNyEcyh6tlvqC6ybG2jaMWegweJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8d1dTaV+qLS35YUVOu6Is8OmT4CajDBKVP3reHqEw4RcOrFUGQ+YX3o/kMz40X/Kt9rUDq/vap3gIqiP99BW7iPsNjm+ozVVzNbeqCHcAoyixH7V0r+GhNkqAeW6W8TEIxZnSv8pms1noXr+riADik3ZBVc2J+SkZ0RnJJ6ivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ij4YmDac; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ij4YmDac"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5495c1e1b63so2252367e87.0
        for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 03:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743156260; x=1743761060; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVEU9Z9Cc8B9W4xNNyEcyh6tlvqC6ybG2jaMWegweJs=;
        b=ij4YmDacLMCTJuKGrNubeyfiUmyneC3PrCg7zyivDfPi383R6ovtCrD65qixO92mD4
         TiWhvduQxKj+NIEg1ivwiUBohKUmcf0cY1KXLHb1nP5nkRuy2OtgsjBv3sJEsPI9wOuV
         O8ozyLMuvy5KaUVG2CoFzurW0d3VZ55xktPOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743156260; x=1743761060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVEU9Z9Cc8B9W4xNNyEcyh6tlvqC6ybG2jaMWegweJs=;
        b=eHYAFTgC9i+ZYV7afkPkugmKhyqniqLLT6XLGGasTdoNpRcz7ju5YBqLVoyC9NEHIb
         0q8cOwghZ4y8HzE9hf5I52ipeAuKXeAHa+YnW2QE7jrO+F+/B2eKa3VKBqFAN+MtoQM7
         XRWSLGwMTf6D2ZSgS2EgrbZVrWfJ8bvX5kn/5lNkrtYmoJJYbYpqkO+M+gACG8KgXFf3
         n0flTbqvzbP/pW1xCuESRvfSWbjFcShddEAdZdjcZyHETc5nJ/gaDSUCpvJOnjp/cLos
         mIzQdCHodDNbYir7Cte1ct6Pmq2blHaGkm1k4TBoDwwHkLF0gO4LEMKG9ol/UK9gazfg
         HK1A==
X-Forwarded-Encrypted: i=1; AJvYcCX1RRN/KeCPMIYGM4SBps7Hckn2nIbNicHzcVYyHHiZRAvKymD+urt741R0BOiNs5HOju0VsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqnNXPiMuMQJmOZ5jzFuKUCIJeT2oKHT0PrC0kY2jNO1kqt34K
	m0MnJxM4AGdIPHG19+gxHYcHeXW16+inFZJp1IHkma/FI2TRC/f27OovvrsigMy96ORaZaU1PPc
	y6S1qq4bsn8iHoK+Tt5VwWPe4lO7euqEHECM7
X-Gm-Gg: ASbGncvmyqcAFDQlhX8CSawMnmsRcpxU0Q6IKqLcdNGWmEOALtM1esh5vDJQ8kaGj7b
	5+tFMPmXvcm7Xarz0/82xpYCiszPSql7jacFuASaDmcRIQ/Kr43s5lCn5g3I9NlWzru7Oaif51a
	Cr2efuOTTtW6DmRlHryugvihLneRNrHpTtsVjf7iR+Dq7zLbNha3QeQw==
X-Google-Smtp-Source: AGHT+IHePVtXJ1qJQdbP4+JraAsng3JxPcp8ln2qAoF7z/+m2DWfYuVxIC5W1TfslB1L3LezP+QcBUJ4Mmt/gRVxkjw=
X-Received: by 2002:ac2:4e16:0:b0:549:7145:5d2f with SMTP id
 2adb3069b0e04-54b01221f44mr2788893e87.33.1743156260501; Fri, 28 Mar 2025
 03:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250327-fix-mtk-iommu-error-v1-1-df969158e752@collabora.com>
In-Reply-To: <20250327-fix-mtk-iommu-error-v1-1-df969158e752@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 28 Mar 2025 18:04:09 +0800
X-Gm-Features: AQ5f1JruRldxLi3oN3F4vGRjnP_jRoig-8O423pVAOXUeHgChYU13ECJHzNzG14
Message-ID: <CAGXv+5HAa0-AXg6=htNappreR5-9sPHNp7L9ByEBq4XZxADBXw@mail.gmail.com>
Subject: Re: [PATCH] iommu/mediatek: Fix NULL pointer deference in mtk_iommu_device_group
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"Rob Herring (Arm)" <robh@kernel.org>, kernel@collabora.com, Joerg Roedel <jroedel@suse.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 6:48=E2=80=AFPM Louis-Alexis Eyraud
<louisalexis.eyraud@collabora.com> wrote:
>
> Currently, mtk_iommu calls during probe iommu_device_register before
> the hw_list from driver data is initialized. Since iommu probing issue
> fix, it leads to NULL pointer dereference in mtk_iommu_device_group when
> hw_list is accessed with list_first_entry (not null safe).
>
> So, change the call order to ensure iommu_device_register is called
> after the driver data are initialized.
>
> Fixes: 9e3a2a643653 ("iommu/mediatek: Adapt sharing and non-sharing pgtab=
le case")
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe pa=
th")
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Tested-by: Chen-Yu Tsai <wenst@chromium.org> # MT8183 Juniper, MT8186 Tenta=
cruel
