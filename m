Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665C1487AE
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159152; cv=none; b=NlOp54hX+IBc9i8CqDxtgMlQvCTgTBztmuIYc4Yf01NYlkGJrrrfC9LpgunG85z04E8VNyi4nDUWgmezSJRCv99TnIIsvqIiJgl8ZoAtNe7nHreFT2PLLgjUMlT4BMAIEt0bVYkx9ZnpnD8ad5N28RMORarWo2LGd1eoL8aFrog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159152; c=relaxed/simple;
	bh=2n6NEhyvuJ5E4qoevj89tVssjIMXhF/xuHE6hgy21vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVMFNTihy3KM0dRBfRL7brMShtS5zTl+zKkf66bDiIambdySgy4HLw37Ks/4AfStvUPWaa6/G4HdTEgaotvYSZNHDD9WMM8T5MXMGHDI+rOZTAVNvzkDIu8Ry1SzfBExgIDHMO75M6IFpEgTk9TgeGbJ1YK2V+kIsPzI+iIKoPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=iM39xAvf reason="key not found in DNS"; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="iM39xAvf"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42aadddeaf8so35458301cf.3
        for <iommu@lists.linux.dev>; Mon, 05 Feb 2024 10:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707159150; x=1707763950; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2n6NEhyvuJ5E4qoevj89tVssjIMXhF/xuHE6hgy21vA=;
        b=iM39xAvfg36OIYB4pPtI9IZezX0Mv4bWJ8LmWno9geG23ddzl5OYOmkz58zf5+tmQE
         p2jV1ebhMbIreg0KbeBlRK10bZOCnFvlxSfGIb/qLYZLO51b3C7l7/rYNz6giutp8qkT
         OxQchl5TKRYAUVw6r3BA+T5cdj/agSJaeViOeVH0aE+eLCjLSf81PUqBceld28menahb
         /VSh37Div9PVpqtTfIFOrdlVRgJHDIogx+QP9OdzY6t9xV9e2TX0ZSF3HVoXy/aeyWoA
         tuVf344UCoRZKuBbigEQh9gf5NMpGcfISMCD7fwhSbl01dUfoWhy+s96vhP7GlzG2Z+X
         RAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159150; x=1707763950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2n6NEhyvuJ5E4qoevj89tVssjIMXhF/xuHE6hgy21vA=;
        b=kviufMazSFX27AuuNNXev8cia3+Ec6+2nnvOC/afwkRfKJtox0840pSQiLM7DBmqcs
         m0ePKayicdfvU4TV2mt1lYLIk5wu2ymlUOiC9hySiON4Hu+zQhWquLdZ9nhfX0S56UNQ
         3UHPZ6kLEui4g5t+F9SdCv2WGZa5WpCX2pUSSK52wGW1RLdaP7rAp3EoFThE/i+SA1MW
         Et2YehRltc3O3qJ2UkQrEFk8eONw6ADh4zhlKv8BkG9AzmtPXn1CzTkNz621NAtzjzHG
         4QsJ27izKfZtAQ6IYcFEDi0/604KS4dEe1lnk0wfsN6OtrfeuSAmNzsMN2cJPbCWeU+f
         LLSA==
X-Gm-Message-State: AOJu0Yy8RVO+sQadZP5nKlKrxLy38Q03V+kmMkRQxpf8mG1yTCVpXR3O
	4f/TtW++UOC6C/ZCqS75Ancm9tNMw4F8ZfxvcJRqWAWPAtLRjIIG7QTC8bA2bogsbXSt8RtZ1gM
	sEDwJz2XqqJazCPj4uySV3WMny018LXM6V7SLtw==
X-Google-Smtp-Source: AGHT+IFxRoPhnX4DyHfg++GDzqZOWUaU4rz9EjS5TCdYAUo2klND3ypyEOGm+jgA5KG6nSjESvNT8+z3Yqb557Gbebc=
X-Received: by 2002:ac8:72d7:0:b0:42a:96cb:c726 with SMTP id
 o23-20020ac872d7000000b0042a96cbc726mr260946qtp.33.1707159149991; Mon, 05 Feb
 2024 10:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1707144953.git.robin.murphy@arm.com> <d4753562f4faa0e6b3aeebcbf88fdb60cc22d715.1707144953.git.robin.murphy@arm.com>
In-Reply-To: <d4753562f4faa0e6b3aeebcbf88fdb60cc22d715.1707144953.git.robin.murphy@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 5 Feb 2024 13:51:53 -0500
Message-ID: <CA+CK2bDFboGQD1YaZix7O_10F3K8bbxwXuJTVK40sNQWxmek_A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/iova: Reorganise some code
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com, 
	yosryahmed@google.com, john.g.garry@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 10:32=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> The iova_cache_{get,put}() calls really represent top-level lifecycle
> management for the whole IOVA library, so it's long been rather
> confusing to have them buried right in the middle of the allocator
> implementation details. Move them to a more expected position at the end
> of the file, where it will then also be easier to expand them. With
> this, we can also move the rcache hotplug handler (plus another stray
> function) into the rcache portion of the file.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
