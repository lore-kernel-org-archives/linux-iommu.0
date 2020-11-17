Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4FDC2D0E4
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 15:33:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9AA2222A
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 15:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NXJJ2+sL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9AA2222A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D048A85754;
	Tue, 17 Nov 2020 15:33:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zMtbRMMMAB0g; Tue, 17 Nov 2020 15:33:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E2C6C855F6;
	Tue, 17 Nov 2020 15:33:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C61CDC0800;
	Tue, 17 Nov 2020 15:33:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA85DC07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 15:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C62FC85431
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 15:33:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GNiBjYEgeA2s for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 15:33:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9EC0485074
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 15:33:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m71p2beUgaWPbnFeSFg3PqOZ4KYTZ2CX7iKex7pWWlNOLD3kjOL6XIjwZof9llWN09x2oqwKpW5UDYUz/sqrM6cgyDlJFN8TW3NaFoougaYXLgyoyemRt8l/h48K+GPNY8j3C8d7BMu++t5g5UdeUzM4c8VkMc6oAenpsyTOPDEmpY8weWtFrPCjUAvY57kQ1z623HZi4P4/WYA4t0Mn9Uv7KjBcH4Z1bOnWhK0YruupdkNI6UsAjNqwReBMMuw9I+pvxvG9lmIkeFZY69lGbnMf0UjcneVV2nnntsr94jsyYCJVKtLxdXvxDwjU3+126pK432iBXul2mRHNjbfSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSPuJqdNe5kQeW/3h1nxbR+64Zz1mqescTqFnoSJ/qo=;
 b=j6neC9r/w/wvGyXmC7I9tl0eNeqJ6Q6+NmlmGuhAZeuDR9XWP1Cu5iARTu3VteMnGp+ZTY9P2cFeNRLIoQu21ZalU6Tdnm+KPLvLHpefJvToyC95fA54uqme1zrY7qaRbWRVH3cEGrc0bjt/8VTYRGCSNCdLPfDrZArdNfFwF/eEPK0SXrUzypYKXj+n3ENt64kIXo30+2tnVCknGa+0p/tuha1ioWKDzcnmSGo3sjL4rz5N0ZwEyQpk+4i3WUeq7g7rUDPk+MfvrwghvwjGxxpN4sszy38DiebbjHF98I2lFTgZ4gCs1Vek/ypgeS0dv6KuMqe0nu3CmHYTe/UeUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSPuJqdNe5kQeW/3h1nxbR+64Zz1mqescTqFnoSJ/qo=;
 b=NXJJ2+sLcNhjcE6owsSO+UKOaVkPB6hq0SusZwBciCkfxp6UOBPjg3Pzidg8s+U9PlhsuA20pHqCgi25Db3qJToP17oXdUU0V7LgleWCp1lxilJYqLYCbE3TcpETc5GGtoN4/dKfXJfHHf3M3aXcG6eHYOwY4Bd1m6a4sJPbABg=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 15:33:43 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3541.025; Tue, 17 Nov 2020
 15:33:43 +0000
Date: Tue, 17 Nov 2020 15:33:34 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201117153302.GA29293@ashkalra_ubuntu_server>
References: <20201104220804.21026-1-Ashish.Kalra@amd.com>
 <20201104221452.GA26079@char.us.oracle.com>
 <20201104223913.GA25311@ashkalra_ubuntu_server>
 <20201105174317.GA4294@char.us.oracle.com>
 <20201105184115.GA25261@ashkalra_ubuntu_server>
 <20201105190649.GB5366@char.us.oracle.com>
 <20201105193828.GA25303@ashkalra_ubuntu_server>
 <20201105202007.GA6370@char.us.oracle.com>
 <20201105212045.GB25303@ashkalra_ubuntu_server>
 <20201113211925.GA6096@char.us.oracle.com>
Content-Disposition: inline
In-Reply-To: <20201113211925.GA6096@char.us.oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0801CA0017.namprd08.prod.outlook.com
 (2603:10b6:803:29::27) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 SN4PR0801CA0017.namprd08.prod.outlook.com (2603:10b6:803:29::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.29 via Frontend
 Transport; Tue, 17 Nov 2020 15:33:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 73425a1c-f79b-4eea-ff45-08d88b0e2936
X-MS-TrafficTypeDiagnostic: SA0PR12MB4510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4510381D951771655561C4578EE20@SA0PR12MB4510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3SPHNAGHuxjm1ndv/M68HjyqE8+b0ZI2HF7AeOi3h/FfUxFBbF3CG6w/dCte9zr3q4tI/RczWlCPNK8rt23PMwP1hre9s9gaaGzRJGQOo4dJozRcH1fFaEJDpDWRoDNASwLXazEeZ71g6bPonoBBndJpE8/ggkQbTj40zCek3ta3Zwg3HQi478ftvNyePwJEddKOlbl/Y3rLnRSnyZEW0SdoQ/gzIjMdg/XUtiXS1SxmIlGEUlcRK4zNjkbjHPD288WV9HcOhxGTz3n4J0K2HdnDP4L6DJ3dpy/ypbZ9pAJ1p7lyLf6/0IrBy9WhfVkE6kvlPgcyb0fuvGs7ume69w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(5660300002)(6496006)(8936002)(956004)(6666004)(86362001)(186003)(316002)(1076003)(2906002)(4326008)(44832011)(83380400001)(33716001)(66946007)(6916009)(478600001)(26005)(8676002)(55016002)(66476007)(16526019)(9686003)(7416002)(52116002)(66556008)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /JvpKZ9WuUr6kXj1+faby68BLUnEa8fyHZD434bxSPeEGLeAnfWw6AxIwlpXyfu8B/GiTDvsfZcvm8ld3BeOuLSckdOjt/GCsWLZhjoKCSqLKe0UcF/fn7soeQbfQOn2Br7I1snvQRno5VEmeWLrh3hY3ZkPUZ17qIyekvvYHfIAxJQSerikr16neb2tE9IML3oCK+c3I4TXYQTfGl08bdhHLxzXlQvcAMfkFNwwVi+EW81bbVnH9M+Lj0JeZDbAQA4YtcBAQMtB2wwKxyq9l5M39F4GnwQqkCzMOwlTsopAFvSy74bgFZlk+10ZzhWhXUIhCtuJB4Gtpm44jseAUb5Um6lO37Q6VJ0UpMafy31urs8c4+uMmhi8ImOzOl1N0SFzfVhfMYrEW63oNNyI/YDSq9RCM0CeGeX77pHZsHRQpe0XiLywM/AckadG0RJSfUOwvBzBWEWXo9Tld2jqA77etGTT9OBYQyX1M1KQdZCEexmf09EyWD8EJfc3NKZZrBIKbgvtkD9ViaH4PNcM/Vc65LuJDddahk8Yd5MgJERXXWRk9ydHG3yoQV3BE1KLPfNoW0FRX9q5ykgypO4mj+imI/Ai+d5kX8GTRBE6EUdknmFEHXbmm4LSjJYLGPpDtSa/bOPOnUdu7o/usQg5POj1scDqRR/PHf5/Km2H/TShfsGrvWelhH1wBhuE/hqLuM73Y+p6r2BjGArIPJTLWipSO/roAjxGqz6ZEVG9ZwuJPm8AjiV+3sRK15fqRutFDXGgJYspW/vI8SmW7YKKnHnoX3S7w43/76oqj0NGByiRcmN/5c0zzFVyuLQdcKhYztd9TAzvY/La8WLPdrQmoIJ5hxDpcZ0P62sN5u9JjRxaBlPw/kuynlRfSkYPQnmDkawtpa6irhjwhjjxg9FDOw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73425a1c-f79b-4eea-ff45-08d88b0e2936
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 15:33:42.8568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShjdQ7CdetD8Aeq0MEIYW8ND71reNmKVk56n9vOVnobT6WZDUAs3mNx7piG/Tw8BOsgTODA1WCtfZvbm5Cny8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
Cc: Thomas.Lendacky@amd.com, jon.grimm@amd.com, brijesh.singh@amd.com,
 ssg.sos.patches@amd.com, dave.hansen@linux-intel.com, peterz@infradead.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, luto@kernel.org, hpa@zytor.com,
 rientjes@google.com, tglx@linutronix.de, hch@lst.de
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

On Fri, Nov 13, 2020 at 04:19:25PM -0500, Konrad Rzeszutek Wilk wrote:
> On Thu, Nov 05, 2020 at 09:20:45PM +0000, Ashish Kalra wrote:
> > On Thu, Nov 05, 2020 at 03:20:07PM -0500, Konrad Rzeszutek Wilk wrote:
> > > On Thu, Nov 05, 2020 at 07:38:28PM +0000, Ashish Kalra wrote:
> > > > On Thu, Nov 05, 2020 at 02:06:49PM -0500, Konrad Rzeszutek Wilk wrote:
> > > > > .
> > > > > > > Right, so I am wondering if we can do this better.
> > > > > > > 
> > > > > > > That is you are never going to get any 32-bit devices with SEV right? That
> > > > > > > is there is nothing that bounds you to always use the memory below 4GB?
> > > > > > > 
> > > > > > 
> > > > > > We do support 32-bit PCIe passthrough devices with SEV.
> > > > > 
> > > > > Ewww..  Which devices would this be?
> > > > 
> > > > That will be difficult to predict as customers could be doing
> > > > passthrough of all kinds of devices.
> > > 
> > > But SEV is not on some 1990 hardware. It has PCIe, there is no PCI slots in there.
> > > 
> > > Is it really possible to have a PCIe device that can't do more than 32-bit DMA?
> > > 
> > > > 
> > > > > > 
> > > > > > Therefore, we can't just depend on >4G memory for SWIOTLB bounce buffering
> > > > > > when there is I/O pressure, because we do need to support device
> > > > > > passthrough of 32-bit devices.
> > > > > 
> > > > > Presumarily there is just a handful of them?
> > > > >
> > > > Again, it will be incorrect to assume this.
> > > > 
> > > > > > 
> > > > > > Considering this, we believe that this patch needs to adjust/extend
> > > > > > boot-allocation of SWIOTLB and we want to keep it simple to do this
> > > > > > within a range detemined by amount of allocated guest memory.
> > > > > 
> > > > > I would prefer to not have to revert this in a year as customers
> > > > > complain about "I paid $$$ and I am wasting half a gig on something 
> > > > > I am not using" and giving customers knobs to tweak this instead of
> > > > > doing the right thing from the start.
> > > > 
> > > > Currently, we face a lot of situations where we have to tell our
> > > > internal teams/external customers to explicitly increase SWIOTLB buffer
> > > > via the swiotlb parameter on the kernel command line, especially to
> > > > get better I/O performance numbers with SEV. 
> > > 
> > > Presumarily these are 64-bit?
> > > 
> > > And what devices do you speak off that are actually affected by 
> > > this performance? Increasing the SWIOTLB just means we have more
> > > memory, which in mind means you can have _more_ devices in the guest
> > > that won't handle the fact that DMA mapping returns an error.
> > > 
> > > Not neccessarily that one device suddenly can go faster.
> > > 
> > > > 
> > > > So by having this SWIOTLB size adjustment done implicitly (even using a
> > > > static logic) is a great win-win situation. In other words, having even
> > > > a simple and static default increase of SWIOTLB buffer size for SEV is
> > > > really useful for us.
> > > > 
> > > > We can always think of adding all kinds of heuristics to this, but that
> > > > just adds too much complexity without any predictable performance gain.
> > > > 
> > > > And to add, the patch extends the SWIOTLB size as an architecture
> > > > specific callback, currently it is a simple and static logic for SEV/x86
> > > > specific, but there is always an option to tweak/extend it with
> > > > additional logic in the future.
> > > 
> > > Right, and that is what I would like to talk about as I think you
> > > are going to disappear (aka, busy with other stuff) after this patch goes in.
> > > 
> > > I need to understand this more than "performance" and "internal teams"
> > > requirements to come up with a better way going forward as surely other
> > > platforms will hit the same issue anyhow.
> > > 
> > > Lets break this down:
> > > 
> > > How does the performance improve for one single device if you increase the SWIOTLB?
> > > Is there a specific device/driver that you can talk about that improve with this patch?
> > > 
> > > 
> > 
> > Yes, these are mainly for multi-queue devices such as NICs or even
> > multi-queue virtio. 
> > 
> > This basically improves performance with concurrent DMA, hence,
> > basically multi-queue devices.
> 
> OK, and for _1GB_ guest - what are the "internal teams/external customers" amount 
> of CPUs they use? Please lets use real use-cases.

>> I am sure you will understand we cannot share any external customer
>> data as all that customer information is proprietary.
>>
>> In similar situation if you have to share Oracle data, you will
>> surely have the same concerns and i don't think you will be able
>> to share any such information externally, i.e., outside Oracle.
>>
>I am asking for a simple query - what amount of CPUs does a 1GB
>guest have? The reason for this should be fairly obvious - if
>it is a 1vCPU, then there is no multi-queue and the existing
>SWIOTLB pool size as it is OK.
>
>If however there are say 2 and multiqueue is enabled, that
>gives me an idea of how many you use and I can find out what
>the maximum pool size usage of virtio there is with that configuration.

Again we cannot share any customer data.

Also i don't think there can be a definitive answer to how many vCPUs a
1GB guest will have, it will depend on what kind of configuration we are
testing.

For example, i usually setup 4-16 vCPUs for as low as 512M configured
gueest memory.

I have been also testing with 16 vCPUs configuration for 512M-1G guest
memory with Mellanox SRIOV NICs, and this will be a multi-queue NIC
device environment.

So we might be having less configured guest memory, but we still might
be using that configuration with I/O intensive workloads.

Thanks,
Ashish
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
