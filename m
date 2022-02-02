Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E5CC433EF
	for <iommu@archiver.kernel.org>; Wed,  2 Feb 2022 20:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 89959405AE;
	Wed,  2 Feb 2022 20:04:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OJrdA9NEW7KL; Wed,  2 Feb 2022 20:03:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D66624040C;
	Wed,  2 Feb 2022 20:03:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F81CC0011;
	Wed,  2 Feb 2022 20:03:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F0D5C000B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 20:03:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6FC7881318
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 20:03:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="mshD3LCu";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="ac8pVOWW"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZHWj6-lOLgza for <iommu@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 20:03:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2316D8130D
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 20:03:55 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212JE7r4023605; 
 Wed, 2 Feb 2022 20:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=NtMs9dXT6qJL/r+WMl0lpOfHbYLOe+UQtqsvdGdUYCg=;
 b=mshD3LCutIjRZPFwM0CTzOy5D/ji/a0KA1l+QArkZqwLY1UOtpwcL3W/HBGlB6EzFMkS
 tUDgVzXMfVQPIt4VMP9LbvBxRMoN2mScUums8AZ2w8SlDYIVXtcSCazRlvODMFpQuCUl
 OKzELkg/oheeyY29acZVNFyMW6KZWFEnwWrheP7SQDELgspuQE/6GvpqoMl5vB/T6Kjc
 9GHNLvvdm1FD1AQ/6TMVN5+2BCqxy1DaPH5e5a0vS2oomnPayFVF8CY0FluVLHzldfeb
 rwV0uSElPbiDz0OqUxxyI5leAfbLi8W6rLK0eHvBuPstC9bJ0VMBpYWEmfmBnkGmZK+V SQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fy8dy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Feb 2022 20:03:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212K1D5f007431;
 Wed, 2 Feb 2022 20:03:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
 by aserp3020.oracle.com with ESMTP id 3dvwd8vgpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Feb 2022 20:03:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dn/tLjC0dEzCkjTQgcK0LTWRx70Pz+Lq5srV+WwdpqHVs4VM4/YqkfAr/1XhzxJlRern7T2TZGYWt+TQ1kzOXTtndzjx9hWGGZCXHlp7RIiM5mYsupN+oDseYzvKuWenwvIlu+dkWk84kfsM9G++j+fglTbEwFy9A2EQG9eY+6LhIFZqZivYAaTfJ31gAJ2CXRnhrrhz7siWrG8KmKdiL2EOBL2T2ZrIgByIDMYdEnlyZopkGF1WaKNsHI+34j3rf68pMd/Y8zcnMs7R7UBKKD12umOzInBNmFbxOFoDrjYZUWHXIsn7/iWXVDXbIWltthZyBMAuZzcwpN40zNzzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtMs9dXT6qJL/r+WMl0lpOfHbYLOe+UQtqsvdGdUYCg=;
 b=CQSZisngW02tZAmJjCDYiaMiYbFtelosaSDNYP9qL2MWakTNsQ2eEjrV3LUkbNL2dSn8OMsduAWoP0wfLPPANbGh9D7DXrynMyA1hz6s+SFwl5/FaUClWr8fW/z2LxLky1xeibGk2K8a0WEA6+oig4YbDyMID4csd5rSbsAM7Hp0DpACJyfsBDG2syYTGZnUAMuzlB4zaZjYvPK1MvwWL8X6lDl5Bg21AqYpFI6pQkRk+8d+ANEBcu7EZyb2FEpbsDIC9VzwOLBOSkxgajtXg/WBkTnsg4xGQUVMilE5q/qAsVOBWi5ARwcP3pGWYbxjPgz4DGTGS1QQ3/Y7IrPxOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtMs9dXT6qJL/r+WMl0lpOfHbYLOe+UQtqsvdGdUYCg=;
 b=ac8pVOWWeP5mlirjO6HVZFBWHa5025CCw1HkyvK9oWA2v3FveHpvUgfaLlVz+05QcYxKP2nad+RP0QCEaZxEFN8jUm+qkq4bqMrORTPkXcNyZ+uebFPa6SDXd8p4DoA/kbPaH8G4hYMBL3V/C1fgf6a80t7v1fi0KVNcrIabeJ8=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by CH2PR10MB4229.namprd10.prod.outlook.com (2603:10b6:610:7a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 20:03:48 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c4e6:3a75:dd85:1912]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c4e6:3a75:dd85:1912%3]) with mapi id 15.20.4930.021; Wed, 2 Feb 2022
 20:03:48 +0000
Date: Wed, 2 Feb 2022 15:03:43 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: iommu/amd: bug report: page table memory leak
Message-ID: <20220202200343.ush43too2uxh4fhd@oracle.com>
References: <20220118194720.urjgi73b7c3tq2o6@oracle.com>
Content-Disposition: inline
In-Reply-To: <20220118194720.urjgi73b7c3tq2o6@oracle.com>
X-ClientProxiedBy: BL0PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:207:3c::18) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa3f137f-20a5-42fd-6858-08d9e6872025
X-MS-TrafficTypeDiagnostic: CH2PR10MB4229:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB422919E277EA09C4425F332ED9279@CH2PR10MB4229.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RpHnTX1uUITPigJNpxVGi/OK1vcQM0nhRHA/kI1b1PTKyoCdrKmFF09hNHaNi988Z3IwnCS2SlS4o4D+fjUxl7Lxa/qA6NFaI6JX+LWgoG5yR3jhLW8F4Z/J1lk8CXmr30i+AqAz5ZDpQIINwNWyTCoCHlDZkCbthv8P49KW8ZF60ijFaiPtjF4sxJFP7iva+fA3P07w477yRYQ90zK+G1mskBSdy+iRnyOyOyL2YWKN6+N8YWFb3itM1Q8E/KenRPrwcsymvm52KWyIE1+4AyADsIKATpc/V7T5PDnWCmAXcpbsipYA+joO/m2gBQmpqHJ7ujqCt0g/3rfewOao1GvXtD3KWX8bAmDxe7S/UWvA6FDp0obtjak0GtsSdDGdsduQbwqD+Mf3LQLn0HKnV2sNeX5pKyG8C13+bp7jp3bItWy7l6IRR8t7RTVktW/gfIj8ORiAe/g3Ccbz17PcGHo1aAhC3Nd+r6fH5BUKRTUJo5XCNpIYYRvwXembtkQc2ObrrM6wZqcasfVEqPhhisKXq05/LUlpOpiqxlVTnxB7GEZkQ8mTeTE/dwFTwR2frshZnhu/1EVyIvNds2kyyfcMk7dBTT+xtHY5GOE8T28aL21LroFA/KrSc9ruDQAG73WlI9tSVRYzdiQtfUTc7drQwIKwKivqnUS0crlnFTlymL9T1PbFdseyvuOepjcr3zqoixXgPtnvkpk66e4wFmJMfamvxNo4XL8eiJTKUAZHxN+7YBWS6AbanEgq1i+GhWMA5UIJFc58Yc94yLeEUkrU1kVrEuScNbhzntoYh2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB5711.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(38350700002)(38100700002)(2906002)(5660300002)(6506007)(6512007)(6666004)(52116002)(316002)(966005)(110136005)(508600001)(6486002)(83380400001)(66556008)(66476007)(26005)(186003)(8936002)(8676002)(1076003)(2616005)(66946007)(36756003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wdDKFwESUuIKueaUW23BIKApXhCsbFFRNiR0eGzzG7kb2W6/k0Kw88GhcsWs?=
 =?us-ascii?Q?+zun9YDg3TNkz1VxYvZDDeoaJWHywbVhpIgY6WmYwD4cjltBlFjfG5YmYc8W?=
 =?us-ascii?Q?IuCM4uDn2iFMXB+f6RQ7IapLZZLFxM8ZwhvafNGtaFXAyZpxjrg6cwJk20fN?=
 =?us-ascii?Q?vaX8MhHs/IQWsbt9816OIl0wHwsn6dU7n7jBVFjwJc2evOBS6cIwAtDI880L?=
 =?us-ascii?Q?PaNp5BrzRcNt+fENvAZrxAxJV5vIROT4VSGMPlhRzBFP2jTfPlCkbEsw8YQ3?=
 =?us-ascii?Q?1Q4xTL47C11dHxO+mwtpNztaGBwmu1B/3RLn90vgAv7ZQFWU4jUvndnqwoUs?=
 =?us-ascii?Q?sTqmROd3ik7BGaU6abZoXCELcpMp0oo1p+hLozG+IjOutisZFcYSfwjXF78O?=
 =?us-ascii?Q?h5bE7bfyo0ISThMqlaKDUBx8Gxf1lisXcQGzsUjwaDYcpgrwiyrx/83fCLvy?=
 =?us-ascii?Q?HwtDaoc2WVpeHbdJG9x40JR9MpAywZL1qSxT8d1JdybvH77FebpLlXxS7YfL?=
 =?us-ascii?Q?z4Kty9YhYkUg9bis+vMuPjEfvu6sTbUmK+pb22gpjhim1zi2e4MLcRNQLIuy?=
 =?us-ascii?Q?b8PqmjTR7m+AzRFQ/KM7n539YaRwvk4/CVS3zWREwemQ8AnOGBR6eTh+hJyy?=
 =?us-ascii?Q?8T/ayRrEnM0rdrYIrXQuiUxIQYi29Q/CTlHB1g39V/i3aY4n66V78Ho3OWE2?=
 =?us-ascii?Q?QVnycdSRp2Y0DpD3OyoZF3WOXGu3VK+JPlb9WJXGKD1D0CCF41pTeATNx4Cv?=
 =?us-ascii?Q?l86tNYxTtoUiyCd5N9XfrdYNJNKMe/Ta0Da1FDPFxzBHmv1MCxm5msfLzw3X?=
 =?us-ascii?Q?bckyC3rl7Z+CS1ABGNKURHctim7kjMJs7uOBHCvcAlL1ZEvrsI7HYBiwJcTT?=
 =?us-ascii?Q?TlQ3g5vFVVrdSCaw3RFDl0qj/2OX/L9tcgK1Q5InbC5i45lehdeLrUAuK+lu?=
 =?us-ascii?Q?BnBknzmorkyABK7LEj4khlj0gw5GbA7w6WkEaEFZOm9J6Gek0cUGanjOqjfQ?=
 =?us-ascii?Q?X8kxx4oaPqfNGq0wCz6n4TU9+3i36WGJ8uRYZ8QCwUCnqm5SJCuLJ+aWMG67?=
 =?us-ascii?Q?asnbo5hhbs6BITxhgL/wGLeGmhe6/Y7WbaZaYjcyJBl42krMeaibfDJG/Vdl?=
 =?us-ascii?Q?DeYKKOxyn4Zy4QzuNKsu48G8TeKVxPpT7nT33Z2IBDHoA1BYOspzs8Rozvlu?=
 =?us-ascii?Q?m6gPy+MILk8yiyR4LJGXIe+f8FxfahJHNcaLp/cPQ5/aV7x1Tzzmx/Cjia9e?=
 =?us-ascii?Q?n9eGvtmhmrfWPm3PKA86s7vgS+qVHDnWxIBsyzCC83x+JERTHESwV77nEe5e?=
 =?us-ascii?Q?zjbT0/+ET7SjEOe7lMSnfAnR4skMfUZsMaMRTvuu1YQYu59Ukk5DcQx6fnX/?=
 =?us-ascii?Q?shpcppqich9u27IQnxuxv+qYSQ5wcyN8x83oXZ91PITZVbY73yj691egzTFM?=
 =?us-ascii?Q?vQ4J5tx15DOSHKQGzKNUxElX6fmq1miX7jji8H4wXv1AaDqAtOkPoW9aXy26?=
 =?us-ascii?Q?vLUZfIv4JGWVFCP0OTcNId9ndcu/oEK5esj4ru3yLIojLjGcxaHzFyOdqHW1?=
 =?us-ascii?Q?HOg5fhyEuWmXff3PtvtC4DWm1k+jN7N2XRXJDjxDKBpaFKD5bwzs/ENr2862?=
 =?us-ascii?Q?JjuQMCDaYrPwRymmutsBNPXQVXqubt3O37IxvmIdIhOzu5b2O8HPvsr6HujE?=
 =?us-ascii?Q?mkTg0g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3f137f-20a5-42fd-6858-08d9e6872025
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 20:03:48.7836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RuaVmo9TBvq24Sb6tb9cIjU1mJjjXjJvok4WojFHvR4REIYQwLrvKZu5hS4iGwxVvfhhqYDlHNEDVbSI88/vaL1ZH7JxNEj+aI8WjCk6Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4229
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246
 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020109
X-Proofpoint-GUID: JI2BKfOhi-uldtFasypgWu4hwAEZOSRZ
X-Proofpoint-ORIG-GUID: JI2BKfOhi-uldtFasypgWu4hwAEZOSRZ
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

Friendly ping.  Any thoughts about this report?

thanks,
Daniel

On Tue, Jan 18, 2022 at 02:47:20PM -0500, Daniel Jordan wrote:
> Hi,
> 
> I've hit a memory leak while testing qemu v6.2.0-rc4 on an AMD EPYC 7J13
> (Milan) system.  Starting an almost 1T guest, the leak is over 1.5G per
> qemu invocation.  I haven't checked whether the leak is proportional to
> guest size.  It happens with a vfio device, and only when the guest's
> memory is preallocated using qemu prealloc (this latter part is kinda
> strange).  It happens when the guest memory uses THP but not hugetlb.
> 
> Bisection:
> 
> # bad: [df0cc57e057f18e44dac8e6c18aba47ab53202f9] Linux 5.16                
> # good: [f40ddce88593482919761f74910f42f4b84c004b] Linux 5.11
> git bisect start 'df0cc57e057f1' 'f40ddce885934' '--' 'drivers/vfio' 'drivers/iommu' 'include/linux/amd-iommu.h' 'include/linux/dma-iommu.h' 'include/linux/intel-iommu.h' 'include/linux/iommu-helper.h' 'include/linux/of_iommu.h' 'include/
> linux/omap-iommu.h' 'include/linux/platform_data/iommu-omap.h' 'include/linux/iommu.h' 'include/trace/events/intel_iommu.h' 'include/trace/events/iommu.h' 'include/uapi/linux/iommu.h' 'include/uapi/linux/virtio_iommu.h' 'arch/x86/events/a
> md/iommu.h' 'arch/x86/events/amd/iommu.c' 'arch/x86/include/asm/iommu.h' 'arch/x86/include/asm/iommu_table.h' 'arch/x86/kernel/pci-iommu_table.c'
> # bad: [cee57d4fe74e82e784f6566bad3e3bb1ca51a211] iommu/vt-d: Remove unnecessary braces
> git bisect bad cee57d4fe74e82e784f6566bad3e3bb1ca51a211                           
> # bad: [9fb5fad562fa0a41c84691714d99c23f54168a9e] iommu: remove DOMAIN_ATTR_PAGING
> git bisect bad 9fb5fad562fa0a41c84691714d99c23f54168a9e                           
> # bad: [45e606f2726926b04094e1c9bf809bca4884c57f] Merge branches 'arm/renesas', 'arm/smmu', 'x86/amd', 'x86/vt-d' and 'core' into next
> git bisect bad 45e606f2726926b04094e1c9bf809bca4884c57f
> # good: [7060377ce06f9cd3ed6274c0f2310463feb5baec] Merge branch 'for-joerg/mtk' into for-joerg/arm-smmu/updates
> git bisect good 7060377ce06f9cd3ed6274c0f2310463feb5baec
> # bad: [6778ff5b21bd8e78c8bd547fd66437cf2657fd9b] iommu/amd: Fix performance counter initialization
> git bisect bad 6778ff5b21bd8e78c8bd547fd66437cf2657fd9b
> # good: [f9b4df790aa4372bfa11b7d212e537b763295429] iommu/amd: Declare functions as extern
> git bisect good f9b4df790aa4372bfa11b7d212e537b763295429
> # bad: [33aef9786046d9a5744cd1e8d5d0ce800d611fdc] iommu/amd: Rename variables to be consistent with struct io_pgtable_ops
> git bisect bad 33aef9786046d9a5744cd1e8d5d0ce800d611fdc       
> # bad: [e42ba0633064ef23eb1c8c21edf96bac1541bd4b] iommu/amd: Restructure code for freeing page table
> git bisect bad e42ba0633064ef23eb1c8c21edf96bac1541bd4b       
> # good: [18954252a1d0b12e1b77087b55c37fb43b09e12a] iommu/amd: Move IO page table related functions
> git bisect good 18954252a1d0b12e1b77087b55c37fb43b09e12a      
> # first bad commit: [e42ba0633064ef23eb1c8c21edf96bac1541bd4b] iommu/amd: Restructure code for freeing page table
> 
> commit e42ba0633064ef23eb1c8c21edf96bac1541bd4b                         
> Author: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>                            
> Date:   Tue Dec 15 01:36:59 2020 -0600                                  
>                                                                                          
>     iommu/amd: Restructure code for freeing page table                    
>                                                                                          
>     By consolidate logic into v1_free_pgtable helper function,            
>     which is called from IO page table framework.                                        
>                                                                             
>     Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>     Link: https://lore.kernel.org/r/20201215073705.123786-8-suravee.suthikulpanit@amd.com
>     Signed-off-by: Joerg Roedel <jroedel@suse.de>                         
>                                                                             
>  drivers/iommu/amd/amd_iommu.h  |  1 -                                    
>  drivers/iommu/amd/io_pgtable.c | 41 ++++++++++++++++++++++++-----------------
>  drivers/iommu/amd/iommu.c      | 21 ++++-----------------                
>  3 files changed, 28 insertions(+), 35 deletions(-)                         
> 
> Qemu command line:
> 
> numactl -m 1 -N 1 "$QEMU" \
>     -name vmol74 \
>     -machine q35,accel=kvm,usb=off,dump-guest-core=off,memory-backend=pc.ram \
>     -cpu host,host-phys-bits=true \
>     -smp cpus=32 \
>     -no-user-config \
>     -nodefaults \
>     -rtc base=utc,driftfix=slew \
>     -global kvm-pit.lost_tick_policy=delay \
>     -no-hpet \
>     -no-shutdown \
>     -boot strict=on \
>     -drive file=${vm_image},format=raw,if=none,id=drive-ide0-0-0 \
>     -device ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=2 \
>     -device vfio-pci,host=${pci_addr},id=net2,bus=pcie.0 \
>     -msg timestamp=on \
>     -nographic \
>     -object memory-backend-ram,id=pc.ram,size=980g,prealloc=on,prealloc-threads=16 -m 980g \
>     -daemonize
> 
> Kernel config attached, and I can provide other details too if I left
> anything out.
> 
> thanks,
> Daniel


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
