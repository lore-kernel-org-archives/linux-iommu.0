Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73464D2F1
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 08:14:38 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-40a47e8e38dso166581cf.1
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 01:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692260077; x=1692864877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRlDliIp3CGp2aSiQsIM0n5hPxeNnC38brktFJUoztg=;
        b=yFFOD2no4UjmvtOd1f+wwkgPxqUaCE26RgD7vxGeBht5FMVUU5XtfBIMMBC6A2kIhM
         0BPJv5bEnRBm1YX0YA93bRliuuIov2VoYuswWYzUvTZigErPnCI3WMCnBdopai3QlYAe
         fFVD5RYL8z0wNqhkuf/0oFjHAGcpFrLlNdp8EN7ht7mlMp3SLOILvFGrqYA0gauFmUC5
         dnPlZhFEsJvSWWaXXdH/jSpddEltQxxXmqK4dyre31akS1hIt0YQtiM6cNVC+Ob8II8g
         5vLvrLLn8cysJMiDlnnWRdD4CLcRJ0J+mm6HE1aXOjDRmbxVjWNjgVS1D5pXJoZPunPr
         rL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692260077; x=1692864877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRlDliIp3CGp2aSiQsIM0n5hPxeNnC38brktFJUoztg=;
        b=fmtjEky26C+qyNEOT/SODn3GOsYAfjWx9IKHS3K4uCcuKPIMUqcHXarwLvuEzyQqmD
         /9R7CdM4k6F8AugOB4p96gqdeFlfJycyHAXYNV8sY3/CT6mBbQgZ8s3E10VUCUTKL3t/
         3PV2aVsSzMRSsP0hsmxp4GQTUulud2r4FKoEviupTtDTzDX01wCUiUGflB0lVNqxKHpe
         INLGBuDvqF5Jxxxlb2Z0LGo7ssDWyTJoxnCg32/xGVTNGnNC8XgBfGQcZ6koND7yqAaN
         9mNOXsBUzRJoeuO5x0IYCI3CHE/Fjrr6QGGOuOKqDZFhXQhJoCar8vwmVXtJxVZxIeSa
         j8Ig==
X-Gm-Message-State: AOJu0YxPCAxER06XjJCx6GB72TMlBJ28/qvUsMxVkxhj5w+ax7ECeqo6
	WoOysbI7soNCnQe7yHmXnre3hNs9zNdI52KL0QIPRw==
X-Google-Smtp-Source: AGHT+IEIEAVGK3aCwKeWT5dAbNi9pux/aA6pVy+iWD5WQ8+wNBWHQJOf0yq1XFSRgXWeV2VR/bnTZjP2+mw3n2IzAWI=
X-Received: by 2002:a05:622a:f:b0:403:affb:3c03 with SMTP id
 x15-20020a05622a000f00b00403affb3c03mr212303qtw.10.1692260076914; Thu, 17 Aug
 2023 01:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230816131925.2521220-1-mshavit@google.com> <20230816211849.v6.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
 <ZN1fW5CmgbxGTrmb@Asurada-Nvidia>
In-Reply-To: <ZN1fW5CmgbxGTrmb@Asurada-Nvidia>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 17 Aug 2023 16:14:01 +0800
Message-ID: <CAKHBV24-ZKS53tdKW7J8kV1br2pKgdEe4EkhRU0Nx+Zsks7CbQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/10] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org, 
	jean-philippe@linaro.org, jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 7:44=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
>
> On Wed, Aug 16, 2023 at 09:18:46PM +0800, Michael Shavit wrote:
>
> > Also add the device to the devices list before writing the CD to the
> > table so that SVA is always aware of all the CD tables that need
> > re-writing when it updates a CD.
>
> Can you please elaborate this a bit more?

Yeah I can update the message. Something like:

Also add the device to the devices list before writing the CD to the
table so that SVA will know that the CD needs to be re-written to this
device's CD table as well if it decides to update the CD's ASID
concurrently with this function.
