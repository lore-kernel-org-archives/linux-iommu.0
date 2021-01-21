Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6272BC433DB
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 17:50:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61E021973
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 17:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61E021973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 41A8520355;
	Thu, 21 Jan 2021 17:50:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gt8YRuYKPQeI; Thu, 21 Jan 2021 17:49:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5CAAC2035B;
	Thu, 21 Jan 2021 17:49:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30076C088B;
	Thu, 21 Jan 2021 17:49:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44299C013A;
 Thu, 21 Jan 2021 17:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2A083861C8;
 Thu, 21 Jan 2021 17:49:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y_5Zm_sTV11K; Thu, 21 Jan 2021 17:49:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A913F85F87;
 Thu, 21 Jan 2021 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcIjWAu6xDhfEJ0ra2IequtMruvxDMqi3GN7TZfHlQ8=;
 b=dqFvmqzfvFiKmMYxasUYwrpozzSQrL8wFlHEbH7wCNDKbtNxTEQjC9vURfOjN/GtVVKI1vGWDfhdrw+PVzk+UZHVucwLmY93KotPr3NKAhVe2Vntm3xNChu7gh0Qp2DnntXgNfYnox2qLKfJ0kvodvXwLsWAPAKsdy+LK1/i+vw=
Received: from AM0PR01CA0161.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::30) by AM0PR08MB4132.eurprd08.prod.outlook.com
 (2603:10a6:208:127::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 21 Jan
 2021 17:34:46 +0000
Received: from AM5EUR03FT008.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:aa:cafe::18) by AM0PR01CA0161.outlook.office365.com
 (2603:10a6:208:aa::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend
 Transport; Thu, 21 Jan 2021 17:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.linux-foundation.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.linux-foundation.org;
 dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT008.mail.protection.outlook.com (10.152.16.123) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Thu, 21 Jan 2021 17:34:45 +0000
Received: ("Tessian outbound 8418c949a3fa:v71");
 Thu, 21 Jan 2021 17:34:44 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fd26a98c07530fcf
X-CR-MTA-TID: 64aa7808
Received: from 1e22ffb69e95.3
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 E1DE3010-26AC-413E-8A89-03CA4D79E956.1; 
 Thu, 21 Jan 2021 17:34:39 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1e22ffb69e95.3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Thu, 21 Jan 2021 17:34:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuOGN+e4WKPByhcp3c2Kqm0aGfDfxgnkLPJB+UkC4jgdTfReS3r5g3IZhr4fFBDbWZdiGDRXx8YGLAivhPFuHw+lDIQozzLfdzrqSxYS4Hi3eGYpgDUeg1I0PrmID2mqABXqD6XPG1m6J/sLagRVa3sbYm/ELPLqSf0MjTOkF8Lk/NbD+IyGidqIjXEHoK8of0Oq1K2UyeVlXnCd6gSe9s9q4ZvhF3j+QFW14Lcv4H1623WMBULz0IxPRTNgTqhfaDHcP7PZzKRR4QZUna17vKhbJuUuq0jwEJuYd1Eo+eSC9QrXwnLrxjQ8ZVjW9SCzduiYJ4F49JZYgG48f1R2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcIjWAu6xDhfEJ0ra2IequtMruvxDMqi3GN7TZfHlQ8=;
 b=B2Q968ZUubCgiyaL+BcpdZqEOCLuEZXPjFPzfRnT0aR67tg8lOJm3Ef9NUpnbXcWr7DdVAznav5XYNN6/PGPciVYs2R0HTzK8A3mNstb2bWTQG1GeS7NLYs9Cswe1hfc29BIPombYb0CJyvL6TSkORCpJZAKXyiG57JRYrzrUQyjnAsZV63cQp3KowqmEfeQEcKh29K+blArJ9ExxTf8+FzTXXasnqPJR4hy7/wXxlogDuFUgEzTNRnZrIvXtdB9+Xz+IAYhcjaQyVn6gxb0FI7lYhj0Qkpttb/cDN5Nqe+GWw4ElYXs3aHjDdJGlXKnN3jPj5n1ykTwC4cs1ssBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcIjWAu6xDhfEJ0ra2IequtMruvxDMqi3GN7TZfHlQ8=;
 b=dqFvmqzfvFiKmMYxasUYwrpozzSQrL8wFlHEbH7wCNDKbtNxTEQjC9vURfOjN/GtVVKI1vGWDfhdrw+PVzk+UZHVucwLmY93KotPr3NKAhVe2Vntm3xNChu7gh0Qp2DnntXgNfYnox2qLKfJ0kvodvXwLsWAPAKsdy+LK1/i+vw=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
 by AM0PR08MB3827.eurprd08.prod.outlook.com (2603:10a6:208:104::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Thu, 21 Jan
 2021 17:34:37 +0000
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::5818:5e0e:3bb7:3b70]) by AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::5818:5e0e:3bb7:3b70%5]) with mapi id 15.20.3784.012; Thu, 21 Jan 2021
 17:34:37 +0000
Subject: Re: [PATCH RFC v1 00/15] iommu/virtio: Nested stage support with Arm
To: Auger Eric <eric.auger@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <a8fd0176-3888-44cf-d659-2e2213a59969@redhat.com>
From: Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <ba4c30b9-1f31-f6b2-e69a-7bb71ce74d57@arm.com>
Date: Thu, 21 Jan 2021 23:04:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <a8fd0176-3888-44cf-d659-2e2213a59969@redhat.com>
Content-Language: en-US
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: BM1PR0101CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::32) To AM0PR08MB3268.eurprd08.prod.outlook.com
 (2603:10a6:208:65::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by
 BM1PR0101CA0070.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Thu, 21 Jan 2021 17:34:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f4305fb5-9450-4634-d405-08d8be32d7d9
X-MS-TrafficTypeDiagnostic: AM0PR08MB3827:|AM0PR08MB4132:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB41325A3988A49437A2A2F62F89A10@AM0PR08MB4132.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: v+FtFm4niW13cf45gvpjLtvkuh9W0rH/pIc9JVtN1/C/YTdtvyx9uJnCSnUWNk/yP5/9pTadH9BsAPyRvmhYSONjbv8872q2VMJmPKnQdhMWqVLiAwAY5/h9f4xkVfn4c4ORPhjqIE4z9Jx+neKE9wc4Mb7F0Tukc63DBae/rYYx+vKmtAg0d3Jz+mJekJydHbVGmp9ikqo0EidSNI0ICxFvHztuYrdeHf9mkEptubvCa8oszrXST/lPHrryYl+y7orrzXbsvMf7N+e2F8r6Ed91s72RLa9Es9ZgMfWTWhps/aIaKLz7VHsiv8+lsz7sK1gBEwlfXg4AElIcyn79IMOXbVxSf4xIt6rsM+hG7Yi0f/c6TZ+6OQUhk932R7bbKU8TMKUIHuwmj6HeGli/EL89pZwAgFdpPlYl6BK9BSmjDpaBQpHlabVfaXRoV549y9gys7e+xJlrFs0nIYkMqZjqG56Mmg8Gf8IEUxw1GOdudRqDpqKSyAPZHssumMB7L7qQbrRA3IPoeVeDdLqSeAqqhpWZp85eJ7e1yV3+Zp7ZmEfVHg9Uigbg5rRuw8WM
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB3268.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(136003)(376002)(366004)(396003)(346002)(66946007)(186003)(5660300002)(6666004)(53546011)(316002)(16526019)(956004)(2616005)(52116002)(966005)(16576012)(478600001)(66556008)(31686004)(8676002)(86362001)(36756003)(7416002)(66476007)(26005)(2906002)(4326008)(31696002)(83380400001)(8936002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YXVUSE01L1BvbGRBNXUvMXF0UkFYc1VUaVREUkJqMWRoTnl0SWd4c25SSUYv?=
 =?utf-8?B?OFJaTWh5QXB2SWNoZ3V5Q1J5ZW1YUE81NDlTQlArOVlyUjAveG5BR2dkQ1h6?=
 =?utf-8?B?L3dSTFVxTUZVeXRaWFdYd1pLOS92MVI3RzlPWFZoVzEreDc0YnpMUjg5MUJU?=
 =?utf-8?B?YUUyZzJxUjNzZWh6TUUzZERJdWZBbU9UYkJkeTNTZnBwRm5sZWxReXU2WkRu?=
 =?utf-8?B?V1o4Z1V5MWFoQ3M3MkN1UmtiWlJsUjRnMzIrUGxXUVBmSVRzR2FFWjFSajFw?=
 =?utf-8?B?YlhZNlMzbEkrN3E4YVI5dnl1dFNaQW82dVliSEYzYW5SZkVSSEJ2elJ1UExT?=
 =?utf-8?B?RXI3ZXVFejNSdVpPTU5xWTJTM1dTS3pIVmpGSDBaREhZb0xyQUthVFZOSHdS?=
 =?utf-8?B?MWVsczRsQTk1Wk92N1J4enE4Tjl3aEhqV1I4MDZUNStIUk1aTno5OXlwbDJY?=
 =?utf-8?B?Z2x2eExibXJXVHdkNUVVRTdVRTRiM0JjeC9iTkRueTJJUzQ5Y0E5Z3NBNFk3?=
 =?utf-8?B?RjZoZkVnNjFPY2w4alRnLzF3S1dEQWZud3kydUh4UjQyckd6dGJBY05GSzB2?=
 =?utf-8?B?NTFnTnlLdTQ1QXB1S1c0NlpFcHBXejhaNFUzaFlNemVDc1ZoMUxRNVVSbi9v?=
 =?utf-8?B?UktOYnFwakhwb3hYV3NtS2JHNmJtVXlRL2xPajdjSzh5WU51SXBJSkZHV1Z4?=
 =?utf-8?B?Wllnb2N4MzcvUVBTNFhoQTRSSlkvb2lDSTlSSDdyb01IREZMS3VFSjJHMEtI?=
 =?utf-8?B?OFZ6WldUUk5hQnoxdWhNK2VIR21vYy9tL2sxYXIrVTJaTTJneExCZHFodnRX?=
 =?utf-8?B?VW9xdXRUNVkzVks2Z01WQzFRZ3FMZVIzV1B0NVcxY3JXRzV1YjVRZDhERk93?=
 =?utf-8?B?WitsdnhzcHVyazU5K3lkUnRNR29qUnBLQk9CMkdzdy9sR3lSVi9mM3p6RldL?=
 =?utf-8?B?eEZDbTJrWFppRVFNR2tOWDVvcHdIczZRL2wwKzdmN1lQN1dQa2xXL2duMXdi?=
 =?utf-8?B?RzRJL1UvVGp1d0pTNHpDSzA3L0hYVlpPVmFzV1VJTkJtSVlOaEZnRGRncGxr?=
 =?utf-8?B?Zm8xTFZoR2lhTEFkZnB4ZlNvQWVXdTBrNXBnUVNLQ3ZCWkRWRHM3T3VCMUNK?=
 =?utf-8?B?N0VIY3R5Z3VOT3lHaGl0bklpbE41L3BId25HTG1qdWcvSnRsaCtKVmU1WEpV?=
 =?utf-8?B?bXlOd09aS3BhWUZEb1FHajBxakQ4RU1IQkFZVmNDRkcxbGJBajZVVmFWZkxh?=
 =?utf-8?B?Mk5xK1doR1Ara24wd09kTXd3YmYvNFcwZ05UZ1lkUFc3bmpKRXNZNjdJQW1N?=
 =?utf-8?Q?iZTj7JkeQcq+dondTQgikcZ1xCnMfFPnvS?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3827
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 13a2fcf9-4a3f-443f-83aa-08d8be32d2d2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ecg4l4Wh3ff9lzCISFW+u/P8P83zj8/tKF6nnsWx/TKJnRknHowavtktGOASwTCFFAjSLXYPBpcbzlA/OAVdWQO+6DG/p85a3QjEM1yeFLebSFOFiupboyBuQzZXTcz4lnSnl9ZBgOU09jnGsTrMrTTD+M7LbYt/lbO+tBVM9et81/Vu/AnWhIuMHxClvvEqNIrJgJtIuqpujGa+8xAewPRY4PA1gBaI6rxh5dcfqBKP2jmOyKfG0pgc6y9E1EX1O5TXCGjHu+Jweso2v/hE7/ad+3ORNQSwEIlpmHWbxxvdmvki802rf3R0xMBOl7V6d6VC10V8+aPn6Zs1l9qVivVy/4BjMay9gB8Na3zZASMFLDnbWuKr9U7UacW0K2VG6/r5MS4biBEGc+1MjJ5Cslj/qQhnAB+8FyUDMpP1nw3reBVQvkFaJJYMPitloAzL9VUE0byFPDiNE3Dc4E+W/arsnKlAV8bY2vpllR6cSkw1vz0L/YwIo9vcy3i5Je8i08WWPdeJgDcDquLjrpzbj0jFyYeQM7WqbVNnnM13qWWtHCKliqwtp8swWsppzO9Y7OG6Lb7rl02L2gdTzp5g3byP0tOjAcaqqyIgTVZOzREctR+hiF0NLGh24F/VG0/BXOCUe2rBOwwt67KmX+hnTlRgNnaUmp7QGRJir2C8B+cu1BV8+Gd/Tkitiu3tPgbrfMf1283AiAJLkEzHZcJqoA==
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(136003)(39840400004)(346002)(396003)(376002)(46966006)(16526019)(36756003)(16576012)(70586007)(31686004)(6666004)(2906002)(186003)(450100002)(5660300002)(6486002)(82310400003)(31696002)(70206006)(2616005)(478600001)(336012)(956004)(53546011)(26005)(8676002)(81166007)(316002)(47076005)(356005)(8936002)(966005)(4326008)(83380400001)(86362001)(107886003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 17:34:45.1104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4305fb5-9450-4634-d405-08d8be32d7d9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4132
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 will.deacon@arm.com, alex.williamson@redhat.com, robin.murphy@arm.com
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

Hi Eric,


On 1/19/21 2:33 PM, Auger Eric wrote:
> Hi Vivek,
> 
> On 1/15/21 1:13 PM, Vivek Gautam wrote:
>> This patch-series aims at enabling Nested stage translation in guests
>> using virtio-iommu as the paravirtualized iommu. The backend is supported
>> with Arm SMMU-v3 that provides nested stage-1 and stage-2 translation.
>>
>> This series derives its purpose from various efforts happening to add
>> support for Shared Virtual Addressing (SVA) in host and guest. On Arm,
>> most of the support for SVA has already landed. The support for nested
>> stage translation and fault reporting to guest has been proposed [1].
>> The related changes required in VFIO [2] framework have also been put
>> forward.
>>
>> This series proposes changes in virtio-iommu to program PASID tables
>> and related stage-1 page tables. A simple iommu-pasid-table library
>> is added for this purpose that interacts with vendor drivers to
>> allocate and populate PASID tables.
>> In Arm SMMUv3 we propose to pull the Context Descriptor (CD) management
>> code out of the arm-smmu-v3 driver and add that as a glue vendor layer
>> to support allocating CD tables, and populating them with right values.
>> These CD tables are essentially the PASID tables and contain stage-1
>> page table configurations too.
>> A request to setup these CD tables come from virtio-iommu driver using
>> the iommu-pasid-table library when running on Arm. The virtio-iommu
>> then pass these PASID tables to the host using the right virtio backend
>> and support in VMM.
>>
>> For testing we have added necessary support in kvmtool. The changes in
>> kvmtool are based on virtio-iommu development branch by Jean-Philippe
>> Brucker [3].
>>
>> The tested kernel branch contains following in the order bottom to top
>> on the git hash -
>> a) v5.11-rc3
>> b) arm-smmu-v3 [1] and vfio [2] changes from Eric to add nested page
>>     table support for Arm.
>> c) Smmu test engine patches from Jean-Philippe's branch [4]
>> d) This series
>> e) Domain nesting info patches [5][6][7].
>> f) Changes to add arm-smmu-v3 specific nesting info (to be sent to
>>     the list).
>>
>> This kernel is tested on Neoverse reference software stack with
>> Fixed virtual platform. Public version of the software stack and
>> FVP is available here[8][9].
>>
>> A big thanks to Jean-Philippe for his contributions towards this work
>> and for his valuable guidance.
>>
>> [1] https://lore.kernel.org/linux-iommu/20201118112151.25412-1-eric.auger@redhat.com/T/
>> [2] https://lore.kernel.org/kvmarm/20201116110030.32335-12-eric.auger@redhat.com/T/
>> [3] https://jpbrucker.net/git/kvmtool/log/?h=virtio-iommu/devel
>> [4] https://jpbrucker.net/git/linux/log/?h=sva/smmute
>> [5] https://lore.kernel.org/kvm/1599734733-6431-2-git-send-email-yi.l.liu@intel.com/
>> [6] https://lore.kernel.org/kvm/1599734733-6431-3-git-send-email-yi.l.liu@intel.com/
>> [7] https://lore.kernel.org/kvm/1599734733-6431-4-git-send-email-yi.l.liu@intel.com/
>> [8] https://developer.arm.com/tools-and-software/open-source-software/arm-platforms-software/arm-ecosystem-fvps
>> [9] https://git.linaro.org/landing-teams/working/arm/arm-reference-platforms.git/about/docs/rdn1edge/user-guide.rst
> 
> Could you share a public branch where we could find all the kernel pieces.
> 
> Thank you in advance

Apologies for the delay. It took a bit of time to sort things out for a 
public branch.
The branch is available in my github now. Please have a look.

https://github.com/vivek-arm/linux/tree/5.11-rc3-nested-pgtbl-arm-smmuv3-virtio-iommu


Thanks and regards
Vivek

> 
> Best Regards
> 
> Eric
>>
>> Jean-Philippe Brucker (6):
>>    iommu/virtio: Add headers for table format probing
>>    iommu/virtio: Add table format probing
>>    iommu/virtio: Add headers for binding pasid table in iommu
>>    iommu/virtio: Add support for INVALIDATE request
>>    iommu/virtio: Attach Arm PASID tables when available
>>    iommu/virtio: Add support for Arm LPAE page table format
>>
>> Vivek Gautam (9):
>>    iommu/arm-smmu-v3: Create a Context Descriptor library
>>    iommu: Add a simple PASID table library
>>    iommu/arm-smmu-v3: Update drivers to work with iommu-pasid-table
>>    iommu/arm-smmu-v3: Update CD base address info for user-space
>>    iommu/arm-smmu-v3: Set sync op from consumer driver of cd-lib
>>    iommu: Add asid_bits to arm smmu-v3 stage1 table info
>>    iommu/virtio: Update table format probing header
>>    iommu/virtio: Prepare to add attach pasid table infrastructure
>>    iommu/virtio: Update fault type and reason info for viommu fault
>>
>>   drivers/iommu/arm/arm-smmu-v3/Makefile        |   2 +-
>>   .../arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c      | 283 +++++++
>>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  16 +-
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 268 +------
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   4 +-
>>   drivers/iommu/iommu-pasid-table.h             | 140 ++++
>>   drivers/iommu/virtio-iommu.c                  | 692 +++++++++++++++++-
>>   include/uapi/linux/iommu.h                    |   2 +-
>>   include/uapi/linux/virtio_iommu.h             | 158 +++-
>>   9 files changed, 1303 insertions(+), 262 deletions(-)
>>   create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
>>   create mode 100644 drivers/iommu/iommu-pasid-table.h
>>
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
