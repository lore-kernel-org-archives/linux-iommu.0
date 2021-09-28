Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD605C4332F
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 05:39:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B84F610A5
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 05:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B84F610A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4869E80C91;
	Tue, 28 Sep 2021 05:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cg4HsC7_njpL; Tue, 28 Sep 2021 05:39:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 446A080C55;
	Tue, 28 Sep 2021 05:39:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AF5EC000F;
	Tue, 28 Sep 2021 05:39:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEFBCC000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 05:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA7FA608CB
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 05:39:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A6LlWl-ZODxb for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 05:39:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C5E9460896
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 05:39:19 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id ED5FC67373; Tue, 28 Sep 2021 07:39:11 +0200 (CEST)
Date: Tue, 28 Sep 2021 07:39:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V5 12/12] net: netvsc: Add Isolation VM support for
 netvsc driver
Message-ID: <20210928053911.GA29208@lst.de>
References: <20210914133916.1440931-1-ltykernel@gmail.com>
 <20210914133916.1440931-13-ltykernel@gmail.com>
 <MWHPR21MB15939A5D74CA1DF25EE816ADD7DB9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <43e22b84-7273-4099-42ea-54b06f398650@gmail.com>
 <e379a60b-4d74-9167-983f-f70c96bb279e@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e379a60b-4d74-9167-983f-f70c96bb279e@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 Michael Kelley <mikelley@microsoft.com>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
 "will@kernel.org" <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "x86@kernel.org" <x86@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "mingo@redhat.com" <mingo@redhat.com>, "pgonda@google.com" <pgonda@google.com>,
 "rientjes@google.com" <rientjes@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "jgross@suse.com" <jgross@suse.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
 "luto@kernel.org" <luto@kernel.org>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "saravanand@fb.com" <saravanand@fb.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "tj@kernel.org" <tj@kernel.org>, vkuznets <vkuznets@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
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

On Mon, Sep 27, 2021 at 10:26:43PM +0800, Tianyu Lan wrote:
> Hi Christoph:
>     Gentile ping. The swiotlb and shared memory mapping changes in this
> patchset needs your reivew. Could you have a look?

I'm a little too busy for a review of such a huge patchset right now.
That being said here are my comments from a very quick review:

 - the bare memremap usage in swiotlb looks strange and I'd
   definitively expect a well documented wrapper.
 - given that we can now hand out swiotlb memory for coherent mappings
   we need to carefully audit what happens when this memremaped
   memory gets mmaped or used through dma_get_sgtable
 - the netscv changes I'm not happy with at all.  A large part of it
   is that the driver already has a bad structure, but this series
   is making it significantly worse.  We'll need to find a way
   to use the proper dma mapping abstractions here.  One option
   if you want to stick to the double vmapped buffer would be something
   like using dma_alloc_noncontigous plus a variant of
   dma_vmap_noncontiguous that takes the shared_gpa_boundary into
   account.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
