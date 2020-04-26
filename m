Return-Path: <SRS0=zWGe=6K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3ECC55186
	for <iommu@archiver.kernel.org>; Sun, 26 Apr 2020 00:28:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C12206DD
	for <iommu@archiver.kernel.org>; Sun, 26 Apr 2020 00:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i6eO8OHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C12206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AFFB7857CB;
	Sun, 26 Apr 2020 00:28:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qBMAX1oqh2Zs; Sun, 26 Apr 2020 00:28:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A908885633;
	Sun, 26 Apr 2020 00:28:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80F5AC089E;
	Sun, 26 Apr 2020 00:28:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B22F6C0175
 for <iommu@lists.linux-foundation.org>; Sun, 26 Apr 2020 00:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9BA6887B48
 for <iommu@lists.linux-foundation.org>; Sun, 26 Apr 2020 00:28:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x+dV0K8ko62T for <iommu@lists.linux-foundation.org>;
 Sun, 26 Apr 2020 00:28:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3FDE087916
 for <iommu@lists.linux-foundation.org>; Sun, 26 Apr 2020 00:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvM7FxHxFS+L+LNp/SvLwgiZyl37VHt2A/WdAB7fJw7NRG/DpWWBtA25wfH0TVcLGvk5nzuz38td5q8VzrG6n3d3bQbIdQ12oKuZrKJtVIxjwO7CZ0fwMbJlk6i8dXShoHaTf5QVsY0E6FGkqeqQPqu9rrIkdRKGHmxHzZbsljODUld35F0gXnBvt5qRrJnKaguAU7c/mlO9t6bVffYtKiO4VrdChy4QO+5cynF5AWUm0+vzt16a2wUljgB2SPBo6la4SclTR0yqKS1IIkLVY/i9B0FowGWUxsXxGaP6pRYSxcyRO1yFgchdC0LaxGVI7cZeqq7H4nEIfSIhfxYE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miKnVIgeK+7lY2NlNFa4YQ/rSSv1KoztPiALGTkL32E=;
 b=HkhR6TXucR6+wImrp1wAM6xtPpFSYEGyucoK0w04DYf/qD96OqQUkaVQV5sf13GZHMEfhoT5PHJQys4qgKwz29NgulSA44hXjBkgeKXcpAqm26DyYZsrJYlszg6E7CixwYGbXJuSy9v6Y3P3rsTGFwF3aVCWjimZsjrKzn8jz/PMHGUHiIl8bTrAxme/paOQJmsyII9a1z12LtOoTSEqL3BxBSIqnwAOR7SHKATp8mUxvMmvB1KaQC13gD630xVwoi89x7uKSOq8Q10p+nVXNWwZUKmoG5LgfWYriXA9rMeQuh6yWSBwEXydkoDns2EAow5/HBUiGhKZhKDzJLW+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miKnVIgeK+7lY2NlNFa4YQ/rSSv1KoztPiALGTkL32E=;
 b=i6eO8OHSKaGZ+ahmLKWveb99jjPqMYFDINOtncqukpZqRcgSn98Ym7Im5wGGwJemPPQldU9uA9/FDbNbAfAlbkR1aRz8dRcCf6CP/O7K8+xQUgNQaqbe5H70OhQUxozE2/BGLOBkcWgpZmsMXFM/yJCkqxDsyW1q6ld2D16quKg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB2471.namprd12.prod.outlook.com (2603:10b6:4:b5::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Sun, 26 Apr 2020 00:28:45 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::d061:4c5:954e:4744]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::d061:4c5:954e:4744%4]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 00:28:45 +0000
Subject: Re: [PATCH] iommu/amd: Fix legacy interrupt remapping for
 x2APIC-enabled system
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <1587562202-14183-1-git-send-email-suravee.suthikulpanit@amd.com>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <18528aea-784f-537c-19f1-1b32328b60f4@amd.com>
Date: Sun, 26 Apr 2020 07:28:35 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
In-Reply-To: <1587562202-14183-1-git-send-email-suravee.suthikulpanit@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SG2PR02CA0100.apcprd02.prod.outlook.com
 (2603:1096:4:92::16) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local
 (2403:6200:8862:1548:ed78:9ae1:4cd4:6cf6) by
 SG2PR02CA0100.apcprd02.prod.outlook.com (2603:1096:4:92::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Sun, 26 Apr 2020 00:28:43 +0000
X-Originating-IP: [2403:6200:8862:1548:ed78:9ae1:4cd4:6cf6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d861751-4ab7-4561-d316-08d7e978c771
X-MS-TrafficTypeDiagnostic: DM5PR12MB2471:|DM5PR12MB2471:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2471EDE591D926B8DFFDA272F3AE0@DM5PR12MB2471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(5660300002)(316002)(81156014)(6666004)(66476007)(66556008)(8676002)(16526019)(4326008)(8936002)(66946007)(2906002)(86362001)(31686004)(31696002)(44832011)(478600001)(6486002)(2616005)(53546011)(52116002)(6506007)(186003)(36756003)(6512007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KYaHWrLmbex6JaAgQpHpR4z+N1WNeAEaZRMTyHmuRUvYx63uoWlMtyiLcIiEzBgDU76P7/igbB2+PYksX89cvetCFP0E5yjFrXsoefG9ESJ8Njc+XShoIwjArb+CQUTJ3mM8p6bM+eo76OtASvawPX5I5FINBYSn0b6aIm+SLxKU2EkyGJ3D3znhzntWDQMbJcwq4UYzXw6fD932wkGYM2bp1w12FITeYjaCMoH6aFRpj7NUZqcYk3j7ZxS/XICUNwrswsbmrss/FuUhDBRpuY4gKpzDiki//3S8z23ZgGH6l9MFXt5or2BTKTW6AVbhVvd8AbJ3P2nfNlQODechGbSKXO5/mw5bldQyGHlP9zblhJG6c9WcYkBjH0AX+IpaXTta1tGznS+/Vpr0cD1uH66HHOmzmkGxYqPYiu5pa9e+c/afz7E9XxWcIP016v3
X-MS-Exchange-AntiSpam-MessageData: m1ZMkFtupSoHmeEi91qgnh8pswZJZeusE2Ea88o8anaVVIuRY0d18IFcEU++tch0PZbMm05oZz7zA4sU5CYMVMGJKBt1AQNx9ALNPkUO9OnKTny/I5RLaymOz4ooerU0f4oLDO4gKudDkqSy9RlULUNzZ3xYhTpGvJx7YK5+7wjGxRb9HZKXpP/CYHQgR3vWLfCfpyo90hZLnlLmbxGa37pvgM1JZYbdOr601IRUMVf6gJZIpwo7Su/VrzWcDCNI93fXEu2xqOj35WN+X/K+kmljcIQ2wZ6JweBZSe1qcNTTKrJuLxyGt18M0XFY4LcPDrkkrf4LLMkflYvn9/TkK9GyukRQXuHj66+HDI+rwYOcKK4aGR6THrPCqxfOG490Ihsx2Uo5YnpJ2WBJOuCv278RFzsnHxwFVLqGTN37yRhQs7g/SibpgTiVCll3hOsIGDVL7ByQWdvA2sgwj3AyZKe2AzvJKdT8ae2rFmSVxMGfxOfkq67nKw0BtmUnAVsl3k6yX8SqxLMWexf/86W10hPvuMtAvYwdKJkRuY03rJRKnTbBkfGvrE8uQM7MwT1iWYsDQIHiyG9km1F6l/LFK35sHDsVLFEYGybcqRFze8AotsxZwCkj/+1+R3N+cW3Dl/6xzPHSlI/xoHgOyOZa2Sic1AalY7LInvkegNxc7zUego3AtbHCCdQ4kJB0JcgmNCqQYnnCHOTKYgXo7UP7Z5G+B9Jk09FI4sciuxcsd5ds7gM1A3rmCeGfQtCaFtdr8ajQPuL23YpBYDGGYIcgmB69/vfHhkNUxGirEwMpBebzVIDi70ZuvTAHT30Sha9tiHX5BG75RHr3vgkrfi4Zwu7HT1OmK80wKFcVtpxHWO+VMj097BPXWQGr2vvCI8fZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d861751-4ab7-4561-d316-08d7e978c771
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 00:28:45.0016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQmC07+HxUeScLx/GdiBXtJA8shPbA4NX2gCTKQ5iTge4E9JPh7Z/V33EPqLTFSWJZP2KZ0ArygMC72bz3g6Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2471
Cc: jon.grimm@amd.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Ping.

Thanks,
Suravee

On 4/22/20 8:30 PM, Suravee Suthikulpanit wrote:
> Currently, system fails to boot because the legacy interrupt remapping
> mode does not enable 128-bit IRTE (GA), which is required for x2APIC
> support.
> 
> Fix by using AMD_IOMMU_GUEST_IR_LEGACY_GA mode when booting with
> kernel option amd_iommu_intr=legacy instead. The initialization
> logic will check GASup and automatically fallback to using
> AMD_IOMMU_GUEST_IR_LEGACY if GA mode is not supported.
> 
> Fixes: 3928aa3f5775 ("iommu/amd: Detect and enable guest vAPIC support")
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd_iommu_init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 6be3853..2b9a67e 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -2936,7 +2936,7 @@ static int __init parse_amd_iommu_intr(char *str)
>   {
>   	for (; *str; ++str) {
>   		if (strncmp(str, "legacy", 6) == 0) {
> -			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
> +			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
>   			break;
>   		}
>   		if (strncmp(str, "vapic", 5) == 0) {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
