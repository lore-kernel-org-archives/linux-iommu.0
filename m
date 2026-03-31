Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA326E70E
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 05:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774935027; cv=none; b=tOYCBdbuIkOU0uVXa7zIG18K56YXI6XayTr18KrZBROPpJe6Cmj3+ilbH25qDXDHwnMlE9XXFIJnEN+Wv5vZaznoiWmu5WorA6aHEant2r3K73VMhNkRAu8WN0j5gJ3DaT0TA0Q3FvnRHxlL7aji2mD1Sc163tSVRTPx9mVPEvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774935027; c=relaxed/simple;
	bh=88WLdxLEDTNu6k9xLQijUGvoPlfUNPqJgQxMuYusay0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GTJ2s7z6hVcNzOBdGzdYReoFMSw4EN/wadjwMizUoeb4Zg9P6wWImNRfg3SY6/+ZJbhxOaGzLBrjMdRgb14LtN9SHCB4Slm2Rf52vtznCUTaGOm6pm0cIzho5GnqSQZWd+A9L536ihA7Zj+j6jaKWoDY7X0mRD/mp0YQQ09qCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l7rV8UZn; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l7rV8UZn"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so4671047eec.1
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 22:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774935026; x=1775539826; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88WLdxLEDTNu6k9xLQijUGvoPlfUNPqJgQxMuYusay0=;
        b=l7rV8UZnvKihzTLqA5lz6EM6m0cW6UPPWba5TffZaksMbaTtgdMTcwVQ5vIXqR+RU9
         y+Z6cKw5e/8mWq6mChzqLH7tU8M3i2iJn+ht8zp7wPI4oUNQeaWUrXEceCI+NklyM2Ug
         5c/CvDZeic60C0sAfXzASi7jdSXSNfCzAS5MfHVNJtga12zyk86Fz85dimt5karG6n9b
         LUOWR94EaF6Ie2rrClDqge3CFx2IdpPbIXViR0c3cfZmpfZ6r77EzbhifsIQyWnovR6R
         5+D/wnxv5DSdu0eeeNMzKB0qnQEMQAomOvOBGMX6QlyTUgyCGUYgZVzDN/8QuD/MR/UW
         qKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774935026; x=1775539826;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=88WLdxLEDTNu6k9xLQijUGvoPlfUNPqJgQxMuYusay0=;
        b=EyzH3d5wEtwcd5wkigjxXZtbHIAZfoeIflkuoHazI/ab5UBr8sbfa/H8PXJfvGCLKY
         XU4S+p26cGg0XvvUHOQHob7eHdCW1VOEDzE19UvZMlxOVjIV44lwdf+xFkhyxDYY7Qdt
         OMiNLjcFcT07VKpJp5U0dCzoc7RWmpFHZludxBCmn6eAgTnFBMNghGezENscIowXVbWP
         TWRoUCriZDEU2vTIl1arPllA1nIgXUIpGoYwsqY2XAajVX75Yl3uAWyAzyZF3LHjKCQP
         lxaNxvGE6w1ZdNP8XExcjDw8TDdNXzAWp6ckLx3jHC+oUn+5aqx5j0edZLfWf4NEQ1Is
         8anQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTARw39NcBUzI6Raz30MDga74cjFCc24WItZqmyrFwrBEDwKRqxuc9E023v/FJKMLbKptkYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwByKq6o+cRJcEW4bnNuzxMpmeoQDUZ1Cut0dQ51QTr0QKF41hn
	yHsd5Qit4AY4g/VYa/LLNMeZw6+Rn77xJAM3n+jAW4xyiHok0Kl/7LEGj2fRzHtNOeVfEJnNorK
	u/A==
X-Received: from dycrq17.prod.google.com ([2002:a05:693c:2c11:b0:2c1:80e6:1768])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d512:b0:2be:83d0:d229
 with SMTP id 5a478bee46e88-2c185e45d90mr8113698eec.27.1774935025727; Mon, 30
 Mar 2026 22:30:25 -0700 (PDT)
Date: Tue, 31 Mar 2026 05:30:22 +0000
In-Reply-To: <20260330084206.9251-7-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260330084206.9251-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260331053024.4008333-1-wnliu@google.com>
Subject: Re: [PATCH 06/22] iommu/amd: Map vIOMMU VF MMIO and VF Control MMIO regions
From: Weinan Liu <wnliu@google.com>
To: suravee.suthikulpanit@amd.com
Cc: chriscli@google.com, dantuluris@google.com, iommu@lists.linux.dev, 
	jay.chen@amd.com, jgg@nvidia.com, jon.grimm@amd.com, joro@8bytes.org, 
	kevin.tian@intel.com, kpsingh@google.com, linux-kernel@vger.kernel.org, 
	nicolinc@nvidia.com, sairaj.arunkodilkar@amd.com, santosh.shukla@amd.com, 
	vasant.hegde@amd.com, wnliu@google.com, wvw@google.com, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 1:43=E2=80=AFAM Suravee Suthikulpanit <suravee.suth=
ikulpanit@amd.com> wrote:

> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
> index f4b5f96d4785..887a9eb8122d 100644
> --- a/drivers/iommu/amd/viommu.c
> +++ b/drivers/iommu/amd/viommu.c
> +static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
> +{...
> + =C2=A0 =C2=A0 =C2=A0 /* Mapping 256MB of VF and 4MB of VF_CNTL BARs */
> + =C2=A0 =C2=A0 =C2=A0 vf_phys &=3D ~1ULL;
> + =C2=A0 =C2=A0 =C2=A0 iommu->vf_base =3D iommu_map_mmio_space(vf_phys, 0=
x10000000);
> + =C2=A0 =C2=A0 =C2=A0 if (!iommu->vf_base) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("Can't reserve =
vf_base\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 vf_cntl_phys &=3D ~1ULL;
> + =C2=A0 =C2=A0 =C2=A0 iommu->vfctrl_base =3D iommu_map_mmio_space(vf_cnt=
l_phys, 0x400000);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!iommu->vfctrl_base) {
If this mapping fails, the previously successful mapping of iommu->vf_base =
need to be clean up=C2=A0
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("Can't reserve =
vfctrl_base\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
