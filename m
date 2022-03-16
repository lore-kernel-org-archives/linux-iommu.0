Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEF9C433F5
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 19:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED2DF417E0;
	Wed, 16 Mar 2022 19:25:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qWGQY8zC41lW; Wed, 16 Mar 2022 19:25:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F2585417CA;
	Wed, 16 Mar 2022 19:25:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C132CC0012;
	Wed, 16 Mar 2022 19:25:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B46AEC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 19:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F994841D8
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 19:25:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RXv0ZX43490W for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 19:25:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::622])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F26D8841CC
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 19:25:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjKNl7n/inhDYgujjnebzFrIshXq17MRXQ8KzH8wCILcbvHSf1gLq2dZ6EexlirP5c8jrS3yrykya/+PA4ntbXxYuigt8hk3wiakOpXR4cN6oKBYa7UD+R7bKOvt7bww9kSMu/gwqennejK+w/jGwqVpWXwMOBzcIx15ejDajjNCH5ItWwNs7jxB5jedhro7HwzBkzCLhGOZ/c0o3Lme7jph5GHg+UcVYAgV8lIIccJ3yoAh/W6Q8iGvFRrJfGLI8yURwfKgCtNGAtfBZotXmUOlg3lpcnR2mG6cJPftSHXWO0cVrGok1WP9zajDLksNOp3MrvGNinYzbefjilIicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVO+1mLqbsQXtfL4j3c3V0QqUTw5KjW4VhpH8IfAG7Y=;
 b=Dp/CveDIjzA4cqszpvc237hjZRUZwGcoIMxYDnbJ4OBAN4iTyotYXDAHUnv+V65fQAz5ouuYVzHVgOHuu8Ld4844XcYu6F7Qn4XvZZzxR4o9v77o59e0pua0gay/U3xnMVqrbEsMzAj70b9kBMN0+g6cSusVEH3wDT5SBy7ioEMhWFhhBCf7l+j8AvGSwIF6zbRK9zH9NJNrx9aVQaQqDjdXBUXjX27m1eTXsruqeDT/gEn5zINXeFpdNXsoUAlpFqkYU6geR/CiMFJChMsmATTWdyUMyWw6YC8gNMmHXA+hbyz3xDd5VbeiI6vCucOxZvWRPwIeMl1PyivgfQke0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVO+1mLqbsQXtfL4j3c3V0QqUTw5KjW4VhpH8IfAG7Y=;
 b=qsBSVy4KWRA0ScmFpAmKRGYjtNDk1EXGvtLJGGBdU4UlYsdjBp8xReAG0P1XsVgnwfuheoHdRIxqa24XGDyTH7jVmQpsjGf8SFdjHIa17DrYZ+WztDXmzdKRnPFE/DXJehGQ/PsP5kA2VglEXVwQfnCASwR5kFt0U3l1ZljhHN4=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 19:25:09 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 19:25:09 +0000
To: Robin Murphy <robin.murphy@arm.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH] thunderbolt: Stop using iommu_present()
Thread-Topic: [PATCH] thunderbolt: Stop using iommu_present()
Thread-Index: AQHYOSidJZwMFUwbGEibeELZIyT74azB9QiAgAAiooCAACnRgIAAAPcAgAAEJICAAANtgIAAAECwgAAI+YCAAALbUIAADK2AgAABHGA=
Date: Wed, 16 Mar 2022 19:25:09 +0000
Message-ID: <BL1PR12MB5157244DC83C6A776D0CDB87E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna> <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
 <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjIgQfmcw6fydkXd@lahna> <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
 <BL1PR12MB5157DA58C3BDAFB5736676F6E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5ef1c30a-1740-00cc-ad16-4b1c1b02fca4@arm.com>
 <BL1PR12MB5157380CD6FD9EB83E76CBB0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <0709e994-1c8b-56fe-7743-8fdbf3ba748b@arm.com>
In-Reply-To: <0709e994-1c8b-56fe-7743-8fdbf3ba748b@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-16T19:24:38Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=db2a2392-134f-4c1c-8906-6880a47ac160;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-16T19:25:07Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 56c220f8-3691-4a4a-bd59-cf8d2f8f0cbc
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e8905d2-de59-43bb-f164-08da0782af32
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_
x-microsoft-antispam-prvs: <MW3PR12MB455318D8344D07C399618CA3E2119@MW3PR12MB4553.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GNoVoLYW1nv2FlJyqAXVk0fulx/otVXyZunLIhKuC2yJknkXoK8ABnG9598BTN1MsUf6aKXqxQ3g8xdwg55ACgm2C9HULIiQUARpEGVLaGKg/EawaIfXgSZ97JcR/OPSAiFi9kVvbQzauOXJ77I0ouMN4aJgYnhVd4ikExCd/VOrw1H6qBGZO4x5SzOlzL7WZfgoCDBeNvyqmmPX4yvvLGxxyrxQv4Pg7Vw3PWJ1E3u5MFOMkcjAWRTCyWLzoc3gAjzgih+/djoCOXURi2jVPiuklEN6TOVY5TL0PtOgEY615Usgo6KjZJHGjUGvDNLticrkYCCy10qM4J3vm+K5ckWF3zHh8TL4qHDWqL3XDdSTS07LucMOxPQ74iLKDUrXzZxe0rIr5Pv/Hujp0GlXu0+X6RWuy1eVH3V/B/TU9iG7Z9AbuZ1vBVzbunWLyZ3v9XOA+E5VCSXCiVMR+UMNpwCAuZ/e7HHcr/z1AKvv4RhvhcmY2KTeHgpC5Sxsev5y6tZAcVSr204uCFWUfisC+vZLIbZjfZMptF2POPzW0VJ4dlzuQPa4ACsqRGijn2QRz8feuLXVePIQY0dpHQQzWaC9q2HP+LAqmfqUw+/1aNWR1VpRmTZNQbV3RTsiwgzfyUSfJcXMPYPkKpDrFpoTTJO1DE2qcI34B1AWuZBFNGg5mY42/TMNLm2xHNBDBXssBjtVf6jL8wAzL9JbtSrMCA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(45080400002)(508600001)(38070700005)(55016003)(8936002)(33656002)(83380400001)(5660300002)(2906002)(64756008)(122000001)(66446008)(66476007)(8676002)(66556008)(86362001)(110136005)(186003)(4326008)(66946007)(54906003)(316002)(76116006)(52536014)(9686003)(71200400001)(53546011)(38100700002)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkVQTlhoM294VDBPeUs2a2I0NmNMRFkxR3YzT0EvNER5Mnp6VURkVWZQejBm?=
 =?utf-8?B?dmUxb25NMkFMWnJSUGNUcUdsWDE4Nmg3NGRBM1hiblZrUFFXcnZnSFFuZGFj?=
 =?utf-8?B?S0g3L1IvSVRaYzJWU2pXdmNJSEZ4azZudVl2Sit1L3FhbkZDR0JwUVk4b1Z0?=
 =?utf-8?B?dm01R09hNjFjNE03SnNQUHFTMmY5WHFnNWdBc2lZUFBHNVpnbDd6S0tNVDND?=
 =?utf-8?B?d3QybXRvMWxIdXZhckljaVB5aUdMekdXaWlOVHR0cXppK1ZwZU9Gb1h2L01G?=
 =?utf-8?B?SmpXcE9nSFNsZXhaNWFGQTdiT3FUMnR0MCtZU2JianFWanBDaEJUeVpmeFNE?=
 =?utf-8?B?MjZHV09NS2VnOUl4WWlSTEtLZ1pxT3puZWtYSVNKSHlEMzBFb2VadlBjcjJP?=
 =?utf-8?B?cXZoeTlkeXk0b3NQeFRZVExZbk56dVVKN3VNeDhaazRsR1hwRDZ4ZXhvWkFY?=
 =?utf-8?B?eUM3a1ExcTJmSWppejk4dTZUSVVMVS9MZFNEbENoQ3UyNUVYTmlsMXI0blFr?=
 =?utf-8?B?QU5pdXcrNjVuemszNHJGWUdQcit5ZEh0UmpORmhoVFUydUZmMEpTYUYzMUY1?=
 =?utf-8?B?SVNBelQrQ0VhRnhCdTNkT3dhRE56aUNGQlAxeUlKRjJDWUNHdDY1ZFNzVUgy?=
 =?utf-8?B?WnBIakFxb01vTWVxWEp1cTZUQUJhdDFGWEVnOTQzeElPaGFxSmJHWVYxZ01u?=
 =?utf-8?B?dURnU1FHcXFEcXl6VzNrcE5CQnFsaDlPMldRT1Y1MUlDK1hpMUtwc2ZmbThy?=
 =?utf-8?B?QzBVRTlGVjh3eCs5ZmxOOHdVeUJzVVEyYTNnUWlUc2FrTUMyNFhQZXpqdnAw?=
 =?utf-8?B?U2NtQjVlUWVBdTU2K1NPbkRLdVdUWVQ2elo5YU5oMGQ0Y3lFVVVWMmtIejZr?=
 =?utf-8?B?UGcvWjNOc2laV0E5aEVPekRPVEJ2TkdNQUc1ZVZmdTRPdmlPQ28xTlVrUlNY?=
 =?utf-8?B?QldpQ2hYTW9mKzFWUEpVbS9LUnVVYlNmbngrSGNXM1N5dFZsQ2lQWndtWDFC?=
 =?utf-8?B?M1FOWEdacjhBT1A4cS9SdU12UXl2cVBVYzZjTUloVWNyc0E2R2o4dlRiZGpN?=
 =?utf-8?B?UGV4M1RtdXRSRjVJRHlNd1U4UlIxUjRmLzVoKzBOZitGKzFQL3ZjM0dyTVUy?=
 =?utf-8?B?YzVIOUtDbVVweEx1a0Zycm9VaWs3cTJqN0hzT29hS21vdWp2UWxZMEdseGw5?=
 =?utf-8?B?RUdiTWUxVWpWNld6WmkwUmJMZW9aYzQxb0dSZWY1c253d0x0cDRhQSt5cm1J?=
 =?utf-8?B?eUk2RUpCU1dYR2IzcGpWWXNESmlWdU5ZMDRRYThHd0tCNmV0Sm9aeXBnTnI4?=
 =?utf-8?B?ZjFabnhXTWk4Y0V1dXI1TkxHYURKOHVmQ0JoVURUZjF5YlErUGxlNnpXN2Vi?=
 =?utf-8?B?clluU3dPeWpnQ3c1M1NyYkt5WW5Pb0I2T045S3EzdWs2MElBTnNLeGtqZkRr?=
 =?utf-8?B?WkgwVUZHTnpvTmNSTHM3bzFSeCtRNllCcnJRSDZUbU4zT1hES1NoKzFoQW1L?=
 =?utf-8?B?bGRpamxlcVFCNnk0aUNXMzZMRmlCYVNhUk1pZWVMQnNTT2NyUWhiMXNNMlZ4?=
 =?utf-8?B?RDBWVEFoK3JKMTlmaGM0RnZVYkdIT1BSYTVCSG4wWHZxTTZKQlE4N3BUUGJo?=
 =?utf-8?B?Zi95M3FCWitRNEoxN0dQUFNqSkJsdm5JOVZjRldYTDZjNllJSUlRbVBPcGJE?=
 =?utf-8?B?eXd6bHk0bEFIajhWMTU4a3NaNjZST2F6TnV5ZkxuRjMrZHl5clZUT0xiVTYy?=
 =?utf-8?B?MnYyUFVuZnJiTytYZGNobUIwa2FmRHduRVd6S0FmZEJHaGZzUUhKY0tMK1hn?=
 =?utf-8?B?YU05ZjlIVzRqNnVlOWVoVzdBNHAxa2JOdEZPaUhpUmV2U2pTQXNqYTRLS1RJ?=
 =?utf-8?B?L3VlNm9WUXhXMHhCZEZwNlZXdUJCZlZrZ0NLRDFZVVIrN2plVWpaZ2t0RHZw?=
 =?utf-8?B?aFVXSm54Rk1xZWhhSitjOGZKaU9VWkplSmsvWDNCQUxlSThTcHJhVnVZS051?=
 =?utf-8?B?c1JQTThVSFlxcjY3QlJaRVVkeDZ5TklYMTVpNE51OFYxeGhXdm53VzBvNmtW?=
 =?utf-8?Q?mqJu9w?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8905d2-de59-43bb-f164-08da0782af32
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 19:25:09.1861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kSsSJqdsHtBqnMmzuJrIrfO7Hv1DCFG3C5EOZ0w3H2TaveH8ITTEXxLG92ocRhxO9oiF9RzgALgnfMbvi/AK0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
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
> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Wednesday, March 16, 2022 14:18
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>
> Cc: michael.jamet@intel.com; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; YehezkelShB@gmail.com; iommu@lists.linux-
> foundation.org; andreas.noever@gmail.com; hch@lst.de
> Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
> 
> On 2022-03-16 18:34, Limonciello, Mario wrote:
> > [Public]
> >
> >>> Can the USB4 CM make the device links in the DVSEC case perhaps too?
> I
> >> would
> >>> think we want that anyway to control device suspend ordering.
> >>>
> >>> If I had something discrete to try I'd dust off the DVSEC patch I wrote
> >> before to
> >>> try it, but alas all I have is integrated stuff on my hand.
> >>>
> >>>>>> Mika, you might not have seen it yet, but I sent a follow up diff in
> this
> >>>> thread
> >>>>>> to Robin's patch.  If that looks good Robin can submit a v2 (or I'm
> happy
> >> to
> >>>> do
> >>>>>> so as well as I confirmed it helps my original intent too).
> >>>>>
> >>>>> I saw it now and I'm thinking are we making this unnecessary
> complex? I
> >>>>> mean Microsoft solely depends on the DMAR platform opt-in flag:
> >>>>>
> >>>>>
> >>>>
> >>>
> >>> I think Microsoft doesn't allow you to turn off the IOMMU though or put
> it
> >> in
> >>> passthrough through on the kernel command line.
> >>>
> >>>>> We also do turn on full IOMMU mappings in that case for devices that
> >> are
> >>>>> marked as external facing by the same firmware that provided the
> >> DMAR
> >>>>> bit. If the user decides to disable IOMMU from command line for
> >> instance
> >>>>> then we expect she knows what she is doing.
> >>>>
> >>>> Yeah, if external_facing is set correctly then we can safely expect the
> >>>> the IOMMU layer to do the right thing, so in that case it probably is OK
> >>>> to infer that if an IOMMU is present for the NHI then it'll be managing
> >>>> that whole bus hierarchy. What I'm really thinking about here is
> whether
> >>>> we can defend against a case when external_facing *isn't* set, so we
> >>>> treat the tunnelled ports as normal PCI buses, assume it's OK since
> >>>> we've got an IOMMU and everything else is getting translation domains
> >> by
> >>>> default, but then a Thunderbolt device shows up masquerading the
> >> VID:DID
> >>>> of something that gets a passthrough quirk, and thus tricks its way
> >>>> through the perceived protection.
> >>>>
> >>>> Robin.
> >>>
> >>> Unless it happened after 5.17-rc8 looking at the code I think that's Intel
> >>> specific behavior though at the moment (has_external_pci).  I don't see
> it
> >>> in a generic layer.
> >>
> >> Ah, it's not necessarily the most obvious thing -
> >> pci_dev->external_facing gets propagated through to pci_dev-
> >untrusted
> >> by set_pcie_untrusted(), and it's that that's then checked by
> >> iommu_get_def_domain_type() to enforce a translation domain
> regardless
> >> of default passthrough or quirks. It's then further checked by
> >> iommu-dma's dev_is_untrusted() to enforce bounce-buffering to avoid
> data
> >> leakage in sub-page mappings too.
> >>
> >
> > Ah thanks for explaining it, that was immediately obvious to me.
> >
> >>> In addition to the point Robin said about firmware not setting external
> >> facing
> >>> if the IOMMU was disabled on command line then
> iommu_dma_protection
> >>> would be showing the wrong values meaning userspace may choose to
> >>> authorize the device automatically in a potentially unsafe scenario.
> >>>
> >>> Even if the user "knew what they were doing", I would expect that we
> still
> >>> do our best to protect them from themselves and not advertise
> something
> >>> that will cause automatic authorization.
> >>
> >> Might it be reasonable for the Thunderbolt core to check early on if any
> >> tunnelled ports are not marked as external facing, and if so just tell
> >> the user that iommu_dma_protection is off the table and anything they
> >> authorise is at their own risk?
> >>
> >> Robin.
> >
> > How about in iommu_dma_protection_show to just check that all the
> device
> > links to the NHI are marked as untrusted?
> >
> > Then if there are device links missing we solve that separately (discrete
> USB4
> > DVSEC case we just need to make those device links).
> 
> The feeling I'm getting from all this is that if we've got as far as
> iommu_dma_protection_show() then it's really too late to meaningfully
> mitigate bad firmware. We should be able to detect missing
> untrusted/external-facing properties as early as nhi_probe(), and if we
> could go into "continue at your own risk" mode right then *before*
> anything else happens, it all becomes a lot easier to reason about. If
> there's a strong enough impetus from Microsoft for system vendors to get
> their firmware right, hopefully we can get away with not trying too hard
> to cope with systems that haven't.
> 
> I'm inclined to send v2 of this patch effectively going back to my
> original (even simpler) cleanup, just now with much more reasoning about
> why it isn't doing more :)
> 

Yeah I'm fine with your patch code as it stands right now.
In that case how about a second patch in the series to dev_warn in drivers/thunderbolt/acpi.c
right when the link is made if it's not set as trusted?  That should happen right during
tb_probe as you suggest then.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
