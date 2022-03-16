Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E106AC433EF
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 17:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 89972405EB;
	Wed, 16 Mar 2022 17:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qE0NTQYldUoq; Wed, 16 Mar 2022 17:24:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C254F403AC;
	Wed, 16 Mar 2022 17:24:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A09C1C0012;
	Wed, 16 Mar 2022 17:24:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABD6EC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 17:24:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C13181750
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 17:24:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pAtWK3qnEDjf for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 17:24:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::631])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E2A4813AE
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 17:24:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXPJNqTNgtFrJ0Ey5h9uZFxLPZh0zw3EETMXgHVNlIFzqJCj/ZLWZrFjt6pCAGCLkR30CeeoOUfsJounA1erHtm7dJPaqRffIR77e6ltm/tJ/CKOEOUZsyhhqcWdNiq0etyWAMrrQ7dC/ZGSvFup8D6PZzu2FfEnfJtfLaUaF5oIVjbNTFr/hRM8tQw9qEtrYmNgwR1X7AP2pahQDBF4baK41nmWQxUf7B3md5jmXcgR8AYXwbEDVRP4PWPk8Xi1DPbdylQSwZYPHoxEryvoVT0D97zTWW6Uwq6pjwaM2VQjle8qnJnx/Rxhjk7dMbpv7zzVFoTVLHlsD4uJRbWlSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCEe5Q6FjGGZKdi72bdo5YcEMDbe+zXWeB6aEjvBsw8=;
 b=n0hVvkmr14HJpZ9eB2fC9USo/4x3htxJgHJR/n6Ncz+8CTeOLhjVAbr2cH4poS+FLev4BTD1P4bhOerhZN1UMnXspYPQ4O5pCwf7fxC4ZBjg9NgVRSUO1zS3o2br05/X/nKvFK97niYvrDX6iF0Nq9eZF29LdTFCRSD1POgueccNNox2QDlHN69NHgeAacYwIa3O0gLYd0Y3M/FJNsVKB6OF7irXZuv/lpLRAz4m2Afs/16812EM443YUEky4SxaNGSHvYxhf1GIxgsmCClPY2OAXKCKejNTIYaSvPUb4CSJXT5URVTb2SdSK1kRmverP44k/UZ5stkwU09SE5GKHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCEe5Q6FjGGZKdi72bdo5YcEMDbe+zXWeB6aEjvBsw8=;
 b=1N4GmZR1MqLTk9WlrvtmXjYp4qzHrh8mZ2Y35PNBnX8HR1MPMyNgawT48WhwevWt6ezrW9wmlEmS7JwTX/8+duxyKq3dvM4LarVfnEuD5eBSUJJSEfKnh12RcVHpzsXkUgxQK95/zvyeXeGQni1G5hVWZHAS0GaRjnuc9x6XW3s=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BN8PR12MB3425.namprd12.prod.outlook.com (2603:10b6:408:61::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 17:24:38 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 17:24:38 +0000
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>
Subject: RE: [PATCH] thunderbolt: Stop using iommu_present()
Thread-Topic: [PATCH] thunderbolt: Stop using iommu_present()
Thread-Index: AQHYOSidJZwMFUwbGEibeELZIyT74azB9QiAgAAiooCAACnRgIAAAPcA
Date: Wed, 16 Mar 2022 17:24:38 +0000
Message-ID: <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna> <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
 <YjIb+XOGZbWKpQDa@lahna>
In-Reply-To: <YjIb+XOGZbWKpQDa@lahna>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-16T17:24:29Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a9459524-06b3-42d9-b785-f0bd583d535a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-16T17:24:36Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: c565fffc-7a9d-4612-bf2e-9df837f5e257
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3df5221-e65d-4fff-9007-08da0771d937
x-ms-traffictypediagnostic: BN8PR12MB3425:EE_
x-microsoft-antispam-prvs: <BN8PR12MB3425D2C31D5F2FFCC62DFE91E2119@BN8PR12MB3425.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NI2nrmlOorZaaNYO8wB31jj+/ClSxwFmjY+PlI2fwa2ygA4I1LlWvrWNjtNOsDr7L3VZL9XwfCJbVAPOks+ldRyPWzB0qsu/nTP5gbBOfiV82lcRMdn5mpt/enO5cFwppgJEY5X+qZLZsv29ovh3uoDyUvpZspabMRpeB897RUpVuyqptjMOQHBZiKDcoFeztOvqxOregAch/wUBC6SbBWuovaLN7D64hcZxv9y54DKyr3NI1PjwDZBnp7g5TeIc3/NjsrwPXeaCmXd7FlHNctRWK5P50/GFveKLkOJ9eGLYR4ZD5eRb+xzRfGscgSXmYY5znGFY8Zm5e1S1oiG5uSsr2Qu7KqWBCWZXtCj2UwK5I/gy5s4bYevVprqiYFK5+c/baOYlSJT9xKD4BQqX2VKUF7lCxp/GFiFxageAuWqx1ps15GA1UkcgKY8ACr2m12lKWVIeffqAMfJdIWvB+JQH60uzzhiQL59CYtKze1BQQZMdTypxD5pkHVtbp69WgqlGbIjDHYa6WHymkKMJmpwQpqnv+IRxsJga6Yw1YG5G01X/RKxCSkso18rZhsPnKo3SsGe50KcvUjiqLWI/fDJSTihIPlUKT0QLbhngnCiWDL3kmR93wHUH77OqHoX7MdEboMMt2l32upjaX5FO2TuBhlL0FVrznRQboJvvGgJCFXZn0O7M5k+f4nWd4Mlb8gc6AJuBkqM52tSJrQEFZQ+JlMLlFDLCdgWnPVItAolZKrsLDbmBSsehjTtjRcnmELTye93mYSiHplOz/P52bNFiSjf+fskov1381kK3Ox8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(71200400001)(2906002)(38070700005)(86362001)(5660300002)(9686003)(45080400002)(966005)(33656002)(508600001)(66946007)(4326008)(54906003)(55016003)(66556008)(66476007)(66446008)(64756008)(8676002)(110136005)(83380400001)(52536014)(8936002)(122000001)(186003)(38100700002)(6506007)(7696005)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MECIOMImi6L7iss9zjgMiE2pxxze+PMpBJzqVnXTGa8ieU5fr13DHizXFxhn?=
 =?us-ascii?Q?yC0Q98Wlh/cv1Ryw4lAkX1rhCzSNVsSRUOP4Qe52BGvJvV42HotKgnfcYK0k?=
 =?us-ascii?Q?kbg3FwP20KBuJDmdCFlsHFyJG0L20MUuhRTujnm4/0jjvyeyCx0kfWPmY03O?=
 =?us-ascii?Q?fhDybeMKYBeuxr24t49XBgy0ohqL/XZuzEjr9PM5TxrtI4/Lln/OdIoHNWAy?=
 =?us-ascii?Q?uGpqz0n5jj9nrJ0VkhsQaJnGJ6IJ0IFUbjA8+z+ostzi10egloqH9j9DcQY9?=
 =?us-ascii?Q?0/0Lr7AFl+xhsP3PJmLg3eMqsT5vC3+X4M/eS4NZc/E8SCOIffGW8+6MpRk9?=
 =?us-ascii?Q?5TUrRm0Nvbz1dbyIM84dXcz+YXJXKFfJc9CbXz/By0YIBvI4X1Lj4P/IPjfc?=
 =?us-ascii?Q?ct/IQYpOQTsuEWEDYeRv49ruDwjYkLdf5kYUUWV25QNUHQhPzRnazZUJXBqn?=
 =?us-ascii?Q?B2/Cdc1zb9eBxrxwFAmYWFJen3VuMpvwh7K42YKhZ+90318DqwwWL0J2kqQG?=
 =?us-ascii?Q?sdVLrMenYBscEJ0ywzuPZQM9aPiCLgvCkp8eKyxKpuForHiD3jyWxbm5muIy?=
 =?us-ascii?Q?D+n1BqdMyPPCgrt2tpghBkVixAHzxHVOGpxWSqJXQCOjTJyf21tvYmRekPTZ?=
 =?us-ascii?Q?0p2DBKxipXI/8+azPVn89TOJfoYoO6lTV3SPbtVK5N8l8EoJQgSr7Cue8VUP?=
 =?us-ascii?Q?Xl6cAO8/Q4MBkYKIO23n+5rH3Vo4aZ5rybNo2/xG6Hp9EG1+2m8Va85W+VsN?=
 =?us-ascii?Q?jiXxf3NF85aCL0Ckk8shKWG5wyNqe/ZiVBoKPgVymr2WIHxMKlTPzetDpVMw?=
 =?us-ascii?Q?eIHrrcgl/GFE11SXcR4DUhrQ5PmLwp/Ly5uG5Ju5U+LoH0i94msDbPNAI8aU?=
 =?us-ascii?Q?xv71f4uO5xRcdXcha81EVoy/xQiB55rJgyyjqsKEdZ4qCHevnZ0YikXF9rmF?=
 =?us-ascii?Q?JtpNGa9WA3QVuSrYIxKuWKiCr5NNVtAvlU7UoVGF7RW8SOGg9LMJRwCXW01D?=
 =?us-ascii?Q?Wi3RMRd6j+3cuGTIXj1KqkjEPErdX0ZOBiDvp5+eGqLeM9wFJr2A0TSj2skT?=
 =?us-ascii?Q?CQcO3k71NfSklqDh8jPoh7i8IR4SHmwY5DaH1KVTO+4xY0AwXXIh1duJfDHp?=
 =?us-ascii?Q?jPSY0Fu6sLPg7u6S/2+WAjtkikPVGaMTbmbHoG+15PEK8CbPY/GFThycC/SF?=
 =?us-ascii?Q?/iCRDYX2EmVDs76szREGGRSNsdWgrMmAJp/pGOutiObyWZ4YHjZhAr7ewoBT?=
 =?us-ascii?Q?z2XCaXrR5FdXiR2V5nYnLS2in5tLEwwxUOsOlcCjDPJ/HvIXbcpzsWH+kp41?=
 =?us-ascii?Q?QuIZvAzjEIwD6arRXna1fl6B/obwXTnJdSRe7FBWZj1sYyNSrR6h74j0GLqD?=
 =?us-ascii?Q?I7eP9Zm0Ve2m9UzVCcSQTL5mWq1TrZugPZASSKj2BhuorIhhpD88YPeW50/D?=
 =?us-ascii?Q?sB80PxWERYqpFN+CBEB0wQhFJzpZiwdbnsYGBqhxCqY8hoxa2z0am6B0NoPC?=
 =?us-ascii?Q?KnA7hn883IEoKyePj9MHVEeiayJoacxz7AB1?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3df5221-e65d-4fff-9007-08da0771d937
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 17:24:38.1333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4v1LJCNN7Sq3heEL1pgsczHkNdfKF+3HueBsAznT+kvMvTKIVdSVvqF7dpPfutxyfdvHGwg7jCSTXPhMLWKaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3425
Cc: "michael.jamet@intel.com" <michael.jamet@intel.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
 "hch@lst.de" <hch@lst.de>
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

> On Wed, Mar 16, 2022 at 02:49:09PM +0000, Robin Murphy wrote:
> > > What we want is to make sure the Tunneled PCIe ports get the full
> IOMMU
> > > protection. In case of the discrete above it is also fine if all the
> > > devices behind the PCIe root port get the full IOMMU protection. Note in
> > > the integrated all the devices are "siblings".
> >
> > Ah, OK, I wasn't aware that the NHI isn't even the right thing in the first
> > place :(
> >
> > Is there an easy way to get from the struct tb to a PCI device representing
> > the end of its relevant tunnel, or do we have a circular dependency
> problem
> > where the latter won't appear until we've authorised it (and thus the
> IOMMU
> > layer won't know about it yet either)?
> 
> The PCIe root ports (and the PCIe downstream ports) are there already
> even without "authorization".
> 
> There is a way to figure out the "tunneled" PCIe ports by looking at
> certain properties and we do that already actually. The BIOS has the
> following under these ports:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs
> .microsoft.com%2Fen-us%2Fwindows-hardware%2Fdrivers%2Fpci%2Fdsd-
> for-pcie-root-ports%23identifying-externally-exposed-pcie-root-
> ports&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C0465d319a
> 6684335d9c208da07710e7c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> C0%7C637830479402895833%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am
> p;sdata=z6hpYGpj%2B%2BVvz9d6MXiO4N66PUm4zwhOdI%2Br6l3PjhQ%3D
> &amp;reserved=0
> 
> and the ports will have dev->external_facing set to 1. Perhaps looking
> at that field helps here?

External facing isn't a guarantee from the firmware though.  It's something we
all expect in practice, but I think it's better to look at the ones that are from
the _DSD usb4-host-interface to be safer.

Mika, you might not have seen it yet, but I sent a follow up diff in this thread
to Robin's patch.  If that looks good Robin can submit a v2 (or I'm happy to do
so as well as I confirmed it helps my original intent too).
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
