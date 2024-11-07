Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E2121216F
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987249; cv=none; b=S5eG8yJ6kZemrohRYHVntRF+boYLu9vNNgtRePvzaUcQM4VPDUV21E2LntPqVS54zxSSNk9ZcCH07rNCZSCWZVNt90iEshvr60GGZKAdLLEuNjt6hMXAXxFr+zILeMidbqsGl+UuFyUdlMgt1pfj/CLozOtmJg/8+DriYefT6ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987249; c=relaxed/simple;
	bh=RFk3924VrW1xb5x1DFkPBcmjcDaZmpuHPPQS5Fg3iuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIaBSSZMc2UGH+wjHPqy8bM6GkQssj4VCFhQ1rMenJO+dZilOeLyfGO+vQZPDhLFNCAVjJExwz0/VXAV1tXdVInW7PFcBRHK7FSSQFjL7Wd5rQKFz5yWb8UyvmfizLik01YM/s0ElAxKLwgDIO1ctZHblBC4YfrFqemCX9vh1Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ5c0U1p; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ5c0U1p"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso11127811fa.0
        for <iommu@lists.linux.dev>; Thu, 07 Nov 2024 05:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730987245; x=1731592045; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0on35LMoILRFRct1tStDDPXY9cyBuAggEZbNv9uoPFU=;
        b=WQ5c0U1pb5CK3GG6YoyO0ZkVzCzzTet4xkiLTYqBDcu5PpmI/veBWJTKiMBLftQu0i
         nggRoD8WxqTjeqshGBAgQCkKxKBnIfsozYaF/mos1oLjUXGAEEk/xh4dULdGWs8ZlZo1
         eZKdI7lpkjwLCYphCjHlLe6MfL6cT/JnlbSlFiOK0OMYbmfjDIR38XW6RXWgCWj178/K
         kTLsxEf2HgUtlqz+tECD8S5xac2zsSNwKW8NMhDY2m5v5QZFKcvPd3gd1eoGMulnckOk
         39yWjPkERs+zBFG2EUb1OpGits6bIKZPjlCiyoUgoXwWwOxjQejuQsnPBxBiCrClbEuR
         jQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987245; x=1731592045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0on35LMoILRFRct1tStDDPXY9cyBuAggEZbNv9uoPFU=;
        b=XYFDYoAT9vz5GwW8OAecVWDWCKkMIm/BBxIvrvyUreRu4/jUnN3bm0hkoP1nAEe6CH
         1KaRVkODoFRznnpQpY9JwIcJZrkAlScw/GF2EegNqfYyE+vJRQVWSoEEsvKyGgbG5cub
         x29DfJPE0XjDV2RW4RoZVCHpPAGXJgBrTnYe1oOSC1qq7+WJXkHE1NndZaTPrrrQIFzM
         YAFoOscZrnxwkerbyJTDxSxt0W4NR+3EQHRYpcxQu/p4B4HhiyM9gL00FR17Gb06j/pb
         9vew2RkuSUq6mKIqh5Vv31b8cN+9fHYsnhY+K/2ZpgQMBTYpzGOgxGbHBszlx1YGj8VZ
         S7DA==
X-Forwarded-Encrypted: i=1; AJvYcCVU6Tv6hl7AQchuigZmZes9UU+OeHs4edxFcitfrFF043xAn8PpxFaji7spkHfZjHnWBvjHeA==@lists.linux.dev
X-Gm-Message-State: AOJu0YypymDG3D+3nJL4ol6U+GM4iMlza/D96jTcxjnCzq63ciueQfBc
	QeFI4jKxypq4B4q0Sf66rnuw3YibiO5WOaAz4DSMH1HSeOHFZxrqADVKvk9XceXtb8tfjRwmiUT
	2Ygd9FIPBXcPIeCS63BMRqgMcso8=
X-Google-Smtp-Source: AGHT+IEFnkyx9mt/m4+C/bADWUR23kL5+W4hrTa+9//vSMQM1VLtLBdN3fRu+hcFzKzPTrZcZ/NxVbPCE/GiT6Q9ONA=
X-Received: by 2002:a05:651c:220a:b0:2fa:ce87:b7da with SMTP id
 38308e7fff4ca-2ff1e980065mr36591fa.18.1730987244974; Thu, 07 Nov 2024
 05:47:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
 <20241101162304.4688-4-suravee.suthikulpanit@amd.com> <ZyoP0IKVmxfesRU8@8bytes.org>
 <323dcff2-6135-4b8a-85db-bccc315ddfdf@app.fastmail.com> <CAFULd4Za4BQL+h9Xmra1TjB2oGGzPwru_y1xOrrAFSg==bfvgg@mail.gmail.com>
 <20241106134034.GN458827@nvidia.com> <4c9fd886-3305-4797-9091-3f9b0b9ee0b6@app.fastmail.com>
 <20241107133725.GD520535@nvidia.com>
In-Reply-To: <20241107133725.GD520535@nvidia.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 7 Nov 2024 14:47:12 +0100
Message-ID: <CAFULd4YDSRzMAvxunw=vfC-jw3xHPRjg=+X6mDONUXSSnU=7Xw@mail.gmail.com>
Subject: Re: [PATCH v9 03/10] asm/rwonce: Introduce [READ|WRITE]_ONCE()
 support for __int128
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, vasant.hegde@amd.com, 
	Kevin Tian <kevin.tian@intel.com>, jon.grimm@amd.com, santosh.shukla@amd.com, 
	pandoh@google.com, kumaranand@google.com, 
	Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 2:37=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Thu, Nov 07, 2024 at 11:01:58AM +0100, Arnd Bergmann wrote:
>
> > >> and later:
> > >>
> > >>  * Yes, this permits 64-bit accesses on 32-bit architectures. These =
will
> > >>  * actually be atomic in some cases (namely Armv7 + LPAE), but for o=
thers we
> > >>  * rely on the access being split into 2x32-bit accesses for a 32-bi=
t quantity
> > >>  * (e.g. a virtual address) and a strong prevailing wind.
> > >>
> > >> This is the "strong prevailing wind", mentioned in the patch review =
at [1].
> > >>
> > >> [1] https://lore.kernel.org/lkml/20241016130819.GJ3559746@nvidia.com=
/
> >
> > I understand the special case for ARMv7VE. I think the more important
> > comment in that file is
> >
> >   * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
> >   * atomicity. Note that this may result in tears!
>
> That makes sense, let's just use that and there is no need to change
> anything here?
>
> Uros?

Yes, preloading "old" value for try_cmpxchg loop does not need to be
atomic (cmpxchg will fail in case teared value is preloaded and loop
will be retried). So, __READ_ONCE() is perfectly OK to be used in this
series.

Please note that __READ_ONCE() uses  __unqual_scalar_typeof()
operator, so at least patch at [1] to teach __uqual_scalar_typeof()
about __int128 is needed.

[1] https://lore.kernel.org/lkml/CAFULd4Z86uiH+w+1N36kOuhYZ5_ZkQkaEN6nyPh8V=
NJth3WNhg@mail.gmail.com/

Uros.
