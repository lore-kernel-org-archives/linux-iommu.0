Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB5927814C
	for <iommu@lists.linux.dev>; Thu,  3 Jul 2025 05:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519298; cv=none; b=Y9z1aEAmateRaQdcRFIpreIlFyTYMwUSr+L284Kyj+C3KDlHr2VsrtOaqRZ6rkyyl6RWXtM5mmogeBbuu5Ii+G2V98WYDgKpYRitCS0YHVjG1IU/933zJ5iSq1zc7fUD0GTiKz+OrCnz8+23iIvi311rNuaiw7ybS9JV6IsiYzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519298; c=relaxed/simple;
	bh=rxN3oVC5R6PZQEsqn9rQsTDCvAKhHeM1OUBg07edHZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJj/w1X/h0BZKTC5fLU5tWX/YCtndbWlBOOJnBrZUwOaiFUHzLOvdMkmuVnFi1dNDrbV05/LVLMB+ek+JyF23teZ8Q1D1w2bqRQ1yu91mjSkMZrIaaFAqDjQUt3ddRwtQCL7Nzu7F62247q0yDxayESPQTL3+U3pJUQFs9sg1lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcraVxFr; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcraVxFr"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae361e8ec32so1132495466b.3
        for <iommu@lists.linux.dev>; Wed, 02 Jul 2025 22:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751519295; x=1752124095; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FP+HlsEPFU6TIdf3XDKmfsXJvNv/Rh2JlketkdKIzzE=;
        b=JcraVxFrdduBRPys+ALn/pGmzMjYQ25VfcHPBS4rrCGLCwoQW38oLQAGEap9N4Jb77
         3nmaO4ImRtFyjwWLpC2s0RBgNyHrxAR3djya4K45EGx+GL5uMiahkKmFgVL6PVeWqFS4
         MUCRX0+kGZK8QYfRRSAqFSrfvRKMDBx5fOKp5b1knWgnBT4lISun6Y08FYgEEu1pP1rH
         HEsQxO4zMOY8kfR8SICZqfIIM+NJvGHV0M2wD83pZ+qDYKPvYuuiJ7mbd/MehSDEUbSF
         fjFe7IXoDsg2j7/dBz1yqpFwECRxA+QCEZ3KXPPnA6kczDtnEyaKi6t7PPJVzX+A6ZtE
         ki0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751519295; x=1752124095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FP+HlsEPFU6TIdf3XDKmfsXJvNv/Rh2JlketkdKIzzE=;
        b=PU8s/+8Mrr/OlRAs0b+lC+ATbXjOIPyBfutYRyrZ1q/MlLY6ttB97gyncZdhhri8d4
         M/+DOU9J2EdsyEX5T7Y/awRU22o9u2yUL6Tavc0ZvLWwQd3OIj5CFHTbEthVRMKHAjWT
         1S6qKcebITdvVB9rZt6WkFpdU8444yzvghZwyyzXra+vOZ5HhcYsTVSBs3OQn8SDamL7
         yV9eFDJtOWiPTEdHr2ODhyt2MbFQcCu8N+LSr7BwZq5NbAA+rOU4O4C7cDKFS44dceNF
         QAP+SKgFMQfTsqctWN+M/3gWZ+5KaJfBUjDkGJvOOe6SLw4to02uDv4gzblfnjS8asLs
         9Tig==
X-Forwarded-Encrypted: i=1; AJvYcCXUu1Da4qPq7ZdRDPkQM7XughQumxHflerd+5g3x3lQaX6SahIkmZcH76WwqDiqVbKh5hyvrw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5KiwJfmyyEYNh8Fewl4FppoCJJc8WfUa1yXFGXX3MlMINER5m
	MBJjtbuXSkBkBh1CeArwiXAg1+5vxPMmWrWW2NJGM5ZZWdqs5OOBqIf3cUyAAfaecjFdcBH2x3G
	pPeJtkzzekvOC4UJ7TtA1ls0CTxc9j+Y=
X-Gm-Gg: ASbGncsVzwBvkG/RPKLysa3XQGWnsRsHy6wrL1j2Yj7/UUMG1t8jWYeG79EXyPu/9xQ
	H6NmuqtJSSYbECWf9/cC8ynSYKEpTtn26/KRh5VzMrSStbcB4oZwrvSMvk7eFGnzDlRfuHE162p
	HLoHi0BUs28EWwQe+IksTsLdTSpn5MDuHszEaIomIPdjvXTstiL84Brc7DP/EgVdRT6HChLr2TZ
	g==
X-Google-Smtp-Source: AGHT+IHFCdTi82wSUFoZbKhu3bgAxXeueg1CfXdZvxduIvqNncAFIUlZiFD2Q1YAOOrKv5LJWEyUWu4NAZfOJM0teAU=
X-Received: by 2002:a17:907:7e5c:b0:ae0:bd4d:4d66 with SMTP id
 a640c23a62f3a-ae3d8b75196mr153106666b.27.1751519294947; Wed, 02 Jul 2025
 22:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
 <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com> <fd3bd8b1-4108-445a-b65f-4769d73e6e63@arm.com>
 <4a13d862-1bbb-4a98-bc1d-219bf78f7c0d@amd.com> <CAPDiVH-kVCUY8DKexT9OqAZsvkZ5_CGo8d8nENYA-kD=s_x8wA@mail.gmail.com>
 <e008afed-819d-43eb-8895-2c7aaf24ec13@oss.qualcomm.com> <CAPDiVH-xPDmx-KQx7YJY=7+kwJNbGY-rEu-w+cz18p=kjnKFsw@mail.gmail.com>
 <979be2a9-9d0b-4382-8519-2f6fbcac5375@oss.qualcomm.com>
In-Reply-To: <979be2a9-9d0b-4382-8519-2f6fbcac5375@oss.qualcomm.com>
From: Matt Mower <mowerm@gmail.com>
Date: Wed, 2 Jul 2025 22:08:02 -0700
X-Gm-Features: Ac12FXy02ncWee8Jpm5jJeudHeKd8QR02xkANsyNNiyukI5Beylq8Po2B-owL64
Message-ID: <CAPDiVH9Fi3Rw4K4npHMAEcOPMj=iFMEJOyhn5cRaq3+9kBYNZA@mail.gmail.com>
Subject: Re: ath12k_pci errors and loss of connectivity in 6.12.y branch
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, will@kernel.org, joro@8bytes.org, 
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
	1107521@bugs.debian.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> in the meanwhile, Matt, could you help do some
> more work to narrow down the problematic change?

I went the opposite direction and started cherry picking changes from
6.15.y, starting where ath12k diverged from 6.12.y in Sep 2024. I
found stability pretty quick and was able to bisect down to a single
commit where stability started. See branch
https://github.com/mdmower/linux/commits/mdm-6.12.35-ath12k-1/ for the
cherry pick history on top of v6.12.35. The commit where stability
started is:
  wifi: ath12k: modify ath12k_mac_op_bss_info_changed() for MLO
  https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/net/wireless/ath/ath12k?h=linux-6.15.y&id=afbab6e4e88da68cca94cabfc1604d71db161d42

I know this isn't exactly what you needed (especially since the commit
is part of a patch series, not standalone), but maybe it'll help?

Logs with ath12k debugging enabled:

1. Last broken revision in my branch:
   wifi: ath12k: modify ath12k_get_arvif_iter() for MLO
   https://github.com/mdmower/linux/commit/841b7f4af08f9d80e6db862218d341402dfc9acf
   https://cmphys.com/ath12k/dmesg-6.12.35-cherrypicks-841b7f4af08f-ath12kdebug.log
2. First fixed revision in my branch:
   wifi: ath12k: modify ath12k_mac_op_bss_info_changed() for MLO
   https://github.com/mdmower/linux/commit/931abb9e838e376a53a82c0f638fb63a9d31e737
   https://cmphys.com/ath12k/dmesg-6.12.35-cherrypicks-931abb9e838e-ath12kdebug.log

I'll continue to test this branch to make sure it's not a false
positive, but so far it's looking good.
