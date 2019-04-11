Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7B7C10F11
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 03:02:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7519D20818
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 03:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7519D20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0B51221E2;
	Thu, 11 Apr 2019 03:02:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B60E621DF
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 03:02:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 341AF7ED
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 03:02:05 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 871FCDA314;
	Thu, 11 Apr 2019 03:02:04 +0000 (UTC)
Received: from treble (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1711F1001E71;
	Thu, 11 Apr 2019 03:02:03 +0000 (UTC)
Date: Wed, 10 Apr 2019 22:02:01 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Message-ID: <20190411030201.uko3njal44w2ea4b@treble>
References: <20190410102754.387743324@linutronix.de>
	<20190410103646.130022106@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190410103646.130022106@linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Thu, 11 Apr 2019 03:02:04 +0000 (UTC)
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, iommu@lists.linux-foundation.org,
	Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411030201.Er8zgy_GMzQEp1lJQFfezKhyhIy__Qs3dY4sSkJS94U@z>

On Wed, Apr 10, 2019 at 12:28:22PM +0200, Thomas Gleixner wrote:
> Replace the indirection through struct stack_trace with an invocation of
> the storage array based interface.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: iommu@lists.linux-foundation.org
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  kernel/dma/debug.c |   13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -89,8 +89,8 @@ struct dma_debug_entry {
>  	int		 sg_mapped_ents;
>  	enum map_err_types  map_err_type;
>  #ifdef CONFIG_STACKTRACE
> -	struct		 stack_trace stacktrace;
> -	unsigned long	 st_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
> +	unsigned int	st_len;
> +	unsigned long	st_entries[DMA_DEBUG_STACKTRACE_ENTRIES];

nit: st_entries isn't very readable.  Thanks to the magic of compilers,
the characters are free, so why not call them "stacktrace_entries" and
"stacktrace_len".

-- 
Josh
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
