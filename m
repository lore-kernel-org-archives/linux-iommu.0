Return-Path: <SRS0=xjv2=36=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C787C352A3
	for <iommu@archiver.kernel.org>; Mon, 10 Feb 2020 15:49:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3A620733
	for <iommu@archiver.kernel.org>; Mon, 10 Feb 2020 15:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="01BXJvMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3A620733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 272E384491;
	Mon, 10 Feb 2020 15:49:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eVvQ_CJJalcx; Mon, 10 Feb 2020 15:49:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3E961842F8;
	Mon, 10 Feb 2020 15:49:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28CC5C1796;
	Mon, 10 Feb 2020 15:49:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E17B9C0171
 for <iommu@lists.linux-foundation.org>; Mon, 10 Feb 2020 15:49:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C8EF586E5C
 for <iommu@lists.linux-foundation.org>; Mon, 10 Feb 2020 15:49:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8BfzM+fix833 for <iommu@lists.linux-foundation.org>;
 Mon, 10 Feb 2020 15:49:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B80E186E2C
 for <iommu@lists.linux-foundation.org>; Mon, 10 Feb 2020 15:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRtRmBgOqka9ERR149s3H5CK5ntbgmyWX1yiW1S5pWEhNtqKfBLkfMn1zfZTcNemqPeN9Knpfaa9r13ipqB89E2o02zC//YwFUPKZkcizJ3m/IFWFGPDN2XyvyN1R+GtPW8KpoDlqB4vAEB3tKZngLPR/0ObRghHXAEwYLLrqkdWz1DZI+jCRpA2gtgPduEstI35GY42OH5yqpmmec96rhim8N5baH5n1o+GizmlCDtiC38yWaBUeev02JIpU3Ehb7clT8RZfL7o3U9uslr0FjD6yI5y3Kc8hKKC983CWPoWiJ6A4rp+kuom/VR5gAOFQAnw19F2gaviH1oUwR/R8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDl3XBfxn9NJOJkTNhIb3MmeKDiSd7xAfcZVgL+iXNA=;
 b=OlcHQpuufv8IzSqsd56phAnZLbpxlcNKJSoaLBLDFV7LavVJ82vYnnwdtxgVrDFp4TCSZIK75zfdy8J/UIU6iT7EI5WoJlWgGAvXZ5De1vwex7ovyRYwCYMtCpNbiEk/44YZSKLzUgxNEGfk9TZ+6MpUi5K1FkuFvOKrkcvgqIKY7euqD0Vjl/FPo7eG/tHM1kM51bVtu9pYpbTsKuJYkYcijPGAYQZzwAgyzEga9vk+QpIjvPnrIBMh+ZTL3a/2J5/8ZkV05TzrsaSu5SyDb/oJsmfws04rlspHjAfmXqrME6z+sGIXcYXDCl8/5U+HWii1xfVDYSxx3OZFWUAXOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDl3XBfxn9NJOJkTNhIb3MmeKDiSd7xAfcZVgL+iXNA=;
 b=01BXJvMxbWigu6QYxKTfi00Vrezre/Zc94D+NVv2+3dPUjPvag/LbUPvQGXtV//3zaHyQbTR9lOglwDw0IeKSdsA3WD/P5IJ1X0c7rWiCrKPpyFIJYrsvXitmWavIvZhkR+s2lVi4Gztnt2a/4JaXoc+bXa/D3QB+G/g/iFBjj4=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (52.132.246.86) by
 CH2PR12MB4038.namprd12.prod.outlook.com (20.180.17.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Mon, 10 Feb 2020 15:16:12 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 15:16:12 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, "joro@8bytes.org"
 <joro@8bytes.org>
Subject: RE: [PATCH v3] iommu/amd: Disable IOMMU on Stoney Ridge systems
Thread-Topic: [PATCH v3] iommu/amd: Disable IOMMU on Stoney Ridge systems
Thread-Index: AQHV3+bm4+O3VLPhyk6WT5Yu9Y1qOKgUigig
Date: Mon, 10 Feb 2020 15:16:12 +0000
Message-ID: <CH2PR12MB39126B048BE94D74B45DB158F7190@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <20200210075115.14838-1-kai.heng.feng@canonical.com>
In-Reply-To: <20200210075115.14838-1-kai.heng.feng@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-10T15:15:27Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=30691b1f-de87-4a3f-9875-00005f3cb55f;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-02-10T15:16:10Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: a1c50943-2d0f-4306-8d96-0000b67c01c4
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6804dc92-06d3-4b3b-25c0-08d7ae3c2a38
x-ms-traffictypediagnostic: CH2PR12MB4038:
x-microsoft-antispam-prvs: <CH2PR12MB40382A445EE918E82A43F778F7190@CH2PR12MB4038.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:187;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(478600001)(8936002)(7696005)(966005)(186003)(6506007)(2906002)(53546011)(110136005)(54906003)(45080400002)(81166006)(81156014)(316002)(8676002)(26005)(86362001)(5660300002)(4326008)(71200400001)(9686003)(55016002)(64756008)(66446008)(66476007)(66556008)(66946007)(33656002)(52536014)(76116006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4038;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RA0lGI6W9VntyYKguYh0OtAIKE6b1wCeZiHkpxDyFqfe8XEBbvTlkWK7Ywb3y0bdUpiVvjLwpCx326ZwyUTlBw8mzauRoILFVM6GgubJt5oCXDCMNFz1D9vtlnmg6kHLrc4XJuZ4TlAb8k1ngJtEY4BRmn8NUQlZ15fYZnAw3WEcvNb4wnuh2VmZyi37EAaoGRW6j8xYt26nM4PKvgOK+9xeb4i+hu6wjIn1R2u0aKNEmWAzjzKTnOZy+Yx7TCqRqxPQpLREnp2nj4wpgnevqdhVIX71q+4DvInQpPH8svrLIDXtbIu8VbYyW9H5kZQbLN9vPOtDsX/adDQrbWPWz/euCzkX1iXnZM/jHcrdgphADJmcRmVrgDnUf2Oz4VIIAHXeayFg7FgFTIqCczTu/J+O5wFMyXcAtT7TmGz/vn1QYtrGsubaHjap0Ys8E6o7Oa2DTDfb8/3jDLnaaJbLyZjvWJKnTkEs5mXZQeDIwl/UDo+/NgLl5GgviTcPfExapN5xhj+pjgJlBSghnFDzdhLfFJaHto5EfCPM5e+kJMy9FF+urTFmk+sARTC6DuyTeyNb70Gj2F/BSVCLcI8Fm8lo3SwAS9mukh5hQ9l1WkX5ST6/YBWJXaTpjQnWVefY
x-ms-exchange-antispam-messagedata: kbMSIy0ezuGhzQLCstaR3iaPi+DdPgkBwBEc5r+bW+3wkT+HSu+C8g6VG6TnX4EKmi42xlVLPoWF5Fmh5gLM8DDd2+2tU1nQtzcOGJO3sYvpcDJhmET4DjVxuzcttq4U5MvCyC0gNUSBGDz4hIzoTQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6804dc92-06d3-4b3b-25c0-08d7ae3c2a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 15:16:12.4218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XGfoBzoVdo2dPxjrDzXKZam+r7pf2e0hNcFJ4q2g/irWuPnTgxQQ5j//wVyYe6pVEorNiSx20LEHSciZ2Zy8Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
Cc: "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

[AMD Public Use]

> -----Original Message-----
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Sent: Monday, February 10, 2020 2:51 AM
> To: joro@8bytes.org
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; open list:AMD IOMMU (AMD-VI)
> <iommu@lists.linux-foundation.org>; open list <linux-
> kernel@vger.kernel.org>
> Subject: [PATCH v3] iommu/amd: Disable IOMMU on Stoney Ridge systems
> 
> Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
> 
> Use identity-mapping and PCI ATS doesn't help this issue.
> 
> According to Alex Deucher, IOMMU isn't enabled on Windows, so let's do the
> same here to avoid screen flickering on 4K monitor.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Bug:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2Fissues%2F961&amp;data=02%7C01%7
> Calexander.deucher%40amd.com%7C79aa213aaf2d4540064308d7adfe0749%
> 7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637169178877965485
> &amp;sdata=UeNw4%2FuQ3Rs5SwEvguDmdfuMEsizO8F138B%2B2GNleTY%
> 3D&amp;reserved=0
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>


> ---
> v3:
>  - Update commit message to mention identity-mapping and ATS don't help.
> 
> v2:
>  - Find Stoney graphics instead of host bridge.
> 
>  drivers/iommu/amd_iommu_init.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c
> b/drivers/iommu/amd_iommu_init.c index 2759a8d57b7f..6be3853a5d97
> 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -2523,6 +2523,7 @@ static int __init early_amd_iommu_init(void)
>  	struct acpi_table_header *ivrs_base;
>  	acpi_status status;
>  	int i, remap_cache_sz, ret = 0;
> +	u32 pci_id;
> 
>  	if (!amd_iommu_detected)
>  		return -ENODEV;
> @@ -2610,6 +2611,16 @@ static int __init early_amd_iommu_init(void)
>  	if (ret)
>  		goto out;
> 
> +	/* Disable IOMMU if there's Stoney Ridge graphics */
> +	for (i = 0; i < 32; i++) {
> +		pci_id = read_pci_config(0, i, 0, 0);
> +		if ((pci_id & 0xffff) == 0x1002 && (pci_id >> 16) == 0x98e4) {
> +			pr_info("Disable IOMMU on Stoney Ridge\n");
> +			amd_iommu_disabled = true;
> +			break;
> +		}
> +	}
> +
>  	/* Disable any previously enabled IOMMUs */
>  	if (!is_kdump_kernel() || amd_iommu_disabled)
>  		disable_iommus();
> @@ -2718,7 +2729,7 @@ static int __init state_next(void)
>  		ret = early_amd_iommu_init();
>  		init_state = ret ? IOMMU_INIT_ERROR :
> IOMMU_ACPI_FINISHED;
>  		if (init_state == IOMMU_ACPI_FINISHED &&
> amd_iommu_disabled) {
> -			pr_info("AMD IOMMU disabled on kernel command-
> line\n");
> +			pr_info("AMD IOMMU disabled\n");
>  			init_state = IOMMU_CMDLINE_DISABLED;
>  			ret = -EINVAL;
>  		}
> --
> 2.17.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
