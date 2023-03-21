Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DB9D516
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 19:53:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXRw2A1vqSDFU+BAvn+D8u6jtTXaGA0u8a6fdlBv73X3J2gDtFqcUkIYSNTHMS3l9SUIm7noQD2UxxiUxb0d1T8rXWoCcBtjdPcEcRS4Vg89A4qHvtRcGTqJ3hrDG+mDtNb7A+e4zle/gwbPd//wIxXVyYT+W61m/2blwI+f9I/Di9IfqAE9Ed78YmPwsQpS9JzPs5qD6CbuQJjrWQwiKIKpBV50mqHDJ96QFEHroSBJ3jSfkgtooWKXINzo/XkHL7+TBim350ZfvmbFFJZuoo9PQvTK18OCSojreP/2PKqAaCmcYPgtlf0OYu6ZWAmwcOyUPuFKv0M1g4h3wKK9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSWxSx7pwMY4iFtfuudEDH8cg2e1zlSMoi/nephUhWo=;
 b=oWy1/ItBrrMxM8mzpFKOfoc2CQeGNtKYqHY0dAsA3hiI2Uax/5tlWYTfR1vryZiLMT27AV4Wl7E9KoCvsgfo1bMtKbZlaYGVpXxEpY9DW6Oh7lC5RhDEEZvuDVDLcIpI0z4+oxAiFqoROFxXQ4V33iY8H/BdrcPCgeG6YNZK2fZ727dfAlxqwexaB9qL2fDWNVil+YlW97AamzUc+ZGNVJjEu4rPiFKA+WF2Opdpz+H+OiO8ZhrHoHBQ3AuNroZmuZ/SeiZ5qybX36+/iGWQvAwdywwmNXl+CJ/9hxpLtKMJrDQnV78ZwjKGRqCo4rDD2ls7mPZ8znPqFhKDIrgvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSWxSx7pwMY4iFtfuudEDH8cg2e1zlSMoi/nephUhWo=;
 b=PxuOg02JVqL3PW6ZcByqpdinS9JeoQFhymQFKAK3qvPpI58R0GQkACR4qvrCwN+e2K/xscga2A4ewPEdTHcCC05CsQ1diWexM+dv+Vw5+gfp5GaXyDRAGzgAdZcc8wfJVYKgVlTO1RBcWBJmdzM0BqmLh/jHsZei5d4yYX2kBlNQXasItwKC269Lk2SdEm/5tEBRWjiXu1Wmy9M+r+Mv88mHojRrlyVwhkPYyA5+Czmhlf573tW7CMJBEej9c4XjAg9qKGkkC6i27zp5+0x1t9sHrx/t7wc+bkAeKdiCh8KWcqMJ1wfSkIwihCWH452K8gLxWwjmuhW6Cil10VbwLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:53:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:53:26 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 4/9] iommu: Replace __iommu_group_dma_first_attach() with set_domain
Date: Tue, 21 Mar 2023 16:53:16 -0300
Message-Id: <4-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c92e2e6-6781-466c-3184-08db2a45edd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TftMBDlPC8A3MyDnBVw5a4XB0Clt/7kIc+ijoCMw/Hv1hm8NanmlKf558bouaQ7AskAA43Ch3f8NmKp9OfC/AiN9uOwpCsQwRzAPyGEv75sAV2INTMYaIl/QSJCQRzASNDjLeIe0FAJeVfp9VHNQ0wXZZBviOiwYm58QT+boNsCOSCO2Z4vkyWGZ5/6EmzbZ5QGcuaAcwu76stkqNch+HoC9kY3WBmp9veZHq459sn9Ly/i83sd/lx38aAXoGieF3tqpS26Ple8sMu4dZuuy8uXC8mZlidWJHA8SlWoRcz9koZFT/80yhdvtZ8DCETS9h1hYJ4i+pfITFIAQMvW6i8XNiFeRst9BMkUsvTM8T2soak58boSbU1LJr8SyMjMrXRiBGCEON/se7Uc9pzqxgy3/KUYPOChMyAZAjzl2oYn2+dtVcD4O69NljfgtxRIrXKH52GlsbsNGWSq2J9TigqZLh/bFCuIjaLJ4WgmnJJMdpc8bq4IRlKyJqihPlC+/PX1IKKOoqdGPciZUVQzqC+3gCN9DGjqNzcreRBk8S7jIYzC8uStKQdZG0vcBK1OXQBVwwt57kJ+dk26aX+69NXV9Ls0yI13hGIopyC6p62tIxCPTc8445aXeHU8hbXJRNAZSH59CbVsauSCKLwdt4NfHou5m3JbWJ8WHotPMQxs7uqSh+RKPvDurWIBH78so
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199018)(66556008)(66476007)(66946007)(8676002)(4326008)(6486002)(2616005)(8936002)(186003)(5660300002)(2906002)(86362001)(110136005)(83380400001)(41300700001)(26005)(316002)(54906003)(6506007)(6512007)(478600001)(36756003)(38100700002)(6666004)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aIukYKLVG+MMhV8Oav5Qi8ueDgCpKVU9eNjsyVErlCivNMsDqMkyLRevEp+Q?=
 =?us-ascii?Q?kd4+dK4FlrPaNDNkNtA5e9ISwhPYmimsb2J7jUjOI2zAWzolJOvVutJcLP3p?=
 =?us-ascii?Q?m3KCrUgkr3jdoZB/x9/Z7ByWnuFUp2u/nyNbhgopthTOG/OT2YJr9ke2Lx7p?=
 =?us-ascii?Q?5hz6nRvcsnqnkNP/GP1SboPUDK04UfVJEAyRpQfKjJ+ZD63Nam8wwWnrdEHX?=
 =?us-ascii?Q?4D3whIgcVYUjZcjWFPaE40rPLTJ4s9f0kiT+DNp1PsIrLvUF+glB6GDx6I/h?=
 =?us-ascii?Q?/gbgMIZGJ2Fb8HfclD7epI357lMfWHh6K48PBaSA8lSr3ngcSuuODFphhUUL?=
 =?us-ascii?Q?OtTWy/hFeU306DC8iRyRNDgWjQRhRBLW/J3uiHPEp/+smNaMjSBIOUvGo0f+?=
 =?us-ascii?Q?CMOAMDDFjEpwmpBRQzmRHdt+kHOUaTYFLnho9YApVURDNOqVN+vLk3lGaC08?=
 =?us-ascii?Q?Edc5A1ZXWdoaYtgwTIPdxaKaHoBXXs4Az8znwqT7MZ9zl1My2p+Eh7jgJU+7?=
 =?us-ascii?Q?Y5S+Y7uRri9ufBer/dNnF7pRtML1d2mFTuGzYOJpQ8+Ls7SLBN1p8ux3B7DH?=
 =?us-ascii?Q?ZUFMfUMIdNR+FgbN8hkmNShspvLBJ/wxjcG+UxJXx4zIkJIbLnPI6fnUfpn+?=
 =?us-ascii?Q?267ZGp6ZsNWMnCtcjRBaFTgS2tMs8lK65ziUT+lWAIkTwjLS4bZdIjZrP/RO?=
 =?us-ascii?Q?Cb6WqDKDV7yiLxM09J+rXe0qgbArCp0QLueYCSEJpH6yX5tjyhWiUhgelpG9?=
 =?us-ascii?Q?RKULWlRdiBNFUBkQ3OBV1cu8aLKOjmLEp38yW3WIQkonvViiJtK0pqPmSnNs?=
 =?us-ascii?Q?BSbMz1t06WOyYhfYacO50rE1/MovbHbvjld4IMpSKuofP24v4e8qdmoV4vdo?=
 =?us-ascii?Q?7BoE6ChJLAPJ0GBQ9Pjm7h2hoVBtyGkmgrnSst30gyvrBpp5FfCCeykx+L+z?=
 =?us-ascii?Q?+mkZzoWlWZt2sh1upLFg72hPf7JDvXquxPIt1EwhQLmxjtnr46ncAd3jZF/O?=
 =?us-ascii?Q?iOMeIgjnpYit4oqUB8LGUFi6ZVtBZmE1SWqtCS0b80zRQ9PB8AehTw2w4TBF?=
 =?us-ascii?Q?lNlHClNBMjeyD8WHhZeHp8OIQnjOtMjTRy6yLt36vza3wh/doz8cKGCgOiGD?=
 =?us-ascii?Q?S9VoN+RCz50zetg3TsarK7HC5Ytt9ldDP/gEEcByK1Y3ZZASLD0YEngl5/lh?=
 =?us-ascii?Q?vHTbI22hM2rOrVBOEeAID3V6BqBP74NkvTRvytnwXVpwuIaBkOC9XrLWDJbS?=
 =?us-ascii?Q?gnS3SAq0hLGZzO8hzbQByEyY1NGwyz0OoVpcs/vxx/npA1AMK/8ZZ7WNtN1W?=
 =?us-ascii?Q?XYm5O6j7JIUBQADkBHcQQa/yNDscVWYY44OSlUtQtfn0K6avc88zmLuWDCAQ?=
 =?us-ascii?Q?UFYjk51HKPNbbIB6APpaiarMj5ilO2Pdu12uZ5culdCD+PMF+mx6dxJ8U4g7?=
 =?us-ascii?Q?H2Wm9ILky8KWXNtKftzLtWDdzFkg4geLNSuZNIWz78/+TPhGTWJnZ9lu4Wy/?=
 =?us-ascii?Q?zn2AaALBH+RE7ILGFYEVAHcglKuVUoUT3VVVqjONikAQtbb4hctktysQqmQJ?=
 =?us-ascii?Q?CB9ugxSOFxDk7Ou3OyQKadafMse6CjeLIGXj/OqF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c92e2e6-6781-466c-3184-08db2a45edd5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:53:23.6057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PahZPBaKfcNKGlHNi1UfNrftOYISkuyv0QltHH11C7P48PxoksiD6sOFGvEsQjSU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

Prepare for removing the group->domain set from
iommu_group_alloc_default_domain() by calling __iommu_group_set_domain_internal()
to set the group->domain.

Add IOMMU_SET_DOMAIN_WITH_DEFERRED to allow it to do the attach_deferred
logic.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ed4d792f4bdb68..3e4f9ab89d38ec 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -99,6 +99,7 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 
 enum {
 	IOMMU_SET_DOMAIN_MUST_SUCCEED = 1 << 0,
+	IOMMU_SET_DOMAIN_WITH_DEFERRED = 1 << 1,
 };
 
 static int __iommu_group_set_domain_internal(struct iommu_group *group,
@@ -1814,12 +1815,6 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 
 }
 
-static int __iommu_group_dma_first_attach(struct iommu_group *group)
-{
-	return __iommu_group_for_each_dev(group, group->default_domain,
-					  iommu_group_do_dma_first_attach);
-}
-
 static int iommu_group_do_probe_finalize(struct device *dev, void *data)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
@@ -1882,7 +1877,10 @@ int bus_iommu_probe(struct bus_type *bus)
 
 		iommu_group_create_direct_mappings(group);
 
-		ret = __iommu_group_dma_first_attach(group);
+		group->domain = NULL;
+		ret = __iommu_group_set_domain_internal(
+			group, group->default_domain,
+			IOMMU_SET_DOMAIN_WITH_DEFERRED);
 
 		mutex_unlock(&group->mutex);
 
@@ -2203,6 +2201,12 @@ static int __iommu_device_set_domain(struct iommu_group *group,
 {
 	int ret;
 
+	if ((flags & IOMMU_SET_DOMAIN_WITH_DEFERRED) &&
+	    iommu_is_attach_deferred(dev)) {
+		dev->iommu->attach_deferred = 1;
+		return 0;
+	}
+
 	ret = __iommu_attach_device(new_domain, dev);
 	if (ret) {
 		/*
-- 
2.40.0

