Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27921C4332F
	for <iommu@archiver.kernel.org>; Mon, 14 Mar 2022 21:49:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B45D2607F0;
	Mon, 14 Mar 2022 21:49:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o0_a6ptJ-sTD; Mon, 14 Mar 2022 21:49:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8865E60597;
	Mon, 14 Mar 2022 21:49:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FF25C001D;
	Mon, 14 Mar 2022 21:49:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D40BC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 21:49:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1DF0F401CC
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 21:49:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sq15Fe4pUegj for <iommu@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 21:49:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::618])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A268B40153
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 21:49:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Omq6Pc0L5YKE0/jTx3HjzJi8VTDsOgTTROMl9GEeX6Kj/dZd9MPJyy1Wea86m4TJMHh/hiVTTBPLqgQDZNpnxySeF4Df4FA8xqu0fEV92jZmcWa5GxEeC3TfdswbmkmXIgswBpouTKvT+s9vPh13hOnE2yH/ca7raUHvGAEeWf7FgKS18xnf7t4QFqx7vL1VxoYR+iikNqRI5JRX+C/k7+QplXCcWGXLhyvqhImRsSx8awldkp/MpEQF+nW7Ofr+cMJxkynss0rVmPua1Hhmb+48Ew5iJVEAU0ZASkBtbEBDd7qFK2SvA6SuAsS64fOo1jgqRwToViwUhSfeYDd4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31SYqNiHWFjuf56QD8Z23OoU3v91m/m3QJxpZCzNnag=;
 b=FRHxBwQQSudtj2bhHUhSOt3zBSQctCj0mE2ZbXKfvVRuJK0uDg8T4yVg8UDrUlI7JX5GkE0ckb/cZXIndze9Y7KIy42kYG7JTxsWU0qVRr3Rti7AiJu2GP84CkBbgp2kYQb9rPFfskbYRNQA4sw96M0gFuesSmyaSlhFL6gpQ3yMENiTuXVDJY/8qprpTAvS9Z58A5AUgyckEwVVG9bGjoyh++Ow3yXM+O1gXsikT9vyNcEbnCCLrLe8Bq1VGy8Z12GIWaxYNY6e2zhEiCUXQ8n7bBdvLL4fkLF1/dchM/VEsjHk37blT1BzoaeednbpLE8gBLOAJBlLeOlLGCjZUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31SYqNiHWFjuf56QD8Z23OoU3v91m/m3QJxpZCzNnag=;
 b=jvU8doVx6qWuZnqwxPF8scniMZy8wGoyYs3MsbCZc2P7RpuGu2f4gjaWM4Gz3yXh/fB61MHW01LVGoMHXk/YGs12GGyvpbzM0FM9oC7bdOny4cwTHhE3mPfEfmM5jhUgeTa1aonR+zJPcTBlxet+GkvQzgsoxSrRY8ozml1dWU6ysh0r7a1zd6r89hd7AJ2vAIGtC1JSzyfSt5NyhzxRdOGxNdRFhIGO5lobAr2ie61/MNQZBCTEoPqEi4q85l/HEmVImceDrV97+i44Nc7DSsurpZQ39CD11e2VGG9tPHFQ57Bmftwg1zZq8uhPjDs0VzG0ukX3ZwwphsjtOYN2kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1174.namprd12.prod.outlook.com (2603:10b6:903:36::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 21:49:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28%4]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 21:49:29 +0000
Date: Mon, 14 Mar 2022 18:49:28 -0300
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v4 29/32] vfio-pci/zdev: add DTSM to clp group capability
Message-ID: <20220314214928.GK11336@nvidia.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
 <20220314194451.58266-30-mjrosato@linux.ibm.com>
Content-Disposition: inline
In-Reply-To: <20220314194451.58266-30-mjrosato@linux.ibm.com>
X-ClientProxiedBy: MN2PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:208:23d::28) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7900b9f4-e3e0-461d-a170-08da06048412
X-MS-TrafficTypeDiagnostic: CY4PR12MB1174:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB117480D2774739DDC0A1F387C20F9@CY4PR12MB1174.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBh7RkmfwwhB8Zixsc2nzm35NuhVbKBoYNCJ0nkfJPBK+z1twCTA30kEp/I8iZCW8vtcsdSsANn6dux/z8c/r5z03308hu7ssa4rzayh7cClzg8BApssY7qnWEGGSwsrJBkb19cXO3BHxuMEqNGZaCc4SoIoB02y2nFColXoaJSf4f86guY3M51uMR49NfV4x6sfRP9oXlm8mGrr0aa1/pRGHIAvyY6mOxAigbkSlOdl5yrVe99g16HbUHcYFhjvh+XXPpRW7oRfIgLRRGhjYTZS8Ou7JkZs4GmXZlsuTkLOGl6lhx9aszilDqxOFnCYtBYnTWh06znZzIXLYmiL+U6ilA4VkJuPCmwYVB5HRAiNF0QiQ0j00PmGEN9uHLpP93++uLRZ+vg4WosG1/ojVoFntCUbTeB+YMUWJC80TyEyoTtliqnq4q5TNl+PmLRpS5G9DvT3x6dFq/nzv06LhzKvRcnEBKlbnjg4021ix7N2Y3JhGictqSxTvkQIa/qmg23jJk8C39Pm/Bt15LEB92OYxgDOb7QcdhvUiqnYKlDA8i6LIRLnVQDIQ/sNo4jwNAztIblBHVYFt16ivIGZM1qZVZNTcWj4aFYpeE7fMSTnjHIKmyP9+35m4/sikwGF/ngKvk+lqGuJRvoLX2B97g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6916009)(316002)(33656002)(2906002)(36756003)(66946007)(508600001)(8936002)(6486002)(4744005)(7416002)(66476007)(5660300002)(38100700002)(8676002)(4326008)(66556008)(86362001)(186003)(6512007)(6506007)(26005)(1076003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JXLz8C8CDg2ibpjBeDUZAhe/RBRYjYSAYb9Yo7/F9FhA0/q6+6pbCX27QeZJ?=
 =?us-ascii?Q?sjXhbP3CrWGPBXx/JAcwQtwI27/K3J3NWUgQKMjqevp/NHN0RDwJTNi+XcY9?=
 =?us-ascii?Q?u6ko/wiYbNYmbfsRHF+RNpZdTYdb3w+szInjfNn1Rj6hv9XUX3LFmeIGqHtA?=
 =?us-ascii?Q?OmucCDHuLCxDLM+PS2naEpGeuiyNMa7PM7NP4JRsVlT1rlnYkJko2KcRHpFR?=
 =?us-ascii?Q?swexLSUMKJZ4aq4DkaO9LPTliFfLcNnoZO+3BoVesW4lcWnRB9mco7gGKqDj?=
 =?us-ascii?Q?BRmPlme1WmbBa8z9hl5F1NWM+6thUeC6m67sMVqUMuKOiV1FSaAHxnvSdMyn?=
 =?us-ascii?Q?WWJ465569o9W1L/C5oG8PpIPL4wM6wo2AFARon3vTk3jlg35D5D2xFJigGRy?=
 =?us-ascii?Q?eCGHGJBNWqEjBB4scsB/2AncdcdLpPiY1FCKKPj6Uh+ASDTj/LjS8R4ur2Ww?=
 =?us-ascii?Q?zoEG2QVCML4iceUwyminPFjIxydOGzAT2+v5kKzgPZZ96hbx/sZU4/kmbSXZ?=
 =?us-ascii?Q?dmBp2jDyh9ApSYguJBpjKQUoE9IwmGxFaH7JC0HUw99dU/Nl9EhsPZbCLCHI?=
 =?us-ascii?Q?cl/e8jgDNONAoqwmwD0c/IMD1jDxArJv2OhrpUg7zQrkabf+/sZkdaaROCyx?=
 =?us-ascii?Q?0VKwcyBIh84rdvUL9EV/vSfhXNBoY1SVdUmKcpdDtTrXDmm8i+6jxMWQ3Np1?=
 =?us-ascii?Q?UP5acGbBoVIr+9D6LsooNJYP/r1edc0gpZba4AEd0LTF3W2c1hpstr6uRODP?=
 =?us-ascii?Q?rA0GQEjQALAqjz2ot5OwZSPYp4x4NbhhXjRJCcRiN1A+mXO3htdzX8zl8YK8?=
 =?us-ascii?Q?O1W2c5VcUYKphjJoahuHCu54y7cAIwgDFOuE9oRthAjjbLfhVgIwIfhUFvTX?=
 =?us-ascii?Q?FvbFPC2Y3ma/MaHJui2Gf84ifLKakQs+ZBz6vrE4+G7yw2FCvns3JMUYTh59?=
 =?us-ascii?Q?mqj3PWIuw6Gj69YTX/O/5k72nBRNp4ArEqDLL9vzqmY1B6nx+BoadtHGwS3y?=
 =?us-ascii?Q?M8wuqm0fidPRl6cxv89W6YPczUe9/3KhQHP3CuZy5xj5KJ2EVpkSX6FmsYTe?=
 =?us-ascii?Q?yH/oKoGI46tUSGCh2lccIJl9liG9eFXUmhHfhUSiIVSGzWs069DIkwfN2QPm?=
 =?us-ascii?Q?Qms3VIwI/2lYjRHC/s0plU7O8MWuBky1PdSzin0pfOSUH1vWdn15PVzIxM5B?=
 =?us-ascii?Q?X5k5aQykIq4LVVtqiZpi5vpSA8LqfFS1gUJ77DGqdM1uQPqLL547fyaYrdSR?=
 =?us-ascii?Q?lnUy6Dgk2zQMEZXoYu07+k0p99xnB2gW+HJDYtQLnxX7QrGIW00qztAp+2hd?=
 =?us-ascii?Q?RJh8hxucWjmyB1WwswCqPnLUMaoENcBxAiQ+aAH7BMOeSdkmJh9MqAmVj78r?=
 =?us-ascii?Q?FaOF7jeSpIbw8VhnUhZwuOhFhJYOjgrlg4tHpzEINCjK60NvzLqYkifNk2UC?=
 =?us-ascii?Q?eR9qu0fVYTBn/RU3Gvnael4XWQgn+2JA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7900b9f4-e3e0-461d-a170-08da06048412
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 21:49:29.3201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLx/2rceEV40bH+wEiqgKMMldtrdLV1Z4ZGoEzWYxb/NSNFW6lJL0gcuAyr+dIpo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1174
Cc: kvm@vger.kernel.org, david@redhat.com, thuth@redhat.com,
 linux-kernel@vger.kernel.org, vneethv@linux.ibm.com, agordeev@linux.ibm.com,
 imbrenda@linux.ibm.com, will@kernel.org, linux-s390@vger.kernel.org,
 frankja@linux.ibm.com, corbet@lwn.net, linux-doc@vger.kernel.org,
 pasic@linux.ibm.com, gerald.schaefer@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, gor@linux.ibm.com, schnelle@linux.ibm.com,
 hca@linux.ibm.com, alex.williamson@redhat.com, freude@linux.ibm.com,
 pmorel@linux.ibm.com, cohuck@redhat.com, oberpar@linux.ibm.com,
 iommu@lists.linux-foundation.org, svens@linux.ibm.com, pbonzini@redhat.com
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Mar 14, 2022 at 03:44:48PM -0400, Matthew Rosato wrote:
> The DTSM, or designation type supported mask, indicates what IOAT formats
> are available to the guest.  For an interpreted device, userspace will not
> know what format(s) the IOAT assist supports, so pass it via the
> capability chain.  Since the value belongs to the Query PCI Function Group
> clp, let's extend the existing capability with a new version.

Why is this on the VFIO device?

Maybe I don't quite understand it right, but the IOAT is the
'userspace page table'?

That is something that should be modeled as a nested iommu domain.

Querying the formats and any control logic for this should be on the
iommu side not built into VFIO.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
