Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA4525E469
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 06:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544371; cv=none; b=abApf8VSPva1Aunw83tTMakfvmbGQzv96QOoWNf1BuDUY4c2vsK+6JiGu/elQKDRGyr9wuE3Ie4FuqjYuZfFKa/+m7+4pMObm+Hg2UYVRfYtGB12wmAHvBZrCLo9epkgcJUPsnZ22eLX2g+jg5BdjUX/saYgg3mFzUXDyr6K93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544371; c=relaxed/simple;
	bh=EuQ94UQRGamNEvKl4ItgKYazHWgUA0nKvtb0UT0leFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xbh+HncFMKv8GYyfSOV0wpkq3qFhX2je/nmlQ6F4Wj63ysRHXDtc/B2LWzDtlM19Z3ftHiyehzPV5tyodZLSFFj/B1Y10PiGKsN29gw0B3IP6m/KIg+57X0NYt2ESKliswheozoZSazPV3PL4yArQGIiLEe8K/pcSThUMX1w0Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iH1l16te; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iH1l16te"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ccc035f125so1756868eec.1
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 23:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775544369; x=1776149169; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjddnILpH/lRXg/T9aV00xAEjWsnXJ4ijmDgFRwGJUg=;
        b=iH1l16teaiXSYMKz8Aga4U3oobw1XbqHSbqAyYK+I2hPbs6IThA5KmBGJImZjIlBzm
         eC5gwl3Za+wI3ABC8LLNvG/HE0OBl+R/U1F85oGxnQ3RyySMPlgc5xM1sBPCB+YTzk+U
         rabU0qpBsZPthE5OUv08Ypm4MMmwESjuzIs5qJSZiZg7qmYqE6IOdX1u4tiellfDn99a
         Be8pISn+dv9yu2QujDvWWWYbG42TCMyT3+aHGzomGGMUfr8BNbXAl+WRztAzjxVkG/pR
         RVNxPubB2zY+wxrepXV3PaUxrZE6UhJlwj8Mr9mwiylTfmpcYJ/YARBqOktGR3b/FOIw
         AexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775544369; x=1776149169;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sjddnILpH/lRXg/T9aV00xAEjWsnXJ4ijmDgFRwGJUg=;
        b=cOOS/ZHXzBoMf+T+HeMjcxDn73UdgZ9tzHcHvZWWZNntfOgGgPGtTPP6qCEtSBXWTR
         QtbcUy9PMs4F0qHaLF5zmUthgUisuVZGl0kvoPPAUASAby+dcPuMS8rvU9viUiYXmIt+
         IpMls/3QEEtqbwAvYv8U9sxAEjtGPT3rkgKdbtQst5eD2z31/7dbwiX0j+Ji7HKhnUEK
         qK7kiXJsuKcnepK/TCnLF8Zzl/niTjUC70crOUjh0wDpQlmFqyYPORy5iOueAvogFewc
         oh4h1yIekvPRcl0aIm0Fx8XnJcFDCIf9PW8k3JzMiLZxWjKy8J0UGu7+p7bD6kz+dqSS
         x2oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVggy3sR5Bxb/qskmq/8e+4jqUvenVXdmiLuowBT5PwLU77pOQTeZIjDPr1K30klSPZ4t34gg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywuacs/WfA6Hf9d7FeZEpdBdW56fKu6ZWYq0Zcz1esqtqFx0Ddd
	/gTV3YPU8J+fZ4R4FvhlHc+ABtCwn99lZNzd4O+JAojihJLML0MkwKYrXYkRlJ0XsKo/rqEUv89
	Ieg==
X-Received: from dldoa12.prod.google.com ([2002:a05:701a:ca8c:b0:12a:83c5:a16f])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6706:b0:11c:883d:1ef0
 with SMTP id a92af1059eb24-12bf08538c3mr6887678c88.15.1775544368429; Mon, 06
 Apr 2026 23:46:08 -0700 (PDT)
Date: Tue,  7 Apr 2026 06:46:06 +0000
In-Reply-To: <20260330084206.9251-5-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260330084206.9251-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407064607.611771-1-wnliu@google.com>
Subject: Re: [PATCH 4/22] iommu/amd: Introduce IOMMUFD vIOMMU support for AMD
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

> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
> index ad627fd5ccc7..e7ffa7e8915b 100644
> --- a/drivers/iommu/amd/iommufd.c
> +++ b/drivers/iommu/amd/iommufd.c
> @@ -34,6 +34,9 @@ void *amd_iommufd_hw_info(struct device *dev, u32 *leng=
th, u32 *type)
>
>  size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu=
_type viommu_type)
>  {
> +       if (viommu_type !=3D IOMMU_VIOMMU_TYPE_AMD)
> +               return 0;
> +

It should also return 0 here if amd_viommu_init() fails or if amd_iommu_vio=
mmu is false.
