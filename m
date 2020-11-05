Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A57C388F7
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 19:05:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04372078E
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 19:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HELBDEJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04372078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4AA1786718;
	Thu,  5 Nov 2020 19:05:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AeYkDyR5SxmR; Thu,  5 Nov 2020 19:05:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3886286704;
	Thu,  5 Nov 2020 19:05:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CAB1C0893;
	Thu,  5 Nov 2020 19:05:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AEDAC0893
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 19:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 39994272E2
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 19:05:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id szil19vcG-48 for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 19:05:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by silver.osuosl.org (Postfix) with ESMTPS id 5E8682725F
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 19:05:30 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A5Io6MN029955;
 Thu, 5 Nov 2020 19:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=aJ9zo6EeG1CCbfreQzq7OILGb9nn0wGeiVtZHQsZ/4I=;
 b=HELBDEJpMfEp8q1fkR0Jaz0UZag5EU5I6ryg3ZjWqSPIpY8RMQ8RwX000v4OYGG5zq61
 qa9cQtXUIOTM9UKYJQQXR37mUqck7XsqqZxLbsFhwbycwcjM5E1xL+p5BXLdcutpbWxp
 bpNNIKLk9+Mq5W8xhlNAu8+cuiN1Oha0ebRcdgwluwpgFbVEw/HrK7BLIPpXO2clAwL8
 lOJMDkV6F1oxmaCSAdCwPdXyk/DksTj+3qNRTAyPRJLWX06zjkl6QI5VD06ek2/axgSV
 KMo5uiBtlZ06o1UWqJvxoWz9kNCceVW07/gV52pKV5XxfJo5JQSix9yt5QiH1pUS+enb pA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 34hhvcnmvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 05 Nov 2020 19:05:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A5IotkQ184107;
 Thu, 5 Nov 2020 19:05:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 34jf4cn9gu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Nov 2020 19:05:09 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A5J51Da031499;
 Thu, 5 Nov 2020 19:05:06 GMT
Received: from char.us.oracle.com (/10.152.32.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 05 Nov 2020 11:05:00 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
 id 680166A00F1; Thu,  5 Nov 2020 14:06:49 -0500 (EST)
Date: Thu, 5 Nov 2020 14:06:49 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201105190649.GB5366@char.us.oracle.com>
References: <20201104220804.21026-1-Ashish.Kalra@amd.com>
 <20201104221452.GA26079@char.us.oracle.com>
 <20201104223913.GA25311@ashkalra_ubuntu_server>
 <20201105174317.GA4294@char.us.oracle.com>
 <20201105184115.GA25261@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105184115.GA25261@ashkalra_ubuntu_server>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050123
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com, ssg.sos.patches@amd.com,
 dave.hansen@linux-intel.com, peterz@infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, luto@kernel.org, hpa@zytor.com,
 tglx@linutronix.de, hch@lst.de
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

.
> > Right, so I am wondering if we can do this better.
> > 
> > That is you are never going to get any 32-bit devices with SEV right? That
> > is there is nothing that bounds you to always use the memory below 4GB?
> > 
> 
> We do support 32-bit PCIe passthrough devices with SEV.

Ewww..  Which devices would this be?
> 
> Therefore, we can't just depend on >4G memory for SWIOTLB bounce buffering
> when there is I/O pressure, because we do need to support device
> passthrough of 32-bit devices.

Presumarily there is just a handful of them?

> 
> Considering this, we believe that this patch needs to adjust/extend
> boot-allocation of SWIOTLB and we want to keep it simple to do this
> within a range detemined by amount of allocated guest memory.

I would prefer to not have to revert this in a year as customers
complain about "I paid $$$ and I am wasting half a gig on something 
I am not using" and giving customers knobs to tweak this instead of
doing the right thing from the start.

That is the right thing being something less static.

Can you work with me on what that could be please?

> 
> Thanks,
> Ashish
> 
> > What I wonder is if we can combine the boot-allocation of the SWIOTLB
> > with the post-boot-allocation of SWIOLTB to stitch together
> > continous physical ranges.
> > 
> > That way you have the flexibility at the start of using 64MB but if there
> > is pressure, we grow to a bigger size?
> > 
> > > 
> > > Thanks,
> > > Ashish
> > > 
> > > > > memory.
> > > > > 
> > > > > Using late_initcall() interface to invoke
> > > > > swiotlb_adjust() does not work as the size
> > > > > adjustment needs to be done before mem_encrypt_init()
> > > > > and reserve_crashkernel() which use the allocated
> > > > > SWIOTLB buffer size, hence calling it explicitly
> > > > > from setup_arch().
> > > > > 
> > > > > The SWIOTLB default size adjustment is added as an
> > > > > architecture specific interface/callback to allow
> > > > > architectures such as those supporting memory
> > > > > encryption to adjust/expand SWIOTLB size for their
> > > > > use.
> > > > > 
> > > > > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > > > > ---
> > > > >  arch/x86/kernel/setup.c   |  2 ++
> > > > >  arch/x86/mm/mem_encrypt.c | 42 +++++++++++++++++++++++++++++++++++++++
> > > > >  include/linux/swiotlb.h   |  1 +
> > > > >  kernel/dma/swiotlb.c      | 27 +++++++++++++++++++++++++
> > > > >  4 files changed, 72 insertions(+)
> > > > > 
> > > > > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > > > > index 3511736fbc74..b073d58dd4a3 100644
> > > > > --- a/arch/x86/kernel/setup.c
> > > > > +++ b/arch/x86/kernel/setup.c
> > > > > @@ -1166,6 +1166,8 @@ void __init setup_arch(char **cmdline_p)
> > > > >  	if (boot_cpu_has(X86_FEATURE_GBPAGES))
> > > > >  		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> > > > >  
> > > > > +	swiotlb_adjust();
> > > > > +
> > > > >  	/*
> > > > >  	 * Reserve memory for crash kernel after SRAT is parsed so that it
> > > > >  	 * won't consume hotpluggable memory.
> > > > > diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> > > > > index 3f248f0d0e07..e0deb157cddd 100644
> > > > > --- a/arch/x86/mm/mem_encrypt.c
> > > > > +++ b/arch/x86/mm/mem_encrypt.c
> > > > > @@ -489,7 +489,49 @@ static void print_mem_encrypt_feature_info(void)
> > > > >  	pr_cont("\n");
> > > > >  }
> > > > >  
> > > > > +#define TOTAL_MEM_1G	0x40000000UL
> > > > > +#define TOTAL_MEM_4G	0x100000000UL
> > > > > +
> > > > > +#define SIZE_128M (128UL<<20)
> > > > > +#define SIZE_256M (256UL<<20)
> > > > > +#define SIZE_512M (512UL<<20)
> > > > > +
> > > > >  /* Architecture __weak replacement functions */
> > > > > +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> > > > > +{
> > > > > +	unsigned long size = 0;
> > > > > +
> > > > > +	/*
> > > > > +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> > > > > +	 * SEV uses SWOTLB to make this happen without changing device
> > > > > +	 * drivers. However, depending on the workload being run, the
> > > > > +	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
> > > > > +	 * run out of buffers for DMA, resulting in I/O errors and/or
> > > > > +	 * performance degradation especially with high I/O workloads.
> > > > > +	 * Increase the default size of SWIOTLB for SEV guests using
> > > > > +	 * a minimum value of 128MB and a maximum value of 512MB,
> > > > > +	 * depending on amount of provisioned guest memory.
> > > > > +	 */
> > > > > +	if (sev_active()) {
> > > > > +		phys_addr_t total_mem = memblock_phys_mem_size();
> > > > > +
> > > > > +		if (total_mem <= TOTAL_MEM_1G)
> > > > > +			size = clamp(iotlb_default_size * 2, SIZE_128M,
> > > > > +				     SIZE_128M);
> > > > > +		else if (total_mem <= TOTAL_MEM_4G)
> > > > > +			size = clamp(iotlb_default_size * 4, SIZE_256M,
> > > > > +				     SIZE_256M);
> > > > > +		else
> > > > > +			size = clamp(iotlb_default_size * 8, SIZE_512M,
> > > > > +				     SIZE_512M);
> > > > > +
> > > > > +		pr_info("SEV adjusted max SWIOTLB size = %luMB",
> > > > > +			size >> 20);
> > > > > +	}
> > > > > +
> > > > > +	return size;
> > > > > +}
> > > > > +
> > > > >  void __init mem_encrypt_init(void)
> > > > >  {
> > > > >  	if (!sme_me_mask)
> > > > > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > > > > index 046bb94bd4d6..01ae6d891327 100644
> > > > > --- a/include/linux/swiotlb.h
> > > > > +++ b/include/linux/swiotlb.h
> > > > > @@ -33,6 +33,7 @@ extern void swiotlb_init(int verbose);
> > > > >  int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
> > > > >  extern unsigned long swiotlb_nr_tbl(void);
> > > > >  unsigned long swiotlb_size_or_default(void);
> > > > > +extern void __init swiotlb_adjust(void);
> > > > >  extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
> > > > >  extern void __init swiotlb_update_mem_attributes(void);
> > > > >  
> > > > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > > > index c19379fabd20..66a9e627bb51 100644
> > > > > --- a/kernel/dma/swiotlb.c
> > > > > +++ b/kernel/dma/swiotlb.c
> > > > > @@ -163,6 +163,33 @@ unsigned long swiotlb_size_or_default(void)
> > > > >  	return size ? size : (IO_TLB_DEFAULT_SIZE);
> > > > >  }
> > > > >  
> > > > > +unsigned long __init __weak arch_swiotlb_adjust(unsigned long size)
> > > > > +{
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +void __init swiotlb_adjust(void)
> > > > > +{
> > > > > +	unsigned long size;
> > > > > +
> > > > > +	/*
> > > > > +	 * If swiotlb parameter has not been specified, give a chance to
> > > > > +	 * architectures such as those supporting memory encryption to
> > > > > +	 * adjust/expand SWIOTLB size for their use.
> > > > > +	 */
> > > > > +	if (!io_tlb_nslabs) {
> > > > > +		size = arch_swiotlb_adjust(IO_TLB_DEFAULT_SIZE);
> > > > > +		if (size) {
> > > > > +			size = ALIGN(size, 1 << IO_TLB_SHIFT);
> > > > > +			io_tlb_nslabs = size >> IO_TLB_SHIFT;
> > > > > +			io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> > > > > +
> > > > > +			pr_info("architecture adjusted SWIOTLB slabs = %lu\n",
> > > > > +				io_tlb_nslabs);
> > > > > +		}
> > > > > +	}
> > > > > +}
> > > > > +
> > > > >  void swiotlb_print_info(void)
> > > > >  {
> > > > >  	unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> > > > > -- 
> > > > > 2.17.1
> > > > > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
