Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63C6C43461
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 10:38:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181E420738
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 10:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="11/GsadY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181E420738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C6CD887310;
	Wed, 16 Sep 2020 10:38:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qDaYQVyYCwC6; Wed, 16 Sep 2020 10:38:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1513D8730E;
	Wed, 16 Sep 2020 10:38:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAA8EC0864;
	Wed, 16 Sep 2020 10:38:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 009BEC0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 10:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DB9D020110
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 10:38:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4gntUUkQmjZf for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 10:38:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by silver.osuosl.org (Postfix) with ESMTPS id 4AE661FCA0
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 10:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDdfsFaAFw+mj8tOiYRxH8URu47xY/+Ya8LFrGBHjxgMsaUDG9NIUqwDv6IBT1DnK4FMIk/oSMJQKwS57fTQZxZnmClSCMSK++n7N98x4b0N5TO7UQIHRDR1oCqxFl7F0cNcIEWOosgTwm17ZpXKUYV/hFbdyrjyzHJutpUNkvL8gPK8vJFV6R9Z5wd0tM4QpiG3fNLBFAbGYlm1avGxJtmW52CW2YKAGGog7/j4qKC47VJwmIAhyThgzzb5BZqEBC/kMlkCKxpw5T8PRcfZHVIeE+6aRJTBuV3aYc4Q4dvUaMYSyV7j0COKy5KUxzhx/jgw4pZo/iOaKRwpGjIOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3O9y+S0/8tqXro5HSEPbfeNx8lpmKp30M9HB8TRz/g=;
 b=V8MVGe+j6lNDQTtgAWamIK2GCccru13cEyBCpk0Zt8VfKCkJJr2J/r06TckcAOlffQwQpj0DgbyF5aQgru9CnoBOGoK/hCJwZSSLxVPnZWJY2Y6jYcWmrT6zZue4vOzy8eM8z3F49d9Y9tSUS5wAUMt+VvLPqffPW8+zZBCCYkN7Khr5MGqwPcwkF9/FqFccRNeZj8PE0LZorL2A+R5dJsha3fk9+2bEv8EOfoH+0YvnB6wCryqxrcMg2g1fr42h7t1Nm5CB9Ca1Ab7MOtXFIG6QuGjmQhIgT39Zp5MUDr9wSUlgnQS6N+HSP3bfoVWX6isXM5MLaXshpplcqW5Cyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3O9y+S0/8tqXro5HSEPbfeNx8lpmKp30M9HB8TRz/g=;
 b=11/GsadYlvMu77LBTMePeyJy4XKnj9ifPk+q/E7p/GyIbe70peoyQ2ff+99jSnQpzYnwvYKrRF/t9jLGjoCTA4VYhHDuBUBFwDcKGCBNbD7Q7wlTxqxb78CCOR9YbGorXJQqf1fztlI1728tYJbhB3iI/Xz+HAoaWEYNLQvUeuE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 16 Sep 2020 10:38:20 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 10:38:20 +0000
Subject: Re: [PATCH] iommu/amd: fix interrupt remapping for avic
To: Joao Martins <joao.m.martins@oracle.com>
References: <20200913124211.6419-1-mlevitsk@redhat.com>
 <60856c61-062b-8d92-e565-38bd00855228@amd.com>
 <04a8ab5cb1f6662f72bcad856da3415d6d9b2593.camel@redhat.com>
 <dd0b9a98-149a-286c-2793-8ea0e8b60e2e@amd.com>
 <b323b9d5-8149-5e6f-c24e-43b64bc6f2f6@oracle.com>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <41a32d50-63ae-a8f3-bc2e-eee28e9e1c08@amd.com>
Date: Wed, 16 Sep 2020 17:38:09 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <b323b9d5-8149-5e6f-c24e-43b64bc6f2f6@oracle.com>
Content-Language: en-US
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.140.250) by
 SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 10:38:18 +0000
X-Originating-IP: [165.204.140.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a47d888d-64c7-43f6-70b2-08d85a2ca143
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42199800073222FB73E539B7F3210@DM6PR12MB4219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZj57iadkN1FZ2kLtd83vW6UUnSQoUmAob49fkWy+qMBnSjtTXyZLTjKtKUN3SibxRsidQye1w/Thu9LddHI64BE01IrSJ56GDDbD7QU7cT/0N5spLUMKtVg9Vk5nnQx7gbGckRUCbsQ7yNpd5y+8BDL66aIlcUC+nYXVSXtaBRnj/6y8c5dkSJvBclpX5yhP79Lc1s9VDWSd3Q4wxrkE9V+NUP9mfxx1mOFPQ1gURCtkLUi0Uufxyq0A9aDDFeM63JfSMGPblDtWKz23m7pNyHDzBdawo3dgLNoXuIfjwq0ge54f0B5nzpC/i4Fx7eEWhr4nIdQ0JAXRt1RrVoz+TRTGVTsIIJhmbMqe7cR2fLrDgFT1+u3LMm6henchHHB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(83380400001)(36756003)(31686004)(4326008)(86362001)(8676002)(6916009)(8936002)(6512007)(31696002)(6486002)(66556008)(478600001)(66476007)(6666004)(5660300002)(956004)(2906002)(66946007)(44832011)(2616005)(6506007)(316002)(54906003)(16526019)(186003)(53546011)(26005)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: T6q2YvIUdRDulTXMoT/hjxZy2CCheeRMMw8moL8NCjnClylTLuskqi3zEdMbfuSyjbuC1n+J/ia2SblTfo8NdyGC9MpXKvYP1AYkUOKEkH5uIlnUibiFpw3FAKywftp5OHMJNeezcDAxWXgXqbbu+9DO1ne3Jb2KcAq+mevTH/Lc+lZrTFqPPIA/hF6NvXu93NlG7UAJr7V+S7i700MH/u8hilKICpKxcgnsIFI0zTt+jaiiXuwbgU0tKs4QQRNUM58kO3icqQUsBpRqUwl7W5xKiyLlyZKzURZB79Ovn2EgRza1Qnv31SN/a8UNvGsg8WdDlS7rnn+gxqSnHKWMt35HD5jgd+2nvFI/Pd0Yg1qawtJfy1eGBPR/+Iw8F/spUPRJHJKn67eOrH7soMKsAPqmG8xOsR5Rvo/Iv8I+sknl1di+szhKgGhLkzGHZHBfEFCA7aln3H4JCfpoBQWsFkBvGmNlCUjUmFp7iK/aY47VGs5Xq3www2bMFrKaCjGFqub4o+UZ2OqCG6KKQLCuSA8XMFw8ztIrdiTblB+u6t5HFyY/XLDlViMSrmQQT9gIKtDvH0YHXUpp9pRKicdar+LuNgl6XaSEmZkV4Kq0T9FRNJcU60H02H4b9vbD0VR9fFSP7tf7p6ZUQZ2+u2USxg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47d888d-64c7-43f6-70b2-08d85a2ca143
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 10:38:20.6556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQWT225PvxYfyIj5KIF9Kn+4VU5Jy/fmHk4BmFJo5ZSSLubkK+zRakE17uM4GoQyVSh7GQxQZRhJulJWnjEUoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
Cc: iommu@lists.linux-foundation.org, "Grimm, Jon" <jon.grimm@amd.com>,
 linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiA5LzE1LzIwIDg6MTkgUE0sIEpvYW8gTWFydGlucyB3cm90ZToKPiBPbiA5LzE1LzIwIDE6
MzAgUE0sIFN1cmF2ZWUgU3V0aGlrdWxwYW5pdCB3cm90ZToKPj4gT24gOS8xNS8yMCA2OjI1IFBN
LCBNYXhpbSBMZXZpdHNreSB3cm90ZToKPj4+IE9uIE1vbiwgMjAyMC0wOS0xNCBhdCAyMTo0OCAr
MDcwMCwgU3VyYXZlZSBTdXRoaWt1bHBhbml0IHdyb3RlOgo+Pj4+IENvdWxkIHlvdSBwbGVhc2Ug
dHJ5IHdpdGggdGhlIGZvbGxvd2luZyBwYXRjaCBpbnN0ZWFkPwo+Pj4+Cj4+Pj4gLS0tIGEvZHJp
dmVycy9pb21tdS9hbWQvaW9tbXUuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYW1kL2lvbW11
LmMKPj4+PiBAQCAtMzg0MCwxNCArMzg0MCwxOCBAQCBpbnQgYW1kX2lvbW11X2FjdGl2YXRlX2d1
ZXN0X21vZGUodm9pZCAqZGF0YSkKPj4+PiAgICAgewo+Pj4+ICAgICAgICAgICAgc3RydWN0IGFt
ZF9pcl9kYXRhICppcl9kYXRhID0gKHN0cnVjdCBhbWRfaXJfZGF0YSAqKWRhdGE7Cj4+Pj4gICAg
ICAgICAgICBzdHJ1Y3QgaXJ0ZV9nYSAqZW50cnkgPSAoc3RydWN0IGlydGVfZ2EgKikgaXJfZGF0
YS0+ZW50cnk7Cj4+Pj4gKyAgICAgICB1NjQgdmFsaWQ7Cj4+Pj4KPj4+PiAgICAgICAgICAgIGlm
ICghQU1EX0lPTU1VX0dVRVNUX0lSX1ZBUElDKGFtZF9pb21tdV9ndWVzdF9pcikgfHwKPj4+PiAg
ICAgICAgICAgICAgICAhZW50cnkgfHwgZW50cnktPmxvLmZpZWxkc192YXBpYy5ndWVzdF9tb2Rl
KQo+Pj4+ICAgICAgICAgICAgICAgICAgICByZXR1cm4gMDsKPj4+Pgo+Pj4+ICsgICAgICAgdmFs
aWQgPSBlbnRyeS0+bG8uZmllbGRzX3ZhcGljLnZhbGlkOwo+Pj4+ICsKPj4+PiAgICAgICAgICAg
IGVudHJ5LT5sby52YWwgPSAwOwo+Pj4+ICAgICAgICAgICAgZW50cnktPmhpLnZhbCA9IDA7Cj4+
Pj4KPj4+PiArICAgICAgIGVudHJ5LT5sby5maWVsZHNfdmFwaWMudmFsaWQgICAgICAgPSB2YWxp
ZDsKPj4+PiAgICAgICAgICAgIGVudHJ5LT5sby5maWVsZHNfdmFwaWMuZ3Vlc3RfbW9kZSAgPSAx
Owo+Pj4+ICAgICAgICAgICAgZW50cnktPmxvLmZpZWxkc192YXBpYy5nYV9sb2dfaW50ciA9IDE7
Cj4+Pj4gICAgICAgICAgICBlbnRyeS0+aGkuZmllbGRzLmdhX3Jvb3RfcHRyICAgICAgID0gaXJf
ZGF0YS0+Z2Ffcm9vdF9wdHI7Cj4+Pj4gQEAgLTM4NjQsMTIgKzM4NjgsMTQgQEAgaW50IGFtZF9p
b21tdV9kZWFjdGl2YXRlX2d1ZXN0X21vZGUodm9pZCAqZGF0YSkKPj4+PiAgICAgICAgICAgIHN0
cnVjdCBhbWRfaXJfZGF0YSAqaXJfZGF0YSA9IChzdHJ1Y3QgYW1kX2lyX2RhdGEgKilkYXRhOwo+
Pj4+ICAgICAgICAgICAgc3RydWN0IGlydGVfZ2EgKmVudHJ5ID0gKHN0cnVjdCBpcnRlX2dhICop
IGlyX2RhdGEtPmVudHJ5Owo+Pj4+ICAgICAgICAgICAgc3RydWN0IGlycV9jZmcgKmNmZyA9IGly
X2RhdGEtPmNmZzsKPj4+PiAtICAgICAgIHU2NCB2YWxpZCA9IGVudHJ5LT5sby5maWVsZHNfcmVt
YXAudmFsaWQ7Cj4+Pj4gKyAgICAgICB1NjQgdmFsaWQ7Cj4+Pj4KPj4+PiAgICAgICAgICAgIGlm
ICghQU1EX0lPTU1VX0dVRVNUX0lSX1ZBUElDKGFtZF9pb21tdV9ndWVzdF9pcikgfHwKPj4+PiAg
ICAgICAgICAgICAgICAhZW50cnkgfHwgIWVudHJ5LT5sby5maWVsZHNfdmFwaWMuZ3Vlc3RfbW9k
ZSkKPj4+PiAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4+Pj4KPj4+PiArICAgICAgIHZh
bGlkID0gZW50cnktPmxvLmZpZWxkc19yZW1hcC52YWxpZDsKPj4+PiArCj4+Pj4gICAgICAgICAg
ICBlbnRyeS0+bG8udmFsID0gMDsKPj4+PiAgICAgICAgICAgIGVudHJ5LT5oaS52YWwgPSAwOwo+
Pj4gSSBzZWUuIEkgYmFzZWQgbXkgYXBwcm9hY2ggb24gdGhlIGZhY3QgdGhhdCB2YWxpZCBiaXQg
d2FzCj4+PiBzZXQgYWx3YXlzIHRvIHRydWUgYW55d2F5IGJlZm9yZSwgcGx1cyB0aGF0IGFtZF9p
b21tdV9hY3RpdmF0ZV9ndWVzdF9tb2RlCj4+PiBzaG91bGQgYmUgcmVhbGx5IG9ubHkgY2FsbGVk
IHdoZW4gc29tZW9uZSBhY3RpdmF0ZXMgYSB2YWxpZCBpbnRlcnJ1cHQgcmVtYXBwaW5nCj4+PiBl
bnRyeSwgYnV0IElNSE8gdGhlIGFwcHJvYWNoIG9mIHByZXNlcnZpbmcgdGhlIHZhbGlkIGJpdCBp
cyBzYWZlciBhbnl3YXkuCj4+Pgo+Pj4gSXQgd29ya3Mgb24gbXkgc3lzdGVtIChJIGFwcGxpZWQg
dGhlIHBhdGNoIG1hbnVhbGx5LCBzaW5jZSBlaXRoZXIgeW91ciBvciBteSBlbWFpbCBjbGllbnQs
Cj4+PiBzZWVtcyB0byBtYW5nbGUgdGhlIHBhdGNoKQo+Pj4KPj4KPj4gU29ycnkgZm9yIHRoZSBt
YW5nbGVkIHBhdGNoLiBJJ2xsIHN1Ym1pdCB0aGUgcGF0Y2ggdy8geW91ciBpbmZvcm1hdGlvbi4g
VGhhbmtzIGZvciB5b3VyIGhlbHAgcmVwb3J0aW5nLCBkZWJ1Z2dpbmcsIGFuZAo+PiB0ZXN0aW5n
IHRoZSBwYXRjaC4KPj4KPiBJIGFzc3VtZSB5b3UncmUgb25seSBkb2luZyB0aGUgdmFsaWQgYml0
IHByZXNlcnZhdGlvbiBpbiBhbWRfaW9tbXVfYWN0aXZhdGVfZ3Vlc3RfbW9kZSgpID8KPiBUaGUg
bnVsbCBkZXJlZiBmaXggaW4gYW1kX2lvbW11X2RlYWN0aXZhdGVfZ3Vlc3RfbW9kZSgpIHdhcyBm
aXhlZCBlbHNld2hlcmVbMF0sIG9yIGFyZSB5b3UKPiBwbGFubmluZyBvbiBtZXJnaW5nIGJvdGgg
Y2hhbmdlcyBsaWtlIHRoZSBkaWZmIHlvdSBhdHRhY2hlZD8KCkkgYW0gcGxhbm5pbmcgdG8gc2Vu
ZCBhIHNlcGFyYXRlIHBhdGNoIGp1c3QgZm9yIGFtZF9pb21tdV9hY3RpdmF0ZV9ndWVzdF9tb2Rl
KCkuCgo+IEFza2luZyBhbHNvIGJlY2F1c2UgY29tbWl0IDI2ZTQ5NWYzNDEgKCJpb21tdS9hbWQ6
IFJlc3RvcmUgSVJURS5SZW1hcEVuIGJpdCBhZnRlcgo+IHByb2dyYW1taW5nIElSVEUiKSB3YXMg
YWRkZWQgaW4gdjUuNCBhbmQgdjUuOCBzdGFibGUgdHJlZXMgYnV0IHRoZSB2NS40IGJhY2twb3J0
IGRpZG4ndAo+IGluY2x1ZGUgZTUyZDU4ZDU0YTMyMSAoImlvbW11L2FtZDogVXNlIGNtcHhjaGdf
ZG91YmxlKCkgd2hlbiB1cGRhdGluZyAxMjgtYml0IElSVEUiKS4KCldlIHNob3VsZCBwcm9iYWJs
eSBiYWNrcG9ydCB0aGUg77u/ZTUyZDU4ZDU0YTMyMSBhbG9uZyB3aXRoIHRoZSBmaXhlcyBpbiBh
bWRfaW9tbXVfYWN0aXZhdGVfZ3Vlc3RfbW9kZSgpIGFuZCAKYW1kX2lvbW11X2RlYWN0aXZhdGVf
Z3Vlc3RfbW9kZSgpLiBJJ2xsIHdvcmsgd2l0aCB0aGUgY29tbXVuaXR5IHRvIGdldCB0aGVzZSBi
YWNrLXBvcnRlZC4KClRoYW5rcywKU3VyYXZlZQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
