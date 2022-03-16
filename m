Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A997CC433EF
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 18:09:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A8EB403AC;
	Wed, 16 Mar 2022 18:09:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jBQP6TGOkCrS; Wed, 16 Mar 2022 18:09:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7F26140493;
	Wed, 16 Mar 2022 18:08:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FA28C001A;
	Wed, 16 Mar 2022 18:08:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC411C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 18:08:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B4BA481400
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 18:08:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YkH8abzAatnh for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 18:08:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 282C9813FB
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 18:08:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzzRhMyp889f0uOHTJrYjTCc7nrix2lN6i2SQCx2bQ7vtZuG9fDYDI4zT/FHP9sIzei7tAODrGFyFrqRcm5+t3mxXLzLO2//KNcWvJTj1YDm21FbJw0Km0t6RKBtiicK5kO0kn3TR1GLeIlUQlEt/VhylnwG9ZUft0Ca9UM+0Lylu9P6v1vqOp9QXvUIN8E6CTPY2Js2PRPSi73nrYCOreri/wHtqveVKcKFUTAl853n/zo0yovEBHWz6XxFj43X1xWavAPsF51g1PbT83u9HpeebV/YmvK9fRSpXd39QV+fobjDhAUGOagScFs2SJA+sOXpOaJnvLWIfgFy2Y/+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pfqg7UaZmiGlVxPaf9oFU/gk1/Rgw4D1OqW1oq21hMU=;
 b=djkT2lpyyqLmrSya0CskcKB12EbdgRAlJzZlHRxYWl8QnL7pOPqBumj44KH7qd5b4JthyhnTlul4Pp0AbUDN08vn8x/+QJIevtL34cM9kJfkacCr0jDdM7Xba0eGYa8cG2zLF01EWjtphFvM4bgx+Se6o/Hk7oM11sUb4zrC0YDmW2OUxkcMHL474JxAkaWFqUniOi3H1aT2zi021vWyPdYxvyNlvSaedElo/ueyyuJFbHo2dzAnxREb+Gvaxnqjm7W2eIBEIwmXJ5qrwIvvjqhIM4ekgNb1tuMsstIG4O0Fy7QVnzF2Hmld0SjP3I97wQ82wibArgmlWcNwRtUlWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pfqg7UaZmiGlVxPaf9oFU/gk1/Rgw4D1OqW1oq21hMU=;
 b=yMGeTp+qU7bk6ya3ZTPt+s0AoQEBsDY8SQpg4snrUhJXlsFTNiglo/yKkGYaBxSl0eU9Cl3S9LpXIztsaGCYMAa0hCYeEBSOcAoLoLqlAnzhu9mY5LVp1YLOejKjjugLcccSqwfNvBnEEMxSO53bNH/DXiT9hPIy4SVwnxpaYoA=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN2PR12MB3822.namprd12.prod.outlook.com (2603:10b6:208:166::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Wed, 16 Mar
 2022 18:08:53 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 18:08:52 +0000
To: Robin Murphy <robin.murphy@arm.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH] thunderbolt: Stop using iommu_present()
Thread-Topic: [PATCH] thunderbolt: Stop using iommu_present()
Thread-Index: AQHYOSidJZwMFUwbGEibeELZIyT74azB9QiAgAAiooCAACnRgIAAAPcAgAAEJICAAANtgIAAAECwgAAE99A=
Date: Wed, 16 Mar 2022 18:08:52 +0000
Message-ID: <BL1PR12MB51577CBCE5E86298530B53A3E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna> <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
 <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjIgQfmcw6fydkXd@lahna> <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
 <BL1PR12MB5157DA58C3BDAFB5736676F6E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5157DA58C3BDAFB5736676F6E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-16T17:53:39Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a32c2a09-b0c2-4794-916a-a4afd648a123;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-16T18:08:50Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 43f448ca-6adf-433f-937f-0c3525b2a965
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88752f87-c9e3-432d-6fab-08da07780770
x-ms-traffictypediagnostic: MN2PR12MB3822:EE_
x-microsoft-antispam-prvs: <MN2PR12MB38227D935D0F122545BABFFFE2119@MN2PR12MB3822.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hvf+GH8EpksPseAWOIzGNbXkOV/6G5r6fzDFESZSQaK68Rj8vN40C70ohNNYIEL9Mtf1EQ7tYy8e2TYpBa7Sqagx5Zn6l+rfBw9dPGQbd77qsAUiYmk/0kWeQ/t3b9i5xfvZV6brFakgnhnjbJ27rXWbY3MCp4a71bMeuNLeefNGqJUZgGFm+nOtmuwXLF/bROd8WRxn/YsTUZ2Je4fAQ3H97AlyubxbKY3wXz0flqHwHHJea1Tgx9Rcf0YYPciAuv/KSbajj292t4iUsq/mUPURkGhMVLrJv76JByO1DMAwP0Znngi+QgIwBZPl8l+cqIMvgrO9DQX+u61upyoDcZq4OUIJJawK9I/9bszBhWYSI3CuwixUAvA1ji+z6/2HuXxmZ1u1RXNBcutmkSu1EOB/t3S4/SNbZ0ySiHU0dZPD2dBvXKo32TWkCISv1Ko59oPz22vAMF0Vl6/95+OwSziKiqoFdgws58+c34rb+c/f6zbyyG55aUS376B3TGOQAT8fcMSnfmpCfmW4xmcLAklg0hKOTh6xoaDE0knjD01sgNJDTmbmLjf3DfQ6BDL/d13vjVCOSXVUC0rk8Yp+nsJJogyLYalBYBTfgNscDDjun+VzKWN/KICNQRPcEdnUj15JB9PjW8yYR8BaqcKd87xdRLIIy4i8AW4l9ovsvZ2Gwxuw32ngpE2CDb4k/d7i5QKMHTtz2xVkBHOPJ30EUJ8Ff5t5pXPjcM/uzjHyobaRbOwdk3fwL/hUgT8tID6nDdhpKWBcvz7KbADEIoWvhlDfTAIFylX0f8uV+/Fxyds=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(2940100002)(83380400001)(508600001)(122000001)(45080400002)(38100700002)(9686003)(5660300002)(71200400001)(6506007)(7696005)(33656002)(966005)(52536014)(8936002)(53546011)(316002)(2906002)(55016003)(38070700005)(186003)(54906003)(110136005)(76116006)(86362001)(8676002)(66946007)(66556008)(66476007)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nccvCjyAVUNHH0cBfV1yVacMU+i555k7LWiy6uAG2dxy82aDaL3lJoLJZjzi?=
 =?us-ascii?Q?Sgern0MGDb0LOl5q1f9sV0wWqGiQ49KeeLXtSRXN4EsnAy675EefXkZAtV24?=
 =?us-ascii?Q?7r3TBoNmplLOlV11kvk7JNbHh4S9SqUD7arNXQ+Z4wbKOtg6mVXrno2KhG1e?=
 =?us-ascii?Q?I1VpaTR9Ci5tRE37NbLtPcpioro7Z0Y4hQr0IMbzyCTpr7e5oGoiN71vNUtJ?=
 =?us-ascii?Q?Xw6H/vyrfLWYBtBvkwZf8ew6Xl427A8C9XKLBaiep5Mk+SHz/PAlWApmfVZz?=
 =?us-ascii?Q?2tKTF4Nvn4CJ32y4Qr4KukQcbUonUw0ZlRAtgHNR+LEYXToANroNnK0sEX8D?=
 =?us-ascii?Q?miijnhj6Cywo417LhZLM9iqkb2lJ9eQQCqB4EkduIejMiXpxaylgn0QHqPF7?=
 =?us-ascii?Q?S7RKZRklMtyP1th6VqNgl5YtJH04ni7J9YqNQkfgtkYiphzku2g578bark6G?=
 =?us-ascii?Q?nAMq6DAwBgbQ8lu00iT/mWr5jQD8FKFqdvN8XtaX+GdSQaHxjNgD726ENGyj?=
 =?us-ascii?Q?CzM1V97ndhRHwfaubwy/GHR/0UiHqL6hrWuPQgefvJpitmHdbVXPfcCshLwf?=
 =?us-ascii?Q?b7oVqr+yc0wcErqE5PD5NOv4GK/qx/YmIZ5yIb6AByCMSpoO6tCuMjMV5xrp?=
 =?us-ascii?Q?00NNpofDhFvLjFvAgSbZrYkKfYo5kJVW8VQTS7Z/Cpkxpu0+SJw51nz0D24P?=
 =?us-ascii?Q?hXhgRB5W5fqs9Rg1ae/64BEXyN8vKodRR7zMTXJYZXvuSP+enMxv32wWgKC8?=
 =?us-ascii?Q?/adE1PgTfdREdDnAf8YTOxBmUuPruSwZsh91wv1RyDzNqSol9Ozq1pcrCtK4?=
 =?us-ascii?Q?69xh8lbyZbIhgV+UgxonC2zAsVvD5NgE4p8s6cfDdDjn/ixlFKp1iBkzRO90?=
 =?us-ascii?Q?iEH0efuC539StCvXQD3DrW/nOrLPYRPIXtoo81MkUoLcWAUtGzzJtcrcLAzt?=
 =?us-ascii?Q?TQb+AZha5iNlj8euwjDXCV4amp6OpmyD6c9JDnjjWJvm3DRYm7x0TZkkxPP9?=
 =?us-ascii?Q?tDKGz7pzKsLvMuhPKy051HDsdzf4C+rvxuPIAtSqNAlAfEez3D1YKeEaP/Sj?=
 =?us-ascii?Q?whaU5UVrDN6eY6Ze2YzS5lXN0ek1Il5J7KlmvtoXCXAvtNbo0EkZ0yRFjOkY?=
 =?us-ascii?Q?WYxD3h5a0qSyx3z3jnYydX5LgJzCs7mS1de3PMproFYpXbcE/4Mbcod0BOHn?=
 =?us-ascii?Q?SVKZe7WPhBxtX41u+bxxkvTsRCbP+CHKWVuPQH17aTL/E6kCFnzXvsr0e5Fj?=
 =?us-ascii?Q?pNcDjdX85QJjDL2GXVGMxwAc27ngaPYYbkYe3q65fd4Leyq8h1emOJgoIU6H?=
 =?us-ascii?Q?097+SVjAny6kYBSpu5yUTNnr9BUm7w8rFdR9K3IxLC8291tToC99MF5h6j8h?=
 =?us-ascii?Q?H5ZMxf3hnodepKMvyW7oxhyVndrBRspOKR/8PhzQeo1SchweI1o7A/DKRIa+?=
 =?us-ascii?Q?MgmU4WrJ6dFwBew3Cp989QAoXqqHDdtqaUBFKVMs0khMvhdYOjYlUw5oYhRZ?=
 =?us-ascii?Q?o0BVfzf5+4wkGPf4JsuPaX1hKl1lEinBalc9?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88752f87-c9e3-432d-6fab-08da07780770
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 18:08:52.7532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3PrXeAjiICqAbm93ANNnvjME8wag51NUF86QF6mdtuAu3VvTQegYwzbZJ2CsXifEU1vyT5m9KEIgFHQYnAjYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3822
Cc: "michael.jamet@intel.com" <michael.jamet@intel.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>, "hch@lst.de" <hch@lst.de>
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
From: "Limonciello, Mario via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

[Public]



> -----Original Message-----
> From: Limonciello, Mario
> Sent: Wednesday, March 16, 2022 12:54
> To: Robin Murphy <robin.murphy@arm.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>
> Cc: michael.jamet@intel.com; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; YehezkelShB@gmail.com; iommu@lists.linux-
> foundation.org; andreas.noever@gmail.com; hch@lst.de
> Subject: RE: [PATCH] thunderbolt: Stop using iommu_present()
> 
> [Public]
> 
> > >>>
> > >>> There is a way to figure out the "tunneled" PCIe ports by looking at
> > >>> certain properties and we do that already actually. The BIOS has the
> > >>> following under these ports:
> > >>>
> > >>>
> >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs
> > >>> .microsoft.com%2Fen-us%2Fwindows-
> > hardware%2Fdrivers%2Fpci%2Fdsd-
> > >>> for-pcie-root-ports%23identifying-externally-exposed-pcie-root-
> > >>>
> >
> ports&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C0465d319a
> > >>>
> >
> 6684335d9c208da07710e7c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> > >>>
> >
> C0%7C637830479402895833%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> > >>>
> >
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am
> > >>>
> >
> p;sdata=z6hpYGpj%2B%2BVvz9d6MXiO4N66PUm4zwhOdI%2Br6l3PjhQ%3D
> > >>> &amp;reserved=0
> > >>>
> > >>> and the ports will have dev->external_facing set to 1. Perhaps looking
> > >>> at that field helps here?
> > >>
> > >> External facing isn't a guarantee from the firmware though.  It's
> > something we
> > >> all expect in practice, but I think it's better to look at the ones that are
> > from
> > >> the _DSD usb4-host-interface to be safer.
> > >
> > > Right but then we have the discrete ones with the DVSEC that exposes
> the
> > > tunneled ports :(
> > >
> 
> Can the USB4 CM make the device links in the DVSEC case perhaps too?  I
> would
> think we want that anyway to control device suspend ordering.
> 
> If I had something discrete to try I'd dust off the DVSEC patch I wrote before
> to
> try it, but alas all I have is integrated stuff on my hand.
> 
> > >> Mika, you might not have seen it yet, but I sent a follow up diff in this
> > thread
> > >> to Robin's patch.  If that looks good Robin can submit a v2 (or I'm happy
> to
> > do
> > >> so as well as I confirmed it helps my original intent too).
> > >
> > > I saw it now and I'm thinking are we making this unnecessary complex? I
> > > mean Microsoft solely depends on the DMAR platform opt-in flag:
> > >
> > >
> >
> 
> I think Microsoft doesn't allow you to turn off the IOMMU though or put it in
> passthrough through on the kernel command line.
> 
> > > We also do turn on full IOMMU mappings in that case for devices that are
> > > marked as external facing by the same firmware that provided the DMAR
> > > bit. If the user decides to disable IOMMU from command line for instance
> > > then we expect she knows what she is doing.
> >
> > Yeah, if external_facing is set correctly then we can safely expect the
> > the IOMMU layer to do the right thing, so in that case it probably is OK
> > to infer that if an IOMMU is present for the NHI then it'll be managing
> > that whole bus hierarchy. What I'm really thinking about here is whether
> > we can defend against a case when external_facing *isn't* set, so we
> > treat the tunnelled ports as normal PCI buses, assume it's OK since
> > we've got an IOMMU and everything else is getting translation domains by
> > default, but then a Thunderbolt device shows up masquerading the
> VID:DID
> > of something that gets a passthrough quirk, and thus tricks its way
> > through the perceived protection.
> >
> > Robin.
> 
> Unless it happened after 5.17-rc8 looking at the code I think that's Intel
> specific behavior though at the moment (has_external_pci).  I don't see it
> in a generic layer.

Oh it's via dev_is_untrusted.  A few layers through external facing translates
to untrusted and then dev_use_swiotlb is used, got it.

> 
> In addition to the point Robin said about firmware not setting external facing
> if the IOMMU was disabled on command line then iommu_dma_protection
> would be showing the wrong values meaning userspace may choose to
> authorize the device automatically in a potentially unsafe scenario.
> 
> Even if the user "knew what they were doing", I would expect that we still
> do our best to protect them from themselves and not advertise something
> that will cause automatic authorization.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
