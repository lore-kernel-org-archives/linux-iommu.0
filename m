Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795649244;
	b=OIF8mrPasqIoq9UcjGItWal+NiscI7hooXK4xwbDdmA2JsLwUW/NuDA+4AiILs0phO0v
	 zRRABhdS1NuTY2G0lenByhFh89b2zmxjO3gwYganZQJsBZT+QqNjHovVpjbk/EdHBtvba
	 RfR6IcahGgHEWIKdJhDIx5KRlmZ0ojwAWU9UjKFIfaolQeHwePt9Ck6AlUiJXcCOdBaL+
	 hf1V3fTARmnI6A6mm4ZCSFy/lE1Jsm8TcTBX2c0gKXFL8vK8COp31ouHD/Wte9BfjZA04
	 z+BJm+H7Mgm1wE1Qknzmbq4U11qP4tAmgteBSNX0lwzmagKoxASPLMEScFutdBi60Zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sp9Gu/ag0sWDcDK/oXTqpJzOnSAhjMt/opO5ZXrPuXU=;
	b=IyvePjREfl69FBE3w4J/LvC5W06qD923j8/LhAn1TqaCjo5duMtAogsw8zYVLXwkpmih
	 btEHPxhXF8Rxh+TD5EESdJF1Yic2CXlQ1wNvaM2OIkShogw0Ca3jfeSE9aWUrYZeGqLIc
	 LcYeahwLAwKlDYKFUHKCo0L9MsVQBxbvbOqc8T4QLCfudQhT7ZXvqbVwwxVklm5WsdK1s
	 KKcf6104U4MJ5Q3zoGakiWL86Vctabo8dH2kyYmMIkzO0rvrwJN4EA5LgJ8T1xx2KF6gW
	 JA34QU9hsmj7Vg/hoWlBEV7ehJVWwUOMDOpQD0ZR+fQGIYTDXZrDKc8lpGlTyZrxQfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dSYgXelN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574B7606A323
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 23:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 574B7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dSYgXelN
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-15ea896ddc8so10606113c88.0
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 15:27:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795649243; cv=none;
        d=google.com; s=arc-20260327;
        b=lHsYm7KGklOG7Dv7nYfdHrwYRhtMxmambxkHbXMc8zxLxKcDuPnriw2IBGu4oUfEo/
         x9Ag2h7E56VBKpuMviNije24I0Irczmv/DxSytQyi4YkeQJKWolVx8tt5Kt4JccG7PHR
         b1qEtQXGJ1QGMxiwf8VzozP8yY1gfGOM35KdTfkvZ8xH5Ghx2q8Ef2T/hwvYXDT95YYQ
         9RWlJMiscHhlOm5+X1R0O1E2KN4ukq+/V/CWUM/6Npb7Gc38k2ZQa08vqRODHl4K0QFr
         +ms73yN/2UbVOL7N65/3GbonSJvsVuoXtmhI2rJShSzFQXFJTcgpedAn0x8sr4hzPI+f
         hUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sp9Gu/ag0sWDcDK/oXTqpJzOnSAhjMt/opO5ZXrPuXU=;
        fh=XNP/Z9vcCCFoPe0rBFNMVqYNfBut7goYYh7gKOTmpTk=;
        b=E6bwahGvNxOxmFlpRWXbtQjVDeAMlyKWhubNAeLFQhFiYXDl6MSYBJ6loaMXWydXYG
         DwoJ8f0k8D6f6FrL6jFL0I9fKLmjbaqAk38l5D0nWvDRSStuw4zlqmaCu9ugxcjtWjvO
         PztOoyE01zgbfYlqNhsnKgY3vTBz/uOgYmWwALlIoy+eTA0uV2ru7jey/x9+JCxY5rG8
         xmE9eV0amfPjay2MQlsb5bphUrJWSIsv45e1ilZQaURBXyMISrFVfTyDwfU0VKaD00bZ
         xS8f0+MSHgKE6FjvCiyuVrqAl8h6G0EzRk9KJ8jehH8Obqa5x1EJV4KZAe0X04OnoiAo
         uR/Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795649243; x=1796254043; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sp9Gu/ag0sWDcDK/oXTqpJzOnSAhjMt/opO5ZXrPuXU=;
        b=dSYgXelN2FtKtMR8fC4nw75Xr2Lrkb0Dpy+7hS+3+oD2fAghaxPGTO5uUYidBJN1WC
         OnAbS31hwXSlLm917Wn8x9fsiqlWuBrdBksp8Wr+SmqHfUKwEVU7ItLS0LNhrB8pckv/
         AY7rxAYLDq7anRPJSejeyoodoAN13yaZ3Oiy+ShjVFi2fV2Rw62me4CbaMdxV1aVFNJ+
         pugi4f6zkg2+Rs30ClLNiNU2z7ibwZQRJtTBWENJbkjqXbRvqk0Yax/IX+2JxCIV39n2
         QXHPtMOI3FlsxYSP+czej53lIKdUJ5tqIi3ummvG0utme22t2+SzlX0VuMQrKXKlrWiY
         QLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795649243; x=1796254043;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sp9Gu/ag0sWDcDK/oXTqpJzOnSAhjMt/opO5ZXrPuXU=;
        b=LEppWLUqYIrqhUv9wzkaxUnMunEd6Ecnha5ytNuFE9Y4Ln9R2/OkVO9qPhlE2VWKFu
         02S/curEE/2YyXD8/+x/Ua9/17tqIGfhBom0WbdvqV1xVOcXao67A8MEfoiS1kx7B3kQ
         Az9LPlElX/sUcPo0ETTFk3ntptdoGRUsyc/gqBnrDKn3mCaCiyfmQu4nlliAeK0hARd6
         Ym9aXSbu69YVAdUkQHD/H3xPJH3BO/B2Q0OHt1IIeiRlQvfMtPxKKBRulGyiUSvAfCgs
         8ux7KveBOOxHPVUbfGlyzsmJDQh2C3Fd2H1Ex63d54yFJLb6ST6/2cnUAeHiHJqYSCLt
         tN1Q==
X-Forwarded-Encrypted: i=1; AL+hErFGdAS2zYE0TJwI20YmqAOE6/5mE87V5GxMomIzs4JWalDF8ohrPljV1EJ6T3aE9Wd/5DsIlQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/endHfrhateZZKloQUXYv4QF5CzYHBDzn8vbKQYZLgOqTulgJc
	jPULyPGoR8SYLeKp+5+ki0iXtB1uZjezmHXaJME/XYH4ZIQINz/NWjGNV/87SrDiN0SHXOW3WYM
	NX/Qh7CvbW7qzLOqKhmYOJ1DQ12nFf5c=
X-Gm-Gg: AZFdTZds5yTUw6g6XsORiPeT/9HzG0j5j2tWY1fnxWjCnuDtse2+b8GnJ/tiRIQVmk3
	2siA6ZmcGIIxvSUJga782LyOO5OfFfIbN4VyMhEGUkyFwA4p7N7wwHOh62lHfXE0spVN2GCN/jG
	TNvursSaV69sVA8LxtvXCMVK/nXBffwMsUL+4qSaoOLFSQiwU4A0RaOuVO6Ij6/egkU5vFLow9k
	gqtqlsp3HAuMNcrZKY7RCGC4BBgZ5JtzC+OFxCmkKbzbWYt7CCy+qkwVeHXOy9Lzy5Z6U7X/OnX
	e2CHfxSP9gxtTSQ8GSosMRUXhtpuiOGLJJcDTEF3tYr3M92D3kwI2MZ6yN+wdXx+hqi6Zq6alXM
	UQBmlhkgvisE2/WdFshl6jL51mfy9k4yPYyYjE2109LceNRhBLwnOSINM
X-Received: by 2002:a05:7300:dd46:b0:385:7762:e1a3 with SMTP id
 5a478bee46e88-3857762e729mr18890931eec.24.1795649243401; Wed, 25 Nov 2026
 15:27:23 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261125074331.25190-1-zhangyu1@linux.microsoft.com>
In-Reply-To: <20261125074331.25190-1-zhangyu1@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Thu, 26 Nov 2026 07:27:07 +0800
X-Gm-Features: Aa3M54r4mxIQgvryDnL-qX8IuFUHHV-JKb0OjIRrToyrlQrT6deJuQHPpw72yiw
Message-ID: <CAMvTesDUqyoayJwGVRT93cF=mC876n+8fwvpPK9TVTH=8AjkyA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add dedicated entry for Hyper-V IOMMU
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, 
	Tianyu Lan <Tianyu.Lan@microsoft.com>, Mukesh R <mrathor@linux.microsoft.com>, 
	Thara Gopinath <tgopinath@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, 
	Michael Kelley <mhklinux@outlook.com>, iommu@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 3:43=E2=80=AFPM Yu Zhang <zhangyu1@linux.microsoft.=
com> wrote:
>
> Changes under drivers/iommu/hyperv/ are merged through the IOMMU
> subsystem tree, while MAINTAINERS currently lists the directory under
> "Hyper-V/Azure CORE AND DRIVERS" pointing to the Hyper-V tree.
>
> Move drivers/iommu/hyperv/ into a dedicated "HYPER-V IOMMU DRIVER"
> entry pointing to the IOMMU tree, with Yu Zhang as maintainer and Jacob
> Pan, Easwar Hariharan, and Tianyu Lan as reviewers. Keep
> linux-hyperv@vger.kernel.org on the mailing list entries so the Hyper-V
> community stays copied on patches.
>
> Suggested-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
> Easwar, Tianyu: please let me know if you have any other thoughts or
> suggestions.

Please keep Hyper-V maintainers also in the Hyper-V
IOMMU driver maintainer list. The Hyper-V IOMMU driver
patch also needs their review and approval.

--
Thanks
Tianyu Lan
