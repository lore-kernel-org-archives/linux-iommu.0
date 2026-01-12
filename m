Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19B436E48B
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236711; cv=none; b=eXlqLmJ5kkwT1uOMuxuUqTaHyaoIgGsNQZqSxs5653avGwqnQ8MNVrhBO7S3rgh3oeP14Ed9zqTCXQOUwZU1zKmmY2VrSJ5KRB0A8LtfoFBs37vVvHITpNPuPwUcGTt4woOVqPNplw1HTM1uq4EHiX5dTjeXWWCm/PeZiOlpyo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236711; c=relaxed/simple;
	bh=vcL0+tkbX9ziazK4k8h2ep5uJ4MGMym8KpSv7Yi9Qxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAo8vOQ+Y71RL4WEP0icObmNkgyQPQOqbtvVdxoFTfjT+cezjzG1dz6Pfmi4RWl+YR4PD1xpgRILliklh3/mT/U5c5PZXAo52WBejd7a4jmM+9sPQ97HFULlFYozt8IxI+1Ua+hWikJSVkbAlDGF2NFZ1lOINX5q1es9utP9vls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGGnZThe; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGGnZThe"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-350fd09fdd0so19103a91.0
        for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 08:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768236706; x=1768841506; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvoZ+rUrOvuG604TGPECUR2LmQ/bZ1xOw03juzbXQQU=;
        b=CGGnZTherSV8tZLFSRyPT+nd6tCqt6xbKwq0fNE4CgUz8hNvKWNukEpyf+18PbQzAN
         vH+zkTNYW8Xe30BAKwLrH32Y9aA9zSosLjvjv5AGROPUCl/R6m20iaIRSOV0kU1GLUAy
         1UJyf3SYLlbq0uECvPf4VglMbyZchl7mBu3qjXbt7v/V6S9McVnAkJTfVojWxW28kaWm
         pOgqavlI9LvYFTOO59Xaw8N4qJIjGDTMZrWG+d8Z/rHFk29jhRyW0v8SEVOjM7KqyfJO
         aoB/F/TIl333o0cuL49b/LAizrc7WDFtYRIbhKPikjddKrQykMCiKc50lz30ZyleuCaZ
         +SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768236706; x=1768841506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AvoZ+rUrOvuG604TGPECUR2LmQ/bZ1xOw03juzbXQQU=;
        b=cv1VSoZMonVWc0GYGK/iQwy2knUAxtJyP6IaDK4q0pO7bkk2nz9ik9WJr5v/rAMbWj
         cYxxAS9jctuDc21tPK+eAp2o2bGit2Zv4wsrKcvGwy9Dc3KGs1KkuDdlG8L2vhw7pqs6
         sPY3JhTD54/wkoJ9+N2igulDL2GF5blroCDakTv1eTUNuuuRp0/VZk4fx3boK1Pj+6I4
         b/zN48PqqsZf6DpAk8wfDDjr9uO0SylfQlGl62RYhGOwyzLg+7Bikq0Ug7x68OcqGiD8
         7BXi5RmH8f/JEEkwtzy5+LYjTh56Zmpag4LEdmyMw+V+H+VdVJP4+Yn3I6iPZuYr7P9U
         Lxfw==
X-Forwarded-Encrypted: i=1; AJvYcCXU/7E/LkUxG/gN9uxx1xyaTC1MdivXcw7PgqPMM88+6Mnzmbn0YTiHQOHWK8JgPMUF2PhOUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwG4o+RBIIiYzUfmlgciifiS51BGM9FXnqz/gorjJNwM7U6rSv3
	JrTVTtV20qBHtoq8moFphfM2wjt6Dm4UGSmJ4/MoIdxC0lEGfSymWi2b
X-Gm-Gg: AY/fxX4OvI2wWB7chIP/E4ZjDkRYgtXNMcy4cFRlnfB87bW2Skj4XT14QGnmJH24a2D
	Zoj8OhloR5xYKhFLSV9vXbPszzAnSoXfh21yfiVY9RKfOmlv426XQG9wOKm/L6+ju0SYflZOBoY
	Mc1aDbxvgHWj8wyr0HkxWVli7CwwYrmwNS1bx/jwOIhAVb6EDbltYFGXZb3HWmwJb6AZ/kW8hlZ
	yTBH8cnEq1NtVCWIyvu+h0rvk2qqyH046RF7bjR+YxvyFD++5yssdvFmepHwPtEnFUyTb2BlaTv
	+I2KGeLuTpmVdD4uk+7nyjojkxjiN04AogvPQb678eoMRW+p0RODmWoqDppL2yQdSuW+BP8rgaT
	/cwcs/Ox7SX4ca3klPJmrZj6QGaFzqDI+c52lgV1mUo24TTKbVYK71/aUoyLpTSo6Mngf02ar95
	aZHKv5aI/i5pG1ivEu
X-Google-Smtp-Source: AGHT+IEpAyWZFzXSpf6HyuZsb9rIgfw2lyXvfzwmTP+2+WJbNT/kH9DQAwkggu83xayYi/59UBFdkw==
X-Received: by 2002:a17:90b:4984:b0:32e:2fa7:fe6b with SMTP id 98e67ed59e1d1-350fd16c922mr25584a91.14.1768236705446;
        Mon, 12 Jan 2026 08:51:45 -0800 (PST)
Received: from rakuram-MSI ([2405:201:d027:f096:5c52:f599:118c:bed2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fa93ee7sm17905078a91.7.2026.01.12.08.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:51:45 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: vasant.hegde@amd.com
Cc: dan.carpenter@linaro.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	lkp@intel.com,
	rakuram.e96@gmail.com,
	robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com,
	will@kernel.org
Subject: Re: [PATCH] iommu: amd: Fix uninitialized dev_data on probe failure
Date: Mon, 12 Jan 2026 22:21:37 +0530
Message-ID: <20260112165139.7120-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: 561ab88a-ba97-41d8-ad6a-8656a2e2b1d5@amd.com
References: <561ab88a-ba97-41d8-ad6a-8656a2e2b1d5@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Vasant, 

On Mon, 12 Jan 2026 at 10:42, Vasant Hegde <vasant.hegde@amd.com> wrote:
>
> On 1/10/2026 3:39 PM, JÃ¶rg RÃ¶del wrote:
> > On Sun, Dec 21, 2025 at 11:04:16PM +0530, Rakuram Eswaran wrote:
> >> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> >> index 5d45795c367a..075125f0f52b 100644
> >> --- a/drivers/iommu/amd/iommu.c
> >> +++ b/drivers/iommu/amd/iommu.c
> >> @@ -2426,7 +2426,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
> >>              dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
> >>              iommu_dev = ERR_PTR(ret);
> >>              iommu_ignore_device(iommu, dev);
> >> -            goto out_err;
> >> +            return iommu_dev;
> >>      }
> >
> > This is not the right fix. It makes the function omit further initialization
> > steps which are needed event when iommu_init_device() fails (which it only does
> > on out-of-memory).
> >
> > The right fix is to initialize dev_data to NULL and check for that value before
> > dereferencing it further down to keep the current logic.
>
> Ack. I think this function needs rewrite. PCIe device capability
> check/enablement is scattered between this one and iommu_init_device(). I will
> fix it as part of other PASID related fixes/cleanups.
>
> I think for now below fix is good enough.
>
> @Rakuram, @Joerg, let me know if you want me to send proper patch?
>

Ok. 

Best Regards,
Rakuram
