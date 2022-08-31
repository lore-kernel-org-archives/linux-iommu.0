Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E752620
	for <iommu@lists.linux.dev>; Wed, 31 Aug 2022 01:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/x61W8ECxcYp6VApa7rbgykWRp7/DFT2S0h+uIWuEt0=; b=fE7O2deJ1RanMKunrQ/zfTMOSf
	ifOEdubrRjpQzwW+wZCnCsaWL1H+dWIVEswSHglWXF4cq19WX45jSAEjFPyZFK2LXQ/wijSM7tb6W
	k+uKJo3mowcOZdAppnjeLHiYp6lzcRvVqvUVCdEqW0pqgaFiMUCu5tCvL+up2/ud0wrXHAYStgD5a
	X7gktDpA97ofBU/rvHf3O939oo9TWrRT3CvpoipMffjAPkcPIWHeNYHzqspR3VsERhUOHNzx430Z/
	qd7jFqLKUOEu/+8WZcmicWNgLbhaqj0Z+mtdiwHRaBjVj4sH29gTT/fbGsv85v6mNxd4VsF6MswZB
	9lmrzOIw==;
Received: from [2601:1c0:6280:3f0::a6b3]
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTCtd-0036Mt-9k; Wed, 31 Aug 2022 01:52:01 +0000
Message-ID: <b252a4e0-57a1-0f27-f4b0-598e851b47ea@infradead.org>
Date: Tue, 30 Aug 2022 18:51:56 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH 22/30] Code tagging based fault injection
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
 ldufour@linux.ibm.com, peterx@redhat.com, david@redhat.com, axboe@kernel.dk,
 mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org,
 changbin.du@intel.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, arnd@arndb.de, jbaron@akamai.com,
 rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
 kernel-team@android.com, linux-mm@kvack.org, iommu@lists.linux.dev,
 kasan-dev@googlegroups.com, io-uring@vger.kernel.org,
 linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20220830214919.53220-1-surenb@google.com>
 <20220830214919.53220-23-surenb@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220830214919.53220-23-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/30/22 14:49, Suren Baghdasaryan wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> This adds a new fault injection capability, based on code tagging.
> 
> To use, simply insert somewhere in your code
> 
>   dynamic_fault("fault_class_name")
> 
> and check whether it returns true - if so, inject the error.
> For example
> 
>   if (dynamic_fault("init"))
>       return -EINVAL;
> 
> There's no need to define faults elsewhere, as with
> include/linux/fault-injection.h. Faults show up in debugfs, under
> /sys/kernel/debug/dynamic_faults, and can be selected based on
> file/module/function/line number/class, and enabled permanently, or in
> oneshot mode, or with a specified frequency.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Missing Signed-off-by: from Suren.
See Documentation/process/submitting-patches.rst:

When to use Acked-by:, Cc:, and Co-developed-by:
------------------------------------------------

The Signed-off-by: tag indicates that the signer was involved in the
development of the patch, or that he/she was in the patch's delivery path.


-- 
~Randy
