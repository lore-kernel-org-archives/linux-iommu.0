Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CA7C8F9
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 12:36:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c19KtpDKvA1Zqf6CdFcqtr3G33lzCAgfWd7fp9AFyqvufijU61OBGJxTo2Nj9d+1yBBMf91bxTHzzpdmZdLQnTfl0jNwJ8C4hCVRaTYDgflIvwvfUYuM0hVGJ6P2fq92OzPsi3ndonTweSBqLJnGcQEGYl6EuUavZFhF//8o5agyV8+VRDiVnRPSqbaq1V028KnsmTtdPzHAZwiI6vstV2tTxcJHFqC4p5d6zJwC2Xi7bOCzIuFc7AE9VmpYHQ+kPYXdGjbrppE/Re7VjmOtemFP5Ru4RoKuLD2USdH5u1Cbvfkxei3QIHVBkJchcixkGhEbgMaJ+rzGwNWMU4f7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQ5XfntSVRpKEVI2mm8RC1ZxDo/dur00k2IVoLm/xBo=;
 b=ViKZiuXbxctE4kSwvFeIKseFK9xCwWqXA3Gxvuj0RKZyKDbZbsgdKo8D7f04o+ayDNBhnVU4iH26YRNq8h5TvgCAGW30orPIwv7DUbqDLRASZ/bZ7wNrHcP8JlPJQlSuS5d5488GCNdZdvH+1/P9Ymt21WxQpukXhd77k3oZk/3inntebkdTKsg85yi67Oe2H2jXYpgutlDe2acgA4nWM7DJgjaGsUahp6eD40vodiFZvDsD4c+KvVq/PoJkcl/5Lb56AKH5ozeWJPB2ZnmvZD45qbbMFC8MGduV+hQtKisotD050C5nCmCAWU0A11uS0XUIYawnmIMD1O3BB6Uw2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQ5XfntSVRpKEVI2mm8RC1ZxDo/dur00k2IVoLm/xBo=;
 b=GntA1CC1VEBckQ6ytWATMabuH1hGbWlVabYvh1EkLy+GuHR57nAJP5P2x7ydITMTx5Oy5WNfzf25QXkqBTM8KJDI6U8enGbFxn4bwZj/Bc93K+hbkm/EToKRXrIKKM+Nm+WLMIPLpb17jqJ3VZpsaS4Hf7InqVhYKGlikESeq+FiIFYwCtxyDInn34S+P050ziy04n0DQrLOcOHCtjiK4VcRp4xVFgMKsbn4VzQl2Cmwe0KpCh3VXR0vIKq8p3XNg3880SpcKbL1TFqATUPGb8kCpUxx8b5VsQKVUqME/O1RMU9V0AlnS7O92frtUQjRQyUlyGSCmuX8MAX8Ln/3QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 12:36:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Tue, 20 Jun 2023
 12:36:08 +0000
Date: Tue, 20 Jun 2023 09:36:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	"syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com" <syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com>,
	"syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com" <syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH rc 1/2] iommufd: Do not access the area pointer after
 unlocking
Message-ID: <ZJGdNhEd+A0qmA1Z@nvidia.com>
References: <0-v1-9f7c19e02561+31-iommufd_syz2_jgg@nvidia.com>
 <1-v1-9f7c19e02561+31-iommufd_syz2_jgg@nvidia.com>
 <ZJEuK3Tw6NnuA/Oi@Asurada-Nvidia>
 <BN9PR11MB52768CF5BF9526D06C7149DE8C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768CF5BF9526D06C7149DE8C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BY3PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:217::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 85bf50a7-1b15-4501-c051-08db718aec07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	viwdRDoZQcEwiU4Apds0BUf37WjqA3u6SMTkC7P0KR8rI7IEyFlsMNVojs/6Rb5vh7dSZsF180leOuDuvWhvP6ox/luJK4goKEVXHzHSe6gLPFlt9uNPZIfwuqD9VvcCnJhXx/rbqbw2lgPa7Kz/8Zqhpm9Rkh/EAZydzTjMBBr6/QbrTfypsplz0yteJrYOcUg98AKtrK8R02c/nMhRu+Ml0gnCGGbj12zp8kuUNmd29Qgc5sHfk2stwf1D28KefV4fcFBFXCqEzJxw0kldiee66Cw1yiXuKq9BmYBQcFnVW8nvK7agMMD13L4SXe2j3e5ZxnKjV8pYz+IlbELUQ0bxdDkJG+QlBTUgQCAkkG8DNiR44zKmZ73rZpRicZHor2F+1rTcywZIGh6M2c0Vd+2pWhNEZj5WdzInOiQSPRxdQQgZ8KzgQBDE4MLmX3o+kLUzSdIhLxFnrcA1OrZELJDPW1ber/7Hu1cr9SujM3fB2kFaYbuwoWV6VnNEnyYPT6aYEDS6COT3FngzjENqvIXsxgLTnKtVrVXcUp0XdNDSNqXJi/Mh+NimGx2LYRdpKAakWQ4GCjTCsIc0LL819DFkBDb1X6Nha7bw8Hzd2eI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(2616005)(26005)(83380400001)(6506007)(6512007)(54906003)(478600001)(6486002)(36756003)(41300700001)(316002)(66556008)(38100700002)(86362001)(66946007)(6916009)(66476007)(4326008)(4744005)(2906002)(8676002)(8936002)(186003)(5660300002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lAfCmgO17sYgBw2AQiVsfE9rI88BTZbIxfEmw5dytQhX7Qv7CNKRBCBKxaM2?=
 =?us-ascii?Q?DtFMlXdGyPo32eri7kao8ah++GgCRIsnULxWF2q8p9YWvP9xXKbz67otm+gl?=
 =?us-ascii?Q?1xsWdyzuVc1tGLntYjQ0fm/Nj7PlYRrmVgY5dmDvQY+HZnAsLmg3LHPjrWrO?=
 =?us-ascii?Q?a5RRKaUw4Pu6vrO4rgd3Yt2B3hjILVGokSr9A8UYRBy4Zr5mhNs8PpJc7Pk3?=
 =?us-ascii?Q?/zWpRg2JY1noPA8TvypZCQBO1WK4XOVDkPkzMvElqKajOFzZGXhdkF3qieQz?=
 =?us-ascii?Q?8Bxdl96gWTo/IFwFQXtvHT9QRlIsexd+rlz4O7eodmGbBgWxGtywwzlhhNpS?=
 =?us-ascii?Q?6wXSgNgN53k/xgZg0LJioKAHn1g3g8/zsg3TKAVeIwAX5bP1HEkKjpjgQQOB?=
 =?us-ascii?Q?Xr7t/jrk1RtBGU/zqs/0tcp3Mzh/PX3SLm896QJdUneeB/V0WtHXNyqnE4nQ?=
 =?us-ascii?Q?00SYUzcPuV0Ob6BLlWjUkBz4nAByTYZ+syDR+vwjnRHbKsDam4Bb9LD4g7Oh?=
 =?us-ascii?Q?aVsqor9sdi6YDzIojPRVOgXkiMtz7VT+PLlHqkOw35k2bH1iBJfPFkhPsSum?=
 =?us-ascii?Q?9vTMHnxvCVfjnV5Iou4GONXK523aZV7d1ON6BLgNaTf8ZRQy5s8lv9oGNVec?=
 =?us-ascii?Q?FZHDkLzhPtLRrZdfQpgVY6/h42rYvJBz0iRc+3W/8orc3aPc04SHRKdF25dB?=
 =?us-ascii?Q?f+T1xKFw2RqiD2PV/Nl+NgWHHoAHrY5G+9RYlGUusU3ZSy1O7tfjeO+bWhQm?=
 =?us-ascii?Q?GZHM1/tp/Wa+85+Fa5F62/cMagLFvvbXHxwy2YpwCC7nwXhaqoKXPzU+Y9/D?=
 =?us-ascii?Q?o52R5sHFgkserneGxpd3fUu4ucSm8rr5wtrAr78m/RtGVtFNVo7FbJ8CWyYC?=
 =?us-ascii?Q?t6rAA5cfJJYxbqEB+DeIindiEK4+i9ar+WEzmO96oqpbbBYbiIJ68IddiOos?=
 =?us-ascii?Q?4QKUZiNSVpzT9XbOvgU8DaFXf/50i4UbYWGoOasyOV6M15VEP7Q/VdTX/aQQ?=
 =?us-ascii?Q?mFELPLzvELbCQiUsM/zUk6VAbeKpII8NggpaAUTeOjU3caCA4FIJcYKbMXjR?=
 =?us-ascii?Q?lko2YsLOFYUqMgoiOXWFbFoBJ0Zt5AFasfqgbquw9MMBBllTe/qsbMnmZ6Wv?=
 =?us-ascii?Q?JoVN47MgNSnBUsidqBImpMa7evDPeHWa4JMZzYjeg45sXG6Ju7cKIeD+NtzS?=
 =?us-ascii?Q?PjLjZ7nsNwdqBCUhrg2D7HlfXNETKugxxY4N4RXOftbZoKfOqjZFaTHpyse5?=
 =?us-ascii?Q?h6I1T0uhAAN8zSEh3d3UMyRnpJinlmviu5/Y+upDy3GCgwQ3LlaHkArlIs7M?=
 =?us-ascii?Q?3l3yt9aSVy6yiu/Akd2j8SiOExsGgTy0M+G8Cc37n1J079+GfN/kSdIJmuHR?=
 =?us-ascii?Q?+lUQ6nwmgqyw4QKJAwJKJj23AP0NCHCQEVi/SNpxnxbilx85C6xDMGnCjd0C?=
 =?us-ascii?Q?Zq8+HjJPiTiB7j85JbUBytbbfs4wgFC6XeTXHYHHfGlmcnKm2pEoqH7DhTDf?=
 =?us-ascii?Q?dVAKdM3ikKrPTW0mCnALfolJB7/UGTDtJiAGLG4VUrMOragxpc/l7mau5yUE?=
 =?us-ascii?Q?Ttcyv0YFPsyO/eiCO4fH6RHTsZFxv6pYHCc0Ul+M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bf50a7-1b15-4501-c051-08db718aec07
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 12:36:08.3455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2nOABk1Wbv0xKd3GB/XFUCnyjs8j//0GKXdsNE+uoOn7rNbL6Qj/HOAkl4eHesQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418

On Tue, Jun 20, 2023 at 05:30:39AM +0000, Tian, Kevin wrote:

> this looks incorrect. If the unmapped range covers more than 1000 areas
> and each area is attached by an access, this logic implies that an error will
> be returned after the first 1000 areas are unmapped.

Yes, that makes sense
 
> IMHO here we want to record the last notified area and compare it in
> retry, e.g.:
> 
> 	struct iopt_area *last_notify_area = NULL;

We can't use the area pointer, but we can keep track of the IOVA and
reset tries as it progresses.

Thanks,
Jason
