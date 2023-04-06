Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC6ECA
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 08:13:36 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id t10so147192986edd.12
        for <iommu@lists.linux.dev>; Thu, 06 Apr 2023 01:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680768815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lu1ZIi7tBRHWfqxhCGVkyOO/jfdqs/J/p+pYOITBDkU=;
        b=ZsSbhJJ3pKekXGH3l1kAv86u9/s8jGrtjbPMAcs/BEyLEXHZMzE0rtLj9YohhlHY5Z
         F53XyvF8tiFcmLhi5c82QMmvn7AhGiLh/LmvM4vR4JgeQs+i4e8kXDvQp/pjelPyTCGL
         R70lzADyRmjduvx89W327EjXOudBurv1gy/tDrijgDZEu+FqpyIpUUODwkbv9jKt/PHG
         SXhWEL6+1j+oCOtoWHgkhFlK+LHW5ot53HB5b+M/APYoChQ8vuKAzeyrL0gelsOyeoxj
         8QfsrhzA8EdQGWh6gXZzkKnpJ8UB4VsBvQupIzu+h8a0JsmYT8dAlfTdXMhXBCGD8GrN
         G+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680768815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lu1ZIi7tBRHWfqxhCGVkyOO/jfdqs/J/p+pYOITBDkU=;
        b=cCjvT9YsS7utf8MyOwnzv8JS3MH3rYS3D46cVW3WsBGYzlGxuUNHxQdjgOlHCNZJgV
         llWLqmNbD3hWPcjLxz6fU7p1P7iTGnNP8T3pLPgpa/maDqCR4NMmzCr4krSX0R4PKkJo
         PK+EcWvlyNY2a99m46Y1TxCD9gMXBaGeDiZpay+MymZTKq2iL3Zdp27KCryikL3pMOQh
         AzT/HUHnsTYYLBEdjphPswWEesE9J0vLjwTHABCQCjp1gtxVM3HDcfp0XYR/sXbQTaaA
         9sI0Mr8SG/ww50OfXwCD92jugCkGIeEU5PQU/GVFcvg2IqvMGVukDCda0VqI9V+tbJVu
         ohiA==
X-Gm-Message-State: AAQBX9dpeJGF6MfJbEsm/gQAIrx/W5CBVzNC8BjkHSnStbFPSTIQBZtk
	DYesCc1cEPgvAmCgommyF676nZEL+tOCAoe83CY=
X-Google-Smtp-Source: AKy350blbuwNZejN6L/nUpeEwCHeQxxdE8X6OS0Ll1ser07oYVVQatoB0SiGSLUgyWopUY6f6TUg0bPKIo9QxXrzPI8=
X-Received: by 2002:a17:906:1619:b0:878:4a24:1a5c with SMTP id
 m25-20020a170906161900b008784a241a5cmr2824172ejd.6.1680768814664; Thu, 06 Apr
 2023 01:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230329123420.34641-1-tomas.krcka@gmail.com>
In-Reply-To: <20230329123420.34641-1-tomas.krcka@gmail.com>
From: Tomas Krcka <tomas.krcka@gmail.com>
Date: Thu, 6 Apr 2023 10:13:23 +0200
Message-ID: <CAOtnYZPfy3AuB-B2O_VCFy9Amt18PRCg+7f2tvKKYMrwZThtdg@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Acknowledge pri/event queue overflow
 if any
To: will@kernel.org
Cc: Tomas Krcka <krckatom@amazon.de>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mi., 29. M=C3=A4rz 2023 um 14:34 Uhr schrieb <tomas.krcka@gmail.com>:
>
> From: Tomas Krcka <krckatom@amazon.de>
>
> When an overflow occurs in the PRI queue, the SMMU toggles the overflow
> flag in the PROD register. To exit the overflow condition, the PRI thread
> is supposed to acknowledge it by toggling this flag in the CONS register.
> Unacknowledged overflow causes the queue to stop adding anything new.
>
> Currently, the priq thread always writes the CONS register back to the
> SMMU after clearing the queue.
>
> The writeback is not necessary if the OVFLG in the PROD register has not
> been changed, no overflow has occured.
>
> This commit checks the difference of the overflow flag between CONS and
> PROD register. If it's different, toggles the OVACKFLG flag in the CONS
> register and write it to the SMMU.
>
> The situation is similar for the event queue.
> The acknowledge register is also toggled after clearing the event
> queue but never propagated to the hardware. This would only be done the
> next time when executing evtq thread.
>
> Unacknowledged event queue overflow doesn't affect the event
> queue, because the SMMU still adds elements to that queue when the
> overflow condition is active.
> But it feel nicer to keep SMMU in sync when possible, so use the same
> way here as well.
>
> Signed-off-by: Tomas Krcka <krckatom@amazon.de>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index f2425b0f0cd6..7614739ea2c1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -152,6 +152,18 @@ static void queue_inc_cons(struct arm_smmu_ll_queue =
*q)
>         q->cons =3D Q_OVF(q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
>  }
>
> +static void queue_sync_cons_ovf(struct arm_smmu_queue *q)
> +{
> +       struct arm_smmu_ll_queue *llq =3D &q->llq;
> +
> +       if (likely(Q_OVF(llq->prod) =3D=3D Q_OVF(llq->cons)))
> +               return;
> +
> +       llq->cons =3D Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
> +                     Q_IDX(llq, llq->cons);
> +       queue_sync_cons_out(q);
> +}
> +
>  static int queue_sync_prod_in(struct arm_smmu_queue *q)
>  {
>         u32 prod;
> @@ -1577,8 +1589,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, vo=
id *dev)
>         } while (!queue_empty(llq));
>
>         /* Sync our overflow flag, as we believe we're up to speed */
> -       llq->cons =3D Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
> -                   Q_IDX(llq, llq->cons);
> +       queue_sync_cons_ovf(q);
>         return IRQ_HANDLED;
>  }
>
> @@ -1636,9 +1647,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, vo=
id *dev)
>         } while (!queue_empty(llq));
>
>         /* Sync our overflow flag, as we believe we're up to speed */
> -       llq->cons =3D Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
> -                     Q_IDX(llq, llq->cons);
> -       queue_sync_cons_out(q);
> +       queue_sync_cons_ovf(q);
>         return IRQ_HANDLED;
>  }
>
> --
> 2.39.2
>

ping for this patch ...
