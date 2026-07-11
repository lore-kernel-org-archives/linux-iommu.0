Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531421E5B88
	for <iommu@lists.linux.dev>; Sat, 11 Jul 2026 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783791510; cv=pass; b=mgkGhG5xkv9QvK4EE81DMR7Reui96vCamw16F83E7PQAb25U8ZEOkKceykFrgKhAFWigmioRx1tTEOv7h9Ra+4BofUgRn6auTwqOeZ+XZlElaw4NCFExxKaKi+ZazxAdDANRIenEcwhRk2kgL8GaPoQMFeftsi6h41hsAyp1WCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783791510; c=relaxed/simple;
	bh=2V2KLSDgcSUiK4L4iVVgXmIB4UUi2eZBF2ABdPzmDAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IuF57zcN9eXrwc78dVzIZ4//kVpUW1KzgJV7SDM12+Fzi7kyvYNPsgT9NR7LjvUkABHmLR8mMk+TltbU9VwHsXW+LvTDx9bnvcVnbT12oWbIKk/MGV/kuggGav6f0sZ4k7Oh52h1tmGJyI/nguKYaKEl7nPoPT2o91tpRtLljQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V3W+v+Lj; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V3W+v+Lj"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c10e86e52so133881cf.1
        for <iommu@lists.linux.dev>; Sat, 11 Jul 2026 10:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783791508; cv=none;
        d=google.com; s=arc-20260327;
        b=C1e1rh4BNNXKuyC62hBiz+NhmNyaTZrfiC30McgUo5+fKYrCpaMZA7dV3r00DjwHl0
         B3wrFR4vGhbYDjnnft9yYgaAEUxv9AS202XemrgUaZqEh4InET/Wy3e0ipympJS2JSk9
         XEXqaRFkrWvUoBh8QlZZgZVFNb30s8F/BhSL8cbO9doQib2Tku368MlgrC/DfA82+Ho7
         dyvJt//tbd+qQww0z9VQu4XqR+a9+RAzxN/OkcDiPfhYi5jwHGvtP0+M+ks1+hcTafV4
         SN7+tTaS3qHoI02YwdeZebaUn/H6NG7G55pLqOGkHsjGPMMwrIqjxfTVrnBSOx4tnxm/
         +z8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2V2KLSDgcSUiK4L4iVVgXmIB4UUi2eZBF2ABdPzmDAE=;
        fh=tudwIpXObUUPMDqURC6/Z6JaVyjOB1MDYO3B32Lpf5k=;
        b=ZtaC6I27SskbF8h92Vk2u7DCE7/Wv3lppzUkmvp79EAgpetZwOGmflPTZgionNh74k
         2l13Z1Ew8r6o6G9HYYR2+LejTDRQd5p2bT+UhlrSdRDwiwtcwXyqUAG2MNwJ/YtEwcu7
         HIRSTWfAf9/0aE1A63jwsFUIPmgMlzhKtinKhoEahCg1zqcZtaydOxftT9xRjsW80CBI
         GeRPdKSrFpN+yS3llV49YDfKIQ0pohfmWuxFBlpSfY93y7g4Mz0Tu8/mNMkBF/5SJ10J
         Lh7V82oeTKBbrSP1m/VksaVxDybOm5X5B/E15SV279Fd4Wiq1Js/FrCQeMvkZqbL/AHu
         v9UA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783791508; x=1784396308; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2V2KLSDgcSUiK4L4iVVgXmIB4UUi2eZBF2ABdPzmDAE=;
        b=V3W+v+LjM6d6kOWJTiistIhG7Xmzyg74DfoeBFtdt+OPGPTTSzVQWTyz+7acJeuUn1
         mVyev560+SJigWlbCWtZBK74OBHb0D/wwraOAF0Xi1ev/hA03/UvmLvbKiFpj0emCEql
         anEYayoWTkefLZWVodYxO6H9QrYkH7sjRNppUIljudVdBm20ADvDtgikUi4ifYjKEpuH
         xym+7DpxIAGplvk2DFdYX/m64lpteFpCjT4gcET1xAAsV4n0VzeoYZ4qjzZgLDtggENf
         m/rZ3+V9HN9G+9ZGd6Xgbv77y2K4svRO/lmFFbTNZH3acL9CLm6ydI7BP+Q875xv1ZXV
         Qg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783791508; x=1784396308;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2V2KLSDgcSUiK4L4iVVgXmIB4UUi2eZBF2ABdPzmDAE=;
        b=TR0kSaWEj5HXDgJZNvk0GlvYkD7efyB9EfPp/Luj2Y/VCN+zeYJFuSTFP3eMkZbSlQ
         YZJkNWsIuln5BFiibpD4c+wK0XoskEO89Z/Dt6+KSa5buotuODTv3TMA7eTLNNfJKfGa
         Tpt+UYF83wzDrfkwj3i/o0tqv2J8t4oUt37nesW3m9qjRcrbsI7ntrR1a4/f+/XTCeOQ
         +gaIWfth5foTKVUWancvkwOMt297O1aTV4x1TLPwIaG5LoI5oe07idrRfIhKAyXt73Dg
         DEMmTku3xEJR8n1G8Q298xGbLgDRkU0w9pVBfaaWqh4q5bm4qvrbiFy9iehXH2f+m+Dx
         wZnQ==
X-Forwarded-Encrypted: i=1; AHgh+RomMZDhqrNP8vRKBxoqUhzEjbiUsBffssgMsY7+1L3l/40QpnIQmvD9PiGLTiJ2HTb2faFZiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYAqDvhMHGnAXXxeaNtY3GCkjKOhwi5RIM5u3oINqEYfnPCyHo
	TkIz0d7EdE4mYh4s0+KcXr5jsia1R0x4hKQ0nvYHaYRnuzzXL10YPTvPfhFc+5p0AjEgYw3f+n3
	CFwECXZDi9qjAuoxD4bu8V/9D0A88YzirJdBZshhV
X-Gm-Gg: AfdE7ckkUmm7LQaouP00lTJs0zUXllM3za9eWtrqYK6ADlHsLFqljjhjzO7sBncsdHm
	jVy3MQRiGpB6p39/DxYjttsWRfu3gE1xkMJ1LqGfbsj+wl5qynAWvOOtMjVfaSl7PjeZr6Q7Dg0
	Iaq70zsdjHu2Jq44/V+n7+ocDfpfdEOV5zZ7AWMRteAZjVQRq1TIx190CJJlFvpQKWZZ04WJxKC
	Kgkms/DI4KEwhu2bLUZBrEPT8ZZpUV/Mv0xfuv2L28ku2v0XLRUDoDkvqow4aLnOQqdrA==
X-Received: by 2002:a05:622a:4d95:b0:50e:5eba:cadd with SMTP id
 d75a77b69052e-51cbe261e39mr7732501cf.2.1783791507671; Sat, 11 Jul 2026
 10:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com>
 <2-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com> <akzh9qFEfi2umwDW@google.com>
 <20260707180811.GB226829@nvidia.com>
In-Reply-To: <20260707180811.GB226829@nvidia.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sat, 11 Jul 2026 10:38:15 -0700
X-Gm-Features: AVVi8CddI1hmY54sulNqNSmEvvFCdyTS1hLAJol6XLoIv6n6A3IeHHUQP2j41GM
Message-ID: <CAE2F3rDoBK8MeGJb=ZDRyjSYdjZac7R8-KiZf5WJnvUPfxbgbQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] iommu/arm-smmu-v3: Move pgsize out of arm_smmu_inv
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Jean-Philippe Brucker <jpb@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 11:08=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Jul 07, 2026 at 11:24:38AM +0000, Mostafa Saleh wrote:
>
> > The smmu_domain is only used for the tgsz_lg2, can=E2=80=99t we add tha=
t
> > directly instead? Decoupling the invalidation form the domain would
> > make it easier for KVM to re-use the code.
>
> Sure, done

I downloaded a newer version from your jgunthorpe repository, and
found that arm_smmu_tlbi and arm_smmu_domain are using the data types
unsigned int and u8 for tgsz_lg2, respectively. Can we align on a
single data type?
