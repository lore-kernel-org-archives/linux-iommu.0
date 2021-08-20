Return-Path: <SRS0=ckUw=NL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF4DC4320A
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 19:22:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA80261130
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 19:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA80261130
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91FFF606CF;
	Fri, 20 Aug 2021 19:22:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GYeE_SwcTOHv; Fri, 20 Aug 2021 19:22:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 65F8B6063A;
	Fri, 20 Aug 2021 19:22:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4321DC001A;
	Fri, 20 Aug 2021 19:22:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E530EC000E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 19:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BE2C86063A
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 19:22:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rfe9POItbYuV for <iommu@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 19:22:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from outbound.mail.eo.outlook.com
 (mail-oln040093008010.outbound.protection.outlook.com [40.93.8.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F06760670
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 19:22:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzodoZrq5U0TGafkMgl8AUuSPyMClQn6jiRFX7PvtZEYAzfyFJAg91NRmvMCdHF9gjjKDrTKUqdaCVd/qsTweTKsOeQWO9WzzYGtb/PHrgTgxDB2iBROuop0APk41vINy0rMZLs01+P0t6T8+4742aBz0MQGENtR5EKY6pJkPqCJTm+pIz6NNffV6PfF564f7linR/Wo5gJKC6RvynVCxHaEsAYVirB4uOC2ZSnsoBT4L94MLXpC9lP5K1qCk5sxm3dJHlj9WS38ZokbqoLa8hGODq4iIR2DE633JzBQ719uhoxpkxPnaG2kh0uShkhZ/aaaIo2e/rKVAfdqZpYS8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nijsuRvOJ23nsVmLpYc5DV21YnvuxPrMi13EC1b7neQ=;
 b=V66kKHFWWE3Nue0n2WcgCNCr4/ReSRzOCQSkcMhaO/qSJzCHq15XUN++aPn5lSdW3IhaVwjkB65Kkuk2gCPi3ZPrzRjzYw43VAfKvTW8cHfbe8HMXTcn8JRDysiBIkURfJwyN2yjpc4dU6HSxqdpEs/uzoT2BHlH3OnY6ML10jOo9QuqoCmMs7sgSzprNnIm8M8vbJlmUWlr+5m93K8PAxr6vomcZ/q2Jat0ZkaLydSEBaWA4jOU3vmsTj3W8CgkRBMnC5mQ+TM/ro5njjA/lkxG9od7xgBC8XwhOSeU2sHWLMuwrCTi/Uj2JT70k47rr+Dc+1ahoHyova7457mhxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nijsuRvOJ23nsVmLpYc5DV21YnvuxPrMi13EC1b7neQ=;
 b=GiJdV2HSWswR4HtjJgxNfECN3LcjsqPqHM96HfRNhWTrEDBBUV77LDnL0sgn5uqP7o88fDBa6/RsLsx8Bb99DthqPMpTHKyrjjYch6ZXsDrO/DtznNnrHq36lOC7Rn7+vvKQTf63YSNfDxRvFlq/DqBDNwPh7lLOLYoeNkpU6eA=
Received: from CY4PR21MB1586.namprd21.prod.outlook.com (2603:10b6:910:90::10)
 by CY4PR21MB0280.namprd21.prod.outlook.com (2603:10b6:903:bb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6; Fri, 20 Aug
 2021 19:22:14 +0000
Received: from CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::686d:43d8:a7e8:1aa6]) by CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::686d:43d8:a7e8:1aa6%8]) with mapi id 15.20.4457.007; Fri, 20 Aug 2021
 19:22:14 +0000
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
Thread-Index: AQHXjUf4MnryDC/QY0a+heAsfHsxAqt3v7VggATTgoCAAAfhIIAAJeaAgAAM0aA=
Date: Fri, 20 Aug 2021 19:22:14 +0000
Message-ID: <CY4PR21MB158655D98947D66C1C8B80B3D7C19@CY4PR21MB1586.namprd21.prod.outlook.com>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-14-ltykernel@gmail.com>
 <MWHPR21MB1593EEF30FFD5C60ED744985D7C09@MWHPR21MB1593.namprd21.prod.outlook.com>
 <a96626db-4ac9-3ce4-64e9-92568e4f827a@gmail.com>
 <CY4PR21MB158664748760672446BFA075D7C19@CY4PR21MB1586.namprd21.prod.outlook.com>
 <939aa552-5c24-65ee-518d-1cf72867c15d@gmail.com>
In-Reply-To: <939aa552-5c24-65ee-518d-1cf72867c15d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0ba912b1-2bad-45cd-923b-a60bd443d8c3;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-20T18:50:03Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24d7f675-86d5-41ad-9da2-08d9640fd10e
x-ms-traffictypediagnostic: CY4PR21MB0280:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB02800876B8C69885C5DFD7E5D7C19@CY4PR21MB0280.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eLeThGL+2lxj/EfsBL3cZ4P03clXBgcRcqDYtOsesgeRHs5z0qnZdu5fole5HKbixBvEKKPUvHiPtC/V+hsyeQcITyyE4UAKpGMx/IL5XvZ2AvSfRj09DqG/iOaF+TWiZawfbn31pFDAyUC2bn0QczYqcT591GpGn2fx6hDQei1MubCIE626EvuwR6FuD9qZtZgq53j8QCPauBXerLlblsnJqNCR2S7DQcgPUZbIHvHIBHlQ3Tcmr8eA6hDspTX+bCYmEbPYNMl+23H3c/MxrpUpDF5y+VTknxqDQg7Zu+FVd4FbPCC3tMacmAEGMKwAEnjk0xkbT2y7dypMP0G+RzmhcN1TnnLEWeY/mbUYTWfzG3a5rezO7YsgA+K94oMctv1iDykKp6H4ryM8ssC7EbFEYCQqOepKzDYosfyKHLOScume2NhRtD+XFfEKeOAXukPw6giJsqm/M9yVc8eE3xPVl6Z+sNJrq2JtE2dDhAuQNiAP3BTWHVRjPN/HuytJEdKKO3ShioeIbiTWRwQAM/5kjdLZLVCB5aPwcbd+om7oCNlYlyQWL4KofvQlfCCPojpeBdgiY/ICVS8/uh59HPuGNPtGlUwbbT3xoZMuSHgPYrxA9j1Y0pW6ngCt+U5xTIYHjnoWuKom4T7CygQb//w1/um+WcbjQbPTcwct1/yp8xlD38m2vFJVkgzuDw7rsmaznkbvocmsEsqgUH3fADFAqRyO9eO9yLmrVSwa000=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR21MB1586.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(316002)(26005)(86362001)(55016002)(54906003)(33656002)(82950400001)(122000001)(8676002)(4326008)(53546011)(64756008)(110136005)(9686003)(38100700002)(8936002)(38070700005)(71200400001)(10290500003)(7406005)(8990500004)(66476007)(7416002)(76116006)(186003)(6506007)(52536014)(66446008)(5660300002)(921005)(7696005)(2906002)(82960400001)(508600001)(66946007)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZC85ZUI4Yll0clhJWFBURFF2dzFZV3RvZnJqM1MzakFJMExVNUlaUXE2U3lK?=
 =?utf-8?B?VDN5Um5nWUZqUEE5L2ErbFlWV0Q2MjV6Slg0UE1aWi9SMk9Tc0dKUmFIZ3Bs?=
 =?utf-8?B?b2Iya3dyWEVJUVozdnRPQkZZeU9ZV2t3K0N6cjNiQ3MzM2RjUVhEUzVyRzgz?=
 =?utf-8?B?QjJjRE9BbmowNjA3WTFlQTdSeVZlVko0dlBUU3R3cTFaQjJKclVnaVJtV005?=
 =?utf-8?B?aHd2Q29pKzRsMTRYZTROc1VEcndaeDdyenFGKzBIU0NTRXEyQXM0R3ByWTQv?=
 =?utf-8?B?di83V1NScXU0UDdpUHd2SVVKdUN6VW1FOEdUd0JDV0ZBMFRlN2tZTkJEWEE2?=
 =?utf-8?B?a3pKM1J1eEkrMXNWUnFYeXc3aTIwTVhsTUgvR1BORjNTN2orS1luZVh0RGxv?=
 =?utf-8?B?VUMzSnk1UHhMRWpJdWdqbStGdU5KYTJzRUJVd0tlTy91SURDYml3bXVTYzFS?=
 =?utf-8?B?V1ZGSjAyNnpIR2ZMQW11RnEwMElWdTlxWDB5eDl2Tm9DcEtvdGVJdWFyUGVL?=
 =?utf-8?B?M0tYTjFUWTE5S3dVYnBJUHkrU0VzMHhPNG9iM3hUcXhYdzhpWjVVVzZxRFNJ?=
 =?utf-8?B?OGdLeklBVDBlbVNhY1NzMFZ6RVhIMnFQZ0xkNFZ4RkYyWHp0WkdROE9uWEhy?=
 =?utf-8?B?SjRDcEh2UC9YYzJYalBGRkxPZGVVMjhXVmtoc21rbWVNaWozZ3UraU1iNG1Y?=
 =?utf-8?B?blYyU2szcXF3SllPcHFSNk54dC9NbEhQRlBQRDA5d2RZUWI5SFhJcHEyMitZ?=
 =?utf-8?B?OFEzYm9Tc1pDL1VHeFBLQjVZZEJzTlkzSVk1aVBkZXNHaldKTkdLWVU1djNR?=
 =?utf-8?B?NU5oYy9FdEkyQmdrUFVzWkFzQnlYU2ZrMmRnUCtmTDhPMW44cVV5ckt1S3dX?=
 =?utf-8?B?YnBLQllqaEozeS9RTTEvM0pSV3kvcDh6bjZPdzNTeUZFcHZiL2Q1TFc1SlVU?=
 =?utf-8?B?aENkZkRxMWVHVEJRNlk3YmVYeEh0RXBJa0FIYmdCanBDc2pIMXhFQnhsWDFt?=
 =?utf-8?B?K1RNME1hOHFvV2xhWmFjYTZrdmFLTWJMaUhyMUZja0h1YWcxQks2SHJpR1hI?=
 =?utf-8?B?QlAzWXk2T1FIaUtsYzJKa21NQjFLWGc2MStNRGZGOGJZb1FxM0IxTFp1U29I?=
 =?utf-8?B?MCtJQVJBQkhhblovRkw5ZUVnOEY2U2NNemlrdnM1UisxQXZNUWs4M0ZRd216?=
 =?utf-8?B?Q05HN0tCTHk1cWNCbHZsY0xReXdrTk5yL1A2cnVQaUFyakdkTlhpV0pMTGVz?=
 =?utf-8?B?Vk8wa3ExTE5sWDdieXdBbDhPUllTQ1lHMG50NjdTVzFPU3pSSCtmbnk1UDhP?=
 =?utf-8?B?R1lPMUNhTll3S0ZhZlNNajVkZ1ozWlhxRjVGMHd1RFN3Qk9yMEJHQkZaVU5u?=
 =?utf-8?B?Q1pYNGpmbVRxYXRhRFFsekJFUEZpSXpWY2hNcGs4ZjBBN2o0VURPaURrSmtW?=
 =?utf-8?B?Uk5UZS9USWQ1S0N2MnFmQ2kzODZhNC9JUE1yODNsdmhQTnlUQXFXa1ZYeFdC?=
 =?utf-8?B?R2orRHF2M3Y3NklnS1hLQ2RyUXJ1MXp1S0U5L0V1Q3RqdFBrU1Qrc1owaThi?=
 =?utf-8?B?YkdoUWR4QWRNRDNoS0ZsN0pNbDlRVE84UGw3YVl2ZnlvRmdlY3Vmb0gvYnNR?=
 =?utf-8?B?WStCS2xPRUZKd1VnMXhrcHBXR3pFRjJMVHJGOEgrVUVwVEh3NlhkS1dVV0or?=
 =?utf-8?B?ejZncVNXV1U3UG90YTFNZ0hzeHM1S20zSkd3OVdvMVRkejJWUTE3ZFpUenVW?=
 =?utf-8?Q?F5mEVZ5P0anxObU2dpBW71v9BSvqYRNsTcNtsaA?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR21MB1586.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d7f675-86d5-41ad-9da2-08d9640fd10e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 19:22:14.1800 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SqILgPuiapj/MmCXfScJLA4Yxao5XWu94HGgwVOQddBGv82AAtJ/bdPhIpcF/8pyCvwycQ7Cx9YBLaMFf5240xBLw1rztk2dS0qJTi/QGYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0280
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

From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, August 20, 2021 11:04 AM
> 
> On 8/21/2021 12:08 AM, Michael Kelley wrote:
> >>>>    	}
> >>> The whole approach here is to do dma remapping on each individual page
> >>> of the I/O buffer.  But wouldn't it be possible to use dma_map_sg() to map
> >>> each scatterlist entry as a unit?  Each scatterlist entry describes a range of
> >>> physically contiguous memory.  After dma_map_sg(), the resulting dma
> >>> address must also refer to a physically contiguous range in the swiotlb
> >>> bounce buffer memory.   So at the top of the "for" loop over the scatterlist
> >>> entries, do dma_map_sg() if we're in an isolated VM.  Then compute the
> >>> hvpfn value based on the dma address instead of sg_page().  But everything
> >>> else is the same, and the inner loop for populating the pfn_arry is unmodified.
> >>> Furthermore, the dma_range array that you've added is not needed, since
> >>> scatterlist entries already have a dma_address field for saving the mapped
> >>> address, and dma_unmap_sg() uses that field.
> >> I don't use dma_map_sg() here in order to avoid introducing one more
> >> loop(e,g dma_map_sg()). We already have a loop to populate
> >> cmd_request->dma_range[] and so do the dma map in the same loop.
> >>
> > I'm not seeing where the additional loop comes from.  Storvsc
> > already has a loop through the sgl entries.  Retain that loop and call
> > dma_map_sg() with nents set to 1.  Then the sequence is
> > dma_map_sg() --> dma_map_sg_attrs() --> dma_direct_map_sg() ->
> > dma_direct_map_page().  The latter function will call swiotlb_map()
> > to map all pages of the sgl entry as a single operation.
> 
> After dma_map_sg(), we still need to go through scatter list again to
> populate payload->rrange.pfn_array. We may just go through the scatter
> list just once if dma_map_sg() accepts a callback and run it during go
> through scatter list.

Here's some code for what I'm suggesting (not even compile tested).
The only change is what's in the "if" clause of the SNP test.  dma_map_sg()
is called with the nents parameter set to one so that it only
processes one sgl entry each time it is called, and doesn't walk the
entire sgl.  Arguably, we don't even need the SNP test and the else
clause -- just always do what's in the if clause.

The corresponding code in storvsc_on_channel_callback would also
have to be changed.   And we still have to set the min_align_mask
so swiotlb will preserve any offset.  Storsvsc already has things set up
so that higher levels ensure there are no holes between sgl entries,
and that needs to stay true.

	if (sg_count) {
		unsigned int hvpgoff, hvpfns_to_add;
		unsigned long offset_in_hvpg = offset_in_hvpage(sgl->offset);
		unsigned int hvpg_count = HVPFN_UP(offset_in_hvpg + length);
		u64 hvpfn;
		int nents;

		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {

			payload_sz = (hvpg_count * sizeof(u64) +
				      sizeof(struct vmbus_packet_mpb_array));
			payload = kzalloc(payload_sz, GFP_ATOMIC);
			if (!payload)
				return SCSI_MLQUEUE_DEVICE_BUSY;
		}

		payload->range.len = length;
		payload->range.offset = offset_in_hvpg;


		for (i = 0; sgl != NULL; sgl = sg_next(sgl)) {
			/*
			 * Init values for the current sgl entry. hvpgoff
			 * and hvpfns_to_add are in units of Hyper-V size
			 * pages. Handling the PAGE_SIZE != HV_HYP_PAGE_SIZE
			 * case also handles values of sgl->offset that are
			 * larger than PAGE_SIZE. Such offsets are handled
			 * even on other than the first sgl entry, provided
			 * they are a multiple of PAGE_SIZE.
			 */
			hvpgoff = HVPFN_DOWN(sgl->offset);

			if (hv_isolation_type_snp()) {
				nents = dma_map_sg(dev->device, sgl, 1, scmnd->sc_data_direction);
				if (nents != 1)
					<return error code so higher levels will retry>
				hvpfn = HVPFN_DOWN(sg_dma_address(sgl)) + hvpgoff;
			} else {
				hvpfn = page_to_hvpfn(sg_page(sgl)) + hvpgoff;
			}

			hvpfns_to_add = HVPFN_UP(sgl->offset + sgl->length) -
						hvpgoff;

			/*
			 * Fill the next portion of the PFN array with
			 * sequential Hyper-V PFNs for the contiguous physical
			 * memory described by the sgl entry. The end of the
			 * last sgl should be reached at the same time that
			 * the PFN array is filled.
			 */
			while (hvpfns_to_add--)
				payload->range.pfn_array[i++] = hvpfn++;
		}
	}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
