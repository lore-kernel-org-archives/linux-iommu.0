Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108CF20326
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730738468; cv=none; b=bqgq0Im1JHE+BmsyM/LNDk5eP9gLphamhsEy0Aj+lW3bzD4eelK7DUSdXF/zS7eTju8rA64fXT4GTBIiJx4CAZ2aD7LCjE0Pm1egVLFxOvIGfHimcESG6hBsKL2jtqjtSbf9m/h8kl+zKOCUO5cb9RKcep+/PgCSWi0afcnlUKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730738468; c=relaxed/simple;
	bh=4g2nSdrXIFpd8HELvh1ubm5iaFAH1CU3rzLZTPvgp5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvDuxOm+KNtxtraupDYEBx4zMgEsjYVbQva4L3seiv3ik4X/5wKJ11g3LuZd3iUGidZKSpn3uU426CUb4QOSRjTK0jgSHgtj7TSA6Kfwft/clWIOLGtDTHJFAyW8PT9xSNidUd4vczWqRS3r8B6W+NDXCZtYA2XfSoHvvarntUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DeZwjpcV; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DeZwjpcV"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c934b2c991so4650a12.0
        for <iommu@lists.linux.dev>; Mon, 04 Nov 2024 08:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730738465; x=1731343265; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qbSzE0kpWuIn4hR1/s76vpQ6GfGuGne40I1Ud6x3q4=;
        b=DeZwjpcV6eRevAJVnqTDh/kOJGqJ04gs/maZWYfJAslT93bgyNzH8K5zzfaIZFnmc2
         wjjnlnTb0l+WgIM/A+73w7XivYvEnWg+SpOf8ZxBXx7ox8w5cFL0Z+N9D+8QgXkrg1oF
         xsKyXFI97zlDA2XROsjvnFVr/j3gMWWTfWIprW177g8+P/Q+jzpuMC9uiFz+NS1WwHO6
         zrXsMOf9Nbt7L1zrd857g3W2I3r1pU9W9/4dGD6Ep6deFjIJ63Z/ui9MdNHJ7M0jb9LL
         g/1bbqBhRUJOoePH+c5b95l37UbULcYgiFlU6BMFP+psSqh9MGBcEIOfNjtFRpVlrR8R
         tsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730738465; x=1731343265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qbSzE0kpWuIn4hR1/s76vpQ6GfGuGne40I1Ud6x3q4=;
        b=pdxT8wgxaUVgZvWqIJA+2PQVHlRykRiHeiMmxppZiSXWPO/CVezRCAFGm1G8BK/EJc
         kTLJM+qYijDbLQsYtrzNgR0y+xReY/Jfek3oO/aESExmC3YlQusSGd1kVw7ctSYi/GdB
         yNTOKLIyIuUT9HjoGQ+0FSfWPQOd1eldC5syEz6ZXMzYSDlQPnSJxMQ0N/7UiOLdcpmE
         dm4Sdq4Mxb5Lr8cpG6VKuUd501w7uHHBMpNngk1om+Z4r49A3hkag1URACVptaDRcrPT
         F12CyeOCLS+a7V0JREokGgLPPe/NBDMVy90xfrXmxOwZsc0/jY0MxzQW2eqt/gElknm2
         XE+A==
X-Forwarded-Encrypted: i=1; AJvYcCU1LOkVoHb1NsRmfQlN36Z+VTjLYfS06fx6CC9NlQ5gXLPB5xakBEe2dPMy2wTRnHN/PJu9tw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOzEkZUJB/QLzoK9kAH4a6VbTeKXOScFdQRPcVbXRVp1uecDFk
	TsXnOhXeaWkp39r2q7oI/Y0bBb7U4yGM9oGZrb1kJXEvYD1IeAQLbcCA7skRFr8NCYFJgJA1HiA
	uMcXcOnV9SaaQTflpRxrqLg/Mm/puOqfBwhbI
X-Gm-Gg: ASbGncv+GoN8ZA0Z/vxG2Mv/mi/uq+tl+Zf3NsK4TMKi5fRFetgMHaVN2Rsnva6UqcA
	9hFTCw6JZFZbLYcDko8X1do81l7XA+gsTnRZGEs6YtUqf/WA9y+X4606DfsDnPyE=
X-Google-Smtp-Source: AGHT+IGnm6JDdC2B1Bid+Kl2FwmzsgH0hTlbL91bjQHQ8xhzgfHeouvP3qej8sHaIuykwEYz2vDSoUQ/s++NjDlmg84=
X-Received: by 2002:a05:6402:18e:b0:5cb:68d8:beae with SMTP id
 4fb4d7f45d1cf-5ceca051b65mr97516a12.3.1730738465028; Mon, 04 Nov 2024
 08:41:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240827193026.3993039-1-praan@google.com> <20240827193026.3993039-2-praan@google.com>
 <ZtAW0hVPFD6JbLTL@Asurada-Nvidia> <ZtEKMknbGaD9q170@google.com>
In-Reply-To: <ZtEKMknbGaD9q170@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 4 Nov 2024 08:40:52 -0800
Message-ID: <CAE2F3rB_ap30D=J4zCtMfiuyu97yK3op4+S-PxOKBsKcp1J2EA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Print better events records
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 4:54=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Wed, Aug 28, 2024 at 11:36:02PM -0700, Nicolin Chen wrote:
> > > +static void arm_smmu_dump_xlation_fault(struct arm_smmu_device *smmu=
,
> > > +                                       struct arm_smmu_event *event)
> > > +{
> > > +       dev_err(smmu->dev, "Fault: %s client %s sid 0x%08x.0x%05x:\n"=
,
> >
> > "client" doesn't seem to be used anywhere in this driver, I would:
> > s/client/master
> >
>
> Ack, would change this to "master".

To align with Documentation/process/coding-style.rst , I propose using
the term "client" as it can be considered "new usage". In this driver,
there are no existing log messages that use the word "master". The Arm
SMMUv3 arch spec consistently uses the term "client device" and
completely avoids the term "master". (The Arm MMU-700 TRM does use the
master/slave terminology)
