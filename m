Return-Path: <SRS0=CQae=6W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3105CC38A2A
	for <iommu@archiver.kernel.org>; Fri,  8 May 2020 19:47:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE94921841
	for <iommu@archiver.kernel.org>; Fri,  8 May 2020 19:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="rMqf/1Fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE94921841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A4A238944A;
	Fri,  8 May 2020 19:47:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VNtOtEhwk4Iz; Fri,  8 May 2020 19:47:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1B65C891A7;
	Fri,  8 May 2020 19:47:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB81DC0865;
	Fri,  8 May 2020 19:47:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C55DCC07FF
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 19:47:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AD4DF875B7
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 19:47:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XvZM-QnZi81Q for <iommu@lists.linux-foundation.org>;
 Fri,  8 May 2020 19:47:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2113.outbound.protection.outlook.com [40.107.237.113])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A363F87582
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 19:47:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dP8wy190byfy45Y8sQwLlwmLCuoM1iTNuL+KQgbgkY99T4rLFofj8DNzKig1IK5xJH6nAzt1N8SBDJlYHa7r8TXyarS9ZNEismnhKvZklePh/KvroniUhZmqAsrrR5KQgoIUxbP8+0bbWjgGrfJxuirEn2JW1M5RZd0sH8wgICGNWgxmxyUP3D2x0EZ+vdZY8JaV30sQatHEHKDFNoH2p57L7HhCoEqjlQN6u+xC6yvGop3ylvoTJjwqBSTemJk5M1lmIRYL8rWvgZFX4MwtMpKxPyhq7PXCfu1mTZJMEhWppe8A2rPFCr75h6y+HHFv1nIn/W/FXN4djEKPkDZGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wQsIJ5a04v7jhzbzzAY7JIIK7DYf/A96HCsJsbXhZc=;
 b=VTyuJfAub/9EC82fTBjNzY6N6sXYH7wu7DoboILi4KAdFnG9rwGqVlZdj+cJD12oqL7mp2fNDvJXs2KRV1ue6J5XKYJbI0BcRqqSxlZude2UssLDBP2x0ZTW2yGlErM2ncALukg2WnUvdK/YKEZEv4dv39E6yoZsGRU2/pJRSMPy9HhM/tfq7jmWXsKB+qmY6607Pt5isJJpVgbA+Fei+efEBz9EKhrotIEB2qBPUqarFi0Zp5iJuoP/ysi/QN19F5+OwWD+unp2any5wyon3mh+XjZS63WTSxYACnBjImkv2M1t4x/phsEnA3N7h0SQvV7hyHKAwpJGj00u43VlwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wQsIJ5a04v7jhzbzzAY7JIIK7DYf/A96HCsJsbXhZc=;
 b=rMqf/1Fzu9wKAzQQffyFbZBkdSTuJiPw8E5mU7+LaPE0mNUC94g35Ro/WzXZuGXcPCQ48k3kDc+fgzj77/07Ya5ifrLjoSEQftKtHTLabYsxINeZWJ7ZkLMJ3KTVyG4zIYKDpr4GUi//YB+HaYQ9vYfCPc5LD6hc5QzG5WdTC14=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none
 header.from=amperemail.onmicrosoft.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB4245.prod.exchangelabs.com (2603:10b6:a03:5d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28; Fri, 8 May 2020 18:13:22 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c%5]) with mapi id 15.20.2979.033; Fri, 8 May 2020
 18:13:22 +0000
From: Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
Message-Id: <84FC4D71-15A2-46D0-9852-8E5219F407EC@amperemail.onmicrosoft.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Don't reserve implementation defined
 register space
Date: Fri, 8 May 2020 11:13:19 -0700
In-Reply-To: <20200506174629.1504153-1-jean-philippe@linaro.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20200506174629.1504153-1-jean-philippe@linaro.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-ClientProxiedBy: CY4PR18CA0053.namprd18.prod.outlook.com
 (2603:10b6:903:13f::15) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.173] (73.151.56.145) by
 CY4PR18CA0053.namprd18.prod.outlook.com (2603:10b6:903:13f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend
 Transport; Fri, 8 May 2020 18:13:20 +0000
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Originating-IP: [73.151.56.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8746b15a-4d7c-4301-94aa-08d7f37b7e17
X-MS-TrafficTypeDiagnostic: BYAPR01MB4245:
X-Microsoft-Antispam-PRVS: <BYAPR01MB4245B52937E6116B1A62DBB1E0A20@BYAPR01MB4245.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 039735BC4E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hu2hYkEMZp55mKSYpU+wDiokUurpUyaFn7lN06jjrnaLo+DXP+yksRWpLzhs5cvpZtwSvBJIn8hCGqQw2hagBcdtDAHra+ThxppKW20F7jKkTRKwHtASBCQ0vqwi6uAGds8U1zg00BETUrz9YU+784rNRRSg9oKMm7eiRvzB9bxW6md6/sIgRDW0JupALCUNnivQR5PvsTuDO6kM6BPiQ6uN/K9PopAzIwX+oyN36+T7XB4kwIJz5UHheeu6og6IqMbl8gInCc0fSX9il6e6NIe+Tzk75YJLB8JlhwU6yCThQz+CRQ9K+a2qHtL0EDcPJvbvt0g6zbbbOEtG2CDL2m2l4iA4PXYMwBtlkBOfrXQ8RoOoHddluFzrhlEvH4ACVzFLUnlDpSKUmivEr/AFgcdZ6x/99nw1ze47NyhMCLOqsLHjv+xDm7iydWFGqeZvLnEcKwGr7l5DurQzBd+4Ez73hVUOdR1cbXlaQ8I7079HDFtR3xkVwpV3OX2A09SzIMorRmpahhH/x0t8HE32PLbpzOi1Fx88AyEpeqqnq++9rZHrlTrsXOdubKyf331WNN2yNYVFXN1RLrprT6AxO4Y12588eNenlTFADFr6idg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR01MB4598.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39840400004)(33430700001)(66946007)(478600001)(33440700001)(166002)(8936002)(26005)(186003)(83170400001)(8676002)(966005)(52116002)(6916009)(33964004)(6486002)(316002)(66476007)(5660300002)(16526019)(33656002)(42882007)(4326008)(83300400001)(16576012)(2616005)(956004)(53546011)(2906002)(66556008)(83310400001)(83320400001)(83290400001)(83280400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wqESBC8a/o5pyy0cVL7i/icf1lvWu0owF0Ai2gn1F0aUeu9Tgcc1n05AhKm0dLp4j1ZUYFsXTXXH71CfokqEduB+W+ALhDC/n4veBKOy60FpJ+syH5jLhoVYE1HC9GtSuN+HsqBPAlv6ufv+ZxQ9VNHLxdkBodp2yUGABomMxDiAA+Fg7IlvpNwCC+svk4R5bjYQEG99R9e9A3mmpcFtcW2zUKfnZDVwTCXPLu/scjaK/EAbPTkY8uaiKqbU3MQ1TYogLi6Z7vcohHka4GycnXahkdqKhSdBNVDYbOPTCJtPf3dcCqoXP6kdW6xi+/JTtV8uLfARxSCH5GZt2fBAtXLyJxDNmKy+XIQWfaild5rcbqVD5OMuA+G+FGI4O8h150iCXRWje4S1C2xndC/Mh4MshINVMtl/R4P2dTIZjnMR6b8GEoIU+0EKBZNATsXfQz/RFcX8DDsVdsdv8V6wI3eLReugIkjgVUKJvaiE3V0=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8746b15a-4d7c-4301-94aa-08d7f37b7e17
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 18:13:22.0906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGOuAesLMh2DwxOIgGg95cfrD2NcjeOOCNX4hPbc8yzKqfKnBOKIUntuA4DAYPY4TmpLApxC6uh9C2eAHhc3yoOXN/dolaq4RYLZrRXPiiRQvvZxQdkGPbIE/fJkfenQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4245
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2059661410035803025=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============2059661410035803025==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_F357CE15-3AFC-4D68-86E3-684210B830CC"

--Apple-Mail=_F357CE15-3AFC-4D68-86E3-684210B830CC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On May 6, 2020, at 10:46 AM, Jean-Philippe Brucker =
<jean-philippe@linaro.org> wrote:
>=20
> Some SMMUv3 implementation embed the Perf Monitor Group Registers =
(PMCG)
> inside the first 64kB region of the SMMU. Since PMCG are managed by a
> separate driver, this layout causes resource reservation conflicts
> during boot.
>=20
> To avoid this conflict, only reserve the MMIO region we actually use:
> the first 0xe0 bytes of page 0 and the first 0xd0 bytes of page 1.
> Although devm_ioremap() still works on full pages under the hood, this
> way we benefit from resource conflict checks.
>=20
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> A nicer (and hopefully working) solution to the problem dicussed here:
> =
https://lore.kernel.org/linux-iommu/20200421155745.19815-1-jean-philippe@l=
inaro.org/
> ---
> drivers/iommu/arm-smmu-v3.c | 50 +++++++++++++++++++++++++++++++++----
> 1 file changed, 45 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 82508730feb7a1..fc85cdd5b62cca 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -171,6 +171,9 @@
> #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
> #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
>=20
> +#define ARM_SMMU_PAGE0_REG_SZ		0xe0
> +#define ARM_SMMU_PAGE1_REG_SZ		0xd0
> +
> /* Common MSI config fields */
> #define MSI_CFG0_ADDR_MASK		GENMASK_ULL(51, 2)
> #define MSI_CFG2_SH			GENMASK(5, 4)
> @@ -628,6 +631,7 @@ struct arm_smmu_strtab_cfg {
> struct arm_smmu_device {
> 	struct device			*dev;
> 	void __iomem			*base;
> +	void __iomem			*page1;
>=20
> #define ARM_SMMU_FEAT_2_LVL_STRTAB	(1 << 0)
> #define ARM_SMMU_FEAT_2_LVL_CDTAB	(1 << 1)
> @@ -733,11 +737,14 @@ static struct arm_smmu_option_prop =
arm_smmu_options[] =3D {
> static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
> 						 struct arm_smmu_device =
*smmu)
> {
> -	if ((offset > SZ_64K) &&
> -	    (smmu->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY))
> -		offset -=3D SZ_64K;
> +	void __iomem *base =3D smmu->base;
>=20
> -	return smmu->base + offset;
> +	if (offset > SZ_64K) {
> +		offset -=3D SZ_64K;
> +		if (smmu->page1)
> +			base =3D smmu->page1;
> +	}
> +	return base + offset;
> }
>=20
> static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain =
*dom)
> @@ -4021,6 +4028,28 @@ err_reset_pci_ops: __maybe_unused;
> 	return err;
> }
>=20
> +static void __iomem *arm_smmu_ioremap(struct device *dev,
> +				      resource_size_t start,
> +				      resource_size_t size)
> +{
> +	void __iomem *dest_ptr;
> +	struct resource *res;
> +
> +	res =3D devm_request_mem_region(dev, start, size, =
dev_name(dev));
> +	if (!res) {
> +		dev_err(dev, "can't request SMMU region %pa\n", &start);
> +		return IOMEM_ERR_PTR(-EINVAL);
> +	}
> +
> +	dest_ptr =3D devm_ioremap(dev, start, size);
> +	if (!dest_ptr) {
> +		dev_err(dev, "ioremap failed for SMMU region %pR\n", =
res);
> +		devm_release_mem_region(dev, start, size);
> +		dest_ptr =3D IOMEM_ERR_PTR(-ENOMEM);
> +	}
> +	return dest_ptr;
> +}
> +
> static int arm_smmu_device_probe(struct platform_device *pdev)
> {
> 	int irq, ret;
> @@ -4056,10 +4085,21 @@ static int arm_smmu_device_probe(struct =
platform_device *pdev)
> 	}
> 	ioaddr =3D res->start;
>=20
> -	smmu->base =3D devm_ioremap_resource(dev, res);
> +	/*
> +	 * Only map what we need, because the IMPLEMENTATION DEFINED =
registers
> +	 * may be used for the PMCGs, which are reserved by the PMU =
driver.
> +	 */
> +	smmu->base =3D arm_smmu_ioremap(dev, ioaddr, =
ARM_SMMU_PAGE0_REG_SZ);
> 	if (IS_ERR(smmu->base))
> 		return PTR_ERR(smmu->base);
>=20
> +	if (arm_smmu_resource_size(smmu) > SZ_64K) {
> +		smmu->page1 =3D arm_smmu_ioremap(dev, ioaddr + SZ_64K,
> +					       ARM_SMMU_PAGE1_REG_SZ);
> +		if (IS_ERR(smmu->page1))
> +			return PTR_ERR(smmu->page1);
> +	}
> +
> 	/* Interrupt lines */
>=20
> 	irq =3D platform_get_irq_byname_optional(pdev, "combined");
> =E2=80=94=20
> 2.26.2
>=20


Tested-by: Tuan Phan <tuanphan@os.amperecomputing.com =
<mailto:tuanphan@os.amperecomputing.com>>


--Apple-Mail=_F357CE15-3AFC-4D68-86E3-684210B830CC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8"></=
head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; line-b=
reak: after-white-space;" class=3D""><br class=3D""><div><br class=3D""><bl=
ockquote type=3D"cite" class=3D""><div class=3D"">On May 6, 2020, at 10:46 =
AM, Jean-Philippe Brucker &lt;<a href=3D"mailto:jean-philippe@linaro.org" c=
lass=3D"">jean-philippe@linaro.org</a>&gt; wrote:</div><br class=3D"Apple-i=
nterchange-newline"><div class=3D""><div class=3D"">Some SMMUv3 implementat=
ion embed the Perf Monitor Group Registers (PMCG)<br class=3D"">inside the =
first 64kB region of the SMMU. Since PMCG are managed by a<br class=3D"">se=
parate driver, this layout causes resource reservation conflicts<br class=
=3D"">during boot.<br class=3D""><br class=3D"">To avoid this conflict, onl=
y reserve the MMIO region we actually use:<br class=3D"">the first 0xe0 byt=
es of page 0 and the first 0xd0 bytes of page 1.<br class=3D"">Although dev=
m_ioremap() still works on full pages under the hood, this<br class=3D"">wa=
y we benefit from resource conflict checks.<br class=3D""><br class=3D"">Si=
gned-off-by: Jean-Philippe Brucker &lt;<a href=3D"mailto:jean-philippe@lina=
ro.org" class=3D"">jean-philippe@linaro.org</a>&gt;<br class=3D"">---<br cl=
ass=3D"">A nicer (and hopefully working) solution to the problem dicussed h=
ere:<br class=3D""><a href=3D"https://lore.kernel.org/linux-iommu/202004211=
55745.19815-1-jean-philippe@linaro.org/" class=3D"">https://lore.kernel.org=
/linux-iommu/20200421155745.19815-1-jean-philippe@linaro.org/</a><br class=
=3D"">---<br class=3D""> drivers/iommu/arm-smmu-v3.c | 50 &#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--=
--<br class=3D""> 1 file changed, 45 insertions(&#43;), 5 deletions(-)<br c=
lass=3D""><br class=3D"">diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers=
/iommu/arm-smmu-v3.c<br class=3D"">index 82508730feb7a1..fc85cdd5b62cca 100=
644<br class=3D"">--- a/drivers/iommu/arm-smmu-v3.c<br class=3D"">&#43;&#43=
;&#43; b/drivers/iommu/arm-smmu-v3.c<br class=3D"">@@ -171,6 &#43;171,9 @@<=
br class=3D""> #define ARM_SMMU_PRIQ_IRQ_CFG1<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" style=3D"=
white-space:pre">	</span>0xd8<br class=3D""> #define ARM_SMMU_PRIQ_IRQ_CFG2=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0xdc<br class=3D""><=
br class=3D"">&#43;#define ARM_SMMU_PAGE0_REG_SZ<span class=3D"Apple-tab-sp=
an" style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>0xe0<br class=3D"">&#43;#define ARM_SMMU_PAGE1=
_REG_SZ<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><sp=
an class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0xd0<br class=
=3D"">&#43;<br class=3D""> /* Common MSI config fields */<br class=3D""> #d=
efine MSI_CFG0_ADDR_MASK<span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</s=
pan>GENMASK_ULL(51, 2)<br class=3D""> #define MSI_CFG2_SH<span class=3D"App=
le-tab-span" style=3D"white-space:pre">	</span><span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>GENMASK(5, 4)<br class=3D"">@@ -628,6 &#43;631=
,7 @@ struct arm_smmu_strtab_cfg {<br class=3D""> struct arm_smmu_device {<=
br class=3D""> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	</=
span>struct device<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><s=
pan class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>*dev;<br cla=
ss=3D""> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>v=
oid __iomem<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span=
><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space:pre">	</span>*base;<br class=3D"=
">&#43;<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>voi=
d __iomem<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><=
span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>*page1;<br class=3D""=
><br class=3D""> #define ARM_SMMU_FEAT_2_LVL_STRTAB<span class=3D"Apple-tab=
-span" style=3D"white-space:pre">	</span>(1 &lt;&lt; 0)<br class=3D""> #def=
ine ARM_SMMU_FEAT_2_LVL_CDTAB<span class=3D"Apple-tab-span" style=3D"white-=
space:pre">	</span>(1 &lt;&lt; 1)<br class=3D"">@@ -733,11 &#43;737,14 @@ s=
tatic struct arm_smmu_option_prop arm_smmu_options[] =3D {<br class=3D""> s=
tatic inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,<br cl=
ass=3D""> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span class=3D"Apple=
-tab-span" style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" style=3D"=
white-space:pre">	</span> struct arm_smmu_device *smmu)<br class=3D""> {<br=
 class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</sp=
an>if ((offset &gt; SZ_64K) &amp;&amp;<br class=3D"">-<span class=3D"Apple-=
tab-span" style=3D"white-space:pre">	</span> &nbsp;&nbsp;&nbsp;(smmu-&gt;op=
tions &amp; ARM_SMMU_OPT_PAGE0_REGS_ONLY))<br class=3D"">-<span class=3D"Ap=
ple-tab-span" style=3D"white-space:pre">	</span><span class=3D"Apple-tab-sp=
an" style=3D"white-space:pre">	</span>offset -=3D SZ_64K;<br class=3D"">&#4=
3;<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>void __i=
omem *base =3D smmu-&gt;base;<br class=3D""><br class=3D"">-<span class=3D"=
Apple-tab-span" style=3D"white-space:pre">	</span>return smmu-&gt;base &#43=
; offset;<br class=3D"">&#43;<span class=3D"Apple-tab-span" style=3D"white-=
space:pre">	</span>if (offset &gt; SZ_64K) {<br class=3D"">&#43;<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span class=3D"Apple-=
tab-span" style=3D"white-space:pre">	</span>offset -=3D SZ_64K;<br class=3D=
"">&#43;<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><s=
pan class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (smmu-&gt=
;page1)<br class=3D"">&#43;<span class=3D"Apple-tab-span" style=3D"white-sp=
ace:pre">	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>bas=
e =3D smmu-&gt;page1;<br class=3D"">&#43;<span class=3D"Apple-tab-span" sty=
le=3D"white-space:pre">	</span>}<br class=3D"">&#43;<span class=3D"Apple-ta=
b-span" style=3D"white-space:pre">	</span>return base &#43; offset;<br clas=
s=3D""> }<br class=3D""><br class=3D""> static struct arm_smmu_domain *to_s=
mmu_domain(struct iommu_domain *dom)<br class=3D"">@@ -4021,6 &#43;4028,28 =
@@ err_reset_pci_ops: __maybe_unused;<br class=3D""> <span class=3D"Apple-t=
ab-span" style=3D"white-space:pre">	</span>return err;<br class=3D""> }<br =
class=3D""><br class=3D"">&#43;static void __iomem *arm_smmu_ioremap(struct=
 device *dev,<br class=3D"">&#43;<span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">	</span><span class=3D"Apple-tab-span" style=3D"white-space:=
pre">	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</sp=
an><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> &nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;resource_size_t start,<br class=3D"">&#43;<span cla=
ss=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span=
" style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" style=3D=
"white-space:pre">	</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;resource_size_t si=
ze)<br class=3D"">&#43;{<br class=3D"">&#43;<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>void __iomem *dest_ptr;<br class=3D"">&#4=
3;<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struct r=
esource *res;<br class=3D"">&#43;<br class=3D"">&#43;<span class=3D"Apple-t=
ab-span" style=3D"white-space:pre">	</span>res =3D devm_request_mem_region(=
dev, start, size, dev_name(dev));<br class=3D"">&#43;<span class=3D"Apple-t=
ab-span" style=3D"white-space:pre">	</span>if (!res) {<br class=3D"">&#43;<=
span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>dev_err(dev, &quot;ca=
n't request SMMU region %pa\n&quot;, &amp;start);<br class=3D"">&#43;<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span class=3D"A=
pple-tab-span" style=3D"white-space:pre">	</span>return IOMEM_ERR_PTR(-EINV=
AL);<br class=3D"">&#43;<span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span>}<br class=3D"">&#43;<br class=3D"">&#43;<span class=3D"Apple=
-tab-span" style=3D"white-space:pre">	</span>dest_ptr =3D devm_ioremap(dev,=
 start, size);<br class=3D"">&#43;<span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">	</span>if (!dest_ptr) {<br class=3D"">&#43;<span class=3D"=
Apple-tab-span" style=3D"white-space:pre">	</span><span class=3D"Apple-tab-=
span" style=3D"white-space:pre">	</span>dev_err(dev, &quot;ioremap failed f=
or SMMU region %pR\n&quot;, res);<br class=3D"">&#43;<span class=3D"Apple-t=
ab-span" style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" s=
tyle=3D"white-space:pre">	</span>devm_release_mem_region(dev, start, size);=
<br class=3D"">&#43;<span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=
dest_ptr =3D IOMEM_ERR_PTR(-ENOMEM);<br class=3D"">&#43;<span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">	</span>}<br class=3D"">&#43;<span cl=
ass=3D"Apple-tab-span" style=3D"white-space:pre">	</span>return dest_ptr;<b=
r class=3D"">&#43;}<br class=3D"">&#43;<br class=3D""> static int arm_smmu_=
device_probe(struct platform_device *pdev)<br class=3D""> {<br class=3D""> =
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int irq, r=
et;<br class=3D"">@@ -4056,10 &#43;4085,21 @@ static int arm_smmu_device_pr=
obe(struct platform_device *pdev)<br class=3D""> <span class=3D"Apple-tab-s=
pan" style=3D"white-space:pre">	</span>}<br class=3D""> <span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">	</span>ioaddr =3D res-&gt;start;<br =
class=3D""><br class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-sp=
ace:pre">	</span>smmu-&gt;base =3D devm_ioremap_resource(dev, res);<br clas=
s=3D"">&#43;<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</spa=
n>/*<br class=3D"">&#43;<span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span> * Only map what we need, because the IMPLEMENTATION DEFINED =
registers<br class=3D"">&#43;<span class=3D"Apple-tab-span" style=3D"white-=
space:pre">	</span> * may be used for the PMCGs, which are reserved by the =
PMU driver.<br class=3D"">&#43;<span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">	</span> */<br class=3D"">&#43;<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>smmu-&gt;base =3D arm_smmu_ioremap(dev, i=
oaddr, ARM_SMMU_PAGE0_REG_SZ);<br class=3D""> <span class=3D"Apple-tab-span=
" style=3D"white-space:pre">	</span>if (IS_ERR(smmu-&gt;base))<br class=3D"=
"> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span c=
lass=3D"Apple-tab-span" style=3D"white-space:pre">	</span>return PTR_ERR(sm=
mu-&gt;base);<br class=3D""><br class=3D"">&#43;<span class=3D"Apple-tab-sp=
an" style=3D"white-space:pre">	</span>if (arm_smmu_resource_size(smmu) &gt;=
 SZ_64K) {<br class=3D"">&#43;<span class=3D"Apple-tab-span" style=3D"white=
-space:pre">	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>smmu-&gt;page1 =3D arm_smmu_ioremap(dev, ioaddr &#43; SZ_64K,<br =
class=3D"">&#43;<span class=3D"Apple-tab-span" style=3D"white-space:pre">	<=
/span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span class=3D=
"Apple-tab-span" style=3D"white-space:pre">	</span><span class=3D"Apple-tab=
-span" style=3D"white-space:pre">	</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;ARM_SMMU_PAGE1_REG_SZ);<br class=3D"">&#43;<span class=3D"Apple-tab-span=
" style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" style=3D=
"white-space:pre">	</span>if (IS_ERR(smmu-&gt;page1))<br class=3D"">&#43;<s=
pan class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span class=3D"Apple-=
tab-span" style=3D"white-space:pre">	</span>return PTR_ERR(smmu-&gt;page1);=
<br class=3D"">&#43;<span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>}<br class=3D"">&#43;<br class=3D""> <span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">	</span>/* Interrupt lines */<br class=3D""><b=
r class=3D""> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	</s=
pan>irq =3D platform_get_irq_byname_optional(pdev, &quot;combined&quot;);<b=
r class=3D"">=E2=80=94 <br class=3D"">2.26.2<br class=3D""><br class=3D""><=
/div></div></blockquote></div><div><br class=3D""></div>Tested-by: Tuan Pha=
n &lt;<a href=3D"mailto:tuanphan@os.amperecomputing.com" class=3D"">tuanpha=
n@os.amperecomputing.com</a>&gt;<div class=3D""><br class=3D""></div></body=
></html>=

--Apple-Mail=_F357CE15-3AFC-4D68-86E3-684210B830CC--

--===============2059661410035803025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2059661410035803025==--
