Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CB3C43219
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 13:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E87B060A78;
	Thu, 24 Mar 2022 13:18:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b-76AqVQ5Nlt; Thu, 24 Mar 2022 13:18:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DC0B5600C6;
	Thu, 24 Mar 2022 13:18:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E1CCC0012;
	Thu, 24 Mar 2022 13:18:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0CAAC000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 13:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AF177400EA
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 13:18:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r9R44LLP3xLE for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 13:18:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from na01-obe.outbound.protection.outlook.com
 (mail-cusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 46754400D6
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 13:18:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ic7alcN3Uz8XNhnHXKzZ75kQ4pc+ONV0hx9P5sdj8aFrbNCTFxKkXGVpu+/6Grc3oQGj+t6klS1Bc8esQ9dGkpDMe64SBJSD70gCtv9YHzaNtI0TYPGANDruBP+6H+lYk1RwKxUVadH1uEH7L+T8/ydJfGlAZ5npmCGxEpS6QuwPGZztcntXO+F3HjymVN7UeTIvNMRJp8zbQGFLXgbgnF6vle4tIMr3+TzJH+tLgGhp+dyqU8ihy3upVbVrtEFjg+UEQjrA4rtza32lqIzizVGWLDuYcx8tZNLdIo8sTiRTHieTD9ZtP4h1kCY2amjLWSzDVQsU8Ihrm6UAv5a1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orDYrLdAH/4J7LHIidjiqLP37geyCTsiYDNB2HkreTY=;
 b=kH1ZfM1tjARKKGUvqjENMO41zV3OgO8+k9OF3ZiDEBSgnKTuLwqMhe44y6HPFCylEyq2lZw0CTY24ycvnQZR4wlhibc/uVpz2MazKJH7NWSTeu8gwm8ijkGSWYBMoAzO8kA4/q0hjeHcmtyl57q1PcEBBZSOC9cXIodGwtvhtadBXHqcRYU7nkP/pJjAdoRNvLbZYETz5KPoaSoyOSjFeWSXdBEyAQc7rXLbEzzyDYZ9p21SN4SCk5BJX5YNoZtrTbf/WDoQs0BE00aKt0JviDKtM4hiqkjybxd2F1DVQyJqdYnb2rIB79992OpphS55psLoWG4Nzk/cTljhw/JamQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orDYrLdAH/4J7LHIidjiqLP37geyCTsiYDNB2HkreTY=;
 b=LkUX4s4MaAkE/guJ/KOvC2wPm7Lg0EVHafpi5LdgxskbhMlCLhVg51x1IYoiqTB91sYX8A3dBw9kzvEkyLvc5M40pD/7YKBuNYDK2KAgSQmBkR36a4o7bWRRGuengeqytXBsomr0VY2pT4ze0ZOvZijHrrCZQDUDZJbHUFn896Q=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH0PR21MB1928.namprd21.prod.outlook.com (2603:10b6:510:19::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.9; Thu, 24 Mar
 2022 13:18:42 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::71de:a6ad:facf:dfbe]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::71de:a6ad:facf:dfbe%5]) with mapi id 15.20.5123.010; Thu, 24 Mar 2022
 13:18:42 +0000
To: Robin Murphy <robin.murphy@arm.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "lenb@kernel.org" <lenb@kernel.org>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>, "robh@kernel.org" <robh@kernel.org>,
 "kw@linux.com" <kw@linux.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v2 1/2] Drivers: hv: vmbus: Propagate VMbus coherence to
 each VMbus device
Thread-Topic: [PATCH v2 1/2] Drivers: hv: vmbus: Propagate VMbus coherence to
 each VMbus device
Thread-Index: AQHYPvUBEpY8vwlFOUC9Zg6lOuCAbKzObzoAgAATiNA=
Date: Thu, 24 Mar 2022 13:18:42 +0000
Message-ID: <PH0PR21MB3025C5DFB189B9609F7A601FD7199@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1648067472-13000-1-git-send-email-mikelley@microsoft.com>
 <1648067472-13000-2-git-send-email-mikelley@microsoft.com>
 <f984116a-c748-ada0-c073-6e62f486b4f5@arm.com>
In-Reply-To: <f984116a-c748-ada0-c073-6e62f486b4f5@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=aa50e27e-af03-40a7-b1bd-4c55deb9ef90;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-24T13:09:04Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ecceb21-797f-41f9-b93c-08da0d98d149
x-ms-traffictypediagnostic: PH0PR21MB1928:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PH0PR21MB192880823406D36C43560EC6D7199@PH0PR21MB1928.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eVt9+uudsQLsK79a6Ch8oc3QqjT+67JkVW36G0hIdHzRyWv7IDEChTBYfkDCl5u+RONcgYzsum755gYDZsLJw0qCXi0eGbtcRwg9hY4TzasWU1BZrR1rnC/w7bzxOtQyPaqQc+LYR3pyPLEO0z4q/ceNVaEdhWP7ituqczQHy21a8lMMQfxUZcW2umQbB/o5lqf7ZwWbYPzZ9nYZD0F5Zt7FdlD3fgbLKvYaaATtvqiKzpSwRDmYNnh2lo+n+wRTX884dCvlCx4L/EzjowkvS/lQacMRqYYcZk7lEsQz6KkApliUCCXCcrqBsdywg/6VFjeO85GkZyuCtOm7hzykBRLPMGoDWVxbJJLanQTY33LVG9kuzqES6YC9lT0NJ4MX9T/4qXag1z1wgDN5Igjxyz3g0pi0M9YULQf7jL9zw3QRviIC6/tdwN+VW7Oet28VJ5N4ljqP0cpmN3J0ry8XjQI2BBkfRReRwEqEZEwtANy8wYi9DVMTAGt2uNZ6rOS3gl7/09RlDR3GUo9Ib6a9g3KKcWSr4IJXstnWdEeLAM/eZhb0pylSnyc6MpMu5RnEzV4HXP910pPZTjlLRgiAa01hFBkOpoaKL1Txvw/gUv8KDBp6WINizUUNeZcbYVQHAy7VNzKVrK5VpJqwFDWIHNRnL0F6MLK1SS5ZddH17ezQgmQhl5qeVI8RElsBK4GfmjRapcQmlgqovxTaRlRte0RZdrA7Lt5gci1gYLIStl+AKYFdzDqkwAxnOR/A28KM12w1quHSrlEvK9Y/SqLNGA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR21MB3025.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(64756008)(38070700005)(86362001)(508600001)(921005)(33656002)(122000001)(38100700002)(8676002)(66946007)(66476007)(66446008)(76116006)(82960400001)(82950400001)(66556008)(71200400001)(110136005)(5660300002)(2906002)(52536014)(7416002)(8990500004)(8936002)(6506007)(53546011)(7696005)(316002)(55016003)(186003)(9686003)(26005)(10290500003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RllHV0RsNzZwajlEbU1XcmNJcGQ4eFE1djdjTFJhOGJyNG5SMDlLd1krUXVp?=
 =?utf-8?B?TzNOWWhrNGhYYldjbmVtRURPVnVCd0hTeWpzSDE4R2lKYXZLNzI3RzFzU0ZX?=
 =?utf-8?B?azBoSVJqWnJocHh5UEhrZDZQeW4wcUQ1YUtKdUhjNkU3eS9YWE0xS3YrZDBY?=
 =?utf-8?B?UkVPVGdHZ0hxMlZsVDFNODBCTXNMVVcwM1Z3cVNVZWZDSDNSZHNMM1k1WVZm?=
 =?utf-8?B?SlhWNjd5Zm5tVnUvRlhXbTM2eFg5ZllOc1kzZFV2bjkxVlNML1M0ZmtBS0hC?=
 =?utf-8?B?b29NK1J4SCtCWVJiNHNPK050ZWd2ZS9mWHZEZnVuNEZmTFk4ZzV1WHNkMXMw?=
 =?utf-8?B?aEwzQ1paNmUycCtUd0NVSFVFbFIySlgyT1F2R1pTZGNsVTR1dVE0ZFhtZDBV?=
 =?utf-8?B?YklCajAvdVRneHQ1Zm5YOGh3TGhNdU44UXYwTGN5aDFZcjN1ZEFibkoxS3NZ?=
 =?utf-8?B?M3o2alRoZE0zUHk2SXRvYUFHbURndWlNempJNHFCU2phSXJoZmJ2WTlhakpz?=
 =?utf-8?B?WjgwVWtjZWxaK0wzYWM5clB6ekg4MVRkWU5MSzV2SDFyRlBlZUN2R0dKb3ZM?=
 =?utf-8?B?dmR3UGRJdWlXUDg0NlFJeXZtSkNOVWlBVEZQci9FaGFGS0tKSUtvRjVoZlJm?=
 =?utf-8?B?Nmhpc1g4aFEzeWtuQnZteVpxcmdMZ0p6NysrSHJuLytyRFZkMkdYMkFER0ZE?=
 =?utf-8?B?K0pmaVZ6U2djTXpYSmxGTCtoRU9TREt1YXFhbnBORkhFdW5keHBKUHl6YmFV?=
 =?utf-8?B?QklkdUdndlpHeXdmdEhad3BLN3g1MFhIWEdDRmdDWHVEaTIxdjU2b0NpTTNj?=
 =?utf-8?B?bjB3SzFFQTVaK1Y3bkczVC82MjlXSldXV2ZkTUhIU3ZFQ3ZiQk1SOGI3c0ZY?=
 =?utf-8?B?OVQ4UnplNUJDV1BxYnpxWmNUcTdrdDQ5dFlwVXkvbThZSzd1VEtQRUVGRWd6?=
 =?utf-8?B?cU5qcEVpR1RWQ3VOWmFTQXF3UGJDMVZ2Rm8zaUlNUi9xck5WQmhhbjlETGQy?=
 =?utf-8?B?YTZTRXFWVDBRVGRPL1pUMFY1c0xkMzBpTGt6cmFFdm8zYmpIUG1OK2M1bjF5?=
 =?utf-8?B?OE0zdElpcU5Hbm4xbmk5Zy9tQzZHUU95OUV2L0FQSUc3SDZrMlZlSDFHdnlP?=
 =?utf-8?B?TWNsQkRRL1d5Z3JYaUNad0NKR0E5UFR2K05LZXFKb1dNa1pnNHV4ODFrRjh5?=
 =?utf-8?B?cFhUYkE3UlptV0krMFRnay9xeEZldnY0ZGY1MVM0dENzeHQrQnZYZFNSUHlj?=
 =?utf-8?B?V2tDdFhVVHhMRGhJZDlDOUJ4TnhBVTNDVUE5dXNUSUU2NWdtVXhWSGhHTGVO?=
 =?utf-8?B?eG9JbTFySmdkV0daSktSMWJyWFZSOGNqS0c4dDlsV3BPSUg0c2MyMWFmaysr?=
 =?utf-8?B?TFdLUDNMNFh3M2NwTjg2eFNyMC9MUG1WanJTL3ZkRFNQYjErU3lLeFE0aVlT?=
 =?utf-8?B?cG5neVc4TUNPUmZCVWZxaFRMaExhUGdGUXp6NVJDQXFsNWZXKzZYVjF6eDFV?=
 =?utf-8?B?ZkJ2NG44ZjArUXhPNzBQeElLdUdrWmdqY3N1c3VOY0IxeVpFSXdtcmI5NDJ4?=
 =?utf-8?B?QittbDh5SDUzeGw2WS9MWGc1R3E3Y1JUM1JseGtESEg0V1FLOTZrOVljS1pr?=
 =?utf-8?B?RUtpNk93bk9iMTJxNktBMUpMZmlGME9BbE9obDgreGpnbCtSaUpPaXBQREdT?=
 =?utf-8?B?MnNxV2ZZTnIzUi9KeWNTZzNVNURlMEdiY3IxRjFNeXRpblk4clk1YUR5akJq?=
 =?utf-8?B?Q0oxK05XbWtmYjRvaHBXWisvQ1VxYU5sYlVMV1MxU3BGc2VIRW1LeUl3NnZa?=
 =?utf-8?B?OGpUQVBVUnd2MHg2b083dmRrb25OQzZnMWJRQTZObEFPNmlSRitpeVpnL0Y1?=
 =?utf-8?B?bHdCWFhqMWxsNzZFNjdOakwxd1VXYWNwWmZPOCsvYTFpaTN6eFZia0hvVE9H?=
 =?utf-8?B?T01rNFZGV0ZtNG8yU1JjempyeFdxQmszSDlWMWlZOVNFRDV4U0xzNmRDSTY1?=
 =?utf-8?B?dnVYd2ZGZXNZV3hTbnEveUhhTUtlcU1ld0VBckR1VllDN3hMdlhuSklmVGdN?=
 =?utf-8?B?MVhnTXZDdEVwRW1FbnNhdlM1SVVTaE53RTBSQ1NLemtOMGlJenZncDVMQUNX?=
 =?utf-8?B?WkhBbnFpNG9vOFFKNGlpeWRHeVJqM3czRExEYU4wSmNGWFEzdW1UMHk0R1NG?=
 =?utf-8?B?RVZBc24yWjhYN2tyeG12SENKb0VLcjJ3RFc3MllHSXFNellDcG52U2lpQUdj?=
 =?utf-8?B?NldUb296TTNFRjJqamdrTnM0VjZ3TXZDdjRDdHBjNFNYVXVGNzJBZVlIWkFR?=
 =?utf-8?B?dHFXTGlucCs1VzFHRzlQajFXc0ZOaW9BTmdzaTEwc1crcEY0YzIxUFd6YVZB?=
 =?utf-8?Q?Gl3o977MPhkCcdBU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecceb21-797f-41f9-b93c-08da0d98d149
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 13:18:42.1256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gY88dpBv+uoAo56rnQyqBwdrK7BuypIFC686Y/HjOfcoafV2XsyMl3BBHIddsF6ytpU0F1+nGB2LG9y383xSreDrHppJZuRnJoQhsHdVjL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1928
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
From: "Michael Kelley \(LINUX\) via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Michael Kelley \(LINUX\)" <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Robin Murphy <robin.murphy@arm.com> Sent: Thursday, March 24, 2022 4:59 AM
> 
> On 2022-03-23 20:31, Michael Kelley wrote:
> > VMbus synthetic devices are not represented in the ACPI DSDT -- only
> > the top level VMbus device is represented. As a result, on ARM64
> > coherence information in the _CCA method is not specified for
> > synthetic devices, so they default to not hardware coherent.
> > Drivers for some of these synthetic devices have been recently
> > updated to use the standard DMA APIs, and they are incurring extra
> > overhead of unneeded software coherence management.
> >
> > Fix this by propagating coherence information from the VMbus node
> > in ACPI to the individual synthetic devices. There's no effect on
> > x86/x64 where devices are always hardware coherent.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >   drivers/hv/hv_common.c         | 11 +++++++++++
> >   drivers/hv/vmbus_drv.c         | 23 +++++++++++++++++++++++
> >   include/asm-generic/mshyperv.h |  1 +
> >   3 files changed, 35 insertions(+)
> >
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index 181d16b..820e814 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -20,6 +20,7 @@
> >   #include <linux/panic_notifier.h>
> >   #include <linux/ptrace.h>
> >   #include <linux/slab.h>
> > +#include <linux/dma-map-ops.h>
> >   #include <asm/hyperv-tlfs.h>
> >   #include <asm/mshyperv.h>
> >
> > @@ -216,6 +217,16 @@ bool hv_query_ext_cap(u64 cap_query)
> >   }
> >   EXPORT_SYMBOL_GPL(hv_query_ext_cap);
> >
> > +void hv_setup_dma_ops(struct device *dev, bool coherent)
> > +{
> > +	/*
> > +	 * Hyper-V does not offer a vIOMMU in the guest
> > +	 * VM, so pass 0/NULL for the IOMMU settings
> > +	 */
> > +	arch_setup_dma_ops(dev, 0, 0, NULL, coherent);
> > +}
> > +EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
> > +
> >   bool hv_is_hibernation_supported(void)
> >   {
> >   	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 12a2b37..2d2c54c 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -905,6 +905,14 @@ static int vmbus_probe(struct device *child_device)
> >   	struct hv_device *dev = device_to_hv_device(child_device);
> >   	const struct hv_vmbus_device_id *dev_id;
> >
> > +	/*
> > +	 * On ARM64, propagate the DMA coherence setting from the top level
> > +	 * VMbus ACPI device to the child VMbus device being added here.
> > +	 * On x86/x64 coherence is assumed and these calls have no effect.
> > +	 */
> > +	hv_setup_dma_ops(child_device,
> > +		device_get_dma_attr(&hv_acpi_dev->dev) == DEV_DMA_COHERENT);
> 
> Would you mind hooking up the hv_bus.dma_configure method to do this?
> Feel free to fold hv_setup_dma_ops entirely into that if you're not
> likely to need to call it from anywhere else.

I'm pretty sure using hv_bus.dma_configure() is doable.  A separate
hv_setup_dma_ops() is still needed because arch_setup_dma_ops() isn't
exported and this VMbus driver can be built as a module.

> 
> > +
> >   	dev_id = hv_vmbus_get_id(drv, dev);
> >   	if (drv->probe) {
> >   		ret = drv->probe(dev, dev_id);
> > @@ -2428,6 +2436,21 @@ static int vmbus_acpi_add(struct acpi_device *device)
> >
> >   	hv_acpi_dev = device;
> >
> > +	/*
> > +	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
> > +	 * method on the top level VMbus device in the DSDT. But devices
> > +	 * are hardware coherent in all current Hyper-V use cases, so fix
> > +	 * up the ACPI device to behave as if _CCA is present and indicates
> > +	 * hardware coherence.
> > +	 */
> > +	ACPI_COMPANION_SET(&device->dev, device);
> > +	if (IS_ENABLED(CONFIG_ACPI_CCA_REQUIRED) &&
> > +	    device_get_dma_attr(&device->dev) == DEV_DMA_NOT_SUPPORTED) {
> > +		pr_info("No ACPI _CCA found; assuming coherent device I/O\n");
> > +		device->flags.cca_seen = true;
> > +		device->flags.coherent_dma = true;
> > +	}
> 
> I'm not the biggest fan of this, especially since I'm not convinced that
> there are any out-of-support deployments of ARM64 Hyper-V that can't be
> updated. However I suppose it's not "real" firmware, and one Hyper-V
> component is at liberty to hack another Hyper-V component's data if it
> really wants to...

Agreed, it's a hack.  But Hyper-V instances are out there as part of
Windows 10/11 on ARM64 PCs, and they run ARM64 VMs for the
Windows Subsystem for Linux.  Microsoft gets pilloried for breaking
stuff, and this removes the potential for that happening if someone
runs a new Linux kernel version in that VM.

Michael

> 
> If you can hook up .dma_configure, or clarify if it wouldn't work,
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> 
> Cheers,
> Robin.
> 
> > +
> >   	result = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> >   					vmbus_walk_resources, NULL);
> >
> > diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> > index c08758b..c05d2ce 100644
> > --- a/include/asm-generic/mshyperv.h
> > +++ b/include/asm-generic/mshyperv.h
> > @@ -269,6 +269,7 @@ static inline int cpumask_to_vpset_noself(struct hv_vpset
> *vpset,
> >   u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
> >   void hyperv_cleanup(void);
> >   bool hv_query_ext_cap(u64 cap_query);
> > +void hv_setup_dma_ops(struct device *dev, bool coherent);
> >   void *hv_map_memory(void *addr, unsigned long size);
> >   void hv_unmap_memory(void *addr);
> >   #else /* CONFIG_HYPERV */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
