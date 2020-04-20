Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A64BC38A30
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 17:52:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1755B20B1F
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 17:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="39M90MWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1755B20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D16CA87F3F;
	Mon, 20 Apr 2020 17:52:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l8fqvMXTO0SO; Mon, 20 Apr 2020 17:52:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0F74E87ED2;
	Mon, 20 Apr 2020 17:52:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA2E1C07FF;
	Mon, 20 Apr 2020 17:52:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E47E5C0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 17:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D6746204FC
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 17:52:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aGl8IpRKepUI for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 17:52:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by silver.osuosl.org (Postfix) with ESMTPS id CD041204F6
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 17:52:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccYo/cmfpe5fodc/OYQgIMoa4+KExM9zcSaTsZkc1Z2jU1jcC2IkMZFwndi8sAAzavl1xv/rI9sKP9Yqhy3kuScYE4+QRLuxr8uVAoiEs4zZwuA2h75t+KudMVAUfICcSsH5EW4g8mq69G9JR+QgJhs1C1KI+akpuXM0sXs2IBjb25v4x6T65P6xAoicGOUacnI7iUXzGnWEWNCMUQo9xLw39mCDNjHrI/3+R5hXt9VfzYWHFijuu4H/mGoSCVejYubt4ZLGK5oP+MGqSUk+CUNXSLQjmSq52XY0x8BPhUMvLD6GPQ6Ji5lTXs56Ty6AC9SrpOI7UFeFkJIUtwpmNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xz2XZBnz6DDavURpQmofPRODhZE3ebr44a2k4OUazkQ=;
 b=jiL3JoGajUPhtSVJtxDs+O/mDMatUrulh+u4aV0kbhs63ywsFoSfkWeuqcEHVCp6d48RAvWaNiUuaWAkxLAtboMN4ZonCRhUCgEr5vzX86cKb3xtCeIboLvcQGR+MDchfZXqpdzIcROPzmxAjKDGIUrhAJp4JQxnzxQaSpzm7eDhm2Y8KVbUnnd6TJj9yNynPngG3xHuvpkvi2fguHkuAh+ydmA8tlFzk+3qs5kc4x7s4sJ35qU0bp03H7MF9wbHdVAWDVnw5ltv/NdXm7+G0QJwynq5jWG1qC5IWLPw8r9//EYv/QhZ+8k5QCP/NJqSa+CqG1aGkiLZ54XddhaJQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xz2XZBnz6DDavURpQmofPRODhZE3ebr44a2k4OUazkQ=;
 b=39M90MWnrJeVuwuAzqqy2u93BbxNqoGDsMBBB+ahxl+ErsFZDgcG0+rhWkhUkNk4DYKqYdPrCcee2xyqTbHZeubtH0bYUlhmQKA4TzaJgDQOByHAYWS/JEmXVoGuRXl2WtQIcCrXcNaqgkpCWiNrs3Nj7rhqePpwwGdM0h4dXVQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 17:52:28 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 17:52:28 +0000
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org> <20200416085402.GB1286150@myrica>
 <20200416121331.GA18661@infradead.org> <20200420074213.GA3180232@myrica>
 <20200420081034.GA17305@infradead.org>
 <6b195512-fa73-9a49-03d8-1ed92e86f607@amd.com>
 <20200420115504.GA20664@infradead.org>
 <966e190e-ca9f-4c64-af05-43b0f0d8d012@amd.com>
 <65709b48-526b-ff43-760c-0fe0317d5e9c@amd.com>
 <20200420104410.3d1622e7@jacob-builder>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <7aed25d4-5852-a000-2ad0-1519e990858e@amd.com>
Date: Mon, 20 Apr 2020 13:52:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200420104410.3d1622e7@jacob-builder>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::44) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 17:52:26 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69849361-4f27-4d32-0466-08d7e5539759
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:|SN1PR12MB2573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB257357303BABFD4D44EDB8FC92D40@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(86362001)(36756003)(4326008)(6486002)(6916009)(316002)(478600001)(16526019)(7416002)(31696002)(186003)(54906003)(2906002)(16576012)(8936002)(81156014)(8676002)(26005)(2616005)(956004)(66476007)(66556008)(5660300002)(66946007)(44832011)(52116002)(31686004)(33964004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVgw9wdQDKmPeU4jWiAJzT/Pdf/Jmgdz5qxbkIDsTbykm6fYRQI7KpjbI4cSn1+VL5WmazKSNaI4kiaVa5zt3vjwr6hS2zxITIAL02RhApH1MJ3SVmMWipcKRGL1MtFDc3sKPhKPPr+ndIAf9SfMOkHLpATQ8xhMOL6H1nh0z7O3nn4eAD31RqLvC5EmrnvAx0Vh2tVEDunUIJllK+zH6IK3WIDWurXBsUjTuXv1CRHHrYHFCPoThN1V0n8G8rlYWec6Gj02a5oAtUGuJ25o2a5X5BsLIck+VOM2KSpIpge+KOFJWLskSWkKZ1M9c08h76jOTEPM25VXXUFBDdZ/oboasHkVkfm4CXL5E95vUYdJ5nakzuYbVFIyo5MdpHRDzRQ0obGS9MQt/YVjykeYsPmb3RVqGJa1Tn5B2PdcMnxyyoBrq6HPHMiCccDgEKGs
X-MS-Exchange-AntiSpam-MessageData: xUJyYlBu30PCbPxgyvOudFlG/5sGVUc1ZcXlaaMNzRbHKfQVDhzrT6cosLjbsS2YFbUC+HLwnACIdfohVaGFQ3+apsYYw3dLfE4u6+mc/pmpNdf2ZJX1P8SE9uw8T/LfBvU/ON5/4WsIs+X0cKxkYQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69849361-4f27-4d32-0466-08d7e5539759
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 17:52:28.3042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGPdiuL9jGADnWl48EjrmTkT9FPCLwY4PgtSMpMsYn/UfvzFIqKQozvzhxiUPfll6tloilHaQqCAnZJ8a/s7fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 devicetree@vger.kernel.org, jgg@ziepe.ca, linux-pci@vger.kernel.org,
 robin.murphy@arm.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 catalin.marinas@arm.com, zhangfei.gao@linaro.org, will@kernel.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
Content-Type: multipart/mixed; boundary="===============4615004550740948362=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============4615004550740948362==
Content-Type: multipart/alternative;
 boundary="------------B0908AA1E22B309E1D932016"
Content-Language: en-US

--------------B0908AA1E22B309E1D932016
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Am 2020-04-20 um 1:44 p.m. schrieb Jacob Pan:
>> The bottom line is, when you allocate a PASID for a context, you want
>> to know how small it needs to be for all the devices that want to use
>> it. If you make it too big, some device will not be able to use it.
>> If you make it too small, you waste precious PASIDs that could be
>> used for other contexts that need them.
>>
> So for AMD, system-wide PASID allocation works with the
> restriction/optimization above?
>
Yes for KFD. On multi-GPU systems we allocate one PASID for the whole
process and use it on all GPUs.

For AMDGPU graphics contexts, we allocate one PASID for each per-GPU
context. But they're allocated from a single global PASID namespace
managed by the AMDGPU driver and shared with KFD. So we're wasting
PASIDs here, but we are compatible with a single system-wide PASID
namespace.

Regards,
  Felix


--------------B0908AA1E22B309E1D932016
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 2020-04-20 um 1:44 p.m. schrieb
      Jacob Pan:<br>
    </div>
    <blockquote type="cite" cite="mid:20200420104410.3d1622e7@jacob-builder">
      <blockquote type="cite" style="color: #000000;">
        <pre class="moz-quote-pre" wrap="">The bottom line is, when you allocate a PASID for a context, you want
to know how small it needs to be for all the devices that want to use
it. If you make it too big, some device will not be able to use it.
If you make it too small, you waste precious PASIDs that could be
used for other contexts that need them.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">So for AMD, system-wide PASID allocation works with the
restriction/optimization above?

</pre>
    </blockquote>
    <p>Yes for KFD. On multi-GPU systems we allocate one PASID for the
      whole process and use it on all GPUs.</p>
    <p>For AMDGPU graphics contexts, we allocate one PASID for each
      per-GPU context. But they're allocated from a single global PASID
      namespace managed by the AMDGPU driver and shared with KFD. So
      we're wasting PASIDs here, but we are compatible with a single
      system-wide PASID namespace.</p>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
  </body>
</html>

--------------B0908AA1E22B309E1D932016--

--===============4615004550740948362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4615004550740948362==--
