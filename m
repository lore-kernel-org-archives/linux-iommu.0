Return-Path: <SRS0=AFVC=6N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11866C83006
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 18:01:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C867821D7B
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 18:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="gdj0TbiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C867821D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 80D7484186;
	Wed, 29 Apr 2020 18:01:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9gWFzzUU1DUS; Wed, 29 Apr 2020 18:01:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A90398207A;
	Wed, 29 Apr 2020 18:01:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C802C0864;
	Wed, 29 Apr 2020 18:01:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3EB0C0172
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 18:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 420F720423
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 18:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ula28VCOHEkm for <iommu@lists.linux-foundation.org>;
 Wed, 29 Apr 2020 18:01:13 +0000 (UTC)
X-Greylist: delayed 23:50:55 by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2118.outbound.protection.outlook.com [40.107.237.118])
 by silver.osuosl.org (Postfix) with ESMTPS id B505D203CF
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 18:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIgZtajfAt2hHTaes1i2+HyFqS6FCpuqgXJ/0KJgsKsyj2aCs9S0WD4+b5NMA/GKJXpNaqO6AV9ifTwB3/buHMBByTwFohNCa6fHEnPYLbMiTTNMgb6IwUOTW5VeG7M2426isfFZ9U+WU+2kWF71t+dHR/1oDtd7FS8QSZsz5/EnEVED7I7y1oigf6qAZ/4SqJZLaKU/DKnYEyEq5RTlk+p4/T1X4At/SDJCSk4w6JDcVU4pWPte0He9RT+0tAamelCZrIlpmeyDZAIsZ1GuZJiJCGgFJMV8h19Ff20dAdmahNUEjUMFlPdJ8G7m0u+09ZSvYKLMATv5DyitGAjesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pdt44Km1QZkL1UTIrf2ohHsRvp+jgNYQBPmSk46F0Nk=;
 b=GtXh272mljn8/QRiTaexagnSk1Ff+hBvW4PuyC8vmu8D9r4QPrcXuUuxEuyhbiSzYtIa7nSOfnrU+dnIepsiNVAE1RgyGQ01ETfw2ELzqKynbv8EYnd9aAjgs6xtnXTYaZgOir+uwqeFTjp8RzJZAupnQ2Ox79JauKv64JJmnXd7z+X/z0IPZEhpZ1HsTAbk/MMmbrSHYyVQOq3DeoB3j+WPucwpVA5nEv7WQADp/AcsMBbb6sfnBaPxN4HPBziJlyvDWe7nn7S2B8rZQz4nysym0u71jPvFFhCifvnXH7OU0J3LdwSYh74AMGdzhHaTpUqY3py8D/9RPqoecZ83xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pdt44Km1QZkL1UTIrf2ohHsRvp+jgNYQBPmSk46F0Nk=;
 b=gdj0TbiCOA2RoiHzpWcBoCamUaqyjub3x5gZzxS815zb17xdVlQUWo61OKlMyLJei23ShNBKPo3sqYxK7xSKTMi6m4xxft6Ay6igP9Pv8iXB72AYvSAQ9OKTzlkvE3DTSHLtp7vwxyOQjZt3rwru4wQ+3V5p1vOpNWgQY3XkWSs=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none
 header.from=amperemail.onmicrosoft.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB4021.prod.exchangelabs.com (2603:10b6:a03:15::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Wed, 29 Apr 2020 18:01:08 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c%5]) with mapi id 15.20.2958.019; Wed, 29 Apr 2020
 18:01:08 +0000
Subject: Re: [PATCH] perf/smmuv3: Allow sharing MMIO registers with the SMMU
 driver
From: Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
In-Reply-To: <20200429072104.GA817954@myrica>
Date: Wed, 29 Apr 2020 11:01:05 -0700
Message-Id: <D4FCF21C-D514-44F0-82CF-4932C704117B@amperemail.onmicrosoft.com>
References: <20200421155745.19815-1-jean-philippe@linaro.org>
 <F8C2FB7F-2D21-44AA-B41D-0D4555A63660@amperemail.onmicrosoft.com>
 <20200429072104.GA817954@myrica>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-ClientProxiedBy: CY4PR18CA0040.namprd18.prod.outlook.com
 (2603:10b6:903:9a::26) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.173] (73.151.56.145) by
 CY4PR18CA0040.namprd18.prod.outlook.com (2603:10b6:903:9a::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Wed, 29 Apr 2020 18:01:07 +0000
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Originating-IP: [73.151.56.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aee5010f-38c1-4e15-f223-08d7ec674ae7
X-MS-TrafficTypeDiagnostic: BYAPR01MB4021:
X-Microsoft-Antispam-PRVS: <BYAPR01MB4021F0A696175151771B60EDE0AD0@BYAPR01MB4021.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR01MB4598.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(396003)(366004)(346002)(376002)(33656002)(4326008)(66556008)(66946007)(8936002)(186003)(26005)(6486002)(316002)(8676002)(53546011)(42882007)(66476007)(52116002)(83170400001)(16576012)(16526019)(478600001)(2616005)(956004)(966005)(54906003)(2906002)(6916009)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wfl4GSCGp6/+5SrkeK2vjCmpDWrzeLtOoXtMt82c9Sb5KgGPcWGIjrvSS0VzbrnOQVd8BAhrX79QmW2ZqqrCejYVF47jWDIqVXJQyY2WVToU1uHw07PvqWRn9G4pG1SkhhWjknXwJLNaXf5NpTTkINwNkP8cCDV6PJMXkrpWfg4nOcFd3LysZuqgNEtw5lQawY35pfJ1HuCm/9nkFl8Ph39eMjNNxXR786M3zbVErSsFiYqSMVl+byd3OkYfAaVUWf+X4AAarAU/L5rdITPPiRMfylrzRvHqwt5dHjlHdNbEQNwS/IwaEYO48Fjh4LbR2jqc2kOn9op3FejTVSKU9nOmkrEVyBxVhQ5k/hnHAi/P8Oz5EFw/iMgY6J68vvWQufzhb0l3AAtGSo7fVMDW8Rx1DEEv0sELd2jR0sUDYQ1jZ95IWaq9T2o6n5oTSajTarCv2ZiDstwv/dS4KLr+atldA0EQdpteD8AyDDoa4VzOyWpOAGYHAKQHMB6WaTEPT/JbwZQqIVMOTkIPhHCpOw==
X-MS-Exchange-AntiSpam-MessageData: m2WAZ1oCHv4i0ZjOZENd+OZMbkXDFxedIZxQRM4mlLRvsoOcfgvMnhubBV+v0VCOKCB3vzAAHL5wSsQneqXVRYfuCisHH6oJKX4VCjO7yCFG/JKWl8KsTRw/u+MthT6MBykQOAWRiOcT3cRWGrJZUa30zINNJzdeJbUJcBz7dWpza8OMr6rHWq/fYBeUbNYAW9w2dg58xK2bs8QqpN1gDO/Xl33m5hHu5IPMR/eTHG6St89aMtHVNq61BTvS8rLQ4RMEnWUGtllxSZHpAnS3qBldwqVY4oqO55Gl+NkMnQ/bWhb/kIL/A0FZnxX5tKsU3i3EqfvragLpyjVfpxQpUaDOmTLJVCiQNmdkAKZSDx8xuaxDCe4zBojnwsEGiMBIEnkfR5prVJZMoQdwsucaPANmgb8FwEz6NnkK/mpzd+9gckNn1hKrBw36rWwBMnlR7A+nld0Rin0gIcxODvcQTIMapL7lN+ImyLDxsdKk4uXnxwQF3FXJTOK4SgcJrer2sdXt2Qsom7SBJyBec7mdqVhvXdbp90ef3iqTOL8hi5nGxX/EKoVxO61DUe1DFtn452NCU5emwOKwpHNWre2HM8FQflAR1h3YYjQy0oFV+8J+0wV78M37mqLe0qeavI9rKYB8bFZEHsFzOWev3LtrJthn+mbpxwPVnx+XELbGhU86zXO6tpYYf+BiLa44MKTXyrk0GkyTKoEDEx/wDFHAXjjt+lYuJUwp5puRwr00CNSpCFwevtRjziAft8A8yLBXSdbxSn2wPPqLQMapVtS9j/45KKp7uMFue68Qg38dZR4=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee5010f-38c1-4e15-f223-08d7ec674ae7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 18:01:08.1524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2pw0RFZF3OdeV4NftWYK/mBvQfNDzt/KdmcN0aV+Ey7FKfnDRo41ZskmMT7NgDBJB1fUiZoY4Qod0TZVzxtEsIjV8hIfxQI3SEiGJaxs7Plmk0+PSVztthI80yNBkml
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4021
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Cgo+IE9uIEFwciAyOSwgMjAyMCwgYXQgMTI6MjEgQU0sIEplYW4tUGhpbGlwcGUgQnJ1Y2tlciA8
amVhbi1waGlsaXBwZUBsaW5hcm8ub3JnPiB3cm90ZToKPiAKPiBPbiBUdWUsIEFwciAyOCwgMjAy
MCBhdCAxMToxMDowOUFNIC0wNzAwLCBUdWFuIFBoYW4gd3JvdGU6Cj4+IEkgdGVzdGVkIHRoaXMg
cGF0Y2ggb24gSFcsIGhvd2V2ZXIgSSBuZWVkIHRvIGFkZCBvbmUgbW9yZSBmb2xsb3dpbmcgY2hh
bmdlIHRvIG1ha2UgaXQgd29ya3MKPiAKPiBUaGFua3MgZm9yIHRlc3RpbmcuIEkgZG9uJ3QgdW5k
ZXJzdGFuZCB3aHkgeW91IG5lZWQgdGhlIGNoYW5nZSBiZWxvdwo+IHRob3VnaCwgZG8geW91IGtu
b3cgd2hpY2ggb3RoZXIgcmVnaW9uIGlzIGNvbmZsaWN0aW5nIHdpdGggdGhlIFNNTVU/Cj4gSXQg
c2hvdWxkIGJlIGRpc3BsYXllZCBpbiB0aGUgZXJyb3IgbWVzc2FnZSBhbmQgL3Byb2MvaW9tZW0u
Cj4gCj4gVGhhbmtzLAo+IEplYW4KClRoZSBlcnJvciBpZiBJIGRvbuKAmXQgYXBwbHkgdGhhdCBw
YXRjaDoKWyAgICA0Ljk0MzY1NV0gYXJtLXNtbXUtdjMgYXJtLXNtbXUtdjMuMC5hdXRvOiBjYW4n
dCByZXF1ZXN0IHJlZ2lvbiBmb3IgcmVzb3VyY2UgW21lbSAweDNiZmZlMDAwMDAwMC0weDNiZmZl
MDAxZmZmZl0KClRoZSBvdXRwdXQgb2YgL3Byb2MvaW9tZW0gZm9yIHRoYXQgcmVnaW9uOgozYmZm
ZTAwMDAwMDAtM2JmZmUwMDFmZmZmIDogYXJtLXNtbXUtdjMuMC5hdXRvICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogIDNiZmZlMDAwMjAwMC0z
YmZmZTAwMDJmZmYgOiBhcm0tc21tdS12My1wbWNnLjE3LmF1dG8gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogIDNiZmZlMDAxMjAwMC0zYmZmZTAwMTJmZmYg
OiBhcm0tc21tdS12My1wbWNnLjE3LmF1dG8gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIAozYmZmZTAwNDIwMDAtM2JmZmUwMDQyZmZmIDogYXJtLXNtbXUtdjMt
cG1jZy4xMS5hdXRvICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIAozYmZmZTAwNTIwMDAtM2JmZmUwMDUyZmZmIDogYXJtLXNtbXUtdjMtcG1jZy4xMS5hdXRv
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAozYmZmZTAw
NjIwMDAtM2JmZmUwMDYyZmZmIDogYXJtLXNtbXUtdjMtcG1jZy4xMi5hdXRvICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAozYmZmZTAwNzIwMDAtM2JmZmUw
MDcyZmZmIDogYXJtLXNtbXUtdjMtcG1jZy4xMi5hdXRvICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIAozYmZmZTAwYTIwMDAtM2JmZmUwMGEyZmZmIDogYXJt
LXNtbXUtdjMtcG1jZy4xMy5hdXRvICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIAozYmZmZTAwYjIwMDAtM2JmZmUwMGIyZmZmIDogYXJtLXNtbXUtdjMtcG1j
Zy4xMy5hdXRvICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IAozYmZmZTAwZTIwMDAtM2JmZmUwMGUyZmZmIDogYXJtLXNtbXUtdjMtcG1jZy4xNC5hdXRvICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAozYmZmZTAwZjIw
MDAtM2JmZmUwMGYyZmZmIDogYXJtLXNtbXUtdjMtcG1jZy4xNC5hdXRvICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAozYmZmZTAxMDIwMDAtM2JmZmUwMTAy
ZmZmIDogYXJtLXNtbXUtdjMtcG1jZy4xNS5hdXRvICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIAozYmZmZTAxMTIwMDAtM2JmZmUwMTEyZmZmIDogYXJtLXNt
bXUtdjMtcG1jZy4xNS5hdXRvICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIAozYmZmZTAxNDIwMDAtM2JmZmUwMTQyZmZmIDogYXJtLXNtbXUtdjMtcG1jZy4x
Ni5hdXRvICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAoz
YmZmZTAxNTIwMDAtM2JmZmUwMTUyZmZmIDogYXJtLXNtbXUtdjMtcG1jZy4xNi5hdXRvCgo+IAo+
PiBAQCAtMjg1NCw3ICsyODU0LDcgQEAgc3RhdGljIGludCBhcm1fc21tdV9kZXZpY2VfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPj4gICAgICAgIH0KPj4gICAgICAgIGlvYWRk
ciA9IHJlcy0+c3RhcnQ7Cj4+IAo+PiAtICAgICAgIHNtbXUtPmJhc2UgPSBkZXZtX2lvcmVtYXBf
cmVzb3VyY2UoZGV2LCByZXMpOwo+PiArICAgICAgIHNtbXUtPmJhc2UgPSBkZXZtX2lvcmVtYXAo
ZGV2LCByZXMtPnN0YXJ0LCByZXNvdXJjZV9zaXplKHJlcykpOwo+PiAgICAgICAgaWYgKElTX0VS
UihzbW11LT5iYXNlKSkKPj4gICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoc21tdS0+YmFz
ZSk7Cj4+IAo+PiAKPj4+IAl9IGVsc2Ugewo+Pj4gCQlzbW11X3BtdS0+cmVsb2NfYmFzZSA9IHNt
bXVfcG11LT5yZWdfYmFzZTsKPj4+IAl9Cj4+PiAtLSAKPj4+IDIuMjYuMAo+Pj4gCj4+PiAKPj4+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+PiBsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAo+Pj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCj4+PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwKPj4+IAo+PiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
