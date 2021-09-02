Return-Path: <SRS0=cE/7=NY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D612C87FDE
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 16:30:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A9EF61268
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 16:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A9EF61268
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D91C640781;
	Thu,  2 Sep 2021 16:14:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LtRi3smcBCXc; Thu,  2 Sep 2021 16:14:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9AB6C4012B;
	Thu,  2 Sep 2021 16:14:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7158BC001A;
	Thu,  2 Sep 2021 16:14:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00244C000E
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 16:14:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D65186071C
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 16:14:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LUDmsEGKrPUy for <iommu@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 16:14:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from na01-obe.outbound.protection.outlook.com
 (mail-oln040093003005.outbound.protection.outlook.com [40.93.3.5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 04F9660716
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 16:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNoAqQoI71meammxhfj/gx/c4tb7ezx8HjYle3+uh/lGS+KUgOHxk2xCR+m9lPzeQ4UqiOR0CNZ6slDBS3fO1CGM202k3dYbdbApMSIGBz9zRY/stncl6btwYCpR2M9FI+YBX9p+V53Lflh6Yhia5ir8QsDONyyw8HGewaV2YIcYSrIAzIRVjiOqtfO1Ul17Bp1IysbZxz5EommUMrNUbtySJg28jD7ZJ/Ja1QLSmGfnJCP5tAYJwuD2O0a/fbrMNvYBaw17RNoPYjyM/ak6B1Yonc7FtOhFvsCIrqVRCKcBrRofVLzQ0AAk47ltrFR24kiplPOhsTY42R6Ey5DJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=h8kFc9GqemG3bgd5NrDd4yM/37itRP5ArxE57wxbEBg=;
 b=RIpmuxN6L/mRNY3I47H+xtO3SGaKme1u7YzdHF90Gx6MRF0jLM09QwOS54FQpv3/Cwot/atmlLIYXSqjh7L2cWt/wFJ6Zsas9JyVk2vxiWT8PcOL6/mGBq2abT3tY0oh6phldoRgDtfYLrP4e7tBLYJ6dK0g5BdT/g740+I8tpb71g6hPp7p+Sx6u+ci8pvRiwMEAJ7rT7ZsbzEcMeT8cQdRCQ8nbXULJL7+6RvpifaZIZkYOFTNi2KE/q0oNRXC++y4RWbvQbzyznu4dFkSt4S9xONtE2tP2SH4vDWMPELiBS8KlSacXyUnwf4Gp0kMt6L/u0HdnvCicxBO9QxWWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8kFc9GqemG3bgd5NrDd4yM/37itRP5ArxE57wxbEBg=;
 b=bxo3sTyL6l/ajEMjZ4L7vv/WZ91eFA0PYD0Qm08JtECVJgnf10eigJ2XiYudU8qhGB/WxQbZ1VqS/az+2znapb61sHQFHw4p0tPsJ2W7y5zXIalp1ombnzzPBaSO8gem6IdwAUO09cIrWmse5A1T5/fqbZiLTw+QCIfkpezMqhg=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0287.namprd21.prod.outlook.com (2603:10b6:300:7a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.7; Thu, 2 Sep
 2021 16:14:04 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c8b:6387:cd5:7d86]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c8b:6387:cd5:7d86%8]) with mapi id 15.20.4478.014; Thu, 2 Sep 2021
 16:14:04 +0000
To: Tianyu Lan <ltykernel@gmail.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
 <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
 <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "jgross@suse.com"
 <jgross@suse.com>, "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, "hch@lst.de"
 <hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "brijesh.singh@amd.com"
 <brijesh.singh@amd.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
 Tianyu Lan <Tianyu.Lan@microsoft.com>, "pgonda@google.com"
 <pgonda@google.com>, "martin.b.radev@gmail.com" <martin.b.radev@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>, "hannes@cmpxchg.org"
 <hannes@cmpxchg.org>, "aneesh.kumar@linux.ibm.com"
 <aneesh.kumar@linux.ibm.com>, "krish.sadhukhan@oracle.com"
 <krish.sadhukhan@oracle.com>, "saravanand@fb.com" <saravanand@fb.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>, "rientjes@google.com"
 <rientjes@google.com>, "ardb@kernel.org" <ardb@kernel.org>
Subject: RE: [PATCH V4 08/13] hyperv/vmbus: Initialize VMbus ring buffer for
 Isolation VM
Thread-Topic: [PATCH V4 08/13] hyperv/vmbus: Initialize VMbus ring buffer for
 Isolation VM
Thread-Index: AQHXm2gFIWSYU02+UUyReBHQOl5/ZauK4YnAgAXmhwCAACrvQA==
Date: Thu, 2 Sep 2021 16:14:04 +0000
Message-ID: <MWHPR21MB1593917C95C95128A4E835D5D7CE9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210827172114.414281-1-ltykernel@gmail.com>
 <20210827172114.414281-9-ltykernel@gmail.com>
 <MWHPR21MB1593B416ED91CD454FC036E5D7CE9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <e864b95d-ecb7-074b-ff0b-85cc451bad52@gmail.com>
In-Reply-To: <e864b95d-ecb7-074b-ff0b-85cc451bad52@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ef79cd5e-7331-4c0e-adbb-97b052469058;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-09-02T16:09:28Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a10f30f-c31a-4b0c-12e9-08d96e2caf25
x-ms-traffictypediagnostic: MWHPR21MB0287:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0287AA3A53ED847207E23899D7CE9@MWHPR21MB0287.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGOnTAxLePV4piCloHPg0HNrCCKjFqOJ03ruJTD+GCTP4UF1PaIK8gwhHPNNJd14psyj+2zOuqCghmd5/QHhATYperkokL2M12IxevdCyHmBPDh+Qgm6ulnw8OMa5ixVRiPXubatO98NxHkDlLHXQUYyQDkDpwkGuNzcMm0ceaN/LcPSGXJfiqeX56JxG/D/uUS39/B5AuEwZcK6As1J8g4sor69545UO6Zw+KPQgxxsQmYjmqMEJsdmrJCjFXrsx8JqF7WaVkuG80PlsWUK79QEgR3bcQ0nyfBortk07bKMHcZ35skTY6qzrPGorYewMWQgW7ai29WoD38r29USg8yQ3U2bhhWvFl37eFF9YTwinIwhxogysj2bI79io89Y7VyxlN7DU/n8mQJ60i8cjI/FYto8urP0xwEWSp12oOSmIna5dv1Gr7In4RIe6Aw1q0CXcDf9t9h7QQN5ITJWn3nLGev7fAQPS19uuHLBSlg/oUnWlfDmYUGgyet6+vRl1jbMMuoA0ZXO3Ll/QtTH1oVj29pRnpB2uZs9gQXV/nOD5I59sKFWbhIUffkaNQL7wGNZlKoQGOZVi7jO3Qhz4L/dqJKsEHjgAs+24BrkcJmvkQJbqI0aOXolLK/UdCD9mI4IJdtorvhNLuBa5KVLBkiBBNxKYAJcWS5CkREIS4XdcWAKUpOo9I951VnvK0yLIoLqeI6VUItSznjK6B2tuQG/8/7nHfE+YPP3bp8m8U0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(10290500003)(186003)(86362001)(76116006)(8936002)(7416002)(7366002)(122000001)(38100700002)(71200400001)(82960400001)(2906002)(82950400001)(38070700005)(8676002)(55016002)(26005)(7406005)(53546011)(4326008)(921005)(64756008)(66446008)(66556008)(66476007)(66946007)(6506007)(316002)(52536014)(33656002)(8990500004)(110136005)(7696005)(9686003)(5660300002)(54906003)(508600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SCt0SWxWdDhBK1BQSUR2TUFWS1dNcWpkb2htRDJLT3VSTmp1aEdWaDRFZzFP?=
 =?utf-8?B?aUtuSW1QTEJSR3AzOTV4bFhWZ0RBOGkveUxzMWk3Q0pKRk52cmpwWW0wTTEz?=
 =?utf-8?B?MlNMYVFPYVk3bEJ1N1puSXJGSjJvWVZXS1dWL2U0T0RwYWJidmJMMDlEd2xj?=
 =?utf-8?B?TnJLREpxN2VJWE1vWTlJS1lkWDhMTExzd1BqbjFMRFFLSUQweGZpZmFXZllL?=
 =?utf-8?B?OStUY3VLc2h0STZFUWt4MG1Rb2F6MDlXdyttT0pHb28yWElzT3lPMEJobnhG?=
 =?utf-8?B?SjQzWWtVU1FwZkNuSXpvYXkwRWlOMUVFRDBsNG5oQ1FnTi90VXdYSitoQml4?=
 =?utf-8?B?TkNoZmZDbVpJWS81Q3BVTmxLZ0RpY0JqR1pjUjRPa29vT3RyYnZhcHBZSTJj?=
 =?utf-8?B?cVZMM2dOU1dmYnJzVFhFUDJETlBoWWdYYVU4Yml0TDFFS21uU094L21CaktI?=
 =?utf-8?B?dFYrSTkvd0I0dVMxL3JJZE9DRVlCeXNzck1ZRlFjaHBVVHhLaDE2ME5FN2hl?=
 =?utf-8?B?ZEx4eCtEOXNjcEN4RGFBQnNVSHM1cGMyN2VEajgxdW1ucGNPLzNONXdlRG1m?=
 =?utf-8?B?MUN1MnE1S2xISmx1bFl0YldCREFEM2UxSFhrM0R1M1IzR3VRSVRaN1czUzlR?=
 =?utf-8?B?TldwejRPcXNyQWdxNmVWeEdNcHJGcEt4dWRmQWljRFc2WXAxMkJFM2NOU2Mw?=
 =?utf-8?B?b2ZhdDJHU3gzZ1dLMll4b3JlYlg0NlRMYlV6UW5odVROL2hVdlZIVFdkdnVn?=
 =?utf-8?B?QUtIODVrTXVhd0hTVFVob0p1N0gycjRvSUJDTjdiWDZVZURUcGFlNkdFYzkz?=
 =?utf-8?B?R1JEVjRPWDVQa1Z4eVUzNCs2OFlJdWd6UXVyWWR5b2I1T0poWFo4cEZwMXJQ?=
 =?utf-8?B?YkdRby9pQTczUmdCd1NBcE95Um96SytST1NQWUtQaENwRkRReG1paTF5M3NG?=
 =?utf-8?B?VFhFSFlvSVAwMUVsUUNPNUF0NStDcGdNWVNvdjVHcWJaV25vdC9WdU4ySkUx?=
 =?utf-8?B?SFFnMXJZZDFlc01sTGk5YUJ3UWRqbHIvOUYxMXN0MW8xai9SaW5oblVWTXly?=
 =?utf-8?B?ZGg4cnVYKytXR1BUSVVGdndPL2ZyY1ZUdXFibWdHMkt0QUFBenAxYVZzdnRP?=
 =?utf-8?B?SmxwOWh5K1p5blQvZlFYZnN5TStHb0dnV3hNVFB3b1JGOEQvbFFzOXpOUlpa?=
 =?utf-8?B?S1IrTU1ROVZ6U0ExSXhhMTNCM0xyN00zRkN6d0pHUi9LOEl6YlI3VjNKVjdK?=
 =?utf-8?B?SDE5bnRGa01DQS92dGxET0p0YVJMNCtMYm9OOTVFa3dWZEpFeGtkbHVPQmhw?=
 =?utf-8?B?cnNVUVNYdFdXWW9SNzQ0ajFQWUpXc2Y5YmdNVUVpWW9QREozVlRyL3YyUHFW?=
 =?utf-8?B?cU1kVHFFRFJ3QWdZQm1WTFlGeU8rcWM4di9DTUc2dW5qMmJYZFZ6L2h4aVVM?=
 =?utf-8?B?RUx1VmVuY2VqODB4QjBoTEh3N0ZHUENkWjdHVktmcGVXV3F6TkhmRDNra1ht?=
 =?utf-8?B?UUtLQ0x5dGFJYVE5ejRaMnlKbVdKUzN4MGh1N3hIV3NVNDRLbEYvT2s1SXE5?=
 =?utf-8?B?bFVTOG1jQklFZkIrRlNFVkhQeldLeSszMXpUc2xwdk9KMThiYk8xL3ZxTmVR?=
 =?utf-8?B?bTBkelJ6aDVubW1GcmY2R0ZOSUIrcmJaM21pMFQzcmI1WHQwdUEySzBpUmZR?=
 =?utf-8?B?ZGJlTFFSdDBaMXlFMlhyZHFQSnhyV1dKUGZpdVBtQUt0Q1IxS1JlaXpQWkJH?=
 =?utf-8?Q?/KsbFS+FFu/eogW6zR47LkfqSJoFw1GvK9smoaR?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a10f30f-c31a-4b0c-12e9-08d96e2caf25
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 16:14:04.3146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yw5Wps3Lv7L2sgCGbAiKeaqoXpEbacvM3u28PlfRsJjUhekwDNXnedm/jETY+2tdzXKwgkE0gULqGhseUsLO+Qp5f6JA9+HASQ+PuOVd7Os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0287
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

From: Tianyu Lan <ltykernel@gmail.com> Sent: Thursday, September 2, 2021 6:36 AM
> 
> On 9/2/2021 8:23 AM, Michael Kelley wrote:
> >> +	} else {
> >> +		pages_wraparound = kcalloc(page_cnt * 2 - 1,
> >> +					   sizeof(struct page *),
> >> +					   GFP_KERNEL);
> >> +
> >> +		pages_wraparound[0] = pages;
> >> +		for (i = 0; i < 2 * (page_cnt - 1); i++)
> >> +			pages_wraparound[i + 1] =
> >> +				&pages[i % (page_cnt - 1) + 1];
> >> +
> >> +		ring_info->ring_buffer = (struct hv_ring_buffer *)
> >> +			vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
> >> +				PAGE_KERNEL);
> >> +
> >> +		kfree(pages_wraparound);
> >> +		if (!ring_info->ring_buffer)
> >> +			return -ENOMEM;
> >> +	}
> > With this patch, the code is a big "if" statement with two halves -- one
> > when SNP isolation is in effect, and the other when not.  The SNP isolation
> > case does the work using PFNs with the shared_gpa_boundary added,
> > while the other case does the same work but using struct page.  Perhaps
> > I'm missing something, but can both halves be combined and always
> > do the work using PFNs?  The only difference is whether to add the
> > shared_gpa_boundary, and whether to zero the memory when done.
> > So get the starting PFN, then have an "if" statement for whether to
> > add the shared_gpa_boundary.  Then everything else is the same.
> > At the end, use an "if" statement to decide whether to zero the
> > memory.  It would really be better to have the logic in this algorithm
> > coded only once.
> >
> 
> Hi Michael:
> 	I have tried this before. But vmap_pfn() only works for those pfns out
> of normal memory. Please see vmap_pfn_apply() for detail and
> return error when the PFN is valid.
> 

Indeed.  This ties into the discussion with Christoph about coming up
with generalized helper functions to assist in handling the
shared_gpa_boundary.   Having a single implementation here in
hv_ringbuffer_init() would be a good goal as well.

Michael

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
