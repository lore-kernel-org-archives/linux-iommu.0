Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47D6D24;
	Thu, 30 Mar 2023 14:28:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRem06aEl/MXTDViweD8d0P6B+SEK9lJn3pF/vD3WyHbRnLki+ruj3FAqQtC1p+CZw7UPEYrqL9RYumvU+qgeDyp9ifOTraFAdHOdcedtA/2U+Rck9DR6TwAPyXtq8Xo7bIBHPcZWIxZKtCGB1OUYjCIXX2qeuJHJ2/M4mHMlFGuvP0WbmP933LMhPcSISCWD/GVD6M7slPsnGocE1EJyBpzDU+tgQAyY9XehgJLrZrhuf2/RczRHNPcUSfj0qPINj7aBzLgqCOp14c5fHcw2dV6E24ibS337+LIXbn5pdOJAR58MHwAluZsXURXMdAL4OXPmhX8jOZFGCGyUx5MFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8sGFtBJFB8FJQ9TN+r754A7VK/ftgrhKwXBosPXajw=;
 b=Yai6Qfm8F1fLHlUzsRkepzNjof0gspVHfuVIBJ2mtDvmjAxpfDa7FdLWf+jJUkCbeiPv+EpJ5vEO5hDSreWuIg2EnnjVAqof3FiAuY6JStfGR/v3r3LdpRSPJq2uJX6jr0z8lJHqu7D2fkLU2UbvoWoZZyh1jkae+AQZEIib7ms6ULkLgALgmGBkwKMpTUa7m4NYwfp0vdeX42r84bDoY9INedRfbN4XqjD7T/TVhr1pf9FyAUv3SP+Io96uAuFmW3heeznBIVjZr6PA0Kkq7X8iOvEM4RCkUGs3a4TAiZkCDGJZ02yhF9mtEYjTHk1LeM1+k0FEXU+Jo6SaRIvl9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8sGFtBJFB8FJQ9TN+r754A7VK/ftgrhKwXBosPXajw=;
 b=rM+49d+sxgjIVYQhKBDvE40nzDGrWf3R7AkBpHZiivEls6Z/jvuGi1RbOCJRCKp7V0LQB9pUUQ6j4MHJXfU+9W56C3qHuGMAloXAVdCH4A5+J7L6pnkGV72roe3HmnvUH5AUQNNOcOL5eKqJtIwVCWznqz51AMlC7eSjAdmniuRTdgEO20hD5rYqYfbAl+/zESlCQMn3oJev+EIwnxi1Eu/eTmq4dmlj8uMB0R+46QU4PGWJOWJcAP4bkrWhn3iJ7BP60vn8h06zWxjgPkj8hpgzGvxjxl1kkYZ2B7PCWioegjwsdBbxvxM9oxmyAZCHfDIi4qQcrBlBI+e0FJ/C0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 14:28:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 30 Mar 2023
 14:28:08 +0000
Date: Thu, 30 Mar 2023 11:28:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 02/14] iommu: Add for_each_group_device()
Message-ID: <ZCWcd5FkGhpYhCUi@nvidia.com>
References: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <2-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <CANiq72m4sGq10s==TPTjN4L28xgHk1dYsq+o1ves7_c6pho_pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72m4sGq10s==TPTjN4L28xgHk1dYsq+o1ves7_c6pho_pw@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0414.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: d5514ad1-2d34-4709-7f95-08db312afb7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mJA1c5W2j1lbc1U2Shurij04iofZEra1iWH7iFdoiCOjsbgLcCchbTCdNDj81Lxyq81J127rYj3KSy50j7KXYzhsOPBAB/53bhDJkYpH6udrAQUW2g9BbsKSxExcTWHe8qYFkmdr1KXY8oSVLBxXgF1hVDK/9UcQvq1lq2ePIQ5PmGToUt38Bw09h6smdgBqRExl6N0kWwuMq6stmOpwXOkNgW3Js1kneChN4lXUk98KUf1xjLy92LD9TqdfsCHfQUyL2AgGoHF70Ew75PazOIWHIUSws/WnMhw5jzYMF78UkAlCh7NN4ySaM9eY3HwctdzlArcxICE6MGgXa7eWcPVjW7s9UHPiF1Cbln1ha/Ug1qHkYKjsDXShkgIbBZiPEYgIq1h+7JYiAcH2BySaxiysxePzmPcYT8LWqAvLliQZ7eR9GZIa2ANDzLYYOjBADunMpk+WuFFwVXY3dnNU7fMgaQC6hhQ7D7pwW8gMyJqKEgQswYEzuLtdSDYTpCO1ffIvO4I1+E2TfTqiBY5IYhxmOBrNdHBGLrpR54aaMxTrTxgmf3Q++fQKJGQ58wdW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(41300700001)(186003)(4326008)(6916009)(66476007)(36756003)(66946007)(66556008)(2906002)(4744005)(83380400001)(7416002)(86362001)(38100700002)(2616005)(8676002)(8936002)(5660300002)(6486002)(6512007)(6506007)(26005)(54906003)(107886003)(478600001)(316002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFdSVXoxMmk0NVpjVFZWWkdwQ203YjZxdEwyWHNzZHZLcXdCSDlVUUwzd0p3?=
 =?utf-8?B?VTBYK0V4eHVXRElTSC9JOFhnZFgwbDRaKzNBUmI3WkREUk9hL0VBeTBmWTh4?=
 =?utf-8?B?TUM2QXJ0Y0ZadVBqdk9tTjRCRWJWV2xkQVNHUmg1T1ROcjdGRjN1VUpoMng4?=
 =?utf-8?B?OS9pQk0xS3lBSTBoNlFIU05IamJ0RkVTSlhpMFVjTHJvK2d6ZUkyUnVNd3E3?=
 =?utf-8?B?d3R0RVVpdDAxNmtnTkxnTnlPRUg2ekxiZFRoUTRQQysvcktrUVB0VTRlZ0dB?=
 =?utf-8?B?cXM3ZEtGMkxEcHB0REFnT2h1TFFNK0ZuL3FoT1JvUW41Ukg0aXNIT0l4a3hw?=
 =?utf-8?B?VVcvZ21hMDUzL2NWV08xWS9GaklkYzQwSmdkbmtFMWFaSUVRQlF6U01oSU11?=
 =?utf-8?B?TFA2OU9vSTltOUZXVm9uT3V1SlpIN1psdDJ3N2FlT2grazg5c3B5Mjc5cXd3?=
 =?utf-8?B?YzN1Ym94S2lwRm5lekh2NEdZYU9PalRHdVJMM0UrSXE3SUNsNFg0R0xRUUFE?=
 =?utf-8?B?VW9zN3hTZ3FrdGptNndIcHRNenFJK1RjSjBFRUdQT1VsMkswN0g1NmI3QW53?=
 =?utf-8?B?WVBJQU9FZThMRGFiZ2xXM3VlZkUyNzMwK0FiNEYydDAxVzlCa1pBck9lTlhD?=
 =?utf-8?B?bDBqSDdRcldCR2s2ZjJ1UEZIeWJPRDhoQ2NkTnJZM1NYUU8yS1Z6WFJGc0Zn?=
 =?utf-8?B?MFI5WUN0bWZsWENpb1o1UktuWkhsWGdXb3RkRGxaZVpwVHJSOTJlaE1YcmFB?=
 =?utf-8?B?Z1lvNGQzbmtVcG1Mb0hVeHBDbVE4dnpxYnhEcy9iRngyRzRldzI3MHNmOElB?=
 =?utf-8?B?cGllclhXWGZRNnNaQ3U1alVNYTJMdk56RVNUUlQxb1VnQmRKSVdSZU5oRnlI?=
 =?utf-8?B?NW1pR010QysxdU5Cb2xVNVZrZkx0eXFJbmlINGx2Z1JQVFVtdWlpV1FRRHp4?=
 =?utf-8?B?RVZiUzRmRi83dENDanVvN3k3NFZiaU1RNloxNjUveFNEZXA3SEpNcjBPMDA4?=
 =?utf-8?B?TkR4OFMwdzJ3S3BGc3M0bitybnNpNWNGZmNEMmJ4aFEvb3ZWOU43U3VUQlpO?=
 =?utf-8?B?M1hTQ2d3QTVheVh5dGxXN1BESDFXUHFoaEFKYk95UUpwNlpzeTBrdkZwV0xF?=
 =?utf-8?B?Sit6NjFZOXFQM3Nmd21zamJidDE0RnJuODc4aDMyTHBiY2xyUm5aYVdjYkpo?=
 =?utf-8?B?SVJ1aFc0ZmRPQy9iS2ZWMkhGZ25aU1ZoRnFvaVdja3BKN2dBYnJNL3hSbjFk?=
 =?utf-8?B?Vi83SmxaN0QxRFNKb1BKaVdIMVRnUEtqSWgrc2sySE40c2VEQ2NnQ01PSmZ1?=
 =?utf-8?B?TUkvL3poUnZxZHZRQitFVWVmQmUzcnJORGl4SFFzemZDRHFOUzBCTU1NcnBi?=
 =?utf-8?B?R2lKdi9mVS9RMno3Nkt6azgzOUxsOE9BVHdUUXdZYllXVGkzNFRHN1U1eEdJ?=
 =?utf-8?B?eXU0N1picEJtRU9nZnJpbWs3QlZVdFdCOUZhdERoVWkraVBkaElpd2lDMlBN?=
 =?utf-8?B?VkpKLzJqWm5OUnlSdWdCSW5Lb0VDejRZa3pWcDNPeVZvV3RBTjVseFVabERB?=
 =?utf-8?B?NG1PTHVENWNVdXNIR2ZVZjRGcWdNTVRxN0QzYU8rMU1kd3RKdXdSYzJZSWNV?=
 =?utf-8?B?OCttTWJVeWllN3F1eG9YTFhCaE5DemNSQ3ljeXBHWk1sa1BHWS9yZEpNWlhT?=
 =?utf-8?B?b1RNYkIrVVRWYTM4cDFyME1BeTZzSyt0ZFJveWtVREQ5bXUvUUF5dDFpWXNn?=
 =?utf-8?B?RjZQWVRLdHIzSzV5c2h0U0QzaEthSHpxOWxhZXVKcXZJcUZyWkhYb1JLYmhY?=
 =?utf-8?B?YjhsdFBQazMyTVlnQ1NZTGIwaW9BNnhlMDNBS2IrS0tpM2gzOWxSMW9qN1No?=
 =?utf-8?B?b3MvS0kwR2xld3JVbEEyUzdudWZmRGMyTE82R3hWdHJxa1lxaHVJUks1b0k1?=
 =?utf-8?B?ajA5S0NXQ0FRVU5tMGNuK3c4Z1FLem14T3lPc0Nac0RuT1U4MEVOU0Z2b0lv?=
 =?utf-8?B?NjdlT0kvZmFyZkNTNTdYcWNJUHZLNTZZMHc5UjZObW84L0YrOXNKREVQTXZU?=
 =?utf-8?B?UjRlQk8zSnM2eHQweEpWOGI2LzFCWnd4dFJOR2NxRUErYkF5NjBRM3pNVktX?=
 =?utf-8?Q?RTpqZ3L7nlK13xzVbodpGpQgx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5514ad1-2d34-4709-7f95-08db312afb7c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:28:08.3184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zi677g7QtvYoYp/0JDsPoIjrKoX1XGQd8tTurrm+BC58mcGiz6PpTMoZwoZ8hIzA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

On Thu, Mar 30, 2023 at 01:52:15AM +0200, Miguel Ojeda wrote:
> On Thu, Mar 30, 2023 at 1:40 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > diff --git a/.clang-format b/.clang-format
> > index d988e9fa9b2653..bece1995f2c159 100644
> > --- a/.clang-format
> > +++ b/.clang-format
> > @@ -254,6 +254,7 @@ ForEachMacros:
> >    - 'for_each_free_mem_range'
> >    - 'for_each_free_mem_range_reverse'
> >    - 'for_each_func_rsrc'
> > +  - 'for_each_group_device'
> 
> We currently only go through `include/` and `tools/` to generate that
> list, so this could easily get deleted on an update. But we discussed
> going through more files, or we could have some extra explicit items,
> etc.

That would be nice..

> Since you added it manually (i.e. vs. renaming some entries), does it
> mean you are already using `clang-format` for this?

Yes!

clang-format and clangd have really transformed how I'm working!

Jason
