Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6942236AB50
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924638; cv=none; b=BC6N5FZ0jflYAKjmYv2g2646pqqYCRUhlxm+BJfbSHgaA9n5GwYHWgD386tGKc/RV8IQqosNAo3lzEYgpRgr8NGknfwcOKntY9uh71NRC5Mn468horQ0+k0JPMWB4jZcA0q3TmcKhS28rbn8O/tCiD9LLKFsMgMdp+UR7v6/z+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924638; c=relaxed/simple;
	bh=gUfxd8tUCsH4Ri8OdkJTpFcmS3niEQjFV9nJtdcbiWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDpyK5C3RER/n6zamZjTTCgUEmCF+gLLEs5iwN8pzhwavdJPEsf0V8Hff+U0moeExeKrdVzQSpjWPIL4U2LBDpqCD1QICulDSYLFBJtrj8eer/VTUyqH4HoqMKJ5lI+tkt2nrKq0DtaMTEK8ifAd+DUVgpUgXUHjCsj0vSukZZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=E5J0Z1sb; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="E5J0Z1sb"
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 2FC1F40198
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 11:17:13 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 1E9774011C
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 11:17:12 +0200 (EET)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 68F82200C40
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 11:17:11 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1771924631;
	bh=DCWq/DDh+AXkwTRVoyWYR0FL/5/cERzM1sSm2MabZXo=;
	h=Received:From:Subject:To;
	b=E5J0Z1sb001wTO+zCTwbX4nN/N9gXJLmEhXLeRk0VrFIPkEw4R42jHVed4yiMAPBj
	 7/rrRKj/EzFV7HdHlfqWhiVMU/ayHrqoj6l2/LqxTIcjMd1BZcfQr+5enaTItqzErd
	 ABTfV7JOY64mA0mtKaEBF7MDNM9eoSlG0E13yIzLJH6DfLcPK3hwVQYjo567BgtMqO
	 KhGnw+UvOipth7lasv7pX0iHkIqGq2EiDPpnILzzBe8U22RfGo8cBEd/3GASPK9CtC
	 NqAboX9xGzmtwxXiWUr9crtJDMf/VDOk04Wv+RxzbZDfvbDKqz43z0cVupbiGkfIam
	 Pv4sIvt/LxyHQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.216.50) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj1-f50.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3566af9900eso2888122a91.2
        for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 01:17:11 -0800 (PST)
X-Gm-Message-State: AOJu0YzZvXcHSzmFmlMRGf/Z0rqK46Ua0mpfm2KzSzuC4d7n+Lfwhcn1
	2/O8MMiBva3fmkRiGPLYdHggr2enX+u1eTHAPAUZSc6b899Om8GFTJNz2P6jNSbFDgzCLYPQdMf
	DjGNi04OUzwX5nMbLBqTBmG53hZp4dwA=
X-Received: by 2002:a17:90b:5646:b0:354:7be4:a241 with SMTP id
 98e67ed59e1d1-358ae81e3d4mr8436472a91.15.1771924629987; Tue, 24 Feb 2026
 01:17:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260221235050.2558321-1-lkml@antheas.dev>
 <a847533d-2488-46a6-9f32-79309d7525ce@amd.com>
 <CAGwozwEe_B6uQPoyz=xXzsi_oYAtyFcLNSOQZ6=kNm3gz8QowQ@mail.gmail.com>
 <131bfe2b-51b1-4235-87a2-ac00a464064a@amd.com>
In-Reply-To: <131bfe2b-51b1-4235-87a2-ac00a464064a@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 24 Feb 2026 10:16:58 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGVoxqbN0XXzHf-73b7jPmjH-wS0YtvG+HFRzezmaNX9Q@mail.gmail.com>
X-Gm-Features: AaiRm52qsmjYAJc589vMWFKY545isPM5A4AdGsBKyxQXsac478C4LVxfuw9RTiE
Message-ID: 
 <CAGwozwGVoxqbN0XXzHf-73b7jPmjH-wS0YtvG+HFRzezmaNX9Q@mail.gmail.com>
Subject: Re: [PATCH v1] iommu: Skip mapping at address 0x0 if it already
 exists
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, dnaim@cachyos.org,
	Mario.Limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <177192463163.119179.2572184556551421044@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 24 Feb 2026 at 09:26, Vasant Hegde <vasant.hegde@amd.com> wrote:
>
> Hi Antheas,
>
> On 2/23/2026 1:16 PM, Antheas Kapenekakis wrote:
> > [You don't often get email from lkml@antheas.dev. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On Mon, 23 Feb 2026 at 07:02, Vasant Hegde <vasant.hegde@amd.com> wrote:
> >>
> >> Antheas,
> >>
> >> On 2/22/2026 5:20 AM, Antheas Kapenekakis wrote:
> >>> Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> >>> introduces the shared iommu page table for AMD IOMMU. Some bioses
> >>> contain an identity mapping for address 0x0, which is not parsed
> >>> properly (e.g., certain Strix Halo devices). This causes the DMA
> >>> components of the device to fail to initialize (e.g., the NVMe SSD
> >>> controller), leading to a failed post.
> >>>
> >>> The failure is caused by iommu_create_device_direct_mappings(), which
> >>> is the new mapping implementation. In it, address aliasing is handled
> >>> via the following check:
> >>>
> >>> ```
> >>> phys_addr = iommu_iova_to_phys(domain, addr);
> >>> if (!phys_addr) {
> >>>         map_size += pg_size;
> >>>         continue;
> >>> }
> >>> ````
> >>
> >> Thanks for debugging and fixing it . Just wondering why can't we replace replace
> >> above check with pfn_valid() ?
> >>
> >
> > Hi Vasant,
> > I can check later today
> >
> > From a cursory glance though, it does not seem very suitable... Can you expand?
>
> Looking into the details, you are right. It won't work for direct_mapping().
>
>
> May be we can have this patch for now, but I think on long run we should update
> iova_to_phys() ops.

Agreed. This commit can be backported so I would like to see it merged.

When you move forward with the refactor, feel free to cc for me to test

Best,
Antheas

> -Vasant
>
>
>

