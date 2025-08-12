Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E832826A09B
	for <iommu@lists.linux.dev>; Tue, 12 Aug 2025 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980879; cv=fail; b=JLvO/WqtBjOoRGh1lVNuUuhbjfRz6dLe5kcOUK7Ia7fvidU3M1sIwWAsAPv6BSnFCdF3AxGhTMB0p0rsrHXW0biEpitYwv73CzMIcO1NaOoEki2eXqEvy3pdduu71Jqf6zqF/9dt8DltracoWHbCMLNCAmy3VayALeZLju/TsQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980879; c=relaxed/simple;
	bh=pBIoVrex9Do4uXxB2moxhP71U8hRynhzJPhn5iXZBT4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcgESEaKc+tnerV7D2l/yd+wBF1xw6HZBkdJdRPHrfh31T7osaWSkyGhA8uFGTMY0YnFT35yc7rj8UdHHe1sm7D+9lvkH8//uGR4pwbP/EIiLDiWkAx+UD6zkmTeV1+HBn/Nhdh0+Pwy2mrsEOMEX3K7d4jU6RvgOnkVApsRgZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r0Wrb/ll; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r0Wrb/ll"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQesWILOCz/HN9AMahO/ASpLzqHMQNpHwnfuhjwjs1pdj7SVRYcx5+0wAzW0i8KsH0Mm0w4ehk2RYmtbPLdQS1iDsP8kudBGRibEe8XAyd9S0i9ImmEkMl8VVtR1PVcYHmtw8eXsIhFEBQSuZ3LkWAtMcWjTLBiynbR5QuUGxgp4hoULDcie1wg6j2CDul5EC+1lWf7p9pzke5O+ZA6tljI//+/VGzL7cTkTPZTQ4ovxDMOM5jWYc9OW58lI0UZkcu9HvEuaFZCwUb6Wu/B72X/E7P03i+G06nEpKKtpCXDIJX9fPs6ibh71kkm5THKNDU1q21utN8hCB2OUESEqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNO3sfOP5h/S8NsPp+LIa1cxVwMA9g8WsaOqvycLHYY=;
 b=diRmtLZ6JqV2hQcBsir2IZcyFFVJE2KrFp79Ne6yp9ilBIyxhLYhwcM8yN5t+yslNOgUKVlPBgfLpMHtQo19Cz3MqiR/HNNd4pcuVaI0v/afQasllRaBpkSDmmEkyYEbJxwdso2VCj4+nJg1HsRpMTAOf/qHzkeyaP9jEAbXlwJAc6CRi3litVeqksiwscgrrbYVp74ohgxF62hYEVD9hjqRvWAoqesk13CqeiOpdxatDUWOEozBqm+ynRVqa6gbdKI0ijSDZAIjzpJr4lLTssU7Xq64jlGXP7E6QUJUprFllNXJExu/lF3H7SWE+RKCYLUflRfYS4Hps048aLgZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNO3sfOP5h/S8NsPp+LIa1cxVwMA9g8WsaOqvycLHYY=;
 b=r0Wrb/llsbPeMlHsbkui/QR6ch7R2te7xZ8z1xKOxedNO1rGxDd45Hw0CqzE6MPochqSrTMK+m36bPd7cZFrCH5+8E2RFW0iS9nsjFTQE98uYnslp5AFm2sJV5P7F9R/TcPLoEBTN1n2jUeKJ2yrPW9FBFS3vyN3ZJz+tIM6az8=
Received: from SJ0PR03CA0177.namprd03.prod.outlook.com (2603:10b6:a03:338::32)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 06:41:11 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::99) by SJ0PR03CA0177.outlook.office365.com
 (2603:10b6:a03:338::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.20 via Frontend Transport; Tue,
 12 Aug 2025 06:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 06:41:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 01:41:10 -0500
Received: from amd.com (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Aug 2025 01:41:07 -0500
Date: Tue, 12 Aug 2025 06:41:01 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Kees Cook <kees@kernel.org>
CC: Joerg Roedel <joro@8bytes.org>, Simcha Kosman
	<simcha.kosman@cyberark.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>, Gavrilov Ilia
	<Ilia.Gavrilov@infotecs.ru>, Kim Phillips <kim.phillips@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH RESEND] iommu/amd: Avoid stack buffer overflow from
 kernel cmdline
Message-ID: <nt5hjadzpif6sqoyj2cfpg3werd3pucfb3nys55fmeix6rcqso@hhmnso6csrn5>
References: <20250804154023.work.970-kees@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250804154023.work.970-kees@kernel.org>
Received-SPF: None (SATLEXMB04.amd.com: Ankit.Soni@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: b6941cb2-3dc1-4d8a-be02-08ddd96b39b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HKBssF2+OZEgG6+iQJsQM6TBKED5Q6aXo0yX2Qx7J4zrjF1RLSofyxXr0kw+?=
 =?us-ascii?Q?bOmcjOtrIPFdtWIanGBDe+kkKy2EhFh28gVX/lyt4hBsqU54vDE3t85TnIZv?=
 =?us-ascii?Q?mmSeSphYFMU8tk6U4fq+sViLnkXxy8i2VfhZcD8OY7O+/cTnplbJFYzq9uHB?=
 =?us-ascii?Q?qik9xnj3NncwS+3JQYcw+eDEoKxXnf6zQwLvbpZQ26m0QAPk70Hnfb5A+tZu?=
 =?us-ascii?Q?AtRL0Q1kmvCs5Y53GIFxN9I2TyL7H0JFBHTb0MoS10k9M+C2jCpQZO/HP/E0?=
 =?us-ascii?Q?UlBCmAR5yc8BRVwMrp4p3mFuzACmMn1rEOOeELuZPYTl/W1kKAqpzKtImiSs?=
 =?us-ascii?Q?doYPQOsZOReWMukd6Bt+NixH8dlbyKCLX8bUjMBU/XXImcXWy8SkmmjFj6kt?=
 =?us-ascii?Q?aolJFjVgSOcc/nLeKBzWYt7M+N1jAa3sYRFcP0NPKJG093hgxdseDKVExNOi?=
 =?us-ascii?Q?8R09g+fZxwLH2WlN6JNbw0KhAGKJAoHldBNRy0TmGL2cD2GJqj5RgFJRY2KP?=
 =?us-ascii?Q?VUA8vBSLs250cmdBrXFXF8QqpuMuBAwzQUKWzAb5WqMKGtN3LC+/skZm44/i?=
 =?us-ascii?Q?FZ3Bl2t6X3pV0RU6d2G7oETi1NNjk0KW7SW3HJ7FuyhYqY+ehRYn8282epKz?=
 =?us-ascii?Q?FbleGFq6GHPydL8hm17PA6ugnx4memk38jRQ+VV0tseHToydwVwLu5CW25hP?=
 =?us-ascii?Q?r75S0OlT/XChNydqPd3tm9pHQcWl6N6nyyfp2yB9V8LP7jz76XWMmpeSOSQb?=
 =?us-ascii?Q?TL8LqAhOqzHF6sJyFAZAedrJ47aMVsg1Rv6Je3ZGE567RLyMrqp7kUmVTNC7?=
 =?us-ascii?Q?DcN06ZS8RiYwMq5gPDciuxob+8cKdTBAJ3O+nbCckShlnEEy1Pwv42HEEs/p?=
 =?us-ascii?Q?n+Zjt63cxF/1XVkeAOooEg8un0rDosVo3Mm1ceS56WkN/PfY/qMvoi+F1BEa?=
 =?us-ascii?Q?ESPkVbbXqkpCk4U+40J2kZ7sJr/UA5qTCOZYXHRv6CfmumA8J6pWlolkpYpj?=
 =?us-ascii?Q?ytLHcYjFNED4EHDQ4WeR740y5woypNpEa9PNzR32Di1h/c6JcB4m9TQvXtMg?=
 =?us-ascii?Q?1WSspgutMaqHyJaNRCNzPFKnwAikJdwKTBhOn1N3p/DSgnklS+7TILm/zVzg?=
 =?us-ascii?Q?Maxuh2z7QZmyHeyS8wAbZTe7PlTsDo/gG/MzA+MxG09ZsTqxClKEK6dtGMhp?=
 =?us-ascii?Q?3zW+SnbxzOGu3kut1yNVuMM4CTNUdhgB0bYx7nh4AOqlo/XdLoK9PJIxyBTX?=
 =?us-ascii?Q?H9hicXTmtODMjJhuXN4mZfkaySTsyvlycWLYSkZJwSD20W87B3vCovEhwUeF?=
 =?us-ascii?Q?bZ9cCL8LZ2yJsVNDqmTFvsxzKw392zpNdozq5ci9SXBTL36BGGQXgEf2ZDpE?=
 =?us-ascii?Q?d5S6FkPmGke0fX+1g99anr7nIwJOp3/oiVlR9bYcEbgkYRknZzaUuoiEeTC4?=
 =?us-ascii?Q?eGS1qc8WY4yIYgqUxzqqUo4YADFXwRGxQrOZ5joa9pIepYaNDRdr6+Qsttnb?=
 =?us-ascii?Q?fvSTQRAUT0GYOX1dHMRLEGDd7tUb0Cpn9IwLC6EtwFDa0pXlp2RDnxzu0g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 06:41:10.8724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6941cb2-3dc1-4d8a-be02-08ddd96b39b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917

Hi,

On Mon, Aug 04, 2025 at 08:40:27AM -0700, Kees Cook wrote:
> While the kernel command line is considered trusted in most environments,
> avoid writing 1 byte past the end of "acpiid" if the "str" argument is
> maximum length.
> 
> Reported-by: Simcha Kosman <simcha.kosman@cyberark.com>
> Closes: https://lore.kernel.org/all/AS8P193MB2271C4B24BCEDA31830F37AE84A52@AS8P193MB2271.EURP193.PROD.OUTLOOK.COM
> Fixes: b6b26d86c61c ("iommu/amd: Add a length limitation for the ivrs_acpihid command-line parameter")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> This was sent out before but it didn't end up on any public mailing list. My mistake!
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: <iommu@lists.linux.dev>
> ---
>  drivers/iommu/amd/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 7b5af6176de9..e11322d8d775 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3638,7 +3638,7 @@ static int __init parse_ivrs_acpihid(char *str)
>  {
>  	u32 seg = 0, bus, dev, fn;
>  	char *hid, *uid, *p, *addr;
> -	char acpiid[ACPIID_LEN] = {0};
> +	char acpiid[ACPIID_LEN + 1] = { }; /* size with NUL terminator */

minor nits below,

s/NUL/NULL
and keeping "{0}" will be as per standard.

otherwise looks good!
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

>  	int i;
>  
>  	addr = strchr(str, '@');
> @@ -3664,7 +3664,7 @@ static int __init parse_ivrs_acpihid(char *str)
>  	/* We have the '@', make it the terminator to get just the acpiid */
>  	*addr++ = 0;
>  
> -	if (strlen(str) > ACPIID_LEN + 1)
> +	if (strlen(str) > ACPIID_LEN)
>  		goto not_found;
>  
>  	if (sscanf(str, "=%s", acpiid) != 1)
> -- 
> 2.34.1
> 
