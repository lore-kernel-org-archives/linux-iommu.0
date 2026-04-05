Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389611DDA18
	for <iommu@lists.linux.dev>; Sun,  5 Apr 2026 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775401359; cv=pass; b=rOklkWugdBw01A7zHY5fpqRMcy/TgD91y8NxLxV4Y87iI6Ip8E53hNrVlwKdMQCjTc7t5Gnv02GQo2/gyyM+j7GcV1flzvezMyiVc4XIAgOqMNpHLEQQQz1Hz1bd2PT4cE8yapUbnhU2xTDOKaf1Ia+Nvri1WhwBAOYkHsy8M8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775401359; c=relaxed/simple;
	bh=9j3lK7WTPMMHSj0ufxyU3+aCHpAzHy9zmH39h4t/RyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKfG22FbpySfVRbChi1uzVeICF1/O9VVUavMDbuUl+cHmPaudbrpg2MDXg1xErMoDNQbQaEMN4QKtlVfPGV/bIGiO82SgUdNgyhHd5L4zegLqyXhsxqEprj1et4My9VWxZzvb8Qyxet3AZuSXvlsuSkqfMLzFXInlgBO/izgHbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIpsXX0i; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIpsXX0i"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-685017d0fbcso362099eaf.3
        for <iommu@lists.linux.dev>; Sun, 05 Apr 2026 08:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775401356; cv=none;
        d=google.com; s=arc-20240605;
        b=QTf5vRK5hJZ7l53qYQfI7J6i/F6VCsHjv2j2P33U+LVCg16qNuAzm9k0yRh1hNkZXu
         Dvpk8cfGtn7/vk+JB/Q64qyPhJNlgVhdT71RtaEnzKmLrpAT/aGC3B5XAp+10T6wv99Z
         fGcwFG4LiMbRzC7dDWd2JcWdAxrUfACrdLi6fvh06Kof5IxQObJjQJEYTqUPmEiPJaiX
         LN4NDqM1AICt0Bx/H9EY0mnLKRx6VNBTn5Nlk9XolpfJKGrzvq0W9DOr7IUHPmkmOMjJ
         ICg2WE+JH+XO6P/H4x7VBHIJG6px5ARafGFICfJd0MnSY9qrrf1CMyQoSfnjPCCzu+W+
         BxHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BKgfqTlDfXW4z+tHeqeXTHJrpsEavKUHMehha19RmKI=;
        fh=m+jQh9MlM5efjiv/F/RvtWwivW8ee1LBVDUeyVH8PTc=;
        b=RosI0CK4Bz8Jb3zli3IE/9aiKVsc9MVQXQXDWgpcJRhcA6nASFZGNxm7iUvfNFkbcj
         WLGYyLz3oy885y3Voxjr4IpV0jB8AdJhcEJ65542i94DpoDT1wDzNW2V/Q86lCb8dojf
         Te2Nt7M92lnYElkMDmRl+tZMlI1B5SzEPQhnJqWP2Cq3jLangHqzrWvn4SQ4J1yzfikZ
         qoSVDmN2hIvlzHxHeSnr9PSry1f9erq72Yz29gS4pxycR9a+LMWp1ozSN26CLbUYxQp4
         ac35euPoG7oVUWPhZ7qpqBzstJNwsML3KJMmObmHDFpoA7eYw4xne4Te65rjQwC7hGq8
         U7gQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775401356; x=1776006156; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BKgfqTlDfXW4z+tHeqeXTHJrpsEavKUHMehha19RmKI=;
        b=EIpsXX0iUQKpFZOzny79xdDq1C+3gWe3oOdGjYlGqlKsfaTc4jIJts+yHGFGdbpMP4
         CtNxCKoh6nrEvqzc7QYRDf1TOw00eqlDNAts2Gkz+Tk0+rrQJSAHJOEaG0tOgnj3deI8
         mDZMLx+HqmfTeVXJ0Zc1DKJRtRPYlrTPRSpES4R+5s3rjPNo6ipNobrdbJmpajUAIWb9
         hzaTRRhjaR+BvmQy0xFt6u8tMIOIWzAAb58r7MegWlda2wWF9+2161Qzg3sPgHWzjmAh
         h+LPZQTrwZP1hIEWB01HFBr8kQDIFZWI0XNZRnul5Y2Gw0JFFJ4mPohax4JjE8PE/8kR
         3WlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775401356; x=1776006156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKgfqTlDfXW4z+tHeqeXTHJrpsEavKUHMehha19RmKI=;
        b=eHdZqYkl3aN8ZjQMy1Il/k4PiyHjQsuzwIiED/uqxpi2YOkY1MHzkR1QLWkVe3jZrX
         jq7KV9cL176Y7u5rQDqNQcba1TFkxLBSmt9yLQ22V4VX/5AYMgyTWJ0ENeNG06kjS1/p
         4x9wP6500fcDFBmz2/csXeOaQU4GRgW9pv2fE7Ty0stM77pln4RQDpO3nHfu4eJutt/j
         toKiH2/XyLzl09J13xkwlh9ZxHVMPb7vHalsVyb9PPTvWE0zih/lr9I/E48u88Ut1o7n
         AVV5avdl5cDUKV1WkTGMlsID+GbiG58uxAmDjvXEFENa2YTmXkZxOpXHBaBNhNniunZo
         VL3A==
X-Forwarded-Encrypted: i=1; AJvYcCUlOZW5JL73/kNEfhLDGpX2PSrhsGLyDt/TaMefUtf0/liZ/Hm9rQK9XGW05vYXhJT9+69U4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwY1Tl8HiObieYON/Rhe82b08OFeXdy6UP39Ep21dboCQEYdLVc
	F4gwpCPR4KZ1baEi8G65RdzOI5hFcOAGuDSpSu4bwXwaE1aXrimSxMeJPllc44px9ksmZzpUm8b
	QzsYi7erULRupNbMP7jHv5BfLGooLNZ/QBTCxsNfHZg==
X-Gm-Gg: AeBDiesCxav42S2DyjziGlkMYY4+V2/F1rlIbydTeYygHSLRSO5tUZ+cnaD5tZGXJrs
	L6RL2EDZPZz+B7ow0OWDAoQkDnjX/rN77oGu2UciBW2Jr1RYiLUDatzvq46O4SHa4nD+oXo2utm
	ZhNRPJkXGk6hCB1+589rN8NubOhJWEw6s7pV8hSthlRsc3I4ZVGmaBR14aLkRbsjY3jDrXuOu9e
	2KRh0nC8tMLsE6aO2op4TCs5RV4hLCN9z+eieSIUWMoCy89eTWb0OHqNrOM3uSidpJrlL2ABXNJ
	NktKy6c=
X-Received: by 2002:a05:6820:4df7:b0:684:552:944 with SMTP id
 006d021491bc7-68405522453mr2824401eaf.32.1775401356051; Sun, 05 Apr 2026
 08:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADvBJZm8nqbpNRvB=WheP6QhWDXMbtcKff3R7F93Ffy5NBOUWQ@mail.gmail.com>
In-Reply-To: <CADvBJZm8nqbpNRvB=WheP6QhWDXMbtcKff3R7F93Ffy5NBOUWQ@mail.gmail.com>
From: Elisabetta Bruno <artisticdesign@gmail.com>
Date: Sun, 5 Apr 2026 16:02:26 +0100
X-Gm-Features: AQROBzBCbSPfzZqFIToaxq2lRjI9yAqTVWHbAD1k578g2IhS_lMSdyITe5YZng8
Message-ID: <CADvBJZmWHUX_3mtFBU8AQ_C12Os3TSRYD0jjRb2p2755-qne6Q@mail.gmail.com>
Subject: Re: Re[PATCH v1] iommu: Skip mapping at address 0x0 if it already exists
To: "lkml@antheas.dev" <lkml@antheas.dev>
Cc: "Mario.Limonciello@amd.com" <Mario.Limonciello@amd.com>, 
	"alejandro.j.jimenez@oracle.com" <alejandro.j.jimenez@oracle.com>, "dnaim@cachyos.org" <dnaim@cachyos.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"joro@8bytes.org" <joro@8bytes.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>, 
	"will@kernel.org" <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 22 Feb 2026 00:50:50 +0100 Antheas Kapenekakis <lkml@antheas.dev> wrote:
> Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> introduces the shared iommu page table for AMD IOMMU. Some bioses
> contain an identity mapping for address 0x0, which is not parsed
> properly (e.g., certain Strix Halo devices). This causes the DMA
> components of the device to fail to initialize (e.g., the NVMe SSD
> controller), leading to a failed post.
>
> The failure is caused by iommu_create_device_direct_mappings(), which
> is the new mapping implementation. In it, address aliasing is handled
> via the following check:
>
> ```
> phys_addr = iommu_iova_to_phys(domain, addr);
> if (!phys_addr) {
>         map_size += pg_size;
>         continue;
> }
> ````
>
> Obviously, the iommu_iova_to_phys() signature is faulty and aliases
> unmapped and 0 together, causing the allocation code to try to
> re-allocate the 0 address per device. However, it has too many
> instantiations to fix. Therefore, catch ret == -EADDRINUSE only when
> addr == 0 and, instead of bailing, skip the mapping and print a warning.
>
> Closes: https://www.reddit.com/r/cachyos/comments/1r5sgr6/freeze_on_boot_after_kernel_update_to_619_fixed/
> Fixes: 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

Hi all,

As I am seeing this still marked as pending fix, hopefully some real
world testing might help.

I can confirm this patch successfully resolves the IO_PAGE_FAULT boot
regression. Without this fix, my system requires the iommu=pt
parameter to successfully boot.

I have verified the downstream patch used by Fedora in kernel 6.19.8
and up is stable and working as intended on the following setup:

* CPU: AMD Ryzen 7 9800X3D
* Motherboard: B650M DS3H
* GPU: AMD Radeon RX 9070
* OS: Fedora Kinoite (Bluewhale custom OCI)
* Environment: Secure Boot Enabled

Tested-by: Elisabetta Bruno <artisticdesign@gmail.com>

> ---
>  drivers/iommu/iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4926a43118e6..d424b7124311 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1224,6 +1224,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
>  ret = iommu_map(domain, addr - map_size,
>  addr - map_size, map_size,
>  entry->prot, GFP_KERNEL);
> + if (ret == -EADDRINUSE && addr - map_size == 0) {
> + dev_warn_once(dev,
> + "iommu: identity mapping at addr 0x0 already exists, skipping\n");
> + ret = 0;
> + }
>  if (ret)
>  goto out;
>  map_size = 0;
>
> base-commit: 57d76ceccee4b497eb835831206b50e72915a501
> --
> 2.52.0
