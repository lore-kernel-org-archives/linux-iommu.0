Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5C8385D7A
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 04:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788410733; cv=pass; b=glGDp2YjR8P0dxu4DiMhUD1aGn0F7Y+MHmOKWGI04XLtJJEaybYNpjoseQuvK56bu6UlbiLHnRdwJeDq0aTM19vUX8vjHK9dP8DA3glx1x/e7beDVyO/oau6bp9M7vyfzNdV6FJrFDPk87S6UwoHn3svahRPM0GCLdLYYSyK2X0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788410733; c=relaxed/simple;
	bh=zI+ifEyxByjM6Y9TrkSsIST3zFDRCsE93qCLJwvC3Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEbhKCBqAkQvxDHOM1W24vVHaGKcytqmOaugQgcsiwP+VLlSoHo5bk7kiXsVaU28pW2aTe5sTqeXgIb0iTK1Y63Hgh96MrHAfgICRKDtxGvCvB01gSSK1+ZcEDWNnllQnUtiBFxSlx9vPGrFyzQVqMw5VLWh0EQU8LJmOrkryTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GT6WQFDv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ii2sCYcM; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GT6WQFDv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ii2sCYcM"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6832xtvd2813965
	for <iommu@lists.linux.dev>; Thu, 3 Sep 2026 04:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=Sc3WkFAgGyNV3trhZQm/9QMD1pz+GBXUg/MNSusqdCk=; b=GT
	6WQFDv9pLArywxCmT3lPlnoXr2OAUvu7mqcefxYUUQuUunKAa5VlMOYVhi1XHofF
	wNp7i1KmIYwmZiVe735eI4cQHXKDmCFkr6yMJdPFaUc/NwzdHYyHYzUClpEYYgie
	yvQv0yMi4H5DAe8jPsq4Xb1aXKV4a4AH592GoLt4RMYMq86gHdsyJ2gaU4UQGByS
	b0gSWRpCIJPxNqaNqfgiDWP0Df9bwLAp4TI28lcvgSpD55UJxpE/3ynVVsLXxaJv
	k02kp6hfeHLbzushzd7gKW96sI6q7AiOPsWX1ak+MOq2YWPSgXTkCDWH4aKaFCvG
	hVD2/xRAwJBROlTjq2IQ==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemj4uevb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 03 Sep 2026 04:45:30 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66cf1803125so2222161d50.0
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 21:45:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788410730; cv=none;
        d=google.com; s=arc-20260327;
        b=PaKeRHXH0Wy3VnpUYHXkiL0ZUzDV3rgvJaSE90cSlnUbKVl9QdJ9FEev1g0+MnQLdh
         s0qrqJJqQK7VM4H4yDwHD3BBrWvzD2ejUxuswytAlgDv9NCtOzOyjXPzO6kGitNneyZ8
         Yy8Yv011ILjObyvN9GOkL63q/9iMOW2CoEl5zq0GDhWF3ZXMgZefyXJGwr9OeW8tNNVn
         wn/DjA6GoJJvSb846M15jL8J9Zgx5OMrDaRcdL6N7wd1Ifx676OrTroLkuXUiAym3Ma5
         eY3mefiunBg8EZ4bqGhjBEGE46qJCiz3lZKQc87BjmQZZWJ9geZHxoNk5nMQIhAskHYr
         mTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=Sc3WkFAgGyNV3trhZQm/9QMD1pz+GBXUg/MNSusqdCk=;
        fh=Zg/u+tNsBYUFlD6cHofPq41rUSz7raAPyqkNPDEjbSU=;
        b=Pt+2Vt4UWZfyywcV0KuSZxKAL+jbUUmsoFqjNBQ2O/9N0iLi4Kp5bKzfse8fnJy3JI
         xcp1iP8KlULuXgPQuX88YKG00D3Qoo7dCZhLhjhCI/2c+lSBOUtDQaP0sXd2+yT/q1ID
         b+Ccq6NsJsNKu2DAJRC+bSUN5jcZoKMeoADeZNVTsJEg2j2BomwzTampyqthEcbksORF
         V0feJhehik6j6J2ovXtprNtxexcW7MSRGnjdB19Nx8Rs3HMK1w2TkyTj8JFq70I6jRok
         IcNZOzAG55wJGieHVdUeGLFh3oTQFaDwwi598t7YAh5xGRZdKtZ/MT30DY2Zjcu4xFjV
         Dx4g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788410730; x=1789015530; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Sc3WkFAgGyNV3trhZQm/9QMD1pz+GBXUg/MNSusqdCk=;
        b=ii2sCYcMuAdGjpPRfnlIVbfgzHnQjN7bLrywoa1VrZ7PML1uHlTx+GryVhhzKMJXI8
         z6xPl9CXObsIRH7aIXanHyvW4rjDmSb0sXVPhr9x4/P8wCN/6MDj8sSyd8TsS75XNtgG
         tRGflh+gFq2VK4DYHHebGCKeLxHTrHFA7PmHq9WuGvtumveB1H0McR8WQxd3niPCtaQK
         QqQZc06X8OZ4DQ6J6bVjqcLJUK5FBmpWospjK+Wjt0Dm55Tqee8yK7rykFWnv2qQ1bTQ
         NckBtmVNKV0l4D1LIj62NpFmhXaDqJFJOnfobBQA1AdVSccReM7oXLdjlXBxInp8pSkY
         PxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788410730; x=1789015530;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sc3WkFAgGyNV3trhZQm/9QMD1pz+GBXUg/MNSusqdCk=;
        b=qrvqEowXVEpGidVEW6kUj2OxIzayXgpU1Yl1kWMNTF/EdUNjm89H6uxAo3QQ/lrimF
         6cLEyqVKTOpQLeh9Ox1XgeZAp2m/5pKFNaXcmPl0TmFwKDKnhLZRO2/rbjzI4cXYNBEL
         E+UOZRErVcssX2pmlozV9DG/DAIMzyIZ/BRLu4Qv0gJncQk7PNQnc16chmFlSs4jeIfX
         /Mae0qYqCb8EkwJi5LwdXviD0YUWVuOuC0OWm5LsfhGtWmriDCr3j79+zVXBg7I+nkmb
         cqb6YNkXmIUnzVvaa700RBgBEJr68kGxOvf5HTHh+cRLzNeJNc33xaoRRfISqK09nsf6
         ULTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxB+u1ytCvjxQharBU0IB8C+kQXYGasTdBKHyA4USpBJ+TjMTXAVXinB1YQwk3Nienpdfcu2w==@lists.linux.dev
X-Gm-Message-State: AFuF++kZDWlcrvVmkR7VzhQb/Kz6+3Q3E3mX8uZ1jdDhq9GTVGeaCHcK
	V2IWyL/z8WsAUHxvbkdu05Z3zBr2lik6vCR5+pz3B98GNEoxCWKOj9lcg6aUfS6sVauWVRE0qni
	l2fi3hPTSW9f9tFFNh8dXRP6w2b8k0A81Iwdp+4LB/Orb23QpbFx83n0Q+PlGIDFMxmTtVeXq32
	o9EmSHciP6bHqfeKDTnfMMsKlTRXsBckHV
X-Gm-Gg: AYBFou0wkmfdJUKfy7nmpVtEVj5ZRFgkXBvNnNjtH1zZpOObSpkC56i6SO0lfFkRyCs
	YjPr03vqsO6i3qrKei6uVrkTDF62HjcQkC/YA0Dt2daYC7ska/CljrMZQyRQBCyZOFMwCCbQ3Pm
	je13ZMn8+OV9qyKDM3WVx91v/AzbbNvnwBfEt+iuP6TZLWPRLXvlJeh6B6aw==
X-Received: by 2002:a53:ac93:0:b0:66c:85e3:7f28 with SMTP id 956f58d0204a3-66f9be6b625mr3646106d50.48.1788410730265;
        Wed, 02 Sep 2026 21:45:30 -0700 (PDT)
X-Received: by 2002:a53:ac93:0:b0:66c:85e3:7f28 with SMTP id
 956f58d0204a3-66f9be6b625mr3646094d50.48.1788410729854; Wed, 02 Sep 2026
 21:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260902140145.42094-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260902140145.42094-1-fangyu.yu@linux.alibaba.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 10:15:18 +0530
X-Gm-Features: AcwNN1UQoEUyCiHFoU50MMSvS7TZQc6s0bZHcLqzyxXDTbBAI2PWHTUKR2JHNJY
Message-ID: <CAB19ukHwcDnApuWcn4MWm=bJZS2=UqbLT2=MnpfsJePG=qA_wA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: RIMT: Enable PCI ACS for root complexes mapped to
 an IOMMU
To: fangyu.yu@linux.alibaba.com
Cc: sunilvl@ventanamicro.com, rafael@kernel.org, lenb@kernel.org,
        pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        alex@ghiti.fr, guoren@kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAzOSBTYWx0ZWRfXx6GkRMt0TeFU
 nrf5sG8MhibbpkeY7UuQlQGeqg3LzrOwFUX9pQarQZgA5faQ6167aSRrHzHgl45fudwc/skyYF3
 Omix4Gi3bBj+P7FNaeefiRDBXAutyJ4S29j7l2ebm3Akuxd0iXUn724yrJyX+5NogoDBFMeSAPZ
 /Yqc7inYfLmhLcsqkHXSuSWv41MthxBwE85wzlMSEVhrtykiuS2BgRtyM8ZTxGVGVmNaYQfo9n5
 w5PvawvFvPFevshIFgLRzrcHF2IA7ywETpZKpPId86LnREWXlaYr9YtgM7qJlzwyON2tGLWljB0
 hliv/AqRf11uo8QL/EZlKFDO+xtm2aYi2SU27QhLsnUrFom7LtJz18LIh8eVJi1W/wZJ7d9ka6A
 SoDUIanthCFlZqGg4drP3s6tCHstD50zMhQpzJhy/6EsWtual2P4r7CtxJI8ag3uoLYpX5W21GJ
 CGkKwTOQq4OiqvpLsHg==
X-Proofpoint-ORIG-GUID: WKAhtLbmMOCA70O8P9O1HLaNYgWAybQK
X-Authority-Analysis: v=2.4 cv=MdhcfZ/f c=1 sm=1 tr=0 ts=6a98fb6a cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8
 a=wQ6y6Ln1IUvFgne-YVsA:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-GUID: WKAhtLbmMOCA70O8P9O1HLaNYgWAybQK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDAzOSBTYWx0ZWRfXwoLjumdvn9Fy
 dm5Qs0MPkyLY8ZSaD/qURl47JsqHQabNE0XyYLPBS9PsaGK2LeEpYHSa325jzQkTuBY6MTgg8Wv
 dFjmZcsnCTBhIjoXSCbKgxG5xThYukE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_01,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030039

On Wed, Sep 2, 2026 at 7:31=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Mirror the ACPI IORT solution used on arm64 (see iort_enable_acs())
> by scanning the RIMT table for PCIe root complex nodes during
> riscv_acpi_rimt_init(), which runs before ACPI PCI enumeration. If a
> root complex node's ID mapping points at an IOMMU node, call
> pci_request_acs() immediately, so pci_acs_enable is already set by
> the time any PCI device is scanned and pci_enable_acs() runs.
>
> Only one call to pci_request_acs() is needed regardless of how many
> root complexes are found, so track that with a static acs_enabled
> flag, same as iort_enable_acs() does.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/acpi/riscv/rimt.c | 56 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
> index e4538fa6c2c8..f22e28c8211e 100644
> --- a/drivers/acpi/riscv/rimt.c
> +++ b/drivers/acpi/riscv/rimt.c
> @@ -179,6 +179,42 @@ static struct acpi_rimt_node *rimt_scan_node(enum ac=
pi_rimt_node_type type,
>         return NULL;
>  }
>
> +#ifdef CONFIG_PCI
> +static void __init rimt_enable_acs(struct acpi_rimt_node *rimt_node)
> +{
> +       static bool acs_enabled __initdata;
> +       struct acpi_rimt_pcie_rc *pci_rc;
> +       struct acpi_rimt_id_mapping *map;
> +       struct acpi_rimt_node *parent;
> +       int i;
> +
> +       if (acs_enabled || rimt_node->type !=3D ACPI_RIMT_NODE_TYPE_PCIE_=
ROOT_COMPLEX)
> +               return;
> +
> +       pci_rc =3D (struct acpi_rimt_pcie_rc *)rimt_node->node_data;
> +       if (!pci_rc->id_mapping_offset || !pci_rc->num_id_mappings)
> +               return;
> +
> +       map =3D ACPI_ADD_PTR(struct acpi_rimt_id_mapping, rimt_node,
> +                          pci_rc->id_mapping_offset);
> +
> +       for (i =3D 0; i < pci_rc->num_id_mappings; i++, map++) {
> +               if (!map->dest_offset)
> +                       continue;
> +
> +               parent =3D ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table=
,
> +                                     map->dest_offset);
> +               if (parent->type =3D=3D ACPI_RIMT_NODE_TYPE_IOMMU) {
> +                       pci_request_acs();
> +                       acs_enabled =3D true;
> +                       return;
> +               }
> +       }
> +}
> +#else
> +static inline void rimt_enable_acs(struct acpi_rimt_node *rimt_node) { }
> +#endif
> +
>  /*
>   * RISC-V supports IOMMU as a PCI device or a platform device.
>   * When it is a platform device, there should be a namespace device as
> @@ -509,7 +545,10 @@ int rimt_iommu_configure_id(struct device *dev, cons=
t u32 *id_in)
>
>  void __init riscv_acpi_rimt_init(void)
>  {
> +       struct acpi_rimt_node *rimt_node, *rimt_end;
> +       struct acpi_table_rimt *rimt;
>         acpi_status status;
> +       int i;
>
>         /* rimt_table will be used at runtime after the rimt init,
>          * so we don't need to call acpi_put_table() to release
> @@ -525,4 +564,21 @@ void __init riscv_acpi_rimt_init(void)
>
>                 return;
>         }
> +
> +       rimt =3D (struct acpi_table_rimt *)rimt_table;
> +       rimt_node =3D ACPI_ADD_PTR(struct acpi_rimt_node, rimt,
> +                                rimt->node_offset);
> +       rimt_end =3D ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table,
> +                               rimt_table->length);
> +
> +       for (i =3D 0; i < rimt->num_nodes; i++) {
> +               if (rimt_node >=3D rimt_end) {
> +                       pr_err("RIMT node pointer overflows, bad table\n"=
);
> +                       return;
> +               }
> +
> +               rimt_enable_acs(rimt_node);
>
NIT: Can we check here itself if it is a PCI RC node and then only
call enable_acs()?

> +               rimt_node =3D ACPI_ADD_PTR(struct acpi_rimt_node, rimt_no=
de,
> +                                        rimt_node->length);
> +       }
>  }
> --
> 2.50.1
>
Otherwise, LGTM.

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
