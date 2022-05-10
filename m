Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCA9C433F5
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 01:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54E4381762;
	Tue, 10 May 2022 01:38:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MvJcxxp00qXv; Tue, 10 May 2022 01:38:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8781E8175D;
	Tue, 10 May 2022 01:38:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BE0CC0032;
	Tue, 10 May 2022 01:38:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B05BC002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 01:38:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF7CC8175D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 01:38:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 93AT6fGt1dFI for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 01:38:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B35798175B
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 01:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652146711; x=1683682711;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pRkNWP86i2qFma4G4bcLqymjKodLCOZ0xp0FmgnnMi8=;
 b=A3DMpb1JDY9EHYqp2UFSuGPc88sSRldJOFUfAkJo+vmQ0VJGC5es4104
 k/fXSaUv6+cSRzThK22qdGnsxCxGGfDp+1x8o53cmMVgE8UU5kbntaq79
 To4JO3WWlXvSQVLAp0p0rLyPBFSRbpK2Q7bjkoKinW13FzMvRUJWhRkda
 +eO+yliEKi6VeH3I7NiAb1wOv19zt8FJ7WHHauChgznKEmRpNlwJ3tRDo
 y+NWFVKu8mS+6TyOFiU7muoSdN3GsHfWLOCr5VLOfOkqT3ICbXxAZ7sY3
 BzfPkK6OeumvU8Q0/shTlhk3vx9WIgJKKnNDpUULXum0ntUqFrDHacgW+ w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="269158336"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="269158336"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 18:38:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="738452749"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga005.jf.intel.com with ESMTP; 09 May 2022 18:38:29 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 9 May 2022 18:38:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 9 May 2022 18:38:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 9 May 2022 18:38:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGQUC3N9/IMKopsHF3Pg2mu6cbnbc4LHa6LZ/PfKZAQobOJigjHMp8Gr+Gwsa3ivSpmco1PqgEShH7z6wMIq1pTKRMgXIJTfG3SfucIhM7HrchqOs0cWWtHh+zt1GaSgwHfcdJs3u/bSX8vr1UcUBdNVpk5amKkYFUdimtDDR7xYvhjiS55mIhST2rXXy+EQ75CPoXXtIxgP9kwCPOmQJ5Q+mLv+E9VYIskgVnA90XpO2hwCUjn+o84wKDw95htfX8PnnjbuTJqd2sbBHK2NMiD4Xi+V+4yKPLnd8H7tlPBc8yiF2P6j7bfmLTVZMQfMmy1Ikbqzsw3M/L1zMxWScg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRkNWP86i2qFma4G4bcLqymjKodLCOZ0xp0FmgnnMi8=;
 b=btO+Vma5j9lpOWn/BzP5o/66mcUeEL4Z2Y0YVJJ/ExSn1qgWmCTosX5iAONHzRYpOjfKLlvj2rvYaT7Aj0WuEaQA3JVqIfS7CphD69BVkCU1o8VC1Iqk0pMuvqjafZ4v3GpBZAeAbH6b5vRvRQBn95327O7yLQ3QeaokqGE51w3AT95JV/hG9a2w1AYCqOPH+Hg907TMANh9q0owipnFWzGYEfpYMc3XTe9UT+C6o9UNRW5Z4gFYAK+m1teFrKEYjz0K33TCcD/sQeMkNxmw6gSJZdliLDSlrg9WTnVzreQ6/9kI9tyLJppJveOZQAmosXf/5QyjNQaLxykTZr07hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY5PR11MB4167.namprd11.prod.outlook.com (2603:10b6:a03:185::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 01:38:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 01:38:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH RFC 00/19] IOMMUFD Dirty Tracking
Thread-Topic: [PATCH RFC 00/19] IOMMUFD Dirty Tracking
Thread-Index: AQHYW0R/S6mfDid5yEe6M+QKFrUDn60GOWsggAB3owCAACSFgIAI+m3AgACMaACAANzWEIAAjfgAgAWZrqA=
Date: Tue, 10 May 2022 01:38:26 +0000
Message-ID: <BN9PR11MB5276AE3C44453F889B100D448CC99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <BN9PR11MB5276F104A27ACD5F20BABC7F8CFC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f5d1a20c-df6e-36b9-c336-dc0d06af67f3@oracle.com>
 <20220429123841.GV8364@nvidia.com>
 <BN9PR11MB5276DFBF612789265199200C8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220505140736.GQ49344@nvidia.com>
 <BN9PR11MB5276EACB65E108ECD4E206A38CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220506114608.GZ49344@nvidia.com>
In-Reply-To: <20220506114608.GZ49344@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5865237f-91c7-4c59-5e58-08da3225c70f
x-ms-traffictypediagnostic: BY5PR11MB4167:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR11MB41675B9CE5118018465264818CC99@BY5PR11MB4167.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WZ9AM44NdS33+DYSwmywD7XMJQ8Mkj5plLYDLRzt5gFKqaFlg3ULWb18X/pj5FYoVT2RYm3qIxVvbWG0+BF/kAr75cQZchjCtT/Y0fKIico1vyiA0qtw9YgAmQ13NaNTmyHlqYDaDwxtyCTDfLdJkcQa9EuvPsGIB4/vD/QZcYNuxYxkpboXpEzw5O4UzrApQyOcbQ7eT/XKoeoK/I5ISA7imH/LVEE2x0vBNSoy1r99I5P/arSBSlGKO5ZqeBh046I+8Z/JiLc9Lo0BWSTHwOm9Y3UOWAFHhLjImhsH+33CVR9sweWbKKr3w6Hyk/FwvHut/Oy+0FGZmjiG50gZzuYPWx8RJtH6tiCkNTI7AHNnmFUOOBtelA3CqqvYjToS/m2yiEHpKy4fjUdYNEsmi62OGmeKhDyk5dJXdu6ue4H82gzo3gWUeBNQ/tER4UF8T2s5o6mp2BixGK+xkp6FjhtMuBbX0cI7cQsWBxzLJpv4PvP5zW0us+nF3KiIiDguacNjrxEqlwcBiL2/2KUAmUz3bn6tD2RY5EOzueWZhGjCocZEQGpZy+BcuEKNvTFAr9wbfWveVJpARq0uhqpMWmkKfJcg2bJlxt8hsZ74mtNQOZFtwYSUB7yymU1qwHtIALSLeWtVb+M0dTA+W2Z8omhqd16MU2CFbkb7cGecjljLlRyM3NmvEueuG4mXr8a/LHNs/pbGgAOFlOlYBtiuFmHcEiNPhyJmBWy2gRuLI7Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(82960400001)(26005)(55016003)(122000001)(9686003)(38070700005)(38100700002)(6916009)(66446008)(8676002)(4326008)(64756008)(186003)(76116006)(316002)(66946007)(54906003)(66476007)(66556008)(5660300002)(71200400001)(8936002)(508600001)(86362001)(6506007)(2906002)(52536014)(7416002)(7696005)(33656002)(83380400001)(14143004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rzhiD6sSItijlqoxp3L5SePCvxjavsSndSqXgmoaugzEeeMNLHwJuZv/aaPA?=
 =?us-ascii?Q?0e4S1PsdZHAcD1G/Kl0ct0N28WzXc8Ha/SziNlxpHAoZCUSSy8m8KugqHwGB?=
 =?us-ascii?Q?p8N8PhcUu7X3uOA75Fsjr60Qdrj2BNVJw0cNGp9SUKZMdo0hnL+3Zi6BnyTk?=
 =?us-ascii?Q?BeGwCvmZehHbN5w5SS0UBYqCjtVc9NPpZSlZv7/qyjmF5gDUDphlUYfYobS1?=
 =?us-ascii?Q?/pxYnWF+ri9IwNunNb+BqPweUR0ZzC5B18sRfeJM2i3xs8yd/PqzXRfGvRfa?=
 =?us-ascii?Q?5U/6G6z5wwlVoHRtKhkzFUsl43V6z1ZWS7I68YIl7YrTsZ+A49salPkt8J2B?=
 =?us-ascii?Q?ZVw3UqDwwWqgjSDm5a4f1FDH0M8oaKoLrL3Ag+ka4SEl9vqzb4l53n9bEABv?=
 =?us-ascii?Q?ETGKRR58Xyq3qpmC6KhPKsE7bmk2crJyKhURvL4zNBkKmmAnjdInTJv9JJbj?=
 =?us-ascii?Q?Dz+YmRDzhheZ5IWbxVs2+pUeshF6Cd0tZ1IiXXVeld/JzUUyoP4fEIyF9Cs0?=
 =?us-ascii?Q?Jta5BkqABIlSWbaEEA9M3OGFGzF+99Vbi6gw9cj206FA08T+SYzy3DgWw71N?=
 =?us-ascii?Q?k3Rug7VR6IE77rJ15pzYoSuJ3H9FO5Vj7LZpy1AqKEQgBigeBIlbQiTBvk4W?=
 =?us-ascii?Q?i6F5rm/sfDMYCrjgwKqeN8dJPR0Y/aqH2mKAu78nuR7hriQjG/U389h2c6nT?=
 =?us-ascii?Q?dR2CZ9BOlJ4p8CDObu+z9UYf/NeX4lyu/iup6QmGUmYP29cLxM9cfMhSS8sg?=
 =?us-ascii?Q?gY6Ie3j5VWVHBg2xb8CtLDTBp4x75qxGoynX8m32sTlx6Iyti6VGuCJcXJ5d?=
 =?us-ascii?Q?cr0vGsAG+yUkCZcxkBa2SK3+Hden7YZKnaJmHxi6SGc6+X80speSCggdBOJ6?=
 =?us-ascii?Q?0XxHD4ZHefh/fOIPuL5a/ksZVkgGy21i6spBnd2baNzf5tBPIjyogBYgEXCe?=
 =?us-ascii?Q?llmnJso5vrXWxfAAELQlVbNUGVzcElzrY1mrPsLtt2xxNi3bxSzTCWK5b8Eu?=
 =?us-ascii?Q?Oxe+saqsqxHCSZUl52O5WWsA/zvlCesRgTTq41U3+cGMs3oD4RnItNq1366V?=
 =?us-ascii?Q?UVShGndZ8DHRSnlF9aP/gRBklyCxpPBw6B8IAiFwSatU3/pPx+cUEaZsFVuF?=
 =?us-ascii?Q?Gt3+fDTVBfIOnWMZD1pDlsS7afOx1APWh+c8tu6ruTXk5FfbhHx0ZK2ypTR/?=
 =?us-ascii?Q?aYd5wQ+rZMHF3FGHdYeFXMbHb2hPYZogUe2e+uUZOekyO7X6KRPSkYNW3a/V?=
 =?us-ascii?Q?WfVKRTYkJQgcQSvkySc8gYrL8PbYaINBPnSV6pHa+0yNmL8izufFdKIdheQ7?=
 =?us-ascii?Q?PCYtCDJDbRLRNiqEQkSpyRC1S73qsudm7YxMXF6CyNORA/8nB7TpmrI6RFfc?=
 =?us-ascii?Q?0Ree9hJyXoL/8kEXPkaOyOUjFGWcbF58OCpj+4raFtac024/EyfCU1sOWNwa?=
 =?us-ascii?Q?WgSyD1076jLpQledlLPy1Dnhpu57S0ICi5iPPbYPZbiAG4yy0PYr1fd32RcG?=
 =?us-ascii?Q?Yt2VS8OawUtJ5x0iLukq8BIpMw2gSHJtevJzBzYSqQhfrNiHMCAfPBAw0ob5?=
 =?us-ascii?Q?Tmad2HjnQhHdoU+ZM888kiYT0Hw5XNx3boZdRSv4SwQLcyVHE+RRC2E/hlNN?=
 =?us-ascii?Q?ihUF394OhANYvFNkQ0u/6BAhES2kG1mNrXUSOGE6L+kyVkF8L+v85G1F6Vfk?=
 =?us-ascii?Q?RnVEWoU1z/VbIpzxDs1l0kx+np7UT+ZB8hEMvBJCPApHzCWV+9QOYHz7rt6F?=
 =?us-ascii?Q?NTw2dnXeFQ=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5865237f-91c7-4c59-5e58-08da3225c70f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 01:38:26.0573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bMLJnrEmpsSsN+nedtuaRNB6X6SOphpc6pNjsfMzhNKcXXGOACxAiCG1IVyrybPTH0wCx8GKUlA9UyXWHrWf6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4167
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yishai Hadas <yishaih@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Martins,
 Joao" <joao.m.martins@oracle.com>, David Woodhouse <dwmw2@infradead.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, May 6, 2022 7:46 PM
> 
> On Fri, May 06, 2022 at 03:51:40AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Thursday, May 5, 2022 10:08 PM
> > >
> > > On Thu, May 05, 2022 at 07:40:37AM +0000, Tian, Kevin wrote:
> > >
> > > > In concept this is an iommu property instead of a domain property.
> > >
> > > Not really, domains shouldn't be changing behaviors once they are
> > > created. If a domain supports dirty tracking and I attach a new device
> > > then it still must support dirty tracking.
> >
> > That sort of suggests that userspace should specify whether a domain
> > supports dirty tracking when it's created. But how does userspace
> > know that it should create the domain in this way in the first place?
> > live migration is triggered on demand and it may not happen in the
> > lifetime of a VM.
> 
> The best you could do is to look at the devices being plugged in at VM
> startup, and if they all support live migration then request dirty
> tracking, otherwise don't.

Yes, this is how a device capability can help.

> 
> However, tt costs nothing to have dirty tracking as long as all iommus
> support it in the system - which seems to be the normal case today.
> 
> We should just always turn it on at this point.

Then still need a way to report " all iommus support it in the system"
to userspace since many old systems don't support it at all. If we all
agree that a device capability flag would be helpful on this front (like
you also said below), probably can start building the initial skeleton
with that in mind?

> 
> > and if the user always creates domain to allow dirty tracking by default,
> > how does it know a failed attach is due to missing dirty tracking support
> > by the IOMMU and then creates another domain which disables dirty
> > tracking and retry-attach again?
> 
> The automatic logic is complicated for sure, if you had a device flag
> it would have to figure it out that way
> 

Yes. That is the model in my mind.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
