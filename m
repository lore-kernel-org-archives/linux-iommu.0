Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F4BC48BD1
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 16:50:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67951613C3
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 16:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67951613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22FAF605F5;
	Fri, 11 Jun 2021 16:50:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eH0CplPLef5u; Fri, 11 Jun 2021 16:50:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D9810606F5;
	Fri, 11 Jun 2021 16:50:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC18AC000D;
	Fri, 11 Jun 2021 16:50:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66DECC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 16:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C4F683E49
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 16:50:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HjCLbbRATj_2 for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 16:49:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2073.outbound.protection.outlook.com [40.107.95.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0356C83E37
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 16:49:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1RHJKOgJ7NjU1doeBtutMZUXVxEQwE0+HpaoYxjOG3tLaudlBEnKSkvlOF98yGpK88pT3yBkiVFgxreX2p6KMaBHHxgpITrUYr36AWczB46vz+ECC+rHByI5ScgzfHGpg4Mg67zEp7c20LctbcXmLQqjaEAoOqXhN9nMtbi0aCX9+YmH650rLyycOLgK++/fzqoTrV16Io5AChy1BdH3Qkmv1PCx6neQB+qPHwNgf6UdYXUYLn9nEPfgUxy2pHL+67EiQDF8WD8yTpHnysEivDgd/i9Al4AtJvO8oPQyGg5nGY5V50Y+Ed58a9r7j8bJlsBWTLhuze25nTnlgqsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PZDTI5qUxThdwXJWiI+pYByqQElapZETqWdP8UDFuU=;
 b=Ow2zGV34CzltH5T4NGaeoEHpBnZOQjYprXgGcbM+u+Ua+kdpT4WiqWQ6o+xMxlPqYTegCxIxPFNK/etfFNQLojzxDKPDaL6hA4+5Ko4MudnoEA7urTMQ4LLUTt5Pyp1JKSERQ6LpeJ9aUMx/N69wgOF9l2Tui1VTsPXNA6dqLJEc+LDoMypxT8aaj05uuoCKz3nrmjcdOLn+SH984zJsEVtrbOQeV75tPw+VBto5awXxT8ceMdrSwdg69R/wSwtDVjjNJox24dh8cTjP4vhh3iWfv2YZ2cUMtQRKufu0Q1v0nDXP5pGDW6aEul7Sg45+GGKjMMsaf5+jIvjyxFkpkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PZDTI5qUxThdwXJWiI+pYByqQElapZETqWdP8UDFuU=;
 b=PrRb/qxHgtq/63qtHlqfW920KDblj09/sAn4M1fEQ2dm9KBuxm8TG8/YO3H94QRlB9J3sxJHDt0nZELFIPeV+v0i8vByDUM8JzamEHYN7HAKpD8rWiKGLaaEyWnUXSe5/n/iLAuMVC9evUqvvWr1bxWhmWMIVGK4Q90VHsVkcVDtWpSXC8Lsw5/2+VpHcRfpYS2xUwRCwHHKkaw9kywyxxqFib3J9qdlhpaIzok0QNzdVWMjTxQEFU8UU+ooTWnahWFgsJMCJHnaqMxN5CybyeEQL23mVIP+wAgNZACNu+TT1/oWdAXq/z1Sv6+dbamdN5OTJQJSl/2R6cUgAAmHgg==
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BYAPR12MB4744.namprd12.prod.outlook.com (2603:10b6:a03:9e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 16:49:55 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::d05:4bca:ea51:15af]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::d05:4bca:ea51:15af%6]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 16:49:55 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: RE: [PATCH] iommu/io-pgtable-arm: Optimize partial walk flush for
 large scatter-gather list
Thread-Topic: [PATCH] iommu/io-pgtable-arm: Optimize partial walk flush for
 large scatter-gather list
Thread-Index: AQHXXT84btg0466hEE2rkvq94oyuZasMBHAAgACy+QCAAD6WAIAAB6mAgAAg2ACAAAWcgIAAPESAgACQdxCAAA05AIABAqfQ
Date: Fri, 11 Jun 2021 16:49:54 +0000
Message-ID: <BY5PR12MB376480219C42E5FCE0FE0FFBB3349@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20210609145315.25750-1-saiprakash.ranjan@codeaurora.org>
 <dbcd394a-4d85-316c-5dd0-033546a66132@arm.com>
 <c600e9b2534d54082a5272b508a7985f@codeaurora.org>
 <35bfd245-45e2-8083-b620-330d6dbd7bd7@arm.com>
 <12067ffb8243b220cf03e83aaac3e823@codeaurora.org>
 <266f190e-99ae-9175-cf13-7a77730af389@arm.com>
 <dfdabcdec99a4c6e3bf2b3c5eebe067f@codeaurora.org>
 <61c69d23-324a-85d7-2458-dfff8df9280b@arm.com>
 <BY5PR12MB37646698F37C00381EFF7C77B3349@BY5PR12MB3764.namprd12.prod.outlook.com>
 <07001b4ed6c0a491eacce6e4dc13ab5e@codeaurora.org>
In-Reply-To: <07001b4ed6c0a491eacce6e4dc13ab5e@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e148353-9cbe-4fa9-1b21-08d92cf8f0da
x-ms-traffictypediagnostic: BYAPR12MB4744:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB474413EDF820C74DF038842EB3349@BYAPR12MB4744.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PB5uEPCKEuq6rElYrqmYRXqVlQim4+N62bOU6+mAhFh0w+RukYMYo68Fem0WQQfpUqn6J0ZbQT2vVogKzcoq8xU+YPDVHAECRZHXtbZ2kPiVPvY9UDQmWPPFcrQPGKkEdkBWlvI0fcTwW7gQriKkLaox/oK/EqLpq7AMgYJ+SQXJaNRnSZMFWEyRhod6FCvPtddoRtw4jasRXpN72BPjfb5UXoSSlzilDkfn+teFmW4sG7fgy/x2cmU3X1zUXXO4Ng91xgwgorCT+onsBUY3piU10V9FkCsJR/Xfa6YbtF/Omt6xrVPAyugC+ObcLz8Av/Y3KQJxc1gIQ6Xn7Rgk8Ou6Jp8qWp9GejqWsnWeJ2sVnbt1mr7qphk5pFVI16JTitV5rrCDKNYA4atRUhi4YiHgxTGoHTLUCimTQxbbKacpeeBUrHadmvSa4yfo8nTpO3IbgjWYnZXdFB/PU6l26j0gqXa6hXEWYzb7xDYc+MGUsNFzBQ+BHin8iB+w49kxZ2AU6b9B/hSzlF6Jh23SN3fEJwCD56ZkLeJssgoKE78jyk0MFe4A5xh+LwsFwEVKzXrkUtQoYbVH2G3/X+IiGDaeOlk6V112aHKkguA/8jc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(76116006)(54906003)(8676002)(8936002)(83380400001)(316002)(71200400001)(107886003)(86362001)(4326008)(9686003)(55016002)(66556008)(66946007)(2906002)(66476007)(66446008)(64756008)(26005)(33656002)(52536014)(6916009)(5660300002)(6506007)(186003)(122000001)(38100700002)(478600001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J8QMuYNSWp6zXWuQyMMTOPxL49BkmIkJX6TvzN1XUJJRLMOXbi6YWkfWRopu?=
 =?us-ascii?Q?+YbvX7DDu4sG1BhsWXJJOH2tt/i29/fOvi9D+XmwDz7jF5IHqDe6/HItEivh?=
 =?us-ascii?Q?VmRQq7G7tMRaIYChmiJSLJUHnOQxg5t3orlIAuqw0Vq3MEHBRnln2jmjA9sM?=
 =?us-ascii?Q?jmyvrwKfy0S1dHXZbAeD7s6fYnGtLq8G9+kawxHnUPifA5rnrj565NtprFIW?=
 =?us-ascii?Q?KXk7CM5gARmiPDdqQcjjKX7wgjMBYLzJXmQiE8blRczlDSAlME8iyKR+N0El?=
 =?us-ascii?Q?dKpMgReBzAG+C978Bwv+7JdC3cLUFeWA97FdqBGVkCm5PSJCXn0tC4WPuzh+?=
 =?us-ascii?Q?cX6ZdixpK1iXWPwKHw8Fais22LmXc42XK006R0N1ibRax+MJCJ9hUgLdHL4U?=
 =?us-ascii?Q?/SpCDKbYogvtoEEbFeWxewZ/PpnA/Hw2bmon9F/or4mrD9KADs4RCIZEtPs7?=
 =?us-ascii?Q?IBs3u2s75ZwWG2TGB0f2w2VOGx7juNqta5nTYn33tNDuZlFAKP44/LhUbBru?=
 =?us-ascii?Q?wRE4VH9hV3kgPkucPElteDgxJ/srPwdAPWRkibXRy9OXU4y0xWGrCP2Fgf/G?=
 =?us-ascii?Q?gEK1esBou7dYukJoN4G82zcew/7FmMaCWVJJYRJgs0CqIRNt1P72W9AlGj2f?=
 =?us-ascii?Q?i9O1EsdPlSCFhWXOzhuzgIr9/fkHdiH8D4POQFVWeAyznWsBQEyc5AXCzZT4?=
 =?us-ascii?Q?w/rxQk1e9q4QTzaQLTQcUr1yGWLwTDtVxqDyvfGNc0uYRWFoQ/9s+hadXBn/?=
 =?us-ascii?Q?Vrg9bNyTNegNRAYSN/QZYDBHZ32iBbQTKuasHebGEAi0mA0eeAcwlKEgWXpx?=
 =?us-ascii?Q?wW8YLcrhxDRRQnp/1ky4MKRUng6e+Jxjq0TqqfIwp87L6bubGbIvjZto6QCk?=
 =?us-ascii?Q?KTW6+CikRVrqoS0sLjgLFYEwgaIGGqE6zGg9Jiu/j+6uK5N5tM7JH1vTBaAp?=
 =?us-ascii?Q?QCEAQScZFxtKV2jqweA3Guop0HdyWgS7b/ofNHQidOuiAPofPs5e6Gmrhd25?=
 =?us-ascii?Q?+aWxU/eU98+KJ2hV+gqu8r8uQ8iTHxfKrzUmHKe9nS3/pOX5+4RSN9MsMiAo?=
 =?us-ascii?Q?BXZCAAYBChhVxsuXA+xSroXka/AypVwo3pB8jhH2RwyBnqhGt7IK6bE8TPaw?=
 =?us-ascii?Q?uTP8i9o1it1XFPpeVkLAwh+OthMXt0B47WIlqRa/HbwfKF6uLhOp25lb0yVy?=
 =?us-ascii?Q?79Lnp/OfxxnKkwFlpm1MMRxpdPQBmIBdRPaXJ3y5NId+gP5NYchDF1nzFmei?=
 =?us-ascii?Q?F3c0xyeBX2nNCBEuqJWWL97TeG8z/jkMBmVKuAjo5YBiZKP+h/EJK/KLNoHR?=
 =?us-ascii?Q?ZvIvt+aOi5E4XyeVl9A7mtdw?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e148353-9cbe-4fa9-1b21-08d92cf8f0da
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 16:49:55.2144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKRDVM9JdY620BWzdf2TshCKxIJT7Jy2rlcOfar5qJXfRWIqeYk6XiTTc3bfOCerWPx2yoBw9RVqmiMiJDxQtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4744
Cc: Will Deacon <will@kernel.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Thierry Reding <treding@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

Hi Sai,
> >> > No, the unmap latency is not just in some test case written, the
> >> > issue is very real and we have workloads where camera is reporting
> >> > frame drops because of this unmap latency in the order of 100s of
> milliseconds.

> Not exactly, this issue is not specific to camera. If you look at the numbers in the
> commit text, even for the test device its the same observation. It depends on
> the buffer size we are unmapping which affects the number of TLBIs issue. I am
> not aware of any such HW side bw issues for camera specifically on QCOM
> devices.

It is clear that reducing number of TLBIs  reduces the umap API latency. But, It is
at the expense of throwing away valid tlb entries. 
Quantifying the impact of arbitrary invalidation of valid tlb entries at context level is not straight forward and
use case dependent. The side-effects might be rare or won't be known until they are noticed.
Can you provide more details on How the unmap latency is causing camera to drop frames?
Is unmap performed in the perf path?
If unmap is queued and performed on a back ground thread, would it resolve the frame drops?

-KR

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
