Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60933D9F
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 12:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIQCxtJEztoA/Q0riJFxJdKRYSKAMtZcBuwJhOZsCvMLjC9fV+qgX4bVBXouBhgx1TjZvwWPCX6O7rcpQXiJIHqjsuzb+iDDnWXrfmUJKE/tjt8ZRCtjjbE8sAG9d58EByc0+/8xFdsZRCd06fu2NADHOtXUcS48iHBHebsShl1vBS5YCbDrEVG+h2SzkxSdExMhHKFYDp/Hpjg000SGgOMi+bdl/30OJ0MqNo+W8+wHpeuQfKn5Ecv55WGfJ0epaHKmDb0jVYIhFgFTvbSr9kq+/FpNkJdhQtVt6Hsz/IpNZLoYCDAtH0jR+l+NTnTwCYq64x3Yb1grQxT0HZUXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoB7JuWRMoxgUbnFLkk+XvvgzfKtKGbtcdDUpKs/jek=;
 b=S0EE3xEGXQc8PrhIQyvj5YujlsUFVtwQB6Pazi5AMNx6tKsZV+JZx5VTwWtDxwZUtra+n/tg3PRlmYikoKfhYpP1ylb3hl1V9yV8PJAclR9bulwnAtt7/iVvFe3e9ihaH/dmuXkwUuu8v5O+b2hwgr+8J3zZxzWWhlyvnODAoGkSj/rDNtaq1ajQDR0zDkvq03DrFur78lASZXQK7BTPNP4aCLkgNGQEuxIwLmWrEroQ1aWjlFPsnB2yrRt1O+li6wzTWLRQw2tjMM33uuMXmtBo2DkuKSLdv3ERtqTeUVF1Gmcsuy8fv22XQ8EqEfGQPYx1NOVQfM8S9RoT+mtqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoB7JuWRMoxgUbnFLkk+XvvgzfKtKGbtcdDUpKs/jek=;
 b=mbEpS8zXfoR5SeSlvw6qivVTLHXunq1p7lW11kyBLeLhukOx4lxgn7sLAzUmBgLm8zvox5myrVxLn2ocpObY119Gkua2TMisFaxQDEdAZepnYHpY/HDXqEQBjrX+x7PzdQ5Ukc3839O9WNiPgxnGPOaSgj0/9bHZP0t4kHPc8NIcXssrRYwv5bUKyTSJYHBz+qB1zeZen9OvMsjU+XE/SSBMqdkuHt0iYpXJh5GRBmVA9HZGJFb1sTfCzVaHx27QHK/NrMswSHT2F9HbPBb8mk1AWRsl0xLfQm4PSmf7mXciuw2ox5XE1dpRtbaEC2Z5qlZmlVmlfkSuOHBNdqOWMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB4881.namprd12.prod.outlook.com (2603:10b6:208:1c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 12:00:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 12:00:03 +0000
Date: Fri, 22 Sep 2023 09:00:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"Huang2, Wei" <Wei.Huang2@amd.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Message-ID: <20230922120002.GJ13733@nvidia.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921163154.GO13733@nvidia.com>
 <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
 <f738e94d-1c1f-94e1-c4e3-752671af3c90@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f738e94d-1c1f-94e1-c4e3-752671af3c90@amd.com>
X-ClientProxiedBy: MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB4881:EE_
X-MS-Office365-Filtering-Correlation-Id: aea1c7fa-05e3-4aef-5e30-08dbbb6374af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Uoo6E5/lgKtr7EMOieuxdB6X8KONKUsEuoHieyl+p1kC/XavFANYQDimRloIym+l+0SH3C4Cdhgj+UjfEDGDnc/V7CxDlus9gwVhYynOhiVhvllIX2Koey0FJRPzipaHtYeOlms6COkfu7OefFpBhFoEMmjlDRTLfHZplzZkowZwmAByJYEboa1CDmuoGDXXueiZhEKgu17gUKh0qZoRbN7FrR+hOCxDZEZnX8/dXVoEVBlTnz+JmVsGXahTSKZjdUTAe9rlqCuoVPkiGEz21bGNVBILq67kQtDGmI72OpzckFkr01tnSA01XY6+8LLSUNaIO8lj05ULN87u1JP2Kq87VYdHMZL4BA1uwG4GM2oUqSGZ7Sw8Yza3CPPN8Ni4kPacQx/YUTcCBiiDhmgWnCrDTID19Oues3kEhA/HmL9d4p5OETOi7GXkY/VjBF+gYfLPx+lbLdlaPr0aGFLJmfCVruu3dczNR163q+TEBtn68iAJq0cyFsBsR9bCDNkjYWy8bQEqLa2hj7Z2vHIdGd3izZKuW5UfbYYWO1KzFcso/4oVPtpJ9xHsOxVQ2HIx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(1800799009)(186009)(451199024)(1076003)(2616005)(26005)(6506007)(6512007)(38100700002)(36756003)(86362001)(33656002)(66946007)(66556008)(6916009)(66476007)(54906003)(316002)(2906002)(4744005)(5660300002)(41300700001)(8676002)(4326008)(8936002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXVkRWlyODFTWUNpOHZJYTRMck5qK25tK3hvcjZtZEVDbG1mVmZqTk84SU95?=
 =?utf-8?B?dnpoWjB6aFFVaUlCTXJ2dEpUdjZzWkVydkRwWHk4Y0xUeUJYN3MxdnBIR3pL?=
 =?utf-8?B?YklWL2tQWElUeUFJU3JMcjY3U2U1R2dwS1o0RXJRbE13dGdIeE1IZnZKZHRv?=
 =?utf-8?B?MHo3U0pJK0U2cnlTK2M4L2Znc3pYN3hOUUZFb2M3bUhrN3ZCUDl1U1kyR2Zp?=
 =?utf-8?B?V1dJMWxMeWNOaGpTWkZWSzAwZkM2dE5NdDRGUk05YnR2ZG8rNURGRVVvZW9J?=
 =?utf-8?B?L0VyMXM3ZHNQMExPTWwvZTl0cjRtSUQ0N1AvL0hZM2Uxb2lJaEtOdEdsSzMz?=
 =?utf-8?B?NGpZaUxDZUJMUFdIWkZ1ZmN5SEYrdmt6TFUydTdkMStsN2ZyektlK3FzM3A4?=
 =?utf-8?B?UXU2dFlLL1JZUUJaWjlmMU1pcTk0WHFka1ovOWw0ZHR2c2h4QkhFMDhqWEor?=
 =?utf-8?B?WnFKN2RQNGJ4MzRyZVVNMlNEcHVpU2NTUVEybXJybE5sZjBTUGZaaWgwRVQ4?=
 =?utf-8?B?Q1FialFyK0lVNHRrMHdQdktCSTltT056NFU2WFZiN2IwS2NwMkpROWRHVmZY?=
 =?utf-8?B?cWVod3J1OHRrOUJEd1Q4bmMyRWFsOE51aDlHR3J4QXVWakE3ZVV6d2xHUkVl?=
 =?utf-8?B?Q2k3M01YK2xtT2JhamF5emxLSXdKWldxNUN3Q3hyTkFPemdJTkhDc1ovaDE0?=
 =?utf-8?B?RC9NTThaT3lFaUh2cnRSZkh0aU5VSWo5NWc4aHlMeXd4NWp6Z3BDOThVUHNk?=
 =?utf-8?B?N3hqTDBHRExxSnp3OHUxbU0yUVRVdkQxSk1rMlpVTzJXN3ZuTVNQMElZVW9M?=
 =?utf-8?B?eGxiVDVLSGRQczYxVHZieEF4Zm5ZYVoreXRrd2VyaGg2aW9abkJ6dElIOERD?=
 =?utf-8?B?bmtSRkdNcGJwaU95cVhCWVBsQ2VhaEVwRkw1QVVuVmk2ekw1TFBBT2RtSzZm?=
 =?utf-8?B?WXdIZkJwcUxlM2xGK0dudG5PcmhCcnVZK080N3ljblhIMWh2TnNiNmZWOVBZ?=
 =?utf-8?B?bjhITHl4Z0I3WG1LUEJSVVI0N1dzeDlPZTRxdGxra3hkMk1kK1VCMFE2YTYx?=
 =?utf-8?B?MGJ2SWdhVisvRURBWjYzeDdLTkxtMGM4a0dtaVlSZHhuQzFudFpEQzFVTTFi?=
 =?utf-8?B?MTFaWE1VRzM3YnpMMW1IK3VTU1hOMkVUTTFRN1N3VHdsM1ZHRFhCZEpYQ1VN?=
 =?utf-8?B?N0hya2N1Y2dIanBiejlHSkhlY25xUUgxK1d5cUpOLzEyMWxVWVdPNDY3SjBu?=
 =?utf-8?B?TUNtQ2hpNTlHZll5RkhxUC9CK2Q5c2krcGhUK1oyNkZhVXJHMTlaSTZQOGxn?=
 =?utf-8?B?VVF1OXpTVTc0RHphYWVleTVFbWZJYmlhSnJKR29hTG5DM1dHbkpFa1M0QWo1?=
 =?utf-8?B?azhYM09wakt2T2xVZjVGZTBjSXVxR2dROVYvSGRMR2JvOWFtZUNDcytONnpE?=
 =?utf-8?B?ZDdnblE3V1hmQ0xZWGhVcGZEdlpKa3RHWCt4eHFJeWZGZ1NvdEwwb0JLcEtS?=
 =?utf-8?B?R3JNWVBwRTZjdVRldEtlVHZDTUEzUTN1SGxpNFJqT3RXVTd0UEZ4eFJEeWdw?=
 =?utf-8?B?WmhVSjhOR0t5OE9xcHc5QWpjenUrN2FCMGZWTkNvT2NWeFU4SVNuVnJyWVBq?=
 =?utf-8?B?ZnVnU01zRUI0WFlWUEdRZE9Mc1lOQkh6d3lSOTFOWVM4dGR3bHlkYVY0dnNa?=
 =?utf-8?B?bXk1eXBKb0h0M1d0UDlwT2lYSExxelNybC9vejNNdDdSYVNGaWQ2QkN2eVZN?=
 =?utf-8?B?ODBDNkY5aVgrTWs2NzhaWnRCcGVobEVucFdpaEFtYi85WGtYckFHckVuczdo?=
 =?utf-8?B?M0hkcTZ2dUx3MEM3ODRDU3BNWmRrZ0ZPZ3BHRmIxQzV6bzV6bkRsdzFlR2Z0?=
 =?utf-8?B?cmlhaWNGWlM1TWJBV0h5UXpFcFN3QUJ4S0dMd2srSzNyb0FSVmQzSm8vaVJl?=
 =?utf-8?B?ZXZrbDBPT3BZNkg1eXdJSFN2ZjFRb0t1YmhzZmxPdW9lOUljVW1kUGgxWm5h?=
 =?utf-8?B?KzU1bWVKSHVLZ3FBdmNSQmo1Njd1ZXN6anNiSU0rNGVud2g5Z2dhRUJCZUp3?=
 =?utf-8?B?OUE1VnJzcG5wVmxqeUVwdmx1SmdLeFBFdkpVQjhqU3M2Qkxscm1EOEdFem50?=
 =?utf-8?Q?H7ZJdEEzPXCvUyFBwdv6mlRxA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea1c7fa-05e3-4aef-5e30-08dbbb6374af
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 12:00:03.7846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R55uLsnI6nLQZv64T/EkBtmJH1Dy4iWUu7kA9ltWmpW6vhQQjV5WV8mlQL4JKj45
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4881

On Fri, Sep 22, 2023 at 02:22:11PM +0530, Vasant Hegde wrote:
> > 2) PCI device supports ATS and PASID
> >    In this case, ATS is required for PRI, so we should enable it even if
> >    the default domain has been configured to PASSTHROUGH mode.
> 
> IMO we should enable ATS along with enable_feature(PRI).

Definately not. ATS is valuable and importnat without PRI.

Jason
