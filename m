Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA35136A;
	Tue, 17 Jun 2025 22:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750198703; cv=none; b=YOJYLYo0OrPzxZnoZBjGNUnABPuUWPh6MmSBMapRkhWCuuCSFp3lLwSPh82bR8e50wJddesJLMls47jAfzfWEJG7HNoQH63egEe9bWMvlj/y9/S1GYaIzJyCSZiCthVmuh+0OzH2k/dQ/cQ9YSW0FAhxFqTQ8fJkwOcevWTRO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750198703; c=relaxed/simple;
	bh=JSQ8c3bRabnCayUlehYiu+uvSPqvMtoPuZgRoDGUHoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeZTTT2+MJwtp1FoU7VZ5vt3laE3vEKTB7Pr4BwMtv7k73dr402CeGOkaVU5Dq8TJZggXngpmKsrdaTcSxT8UkEEcDZABEzujiIzj2e5JUvnh+XI7FTFalJHSqQiuNAkNgnefaZcbmkhf8j2Pb1VX/cb8MiuGpeX2MJRMvUnMEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fg524o0M; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fg524o0M"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2353a2bc210so55679155ad.2;
        Tue, 17 Jun 2025 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750198702; x=1750803502; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9NIdWve1K1b8QzOBntihNhgvZs/2vkEK7FdH81C/3/I=;
        b=Fg524o0MPJyyK5xNC7dPgSzOBGhzeoI02VlK1sUFmEaFR71kTOd4rcDLgKzXjvRBjZ
         nwrbaNS4/YgV7kuO9VR4igwPioVDO34yjYALSZK6CrRUm2l/E1+gCdRCWcjEar2yeI/4
         V6EEvMkAQtoLuMhwo3A10E6+OtC7yFNUeN721U34IU11toBwlrpKVN6Bd4zAIIym9hXR
         Z3fHZi+ggb462WnMs9Lu8yb1BvW4tbMW6/XQ+G9Bf3kv8rHB2XCrlogYCqzz7DrFKShT
         zCOkr2o9IfFic36fwtEWrTj5bhkmx3B1B9ZEEJuQxMSSEKPiRswkVuP2NIH1fLl0pA9E
         aZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750198702; x=1750803502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NIdWve1K1b8QzOBntihNhgvZs/2vkEK7FdH81C/3/I=;
        b=GebxG4AXHPnfQQ9D6Ksyk0d/NIt1yv11u6DLJNqUqGnfkafkh60ydtUXqeermswxKO
         posi/EMEZng5AvrtQV6D/tV6P4zhOzYt8x8c3xx13lQqYtHa6P9KuG92ShfLqxGvZEmL
         fIdhtO/G7DR4QMWw5rdmfeiyL2pPf365WQFJh3ij1NgCpRPrOe1s39g906GpmtwN15h2
         eEGG4iHCGJuTRoqej8SpvVDN/zhYNMok8QEBDTNWbIEuYY+B6HTen+oRXjLbDQMmx5A2
         wMEi3a0tcaGawBMU1sW9gEwZ1trRg7XH0DGC4v/uigaGSEJ+5aGHvFJOv9hGB78QZZxa
         xf/A==
X-Forwarded-Encrypted: i=1; AJvYcCUtELkApynED1m5xQIBT+tzbbtcVg/rSDm9dz9+u+5ZG0b+byz18sD2zVVQCjyauUZVHikBmQ==@lists.linux.dev, AJvYcCVKf252dFwyIegzicDk58d+UfJoYB4LnbSwrc0leFhGWl1fHqrlGMIVz0j22bGo3yf93mU5wxI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5ZBIhFvumjVsDq5G5KBrne2Y51vGdlz4kviHmpzhsWppHahA2
	cdqlfh8LXzq16JmJzVWDaUESj+qSAxrTxkfy5or1W0NWCNJTiLBn/5HO
X-Gm-Gg: ASbGncuRwllI51LXeC15c+skBpElz9/Afnv1Sa/UPcT5mhOPvDGhmEpPVQk7VDUxlkp
	OjkdJpDAMNqyh2FBnbcUsrcR4KbHYpB1kn+/5DbkA0GyTNlpZ5rnbm+0igmsKoPrmViMOZt/Cmk
	1t3Pta90jzlzvXwO8zkSkzlAOsnyuixEukn0GNJw2+GNxr2yu+ps8LK6EGf7PVuSdtYmtBbrudc
	fZ05MvAz3RRQVRIiNdMqs25Mu1kHFZlNCRkRx4fk+QdP8wOeEHP+R6f+oHxj1fr97ZQ0/esHdzw
	R1kbdsGU7QNuF+0YWhPrRkj1XLelLfFzRiqTr5WmwycTZX9ORo1aqWT7B2UcYgc=
X-Google-Smtp-Source: AGHT+IF91BQZXlbd6uuMahbLtTEtN2tg3W8Od60D+rCGiIPm2Y3r9UQq92CpdM0V1gssQmyVDCfWGA==
X-Received: by 2002:a17:902:8bc8:b0:234:a139:120d with SMTP id d9443c01a7336-2366b32e4ebmr135159835ad.7.1750198701630;
        Tue, 17 Jun 2025 15:18:21 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:4cd9:8b8e:24cd:5a36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deca40fsm86178655ad.208.2025.06.17.15.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 15:18:20 -0700 (PDT)
Date: Tue, 17 Jun 2025 15:18:17 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sven Peter <sven@kernel.org>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Neal Gompa <neal@gompa.dev>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Vinod Koul <vkoul@kernel.org>, 
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, iommu@lists.linux.dev, linux-input@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 08/11] Input: apple_z2: Drop default ARCH_APPLE in Kconfig
Message-ID: <oinzomct3qvhmlvulhsubckhtarrz2eedk4ymgnvfeebmiljtt@3wtkh3un7cdb>
References: <20250612-apple-kconfig-defconfig-v1-0-0e6f9cb512c1@kernel.org>
 <20250612-apple-kconfig-defconfig-v1-8-0e6f9cb512c1@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-apple-kconfig-defconfig-v1-8-0e6f9cb512c1@kernel.org>

On Thu, Jun 12, 2025 at 09:11:32PM +0000, Sven Peter wrote:
> When the first driver for Apple Silicon was upstreamed we accidentally
> included `default ARCH_APPLE` in its Kconfig which then spread to almost
> every subsequent driver. As soon as ARCH_APPLE is set to y this will
> pull in many drivers as built-ins which is not what we want.
> Thus, drop `default ARCH_APPLE` from Kconfig.
> 
> Signed-off-by: Sven Peter <sven@kernel.org>

Applied, thank you.

-- 
Dmitry
