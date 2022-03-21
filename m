Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76D7C433EF
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 14:07:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 42B2E40227;
	Mon, 21 Mar 2022 14:07:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oCWHvJFKvD5e; Mon, 21 Mar 2022 14:07:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E025840106;
	Mon, 21 Mar 2022 14:07:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9546CC001A;
	Mon, 21 Mar 2022 14:07:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F805C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 14:07:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7AF4E41508
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 14:07:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uXzlyYerauYj for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 14:07:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2183240883
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 14:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDfxK8ZrbMzKdstimr3jEpS437g9g8k0XGuY8f9W+HkFf8CUoU84hKOSdruCC2SuZf0Mlk9BcEIkhicgFfarVdy3SfJaWKfSRlYCLOzHfoHvu4NxVllBQbv/pdmSKTyJDUPHvIiT8mRcgIynv5mY2QA+25HVioYI+ZI7Lyl+pFibA35AaLPvQsQVLZG4Pv95EYbJbWHnvcPm6HCKCRDOQV7ilWFMeD/oPe9g2v7uJx09XwTcpcYkY+XQm3+GxAec33wCa/HXtEoh/1r0ZgZhJexIsDCCm6IjJsN0URHdh9jz5XOaJWVyW/fEvm98le1E7eMBBgos5JqwcQXY2l2JCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8cpz5mqDR80LUfIirnOdhMXugefKNY5Yd6+kyK5mNE=;
 b=MKCjOP65cCcGmXw1VAAqTxkxzSuF7/vBcKbuD8KS95nYl9/5RZXqYcqu4LKgHQoWNqUirNQlNlTBDBt29WMEhjMGwJ8tcZ2doXuWxhBK9o+kk5Vb+o72LUQsojv00gxnHil8KHRYSmm+eLt/K0JpCyYZHICAOTzkRYXxZPS80ZHxtTJfQtfOtYS4B7gu0Napuz8kNIXf2lmU4JEWGPyJpeOIEnv/QOmlalikCKXnClYY6pTJNeE5KP21hbuCZtd08WEvtjUaVaIF8OgSEI61UivKntYzOoy5ro5Dphg2SRh5EF6QQPthy0hFnbJeV940G5s2BGvUla4Sv8SGU5Og1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8cpz5mqDR80LUfIirnOdhMXugefKNY5Yd6+kyK5mNE=;
 b=UrD5Kyg0pUDgmnrSCHZtV7zy9rjUbyZolSYJhwfprEZokO3f4IepqYNoWOTM+L5sx/5K3y65QQo9aj1+bpyLYMD/3w/gcJ4LCmMgJhgAaNuiVF1oN2g3UJP2fKrzW+uATTnpPu7HX+WMu2vhlaJHDmlW5ONQOT6V2Oc9+ciFAHM6pYCadYnFV0XyV1xluC7/9lkbLWIQsiusillKU8StKlOeKnN9uE6PBhaLAzoAaCOlOXa7BO6JtwiFXh9pcuwgIXg26M+GD5bVDdIdPbZ5n+cND5num7M1wEXYIUtwSWA2bE8xkVoTas7H44jNanU+nno0v2HFyRPM6E3b3mQEQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 14:07:02 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 14:07:02 +0000
Date: Mon, 21 Mar 2022 11:07:01 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v4 14/32] iommu: introduce iommu_domain_alloc_type and
 the KVM type
Message-ID: <20220321140701.GV11336@nvidia.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
 <20220314194451.58266-15-mjrosato@linux.ibm.com>
 <a9637631-c23b-4158-d2cb-597a36b09a6b@arm.com>
 <BN9PR11MB5276360F6DBDC3A238F3E41A8C129@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220317135254.GZ11336@nvidia.com>
 <BN9PR11MB52764EF888DDB7822B88CF918C139@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220318141317.GO11336@nvidia.com>
 <BN9PR11MB527649907D241347BCB540528C149@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527649907D241347BCB540528C149@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:23a::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 250986d1-7ac7-4f9e-f979-08da0b441291
X-MS-TrafficTypeDiagnostic: CH2PR12MB4296:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB429657047FFEC3C210AAE62BC2169@CH2PR12MB4296.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CKoAj/jnlmMJbberT6z7QbxBlajT5rKtu6/OjY38Obr0rJtDv8xZQrZhMVWH75/Dq2cSzrg3oDJn166RdxvDnk0KWINk76TuBa+WKVCnbI1UBog4JrfQYzrxbGKUMw19VBvtjWpI4WqXYsaWNB7DU+jI/HZqW9C+EDjPwCqj6maAV9udyv/Q2ocqYtv7yPurMYdp4kLa4fEtUc5ApvpY74BnVeB9VBBF7pGAsDMy/rt565ovdjI/dcpWpCcJqqCnGCD1Z2PJD3X7OZRFguUG92cdyjZIGmZfF3sHigxVw6wZnYh5qr1+vgny76K73yX7839r/7oLHKmJaknbNiTvKAC0kdAfK/O0Bq8VkcHPOj6dI56FoJvHrtc8J8tsj66cvtodUrQXX7OFMnNaKFGXwJdG3Zpridha8EGd4wj2i7vfvlAidjpys23x2yZJ9Fflf5gO5cn1WM336xiQr6Kwq66FunrPiaJlPbwBVo6flZeNjL7R8fskwep91HxDNB6Jp48YvEl9ugp6FDjwz/wjepSlcY6u945OSoK3hdP7ld0ltCF3ezGGpYx1qekCZXtQ4quYRL9G6ANnndxJVZEtKohdwxwRQa6PK9PZFvSJkO7UiUsJbaO+6pwl0mVLaQerp0zIr9RSRi68BhG9vgM9wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(66946007)(66476007)(5660300002)(8676002)(4326008)(6916009)(54906003)(508600001)(6486002)(83380400001)(316002)(33656002)(2616005)(6512007)(1076003)(36756003)(186003)(26005)(86362001)(7406005)(8936002)(38100700002)(7416002)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XGVPAknhUyhm0K88wW+3o+nj4hh2vnCErlyNJDQ0SAEFLBy03SlndrCx7WwM?=
 =?us-ascii?Q?/9cCnklrzBNVwOUfLGGkOxDMfyBCv9vdAzQsugddqfrDVCR1GdaNyEsrznUC?=
 =?us-ascii?Q?Hi+37odDxPHGlw83R/jkPpvf3Wzn9X3lZAmcqLeSTW5S0t77JOWrnaI/eugy?=
 =?us-ascii?Q?vWC/5fqavna0H1cH90FkNvLP69iMg3PFNnGppH+JCizivnFchFETXQpud9GH?=
 =?us-ascii?Q?r/JqPRSq1ZaebGaR3Vb4BPKG1h49HqQPPOEMrJBH+TrdV8ezgQFj/tK8NrvH?=
 =?us-ascii?Q?rRttRUQkD9Wl/Ous3HUbpSefcQBOPyxV7GrcVlNcDtKcNPh+cmMk6XEPed5j?=
 =?us-ascii?Q?tfPYhkWWn3uaOnKcDkmiIJvU4eiDmeIlJB9GaPMWax/HlcsM/O751FukWj57?=
 =?us-ascii?Q?BdniCdktmlHzM/qAVKF2Sw95/SgBg/quIomtzCjcJBMe4afeeFtNMuC3xPMG?=
 =?us-ascii?Q?CDaOvMbtTOM7WID6I4RVWh7XyZ8XI5Fep0atNEvHyM3qbzwlMqIISmMC0cb4?=
 =?us-ascii?Q?hshQe5FsgZ10n8yMN4IAjeuOUuNEuFuEUyMZIQomkKICWAgT1MbEJdA79c/a?=
 =?us-ascii?Q?tdY+NCmbvDtNyMn52PZFGMfpH9800aE/Rl57HmgxEeBsj5G+ei3jLguGxzfr?=
 =?us-ascii?Q?q9ENea7WAiNEzWjXJ9aKHG/BtCpg0Qe3izsvXHPm3RvbHoMieamf6vngkZT7?=
 =?us-ascii?Q?UyEm6DANthEN6snti3q2TshOTCywxfda8E84HxLJ7pfArLGa5KlZlvbM0frB?=
 =?us-ascii?Q?4pAxrUOkOgn537TmzIHULKLtVkMWK9ZdwWpfZD0hJzwPPjOl8rPckwn25duB?=
 =?us-ascii?Q?F3Bfkt3T6DTDrNucy/BwZQNMlnwCFzmXwIPLdcqC8UAD0OJeQFTi7tj5Q5gZ?=
 =?us-ascii?Q?cHLv+hX2hJWLr9r6Jno9FtBvpQi8kpOt//y0O+X9vp8hsgz+W6N+dchbGgBC?=
 =?us-ascii?Q?SvCgONd7T3Vy+q1tyIkrBSdu7U/PtXwyBxgKsfjKa7nSJWA8XZLYIwBtqbhI?=
 =?us-ascii?Q?e+GSMRzmV7KmEjNQ5/pQw1DA+yKcBdMLq4DNTHI7DpuMpaGo5cN7uRuzIq/H?=
 =?us-ascii?Q?K6/0Yq2ClsRKgR/A+UAR9V2ReP68sGIfUTkOkZFLgRZzuGJ9qej60jDJ1qAU?=
 =?us-ascii?Q?nbz9zE3EpvHr/Dm1ATb6vhjmQCXuZIpYqYI7t55TCLD4P+bnRrmOLC8e65Bz?=
 =?us-ascii?Q?cl+/2NO9RYDs6696OOMO7Gi/kwcbwAHCcdfsWbnOKX2OmMta9sesNML5G+PI?=
 =?us-ascii?Q?QTNDqU7RcCvg2nLS5AckLwivqlrHrVJp2JKiiaEF11M1CwD/GUx83ZxjV0+W?=
 =?us-ascii?Q?sKk14JVyBqZxpVl2vPArwYxuildnwwrotrsf7WZlkHWoACeN5G+e9fBQihyX?=
 =?us-ascii?Q?dm1zkSYqRtgo+s47YpWZcmPwD+L8hPPkWSTkGBX3iZW5aoCayuftG+wuBdXe?=
 =?us-ascii?Q?VSD4h/YmYwqLob36FCh7lrJzszqP/Rb9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250986d1-7ac7-4f9e-f979-08da0b441291
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 14:07:02.5459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vArQL2dkE+bAFBv27NnXD9Hng4Ntl/RD+08NKFpK/QowIbI0SGg5jWgRf2ZCKPzl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
Cc: "david@redhat.com" <david@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "vneethv@linux.ibm.com" <vneethv@linux.ibm.com>,
 "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
 "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
 "will@kernel.org" <will@kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>,
 "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
 "hca@linux.ibm.com" <hca@linux.ibm.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "freude@linux.ibm.com" <freude@linux.ibm.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "frankja@linux.ibm.com" <frankja@linux.ibm.com>,
 "pmorel@linux.ibm.com" <pmorel@linux.ibm.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "oberpar@linux.ibm.com" <oberpar@linux.ibm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "svens@linux.ibm.com" <svens@linux.ibm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sat, Mar 19, 2022 at 07:51:31AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, March 18, 2022 10:13 PM
> > 
> > On Fri, Mar 18, 2022 at 02:23:57AM +0000, Tian, Kevin wrote:
> > 
> > > Yes, that is another major part work besides the iommufd work. And
> > > it is not compatible with KVM features which rely on the dynamic
> > > manner of EPT. Though It is a bit questionable whether it's worthy of
> > > doing so just for saving memory footprint while losing other capabilities,
> > > it is a requirement for some future security extension in Intel trusted
> > > computing architecture. And KVM has been pinning pages for SEV/TDX/etc.
> > > today thus some facilities can be reused. But I agree it is not a simple
> > > task thus we need start discussion early to explore various gaps in
> > > iommu and kvm.
> > 
> > Yikes. IMHO this might work better going the other way, have KVM
> > import the iommu_domain and use that as the KVM page table than vice
> > versa.
> > 
> > The semantics are a heck of a lot clearer, and it is really obvious
> > that alot of KVM becomes disabled if you do this.
> > 
> 
> This is an interesting angle to look at it. But given pinning is already
> required in KVM to support SEV/TDX even w/o assigned device, those
> restrictions have to be understood by KVM MMU code which makes
> a KVM-managed page table under such restrictions closer to be 
> sharable with IOMMU.

I thought the SEV/TDX stuff wasn't being done with pinning but via a
memfd in a special mode that does sort of pin under the covers, but it
is not necessarily a DMA pin. (it isn't even struct page memory, so
I'm not even sure what pin means)

Certainly, there is no inherent problem with SEV/TDX having movable
memory and KVM could concievably handle this - but iommu cannot.

I would not make an equivilance with SEV/TDX and iommu at least..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
