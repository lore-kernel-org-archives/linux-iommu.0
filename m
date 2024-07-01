Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AA116F0E1
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864437; cv=none; b=Z9/vf9cFTa6uGpVgiCb0bxM8V9UoOf0dyACxwm9iiv/DIlj5MJp9Ox/7d4ULQ/cwI6dCHr0D5JHgQc15QG6UipPmd6pbSBNagM3W+zSrYRWIeTBEqZEB0sNH0oX+pvo0rgOP091NoZWlRv5YWDLQlRPCjyUYjYVv8jjb9TYZIeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864437; c=relaxed/simple;
	bh=DTx0TnMXknMnU1py/GEV3TbUeQ0A4+c8OwKWSEIEY60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyyBfA6Z9RM8Nhja8URTS4Po6elELxbI2e5Lh7NvlJx3hzvQONk1PSZpDZ5jp9sQFf7gvEvGBbXTXLHLz69hzYsQKAItk77u8Y4sBbm7AXGB7UnJ9xCoZtwsrjBmQixAOOzzxMHvXiJC4cKhyBEde1kqO6EpALhvV239D5Unjno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jgFxoExh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jgFxoExh"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d119fddd9so10815a12.1
        for <iommu@lists.linux.dev>; Mon, 01 Jul 2024 13:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719864433; x=1720469233; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HA1dU22m3UNj5lyj13MGSrb+8h3p7MYcfXDGMuEpnwo=;
        b=jgFxoExhW92LdHyK95ft7mdw6wxT8IXPc2ESPO/EPlnWnDcjweg/+RG6SXiBvN/PtF
         MqgEsVpcyURGVyy+bxnxBLPT0QS1Hl4UvwOSHQVs/1HI5GwG2MNg2WGX6qxfxe38nlie
         NqeHQ5uN2GKTwGMedmMoxag5a65S920h341H44YnXkCWYSMhvF0i5tcGM4UDpgoZagOv
         jUXcNPLMMNjDV0TYOW5/UFoEjmWmuVj4+fWlMoFqzcOKkT5CrcqkjwIq/pLu+Lk7s4s8
         ZrWosfxbsOJuMH7PpHDOJMQMMo4BqqN1VLKgaYWY6BvD/df77hQsh0HKvzhIwujvkC6O
         02OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719864433; x=1720469233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HA1dU22m3UNj5lyj13MGSrb+8h3p7MYcfXDGMuEpnwo=;
        b=Wj0gDdhMqphUGA5OEYDPQt0/mX5EKsdu9uohJzQp8sFVlFjKHvsc6eGcp8gX1MyDf3
         PIjczbykpfdpEL1h/jtv4Rqf1//OAUPGo96KSzhtBDoIymt3HWkbYOO3t8LOWxyslgyX
         uqCI/Q5krvDbR+xwqu+Fp6m6UmK8zYc78x69UxBvuv5wbS6yDvQj3v9QPiZ/0cUqyxnx
         E6s15GxFO1YTxvFoGYLvPreXYbQgCEo+ljVxOUyOW+YzA2zBtoZ02lfCy35Afe7UkC3V
         m2dNS2QVQ13bhE5cdWzlh2Fq6xMviRhtO9rFVWWDRhBGbKwYnlSedCGgAmuIAjuV6uw/
         oQlg==
X-Gm-Message-State: AOJu0YydvGXZHrGOaWGCmG6Fw1vfa3xr3IxYbCXzuqejL4+/52ckhk/2
	g5AHNYJaNfLXnIM9GmxaxnT+Dq689Mj9qiixFcmkg18pKJhCc5fMTiqtYh0hPyCcD3xplJesxB8
	N3Q7Wym8lbvQgdnjavS5xwg0Y1dNvT54xQq+I
X-Google-Smtp-Source: AGHT+IH9YyeTHtOmKWNRjWDZNOFaOcyjCIO5hmhn2IbnyBQewSRB362+m++tv5m6fkb6HeoZ2TpHUYTYJYIbCgB85hk=
X-Received: by 2002:a50:d799:0:b0:58b:93:b624 with SMTP id 4fb4d7f45d1cf-58b0093b6fdmr89607a12.1.1719864432894;
 Mon, 01 Jul 2024 13:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240701162025.375134-1-robdclark@gmail.com>
In-Reply-To: <20240701162025.375134-1-robdclark@gmail.com>
From: Pranjal Shrivastava <praan@google.com>
Date: Tue, 2 Jul 2024 01:37:00 +0530
Message-ID: <CAN6iL-TCsS1dxwZngJ77J1MJcBeRsZW22W9uNLG59Z-isy9J5w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] iommu/arm-smmu: Prettyify context fault messages
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Clark <robdclark@chromium.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Georgi Djakov <quic_c_gdjako@quicinc.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jerry Snitselaar <jsnitsel@redhat.com>, Joerg Roedel <jroedel@suse.de>, Krishna Reddy <vdumpa@nvidia.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>, 
	"open list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:50=E2=80=AFPM Rob Clark <robdclark@gmail.com> wrot=
e:
>
> From: Rob Clark <robdclark@chromium.org>
>
> v3: Split out the reg bitfield renaming, rework
>     print_context_fault_info() helper
>
> Rob Clark (3):
>   iommu/arm-smmu: Add CB prefix to register bitfields
>   iommu/arm-smmu-qcom-debug: Do not print for handled faults
>   iommu/arm-smmu: Pretty-print context fault related regs
>
>  drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c  |  2 +-
>  .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  | 66 ++++++-----------
>  drivers/iommu/arm/arm-smmu/arm-smmu.c         | 74 ++++++++++++++-----
>  drivers/iommu/arm/arm-smmu/arm-smmu.h         | 71 +++++++++++-------
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  4 +-
>  5 files changed, 127 insertions(+), 90 deletions(-)
>
> --
> 2.45.2
>
For the series:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
