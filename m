Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A36013DDB9
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767965; cv=none; b=GgKutyTZF22AX9j/2sO7ycYjEVCc0UnGkxeENBwtre/iPABam7nFlp+JNBpQ8rj8hUzlcP6UF5fBS9kNaq8lU/+cdqV/7s3ZtVvAE/9WNuSK6Cl8u0jMC96on9NVBizygtmFb3fmEoNMbpoBctftmKYreQCUJvRzkFXbplOrcas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767965; c=relaxed/simple;
	bh=qn060LLjQ/iIKiEBOyhqceipwLz6Rtb/XZdaXblpksE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oq+gfWLFMUOfNLZiERDxKkenbS2YXo1gv9NWIhleV9746bRtbJDWzVyjOzcnRnIFl2AnVtt/m9es585i/Ac5S3oNN1eRt9bgu5I1vPO3Irv/0VUwz2XopSEbWt5/73kyNdpShc/ZTSxF02uTHbadSqED9zRnzalOeDe6qgH5+7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VXrJjZ82; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXrJjZ82"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70b4267ccfcso1503937b3a.3
        for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 00:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720767964; x=1721372764; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qn060LLjQ/iIKiEBOyhqceipwLz6Rtb/XZdaXblpksE=;
        b=VXrJjZ82VWan5CeGFUbAtHBoy6UkHva2Ka7DaH9FFZCeN4kyNR5wasQuS3Oh330y0D
         79VndgdTjbXY7uAMi0iVpH7lN1xjFQZBXJIvuPzLiLNps81RIUHCmfHHqZn3pgvBX55s
         MpmCelMZ0CBI6bUF/Wy+RZknQo6algzqmZjuWP6Bx5VNeRypz92vjEEw6OZn/oTu+Opc
         nOWZ/OBoCsqFt23ICBVKWcc8tQv0FOgrt/UH5wAlQ/t4T9P7zELm/aLtax69mMz35MsW
         9dJYlHRA97sed+20Rtkze/aJKbRKKJMMb35wMtejuBKzCHI2e6UEsF+rZ6/3QGbw9hIv
         T7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720767964; x=1721372764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qn060LLjQ/iIKiEBOyhqceipwLz6Rtb/XZdaXblpksE=;
        b=RVLpbzKt+ynQhP5Vv1OR7hoyCpG1P4uYBD5MYj5fp4vL8+FuUROMNnRMnwcliypsOq
         gIdGpRAbxqKFx3E1/OCiZiYbGq2hDvLcTgYHTQG2JzrR1Vbe7iK5fwSsxqjC/iURccVN
         xn5iSnTDmHzwxQW9Eoe3dvOMOF7RE71fjOS8mrE9ykWXTXbDPpDuGCIQXdMdzyq4sGsR
         RjvUwmhPFyZbELK+ZSHp/vHWy1/rzEFuhnC3BArmY239WyXhKdYYYdoKcBpYsiXXF2Pa
         LQOX+q0Ay19JZTBIAfBt9izxY9zAQxH3faV/zNAQcZVhKTwpWpVvYBItZYVjQB/IYEDB
         K09g==
X-Forwarded-Encrypted: i=1; AJvYcCV3E3ylbKzGG/NYEwvb7QJ4Qqq3gbIMfvSods3DeEKZapkl13XQ3g52PLzh9VeDUvzq9mmfEbLhxxk7hXUTElajzpqPcqQ=
X-Gm-Message-State: AOJu0YxcKvBkk6S5Ylegp/8AiIXgiBSy/g6BTf73eRUvWGLOTQsiyNln
	S3vUT+FSPnZr5b0sC+4sphD+BoBI+6K2mYY8jDVMnhydJ0H0ZOE2gSKSFXv5g1WmFPKygGkWAli
	6DnFHiWzKOz7xssOoeeIljvE+BOxjsFZix7Hw
X-Google-Smtp-Source: AGHT+IHF+IQNF+84R2HuQm4DaRBIt08wyUhggtbfIGujMYkHCproHjLzYh38/DIH/rrwybPiylXk6nxfOaVGpxQqxvA=
X-Received: by 2002:a05:6a21:3393:b0:1c2:8d22:c6a6 with SMTP id
 adf61e73a8af0-1c2982158c3mr12336608637.8.1720767963426; Fri, 12 Jul 2024
 00:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240709234913.2749386-1-pandoh@google.com> <b3401333-76d3-415a-b2e4-b148c44b13f3@linux.intel.com>
In-Reply-To: <b3401333-76d3-415a-b2e4-b148c44b13f3@linux.intel.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Fri, 12 Jul 2024 00:05:52 -0700
Message-ID: <CAMC_AXXy+2Fc8RcGGFh0abL0BRLHwnR-9BmypFNCJpVuPoHmJg@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Fix identity map bounds in si_domain_init()
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Kevin Tian <kevin.tian@intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"H. Peter Anvin" <hpa@linux.intel.com>, Tejun Heo <tj@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sudheer Dantuluri <dantuluris@google.com>, 
	Gary Zibrat <gzibrat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 7:45=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com> =
wrote:
> Do you mind telling me on which platform did you test this fix? My
> understanding is that modern VT-d hardware supports hardware pass
> through mode, hence this piece of code won't be executed anymore.

We tested it in a VM using an emulated vIOMMU setup. Hope that helps.

Thanks,
Jon
