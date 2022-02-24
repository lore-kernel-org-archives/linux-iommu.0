Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1A3C433F5
	for <iommu@archiver.kernel.org>; Thu, 24 Feb 2022 13:08:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7FCE940122;
	Thu, 24 Feb 2022 13:08:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CawucbQGebAM; Thu, 24 Feb 2022 13:08:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 496C240141;
	Thu, 24 Feb 2022 13:08:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2273EC001A;
	Thu, 24 Feb 2022 13:08:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E297C0011
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 13:08:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4871B83380
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 13:08:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LHgU0LI3cOv1 for <iommu@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 13:08:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::621])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5686B81766
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 13:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7ovStxpFB8VWiioqu/6CqDPhAAta7P8vR35QPIIS9Rr6y6rYAviz5LgP4xq7mrB0CfdnKNWNZ5Yh3j3BO0pGBky5ujuHP+HocFAnaURM7N9eu4+ncKdOOcO7D0YQg86urfp/PvEGUBYWPmOjgXmxUszqePR8BTMUIeXmGnrt2G3Go0Cu/QpLp2dyqmgnE5/0mdIHxuJdkZz/9CygYwJamhRgmpLHbj1RETY5gRBqgeVdA8JhvXz7n3i6or0/R5j2K5Bun1alVKCK/po6Ef8z/Da/EFbaFDjt+VFrJQLnfjXMhKT4ReXetYci/kxlpPFBiZ/UXTBNPOJroZqWv1tUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGQqwZ+DiPKB7lf2HLI0FezsuLE+6H4PFN0W/gWiYyg=;
 b=C8k0SYgYeJN4R8aMm+X0YF2erhmU4kacS6qjyQw6nB4Pp+2iYekt2bWoNQx+DUoriz99oL1oqOiylB5kiWCSas/dy5OrXx/TDjXHfWA9aqWltP1GdPz/cfgv11XNq4/bwev7VSqWTDxpOBa4PGXAbaqyfBsqzOJVTXjZSUcd/Jk/SCfCDKMoLOsYhoua+BRkBtQ/6MEbcshD06ehWYqe26QPDJbEhw39x8v9VQw8CzY7M1fA37YZIbItVWD4R6SRk2gADVVWv7a3DLfo51XQrhpAYSKzm+GQIMI2edtgEyu/5voKE6nur3skMBV8KoYQoReVkD7XAOnA8VTIOYqaNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGQqwZ+DiPKB7lf2HLI0FezsuLE+6H4PFN0W/gWiYyg=;
 b=PNboHBIh7OfTdE3CxyNKJrcdC0KCjBhWlX6n+IClBcwfCHHQEPqJgeylKwdoBO3sdQU2r0J+jhGXtbYSdWFINliAOy7xxOtO89cAgCqRzYdGwgoKM6dbTM1aAaGcnIOtzWOuirfOnuwA0T6h4vQJYSXX39IT4W/UJd1+pJ9vxM/SsjYc90gahlDnt1puhS29x53lGCmhxZPiKCFwN/PFKk9lb5I4xCEv9R7zqjhlt5oEUGNKsBD7DiywyOIlYQer2jz344oDzSksiPrJe51WOC4HX4/ak4Z8JqoaFviPoxmeckNJK/xiED90Wo6eH5TylNAI9JwKhPSU2kd40pAGqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 13:08:24 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba%3]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 13:08:24 +0000
Date: Thu, 24 Feb 2022 09:08:22 -0400
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 08/11] iommu/vt-d: Fix indentation of goto labels
Message-ID: <20220224130822.GK6413@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-9-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220214025704.3184654-9-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0275.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::10) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7789e55-49fa-4152-5fc6-08d9f796bd22
X-MS-TrafficTypeDiagnostic: PH7PR12MB5880:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5880F0165FC24E735614F209C23D9@PH7PR12MB5880.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3sHndOxAfNjXXtoGYNaf76J2ZFI6Xid1EfMUKeTe+NAUaXqKjofYeeIZfhINv3xIWE0y4Qr1vPgNOQcVLkfQHp8VQjt45/9lFsTd2USMtsVFd9b1Qsyu7Qlq1sCf970Is1tv6ULNgcufl3qa/OmtvnxNsIjl01XEfucSgq/Y2Qal1YsG6yGnVEzuhsjPJOF1MhpsFGkT/nQ5xZc4Rb3eCFWLYE7641R7eMXyZ306sVNEnVYzo9vMldqoEXtAxluDPfFN8xKnheFsv+Kqc5hGaD0EuMTO5hPW5toiHdkYWGTHMSiImqRpLDrwPDXCm3vuuR3ss7EIUBqp3udJmAVr5Xatzoc8wqibNwjj7Z/sXn8/fE/YYXBPorVhsm+47TYc62ggPUMEtftXRDShqEltj+q325SGMLXiLQb6/fhgm3Vou2Q/kWnOEiF5/ChztvZyu+gcCHKBtIbAA8q1GfgjHfexCXS5MfFuiAcuXVL5hNH3fz25jD5wma2t38QmUyQVFNmYv/xbNVm0p3fbzZbHE4C0GPC+Z/P/ZVv0olnqxQwKApuhuvy+I2NOuKM576jLbzYKs/HivjBYra+C3N22UeuZ9wn6FUf/O6pOf6FsmQPxOUCKUMYim8NZ2VFBjHansAIAY83nBTBGtBS7Y+Bkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(1076003)(54906003)(316002)(6506007)(26005)(38100700002)(6916009)(4744005)(36756003)(186003)(66556008)(6486002)(83380400001)(33656002)(4326008)(86362001)(66476007)(66946007)(508600001)(8936002)(8676002)(6512007)(2616005)(2906002)(5660300002)(7416002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F/Q/swX5N70+Gb9wHy804aDXA3mtogbyzywOHZdT/XbumHpd2X+EWAaWEg/p?=
 =?us-ascii?Q?374givYe9aChMw6bovxI6N88E+ksSaI/qKJ590PyyN14w/FFZOurI/NJ5ekZ?=
 =?us-ascii?Q?fMVUSxgKLemh2T/LC5Kv78RO3eLw9LHuj/k/uWzkF9dIYIvmuiZhthEc1AA8?=
 =?us-ascii?Q?QpUF19cAZNsCdpdn0DQ1nzKwtGiIxREDfe8J7CnXFnORvKOHEKRMKuJEWlho?=
 =?us-ascii?Q?4rm6E+BWLh9wq6KVAIwcY/Fn3fN8JBQnT1XCTl5EEJOTzjEDvedycwjx1wMu?=
 =?us-ascii?Q?KVVJf3wrLb0wJR2G2PEfN4YQfhvmPQ52/yBd/VFNWxu1E3/FAbuvFZUEaSiH?=
 =?us-ascii?Q?ys59B8PmjBvNkBHDAoFfTvFwCT1XJTHrdiK9fJHv5EjarwVrAODhqzDRrQmE?=
 =?us-ascii?Q?VtICG4GPtSHhl74juQQmfs43VTsxhei5wMyWX8emYA5h5L064sE4PfqIKpSf?=
 =?us-ascii?Q?L6mqCn+TCwIbLcC/9Rc+AEeGeplhAKtdHt62e9bGykEBZ2vv6Hsv5/ltp260?=
 =?us-ascii?Q?PqW1ziSHxpja8GBqmxHpg6aOslP6un6HOtBG70YO7L9jxhO9wxjwfjsDcpqj?=
 =?us-ascii?Q?ruH91PO0NFPximv597EMB4c/HzjSGTJegkVR+QgoJJCFm04VDc+DEG8uGphI?=
 =?us-ascii?Q?TjBveCTi7JL28GNdGKJHaNaqTznBQ+xGvu7RplAhBt20WuFWFiLnMIMYa6iA?=
 =?us-ascii?Q?ZC/Jtc+A9b69+Ii9HA8Fb/ubQiwHf6Ak/ZKBVtRo2e/TMq+yEJlSmfkljBKn?=
 =?us-ascii?Q?FDSpfuCKohnconrs4nH4QoG2RrWjdCPdYmws4+ctw+uPrHyzzRoFcDBTgpUg?=
 =?us-ascii?Q?JjSHYjox1xqP1ALYDdjubFXF/3VpXddsHHYnmZN2/kNHVaxkrKTXppA9Xavi?=
 =?us-ascii?Q?JMUJreI/39nh/vPmWN7KHd+eQuaaFV9vl+ViJHQvP4EWULtmkEJo4GQQp1/P?=
 =?us-ascii?Q?wG3IrmfAf9k7oa2DLaoenyiqoR8g0CyPXdhBvRJu3+c54xpJvqZ0WLRtNFQO?=
 =?us-ascii?Q?XVmhmeoPDLcio1Sxg2Wd1CgSSJ+HLUZOt+F8uhUcs1PuyLun3bac6T8Knscq?=
 =?us-ascii?Q?fpI1u2vEMDnnNvJdBU1lLKLfpdnL1bfDsLWBtDVJnDNGFaevLTMb7Kh4Df0B?=
 =?us-ascii?Q?kUZ8S7p2ucmalLau0/KxJnpcKbsDg9obCl48Ex8USSSKWARUZm33lN1TLq2P?=
 =?us-ascii?Q?iXrOE5S6ZEQJSomtp97gMynJm/i+cuyqOH39Gk0KljwRjZFriE7GYBlYCM6l?=
 =?us-ascii?Q?EKAQhfDqBJo97HFkYImZkhsHxKNGaKrk0icLsTR5g0ymCp/NcbgBuJMKLlx5?=
 =?us-ascii?Q?qRH+LTvxq+D5FhbFX40uKR00fruGtV3Q5QBDicSzBcLsbGuBPfDU56PXkoUX?=
 =?us-ascii?Q?i+88XGka/jnhNMasuAoRX8Qsg2q8vcg56az6/Mu9TB+7++j9mGwUQVaSHspn?=
 =?us-ascii?Q?qEl9yixezwqFz6RY9WV3dmfveA+Hmk/6bNTwd93SCFWjMnpv2POq2tP1jBHr?=
 =?us-ascii?Q?SD9rDA8Lfbt09tA2+/BL7uEzC4k66WFBIg96wzma6ERwSTqOeBoE4U/gzx4U?=
 =?us-ascii?Q?3O/i7iV64BeutFVp5M8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7789e55-49fa-4152-5fc6-08d9f796bd22
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 13:08:24.1031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSxLKfHjtJa0qwuI9dLBAmAYRFBoReePyCSee8E/91h0mk6o9ZiePLx+3rdB/TUm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Mon, Feb 14, 2022 at 10:57:01AM +0800, Lu Baolu wrote:
> Remove blanks before goto labels.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>  drivers/iommu/intel/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

It would be better to rework this function to not have the goto
spaghetti in the first place.. Looks like putting the
'for_each_active_dev_scope' into another function would do the trick.

Anyhow, this is more consistent with kernel style:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
