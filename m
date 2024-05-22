Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C9249F9
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396506; cv=fail; b=gO6/IDMd07+O3tm+8imJL0sEtp8kwik3ItDSWMIrD9LMFB+a5ZHZs7LJEqNfoDqjQRIUF92s+W/SkhYeBX30miNt7Xvrpx+TSThUfm8EOv8QSP8R2BPfW0v27l2G6zt6Kgcd1Q5NgyUf8CqYws89iy0qaseZa7ZdQ0VSrp5LcY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396506; c=relaxed/simple;
	bh=EU49AnnWVn8BVyO7/8tqKNhu/JjtyqQWPIZxUXXQANc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a8HFSfTQrarBn7eSg4HYR8eGK/oFrxDbtfFLhTAn7ARIzjVLwWqtRhXkekK6ju153x9C30MyUjbE/i/M8GNCKeBbj9Ljd42ypztGN5HYuCv7FmkXTfq2YIo4rZWPSEgbp5/rPkCHuHC1/FQVXSHvkDLOStNR2nD/j3AniqiYeG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Anvz1tSK; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Anvz1tSK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNMbztvMedKgJmv4puPY8qdQTcj/3PjM48u+2egatdLiMUL6QN/HTVoRcpginMHstZpJigk5dnuXzhOI5gyiDe/P87vX3ZMBCKWo8sWRg1nnVer5jbGMg5R67QoCGV15UsP2yKT4V+tdjXRBMUkdp/behWXLFID0Fh4sQXc0TNj1zWQRvRYo/DasGuveeXJONH3GSxLAPONTEaep6/OfLgReFqeAwZcCKjqczoibxoBcbZEQPmn+tQFaN8hJIirjnVYuzKiPU8+dwc3exMVF3jMzmmfDA9TrhoipsPF+FOSx7SkFQJfNN3exKltV8v3K5//S23srbD/EbLMpptZr+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjYxnXO92hKV5ulLAd5n7xBXvqpCXtz3bzbEpH+N4Bo=;
 b=fnp8UHufAgdQYJzepXAzORKTU/0R9mr1hgtnCemG53JvhF4AqgW8pIoXG4C9ijlE6XJ3fB/ej/ND0NmKUgUvRSH0CVgFnnvVdh4Wk3Os9nAd2ZmlWl/nsUNUpIw6rOuqrOZ+1eb38qrgxgvajU54SLlLA/ff5HwUDdznzVETVOUsc6trUrWLkgLMAMqxhrZRKyarIrQlX0RlPIuehxsJ+ldIMMCcGEJX7tQGennBXuPQQO6YpFt/wjWpBecUnejb/6KLUN8kzxYyPBSbAPYdVoRIubj8Qeb2UCWWymSuv+Sr906h+oVIUL75rXq/9DlgrglSQPaUdvIic8T8DMmQ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjYxnXO92hKV5ulLAd5n7xBXvqpCXtz3bzbEpH+N4Bo=;
 b=Anvz1tSKOFPktAPsHHumt38zN3P6HPTUxZGtxYIFm+7wsK0bmUE7drGTXBqm4QHoOIt9MYH84Bod7o+dBE9AkkZiccq+z7KfBzsj/HM+zFtOEUf+xIvGs3MaZ3fcMO9G2706NZMF0BZOFdvuFGhlDdkG9gfAlSZfb12POls3jL2ovp8yYxYWjDO8hqfmmE7YVMw81+tDKBf99rI/BSXoMz1NAGZHK9bX2cvC2aDs0t3rMUvX2ABPSNX6Vvh+RyidZC00yJ8GL1+o2r//OcHh5Rb6fse0WZRPH9QMJlWTrnp+/qjxx7a9EtB93MHKhC5VD6I7Ae6RZzmJBZeE+tKtvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 16:48:20 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 16:48:20 +0000
Date: Wed, 22 May 2024 13:48:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 00/14] Add Tegra241 (Grace) CMDQV Support (part 2/2)
Message-ID: <20240522164818.GB20229@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB527641C15DD88FB0C44323D08CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527641C15DD88FB0C44323D08CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0386.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::31) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b87ef55-fc5c-4afe-ab45-08dc7a7efcde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rjUsYkWTZ4y/OdKyYV7TIWHwHjOVmyOrfUWcNKZ0vRsO8/rWOysWcyqpzZYU?=
 =?us-ascii?Q?K5jYl/BNpp9VeZT3DN3aejwDnwNvlbqCQcmxrogQMdEB2bqfP4mKfvFtHvmE?=
 =?us-ascii?Q?RPuOBnntw/nXhxxMWiKJV1ap9+yQ65rRDn8Ei7+fwY79S/a73ekcc1ZwW96a?=
 =?us-ascii?Q?7+LBi+6yWNQKUbFQDE249i7QSviP8qoAHd7WZNaLZKYv+qpK9XKEhrDc3v/y?=
 =?us-ascii?Q?ZFQiS+sVoXD/5wBl5gwiJSVbSqDIljjkWjoQMVZ1ntw3ob855guo4WKrfPKD?=
 =?us-ascii?Q?NsxdzubPF0FmmVTMspC6Ape/zfCYPxJ0TLbzVMqFfr/mG6qqbNR9oAFZ7b1D?=
 =?us-ascii?Q?fNThKk7WpRzVZDzxQXM9KGBsNtutHvlf1Cu7FmGMcxlYoVLrD+FD0te0HVvs?=
 =?us-ascii?Q?cwNrLsy2hEy9kd+RtnbdaY2ShBzEDbmEfxFfngMwl+MR+/d2IxE05cdRXhTB?=
 =?us-ascii?Q?7ZWx8ClQ16aQ3TDMfl3f7QoRG14PHJvcgvt4//5CzJXl4Ctoq560PjOQqmsf?=
 =?us-ascii?Q?eyxUb4Gd8s9GgRx+2O96Mm3dNZEVqad9/O6im8fzOOKTAbNCQ5Xs9KdkbI5P?=
 =?us-ascii?Q?qNF2Qi/foh2JeWiO4KzUvYtQTFmdIBVpAwhBSnlcmdvjmqGgIQZdFUMkwnFs?=
 =?us-ascii?Q?KpeGQuPJJGQwXx/t3kGml2zF/oRYZBeFLGED7WcjyIrYURXHwm2RLk3mlnQa?=
 =?us-ascii?Q?k3+LuLkQgGH8w/VTIlI4MNlawoymjEaOgufpx0tyL6H2PdcaUvZeLAN1dOR/?=
 =?us-ascii?Q?GhALodanzEbxPeTvBC0XnlznFRLnmHUcvH1wf+mf8WdNglpUpF9rm4L+tYzs?=
 =?us-ascii?Q?KuWP4aGJy9iZTI1JgfaYOpOj/YjRC8UwaKi5CJOBcII9KScJ1mwTHqdEnl00?=
 =?us-ascii?Q?0EewD2m3vsv+yPysgsUO6tt0f3+ldxnm66fEktASmmjUjuiQB5vtsWhcxcqw?=
 =?us-ascii?Q?bu7xLuxDrnCDZkVcFUaI+dCMbAQUs/ThZgdpTQ14ISIXqWIPKplvGbMni/RR?=
 =?us-ascii?Q?9nkxmzG80tNAyR8zKSJ012SB4B3vdBrW9CdOM9BBZkYRYC3hBKRFSt0Ck8aS?=
 =?us-ascii?Q?eNTWaLAoMXzdxcHmbLiZ/NXYwrpHPdaJEvONWTU0qFnnzvDsNQZ8aj4ygbH8?=
 =?us-ascii?Q?tRPG+I+WkQS0pz4DI0tFAKysifKlil9NPa57/eSZUUB9P0yHareanCl8JRtH?=
 =?us-ascii?Q?FygUdKyluo7JSdA5RMW3+tmHT0f5FKPP1D7SDEP+pQCh6s6yP/Z9WnrLXFx+?=
 =?us-ascii?Q?U/msBKsHBYcHRmj6Qj9NYUq+EmundkHvzJA8oee6zQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xpmic/1U6haKO26vPmwLJFgbnsxdG+dt247By8h2KPOgfimlr1Kkz0Q69Vk1?=
 =?us-ascii?Q?7r22YK4nzrqjMMTIZENBf53xCMTS0a45wuVmmQEoKAGjvpOGtXOgvZG+milO?=
 =?us-ascii?Q?5idUfqCzETYUaYcpYTE7SKSVgzG5ggXr3zsmh4B17KWfbVKVSVb6HEaSq3l3?=
 =?us-ascii?Q?hWtXnNI22+ggbChZ37kbgQS3Y4su19J4NvoVuvBQptbQvjLtqKIUDxYA/sln?=
 =?us-ascii?Q?sD67GwRSSvKmafGbTIy5py10LJTQfH8yytPanAI6hIDs2hr6isx0Fu1WO1vw?=
 =?us-ascii?Q?BD0J+5qPJjKC0kdRYVphiqpzgguKuXBKISoL0rb5SkhMKewZuw/f55DrWZaV?=
 =?us-ascii?Q?dsOTeRSplBCsMf9ovIHpCDVaqUfljmg1f7RdEP16tmxAKY5A3K415lCigyl/?=
 =?us-ascii?Q?K/WIPOuHVvk7HqoJMUuJugeGOg6mDXOhpz+mG+rwo9YEYuygng0ygSgtwDVL?=
 =?us-ascii?Q?8RUzwdeasHILopNjnD6UnW5qIwXzPft9b0+Vsqi4PZduqhfj+2ZIU+cenC5R?=
 =?us-ascii?Q?RAvZ4KvACd9PbpvR7BYSff9mLl2bStc4cNCmj/t/knbjhF+Bj4SydoSSERux?=
 =?us-ascii?Q?TA4IXpfkXyb/1c6MI8e60++ycRHAbn02/Ovjnza+FGBogilUhgyRDfsWDQ5+?=
 =?us-ascii?Q?k64gaJCT9NUbPCfoCmQmnTo2dVw3UMXPUNO5UHiKHzds8NOQP0lmlGdj2Pfp?=
 =?us-ascii?Q?4pcvnsovz9Ypy+qb9ehG39v7H5vdfu06Ikcwaz6+zQ8qOEAffZH8NsizYphO?=
 =?us-ascii?Q?C8SlTxiPc4RAhct9OV9oMr67zgOoszWMDjZUP2xNcAcJrXXS1BOLpS6XWTnt?=
 =?us-ascii?Q?ph2gK0WZcukjpIcm/8bqHzeWTHzwtPaTXyottiC8KRjgfOD9hirLeZyIqHiT?=
 =?us-ascii?Q?OEFMGfLvIu8FVZzQM3mg6d8gavEZevlHdxX0fCmDJjPV30HWRsSFE3aRsuVs?=
 =?us-ascii?Q?H7B8ghawLBrUoZWk6l+ZC0Q7Q3ieE4UbQqDiZWzId2e5pEpucWkPUsyzLvb/?=
 =?us-ascii?Q?jA1RRfOps4jW0lR7XYZ4XKFn5rGEtNm6Ik855aJ6mBeg+doC2RQZJMtUufTC?=
 =?us-ascii?Q?q2QEAS8HFKnI7oZ/yor4hcvd9If2+UcAs8+WbHfTdD7xmYNgk+3SSVvmMY+b?=
 =?us-ascii?Q?9AcUDUfQZtOGUrEbYKvxHfEhc+XqF7c1tlWU5MSpHdlyzypYssgIkp+unpbI?=
 =?us-ascii?Q?rfkgsoK1lJYUr3XAbX1V/kpe5JBlhSZnDbdOgwkq0xS0iINF7ZESrydaCBJz?=
 =?us-ascii?Q?vaIW0YfA/CzRhQfCt/vAmsohKxDLYLzi2WmWRoYO7nb/BK8GJdSo++WeA7wQ?=
 =?us-ascii?Q?0vYVgo3Jf7Ue1WiGkN8KFbvaa1GenJEfc0a3y8gmt6DIVDDgwDIM+wSdumCh?=
 =?us-ascii?Q?M8HU6ls5EkbxP+HaKuSEx00ksnjx9t5qwEmuEqLkGu2RkovHQ9S3IRURXpz0?=
 =?us-ascii?Q?bjfhMbU3zo73hASWEw4maxsJzRbejw7WJN99waAjSzjFcI0Y0oWfsS6rAeIz?=
 =?us-ascii?Q?80XhV9fJBSQfvq9Q8RHQ0RVmJKYo/9dxqFYwfZhShymmQlW7r2u78x5AUGkc?=
 =?us-ascii?Q?moZhCjwjmjUv4yYH4zo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b87ef55-fc5c-4afe-ab45-08dc7a7efcde
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 16:48:20.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cK5MTYaGRQ0eoiNmWgDXuPuoyapJasXqX9FAYO9ZgpNJrUWoL5v2Y0A6rQHTt7Eu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307

On Wed, May 22, 2024 at 08:40:00AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, April 13, 2024 11:47 AM
> > 
> > This is an experimental RFC series for VIOMMU infrastructure, using NVIDIA
> > Tegra241 (Grace) CMDQV as a test instance.
> > 
> > VIOMMU obj is used to represent a virtual interface (iommu) backed by an
> > underlying IOMMU's HW-accelerated feature for virtualizaion: for example,
> > NVIDIA's VINTF (v-interface for CMDQV) and AMD"s vIOMMU.
> > 
> > VQUEUE obj is used to represent a virtual command queue (buffer) backed
> > by
> > an underlying IOMMU command queue to passthrough for VMs to use
> > directly:
> > for example, NVIDIA's Virtual Command Queue and AMD's Command Buffer.
> > 
> 
> is VCMDQ more accurate? AMD also supports fault queue passthrough
> then VQUEUE sounds broader than a cmd queue...

Is there a reason VQUEUE couldn't handle the fault/etc queues too? The
only difference is direction, there is still a doorbell/etc.

Jason
