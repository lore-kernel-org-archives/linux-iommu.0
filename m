Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AD9C433FE
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 13:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6630A409C1;
	Mon, 21 Mar 2022 13:21:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xr0tBZxsHKmB; Mon, 21 Mar 2022 13:21:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1B39440028;
	Mon, 21 Mar 2022 13:21:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E626AC001A;
	Mon, 21 Mar 2022 13:21:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ADB3C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 13:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC7884018A
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 13:21:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YLvewXoYMLGS for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 13:21:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C3C340106
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 13:21:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pms2GVqw5ZmrHhVcFe31NmwTdpIv4FgyXFBWL9vyTH32O3utjOHBnLEENOkfXOpMy0UY5K8PdbEa/1LPFjWBegcIo/eLdQqZY2gkU7DoY4WHFftTPhfjLdtVLfVVnBrrvH+HAka8IO40QSCSzlQ3fnQAZXExSr1OdMVGWlPfAfjGcV2v57AtvrOkeQ9FXGoerR3xk9FarWE58u38RjoBvCN3XAEg8D7gYugTugUftPFatKKELRTlckED2Py3b049hvPFkDewNDLz/xLniNsgGhcmxMChvbAdrIsDCX8X/LH5rkumpYu0Sv/mT+hSttCrgncqXoVfuTrX1yFlqSuPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LV5+Af7517RVVFlSS2v6pLEQNYf2vCKGB4CbYBqXaqM=;
 b=bvoyOmN+NW6ztkC8UTSzGjZxZJLplCNuY2uGNOlfHeMLJs3pJBZhPJrL/aS4aXNdzFnbi5Zym+tuh5g7QLjCiM7OZBf7VN5amEWF0GrwQKratEe1b3vhR7g4PipAtFK1ckD8o6NFtu1MXw3TVKt3V9Z7rLJfLdXGyENsHJC0gAnWwJz/ayrulTWF80v8w5RkkD/MXMRCUEe+r3RAo3EUpJXdTgmco+HIUL8hovQ3X0+gZ3UkzB1zoZorogYAVfH1grq5jLPDPAIybjKopUlvorhxRZWoYQwow3MqSRXamRJ82keyfMLDGyVQp1R7XpvSgo5XuYYW8zLXLsyES3FP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LV5+Af7517RVVFlSS2v6pLEQNYf2vCKGB4CbYBqXaqM=;
 b=1PAr0S3jvvZ4oeljbnwqSwIAqgkVXrCFxqZKAfyx66GD4LVPZpF5CMpex9es/b/C2P1b1kdv3EDVW4xIJOB94W/qmUosh9S7OgNOSci29P07o3GJnLy3dmy5hNBKrNUS9fbMeUgVUAqaqB7mdh4Cawr/E6ONs+geftMws7WOGtg=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by SN6PR12MB2701.namprd12.prod.outlook.com (2603:10b6:805:6f::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Mon, 21 Mar
 2022 13:21:14 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 13:21:12 +0000
To: Robin Murphy <robin.murphy@arm.com>, "mika.westerberg@linux.intel.com"
 <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH v2 2/2] thunderbolt: Make iommu_dma_protection more
 accurate
Thread-Topic: [PATCH v2 2/2] thunderbolt: Make iommu_dma_protection more
 accurate
Thread-Index: AQHYOu+lUdyxWySMNUuJeS+suvjzA6zFr+rwgAP/aQCAAAOwAIAAI47Q
Date: Mon, 21 Mar 2022 13:21:12 +0000
Message-ID: <BL1PR12MB515731B8F62C45156037CF8CE2169@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <cover.1647624084.git.robin.murphy@arm.com>
 <0dd14883930c9f55ace22162e23765a37d91a057.1647624084.git.robin.murphy@arm.com>
 <DM4PR12MB51683722CF9A553563D0C721E2139@DM4PR12MB5168.namprd12.prod.outlook.com>
 <YjhaViFzmEjBgmmu@lahna> <fd86c2cf-3068-1bea-2a6f-46cabb019062@arm.com>
In-Reply-To: <fd86c2cf-3068-1bea-2a6f-46cabb019062@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-21T13:19:53Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f31c7994-a437-426b-859f-969cdcc67817;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-21T13:21:11Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 2e276c30-4fbc-4d1d-a66b-d1a1f8804847
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d42ae7ac-060b-4753-8b66-08da0b3dabd1
x-ms-traffictypediagnostic: SN6PR12MB2701:EE_
x-microsoft-antispam-prvs: <SN6PR12MB2701D623F2226ECE4969E809E2169@SN6PR12MB2701.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nkbo5iW432hz+wGMSUIjvEfDmREDfigHhKBUFyb4ZtSDY00gVU8kaaqMIZ6i7Ay/SerL60Lwrx9Q2x+s7zQRjxKXeNnUxeJ+VO04EXAP7CD3A+o13uvpGODaGn17tNoKx0qBJP2UDwH4Qy2QKx+PFQ8JiA3Kzu3xUeJ+qsjMqXhgzM7l17Xpmo03agSXhPXa7/Zgw1lget9FeAmyygZo2LTc6FVRerMmq1Cc3Mdvld9VJxyjVj+fxg7gIQUdRFNjfzkeqS1V7eZi8NX7zU0Z88vXSFPHtcZSkAUKlU2nV9OMlGzoWJ9CpLDd0UrsdTr0+vc8/UXB617NksykOpRktnoJo5CeyF8QEPlfTTL1KEVRwZzEAeyvygPYgtZk3BWBkNaEA4xzAoRboOH9AI8cmHqtxKVWPSnCVPC6B+AYMPDf+aX4PuO+hyM5bE/rVswkBVUmyzHdh1hrgysFBpJh8AZET3mrQAovtYw8lnxFY/VtUb7rUWmLfXWfJ3WZINfCx9ZXt+i+eZ7DidGdBTBmsiHBsKqqW/EYUu/mK8UR9CJOKg0NNU/7V1RS6luwQSI7WhxFrm2zXct1acgoU5oqWnltw9+yp6Yy562vASpqhEYv1SNFsFood5ie5ueJoWcqypr1tueD0FHXpdvzMvjee3UphjPnAKxFI5Uk/ip+jPFQKnu9LSYzjxMfHRQka2Jubct492b78bQwp8kx5ZMJzQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(66476007)(66446008)(66556008)(316002)(64756008)(4326008)(71200400001)(54906003)(110136005)(76116006)(38070700005)(66946007)(8676002)(9686003)(86362001)(8936002)(186003)(2906002)(508600001)(5660300002)(52536014)(55016003)(38100700002)(122000001)(7416002)(7696005)(33656002)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUIrb1o1UEZNbjY2WkxBUlBORXoyNTZJY095TDJUcGRkbmtRT2t3SmRSZ3BK?=
 =?utf-8?B?YlZKK0JsUThUZjdtQ1ZUWXpUSFZYMloydXNZMENPNTNnM3E2TENuMUhhNDZQ?=
 =?utf-8?B?UHFUZU9uOGZweUtDUVU2cUcxeDZjOTFoSDAzbE45Q21FTW9Xd0ZQNTdMWUFI?=
 =?utf-8?B?ekJBOWYzeU5kUCtTenluSitxbGdkbnhGZkhMV1pnM3dmcFphUmJQc1F4cTY2?=
 =?utf-8?B?Qk9Edm5tWmNBVnUzNTBBUlJGNCtjbUR4dHo2end2eVBvazJYWGUrcmM4Zmhs?=
 =?utf-8?B?TW1SSldkTmxhSElDUkRvdVVtaVo2ZCs2MHhya1BUTDNCeVpYd04vRXBZT2tx?=
 =?utf-8?B?UTNYVEtJdHJMV1E2bXRYalh4bVNlczFFM280aUlyMXpYUnNVcmxNZFJpeHBB?=
 =?utf-8?B?RjdUOTVTRmN2WUlXaHh1dVFlVDBlWXlJVVVDZ2VRVE5BM0lYdlordlk3QVV6?=
 =?utf-8?B?bHp4WXhEZUl2R0hHUW4wdU94S05vT04wZkdBelVuRms5SFVtb0VPc3hZcUJK?=
 =?utf-8?B?eWFxdjRkbXNqYjJsaTVERDlJV0FKemdRUTcwUUcyNE5RbUp6bzV2N2ZjalFK?=
 =?utf-8?B?Vlo1aDJIcHNKeU5sOHk4YW8vUThBSjBqdnZPTVF4NzgzVktZRlpyeVFueVhH?=
 =?utf-8?B?WmE2eTdESUR3ODlvaGF2a3ovQlplclQzeUI4MzFJSzZnYkZBdHh4SE5pSGhr?=
 =?utf-8?B?SzhMcWhqR0hvakUyUUM3YzZwdUphUjB2RDNkTlFPZzdVZzJkV1ZkM3I3WVBv?=
 =?utf-8?B?eitjQlVHa0M3MjdxUUZMRmhmeWxxRkJHTU1DMkFrZGFOeFI5VURhd0E1dTFJ?=
 =?utf-8?B?alM5R1VTZ0YvYjZLeTJ1SURNbnBzeWZ5TXRDS0h1SVJGMEJRamxoam00VTAw?=
 =?utf-8?B?c3BpeWNGeUFacERCQVpQQWNKY1dpelBkK0pzcXNFeEFxUUdNY3BSTERSN2I5?=
 =?utf-8?B?Wk1GVGc1Qnhad2ZidGRianZlak4rTW81a2M5b3dhaEJGSXFWdFl0TEVrc1gw?=
 =?utf-8?B?NjlsLzJ3U2M1Mk9oTnczcVNKeThSTGxvQTJ0cWxYRTIzalVxZlY4VFR1cTlS?=
 =?utf-8?B?TEl4YkxJLzhWN09yRDB6R21aSWx6a3ppKzB0L3h3NVlEdGppV29UV1VlVXRC?=
 =?utf-8?B?UDFzOFdWWmowUThoYjBKYmJFTnRSSDRtTk40MkxYWmhQc1BMa1NuTkZnTFEy?=
 =?utf-8?B?WFl5aEJVWGU2NkFjaDQ4Y1ZXbW5zVmlxREFia3VTdnZrZXh1Nmc4dlF5K0hI?=
 =?utf-8?B?VmphTWgwVVFHdDVJL0lkTkllaTcrZGhXWndQZy9JajZpZWw0SmFCNG83WlA0?=
 =?utf-8?B?V0IwZnI2dUo1ajVjcU53d1NBVXJydEpJa2dta3JUWmJDRUdPdHZFdUd3Mm9E?=
 =?utf-8?B?aVdCSmhnOFBtQWs1MVVZT0VMWVQ0eHc0ZnAzQ21rMWk0WmtPL1dCL0J0c2pJ?=
 =?utf-8?B?cjRTS3JkeEVDVE5FT21iRWN5MG1kMjdZbER4QkJjSmpHeSsrQWMrbHU3dlgx?=
 =?utf-8?B?U1pNL1BsQkpTejRtS1VNaFFPWEcyejZEdUNmS0Y0TCtwT093c3NPKzYwdkhs?=
 =?utf-8?B?a0N6UGQwbEptU2wraG5wNnlsb2RlWGR4eVp3d3Q3L2lQN25sY0ZkTzFkV1Rv?=
 =?utf-8?B?RU5ScjZCNWxkaTRDSGt5dHB3clp4WlNUK3RKdmc3d1RkMkdQSS9xSEt2VnQ2?=
 =?utf-8?B?ckxTN2JMSmhwREdreTArdHZmVXNCT1FiTkZzeFhXcFNUK3dGZGg4U05uS0FE?=
 =?utf-8?B?T0lRSitobVQvaTdiQVIrbTBaaTM5TzNGbVMwQzJ4YTI1Uy9DL2dEMlRlNG1j?=
 =?utf-8?B?RmhqNWZOZ2dEZjIwUzhwVzgxMFJPT3hIejdEaEI2eXN5bU03a0syODlMTGV4?=
 =?utf-8?B?Y3BiMFZ3STU2c0p5SjlvWnhqK2ZhUlFXVitReXdQUFhBcmRJQi8waVdqckIw?=
 =?utf-8?B?RkU2WW5hcTQ0azIrZlhGT0JtUDZNM2tCbWZpMGl6Z0dCK000V0xHYTlWZHlL?=
 =?utf-8?Q?aPpcv6TasVXB4CLI4oxmlSyRZnQmk0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42ae7ac-060b-4753-8b66-08da0b3dabd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 13:21:12.7862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L7Pr3qn8w/5mHk/R5qI+LiTPy2F++x+4V4I/4IHOWxIO3sEz0hTy9wb90uV7tW2aZLrsUg/7ahayXzky8bsgXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2701
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



> -----Original Message-----
> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Monday, March 21, 2022 06:12
> To: mika.westerberg@linux.intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Cc: joro@8bytes.org; baolu.lu@linux.intel.com; andreas.noever@gmail.com;
> michael.jamet@intel.com; YehezkelShB@gmail.com; iommu@lists.linux-
> foundation.org; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
> hch@lst.de
> Subject: Re: [PATCH v2 2/2] thunderbolt: Make iommu_dma_protection
> more accurate
> 
> On 2022-03-21 10:58, mika.westerberg@linux.intel.com wrote:
> > Hi Mario,
> >
> > On Fri, Mar 18, 2022 at 10:29:59PM +0000, Limonciello, Mario wrote:
> >> [Public]
> >>
> >>> Between me trying to get rid of iommu_present() and Mario wanting to
> >>> support the AMD equivalent of DMAR_PLATFORM_OPT_IN, scrutiny has
> >>> shown
> >>> that the iommu_dma_protection attribute is being far too optimistic.
> >>> Even if an IOMMU might be present for some PCI segment in the
> system,
> >>> that doesn't necessarily mean it provides translation for the device(s)
> >>> we care about. Furthermore, all that DMAR_PLATFORM_OPT_IN really
> does
> >>> is tell us that memory was protected before the kernel was loaded, and
> >>> prevent the user from disabling the intel-iommu driver entirely. While
> >>> that lets us assume kernel integrity, what matters for actual runtime
> >>> DMA protection is whether we trust individual devices, based on the
> >>> "external facing" property that we expect firmware to describe for
> >>> Thunderbolt ports.
> >>>
> >>> It's proven challenging to determine the appropriate ports accurately
> >>> given the variety of possible topologies, so while still not getting a
> >>> perfect answer, by putting enough faith in firmware we can at least get
> >>> a good bit closer. If we can see that any device near a Thunderbolt NHI
> >>> has all the requisites for Kernel DMA Protection, chances are that it
> >>> *is* a relevant port, but moreover that implies that firmware is playing
> >>> the game overall, so we'll use that to assume that all Thunderbolt ports
> >>> should be correctly marked and thus will end up fully protected.
> >>>
> >>
> >> This approach looks generally good to me.  I do worry a little bit about
> older
> >> systems that didn't set ExternalFacingPort in the FW but were previously
> setting
> >> iommu_dma_protection, but I think that those could be treated on a
> quirk
> >> basis to set PCI IDs for those root ports as external facing if/when they
> come
> >> up.
> >
> > There are no such systems out there AFAICT.
> 
> And even if there are, as above they've never actually been fully
> protected and still won't be, so it's arguably a good thing for them to
> stop thinking so.

I was meaning that if this situation comes up that we could tag the PCI IDs for
those root ports as ExternalFacing in drivers/pci/quirks.c so that the protection
"is" enacted for them even if it was missing from the firmware.

> 
> >> I'll send up a follow up patch that adds the AMD ACPI table check.
> >> If it looks good can roll it into your series for v3, or if this series goes
> >> as is for v2 it can come on its own.
> >>
> >>> CC: Mario Limonciello <mario.limonciello@amd.com>
> >>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >>> ---
> >>>
> >>> v2: Give up trying to look for specific devices, just look for evidence
> >>>      that firmware cares at all.
> >>
> >> I still do think you could know exactly which devices to use if you're in
> >> SW CM mode, but I guess the consensus is to not bifurcate the way this
> >> can be checked.
> >
> > Indeed.
> >
> > The patch looks good to me now. I will give it a try on a couple of
> > systems later today or tomorrow and let you guys know how it went. I
> > don't expect any problems but let's see.
> >
> > Thanks a lot Robin for working on this :)
> 
> Heh, let's just hope the other half-dozen or so subsystems I need to
> touch for this IOMMU cleanup aren't all quite as involved as this turned
> out to be :)

Thanks a lot for this effort!

> 
> Cheers,
> Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
