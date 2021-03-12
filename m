Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881E7C433DB
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 12:54:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A5864FA8
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 12:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A5864FA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3CEE84565;
	Fri, 12 Mar 2021 12:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uocw-X9cXf_3; Fri, 12 Mar 2021 12:54:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9BF884544;
	Fri, 12 Mar 2021 12:54:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DF56C000B;
	Fri, 12 Mar 2021 12:54:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56A8FC0001;
 Fri, 12 Mar 2021 12:54:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 440ED4ED3C;
 Fri, 12 Mar 2021 12:54:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com
 header.b="skGs8jWU"; dkim=pass (1024-bit key)
 header.d=armh.onmicrosoft.com header.b="skGs8jWU"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6wNkXV-8FuMm; Fri, 12 Mar 2021 12:54:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02on0619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe06::619])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 886B84ED2C;
 Fri, 12 Mar 2021 12:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRYCWlv+yZFwJ1ufp3rdlK0vAL1StXhbu8EYeu5DYDk=;
 b=skGs8jWUvaTL/2qby5xQYRXMMoK4TWGzYymU1ALK9TL4GEvbeGe7hfO9Y4kXT+jedS1pFrDbf1sk8cgjtLHBXl6BPTCwpHgXczMhYZpwCo+L38ibGp1ao7v44Y9S3HgNbZH2vrmcIJf3wrN8oTNcmDhK0tdwp6VVqbHo+bXsG7k=
Received: from AM6P191CA0072.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::49)
 by AM9PR08MB6129.eurprd08.prod.outlook.com (2603:10a6:20b:284::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 12:54:45 +0000
Received: from AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:7f:cafe::fc) by AM6P191CA0072.outlook.office365.com
 (2603:10a6:209:7f::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 12 Mar 2021 12:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.linux-foundation.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.linux-foundation.org;
 dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT057.mail.protection.outlook.com (10.152.17.44) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Fri, 12 Mar 2021 12:54:43 +0000
Received: ("Tessian outbound e7a0046930fb:v71");
 Fri, 12 Mar 2021 12:54:43 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 230b1e90ae6dbc93
X-CR-MTA-TID: 64aa7808
Received: from 284725744c93.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 D2915C79-F415-4FB2-93F9-9F031B334791.1; 
 Fri, 12 Mar 2021 12:54:37 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 284725744c93.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Fri, 12 Mar 2021 12:54:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vfb012yQDGQwLjIyh4znW2BfO/XahhpplLWCPoPQ/SV3TOP+nBYQ0KTgDweXywHP4ee+ITNVygm0lelXZxUSReZQU/V7WaFSTHL9iN6PoPXNU95/Yzt7WoFMuMsWRBwWLD7oYtieqXfP5p04/pB8INMNV+iqh1J7PPsFKPSxPn4FnBdzN0a1v+mndHPNS3T0RCVcYKsOATdHNzR41hxjERH6eiRjYS8eBjH2V1wGW1g9ot+gdNI7IHH+ojCxswy3iR21r1aCs2bKjTs4F78zXA2V3spZmWYYJeLNyIBuaJznVYnN/IYZq/wStIECPTJM7CMU7X09CwabM8C7Stj4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRYCWlv+yZFwJ1ufp3rdlK0vAL1StXhbu8EYeu5DYDk=;
 b=JsFmMK7S+FIr608uBydXSqjKPxSNa5202eveNWlvmrgYY9hxHj2h8rPrutH+Bz/W6RK9OKkvu6psk329lBhByhHQguy2tNL+JJt3+1m2WVz5YbsBEPXYTBWifBvxRtV9z0/PmkI2r6zEZQw1m0fhI4c0Oc6gZ21nqmIfWHhu1adhjV5deoDxM9P853msk/cOauH0HrJcfHtb8jPAzMozj3RAMjJAxdBZlZ7dsNwgIF8Lt99qb+WlOfxjDwEWWLb6rszlXDC+XWY31kAXwkhd72xWgf+JA7z8UhEMaBtoA0QChD1TkZGUW45g0n3P/M6hf9pAr7hrLy//5sxB8hHbGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRYCWlv+yZFwJ1ufp3rdlK0vAL1StXhbu8EYeu5DYDk=;
 b=skGs8jWUvaTL/2qby5xQYRXMMoK4TWGzYymU1ALK9TL4GEvbeGe7hfO9Y4kXT+jedS1pFrDbf1sk8cgjtLHBXl6BPTCwpHgXczMhYZpwCo+L38ibGp1ao7v44Y9S3HgNbZH2vrmcIJf3wrN8oTNcmDhK0tdwp6VVqbHo+bXsG7k=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
 by AM0PR08MB4403.eurprd08.prod.outlook.com (2603:10a6:208:141::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 12:54:33 +0000
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685]) by AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685%6]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 12:54:33 +0000
Subject: Re: [PATCH RFC v1 06/15] iommu/virtio: Add headers for table format
 probing
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-7-vivek.gautam@arm.com> <YD/ExjIwG/as52CI@myrica>
From: Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <375eae7c-4bfd-331d-4dbb-2cba857ae369@arm.com>
Date: Fri, 12 Mar 2021 18:24:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YD/ExjIwG/as52CI@myrica>
Content-Language: en-US
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: PN1PR0101CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::11) To AM0PR08MB3268.eurprd08.prod.outlook.com
 (2603:10a6:208:65::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by
 PN1PR0101CA0001.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 12 Mar 2021 12:54:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3de73828-c112-4a14-744e-08d8e5560216
X-MS-TrafficTypeDiagnostic: AM0PR08MB4403:|AM9PR08MB6129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9PR08MB61299E351142AA929E2F7F41896F9@AM9PR08MB6129.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: E9678DsWv6Y7XvWJ9/ZYkCxLWtRMcrBFELBvGejU0RJ/S/ymPdwxdQthkiglqipmvBO6uNKyflMJL4dOetv8lF0vo7Jp4o42JiKumFTlCmBIzHNHURwolOkR518i6gPXPDpfcGW3uVvy2R2lWQ/NcD0LiuErUh63WYzNLgkauvk6SOYm5L8UEMWxaW5GE3U90ynRoT1MS/448gpqG5VwMjMhPimDPZ10a5VBl7XjFQLT651q7YnuWk8JH6o+7yAx+ok2k6UKfL4kMm0HlQz1PqOvJ9ZClkmCaxR7xIbT46R4+98IbLPsrzg11Lzy5tu0OuXLa4mx6OevAXJ4ntcSn+f256Zf/1N+RFuCQ6ZDXH43Mn+1X+qu8NIG+RvVuFaVe7GUHxkstYEfY2cJ+PYOTjr7QUjden8Bym3EPJsrnBi2sBtN5FLPkSB2NOed1KN+0ph5ollYrdd9YdG3t7/bGZr3KaPxUifdVIcU58j9onZzTuAqiOk6WHKGJqamFwIrcB3bhIvXpl1P7rr0M0zehu5Bsv09rf/L4gjdgbBQfF//rPOcN+oZNeWlrSCYOs/m2iqKRxBlcgxNSyDnYm9i3sGiyOujtq04Kh5sezjVJtw2dWOUY11TOhm0jW0xSzJW5qdWXUf1aiQk73eAmnU0CBC3Q0N+E1AIPXYtIXwGbFK5wkS7s0Vs0mFpqo7t0mYI9KdkOyDCRzi98fz3Q+Azd6S273e75hyrrnUDf0pZjX4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB3268.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(83380400001)(36756003)(52116002)(31696002)(31686004)(53546011)(316002)(86362001)(16576012)(6486002)(66946007)(6916009)(66556008)(66476007)(5660300002)(966005)(8936002)(478600001)(8676002)(2906002)(4326008)(16526019)(186003)(6666004)(26005)(7416002)(956004)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cngvNURjaVJvbFFIVlBxZWkzRGV2ZjRsRXJDQW9haFJ4WlpDUlM3TWphVyt4?=
 =?utf-8?B?L3pES0NOTXJKZHorUjdqZjZUTW1EOWhpMzNEdTdnOXBzRUdSYlkrblMzT011?=
 =?utf-8?B?V3UwNEc5MmJpUkt5UTI1TldyLzdITG1sKzRiUytQNGFVQkNtM2kzeUV6ZnZx?=
 =?utf-8?B?MGV2VHRkUXgrOVNjcUtyc3dhMFJpOEFNZTZMVEUwdFFrMEl3S2gzR2JxbXQy?=
 =?utf-8?B?Rjhqb3ZQSnAxWml1QXpTVWNhN2tsVkk0WWx6bWpzVkx6Q1pLRXQ3eGQ4MjF4?=
 =?utf-8?B?MnVaYTFEZHFzZHFIUG9FRkI2R1pjSUVMYS9Xa3VnTjZkY21sTmJoQjRtRjdv?=
 =?utf-8?B?NlArZW5DWjdBekVvS0t6MVhSQklXZ0tpYW9jOUFVN0ZzYnhTRXc2d1EzcGpj?=
 =?utf-8?B?cHhadXZIaVBpTEZaQm9qRnpHS1FuTE41ZGxycWpSV1JFRjJ0V3EybmxkZzdr?=
 =?utf-8?B?ZzlRQ2U2NTNRcDJMYnBzNk9Jc3FwM1c3cFVCQVNnZlR4cSsxTUNrNkJ4RDBL?=
 =?utf-8?B?dnNXblZZRFZjWW1mbVJ0WE5zR2pRdTlIZ3ROd0hJLzN1TlE1YzNKVUxURWU3?=
 =?utf-8?B?ZnduNVM3Y1BEbGUwUmd5TjM0ZXBsOEprRC8zaVF0cUZoN3FOSHR1UlZjdjZ1?=
 =?utf-8?B?eFBYSDQvS3F5UDZ4amJHU00waDk3bG9sVmZtRm9yOVQwWWo1U05Mb25WUDFz?=
 =?utf-8?B?QSt5SWlUTkZQd084WjEyenMzREs5YVY1bElmWk83a1J2Q24zNTBIdnBVMzlT?=
 =?utf-8?B?L1U1UmlCTTUvYlVhZURvc0RyQUJFMlQxQVRoaGhZSFBMcUFTTUxtVEhMdzRN?=
 =?utf-8?B?U2NPTGVSd0UwcEZxZEZacTVpY2V3WllxeEhkWVgvUEJvNXZYWmp2aFhCZ2cw?=
 =?utf-8?B?OUdVMmtueXYvQ09tMHltekN4dEdIWXJaVWJxZnZpZlJBR3lLWjZhRjAzZXdi?=
 =?utf-8?B?S1ZBSFBaRlBWSWRGQXJscjRqVGFHRFNBMEdEMUQ0YmRJMW4yUGxCZ2RvM0x4?=
 =?utf-8?B?OFBldktTT2dNNHZHaDFvUmQ2MnpRZW5oQVhqaEVZK0V1aS9qT3VPbmhxR0Na?=
 =?utf-8?B?NlJYa3o0d3ZEL1ZHaWdEcW5aUHcrQTZwRWl6SUFVc3dJY1RMSXF5dEg2c0h4?=
 =?utf-8?B?UTZUd2czMEJLZE5hRVc1NGhEK1R3aVFFQk1mb05CdGp0RWpsTUFCdDhVd1ZT?=
 =?utf-8?B?eTlLampSUktxMzdaV01jcjlKOUNaU3FPQTFQN3l5NWlucTR4NmRNb2VucExo?=
 =?utf-8?B?QUlKUCtVYlZsdXh0WFlqcTc0MVNMMmlzRG4xQkRXK2FDUjhlSzdTcU9GQWRa?=
 =?utf-8?B?OS9JQnVrcU9hNTB3T1VOazNFaFg2SEhpbDl3ZDIxVmVOdFJySHhCKzdMN3VD?=
 =?utf-8?B?ZTVHQmR5ZklhVzlsMk9QMkNpM0J4YmdoTmtkRVNiN3JFQnB2b3NCdFc0WXo3?=
 =?utf-8?B?Q0taclNONDFEeU1oSHBtVEdXOGNJeGRudFdzTExoMFdIUkdNZEZ5dXdSeitu?=
 =?utf-8?B?YUNaSjNnY2NBa2hMSC9pNWl0SlExTHR6Wk1EdXpmLzZGQ3BxaExIMG12aGNQ?=
 =?utf-8?B?WFhOUzZyc1hwVVpyNW95MGFORjBGUGF4eFpOWjhXQ2NJNC93WmI2L1pXZGFG?=
 =?utf-8?B?eE51UXloVE5aUFNCMUQ4eEZ6T1NRekE3RlRXREMweHZVU0RkZjFTbGZLYlFn?=
 =?utf-8?B?MkFkc240Um92dEcxcjViMG5FNWdXcFVuMjE1NWJhWFI0OVJxY1FTQ0NSWGtV?=
 =?utf-8?Q?7Yjv8/bDDzwA5N7O8YnpYXU4lsn8WE7wxj8CQ7e?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4403
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4f1a8829-bd5d-4ef5-8560-08d8e555fb48
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Fqp1b3LqjgIZB/Uo56kKrFz7KwIh/VD/EcWgVev9P7guHttSCGSrWSlMHtqEs26agLsYxdEuyruUPg9VSC2fVLV7j+Pa+TSMkh7mnyBii5tfltVWoGBFAXBPyupOD1lPq8U19vjGufORFcTRjGQUhaHjlzSJjURntklkfhskEt7dqJAyQNkv2IH+KjwC0mHypipkxhSbLH2lbnCFoohitOeNt7m5WzU6zNanOXHefJWURpb3vR+NveZ44fzwps3zdTN6kzvXM8JPOP0fMBddw8eEK2sJurkSScaOxzibdO2sZ2ovm6bogr433IuzPlbIzOkoUwzFIEbGw+Mf5OmQlUOYlI1hyA+qbXWrf7HDsv2r4We7wSCNOGl+9PLVSHZknCKf4XMOfiWC5OYQTyuHsoNoaeX79jL2O+1BQXC8cvFiwq+Aoc8abCFNWDp9qk3v/4FC+f8V+AphvThfDbNSPxLtk43VrQpLafiSXBTfcoNl4UsRD69V2rRq9c1IJ/Nybyl/03xEq1CZfp5ex2K4MyhQIJTi9P8fhGmomcpbFPbmo6lNygvHU7Bfznv6iaVifRA+Ws2eDtgEO+k+wl70l0I8au6x3YVJYnFPLiDW2MJTRCnE8mDDPyFPw8HsKpUSEmFVQGgTWxZ7ZUcTni5OClUIZuBHBPEVmSq86INTZN2U9lZoTuzwM/YbGMqKmN/KsWj9HX1ZrBov00/v/naObe5cjLkVu+B9R8n2ictroRg94nc89YTTxcVKWwanERJ1T760551sBjt17CBkoH7MQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(36840700001)(46966006)(107886003)(6486002)(956004)(70586007)(26005)(6666004)(16526019)(6862004)(186003)(5660300002)(2616005)(70206006)(16576012)(2906002)(316002)(47076005)(82740400003)(31686004)(81166007)(36756003)(966005)(478600001)(83380400001)(31696002)(36860700001)(82310400003)(336012)(86362001)(8676002)(53546011)(450100002)(4326008)(356005)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 12:54:43.7109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de73828-c112-4a14-744e-08d8e5560216
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6129
Cc: kevin.tian@intel.com, alex.williamson@redhat.com, mst@redhat.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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



On 3/3/21 10:47 PM, Jean-Philippe Brucker wrote:
> On Fri, Jan 15, 2021 at 05:43:33PM +0530, Vivek Gautam wrote:
>> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>>
>> Add required UAPI defines for probing table format for underlying
>> iommu hardware. The device may provide information about hardware
>> tables and additional capabilities for each device.
>> This allows guest to correctly fabricate stage-1 page tables.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> [Vivek: Use a single "struct virtio_iommu_probe_table_format" rather
>>          than separate structures for page table and pasid table format.
> 
> Makes sense. I've integrated that into the spec draft, added more precise
> documentation and modified some of the definitions.
> 
> The current draft is here:
> https://jpbrucker.net/virtio-iommu/spec/virtio-iommu-v0.13.pdf
> Posted on the list here
> https://lists.oasis-open.org/archives/virtio-dev/202102/msg00012.html

Thanks, I took an initial look, will review it this week.

> 
>> 	Also update commit message.]
>> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> ---
>>   include/uapi/linux/virtio_iommu.h | 44 ++++++++++++++++++++++++++++++-
>>   1 file changed, 43 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
>> index 237e36a280cb..43821e33e7af 100644
>> --- a/include/uapi/linux/virtio_iommu.h
>> +++ b/include/uapi/linux/virtio_iommu.h
>> @@ -2,7 +2,7 @@
>>   /*
>>    * Virtio-iommu definition v0.12
>>    *
>> - * Copyright (C) 2019 Arm Ltd.
>> + * Copyright (C) 2019-2021 Arm Ltd.
> 
> Not strictly necessary. But if you're modifying this comment please also
> remove the "v0.12" above

Sure, let me keep the copyright year unchanged until we finalize the 
changes in draft spec.

> 
>>    */
>>   #ifndef _UAPI_LINUX_VIRTIO_IOMMU_H
>>   #define _UAPI_LINUX_VIRTIO_IOMMU_H
>> @@ -111,6 +111,12 @@ struct virtio_iommu_req_unmap {
>>   
>>   #define VIRTIO_IOMMU_PROBE_T_NONE		0
>>   #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
>> +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
>> +#define VIRTIO_IOMMU_PROBE_T_INPUT_RANGE	3
>> +#define VIRTIO_IOMMU_PROBE_T_OUTPUT_SIZE	4
>> +#define VIRTIO_IOMMU_PROBE_T_PASID_SIZE		5
>> +#define VIRTIO_IOMMU_PROBE_T_PAGE_TABLE_FMT	6
>> +#define VIRTIO_IOMMU_PROBE_T_PASID_TABLE_FMT	7
> 
> Since there is a single struct we can have a single
> VIRTIO_IOMMU_PROBE_T_TABLE_FORMAT.

Right, that would make sense.

> 
>>   
>>   #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
>>   
>> @@ -130,6 +136,42 @@ struct virtio_iommu_probe_resv_mem {
>>   	__le64					end;
>>   };
>>   
>> +struct virtio_iommu_probe_page_size_mask {
>> +	struct virtio_iommu_probe_property	head;
>> +	__u8					reserved[4];
>> +	__le64					mask;
>> +};
>> +
>> +struct virtio_iommu_probe_input_range {
>> +	struct virtio_iommu_probe_property	head;
>> +	__u8					reserved[4];
>> +	__le64					start;
>> +	__le64					end;
>> +};
>> +
>> +struct virtio_iommu_probe_output_size {
>> +	struct virtio_iommu_probe_property	head;
>> +	__u8					bits;
>> +	__u8					reserved[3];
>> +};
>> +
>> +struct virtio_iommu_probe_pasid_size {
>> +	struct virtio_iommu_probe_property	head;
>> +	__u8					bits;
>> +	__u8					reserved[3];
>> +};
>> +
>> +/* Arm LPAE page table format */
>> +#define VIRTIO_IOMMU_FOMRAT_PGTF_ARM_LPAE	1
> 
> s/FOMRAT/FORMAT

Sure.

> 
>> +/* Arm smmu-v3 type PASID table format */
>> +#define VIRTIO_IOMMU_FORMAT_PSTF_ARM_SMMU_V3	2
> 
> These should be with the Arm-specific definitions patches 11 and 14

Right, will add these definitions with Arm specific patches.

Best regards
Vivek

[snip]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
