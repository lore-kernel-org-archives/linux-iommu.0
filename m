Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E684CCA47C
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 04:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A15FE83F93;
	Tue,  7 Jun 2022 04:03:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YSA5Y9-ervoM; Tue,  7 Jun 2022 04:03:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7266683168;
	Tue,  7 Jun 2022 04:03:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FAD0C0032;
	Tue,  7 Jun 2022 04:03:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4584C002D;
 Tue,  7 Jun 2022 04:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A24C40743;
 Tue,  7 Jun 2022 04:03:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J4kv_qMNvgD7; Tue,  7 Jun 2022 04:03:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::617])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0FB354168E;
 Tue,  7 Jun 2022 04:03:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYyWuOz1ue8EdAQF52/kLen8U8rNu56YIItP4n9/wo2XHT9IPS4RK0MhObWZWKuTD0hKYtF0uCU/QNokLXseYmRpcxKKr6q7rqAMzBkWWe/8TeAFBKb1GZakBwmJ9eJavYrrlXp41Z8uOryhaVP+yRYwXzIiewhvptjbiEe/sz07NzCgNIQk0+CCOynb7n7b5SwUQPRG5pb0/I0nMw2wFdjASOu4s14tgn/miSy972o9GVLp9Ob6mtxVj0qv62t2cUqJuDzOjsmZES2wbxNhpaNGqbtlGrt2BjTXwyMsbpjzGrOWbfLtJfcdpUqXcz+gaBL0eNZediKEPfBHny5Dig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVQvt7fCJ4vIh+8KbgiCjfi0onJDv03vxmY1oNl8GYs=;
 b=iNKM7JpHtlNpgLt4wgvEViuNiqgS7vKAKsexZCp0ozNVKVSgxzeS1g3CjyXar9PrOmvut12h0otFF45JLA6zD0t5jitm7ZBuy3sIipspylEXr4kbl8Wukaje7Ar3mhpPcct5IpoNWYLxwkCjxzpbsRl2yu9WfVRDIoC38QlyI3QwNrH15ZcWikcjpb+6J5IohwlFp8srUHgnK7SBO8XMFWIJUedfSwxihCJSDgQXxnwezCyR/9iUh6htGtDtYNzVCrEA8wJySlNXBen/0ST4Y/z+BHLQaHJ+dA4VulKXDZkUbkfMY82/2XZcrq4hg2Town5HfUwOU59Ced3x41OPpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVQvt7fCJ4vIh+8KbgiCjfi0onJDv03vxmY1oNl8GYs=;
 b=uHUu26cZgbYiR8+GviikMlIJtsPBbu7NTwAf+28XODfQtevNPM297NOVjKwhbmtP9oQSL2ZxhmEhsMh9O/0UoV61Eyi2YZJTqrHe9BBR9SvlsQGGoVnQcTLvHpplpgtJaLr+nu+8xDWVRmYLbQMvoxGqeT562v5Iz3fq9i96+5r0kyMk0s1x43ryxLPJ6N83Be3sK9o+sfvzrorjZVEr4zTo/Bzmr4NxVBs/sp1aBWNv2KEwAVZw3AFaM+pDvbwT5D2tfoBHCbKHQAZ+oeradFbKEOVB99Qtc9fryl+dWysI8HYtyh2Kx54HbQU2u2NHRCxnI7DWIujJtUcuPJ6ZWA==
Received: from DM6PR11CA0013.namprd11.prod.outlook.com (2603:10b6:5:190::26)
 by CH2PR12MB4840.namprd12.prod.outlook.com (2603:10b6:610:c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Tue, 7 Jun
 2022 04:03:14 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::a6) by DM6PR11CA0013.outlook.office365.com
 (2603:10b6:5:190::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Tue, 7 Jun 2022 04:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 04:03:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Tue, 7 Jun 2022 04:03:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 21:03:12 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22 via Frontend
 Transport; Mon, 6 Jun 2022 21:03:09 -0700
Date: Mon, 6 Jun 2022 21:03:08 -0700
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/5] iommu: Return -EMEDIUMTYPE for incompatible domain
 and device/group
Message-ID: <Yp7N/IDRcc35hD5U@Asurada-Nvidia>
References: <20220606061927.26049-1-nicolinc@nvidia.com>
 <20220606061927.26049-2-nicolinc@nvidia.com>
 <f81b8b8f-b811-3be2-5dda-139dc1bd7bdd@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f81b8b8f-b811-3be2-5dda-139dc1bd7bdd@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0683e660-e9e2-463d-45cb-08da483aa4fd
X-MS-TrafficTypeDiagnostic: CH2PR12MB4840:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4840D6F5C79D585136FBA526ABA59@CH2PR12MB4840.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NuKzzvxYS1I04PJNmqQCCwfk1FdaiXwZkAEoBRlHdkcsfRihNG0efjDDVTHxp98H/wlbCUJm2nMQIzmBB+UCv1YocIqY0eHbUgQ9hRnjm2XgRa47j2Cqpv4SGow00ssSGouHxMzzJUmguzr1SXMmJdiwd3J+QIBYBJ25PzArR5+tMdCOxuEg2if/Wxtvq8wDOShKdF/6Nt2/aLEpsGe2AnOqlMmz/Hrc4JN/SP1tqT+vsGZ60mmwMtRhyPUXyxPSrNMZJ9EVMpe1qE2Lp45c4X57myUM5XM+88u7RfhGUTAOrgfyNRSeixnlEMhuLSZ2GlbhKvOh8+JooKuEJJueDRQB539q+O6W3AK4uR4SEM7bCz7qyixvEEkcUs+8k2KiqzObm7++q5wA00/gOwguiohrJIlrHlp2cZY6oBwpQ6fKTxMXrbxQI/YY9R3dz5P9oBJhQGv+hlf50XdUHwM0HH41Ge08ENEzzhU0fNq66qYASQ17dYh6sv3nQl99b04m+2auqE/MKT5Z2NM774YBk3SuSvauQKUnLycO0YzrHyndiiCgtDNoBZuSB6XrMASmxNNYBQLX/M+b4qQtyjshYCxLVIYXmoP6CPCXNeOIgkmFLbp6aj8g+cWnX1kvUeqMB/wHeDoZpGB5CSZpp2gLoFkwN3x7Mem81MnMNDFPGgtbSpXQlytDG/3FTFwx3wZ99XRsKzcA8IPBmtQLXErcqw==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(4744005)(4326008)(8936002)(8676002)(47076005)(5660300002)(7416002)(36860700001)(82310400005)(356005)(70206006)(70586007)(7406005)(33716001)(316002)(55016003)(86362001)(426003)(26005)(508600001)(336012)(6916009)(54906003)(53546011)(9686003)(40460700003)(2906002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 04:03:13.8617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0683e660-e9e2-463d-45cb-08da483aa4fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4840
Cc: linux-s390@vger.kernel.org, cohuck@redhat.com, heiko@sntech.de,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com, alim.akhtar@samsung.com,
 will@kernel.org, alyssa@rosenzweig.io, jean-philippe@linaro.org,
 linux-samsung-soc@vger.kernel.org, kvm@vger.kernel.org, samuel@sholland.org,
 zhang.lyra@gmail.com, jernej.skrabec@gmail.com, jonathanh@nvidia.com,
 linux-rockchip@lists.infradead.org, wens@csie.org, agross@kernel.org,
 linux-arm-kernel@lists.infradead.org, jgg@nvidia.com, orsonzhai@gmail.com,
 gerald.schaefer@linux.ibm.com, linux-sunxi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, alex.williamson@redhat.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, virtualization@lists.linux-foundation.org,
 dwmw2@infradead.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, baolin.wang7@gmail.com, robin.murphy@arm.com
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
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Jun 07, 2022 at 11:23:27AM +0800, Baolu Lu wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2022/6/6 14:19, Nicolin Chen wrote:
> > +/**
> > + * iommu_attach_group - Attach an IOMMU group to an IOMMU domain
> > + * @domain: IOMMU domain to attach
> > + * @dev: IOMMU group that will be attached
> 
> Nit: @group: ...

Oh...Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
