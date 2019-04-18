Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C55C10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 11:52:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6142183E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 11:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6142183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CF6E11654;
	Thu, 18 Apr 2019 11:52:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 301BE1638
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 11:52:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
	[148.163.156.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id ABD49108
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 11:52:11 +0000 (UTC)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3IBnRdo069184
	for <iommu@lists.linux-foundation.org>; Thu, 18 Apr 2019 07:52:11 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rxqysa0kn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Thu, 18 Apr 2019 07:52:10 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <rppt@linux.ibm.com>;
	Thu, 18 Apr 2019 12:52:07 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 18 Apr 2019 12:51:58 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
	[9.149.105.59])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3IBpvT627525222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 18 Apr 2019 11:51:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58BF2A4051;
	Thu, 18 Apr 2019 11:51:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB49FA4040;
	Thu, 18 Apr 2019 11:51:54 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Apr 2019 11:51:54 +0000 (GMT)
Date: Thu, 18 Apr 2019 14:51:53 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 03/29] lib/stackdepot: Provide functions which operate
	on plain storage arrays
References: <20190418084119.056416939@linutronix.de>
	<20190418084253.337266121@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190418084253.337266121@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19041811-0012-0000-0000-000003103330
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041811-0013-0000-0000-000021487584
Message-Id: <20190418115152.GA13304@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-18_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=588 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904180084
Cc: Mike Snitzer <snitzer@redhat.com>, David Airlie <airlied@linux.ie>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	dm-devel@redhat.com, Alexander Potapenko <glider@google.com>,
	Christoph Lameter <cl@linux.com>, Christoph Hellwig <hch@lst.de>,
	Alasdair Kergon <agk@redhat.com>, linux-arch@vger.kernel.org,
	x86@kernel.org, kasan-dev@googlegroups.com,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexey Dobriyan <adobriyan@gmail.com>, intel-gfx@lists.freedesktop.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, Josef Bacik <josef@toxicpanda.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	David Sterba <dsterba@suse.com>,
	Dmitry Vyukov <dvyukov@google.com>, Chris Mason <clm@fb.com>,
	LKML <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>,
	iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-btrfs@vger.kernel.org
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
Message-ID: <20190418115153.Sb0sxyQx-q33GGk8tl-BQTyYtlGmIbf2sbp28r6pdv0@z>

On Thu, Apr 18, 2019 at 10:41:22AM +0200, Thomas Gleixner wrote:
> The struct stack_trace indirection in the stack depot functions is a truly
> pointless excercise which requires horrible code at the callsites.
> 
> Provide interfaces based on plain storage arrays.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Alexander Potapenko <glider@google.com>
> ---
>  include/linux/stackdepot.h |    4 ++
>  lib/stackdepot.c           |   66 ++++++++++++++++++++++++++++++++-------------
>  2 files changed, 51 insertions(+), 19 deletions(-)
> 
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -26,7 +26,11 @@ typedef u32 depot_stack_handle_t;
>  struct stack_trace;
> 
>  depot_stack_handle_t depot_save_stack(struct stack_trace *trace, gfp_t flags);
> +depot_stack_handle_t stack_depot_save(unsigned long *entries,
> +				      unsigned int nr_entries, gfp_t gfp_flags);
> 
>  void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *trace);
> +unsigned int stack_depot_fetch(depot_stack_handle_t handle,
> +			       unsigned long **entries);
> 
>  #endif
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -194,40 +194,56 @@ static inline struct stack_record *find_
>  	return NULL;
>  }
> 
> -void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *trace)
> +/**
> + * stack_depot_fetch - Fetch stack entries from a depot
> + *

Nit: kernel-doc will complain about missing description of @handle.

> + * @entries:		Pointer to store the entries address
> + */
> +unsigned int stack_depot_fetch(depot_stack_handle_t handle,
> +			       unsigned long **entries)
>  {
>  	union handle_parts parts = { .handle = handle };
>  	void *slab = stack_slabs[parts.slabindex];
>  	size_t offset = parts.offset << STACK_ALLOC_ALIGN;
>  	struct stack_record *stack = slab + offset;
> 
> -	trace->nr_entries = trace->max_entries = stack->size;
> -	trace->entries = stack->entries;
> -	trace->skip = 0;
> +	*entries = stack->entries;
> +	return stack->size;
> +}
> +EXPORT_SYMBOL_GPL(stack_depot_fetch);
> +
> +void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *trace)
> +{
> +	unsigned int nent = stack_depot_fetch(handle, &trace->entries);
> +
> +	trace->max_entries = trace->nr_entries = nent;
>  }
>  EXPORT_SYMBOL_GPL(depot_fetch_stack);
> 
>  /**
> - * depot_save_stack - save stack in a stack depot.
> - * @trace - the stacktrace to save.
> - * @alloc_flags - flags for allocating additional memory if required.
> + * stack_depot_save - Save a stack trace from an array
>   *
> - * Returns the handle of the stack struct stored in depot.
> + * @entries:		Pointer to storage array
> + * @nr_entries:		Size of the storage array
> + * @alloc_flags:	Allocation gfp flags
> + *
> + * Returns the handle of the stack struct stored in depot

Can you please s/Returns/Return:/ so that kernel-doc will recognize this as
return section.

>   */
> -depot_stack_handle_t depot_save_stack(struct stack_trace *trace,
> -				    gfp_t alloc_flags)
> +depot_stack_handle_t stack_depot_save(unsigned long *entries,
> +				      unsigned int nr_entries,
> +				      gfp_t alloc_flags)
>  {
> -	u32 hash;
> -	depot_stack_handle_t retval = 0;
>  	struct stack_record *found = NULL, **bucket;
> -	unsigned long flags;
> +	depot_stack_handle_t retval = 0;
>  	struct page *page = NULL;
>  	void *prealloc = NULL;
> +	unsigned long flags;
> +	u32 hash;
> 
> -	if (unlikely(trace->nr_entries == 0))
> +	if (unlikely(nr_entries == 0))
>  		goto fast_exit;
> 
> -	hash = hash_stack(trace->entries, trace->nr_entries);
> +	hash = hash_stack(entries, nr_entries);
>  	bucket = &stack_table[hash & STACK_HASH_MASK];
> 
>  	/*
> @@ -235,8 +251,8 @@ depot_stack_handle_t depot_save_stack(st
>  	 * The smp_load_acquire() here pairs with smp_store_release() to
>  	 * |bucket| below.
>  	 */
> -	found = find_stack(smp_load_acquire(bucket), trace->entries,
> -			   trace->nr_entries, hash);
> +	found = find_stack(smp_load_acquire(bucket), entries,
> +			   nr_entries, hash);
>  	if (found)
>  		goto exit;
> 
> @@ -264,10 +280,10 @@ depot_stack_handle_t depot_save_stack(st
> 
>  	spin_lock_irqsave(&depot_lock, flags);
> 
> -	found = find_stack(*bucket, trace->entries, trace->nr_entries, hash);
> +	found = find_stack(*bucket, entries, nr_entries, hash);
>  	if (!found) {
>  		struct stack_record *new =
> -			depot_alloc_stack(trace->entries, trace->nr_entries,
> +			depot_alloc_stack(entries, nr_entries,
>  					  hash, &prealloc, alloc_flags);
>  		if (new) {
>  			new->next = *bucket;
> @@ -297,4 +313,16 @@ depot_stack_handle_t depot_save_stack(st
>  fast_exit:
>  	return retval;
>  }
> +EXPORT_SYMBOL_GPL(stack_depot_save);
> +
> +/**
> + * depot_save_stack - save stack in a stack depot.
> + * @trace - the stacktrace to save.
> + * @alloc_flags - flags for allocating additional memory if required.
> + */
> +depot_stack_handle_t depot_save_stack(struct stack_trace *trace,
> +				      gfp_t alloc_flags)
> +{
> +	return stack_depot_save(trace->entries, trace->nr_entries, alloc_flags);
> +}
>  EXPORT_SYMBOL_GPL(depot_save_stack);
> 
> 

-- 
Sincerely yours,
Mike.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
