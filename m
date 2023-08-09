Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2C62C
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 06:37:25 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-44781abd5a8so2661357137.1
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 23:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691563045; x=1692167845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXim2MymBxTflefzDOZEMnQ/WX10EzI7OaoHPJ5kCOg=;
        b=eTdOW3qToxUPAT6ev8xRADd/Y8t00wIqEDMXLZM/aliVEHzifmLaPqxvuMk1K+9Z28
         QjTx2EuHFt8znaqPNZYEfI3N3LSynhT5mfZj/f8aLJHl7986YPAcWQmqmV33ruoMEI4F
         Wy/HkHqqPAbnQkSrM2kcFzvABsJarpOJtyBmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563045; x=1692167845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXim2MymBxTflefzDOZEMnQ/WX10EzI7OaoHPJ5kCOg=;
        b=KkAFxdIlbjLdEH4M7hEWGS+M2aX3OdvcSb0zcIzioGadhvQbIOIWHkChgzE7V2HK9p
         +i446XpuIpImvrOcV8/4Y4cqzIYr2Lmco6RswW9daT/I9cZ/ves9lBgmITZwsQtp+JNe
         XK9iWz8Ojt9anJvWmyCyW3S8PRjY1krwkDRYjF2DfbFKQHuGopgWJteB8pSR+hUL7VB4
         Xn1h+WFKcLibNQsXWRDxEDrTFqQoMBvTxcaINVgfmFntBpEaREeu1tENVxPdXPUSLNP2
         d3DreYwQiFVzHr7HWf86xm76Ew/hScuohQjId0Z0KFqOkXs/FUGFStQnKO82GXK70sKk
         BB1Q==
X-Gm-Message-State: AOJu0YxcUPYPt14AFHiFvfmLEfH73OZXDXm1GnCV0DuUuHZdCOHnp3Y0
	cmWO8gamo1zA8MCn7ZA2+SDamI1qIj6EMvg/ZMSBIaLug6yoa9G0
X-Google-Smtp-Source: AGHT+IGz/4D96cU9ja2eYEBssih1gH0rRpSOd+CLJoi0SzNs4SxPmgwff00GMCkK5WIE2enVwuqkKwI69LXZcGTKcJI=
X-Received: by 2002:a67:f3d3:0:b0:443:a4d2:86b9 with SMTP id
 j19-20020a67f3d3000000b00443a4d286b9mr1919249vsn.0.1691563044929; Tue, 08 Aug
 2023 23:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
In-Reply-To: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 9 Aug 2023 14:37:13 +0800
Message-ID: <CAGXv+5GL33D-uZ9MeZbvUuy5aSntOSfk3KaYMa1pFarydp=Vjg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix device_lock deadlock on two probe() paths
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 9, 2023 at 1:27=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> I missed two paths where __iommu_probe_device() can be called while
> already holding the device_lock() for the device that is to be probed.
>
> This causes a deadlock because __iommu_probe_device() will attempt to
> re-acquire the lock.
>
> Organize things so that these two paths can re-use the existing already
> held device_lock by marking the call chains based on if the lock is held
> or not.
>
> This is an incremental on top of Joerg's next, but it could also be handl=
ed by
> respinning the last patch in that series. Please let me know.
>
> Jason Gunthorpe (3):
>   iommu: Provide iommu_probe_device_locked()
>   iommu: Pass in the iommu_device to probe for in bus_iommu_probe()
>   iommu: Do not attempt to re-lock the iommu device when probing

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

Thank you for coming up with fixes so quickly.
