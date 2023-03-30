Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC888C02
	for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 17:22:30 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id ew6so79315713edb.7
        for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 10:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVAn4wR6MEB1azuZNqppvLy3xIslL0OfTJA1ojOVPMs=;
        b=DLvzp46JWuHnoAI6eDLxZPFz2+PCJ98ynEfzkldzkTNTtLVEW2yWETjQV0ehUmChxv
         yIWd96UCr/NbhUThD1/iCypH9trqQnOpKvtNt4WLK00kSJOU4iEzydQKafJ93Lh5nmCu
         82WY4LNgJGQeXdphy+0JVIUj/fakIsI60XWFv5X4GFVEnMH3Yh/Wmhger2YV9VKRSAJ9
         HN14qlu00M5rXZ9F7LRJkjHLkID9/gXItCl2m7PF+bort95FUtN/ywtwyAbNOzWgsQGN
         lUa+4JlRGcIFR01yk9zVIcbfEU1avfFjzPGK/XPG4fUZKAyAwXEbRk9/eu0mM9OsINgF
         CTfA==
X-Gm-Message-State: AAQBX9euQ2abv86E1r2R+nIc2GewIkRyiuqt2rCPVcvHGaJIm9m/sNmu
	iUqq137nMMLKRUro/ewKplN+YlEMn+qmiVV5rEU=
X-Google-Smtp-Source: AKy350aWoTnfeNTO0Zh34lQQjCl79sTr1N4Q92wZJzRbUTZGgAbJgGc97/iIuq9rCgZAjBTQ33hmTNwCgef6g8VRQ7Y=
X-Received: by 2002:a17:906:fe49:b0:8b1:3298:c587 with SMTP id
 wz9-20020a170906fe4900b008b13298c587mr13056544ejb.2.1680196948585; Thu, 30
 Mar 2023 10:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230320180528.281755-1-jean-philippe@linaro.org> <1a227cc4-217b-01aa-ecee-9819160d9a44@redhat.com>
In-Reply-To: <1a227cc4-217b-01aa-ecee-9819160d9a44@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Mar 2023 19:22:17 +0200
Message-ID: <CAJZ5v0hv3B-J0EOUxuKXAatvnpo463OpYLTEAzar-FS7onp21g@mail.gmail.com>
Subject: Re: [RESEND PATCH] ACPI: VIOT: Initialize the correct IOMMU fwspec
To: eric.auger@redhat.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, iommu@lists.linux.dev, 
	linux-pci@vger.kernel.org, helgaas@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2023 at 11:04=E2=80=AFAM Eric Auger <eric.auger@redhat.com>=
 wrote:
>
> Hi Jean,
>
> On 3/20/23 19:05, Jean-Philippe Brucker wrote:
> > When setting up DMA for a PCI device, we need to initialize its
> > iommu_fwspec with all possible alias RIDs (such as PCI bridges). To do
> > this we use pci_for_each_dma_alias() which calls
> > viot_pci_dev_iommu_init(). This function incorrectly initializes the
> > fwspec of the bridge instead of the device being configured. Fix it by
> > passing the original device as context to pci_for_each_dma_alias().
> >
> > Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
> > Reported-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>
> Tested-by: Eric Auger <eric.auger@redhat.com>

Applied as 6.4 material, thanks!
