Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24069C433F5
	for <iommu@archiver.kernel.org>; Wed, 30 Mar 2022 14:01:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A67C9611FA;
	Wed, 30 Mar 2022 14:01:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lY5RN5AajWmM; Wed, 30 Mar 2022 14:01:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4D2086109B;
	Wed, 30 Mar 2022 14:01:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 318DCC001D;
	Wed, 30 Mar 2022 14:01:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8528CC0012
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 14:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 71E3441C7A
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 14:01:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T0cumg6QbVwg for <iommu@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 14:01:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::61d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 901DD41C77
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 14:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjugiOUNZNCPRe3Pgjgp9T71DZKoP2l6ekaYjmt38RRehgUpsNQ+h+gpJAwUO9YCJK15wGuOOp6/TkVFE7+g2pTpqM52Sc8sbrhJfzxLTGqjc8LRcyC1MDn5de/5/my7Dy6zQW1Ox3+PZcJGTyLcIwk2rfEpuVB2euJG+k/qVURXxakJKrTyR8e7cut3lDhFRAO2NPByuWN8v6l1HEH4ibR0AjLazi//IGWn/sBFnW2gqrB57CUyl8TVO4YLZvOag1995fonoTghVKR6/+9AsKwA+mKKnkwPuRT6IpBf9rO07fAXHVAwByclud/ZJT54pOYYZDrpv5CWGnndC420QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pb/jmlrY7sr6Tb9ZcbJvD6hALEgabCQCan9f4Lk6HE=;
 b=lCB+RWjZFZ4r78mD7Z9uXsncIj4hppwBX6Rd6s9S2xs6gdcikEPuHydsNe3Ci1dOz0E52QDLdMZNfLXXnJ7TV0Czb3hMh5iMgYiqQNzHFbVf9LWwoxX9a/355wVvYKxtyLvjMGddzJ9JuNkp5eRDK4mxs06GN/LZNAgxIPdIi4b8n7EeEnt1dqV3FJ7FCm/emykl8jE7e/CWDjLejxZLUuARmQJB540afVqikQApiRmkAoh3jv1odzAEEAqZrYMgAr/bP8+0KNO45Q7vQqkfBt9wCOdo8hKnGq8ltWTTKYyO60eckR6Lb0DbZ2zY+JXgxppxlEmWTLIP+blSQTsYjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pb/jmlrY7sr6Tb9ZcbJvD6hALEgabCQCan9f4Lk6HE=;
 b=i0gtK6t5nmvZPkNUGuKu57ihM12j8LpC5CGm43LeMPgSCMf0D3kZkmsD1kpD/3djR/iw/sjKCJZtoSavkDvJMqszQHJSDyH8jrKCrNFs7/DzPzUZhy9RuQ+zWrnGO7x1gBn/XuNk8wBs9ZKtDKarUBBcTDXbQhYMSribREm6ZCg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SN6PR12MB2736.namprd12.prod.outlook.com (2603:10b6:805:75::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 14:01:00 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::4566:560c:e193:d210]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::4566:560c:e193:d210%6]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 14:01:00 +0000
To: Dave Hansen <dave.hansen@intel.com>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de"
 <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "joro@8bytes.org" <joro@8bytes.org>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>, "will@kernel.org"
 <will@kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "Hegde, Vasant" <Vasant.Hegde@amd.com>
Subject: RE: [PATCH V3 1/2] Documentation: x86: Add documentation for AMD IOMMU
Thread-Topic: [PATCH V3 1/2] Documentation: x86: Add documentation for AMD
 IOMMU
Thread-Index: AQHYQslLqpWUeg5qeEmTRh77YLEneKzWfJmAgAF6XmA=
Date: Wed, 30 Mar 2022 14:01:00 +0000
Message-ID: <BL1PR12MB5144C7172FCB8ED2C1AB013AF71F9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220328172829.718235-1-alexander.deucher@amd.com>
 <20220328172829.718235-2-alexander.deucher@amd.com>
 <b3998af9-24bc-6191-a8ed-de747e895799@intel.com>
In-Reply-To: <b3998af9-24bc-6191-a8ed-de747e895799@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-30T13:58:54Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=827e65ef-7505-4c1b-8d76-7aeedc3eb3b4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-30T14:00:58Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: da794e31-0788-4ca0-bc57-cd53cce220fd
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abe5420f-8898-4e92-1dbd-08da1255b882
x-ms-traffictypediagnostic: SN6PR12MB2736:EE_
x-microsoft-antispam-prvs: <SN6PR12MB2736F3974ECCBD319C2E7EE9F71F9@SN6PR12MB2736.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9MB+EzelkOMwT9p0wFkWNd24cMPkcbaqOMwUQBeMG+xlLFLXvOdRknSuhurz+z/F9xogoJ2mg31O5vlWqlLHo+sj0HEPhdb3JAok9RX1CI2j31cALqBhHMh2jIhycK2kWfd4qjx+8dJ9Bfx715POXur7bvQtWWi+iBZEKl7sCC+BKP9GugQ0kAHXh6d1i/rCF7odIUSNmh3rQo1L9ZQbGw1xsxKztReOA5MV2sgMP/AcEAxuMucJJuhG99PlXjOK2HKGTGjI0v1jXm/xyVIyZSxDOySgBM+lb8HQXHEK+ve4kgu9xq9/lLA9Ub9XWB/NB2R1B1LJkT+DhPuZ7TYJcpPCRve3xkCt89VgfJhcFgupzt5n3EiUCWsOCPXNcaPAdyeIxpizmK7EIHRN/F3ojgdzuvtVil9SsWxOjIWpWs0Q+AHfDMvEtAZmWpRAjujsTd/jNXzl0gh7Y23PqvZBTiAPkgv33QnSu3sdRnJXJ79gSihZE+5JqOlF/fpi/BxXgX2uah96Wz07PD+TG8jr2e/nImPT83VSTYSv4RAWEJnQ0Qv1C2iwGdAiDS1nb506av+tg+qw7E/INBakrfSS9v+EWG6PXIFH6sgyJ6VxTDWSzlL+voDLK8DLRcQJySKiRqVsAL6EEqMg8jrott9ZWIqspxXgMjubWkp6c9vLpdh0MtYQCPd7RB8DPb4KelNPKDpdsJbFDdYT9roC+tYRQN9xz7qoW3yygvm3MzpuubI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(71200400001)(6506007)(7416002)(66946007)(5660300002)(2906002)(76116006)(7696005)(9686003)(53546011)(38070700005)(83380400001)(66446008)(921005)(66476007)(122000001)(66556008)(110136005)(508600001)(8676002)(86362001)(52536014)(64756008)(33656002)(316002)(6636002)(55016003)(186003)(26005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3k1NmlkdDEwRUh3WTRnY3BoUnliMTg5cWlHM2NONGxTemhBLzlWVEZKTnVQ?=
 =?utf-8?B?UHh2endheGtuZmh1VlB3OUgvUDY3bW1RaU1qTXlRSDV3b1k0dDVpaVFvYXBl?=
 =?utf-8?B?VDRxZGpqcTQ2dW1BQWRtM21uMk5hbFIrZTU1SzdCWUthWm5QNDg5L1VweFNY?=
 =?utf-8?B?WWs4QTlPSEdSa1Jwa2ZNNWVrUjJuZnFYdHEzV0d0MGtnSHo1SFM0anF3M2Yy?=
 =?utf-8?B?U1JJZktpeXpyZDcxaWY0Vmswek1CUnBZS1k0dDg4c0Z1YWhQOU9NZzlBaGtG?=
 =?utf-8?B?YXRDdWNVMUJsVlhQb2NvekE0Q21NWnJpOUdkUWU2bTRyTld6WG9HTlJIb3Rm?=
 =?utf-8?B?UlZtNzUxNk9KclN3am1JdE1vUVpjQ2NEN2VjcThlcmtWZ042ZFpXdEcwYkV0?=
 =?utf-8?B?aEpnQ1Qyekd6amE4VGxyUW9Pb3VUOUU4VEo0WlYvUkVncXpXaFdmSDFjdVJK?=
 =?utf-8?B?SzZJdlVmLzFIOGd5dU5XUEdJeUZxcFlRcUdqZXpXY0V5T1gxTVQ1YkhBUXJ6?=
 =?utf-8?B?ZUNzMUZYM0NqazBmdDZVaUtabXl3ZjMwajRIVElSQm9QQWN1Mmt4bzBoandN?=
 =?utf-8?B?QzhVTmdsZmhaUlZIOXJwVmNQamlZMUp5YkN4Q0RGVlo5bmhLQXo2b1g5Y0FT?=
 =?utf-8?B?VnloazVsNXZVdytIbHFpQW9uMWdUTE1SOCs5R3F0OXFCekdrSjFxTkZHd0w4?=
 =?utf-8?B?UWM0SHc3YTI1V3Zqakd4WWV2YzU3NWhOZFJqQTNUUW1EcDZkYVczR3NyQi9W?=
 =?utf-8?B?OFJFZDZhZUQyMTFMc0JVbUpWb2FubUpEakJpTEVIRU5RYkVqdmdUQS9RcWJF?=
 =?utf-8?B?TXBUbWttam9QMTJjcENWZjJabTFiQXhwRTlXc1F4MmhnRHhmK0w5MlRnc0lP?=
 =?utf-8?B?ZlB1aDRQN3VGeXdKN24yNmFGOHJzL01NTy9jZ2xmRnBQUDNXbGdaSVBTTGZS?=
 =?utf-8?B?dVE3bTMvWFA4QkdBZms3cWcrZnF1M204N2FPbysyVWdXUjNVV0ZUYUV1Qnln?=
 =?utf-8?B?VTR6RFRUQ0RYRjJOam9Ga1FuVzIwTW9ZNGZ1Z05jME5sNzlTajJ0c2hHWlZV?=
 =?utf-8?B?bENXRlNVL2RDNkVaV3dZaDZRWHRNRnR3YXcwanc3M3NYeGlIMjR5amV1VGVP?=
 =?utf-8?B?a2VrZTN1SkhuRzJoeVFyVE9oaEdTTU9RY2JOVTg0N0JTNytaSDZxTDQxQVNP?=
 =?utf-8?B?c3NPUUg2cHM2VTRsblh6S2M2dmt1WmU2WTZScnlEUE9DQTJrUCsrdUxsQ1RY?=
 =?utf-8?B?OXNHME1WM0pWdzM5U3o2dFNiNTRTQ3lyTDlqaEw2L1FhU0VpcHJBa0lKOXdx?=
 =?utf-8?B?ZW0vQVU0ZkN1WFBXRzNoV2dYTFV0aDRLbGlQZGhJbWlrcDVrczlLbDhxY0Jp?=
 =?utf-8?B?TUFWQlZPSXRqaHAzTmxhWEtZZkloSks5V3E1aXpMVks4M3ZiQWY0WHZCVk55?=
 =?utf-8?B?VHN4RnV1K0p6NE1XN0h5YjcvQ2J6QTByczA1YzhXSTBkTElkdEdqZ2I2b1cw?=
 =?utf-8?B?UFdlWDQvUzBkK0g2SUpoa0w0cFdtRzJHdDFJdEFGT2JOMVdzbUJSOXBXWE14?=
 =?utf-8?B?VnFIN1hCUEUwZHV1Ykt1ZEZZNDRlYVIvWWZzSDZaMCt3MlBySUtuMkpGNVlN?=
 =?utf-8?B?K1k5ZmlkeWFOcm81bDVJdC9xS0JnVTdEckZ6ZFdxd2J5dEtYajA3TEdBTnVl?=
 =?utf-8?B?eGJ5V1MxL0tUQUMzR0F1T3lVOWlveHZPZ0VvNXprdzhTMFBVOUs5U09SQ0dl?=
 =?utf-8?B?amVnMkM2T21tWW5hY2E2a2JIZHh1bk9sZWFJc1RneG0rVE1uVVhaZ094Qmsw?=
 =?utf-8?B?TGducXN5eiswcFl6SFcrT1lmMmZ4aklPeDdvVlZhZnFXaGZVazY5WHNnVkxx?=
 =?utf-8?B?Y0N6Z1hDZ1FUSW43WkpLTVpySHVlQUxBMU11eTdSckFsSy84Y000YzhVZXBB?=
 =?utf-8?B?clorcVAxVGNMa1dNcW11dTNlWUVmMjg1NEZKZWx4ZWZZR05kTWtkYVUrV3ZH?=
 =?utf-8?B?ZXFCOXNPeU1jVmt2anNtM2MrTVBVemxDdTNZRW01blNjU1ExN0Q1QXcwSnJG?=
 =?utf-8?B?dWNlWWJpVzllRnBvVHljUndMaHArUWxaV0J5c0FjcEM5M2JLYTFUcUR4alpE?=
 =?utf-8?B?T1hYalgwdDFNWXZqZEZrSmNuR0tvd2labk9LektPKy8xeisvbE1MTXZzWXRy?=
 =?utf-8?B?RTFwRlQ3dG5FenYwd0dEN0dxekl3YXFpRExwcThSMFdnbmtOVE9STzd1VERB?=
 =?utf-8?B?azFrNGZIcFNRTVhXbFFVbGk5MzBBcXRBWGFpbW5oS1ZCY2lnOXlMbUlLME5W?=
 =?utf-8?B?eHlnNTJ5K2tqUXJ0Vld6R3FwT2UzUHJWZklOODVSVE1nN0ZVa0JFQT09?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe5420f-8898-4e92-1dbd-08da1255b882
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 14:01:00.2151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qqx3/LPPzN+aLAbZCSz2CL9MoFz3OR7oVvG2u8jXLI/qqLCqmSjO5mAPqBRckNE9+M7OCxTSBxbODtB9mhzmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2736
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
From: "Deucher, Alexander via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

[Public]

> -----Original Message-----
> From: Dave Hansen <dave.hansen@intel.com>
> Sent: Tuesday, March 29, 2022 11:25 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; corbet@lwn.net;
> hpa@zytor.com; x86@kernel.org; dave.hansen@linux.intel.com;
> bp@alien8.de; mingo@redhat.com; tglx@linutronix.de; joro@8bytes.org;
> Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>; will@kernel.org;
> iommu@lists.linux-foundation.org; robin.murphy@arm.com; Hegde, Vasant
> <Vasant.Hegde@amd.com>
> Subject: Re: [PATCH V3 1/2] Documentation: x86: Add documentation for
> AMD IOMMU
> 
> On 3/28/22 10:28, Alex Deucher wrote:
> > +How is IOVA generated?
> > +----------------------
> > +
> > +Well behaved drivers call dma_map_*() calls before sending command to
> > +device that needs to perform DMA. Once DMA is completed and mapping
> > +is no longer required, driver performs dma_unmap_*() calls to unmap the
> region.
> > +
> > +Fault reporting
> > +---------------
> > +
> > +When errors are reported, the IOMMU signals via an interrupt. The
> > +fault reason and device that caused it is printed on the console.
> 
> Just scanning this, it looks *awfully* generic.  Is anything in here AMD-
> specific?  Should this be in an AMD-specific file?

There is some information about the ACPI tables used to enumerate the IOMMUs and a link to the AMD IOMMU programming documentation.  Would you prefer I just create a combined x86 IOMMU document?

Alex
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
