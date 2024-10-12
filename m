Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D084A3E
	for <iommu@lists.linux.dev>; Sat, 12 Oct 2024 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728702744; cv=none; b=I6/VJGwcimbF0zS1N382hTMGAer9GdoJ3K2sG1eSY9zC+mSdgiihP0Iq9N3mJkXChutKMQZQUjnqMrQHpLTV1WVR6cWlDoyl58okAQbHZM7vFPl0ufCu30ecQbSEcGBl5KbHh3h3eR+t+ec3rEL6ZZzYv0+L+i3QyOOeC6NTd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728702744; c=relaxed/simple;
	bh=ZPl0vRIjZy6Q1TLJkMAfmvzvlUnFAH8cE6wBRsWA6AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlylSqG+BhR4LGrDzuuyBZOAy35kLCv8LU64TPNHC9gYnHAo/hWoUywfrjxLDyrXraezeZEEHoND4FAiaL7sZo+b7/PiSVytDTLVsLPBU4p91X9MT9LMaYnmMYScR8var4f6XBAjswLvIfzNFOgEYz/uJEE/xSbB36+mPtVboXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LqTm01F7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LqTm01F7"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53997328633so4319697e87.3
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 20:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728702740; x=1729307540; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=skhRjSsjRWRBkBJSR7ncRA8S1Q1nCZnYe3M18zuYqQk=;
        b=LqTm01F7W4AuYPe9+WnKbXZ4N9xjC/u9Yg7VsNmx6nHWOhB7AN29fXvKf+zNVuZ0Ps
         1OlOtFaIJIsqIuUuG/i1iga892VLWcdfyh8sz/O8/g/HJHlXdxTrhJyi4999aA+wIGKE
         sxcbdw4ICpgCUYD/1XSSVum76BeOSFCpCvMJAXu5uCyMiUHGeMo+ea8Jr6UCgtyLwQ9C
         it8NQdc7nqVgCSHvy49HkItfTaZlwT2GqhtthPGCXnIE//CxhxsvVoFuL4f2RQ4l1Gqn
         4HxJJsFgTAl4JeIWNIsUQLA9vpcJcw+tc3OZowO82W4bqf+H1C78XDL4JAaj7BZk0FUp
         yCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728702740; x=1729307540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skhRjSsjRWRBkBJSR7ncRA8S1Q1nCZnYe3M18zuYqQk=;
        b=VNG4zTRuO3qTD+Z0unXA3B7fh/pFdmAbchl+/iPXSjD/MkwDahcB64PKt36L+Dc9Y6
         y63IfrkgS8CV9gBP5doP9aIpjbGRl2sUk1HgYaCOKeAmyefjG//hyMOavhLUHQgL+ApN
         BZlC1CdUk4KY/1ouhiEwvxf4dad6x3Sjxk00+iHiGibKAGUIYVmBfuw/1UtGuYzodiNU
         msvqD9ZhHx5ydKjt0EIYWZCEDwDW2/KXjIgxxgsHTcK4QTQKQQ3BnGXcCuacnxvBAGUI
         Rt0kDNuyT7N7j9fHeesf8mwy1Z9NTWeAt63aC4/8L9VDKDxj37cAJHq0ot/D2anu6c5G
         VH0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVU0RtU8dMcjNGrj9X8opw+lMYGqyg1T71xBr+C97GF4vSrL8Iclcc0fiREP0dA0MUwfvwTcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKjOsyUMYiyEs7p1XcmvT03rHfm4eaeXhsATm7u3mMNhmm50ke
	fTNX9prwKImUGYWbN6cp+EiGCy6v1ybYVpj9mOOt+aPCKXcNYKombhkysJQP9pnwAcmD8ke4/n1
	TOup8f/SFC+e8Hz3PUnKiFL5ReQEyjhnm9/w8fA==
X-Google-Smtp-Source: AGHT+IESbkfK9x0RkC/zr+X/5OJJGUEqu4Sl+Zaum+icoDlotDKEsytnJ09AslW1W0e34iL7p8s2SZSLipO7yFwMhZw=
X-Received: by 2002:a05:6512:b85:b0:539:936c:9845 with SMTP id
 2adb3069b0e04-539e571c924mr863040e87.37.1728702740436; Fri, 11 Oct 2024
 20:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1728491532.git.nicolinc@nvidia.com> <d714a9d107696194cc63e5f6c2b6bf5877b37f68.1728491532.git.nicolinc@nvidia.com>
In-Reply-To: <d714a9d107696194cc63e5f6c2b6bf5877b37f68.1728491532.git.nicolinc@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 12 Oct 2024 11:12:09 +0800
Message-ID: <CABQgh9E1rfA8i+x+6VRgyFb41n+n_F6-gqnT-TfqLqVeYaYmew@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] iommu/arm-smmu-v3: Add arm_vsmmu_cache_invalidate
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, will@kernel.org, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, shuah@kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com, 
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com, 
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com, yi.l.liu@intel.com, 
	aik@amd.com, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Oct 2024 at 00:44, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> Implement the vIOMMU's cache_invalidate op for user space to invalidate the
> IOTLB entries, Device ATS and CD entries that are still cached by hardware.
>
> Add struct iommu_viommu_arm_smmuv3_invalidate defining invalidation entries
> that are simply in the native format of a 128-bit TLBI command. Scan those
> commands against the permitted command list and fix their VMID/SID fields.
>
> Co-developed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   5 +
>  include/uapi/linux/iommufd.h                  |  24 ++++
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 131 +++++++++++++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   6 +-
>  4 files changed, 162 insertions(+), 4 deletions(-)
>

> +static int
> +arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
> +                          struct iommu_viommu_arm_smmuv3_invalidate *cmd)
> +{
> +       cmd->cmd[0] = le64_to_cpu(cmd->cmd[0]);
> +       cmd->cmd[1] = le64_to_cpu(cmd->cmd[1]);
> +
> +       switch (cmd->cmd[0] & CMDQ_0_OP) {
> +       case CMDQ_OP_TLBI_NSNH_ALL:
> +               /* Convert to NH_ALL */
> +               cmd->cmd[0] = CMDQ_OP_TLBI_NH_ALL |
> +                             FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
> +               cmd->cmd[1] = 0;
> +               break;
> +       case CMDQ_OP_TLBI_NH_VA:
> +       case CMDQ_OP_TLBI_NH_VAA:
> +       case CMDQ_OP_TLBI_NH_ALL:
> +       case CMDQ_OP_TLBI_NH_ASID:
> +               cmd->cmd[0] &= ~CMDQ_TLBI_0_VMID;
> +               cmd->cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
> +               break;
> +       case CMDQ_OP_ATC_INV:
> +       case CMDQ_OP_CFGI_CD:
> +       case CMDQ_OP_CFGI_CD_ALL:
> +               u32 sid, vsid = FIELD_GET(CMDQ_CFGI_0_SID, cmd->cmd[0]);

Here got build error

drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:302:3: error: a
label can only be part of a statement and a declaration is not a
statement
  302 |   u32 sid, vsid = FIELD_GET(CMDQ_CFGI_0_SID, cmd->cmd[0]);
      |   ^~~

Need {} to include.
case CMDQ_OP_CFGI_CD_ALL: {
...
}

Thanks
