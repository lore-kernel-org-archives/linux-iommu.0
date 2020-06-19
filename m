Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEF1C433DF
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 22:57:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A1121D7D
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 22:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Q/vQ2c/R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Mf+hxfgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A1121D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5B6AD86BE1;
	Fri, 19 Jun 2020 22:57:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Uryz15LkY0z; Fri, 19 Jun 2020 22:57:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9846386BD0;
	Fri, 19 Jun 2020 22:57:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C7BCC0865;
	Fri, 19 Jun 2020 22:57:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2654C016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 22:57:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A9FF5896F3
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 22:57:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gm0x6B4XuFxF for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 22:57:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9ED1189551
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 22:57:19 +0000 (UTC)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05JMsCir023116; Fri, 19 Jun 2020 15:57:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=6hIjoTmd1LM1QJygvVjlWgxEyBWHDQEv/FmlOzrT8l0=;
 b=Q/vQ2c/RF6mP/yQHspRqKRE2mwkC5yoNwnUKnMkETDqXimHXup0ypT2DU9AP2jsCpPA/
 QHp4ColJXxhvOTKg2/r0v+KAeq5S8+bq3GQpXCSzCZfrH4Bth1T+xi8JJe5g7+ic9vmN
 Oa84CD16mp7aO33Wv/SMyweyAoSZW08LK1Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by mx0a-00082601.pphosted.com with ESMTP id 31rwgsbys8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 19 Jun 2020 15:57:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 15:57:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gx7jioYzCOyblXSZzj2ngM3MCb2JlPK7BCKNSULM1276O3MRKQ29nSb9skR/5B2D0M2GHnWfRx7TJaBp5mG18fzog/04esm5gwqNddK8wp1zCGB/zIgT14H98xdVMeu9aQeimia9B3miLOV8lvAmtek0FoyNCu7OdULa4MAmtlCdH5feIrgNQhz/IsEkULPYmj6HfVqgJF30a33T5rbdl44JanTZI8lJ5f+VRkBMQdLWW+Ug7QVjsNa3rr1Gwig6kwdPZnMhTc+0KVnkwwVV0sCzPSORAccaSf5bbV+JdJ5vpouNufY8aTYmIz+eFwRx16UvnII7E8VliQCI4v8H2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hIjoTmd1LM1QJygvVjlWgxEyBWHDQEv/FmlOzrT8l0=;
 b=SGnCLgMbLLIBAFcjRfROTyVmQM2pXxoQxjW1S0EdnCrQFkBqpzW4/jBXv9el5GJvrVWG7+fSHXFYrkryTOa2Zys7dcFqA5cOWzgVNYkULoTS3/r8gpddY04b61rAp3kY5uLj4gH0pOFv+FeIOqQUg8ZxW2mt/tDrTgsc60VXxG/wJ4iUjx/L/KIM1bOklt9SfSdiiAvtcUMrBiaVJsIyzcb+u3dYeeXBpRTCGL6Ua9EXVaVdu8ldLvhElsNX9bvA+WM7ma/PIQPbgi8Hl5VqxUgkHhT3bat6gZJmkQ1f7YVRzcaHfKY5fRJHmM7XTymexQKz6a84uhyhw+ZsyZe7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hIjoTmd1LM1QJygvVjlWgxEyBWHDQEv/FmlOzrT8l0=;
 b=Mf+hxfgVfve//bOFUBOeJJDmwE93fD6VkvMOzHgPgmDCQ70ygyXV11Yaz0yOqT+Z0v6VDvkL8warf79hF/vTdEyVlFdqcYsvvnmiryxg8ceP9X+Qc4wmshIlcyRJqx3gDX/bwrzXNnOl685ac8yHt7XkGedPv/NWSGIRN4zxOro=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3144.namprd15.prod.outlook.com (2603:10b6:a03:fe::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 22:57:07 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 22:57:07 +0000
Date: Fri, 19 Jun 2020 15:57:04 -0700
To: David Rientjes <rientjes@google.com>
Subject: Re: kernel BUG at mm/huge_memory.c:2613!
Message-ID: <20200619225704.GC237539@carbon.dhcp.thefacebook.com>
References: <20200619001938.GA135965@carbon.dhcp.thefacebook.com>
 <CAHbLzkrDcn-GQOrAM=m7+2g5_J6obsz4K50Oqb-1RD5p1iWTPQ@mail.gmail.com>
 <20200619011449.GC135965@carbon.dhcp.thefacebook.com>
 <20200619024026.GB21081@redhat.com>
 <20200619185540.GB217189@carbon.lan>
 <alpine.DEB.2.22.394.2006191354080.26224@chino.kir.corp.google.com>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006191354080.26224@chino.kir.corp.google.com>
X-ClientProxiedBy: BY5PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::35) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a2a9) by
 BY5PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:1e0::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23 via Frontend
 Transport; Fri, 19 Jun 2020 22:57:06 +0000
X-Originating-IP: [2620:10d:c090:400::5:a2a9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aae7227b-684a-40b9-9892-08d814a4175b
X-MS-TrafficTypeDiagnostic: BYAPR15MB3144:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3144A8139B66B907FE2D1FCBBE980@BYAPR15MB3144.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/G/8oEb7vQBmOB64xLWRxv50peqSOFGnv32FrbJ+Nnoh78GcFJclw5GkEZDLzeCagxIJgYEyZ9cuvOdgumft6u/wwd4EfdWj/0/VQwI5fPNF/5oe5n2r7oXsia+f4tqyzVD5xF+yk3MU4PLORZjbLvB2qXCk7QR54VDBrgKByXqD7yGu1Ka4YC/UkartCMtR/jayT9rLWWN1Mn23JrWRCceX29rS6dEZhiAw4pVjR/7fsfdIGDm5ljsHlSTTbJadTDK6uttEYvf2jMHqxyF86dUwdP1RlTMHootpk3qz7asfBqPXwNwEnrmfQcJQh0II6Xlyfr5IaPqBGROPUw2U8Ujm8iZxh+cHOBXDdIlq85Nt6ITKIcL/RYdsjdxguft
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR15MB4136.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(346002)(376002)(366004)(39860400002)(396003)(2906002)(86362001)(66946007)(1076003)(66476007)(66556008)(16526019)(478600001)(7416002)(186003)(54906003)(316002)(9686003)(8936002)(55016002)(7696005)(52116002)(8676002)(6916009)(33656002)(4326008)(5660300002)(83380400001)(6506007)(14583001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WmoV5lzelW17iBZ0E+/nh17IGMz37BEc0pLNVC6roRFHK56mt3f6Ju8LGZWPuljrzuVaaDBpoIrUbeltKqJQEtrdMKYnClUisc3Sl0SMMuIsNg/xgwPGW9dvIg2u0eyLoa8jZZwCqJ15tuihzPB7dPdrq8SQckbcO+O2BA4cl2mxS464W0vfm8nzkAMRLYZLaIx8tQ856fXX9KaqUUyi4YC0zYxU0kAIbfB9UnU1koTnBDdw9i7YFbxG2uyFFkMvyeUQjrJlrB3RKN3akLs6vfT19bIjYS6kFRJMiZ3NICbv8zneZ/fyuCxvO3kCyzZ0qJlRzN8LmVvzlgeQAMH/Imjv0hgC3m62HfCGFsE0JK6ZXf3//Bk8YjDSCQLWDGVDT4I6JvA/5pmA73y3tz9LbZvVWsh0qnhLDZx8o680c76X/Phztpga4MCcOZz9oZwMsi8jqwAAxegn1K33i2HLxPrbE6TfzzG+PSsLqsAbfwxq31LWAN5KLke3WF9YxulNkRpRHZaEKxcgeDbQUJHh6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: aae7227b-684a-40b9-9892-08d814a4175b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 22:57:07.3128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8C7lOXC5CwRSQfGMtw2CoZOy7+D/iSLpeWlT3eNLDrdmR1AYmZ7/usSg/PxOkXk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3144
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-19_22:2020-06-19,
 2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 phishscore=0
 cotscore=-2147483648 spamscore=0 suspectscore=1 clxscore=1015 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190160
X-FB-Internal: deliver
Cc: Andrea Arcangeli <aarcange@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Linux MM <linux-mm@kvack.org>,
 iommu@lists.linux-foundation.org, Wei Yang <richardw.yang@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
From: Roman Gushchin via iommu <iommu@lists.linux-foundation.org>
Reply-To: Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Jun 19, 2020 at 01:56:28PM -0700, David Rientjes wrote:
> On Fri, 19 Jun 2020, Roman Gushchin wrote:
> 
> > [   40.287524] BUG: unable to handle page fault for address: ffffa77b833df000
> > [   40.287529] #PF: supervisor write access in kernel mode
> > [   40.287531] #PF: error_code(0x000b) - reserved bit violation
> > [   40.287532] PGD 40d14e067 P4D 40d14e067 PUD 40d14f067 PMD 3ec54d067
> > PTE 80001688033d9163
> > [   40.287538] Oops: 000b [#2] SMP NOPTI
> > [   40.287542] CPU: 9 PID: 1986 Comm: pulseaudio Tainted: G      D
> >       5.8.0-rc1+ #697
> > [   40.287544] Hardware name: Gigabyte Technology Co., Ltd.
> > AB350-Gaming/AB350-Gaming-CF, BIOS F25 01/16/2019
> > [   40.287550] RIP: 0010:__memset+0x24/0x30
> > [   40.287553] Code: cc cc cc cc cc cc 0f 1f 44 00 00 49 89 f9 48 89
> > d1 83 e2 07 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48
> > 0f af c6 <f3> 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89
> > d1 f3
> > [   40.287556] RSP: 0018:ffffa77b827a7e08 EFLAGS: 00010216
> > [   40.287558] RAX: 0000000000000000 RBX: ffff90f77dced800 RCX: 00000000000008a0
> > [   40.287560] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffa77b833df000
> > [   40.287561] RBP: ffff90f7898c7000 R08: ffff90f78c507768 R09: ffffa77b833df000
> > [   40.287563] R10: ffffa77b833df000 R11: ffff90f7839f2d40 R12: 0000000000000000
> > [   40.287564] R13: ffff90f76a802e00 R14: ffffffffc0cb8880 R15: ffff90f770f4e700
> > [   40.287567] FS:  00007f3d8e8df880(0000) GS:ffff90f78ee40000(0000)
> > knlGS:0000000000000000
> > [   40.287569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   40.287570] CR2: ffffa77b833df000 CR3: 00000003fa556000 CR4: 00000000003406e0
> > [   40.287572] Call Trace:
> > [   40.287584]  snd_pcm_hw_params+0x3fd/0x490 [snd_pcm]
> > [   40.287593]  snd_pcm_common_ioctl+0x1c5/0x1110 [snd_pcm]
> > [   40.287601]  ? snd_pcm_info_user+0x64/0x80 [snd_pcm]
> > [   40.287608]  snd_pcm_ioctl+0x23/0x30 [snd_pcm]
> > [   40.287613]  ksys_ioctl+0x82/0xc0
> > [   40.287617]  __x64_sys_ioctl+0x16/0x20
> > [   40.287622]  do_syscall_64+0x4d/0x90
> > [   40.287627]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Hi Roman,
> 
> If you have CONFIG_AMD_MEM_ENCRYPT set, this should be resolved by
> 
> commit dbed452a078d56bc7f1abecc3edd6a75e8e4484e
> Author: David Rientjes <rientjes@google.com>
> Date:   Thu Jun 11 00:25:57 2020 -0700
> 
>     dma-pool: decouple DMA_REMAP from DMA_COHERENT_POOL
> 
> Or you might want to wait for 5.8-rc2 instead which includes this fix.
> 

Hello, David!

Thank you for pointing at it! Unfortunately, there must be something wrong
with drivers, your patch didn't help much. I still see the same stacktrace.

I'll try again after 5.8-rc2 will be out.

Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
