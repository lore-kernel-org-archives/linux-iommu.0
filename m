Return-Path: <SRS0=TTgE=JT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA5AC433B4
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 15:04:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA26E6143B
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 15:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA26E6143B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66A3A83C6E;
	Thu, 22 Apr 2021 15:04:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wjaP_n_cvrXL; Thu, 22 Apr 2021 15:04:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5268483CB2;
	Thu, 22 Apr 2021 15:04:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 327DCC000F;
	Thu, 22 Apr 2021 15:04:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B770BC000B
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 15:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 90674606AF
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 15:04:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3hT5O0jl4Isj for <iommu@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 15:04:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam04on0610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4d::610])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 82C8C605FA
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 15:04:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXUrXJhs52xekZYmEeTD725q6/Fby/u2/8c47jm7nvnW3/xqq8k0CmLbyZa/8xjTxjQTgx9rz/kZ0GY79ukIJi0auuIschKZthc5jt/igoftmxTje+yBS1aNSy+c+tq0XtE3W7LJ/GDatX5he9+QOJoUvkaBS2m9E2xaJ+4pwtk315CjtB/JnSt+YowfcBV//Sw5sznLkgpqVhClV4irVlX8JPVzkfJL5WZ11lBa5Io4f+fxrrT6LE2OoAdbh01lopaGf6LZVoDFqJjKPu0mBkSk+b91Qyem942mrie9C/IACcOfJkOFWQU856sWholEc4+zbC1QX9hVXmWcmLd6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSqcADhvlVJ7LO0LRcox2vn8jpKEVTOjLBlNWYARao8=;
 b=NticaE/O+TOQQr/02I9PPxkdnSN15XlV1/JIrczvzzhJe2+7owCY20elKY/YBOiOTEYET5EAxfJvmxgBfy4JUvpHEoUS/seeQioLHcHvd+bdizGH8ZQvqoNyFNN049yKekwknSH5eAfOjpayTtu1A5ZwjgllimlvLTTJbXYJFyKtrEdnIgytx3YO62jU/77j7Ns7+bK7moNjSpHg57l+eGeLzHHseNK6sNwiTzMEROrg4fbGywcnSpLihIg6B8X4NQ9gi9QIswIuf6cRoRdALiL07Q+mKjEeJRt7i+3uJsICTb1QE2yl6RpB4mql2ty6K2KEJlLzCJMCOdjxTVNbYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSqcADhvlVJ7LO0LRcox2vn8jpKEVTOjLBlNWYARao8=;
 b=JNyVv/PABV8SjM6+GBmsOEcZqwkRWtBeIBolgQ+P1xiLzLrZqf8u27E0i4DTf6PUwoSwiKFfdGP4LtZWyE0y38to1SqWVODLn1NNaSQQ+r/G7o26RV1ru+2MluolaqStUnkhHThdAJBdffUUxq9nMyXuU8I8Z0o+Hro9BbD8v2riOHlQ0N96618XLMJtkTFjEKEM5T2gvP63dJxy44G44tRqkL/x8iTE+c9yN/2OqJUX/0CBwQT3EmQVhDaKs3Uz7VotWAlxbWQxK1JaWbUUPEBp0OdqS5KyTeaJzKArveyOReWPf8AV0BWXBQfEOSCvGqjflfO6/HZShD6vEtHkGw==
Received: from BN8PR04CA0016.namprd04.prod.outlook.com (2603:10b6:408:70::29)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 15:04:46 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::73) by BN8PR04CA0016.outlook.office365.com
 (2603:10b6:408:70::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Thu, 22 Apr 2021 15:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 15:04:46 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Apr
 2021 08:04:45 -0700
Received: from sumitg-l4t.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Apr 2021 15:04:40 +0000
From: Sumit Gupta <sumitg@nvidia.com>
To: <eric.auger@redhat.com>
Subject: Re: [PATCH v14 00/13] SMMUv3 Nested Stage Setup (IOMMU part)
Date: Thu, 22 Apr 2021 20:34:38 +0530
Message-ID: <1619103878-6664-1-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <f99d8af1-425b-f1d5-83db-20e32b856143@redhat.com>
References: <f99d8af1-425b-f1d5-83db-20e32b856143@redhat.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02cb4a85-3f6a-42dc-d239-08d9059ff7ed
X-MS-TrafficTypeDiagnostic: CH2PR12MB4039:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4039EE93B47B1378B1A539B2B9469@CH2PR12MB4039.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aS7IBfHHoR+5HubceEs+Qh/RrdKpvrqz7PiCvNrgIZPXqgjJRsnzC4YrjGid1lVDvr2tM0N9zR0SSA1meD7MTA3FAWhVzpBNTmvN422T+yqoIbeSoWaMHlTGFEqWj8OSnQYd/K3XSi8TAP4Z4Hw8I6NmTj1kxFFlmerzTnVWYLdfP7F+2OSqxInSVBC/G/nJIO4x2CcJsMCO2Bbp1fb+p7rzN2lreXXgzLCNclRNznARX+fbjGV/rma60puwynxQkHyrFXE+QPOaiwhpibD79XsFmjl/vLLbdlrruienLV1aa9V8/aqS93DCsh8E0fdC4Xwn0zFW4mpBvTKtZbBmMdejFo4dUQdCzlTgpLQosOzSK08MURkmPkuJgy5eqG3c/8z0ZONXUQfHyD9pf1eL6WIBkzvdLdkE4GtFOvG2/FtHFNNEhGT7U69t66zFaLTE28eeg1f8eqC3OcaM7acW4Aj8bkHXPNzlHIgtjFgWmXnwtNdcfUfXIMBAOTNsEKoLfEweclxFMOIVO+noxc4VEvWw8r7lS5MzgtD7+RiJdjITOZFkCLTlXzDeVnpzEsHUgQ5dR37QB5bTR92gAt3ATjveQ2XE7vJwFOCSpRalCWXXaVQrVgP8pxsSkQllzFQwrQrBtKx3ThKCdPwKoGMR0w==
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(36840700001)(46966006)(36756003)(558084003)(186003)(7416002)(426003)(26005)(8936002)(107886003)(8676002)(316002)(2906002)(6916009)(356005)(336012)(70206006)(82740400003)(70586007)(7636003)(83380400001)(36860700001)(82310400003)(4326008)(47076005)(7696005)(2616005)(5660300002)(54906003)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 15:04:46.5264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cb4a85-3f6a-42dc-d239-08d9059ff7ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
Cc: jean-philippe@linaro.org, wangxingang5@huawei.com, kvm@vger.kernel.org,
 vivek.gautam@arm.com, maz@kernel.org, jiangkunkun@huawei.com, will@kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 vsethi@nvidia.com, lushenming@huawei.com, alex.williamson@redhat.com,
 zhangfei.gao@linaro.org, sumitg@nvidia.com, robin.murphy@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Eric,
I have validated the v14 of the patch series from branch "jean_sva_current_2stage_v14".
Verfied nested translations with NVMe PCI device assigned to Qemu 5.2 Guest.
Had to revert patch "mm: notify remote TLBs when dirtying a PTE".

Tested-by: Sumit Gupta <sumitg@nvidia.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
