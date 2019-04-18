Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3422C10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 22:20:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957612064A
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 22:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957612064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3490B1EBE;
	Thu, 18 Apr 2019 22:20:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 30F641CD5
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 22:19:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D2F58823
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 22:19:44 +0000 (UTC)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
	[66.24.58.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 509352064A;
	Thu, 18 Apr 2019 22:19:41 +0000 (UTC)
Date: Thu, 18 Apr 2019 18:19:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 01/29] tracing: Cleanup stack trace code
Message-ID: <20190418181938.2e2a9a04@gandalf.local.home>
In-Reply-To: <20190418084253.142712304@linutronix.de>
References: <20190418084119.056416939@linutronix.de>
	<20190418084253.142712304@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Mike Snitzer <snitzer@redhat.com>, David Airlie <airlied@linux.ie>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	dm-devel@redhat.com, Alexander Potapenko <glider@google.com>,
	Christoph Lameter <cl@linux.com>, Christoph Hellwig <hch@lst.de>,
	Alasdair Kergon <agk@redhat.com>, linux-arch@vger.kernel.org,
	x86@kernel.org, kasan-dev@googlegroups.com,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexey Dobriyan <adobriyan@gmail.com>, intel-gfx@lists.freedesktop.org,
	David Rientjes <rientjes@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Josef Bacik <josef@toxicpanda.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>, Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, David Sterba <dsterba@suse.com>,
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
Message-ID: <20190418221938.A9i-6FrvLzZwT5RYEpMrEMNi1Y2eAq87WxO6QWclctw@z>

On Thu, 18 Apr 2019 10:41:20 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:


> @@ -412,23 +404,20 @@ stack_trace_sysctl(struct ctl_table *tab
>  		   void __user *buffer, size_t *lenp,
>  		   loff_t *ppos)
>  {
> -	int ret;
> +	int ret, was_enabled;

One small nit. Could this be:

	int was_enabled;
	int ret;

I prefer only joining variables that are related on the same line.
Makes it look cleaner IMO.

>  
>  	mutex_lock(&stack_sysctl_mutex);
> +	was_enabled = !!stack_tracer_enabled;
>  

Bah, not sure why I didn't do it this way to begin with. I think I
copied something else that couldn't do it this way for some reason and
didn't put any brain power behind the copy. :-/ But that was back in
2008 so I blame it on being "young and stupid" ;-)

Other then the above nit and removing the unneeded +1 in max_entries:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


>  	ret = proc_dointvec(table, write, buffer, lenp, ppos);
>  
> -	if (ret || !write ||
> -	    (last_stack_tracer_enabled == !!stack_tracer_enabled))
> +	if (ret || !write || (was_enabled == !!stack_tracer_enabled))
>  		goto out;
>  
> -	last_stack_tracer_enabled = !!stack_tracer_enabled;
> -
>  	if (stack_tracer_enabled)
>  		register_ftrace_function(&trace_ops);
>  	else
>  		unregister_ftrace_function(&trace_ops);
> -
>   out:
>  	mutex_unlock(&stack_sysctl_mutex);
>  	return ret;
> @@ -444,7 +433,6 @@ static __init int enable_stacktrace(char
>  		strncpy(stack_trace_filter_buf, str + len, COMMAND_LINE_SIZE);
>  
>  	stack_tracer_enabled = 1;
> -	last_stack_tracer_enabled = 1;
>  	return 1;
>  }
>  __setup("stacktrace", enable_stacktrace);
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
