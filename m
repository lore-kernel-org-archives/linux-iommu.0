Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC702AE6A
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510035; cv=none; b=j9rvO8lccY94oJEIWZzGVr+XrHVkf1VClW4KKILdTIbSvhxVQG0BmfQuUXLfTQjU1nZae0/vk04MH2HxpNyKrciNWHpCHVyQiIunmndphFrd3eL8o6ynZ5A7k1KxMtAj+DdpJi1U90oVQYVHc8Gth65UV/Aj+bTp1qFfy8pTDSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510035; c=relaxed/simple;
	bh=9tszUB1Kj6QZXleOOcbtfNgAXBeQTMDkBWNIMC747H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ti3PWS52nRF1LpP8elzClGYbFiFgUDQD/SLPNft9lmmxVaE942csGbC3Rhcq0Q5oeyHgGLrtL8y6VNkuJKnhynqdm3XYvrxvcsGxMUvI/yjAHlFba4uB3QeKdgq+AkxmhHQ9w4jDnJRxI1j+AQgec65Xpe8j+yj0si5HIYnsZPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Etwi3Xx9; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Etwi3Xx9"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47666573242so167601cf.0
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 15:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742510033; x=1743114833; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTN3cYwp9QjWQllz3iT9To/2pZPneLE7l2qiDtQWR1s=;
        b=Etwi3Xx9VgdW6WogoBXEo6eP5rt+xHIJ6YHTKxuP3kO9dQj5wcTkfbXcSJzIijNpXd
         C3JWwlX8E/f25Kt4KhGWfQoTOo+EW9c7DTmbVESqKXA/Rh1/Oyuk1UhkciiOQ6Vk6VtO
         9XGMjrO8XX7MUXn7zAhGqF/rSNtrRGjI4F5erdvuTP+iKbzOLQ7IodxbEVolAQH7Ot1F
         HsHLxR/dSouucZ7MZANqecr+PGTGvyi8xPQzqxtv3fjq8MjD3DAOQxPLR/H+RGH2LW1z
         50ZGqrIN7I5PQGw4bWFkblNvG9w772xdvhqGMzaR90nfvAkTZ76wr9MPZ/VDM98cJ/ZA
         gsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742510033; x=1743114833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTN3cYwp9QjWQllz3iT9To/2pZPneLE7l2qiDtQWR1s=;
        b=SYPlyiynayHE0M/03GJDLleZie4Yv9pz4UrZluJ0UUOBhGEcONprveuYDWTgEVFN57
         qOv/sDYgLlNOpcVhbLUoPo/1ZPIjmjSxOSMBgRgmjDd6m+3oagIH2id2pXV7srDy9khv
         eSF8QJ7ypPtOcTc8pTn/rxVaq/RgoWRAAHAdFrPYpRfqP+UbcNIRzRFRUKCsNeGygwRw
         YYXB3L3WrBNDKQRYcDKdxDETCIWDKTCbe7IxW3/qcGBCJRuUyPlkDJ+eJHoIO0Drnax8
         vu8ypZXgAEYdGqGcmSLjKuIFw7GIqhIIdZKfzxmOVzkKsvsoLI1MqWT7EWPKZXQ1zdXy
         +8zA==
X-Forwarded-Encrypted: i=1; AJvYcCUkfUuC0S/3mfC2CIFJwRFx1nZXujmmDEYKc93tuj3grWGGCjfybi6ZwWfGPDCT7QKd41Wpqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNpChHfaSxq4PpU3peqU07x5EL51om0dqiWeqvbCKDT1ONMy73
	YlefE5hBjRLTVz5fu/GSroE7J7hpaSfUdX1c/8B9TiSOx0LAee3hwXoMqvG3NwqfcKf3fNwQXy/
	A4YrytKL1bsx6ampHQPmY0vKGm7uK+oh+CHU9
X-Gm-Gg: ASbGncuwRveRX2m4YLAOAuXYZw+Hht182XEZg6IUYtijNuH+u0ESRAi+9cm1xMsqECs
	jtImOvJwArU3v8TfoEb9Utpr2R4ksdzu5y3zbd7BlAb+NgiuyubYrbihzf03BqFWm7G/OJcBpQy
	JbqMTrchMQLx8tEDX48ygNWREaRRWNZOoeECs=
X-Google-Smtp-Source: AGHT+IHWfL0gNuJ6EJNGPAsECWaw4y3CGswKWAtdXB9K42viAwFE6sClJNzEmP9KxXInz5pbHpJUQr+no+g42Lj1kgU=
X-Received: by 2002:a05:622a:4c14:b0:477:160:846a with SMTP id
 d75a77b69052e-4771f4745d9mr487561cf.1.1742510032492; Thu, 20 Mar 2025
 15:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250319004254.2547950-1-praan@google.com> <20250319004254.2547950-4-praan@google.com>
In-Reply-To: <20250319004254.2547950-4-praan@google.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Thu, 20 Mar 2025 22:33:41 +0000
X-Gm-Features: AQ5f1Jr0ITyPiAJLC9l8-nJANfuaYTCAhOZutM8VRVTJ8j6NuNEJS6_fc6Zn7ZU
Message-ID: <CAFgf54pNbmb75LKnaqbD4o9xZF4sm7ssrki1Srq-mYfrVJwBAQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 12:43=E2=80=AFAM Pranjal Shrivastava <praan@google.=
com> wrote:
>
> Implement pm_runtime and system sleep ops for arm-smmu-v3. The smmu is
> disabled as part of the suspend callbacks after ensuring the completion
> of all pending commands and is configured to abort any transactions that
> happen after disabling the smmu. The smmu shall be reinitialized in the
> resume callback by invoking the `arm_smmu_device_reset` helper.
>
> The MSIs are freed as part of the suspend and are re-allocated during
> the resume operation.
>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 106 ++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   2 +
>  2 files changed, 108 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index f65d9bca0392..caf750470772 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -26,6 +26,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-ats.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/string_choices.h>
>  #include <kunit/visibility.h>
>  #include <uapi/linux/iommufd.h>
> @@ -108,6 +109,32 @@ static const char * const event_class_str[] =3D {
>
>  static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
>
> +static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> +{
> +       int ret;
> +
> +       if (pm_runtime_enabled(smmu->dev)) {
> +               ret =3D pm_runtime_resume_and_get(smmu->dev);
> +               if (ret < 0) {
> +                       dev_err(smmu->dev, "Failed to resume device: %d\n=
", ret);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> +{
> +       int ret;
> +
> +       if (pm_runtime_enabled(smmu->dev)) {
> +               ret =3D pm_runtime_put_autosuspend(smmu->dev);
> +               if (ret < 0)
> +                       dev_err(smmu->dev, "Failed to suspend device: %d\=
n", ret);
> +       }
> +}
> +
>  static void parse_driver_options(struct arm_smmu_device *smmu)
>  {
>         int i =3D 0;
> @@ -4850,6 +4877,84 @@ static void arm_smmu_device_shutdown(struct platfo=
rm_device *pdev)
>         arm_smmu_device_disable(smmu);
>  }
>
> +
> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> +{
> +       struct arm_smmu_device *smmu =3D dev_get_drvdata(dev);
> +
> +       /* We might get the vcmdq */
> +       struct arm_smmu_cmdq_ent cmd =3D {
> +               .opcode =3D smmu->features & ARM_SMMU_FEAT_E2H ?
> +                       CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
> +       };
> +
> +       struct arm_smmu_cmdq *cmdq =3D arm_smmu_get_cmdq(smmu, &cmd);
> +       struct arm_smmu_ll_queue *llq =3D &cmdq->q.llq;
> +
> +       /*
> +        * Since suspend is invoked when all clients have been
> +        * we don't expect more commands to be added to the cmdq.
> +        * Thus, wait for all existing commands to complete.
> +        */
> +       arm_smmu_cmdq_shared_lock(cmdq);
> +       arm_smmu_cmdq_poll_until_empty(smmu, cmdq, llq);
> +       arm_smmu_cmdq_shared_unlock(cmdq);
> +
> +       /* Disable all queues */
> +       arm_smmu_device_disable(smmu);
> +
> +       /* Abort all transactions to avoid spurious bypass */
> +       arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> +
> +       /* Free all MSIs (re-allocated on resume) */
> +       arm_smmu_free_msis(dev);
> +
> +       dev_dbg(dev, "Suspending smmu\n");
> +       return 0;
> +}
> +
> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> +{
> +       int ret;
> +       struct arm_smmu_device *smmu =3D dev_get_drvdata(dev);
> +
> +       dev_dbg(dev, "Resuming device\n");
> +
> +       /*
> +        * The reset will re-initialize all the queues with the base addr=
,
> +        * prod and cons maintained within struct arm_smmu_device as well=
 as
> +        * re-wire the IRQs and/or enable MSIs and install relevant handl=
ers.
> +        */
> +       ret =3D arm_smmu_device_reset(smmu);
> +
> +       if (ret)
> +               dev_err(dev, "Failed to reset during resume operation: %d=
\n", ret);
> +
> +       return ret;
> +}
> +
> +static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
> +{
> +       if (pm_runtime_suspended(dev))
> +               return 0;
> +
> +       return arm_smmu_runtime_suspend(dev);
> +}
> +
> +static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> +{
> +       if (pm_runtime_suspended(dev))
> +               return 0;
> +
> +       return arm_smmu_runtime_resume(dev);
> +}
> +
> +static const struct dev_pm_ops arm_smmu_pm_ops =3D {
> +       SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_pm_suspend, arm_smmu_pm_resume)

I guess, as there is no specific logic in the system suspend/resume handler=
s,
SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
would be enough?

Thanks,
Mostafa

> +       SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
> +                          arm_smmu_runtime_resume, NULL)
> +};
> +
>  static const struct of_device_id arm_smmu_of_match[] =3D {
>         { .compatible =3D "arm,smmu-v3", },
>         { },
> @@ -4866,6 +4971,7 @@ static struct platform_driver arm_smmu_driver =3D {
>         .driver =3D {
>                 .name                   =3D "arm-smmu-v3",
>                 .of_match_table         =3D arm_smmu_of_match,
> +               .pm                     =3D &arm_smmu_pm_ops,
>                 .suppress_bind_attrs    =3D true,
>         },
>         .probe  =3D arm_smmu_device_probe,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.h
> index bd9d7c85576a..6bac83a511e2 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -505,6 +505,8 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsi=
gned int ssid)
>  #define MSI_IOVA_BASE                  0x8000000
>  #define MSI_IOVA_LENGTH                        0x100000
>
> +#define RPM_AUTOSUSPEND_DELAY_MS       15
> +
>  enum pri_resp {
>         PRI_RESP_DENY =3D 0,
>         PRI_RESP_FAIL =3D 1,
> --
> 2.49.0.rc1.451.g8f38331e32-goog
>
