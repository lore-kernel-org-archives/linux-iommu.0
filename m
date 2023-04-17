Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3306FCB
	for <iommu@lists.linux.dev>; Mon, 17 Apr 2023 13:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681737590; x=1713273590;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Yloo1GVjunnx9GbtkwEoUuNf8RnoM7TBBPPqiqyUKBE=;
  b=KrTVTBBgoKlVRcKlXNiezA3TlItu+kZ/KRXllGiMd1n66bJ57i9HRCfy
   tYTfGpavrjnIw4HXhGYVsnPc33o7xgHE4Os7oUSp6dn6aHqT7RhtRoN1s
   93LwXEUmZun94Z2bno0gfbtrc2dT+5Im7bd2vkWu7KkmRYOdS4yxutwzI
   3KscB8cxf9gcX88KLKaVfk86nO7MH8htaxqnms09HlrwnY75ZmQdxuUkF
   wiq/X/8ozMfDf17SPOojwwpGMllcEW9Oa6HK3skyplDk3XAJCDfio48W7
   0Hdvhb4X55ywehgw6YkvCA+NEhuo0YG/S7UQukViasYz8p10Q2xWj1son
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="410101997"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="410101997"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 06:19:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="834413036"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="834413036"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2023 06:19:49 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 06:19:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 06:19:49 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 06:19:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mz+k6Y15VesCRwUsd/iTyfPfitCXxQ3At1p+980RIEaQzAVxNCzpoNF9hZul/E98T2+W0r/Lks84ZgiSPya22VQtoYwrhtuKfCrn4LPpUgNcsGX5yD7a0ToSuRnZra+ZdgfftTchGRvAaS/FUmvDuacoOoLqDBZezPdBbJkMKztDBuXrSXwFueCK3nq1vjgXgMS65rFF+JGSWMShqbIEK+eQRxmCFVwMCV5vGIRwAvJOQgv779mlIfqv6VvmB+tSP8QNovA464r2F6dKGJO90V7IrbuKI5xv7kx7OOg5B69uii8oRdZ1vBAQwp2YMrCKJ9QtAWvWKo+YFyWNCCh0qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQNa302iNCV1md46AIW+Yt242JN1d1ayHYPylS9Adr0=;
 b=Z0G97KRKr6Rt8fsQv8IHDywLABLCah8X+mw33bNh/v1tGBPhDLcE/d4M5Kof97c/4GpWaHpQsu4F7vf6gmHUZXlvWoXc6IOq4zsXxwJnv0fxukzAHaIbUy4039wwqDUYHXbWiBhhqCzC1LNFsYfvRSCqigZrfRnV5kLnxrVDJq8YPy3KZn0PAog7zhBwbtC6yolcRlok33OzPmnjpqXmt+uvARGVNWiPfufD8fNYjQjTaPPYmeVBIuC/hvuYi3zw5gDczK6Z4YJ05HDGTlcuElKmE9xPipgKdDALRRqaayWNBYVgQmd1b6axub1kfBMui3bdqouj35z4HqHdMY+BZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CY5PR11MB6162.namprd11.prod.outlook.com (2603:10b6:930:29::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 13:19:45 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 13:19:45 +0000
Date: Mon, 17 Apr 2023 21:21:26 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH] iommufd/selftest: Catch overflow of uptr and length
Message-ID: <ZD1H1rl8ygJHqko2@xpf.sh.intel.com>
References: <0-v1-95390ed1df8d+8f-iommufd_mock_overflow_jgg@nvidia.com>
 <ZAuJB92z/6XIriZ1@nvidia.com>
 <ZD0EoRVqdfYkOtt6@xpf.sh.intel.com>
 <ZD06QshDIsLYLh3W@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZD06QshDIsLYLh3W@nvidia.com>
X-ClientProxiedBy: SG2PR03CA0129.apcprd03.prod.outlook.com
 (2603:1096:4:91::33) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CY5PR11MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: 0779d51c-ee84-4664-f199-08db3f466968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVPTUtq8X4XYcb5XgLEa6KttB/DiiDh2/pNQQFtSJn1ZqEP46Ty51YzbMXIJ63C8BHnQEuJFHxfJf3Bgx7nkqvoTI3Kxs9Ra8enmdUx4QoMAMpPx/KQqN60+2ZnUatCi4DwGquifnyRuSYd7mi4ZrPKCz0OZ3AsFwi2fVMAvIgIX/X3NohM0BM4iLIO6Ci/I3kY5hhB4cQVryHY+9fCDrDa1mwML75BVTnlDiNSJ/pYlwvfF2aHS8jhnu1N1mpfw17j/QGncdrQJQqqmwNEqU9/nUJvHnWht9novkl9pWUzmfmkBsFdNT79KSUxvZGCFYGyJqKORpxlZQkGZAoHl5HVjUK+Sij9poZ+2AJv/Xg5XWyF6etTMTJqvuoaqh442CotadO4qMY21MI/2S4QHh5kqrjeCQA27nXVJubYknSGp1Ul183UwC4Oeky0w6rISjSdHJuWfqMRZoHP5ruaiX5+jKzzkFd4W5Qtm2vslEouMPC5kmLLO3bdFdxqQho073gLlZqSbCsbJArt5pMqwgOhFvkNuu1XtqexXYax6Xf+Q/J41MUrxqVY/ZnFMoNZ4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(6916009)(4326008)(316002)(66556008)(66946007)(66476007)(6486002)(478600001)(6666004)(5660300002)(8936002)(8676002)(41300700001)(4744005)(2906002)(44832011)(86362001)(82960400001)(38100700002)(26005)(6512007)(6506007)(107886003)(186003)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v8ubaGqojKj7v06/6SYfYUv+9AoVV3vm1IKSC9P5fU50TwF5QpcEQcjyqU98?=
 =?us-ascii?Q?YW3Wkn4rtyyOVs1EU/DDaBYaMqhuuxwKKgBBW3QModFbVg16h7h/GkxhMnWZ?=
 =?us-ascii?Q?5ue3BQS20PLrrWZTkuk/aT6i4i6DNaAclqokexJy3iZK/eA8+7nP7FP2Q213?=
 =?us-ascii?Q?CZvqk0jbrffUy7QqF3lCnlDeB1EGFc9QrTX32Ir8Q2O5rTDjcmvsQ1/qb3dh?=
 =?us-ascii?Q?aNpI1jG4OKdru8uTP3juXSPI1XuHb9fOP1QP2grtjhVVpKKqmhA25SNxTJ6q?=
 =?us-ascii?Q?yVAOHA7X+jyjSYhBbXvIwF0yJZqk2wchV4MqPw3HhIHB0rKAbGDpgOZ8ubTT?=
 =?us-ascii?Q?H1QVyM/g8tHN+CBHGKM6F/pgAG5A1mtVdW+vNRo3ID8qE/kCSVpG+cOKAtVw?=
 =?us-ascii?Q?1wxPu/NATOhbYtfPL6CReugZY8hihUcY4R3ig6yi1ezu10tujJFXTMhSlded?=
 =?us-ascii?Q?dEHWLNOtInLSr0JDczNu9WTvsfdaee5BiRkPTqPR17jwCimdkJTttBxPK704?=
 =?us-ascii?Q?Wb+tdGrU9ZhbZqmoVwNcEumsSroyDnDxmWczv3ntbKiFePjd8g2C8eMhvzVs?=
 =?us-ascii?Q?dm8oxFV5ICPXEpbzcICIamcHoBgDW31I2YUAu1hSgWWLqpTxcoYWJde52uve?=
 =?us-ascii?Q?r2cq6myOyeO/quF46+JAzKQOXmbFRua8e8Rf92zUfOM9pOp3HpSQhmzwsEpx?=
 =?us-ascii?Q?Syyq1LLDR0/PtN6UZ7BTaHPWx190tjGxlr4B++flgxNAc5WP4eivpf/eez7G?=
 =?us-ascii?Q?L5J2SLN4V+YA61dTv6IoJI3866wTPcHad5pwQf/iChJj+C2vmOamJpyMI8Xh?=
 =?us-ascii?Q?kdf8O6uN/AVp10ED4uSYSwdy+0X4vFIovyZLeIsz7bAHXh6VazhLWh1lbOUx?=
 =?us-ascii?Q?O3yxpZJmlP/xHFqvZlPweMu58Ggkq2G7t3facVGhd3byOQvLBU8KfHnlw+7z?=
 =?us-ascii?Q?ezWznOzVMNBHX5MEuxND1e3gpqfrzvkyaGWAZ0ryXHxES20PhSArC5HS/Kjx?=
 =?us-ascii?Q?oluj1eJUopI7QHhHjJVe9VZR3kjZ6DETBlqeRWGhjFvOcUKZdJkJ2yRvcxDo?=
 =?us-ascii?Q?Iq7sr59oGoswGYj41y7hcErfGOERqhb+LBvhDhRwuUF8fdBOT4Y44s2q85Vo?=
 =?us-ascii?Q?gzTuf3lb8/oClF097I4aznHmKNPubMvuZ+VvG87WqPuLYCGHI2i+F/mp7Ig2?=
 =?us-ascii?Q?/PXVfDPn1D+XoBTHf79ColLcr+ybq51YxOPpHpb/pUDf6p+Xg0HdtmY38jKm?=
 =?us-ascii?Q?H+Z0MuAv5rflxUpd13FtMhcF5r4AkLKLZdF154PEyDxGI85nbaHTI87xznbI?=
 =?us-ascii?Q?5oohqq6X4KOc3Wlgbe5F8kXlKAlUw/aDjpMrC1ur5YRwWL/WeJ/znpZI5UUy?=
 =?us-ascii?Q?X/7YQ7vyH09uT/xRu5IgacYAL2VZ+XB96RG17zQiIB8XoBDnJZSRXe1IT3t/?=
 =?us-ascii?Q?7a0RHoJyreUnQF9NCXEZjqC71QOIq+VfI6fBam1X2Sm8kKt7yS6cTcOlIkJT?=
 =?us-ascii?Q?jBabt5nv+MYusuOkpmqsI8ccXFsjO3Sykxfz46PCI+fleSCgPD51ih7axBM6?=
 =?us-ascii?Q?OPJEF/N0UzrFKQSU94AHw17FpX7zbfMek9OmeW5J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0779d51c-ee84-4664-f199-08db3f466968
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 13:19:45.3583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+I3W/v2VOvNBTo4iZizJWUiE/1JctkA6OnUKJho4rZe3Xf+O82RrhVHQR8e7Btu9vg5jwnHQh6H8iX9FGS8HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6162
X-OriginatorOrg: intel.com

On 2023-04-17 at 09:23:30 -0300, Jason Gunthorpe wrote:
> On Mon, Apr 17, 2023 at 04:34:41PM +0800, Pengfei Xu wrote:
> > Hi Jason,
> > 
> > It's a soft remind.
> > Seems like this patch was not merged into Linux kernel main line yet for some
> > reason?
> > And this issue still could be reproduced in v6.3-rc7 kernel.
> 
> Yes, since it is a selftest only issue it will go into 6.4
> 
  Ah, got it, thanks for the description!

  Thanks!
  BR.

> Jason
