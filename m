Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF977174F
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748762; cv=none; b=tvhzf01UXL6u1gCM+G+ThqrLPiq+xWEqVOEGOC3wppx/ez7XE1oaxfS7K01bxcbW0i2SKwZkQouSdzvHt9mKhNnNxt8k4AVUe1Uhg7nPYMYEEz3UduK/TDFIkXoinOt6fq+qpp1GvmtpP/ak/JA6RsOBm4bJbTaGET+o32DZ/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748762; c=relaxed/simple;
	bh=JWTK8FGShNYT2lN877/l3UqBYwVjKrQjVP5pV6Uvu6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B21tw2waqYDPQ8UoZFqY+1EUvhfcoz/cYe04LZJ6d3alYgDTsSIKbpAhIz1LDz6WRtEomOS7Ve5dkm26jne24RUunk3Qqx8wX6PqTw/ip93RPqvMoIj/HT+pDBMyyCgkRW/op5xUMfFu3FBdpCr79AR1QtwAlN7AB9iTaHfZACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bka4nDI6; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bka4nDI6"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-26ff51294c4so916645fac.3
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723748760; x=1724353560; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWTK8FGShNYT2lN877/l3UqBYwVjKrQjVP5pV6Uvu6w=;
        b=bka4nDI645wt3Wqal/TyFJrWaaF+g7A3Qk6M6qlqKgGYfiSh8+eD/sGS3rJ27tVLX6
         2CHWrhamutICUM0pq8dUWOgte72LYmb6+ykNzJVAha8w0YUd2rWd+MUJvFwG1yeugg6r
         TIhUlIQACLFhSNtz/0DNgx0EDls1KplIfzWvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723748760; x=1724353560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWTK8FGShNYT2lN877/l3UqBYwVjKrQjVP5pV6Uvu6w=;
        b=vOHfhMHDV06dmxCsPPP1pxC6rdm6m9803rpkMuiRG4LcPR2MYJ2oxpUMjrfgKXRR4B
         FUpTDE1X7Klcf1773CXLQKOoZhYnEvOe+4Uvj7o9mUaOa0WiBxaKGXUOuIKSu557JJQ0
         0HAbzvkhD4bK5feo0tMC62V07mPvu/XoIXXO/luCm9GSX1bRxhDKOiM8Y87iAYJ7VX1H
         2LyafPhBSllkSFmV6KYgkby8h4UVjnSqKRAYmxxYj18//tQaK2Pt5VdGTAcHlBrcIIUr
         SnUNuOuWp7vDq3Vt0mByxCHGtJ/ujtMTpUOVqPQFilWIWLubVrAIe9YRi8gI499odGip
         o58g==
X-Forwarded-Encrypted: i=1; AJvYcCXRbg4L3066M+cLBN4yiyDd1QEJiKfEyE4nvrLQsemOtFeKdHYKK6qBsmnoxYGWkF+5IEr74KyiESb0W/2ivqDZzZuFXuw=
X-Gm-Message-State: AOJu0Yyt1jRb1eiwwjpMyijIgBUnHvqr1gY05TFJSU6KdxXv9iCRz6mK
	iSIz/u5bW9gciCrVPzyZ08gqjAzbufy4hrtv5vD/dhKg/lCDVPJWh7KuYNQUdYJzMvuO3Re+lHM
	oTWd8aQykY6QfG1NHveOuK0G7MaEcHt1RerbA
X-Google-Smtp-Source: AGHT+IFI6hSc7AGc/sW2JQfBUY/KniMDdNgoq1mzxNAQkecM/83LRUyAO4Lxl0MBqVBAVhpmGep+xg8wQQC8nX9vvQM=
X-Received: by 2002:a05:6870:d609:b0:260:fd64:60f2 with SMTP id
 586e51a60fabf-2701c34a69cmr661045fac.8.1723748760099; Thu, 15 Aug 2024
 12:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240808-trust-tbt-fix-v2-1-2e34a05a9186@chromium.org> <20240815095928.GE1532424@black.fi.intel.com>
In-Reply-To: <20240815095928.GE1532424@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Thu, 15 Aug 2024 15:05:49 -0400
Message-ID: <CA+Y6NJGncpn4+UjgNavU0gAcChJZ9dji9_sBmMr85oJ5Eo79cQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Detect and trust built-in Thunderbolt chips
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 5:59=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Esther,
>
>
> I now managed to test this on my test systems:

Amazing! Thank you for the testing! And also for the continual prompt
responses. It is very much appreciated.

I incorporated all your minor comments (debug lines and comment
deletion) and added the commit lines. Submitting the third patch now!
