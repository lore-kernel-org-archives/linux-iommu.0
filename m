Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4788CC388F7
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 15:08:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58E2221F9
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 15:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="nR1mmu21";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="nR1mmu21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58E2221F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 926BC868C2;
	Mon,  9 Nov 2020 15:08:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H5+5Zo0j-GTP; Mon,  9 Nov 2020 15:08:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 79F9186797;
	Mon,  9 Nov 2020 15:08:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F9FEC088B;
	Mon,  9 Nov 2020 15:08:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 627E0C016F
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 12:29:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4916986569
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 12:29:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x9n6qngcPRTx for <iommu@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 12:29:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CE1B686566
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 12:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do9+WToy3/OjLrpQIW91vncork5iHQw0s+O1pxkRKWM=;
 b=nR1mmu21IUzw/EOzQefip4jSZzx0dMF90aQ4DAvV0uDJjvehmIZ76PUHmhkJdyjelk4uDaQglWyrhA1amUrXf3mYJ0dC57jMQD+n+fx1ZM3+XfMr3tEZg7XamSZF13OhrDSW9464c3/rSeh+CH6fBvqu8c/nLKplo7W9R1bG3Cc=
Received: from MR2P264CA0029.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::17) by
 AM6PR08MB4770.eurprd08.prod.outlook.com (2603:10a6:20b:c7::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Mon, 9 Nov 2020 12:29:48 +0000
Received: from VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:0:cafe::ef) by MR2P264CA0029.outlook.office365.com
 (2603:10a6:500::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Mon, 9 Nov 2020 12:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.linux-foundation.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.linux-foundation.org;
 dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT037.mail.protection.outlook.com (10.152.19.70) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.17 via Frontend Transport; Mon, 9 Nov 2020 12:29:46 +0000
Received: ("Tessian outbound 13ed5f5344c0:v71");
 Mon, 09 Nov 2020 12:29:46 +0000
X-CR-MTA-TID: 64aa7808
Received: from f3133d7c02e4.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 D2654B0B-83A0-4593-9547-D92E224FFDD7.1; 
 Mon, 09 Nov 2020 12:29:41 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f3133d7c02e4.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Mon, 09 Nov 2020 12:29:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5YvSAIwTuice2xduZJYHMJzeDLZud9QYg9Y20Ue4m4UnElq2zTlgUSaLmbwsZeybaD1j556Hsu5s7KGgkAln+hpl9Ln/Us3GNj8wRI46jw70AOfnRKyoKMQz1DPTuXd0nFI14Wjc1j21Q3PmuHQ37WEiq6ylPk8gMFrQq/BzsntNoOC/Nmhs27cjOCJEA6PBoKyapoGlPVZ7ipUg6Ow3YL4FoWlOQoI0894LbplBq0Ps/PN9Y6HAALLxr/TqTP4OcRVf9Ml/nS3fX2Li241aJGFj5pSpr667ZACMDdoRfQeZZk8RzMh5gMdoGeb8QoGq3m+KsmLv4v6Ia2MtNIP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do9+WToy3/OjLrpQIW91vncork5iHQw0s+O1pxkRKWM=;
 b=Qb/+azt/gAdW7VqSZY9qWGHIuhsZlYTcvA5IGRCmIkXPZ/15S8CyQUvajx1Q+e2Ljhxfr5uw9xrWSBK5IRPAqdf8TFNrfTLPIilTlXnKRr5aKS0pYefsRU3dwVA7X3HKJgqYomsk3ho0gdWGQ9/CJZcNHBC+QiUHSq0rrlBuzBZMCSimyX4+lfeZoSJtdDmPyUgNaJVDU3BVaTi6b/czsHZN4iRL2F8zCGi8LjbQZphCkma3lEBZaxwUWCNNnsFFoG7wzsrQ5YfdH8uoElSeCHRbjn/bSvTKod7qgdlg1fScuKH920bfEno6PthUompOjN1dfQ3tb39ybQr85w7Exw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do9+WToy3/OjLrpQIW91vncork5iHQw0s+O1pxkRKWM=;
 b=nR1mmu21IUzw/EOzQefip4jSZzx0dMF90aQ4DAvV0uDJjvehmIZ76PUHmhkJdyjelk4uDaQglWyrhA1amUrXf3mYJ0dC57jMQD+n+fx1ZM3+XfMr3tEZg7XamSZF13OhrDSW9464c3/rSeh+CH6fBvqu8c/nLKplo7W9R1bG3Cc=
Received: from DB7PR08MB3097.eurprd08.prod.outlook.com (2603:10a6:5:1d::27) by
 DBBPR08MB6299.eurprd08.prod.outlook.com (2603:10a6:10:20d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Mon, 9 Nov 2020 12:29:40 +0000
Received: from DB7PR08MB3097.eurprd08.prod.outlook.com
 ([fe80::897b:8573:fd4b:d06b]) by DB7PR08MB3097.eurprd08.prod.outlook.com
 ([fe80::897b:8573:fd4b:d06b%7]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 12:29:40 +0000
From: Sami Mujawar <Sami.Mujawar@arm.com>
To: "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>, Shameer
 Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "devel@acpica.org" <devel@acpica.org>
Subject: RE: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node
 parsing
Thread-Topic: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node
 parsing
Thread-Index: AQHWrVpjD7ff2ZbXik6CnzMoubH0pam/uMvg
Date: Mon, 9 Nov 2020 12:29:39 +0000
Message-ID: <DB7PR08MB3097062CEEDB4635BF3F694784EA0@DB7PR08MB3097.eurprd08.prod.outlook.com>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
 <20201027112646.44680-3-shameerali.kolothum.thodi@huawei.com>
 <d414a22fbae9575e6c04f4a557ae49a2cd8eac57.camel@linux.intel.com>
In-Reply-To: <d414a22fbae9575e6c04f4a557ae49a2cd8eac57.camel@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 3A01DFA93301644C87586B117271E683.0
x-checkrecipientchecked: true
Authentication-Results-Original: linux.intel.com; dkim=none (message not
 signed) header.d=none;linux.intel.com; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [109.146.228.240]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b738dd8-394d-41a9-185e-08d884ab24f9
x-ms-traffictypediagnostic: DBBPR08MB6299:|AM6PR08MB4770:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4770C4084E077C866B6F264284EA0@AM6PR08MB4770.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:517;OLM:517;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 6xYPjOo6CCXTxL2CN9FALeelXR2wEyeIxW1V76k0uoV8tmv7gmRLYnbWLKsme5B+PiVB1pNtgt0DIEReA+l2wLqVofbiAxoggCBq1vAtqK363td6NBxh1UPDqZLSUOC8NdjEeAdiDIBIQiirfPbgGGs/kIyjDqotafD+MDyXyPF3FUeNrETw0j25YRDwQQUC/gpvWGhD/HtURrIwKdWT57szOQyt3RdVq8un+mY3IicYteLuCxsyuJaqfkT3EF84RNrR1lZF2xn6SM3wqokSvx0DIEYTGQptI8qiA1RCKWVckffUYn+Y2o+1iz9u8R/94kjzqIKlh2OsayRfl9WxDA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB7PR08MB3097.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(4001150100001)(86362001)(316002)(478600001)(66946007)(2906002)(64756008)(8676002)(66556008)(66446008)(83380400001)(66476007)(76116006)(33656002)(7696005)(6506007)(7416002)(53546011)(54906003)(4326008)(71200400001)(5660300002)(55016002)(8936002)(52536014)(110136005)(26005)(186003)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: c/8yl3XQzyAn8g0eP5GujEo9aJDVb/nUwLr5oSUuG0IpA0HaIo75pW4K5I4wNKTRim5QSbxleIHKcoF2F37+TD/n937AtCb86LIeMqwrPNU1BU/vmgvYkuiCdmAtkRsX0NAP0a4mulA+yfbSMijm2XgC8gyx3I0uVu8W/PVVSEWT9DpPAxk8SUBeuJ/Rbj9tuWnwTmvxUtp4RFdErP17kQwRGEWfxRG2ZvYtPmB7ruEx5FGCt+gQqO/OQk8OQtvPPuJLuls9Ym3rJiwVlKL8SNq5eWvirrFFEh9n+pIJ0I9ftYqsLFzn2OikmyTYGxHP5RNMKXHXIGubo88gkbl+sAFGOIVzRT9Eh1GKjG10hCwLj4TLBSC3zhqi2GMF8cS8MTk+vFdbhhzIk8Qx3SEPjlUYFuMUruBskMNxjFOO1VHw2jCKmZVRuA8/6+1fb0PxhxPxwU1PAI53MNxiY1M8rmcwyd2sYQ3TfzqTVqEvCQrbo28PhALeiC6DGc/PNBJNaXVci1FOR48umx6EQAOxO83dpWAQxp/CjYfk92AUK8pyCTX7noYOFsF9ExGe9VNPCxsuuahkTzQmawJdAb26rOVPV+YhLgVUSgqFNyZHDgd6S5BtaO5nw1S0xQ+oyT7Kzz8Rj3esiJUXN8wKZIbbcg==
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6299
Original-Authentication-Results: linux.intel.com;
 dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6cad0bdb-2d4d-4cd9-4141-08d884ab20ff
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uj51NiZO5ts1s+4z3eL093dpny0cbJ5YunKYWkQhfbL7ie2wPSZYeIRjxBet1JMkX2wthdT1fpnz7X6s6dAYN2OnomF7ZuwJU2X49WcBQ7uNeEVpT47ZMexBfWI2FGXLlJblGodPe+iY+gQ8j2EKTWO83w8KSmd9pgrhNR+SgDShsQGEr9i2azTI3aW8KZBiUNyfpvBVQ0kDJVVrrr2hTf0fWV8cGq/aLEFOSb48vOMhBGmpy7d/W/P6Xpr4tbplWnXs8aRjCSHNzDKC9PufI5NFFGkbLSalEZLMdn/C3XrjF7nLB4V1ggR2UrdqtV2bplWZQWI9eF3WohnCjINXMbK0aslGdPrSBeT6YsqiPuHN8PFqvVlv/Tvm+233b/Ad6M5QK7Fkq8P4U+IKMV8Zzw==
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966005)(70586007)(186003)(52536014)(55016002)(9686003)(86362001)(356005)(4326008)(82740400003)(82310400003)(81166007)(83380400001)(7696005)(5660300002)(70206006)(4001150100001)(6506007)(336012)(8676002)(36906005)(54906003)(8936002)(53546011)(2906002)(26005)(478600001)(33656002)(110136005)(316002)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 12:29:46.6164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b738dd8-394d-41a9-185e-08d884ab24f9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4770
X-Mailman-Approved-At: Mon, 09 Nov 2020 15:08:21 +0000
Cc: "linuxarm@huawei.com" <linuxarm@huawei.com>, nd <nd@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>,
 "wanghuiqiang@huawei.com" <wanghuiqiang@huawei.com>
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

Hi,

-----Original Message-----
From: David E. Box <david.e.box@linux.intel.com> 
Sent: 28 October 2020 06:44 PM
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>; linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org; iommu@lists.linux-foundation.org; devel@acpica.org
Cc: linuxarm@huawei.com; Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>; joro@8bytes.org; Robin Murphy <Robin.Murphy@arm.com>; wanghuiqiang@huawei.com; jonathan.cameron@huawei.com
Subject: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node parsing

Hi,

On Tue, 2020-10-27 at 11:26 +0000, Shameer Kolothum wrote:

...

> @@ -1647,6 +1667,100 @@ static void __init iort_enable_acs(struct
> acpi_iort_node *iort_node)
>  #else
>  static inline void iort_enable_acs(struct acpi_iort_node *iort_node)
> { }
>  #endif
> +static int iort_rmr_desc_valid(struct acpi_iort_rmr_desc *desc)
> +{
> +	struct iort_rmr_entry *e;
> +	u64 end, start = desc->base_address, length = desc->length;
> +
> +	if ((!IS_ALIGNED(start, SZ_64K)) || (length % SZ_64K != 0))

You could just do:

if ((!IS_ALIGNED(start, SZ_64K)) || (length % SZ_64K))

[SAMI] In my opinion, the following may be better:
	if (!IS_ALIGNED(start, SZ_64K) || !IS_ALIGNED(length, SZ_64K)) 
[/SAMI]

Regards,

Sami Mujawar

David
_______________________________________________
Devel mailing list -- devel@acpica.org
To unsubscribe send an email to devel-leave@acpica.org
%(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
