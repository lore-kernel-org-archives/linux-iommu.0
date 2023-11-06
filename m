Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81DEF9C8
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HaeMd9dm"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-41ea9c5e83cso273381cf.0
        for <iommu@lists.linux.dev>; Mon, 06 Nov 2023 01:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699261415; x=1699866215; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTG48Y2ovfKOp0Y1DlwIaJiOl/Ig8rwMglYpTHiSco8=;
        b=HaeMd9dmOXchSc7LbX0oMMoDfRnjjIW476ZSJRFJnYt40Q1QKHxIJl/b9kLIf9gu1Y
         LI2ALMblyKtfEiTyiHeDbCqWe8AC4k4XQggEHEYoLaPy2FViVaole2ToOdT2h0Z+JLgZ
         jcVB7AKW5cX9jzSHd6Gvq25m6iJXexw5ydWwuDFkJF5J5XUCLZr6X1wVF92klEDgvJ/H
         2dTLqCtKmZUPIKOdhsljimInGrTCwKgQBLxu2QtePgBq/wp85A78G0rzD5h0xSKGRyMi
         5cgk4yjOU+Oo73YxPnzNk9N7gIeSUCuNhs+pcJLiZPAVg3dCnPEtbdXYWrzNAsFfy6fw
         Q/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699261415; x=1699866215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTG48Y2ovfKOp0Y1DlwIaJiOl/Ig8rwMglYpTHiSco8=;
        b=asKio71xJHrZCkKATT2ppuBIASUFafoLpJGmextu3OYKrANROBEbHFusGGAKECpcK6
         WWgdG7nJmN4DCI4sGktRyvpIen0nAMhreB5q86ED/n6jjU/M6PYmdtIs8VEDj+xecMXX
         cgAwdnHJ4peBI8kgyd/CpRj/Mpn49BcU1I66lAiZjnfjIN8k5ZIxU9m9O5RniV62uj9V
         MY5QIZtm2LNrQadmfCJuS/5K5PE78iwO7HjRCDJaAclsxdhA8Pt+yi/dF+g6DHTXqmsT
         DT65qWMCQ4PVAbq+fu3wcmOrJ47u4+eDTu9JCD2mGrxeXdOjxsdoYRAfX0qdOyHj1MIL
         DbDQ==
X-Gm-Message-State: AOJu0YycgKh4YgSDbQZE4cQP9QYUlel1eDF796VR8yuHZqHes7xg8SCJ
	t4p12Iu2/qptEbavQubTcX4lWUoS90vNdgRsFjP5IA==
X-Google-Smtp-Source: AGHT+IH7DcjaNB/KVzxweZ2ijWw6q3lvzbICaM+MMNRPKHHvEm7oOvq6BpbBimt+nj6b7JcY+81mgwGDDMQZrJ4Rfew=
X-Received: by 2002:a05:622a:3c8:b0:41e:2bad:f3c5 with SMTP id
 k8-20020a05622a03c800b0041e2badf3c5mr425940qtx.9.1699261415412; Mon, 06 Nov
 2023 01:03:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com> <16-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <16-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Mon, 6 Nov 2023 17:02:59 +0800
Message-ID: <CAKHBV27wTOqkbfY0D+GNiE-aJyJzP6MS6pa23Bqk_tVU37DK2A@mail.gmail.com>
Subject: Re: [PATCH v2 16/27] iommu/arm-smmu-v3: Keep track of valid CD
 entries in the cd_table
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 7:37=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> We no longer need a master->sva_enable to control what attaches are
> allowed.

Doesn't it also guard against attaching a domain before
arm_smmu_master_sva_enable_iopf is called? Is the idea here to allow
attaching SVA domains independently of whether it will be functional
or not?
