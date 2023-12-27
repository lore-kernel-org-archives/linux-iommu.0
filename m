Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C9128E20;
	Wed, 27 Dec 2023 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNi0BRc8"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d427518d52so21922715ad.0;
        Wed, 27 Dec 2023 02:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703671562; x=1704276362; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XEw1e9XOhK8loeWvp+2JpD1B3sTf7+dz1HWvX7OkY0o=;
        b=cNi0BRc8UaiynlxGCM4uq3y5YlWRy/4DXolDCNmAakzAZFE5o8H1ebYc73j4qQxhlG
         3cvYfn2KzMcY+l10oqehtI15r6Q8M+NJSC8MQB4ux6yOITDA72slUl7bPvFLcNcbeQ6C
         BTejO3112wMT5yBi0R9skQvSEGb/ZngNm93FrP2+MVdLjQo1rOHi2jAv1Gmjwwo3kP3t
         3DVBFuA5aGLhDG7w+qOhkq5qlJM+7eVrMPqpS4AwZhH9FvJw4/QO3f5LxbvKpO3H0gbo
         LmENbfw92uNDl5a+otEqcu3oo7v4GwOTYAi30O4Jpw3V7pduH6nlCACWLi+WTOB2xFmB
         tOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703671562; x=1704276362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEw1e9XOhK8loeWvp+2JpD1B3sTf7+dz1HWvX7OkY0o=;
        b=FOOkY67YmDrjR74KB5mldsddlda9XHvA3Tv2wn9YPR0r1gdrD60CzedZYXgjQvEie/
         PtaIcCoQ8Rv75BpK5QQslgptEqgT74j67QuSflPurCMjMn98H1yt0cM3z491qiM+qQ56
         +wUZbvMd/LLGbQbdH4qbKV3KpyBV1xfRe0TBEtL0pJcdGTGpCzRAC1l8n/I2ZdJFolNI
         TURFXk5FmJXSqnwhLDlr/CSnRhujmV4OQ4bm8ZvnN3epVnja63BPUW16nL26wutWVWvz
         xwFdcvvjkqYgFccg90eCAw1B5u8FkVDLZBc78y+gguzt8vMp22J2HXqrAzLgm+EjUt+b
         wMBg==
X-Gm-Message-State: AOJu0YwKIU1ekZqJrLoSRykm4P7FWvVh7wekwdlqqBNQdsNU6LM/fVmS
	TPRApkgZNDuN4v7+MA6Xhj8=
X-Google-Smtp-Source: AGHT+IE0A23XYDmcU01t8+uFS8Gp29gePwIgov5tuUl0DPEmBiz4Ke/Z418pTWmSQ1nONlmsPn7+Xw==
X-Received: by 2002:a17:903:2988:b0:1d4:1044:87d4 with SMTP id lm8-20020a170903298800b001d4104487d4mr14263741plb.19.1703671562158;
        Wed, 27 Dec 2023 02:06:02 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902cec500b001d07ebef623sm11577837plg.69.2023.12.27.02.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 02:06:01 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id E15C51221DDFD; Wed, 27 Dec 2023 17:05:57 +0700 (WIB)
Date: Wed, 27 Dec 2023 17:05:56 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
	alim.akhtar@samsung.com, alyssa@rosenzweig.io,
	asahi@lists.linux.dev, baolu.lu@linux.intel.com,
	bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
	david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
	heiko@sntech.de, iommu@lists.linux.dev, jernej.skrabec@gmail.com,
	jonathanh@nvidia.com, joro@8bytes.org,
	krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
	marcan@marcan.st, mhiramat@kernel.org, m.szyprowski@samsung.com,
	paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
	samuel@sholland.org, suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org,
	will@kernel.org, yu-cheng.yu@intel.com, rientjes@google.com
Cc: Josh Don <joshdon@google.com>, YouHong Li <liyouhong@kylinos.cn>
Subject: Re: [PATCH v3 00/10] IOMMU memory observability
Message-ID: <ZYv3BIeEgY8LnH7U@archie.me>
References: <20231226200205.562565-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vZmYjWY6Cm0pkfHC"
Content-Disposition: inline
In-Reply-To: <20231226200205.562565-1-pasha.tatashin@soleen.com>


--vZmYjWY6Cm0pkfHC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 08:01:55PM +0000, Pasha Tatashin wrote:
> ----------------------------------------------------------------------
> Changelog
> ----------------------------------------------------------------------
> v3:
> - Sync with v6.7-rc7
> - Addressed comments from David Rientjes: s/pages/page/, added unlikely()=
 into
>   the branches, expanded comment for iommu_free_pages_list().
> - Added Acked-bys: David Rientjes
>=20
> v2:
> - Added Reviewed-by Janne Grunau
> - Sync with 6.7.0-rc3, 3b47bc037bd44f142ac09848e8d3ecccc726be99
> - Separated form the series patches:
> vhost-vdpa: account iommu allocations
> https://lore.kernel.org/all/20231130200447.2319543-1-pasha.tatashin@solee=
n.com
> vfio: account iommu allocations
> https://lore.kernel.org/all/20231130200900.2320829-1-pasha.tatashin@solee=
n.com
> as suggested by Jason Gunthorpe
> - Fixed SPARC build issue detected by kernel test robot
> - Drop the following patches as they do account iommu page tables:
> iommu/dma: use page allocation function provided by iommu-pages.h
> iommu/fsl: use page allocation function provided by iommu-pages.h
> iommu/iommufd: use page allocation function provided by iommu-pages.h
> as suggested by Robin Murphy. These patches are not related to IOMMU
> page tables. We might need to do a separate work to support DMA
> observability.
> - Remove support iommu/io-pgtable-arm-v7s as the 2nd level pages are
> under a page size, thanks Robin Murphy for pointing this out.
>=20
> ----------------------------------------------------------------------
> Description
> ----------------------------------------------------------------------
> IOMMU subsystem may contain state that is in gigabytes. Majority of that
> state is iommu page tables. Yet, there is currently, no way to observe
> how much memory is actually used by the iommu subsystem.
>=20
> This patch series solves this problem by adding both observability to
> all pages that are allocated by IOMMU, and also accountability, so
> admins can limit the amount if via cgroups.
>=20
> The system-wide observability is using /proc/meminfo:
> SecPageTables:    438176 kB
>=20
> Contains IOMMU and KVM memory.
>=20
> Per-node observability:
> /sys/devices/system/node/nodeN/meminfo
> Node N SecPageTables:    422204 kB
>=20
> Contains IOMMU and KVM memory memory in the given NUMA node.
>=20
> Per-node IOMMU only observability:
> /sys/devices/system/node/nodeN/vmstat
> nr_iommu_pages 105555
>=20
> Contains number of pages IOMMU allocated in the given node.
>=20
> Accountability: using sec_pagetables cgroup-v2 memory.stat entry.
>=20
> With the change, iova_stress[1] stops as limit is reached:
>=20
> # ./iova_stress
> iova space:     0T      free memory:   497G
> iova space:     1T      free memory:   495G
> iova space:     2T      free memory:   493G
> iova space:     3T      free memory:   491G
>=20
> stops as limit is reached.
>=20
> This series encorporates suggestions that came from the discussion
> at LPC [2].
> ----------------------------------------------------------------------
> [1] https://github.com/soleen/iova_stress
> [2] https://lpc.events/event/17/contributions/1466
> ----------------------------------------------------------------------
> Previous versions
> v1: https://lore.kernel.org/all/20231128204938.1453583-1-pasha.tatashin@s=
oleen.com
> v2: https://lore.kernel.org/linux-mm/20231130201504.2322355-1-pasha.tatas=
hin@soleen.com
> ----------------------------------------------------------------------
>=20

First of all, Merry Christmas and Happy New Year for all!

And for this series, no observable regressions when booting the kernel with
the series applied.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--vZmYjWY6Cm0pkfHC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYv2+wAKCRD2uYlJVVFO
oxMfAP91UU+PRqp8ppjQagfbN7pLlLypEHbSPkqxzjMbovw1xQD7B3ptIVhk9yfz
/Uw9Lm3b2HtnyDuZ0vJwXjXM2mBM/AA=
=vPeL
-----END PGP SIGNATURE-----

--vZmYjWY6Cm0pkfHC--
