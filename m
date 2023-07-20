Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D822FA35
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 17:47:52 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5440e98616cso1566869a12.0
        for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 10:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689875272; x=1690480072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeRtmaYTAPyRY4aCeM38ToCVz+RzHutrGkJCqmGIdOc=;
        b=VN4kSEn7Ij6Jb7Boit8qxzz8hu77UOlfTYQHpith3ypcF9dbr8xWuknkAmP8IvhxBt
         LSx9B51i2TsdB+RUriiJWHvSRCwVRBNb/OI0bv4fZ/ddJi9e7EqZDdUFRo7TczeEC+of
         URUI2buBPQWpMuUbL5yFNjv3VfjFHoK6KfHtE3V0FBlLSVS1/fJkaVvbpoFsooaHkONk
         IiFE6+Rr2ppLX1fM4YPj6b3txnVsbIyOeLireIiBSPXqxXZkVMydnEz+QuohTe2sTnjg
         S5IjI4CkxDg5Hq6JKbejvTXX4S9QbaToU/WxyTcuWJ+ESMkC7DDIWj4BZafziobkSX7k
         soOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689875272; x=1690480072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeRtmaYTAPyRY4aCeM38ToCVz+RzHutrGkJCqmGIdOc=;
        b=WxOwMp7A+SO3Nljmdbon+tGyYptod+WRlOUNUSI2extrT6hNNy3zjRWrryLwSPEZjU
         Nz7mhZufETq8/LtF1JP59SZVVBNDP8MlnVg4zHVnIg9Z5FkWLCzrt52RqlFzH6AemBA9
         J2zDxz/J819g+fUv/4fHWlYJRWyVvjQ68ygARLVouMuZXgyzCCCJXJ1Vw6umqphXLTVr
         iphjhtdlSveDgzM8o2BO1ZFeyY+ab0FHcvsZ1+45aB6FgwJvLMVwd04CyNJP5d43PoNt
         SIdkfS7BM/zwY1X11eGN9tSXvZRIeec/qi6s2Cc/xkomJvDajiI6Rse1aD54VxHXib92
         HMYA==
X-Gm-Message-State: ABy/qLb5Zifc9jefeLP5rJyetbEP0H+RFld5oZRJ3GtClQScJHKRq1zA
	DRstnhMBK0KPqKSbax29GD4DFXwzaG6ne3cA9cmQmQ==
X-Google-Smtp-Source: APBJJlHy5UEy2yIQNNS3I4ewj2XdSdHRI6Php31TNjCHwslBISu4YslmtmapMSbRvm/h863Rb7ly70c0/Q+NZJYe7/k=
X-Received: by 2002:a17:90a:8b81:b0:256:675f:1d49 with SMTP id
 z1-20020a17090a8b8100b00256675f1d49mr120295pjn.0.1689875271671; Thu, 20 Jul
 2023 10:47:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <610abe685f90870be52bc7c2ca45ab5235bd8eb4.1689792825.git.tjeznach@rivosinc.com>
 <2556751a-c439-bb69-a102-583dd985fc5e@linux.intel.com>
In-Reply-To: <2556751a-c439-bb69-a102-583dd985fc5e@linux.intel.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Thu, 20 Jul 2023 10:47:40 -0700
Message-ID: <CAH2o1u7WO=Kpki1qMGoq3uJ2vVqhCvffvX0hLGc7o9op2vTCbw@mail.gmail.com>
Subject: Re: [PATCH 05/11] RISC-V: drivers/iommu/riscv: Add sysfs interface
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 5:51=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 2023/7/20 3:33, Tomasz Jeznach wrote:
> > +#define sysfs_dev_to_iommu(dev) \
> > +     container_of(dev_get_drvdata(dev), struct riscv_iommu_device, iom=
mu)
> > +
> > +static ssize_t address_show(struct device *dev,
> > +                         struct device_attribute *attr, char *buf)
> > +{
> > +     struct riscv_iommu_device *iommu =3D sysfs_dev_to_iommu(dev);
> > +     return sprintf(buf, "%llx\n", iommu->reg_phys);
>
> Use sysfs_emit() please.
>

ack. Thanks, will update.

> > +}
> > +
> > +static DEVICE_ATTR_RO(address);
> > +
> > +#define ATTR_RD_REG32(name, offset)                                  \
> > +     ssize_t reg_ ## name ## _show(struct device *dev,               \
> > +                     struct device_attribute *attr, char *buf)       \
> > +{                                                                    \
> > +     struct riscv_iommu_device *iommu =3D sysfs_dev_to_iommu(dev);    =
 \
> > +     return sprintf(buf, "0x%x\n",                                   \
> > +                     riscv_iommu_readl(iommu, offset));              \
> > +}
> > +
> > +#define ATTR_RD_REG64(name, offset)                                  \
> > +     ssize_t reg_ ## name ## _show(struct device *dev,               \
> > +                     struct device_attribute *attr, char *buf)       \
> > +{                                                                    \
> > +     struct riscv_iommu_device *iommu =3D sysfs_dev_to_iommu(dev);    =
 \
> > +     return sprintf(buf, "0x%llx\n",                                 \
> > +                     riscv_iommu_readq(iommu, offset));              \
> > +}
> > +
> > +#define ATTR_WR_REG32(name, offset)                                  \
> > +     ssize_t reg_ ## name ## _store(struct device *dev,              \
> > +                     struct device_attribute *attr,                  \
> > +                     const char *buf, size_t len)                    \
> > +{                                                                    \
> > +     struct riscv_iommu_device *iommu =3D sysfs_dev_to_iommu(dev);    =
 \
> > +     unsigned long val;                                              \
> > +     int ret;                                                        \
> > +     ret =3D kstrtoul(buf, 0, &val);                                  =
 \
> > +     if (ret)                                                        \
> > +             return ret;                                             \
> > +     riscv_iommu_writel(iommu, offset, val);                         \
> > +     return len;                                                     \
> > +}
> > +
> > +#define ATTR_WR_REG64(name, offset)                                  \
> > +     ssize_t reg_ ## name ## _store(struct device *dev,              \
> > +                     struct device_attribute *attr,                  \
> > +                     const char *buf, size_t len)                    \
> > +{                                                                    \
> > +     struct riscv_iommu_device *iommu =3D sysfs_dev_to_iommu(dev);    =
 \
> > +     unsigned long long val;                                         \
> > +     int ret;                                                        \
> > +     ret =3D kstrtoull(buf, 0, &val);                                 =
 \
> > +     if (ret)                                                        \
> > +             return ret;                                             \
> > +     riscv_iommu_writeq(iommu, offset, val);                         \
> > +     return len;                                                     \
> > +}
>
> So this allows users to change the registers through sysfs? How does
> it synchronize with the iommu driver?
>

The only writable registers are for debug interface and performance
monitoring counters, without any synchronization requirements between
user / driver.  In follow up patch series performance counters will be
also removed from sysfs, replaced by integration with perfmon
subsystem. The only remaining will be a debug access, providing user
access to address translation, in short it provides an interface to
query SPA based on provided IOVA/RID/PASID. There was a discussion in
RVI IOMMU TG forum if it's acceptable to expose such an interface to
the privileged user, and the conclusion was that it's very likely not
exposing more info than privileged users already are able to acquire
by looking at in-memory data structures.

Read-only registers are to provide debug access to track queue
head/tail pointers and interrupt states.

> Best regards,
> baolu

regards,
- Tomasz
