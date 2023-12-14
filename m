Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88C697AA
	for <iommu@lists.linux.dev>; Thu, 14 Dec 2023 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KFdxvfk6"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1f03d9ad89fso5948808fac.1
        for <iommu@lists.linux.dev>; Thu, 14 Dec 2023 11:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1702581566; x=1703186366; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGqN9VyFA6bGzLMvanbVJ9xu/V9dzBL2qAxRA0SNydY=;
        b=KFdxvfk6guHkpEr2kJSX7z/hQiI98cPrPMTSbCiE6fclIY18VoDxgoquMmwzTUIsqN
         MeoP2WHStzKUTTgPWimBRuMxYfH40129kiP5CNGLXLifTS/QrYiD7cehoT+USJvSN4JN
         t0sU3HpbnlQ4TFGW9iTcAfzctAq/E8j74zxpXiVXWHR7HfoILTxV2galP6mJokfpESaY
         9mOz8LCNhbDgYPzJuWPLet4YNMaLNHK1R/ioyyBNdaozvOBZ5T98qFzjcD0NgwkpRvYX
         vfJM3MDYZNVZR1IWHPCeR5mgaSdgbzMBMDhCI8q9UEttLV9I19M+0DKyhnfH65U0NIo6
         5f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702581566; x=1703186366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGqN9VyFA6bGzLMvanbVJ9xu/V9dzBL2qAxRA0SNydY=;
        b=AD9+oSBiP/5JuSzjVKJRAn2BExzpUP8e5N+SXbn7nUZwDxryzKTLEatYqCH7d9nmsF
         m0x6oFa5sAkaR1N7iV/KFF8/nYVmKBa0VRZRgwJ32ie0TO3cKM9IBUUCY6Eh65TMpWl4
         I1NrNHWjgiSnuJlBi9KWXN1rFxFDNVZSwbZv9dSszitRs7LlLsKDzeMyY/P28z/G1Xh1
         bCQfbT6xFSfMpTEHTIPYad8Txn3YkGXhFa5X7sEvBKgy7OIHuoLHhsaijAv0/0aPZeVA
         1ve+x1ymeT5N2CyodJjLeoENpsgyjrs3GOPemoauVvlj2UonIIg8JA309yQ/o+mR0nSh
         giuQ==
X-Gm-Message-State: AOJu0YxZT96hb4PC0dHWK9fpVkMmpELmqab5fNdDR51tAduaBilYm2r7
	g5tenB94mQpzjaAtfrSy/Oz2p3SV2DDOjxYSKAcX7g==
X-Google-Smtp-Source: AGHT+IHAnrtenlddaWtCyLx9aBi69QrVuHVWG2rdYXiv2yuQ5vKdApOHPoLr5i+XPih06QNJDodZZT5+m5u6D1Em/48=
X-Received: by 2002:a05:6871:4099:b0:1ff:805:b3e6 with SMTP id
 kz25-20020a056871409900b001ff0805b3e6mr13641663oab.6.1702581566484; Thu, 14
 Dec 2023 11:19:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
 <20231130201504.2322355-10-pasha.tatashin@soleen.com> <88519685-abfb-e2f8-38b4-d94340b40d1d@google.com>
In-Reply-To: <88519685-abfb-e2f8-38b4-d94340b40d1d@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 14 Dec 2023 14:18:49 -0500
Message-ID: <CA+CK2bD-phEK4aWQv-xK74_uR_agRN+cmt5Wq-a8YVB1Gm_gVA@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] iommu: observability of the IOMMU allocations
To: David Rientjes <rientjes@google.com>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
	joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
	rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev, thierry.reding@gmail.com, 
	tj@kernel.org, tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, 
	will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:59=E2=80=AFPM David Rientjes <rientjes@google.co=
m> wrote:
>
> On Thu, 30 Nov 2023, Pasha Tatashin wrote:
>
> > Add NR_IOMMU_PAGES into node_stat_item that counts number of pages
> > that are allocated by the IOMMU subsystem.
> >
> > The allocations can be view per-node via:
> > /sys/devices/system/node/nodeN/vmstat.
> >
> > For example:
> >
> > $ grep iommu /sys/devices/system/node/node*/vmstat
> > /sys/devices/system/node/node0/vmstat:nr_iommu_pages 106025
> > /sys/devices/system/node/node1/vmstat:nr_iommu_pages 3464
> >
> > The value is in page-count, therefore, in the above example
> > the iommu allocations amount to ~428M.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Acked-by: David Rientjes <rientjes@google.com>

Thank you,
Pasha
