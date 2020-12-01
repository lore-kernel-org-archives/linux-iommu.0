Return-Path: <SRS0=bYB5=FF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454EAC64E7B
	for <iommu@archiver.kernel.org>; Tue,  1 Dec 2020 20:41:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4742065E
	for <iommu@archiver.kernel.org>; Tue,  1 Dec 2020 20:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GOyeqKz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4742065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E2CA987FFE;
	Tue,  1 Dec 2020 20:41:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UHj67x249hc4; Tue,  1 Dec 2020 20:41:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C9ADF87E98;
	Tue,  1 Dec 2020 20:41:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBFCAC0859;
	Tue,  1 Dec 2020 20:41:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8F02C0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 20:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C3FE687E98
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 20:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EtmwbU60759I for <iommu@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 20:41:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8441287FED
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 20:41:20 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1KdDAr023774;
 Tue, 1 Dec 2020 20:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=K4sJueQWoshKIfrrjBIw1vFWnEfdeqdwL9VzWeJyWT4=;
 b=GOyeqKz3WeFPazEFMTnmVGVYHkoNKm8e32glahdb/t9UOOLTpwpEqHdAi7tFjzuaNEN8
 e0q0Z7nsYf1ThDugeLr8k3TuBjWyQzPUDse/d0tk99fwS4mT6WuJGemvXwHA9ywdhrOW
 RyoI/fnt/m9AhOfdzAZuCOJK+v1v/T94MzXXK+QSCpCgzxebRFw33pq/U64z9tgHlu4x
 wgawZ+lMe1sqjbFR0s5YMr3HIGQY/EnPxnMcqxO16MnFLrr1eNOVBPzAxS/sjgFzFtC6
 aA8VThjMnaxphHWB8OrLwy7QSt1QhINxmavl4CRScVZTXx3TDRxIihnr407n7lpr9oF2 Ww== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 353c2avvct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 01 Dec 2020 20:40:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1KVKDF052973;
 Tue, 1 Dec 2020 20:40:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 3540fxhnxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Dec 2020 20:40:45 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B1KecaZ011014;
 Tue, 1 Dec 2020 20:40:39 GMT
Received: from char.us.oracle.com (/10.152.32.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 01 Dec 2020 12:40:38 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
 id 88B9B6A00D6; Tue,  1 Dec 2020 15:42:39 -0500 (EST)
Date: Tue, 1 Dec 2020 15:42:39 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v6] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201201204239.GA4528@char.us.oracle.com>
References: <20201119214205.11062-1-Ashish.Kalra@amd.com>
 <20201123170647.GE15044@zn.tnic>
 <20201123175632.GA21539@char.us.oracle.com>
 <20201123225631.GA16055@ashkalra_ubuntu_server>
 <20201124234622.GA16867@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201124234622.GA16867@ashkalra_ubuntu_server>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010125
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

On Tue, Nov 24, 2020 at 11:46:22PM +0000, Ashish Kalra wrote:
> Hello Konrad, 
> 
> On Mon, Nov 23, 2020 at 10:56:31PM +0000, Ashish Kalra wrote:
> > Hello Konrad,
> > 
> > On Mon, Nov 23, 2020 at 12:56:32PM -0500, Konrad Rzeszutek Wilk wrote:
> > > On Mon, Nov 23, 2020 at 06:06:47PM +0100, Borislav Petkov wrote:
> > > > On Thu, Nov 19, 2020 at 09:42:05PM +0000, Ashish Kalra wrote:
> > > > > From: Ashish Kalra <ashish.kalra@amd.com>
> > > > > 
> > > > > For SEV, all DMA to and from guest has to use shared (un-encrypted) pages.
> > > > > SEV uses SWIOTLB to make this happen without requiring changes to device
> > > > > drivers.  However, depending on workload being run, the default 64MB of
> > > > > SWIOTLB might not be enough and SWIOTLB may run out of buffers to use
> > > > > for DMA, resulting in I/O errors and/or performance degradation for
> > > > > high I/O workloads.
> > > > > 
> > > > > Increase the default size of SWIOTLB for SEV guests using a minimum
> > > > > value of 128MB and a maximum value of 512MB, determining on amount
> > > > > of provisioned guest memory.
> > > > 
> > > > That sentence needs massaging.
> > > > 
> > > > > Using late_initcall() interface to invoke swiotlb_adjust() does not
> > > > > work as the size adjustment needs to be done before mem_encrypt_init()
> > > > > and reserve_crashkernel() which use the allocated SWIOTLB buffer size,
> > > > > hence calling it explicitly from setup_arch().
> > > > 
> > > > "hence call it ... "
> > > > 
> > > > > 
> > > > > The SWIOTLB default size adjustment is added as an architecture specific
> > > > 
> > > > "... is added... " needs to be "Add ..."
> > > > 
> > > > > interface/callback to allow architectures such as those supporting memory
> > > > > encryption to adjust/expand SWIOTLB size for their use.
> > > > > 
> > > > > v5 fixed build errors and warnings as
> > > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > > 
> > > > > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > > > > ---
> > > > >  arch/x86/kernel/setup.c   |  2 ++
> > > > >  arch/x86/mm/mem_encrypt.c | 32 ++++++++++++++++++++++++++++++++
> > > > >  include/linux/swiotlb.h   |  6 ++++++
> > > > >  kernel/dma/swiotlb.c      | 24 ++++++++++++++++++++++++
> > > > >  4 files changed, 64 insertions(+)
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
> > > > > index 3f248f0d0e07..c79a0d761db5 100644
> > > > > --- a/arch/x86/mm/mem_encrypt.c
> > > > > +++ b/arch/x86/mm/mem_encrypt.c
> > > > > @@ -490,6 +490,38 @@ static void print_mem_encrypt_feature_info(void)
> > > > >  }
> > > > >  
> > > > >  /* Architecture __weak replacement functions */
> > > > > +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> > > > > +{
> > > > > +	unsigned long size = 0;
> > > > 
> > > > 	unsigned long size = iotlb_default_size;
> > > > 
> > > > > +
> > > > > +	/*
> > > > > +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> > > > > +	 * SEV uses SWOTLB to make this happen without changing device
> > > > > +	 * drivers. However, depending on the workload being run, the
> > > > > +	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
> > > > 						     ^
> > > > 
> > > > Use words pls, not "&".
> > > > 
> > > > 
> > > > > +	 * run out of buffers for DMA, resulting in I/O errors and/or
> > > > > +	 * performance degradation especially with high I/O workloads.
> > > > > +	 * Increase the default size of SWIOTLB for SEV guests using
> > > > > +	 * a minimum value of 128MB and a maximum value of 512MB,
> > > > > +	 * depending on amount of provisioned guest memory.
> > > > > +	 */
> > > > > +	if (sev_active()) {
> > > > > +		phys_addr_t total_mem = memblock_phys_mem_size();
> > > > > +
> > > > > +		if (total_mem <= SZ_1G)
> > > > > +			size = max(iotlb_default_size, (unsigned long) SZ_128M);
> > > > > +		else if (total_mem <= SZ_4G)
> > > > > +			size = max(iotlb_default_size, (unsigned long) SZ_256M);
> > > 
> > > That is eating 128MB for 1GB, aka 12% of the guest memory allocated statically for this.
> > > 
> > > And for guests that are 2GB, that is 12% until it gets to 3GB when it is 8%
> > > and then 6% at 4GB.
> > > 
> > > I would prefer this to be based on your memory count, that is 6% of total
> > > memory. And then going forward we can allocate memory _after_ boot and then stich
> > > the late SWIOTLB pool and allocate on demand.
> > > 
> > > 
> > Ok. 
> > 
> > As i mentioned earlier, the patch was initially based on using a % of guest memory,
> > as below:
> > 
> > +#define SEV_ADJUST_SWIOTLB_SIZE_PERCENT        5
> > +#define SEV_ADJUST_SWIOTLB_SIZE_MAX    (1UL << 30)
> > ...
> > ...
> > +       if (sev_active() && !io_tlb_nslabs) {
> > +               unsigned long total_mem = get_num_physpages() <<
> > + PAGE_SHIFT;
> > +
> > +               default_size = total_mem *
> > +                       SEV_ADJUST_SWIOTLB_SIZE_PERCENT / 100;
> > +
> > +               default_size = ALIGN(default_size, 1 << IO_TLB_SHIFT);
> > +
> > +               default_size = clamp_val(default_size, IO_TLB_DEFAULT_SIZE,
> > +                       SEV_ADJUST_SWIOTLB_SIZE_MAX);
> > +       }
> > 
> > So a similar logic can be applied here.
> > 
> > > 
> > > > > +		else
> > > > > +			size = max(iotlb_default_size, (unsigned long) SZ_512M);
> > > > > +
> > > > > +		pr_info("SWIOTLB bounce buffer size adjusted to %luMB for SEV platform",
> > > > 
> > > > just "... for SEV" - no need for "platform".
> > > > 
> > > > ...
> > > > 
> > > > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > > > index c19379fabd20..3be9a19ea0a5 100644
> > > > > --- a/kernel/dma/swiotlb.c
> > > > > +++ b/kernel/dma/swiotlb.c
> > > > > @@ -163,6 +163,30 @@ unsigned long swiotlb_size_or_default(void)
> > > > >  	return size ? size : (IO_TLB_DEFAULT_SIZE);
> > > > >  }
> > > > >  
> > > > > +unsigned long __init __weak arch_swiotlb_adjust(unsigned long size)
> > > > > +{
> > > > > +	return 0;
> > > > 
> > > > That, of course, needs to return size, not 0.
> > > 
> > > This is not going to work for TDX. I think having a registration
> > > to SWIOTLB to have this function would be better going forward.
> > > 
> > > As in there will be a swiotlb_register_adjuster() which AMD SEV
> > > code can call at start, also TDX can do it (and other platforms).
> > > 
> > 
> > The question is how does mem_encrypt_init() work ?
> > 
> > That uses a similar logic as arch_swiotlb_adjust() as a "__weak"
> > function and i am sure it will also need to have added support for TDX,
> > can't both arch_swiotlb_adjust() and mem_encrypt_init() have specific
> > checks for active AMD/INTEL memory encryption technology and accordingly
> > perform actions, as mem_encrypt_init() currently checks for
> > sev_active().
> > 
> > init/main.c: 
> > 
> > void __init __weak mem_encrypt_init(void) { }
> > 
> > start_kernel()
> > {
> >    ..
> >    mem_encrypt_init();
> >    ..
> > }
> > 
> > arch/x86/mm/mem_encrypt.c: 
> >     
> > /* Architecture __weak replacement functions */
> > 
> > void __init mem_encrypt_init(void)
> > {
> >         if (!sme_me_mask)
> >                 return;
> > 
> >         /* Call into SWIOTLB to update the SWIOTLB DMA buffers */
> >         swiotlb_update_mem_attributes();
> > 
> >         /*
> >          * With SEV, we need to unroll the rep string I/O instructions.
> >          */
> >         if (sev_active())
> >                 static_branch_enable(&sev_enable_key);
> > ...
> > ...
> > 
> 
> Your thoughts on this ?

That looks quite sensible. 
> 
> Thanks,
> Ashish
> 
> > 
> > > > 
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
> > > > 
> > > > And when you preset the function-local argument "size" with the size
> > > > coming in as the size argument of arch_swiotlb_adjust()...
> > > > 
> > > > > +	if (!io_tlb_nslabs) {
> > > > > +		size = arch_swiotlb_adjust(IO_TLB_DEFAULT_SIZE);
> > > > > +		if (size) {
> > > > 
> > > > ... you don't have to do if (size) here either but simply use size to
> > > > compute io_tlb_nslabs, I'd say.
> > > > 
> > > > Thx.
> > > > 
> > > > -- 
> > > > Regards/Gruss,
> > > >     Boris.
> > > > 
> > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CAshish.Kalra%40amd.com%7Cebd4a85f98f44bdfcb5408d88fd8dfac%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637417508926083910%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Ub9PjAPzhDWr7K2iQggTAXwgg4VbORxP%2F%2Fcg6gQreCc%3D&amp;reserved=0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
