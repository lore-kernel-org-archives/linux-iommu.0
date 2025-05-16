Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0421519AC;
	Fri, 16 May 2025 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747404778; cv=none; b=ulivxSdPRue1mn27F/S0KjAoADgorAPKZFUoe6ksez2BpwVEgipUZ8iaXC7WK5I9JBZgSdLQX1B8zpeSEp+EHw9C65NxuGOD+p0qq5bX8OtPx9eVkEEJUCQyF0idJZnQ9rVLJWq94vo2g2LSNFIzZWuXPclnONxplojn45F1wDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747404778; c=relaxed/simple;
	bh=M40WfWlk5YMTEsDWr5cABgdKxkUNV407DW73Q7i7IeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVXSOaYWGSmTSFFngbe45qa84aRJ1L9Rwfk1qZkp3/WUITmhtHJxigXMLRJX5H2bmW2pTXSsnoMGSfO8EJTj20LMxqCtuKu6lqZwcFneiFfxvDBTN7IAep6MKwBAxBP9dAmDaGQA15b3PkPlBS239jOKg1pKXIvStuomF+hR5Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAZaY/4C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAZaY/4C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D06FC4CEF2;
	Fri, 16 May 2025 14:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747404778;
	bh=M40WfWlk5YMTEsDWr5cABgdKxkUNV407DW73Q7i7IeI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NAZaY/4CpF0feR2rflVvHns81UR7MQacqaPo/ql/3FOQ/wRMlyVUzX9OLlk8Z780h
	 NW0WIOojV892uYO1oRts59Uae2uXosWs5rDCcNJrHvPAEzpASW5gRkcO15ihuNQ3at
	 KX9s3XBPMmzxHMHBJhzxW1hyAiAykGXi7Oh3DnBL2KtsUabczzEcEqWdt6m3ETc+3s
	 K1FgLClCRQdSGC4eee5Y8D3u8Qr+VT70nEQvZw5aaKYA/R3v5nSxaon5aGmwNFBmcP
	 rvoHyWrXkkPNIzeBK1/OPZrDi3qTb8d5Q9hxTm5wiIq9YBjh70bAxKmlJsq+5cWVM5
	 /UhI6clSoea4Q==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-60402c94319so1572926eaf.1;
        Fri, 16 May 2025 07:12:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWAYn3IT5me4liEcVjBdQcVcnN4GWGRevOBz8nPN8aLEb0WxOXA1wBLIEHpl3atls1JFoHQhJM=@lists.linux.dev, AJvYcCXqzqUSZOQDC8TfmNUSgzkXt/ffkK1eRpAuveDWQ2S3S2GgmHwic0RKuTZUJTb5EOBjXwxUTBJ+9G9SF2I=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7tiOL0hhOI3vCSsINPMY4vD4GExYmoeAvNmjY6dp9v3/5Lm0b
	ramJWqvAjr2I7DfbOv1+Mm0DgVDWASY7nsUxZT0jWRrZwsHmTJ2qxcOUoSmZTRztdyCSkV1ISee
	FZ28d2OrO1xNIN9RBr+wXMm4odi+Qtxc=
X-Google-Smtp-Source: AGHT+IGupjLPJfmTwVsmvNg0fAfU7DGdQNDawRspJaseP9wgN7f5DAnJ+5/LOf3oSCS/IGTVEHVkkx5+Ray2I6WcuTI=
X-Received: by 2002:a05:6820:1908:b0:606:361b:52ad with SMTP id
 006d021491bc7-609f3731c3bmr2140452eaf.3.1747404777502; Fri, 16 May 2025
 07:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250514055723.1328557-1-sunilvl@ventanamicro.com> <20250514055723.1328557-2-sunilvl@ventanamicro.com>
In-Reply-To: <20250514055723.1328557-2-sunilvl@ventanamicro.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 May 2025 16:12:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hGVYyHX7ZQPQ5XNrHBBy9jfA+WMLu7XaoXAqr3s4dOfg@mail.gmail.com>
X-Gm-Features: AX0GCFsH-bwqQdQsyTXD9jznFAfsf5DgDdkDatIcIuRAOxRJWF942Z9YbvDa2JI
Message-ID: <CAJZ5v0hGVYyHX7ZQPQ5XNrHBBy9jfA+WMLu7XaoXAqr3s4dOfg@mail.gmail.com>
Subject: Re: [PATCH 1/4] ACPICA: actbl2: Add definitions for RIMT
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev, 
	acpica-devel@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Anup Patel <apatel@ventanamicro.com>, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 7:57=E2=80=AFAM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> ACPICA commit 73c32bc89cad64ab19c1231a202361e917e6823c
>
> RISC-V IO Mapping Table (RIMT) is a new static table defined for RISC-V
> to communicate IOMMU information to the OS. The specification for RIMT
> is available at [1]. Add structure definitions for RIMT.
>
> [1] - https://github.com/riscv-non-isa/riscv-acpi-rimt
>
> Link: https://github.com/acpica/acpica/commit/73c32bc8
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

An analogous patch is present in linux-next already as

ced63370237a ACPICA: actbl2: Add definitions for RIMT

No need to send this again.

> ---
>  include/acpi/actbl2.h | 83 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 2e917a8f8bca..99ea8bfe47de 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -50,6 +50,7 @@
>  #define ACPI_SIG_RAS2           "RAS2" /* RAS2 Feature table */
>  #define ACPI_SIG_RGRT           "RGRT" /* Regulatory Graphics Resource T=
able */
>  #define ACPI_SIG_RHCT           "RHCT" /* RISC-V Hart Capabilities Table=
 */
> +#define ACPI_SIG_RIMT           "RIMT" /* RISC-V IO Mapping Table */
>  #define ACPI_SIG_SBST           "SBST" /* Smart Battery Specification Ta=
ble */
>  #define ACPI_SIG_SDEI           "SDEI" /* Software Delegated Exception I=
nterface Table */
>  #define ACPI_SIG_SDEV           "SDEV" /* Secure Devices table */
> @@ -3002,6 +3003,88 @@ struct acpi_rhct_hart_info {
>         u32 uid;                /* ACPI processor UID */
>  };
>
> +/***********************************************************************=
********
> + *
> + * RIMT - RISC-V IO Remapping Table
> + *
> + * https://github.com/riscv-non-isa/riscv-acpi-rimt
> + *
> + ***********************************************************************=
*******/
> +
> +struct acpi_table_rimt {
> +       struct acpi_table_header header;        /* Common ACPI table head=
er */
> +       u32 num_nodes;          /* Number of RIMT Nodes */
> +       u32 node_offset;        /* Offset to RIMT Node Array */
> +       u32 reserved;
> +};
> +
> +struct acpi_rimt_node {
> +       u8 type;
> +       u8 revision;
> +       u16 length;
> +       u16 reserved;
> +       u16 id;
> +       char node_data[];
> +};
> +
> +enum acpi_rimt_node_type {
> +       ACPI_RIMT_NODE_TYPE_IOMMU =3D 0x0,
> +       ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX =3D 0x1,
> +       ACPI_RIMT_NODE_TYPE_PLAT_DEVICE =3D 0x2,
> +};
> +
> +struct acpi_rimt_iommu {
> +       u8 hardware_id[8];      /* Hardware ID */
> +       u64 base_address;       /* Base Address */
> +       u32 flags;              /* Flags */
> +       u32 proximity_domain;   /* Proximity Domain */
> +       u16 pcie_segment_number;        /* PCIe Segment number */
> +       u16 pcie_bdf;           /* PCIe B/D/F */
> +       u16 num_interrupt_wires;        /* Number of interrupt wires */
> +       u16 interrupt_wire_offset;      /* Interrupt wire array offset */
> +       u64 interrupt_wire[];   /* Interrupt wire array */
> +};
> +
> +/* IOMMU Node Flags */
> +#define ACPI_RIMT_IOMMU_FLAGS_PCIE      (1)
> +#define ACPI_RIMT_IOMMU_FLAGS_PXM_VALID (1 << 1)
> +
> +/* Interrupt Wire Structure */
> +struct acpi_rimt_iommu_wire_gsi {
> +       u32 irq_num;            /* Interrupt Number */
> +       u32 flags;              /* Flags */
> +};
> +
> +/* Interrupt Wire Flags */
> +#define ACPI_RIMT_GSI_LEVEL_TRIGGERRED  (1)
> +#define ACPI_RIMT_GSI_ACTIVE_HIGH       (1 << 1)
> +
> +struct acpi_rimt_id_mapping {
> +       u32 source_id_base;     /* Source ID Base */
> +       u32 num_ids;            /* Number of IDs */
> +       u32 dest_id_base;       /* Destination Device ID Base */
> +       u32 dest_offset;        /* Destination IOMMU Offset */
> +       u32 flags;              /* Flags */
> +};
> +
> +struct acpi_rimt_pcie_rc {
> +       u32 flags;              /* Flags */
> +       u16 reserved;           /* Reserved */
> +       u16 pcie_segment_number;        /* PCIe Segment number */
> +       u16 id_mapping_offset;  /* ID mapping array offset */
> +       u16 num_id_mappings;    /* Number of ID mappings */
> +};
> +
> +/* PCIe Root Complex Node Flags */
> +#define ACPI_RIMT_PCIE_ATS_SUPPORTED   (1)
> +#define ACPI_RIMT_PCIE_PRI_SUPPORTED   (1 << 1)
> +
> +struct acpi_rimt_platform_device {
> +       u16 id_mapping_offset;  /* ID Mapping array offset */
> +       u16 num_id_mappings;    /* Number of ID mappings */
> +       char device_name[];     /* Device Object Name */
> +};
> +
>  /***********************************************************************=
********
>   *
>   * SBST - Smart Battery Specification Table
> --
> 2.43.0
>
