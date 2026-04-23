Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F33A6EE3
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 22:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776982287; cv=pass; b=mjR67O8yuh3Zv+GACmWV5fbkj2T4d13D+tmpyTa/VQ/ISo5tJa5RmPsrxGXbcEevknGyUVjyQvs5TLYA7h01ZWCXPXLDciP+DQ01GC3tf48YWC8V7klE+U/LIqYFvnGAEu0eda9yNMnKTcYI1DH11ag1p/pV0YNkVk9cQwwggfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776982287; c=relaxed/simple;
	bh=1LE8KttVtGM+9CpiUlwllHY6AYyzUrNOnEbtRD51iDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7lGIAl3O16E4QaSD4ePRdfk/sIj7DohnkXu2cw165JiWmX2UuLfEmupw8B7dCjgbsrf6yklp1v8Jqe9zA/ZEA9kbZIikdgvIZUhNCWDjWOuEiLyFR3avgPF9zAq0NwDNOyiBqASAa/fpojuP32bOqQsJCS2BAFSQLv1LDawLCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PSH7O6cf; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSH7O6cf"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38dd9f11a09so66312831fa.2
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 15:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776982284; cv=none;
        d=google.com; s=arc-20240605;
        b=GQlICUzyRBPv1jUhrH+2ghJ+VNvcGiv2zTpPxCMpRkpZrNYRACaOTYl+c0OrnhZGs8
         49es1h+EM5KYRUwmvjwF3pf4Yntwz/NsgxLgjRkslg1GDygCHzpX+zbKkALbTft6MGjg
         fmiXePts/xRpSV0OWemT4fyJa2eki+PHXAiSr/GlzxJEOntAKO5X2JTM54zahoNIm1Bm
         o5mUfvIqkVtLQcjKRJL2uRrw4a0bdp02ShH/xtNVG+oJ5GStiHytAZUuIFeroaotNCW4
         Rz9ferVceUzxQRXmCt7ET4igjtoW2iWPzNBvjZ115p9cfMeblRJlaSDANjlWq0t8RiA4
         jTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1LE8KttVtGM+9CpiUlwllHY6AYyzUrNOnEbtRD51iDc=;
        fh=LPgMkiZUAYyiL3iHnBTuyrx2kwBVwXCsj7awObA1ePk=;
        b=ATm16IT5PQh15bVqm7n26CYfL+GQ5KbrQlXfU1SV/BG0pIcDxcPugX1vvCN40TAGJL
         CbLXuQYMUBiEPv0qSuAK7+XM1NyfVPvgrdzMCJ+Vt7GCFlwXicw1npHWB3wfY2fY5Wbt
         nRY4X/IEVdiGcH8Vo6YA4LyyMTuu/OM+LoIBKV4tfxcSDSZ3XUDiX9l/Z7GwfIJwIaZ+
         Mjv4c1p3CJ55y3yWJ2ataMKGHuiyctfJr0WohfMuqzs2sON5ejItzPXzJ9JzGjtfu6jE
         cHkBz+rl6DRs7L95Dpfmhf7RBSn6FnTEIjxt+QrBUfH35fpSwsjToMt9O02oJTLk/bKd
         KRjw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776982284; x=1777587084; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LE8KttVtGM+9CpiUlwllHY6AYyzUrNOnEbtRD51iDc=;
        b=PSH7O6cfRnrbx/dX/J7+7dxZNFq6uLkLxYe6bCBgVqiINL+RFg1yeKSu/orgmts0AC
         VXlwiYqJSoLgUpRpHF1mkiE/pRDzi/hG5mSqUUAwQX/p7mT0oUaFVt1QX5hc8h4WEZjE
         dEwTyw72o77U+hOMwCJwl8Dn0SW0O/VS9CSfPsh84anEe+yEAGMcIUjPbvmupUqUCQNa
         Zgdh/MXjF92DcTEVHAxzfc+F3cVBajdU9f1vCLzBznz8Wa/5T7V/jMHC71SFzUT4xfTL
         d191xGDonn8lMBlDR2NG6UVpz1ZNsj5rniEfMB6xH8mmQgDX/5xlkGOgUYJNd9Kiw/Vs
         dpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776982284; x=1777587084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1LE8KttVtGM+9CpiUlwllHY6AYyzUrNOnEbtRD51iDc=;
        b=Vg/hD/XyOmDX9jd3yZRJjFOaEnmVhuNgCy3WwM3GM7YFxzplJLRh/2QfENHCd8MR/M
         eOkFT+0AdiKeqfpMmi1Eesyjfo7s6RMVwtypUhJvMJMnbSBIA8y57ExZZOXKvxlc4977
         sh9TQRmsU4fbY7t5U2cSjIhEvDrHFVv2jjuy+xE8v0AFJSfMVvkR1CdXflhwyn6nZPj+
         C8muDid9FWSLoBlTImc3SI+dGsn7iXZsi9jiQ2ZEd78Zncv+szFJ62Z2Mw++eyg0oe3S
         gklA9rb5Qi8/1XgWqwSc9PXUmRJ6D+HOFUXeme/rV0dgFyFGFf4vhhhDn/BiaYzqFKLP
         hPfw==
X-Gm-Message-State: AOJu0YzofD2EFEuc8QB84XXKY2n0fBeMCfhZOJswpSiVlw0wtclnMr1S
	nleAl/aoCvX6N0aABrN4ODwsHvap6tgPCL+LOQyaLIwza6fM/XRtaG6v1ClLq3ttytd2X73HFu+
	nrYl7xWmQQZcwxxL9LplMIkq8mXSyATcu6o0ZQhdJeh9kMxfwoL0l82Wa
X-Gm-Gg: AeBDiesl299bxQHqapNsLshM1D1IjN5YYkwYPHbfwrrSPJ9v6JUDt3Q7CMiAiHqE2Hr
	huAbiNQxHAoPQOq0LKV2nFpoknjds+OJy0VkGuMGWQpdLzmtmpk89qKHQL/mgqIhMOSdHyUE3/Y
	dglo6kbWuq2UKY1HrbtOAoVnXlgVq23s9ER7d4TgZJg2Z2XNTBasXjyCYEXoD8PqmPXHP/PbqP/
	cHzHk3tLUKlMLFakmEpuKlrS47t77ziHPZIc2WK3veZtAmfFC/B91ho2OuTSgUCRLFk7w8dOv9a
	s1HAUMAum3nNCeY/LygQHojh3iWAMw==
X-Received: by 2002:a2e:bc83:0:b0:38c:6b7:ad39 with SMTP id
 38308e7fff4ca-38ec7818193mr99821181fa.13.1776982283419; Thu, 23 Apr 2026
 15:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-9-dmatlack@google.com>
In-Reply-To: <20260423212316.3431746-9-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 23 Apr 2026 15:10:55 -0700
X-Gm-Features: AQROBzCzQHNRAyujF9tGZltx4kVtGjkMoj2uVw4QUXf8lLhcB6v0kyr5BiRYiDc
Message-ID: <CALzav=dGpHEnEjyp8qc50iZrGeKJ47vjLvwtvkLCyNzOMJhozw@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] PCI: liveupdate: Require preserved devices are
 in immutable singleton IOMMU groups
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 2:23=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> Restrict support for preserving PCI devices across Live Update to
> devices in immutable singleton IOMMU groups. A device's group is
> considered immutable if all bridges upstream from the device up to the
> root port have the required ACS features enabled.
>
> Since ACS flags are inherited across a Live Update for preserved devices
> and all the way up to the root port, the preserved device should be in a
> singleton IOMMU group after kexec in the new kernel.
>
> This change should still permit all the current use-cases for PCI device
> preservation across Live Update, since it is intended to be used in
> Cloud enviroments which should have the required ACS features enabled
> for virtualization purposes.
>
> If a device is part of a multi-device IOMMU group, preserving it will
> now fail with an error. This restriction may be lifted in the future if
> support for preserving multi-device groups is desired.
>
> Signed-off-by: David Matlack <dmatlack@google.com>

Jason, do you think requiring singleton iommu groups is still
necessary/useful now that this series preserves ACS flags on preserved
devices and upstream bridges?
