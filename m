Return-Path: <SRS0=ekvE=HY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CCBC433E0
	for <iommu@archiver.kernel.org>; Mon, 22 Feb 2021 19:30:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F048564E15
	for <iommu@archiver.kernel.org>; Mon, 22 Feb 2021 19:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F048564E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AEDA18702B;
	Mon, 22 Feb 2021 19:30:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 58ejBRn0P3-M; Mon, 22 Feb 2021 19:30:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3239486FC1;
	Mon, 22 Feb 2021 19:30:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1562AC000A;
	Mon, 22 Feb 2021 19:30:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F9A4C0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 19:30:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 25F1D87018
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 19:30:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PtUINv2ecwbd for <iommu@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 19:29:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6A39786FC1
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 19:29:59 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MJOPRi162835;
 Mon, 22 Feb 2021 19:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=b6v5oMIYooQdgCRtJDZTUO35WW9Y8gZH3Ds/L/jHIWQ=;
 b=p/3KGMWrRsfbUH7nI1vco5KXPvoIvjG0lQraT8riqmHYGincBl57/h/KfHHwr83bT2ti
 qEhiiPuPpXyEXi0mNK3P5gMGT72lnTDLDUMJUzmSx3kD+JipeVmWnSFX5kdAI7qlU9x+
 OrKRB3gfBEY8W7CftYfwSWwHWkTWUTVVh6axAH7OkX7URIKoJp1hpYTqHe4InXS4OuoO
 yEVmnXjnHKXzcOOY6vM4M3LghOn7DzLgquom02dYJb7UfB4iWEkICyPb4RU7KQ8qISaR
 1qCHMQGBNHKbXAaJhnkjjsiHmwQi9diJD7HzXx+pvOpfGeyyiTTSMGeB6oNTYt8On2ZU Dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 36ugq3bqmk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Feb 2021 19:29:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MJQRVK161545;
 Mon, 22 Feb 2021 19:29:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
 by userp3030.oracle.com with ESMTP id 36ucbwh779-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Feb 2021 19:29:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORcj1EJVDi/xgQcsaTtwKoUKqc1G4+6pQJMIrkjUgspNOS+iEaKtGvX6Syvl9TtZ+NZarJeUyLX1DFkYH2YEJ1WpaOFekreOkHqlQpWcLGcgcjpapZZoVGg6eV73TsSP6pBekvIrfuyJEOyicKBBKc+w2pajpvop9NxhA0rdi/EUrlpx8ZZufTsFSkurc0mqpLdPxLLl093bjMPri4NHJE3QHhtFuFuniVwKkmKm6DGlTzADxnAhuuyMW1eAZfw7xKkkQCIsPg50vX23ybyOC2EBwac7XNeWJkJR10goPXEUciQ6GEc6h8vQ5iBn2vlN62w/qXrmsmiUuBLrR+P9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6v5oMIYooQdgCRtJDZTUO35WW9Y8gZH3Ds/L/jHIWQ=;
 b=ifMvAAm6iUE99YA348pHtdccwlNbUvrPw0qO457E+20hhErkYv03msYEnAo+Kb2i5Re3J3QHatoZM/nPfOg/VdKmicjj2uGqqcjTbnswRi9BGFHnk5D0KqoUmdro//4yAJdWj+4hEjvidANFZ16MZ6NxD4pXeXXbsheWFaSyvMMXMimzGXFiuioNOnQom3g/EuS5lrdO98HIZI+FypwHnU2StNQbznxN+1J5ogTLzn2szQPRqXRfBh0YrTEQEDIu+XhcuHesAqAVYdjJajTEab1y5CN3512WLBkcmnl82Uc0rwb0o5e9EpaUaZH0EbOqrLmUGHM2X5ZwlPrPgn4LCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6v5oMIYooQdgCRtJDZTUO35WW9Y8gZH3Ds/L/jHIWQ=;
 b=tUy6+33RGRXaqERXlaA8zBaZX7DAPDdi4I33OiwmgCEYbrM2hd3jsH7PAiWMrGyjo2T6XyXUs6kvMYaZ80KUpMM+9JKTb/x86yJqHCxJjRuvGRJLZTzhdbgVI9W6NRVDL1XMDF+AcoVOieVBwIhj6E+uauFVnf7E5YCEh/tTv/o=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB4372.namprd10.prod.outlook.com (2603:10b6:a03:207::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Mon, 22 Feb
 2021 19:29:42 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 19:29:41 +0000
Date: Mon, 22 Feb 2021 14:29:37 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH 6/9] swiotlb: refactor swiotlb_tbl_map_single
Message-ID: <YDQGIb4YqFpTKfyB@Konrads-MacBook-Pro.local>
References: <20210207160327.2955490-1-hch@lst.de>
 <20210207160327.2955490-7-hch@lst.de>
 <70edceb03e4bf283072397f9563dfc4162aec92a.camel@suse.de>
Content-Disposition: inline
In-Reply-To: <70edceb03e4bf283072397f9563dfc4162aec92a.camel@suse.de>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: SN4PR0201CA0046.namprd02.prod.outlook.com
 (2603:10b6:803:2e::32) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (209.6.208.110) by
 SN4PR0201CA0046.namprd02.prod.outlook.com (2603:10b6:803:2e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Mon, 22 Feb 2021 19:29:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be715bc5-63f2-4c12-a879-08d8d76833b6
X-MS-TrafficTypeDiagnostic: BY5PR10MB4372:
X-Microsoft-Antispam-PRVS: <BY5PR10MB437269083A297300C825D5DC89819@BY5PR10MB4372.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWmrt9ssRPY1FzzhlURf4EPKQe59x+4ZEe9/QSmZ86vt8oyBUrtTjae5Ic7GANxmaYta8kXHmOnzLqwTV9FTz3F7yvJ5QOToBi/UyYoB032g4WAzI19ehZkBBJQcrlT7EKN8s86dAdxF2earPC8VoaPGZ7oKfSXPeSmHBQWcxCw3DPCy6pYAQKwzJFKP0pHnIhDRtpHDtcon0wdRfezTHbn8agcmxWPSlhfYzLQoEgoTRMA/tq8yCVwIPkCHMbJPItiOZ5ny9ofBKZC7Bwub/lRna8D8Z+l6C242+oo/6dZXvad83ruP4r2CiFXt6sDhr4FQo0K4jcv4IxPfp9HjFZwgm166ZBoGzLKPgRx4gCsUPvhmeYSXH+v89nwMuJ3OqoQ0W19jdFM6uS8FmaRFNuXlLywcp8Io4YxjLdWXFUUhd8to2MAnkD5jK5DWGjuTT/DydmDv3vwKvftMOd/1jU5LSLVwgnB+VFxIO2Sk4cm4NuHjEkaHmghP1Z1a9pNNv+/c84AwMRc7K/Wp8SY8mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2999.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(376002)(396003)(39860400002)(346002)(136003)(478600001)(66556008)(2906002)(8936002)(7696005)(55016002)(52116002)(86362001)(4744005)(66476007)(66946007)(8676002)(186003)(6916009)(26005)(7416002)(16526019)(956004)(6666004)(316002)(4326008)(6506007)(9686003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nf0mvmZ0Un3UvClJyECBPzrZfGKcG4kWrpnFrOYD1xmffr3UDBAyKiV49Dc6?=
 =?us-ascii?Q?3PAKeTxrUj4Z6XvKpfxxsZi3q4EeXDI+v610hGTDYT3MUSf3D1t4vK/4xcXp?=
 =?us-ascii?Q?PRfIULRKoVKgzlMuZhl/S5WALH43WkqMbe+8b8T1Rl1P1D/xwIxSZA/Xv3yw?=
 =?us-ascii?Q?tGSClqimRSbO2DypvDDLyOFP63RKPRtKl3LezTCmOlbp6BnFqzF+BI/UbgxE?=
 =?us-ascii?Q?cwRYxFkOwDABD2leAMoM2YCE10YOS3shWAE/7jCFOUQYRrWY6OiopB4c84vK?=
 =?us-ascii?Q?JvJ3slOHOnx33TlXzmYRjHouHuDxpjj/AdGJqr0hUSDd12/PNZtzrkHNmQzs?=
 =?us-ascii?Q?xaG93Mofg29wlWAEdTaSqgf7yV++D5wEPXKZ9U47vPwZe7RPUJy5s8Z1Jeu8?=
 =?us-ascii?Q?4PZi8KF/NHCxfv1Ey6cA5FkaWuUc6yWkJFeS02T5j8OhcF6c4zHxZ8astRxa?=
 =?us-ascii?Q?S1/pNcpKceMeJrpBlgzpwT2xjaZWBzSoyXi20y/UIze7D7VZa1hd9nuz0F/o?=
 =?us-ascii?Q?LG8NgMEFxHDrnbIEu3/u3/6F9rTdHjrcLd2ehb7HGK3lwcvsWoXelUSGsjq/?=
 =?us-ascii?Q?DxkTpHAIqhgu9re1nriO3ZXj6eW5YWTqg2iQj029pOP+xSwX61gSv4je0Qjn?=
 =?us-ascii?Q?kWpm4xW4FO3uhU0PkUqdbsDLztXCFVttY2C55IXoNe8hOCFvN8+voMJec3i7?=
 =?us-ascii?Q?TWvawpoN5ZB0/IIwWKLxPO+HVQc+2CVR8Ap3VqHk+43rje/MeNC17be5Sfs5?=
 =?us-ascii?Q?2eguOsRCT3w4oiCp0zjYFN57yUaUkpCoeh5IEAsjkiE9LMGcRjKUYqh+zkFQ?=
 =?us-ascii?Q?henvDapKJx8xWyhCxg+Xtwb2Bm71P6elr4mZO8HhlYZVL6iWL7PjWD/Ze59B?=
 =?us-ascii?Q?r1aYgZ7qUaioKwHEVI9oEZ29L5x48rkdmhlGmn/fJZufqz2obDv3UwolvZEh?=
 =?us-ascii?Q?OenP1+fm3MIMfH3N5HWbcCb0QeiKsY0CubK4SRwmE6cSZnUATLdRjCJ9/HSn?=
 =?us-ascii?Q?2Q+2cYbGyAOFOU6XhhmQ35tqOEazlDCCuTbqEQoEbSSwD1M69IH58jLXY5Lm?=
 =?us-ascii?Q?dUTYqdc/Wh2b5fyXMLCXPbkSoLY1TShtXRmkTCxbRqVe4Y90GF+/t1R4BBlo?=
 =?us-ascii?Q?SUbYLKQsoiPEnCbe8BVOtrS7bs6IVxPVp/w7zdjFqOvWuqwwb3jOxoUtSUfe?=
 =?us-ascii?Q?9myyfrsAIUOcbW53cMim6Q/SFHZ8ItZyGHaaLRu4cblnAGmJk/X+fchvIr8B?=
 =?us-ascii?Q?xEViDMO1A0LLyHHrUa7zAcsMw9SiUHMQhP5RKdLmUxkDJrurdkNQBZN2Jx5Y?=
 =?us-ascii?Q?iZw74pCgpsxgFYpbXmbTc4/m?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be715bc5-63f2-4c12-a879-08d8d76833b6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 19:29:41.9053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0c+T/Vs34spt0DXZ/9Mx9w+fJrsW6XBT9qh+bywQNk5EYnO700Gj89EoTyxqzQrYkQa5SCQOfcuzGHlk0nsa+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4372
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=944
 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220171
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220171
Cc: saravanak@google.com, marcorr@google.com, gregkh@linuxfoundation.org,
 linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
 kbusch@kernel.org, robin.murphy@arm.com, Christoph Hellwig <hch@lst.de>,
 jxgao@google.com
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

> > +static int find_slots(struct device *dev, size_t alloc_size)
> > +{
> > +	unsigned long boundary_mask = dma_get_seg_boundary(dev);
> > +	dma_addr_t tbl_dma_addr =
> > +		phys_to_dma_unencrypted(dev, io_tlb_start) & boundary_mask;
> > +	unsigned int max_slots = get_max_slots(boundary_mask);
> 
> 'max_slots' should be 'unsigned long' here. Breaks SWIOTLB on RPi4. Do you want
> me to send a fix or you prefer editing the patch?

I can roll it in. Thx!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
