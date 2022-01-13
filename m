Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2A2C433F5
	for <iommu@archiver.kernel.org>; Thu, 13 Jan 2022 16:23:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABEEC84B77;
	Thu, 13 Jan 2022 16:23:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ByzMb_FPdkHE; Thu, 13 Jan 2022 16:23:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7D0AB84B8C;
	Thu, 13 Jan 2022 16:23:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D3A8C0038;
	Thu, 13 Jan 2022 16:23:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41F08C001E;
 Thu, 13 Jan 2022 16:23:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1ABF441699;
 Thu, 13 Jan 2022 16:23:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XVgHISyv9DzF; Thu, 13 Jan 2022 16:23:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3171341667;
 Thu, 13 Jan 2022 16:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXupAUNtVNW/ikThdB//oewQcI+7ygisahdqB8mzuapbXrBhkJ6J5VfWymKGvrn7eoISdqHTgZRkiGjyh14ewLdWHHZoZI3OiID8o34GBUcUwuZ/wlCstGmclkaVrRsS/uxJATNeB9GQoPC391NYViJPaXO+mIN09TtgJ6+iPA783rB+irpMOuLVTJ2gYFe1NrLMlnmHFNXrZf8QFISJ769RJRPQaBNmx/TElQJJBeZK692EJANhK18YR3HhA1gmc3xyr7U7GZoApvr/Cr5xsgNNkp8Af07R/v5sOyNqymjUFw7vUFgeMt33wk/5+tkEdQD+MUnwxkBNkv9/iRLCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWF91S0CikNzG+ZBTet7wo1Octtg/sFJyuuCs9R0gD8=;
 b=HGwXLraO+eUbr+6/0/nA2RbvRhjFB4ykc5YZiunQJ/JTRqeBRXzXkC5n8uM2r+Pzj+OJ+BgajIjwU4Y3+93C27RoLd2+ebLSgLBcd/RsrIil8XcQkTxE+8L9Ie+E1ehCaDD5wKrekvQTmQeM9ulgYwu+psamEGMjRz6JN7c1xpL1vQF/38Fzh0VknTyOvhRx05IFqJtqTguF3mukKlZhpZlDtfVCkRROXb+jv9Gn2MP8ObEkCyaJ64n9V6AQfq3yjQaVlwdfSCyOyu+2PV+oXZ4bJOk4a28jT7FVSU1BWgCnBFnOye95W3zUzUfzjGwNB+ATc2xqMQ8hyO674smIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWF91S0CikNzG+ZBTet7wo1Octtg/sFJyuuCs9R0gD8=;
 b=idfGUnJGJC3Q8tEjIVWq/tLF+xIycVBJknq1tV2niarZp8aMIXMEltex48Iro3xXQermxoP0YvzsZerJK4HugapIoq0J6yHJqNppsz6rXQxylfKKrSszkp/qsisnWdIY4wNvk/saotSrQK7gHMLIx2UCK1O4rJvjke4V0eCQs5xHQM3BwN41FzdRVJY/W9xg8GdruIid9OATjBLeHPG1U5QfAmK8kgSqMASdE5ohOAP2l9MlgQIuq5BD0WUXyiQG010kFk7hMQ/tRAakbXjedKrCBKuNTpExF9ySnCcOF/aptg9M0P0op0GD3NO2bRfxfvsJhiyYBoXRgAqcDykCiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4637.namprd12.prod.outlook.com (2603:10b6:208:3e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 16:23:39 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a9db:9c46:183e:c213]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a9db:9c46:183e:c213%3]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 16:23:39 +0000
To: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH v3 2/8] mm: compaction: handle non-lru compound pages
 properly in isolate_migratepages_block().
Date: Thu, 13 Jan 2022 11:23:37 -0500
X-Mailer: MailMate (1.14r5853)
Message-ID: <99D30A79-7B57-4FCB-8C7A-7F93B66490E6@nvidia.com>
In-Reply-To: <71108865-5368-4725-AA5A-35A57C350D77@nvidia.com>
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-3-zi.yan@sent.com>
 <a5e029e8-f646-a414-f4f4-ba573171642f@redhat.com>
 <71108865-5368-4725-AA5A-35A57C350D77@nvidia.com>
X-ClientProxiedBy: MN2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::15) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab17cd73-f38c-4fbe-6f60-08d9d6b10eb2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4637:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB46373F0627C37CB43464A2D5C2539@MN2PR12MB4637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ft2SL/3Zfp8vlpzKPxYWwoYJ3SQeTAU08I5gvlBT1IShEVkGUyC9yDgA/6cDZx0QTsP0zw15WCNe6DKwBMX/+hlKdU04Fpw/fxConrS0NJqUSxrXxvHY8y3s+YDRAqmtMXWg3nFmCGN9bx4E64/thwGNjM6lqzlIbk4duW+3OVAFJ1sYu17AODoR1CMbSVKy3q9knT6AaWuCKgH2GAyPZ6gWNQ1q5YDhEZu+9K18u76R4z0jJ32m9li6nanOP8R5I+Lywh786kPh/UkLIwcGbREAHOJy6c/Tka78rMUTCExAO3MMyiR0TXPCtWuDLzXCwbuj6JuPeUqGX7L3S/mKCyO6BfNW3nc4Z5tpFT3O8YN8zrWneizA9vn2iw0bosXDnyWo+vpjfVqLfJSEY2DanAyiJF03iaNOKbLQjdy0gNyGLW9NWU43oy+wXtAS92WJGW71wvBs7cUCiIQSWDAibmSj3g+PVbBC5U0/yMLK3/OeFwYhI7Uy+J1xcj9yWXmbw1uSEraRyb9VNon6Y/WyzXaZP0ulrHkCjvtThtfGsoGq+BcjyjtHnjN3Fw7f4DjGu9YxwgBOibmhs48C6YUF9q2DRZpQivCfJsDZ1P9dtunlL3IV19sf7LOEFRxx5x95BM4OyW8gcnMwQQi5brhMNJDvUjV9P1Ytawpwsf9JzHN7Fa9rLKwtiMS+o6YvdSMRnANRr1W1CxrQVUZC82pRx5KoCV9swlydiagdIcvPEZa6PIanF8mPuDZg3RwxctElSRxUML/pz0J/eOExa5w6NMYVTYhOzGQ3oVXu9HaSgw+15cSuhnon/TQRSu5gPRB2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3823.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(54906003)(6486002)(6506007)(316002)(83380400001)(21480400003)(7416002)(4326008)(86362001)(33656002)(36756003)(66556008)(66476007)(38100700002)(66946007)(966005)(8936002)(8676002)(2616005)(26005)(186003)(6512007)(6916009)(5660300002)(235185007)(2906002)(508600001)(72826004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TpfSgzn2RU5Z+IuegFaTKSXjk7PMPiUz9sMighlAK/neqZsQG9PlA3Fkw8Pw?=
 =?us-ascii?Q?xIKX5zl1pUCCuzBriDzD0hSEmsYvQIpyDADMofkIWmyuX1OimKFJbrBfekxp?=
 =?us-ascii?Q?Xb1YzvOTxsX9mguuh6XBujvNtHbtotHj7SVFnZeT0MQhsjyhDrZzpvwM5QXj?=
 =?us-ascii?Q?RJQlI0Jm/rJMbEZ3ffXNVHwMA2mrUnGbsJetC2nY6NQxTsmybUuFWhmR9J6m?=
 =?us-ascii?Q?4ijThbVcBi9jKTpEhQshqpuqPA20hPrQWsRGosu5diefZrIU211dTOsMimf/?=
 =?us-ascii?Q?SnOG/jC6yjkmX6lcCndwMolB5tyY+PMkNO2ZC3yuFWN0IOzp3yILSjgAq+3W?=
 =?us-ascii?Q?A6rqK7j0tLY/qicIBwCrIN3byv4vF0h79CR1QzwIoBIDu6BrAMq7OXIRPzc7?=
 =?us-ascii?Q?uOzTTf+iObj8VFr3Pj8TUJjR13cuiDcWBNmUM7B7ect61BfosbQq7V761TKg?=
 =?us-ascii?Q?KrEz5+fCZd8XEu64z6yUk5QenrxkEoTBSw6rmQKbDsQaJBd3viBSWu11bbHZ?=
 =?us-ascii?Q?WR9lhahk5DbVraXbGJScVwocdaetv08Ls2kF8dTpbvc+eirkijR17pnyVXIK?=
 =?us-ascii?Q?Q6mDHmbefzWYFJ1pujTw3Tw5VKeS9X6Cfbd04tRw50ZVdrVDWlGYK0k6/Rln?=
 =?us-ascii?Q?pUkpcttu/T3gzUIHpbxwNmPyicKf8SjgMp1CfFiUIgasff3a8yrY+e9GPaNg?=
 =?us-ascii?Q?4BXrzKaaR4qwFD9IBRyMQsDHZXHQZPxBUee7uQ/Tabi05zBk/uYXfiH7OYwc?=
 =?us-ascii?Q?xeKQEEDIBHK3ngrhk4XuU72IGUwSTKwsHeQMLBffrwqXg+dQ4lwJ2OnnY5hi?=
 =?us-ascii?Q?wxy09DzNt46HEelSncmtPUNCl2gE59bzAL3SfD7VGXi8vrnJtPVo9kPuFRix?=
 =?us-ascii?Q?yRjgvXMw3FqQAeQjkFjD8ZVfCuzqB0nRBA+QoE/AEY7mEX6slozxEeIeWBdp?=
 =?us-ascii?Q?hnpT81iUFVyYKYdK1kulfOrMUDKx2BGy1+dOHilS56CjGWDRQKRpaBrSwkJc?=
 =?us-ascii?Q?9GPQZniT8nzyoBnJ88uvxkMoWpyAn6vxqAn3R/+8UjEPavqg27XQTfbeHKp5?=
 =?us-ascii?Q?9IJrWGJZbkXQbjtOYLH88wXdDVGrfiZSU8avsfFkzX7j7wQ9ApqNV3otKyb0?=
 =?us-ascii?Q?guhktO2iHlBrtLv4Y81C4mK5JntwoEK+mRRrctzxgubKuMC8bxwDRDBu9KsN?=
 =?us-ascii?Q?AzYq5/PVXR5mcq53wa9E81dn9Sq5uHNNGfN36iDo0QHGW6CqG0maYqH7OyQx?=
 =?us-ascii?Q?IuESs7NlHSgfzHQzNq/VVQli2fyjflz+SzqyIjCccKGJsBQCu4H9K729nNlF?=
 =?us-ascii?Q?e1js3ILMg/T0Yi5RT8TAfcD7VfN+nrDbX6EDebaX5V9lxEHQz7BkcOff1WLL?=
 =?us-ascii?Q?11+4H421CjA5Bi6xspqhpmM6dEoV1HvUrciscLBRPdKeEwwkrCMsOkoOd+px?=
 =?us-ascii?Q?WFw0vcUDxqj+5FzQP/NiKkjLB0Mu9erv4KwVpbNTZ31U8sb5lpQMx+gTj+Ww?=
 =?us-ascii?Q?MFybLxzaVNpWPp5YMptkA2YUqjrQyLWAjr5RnCBDTqxj9Ae4KcpGA2KPQvf/?=
 =?us-ascii?Q?9r3OH8ulpQnBzO+5Oik=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab17cd73-f38c-4fbe-6f60-08d9d6b10eb2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 16:23:39.5484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 152eqzJOxbMsaXhGxTAna4VX/pQQafU2rGuVGq9vE/FX86wT1oWVHDnGgAJfCHv2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4637
Cc: Mel Gorman <mgorman@techsingularity.net>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Eric Ren <renzhengeek@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, Vlastimil Babka <vbabka@suse.cz>
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
From: Zi Yan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Zi Yan <ziy@nvidia.com>
Content-Type: multipart/mixed; boundary="===============5679185002401539028=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============5679185002401539028==
Content-Type: multipart/signed;
 boundary="=_MailMate_00D2A4F3-896C-489B-A3C9-7A9A87B83B6C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"

--=_MailMate_00D2A4F3-896C-489B-A3C9-7A9A87B83B6C_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 13 Jan 2022, at 9:57, Zi Yan wrote:

> On 12 Jan 2022, at 6:01, David Hildenbrand wrote:
>
>> On 05.01.22 22:47, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> In isolate_migratepages_block(), a !PageLRU tail page can be encounte=
red
>>> when the page is larger than a pageblock. Use compound head page for =
the
>>> checks inside and skip the entire compound page when isolation succee=
ds.
>>>
>>
>> This will currently never happen, due to the way we always isolate
>> MAX_ORDER -1 ranges, correct?
>
> You are right.
>
>>
>> Better note that in the patch description, because currently it reads
>> like it's an actual fix "can be encountered".
>>
>
> Will do. This is a preparation patch for the upcoming commits.

I will drop this one too. Like you mentioned in [1], there are no
non-lru migratable compound pages. This is only used by my local
test code.

[1] https://lore.kernel.org/linux-mm/970ca2a4-416d-7e8f-37c7-510c5b050f4b=
@redhat.com/


>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  mm/compaction.c | 10 +++++++---
>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>> index b4e94cda3019..ad9053fbbe06 100644
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -979,19 +979,23 @@ isolate_migratepages_block(struct compact_contr=
ol *cc, unsigned long low_pfn,
>>>  		 * Skip any other type of page
>>>  		 */
>>>  		if (!PageLRU(page)) {
>>> +			struct page *head =3D compound_head(page);
>>>  			/*
>>>  			 * __PageMovable can return false positive so we need
>>>  			 * to verify it under page_lock.
>>>  			 */
>>> -			if (unlikely(__PageMovable(page)) &&
>>> -					!PageIsolated(page)) {
>>> +			if (unlikely(__PageMovable(head)) &&
>>> +					!PageIsolated(head)) {
>>>  				if (locked) {
>>>  					unlock_page_lruvec_irqrestore(locked, flags);
>>>  					locked =3D NULL;
>>>  				}
>>>
>>> -				if (!isolate_movable_page(page, isolate_mode))
>>> +				if (!isolate_movable_page(head, isolate_mode)) {
>>> +					low_pfn +=3D (1 << compound_order(head)) - 1 - (page - head);
>>> +					page =3D head;
>>>  					goto isolate_success;
>>> +				}
>>>  			}
>>>
>>>  			goto isolate_fail;
>>
>>
>> -- =

>> Thanks,
>>
>> David / dhildenb
>
>
> --
> Best Regards,
> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_00D2A4F3-896C-489B-A3C9-7A9A87B83B6C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmHgUgkPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK5FMQALOMRAoZNz8wqr/FszEJvt0Y+/WKSOwIp59F
xDsF4QztnneizNkbmSdhf6+KpxdyYK+xyOSto8LbgY/Py4WjMy9j/rMZuyZa09QR
zx6VX27qZRQoDxypiWAzOg/k9l/7LeTSR79sOHTRNDVxcHzH9Jci1PKD7myMySe8
aia8NMwhWWnUzMmqVlCsZRwzcHs9jjPHuMgIdWLtUTxA97V1eTFrJPGkxgzNZRBD
oySQIhl60LJxniiakcb4/cLQQr3SJvCIz6DDYGUcK6EbYuJ4PbciVMfgF3skiVnk
Tv6IErFnlh6Dkc+sjXc2MAgbMkJH2KpCyqV9nJncvF8MR3bfymUhaqia25wCWTk3
c6+iWSpu3Qmp1sjCOnCwMvNAgzqVIJ1/LYEzEGh0UbhgYY9j/p1rYi3G2NOtQkmc
OmqKzUYWFhEAY1PyERHfyWWd8ViTKn5DkUsOXY5WHpPw16XIL7n00uKzFENUZN3K
pM32J2foG48YWZBKCu78ljfXw/XfQlYgNNKdEJXSV5lCcekNbzYhYmAGE41lC6e7
H2BaNrcqm0iklrXOAmf10TuDbWb7iAUeKoo3XKKAO+QY4OIEnGuppunRA+F2RW2D
i6KooZGOZfl7Wspdh4U1Z7Zfg/zCcGXVqYQlvUdTY5LVr+8ONrv4yTxAr2no1BZ+
X8oMlNqi
=99D7
-----END PGP SIGNATURE-----

--=_MailMate_00D2A4F3-896C-489B-A3C9-7A9A87B83B6C_=--

--===============5679185002401539028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5679185002401539028==--
