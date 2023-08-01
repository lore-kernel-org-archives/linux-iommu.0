Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6311EA9A
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 08:10:29 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-40a47e8e38dso165861cf.1
        for <iommu@lists.linux.dev>; Tue, 01 Aug 2023 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690877429; x=1691482229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfxf35QEdYY0OSeBLLB/TKiEyw1s73KmxDhCmVa+GQQ=;
        b=BSOQo36x+R0DY2LXinFdqRdbB4vEfzSH24J2R8rF2ZzJkOBf/+rmJn4aawldedN5tY
         NartRiOVkWmgbnwGkEY4FG3KnMDVLrSeIV0N2hFSGgvfN8VwP8mgC8snFIPLieUgJ8lz
         UnsHl+weLbuJ95bnCtmh+cC/uFYGOm6QOOoES23M8+0Ph3OGOtEcdG2+qaqtq37IluXj
         zYQeLNpC10fXzo6jTlw41jxZ7DYijHb107QXif9qn+RdmePhho23AibOx+BtQ8sXZL40
         fXanBtDzAkdNvnIup7L2K2799jnm7PV47+aFNN0+2akBInHyDY/3fGSPBV5At3EFxZwM
         ptfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690877429; x=1691482229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfxf35QEdYY0OSeBLLB/TKiEyw1s73KmxDhCmVa+GQQ=;
        b=eYALjNY7zLVYO8WVB9L1NP1NvTgLXyC8faHdIOthvR0uUXaN7NCE1Em+2RAyUHY2bI
         n5SS4SsVzgtL7AhNHjN8nFcLQE4xnwD7rh9lJOcXDhZT/82pRgz56kYT3FYk8rEioMAq
         yiGpM+gxVSjufI/JsVlN4TDRcUhsNViOVqiMfp0MbQGGWFoISsXgQh9EkAND8NuXzhZf
         ZB1SPcj5+g109unItce7q1ReRtM9C/a6byXpAHSAASiCP95VIpVEvhxKUW5OhKj2LUYh
         8EmOkgl9rNCLbBTbCmNs5vOVW+QWBJ/P2eJpoKRJNTaa6Cr6TcGJq5ZKX8SozPBTx3zE
         QaPA==
X-Gm-Message-State: ABy/qLY+bwURobu3CD7ZDJQOqzhAMapuH9DYUf+yg9gc5smQURpb8Mm5
	CAm8aXnwMIaYlNfbrTd6CdHCaf19Bi+HDObX/dMZhN5+Dyp0cbtONZpoHqLi
X-Google-Smtp-Source: APBJJlECES7oDVzhAvgrIjKnBacfwahdB7C4mQA9TtcZDBFnk6u3FAWxLlAKrD+AAjCc+35TLdjxAMV3SUtY8es6x0I=
X-Received: by 2002:a05:622a:104d:b0:403:9572:e37f with SMTP id
 f13-20020a05622a104d00b004039572e37fmr594142qte.22.1690877428749; Tue, 01 Aug
 2023 01:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230731104833.800114-1-mshavit@google.com> <20230731184817.v2.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
 <ZMiJ9Cg5wfbxMZ+W@Asurada-Nvidia> <ZMiPjRtch1c06F5Y@Asurada-Nvidia>
In-Reply-To: <ZMiPjRtch1c06F5Y@Asurada-Nvidia>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 1 Aug 2023 16:09:52 +0800
Message-ID: <CAKHBV26C17_9VrVC0ZESC9FF3TheNifVx8w97ig2qeMFHFfKjA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] iommu/arm-smmu-v3: move stall_enabled to the cd table
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, robin.murphy@arm.com, 
	jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Mon, Jul 31, 2023 at 09:28:40PM -0700, Nicolin Chen wrote:
> > This cd_table->stall_enabled comes from master->stall_enabled, and
> > cd_table will be in master structure. Also, struct arm_smmu_master
> > pointer will be passed in to arm_smmu_write_ctx_desc(). So, there
> > seems to be no need of master->cd_table.stall_enabled in the end;
> > just use master->stall_enabled directly?

Yes it's correct that this change isn't strictly necessary. Thoughts jgg@ ?

On Tue, Aug 1, 2023 at 12:52=E2=80=AFPM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
> Actually the stall_enabled might still need to be per-CD/domain.
> If a domain is attached by two masters. The domain->stall_enabled
> is initialized with the first master->stall_enabled. Then, the
> second master->stall_enabled would be required to match with the
> domain->stall_enabled. arm_smmu_attach_dev() has such a sanity.
>
> So, I think we might not need this patch.

But why force domains attached to different masters to have the same
stall_enabled setting? Whether stall is enabled is strictly a property
of the master, not the domain. IMO the fact that it was stored in
domain and checked in attach_dev was only because the previous design
required it, not because it's more appropriate.
