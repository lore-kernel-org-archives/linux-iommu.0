Return-Path: <SRS0=3/Zu=FA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CCBC56202
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 09:24:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296972173E
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 09:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emerson.onmicrosoft.com header.i=@emerson.onmicrosoft.com header.b="1CRTsKTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296972173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emerson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5106E2E1E5;
	Thu, 26 Nov 2020 09:24:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9SeI2nOqd+CW; Thu, 26 Nov 2020 09:24:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5B22C2E0EB;
	Thu, 26 Nov 2020 09:24:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E547C0891;
	Thu, 26 Nov 2020 09:24:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38153C0052
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 09:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DB76886EE8
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 09:24:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uc0rqS55Bgkg for <iommu@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 09:24:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com
 [148.163.142.35])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7AAB486D7D
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 09:24:15 +0000 (UTC)
Received: from pps.filterd (m0144091.ppops.net [127.0.0.1])
 by mx0b-00300601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0AQ98fo5073909; Thu, 26 Nov 2020 09:24:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
 by mx0b-00300601.pphosted.com with ESMTP id 3525cfb5ct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2020 09:24:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgCZEpPuSqubt35xWB7y7oVa+5L5TjI0zOjJi3eJtzj25ZTCP+nULV+R4yzf7xr3HqZ/IRj5FF3PO3Szcs22k9UDefgkBoip126ouONgdA46HtDtPGNWGTnvgysDwZNWNpDsy3XLvuptv83MJXSmyUHbRw38BIsPvsZDGf6SGO+pBX3o1gEIvQObmZFuQeim/9RifZIOgQfsBkftUQQamw09LgOPoXT3kgI2NtHQymqpt9l2JQstehqtA+YuGfkZoMaOCbqR0D45u32XlXM0E5lhxeST+d9BTG3v5Z76Gds/2M7LcmP3Mso8YABef0pRLvI9iBb0rOVdwirIR1EdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YquVkAXFpGwyoM0k4isdOWY9zvIxpaxs+2+RcNmGW+c=;
 b=Nji/AlhKDmvc4/EsCT0vbNKfhTFwakHq6dwLaYDXAGgZwHphO0Oz17LU5i0of+a42G1Ha1moSjPYP4gwKN2jVmLdT3LbTr8nNbo59ecBuDRPMYwoilDcHrXnmEuRTKaWwKzpqZ2M2j7o+hEEe0JB9P9n/IJbnlhMm21l6d58O5YzUVjWv98Fss09a751ty0en8jVy1Oz5tFkyxAqVDesVAmFbBC9e/BH9Ln9shCw8bWC8QFPVyLWDeQtPhiicRJsCclM/3zT0zpebMBAdHS5/+Fe3McrUaBF9xa3hmId2tRVt9CGxovzuro+nH6+/SVcNt0FL+fITt8cTYFvMvc2uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emerson.onmicrosoft.com; s=selector2-emerson-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YquVkAXFpGwyoM0k4isdOWY9zvIxpaxs+2+RcNmGW+c=;
 b=1CRTsKTh/CKOklKbLel3hL9EmKao1Glfl1WkYK5S7NMZqxI64rC3+R0t32BCce3Ij0IdwLzSZO0/KISZLK0DUAZHrruF10JmvqGaxoUUtkVXkjcDA3x3tMXfKa92b4LPDg1+k/P3xc5j7XGcbdDVCL67s7E9ZxDQ6+unkV+etog=
Received: from MWHPR10MB1310.namprd10.prod.outlook.com (2603:10b6:300:21::18)
 by MWHPR10MB1837.namprd10.prod.outlook.com (2603:10b6:300:10d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Thu, 26 Nov
 2020 09:24:06 +0000
Received: from MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e]) by MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e%12]) with mapi id 15.20.3611.023; Thu, 26 Nov 2020
 09:24:06 +0000
From: "Merger, Edgar [AUTOSOL/MAS/AUGS]" <Edgar.Merger@emerson.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
Thread-Topic: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
Thread-Index: AQHWwdw3n5VLcueYHUSP0T6AMdoDgKnWTbwAgAAE0oCAAIPUgIAACwGQgACBfgCAAPBvUIAAPe5ggAADdOCAAHHKAIAA7wXw
Date: Thu, 26 Nov 2020 09:24:06 +0000
Message-ID: <MWHPR10MB13108E26A50D6A92BD9C58F189F90@MWHPR10MB1310.namprd10.prod.outlook.com>
References: <20201123134410.10648-1-will@kernel.org>
 <MN2PR12MB4488308D26DB50C18EA3BE0FF7FC0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20201123223356.GC12069@willie-the-truck>
 <218017ab-defd-c77d-9055-286bf49bee86@amd.com>
 <20201124064301.GA536919@hr-amd>
 <MWHPR10MB13108B04F4765EA6E278660B89FB0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MN2PR12MB44884857E65E3599DA32D0B2F7FB0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MWHPR10MB13107611C2309BD0AECA685989FA0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <CY4PR10MB13029B38D31936622E4CA62389FA0@CY4PR10MB1302.namprd10.prod.outlook.com>
 <CY4PR10MB13022501A57CC02FF5BC632B89FA0@CY4PR10MB1302.namprd10.prod.outlook.com>
 <MN2PR12MB4488C655936CE25DC0C3EA5EF7FA0@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4488C655936CE25DC0C3EA5EF7FA0@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-24T15:01:54Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=de2f7a10-55c4-48b3-9a56-00005e730a8e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=emerson.com;
x-originating-ip: [80.79.80.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5defb265-7891-492d-0ad4-08d891ed060b
x-ms-traffictypediagnostic: MWHPR10MB1837:
x-microsoft-antispam-prvs: <MWHPR10MB1837BC10E28D0E855EF4C27189F90@MWHPR10MB1837.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:341;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z92eF2+m+AGro5VJ5ansnwtD3v27x4nulj9BNOndH7Ang0eMZ0R9i0w9Mqxq6O5nTVmTAfiJJh2/Nftek8c3F0GmaTeRCOzveROQO1dByaXAP+uF2o+upwDq7rkbOcAPtYvSyPhByzLa9cggimrbP6HGv/XUrAXngM1rGiG4Wyttvb86hkOQS3dEPtX52fDzTul89bM3/a7kHcvws4H9+lXBP7F5qxn8sMDo3OIoObaXJllvNUPsEoiLukqF84YEpeCEfKYPke6VKmuMIu/vW/YWrmJXn74kl/CpSQ6PLJDDHiQH/HS0P9uYETQq0pBH+xDg8SD9Cl4fpyaCgrFOHxDVwH/riiC2e4o4ndJv/Qfr/2wrsaJOG5pSS14rIDZ3j7miAPEUMBswaLiJ8qncaYyh/uY016wrzMe0RsCkEA0rxiRYy3C8g0800LkjW2OyI2a7g7+fE4phiDJ36owdsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR10MB1310.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(396003)(136003)(366004)(376002)(39860400002)(19627235002)(4001150100001)(6506007)(186003)(83380400001)(26005)(55016002)(33656002)(52536014)(8676002)(30864003)(9686003)(7696005)(54906003)(4326008)(478600001)(5660300002)(53546011)(966005)(45080400002)(110136005)(316002)(8936002)(71200400001)(66476007)(66946007)(2906002)(7416002)(66446008)(76116006)(66556008)(86362001)(64756008)(559001)(579004)(505234006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?1neI0kuaL1Bjq6CiHw+ms540eycgKdbfkL274h4hfcH7xtNlk+QmIGg+7y?=
 =?iso-8859-1?Q?zi2iA0XxWJxqbsefb4EueqwNLUpcmqcypkzaAnAdOxmJrebJQgAnYVTFTJ?=
 =?iso-8859-1?Q?bmapn0x2+S7BgbZvEAJJRNHKKuVRBfQfbT7AKZwZ9KgJ9zlQ2546Q+MUlX?=
 =?iso-8859-1?Q?mjV+cC1xvRy/C6KkvEuSUhLOAMkGkTm7GFttLM1fXM/J3/6v4S8RVBbt0n?=
 =?iso-8859-1?Q?XViSgB5uDgsIhFewiGphPznIJdS2CHpy4dqyR/eKKk8pZsXxyT7XPeEkWD?=
 =?iso-8859-1?Q?l+Gh+AZtY/PcR632OvUI1h0XIe4wHgZxWYVoem48HZEyCjC3+YrHy3gTu4?=
 =?iso-8859-1?Q?MShG/XgVolipfvnUHHBlAbpqX8IgYucDdJjZys57ONT1jE/pSOw92cK7lp?=
 =?iso-8859-1?Q?fFMvHMvrhg3oUmETPZE+RdjZkm+kRlBQ3qNsHp5Ja5w2s7dg+WltM7Ue9y?=
 =?iso-8859-1?Q?1Dy6rCEd/7PcGHQ9COngJi5yTKKc1wdr28g73ATFJjrr00QSRu5Y6oCGm7?=
 =?iso-8859-1?Q?rAb/i2OLcfw6EKfkCoAju+/iDE/ijsMXnzPRbqCi7N/4YLwbAl8zW61Hwg?=
 =?iso-8859-1?Q?BuJ/P3PRLLQgMfcjeYhcUjnMv6nf8t4UNyD/Y8gxOesp/8DczUChqkz8o5?=
 =?iso-8859-1?Q?KKDBeoV5b01GoYf0SdI+MzwpD83Kz7YV6pVoDBnBRarG55JdIJbLnwA5wy?=
 =?iso-8859-1?Q?Z19H6m4ipysiDS8Kw6LcAoXvB+7+yEY411WusB0b+0TWy6aDHB1+yT/w0q?=
 =?iso-8859-1?Q?PcoFHXb1q4m2vmPLycp7lEPsKO8Z8P8ix+VBSOKNiYaXkP1nKmRpS9K2du?=
 =?iso-8859-1?Q?XFbgo0UnwXYSDBuBclfK5ZVE32iwqcRFgilWf1QWJl540Lxh2MkWQuJOU9?=
 =?iso-8859-1?Q?VlrNb4rH/OHbF7qleJ/E2mDmlybt6fNooFaG2vriyscSGVoMO4tVVMH+OL?=
 =?iso-8859-1?Q?rPWMgi9eWgpcq9MNH2F9f6/Hk/W7ecSTgdV+WPJNmQExwJTb6kag/nKmkM?=
 =?iso-8859-1?Q?Z+iD8N8cAGivR22CM=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5defb265-7891-492d-0ad4-08d891ed060b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 09:24:06.6189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vAZcteMVmGe6TW3YjOm9Ipnfn1Dzr3IsOIyW9mV4K/3mTphJt9IMB7TlYwsQUbYpiM0d+EKrk4gZe8fbW9KaW/8KwASAVK7x3dP/gEjsljs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1837
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-26_03:2020-11-26,
 2020-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260056
Cc: Joerg Roedel <jroedel@suse.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Zhu,
 Changfeng" <Changfeng.Zhu@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Alex,

This is pretty much the same patch as what I have received from Joerg previ=
ously, except that it is tied to the particular Emerson platform and its de=
rivatives (listed with Subsystem IDs). =


Below patch was what Joerg provided me and I successfully tested.

This diff to the kernel should do that:

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index f70692ac79c5=
..3911b0ec57ba 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5176,6 +5176,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, qu=
irk_amd_harvest_no_ats);  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312=
, quirk_amd_harvest_no_ats);
 /* AMD Navi14 dGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_at=
s);
+/* AMD Raven platform iGPU */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, =

+quirk_amd_harvest_no_ats);
 #endif /* CONFIG_PCI_ATS */
 =

 /* Freescale PCIe doesn't support MSI in RC mode */

So far I have seen this issue on two instances of this chip, but I must adm=
it that I did test only two of them to this extent, so I guess it is not a =
bad chip in particular, but the chips we use are from the same production l=
ot, so it might be a systematical problem of that production lot?

UEFI-Setup shows:
Processor Family: 17h
Procossor Model: 20h - 2Fh
CPUID: 00820F01
Microcode Patch Level: 8200103

Looking at the chip-die I found that this is a fully qualified IP Silicon (=
according to Ryzen Embedded R1000 SOC Interlock).
YE1305C9T20FG
BI2015SUY
9JB6496P00123
2016 AMD
DIFFUSED IN USA
MADE IN CHINA

Currently used SBIOS is a branch from "EmbeddedPI-FP5 1.2.0.3RC3".

In the future our SBIOS might merge with EmbeddedPI-FP5_1.2.0.5RC3.




-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com> =

Sent: Mittwoch, 25. November 2020 17:08
To: Merger, Edgar [AUTOSOL/MAS/AUGS] <Edgar.Merger@emerson.com>; Huang, Ray=
 <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org; linux-pci@=
vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn Helgaas <bhelgaas@=
google.com>; Joerg Roedel <jroedel@suse.de>; Zhu, Changfeng <Changfeng.Zhu@=
amd.com>
Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken

[AMD Public Use]

> -----Original Message-----
> From: Merger, Edgar [AUTOSOL/MAS/AUGS] <Edgar.Merger@emerson.com>
> Sent: Wednesday, November 25, 2020 5:04 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray =

> <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org; =

> linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn =

> Helgaas <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu, =

> Changfeng <Changfeng.Zhu@amd.com>
> Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as =

> broken
> =

> I do have also other problems with this unit, when IOMMU is enabled =

> and pci=3Dnoats is not set as kernel parameter.
> =

> [ 2004.265906] amdgpu 0000:0b:00.0: [drm:amdgpu_ib_ring_tests =

> [amdgpu]]
> *ERROR* IB test failed on gfx (-110).
> [ 2004.266024] [drm:amdgpu_device_delayed_init_work_handler [amdgpu]]
> *ERROR* ib ring test failed (-110).
> =


Is this seen on all instances of this chip or only specific silicon?  I.e.,=
 could this be a bad chip?  Would it be possible to test a newer sbios?  I =
think the attached patch should work if we can't get it fixed on the platfo=
rm side.  It should only enable the quirk on your particular platform.

Alex


> -----Original Message-----
> From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> Sent: Mittwoch, 25. November 2020 10:16
> To: 'Deucher, Alexander' <Alexander.Deucher@amd.com>; 'Huang, Ray'
> <Ray.Huang@amd.com>; 'Kuehling, Felix' <Felix.Kuehling@amd.com>
> Cc: 'Will Deacon' <will@kernel.org>; 'linux-kernel@vger.kernel.org' =

> <linux- kernel@vger.kernel.org>; 'linux-pci@vger.kernel.org' <linux- =

> pci@vger.kernel.org>; 'iommu@lists.linux-foundation.org'
> <iommu@lists.linux-foundation.org>; 'Bjorn Helgaas'
> <bhelgaas@google.com>; 'Joerg Roedel' <jroedel@suse.de>; 'Zhu, =

> Changfeng' <Changfeng.Zhu@amd.com>
> Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as =

> broken
> =

> Remark:
> =

> Systems with R1305G APU (which show the issue) have the following VGA-
> Controller:
> 0b:00.0 VGA compatible controller: Advanced Micro Devices, Inc. =

> [AMD/ATI] Picasso (rev cf)
> =

> Systems with V1404I APU (which do not show the issue) have the =

> following
> VGA-Controller:
> 0b:00.0 VGA compatible controller: Advanced Micro Devices, Inc. =

> [AMD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile Series] =

> (rev 83)
> =

> "rev cf" vs. "ref 83" is probably what you where referring to with PCI =

> Revision ID.
> =

> -----Original Message-----
> From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> Sent: Mittwoch, 25. November 2020 07:05
> To: 'Deucher, Alexander' <Alexander.Deucher@amd.com>; Huang, Ray =

> <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org; =

> linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn =

> Helgaas <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu, =

> Changfeng <Changfeng.Zhu@amd.com>
> Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as =

> broken
> =

> I see that problem only on systems that use a R1305G APU
> =

> sudo cat /sys/kernel/debug/dri/0/amdgpu_firmware_info
> =

> shows
> =

> VCE feature version: 0, firmware version: 0x00000000 UVD feature =

> version: 0, firmware version: 0x00000000 MC feature version: 0, firmware =
version:
> 0x00000000 ME feature version: 50, firmware version: 0x000000a3 PFP =

> feature version: 50, firmware version: 0x000000bb CE feature version: =

> 50, firmware version: 0x0000004f RLC feature version: 1, firmware version:
> 0x00000049 RLC SRLC feature version: 1, firmware version: 0x00000001 =

> RLC SRLG feature version: 1, firmware version: 0x00000001 RLC SRLS =

> feature
> version: 1, firmware version: 0x00000001 MEC feature version: 50, =

> firmware
> version: 0x000001b5
> MEC2 feature version: 50, firmware version: 0x000001b5 SOS feature versio=
n:
> 0, firmware version: 0x00000000 ASD feature version: 0, firmware version:
> 0x21000030 TA XGMI feature version: 0, firmware version: 0x00000000 TA =

> RAS feature version: 0, firmware version: 0x00000000 SMC feature =

> version: 0, firmware version: 0x00002527
> SDMA0 feature version: 41, firmware version: 0x000000a9 VCN feature
> version: 0, firmware version: 0x0110901c DMCU feature version: 0, =

> firmware
> version: 0x00000001 VBIOS version: 113-RAVEN2-117
> =

> We are also using V1404I APU on the same boards and I haven=B4t seen the =

> issue on those boards
> =

> These boards give me slightly different info: sudo cat =

> /sys/kernel/debug/dri/0/amdgpu_firmware_info
> =

> VCE feature version: 0, firmware version: 0x00000000 UVD feature =

> version: 0, firmware version: 0x00000000 MC feature version: 0, firmware =
version:
> 0x00000000 ME feature version: 47, firmware version: 0x000000a2 PFP =

> feature version: 47, firmware version: 0x000000b9 CE feature version: =

> 47, firmware version: 0x0000004e RLC feature version: 1, firmware version:
> 0x00000213 RLC SRLC feature version: 1, firmware version: 0x00000001 =

> RLC SRLG feature version: 1, firmware version: 0x00000001 RLC SRLS =

> feature
> version: 1, firmware version: 0x00000001 MEC feature version: 47, =

> firmware
> version: 0x000001ab
> MEC2 feature version: 47, firmware version: 0x000001ab SOS feature versio=
n:
> 0, firmware version: 0x00000000 ASD feature version: 0, firmware version:
> 0x21000013 TA XGMI feature version: 0, firmware version: 0x00000000 TA =

> RAS feature version: 0, firmware version: 0x00000000 SMC feature =

> version: 0, firmware version: 0x00001e5b
> SDMA0 feature version: 41, firmware version: 0x000000a9 VCN feature
> version: 0, firmware version: 0x0110901c DMCU feature version: 0, =

> firmware
> version: 0x00000000 VBIOS version: 113-RAVEN-116
> =

> =

> =

> =

> 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 =

> Root Complex
> 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 IOMMU
> 00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h =

> (Models
> 00h-1fh) PCIe Dummy Host Bridge
> 00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 =

> PCIe GPP Bridge [6:0]
> 00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Zeppelin Switch =

> Upstream (PCIE SW.US)
> 00:01.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 =

> PCIe GPP Bridge [6:0]
> 00:01.5 PCI bridge: Advanced Micro Devices, Inc. [AMD] Zeppelin Switch =

> Upstream (PCIE SW.US)
> 00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h =

> (Models
> 00h-1fh) PCIe Dummy Host Bridge
> 00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 =

> Internal PCIe GPP Bridge 0 to Bus A
> 00:08.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 =

> Internal PCIe GPP Bridge 0 to Bus B
> 00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller =

> (rev 61)
> 00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge =

> (rev
> 51)
> 00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 =

> Device 24: Function 0
> 00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 =

> Device 24: Function 1
> 00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 =

> Device 24: Function 2
> 00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 =

> Device 24: Function 3
> 00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 =

> Device 24: Function 4
> 00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 =

> Device 24: Function 5
> 00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 =

> Device 24: Function 6
> 00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 =

> Device 24: Function 7
> 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0e)
> 01:00.1 Serial controller: Realtek Semiconductor Co., Ltd. Device 816a =

> (rev 0e)
> 01:00.2 Serial controller: Realtek Semiconductor Co., Ltd. Device 816b =

> (rev 0e)
> 01:00.3 IPMI Interface: Realtek Semiconductor Co., Ltd. Device 816c =

> (rev 0e)
> 01:00.4 USB controller: Realtek Semiconductor Co., Ltd. Device 816d =

> (rev 0e)
> 02:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network =

> Connection (rev 03)
> 03:00.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 =

> 6-Port/8- Lane Packet Switch
> 04:01.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 =

> 6-Port/8- Lane Packet Switch
> 04:02.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 =

> 6-Port/8- Lane Packet Switch
> 04:03.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 =

> 6-Port/8- Lane Packet Switch
> 04:04.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 =

> 6-Port/8- Lane Packet Switch
> 04:05.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 =

> 6-Port/8- Lane Packet Switch
> 06:00.0 Serial controller: Asix Electronics Corporation Device 9100
> 06:00.1 Serial controller: Asix Electronics Corporation Device 9100
> 07:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network =

> Connection (rev 03)
> 0a:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network =

> Connection (rev 03)
> 0b:00.0 VGA compatible controller: Advanced Micro Devices, Inc. =

> [AMD/ATI] Picasso (rev cf)
> 0b:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] =

> Raven/Raven2/Fenghuang HDMI/DP Audio Controller
> 0b:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] =

> Family 17h (Models 10h-1fh) Platform Security Processor
> 0b:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Raven2 USB =

> 3.1
> 0b:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] =

> Raven/Raven2/FireFlight/Renoir Audio Processor
> 0b:00.7 Non-VGA unclassified device: Advanced Micro Devices, Inc. =

> [AMD] Raven/Raven2/Renoir Non-Sensor Fusion Hub KMDF driver
> 0c:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA =

> Controller [AHCI mode] (rev 61)
> =

> PCI Revision ID is 06 I believe. Got that from this lspci -xx
> =

> 00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Zeppelin Switch =

> Upstream (PCIE SW.US)
> 00: 22 10 5d 14 07 04 10 00 00 00 04 06 10 00 81 00
> 10: 00 00 00 00 00 00 00 00 00 02 02 00 f1 01 00 00
> 20: e0 fc e0 fc f1 ff 01 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 12 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 01 58 03 c8 00 00 00 00 10 a0 42 01 22 80 00 00
> 60: 1f 29 00 00 13 38 73 03 42 00 11 30 00 00 04 00
> 70: 00 00 40 01 18 00 01 00 00 00 00 00 bf 01 70 00
> 80: 06 00 00 00 0e 00 00 00 03 00 01 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 05 c0 81 00 00 00 e0 fe 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 0d c8 00 00 22 10 34 12 08 00 03 a8 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 4c 8a 05 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =

> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Dienstag, 24. November 2020 16:06
> To: Merger, Edgar [AUTOSOL/MAS/AUGS] <Edgar.Merger@emerson.com>; =

> Huang, Ray <Ray.Huang@amd.com>; Kuehling, Felix =

> <Felix.Kuehling@amd.com>
> Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org; =

> linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn =

> Helgaas <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu, =

> Changfeng <Changfeng.Zhu@amd.com>
> Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as =

> broken
> =

> [AMD Public Use]
> =

> > -----Original Message-----
> > From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> <Edgar.Merger@emerson.com>
> > Sent: Tuesday, November 24, 2020 2:29 AM
> > To: Huang, Ray <Ray.Huang@amd.com>; Kuehling, Felix =

> > <Felix.Kuehling@amd.com>
> > Cc: Will Deacon <will@kernel.org>; Deucher, Alexander =

> > <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org; linux- =

> > pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn Helgaas =

> > <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu,
> Changfeng
> > <Changfeng.Zhu@amd.com>
> > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as =

> > broken
> >
> > Module Version : PiccasoCpu 10
> > AGESA Version   : PiccasoPI 100A
> >
> > I did not try to enter the system in any other way (like via ssh) =

> > than via Desktop.
> =

> You can get this information from the amdgpu driver.  E.g., sudo cat =

> /sys/kernel/debug/dri/0/amdgpu_firmware_info .  Also what is the PCI =

> revision id of your chip (from lspci)?  Also are you just seeing this =

> on specific versions of the sbios?
> =

> Thanks,
> =

> Alex
> =

> =

> >
> > -----Original Message-----
> > From: Huang Rui <ray.huang@amd.com>
> > Sent: Dienstag, 24. November 2020 07:43
> > To: Kuehling, Felix <Felix.Kuehling@amd.com>
> > Cc: Will Deacon <will@kernel.org>; Deucher, Alexander =

> > <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org; linux- =

> > pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn Helgaas =

> > <bhelgaas@google.com>; Merger, Edgar [AUTOSOL/MAS/AUGS] =

> > <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.de>;
> Changfeng
> > Zhu <changfeng.zhu@amd.com>
> > Subject: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as
> broken
> >
> > On Tue, Nov 24, 2020 at 06:51:11AM +0800, Kuehling, Felix wrote:
> > > On 2020-11-23 5:33 p.m., Will Deacon wrote:
> > > > On Mon, Nov 23, 2020 at 09:04:14PM +0000, Deucher, Alexander wrote:
> > > >> [AMD Public Use]
> > > >>
> > > >>> -----Original Message-----
> > > >>> From: Will Deacon <will@kernel.org>
> > > >>> Sent: Monday, November 23, 2020 8:44 AM
> > > >>> To: linux-kernel@vger.kernel.org
> > > >>> Cc: linux-pci@vger.kernel.org; =

> > > >>> iommu@lists.linux-foundation.org; Will Deacon =

> > > >>> <will@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; =

> > > >>> Deucher, Alexander <Alexander.Deucher@amd.com>; Edgar Merger =

> > > >>> <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.de>
> > > >>> Subject: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
> > > >>>
> > > >>> Edgar Merger reports that the AMD Raven GPU does not work =

> > > >>> reliably on his system when the IOMMU is enabled:
> > > >>>
> > > >>>    | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx =

> > > >>> timeout, signaled seq=3D1, emitted seq=3D3
> > > >>>    | [...]
> > > >>>    | amdgpu 0000:0b:00.0: GPU reset begin!
> > > >>>    | AMD-Vi: Completion-Wait loop timed out
> > > >>>    | iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
> > > >>> device=3D0b:00.0 address=3D0x38edc0970]
> > > >>>
> > > >>> This is indicative of a hardware/platform configuration issue =

> > > >>> so, since disabling ATS has been shown to resolve the problem, =

> > > >>> add a quirk to match this particular device while Edgar =

> > > >>> follows-up with AMD
> > for more information.
> > > >>>
> > > >>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > >>> Cc: Alex Deucher <alexander.deucher@amd.com>
> > > >>> Reported-by: Edgar Merger <Edgar.Merger@emerson.com>
> > > >>> Suggested-by: Joerg Roedel <jroedel@suse.de>
> > > >>> Link:
> > > >>>
> >
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__nam11.safelinks.p
> rotection.outlook.com_-3Furl-3Dhttps-253A-252F-252Furld&d=3DDwIFAw&c=3DjOU
> RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-862rdSP1
> 3_P6LVp7j_9l1xmg&m=3DZhN0Jau6oCc4cnz64IhGK2-XDiD5D_6vW6ZYbifWYF0&s=3DndvE-
> ezxTBweMMUjyMWdiCyPB6GDIS_eWs0kmZwqtpY&e=3D
> > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> 3A__nam11.safelinks.p&amp
> >
> ;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7C1d797071822d47ce6
> c9808d8
> >
> 9129698f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637418954
> 3633797
> >
> 99%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> zIiLCJBTiI
> >
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DVLlzQtS3KWZqQslcJKZYrG
> sj6eMk3
> > VWaE%2BXhbNdRx80%3D&amp;reserved=3D0
> > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> 252Furld&d=3DDwIFAw&c=3DjOU
> >
> RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-
> 862rdSP1
> > 3_P6LVp7j_9l1xmg&m=3DMMI_EgCqeOX4EvIftpL7agRxJ-
> udp1CLokf2QWuzFgE&s=3DZLdz6
> > OgavzNn2vSzsgyL1IB6MbK7hPKavOYwbLhyTPU&e=3D
> > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> >
> 3A__lore%26d%3DDwIDAw%26c%3DjOURTkCZzT8tVB5xPEYIm3YJGoxoTaQs
> > QPzPKJGaWbo%26r%3DBJxhacqqa4K1PJGm6_-
> >
> 862rdSP13_P6LVp7j_9l1xmg%26m%3DlNXu2xwvyxEZ3PzoVmXMBXXS55jsmf
> >
> DicuQFJqkIOH4%26s%3D_5VDNCRQdA7AhsvvZ3TJJtQZ2iBp9c9tFHIleTYT_ZM
> >
> %26e%3D&amp;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7C6d5f
> >
> a241f9634692c03908d8904a942c%7C3dd8961fe4884e608e11a82d994e183d%7
> >
> C0%7C0%7C637417997272974427%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> >
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100
> >
> 0&amp;sdata=3DOEgYlw%2F1YP0C%2FnWBRQUxwBH56mGOJxYMWSQ%2Fj1Y
> > 9f6Q%3D&amp;reserved=3D0 .
> > > >>> kernel.org/linux-
> > > >>>
> > iommu/MWHPR10MB1310F042A30661D4158520B589FC0@MWHPR10M
> > > >>> B1310.namprd10.prod.outlook.com
> > > >>>
> >
> her%40amd.com%7C1a883fe14d0c408e7d9508d88fb5df4e%7C3dd8961fe488
> > > >>>
> >
> 4e608e11a82d994e183d%7C0%7C0%7C637417358593629699%7CUnknown%7
> > > >>>
> >
> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> > > >>>
> >
> LCJXVCI6Mn0%3D%7C1000&amp;sdata=3DTMgKldWzsX8XZ0l7q3%2BszDWXQJJ
> > > >>> LOUfX5oGaoLN8n%2B8%3D&amp;reserved=3D0
> > > >>> Signed-off-by: Will Deacon <will@kernel.org>
> > > >>> ---
> > > >>>
> > > >>> Hi all,
> > > >>>
> > > >>> Since Joerg is away at the moment, I'm posting this to try to =

> > > >>> make some progress with the thread in the Link: tag.
> > > >> + Felix
> > > >>
> > > >> What system is this?  Can you provide more details?  Does a =

> > > >> sbios update fix this?  Disabling ATS for all Ravens will break =

> > > >> GPU compute for a lot of people.  I'd prefer to just black list =

> > > >> this particular system (e.g., just SSIDs or revision) if possible.
> > >
> > > +Ray
> > >
> > > There are already many systems where the IOMMU is disabled in the =

> > > BIOS, or the CRAT table reporting the APU compute capabilities is =

> > > broken. Ray has been working on a fallback to make APUs behave =

> > > like dGPUs on such systems. That should also cover this case where =

> > > ATS is blacklisted. That said, it affects the programming model, =

> > > because we don't support the unified and coherent memory model on =

> > > dGPUs like we do on APUs with IOMMUv2. So it would be good to make =

> > > the conditions for this workaround as narrow as possible.
> >
> > Yes, besides the comments from Alex and Felix, may we get your =

> > firmware version (SMC firmware which is from SBIOS) and device id?
> >
> > > >>>    | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx =

> > > >>> timeout, signaled seq=3D1, emitted seq=3D3
> >
> > It looks only gfx ib test passed, and fails to lanuch desktop, am I rig=
ht?
> >
> > We would like to see whether it is Raven, Raven kicker (new Raven), =

> > or Picasso. In our side, per the internal test result, we didn't see =

> > the similiar issue on Raven kicker and Picasso platform.
> >
> > Thanks,
> > Ray
> >
> > >
> > > These are the relevant changes in KFD and Thunk for reference:
> > >
> > > ### KFD ###
> > >
> > > commit 914913ab04dfbcd0226ecb6bc99d276832ea2908
> > > Author: Huang Rui <ray.huang@amd.com>
> > > Date:=A0=A0 Tue Aug 18 14:54:23 2020 +0800
> > >
> > >  =A0=A0=A0 drm/amdkfd: implement the dGPU fallback path for apu (v6)
> > >
> > >  =A0=A0=A0 We still have a few iommu issues which need to address, so =

> > > force raven
> > >  =A0=A0=A0 as "dgpu" path for the moment.
> > >
> > >  =A0=A0=A0 This is to add the fallback path to bypass IOMMU if IOMMU =
v2 =

> > > is disabled
> > >  =A0=A0=A0 or ACPI CRAT table not correct.
> > >
> > >  =A0=A0=A0 v2: Use ignore_crat parameter to decide whether it will go =

> > > with IOMMUv2.
> > >  =A0=A0=A0 v3: Align with existed thunk, don't change the way of rave=
n, =

> > > only renoir
> > >  =A0=A0=A0=A0=A0=A0=A0 will use "dgpu" path by default.
> > >  =A0=A0=A0 v4: don't update global ignore_crat in the driver, and rev=
ise =

> > > fallback
> > >  =A0=A0=A0=A0=A0=A0=A0 function if CRAT is broken.
> > >  =A0=A0=A0 v5: refine acpi crat good but no iommu support case, and =

> > > rename the
> > >  =A0=A0=A0=A0=A0=A0=A0 title.
> > >  =A0=A0=A0 v6: fix the issue of dGPU initialized firstly, just modify =

> > > the report
> > >  =A0=A0=A0=A0=A0=A0=A0 value in the node_show().
> > >
> > >  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
> > >  =A0=A0=A0 Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > >  =A0=A0=A0 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > >
> > > ### Thunk ###
> > >
> > > commit e32482fa4b9ca398c8bdc303920abfd672592764
> > > Author: Huang Rui <ray.huang@amd.com>
> > > Date:=A0=A0 Tue Aug 18 18:54:05 2020 +0800
> > >
> > >  =A0=A0=A0 libhsakmt: remove is_dgpu flag in the hsa_gfxip_table
> > >
> > >  =A0=A0=A0 Whether use dgpu path will check the props which exposed f=
rom
> kernel.
> > >  =A0=A0=A0 We won't need hard code in the ASIC table.
> > >
> > >  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
> > >  =A0=A0=A0 Change-Id: I0c018a26b219914a41197ff36dbec7a75945d452
> > >
> > > commit 7c60f6d912034aa67ed27b47a29221422423f5cc
> > > Author: Huang Rui <ray.huang@amd.com>
> > > Date:=A0=A0 Thu Jul 30 10:22:23 2020 +0800
> > >
> > >  =A0=A0=A0 libhsakmt: implement the method that using flag which expo=
sed =

> > > by kfd to configure is_dgpu
> > >
> > >  =A0=A0=A0 KFD already implemented the fallback path for APU. Thunk w=
ill =

> > > use flag
> > >  =A0=A0=A0 which exposed by kfd to configure is_dgpu instead of hardc=
ode
> before.
> > >
> > >  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
> > >  =A0=A0=A0 Change-Id: I445f6cf668f9484dd06cd9ae1bb3cfe7428ec7eb
> > >
> > > Regards,
> > >  =A0 Felix
> > >
> > >
> > > > Cheers, Alex. I'll have to defer to Edgar for the details, as my =

> > > > understanding from the original thread over at:
> > > >
> > > >
> >
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__nam11.safelinks.p
> rotection.outlook.com_-3Furl-3Dhttps-253A-252F-252Furld&d=3DDwIFAw&c=3DjOU
> RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-862rdSP1
> 3_P6LVp7j_9l1xmg&m=3DZhN0Jau6oCc4cnz64IhGK2-XDiD5D_6vW6ZYbifWYF0&s=3DndvE-
> ezxTBweMMUjyMWdiCyPB6GDIS_eWs0kmZwqtpY&e=3D
> > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> 3A__nam11.safelinks.p&amp
> >
> ;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7C1d797071822d47ce6
> c9808d8
> >
> 9129698f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637418954
> 3633797
> >
> 99%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> zIiLCJBTiI
> >
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DVLlzQtS3KWZqQslcJKZYrG
> sj6eMk3
> > VWaE%2BXhbNdRx80%3D&amp;reserved=3D0
> > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> 252Fur&d=3DDwIFAw&c=3DjOURT
> > kCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-
> 862rdSP13_
> > P6LVp7j_9l1xmg&m=3DMMI_EgCqeOX4EvIftpL7agRxJ-
> udp1CLokf2QWuzFgE&s=3DIPZRolk
> > y3TYlbWPsOkY37MbDdzwhc1b_LaE6JkaOkOo&e=3D
> > > > ldefense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > 3A__lore.kernel.org&a
> > > >
> >
> mp;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7C6d5fa241f963469
> > 2c039
> > > >
> >
> 08d8904a942c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63741
> > 79972
> > > >
> >
> 72974427%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > V2luMzI
> > > >
> >
> iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DiKTPucGQqcRXET
> > QZiQz
> > > > j90WdJeCYDytdZHJ1ZiUyR%2FM%3D&amp;reserved=3D0
> > > > _linux-2Diommu_MWHPR10MB1310CDB6829DDCF5EA84A14689150-
> > 40MWHPR10MB131
> > > >
> >
> 0.namprd10.prod.outlook.com_&d=3DDwIDAw&c=3DjOURTkCZzT8tVB5xPEYIm3Y
> > JGoxo
> > > > TaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-
> > 862rdSP13_P6LVp7j_9l1xmg&m=3DlNXu
> > > >
> >
> 2xwvyxEZ3PzoVmXMBXXS55jsmfDicuQFJqkIOH4&s=3DdsAVVJbD7gJIj3ctZpnnU
> > 60y21
> > > > ijWZmZ8xmOK1cO_O0&e=3D
> > > >
> > > > is that this is a board developed by his company.
> > > >
> > > > Edgar -- please can you answer Alex's questions?
> > > >
> > > > Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
