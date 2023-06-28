Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC90C12E
	for <iommu@lists.linux.dev>; Wed, 28 Jun 2023 13:36:49 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4007b5bafceso239431cf.1
        for <iommu@lists.linux.dev>; Wed, 28 Jun 2023 06:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687959408; x=1690551408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxNDlyNnnUp8RWBC1VLsgA/+iGnbRpi0J2EVSR52FcM=;
        b=rKNzwVZcU3cLIC9qcDCyNFSF0snGD06RpyVH336Lt8XBAWSm/62RDwSb3Kw5Fnq8af
         071saHOZnx4MsQw+nhZktkAxGksWG5tEFAgrlQaguO2mfB7yCCkdwf4+bHYB5Av3mtJp
         dNyp3ifKrheqK5Jta3DbM+H6crd+V1GjtVJNTdSF0UGZrThghXaiDneFBJcACli21VO1
         siAxo8B/Ihtd6WAMJhH5Dnryki6OvLvSb1eZJBXVSyUi4q40y6y+ZKBrmaN6wj9PHI16
         LoUPy1x4a15Fmenlj7Mnjk4paBdrCMOnqZdw0biiIdZEk7EsDKNMzjsSlCIigIzanab4
         mtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687959408; x=1690551408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxNDlyNnnUp8RWBC1VLsgA/+iGnbRpi0J2EVSR52FcM=;
        b=fr/jU2V0uP8dw/gYmJPGm6NHRa+5WGexWT1yt6NIKiwm+9J+kw/sQTZZxwyL1nsVgB
         tdS3ogxjupCw4pQ1kkUYgwl78r1n2RvaNTVqsm45zWnF8SJ0rbpqCoFztgrtI3+sByL/
         Ge7ApUWwLcYMZPgAQHDJoFCGJ8BfEw+3ul2k2R1VNGOmFSPHf188p1PeFsNYbrf9U+gP
         KcR+AocSuP3ka8dLJpRy6zMSmgX5muAnmC3JSVJnnOPmnTmzSd1OEJ1R4WOQGkwZMV7t
         cuhhrU6MpQOVVd47X45zlmk8TrJWa1v6YRcQqRYD1zRex/ROHeOC70+DqHdkgDd/ctCr
         Paww==
X-Gm-Message-State: AC+VfDwBivUIqGKYZEYCKBb9FqV8X5cLErcrTQuuapRH3OvnTfJ5wu+z
	I1t8Bf6ZWURhg+puzLFuEEHGcif3ZoMkujJghvYKkA==
X-Google-Smtp-Source: ACHHUZ60AjWGc2bglbo+JECbZzsVot+WSWR2GQvtPPz3GEc8kwmp8sEBxLjEpUAJNmGk6Clveh555GFZ7J2VnYGoUdE=
X-Received: by 2002:a05:622a:51:b0:3f8:5b2:aef2 with SMTP id
 y17-20020a05622a005100b003f805b2aef2mr224203qtw.26.1687959407890; Wed, 28 Jun
 2023 06:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-10-mshavit@google.com>
 <ZJToAfeKg8FF1sZL@Asurada-Nvidia> <CAKHBV266J1S6EMMjNCRMPhSXCKnqU7-H=rhi5iMbV4D9rH7WgQ@mail.gmail.com>
 <ZJnVjvh+kdUfeMcP@Asurada-Nvidia>
In-Reply-To: <ZJnVjvh+kdUfeMcP@Asurada-Nvidia>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 28 Jun 2023 21:36:12 +0800
Message-ID: <CAKHBV25P7d85LgeAQ7VbLyATjFf+AG447pZC7YRAg=5zty1R9A@mail.gmail.com>
Subject: Re: [PATCH v4 09/13] iommu/arm-smmu-v3: Implement set_dev_pasid
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, jgg@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2023 at 2:14=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
> > I've been considering migrating those tests to the smmute driver if
> > that would be valuable.
>
> Is this on Gerrit too?

It's not pretty but I've rewritten the tests into the smmute kernel
driver. Pushed to Gerrit here:
https://linux-review.googlesource.com/id/Ibb33ba6f9c6d069324f21b9ad98e29c94=
e15374a
.
