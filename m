Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699918;
	b=rUxtzAVJ1MNwSdFH/3eFgr32Ta8JuMWQI2MtJdJYuhmx/f4pH3lle2RoOnwYHqLAGV47
	 j9leRYRmn4ZQPMr8a9iAL0X6gEUCy0dahF/SN/eZrQQFdcS50g/eDzm7H9vqjIzwJGQA+
	 9WalhVQWKsKGLOrLUyBSrbrju8WtJxteudWs5NNkmOn1JP/lI+5v14gvC1QPIYGYK6zv0
	 0TWjtpaHCmwXOtdaxc+embCdYGU6W4bP7/fuPCe+iLY/gLV+bTzBEtuAP3qjphGg4F/DK
	 6PD7UtLb01/0aDdpoIRtiCso1Gknj/esC/nGfT1+HskLPQidwssG4vXzHkfh1S/szjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699918;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=3B43kyyzUUTLVNXK4AN+mljA56km2Ewzy7V4dK6lZDs=;
	b=vi9vgecc/6UcMj8HazmAJyxR23a4N1gPT9ygiHGDf9EDloNqU2DKP/fF3lwkNsQLwy5/
	 8MeFMSkBX7NNw1zTJy9c7TIiaWu0yb5zRg7DCgCPMtCDwC0KjjKOA4uuS/CRpKNTpmtaQ
	 LZnmVqI7CsiiP+ZqeWnRy34Hx/0aeMn/tJwzfBtbchpxaBdYj91zI7ogPm1lpjbB5Exzd
	 G+M8GhuSRm0nWF7SI2HVGa67rJvCW1ivdDDvxcjeLsZGS1SUjeyy+6WlDJpOEQM1rYLXt
	 Xp7XWQ0Us4GjzW/cXYX6eDd5DFSYoOU45jpQzDEaW5UDZ8CPd0ybWIHMAOZkx2jKmIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="WJ/MpnsM";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033B606A682
	for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 13:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5033B606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WJ/MpnsM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795699917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3B43kyyzUUTLVNXK4AN+mljA56km2Ewzy7V4dK6lZDs=;
	b=WJ/MpnsMhiux4kO2TcryEy1ZEU7GoPXkgoJC32P2byjNky3ic9339pCaDTb4YOSj89LiDp
	rc4Gd6JzCwvDpsVXmeNc7EB00f/DQHaNnauPQ8lOEkPdN3VZy41AWjLpA3/DF6cxQdMzPb
	Ny3szvQ5hjT6sVl0cCoyl5kbCKp27XU=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-aZVcC6G-O3ySOYB9yE_xwQ-1; Thu, 26 Nov 2026 13:31:55 +0000
X-MC-Unique: aZVcC6G-O3ySOYB9yE_xwQ-1
X-Mimecast-MFC-AGG-ID: aZVcC6G-O3ySOYB9yE_xwQ_1795699915
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5ed100ed770so596935e0c.1
        for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 05:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699915; x=1796304715;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3B43kyyzUUTLVNXK4AN+mljA56km2Ewzy7V4dK6lZDs=;
        b=Ey+RJqI8CAm+uRctg9xy03JfgKpRu6NGGJmUgWitUhl9pxXWgEe8o9iAEeLOuk1yGy
         lJmaBEmHY7O8El8foYvoFMpJGBorXIoDS0ENngH/LW5XUtzxpWrRvZoblgaJoOz+Sj1k
         Pk4ZyyDFOOVXJmV9E5vmYmQrS0hmxDio1IiraJfus4DLmETZBLgZ2sRJtJp6KNO5ZcEr
         K4MMbwc/oigY9qMQxlqQCVGqP7pogm7/3/V5NJI+dKQfs+y9kFFiqtRF9jmoWxB0K20J
         j4SZyqpw1haUbrSKMBPhQ0AreGzsb4rJCtsmgArWtxZBH2qUUTaie70AfcW4KVix2vgf
         Ofgg==
X-Forwarded-Encrypted: i=1; AL+hErE6lcauXFhyD2g70UThRBGAgaw4VONBaHUEf1+0tyWCbgRy8WNS27VSOJWtBXi9fczpYG6Y5Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z8G35VCAlMLZ22MdEfiy25qfIGMckEb+rVp+fNuYzL+kCAMa2Iz
	iGglRblWchfQuRYVp6xF+17XV1wTGoFaJACon0kSb/sL4KYU45qQ8hYWxXjduGJ5hBzbp6OY9id
	pyX9NLIvpT0o+1frFvxI07WBF1R/7HkfeBeo6YI21YF+1dyUY/JYwX83m
X-Gm-Gg: AZFdTZc55IQrhO+IzjeYb2g6jqZA3P9Ua2chePnMh6sP1Jx+wClGPHqnC89B8ybGeb3
	CQO3T6ZRmwYywDp0zvM/6VDSORV3cNCCCDeNERFUxjhVoJXk3m1A6C5k+LN/h7MhpZmKOD7kehl
	DdaCGBUHkzbnL2wICghmwFuwbydNs3heKE9WU/d7qV7FUrIi3+XPA7OMNoW5AYjV/Na3CFvej4j
	/MHwWH8ss2gKZBm6SHYLiGkj0dbuCdFA+ciWjEOnQ4RZtYqSWO6+f3hbaO48aC5C3BUHcm61cwu
	7Wmju8FOtTKY/ie4UqeTRWQn0vhenr0vLoRoqePWudmfgbK1COr+5mScfz/U3/mI0yn22FqUkE/
	GGL1CqOlFG8ZaN6M3uqDxasmXWJk56d8yu7joxu+ICONtQM2At2keGV6Q0vCpFQDjCNcHNoWm3U
	dQD/SD41TKD59kO38e3FUwqdAp0pyAY3nMncerJ8Pnv+rGCJU4/RcDl9XiRlx8BV71ziTTew==
X-Received: by 2002:a05:6122:29cd:b0:5ec:d751:a18e with SMTP id 71dfb90a1353d-5ee8af5d5c6mr11288508e0c.19.1795699911800;
        Thu, 26 Nov 2026 05:31:51 -0800 (PST)
X-Received: by 2002:a05:6122:29cd:b0:5ec:d751:a18e with SMTP id 71dfb90a1353d-5ee8af5d5c6mr11288267e0c.19.1795699910439;
        Thu, 26 Nov 2026 05:31:50 -0800 (PST)
Received: from loberman-thinkpadp1gen5.rmtusma.csb ([2600:6c65:2440:d8c:929c:b769:6def:faa3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788506b0sm180018331cf.17.2026.11.26.05.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 05:31:49 -0800 (PST)
Message-ID: <f323c3d62265dfe90fa71514028af4d35f6e2420.camel@redhat.com>
Subject: Re: [REGRESSION] DMAR fault by Intel H97 SATA controller since
 "block: Increase BLK_DEF_MAX_SECTORS_CAP" (6.17-rc1)
From: Laurence Oberman <loberman@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>, Lu Baolu
 <baolu.lu@linux.intel.com>,  Jason Gunthorpe	 <jgg@ziepe.ca>, Joerg Roedel
 <joro@8bytes.org>
Cc: 70sp <70sp@protonmail.com>, Thorsten Leemhuis
 <regressions@leemhuis.info>,  Tobias Laas <tobias.laas@posteo.de>, Damien
 Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	regressions@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-ide@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org,  David Woodhouse <dwmw2@infradead.org>, Will
 Deacon <will@kernel.org>, Niklas Cassel <cassel@kernel.org>
Date: Thu, 26 Nov 2026 08:31:48 -0500
In-Reply-To: <0edb9525-5068-42e6-b6c3-a1dcebcbcea7@acm.org>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>
	 <awSs5Cw3hFkf4O4T@ryzen>
	 <ec36d13e-e4c2-4bfb-8b50-69d4a1628839@leemhuis.info>
	 <87b1bbd8-8113-4890-8623-738b19a9cc7b@leemhuis.info>
	 <a0ff3156-add0-4f7d-8373-09f95bd7036b@acm.org>
	 <2adaf0ef9e1a2fa18590f7d8dbf203c0f7de2be7.camel@redhat.com>
	 <uJluFNYGCCrdvnYT3MatN_4Om8UczTJX_dzxumJxyCAC7F-Ubrekb7LPwlRxhCW0J91UBf-TqeRoJQfgYIYBRvMsPmE-Qs1eAg5zbDP0s58=@protonmail.com>
	 <0edb9525-5068-42e6-b6c3-a1dcebcbcea7@acm.org>
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Foua6ggIv6E4l30y6QsXktv5IEAH53MB0FrXD-CqZcM_1795699915
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-11-25 at 15:27 -0800, Bart Van Assche wrote:
> On 11/25/26 2:51 PM, 70sp wrote:
> > as I mentioned in the referenced regression thread I reported, the
> > patch I sent out was basically an example to show that it works for
> > my use case. I wrote that I don't think the patch is ideal (in
> > fact,
> > I think it's an absolutely terrible solution to fix this). This is
> > also the reason, why I just sent it as a snippet of code.
> >=20
> > Please take a look at the code before the regression started to
> > occur. It was implemented universally. These vibe coded patches are
> > horrible compared to the original code. We are literally making an
> > exemption for a specific CPU in a place where it shouldn't be. The
> > actual correct solution would be to make a patch which works
> > similarly to the pre-regression state.
> >=20
> > If we are going to merge something that is made by a LLM we should
> > at least make it good. Ideally made by an actual human.
> (+Lu, Jason and Joerg, signers/reviewers of the patch mentioned in
> the
> Fixes: tag)
>=20
> Is a better solution possible than the patch "iommu/vt-d: Disable
> superpages on Haswell with integrated graphics" I posted here:
> https://lore.kernel.org/linux-block/uJluFNYGCCrdvnYT3MatN_4Om8UczTJX_dzxu=
mJxyCAC7F-Ubrekb7LPwlRxhCW0J91UBf-TqeRoJQfgYIYBRvMsPmE-Qs1eAg5zbDP0s58=3D@p=
rotonmail.com/T/#mc147f250c5356e3742ab3d30ccf6b4a3a8c4196b
> =C2=A0
> ?
>=20
> Thanks,
>=20
> Bart.

@Simon,
To be clear, What I tested was the patch Bart suggested. Not your
original suggestion. We will still need a test from Tobias to make
sure.

Thanks
Laurence

