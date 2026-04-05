Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCE82C234A
	for <iommu@lists.linux.dev>; Sun,  5 Apr 2026 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775410803; cv=pass; b=emrhgxwb9cGK5gjHRNhoL0G2iUlI3eZ0uDL4bdZBHOah0AVhev53H51PnXvaMcqpQ3CW7BpLsjOE+x7CWiaCg6y187w7SwI8HucXR/xxOouhKovSlwuVSBOGRtU51fXn2vfMWD11RkSdKMMTMVI7rUiZi/LOnMfEA08RicKlhtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775410803; c=relaxed/simple;
	bh=HPsLt/BA7weGZLf0EXmME6ubSVLx0GGTj00O/QCLtvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PisNXZ2U1UWsIOqELrmb7BA4BgmhZVBrVKzdF7/1I4ySgRUMtKISKXdLrtaTVeuEFzW1RvCTj3UHAWwdAKV7JynHhjg6WA5T571jdIH4Jm1ZMAqTe58KUPTrcmRkVDif1hs9+UleM+T7m5eLGq2eQCuCkqi1pDw7BDnPuSONc0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jV75TeBQ; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV75TeBQ"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-682baaa9f1aso491868eaf.3
        for <iommu@lists.linux.dev>; Sun, 05 Apr 2026 10:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775410801; cv=none;
        d=google.com; s=arc-20240605;
        b=E82buumAX/l4A8Ee0f4UvhVF3ZXzh69hGwflT/QMU6wq9NZ/R/GFcmUlXkTKgtz5Rw
         xDNxJ4dos9vApBfP0ptpnSRUraQbnAoAYMwuS+0J3ySlzB/Ar4V3n6/Xx9caXKqDu7HC
         ALy09EQc4Uo1V7vFyoYv59iLUUEKzEF5+a8WxCRKJBJBLIB/4A6YU5ib1yvWhkRjHWhW
         aQIBnSgkAxAUFNSAtBjBdUdv/naFNs+LWeHc10Rno5UcuS/Fk8WwaXWUqb9TzaGYmocc
         vdoV3ho/87Cnu55hIiDunfKuQIrp/IMYizysZ9K6yd1LhzU5knIjzVILWXUxuHnzgVZs
         HaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HPsLt/BA7weGZLf0EXmME6ubSVLx0GGTj00O/QCLtvY=;
        fh=CTGwdfOi2+Swx3J9nDkCn6KkiEPEqKvYc+l8+Dz5dP0=;
        b=TNYB79ecVlzuCb46w4SsRTvvtw6xlK+tK787K57Sum0Zt5CPlDwG1wwlXhr/5r0ih3
         MdSSen2DhVOVAoPxofg4eKkxV4K6gOVUUL0pllsQht0RVhZTJbBbRf9kzR6/eH29Q/GB
         Xn6AZ2qysgNZ4xLf9sDVhAJ2eSzuBgncH9PPIOce9ddDLySF6rZsMoz46Oi48YkaJSBf
         Nikq9cfnV1a1TLxvPY9Zz2A3ergtEdj4GKTYOPTFZttQ/5OwEFWenJKhLNwA/KtF8423
         tGjYM64TbG3OatvVxwV7OVyyUPboHt7PHg7JuJRsLa+kEY9v3BBuwaf9kB0ke5/y60ut
         AHPw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775410801; x=1776015601; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HPsLt/BA7weGZLf0EXmME6ubSVLx0GGTj00O/QCLtvY=;
        b=jV75TeBQ2+pKJlTm5htVQ3TUaAKnByxm/LlWf+34B9GthuUBnnG/fjoqtBLRX76BLy
         5a46MXAsn9Mvl2vv9m2GiQZWZaX5xhyVjDLoDeuLcqM6Kp6W3E1fS3TBOcyZVOH1RUvm
         l4lJPV/l/jDZi31SHluM76jVVozJh2Tl8GE44pV2+5SfFzEKt1M6hoW4aJYTZIoE6gWQ
         UwZzhs6r3bS91P8KgAjdOuG16kGP9SHVddQRKOyShpnUQ0Qhblur02vTMYVoNC6e6g51
         YKmLviqHZLz8Qg+Gig4o/DWe6N6Li+Wcu6aSO06osdvaC0JvRJT3B81M/V5j/2V1OSKk
         jibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775410801; x=1776015601;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPsLt/BA7weGZLf0EXmME6ubSVLx0GGTj00O/QCLtvY=;
        b=jEnfssGNJvlzDYJWVoRiflkcEpr5eMKbof5I4jgd+53vEg5EhVsNrgaFCjdJcA1Cky
         bAk6fzQg+KoiTN1xZ2Rf1jnUGg468wUBES5zds2lZL5It8bkgkC3ifq3yEVwRYY4AJ0P
         tmRYU8O+eBJgBBVmzSWargGJmCFh9nx2C7rea4amRkjwNaSzRFbHpgMGRas9XxAC+Pok
         9ygTbVUlhaAlWudHhaDXLTH34T87NWO8fNUbQTHi7O9pH84PspmJu8X4O4scF0wBY4e3
         b9y4g0z/TI1yQouw6IlMJKLLekv34zlFvOiC6T5o8KKsCS1vK7Magzmgb6o9PF8RIlEE
         YzgA==
X-Forwarded-Encrypted: i=1; AJvYcCWQzSQXoyaJn31Ko5ig8jCn6XwzrYUw/4BUpWfAC5DuOWUqdTfRzuAm8gSlDQ1XpJlvYykc1A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/u7MUG8a/XFN9fY5YSz7zJE9dJzOILWSGS5H46EsDgOj57K0j
	x1o4jCqewjGWzoin8rtciYc1GuwOQt5Ti5mgwjXdi42BzAIK1xo/o0o0jXUu47oOUjxVI2183tT
	UYSXBVFZNrlAR8GioOFRv/hNZVbQDQqQ=
X-Gm-Gg: AeBDievqf7/5c7MdXi+BaTQm8ckbGEITcrnCRplZnYqZVk2vQrWTTIiVrXKYZtCvyg6
	+qhdKvpLAWNV0A95chrmeSO85V4THeVyJpvma6md+M5viO0F7qFXrqhMoTT6ztyxEGeZl5GJVZ+
	qKsLwbCxnW+Z9sOjnuCkjLLkUvpFhCDDchqj1uKo8T/op+B0ehmJviW2gV6zbFLyGmT30eLUIk6
	FrMRcECP0bm2pesgW30q+KcqiaDJs6MtmA0pe9FD2rblTa4lhMELz/nFahLRYn5q1SK96cFxF0P
	CoII87g=
X-Received: by 2002:a05:6820:1c83:b0:67e:42ca:bf0 with SMTP id
 006d021491bc7-68220d45366mr5394961eaf.39.1775410800634; Sun, 05 Apr 2026
 10:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADvBJZm8nqbpNRvB=WheP6QhWDXMbtcKff3R7F93Ffy5NBOUWQ@mail.gmail.com>
 <CADvBJZmWHUX_3mtFBU8AQ_C12Os3TSRYD0jjRb2p2755-qne6Q@mail.gmail.com> <ec71ed01-1ec1-4e3d-9724-a51db8e10c0a@leemhuis.info>
In-Reply-To: <ec71ed01-1ec1-4e3d-9724-a51db8e10c0a@leemhuis.info>
From: Elisabetta Bruno <artisticdesign@gmail.com>
Date: Sun, 5 Apr 2026 18:39:51 +0100
X-Gm-Features: AQROBzDdA5Bzt5K-zmMbC6JQ7cZBEHvc4eL1vFEHFzvuoFBQwhdnKvYvDcuaKjQ
Message-ID: <CADvBJZk4atjZHTGJjnOkaJkGXaRRT7CAoNxmgaJRewikvKNXhg@mail.gmail.com>
Subject: Re: Re[PATCH v1] iommu: Skip mapping at address 0x0 if it already exists
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "lkml@antheas.dev" <lkml@antheas.dev>, 
	"Mario.Limonciello@amd.com" <Mario.Limonciello@amd.com>, 
	"alejandro.j.jimenez@oracle.com" <alejandro.j.jimenez@oracle.com>, "dnaim@cachyos.org" <dnaim@cachyos.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"joro@8bytes.org" <joro@8bytes.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>, 
	"will@kernel.org" <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Apr 2026 at 18:14, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 4/5/26 17:02, Elisabetta Bruno wrote:
> > On Sun, 22 Feb 2026 00:50:50 +0100 Antheas Kapenekakis <lkml@antheas.dev> wrote:
> >> Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> >> introduces the shared iommu page table for AMD IOMMU. Some bioses
> >> contain an identity mapping for address 0x0, which is not parsed
> >> properly (e.g., certain Strix Halo devices). This causes the DMA
> >> components of the device to fail to initialize (e.g., the NVMe SSD
> >> controller), leading to a failed post.
> > [...]
> >> Closes: https://www.reddit.com/r/cachyos/comments/1r5sgr6/
> >> freeze_on_boot_after_kernel_update_to_619_fixed/
> >> Fixes: 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> >> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >
> > As I am seeing this still marked as pending fix, hopefully some real
> > world testing might help.
>
> I lost track here, but from a quick look I suspect 0a4d00e2e99a39
> ("iommu: Fix mapping check for 0x0 to avoid re-mapping it") [v7.0-rc5,
> v6.19.10] fixed this;
> https://lore.kernel.org/all/20260227080638.208693-1-lkml@antheas.dev/
> and the links there have more details.
>
> And if I'm wrong, please yell!
>
> Ciao, Thorsten

Hello!

I hopped on my secondary drive, fired up NixOS and put it on 6.19.10
and it worked without the iommu=pt workaround.

Sorry I missed it was merged.

Thanks for all you Devs do and take care.
