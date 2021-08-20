Return-Path: <SRS0=ckUw=NL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326A6C4338F
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 16:08:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD90C6121F
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 16:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD90C6121F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9631640105;
	Fri, 20 Aug 2021 16:08:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TJSX0GzClLZ8; Fri, 20 Aug 2021 16:08:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4F364401BA;
	Fri, 20 Aug 2021 16:08:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3034BC001A;
	Fri, 20 Aug 2021 16:08:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A1ACC000E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 16:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 75887600C6
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 16:08:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0fQKM_2hABCV for <iommu@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 16:08:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from outbound.mail.eo.outlook.com
 (mail-oln040093003010.outbound.protection.outlook.com [40.93.3.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 516DB60008
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 16:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TY6igOUyzdF0rVBZ2UcB6Ev9ueZEF7QpwENfv6Per5IcgZDPKYTiFXkbxOJEJMnAGLgt+8uo6McgHzrhQ/AdJlaieu1jNYEGjKCAYaz2BLhZ1qYiqRaS93n256s9xVMg2VTEi4L4s98d9JKTwVu+eVIU38Eh7SbbcXtmVM8nEa66A0oaAKmUjOsPYCUTmiQp3mw8OmT4q3r5Y0L3eK0KfwZyKcnMjJYo1CQItX89eY4jkOjosKmTJ9q/zz3woENsE5/JEYjC/Xt+awy44Aoh57BqWALUd5C9zid/yZS4h02OV6qv/E8yq3si9vcrjInA0FlIpzptwQOv79YTh1An8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+H0tDeTmwPsXkAmbo0pX2aftdDFEj/VcfEvMEKiOGi4=;
 b=L4lTkr9uiEeQ+H/6GXxv8YnQk83P4J69DIT7GuJaPeXadhWVILDfo430dpH6t2TIk14F8MDFVXaTq6uZjCxiN/RgdKpxYrd1l5gS5O5Jo1Tr3IxXUByqjFEQnpFnINk4HQEpgXPgUQFHx2dA/FjuSRZMpDC7VJSP3Qwqld5q0YY9DZQaWNBC7aiRgfaU+95M/eUAxsfiuWivHEd4w/Ft0HaY/kJ7ljS/WbWyX/C1ODpnpbfG7G5D1QATS9JxWa5JTumM7c4kdNi2gtViFGoPsCrFG1AvH4S20hhEQo9kwqTO/k4NSKmbziDwzdwXyz2MfjEk4sDgCOVUnzdIfpxbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+H0tDeTmwPsXkAmbo0pX2aftdDFEj/VcfEvMEKiOGi4=;
 b=Qo4QhWF7WhFLlT6/ElfXBMMRDGgJzhTnJ0579en7N1NDXqfeCvmbvSXnZ7ginKUHwagg218BMnRMsM1Cl4Htj/W4s79orbnnvZ8MvB9kNeqyx4eTOAn7wPcCo6mP8mOz2d6DAStkuGnWyLeNW/prDhngSaM9P3GriTnfV4Yrxrs=
Received: from CY4PR21MB1586.namprd21.prod.outlook.com (2603:10b6:910:90::10)
 by CY4PR21MB0630.namprd21.prod.outlook.com (2603:10b6:903:12e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.1; Fri, 20 Aug
 2021 16:08:32 +0000
Received: from CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::686d:43d8:a7e8:1aa6]) by CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::686d:43d8:a7e8:1aa6%8]) with mapi id 15.20.4457.007; Fri, 20 Aug 2021
 16:08:32 +0000
To: Tianyu Lan <ltykernel@gmail.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "jgross@suse.com"
 <jgross@suse.com>, "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
 <kuba@kernel.org>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "brijesh.singh@amd.com"
 <brijesh.singh@amd.com>, "ardb@kernel.org" <ardb@kernel.org>, Tianyu Lan
 <Tianyu.Lan@microsoft.com>, "pgonda@google.com" <pgonda@google.com>,
 "martin.b.radev@gmail.com" <martin.b.radev@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>, "sfr@canb.auug.org.au"
 <sfr@canb.auug.org.au>, "saravanand@fb.com" <saravanand@fb.com>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "rientjes@google.com" <rientjes@google.com>, "hannes@cmpxchg.org"
 <hannes@cmpxchg.org>, "tj@kernel.org" <tj@kernel.org>
Subject: RE: [PATCH V3 13/13] HV/Storvsc: Add Isolation VM support for storvsc
 driver
Thread-Topic: [PATCH V3 13/13] HV/Storvsc: Add Isolation VM support for
 storvsc driver
Thread-Index: AQHXjUf4MnryDC/QY0a+heAsfHsxAqt3v7VggATTgoCAAAfhIA==
Date: Fri, 20 Aug 2021 16:08:32 +0000
Message-ID: <CY4PR21MB158664748760672446BFA075D7C19@CY4PR21MB1586.namprd21.prod.outlook.com>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-14-ltykernel@gmail.com>
 <MWHPR21MB1593EEF30FFD5C60ED744985D7C09@MWHPR21MB1593.namprd21.prod.outlook.com>
 <a96626db-4ac9-3ce4-64e9-92568e4f827a@gmail.com>
In-Reply-To: <a96626db-4ac9-3ce4-64e9-92568e4f827a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=17b8e382-57d0-4c83-8b70-e6b9188dc733;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-20T15:48:32Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee0201dd-fdff-4203-0104-08d963f4c1f9
x-ms-traffictypediagnostic: CY4PR21MB0630:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB063069C91821DB2B19844FC4D7C19@CY4PR21MB0630.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zhmVJrKlueJP0U4GmOu0PtiGsKg+aF6JDSCxkBOYRH2XVjbEtuYDPVU8ZTR/Y/mwm13CYY/wo/KvDWzLy0bgK+LbADZMaf6V+PscVEOh1J6HFtkXyu2kob7RmgMCFMrzEel5VnPoCNoxLsGIbAYZ1qu3EsPgzKUEC0vOau0z8M61wwRolh3x8tsk/10gwKv71MqOpaXPgAz87nh1TrnVI8HxeVpxg8/osbq7S0cWojFHNH2UNhSIHS5+cYRW3dBkema4u3Rb7755PYw1RzU2VRDgWmAQO7tYRmySgNtMnIeXJD9CkqLjlEAZSTIYCtNuHgRL0RE5XkyivpAsasOevZhOEqEC7k9FwydF15rDNGUIugyoJ75b3PhCDDW3lifGnGPn4Ghq1Vs/eQwVFr2rg9CS+a1RqC30qXip77D248sm16HyO+agl5bZQGQtT0j0w+YrtplCrvX1M+5X2+A4B+tXzA7ZKn4nDOSWx7DG52wNgn+z4OjCE3ZDbsxNVwBw0TuhTkfQlvP28H9FgPMGrDr2T5f3Ql+iGb/LzBoGHJW/Fr1y5jyRcIKPtYsBLwTohp21TfleJbRcRYvVWi1bpko4AEeM4UHQGrrlMJUeVjVNzNl/hWr5/f0AKpVZwLCiB4QDUR/5I3j9HfHka/5cunzjCbck9N80A0x5Cu4hnJZD7Lekimt7PLr+N/7ggVZjb49cidDNQwZrAPkATwU7W9520lbu/NB+wzzWkay/9uE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR21MB1586.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(316002)(8936002)(4326008)(8990500004)(86362001)(83380400001)(71200400001)(10290500003)(66476007)(66556008)(64756008)(110136005)(8676002)(921005)(54906003)(76116006)(186003)(66946007)(66446008)(7416002)(55016002)(2906002)(38100700002)(6506007)(7406005)(9686003)(52536014)(82950400001)(82960400001)(33656002)(7696005)(38070700005)(122000001)(5660300002)(26005)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnhQNlFId0pVQkMya0hsdXpYVnJLU3U0blY3RDhORnlhcGt0Vmw0QTN1UGRw?=
 =?utf-8?B?M1Zub0JXcU16TkxCTmMyWXZZV1lOTnExZENEWGU1K3ppMjJSMG1jZ2phU1hv?=
 =?utf-8?B?eGI2dEg5NjNBY1BmSXJ2K3F0dEQxdWVLZnhWcWFKdHo2V3BZU1pVSmlzcUsx?=
 =?utf-8?B?eTB3QkJYYTRYMHBDNjFpSWRJcFFBVHRrMG1QZWxOQldveUp4aGtsSit5OGEw?=
 =?utf-8?B?ZURoM2ZKV0J2N3d4a2xwaEpnTlJaMGNhQnI1SzBpeHljRW15NlBDemU0Qi9q?=
 =?utf-8?B?RTNudG5nNTkyd0gwcmtQOXdDWkM5dFBaL0oxTlp5dkU5SE9SdVVNNER4Mm1s?=
 =?utf-8?B?UG11cFN2dmtMN0xGdHdvd3NYUGU3MDlvcXdDZDl2RE1neEgwL1YxaVZDQi9w?=
 =?utf-8?B?Nk0rMmRtKzZXUnZaUGh1UWtKUjhqcnJTdEorcVMwZ1h5Q1ZNbWNVMFprVWJx?=
 =?utf-8?B?Nnp3ZE5HdEJ1NExKMXcrbnJIRkNML2xvTC9NTWd4cEFLZW54NXp3ckJKYmxJ?=
 =?utf-8?B?NFg5N3UweXIvWk8wV3FUSUJPaXpNaGZ2b0F4cFZZdDFGR2ZRekNKTVpqV041?=
 =?utf-8?B?Z080TVNmb3ozVk1zZUJjTHh5WE1UTHJBdEVwNmhBTGg2K2htZ3NiczEvQUxH?=
 =?utf-8?B?U3cycDRaVXUvVTNXbkVvZXdRS2QwNVZXNEdMT3hOM3FoemlGaElOOEZNQkNm?=
 =?utf-8?B?QlhxdWVGbXdqVnFuMjQ2a1FkTlVlUHdJMlFwdCtUR1l2RDZtNkdyNGYybVdH?=
 =?utf-8?B?aGt5SWNnWDVBZjRlQW81dFpJQjVhd1pFQ1ArTVhIczY2UjYxblJjZlhITkhE?=
 =?utf-8?B?RjlDWmM1NldIM0o0SzdISHhJQ01RaXdmVmZJZkEvRS9UWEJVUFRGZ29FbHNi?=
 =?utf-8?B?anFaUk5nWFB4NnJUelFRcGc2bTZGWmZNNnJ0c2g2Z2wyUE5JMTdtUHFhaEZG?=
 =?utf-8?B?aFdlajRmMk1kNXdMV1c1Z3BwR1hoaFAwMktaVWRIWExWcWlvTjNGNFBTVS9J?=
 =?utf-8?B?RHlpUndsdXZXRkVid2ovRFBxUEhOYkluOGJIREgzbjBCMExUMWw3NW5WWjRl?=
 =?utf-8?B?SDlxaDl0a1hybUxoeEZnOUVrWmpOSlVPVFBNRXoxNS82emU0ZUhUZEVBSmpV?=
 =?utf-8?B?MzVNRW02Q0xwRVh4VjNJSXhlZGVLdTNTZVg5Z1BTUVFoUTVnZkE2cE01UVBk?=
 =?utf-8?B?eFE1dXFaaHVvMFArSERsVkQ0U3drVDZnY1ZSbEVwb1dGcHlNTEVodFJib3Vv?=
 =?utf-8?B?YTZJZHlUVzNkUzYvMDIxaC9PNklxMS9QR1lmU3hGdDVRUk05dFV2b2tHTkhz?=
 =?utf-8?B?V2tGTElLQ0J5L3EzWkZuQVBqR3lNNVJpYzd4VWIrVDlnQ0ZFVVlWQy9tNERx?=
 =?utf-8?B?ZmgvNnFrVklaUnFhTllNdi80emFPWkFBWEV6K3lFSlhocjBCZGpoYjdIcGlD?=
 =?utf-8?B?Q3h3TjE0aXlYaHhSWnBodk5kQ3Q2dkF1RTBFQnM5RzBZbDNTNkp5VnZNQnhR?=
 =?utf-8?B?am95QVVzY09jOVhFclNIbXJhd1RQemFPclZjNjFZNUpmRUNwU3haVXp4Vk0w?=
 =?utf-8?B?TDRjblRoRFJUYzNzVjREdzlCanR6KzdZWEpGdXdJWExlZEc0S2pnNFdZUG1n?=
 =?utf-8?B?cUtmM0pjZWl5MmdSRDI3dmNwTFIvbmtOc05QV3BRaTEyRllDV1lLbFQ4S3M2?=
 =?utf-8?B?N0dyaTZLRFduWWhiWW0zR095UE41N3A5cm1vVDg4Q3BENmwwMnVWQzNGQlVt?=
 =?utf-8?Q?XAeZ88WyfJTO9t5543mrW3/uHlcr6mWfCWtlwgu?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR21MB1586.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0201dd-fdff-4203-0104-08d963f4c1f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 16:08:32.4059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xO8fyyaAz65eHLOQzdArWlu4p62qqD+BCCyq5FTn0Dg3XmvvJMiiCKkoljDBB0qwmMkM9akoOwJJiiUDD3YgRw/wF7vTOJc47XNlt5y0Eqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0630
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 vkuznets <vkuznets@redhat.com>
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
From: Michael Kelley via iommu <iommu@lists.linux-foundation.org>
Reply-To: Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, August 20, 2021 8:20 AM
> 
> On 8/20/2021 2:17 AM, Michael Kelley wrote:
> > From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, August 9, 2021 10:56 AM
> >
> > I'm not clear on why payload->range.offset needs to be set again.
> > Even after the dma mapping is done, doesn't the offset in the first
> > page have to be the same?  If it wasn't the same, Hyper-V wouldn't
> > be able to process the PFN list correctly.  In fact, couldn't the above
> > code just always set offset_in_hvpg = 0?
> 
> The offset will be changed. The swiotlb bounce buffer is allocated with
> IO_TLB_SIZE(2K) as unit. So the offset here may be changed.
> 

We need to prevent the offset from changing.  The storvsc driver passes
just a PFN list to Hyper-V, plus an overall starting offset and length.  Unlike
the netvsc driver, each entry in the PFN list does *not* have its own offset
and length.  Hyper-V assumes that the list is "dense" and that there are
no holes (i.e., unused memory areas).

For example, consider an original buffer passed into storvsc_queuecommand()
of 8 Kbytes, but aligned with 1 Kbytes at the end of the first page, then
4 Kbytes in the second page, and 3 Kbytes in the beginning of the third page.
The offset of that first 1 Kbytes has to remain as 3 Kbytes.  If bounce buffering
moves it to a different offset, there's no way to tell Hyper-V to ignore the
remaining bytes in the first page (at least not without using a different
method to communicate with Hyper-V).   In such a case, the wrong
data will get transferred.  Presumably the easier solution is to set the
min_align_mask field as Christop suggested.

> 
> >
> >>   	}
> >
> > The whole approach here is to do dma remapping on each individual page
> > of the I/O buffer.  But wouldn't it be possible to use dma_map_sg() to map
> > each scatterlist entry as a unit?  Each scatterlist entry describes a range of
> > physically contiguous memory.  After dma_map_sg(), the resulting dma
> > address must also refer to a physically contiguous range in the swiotlb
> > bounce buffer memory.   So at the top of the "for" loop over the scatterlist
> > entries, do dma_map_sg() if we're in an isolated VM.  Then compute the
> > hvpfn value based on the dma address instead of sg_page().  But everything
> > else is the same, and the inner loop for populating the pfn_arry is unmodified.
> > Furthermore, the dma_range array that you've added is not needed, since
> > scatterlist entries already have a dma_address field for saving the mapped
> > address, and dma_unmap_sg() uses that field.
> 
> I don't use dma_map_sg() here in order to avoid introducing one more
> loop(e,g dma_map_sg()). We already have a loop to populate
> cmd_request->dma_range[] and so do the dma map in the same loop.
> 

I'm not seeing where the additional loop comes from.  Storvsc
already has a loop through the sgl entries.  Retain that loop and call
dma_map_sg() with nents set to 1.  Then the sequence is
dma_map_sg() --> dma_map_sg_attrs() --> dma_direct_map_sg() ->
dma_direct_map_page().  The latter function will call swiotlb_map()
to map all pages of the sgl entry as a single operation.

Michael


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
