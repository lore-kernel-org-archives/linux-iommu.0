Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A956036B075
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832728; cv=pass; b=pIYthh6GYspYq77R8Kk3x2LFRBhtm48K1mCXDZqbJV/aOTjIwBHKQiA13ToUCCiUe4nO/UZ2eNnR3Lh/bAuVtuNwRJCG1jAj6cHrifeV0lD9B764Mf/L9f0n7GZJNbxMAcUpkAwbN2vMSICWOxkE+Xau4GbvSZkKDMgpZ/Z8DSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832728; c=relaxed/simple;
	bh=yWfpM57Ov0hDYx5aY7CnSscsAijAfja4kjPeN0VMSfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuIivJv7v1bJR+TBQqJ+cXuPXysysIuHaGWLl9vGmQkTjKXW6DvAqUFivPTwApeIxO6a5JoVH+ctyF5d8Ew0rOgmiW4XhIwkEV5p1IaOr8R1C/8gghr5j9i7SztQ7YrXNG0JcJYOz6w/rRWt0LQYyzw2sM0xEmXhAlbWcDAo0L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qSLt+gyA; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSLt+gyA"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6505d147ce4so11119a12.0
        for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 06:25:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768832725; cv=none;
        d=google.com; s=arc-20240605;
        b=hPUM5oUlkAtoXtc9Cb/FSzJ4TccT0SA35fOjBhKqyrvx8eUiy4E3VDq8SVubHPI8QC
         fvUn5mwarInI8b4lmQbEn5OU+YIK/Hb0dF+ALzmnPkO3XX9mC5vzCUmEbW4i3UqG1uz9
         WzQQDtc/6aAIFv9nf9cDd+8L/5z1vKBKsHG/gjRufxof/kmJHOtjeZc6BMI7kXc8oij2
         8iNPhdmHDGcuU7fwxrMr4RkQVVpYOg97ukMZOP1C+Bu0mJisxAiuNTkSsZb+jYWsNcFZ
         o6OLl8G7kG0Jo84H227zN5AAYF95GbyFUgBo+Smj+1Br2mkfVuqDD3Jua3vSMJrdDQ8n
         lLUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yWfpM57Ov0hDYx5aY7CnSscsAijAfja4kjPeN0VMSfk=;
        fh=EElHUopu9NVn+Bg/ICSmGy6x8CgzX+fh5hU8bq0UGTk=;
        b=gWqd2KFQQveeT29KOgNwCSNsFfinyKtdHuRlmLYa48RZ73yaagel+Yt2R6/vJyQ5iX
         u5Iojv8OgHO3/FUT1veWdim/GCWrp9cr+do+X7kW323hO92ng0d+KhHZw8Y7ACZ9AEDi
         sUWrObVaI5iNRR8s+iYKuJGXsMdKtBoBvNi03TPduW4ldOQ+sDcdlMa2lbdGF+RBtiu0
         uhglDo+5dFC4FQI/v9PVf10xnwACADts0TZmFtOr2G3FV+bGpH4V/MG+j3SuPKB5CgcY
         f9EMrRgUAXFuMPNzFhvQtC1NmD6nhhrfHLFfHowROFwQzAeVmKq4a7eFf6qPjsuC66iH
         kM0A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768832725; x=1769437525; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWfpM57Ov0hDYx5aY7CnSscsAijAfja4kjPeN0VMSfk=;
        b=qSLt+gyAlMc/phqzHqlzBQ5jpogXFTC4UfcBwsaY3+rJA2zZKZXMXnbtRdH608JQCx
         fcPcTMU1HyHSt51TDq2PEkK7DewgCQdog25WrpxswbeR9oHARyCEq+HooMigy9+HqoNr
         3KlcUVMQE3zZsTg13b1k/8TklBzGDh29B2mwflM3DCqj+0t/TrnkDaRhl2It5iV54V9C
         +Q2PrtWhufAlj4XDbwfmbne8vhwLjQX9XMbrvX3XlDjmQhlj9V87dz9k4x8njD2lM5oY
         j03HUVDVEikpufRsXgoI3R7xC0KE6ROEcKoYSEK65mEh2UXNtBWETJNy7qKeRI7E0BJl
         HpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832725; x=1769437525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yWfpM57Ov0hDYx5aY7CnSscsAijAfja4kjPeN0VMSfk=;
        b=XbuTb3VsF/6OuQIKEn8nbwoEKQaEVy0HRHSZXh9kjSKHmDk2v0kWMBaKp9bVo7Fx5p
         gt5hxZNa7s/bM/RYnDOI0kv1lu2A/B7ncku7TKspqp7ZwDpYPpX4gWfFDEVfWTXVwZI5
         SstUTYcV+HVGMJgFRxlgV+rXk+JQIZbO1dbjZM5XXo+RjP0gJQZ6bwQwmUIJ7Qo/vpMp
         VJdTwfi8ttzNiBKPdBb941z8VNDa2zAWYyeUpwNPbEUrUK3PR2/lesi4uys3Few+Y8HP
         8zRRK7/6+f1ujZMJolFJ9InyrsEyceYNa+iLJ/Akut3/NhlwNIqMnFUyvcV4utYZT/oc
         Mk4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvqgTFy4tC+WCxE+osg4tivl96vxtVuc/TfP7DRZtvzXDXP2MTNs2uBSKcXlYW4kJGX4rwxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxczyHI2ld3w2sP6a9Wz9ZuwsuwHvnWK6j0QAzxfLuWq+5lp/B0
	d42amue5VE/yXOjUYkKSHEuj4KXP3UGaXrTAhYsWsEPtAobZZBN+plKu+Vc1EhGBvaOupa52NV7
	StYgYkmb9wSf6H50P95ERV2f5izideNcq8lxrKWR0
X-Gm-Gg: AZuq6aL5vao3170WbzN0Ve1fRwaelZ2dRp8Jsv9YhnaySKqIy3cwlCi/gSUjs8wFyXK
	AIVJ5N4hMpvEGnGtPcJlh8+XBO5IKnDeOrDSXZA9a6N10FT6NWncl3hiq3N6HTm167TL4y0yxgJ
	3ng++tOrQpoYodIORkvESwDmzVKYVIiEgLdKkvfRkq5KCE2ZUQp4az108wUxaP/iEM75DfqMW1u
	sqSTqPE5auV0O8h3ePxcyCK2OiWbVLWAZVkMER+DIoYHL5Juy1hNNtXWxOs7KuIoVpix48=
X-Received: by 2002:aa7:d914:0:b0:645:21c1:97e1 with SMTP id
 4fb4d7f45d1cf-6560b37891fmr63399a12.18.1768832724914; Mon, 19 Jan 2026
 06:25:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260114164322.787125-1-smostafa@google.com> <f3ab0156-3d7c-470d-9c1e-922195ea27af@linux.intel.com>
 <CAFgf54rVPaUgbouXWQkczCyFQvXkrei_x6FYY6n1X5NkSSwYfA@mail.gmail.com> <aWos4aIxKpqWuHoK@willie-the-truck>
In-Reply-To: <aWos4aIxKpqWuHoK@willie-the-truck>
From: Mostafa Saleh <smostafa@google.com>
Date: Mon, 19 Jan 2026 14:25:11 +0000
X-Gm-Features: AZwV_QgGzbNYGrxymBlNJ_B6_tKEdbujc-QXDCatHQBzV6r02BmVWWZUnnYdT0I
Message-ID: <CAFgf54r+RW0ot2Pmv6z6yvb90ADheWeRkxDsa503vOw7nXpZQQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
To: Will Deacon <will@kernel.org>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, linux-mm@kvack.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, 
	joro@8bytes.org, robin.murphy@arm.com, akpm@linux-foundation.org, 
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com, jackmanb@google.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 12:19=E2=80=AFPM Will Deacon <will@kernel.org> wrot=
e:
>
> On Fri, Jan 16, 2026 at 09:08:42AM +0000, Mostafa Saleh wrote:
> > Sorry I was travelling all day yesterday. I see Jorg hasn't done the
> > pull request yet, so I was hoping we can still change it.
> > But I can send the fix separately also.
>
> iommu/core is a stable (non-rebasing) branch, so patches on top, please.
>

I see, I posted the fix separately in:
https://lore.kernel.org/linux-iommu/20260119142246.3821052-1-smostafa@googl=
e.com/

Thanks,
Mostafa

> Will
