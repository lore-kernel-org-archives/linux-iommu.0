Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392FA3D9F
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 11:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNiQt6xBtISYxRIjupEmv3WJwMX4vEL1hs+DGJlaCUsbTOyMaJl7vlFal/Zb9aPfuKnYlsPa5HnnuH1rfsSLEEHuv8E4/02hX4ZWLnHGGf4LGEi1wScVjN53vrN/aWYOwxliWvq7sq8ROXZkG1Nk/+xDJ2vX4yXM44MN3bFN9mb/OsXZN6mnNRxXy1rfQUi2tKMI6g+VGa1insvXKTGMzSMqan0YSMoQi70K+eNc5rpzbb/xE2/tuJKETt/cWlmqGOfHcGK2CCF4XfirXzHJo2WkLRdVEiaO65AxXCcuJTdz6geB9ROqjLu50ODA3H7eWYGpukFqHUSz9WDaQZG1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dPeliIMRphFUhxI9r5131uj1L81mR4FwIgciS077ko=;
 b=F5ZXzvomTXZQlfvS+BuVLQ4fP7T93jZoyIpi3X6gD7WaN0wB45jDsU6wNluF+iUYjqiKF6JNgNMnnfHFp8flntq3YMBSn9lcLMSGfDYCsqxHU4nrcmk0vYbKg2ODZIG0vKaA90VysjQDUJZ964ZPoLCC6IFv4I/2WxPKwouc3ldAST9qyTMtZxuHueoX6HOiTRH3S57lT8F+hwysXeb/fbVsga4jEQHhasQMtfQLdM9grs2S+TLKSK/rg31hotwimyQ2xcfn+OufGPmPaN4xtaI3oy/RkZSTfhV2PZ4YmjCpnHxMra4eQK+hWhfIajMkq274lqimU+n6L80vAXw7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dPeliIMRphFUhxI9r5131uj1L81mR4FwIgciS077ko=;
 b=ok7EtGlbCEozXGkYdtDCKT2eKz2vczqbLyE0OyBE8M0R23fSwzGg6EdZC8068stI2zem+dpL6lR/EW2ShO4WVBSVnYd+6M6KIdnbqsDBElFdWwSTNIMri9LTJTpQ2QhzvDOPPrFAwaN+7KhTFSD8gNtSHRMiRKm94p7qwptxSrf3Gm3HlfIDTkwOYmqFp50NUJi8bZSZ4+j8AxulAMkl01PyVF83FeX48qNh0iDpVukZ3jTntIH3RdV4ss3KXzxLHT7GRQtabkOpUD1+w2V7kNRs3Y/QZNJoMliksHDqtWgMo0CJ6BSrEssHbKdN3yJBoqeXcLHphvHOMQEvtzujzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB4881.namprd12.prod.outlook.com (2603:10b6:208:1c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 11:59:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 11:59:28 +0000
Date: Fri, 22 Sep 2023 08:59:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Hegde, Vasant" <Vasant.Hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"Huang2, Wei" <Wei.Huang2@amd.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Message-ID: <20230922115927.GI13733@nvidia.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921163154.GO13733@nvidia.com>
 <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0435.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB4881:EE_
X-MS-Office365-Filtering-Correlation-Id: e09a2044-3c69-478d-ec78-08dbbb635f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FFDUaEEfSzXN2xYJHycDsEG0Nqe3tglj+iVEAC4RAeKTI1WgdD6oXAKOTr+GqLZtkJqrcMKyFVJejRFNbc0/6ceTXMphDh9Hbt5+pD4pS+y7Vq+u52pljoSAiqNPI1mmx5bbPOEI3Ipe+TW4P6lLY3Sh5ykKaZjZSNADy7/g4GFuhULs+lFWyegPCuS4QX9DuJgs+mSNcaliBROD1pO07efiFm2Q+JzhFcZOruk4GdUVkM97Sv7/ij3Q6gDSE+Offj0ljRGFlBaH1+8pM8N01qKoj+EIsPKJMWrc6Y9FnQfzou00u8u8ZAG0Qpp7zkJp6VGtvJZxU00zMxxOtmpopOXuPjkcY0zGkTYkMKTomPwhKuaLKxgzPZo/39lWNHrwyvFN3T9mdlKvXK9V2OiSajNgjx19CbvOmdsXRP1+qMyETV6SrNeexSK05ZmB5I7PuNwg9/2MDPR2wWMFBqjRthJrS2L76TAzmwGlRg6ePxfDgOEFFVxpexGIkgbXlZArM6jJ8ZVZ3lfgsW6Sxg9VsZVrCxwZtCGuIfjLzxvm5U7EBqs/HSblbyA6yVvFMQST
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(1800799009)(186009)(451199024)(1076003)(2616005)(26005)(6506007)(6512007)(38100700002)(36756003)(86362001)(33656002)(83380400001)(66946007)(66556008)(6916009)(66476007)(54906003)(316002)(2906002)(4744005)(5660300002)(41300700001)(8676002)(4326008)(8936002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MH/LN+YT679FpseNdUFxtbpa7ZMyGQfV1GhB7V4wi5NVCw3hukTC0zqtxFQE?=
 =?us-ascii?Q?p7IEu4INnhbjcPTcbly/eHb499wuPL+3h3MRK7Sgxi+3PxKFAA8urlE+qUfr?=
 =?us-ascii?Q?sPalSRW/flRs0w9CqoQynr4O3s6loFyiAX6ACKOwvSnkn0IkEM7w4ApsNGzM?=
 =?us-ascii?Q?K7FukES1GtGTgW8uYR8aXi8D5f+w7DLc6eqwXSv/GEC+XZCmjaBTcaGeM+bw?=
 =?us-ascii?Q?zDxEw++6visuMPlTaORPx/Q3Hj9vM4awcpxcNanUHftzuTPnUP/bj0ZBWjh6?=
 =?us-ascii?Q?6gid8f3kjcySzlzehHd9u2/I+sAxvytpJZ94h3FMaxjnKdmgkvqCkbTMjuM4?=
 =?us-ascii?Q?JCRcUY/HWAy84ogqL6r2lV3etonruriiLj+aRyWR2lZTaXZSx+CMSALaCzdd?=
 =?us-ascii?Q?oeHifxw1I4Zswgr3IukZnjpbcxI6rPo5TaoJBO0yXQjmrfhxbuu9FBD0WXIW?=
 =?us-ascii?Q?UetKueksmoxTRCrFFS7m6m5Xw8wo/p1wPzLZp4JVRElmqmpCDzwkT3IGr5NU?=
 =?us-ascii?Q?HZaiIazLKqjhgZC0FqRD/DRNIVq5c0mB79B5nNb008STSoHeqwt4dL1LdSKn?=
 =?us-ascii?Q?SVzhgcVGLM6gm8nJuJgd6Sa9f9TGXWtrkQPTRwlG7ze4nnTD3WQhTNFC+vUF?=
 =?us-ascii?Q?pmQ8jzAJRdOtDtSOgibzfKos3fZwAm1ifvkb/QWh6Ih1QKOY/TU+TXg9dru0?=
 =?us-ascii?Q?jUIwrVefYvVBgmSvGbj3cgVKKOV1gK/iUxw5YXYmNiC1q696sNvqck9rLdjx?=
 =?us-ascii?Q?PVvXyUwSweZQn3R1QwA24b/pHFMczK3Tw1vVgfIl8Da4kV6Dg39brjY/CY3x?=
 =?us-ascii?Q?oQwChAAb3pnhTGlP8q2LBCcU87r6nT+6WwVq33qPZhSKwijHhs7LEjP4Y3hJ?=
 =?us-ascii?Q?bmXAhh4Hd5p7TnmFryGgsyKMzLCPIfROuGk4+Vct24R8GjsZisleHnrnJqa+?=
 =?us-ascii?Q?AWJxeWBdBuGBVfkOx1bG/uevKq8MfpbwM3ThlP9VMiDpXA/TjgVk047R7MxC?=
 =?us-ascii?Q?ZFnO862qi2x5Ks9pkvGoVEGY+ekwkWlzmckdRtHErZgMqTI6VowtXONlayi0?=
 =?us-ascii?Q?xKcal+aQ9fFv00t5DHQYSn9P89QPbRtgaS5FX7mtYNiP+G6ptryYxsaSKbw9?=
 =?us-ascii?Q?cs3cuRsQVefwWqF48lfWo/Gv1KRs/HiELwX2khqhRbx4bbjVH+jnKcd8ADi7?=
 =?us-ascii?Q?gxprsV1Glfd62A3I19ww0Vuvot6j4crY6ugiAoxF6pd5aiVSfLI4qm/IUdcY?=
 =?us-ascii?Q?oovrB5bIj0gmD2KzYboRsnxl7/iB1s1vHJP8Tp06HFCH5TVCqDdjPxnMECdQ?=
 =?us-ascii?Q?VKWM7ahpsotmv4/RoW0PnBGV6Rrt6Y9om5DWH+EySs3HAUK4BG3wnkc6IHLm?=
 =?us-ascii?Q?IczDQ/x4FNjVGIWWT6qpeCnB54sSfnwgjqVXt6YKVsEkpbELHafQHKP3MhLe?=
 =?us-ascii?Q?dkMEf+VqhBUkpfvz5XI3XJ6T8K+Bl/owzoEA8LkkxZu8Xkt6d4TcenJiG+Ij?=
 =?us-ascii?Q?I3PtCyHHfRxyoB7gdupX04Icykkl05L/3BBAwL19PuU2nmBApu29VDt2nsEz?=
 =?us-ascii?Q?2E5bLfF7p8tgE6B44terzgsQsJ9wsjk3UAbxkpNQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09a2044-3c69-478d-ec78-08dbbb635f4b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 11:59:27.9469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +b2JaZcynJ9/YIAl2WiKON1alJ95UCt/9h9jAKti1d6C8uZNGKq5emzi5qKHAIJe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4881

On Fri, Sep 22, 2023 at 10:23:26AM +0800, Baolu Lu wrote:

> 1) PCI device supports ATS but *no* PASID
>    In this case, ATS only means a TLB cache in the device, and it does
>    not make much sense to cache the 1:1 mappings in the device. Even
>    worse, the ATS translation requests could probably cause I/O
>    congestion in corner cases. Therefore, the best choice is probably to
>    disable ATS on the device.

Nope. We have important use cases where ATS must always be on. :(

You might make this argument if ACS is also non-isolating though..

Regardless I think we need to get into a position where the iommu core
is deciding if PRI or ATS is enabled for a device, not the iommu
driver.

Jason
