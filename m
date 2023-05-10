Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3BE16411
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 18:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ft7glWEc6SmaTscra0upCqoqjOiRqwVJ2IfrEHPt4U6HnTIeRPCuK/CPMIIDFjl77vvsLQjQsvY2GO5QFsd6O6kPorFYrT24auRwZvf+E0KnWtR0U8jf8D3NPaUdmhlG0JNz3G12FzuKGhUMclnByT1BiL4S6PN5DXoCW52u74Pi74wzSY9W/FZlF5vZSQlWZaZ73Ngi8RWydzUC6XCw0DOBYe8UVCOvq9f0BI8ybc/jF4BlrwrinZdNg/mX3yaPq0BzJzaHCathICJ3QVjFwVOpBzBlkT8bUPQjN6VabGGNYO/NJ3enkCsI54hSREolfF9PG7uJHNNoI5jsmfrnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYj1kdYbXIISdxx02bFtEbGt2/xiYNTCS4wP6Fyr6hE=;
 b=S6+bIfYZgMTl9oAzJNw3t4y0TInH8rPFo0fc5QlLXKiZk8fVU9xGJsTUcRo12PhESQgl8KMfpwCb0ft8bIxjLlcxJ56ZV9jTLT9BpTi+sv9Hok+maU4ozEX5kRsO9/sUJguFeL4Al+N9XpeOgaRi6hBHk91mUbwaeq0AINTYbOg+p0cuMfH5GYjtnfgLEpVJb+IOi0cThnOe4wPgso2mMSCPN8lo2AKT8Cvy2iXgm4qA1/GIM3bhJyZkVrpJJdgqkgn0+ww/09Ffml6hY6SFLf+bKPNEu64JbA6zNeuWirJxE1iHY83NGWevaN/uhN15xKqvv2F9LsCkaR0RJsi05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYj1kdYbXIISdxx02bFtEbGt2/xiYNTCS4wP6Fyr6hE=;
 b=CKeDeqRy1IrBbi5mAmMJpz4UFZp8yOjL3c/rzgobTqgJ4GWAVDRFsS+1SR3DqKxfmYJ9JogK3DDnv/zs6zChc7jO0/OmdzOkKBBHBR7s+gS2gM1dkoG3IKF8mM18+IjzySKlx6vtCh7/ireZMNjpSjOIutlGLFyBfGWA53WM9QiTjS1j8RAqpzs3+LE+Bmt00Mv3UBYw3VSn/uqRm4SGpcdID+Euto89yHq8IDpvJ34LFXFC0+PILajjmOB0bfDuMKUJ6kdxmpJtma2Hc6uPzPnA3H/Z9//t+Y51n2eJbX59akY86jbO935gtarWOU42R+DDIhAkSNs8Eaa3fZtj+Q==
Received: from MW4PR03CA0220.namprd03.prod.outlook.com (2603:10b6:303:b9::15)
 by PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 18:37:49 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::74) by MW4PR03CA0220.outlook.office365.com
 (2603:10b6:303:b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 18:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 18:37:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 11:37:34 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 10 May 2023 11:37:34 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 11:37:33 -0700
Date: Wed, 10 May 2023 11:37:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: <will@kernel.org>, <joro@8bytes.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <jean-philippe@linaro.org>
Subject: Re: [PATCH 4/4] iommu/arm-smmu-v3: Document nesting-related errata
Message-ID: <ZFvkbCjg6RJUTQGw@Asurada-Nvidia>
References: <cover.1683731256.git.robin.murphy@arm.com>
 <696da78d32bb4491f898f11b0bb4d850a8aa7c6a.1683731256.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <696da78d32bb4491f898f11b0bb4d850a8aa7c6a.1683731256.git.robin.murphy@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|PH7PR12MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a63e0e-4fd5-431d-35a7-08db5185a801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BZpGMGP087wFQYCNHEY2pDN85mesqmoZ53aSGJ4V32Ia5Glk3E+xJ1jnvInh2u2lLfhyOe75t96Sr9FNvCgrIhNVgid091utyCLRk4zjaZApxFJoSyutKhmfk8cLjtFhEjQ1f2fnRrUJaTpeP2JW/jNiTAmhGe+K/aL18F2MpOUWJT5PGKSgLDYj+Vv+G6MXBgPhzCgWJRn8wDGnw12Inz9yVOEDD2PXPfNGhzJaHefN0mig10k/bkxqKxm242zCvlZ8WagXitEym63At3roG6m6rPA3NRp5jwMnJSUJtkZmp5VduJuI2/bAAWMUwsezIuGgRMX1m/x/YVuMRQcV59INum9R8WHv+g0HoJJeMsBRgA6HARBzPGRcPLB54whSrBPhAIXJsxtcw1Ndczr+WFkDYp1j59nVO22mnsJK5m8g0mhrigos/VIx4CCTDAPBVJMbl9ueyVsil/FCCYbwtjQCZyctNzL5RxHiYP800IR4WBgbEpMNXzh8hjk31zW1rhAkuddFtkWHP0KsuYsagHvC6NETPPGwmMxW3Jt+YAei3Pbv+EGHVPWMAVeG8lCst+zeoAeKUklUignvK7VPnrWhmGEpQepa/pc1eTq/thyAkZb3OjgJRMqbOI4lg/RATbu4BPUHDL8K6kUaZ5KhxfNdNHUhL4BGzfvPunkYWlLdC984UUilyhGBKQi7QmAKFQgRN5cRLTIWNtuRYCRORg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(2906002)(70206006)(70586007)(36860700001)(40460700003)(47076005)(426003)(55016003)(336012)(86362001)(356005)(7636003)(40480700001)(54906003)(9686003)(186003)(26005)(478600001)(82740400003)(4744005)(82310400005)(33716001)(4326008)(316002)(6916009)(8936002)(8676002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 18:37:49.3271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a63e0e-4fd5-431d-35a7-08db5185a801
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6000

On Wed, May 10, 2023 at 04:38:46PM +0100, Robin Murphy wrote:
> 
> Both MMU-600 and MMU-700 have similar errata around TLB invalidation
> while both stages of translation are active, which will need some
> consideration once nesting support is implemented. For now, though,
> it's very easy to make our implicit lack of nesting support explicit
> for those cases, so they're less likely to be missed in future.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
