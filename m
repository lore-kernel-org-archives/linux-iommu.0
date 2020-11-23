Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA1AC2D0E4
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 22:57:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A216E20728
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 22:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iXyzK7H4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A216E20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 192A7867E0;
	Mon, 23 Nov 2020 22:57:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fk+ebFkCYpDW; Mon, 23 Nov 2020 22:57:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 27C62867D2;
	Mon, 23 Nov 2020 22:57:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07DECC163C;
	Mon, 23 Nov 2020 22:57:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CFE2C0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 22:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3057F867E0
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 22:57:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8twht356qZH7 for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 22:56:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C4C33867D2
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 22:56:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Td8LXEqOlmwq7vnMcr9/Uhc7DxQuRew/e/Ig/BZVJmcrQCMjeEwDyN+nIU9FJAxY/dyRMgvlUZh86GHie889g3acVUbzQHlHAR7eqcwJMfUWcgDVXpp0MC1L2toIMzO8ChHRqXk4Ds2tgvQnHlOco+b/Lxcb3U1+5IDHjg6C8gpjLICVdzr9UMZ94KBrI0UHZl2NuoCRwjXk1AGZXiaNBDv9uFZJ3SaGjNtEjP6G/vh9uBzLxjVZ19ElWpINwC8yLkGLtIwxfwMtx5LHEittHzWgIIaWzBVU5dnnAgK9FSlyV6csi1t3aciMgW3OYQrWpGx7gf8vRabXB0oPkE7rWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ndgt9V66E9ETUf92N/oiKjFVBvm28IMe0Shma7reSYE=;
 b=ctKQz8waP/g3cPdjjlwlTzOEYbXBS5BaNUBofTATBwFbCsY+asew1Rq8R2QJDn5k2Y4wCt1J0mDINVyqWsSk780bvwRPPzHCa+bDDwZZkxnX17lader+JDj/Cg0gtLbOzQNt88yP6YJ+qQi9zdNeq85I6jM32aLuK0OMQMIg35HAB1fQ9UBVzH0N/3jVMUEiYk9iZTbRBKjJIP0QdQ54SS5w0uMXBdSbGIoG2E8cN7eY4kscCD5Zl1a3t4TmwbG3W8Z/lF/MbUF2bquX/vyg/ao92i0d9dKCrVp3R92JnaQz8gHWBNe9qdKeh2alFJYzUuhabpark38XbA9IYirJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ndgt9V66E9ETUf92N/oiKjFVBvm28IMe0Shma7reSYE=;
 b=iXyzK7H46PF7BwEE5MwEuqYvgpO1uusd6yxJ80Uqu1bmKtYKbFGbHUz19q7qadpLkTxowFwUZqHQv+//BHTRPmGYlbSgfG1Lw4YlyIOHhYYG6AdwdcZJG+A3cUlPprRNIzw+/Lq03bi4LlP4m8QnDHY6qLj32PvOdmaWleeStvY=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Mon, 23 Nov
 2020 22:56:56 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3541.025; Mon, 23 Nov 2020
 22:56:56 +0000
Date: Mon, 23 Nov 2020 22:56:31 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v6] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201123225631.GA16055@ashkalra_ubuntu_server>
References: <20201119214205.11062-1-Ashish.Kalra@amd.com>
 <20201123170647.GE15044@zn.tnic>
 <20201123175632.GA21539@char.us.oracle.com>
Content-Disposition: inline
In-Reply-To: <20201123175632.GA21539@char.us.oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR07CA0079.namprd07.prod.outlook.com
 (2603:10b6:4:ad::44) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 DM5PR07CA0079.namprd07.prod.outlook.com (2603:10b6:4:ad::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 22:56:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 96251d93-7984-40f0-e6ce-08d89003134d
X-MS-TrafficTypeDiagnostic: SA0PR12MB4509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB450979FCB12AEB03D164BA018EFC0@SA0PR12MB4509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HD3LDwsrC2m3/t/J6e5l3F65WAkSe9D5jMF7AuUUuFfcrfqXuCFrqQ/BauR4QmOfxLL9YHmoFUbCS3qCYD8koAWHXq4FgIM9RN57J+u47CAivDeEFCZlaTgPFzpTu54FQUj9WS7xBEQ+K8GYXD62m7ZK5Pwq4Wok0WCcZee8sGcKhWofau7cuWXao/L7bqEmOeXUTqd0W0hPpVHE5xNfoxCA8sZkOKFSZKTa/3tIXxIa6IlESPbD+GlCyJBLFgVoyHXmA4Yae7fxh6g5PL2e+LjmfEdqcFrF1a9PyULxUe+kg5nnp+08zdXfXZ0IdHZE43tqYWzCppVP7fAoAwC9gxebgukJWqOj4aVhMSvAS0uTJZ9Q7idXtW9FUl5/B970bjydF6NBXrqKulv7FJL4CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(7416002)(55016002)(9686003)(16526019)(6916009)(2906002)(316002)(6666004)(83380400001)(478600001)(1076003)(66946007)(66476007)(45080400002)(4326008)(66556008)(33656002)(52116002)(956004)(44832011)(186003)(26005)(966005)(6496006)(8936002)(33716001)(5660300002)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: juCAuL1dYt6yqgI7qhaE9uDN7XGEwC7d8b1hbG7WzEiSth/7wiTFRPIBvkiEi5Vr23bZ0P/aKjCqKoD+GCuwr2TlPZGTUyuROMejAeUlDwYJ20KKQ3dsFDNARIoAFTT6elfoihz5lejJEGU0IRUxhlG9s8+4RkBh3lH97kgd/eRddSoRnjB6BvPxGLO5zTERXo6Qfbw2kHKU27cykbrfN8WROrsnC0pCgU4/tHLFpk5ITDUi+A0x4XtKB2wYXFyY12kr1ic8nWrqcsA/VwiNxZlqka07bW1VFdBR2OgXXwfXiEhu47ZATfpbq2VBh2fzZ7n9XywEar/7Jt8KfgIZ887MizLXhC0dvr8qNRqO2zp2m7oN2y+t0Q0aPNFMWrvGBS8jw6DcwF8PGV2sJ1B6/B4pAdlGlrd8dg03BLOZpiPpXgHs1LbIpvrq+f7Zgvao5+A1AQCs0STeFpFahb1cWcjsJTnc8WLz6dxKt9+XPBBRpN/6lm9Z5Cmg9TQNccgOzejn7hF8dmn5am+C9Pwhi5tpCmHtvojegxC6i9eXY0TuFX5VARk9CdwCaIBu/a5uNlyD9t7B/cq0bj8NTiTbzF9fzwFGNo7wbKlfkecvlkrn7Sc4No72+3pw15AYrtJf+F7XxwxcrXVVmjrx3j92KY7X/rUvYYpvRD99ioIiDCzy5CcpAwZxsleTO+4LMFH2xJR7NojegltZZMmSCfK8qf9SgiXjxyH0tNcRF/HMzA3IM+ky8Lp0krpI3PLkN/FPMI+JyCrx0GMkTbL+DEiwInrDVY1LRUhurAi7bTqu7rBHlBXvxkm8l5hUcPvrXm+OjiWBpbjPJugaWXDDiRsb7Or9Rcdp/gTusjGnG4u/hRSguJYMKEARhawbfQE+VlQ+FJ2Fg8Y3ENnwUjSfB6gAxw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96251d93-7984-40f0-e6ce-08d89003134d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 22:56:55.8457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDkt27/lD4QjiKZaAu2mUNg6MVe/vo2IzUtMpivqSbU8nC9JVcm0fsV6SWMQ5DuqPRQYuBIaq3derKatvHq3hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
Cc: Thomas.Lendacky@amd.com, jon.grimm@amd.com, brijesh.singh@amd.com,
 dave.hansen@linux-intel.com, peterz@infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, Borislav Petkov <bp@alien8.de>, luto@kernel.org,
 hpa@zytor.com, rientjes@google.com, tglx@linutronix.de, hch@lst.de
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

Hello Konrad,

On Mon, Nov 23, 2020 at 12:56:32PM -0500, Konrad Rzeszutek Wilk wrote:
> On Mon, Nov 23, 2020 at 06:06:47PM +0100, Borislav Petkov wrote:
> > On Thu, Nov 19, 2020 at 09:42:05PM +0000, Ashish Kalra wrote:
> > > From: Ashish Kalra <ashish.kalra@amd.com>
> > > 
> > > For SEV, all DMA to and from guest has to use shared (un-encrypted) pages.
> > > SEV uses SWIOTLB to make this happen without requiring changes to device
> > > drivers.  However, depending on workload being run, the default 64MB of
> > > SWIOTLB might not be enough and SWIOTLB may run out of buffers to use
> > > for DMA, resulting in I/O errors and/or performance degradation for
> > > high I/O workloads.
> > > 
> > > Increase the default size of SWIOTLB for SEV guests using a minimum
> > > value of 128MB and a maximum value of 512MB, determining on amount
> > > of provisioned guest memory.
> > 
> > That sentence needs massaging.
> > 
> > > Using late_initcall() interface to invoke swiotlb_adjust() does not
> > > work as the size adjustment needs to be done before mem_encrypt_init()
> > > and reserve_crashkernel() which use the allocated SWIOTLB buffer size,
> > > hence calling it explicitly from setup_arch().
> > 
> > "hence call it ... "
> > 
> > > 
> > > The SWIOTLB default size adjustment is added as an architecture specific
> > 
> > "... is added... " needs to be "Add ..."
> > 
> > > interface/callback to allow architectures such as those supporting memory
> > > encryption to adjust/expand SWIOTLB size for their use.
> > > 
> > > v5 fixed build errors and warnings as
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > 
> > > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > > ---
> > >  arch/x86/kernel/setup.c   |  2 ++
> > >  arch/x86/mm/mem_encrypt.c | 32 ++++++++++++++++++++++++++++++++
> > >  include/linux/swiotlb.h   |  6 ++++++
> > >  kernel/dma/swiotlb.c      | 24 ++++++++++++++++++++++++
> > >  4 files changed, 64 insertions(+)
> > > 
> > > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > > index 3511736fbc74..b073d58dd4a3 100644
> > > --- a/arch/x86/kernel/setup.c
> > > +++ b/arch/x86/kernel/setup.c
> > > @@ -1166,6 +1166,8 @@ void __init setup_arch(char **cmdline_p)
> > >  	if (boot_cpu_has(X86_FEATURE_GBPAGES))
> > >  		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> > >  
> > > +	swiotlb_adjust();
> > > +
> > >  	/*
> > >  	 * Reserve memory for crash kernel after SRAT is parsed so that it
> > >  	 * won't consume hotpluggable memory.
> > > diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> > > index 3f248f0d0e07..c79a0d761db5 100644
> > > --- a/arch/x86/mm/mem_encrypt.c
> > > +++ b/arch/x86/mm/mem_encrypt.c
> > > @@ -490,6 +490,38 @@ static void print_mem_encrypt_feature_info(void)
> > >  }
> > >  
> > >  /* Architecture __weak replacement functions */
> > > +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> > > +{
> > > +	unsigned long size = 0;
> > 
> > 	unsigned long size = iotlb_default_size;
> > 
> > > +
> > > +	/*
> > > +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> > > +	 * SEV uses SWOTLB to make this happen without changing device
> > > +	 * drivers. However, depending on the workload being run, the
> > > +	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
> > 						     ^
> > 
> > Use words pls, not "&".
> > 
> > 
> > > +	 * run out of buffers for DMA, resulting in I/O errors and/or
> > > +	 * performance degradation especially with high I/O workloads.
> > > +	 * Increase the default size of SWIOTLB for SEV guests using
> > > +	 * a minimum value of 128MB and a maximum value of 512MB,
> > > +	 * depending on amount of provisioned guest memory.
> > > +	 */
> > > +	if (sev_active()) {
> > > +		phys_addr_t total_mem = memblock_phys_mem_size();
> > > +
> > > +		if (total_mem <= SZ_1G)
> > > +			size = max(iotlb_default_size, (unsigned long) SZ_128M);
> > > +		else if (total_mem <= SZ_4G)
> > > +			size = max(iotlb_default_size, (unsigned long) SZ_256M);
> 
> That is eating 128MB for 1GB, aka 12% of the guest memory allocated statically for this.
> 
> And for guests that are 2GB, that is 12% until it gets to 3GB when it is 8%
> and then 6% at 4GB.
> 
> I would prefer this to be based on your memory count, that is 6% of total
> memory. And then going forward we can allocate memory _after_ boot and then stich
> the late SWIOTLB pool and allocate on demand.
> 
> 
Ok. 

As i mentioned earlier, the patch was initially based on using a % of guest memory,
as below:

+#define SEV_ADJUST_SWIOTLB_SIZE_PERCENT        5
+#define SEV_ADJUST_SWIOTLB_SIZE_MAX    (1UL << 30)
...
...
+       if (sev_active() && !io_tlb_nslabs) {
+               unsigned long total_mem = get_num_physpages() <<
+ PAGE_SHIFT;
+
+               default_size = total_mem *
+                       SEV_ADJUST_SWIOTLB_SIZE_PERCENT / 100;
+
+               default_size = ALIGN(default_size, 1 << IO_TLB_SHIFT);
+
+               default_size = clamp_val(default_size, IO_TLB_DEFAULT_SIZE,
+                       SEV_ADJUST_SWIOTLB_SIZE_MAX);
+       }

So a similar logic can be applied here.

> 
> > > +		else
> > > +			size = max(iotlb_default_size, (unsigned long) SZ_512M);
> > > +
> > > +		pr_info("SWIOTLB bounce buffer size adjusted to %luMB for SEV platform",
> > 
> > just "... for SEV" - no need for "platform".
> > 
> > ...
> > 
> > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > index c19379fabd20..3be9a19ea0a5 100644
> > > --- a/kernel/dma/swiotlb.c
> > > +++ b/kernel/dma/swiotlb.c
> > > @@ -163,6 +163,30 @@ unsigned long swiotlb_size_or_default(void)
> > >  	return size ? size : (IO_TLB_DEFAULT_SIZE);
> > >  }
> > >  
> > > +unsigned long __init __weak arch_swiotlb_adjust(unsigned long size)
> > > +{
> > > +	return 0;
> > 
> > That, of course, needs to return size, not 0.
> 
> This is not going to work for TDX. I think having a registration
> to SWIOTLB to have this function would be better going forward.
> 
> As in there will be a swiotlb_register_adjuster() which AMD SEV
> code can call at start, also TDX can do it (and other platforms).
> 

The question is how does mem_encrypt_init() work ?

That uses a similar logic as arch_swiotlb_adjust() as a "__weak"
function and i am sure it will also need to have added support for TDX,
can't both arch_swiotlb_adjust() and mem_encrypt_init() have specific
checks for active AMD/INTEL memory encryption technology and accordingly
perform actions, as mem_encrypt_init() currently checks for
sev_active().

init/main.c: 

void __init __weak mem_encrypt_init(void) { }

start_kernel()
{
   ..
   mem_encrypt_init();
   ..
}

arch/x86/mm/mem_encrypt.c: 
    
/* Architecture __weak replacement functions */

void __init mem_encrypt_init(void)
{
        if (!sme_me_mask)
                return;

        /* Call into SWIOTLB to update the SWIOTLB DMA buffers */
        swiotlb_update_mem_attributes();

        /*
         * With SEV, we need to unroll the rep string I/O instructions.
         */
        if (sev_active())
                static_branch_enable(&sev_enable_key);
...
...

Thanks,
Ashish

> > 
> > > +}
> > > +
> > > +void __init swiotlb_adjust(void)
> > > +{
> > > +	unsigned long size;
> > > +
> > > +	/*
> > > +	 * If swiotlb parameter has not been specified, give a chance to
> > > +	 * architectures such as those supporting memory encryption to
> > > +	 * adjust/expand SWIOTLB size for their use.
> > > +	 */
> > 
> > And when you preset the function-local argument "size" with the size
> > coming in as the size argument of arch_swiotlb_adjust()...
> > 
> > > +	if (!io_tlb_nslabs) {
> > > +		size = arch_swiotlb_adjust(IO_TLB_DEFAULT_SIZE);
> > > +		if (size) {
> > 
> > ... you don't have to do if (size) here either but simply use size to
> > compute io_tlb_nslabs, I'd say.
> > 
> > Thx.
> > 
> > -- 
> > Regards/Gruss,
> >     Boris.
> > 
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CAshish.Kalra%40amd.com%7Cebd4a85f98f44bdfcb5408d88fd8dfac%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637417508926083910%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Ub9PjAPzhDWr7K2iQggTAXwgg4VbORxP%2F%2Fcg6gQreCc%3D&amp;reserved=0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
