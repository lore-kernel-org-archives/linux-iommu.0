Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40EE1C3F13
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 23:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872005; cv=none; b=e5wTtq9246TXgrW+MxauBk79V1Z02MzhLyQjddEukV4j6OR4sDapJeGOwYBMwsSQHbsPh8L5X0krvXEzofXzacRNcs1WWA2pVfStzdexGni3nm4jMB6BpV7/r+0YmQ8Pphu2MXhIFti6KUa8OJ5AKNeHmoA1iie+9u3KPwFI/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872005; c=relaxed/simple;
	bh=sVYXJXSzW6YUxCJsxxrtVnqQTqgEA8N5VXF4bXIS/Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKaOdjZsG8Y/+yb0qNMWHERUAs/+x1H0rwEbJeU6m6a3Dp/IpXp40gCan77hrUnIZt/WolcqFx4oXnT5ZFDMH+lp/AVYbpvNS8Zfm13/lRrIE2EDrd+TSYWpVYZvSHYoa19bsj2HnSXhFEXZZ/P9G4MEz4vcQYSCnWz8vIqfxrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=CrQOZmY6; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="CrQOZmY6"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3a0d2d15adso4152085276.0
        for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 15:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1733872002; x=1734476802; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqT6g0W8wBftvp6aSxR69K7dIiruVpolHF6yT66BzYA=;
        b=CrQOZmY6oVbeLIiRpEf6U7ZYGAwejvyLftXvJzIeRKKcVR3XmxIYe2bt3fy/v4Yegi
         htAoagULk8utVX6oL4Y6eDluhtpLV0kG2wNWim0AywbflOn0O1QUarKSjjRV+kPxtRPk
         Gsj5rdWc1RboRqvaKSl7QNvyprDF51fWfagROFmyxrov/maPm5Dniy1fhM7GRjVvAmhY
         XF1ATF+oFglyoqXSPCt0MOIiVL3jtZ5x2zPCKlPgNJ5ghKZnAIDvAFTGUF7YsObuQZs0
         HgV0RGNmWGqH04M3FtH9ymJ9XKuU6AR9WdA1krCWThZ5Rclnsq+YvBAIYXWEWJXHvqjR
         A9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733872002; x=1734476802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqT6g0W8wBftvp6aSxR69K7dIiruVpolHF6yT66BzYA=;
        b=MNtojcPw6iLg2hAkfCfoCQsilovHihm7XFk1KfQA++JQBe/+1TYtqD1OmKU2j0h3rx
         bOHSKrlc58aw2abH7i48I4BnndIf+UEIs24CDq1onkdnJSltRILI8RotERucJmRWpQQR
         i5Zw4AwGIxLSBsTuU328btU/ae4O2BislqpvYAxHfF0rXmvf9loD1JCNuRLXeJPqE26H
         wVV/aIlmQC6UgUDt4YzPT1NhBgdqW+QcVLfohriRvjabvruTpm1Nr8v0P+Xo3SYK31Wr
         in5zR0CrY0vua2ZiSeUbIgxbWAVJDhC56Z266W3NsMn8rMwyQHFn68UuqlVyWcZ67mnc
         u7XA==
X-Forwarded-Encrypted: i=1; AJvYcCVBgkvrbxBfMyhvfGywfHorfiTpf1rUjejqh7zL2CvFQmvrmDSWfAAlvqk9z4WzNKF3p3TDRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpxVOzUofgzg22pJowU4VV/gZup8fQo0KrQCVs+GBG2fApY6Rb
	SnT2G5u8p0J4gPfDuzjq8jS2DysFwkPqshVPx/zYa3sFgaR7fYWxirzuVpellvnnuvDY8Aq72jZ
	J+mYTSks5MuIuTd4wUdjhSy1bey78wxRjfHqIFg==
X-Gm-Gg: ASbGncvcNcz6teVRPHlvNa119l5BsJpuw0UtENpLpNBj9u9PvEnUH0DuwnGZo59X56M
	CowVeQbs4LINLybjzakqczlJWpHAsa2yVVbw=
X-Google-Smtp-Source: AGHT+IHDSE8vWTo5AI2GRtvcRlxTgl5Sv9MW1qFpKY2BPLTbrUME85VaPcnBA4mMZTf7UD9AjbDzT6zqXJ7grktQ4+s=
X-Received: by 2002:a05:6902:260c:b0:e39:8f3e:30a1 with SMTP id
 3f1490d57ef6-e3c8e645ca4mr949108276.46.1733872002729; Tue, 10 Dec 2024
 15:06:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJ+vNU0EL3T+GyNAbVbGqYYQ5NM3h7cgAwqxxBMuZjh+-YQ3bA@mail.gmail.com>
 <1b2ea8b2-6fbe-4118-b6c6-742c8f0be476@quicinc.com> <CAJ+vNU1-OZ3y4p2L+zf64AiVtUv70yZNqkT20jTxyE0_gJb6Jg@mail.gmail.com>
 <0282be95-9094-4d49-b79e-4f7c976dad00@quicinc.com> <CAJ+vNU32EMHjtchJRb1sODBrUKG2vZW4ZEu1_F0+dCCEjCn7Dg@mail.gmail.com>
 <20241209081714.GA25363@lst.de> <593c0d63-d8fd-4439-a57a-97340212c197@arm.com>
 <CAJ+vNU2ypE_Mn_6iKCmf5LYk9Sth=ryWXyewc5MhOKK8VoAKCA@mail.gmail.com> <20241210041133.GA17116@lst.de>
In-Reply-To: <20241210041133.GA17116@lst.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 10 Dec 2024 15:06:31 -0800
Message-ID: <CAJ+vNU03Cqsc+O5anwmvJW8Wfd-06LbDMVHjxVFdixf01ZLczQ@mail.gmail.com>
Subject: Re: ath11k swiotlb buffer is full (on IMX8M with 4GiB DRAM)
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Baochen Qiang <quic_bqiang@quicinc.com>, 
	ath11k@lists.infradead.org, linux-wireless <linux-wireless@vger.kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 8:11=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Mon, Dec 09, 2024 at 11:15:02AM -0800, Tim Harvey wrote:
> > After a lot of back and forth and investigation this is due to the
> > IMX8M SoC's not having an IOMMU thus swiotlb is being used and ath11k
> > is requesting some buffers that are too large for swiotlb to provide.
> > There is a specific patch which added the HAL_WBM2SW_RELEASE buffers
> > to cacheable memory that could be reverted to fix this but the concern
> > was that it would impact performance moving those buffers to
> > non-cacheable memory (there are three ~1MiB buffers being allocated):
> > commit d0e2523bfa9cb ("ath11k: allocate HAL_WBM2SW_RELEASE ring from
> > cacheable memory").
>
> The combination of "buffers" and "swiotlb" sounds like Robin was right
> below.
>
> > The chain of events as best I can tell are:
> >
> > commit 6452f0a3d565 ("ath11k: allocate dst ring descriptors from
> > cacheable memory")
> > - Nov 12 2021 (made it into Linux 5.17)
> > - changes allocation of reo_dst rings to cacheable memory to allow
> > cached descriptor access to optimize CPU usage
> > - this is flawed because it uses virt_to_phys() to allocate cacheable
> > memory which does not work on systems with an IOMMU enabled or using
> > software IOMMU (swiotlb); this causes a kernel crash on client
> > association
>
> And this is where it started to take a wrong turn, that everyhing
> later basically made worse.  If you have long living and potentially
> large DMA allocations, you need to use dma_alloc_* interfaces.
>
> 5.17 already had dma_alloc_pages for quite a while which was and still is
> the proper interface to use.  For much older kernel you'd be stuck
> with dma_alloc_noncoherent or dma_alloc_attrs with the right flag,
> but even that would have been much better.

Christoph,

I'm not clear what you are suggesting be done here. Are you suggesting
that ath11k has been using the wrong mechanism by calling
dma_map_single for cached DMA buffers? I'm not all that familiar with
ath11k so I can't tell what buffers are considered long living.

Best Regards,

Tim
