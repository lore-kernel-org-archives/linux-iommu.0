Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418EDC4338F
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 00:48:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C573A60EFF
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 00:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C573A60EFF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 960E0843DD;
	Wed,  4 Aug 2021 00:47:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jR0V2rTym5l1; Wed,  4 Aug 2021 00:47:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 96F3283BE9;
	Wed,  4 Aug 2021 00:47:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65415C0010;
	Wed,  4 Aug 2021 00:47:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6F57C000E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 00:47:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5A5A40649
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 00:47:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OkoRy5I_gi5B for <iommu@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 00:47:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A97804061C
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 00:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d//3HuFgulffLVUk2ol/BC/ndMiWhgIFF5RLRxIRIwVxg8tTkzWRdFv+BKrtuLjbWf66rZFlYx9welcAhAbxojmOieT9JJpK9Se4PestgqQq61u8Z/mSjxvDUbbt3lpPHTKBFKGvWg4dlreVfgSJb8mxuXKAZFutGoCWyzFISYR/nfYfiDAmlPYqZSIZRgobXUxwVtCkSVAdCqKRODJZs8lnNEE1XBdnmUGyeYC74UGm1IUVy/V0jv71aQGrvlEb4qJQXN6TtcaQelOl1lVavf/3a8QA/F0NzuiG9WZrMRpwLilTNKJeygyDwKpQFymM79juDx8kZ6sZNVgmRwj7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEFMSDQIF7WxV1HiGqIUpJk8ELI9J4F9a1iSDKnHl5Q=;
 b=b5kojjw9pcOUTnYNW2WjGaj4zGNpdICyUWHrYS4vEot0ZxYyFbsfZz1y3GrxTJJjBsgVHI4nFkhgOerc8l5TuwBSgH2inuYLRvSxVwPrRt1TbauLKm9b29DEaaeJaAeLcM4MGmpAfsI44+JYInmdy8rUFhKAUcZszwESJFodE6v4oIjVdtT3zzBrw/S6FFpWh5Xw83hRGZ0q69H5Z4Nyv4ScqamjkCslfRZqT5waJzloYl1jfHOosrCm5uNtHY/1CCLvkhhyO31EYM4By3EdB294HKwXEe3FtaCNW1JFa5NEdRyvYxJI117EsdquYTVY8j40/1+b0fNFoN632+WVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEFMSDQIF7WxV1HiGqIUpJk8ELI9J4F9a1iSDKnHl5Q=;
 b=cc2uTzDX3K2wKoIgalb1+GbHlmwceSXa6Bh8DHv+tls/lOroDYCUWc9LTJqF+WP7lU5bc2hLi9B9oLEK5gsqHkxmBARj6RVBck9KH5ZJ65LwUO4OhVB0dWADTZsMjtE/17Bhb7bliHsB+w/3hQIhz5IkdRPr1Pk5MdpxKNINVgI=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM4PR12MB5327.namprd12.prod.outlook.com (2603:10b6:5:39e::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Wed, 4 Aug 2021 00:47:50 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72%9]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 00:47:50 +0000
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Chris Wilson
 <chris@chris-wilson.co.uk>, Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH] iommu/iova: kmemleak when disable SRIOV.
Thread-Topic: [PATCH] iommu/iova: kmemleak when disable SRIOV.
Thread-Index: AQHXftHncp563ylbik+a4AZQduZFMKtPFoAAgAcppICAAEt+gIAAVxPQgAAFi4CACmK5oIAAjoqAgAC76gA=
Date: Wed, 4 Aug 2021 00:47:50 +0000
Message-ID: <DM8PR12MB5478CABE64953CDFD0174BA2F8F19@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210722081629.7863-1-PengJu.Zhou@amd.com>
 <4b59b7ee-5258-a2ca-531c-b1b5d9c064e7@arm.com>
 <DM8PR12MB5478D90255FF1379E44AC51AF8E99@DM8PR12MB5478.namprd12.prod.outlook.com>
 <c86a8861-64b5-92dc-b664-b31402f23db3@arm.com>
 <DM8PR12MB5478DD7F296EB264848680EEF8E99@DM8PR12MB5478.namprd12.prod.outlook.com>
 <e6675688-c5a7-448f-84f4-bba0217d99a6@arm.com>
 <DM8PR12MB54785D5E3F31EA4E887B02C3F8F09@DM8PR12MB5478.namprd12.prod.outlook.com>
 <BL1PR12MB51449EAD6C85FEED76015D59F7F09@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51449EAD6C85FEED76015D59F7F09@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-04T00:47:45Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c4451eb3-541a-41c0-a278-51ff7edbe21b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a32b8d4-56b2-4e13-8a3d-08d956e17c39
x-ms-traffictypediagnostic: DM4PR12MB5327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB53270B40875EACB74D15C3EAF8F19@DM4PR12MB5327.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +kdqWH2UCFd6QK5g89AJx0SAqoo0qgFqysdaOGQ2o0NG/1s0TF3BBdWFRFOGGibSlneDztPzp+952wL2S48+AD7CqHxfzI2fM+xkAIT3OCC9WrYr9ewAthZy+B2CbYVRzltP4bJIpIVEiVC2ZIDcEQlhXAX4x0OXsAlCzHYqkWWyq7k0G6Kiio5LE7MZIMBxOp9X6zJLIKXA5TG3VQPN8XU3tS2eutwlnc9qgoMpc/xXKoqsm+S2y/RzRfrPTb8+LsP+V4o13wQb1WQIRNzmFzwZt0o5yd81B5uCKVzh2vLJbbkJPDrf2ZrXTRmJIOSnx+CH8LgNuQ0ewCCNUTE5u+ICtljdhUt2NmW0pQYNYl3y3se1kqyD5tub9YgT3oMun3sS7Ov3g+74UGbEF431tSkpmoaEuNbDOpHBKx91OEaKO/vBRyJcr/vpIFlujy/urMdhcuBIqv57CglezFyVap61jBv1DDxyvFynjGj+LG+EaSrNHc49cpD2btJj9Vi5cT84qsbeXeftyihR3CkXfezDM6KlKTraGHSwyHGkDAkKsFaBhtYq6c4HJBCPPvUlQ2NLgt8G9tAw6Cc1bEfcHlBDqWweEmUqFyKh+djZ4Zwt4MOSvekACJ2dmzWKFXlp2Q+f+FxNpi8dvNTmaxI9sVI9gUjaJbqepjmYJpUihUV9XZaNmjZGGTFiCKpqU3/lVCOcdGFin0tD8WN5MAcSLYDAIqpTs6n/d78wU71QIjlPEdQ1oXxJWo6yeVJzbbZ2xomumGGZ3gcFqjXNtG8FLg/1x+cGPWAzN23l9NkKpQo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(84040400004)(66556008)(4326008)(66476007)(38100700002)(66446008)(6506007)(122000001)(64756008)(66946007)(53546011)(76116006)(38070700005)(30864003)(52536014)(71200400001)(26005)(66574015)(5660300002)(55016002)(9686003)(86362001)(966005)(186003)(7696005)(83380400001)(110136005)(8676002)(8936002)(316002)(33656002)(45080400002)(54906003)(478600001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dZJWd7qDViwNYynwjT3UMXms6t94AVkGjb3gT+z0GP80rwa6zRjIQp3pbb42?=
 =?us-ascii?Q?jH5YNnWbmcHRRRFrrl1tgig81B766iqL2ckmxHYfrhLBVihyXwVkff7Wdo3i?=
 =?us-ascii?Q?H0gScjJgdHF5veJ/5bzZX09svH0H4RYa3eDRYphIHIPMeTYOaFfl2GJEKCj1?=
 =?us-ascii?Q?AeoNvsN0kmM1llKRF8EH4wuW9V9WpwPrjD+OzxIkYbQus53/MNhqSnTx/Tyl?=
 =?us-ascii?Q?HWIqPIGRsZp72o2XUyGVBNleTcNQkcFZG7UpO0nF4qvYJftwmC86CBH90FFQ?=
 =?us-ascii?Q?Ccs+u3kVCnsSVVhqvq0Q9NZJF2lOMj7lwjur+yq899eecj0uNq6KBiwekMWh?=
 =?us-ascii?Q?lnGvvRIFk7u9ILMaTJ/8IlZu14PPeds0dtgJZ7TtiVNpqir7yY7BSHFcweTK?=
 =?us-ascii?Q?4xVPmJY5S873eyLT1TuUDTY9gnLxkaCssfaLS3IxEuI9UdTbpJCVJr8AOMOA?=
 =?us-ascii?Q?m98vQ7ntziZFTc0CazpOyDTZ7ykKNARo3/q78k9waap23j5oEzqc3Q2wIoHT?=
 =?us-ascii?Q?lwcFHZ1oGPBvkmogz1jn4qXkSNtyWKISvmMLEybBQLgNhrZsb5/u7fN2rpJ1?=
 =?us-ascii?Q?Ke1fqeBdE7VZOYaKFFpI3x+HjNl1pk6SndtZ9bHDVIjhZt3UJgN2I8ueQrg2?=
 =?us-ascii?Q?BAP9vs8z2VqGyjzoZp/fiYZHno35nL9SbM7Dm+ppqU0flIGRbOyraENfBuAG?=
 =?us-ascii?Q?NwQTW6aGZOVfFInnFgIdesyEinUYIkI8Xhmmi0LTr6YttMh/VLKiXapsxsII?=
 =?us-ascii?Q?0mJyR7U1JABbzvcy5wHwdQ3QnpLlATz7osCmwsqFYcYnCJZVEzoPaw3e4u+P?=
 =?us-ascii?Q?WaZ6L5Q6tYme3Tka4j4sbkwj7eSskP7WOl8Z0vyv/YvWTcd5jFwsj9DSTUcQ?=
 =?us-ascii?Q?lk28eaWQOIN5MWyAngF4CA8Jz92Kd1If70Y5FjBqjGhi/TNzy3ZNjqMNStTz?=
 =?us-ascii?Q?rWrNLwCsH/rGM4bXYxcT8XdtToltCmXSKnRqQavZMFIY/24KTfuR5kcwWbsi?=
 =?us-ascii?Q?PqyoB6guV7W00kFkM9iPSvxuYb3b7fvqQ76NS1n+XAZ5vLXtcIhxk7Yel8tE?=
 =?us-ascii?Q?oahaM5N3lKygkVxYaVBhm6D78FRbu35lLBpQcsMEno+Fz4Cv1xugJ7ZnZ8IW?=
 =?us-ascii?Q?7QdrWDui/uZ2lw/OP+j77xAGHDDPBdGDLwNtPLJy9s/QEIF+2dNZDRTu0woS?=
 =?us-ascii?Q?/JzAt/p38nB/RRqqLCGHZM3yEgU4rREBcJM3LHg1nYjQbL1rfE4enwuk6j4x?=
 =?us-ascii?Q?06kUUN4mHelNILsPBeL9DA3Bg1kWe+4i1qeJ9StvQD0Mh6Y1H8s15RdkNppr?=
 =?us-ascii?Q?Yy3uuhM+ZaMG5UKDqMU8Vrv+?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a32b8d4-56b2-4e13-8a3d-08d956e17c39
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 00:47:50.0446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /X7djiBrobiYEm5AQK0BLBh/ONZrG5PN7zC1Lta2bGVmbJX3rTDDHSR7+FoAiz6Lw+lWux10F1F9BZ5rTb5sHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5327
Cc: "Wang, Yin" <Yin.Wang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>,
 "will@kernel.org" <will@kernel.org>, "Chang, HaiJun" <HaiJun.Chang@amd.com>
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
From: "Zhou, Peng Ju via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

[Public]

Hi Alex
Is there any doc to descript how the branch sync up?
I only know the drm-next, mainline, project branch, and the relationship between them, 
having no idea about drm-tip or drm-misc.


---------------------------------------------------------------------- 
BW
Pengju Zhou



> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Tuesday, August 3, 2021 9:29 PM
> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>; Chris Wilson <chris@chris-
> wilson.co.uk>; Robin Murphy <robin.murphy@arm.com>; iommu@lists.linux-
> foundation.org
> Cc: Wang, Yin <Yin.Wang@amd.com>; will@kernel.org; Chang, HaiJun
> <HaiJun.Chang@amd.com>; Deng, Emily <Emily.Deng@amd.com>
> Subject: RE: [PATCH] iommu/iova: kmemleak when disable SRIOV.
> 
> [Public]
> 
> > -----Original Message-----
> > From: Zhou, Peng Ju <PengJu.Zhou@amd.com>
> > Sent: Tuesday, August 3, 2021 1:51 AM
> > To: Chris Wilson <chris@chris-wilson.co.uk>; Robin Murphy
> > <robin.murphy@arm.com>; iommu@lists.linux-foundation.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yin
> > <Yin.Wang@amd.com>; will@kernel.org; Chang, HaiJun
> > <HaiJun.Chang@amd.com>; Deng, Emily <Emily.Deng@amd.com>
> > Subject: RE: [PATCH] iommu/iova: kmemleak when disable SRIOV.
> >
> > [AMD Official Use Only]
> >
> > Hi Chris
> > I hit kmemleak with your following patch, Can you help to fix it?
> >
> > According to the info in this thread, it seems the patch doesn't merge
> > into iommu mainline branch, but I can get your patch from my kernel:
> > 5.11.0
> 
> If this patch is not upstream, it probably ended up in our tree via drm-tip or
> drm-misc last time we synced up.  If that is the case and the patch is not
> upstream, you can just revert the patch from our tree.
> 
> Alex
> 
> >
> >
> > commit 48a64dd561a53fb809e3f2210faf5dd442cfc56d
> > Author: Chris Wilson <chris@chris-wilson.co.uk>
> > Date:   Sat Jan 16 11:10:35 2021 +0000
> >
> >     iommu/iova: Use bottom-up allocation for DMA32
> >
> >     Since DMA32 allocations are currently allocated top-down from the 4G
> >     boundary, this causes fragmentation and reduces the maximise allocation
> >     size. On some systems, the dma address space may be extremely
> >     constrained by PCIe windows, requiring a stronger anti-fragmentation
> >     strategy.
> >
> >     Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/2929
> >     Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> >
> >
> > ----------------------------------------------------------------------
> > BW
> > Pengju Zhou
> >
> >
> >
> >
> >
> > > -----Original Message-----
> > > From: Robin Murphy <robin.murphy@arm.com>
> > > Sent: Tuesday, July 27, 2021 10:23 PM
> > > To: Zhou, Peng Ju <PengJu.Zhou@amd.com>; iommu@lists.linux-
> > > foundation.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yin
> > > <Yin.Wang@amd.com>; will@kernel.org
> > > Subject: Re: [PATCH] iommu/iova: kmemleak when disable SRIOV.
> > >
> > > On 2021-07-27 15:05, Zhou, Peng Ju wrote:
> > > > [AMD Official Use Only]
> > > >
> > > > Hi Robin
> > > > The patch which add "head" :
> > > >
> > > > commit 48a64dd561a53fb809e3f2210faf5dd442cfc56d
> > > > Author: Chris Wilson <chris@chris-wilson.co.uk>
> > > > Date:   Sat Jan 16 11:10:35 2021 +0000
> > > >
> > > >      iommu/iova: Use bottom-up allocation for DMA32
> > > >
> > > >      Since DMA32 allocations are currently allocated top-down from the 4G
> > > >      boundary, this causes fragmentation and reduces the maximise
> > allocation
> > > >      size. On some systems, the dma address space may be extremely
> > > >      constrained by PCIe windows, requiring a stronger anti-fragmentation
> > > >      strategy.
> > > >
> > > >      Closes:
> > >
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitl
> > a
> > b.f
> > > reedesktop.org%2Fdrm%2Fintel%2F-
> > >
> > %2Fissues%2F2929&amp;data=04%7C01%7CPengJu.Zhou%40amd.com%7C4
> > 7f
> > >
> >
> c4308f6044a379ed908d9510a19b1%7C3dd8961fe4884e608e11a82d994e183d
> > >
> > %7C0%7C0%7C637629927137121754%7CUnknown%7CTWFpbGZsb3d8eyJWI
> j
> > o
> > >
> > iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C20
> > 00
> > >
> > &amp;sdata=iO5%2FKSW8KV1UZtwGU3oiZpYqiR4eBNcSpF3%2Ft6uSDpY%3D
> > &
> > > amp;reserved=0
> > > >      Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > >
> > > ...which is not in mainline. I've never even seen it posted for review.
> > > In fact two search engines can't seem to find any trace of that SHA
> > > or patch subject on the internet at all.
> > >
> > > By all means tell Chris that his patch, wherever you got it from, is
> > > broken,
> > but
> > > once again there's nothing the upstream maintainers/reviewers can do
> > about
> > > code which isn't upstream.
> > >
> > > Thanks,
> > > Robin.
> > >
> > > > ------------------------------------------------------------------
> > > > ----
> > > > BW
> > > > Pengju Zhou
> > > >
> > > >
> > > >
> > > >> -----Original Message-----
> > > >> From: Robin Murphy <robin.murphy@arm.com>
> > > >> Sent: Tuesday, July 27, 2021 4:52 PM
> > > >> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>; iommu@lists.linux-
> > > >> foundation.org
> > > >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yin
> > > >> <Yin.Wang@amd.com>; will@kernel.org
> > > >> Subject: Re: [PATCH] iommu/iova: kmemleak when disable SRIOV.
> > > >>
> > > >> On 2021-07-27 05:46, Zhou, Peng Ju wrote:
> > > >>> [AMD Official Use Only]
> > > >>>
> > > >>> Hi Robin
> > > >>> 1. it is not a good manner to free a statically allocated
> > > >>> object(in this case, it
> > > >> is iovad->head) dynamically even though the free only occurred
> > > >> when shut down the OS in most cases.
> > > >>> 2. the kmemleak occurred when disable SRIOV(remove a PCIE
> > > >>> device),
> > I
> > > >>> post the log in the following, in the log, the line:" kmemleak:
> > > >>> Found object by alias at 0xffff9221ae647050" means the OS frees
> > > >>> a not existing object(iovad->head) which added to RB_TREE in the
> > > >>> function init_iova_domain
> > > >>
> > > >> Sure, it was apparent enough what the bug was; my point is that
> > > >> the bug does not exist in mainline. This is the current mainline
> > > >> definition of struct
> > > >> iova_domain:
> > > >>
> > > >>
> > > >> /* holds all the iova translations for a domain */ struct iova_domain {
> > > >> 	spinlock_t	iova_rbtree_lock; /* Lock to protect update of rbtree
> > > >> */
> > > >> 	struct rb_root	rbroot;		/* iova domain rbtree root */
> > > >> 	struct rb_node	*cached_node;	/* Save last alloced node */
> > > >> 	struct rb_node	*cached32_node; /* Save last 32-bit alloced node */
> > > >> 	unsigned long	granule;	/* pfn granularity for this domain */
> > > >> 	unsigned long	start_pfn;	/* Lower limit for this domain */
> > > >> 	unsigned long	dma_32bit_pfn;
> > > >> 	unsigned long	max32_alloc_size; /* Size of last failed allocation */
> > > >> 	struct iova_fq __percpu *fq;	/* Flush Queue */
> > > >>
> > > >> 	atomic64_t	fq_flush_start_cnt;	/* Number of TLB flushes
> > > >> that
> > > >> 						   have been started */
> > > >>
> > > >> 	atomic64_t	fq_flush_finish_cnt;	/* Number of TLB flushes
> > > >> that
> > > >> 						   have been finished */
> > > >>
> > > >> 	struct iova	anchor;		/* rbtree lookup anchor */
> > > >> 	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/*
> > > >> IOVA range caches */
> > > >>
> > > >> 	iova_flush_cb	flush_cb;	/* Call-Back function to flush IOMMU
> > > >> 					   TLBs */
> > > >>
> > > >> 	iova_entry_dtor entry_dtor;	/* IOMMU driver specific destructor
> > > >> for
> > > >> 					   iova entry */
> > > >>
> > > >> 	struct timer_list fq_timer;		/* Timer to regularily empty
> > > >> the
> > > >> 						   flush-queues */
> > > >> 	atomic_t fq_timer_on;			/* 1 when timer is active, 0
> > > >> 						   when not */
> > > >> 	struct hlist_node	cpuhp_dead;
> > > >> };
> > > >>
> > > >>
> > > >> Please point to where "head" exists either way ;)
> > > >>
> > > >> The mainline code already has a special case to avoid trying to
> > > >> free the statically-allocated "anchor" node. Whoever modified
> > > >> your kernel has apparently failed to preserve the equivalent behaviour.
> > > >>
> > > >> Robin.
> > > >>
> > > >>> The patch I sent out may don't meet IOMMU requirement because I
> > have
> > > >> no knowledge of the background of IOMMU, but this patch can fix
> > > >> this kmemleak.
> > > >>>
> > > >>> The kmemleak log on my server:
> > > >>> 316613 Jul 19 02:14:20 z-u18 kernel: [  108.967526] pci 0000:83:02.0:
> > > >>> Removing from iommu group 108
> > > >>> 316614 Jul 19 02:14:20 z-u18 kernel: [  108.969032] kmemleak:
> > > >>> Found
> > > >> object by alias at 0xffff9221ae647050
> > > >>> 316615 Jul 19 02:14:20 z-u18 kernel: [  108.969037] CPU: 30 PID:
> > > >>> 2768
> > > >> Comm: modprobe Tainted: G           OE     5.11.0 #       12
> > > >>> 316616 Jul 19 02:14:20 z-u18 kernel: [  108.969042] Hardware name:
> > > >> Supermicro ...
> > > >>> 316617 Jul 19 02:14:20 z-u18 kernel: [  108.969045] Call Trace:
> > > >>> 316618 Jul 19 02:14:20 z-u18 kernel: [  108.969049]
> > > >>> dump_stack+0x6d/0x88
> > > >>> 316619 Jul 19 02:14:20 z-u18 kernel: [  108.969061]
> > > >>> lookup_object+0x5f/0x70
> > > >>> 316620 Jul 19 02:14:20 z-u18 kernel: [  108.969070]
> > > >>> find_and_remove_object+0x29/0x80
> > > >>> 316621 Jul 19 02:14:20 z-u18 kernel: [  108.969077]
> > > >>> delete_object_full+0xc/0x20
> > > >>> 316622 Jul 19 02:14:20 z-u18 kernel: [  108.969083]
> > > >>> kmem_cache_free+0x22b/0x410
> > > >>> 316623 Jul 19 02:14:20 z-u18 kernel: [  108.969097]
> > > >>> free_iova_mem+0x22/0x60
> > > >>> 316624 Jul 19 02:14:20 z-u18 kernel: [  108.969103]
> > > >>> put_iova_domain+0x1b5/0x1e0
> > > >>> 316625 Jul 19 02:14:20 z-u18 kernel: [  108.969108]
> > > >>> iommu_put_dma_cookie+0x44/0xc0
> > > >>> 316626 Jul 19 02:14:20 z-u18 kernel: [  108.969118]
> > > >>> domain_exit+0xba/0xc0
> > > >>> 316627 Jul 19 02:14:20 z-u18 kernel: [  108.969123]
> > > >>> iommu_group_release+0x51/0x90
> > > >>> 316628 Jul 19 02:14:20 z-u18 kernel: [  108.969129]
> > > >>> kobject_put+0xa7/0x210
> > > >>> 316629 Jul 19 02:14:20 z-u18 kernel: [  108.969140]
> > > >>> iommu_release_device+0x41/0x80
> > > >>> 316630 Jul 19 02:14:20 z-u18 kernel: [  108.969147]
> > > >>> iommu_bus_notifier+0xa0/0xc0
> > > >>> 316631 Jul 19 02:14:20 z-u18 kernel: [  108.969153]
> > > >>> blocking_notifier_call_chain+0x63/0x90
> > > >>> 316632 Jul 19 02:14:20 z-u18 kernel: [  108.969162]
> > > >>> device_del+0x29c/0x3f0
> > > >>> 316633 Jul 19 02:14:20 z-u18 kernel: [  108.969167]
> > > >>> pci_remove_bus_device+0x77/0x100
> > > >>> 316634 Jul 19 02:14:20 z-u18 kernel: [  108.969178]
> > > >>> pci_iov_remove_virtfn+0xbc/0x110
> > > >>> 316635 Jul 19 02:14:20 z-u18 kernel: [  108.969187]
> > > >>> sriov_disable+0x2f/0xe0 ......
> > > >>> 316651 Jul 19 02:14:20 z-u18 kernel: [  108.969629] RIP:
> > > >> 0033:0x7f6d8ec45047
> > > >>> 316652 Jul 19 02:14:20 z-u18 kernel: [  108.969634] Code: 73 01
> > > >>> c3
> > > >>> 48 8b
> > > >> 0d 41 8e 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66        2e 0f 1f 84 00 00 00 00
> > > >> 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b
> 0d
> > > >> 11 8e 2c 00 f       7 d8 64 89 01 48
> > > >>> 316653 Jul 19 02:14:20 z-u18 kernel: [  108.969638] RSP:
> > > >> 002b:00007ffc18dafc48 EFLAGS: 00000206 ORIG_RAX: 00000000000000b
> > > >> 0
> > > >>> 316654 Jul 19 02:14:20 z-u18 kernel: [  108.969645] RAX:
> > > >>> ffffffffffffffda RBX: 000055817f00adc0 RCX: 00007f6d8ec45047
> > > >>> 316655 Jul 19 02:14:20 z-u18 kernel: [  108.969648] RDX:
> > > >>> 0000000000000000 RSI: 0000000000000800 RDI: 000055817f00ae28
> > > >>> 316656 Jul 19 02:14:20 z-u18 kernel: [  108.969651] RBP:
> > > >>> 000055817f00adc0 R08: 00007ffc18daebf1 R09: 0000000000000000
> > > >>> 316657 Jul 19 02:14:20 z-u18 kernel: [  108.969654] R10:
> > > >>> 00007f6d8ecc1c40 R11: 0000000000000206 R12: 000055817f00ae28
> > > >>> 316658 Jul 19 02:14:20 z-u18 kernel: [  108.969656] R13:
> > > >>> 0000000000000001 R14: 000055817f00ae28 R15: 00007ffc18db1030
> > > >>> 316659 Jul 19 02:14:20 z-u18 kernel: [  108.969661] kmemleak:
> > > >>> Object
> > > >> 0xffff9221ae647000 (size 2048):
> > > >>> 316660 Jul 19 02:14:20 z-u18 kernel: [  108.969665] kmemleak:   comm
> > > >> "gpu_init_thread", pid 2687, jiffies 4294911321
> > > >>> 316661 Jul 19 02:14:20 z-u18 kernel: [  108.969669] kmemleak:
> > > >> min_count = 1
> > > >>> 316662 Jul 19 02:14:20 z-u18 kernel: [  108.969671] kmemleak:   count
> =
> > 0
> > > >>> 316663 Jul 19 02:14:20 z-u18 kernel: [  108.969672] kmemleak:   flags =
> > > >> 0x1
> > > >>> 316664 Jul 19 02:14:20 z-u18 kernel: [  108.969674] kmemleak:
> > checksum
> > > >> = 0
> > > >>> 316665 Jul 19 02:14:20 z-u18 kernel: [  108.969675] kmemleak:
> > backtrace:
> > > >>> 316666 Jul 19 02:14:20 z-u18 kernel: [  108.969677]
> > > >> cookie_alloc+0x1f/0x60
> > > >>> 316667 Jul 19 02:14:20 z-u18 kernel: [  108.969682]
> > > >> iommu_get_dma_cookie+0x17/0x30
> > > >>> 316668 Jul 19 02:14:20 z-u18 kernel: [  108.969685]
> > > >> intel_iommu_domain_alloc+0xa7/0xe0
> > > >>> 316669 Jul 19 02:14:20 z-u18 kernel: [  108.969689]
> > > >> iommu_group_alloc_default_domain+0x4c/0x160
> > > >>> 316670 Jul 19 02:14:20 z-u18 kernel: [  108.969695]
> > > >> iommu_probe_device+0xff/0x130
> > > >>> 316671 Jul 19 02:14:20 z-u18 kernel: [  108.969702]
> > > >> iommu_bus_notifier+0x7c/0xc0
> > > >>> 316672 Jul 19 02:14:20 z-u18 kernel: [  108.969708]
> > > >> blocking_notifier_call_chain+0x63/0x90
> > > >>> 316673 Jul 19 02:14:20 z-u18 kernel: [  108.969713]
> > > >> device_add+0x3f9/0x860
> > > >>> 316674 Jul 19 02:14:20 z-u18 kernel: [  108.969717]
> > > >> pci_device_add+0x2c3/0x6a0
> > > >>> 316675 Jul 19 02:14:20 z-u18 kernel: [  108.969723]
> > > >> pci_iov_add_virtfn+0x1b1/0x300
> > > >>> 316676 Jul 19 02:14:20 z-u18 kernel: [  108.969729]
> > > >> sriov_enable+0x254/0x410
> > > >>>
> > > >>>
> > > >>> ----------------------------------------------------------------
> > > >>> ----
> > > >>> --
> > > >>> BW
> > > >>> Pengju Zhou
> > > >>>
> > > >>>
> > > >>>
> > > >>>
> > > >>>> -----Original Message-----
> > > >>>> From: Robin Murphy <robin.murphy@arm.com>
> > > >>>> Sent: Thursday, July 22, 2021 10:59 PM
> > > >>>> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>; iommu@lists.linux-
> > > >>>> foundation.org
> > > >>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yin
> > > >>>> <Yin.Wang@amd.com>; will@kernel.org
> > > >>>> Subject: Re: [PATCH] iommu/iova: kmemleak when disable SRIOV.
> > > >>>>
> > > >>>> On 2021-07-22 09:16, Peng Ju Zhou via iommu wrote:
> > > >>>>> the object iova->head allocated statically when enable SRIOV
> > > >>>>> but freed dynamically when disable SRIOV which causing kmemleak.
> > > >>>>> changing the allocation from statically to dynamically.
> > > >>>>
> > > >>>> Thanks for the glimpse into the kind of weird and wonderful
> > > >>>> things people are doing to the IOVA allocator out-of-tree (the "holes"
> > > >>>> list sounds like an idea I also thought about a long time ago),
> > > >>>> but judging by the context this patch is clearly of no use to
> > > >>>> mainline
> > > >>>> ;)
> > > >>>>
> > > >>>> Robin.
> > > >>>>
> > > >>>>> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> > > >>>>> ---
> > > >>>>>     drivers/iommu/iova.c | 15 ++++++++-------
> > > >>>>>     include/linux/iova.h |  4 ++--
> > > >>>>>     2 files changed, 10 insertions(+), 9 deletions(-)
> > > >>>>>
> > > >>>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c index
> > > >>>>> 2371524796d3..505881d8d97f 100644
> > > >>>>> --- a/drivers/iommu/iova.c
> > > >>>>> +++ b/drivers/iommu/iova.c
> > > >>>>> @@ -26,6 +26,8 @@ static void free_iova_rcaches(struct
> > iova_domain
> > > >>>> *iovad);
> > > >>>>>     static void fq_destroy_all_entries(struct iova_domain *iovad);
> > > >>>>>     static void fq_flush_timeout(struct timer_list *t);
> > > >>>>>     static void free_global_cached_iovas(struct iova_domain
> > > >>>>> *iovad);
> > > >>>>> +static inline struct iova *alloc_and_init_iova(unsigned long pfn_lo,
> > > >>>>> +					       unsigned long pfn_hi);
> > > >>>>>
> > > >>>>>     void
> > > >>>>>     init_iova_domain(struct iova_domain *iovad, unsigned long
> > > >>>>> granule, @@ -47,17 +49,16 @@ init_iova_domain(struct
> > iova_domain
> > > >>>>> *iovad, unsigned long granule,
> > > >>>>>
> > > >>>>>     	INIT_LIST_HEAD(&iovad->holes);
> > > >>>>>
> > > >>>>> -	iovad->head.pfn_lo = 0;
> > > >>>>> -	iovad->head.pfn_hi = start_pfn;
> > > >>>>> -	rb_link_node(&iovad->head.node, NULL, &iovad-
> > >rbroot.rb_node);
> > > >>>>> -	rb_insert_color(&iovad->head.node, &iovad->rbroot);
> > > >>>>> -	list_add(&iovad->head.hole, &iovad->holes);
> > > >>>>> +	iovad->head = alloc_and_init_iova(0, start_pfn);
> > > >>>>> +	rb_link_node(&iovad->head->node, NULL, &iovad-
> > >rbroot.rb_node);
> > > >>>>> +	rb_insert_color(&iovad->head->node, &iovad->rbroot);
> > > >>>>> +	list_add(&iovad->head->hole, &iovad->holes);
> > > >>>>>
> > > >>>>>     	iovad->tail.pfn_lo = IOVA_ANCHOR;
> > > >>>>>     	iovad->tail.pfn_hi = IOVA_ANCHOR;
> > > >>>>>     	rb_link_node(&iovad->tail.node,
> > > >>>>> -		     &iovad->head.node,
> > > >>>>> -		     &iovad->head.node.rb_right);
> > > >>>>> +		     &iovad->head->node,
> > > >>>>> +		     &iovad->head->node.rb_right);
> > > >>>>>     	rb_insert_color(&iovad->tail.node, &iovad->rbroot);
> > > >>>>>
> > > >>>>>     	init_iova_rcaches(iovad); diff --git
> > > >>>>> a/include/linux/iova.h b/include/linux/iova.h index
> > > >>>>> 076eb6cfc613..553905ef41fe 100644
> > > >>>>> --- a/include/linux/iova.h
> > > >>>>> +++ b/include/linux/iova.h
> > > >>>>> @@ -81,7 +81,7 @@ struct iova_domain {
> > > >>>>>     						   have been finished
> > > */
> > > >>>>>
> > > >>>>>     	struct list_head holes;
> > > >>>>> -	struct iova	head, tail;		/* rbtree lookup
> > anchors */
> > > >>>>> +	struct iova	*head, tail;		/* rbtree lookup
> > anchors */
> > > >>>>>     	struct iova_rcache
> > rcaches[IOVA_RANGE_CACHE_MAX_SIZE];
> > > 	/*
> > > >>>> IOVA range caches */
> > > >>>>>
> > > >>>>>     	iova_flush_cb	flush_cb;	/* Call-Back function to flush
> > > IOMMU
> > > >>>>> @@ -252,7 +252,7 @@ static inline void
> > > >>>>> free_cpu_cached_iovas(unsigned int cpu,
> > > >>>>>
> > > >>>>>     static inline unsigned long iovad_start_pfn(struct
> > > >>>>> iova_domain
> > *iovad)
> > > >>>>>     {
> > > >>>>> -	return iovad->head.pfn_hi;
> > > >>>>> +	return iovad->head->pfn_hi;
> > > >>>>>     }
> > > >>>>>
> > > >>>>>     #endif
> > > >>>>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
