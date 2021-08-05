Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A8BC4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 14:13:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57A56113B
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 14:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B57A56113B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89066831DA;
	Thu,  5 Aug 2021 14:13:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z91R-e5lsEeM; Thu,  5 Aug 2021 14:13:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 66A0983004;
	Thu,  5 Aug 2021 14:13:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50FF6C0010;
	Thu,  5 Aug 2021 14:13:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEB67C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 14:13:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BBC59402F0
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 14:13:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FWFjZCPlvO3z for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 14:13:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7FABC400F7
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 14:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=jkC5BHIA+OoNY3RA1kKnhanE39KSJUyRxPOSK5PxKJ4=; b=jS9beBRN33+YE3nLhV0+juwj2m
 M21gswRLRXlj9G7nUL9+UaYZaqldUk6dYat8MK2TEtQx98o7T9VsMJPD7iRU4uGctnpwJmiAENC0S
 d5iBGtcKE/rvu2bDPFEsbbPN5g4HEVxgwrnHKLJHDx6oq4fdfON20zC1m1PYA4MystYDRR/ijf6n+
 yKP6PzPUB8C4KKMetCzyTfsQiIZX9POLtO6DG6sM1OD0l3e9s8v/Kx4GgKgISf9CHEnHVcYWRA4+Q
 LHlKUuStVn3XhYiGoHOGpKfs5vgB5qUCyiEjS8M7ODcJbCa/Q2rQchs+BwAv5uLBsAuE3F/UYuh1M
 DgYQMj1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBe5i-00799u-0r; Thu, 05 Aug 2021 14:11:31 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 951B130031E;
 Thu,  5 Aug 2021 16:11:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 5BFD82028D0D9; Thu,  5 Aug 2021 16:11:19 +0200 (CEST)
Date: Thu, 5 Aug 2021 16:11:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V2 03/14] x86/set_memory: Add x86_set_memory_enc static
 call support
Message-ID: <YQvxhyn5O1POQTF/@hirez.programming.kicks-ass.net>
References: <20210804184513.512888-1-ltykernel@gmail.com>
 <20210804184513.512888-4-ltykernel@gmail.com>
 <5823af8a-7dbb-dbb0-5ea2-d9846aa2a36a@intel.com>
 <942e6fcb-3bdf-9294-d3db-ca311db440d3@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <942e6fcb-3bdf-9294-d3db-ca311db440d3@gmail.com>
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 david@redhat.com, ardb@kernel.org, dave.hansen@linux.intel.com,
 Dave Hansen <dave.hansen@intel.com>, hpa@zytor.com, kys@microsoft.com,
 will@kernel.org, boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org,
 wei.liu@kernel.org, sstabellini@kernel.org, sthemmin@microsoft.com,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
 aneesh.kumar@linux.ibm.com, x86@kernel.org, decui@microsoft.com, hch@lst.de,
 michael.h.kelley@microsoft.com, mingo@redhat.com, pgonda@google.com,
 rientjes@google.com, kuba@kernel.org, jejb@linux.ibm.com,
 martin.b.radev@gmail.com, thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 keescook@chromium.org, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, vkuznets@redhat.com,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kirill.shutemov@linux.intel.com,
 tj@kernel.org, akpm@linux-foundation.org, robin.murphy@arm.com,
 davem@davemloft.net, rppt@kernel.org
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

On Thu, Aug 05, 2021 at 10:05:17PM +0800, Tianyu Lan wrote:
> +static int default_set_memory_enc(unsigned long addr, int numpages, bool
> enc)
> +{
> +	return 0;
> +}
> +
> +DEFINE_STATIC_CALL(x86_set_memory_enc, default_set_memory_enc);

That's spelled:

DEFINE_STATIC_CALL_RET0(x86_set_memory_enc, __set_memory_enc_dec);

And then you can remove the default_set_memory_enc() thing.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
