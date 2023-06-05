Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDC41548E;
	Mon,  5 Jun 2023 14:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgwSA+VfeX8Wtr5PDEorl+fCMgJKwF+/V2xlJ0jSfkdbggfevqfGWZyor8K8hVpP397bkSg0JFAqqJpfc4j/43f6y44B+yVz9jNu6lMtoLVKM8xBeYJ7sVztcofMao6fGgTJjQNQz3slvaZGnOHLnLZ4bF1SGy/TJwLvu8HkR6av/hRPfg4VBoeRPlemiX+iTBRH+upCV9Ez2Izydkv7tL2Bfq1Ss3rHVM3i2zzWEtxp5t2lkmTozFc3dMqojsIQ2Xiblb7lg+dc9nHhzJvxRN63PWYHCvZZgvcQyRAdt1Lp4z9Nd3GHWZf9Eg8zfeMmtGWINih7rX3SZkDR8w6onw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A41PdbeuIIiLE5XPrcHVPO9KAI/pLrYZ2vXv9twewog=;
 b=N5UI5zsuzVuS+Fa5tfnAi6M1jb1wHGjE5PCliR4D0kdUBQct8sfPy6dRIdAuvcsevDkxPikIDm0Tf6uZVAGiIqavfvjMgCr8c2jtL/+YXfX2IjnleKyyftB6scD6azn6d7yrgJpp6gajl5GNdLliXo1Wig9XAPdgYAYGxfjdZ9BwIStF/a5XTm96P+sWUl1QMvEqG+VRa1sVW2OGjxMW1gOJdywqQmGiFTlr5QIO7mR7aqlJxe46ORI19aldA4GLKTQQodq7TbLpgAR3CA5I0t5odY4A+pwED6fxKZIV1mYsOPud5yKxZlMZxy4RtX1sGns7OJ0epyCzqswTPT7AwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A41PdbeuIIiLE5XPrcHVPO9KAI/pLrYZ2vXv9twewog=;
 b=BjY3Sy4W0qJ/2v9kawzSji6sxDuxfkoH1TRcmGfCbOTaZGOMTj+gzM4Z2Q9xNd1uJr5sonHo+kXwwb5qFIYysyJD6G1HLm70n6uyn0lUs+iJbXmUJmkHp7OB9pB3EJDrZkbM0RJ+siM/nEeSNTzFg8PuCZE44gOsKKPjIhzvFXVqq7wAQWsM3B4bs/uZxMUJA5ZNkvgoxP/xohJvcGvrxBFznRUTGFAmA4BvnxX8e4evVMRNqi/f1emDFElg3n8mgmBThKuRLhig9KUAfdWMrk7B2RaavXtAxiggv4KyPn0AgMfZqyMWqZUyfTBJ1P39adtWQGA6pimtojYKIaQKuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 14:11:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.028; Mon, 5 Jun 2023
 14:11:10 +0000
Date: Mon, 5 Jun 2023 11:11:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
	Yong Wu <yong.wu@mediatek.com>, linux-mediatek@lists.infradead.org,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH v5 10/17] iommu: Do iommu_group_create_direct_mappings()
 before attach
Message-ID: <ZH3s+xnvyL9xIgiZ@nvidia.com>
References: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
 <10-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
 <20230605070959.moupivvi7wr4nibu@rcn-XPS-13-9305>
 <ZH3nXbVFR6JfUKpV@nvidia.com>
 <01dee34c-5663-22f4-0d88-90f87b1fe879@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01dee34c-5663-22f4-0d88-90f87b1fe879@arm.com>
X-ClientProxiedBy: BY5PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 887dee92-c811-42a4-0850-08db65ceb69c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JW4undzbdRZBuVYggabyJMXHPEbaiyLAdIqWOg4vVDu3bJNoMMwQTKvViiWz+4NY2ZrzruA0oznfolwWC5IcX1LtB+gpJiWM1NX7rKAq/53i6AV+ePrmF09EEN6GK1J/Px3tHOq6GOzJq+umVglUJf2r011Y+eyQvxsANdH5PxlWCyXEF+t4gBO5N3Kz/BoF5HdSWM7fv4sb5UT0Z6+fay9E0VvyHEr4X41EwVA10/B7AXydUA3LlBLIv75aiYv5Rdv98Wh+xPpEEiCDVsCxNP8LDWR7cPZNQF1HUsnycyX7AFFUUrflcKF1DGgnNH3oDJLJHXpRgWx3d8Hz7Q+YJBXFRnmtCiCe1w7J1ELvdozeinGjjknFGr05uMY+q/d1nDOmnv6Wt1zzk3Ft+K3A61Sd2NNE+j2FAFSUqk7wfsG4P0GSGVbmRtcKhSkePl977e6xs6CHiddzwasRRbAfeo4O/lrBLdDdRHmfIZcYjaD+cM5JYT3imZqm+r5e7E9dtTbfNFghkup9J179WZ9NxzbfpjAJUHIBVM4O1JPu5lVTF/Mn3v/Q35JvnvLE/ZUFFvOT+aikENCF9GLcUrH3FUBRUWxLDg2OhrdqrMoqtA4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199021)(478600001)(38100700002)(6916009)(4326008)(66946007)(36756003)(66476007)(54906003)(8936002)(8676002)(86362001)(5660300002)(7416002)(2906002)(41300700001)(316002)(66556008)(83380400001)(2616005)(66574015)(26005)(6512007)(6506007)(53546011)(186003)(6666004)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajRPd2t1N3hvdEFBR0xuUjZYS3JKNEpuVmNYTVFWNnNNam5pTk5SQVVIRzAx?=
 =?utf-8?B?TmNhc1lNazVUMG45NGtsckNoTWZWQ013KzduR3FvRmdCNDJWVm5tR3drMTFj?=
 =?utf-8?B?TEpyQ1dWWVJkNngyQWlOS0lJUHdrREI4MEx2SnJISXp6ZTQ1SWs1dS9iRnBJ?=
 =?utf-8?B?MitpaDdjSTluY1paV2QrRmVMV1dnSHJRaURYNUU3UC9EbWlXYW9zTStOeWFC?=
 =?utf-8?B?czRGT29ldEZpWGI4UzJoMkxOT2ZmdGljUmJ1ZmVoNlI5WXlQcVJEeTVmSGV2?=
 =?utf-8?B?TTVJaE1tYjVmL2s0TVgwUkpkVzN6b0RTL3FHUklxbmxweDNPanRuRTJZS0dm?=
 =?utf-8?B?QjZmMFBZeVhyQlliVkJ2SkwyRDI1Q3dhTjJVc1RSMC9rV3ErMXpraUNKRXNO?=
 =?utf-8?B?R3AxbVpvb1g4Ykdaa29EQ2phRmJ2c3JqNkhyZkZyOVl3bFd6eTAvUU5QSWM0?=
 =?utf-8?B?WnhJM3NTZlJOUHIrMWo0V3ZjSGF6U3pzOHFZVXlMSEp1aHlZSXp5RVJkN0xR?=
 =?utf-8?B?c2FhbXkrZ0tad1VTTHdxMTVLQW0yWnBEUEdQUG1uZk1ac0tHeXVuL01qTXcr?=
 =?utf-8?B?U3NoOUJzTVlRbFlmU0ZhcW1IZzZnT2tPQXh0NS9DU0VUdUh6WUtLRnNDSVVr?=
 =?utf-8?B?TnhMb3o1M05CL240UVl2aGlKZDZ2QTVJZk1PcnhnenVoYkZ4a3VFR05BQXdV?=
 =?utf-8?B?SnU1K0VkSDJDc2hTTXVwNjRQYkVSalVncVZOSWxEQlpkOVliN0pQaGVieUJ2?=
 =?utf-8?B?WlVlZllWRzdnQ01SKzFnNFU0dWk3YVUrVDkxcE4vb3NtWVlabHpXeHNmTjV4?=
 =?utf-8?B?eXhVSENqU3hzSlBnZFh0ZnozUUN4MXh6VUx5ZXBhUVZmMzIrTjROaVpBSXFs?=
 =?utf-8?B?TUR5QURyUzB5TWlNb05oVEw4aXZaUVFmTjEzZ3ZKbmN6MVFUbldDM1JpSlRR?=
 =?utf-8?B?MnFhQ0NTcVNjOEpqZ0xLeVRDQ0cyb1BYdTdSSkRsYXpQdnFEY0tHK08raENn?=
 =?utf-8?B?VDdEb3VWWDFjaGVlQURPVTVsNStvaXpMWCtjL282OGcxU3pacDdMUXRJejk2?=
 =?utf-8?B?MytuT0NNWlhnQmNPd1NITmx2SlVGUzNkVWkyWkJhbU5waHFTWnlRcG9Ra1Q0?=
 =?utf-8?B?MkgxQW9BMThSTldHTmp5cTdIS0M2S2pWZHBMRTBHUE1PQnJGblY4bVpUczVT?=
 =?utf-8?B?Rm45TzRVMEFkYk5xcWw5QUJHd1N5bDJkcXEwdkFkSFJ5d3FPSFRIQmQyUjhM?=
 =?utf-8?B?eU50S1QwcXBscGdINFhHUDZmMHFpSmo3blFPdGV1azBWYTZicjl5Zk44MmVS?=
 =?utf-8?B?bXl3KzF2UCtNVWt5Yko1VkcyS25QQ0NKbmd6aFV1TU0rTnhLbVd6bDVEcjF0?=
 =?utf-8?B?NlZtR2N4WVNPTy9pVFFBNE9BcTZTY09rdVVaSDJqbkEydHY2U1FrekxHRmFx?=
 =?utf-8?B?RnBWOVZ3NmdTVDhwTmxmenYxVE91OFp4MkgxeDFpNS9TMWRQZ1VUeEpKRisx?=
 =?utf-8?B?NXg3bGc3QWlWOEIxeEpyamRlZkpML0VWcTBaWkdnSm1qMzlYU1NTVWFaQ2U3?=
 =?utf-8?B?dktFZ1lQMmpXNUZCaFRwMS9FN2YwbWhtbCttSFRJb0pTYklQR3JFNHFCWVp2?=
 =?utf-8?B?d3hZSE05K0tpb0lmZmdQeE1BMll4dy94KzNYSXlNRENFb0RDdWFpQnFLQjI3?=
 =?utf-8?B?bjZBRGo3YXYvdWtCZTlQM1B1RFY4RUZFeE5yT2x6SlNGcVJnQ1lQZnU4TXZr?=
 =?utf-8?B?eElHaVJOSkFHWm5BTnIxWDc5OUJkRmlVV21acloxTkJzMFdSNHM5UGNmbEZV?=
 =?utf-8?B?UE42UE1WSkRRQkJHV25ldGkxWUIzSThlcUFVNWZmYkhCbElxOVdYQXdXSjZi?=
 =?utf-8?B?MzZrUXJOV0tiTDB5alVpU2Jld29pMmJnL2QrcDF2S2hsalRCNTdydWxUeVli?=
 =?utf-8?B?NFAxK1Z2MW1uVm8xTGtuaXZUYVNqa2tDeEQ0cC9MSWJqMDBkRXNueFZ4UGdu?=
 =?utf-8?B?UGg5OWlrenNzZ295T3p5SlpvcHVCWW5LNWxlN0hvL1NubnpaNWhmSzBoZlVQ?=
 =?utf-8?B?S1ArT2JKTUZGRlhUY1A5NFgzcWhaajNSYUltMU11V0d1SUdVTjNKWFE4M0Q2?=
 =?utf-8?Q?Sn2tOxM/qdwypMzObJgbeMHzy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887dee92-c811-42a4-0850-08db65ceb69c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 14:11:10.5906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2p7rGk9Z1/5DsZO65XGzdSXCanuRIbD4qIuUVi7FvrYbKG1Aw6LxpYtbnCxdf3N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571

On Mon, Jun 05, 2023 at 03:00:24PM +0100, Robin Murphy wrote:
> On 2023-06-05 14:47, Jason Gunthorpe wrote:
> > On Mon, Jun 05, 2023 at 09:09:59AM +0200, Ricardo Cañuelo wrote:
> > > [   16.267594] Call trace:
> > > [   16.267597]  mtk_iommu_flush_iotlb_all+0x18/0x70
> > > [   16.267603]  iommu_create_device_direct_mappings.part.0+0x13c/0x21c
> > > [   16.267608]  iommu_setup_default_domain+0x27c/0x430
> > > [   16.267611]  iommu_probe_device+0x7c/0x144
> > > [   16.267615]  of_iommu_configure+0x114/0x200
> > > [   16.267619]  of_dma_configure_id+0x1e0/0x3b4
> > 
> > This is definitely some problem in the mtk driver.. But I can't guess
> > what is wrong:
> > 
> > static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
> > {
> > 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> > 
> > 	if (dom->bank)
> > 		mtk_iommu_tlb_flush_all(dom->bank->parent_data);
> > }
> > 
> > We know domain != NULL since the caller checked (and de-ref'd)
> > it.
> > 
> > dom->bank should either be NULL (if pre-finalize) or a devm tracked
> > pointer.
> > 
> > parent_data is always valid if bank is valid.
> > 
> > So I'm at a loss.. Can you debug a bit more and find out where mtk is
> > crashing?
> 
> The log says it's next-20230530 - the fix you're seeing there from commit
> b3fc95709c54 landed 2 days later :)

Ah, I was looking at Joerg's tree, mystery solved then :)

Thanks,
Jason
